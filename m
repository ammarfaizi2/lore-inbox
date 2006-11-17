Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755829AbWKQT13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829AbWKQT13 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755825AbWKQT11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:27:27 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:24037 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1755828AbWKQT1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:27:23 -0500
Date: Fri, 17 Nov 2006 20:26:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Wolfgang Erig <Wolfgang.Erig@fujitsu-siemens.com>,
       Andreas Friedrich <andreas.friedrich@fujitsu-siemens.com>,
       Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       linux-acpi@vger.kernel.org
Subject: Re: [patch] i386/x86_64: ACPI cpu_idle_wait() fix
Message-ID: <20061117192626.GA25050@elte.hu>
References: <20061116124132.GA9048@upset.pdb.fsc.net> <20061116131842.GA12961@elte.hu> <20061116133019.GA14546@upset.pdb.fsc.net> <20061116144356.GA4891@elte.hu> <20061117090356.GA26013@upset.pdb.fsc.net> <20061117112237.GA26270@elte.hu> <20061117124913.GA24893@upset.pdb.fsc.net> <20061117132618.GA14411@elte.hu> <20061117133128.GA15404@elte.hu> <20061117111844.a6dfd039.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20061117111844.a6dfd039.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Andrew Morton <akpm@osdl.org> wrote:

> > correction: the last known working kernel was 2.6.8. The bug 
> > predates our GIT history so it's older than 1.5 years.
> 
> How come nobody noticed?  Maybe it improved things ;)
> 
> I spose it's 2.6.19 material, although it's a bit of a leap into the 
> unknown.

i think it's 2.6.19 material. A kernel release that will speed up some 
systems quite noticeably ;-)

> How many systems will this affect?

dont know - it should be relatively rare - maybe the ACPI guys know when 
this has a chance to trigger?

> CPU#1: set_cpus_allowed(), swapper:1, 3 -> 2
>  [<c0103bbe>] show_trace_log_lvl+0x34/0x4a
>  [<c0103ceb>] show_trace+0x2c/0x2e
>  [<c01045f8>] dump_stack+0x2b/0x2d
>  [<c0116a77>] set_cpus_allowed+0x52/0xec
>  [<c0101d86>] cpu_idle_wait+0x2e/0x100
>  [<c0259c57>] acpi_processor_power_exit+0x45/0x58
>  [<c0259752>] acpi_processor_remove+0x46/0xea
>  [<c025c6fb>] acpi_start_single_object+0x47/0x54
>  [<c025cee5>] acpi_bus_register_driver+0xa4/0xd3
>  [<c04ab2d7>] acpi_processor_init+0x57/0x77
>  [<c01004d7>] init+0x146/0x2fd
>  [<c0103a87>] kernel_thread_helper+0x7/0x10
> 
> It seems strange that the kernel is calling 
> acpi_processor_power_exit() at this stage.  It'll have happened 
> because acpi_start_single_object()'s call to acpi_processor_start() 
> returned non-zero.  Why did that happen?

ah, maybe due to:

 BIOS reported wrong ACPI idfor the processor

google gives 4 hits, so i guess it's relatively rare.

> > 	/*
> > 	 * Buggy BIOS check
> > 	 * ACPI id of processors can be reported wrongly by the BIOS.
> > 	 * Don't trust it blindly
> > 	 */
> > 	if (processor_device_array[pr->id] != NULL &&
> > 	    processor_device_array[pr->id] != device) {
> > 		printk(KERN_WARNING "BIOS reported wrong ACPI id"
> > 			"for the processor\n");
> > 		return -ENODEV;
> 
> Andreas wasn't seeing that, right?

he was actually! dmesg.txt attached.

	Ingo

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.19-rc5 (root@yvonne) (gcc version 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)) #3 SMP PREEMPT Thu Nov 16 12:50:49 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f6f0000 (usable)
 BIOS-e820: 000000003f6f0000 - 000000003f6fb000 (ACPI data)
 BIOS-e820: 000000003f6fb000 - 000000003f700000 (ACPI NVS)
 BIOS-e820: 000000003f700000 - 000000003f780000 (usable)
 BIOS-e820: 000000003f780000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
119MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f78a0
Entering add_active_range(0, 0, 259968) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   259968
early_node_map[1] active PFN ranges
    0:        0 ->   259968
On node 0 totalpages: 259968
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 239 pages used for memmap
  HighMem zone: 30353 pages, LIFO batch:7
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7900
ACPI: RSDT (v001 PTLTD    RSDT   0x00050000  LTP 0x00000000) @ 0x3f6f7421
ACPI: FADT (v001 FSC    D156x    0x00050000      0x000f4240) @ 0x3f6f7451
ACPI: MADT (v001 FSC    	 APIC   0x00050000  CSF 0x00000000) @ 0x3f6faf76
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x00050000  LTP 0x00000001) @ 0x3f6fafd8
ACPI: DSDT (v001 FSC    D156x    0x00050000 MSFT 0x02000002) @ 0x00000000
ACPI: PM-Timer IO Port: 0xf008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Detected 2593.696 MHz processor.
Built 1 zonelists.  Total pages: 257937
Kernel command line: 
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
num_possible_cpus(): 2
CPU#0: allocated 4194272 bytes trace buffer.
CPU#0: allocated 4194272 bytes max-trace buffer.
CPU#1: allocated 4194272 bytes trace buffer.
CPU#1: allocated 4194272 bytes max-trace buffer.
allocated 8388544 bytes out-trace buffer.
tracer: a total of 25165632 bytes allocated.
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1001348k/1039872k available (2720k kernel code, 37852k reserved, 911k data, 208k init, 122304k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0494000 - 0xc04c8000   ( 208 kB)
      .data : 0xc03a82ba - 0xc048c0cc   ( 911 kB)
      .text : 0xc0100000 - 0xc03a82ba   (2720 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5191.55 BogoMIPS (lpj=10383118)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 16k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5187.42 BogoMIPS (lpj=10374840)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
Total of 2 processors activated (10378.97 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=125
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8cb, last bus=3
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region f000-f07f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region f180-f1bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.CSAB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIH._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: Device [LPT] status [00000008]: functional but not present; setting present
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:03.0
  IO window: 4000-4fff
  MEM window: e0100000-e01fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x69 set to 0x1
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
BIOS reported wrong ACPI idfor the processor
ACPI Exception (evxface-0545): AE_NOT_EXIST, Removing notify handler [20060707]
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xf0000000
[drm] Initialized drm 1.0.1 20051102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.2.9-k4
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:01.0 to 64
e1000: 0000:02:01.0: e1000_probe: (PCI:33MHz:32-bit) 00:30:05:6b:e3:02
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x3000-0x3007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x3008-0x300f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD800LB-07DNA2, ATA DISK drive
hdb: ST38421A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-STDVD-ROM GDR8162B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 < hda5 >
hdb: max request size: 128KiB
hdb: 16498944 sectors (8447 MB) w/256KiB Cache, CHS=16368/16/63, UDMA(66)
hdb: cache flushes not supported
 hdb: hdb1 hdb2 < hdb5 >
hdc: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 17, io mem 0xe0080000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 18, io base 0x00001400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 16, io base 0x00001c00
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 18, io base 0x00002000
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.13 (Sun Oct 22 08:56:16 2006 UTC).
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.5 to 64
input: AT Translated Set 2 keyboard as /class/input/input0
intel8x0_measure_ac97_clock: measured 56003 usecs
intel8x0: clocking to 45100
ALSA device list:
  #0: Intel ICH5 with AD1980 at 0xe0080c00, irq 20
ip_conntrack version 2.4 (8124 buckets, 64992 max) - 176 bytes per conntrack
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding 377488k swap on /dev/hdb5.  Priority:-1 extents:1 across:377488k
EXT3 FS on hdb1, internal journal
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
(  trace-it-sched-3074 |#0): new 10007840 us user-latency.

--tjCHc7DPkfUGtrlw--
