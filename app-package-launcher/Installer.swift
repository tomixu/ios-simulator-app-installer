import Cocoa
import Foundation

func installAndRunApp(packagedApp: PackagedApp, #simulator: Simulator) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
        shutDownCurrentSessions()
        
        system("xcrun instruments -w \"\(simulator.identifierString)\"")
        
        system("xcrun simctl install booted \"\(packagedApp.path)\"")
        system("xcrun simctl launch booted \(packagedApp.bundleIdentifier)")
        
        NSApplication.sharedApplication().terminate(nil)
    }
}

func shutDownCurrentSessions() {
    system("killall \"iOS Simulator\"")
    system("xcrun simctl shutdown booted")
}
