//
//  ContentView.swift
//  GuessFlag
//
//  Created by Vika on 18.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["UK", "USA", "Bangladesh", "Germany", "Argentina", "Brazil", "Canada", "Greece", "Russia", "Sweden"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingDelete = false
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var bestFinal = 0
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.red,.blue]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                
                VStack{
                    Spacer()
                        .frame(height: 30)
                    
                    Text("Choose a flag: ")
                        .foregroundColor(.white)
                        .font(.title)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) {number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                        
                        if bestFinal < score{
                            bestFinal = score
                        }
                    }) {
                        
                        Image(self.countries[number])
                            .resizable()
                            .frame(width: 250.0, height: 150.0)
                            .shadow(color: .black, radius: 15)
                    }
                }
                Text("Total Score: \(score) ")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
                
            }
            
        }
        .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("Total Score: \(score)"), primaryButton:.destructive(Text("Stop game")){
                
                showingDelete.toggle()
                
                
            }, secondaryButton: .default(Text("Continue")){
                self.askQuestion()})
        }
        .alert(Text("Your result: \(score) \nYour best result: \(bestFinal)"), isPresented: $showingDelete){
            Button("OK"){
                showingDelete.toggle()
                score = 0
            }
        }
    }
    
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct answer!"
            score += 1
        }else{
            scoreTitle = "InCorrect answer!\n This is \(countries[number]) flag"
            score -= 1
        }
    }
}


#Preview {
    ContentView()
}
