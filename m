Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280682AbRKFX3S>; Tue, 6 Nov 2001 18:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280673AbRKFX3J>; Tue, 6 Nov 2001 18:29:09 -0500
Received: from air-1.osdl.org ([65.201.151.5]:27778 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S280682AbRKFX3B>;
	Tue, 6 Nov 2001 18:29:01 -0500
Date: Tue, 6 Nov 2001 15:32:16 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: <linux-kernel@vger.kernel.org>
cc: <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: ACPI "hlt" mode and SMP systems?
In-Reply-To: <Pine.LNX.4.33.0111061133250.22170-100000@segfault.osdlab.org>
Message-ID: <Pine.LNX.4.33.0111061527500.22170-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ acpi list cc'ed for relevance ]

> I once documented all of the states in a readable format. I will post it
> once I get back from lunch...

As promised, here is the document, slightly updated. Presented as a patch,
for easy inlcusion into your favourite kernel tree..

	-pat

diff -Nur linux-2.4.14.orig/Documentation/power/acpi-states.txt linux-2.4.14/Documentation/power/acpi-states.txt
--- linux-2.4.14.orig/Documentation/power/acpi-states.txt	Wed Dec 31 16:00:00 1969
+++ linux-2.4.14/Documentation/power/acpi-states.txt	Tue Nov  6 15:29:24 2001
@@ -0,0 +1,284 @@
+
+Quick and Dirty Guide to ACPI States
+
+Patrick Mochel
+<mochel@osdl.org>
+
+6 November 2001
+
+1. Global States (G0 - G3)
+2. Device Power States (D0 - D3)
+3. System Power States (S0 - S5)
+4. Processor Power States (C0 - C3)
+5. Performance States (P0 - Pn)
+6. References
+
+0.
+~~
+This is the result of spending many nights and mornings deciphering the ACPI
+spec, as well as ironing out the confusion with several people concerning the
+various letter and number combinations.
+
+This is meant to be un-bias. I personaly disagree with several of the ACPI
+design points and requirements. This is meant to be accurate only. Please
+email me if you find any discrepancies between this document and the spec.
+Feel free to email me if you want an opinionated dissertation as well..
+
+1. Global States (G0 - G3)
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+Global system states (G0 - G3) are logical states that are visible to
+the user. Global states are not states that the OS can explicitly
+transition to. They instead simply describe the current state of the
+system.
+
+G0 - Working
+   - The system is normal operating mode.
+   - Devices and processors may change power and performance states.
+   - The OS is "active and responsive".
+
+G1 - Sleeping
+   - The system is in an ACPI sleep state (S1 - S4).
+   - All devices are in a sleeping state.
+   - The processor is in a low power state, or is off.
+   - The operating system is suspended and not responding to any requests.
+   - All operating context has been preserved by the OS, so it can
+     resume execution from the exact point from which it left off.
+   - There is a latency involved in transitioning to the G0 state.
+
+G2 - Soft Off
+   - The OS has transitioned the system to the ACPI sleep state S5.
+   - Operating context is not preserved, so the OS must completely
+     reinitialise itself to get to G0.
+   - The ACPI spec states that it is _not_ safe to disassemble the
+     system at this point.
+   - The system may still be powered on via some wake event.
+
+G3 - Mechanical Off
+   - The system has been physically turned off.
+     This can happen via a mechanical switch, or removing the power cable.
+     On a laptop this is achieved by removing the battery from the system.
+   - Per spec, this is the only state in which it is safe to disassemble
+     the system.
+
+
+2. Device Power States (D0 - D3)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The ACPI definition of device power states is modeled directly after
+the PCI device power states. It defines four states (D0 - D3) which
+the device can be in.
+
+What each state means to a particular device is defined by its device
+class (e.g. video device class, sound device class). These definitions
+are covered in the ACPI spec, and I will not discuss them here.
+
+In general, as the numerical power state increases (from D0 to D1, etc),
+the following things happen:
+
+- Power consumption decreases
+- Device context retained by the device decreases
+- Latency to bring the device to the D0 state increases
+- Responsibility of the driver to have knowledge of the device state
+  increases.
+
+As with the PCI definitions of low power states, the Off state (D3)
+and the working state (D0) are supported by default by every
+device. The other two states (D1 and D2) are optionaly supported by
+the device class.
+
+Note that support of these two states are optional at a device level,
+as far as PCI is concerned. However, with some more recent peripheral buses
+(e.g. PCI-X), device support for all states is mandatory.
+
+Device states are defined as follows:
+
+D0 - On
+   - Device is powered on and running.
+   - It is accepting I/O requests.
+
+D1 -
+D2 - Optional intermediate power states
+   - The device is not accepting any I/O requests.
+   - The device is still consuming power, though it may be less than it does
+     in the D0 state.
+   - The device may have lost some state, as it may powered down various
+     components to conserve power.
+   - The driver is responsible for preserving and restoring this state if it
+     receives a request to transition the device to the D0 state.
+
+D3 - Off
+   - Device is not acception I/O requests.
+   - All device context is lost.
+   - The device must be completely reinitialised upon a transition to the D0
+     state.
+   - The device is not consuming any power.
+
+   (Note that the last point is not always necessarily true; the PCI Power
+    Management specs makes a distinction between D3 "Hot" -- when the device
+    is in D3, but power is still supplied to the slot -- and D3 "Cold" -- when
+    power has been removed from the controlling bus.)
+
+
+Relation to Global System States
+
+G0
+   - Devices are typically in the D0 state, though they may be technically be
+     in any state (D0 - D3). They may have been placed in a low power state
+     based on a system-wide power policy or via direct user control.
+G1
+   - Devices are in a low power state (D1 - D2). The exact state is dictated by
+     both what the device supports and by what the driver is capable of
+     restoring. (Some drivers may not have enough knowledge of the device to
+     restore all of its state.)
+G2 -
+     All devices are off.
+     Some devices may have auxillary power lines that allow the device to wake
+     the system up under certain circumstances (e.g. Wake-On-Lan).
+G3 -
+     All devices are off.
+     No device is consuming any power.
+
+
+3. System Sleep States (S0 - S5)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ACPI defines 6 states which the system can be in, S0 - S5.
+
+S0 is the working state. S5 is the soft-off state. S1 - S4 are intermediate
+sleeping states. Similar to device power states, there are tradeoffs in time
+and power consumption for each system sleep state.
+
+In general, as the numerical sleep state increases, the following are true:
+
+- Power consumption decreases
+- Context retained by system components decreases; the responsibility of the OS
+  to account for this context increases.
+- Latency to bring the system to the S0 state increases.
+
+System sleep states are defined as follows:
+
+S0 - On
+   - System is running.
+
+S1 - "Power On Suspend"
+   - Processor power, and hence execution context, is preserved.
+   - Devices may have been put into a low power state.
+
+S2 - "Pseudo-Suspend To Ram"
+   - Processor power is removed.
+   - Devices may be placed into low power state.
+   - Memory is placed into self-refresh and retains context.
+   - Execution starts again from processor's reset vector
+   - Cache and MTRR configuration is lost during this state; the
+     firmware is responsible for restoring it to some known state.
+
+S3 - "Suspend to Ram"
+   - Processor power is removed.
+   - Devices are placed into a low power state.
+   - Power may be removed from all system buses.
+   - Memory context is preserved by placing memory in Self-Refresh
+   - Execution begins from processor's reset vector
+   - Cache and MTRR configuration is lost during this state; the
+     firmware is responsible for restoring it to some known state.
+
+S4 - "Suspend to Disk", aka "Hibernate"
+   - All power may be removed from the system.
+   - All device context may be lost.
+   - Context is usually written to persistant storage (e.g. disk).
+   - Execution begins at processor's reset vector; the firmware
+     will usually load the OS boot loader.
+
+S5 - Soft Off
+   - Technically not a sleep state
+   - No context is retained
+   - OS is not responsible for saving context
+   - OS must completely reinitialise itself on 'resume' (power-on)
+   - Wake events may still trigger the system to resume from sleep.
+
+When the system is in a sleep state, it can be woken up via a 'wake event'.
+The type of wake events available to a user is dependent on the system
+components and the configuration.
+
+Relation to Global System States
+
+G0 -
+     The system is in the S0 state.
+G1 -
+     The system is in one of the S1 - S4 sleep states.
+G2 -
+     The system is in the S4 sleep state.
+G3 -
+     The system is completely off.
+
+Relation to Device Power States
+
+S0 -
+     Devices are typically in the D0 state, though they may be individually
+     powered down.
+S1 -
+     Devices should be placed in a low-latency low power state (i.e. D1) if
+     they support it.
+S2 -
+     Devices are placed in a low power state if they support it. The resume
+     latency D2 is commonly acceptable because of the savings in power.
+S3 -
+     Devices are placed in a low power state, and power is typically removed
+     from all buses.
+     Some devices may retain power and context, based on their function in the
+     system (e.g. A memory controller may retain power so it can safely
+     resume).
+S4 -
+S5 -
+     All devices are powered off.
+     Some residual power may be consumed by devices that support wake events
+     and need some amount of power to generate an interrupt.
+
+4. Processor States (C0 - C3)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ACPI defines 4 power states for processors. Each state is entered when the
+system is running (in the G0 state), but when the processor is idle. The
+longer the processor is idle, the deeper the sleep state it enters.
+
+The four processor states are:
+
+C0 - On
+   - The processor is executing instructions at this point
+
+C1 - "AutoHalt"
+   - The processor executes the equivalent to the "hlt" instruction
+     on x86.
+   - All processors must support this state.
+   - Latency should be transparent to Operating System.
+
+C2 - "Quick Start"
+   - Entered by reading from a system port.
+
+C3 - Deep Sleep
+   - Entered by reading from a system port.
+   - Caches may not be snooped in this state.
+
+The ACPI firmware tables (specifically the FADT table) tell what port to read
+from to enter C2 and C3. The table also contains the latency involved in
+returning from each state. (The processor states are supposed to nearly
+transparent to the OS; so, if a latency was deemed to be too high, the OS
+could simply choose not to enter it.)
+
+5. Performance States (P0 - Pn)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Performance states are a mechanism for processors and devices to
+compromise performance for lower power consumption while in the
+fully on state (C0 or D0).
+
+An example of this would be a video controller with a 3d graphics
+engine. When placed into a lower performance state, Px, the 3d
+graphics engine is disabled.
+
+By default, all devices support and operate in the P0 state. A device or
+processor may define a maximum of 16 performance states which the OS or an
+application may use.
+
+
+6. References
+~~~~~~~~~~~~~
+
+ACPI 2.0 Specification; esp. Ch 1 - 3.
+<http://acpi.info>
+

