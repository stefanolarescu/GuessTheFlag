//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Stefan Olarescu on 19.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = Int.zero
    
    @State var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Spain",
        "UK",
        "Ukraine",
        "US"
    ].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingEnd = false
    @State private var questionsAsked = 1
    private let numberOfQuestions = 8
    
    // MARK: - UI
    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(
                        color: Color(
                            red: 0.1,
                            green: 0.2,
                            blue: 0.45
                        ),
                        location: 0.3
                    ),
                    .init(
                        color: Color(
                            red: 0.76,
                            green: 0.15,
                            blue: 0.26
                        ),
                        location: 0.3
                    ),
                ],
                center: .top,
                startRadius: 200,
                endRadius: 400
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(
            scoreTitle,
            isPresented: $showingScore
        ) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score).")
        }
        .alert(
            "Game Over",
            isPresented: $showingEnd
        ) {
            Button("Restart", action: reset)
        } message: {
            Text("Final score: \(score)")
        }
    }
    
    // MARK: - METHODS
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong. That's the flag of \(countries[number])."
        }
        
        if questionsAsked == 8 {
            showingEnd = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionsAsked += 1
    }
    
    func reset() {
        score = .zero
        questionsAsked = .zero
        askQuestion()
    }
}

#Preview {
    ContentView()
}
