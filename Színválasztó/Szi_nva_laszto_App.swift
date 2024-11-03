import SwiftUI

@main
struct SzinvalasztoApps: App {
    var body: some Scene {
        WindowGroup {
            ContentView()  // Itt hivatkozunk a fő nézetre
        }
    }
}

struct ContentView: View {
    var body: some View {
        SzínválasztóApp()
    }
}
// A fő alkalmazás nézet
struct SzínválasztóApp: View {
    @State private var kiválasztottSzín: Color = .white
    @State private var szinNeve: String = "Fehér"  // Az alapértelmezett szín neve
    
    // A rendelkezésre álló színek és neveik
    private let szinek: [(szin: Color, nev: String)] = [
        (.red, "Piros"),
        (.green, "Zöld"),
        (.blue, "Kék"),
        (.yellow, "Sárga"),
        (.pink, "Rózsaszín")
    ]
    
    var body: some View {
        VStack {
            Text("Színválasztó")
                .font(.headline)
                .padding()
            
            // Színválasztó gombok
            Színválasztó(szinek: szinek, onSelect: { szin, nev in
                kiválasztottSzín = szin
                szinNeve = nev
            })
            
            // Szín megjelenítő doboz
            SzínDoboz(szin: kiválasztottSzín, szinNeve: szinNeve)
        }
    }
}

// Színválasztó komponens
struct Színválasztó: View {
    let szinek: [(szin: Color, nev: String)]
    let onSelect: (Color, String) -> Void
    
    var body: some View {
        HStack {
            ForEach(szinek, id: \.nev) { szinInfo in
                Button(action: {
                    onSelect(szinInfo.szin, szinInfo.nev)
                }) {
                    Circle()
                        .fill(szinInfo.szin)
                        .frame(width: 40, height: 40)
                        .padding(5)
                }
            }
        }
        .padding()
    }
}

// Szín megjelenítő doboz komponens
struct SzínDoboz: View {
    let szin: Color
    let szinNeve: String
    
    var body: some View {
        Rectangle()
            .fill(szin)
            .frame(width: 200, height: 200)
            .cornerRadius(10)
            .overlay(
                VStack {
                    Text("A kiválasztott szín:")
                        .foregroundColor(.white)
                        .bold()
                        .shadow(radius: 5)
                    Text(szinNeve)  // A szín nevének megjelenítése
                        .foregroundColor(.white)
                        .bold()
                        .shadow(radius: 5)
                }
            )
            .padding()
    }
}

// A SwiftUI előnézete a fejlesztés során
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SzínválasztóApp()
    }
}
