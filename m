Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWESQvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWESQvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 12:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWESQvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 12:51:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3046 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751337AbWESQvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 12:51:20 -0400
Message-ID: <446DF768.80205@redhat.com>
Date: Fri, 19 May 2006 11:50:48 -0500
From: Clark Williams <williams@redhat.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Robert Crocombe <rwcrocombe@raytheon.com>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.16-rtXYZ hangs at boot on quad Opteron
References: <44623EE0.8040300@raytheon.com> <Pine.LNX.4.58.0605101540490.22959@gandalf.stny.rr.com> <44628A70.1020502@raytheon.com> <44634F63.1090504@redhat.com> <Pine.LNX.4.58.0605120216001.26721@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605120216001.26721@gandalf.stny.rr.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------020802050601050604080702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020802050601050604080702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Steven Rostedt wrote:
> On Thu, 11 May 2006, Clark Williams wrote:
>
>> Robert Crocombe wrote:
>>> testing NMI watchdog ... OK.
>>>
>>> where we croak.  On the non-realtime version, it is instead like so:
>> Yeah, this is where my Athlon64x2 goes into the weeds.  I followed it
>> down into the routines that calculate processor migration costs and
>> got lost in the context switches.  I suspect that the forced
>> migrations aggravate a problem down in the 64-bit arch specific code
>> that hasn't been looked at in a while (I believe most people running
>> AMD are doing so in 32-bit mode).
>>
>> Maybe it's time for round two...
>>
>
> Hmm, I run my AMDx2 in 64bit kernel mode and 32bit user space.  But since
> it is my main machine I don't usually test the new -rt kernels on it that
> often.  Looks like when I'm back in the States, I'll have to test it
> again.
>
> -- Steve
>
I spent some time this week trying to dig a bit deeper into why a
64-bit -rtXX won't boot on my Athlon64x2.

I've attached the output from one of my kernel boots (2.6.16-rt23)
that has lots of extra printks in kernel/sched.c and some in
arch/x86_64/kernel/smpboot.c.  After spending time looking at the code
around the migration measurement, it occurred to me that things didn't
really look right for the migration thread on processor 1. I stuck a
print in the routine migration_thread() and noticed that I never
actually saw the migration thread for processor 1 get started (I did
see the print when migration_init() started the migration thread on
processor 0). Since the migration measurement code depends on all
migration threads being present, I suspect that somehow the kernel is
not completing initialization for the second processor.

My only thought at this point is to start comparing
arch/x86_64/kernel/smpboot.c to arch/i386/kernel/smpboot.c and see if
something isn't being done on the x86_64 side.

Clark



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEbfdnHyuj/+TTEp0RAnIQAKDEYjJgVho6RXLllgDolZKGRGpPKACfTL/j
s4N1Cg9R3Sh/v87xfx45Vcc=
=WV8C
-----END PGP SIGNATURE-----


--------------020802050601050604080702
Content-Type: text/x-log;
 name="boot-2.6.16-rt23-x86_64x2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot-2.6.16-rt23-x86_64x2.log"

Bootdata ok (command line is ro root=/dev/hda2 console=tty0 console=uart,io,0xbc00,115200n8 nmi_watchdog=1 migration)
Linux version 2.6.16-rt23 (williams@rt3) (gcc version 4.1.0 20060304 (Red Hat 4.1.0-3)) #154 SMP PREEMPT Fri May 19 6
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000037ef0000 (usable)
 BIOS-e820: 0000000037ef0000 - 0000000037ef3000 (ACPI NVS)
 BIOS-e820: 0000000037ef3000 - 0000000037f00000 (ACPI data)
 BIOS-e820: 0000000038000000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:11 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:11 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Checking aperture...
CPU 0: aperture @ 3dda000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
SMP: Allowing 2 CPUs, 0 hotplug CPUs
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 1 zonelists
Kernel command line: ro root=/dev/hda2 console=tty0 console=uart,io,0xbc00,115200n8 nmi_watchdog=1 migration_debug=1
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz WALL PIT GTOD PIT timer.
time.c: Detected 2004.217 MHz processor.
Console: colour VGA+ 80x25
Early serial console at I/O port 0xbc00 (options '115200n8')
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 848936k/916416k available (4005k kernel code, 67088k reserved, 2105k data, 236k init)
Calibrating delay using timer specific routine.. 4010.93 BogoMIPS (lpj=2005468)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
activating NMI Watchdog ... done.
Using local APIC timer interrupts.
result 12526354
Detected 12.526 MHz APIC timer.
>>>>>>>>>> migration_thread(0): starting (pid: 2)
++++++++++++++++++++=_---CPU UP  1
Booting processor 1/2 APIC 0x1
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
CPU#1 (phys ID: 1) waiting for CALLOUT
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
Calibrating delay using timer specific routine.. 4007.88 BogoMIPS (lpj=2003941)
Stack at about ffff810037c81ed4
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 01
cpu 1: setting up apic clock
CPU has booted.
cpu 1: enabling apic timer
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -88 cycles, maxerr 546 cycles)
waiting for cpu 1
Brought up 2 CPUs
testing NMI watchdog ... CPU#0: NMI appears to be stuck (0->0)!
build_sched_domains: starting
build_sched_domains: calling calibrate_migration_costs
calibrate_migration_costs: starting on processor 0
calibrate_migration_costs: starting first pass
calibrate_migration_costs: calculating distance betweeen 0 and 1
calibrate_migration_costs: distance == 0
calibrate_migration_cost: measuring cost betwen 0 and 1
measure_migration_cost: between 0 and 1
measure_migration_cost: starting measurement loop
measure_cost: starting for cpus 0 and 1
measure_one: source:0, target:1, size:65536
meaure_one: migrating pid 1 to cpu:0
measure_one: dirtying the working set
measure_one: migrating pid 1 to target:1
set_cpus_allowed: waking migration thread
wake_up_process: waking pid 15
try_to_wake_up: pid: 15, states:0x1f, sync:0, mutex:0
try_to_wake_up: bailing because oldstate(0) & state(31) is zero
wake_up_process: waking pid 15
try_to_wake_up: pid: 15, states:0x1f, sync:0, mutex:0
try_to_wake_up: bailing because oldstate(0) & state(31) is zero
wake_up_process: waking pid 15
try_to_wake_up: pid: 15, states:0x1f, sync:0, mutex:0
try_to_wake_up: bailing because oldstate(0) & state(31) is zero
wake_up_process: waking pid 15
...

--------------020802050601050604080702--
