Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWDXFX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWDXFX3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 01:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWDXFX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 01:23:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbWDXFX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 01:23:27 -0400
Date: Sun, 23 Apr 2006 22:21:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Reppert <arashi@sacredchao.net>
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI ROM resource allocation issue with 2.6.17-rc2
Message-Id: <20060423222122.498a3dd2.akpm@osdl.org>
In-Reply-To: <1145851361.3375.20.camel@minerva>
References: <1145851361.3375.20.camel@minerva>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Reppert <arashi@sacredchao.net> wrote:
>
> I've been running 2.6.12-rc2-mm3 for a long time.  Recently I upgraded
> a bunch of OS packages (Debian unstable), so I thought I may as well
> upgrade the kernel, too.  I've got a dual-head setup driven by a Radeon
> 9200 and a Radeon 7000.  When I booted 2.6.17-rc2, X never came up; I
> got "RADEON: Cannot read V_BIOS" and "RADEON: VIdeo BIOS not detected
> in PCI space!" for the RADEON 7000, and it eventually gets in a loop of
> spitting out "RADEON: Idle timed out, resetting engine ... " messages
> in Xorg.log.  Doing a diff of working and broken logs uncovered that the
> Radeon 7000's PCI ROM resource area had moved from ff8c000 to c6900000.
> Once I removed the Radeon 7000 screen from the Xorg config, X came up fine
> on the one head.  Adding stupid amounts of printks to the PCI subsystem in
> .17-rc2 uncovered that at some point, the ROM area is discovered to be
> at ff8c0000, but is later reallocated to c6900000.
> 
> I've also got a Promise PDC20268 whose expansion ROM seems to have made a
> similar move (from ff8f8000 to c6920000), but the ATA devices attached to
> that controller seem to work fine under 2.6.17-rc2.
> 
> I have a copy of relevant dmesg and lspci output, as well as a copy of
> Xorg.log files, at http://sacredchao.net/~arashi/pci-problem/ .  I'll
> try to binary-search for the last version of the kernel that works later
> this week (hopefully by Tuesday afternoon), I just haven't had time to
> since I've discovered the problem.
> 

I'm pretty sure this has come up before, but I cannot for the life of me
remember what the answer was.

You did everything right though - thanks.  Here's
diff -u dmesg-working dmesg-broken:

--- dmesg-working	2006-04-23 22:17:45.000000000 -0700
+++ dmesg-broken	2006-04-23 22:17:23.000000000 -0700
@@ -1,4 +1,4 @@
-Linux version 2.6.12-rc2-mm3 (miz@minerva) (gcc version 4.0.3 (Debian 4.0.3-1)) #4 PREEMPT Sun Apr 23 13:43:42 EDT 2006
+Linux version 2.6.17-rc2 (miz@minerva) (gcc version 4.0.3 (Debian 4.0.3-1)) #1 PREEMPT Sun Apr 23 08:32:41 EDT 2006
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
@@ -10,29 +10,26 @@
  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
 511MB LOWMEM available.
 On node 0 totalpages: 131008
-  DMA zone: 4096 pages, LIFO batch:1
-  Normal zone: 126912 pages, LIFO batch:16
-  HighMem zone: 0 pages, LIFO batch:1
+  DMA zone: 4096 pages, LIFO batch:0
+  Normal zone: 126912 pages, LIFO batch:31
 DMI 2.3 present.
-ACPI: RSDP (v000 AMI                                   ) @ 0x000ff980
-ACPI: RSDT (v001 D815EA EA81510A 0x20000628 MSFT 0x00001011) @ 0x1fff0000
-ACPI: FADT (v001 D815EA EA81510A 0x20000628 MSFT 0x00001011) @ 0x1fff1000
-ACPI: DSDT (v001 D815EA EA81510A 0x00000012 MSFT 0x0100000b) @ 0x00000000
-Allocating PCI resources starting at 20000000 (gap: 20000000:dfb80000)
+Allocating PCI resources starting at 30000000 (gap: 20000000:dfb80000)
 Built 1 zonelists
+Kernel command line: root=/dev/hda1 read-only init=/bin/sh
 Local APIC disabled by BIOS -- you can enable it with "lapic"
-mapped APIC to ffffd000 (01404000)
+mapped APIC to ffffd000 (01401000)
+Enabling fast FPU save and restore... done.
+Enabling unmasked SIMD FPU exception support... done.
 Initializing CPU#0
-Kernel command line: root=/dev/hda1 read-only init=/bin/sh
-PID hash table entries: 2048 (order: 11, 32768 bytes)
-Detected 864.158 MHz processor.
+PID hash table entries: 2048 (order: 11, 8192 bytes)
+Detected 863.902 MHz processor.
 Using tsc for high-res timesource
 Console: colour VGA+ 80x25
-Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
-Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 513580k/524032k available (3597k kernel code, 9972k reserved, 1035k data, 188k init, 0k highmem)
+Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
+Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
+Memory: 515328k/524032k available (2078k kernel code, 8216k reserved, 1249k data, 144k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay loop... 1708.03 BogoMIPS (lpj=854016)
+Calibrating delay using timer specific routine.. 1729.66 BogoMIPS (lpj=8648342)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
 CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
@@ -42,123 +39,24 @@
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
 CPU: Intel Pentium III (Coppermine) stepping 06
-Enabling fast FPU save and restore... done.
-Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
+SMP alternatives: switching to UP code
+Freeing SMP alternatives: 0k freed
 ACPI: setting ELCR to 0200 (from 0e00)
-softlockup thread 0 started up.
 NET: Registered protocol family 16
+ACPI: bus type pci registered
 PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
-PCI: Using configuration type 1
-mtrr: v2.0 (20020519)
-ACPI: Subsystem revision 20050309
+Setting up standard PCI resources
+ACPI: Subsystem revision 20060127
 ACPI: Interpreter enabled
 ACPI: Using PIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (0000:00)
 PCI: Probing PCI hardware (bus 00)
-ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
-PCI: Scanning bus 0000:00
-PCI: Found 0000:00:00.0 [8086/1130] 000600 00
-PCI: Calling quirk c0277c70 for 0000:00:00.0
-PCI: Calling quirk c0278250 for 0000:00:00.0
-PCI: Calling quirk c03ff370 for 0000:00:00.0
-PCI: Calling quirk c03ff5a0 for 0000:00:00.0
-PCI: Calling quirk c03ff780 for 0000:00:00.0
-PCI: Found 0000:00:01.0 [8086/1131] 000604 01
-PCI: Calling quirk c0277c70 for 0000:00:01.0
-PCI: Calling quirk c0278250 for 0000:00:01.0
-PCI: Calling quirk c03ff370 for 0000:00:01.0
-PCI: Calling quirk c03ff5a0 for 0000:00:01.0
-PCI: Calling quirk c03ff780 for 0000:00:01.0
-PCI: Found 0000:00:1e.0 [8086/244e] 000604 01
-PCI: Calling quirk c0277c70 for 0000:00:1e.0
-PCI: Calling quirk c0278250 for 0000:00:1e.0
-PCI: Calling quirk c03ff370 for 0000:00:1e.0
-PCI: Calling quirk c03ff5a0 for 0000:00:1e.0
-PCI: Calling quirk c03ff780 for 0000:00:1e.0
-PCI: Found 0000:00:1f.0 [8086/2440] 000601 00
-PCI: Calling quirk c02776b0 for 0000:00:1f.0
-PCI: Calling quirk c0277c70 for 0000:00:1f.0
-PCI: Calling quirk c059edf0 for 0000:00:1f.0
-PCI: Calling quirk c0278250 for 0000:00:1f.0
-PCI: Calling quirk c03ff370 for 0000:00:1f.0
-PCI: Calling quirk c03ff5a0 for 0000:00:1f.0
-PCI: Calling quirk c03ff780 for 0000:00:1f.0
-PCI: Found 0000:00:1f.1 [8086/244b] 000101 00
-PCI: Calling quirk c0277c70 for 0000:00:1f.1
-PCI: Calling quirk c0278250 for 0000:00:1f.1
-PCI: Calling quirk c03ff370 for 0000:00:1f.1
-PCI: Calling quirk c03ff5a0 for 0000:00:1f.1
-PCI: Calling quirk c03ff780 for 0000:00:1f.1
-PCI: Found 0000:00:1f.2 [8086/2442] 000c03 00
-PCI: Calling quirk c0277c70 for 0000:00:1f.2
-PCI: Calling quirk c0278250 for 0000:00:1f.2
-PCI: Calling quirk c03ff370 for 0000:00:1f.2
-PCI: Calling quirk c03ff5a0 for 0000:00:1f.2
-PCI: Calling quirk c03ff780 for 0000:00:1f.2
-PCI: Found 0000:00:1f.3 [8086/2443] 000c05 00
-PCI: Calling quirk c0277c70 for 0000:00:1f.3
-PCI: Calling quirk c0278250 for 0000:00:1f.3
-PCI: Calling quirk c03ff370 for 0000:00:1f.3
-PCI: Calling quirk c03ff5a0 for 0000:00:1f.3
-PCI: Calling quirk c03ff780 for 0000:00:1f.3
-PCI: Found 0000:00:1f.4 [8086/2444] 000c03 00
-PCI: Calling quirk c0277c70 for 0000:00:1f.4
-PCI: Calling quirk c0278250 for 0000:00:1f.4
-PCI: Calling quirk c03ff370 for 0000:00:1f.4
-PCI: Calling quirk c03ff5a0 for 0000:00:1f.4
-PCI: Calling quirk c03ff780 for 0000:00:1f.4
-PCI: Fixups for bus 0000:00
-PCI: Scanning behind PCI bridge 0000:00:01.0, config 020200, pass 0
-PCI: Scanning bus 0000:02
-PCI: Found 0000:02:00.0 [1002/5960] 000300 00
-PCI: Calling quirk c0277c70 for 0000:02:00.0
-PCI: Calling quirk c0278250 for 0000:02:00.0
-PCI: Calling quirk c03ff370 for 0000:02:00.0
-PCI: Calling quirk c03ff780 for 0000:02:00.0
+PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
+PCI quirk: region 0500-053f claimed by ICH4 GPIO
 Boot video device is 0000:02:00.0
-PCI: Found 0000:02:00.1 [1002/5940] 000380 00
-PCI: Calling quirk c0277c70 for 0000:02:00.1
-PCI: Calling quirk c0278250 for 0000:02:00.1
-PCI: Calling quirk c03ff370 for 0000:02:00.1
-PCI: Calling quirk c03ff780 for 0000:02:00.1
-PCI: Fixups for bus 0000:02
-PCI: Bus scan for 0000:02 returning with max=02
-PCI: Scanning behind PCI bridge 0000:00:1e.0, config 010100, pass 0
-PCI: Scanning bus 0000:01
-PCI: Found 0000:01:0a.0 [105a/4d68] 000180 00
-PCI: Calling quirk c0277c70 for 0000:01:0a.0
-PCI: Calling quirk c0278250 for 0000:01:0a.0
-PCI: Calling quirk c03ff370 for 0000:01:0a.0
-PCI: Calling quirk c03ff780 for 0000:01:0a.0
-PCI: Found 0000:01:0b.0 [1073/0012] 000401 00
-PCI: Calling quirk c0277c70 for 0000:01:0b.0
-PCI: Calling quirk c0278250 for 0000:01:0b.0
-PCI: Calling quirk c03ff370 for 0000:01:0b.0
-PCI: Calling quirk c03ff780 for 0000:01:0b.0
-PCI: Found 0000:01:0c.0 [1002/5159] 000300 00
-PCI: Calling quirk c0277c70 for 0000:01:0c.0
-PCI: Calling quirk c0278250 for 0000:01:0c.0
-PCI: Calling quirk c03ff370 for 0000:01:0c.0
-PCI: Calling quirk c03ff780 for 0000:01:0c.0
-PCI: Found 0000:01:0d.0 [10ec/8139] 000200 00
-PCI: Calling quirk c0277c70 for 0000:01:0d.0
-PCI: Calling quirk c0278250 for 0000:01:0d.0
-PCI: Calling quirk c03ff370 for 0000:01:0d.0
-PCI: Calling quirk c03ff780 for 0000:01:0d.0
-PCI: Fixups for bus 0000:01
-PCI: Bus scan for 0000:01 returning with max=01
-PCI: Scanning behind PCI bridge 0000:00:01.0, config 020200, pass 1
-PCI: Scanning behind PCI bridge 0000:00:1e.0, config 010100, pass 1
-PCI: Bus scan for 0000:00 returning with max=02
+PCI: Transparent bridge - 0000:00:1e.0
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
-ACPI: Can't get handler for 0000:00:01.0
-ACPI: Can't get handler for 0000:02:00.0
-ACPI: Can't get handler for 0000:02:00.1
-ACPI: Can't get handler for 0000:01:0a.0
-ACPI: Can't get handler for 0000:01:0b.0
-ACPI: Can't get handler for 0000:01:0c.0
-ACPI: Can't get handler for 0000:01:0d.0
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
 ACPI: Power Resource [URP1] (off)
 ACPI: Power Resource [URP2] (off)
@@ -177,69 +75,42 @@
 usbcore: registered new driver hub
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
-audit: initializing netlink socket (disabled)
-audit(1145849409.148:0): initialized
-inotify device minor=63
+PCI: Bridge: 0000:00:01.0
+  IO window: d000-dfff
+  MEM window: ff900000-ff9fffff
+  PREFETCH window: d6a00000-f6afffff
+PCI: Bridge: 0000:00:1e.0
+  IO window: c000-cfff
+  MEM window: ff800000-ff8fffff
+  PREFETCH window: c6900000-d69fffff
+PCI: Setting latency timer of device 0000:00:1e.0 to 64
 Initializing Cryptographic API
-PCI: Calling quirk c0277b30 for 0000:00:00.0
-PCI: Calling quirk c02782a0 for 0000:00:00.0
-PCI: Calling quirk c0277b30 for 0000:00:01.0
-PCI: Calling quirk c02782a0 for 0000:00:01.0
-PCI: Calling quirk c0277b30 for 0000:00:1e.0
-PCI: Calling quirk c02782a0 for 0000:00:1e.0
-PCI: Calling quirk c0277b30 for 0000:00:1f.0
-PCI: Calling quirk c02782a0 for 0000:00:1f.0
-PCI: Calling quirk c0277b30 for 0000:00:1f.1
-PCI: Calling quirk c02782a0 for 0000:00:1f.1
-PCI: Calling quirk c0277b30 for 0000:00:1f.2
-PCI: Calling quirk c02782a0 for 0000:00:1f.2
-PCI: Calling quirk c0277b30 for 0000:00:1f.3
-PCI: Calling quirk c02782a0 for 0000:00:1f.3
-PCI: Calling quirk c0277b30 for 0000:00:1f.4
-PCI: Calling quirk c02782a0 for 0000:00:1f.4
-PCI: Calling quirk c0277b30 for 0000:02:00.0
-PCI: Calling quirk c0277b30 for 0000:02:00.1
-PCI: Calling quirk c0277b30 for 0000:01:0a.0
-PCI: Calling quirk c0277b30 for 0000:01:0b.0
-PCI: Calling quirk c0277b30 for 0000:01:0c.0
-PCI: Calling quirk c0277b30 for 0000:01:0d.0
+io scheduler noop registered
+io scheduler cfq registered (default)
 ACPI: Power Button (FF) [PWRF]
 ACPI: Sleep Button (CM) [SBTN]
-ACPI: CPU0 (power states: C1[C1])
-Real Time Clock Driver v1.12
+Real Time Clock Driver v1.12ac
+Non-volatile memory driver v1.2
 hw_random hardware driver 1.0.0 loaded
 Linux agpgart interface v0.101 (c) Dave Jones
 agpgart: Detected an Intel i815 Chipset.
 agpgart: AGP aperture is 64M @ 0xf8000000
-[drm] Initialized drm 1.0.0 20040925
+[drm] Initialized drm 1.0.1 20051102
 PCI: Enabling device 0000:01:0c.0 (0080 -> 0083)
 ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
 PCI: setting IRQ 11 as level-triggered
 ACPI: PCI Interrupt 0000:01:0c.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
-[drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
+[drm] Initialized radeon 1.24.0 20060225 on minor 0
 ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
 ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
-[drm] Initialized radeon 1.16.0 20050311 on minor 1: ATI Technologies Inc RV280 [Radeon 9200 PRO]
-ACPI: No ACPI bus support for i8042
-serio: i8042 AUX port at 0x60,0x64 irq 12
-serio: i8042 KBD port at 0x60,0x64 irq 1
-Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
-ACPI: No ACPI bus support for serial8250
-ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
-ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
-io scheduler noop registered
-io scheduler anticipatory registered
-io scheduler deadline registered
-io scheduler cfq registered
-floppy: ignoring I/O port region 0x3f4-0x3f5
-floppy: ignoring I/O port region 0x3f7-0x3f7
-ACPI: Floppy Controller [FDC0] at I/O 0x3f0-0x3f1, 0x3f2-0x3f3 irq 6 dma channel 2
-ACPI: [FDC0] doesn't declare FD_DCR; also claiming 0x3f7
-Floppy drive(s): fd0 is 1.44M
-ACPI: No ACPI bus support for serio0
-ACPI: No ACPI bus support for serio1
-FDC 0 is a post-1991 82077
-ACPI: No ACPI bus support for floppy.0
+[drm] Initialized radeon 1.24.0 20060225 on minor 1
+Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
+serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
+serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
+parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
+loop: loaded (max 8 devices)
+e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
+e100: Copyright(c) 1999-2005 Intel Corporation
 8139too Fast Ethernet driver 0.9.27
 ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
 ACPI: PCI Interrupt 0000:01:0d.0[A] -> Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
@@ -256,20 +127,16 @@
 hda: WDC WD300BB-00CCB0, ATA DISK drive
 hdb: ST380011A, ATA DISK drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
-ACPI: No ACPI bus support for 0.0
-ACPI: No ACPI bus support for 0.1
 Probing IDE interface ide1...
 hdc: _NEC DVD_RW ND-3520A, ATAPI CD/DVD-ROM drive
 hdd: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
 ide1 at 0x170-0x177,0x376 on irq 15
-ACPI: No ACPI bus support for 1.0
-ACPI: No ACPI bus support for 1.1
 PDC20268: IDE controller at PCI slot 0000:01:0a.0
 ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
 PCI: setting IRQ 9 as level-triggered
 ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [LNKG] -> GSI 9 (level, low) -> IRQ 9
 PDC20268: chipset revision 2
-PDC20268: ROM enabled at 0xff8f8000
+PDC20268: ROM enabled at 0xc6920000
 PDC20268: 100% native mode on irq 9
     ide2: BM-DMA at 0xcf90-0xcf97, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xcf98-0xcf9f, BIOS settings: hdg:pio, hdh:pio
@@ -278,16 +145,11 @@
 hdg: Maxtor 4D060H3, ATA DISK drive
 hdh: Maxtor 6Y060L0, ATA DISK drive
 ide3 at 0xcfa8-0xcfaf,0xcfe2 on irq 9
-ACPI: No ACPI bus support for 3.0
-ACPI: No ACPI bus support for 3.1
-Probing IDE interface ide2...
-Probing IDE interface ide4...
-Probing IDE interface ide5...
 hda: max request size: 128KiB
 hda: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(100)
 hda: cache flushes not supported
  hda: hda1 hda2
-hdb: max request size: 1024KiB
+hdb: max request size: 512KiB
 hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hdb: cache flushes supported
  hdb: hdb1 hdb2 hdb3 hdb4
@@ -302,72 +164,82 @@
 hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
 Uniform CD-ROM driver Revision: 3.20
 hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
-USB Universal Host Controller Interface driver v2.2
+USB Universal Host Controller Interface driver v3.0
 ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
 ACPI: PCI Interrupt 0000:00:1f.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
 PCI: Setting latency timer of device 0000:00:1f.2 to 64
-uhci_hcd 0000:00:1f.2: Intel Corporation 82801BA/BAM USB (Hub #1)
+uhci_hcd 0000:00:1f.2: UHCI Host Controller
 uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
 uhci_hcd 0000:00:1f.2: irq 11, io base 0x0000ef40
-ACPI: No ACPI bus support for usb1
+usb usb1: configuration #1 chosen from 1 choice
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 2 ports detected
-ACPI: No ACPI bus support for 1-0:1.0
 ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
 PCI: setting IRQ 10 as level-triggered
 ACPI: PCI Interrupt 0000:00:1f.4[C] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
 PCI: Setting latency timer of device 0000:00:1f.4 to 64
-uhci_hcd 0000:00:1f.4: Intel Corporation 82801BA/BAM USB (Hub #2)
+uhci_hcd 0000:00:1f.4: UHCI Host Controller
 uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
 uhci_hcd 0000:00:1f.4: irq 10, io base 0x0000ef80
-ACPI: No ACPI bus support for usb2
+usb usb2: configuration #1 chosen from 1 choice
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
-ACPI: No ACPI bus support for 2-0:1.0
+Initializing USB Mass Storage driver...
 usb 1-1: new low speed USB device using uhci_hcd and address 2
-ACPI: No ACPI bus support for 1-1
-ACPI: No ACPI bus support for 1-1:1.0
-ACPI: No ACPI bus support for 1-1:1.1
+usb 1-1: configuration #1 chosen from 1 choice
 usb 1-2: new full speed USB device using uhci_hcd and address 3
-ACPI: No ACPI bus support for 1-2
+usb 1-2: configuration #1 chosen from 1 choice
 hub 1-2:1.0: USB hub found
 hub 1-2:1.0: 4 ports detected
-ACPI: No ACPI bus support for 1-2:1.0
-usbcore: registered new driver usblp
-drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
-Initializing USB Mass Storage driver...
+usb 1-2.1: new low speed USB device using uhci_hcd and address 4
+usb 1-2.1: configuration #1 chosen from 1 choice
+usb 1-2.3: new low speed USB device using uhci_hcd and address 5
+usb 1-2.3: configuration #1 chosen from 1 choice
 usbcore: registered new driver usb-storage
 USB Mass Storage support registered.
 usbcore: registered new driver hiddev
-usb 1-2.1: new low speed USB device using uhci_hcd and address 4
-ACPI: No ACPI bus support for 1-2.1
-ACPI: No ACPI bus support for 1-2.1:1.0
-usb 1-2.3: new low speed USB device using uhci_hcd and address 5
-ACPI: No ACPI bus support for 1-2.3
-ACPI: No ACPI bus support for 1-2.3:1.0
+input: Logitech USB Receiver as /class/input/input0
 input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:1f.2-1
+input: Logitech USB Receiver as /class/input/input1
 input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1f.2-1
+input: Logitech USB-PS/2 Optical Mouse as /class/input/input2
 input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1f.2-2.1
-input,hiddev96: USB HID v1.00 Mouse [WACOM CTE-440-U V4.0-3] on usb-0000:00:1f.2-2.3
 usbcore: registered new driver usbhid
-drivers/usb/input/hid-core.c: v2.01:USB HID core driver
+drivers/usb/input/hid-core.c: v2.6:USB HID core driver
+serio: i8042 AUX port at 0x60,0x64 irq 12
+serio: i8042 KBD port at 0x60,0x64 irq 1
 mice: PS/2 mouse device common for all mice
-Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
+Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22 10:27:24 2006 UTC).
 ALSA device list:
   No soundcards found.
-oprofile: using timer interrupt.
 NET: Registered protocol family 2
-IP: routing cache hash table of 1024 buckets, 32Kbytes
-TCP established hash table entries: 32768 (order: 6, 262144 bytes)
-TCP bind hash table entries: 32768 (order: 7, 917504 bytes)
-TCP: Hash tables configured (established 32768 bind 32768)
+IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
+TCP established hash table entries: 16384 (order: 4, 65536 bytes)
+TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
+TCP: Hash tables configured (established 16384 bind 8192)
+TCP reno registered
+TCP bic registered
+Initializing IPsec netlink socket
 NET: Registered protocol family 1
+NET: Registered protocol family 10
+IPv6 over IPv4 tunneling driver
 NET: Registered protocol family 17
+NET: Registered protocol family 15
+Using IPI Shortcut mode
+kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
-Freeing unused kernel memory: 188k freed
-kjournald starting.  Commit interval 5 seconds
-input: AT Translated Set 2 keyboard on isa0060/serio0
+Freeing unused kernel memory: 144k freed
+input: AT Translated Set 2 keyboard as /class/input/input3
+EXT3 FS on hda1, internal journal
+Adding 1060280k swap on /dev/hda2.  Priority:-1 extents:1 across:1060280k
+EXT3 FS on hda1, internal journal
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on hdb2, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
+ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
+input: Wacom Graphire4 4x5 as /class/input/input4
+usbcore: registered new driver wacom
+drivers/usb/input/wacom.c: v1.45:USB Wacom Graphire and Wacom Intuos tablet driver
+eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
+eth0: no IPv6 routers present

