Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTH0ArO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 20:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbTH0ArO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 20:47:14 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:47283 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S262985AbTH0Aqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 20:46:43 -0400
Subject: acpi problem (was: Strange (scheduler/vm?) starvations in latest
	2.6 tree)
From: Christophe Saout <christophe@saout.de>
To: linux-kernel@vger.kernel.org
Cc: Andy Grover <andrew.grover@intel.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1061303543.4268.11.camel@chtephan.cs.pocnet.net>
References: <1061303543.4268.11.camel@chtephan.cs.pocnet.net>
Content-Type: multipart/mixed; boundary="=-7nDb2w3L/vgIHn9kWUgS"
Message-Id: <1061945189.4058.19.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 27 Aug 2003 02:46:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7nDb2w3L/vgIHn9kWUgS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Di, 2003-08-19 um 16.32 schrieb Christophe Saout:

> Some days ago after updating the kernel source from bkcvs my system
> started behaving very strange. When compiling something (without make
> -j) the mouse cursor sometimes got *very* jumpy and even hangs for some
> time, also xmms likes to skip. It seems like the whole system freezes
> for some time.

Argh! I am so stupid. I found the problem... it's my harddisk suddenly
running in non-dma mode (ok, well, I didn't really investigate the
problem).

While doing an lspci I found that some of my onboard-devices (usb
controllers and ide controller) had assigned irq -19. Well, negative
interrupt numbers, I didn't know those existed. ;-)

The board is a VIA KT400 (lspci attached).

A quick lookup in errno.h showed that this could be a -ENODEV. A grep in
the acpi directory showed that returning ENODEV is quite common. After
taking a look in the latest acpi patches I found the problem in the
nvidia patch.

In drivers/acpi/pci_link.c in acpi_pci_link_get_irq there is -ENODEV
returned but everywhere else 0 is returned on failure. This function is
used from pci_irq.c and only checked whether false or not (in the second
case the return value is used as irq number, that's where the -19 is
coming from). So changing this:

--- pci_link.c.orig     2003-08-27 02:34:46.650631336 +0200
+++ pci_link.c  2003-08-27 02:13:31.000000000 +0200
@@ -517,7 +517,7 @@
        }
  
        if (acpi_pci_link_allocate(link)) {
-               return -ENODEV;
+               return_VALUE(0);
        }

        if (!link->irq.active) {

helps. Well, the USB interrupts are still where they were before the
patch broke my acpi interrupt routing. The problem is that the USB
controllers were not working correctly. I've got no usb devices, so I
haven't checked if they are working now (but I think all controllers
should be on one irq line, not three?).

BTW: The problem also triggered an error message with a typo in the apic
code:

--- mpparse.c.orig      2003-08-27 02:39:26.536082280 +0200
+++ mpparse.c   2003-08-27 02:38:22.549809672 +0200
@@ -850,7 +850,7 @@
                        return i;
        }
  
-       printk(KERN_ERR "ERROR: Unable to locate IOAPIC for IRQ %d/n",
irq);
+       printk(KERN_ERR "ERROR: Unable to locate IOAPIC for IRQ %d\n",
irq);
  
        return -1;
 }

My lspci -vvv output (after the patch) is attached as well as the boot
output from the kernel (before and after my "fix").

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

--=-7nDb2w3L/vgIHn9kWUgS
Content-Disposition: attachment; filename=lspci.txt
Content-Type: text/plain; name=lspci.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
	Subsystem: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at e3002000 (32-bit, prefetchable) [size=4K]

00:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at e3000000 (32-bit, prefetchable) [size=4K]

00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at d000 [size=128]
	Region 1: Memory at e3001000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at d400 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at d800 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Unknown device 1695:3005
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Unknown device 1695:3005
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Unknown device 1695:3005
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at e400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: Unknown device 1695:3005
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 10
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at e3003000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device 1695:3005
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at e800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL [Radeon 8500 LE] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Radeon 8500
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--=-7nDb2w3L/vgIHn9kWUgS
Content-Disposition: attachment; filename=bootlog-before.txt
Content-Type: text/plain; name=bootlog-before.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Aug 24 12:18:46 chtephan Linux version 2.6.0-test4 (root@chtephan) (gcc-Version 3.3.1 (Gentoo Linux 3.3.1, propolice)) #1 Sun Aug 24 12:14:50 CEST 2003
Aug 24 12:18:46 chtephan Video mode to be used for restore is f00
Aug 24 12:18:46 chtephan BIOS-provided physical RAM map:
Aug 24 12:18:46 chtephan BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug 24 12:18:46 chtephan BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug 24 12:18:46 chtephan BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug 24 12:18:46 chtephan BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
Aug 24 12:18:46 chtephan BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
Aug 24 12:18:46 chtephan BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
Aug 24 12:18:46 chtephan BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 24 12:18:46 chtephan BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug 24 12:18:46 chtephan BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 24 12:18:46 chtephan 511MB LOWMEM available.
Aug 24 12:18:46 chtephan found SMP MP-table at 000f5a30
Aug 24 12:18:46 chtephan hm, page 000f5000 reserved twice.
Aug 24 12:18:46 chtephan hm, page 000f6000 reserved twice.
Aug 24 12:18:46 chtephan hm, page 000f1000 reserved twice.
Aug 24 12:18:46 chtephan hm, page 000f2000 reserved twice.
Aug 24 12:18:46 chtephan On node 0 totalpages: 131056
Aug 24 12:18:46 chtephan DMA zone: 4096 pages, LIFO batch:1
Aug 24 12:18:46 chtephan Normal zone: 126960 pages, LIFO batch:16
Aug 24 12:18:46 chtephan HighMem zone: 0 pages, LIFO batch:1
Aug 24 12:18:46 chtephan DMI 2.2 present.
Aug 24 12:18:46 chtephan ACPI: RSDP (v000 KT400                                     ) @ 0x000f7460
Aug 24 12:18:46 chtephan ACPI: RSDT (v001 KT400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
Aug 24 12:18:46 chtephan ACPI: FADT (v001 KT400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
Aug 24 12:18:46 chtephan ACPI: MADT (v001 KT400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff7000
Aug 24 12:18:46 chtephan ACPI: DSDT (v001 KT400  AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
Aug 24 12:18:46 chtephan ACPI: Local APIC address 0xfee00000
Aug 24 12:18:46 chtephan ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Aug 24 12:18:46 chtephan Processor #0 6:8 APIC version 16
Aug 24 12:18:46 chtephan ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
Aug 24 12:18:46 chtephan ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
Aug 24 12:18:46 chtephan IOAPIC[0]: Assigned apic_id 2
Aug 24 12:18:46 chtephan IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
Aug 24 12:18:46 chtephan ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
Aug 24 12:18:46 chtephan ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x0] trigger[0x0])
Aug 24 12:18:46 chtephan ACPI: INT_SRC_OVR (bus[0] irq[0xe] global_irq[0xe] polarity[0x1] trigger[0x1])
Aug 24 12:18:46 chtephan ACPI: INT_SRC_OVR (bus[0] irq[0xf] global_irq[0xf] polarity[0x1] trigger[0x1])
Aug 24 12:18:46 chtephan Enabling APIC mode:  Flat.  Using 1 I/O APICs
Aug 24 12:18:46 chtephan Using ACPI (MADT) for SMP configuration information
Aug 24 12:18:46 chtephan Building zonelist for node : 0
Aug 24 12:18:46 chtephan Kernel command line: auto BOOT_IMAGE=linux ro root=fe04
Aug 24 12:18:46 chtephan Initializing CPU#0
Aug 24 12:18:46 chtephan PID hash table entries: 2048 (order 11: 16384 bytes)
Aug 24 12:18:46 chtephan Detected 1750.898 MHz processor.
Aug 24 12:18:46 chtephan Console: colour VGA+ 80x25
Aug 24 12:18:46 chtephan Calibrating delay loop... 3448.83 BogoMIPS
Aug 24 12:18:46 chtephan Memory: 512084k/524224k available (2563k kernel code, 11392k reserved, 918k data, 180k init, 0k highmem)
Aug 24 12:18:46 chtephan Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug 24 12:18:46 chtephan Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Aug 24 12:18:46 chtephan Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 24 12:18:46 chtephan -> /dev
Aug 24 12:18:46 chtephan -> /dev/console
Aug 24 12:18:46 chtephan -> /root
Aug 24 12:18:46 chtephan CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
Aug 24 12:18:46 chtephan CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
Aug 24 12:18:46 chtephan CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 24 12:18:46 chtephan CPU: L2 Cache: 256K (64 bytes/line)
Aug 24 12:18:46 chtephan CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Aug 24 12:18:46 chtephan Intel machine check architecture supported.
Aug 24 12:18:46 chtephan Intel machine check reporting enabled on CPU#0.
Aug 24 12:18:46 chtephan CPU: AMD Athlon(tm)  stepping 00
Aug 24 12:18:46 chtephan Enabling fast FPU save and restore... done.
Aug 24 12:18:46 chtephan Enabling unmasked SIMD FPU exception support... done.
Aug 24 12:18:46 chtephan Checking 'hlt' instruction... OK.
Aug 24 12:18:46 chtephan POSIX conformance testing by UNIFIX
Aug 24 12:18:46 chtephan enabled ExtINT on CPU#0
Aug 24 12:18:46 chtephan ESR value before enabling vector: 00000000
Aug 24 12:18:46 chtephan ESR value after enabling vector: 00000000
Aug 24 12:18:46 chtephan ENABLING IO-APIC IRQs
Aug 24 12:18:46 chtephan init IO_APIC IRQs
Aug 24 12:18:46 chtephan IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Aug 24 12:18:46 chtephan ..TIMER: vector=0x31 pin1=2 pin2=-1
Aug 24 12:18:46 chtephan number of MP IRQ sources: 15.
Aug 24 12:18:46 chtephan number of IO-APIC #2 registers: 24.
Aug 24 12:18:46 chtephan testing the IO APIC.......................
Aug 24 12:18:46 chtephan IO APIC #2......
Aug 24 12:18:46 chtephan .... register #00: 02000000
Aug 24 12:18:46 chtephan .......    : physical APIC id: 02
Aug 24 12:18:46 chtephan .......    : Delivery Type: 0
Aug 24 12:18:46 chtephan .......    : LTS          : 0
Aug 24 12:18:46 chtephan .... register #01: 00178003
Aug 24 12:18:46 chtephan .......     : max redirection entries: 0017
Aug 24 12:18:46 chtephan .......     : PRQ implemented: 1
Aug 24 12:18:46 chtephan .......     : IO APIC version: 0003
Aug 24 12:18:46 chtephan .... IRQ redirection table:
Aug 24 12:18:46 chtephan NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Aug 24 12:18:46 chtephan 00 000 00  1    0    0   0   0    0    0    00
Aug 24 12:18:46 chtephan 01 001 01  0    0    0   0   0    1    1    39
Aug 24 12:18:46 chtephan 02 001 01  0    0    0   0   0    1    1    31
Aug 24 12:18:46 chtephan 03 001 01  0    0    0   0   0    1    1    41
Aug 24 12:18:46 chtephan 04 001 01  0    0    0   0   0    1    1    49
Aug 24 12:18:46 chtephan 05 001 01  0    0    0   0   0    1    1    51
Aug 24 12:18:46 chtephan 06 001 01  0    0    0   0   0    1    1    59
Aug 24 12:18:46 chtephan 07 001 01  0    0    0   0   0    1    1    61
Aug 24 12:18:46 chtephan 08 001 01  0    0    0   0   0    1    1    69
Aug 24 12:18:46 chtephan 09 001 01  0    0    0   0   0    1    1    71
Aug 24 12:18:46 chtephan 0a 001 01  0    0    0   0   0    1    1    79
Aug 24 12:18:46 chtephan 0b 001 01  0    0    0   0   0    1    1    81
Aug 24 12:18:46 chtephan 0c 001 01  0    0    0   0   0    1    1    89
Aug 24 12:18:46 chtephan 0d 001 01  0    0    0   0   0    1    1    91
Aug 24 12:18:46 chtephan 0e 001 01  0    0    0   0   0    1    1    99
Aug 24 12:18:46 chtephan 0f 001 01  0    0    0   0   0    1    1    A1
Aug 24 12:18:46 chtephan 10 000 00  1    0    0   0   0    0    0    00
Aug 24 12:18:46 chtephan 11 000 00  1    0    0   0   0    0    0    00
Aug 24 12:18:46 chtephan 12 000 00  1    0    0   0   0    0    0    00
Aug 24 12:18:46 chtephan 13 000 00  1    0    0   0   0    0    0    00
Aug 24 12:18:46 chtephan 14 000 00  1    0    0   0   0    0    0    00
Aug 24 12:18:46 chtephan 15 000 00  1    0    0   0   0    0    0    00
Aug 24 12:18:46 chtephan 16 000 00  1    0    0   0   0    0    0    00
Aug 24 12:18:46 chtephan 17 000 00  1    0    0   0   0    0    0    00
Aug 24 12:18:46 chtephan IRQ to pin mappings:
Aug 24 12:18:46 chtephan IRQ0 -> 0:2
Aug 24 12:18:46 chtephan IRQ1 -> 0:1
Aug 24 12:18:46 chtephan IRQ3 -> 0:3
Aug 24 12:18:46 chtephan IRQ4 -> 0:4
Aug 24 12:18:46 chtephan IRQ5 -> 0:5
Aug 24 12:18:46 chtephan IRQ6 -> 0:6
Aug 24 12:18:46 chtephan IRQ7 -> 0:7
Aug 24 12:18:46 chtephan IRQ8 -> 0:8
Aug 24 12:18:46 chtephan IRQ9 -> 0:9
Aug 24 12:18:46 chtephan IRQ10 -> 0:10
Aug 24 12:18:46 chtephan IRQ11 -> 0:11
Aug 24 12:18:46 chtephan IRQ12 -> 0:12
Aug 24 12:18:46 chtephan IRQ13 -> 0:13
Aug 24 12:18:46 chtephan IRQ14 -> 0:14
Aug 24 12:18:46 chtephan IRQ15 -> 0:15
Aug 24 12:18:46 chtephan .................................... done.
Aug 24 12:18:46 chtephan Using local APIC timer interrupts.
Aug 24 12:18:46 chtephan calibrating APIC timer ...
Aug 24 12:18:46 chtephan ..... CPU clock speed is 1750.0071 MHz.
Aug 24 12:18:46 chtephan ..... host bus clock speed is 333.0347 MHz.
Aug 24 12:18:46 chtephan PM: Adding info for No Bus:legacy
Aug 24 12:18:46 chtephan Initializing RT netlink socket
Aug 24 12:18:46 chtephan PCI: PCI BIOS revision 2.10 entry at 0xfb3b0, last bus=1
Aug 24 12:18:46 chtephan PCI: Using configuration type 1
Aug 24 12:18:46 chtephan mtrr: v2.0 (20020519)
Aug 24 12:18:46 chtephan BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Aug 24 12:18:46 chtephan biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Aug 24 12:18:46 chtephan biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Aug 24 12:18:46 chtephan biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Aug 24 12:18:46 chtephan biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Aug 24 12:18:46 chtephan biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Aug 24 12:18:46 chtephan biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Aug 24 12:18:46 chtephan ACPI: Subsystem revision 20030813
Aug 24 12:18:46 chtephan ACPI: Interpreter enabled
Aug 24 12:18:46 chtephan ACPI: Using IOAPIC for interrupt routing
Aug 24 12:18:46 chtephan ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 24 12:18:46 chtephan PCI: Probing PCI hardware (bus 00)
Aug 24 12:18:46 chtephan PM: Adding info for No Bus:pci0000:00
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:00:00.0
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:00:01.0
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:00:09.0
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:00:09.1
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:00:0a.0
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:00:0b.0
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:00:0b.1
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:00:10.0
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:00:10.1
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:00:10.2
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:00:10.3
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:00:11.0
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:00:11.1
Aug 24 12:18:46 chtephan PM: Adding info for pci:0000:01:00.0
Aug 24 12:18:46 chtephan ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Aug 24 12:18:46 chtephan ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Aug 24 12:18:46 chtephan ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Aug 24 12:18:46 chtephan ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Aug 24 12:18:46 chtephan ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Aug 24 12:18:46 chtephan ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled)
Aug 24 12:18:46 chtephan ACPI: PCI Interrupt Link [ALKB] (IRQs 21, disabled)
Aug 24 12:18:46 chtephan ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)
Aug 24 12:18:46 chtephan ACPI: PCI Interrupt Link [ALKD] (IRQs 23, disabled)
Aug 24 12:18:46 chtephan Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 24 12:18:46 chtephan PnPBIOS: Scanning system for PnP BIOS support...
Aug 24 12:18:46 chtephan PnPBIOS: Found PnP BIOS installation structure at 0xc00fbe80
Aug 24 12:18:46 chtephan PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbeb0, dseg 0xf0000
Aug 24 12:18:46 chtephan PM: Adding info for No Bus:pnp0
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:00
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:01
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:02
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:03
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:04
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:05
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:06
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:07
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:08
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:09
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:0a
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:0b
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:0c
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:0d
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:0f
Aug 24 12:18:46 chtephan PM: Adding info for pnp:00:10
Aug 24 12:18:46 chtephan PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
Aug 24 12:18:46 chtephan drivers/usb/core/usb.c: registered new driver usbfs
Aug 24 12:18:46 chtephan drivers/usb/core/usb.c: registered new driver hub
Aug 24 12:18:46 chtephan IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
Aug 24 12:18:46 chtephan 00:00:08[A] -> 2-16 -> IRQ 16
Aug 24 12:18:46 chtephan IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
Aug 24 12:18:46 chtephan 00:00:08[B] -> 2-17 -> IRQ 17
Aug 24 12:18:46 chtephan IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
Aug 24 12:18:46 chtephan 00:00:08[C] -> 2-18 -> IRQ 18
Aug 24 12:18:46 chtephan IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
Aug 24 12:18:46 chtephan 00:00:08[D] -> 2-19 -> IRQ 19
Aug 24 12:18:46 chtephan Pin 2-17 already programmed
Aug 24 12:18:46 chtephan Pin 2-18 already programmed
Aug 24 12:18:46 chtephan Pin 2-19 already programmed
Aug 24 12:18:46 chtephan Pin 2-16 already programmed
Aug 24 12:18:46 chtephan Pin 2-18 already programmed
Aug 24 12:18:46 chtephan Pin 2-19 already programmed
Aug 24 12:18:46 chtephan Pin 2-16 already programmed
Aug 24 12:18:46 chtephan Pin 2-17 already programmed
Aug 24 12:18:46 chtephan Pin 2-19 already programmed
Aug 24 12:18:46 chtephan Pin 2-16 already programmed
Aug 24 12:18:46 chtephan Pin 2-17 already programmed
Aug 24 12:18:46 chtephan Pin 2-18 already programmed
Aug 24 12:18:46 chtephan Pin 2-18 already programmed
Aug 24 12:18:46 chtephan Pin 2-19 already programmed
Aug 24 12:18:46 chtephan Pin 2-16 already programmed
Aug 24 12:18:46 chtephan Pin 2-17 already programmed
Aug 24 12:18:46 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [ALKA] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [ALKC] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [ALKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ERROR: Unable to locate IOAPIC for IRQ -19/n<7>Pin 2-16 already programmed
Aug 24 12:18:46 chtephan Pin 2-17 already programmed
Aug 24 12:18:46 chtephan Pin 2-18 already programmed
Aug 24 12:18:46 chtephan Pin 2-19 already programmed
Aug 24 12:18:46 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [ALKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [ALKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [ALKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ERROR: Unable to locate IOAPIC for IRQ -19/nACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKA] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 24 12:18:46 chtephan PCI: Using ACPI for IRQ routing
Aug 24 12:18:46 chtephan PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Aug 24 12:18:46 chtephan pty: 256 Unix98 ptys configured
Aug 24 12:18:46 chtephan Machine check exception polling timer started.
Aug 24 12:18:46 chtephan Total HugeTLB memory allocated, 0
Aug 24 12:18:46 chtephan devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
Aug 24 12:18:46 chtephan devfs: boot_options: 0x1
Aug 24 12:18:46 chtephan Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Aug 24 12:18:46 chtephan Initializing Cryptographic API
Aug 24 12:18:46 chtephan PCI: Via IRQ fixup for 0000:00:10.0, from 10 to 13
Aug 24 12:18:46 chtephan PCI: Via IRQ fixup for 0000:00:10.1, from 5 to 13
Aug 24 12:18:46 chtephan PCI: Via IRQ fixup for 0000:00:10.2, from 11 to 13
Aug 24 12:18:46 chtephan ACPI: Power Button (FF) [PWRF]
Aug 24 12:18:46 chtephan ACPI: Fan [FAN] (on)
Aug 24 12:18:46 chtephan ACPI: Processor [CPU0] (supports C1 C2)
Aug 24 12:18:46 chtephan ACPI: Thermal Zone [THRM] (57 C)
Aug 24 12:18:46 chtephan PM: Adding info for No Bus:pnp1
Aug 24 12:18:46 chtephan isapnp: Scanning for PnP cards...
Aug 24 12:18:46 chtephan isapnp: No Plug & Play device found
Aug 24 12:18:46 chtephan request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
Aug 24 12:18:46 chtephan lp: driver loaded but no devices found
Aug 24 12:18:46 chtephan Real Time Clock Driver v1.11a
Aug 24 12:18:46 chtephan Non-volatile memory driver v1.2
Aug 24 12:18:46 chtephan Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Aug 24 12:18:46 chtephan Linux agpgart interface v0.100 (c) Dave Jones
Aug 24 12:18:46 chtephan agpgart: Detected VIA Apollo Pro KT400 chipset
Aug 24 12:18:46 chtephan agpgart: Maximum main memory to use for agp memory: 439M
Aug 24 12:18:46 chtephan agpgart: AGP aperture is 128M @ 0xd0000000
Aug 24 12:18:46 chtephan Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
Aug 24 12:18:46 chtephan ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 24 12:18:46 chtephan ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Aug 24 12:18:46 chtephan parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Aug 24 12:18:46 chtephan parport0: irq 7 detected
Aug 24 12:18:46 chtephan parport0: cpp_daisy: aa5500ff(38)
Aug 24 12:18:46 chtephan parport0: assign_addrs: aa5500ff(38)
Aug 24 12:18:46 chtephan parport0: cpp_daisy: aa5500ff(38)
Aug 24 12:18:46 chtephan parport0: assign_addrs: aa5500ff(38)
Aug 24 12:18:46 chtephan lp0: using parport0 (polling).
Aug 24 12:18:46 chtephan Using anticipatory scheduling elevator
Aug 24 12:18:46 chtephan Floppy drive(s): fd0 is 1.44M
Aug 24 12:18:46 chtephan FDC 0 is a post-1991 82077
Aug 24 12:18:46 chtephan PM: Adding info for platform:floppy0
Aug 24 12:18:46 chtephan RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Aug 24 12:18:46 chtephan loop: loaded (max 8 devices)
Aug 24 12:18:46 chtephan Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 24 12:18:46 chtephan ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 24 12:18:46 chtephan VP_IDE: IDE controller at PCI slot 0000:00:11.1
Aug 24 12:18:46 chtephan VP_IDE: (ide_setup_pci_device:) Could not enable device.
Aug 24 12:18:46 chtephan hda: Maxtor 94098U6, ATA DISK drive
Aug 24 12:18:46 chtephan PM: Adding info for No Bus:ide0
Aug 24 12:18:46 chtephan hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
Aug 24 12:18:46 chtephan PM: Adding info for No Bus:ide1
Aug 24 12:18:46 chtephan hdd: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
Aug 24 12:18:46 chtephan ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 24 12:18:46 chtephan PM: Adding info for ide:0.0
Aug 24 12:18:46 chtephan ide1 at 0x170-0x177,0x376 on irq 15
Aug 24 12:18:46 chtephan PM: Adding info for ide:1.0
Aug 24 12:18:46 chtephan PM: Adding info for ide:1.1
Aug 24 12:18:46 chtephan hda: max request size: 128KiB
Aug 24 12:18:46 chtephan hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63
Aug 24 12:18:46 chtephan /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >
Aug 24 12:18:46 chtephan hdc: ATAPI 32X CD-ROM drive, 128kB Cache
Aug 24 12:18:46 chtephan Uniform CD-ROM driver Revision: 3.12
Aug 24 12:18:46 chtephan hdd: ATAPI 48X DVD-ROM drive, 512kB Cache
Aug 24 12:18:46 chtephan ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Aug 24 12:18:46 chtephan ohci-hcd: block sizes: ed 64 td 64
Aug 24 12:18:46 chtephan drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Aug 24 12:18:46 chtephan mice: PS/2 mouse device common for all mice
Aug 24 12:18:46 chtephan input: PC Speaker
Aug 24 12:18:46 chtephan input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Aug 24 12:18:46 chtephan serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 24 12:18:46 chtephan input: AT Set 2 keyboard on isa0060/serio0
Aug 24 12:18:46 chtephan serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 24 12:18:46 chtephan i2c /dev entries driver module version 2.7.0 (20021208)
Aug 24 12:18:46 chtephan md: linear personality registered as nr 1
Aug 24 12:18:46 chtephan md: raid0 personality registered as nr 2
Aug 24 12:18:46 chtephan md: raid1 personality registered as nr 3
Aug 24 12:18:46 chtephan md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Aug 24 12:18:46 chtephan device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
Aug 24 12:18:46 chtephan NET4: Linux TCP/IP 1.0 for NET4.0
Aug 24 12:18:46 chtephan IP: routing cache hash table of 4096 buckets, 32Kbytes
Aug 24 12:18:46 chtephan TCP: Hash tables configured (established 32768 bind 65536)
Aug 24 12:18:46 chtephan GRE over IPv4 tunneling driver
Aug 24 12:18:46 chtephan Initializing IPsec netlink socket
Aug 24 12:18:46 chtephan NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Aug 24 12:18:46 chtephan IPv6 v0.8 for NET4.0
Aug 24 12:18:46 chtephan IPv6 over IPv4 tunneling driver
Aug 24 12:18:46 chtephan BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
Aug 24 12:18:46 chtephan ACPI: (supports S0 S1 S3 S4 S5)

--=-7nDb2w3L/vgIHn9kWUgS
Content-Disposition: attachment; filename=bootlog-after.txt
Content-Type: text/plain; name=bootlog-after.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Aug 27 02:16:53 chtephan Linux version 2.6.0-test4 (root@chtephan) (gcc-Version 3.3.1 (Gentoo Linux 3.3.1, propolice)) #1 Wed Aug 27 02:15:04 CEST 2003
Aug 27 02:16:53 chtephan Video mode to be used for restore is f00
Aug 27 02:16:53 chtephan BIOS-provided physical RAM map:
Aug 27 02:16:53 chtephan BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug 27 02:16:53 chtephan BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug 27 02:16:53 chtephan BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug 27 02:16:53 chtephan BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
Aug 27 02:16:53 chtephan BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
Aug 27 02:16:53 chtephan BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
Aug 27 02:16:53 chtephan BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 27 02:16:53 chtephan BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug 27 02:16:53 chtephan BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 27 02:16:53 chtephan 511MB LOWMEM available.
Aug 27 02:16:53 chtephan found SMP MP-table at 000f5a30
Aug 27 02:16:53 chtephan hm, page 000f5000 reserved twice.
Aug 27 02:16:53 chtephan hm, page 000f6000 reserved twice.
Aug 27 02:16:53 chtephan hm, page 000f1000 reserved twice.
Aug 27 02:16:53 chtephan hm, page 000f2000 reserved twice.
Aug 27 02:16:53 chtephan On node 0 totalpages: 131056
Aug 27 02:16:53 chtephan DMA zone: 4096 pages, LIFO batch:1
Aug 27 02:16:53 chtephan Normal zone: 126960 pages, LIFO batch:16
Aug 27 02:16:53 chtephan HighMem zone: 0 pages, LIFO batch:1
Aug 27 02:16:53 chtephan DMI 2.2 present.
Aug 27 02:16:53 chtephan ACPI: RSDP (v000 KT400                                     ) @ 0x000f7460
Aug 27 02:16:53 chtephan ACPI: RSDT (v001 KT400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
Aug 27 02:16:53 chtephan ACPI: FADT (v001 KT400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
Aug 27 02:16:53 chtephan ACPI: MADT (v001 KT400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff7000
Aug 27 02:16:53 chtephan ACPI: DSDT (v001 KT400  AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
Aug 27 02:16:53 chtephan ACPI: Local APIC address 0xfee00000
Aug 27 02:16:53 chtephan ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Aug 27 02:16:53 chtephan Processor #0 6:8 APIC version 16
Aug 27 02:16:53 chtephan ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
Aug 27 02:16:53 chtephan ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
Aug 27 02:16:53 chtephan IOAPIC[0]: Assigned apic_id 2
Aug 27 02:16:53 chtephan IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
Aug 27 02:16:53 chtephan ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
Aug 27 02:16:53 chtephan ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x0] trigger[0x0])
Aug 27 02:16:53 chtephan ACPI: INT_SRC_OVR (bus[0] irq[0xe] global_irq[0xe] polarity[0x1] trigger[0x1])
Aug 27 02:16:53 chtephan ACPI: INT_SRC_OVR (bus[0] irq[0xf] global_irq[0xf] polarity[0x1] trigger[0x1])
Aug 27 02:16:53 chtephan Enabling APIC mode:  Flat.  Using 1 I/O APICs
Aug 27 02:16:53 chtephan Using ACPI (MADT) for SMP configuration information
Aug 27 02:16:53 chtephan Building zonelist for node : 0
Aug 27 02:16:53 chtephan Kernel command line: auto BOOT_IMAGE=test ro root=fe01
Aug 27 02:16:53 chtephan Initializing CPU#0
Aug 27 02:16:53 chtephan PID hash table entries: 2048 (order 11: 16384 bytes)
Aug 27 02:16:53 chtephan Detected 1750.898 MHz processor.
Aug 27 02:16:53 chtephan Console: colour VGA+ 80x25
Aug 27 02:16:53 chtephan Calibrating delay loop... 3448.83 BogoMIPS
Aug 27 02:16:53 chtephan Memory: 511740k/524224k available (2838k kernel code, 11736k reserved, 983k data, 184k init, 0k highmem)
Aug 27 02:16:53 chtephan Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug 27 02:16:53 chtephan Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Aug 27 02:16:53 chtephan Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 27 02:16:53 chtephan -> /dev
Aug 27 02:16:53 chtephan -> /dev/console
Aug 27 02:16:53 chtephan -> /root
Aug 27 02:16:53 chtephan CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
Aug 27 02:16:53 chtephan CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
Aug 27 02:16:53 chtephan CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 27 02:16:53 chtephan CPU: L2 Cache: 256K (64 bytes/line)
Aug 27 02:16:53 chtephan CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Aug 27 02:16:53 chtephan Intel machine check architecture supported.
Aug 27 02:16:53 chtephan Intel machine check reporting enabled on CPU#0.
Aug 27 02:16:53 chtephan CPU: AMD Athlon(tm)  stepping 00
Aug 27 02:16:53 chtephan Enabling fast FPU save and restore... done.
Aug 27 02:16:53 chtephan Enabling unmasked SIMD FPU exception support... done.
Aug 27 02:16:53 chtephan Checking 'hlt' instruction... OK.
Aug 27 02:16:53 chtephan POSIX conformance testing by UNIFIX
Aug 27 02:16:53 chtephan enabled ExtINT on CPU#0
Aug 27 02:16:53 chtephan ESR value before enabling vector: 00000000
Aug 27 02:16:53 chtephan ESR value after enabling vector: 00000000
Aug 27 02:16:53 chtephan ENABLING IO-APIC IRQs
Aug 27 02:16:53 chtephan init IO_APIC IRQs
Aug 27 02:16:53 chtephan IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Aug 27 02:16:53 chtephan ..TIMER: vector=0x31 pin1=2 pin2=-1
Aug 27 02:16:53 chtephan number of MP IRQ sources: 15.
Aug 27 02:16:53 chtephan number of IO-APIC #2 registers: 24.
Aug 27 02:16:53 chtephan testing the IO APIC.......................
Aug 27 02:16:53 chtephan IO APIC #2......
Aug 27 02:16:53 chtephan .... register #00: 02000000
Aug 27 02:16:53 chtephan .......    : physical APIC id: 02
Aug 27 02:16:53 chtephan .......    : Delivery Type: 0
Aug 27 02:16:53 chtephan .......    : LTS          : 0
Aug 27 02:16:53 chtephan .... register #01: 00178003
Aug 27 02:16:53 chtephan .......     : max redirection entries: 0017
Aug 27 02:16:53 chtephan .......     : PRQ implemented: 1
Aug 27 02:16:53 chtephan .......     : IO APIC version: 0003
Aug 27 02:16:53 chtephan .... IRQ redirection table:
Aug 27 02:16:53 chtephan NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Aug 27 02:16:53 chtephan 00 000 00  1    0    0   0   0    0    0    00
Aug 27 02:16:53 chtephan 01 001 01  0    0    0   0   0    1    1    39
Aug 27 02:16:53 chtephan 02 001 01  0    0    0   0   0    1    1    31
Aug 27 02:16:53 chtephan 03 001 01  0    0    0   0   0    1    1    41
Aug 27 02:16:53 chtephan 04 001 01  0    0    0   0   0    1    1    49
Aug 27 02:16:53 chtephan 05 001 01  0    0    0   0   0    1    1    51
Aug 27 02:16:53 chtephan 06 001 01  0    0    0   0   0    1    1    59
Aug 27 02:16:53 chtephan 07 001 01  0    0    0   0   0    1    1    61
Aug 27 02:16:53 chtephan 08 001 01  0    0    0   0   0    1    1    69
Aug 27 02:16:53 chtephan 09 001 01  0    0    0   0   0    1    1    71
Aug 27 02:16:53 chtephan 0a 001 01  0    0    0   0   0    1    1    79
Aug 27 02:16:53 chtephan 0b 001 01  0    0    0   0   0    1    1    81
Aug 27 02:16:53 chtephan 0c 001 01  0    0    0   0   0    1    1    89
Aug 27 02:16:53 chtephan 0d 001 01  0    0    0   0   0    1    1    91
Aug 27 02:16:53 chtephan 0e 001 01  0    0    0   0   0    1    1    99
Aug 27 02:16:53 chtephan 0f 001 01  0    0    0   0   0    1    1    A1
Aug 27 02:16:53 chtephan 10 000 00  1    0    0   0   0    0    0    00
Aug 27 02:16:53 chtephan 11 000 00  1    0    0   0   0    0    0    00
Aug 27 02:16:53 chtephan 12 000 00  1    0    0   0   0    0    0    00
Aug 27 02:16:53 chtephan 13 000 00  1    0    0   0   0    0    0    00
Aug 27 02:16:53 chtephan 14 000 00  1    0    0   0   0    0    0    00
Aug 27 02:16:53 chtephan 15 000 00  1    0    0   0   0    0    0    00
Aug 27 02:16:53 chtephan 16 000 00  1    0    0   0   0    0    0    00
Aug 27 02:16:53 chtephan 17 000 00  1    0    0   0   0    0    0    00
Aug 27 02:16:53 chtephan IRQ to pin mappings:
Aug 27 02:16:53 chtephan IRQ0 -> 0:2
Aug 27 02:16:53 chtephan IRQ1 -> 0:1
Aug 27 02:16:53 chtephan IRQ3 -> 0:3
Aug 27 02:16:53 chtephan IRQ4 -> 0:4
Aug 27 02:16:53 chtephan IRQ5 -> 0:5
Aug 27 02:16:53 chtephan IRQ6 -> 0:6
Aug 27 02:16:53 chtephan IRQ7 -> 0:7
Aug 27 02:16:53 chtephan IRQ8 -> 0:8
Aug 27 02:16:53 chtephan IRQ9 -> 0:9
Aug 27 02:16:53 chtephan IRQ10 -> 0:10
Aug 27 02:16:53 chtephan IRQ11 -> 0:11
Aug 27 02:16:53 chtephan IRQ12 -> 0:12
Aug 27 02:16:53 chtephan IRQ13 -> 0:13
Aug 27 02:16:53 chtephan IRQ14 -> 0:14
Aug 27 02:16:53 chtephan IRQ15 -> 0:15
Aug 27 02:16:53 chtephan .................................... done.
Aug 27 02:16:53 chtephan Using local APIC timer interrupts.
Aug 27 02:16:53 chtephan calibrating APIC timer ...
Aug 27 02:16:53 chtephan ..... CPU clock speed is 1750.0071 MHz.
Aug 27 02:16:53 chtephan ..... host bus clock speed is 333.0347 MHz.
Aug 27 02:16:53 chtephan PM: Adding info for No Bus:legacy
Aug 27 02:16:53 chtephan Initializing RT netlink socket
Aug 27 02:16:53 chtephan PCI: PCI BIOS revision 2.10 entry at 0xfb3b0, last bus=1
Aug 27 02:16:53 chtephan PCI: Using configuration type 1
Aug 27 02:16:53 chtephan mtrr: v2.0 (20020519)
Aug 27 02:16:53 chtephan BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Aug 27 02:16:53 chtephan biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Aug 27 02:16:53 chtephan biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Aug 27 02:16:53 chtephan biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Aug 27 02:16:53 chtephan biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Aug 27 02:16:53 chtephan biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Aug 27 02:16:53 chtephan biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Aug 27 02:16:53 chtephan ACPI: Subsystem revision 20030813
Aug 27 02:16:53 chtephan ACPI: Interpreter enabled
Aug 27 02:16:53 chtephan ACPI: Using IOAPIC for interrupt routing
Aug 27 02:16:53 chtephan ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 27 02:16:53 chtephan PCI: Probing PCI hardware (bus 00)
Aug 27 02:16:53 chtephan PM: Adding info for No Bus:pci0000:00
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:00:00.0
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:00:01.0
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:00:09.0
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:00:09.1
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:00:0a.0
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:00:0b.0
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:00:0b.1
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:00:10.0
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:00:10.1
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:00:10.2
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:00:10.3
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:00:11.0
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:00:11.1
Aug 27 02:16:53 chtephan PM: Adding info for pci:0000:01:00.0
Aug 27 02:16:53 chtephan ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Aug 27 02:16:53 chtephan ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Aug 27 02:16:53 chtephan ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Aug 27 02:16:53 chtephan ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Aug 27 02:16:53 chtephan ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Aug 27 02:16:53 chtephan ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled)
Aug 27 02:16:53 chtephan ACPI: PCI Interrupt Link [ALKB] (IRQs 21, disabled)
Aug 27 02:16:53 chtephan ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)
Aug 27 02:16:53 chtephan ACPI: PCI Interrupt Link [ALKD] (IRQs 23, disabled)
Aug 27 02:16:53 chtephan Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 27 02:16:53 chtephan PnPBIOS: Scanning system for PnP BIOS support...
Aug 27 02:16:53 chtephan PnPBIOS: Found PnP BIOS installation structure at 0xc00fbe80
Aug 27 02:16:53 chtephan PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbeb0, dseg 0xf0000
Aug 27 02:16:53 chtephan PM: Adding info for No Bus:pnp0
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:00
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:01
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:02
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:03
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:04
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:05
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:06
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:07
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:08
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:09
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:0a
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:0b
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:0c
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:0d
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:0f
Aug 27 02:16:53 chtephan PM: Adding info for pnp:00:10
Aug 27 02:16:53 chtephan PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
Aug 27 02:16:53 chtephan drivers/usb/core/usb.c: registered new driver usbfs
Aug 27 02:16:53 chtephan drivers/usb/core/usb.c: registered new driver hub
Aug 27 02:16:53 chtephan IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
Aug 27 02:16:53 chtephan 00:00:08[A] -> 2-16 -> IRQ 16
Aug 27 02:16:53 chtephan IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
Aug 27 02:16:53 chtephan 00:00:08[B] -> 2-17 -> IRQ 17
Aug 27 02:16:53 chtephan IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
Aug 27 02:16:53 chtephan 00:00:08[C] -> 2-18 -> IRQ 18
Aug 27 02:16:53 chtephan IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
Aug 27 02:16:53 chtephan 00:00:08[D] -> 2-19 -> IRQ 19
Aug 27 02:16:53 chtephan Pin 2-17 already programmed
Aug 27 02:16:53 chtephan Pin 2-18 already programmed
Aug 27 02:16:53 chtephan Pin 2-19 already programmed
Aug 27 02:16:53 chtephan Pin 2-16 already programmed
Aug 27 02:16:53 chtephan Pin 2-18 already programmed
Aug 27 02:16:53 chtephan Pin 2-19 already programmed
Aug 27 02:16:53 chtephan Pin 2-16 already programmed
Aug 27 02:16:53 chtephan Pin 2-17 already programmed
Aug 27 02:16:53 chtephan Pin 2-19 already programmed
Aug 27 02:16:53 chtephan Pin 2-16 already programmed
Aug 27 02:16:53 chtephan Pin 2-17 already programmed
Aug 27 02:16:53 chtephan Pin 2-18 already programmed
Aug 27 02:16:53 chtephan Pin 2-18 already programmed
Aug 27 02:16:53 chtephan Pin 2-19 already programmed
Aug 27 02:16:53 chtephan Pin 2-16 already programmed
Aug 27 02:16:53 chtephan Pin 2-17 already programmed
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKA] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKC] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan Pin 2-16 already programmed
Aug 27 02:16:53 chtephan Pin 2-17 already programmed
Aug 27 02:16:53 chtephan Pin 2-18 already programmed
Aug 27 02:16:53 chtephan Pin 2-19 already programmed
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKD] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: No IRQ known for interrupt pin B of device 0000:00:10.1
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: No IRQ known for interrupt pin C of device 0000:00:10.2
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: No IRQ known for interrupt pin D of device 0000:00:10.3
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKA] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
Aug 27 02:16:53 chtephan PCI: Using ACPI for IRQ routing
Aug 27 02:16:53 chtephan PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Aug 27 02:16:53 chtephan pty: 256 Unix98 ptys configured
Aug 27 02:16:53 chtephan Machine check exception polling timer started.
Aug 27 02:16:53 chtephan Total HugeTLB memory allocated, 0
Aug 27 02:16:53 chtephan devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
Aug 27 02:16:53 chtephan devfs: boot_options: 0x1
Aug 27 02:16:53 chtephan Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Aug 27 02:16:53 chtephan Loading Reiser4. See www.namesys.com for a description of Reiser4.
Aug 27 02:16:53 chtephan Initializing Cryptographic API
Aug 27 02:16:53 chtephan ACPI: Power Button (FF) [PWRF]
Aug 27 02:16:53 chtephan ACPI: Fan [FAN] (on)
Aug 27 02:16:53 chtephan ACPI: Processor [CPU0] (supports C1 C2)
Aug 27 02:16:53 chtephan ACPI: Thermal Zone [THRM] (53 C)
Aug 27 02:16:53 chtephan PM: Adding info for No Bus:pnp1
Aug 27 02:16:53 chtephan isapnp: Scanning for PnP cards...
Aug 27 02:16:53 chtephan isapnp: No Plug & Play device found
Aug 27 02:16:53 chtephan request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
Aug 27 02:16:53 chtephan lp: driver loaded but no devices found
Aug 27 02:16:53 chtephan Real Time Clock Driver v1.11a
Aug 27 02:16:53 chtephan Non-volatile memory driver v1.2
Aug 27 02:16:53 chtephan Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Aug 27 02:16:53 chtephan Linux agpgart interface v0.100 (c) Dave Jones
Aug 27 02:16:53 chtephan agpgart: Detected VIA Apollo Pro KT400 chipset
Aug 27 02:16:53 chtephan agpgart: Maximum main memory to use for agp memory: 439M
Aug 27 02:16:53 chtephan agpgart: AGP aperture is 128M @ 0xd0000000
Aug 27 02:16:53 chtephan Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
Aug 27 02:16:53 chtephan ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 27 02:16:53 chtephan ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Aug 27 02:16:53 chtephan parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Aug 27 02:16:53 chtephan parport0: irq 7 detected
Aug 27 02:16:53 chtephan parport0: cpp_daisy: aa5500ff(38)
Aug 27 02:16:53 chtephan parport0: assign_addrs: aa5500ff(38)
Aug 27 02:16:53 chtephan parport0: cpp_daisy: aa5500ff(38)
Aug 27 02:16:53 chtephan parport0: assign_addrs: aa5500ff(38)
Aug 27 02:16:53 chtephan lp0: using parport0 (polling).
Aug 27 02:16:53 chtephan Using anticipatory scheduling elevator
Aug 27 02:16:53 chtephan Floppy drive(s): fd0 is 1.44M
Aug 27 02:16:53 chtephan FDC 0 is a post-1991 82077
Aug 27 02:16:53 chtephan PM: Adding info for platform:floppy0
Aug 27 02:16:53 chtephan RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Aug 27 02:16:53 chtephan loop: loaded (max 8 devices)
Aug 27 02:16:53 chtephan Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 27 02:16:53 chtephan ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 27 02:16:53 chtephan VP_IDE: IDE controller at PCI slot 0000:00:11.1
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKA] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
Aug 27 02:16:53 chtephan VP_IDE: chipset revision 6
Aug 27 02:16:53 chtephan VP_IDE: not 100% native mode: will probe irqs later
Aug 27 02:16:53 chtephan ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 27 02:16:53 chtephan VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Aug 27 02:16:53 chtephan ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:pio
Aug 27 02:16:53 chtephan ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:DMA, hdd:DMA
Aug 27 02:16:53 chtephan hda: Maxtor 94098U6, ATA DISK drive
Aug 27 02:16:53 chtephan PM: Adding info for No Bus:ide0
Aug 27 02:16:53 chtephan ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 27 02:16:53 chtephan PM: Adding info for ide:0.0
Aug 27 02:16:53 chtephan hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
Aug 27 02:16:53 chtephan PM: Adding info for No Bus:ide1
Aug 27 02:16:53 chtephan hdd: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
Aug 27 02:16:53 chtephan ide1 at 0x170-0x177,0x376 on irq 15
Aug 27 02:16:53 chtephan PM: Adding info for ide:1.0
Aug 27 02:16:53 chtephan PM: Adding info for ide:1.1
Aug 27 02:16:53 chtephan hda: max request size: 128KiB
Aug 27 02:16:53 chtephan hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
Aug 27 02:16:53 chtephan /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
Aug 27 02:16:53 chtephan hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Aug 27 02:16:53 chtephan Uniform CD-ROM driver Revision: 3.12
Aug 27 02:16:53 chtephan hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: No IRQ known for interrupt pin D of device 0000:00:10.3
Aug 27 02:16:53 chtephan ehci_hcd 0000:00:10.3: EHCI Host Controller
Aug 27 02:16:53 chtephan ehci_hcd 0000:00:10.3: irq 11, pci mem e0833000
Aug 27 02:16:53 chtephan ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
Aug 27 02:16:53 chtephan ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
Aug 27 02:16:53 chtephan PM: Adding info for usb:usb1
Aug 27 02:16:53 chtephan hub 1-0:0: USB hub found
Aug 27 02:16:53 chtephan hub 1-0:0: 6 ports detected
Aug 27 02:16:53 chtephan PM: Adding info for usb:1-0:0
Aug 27 02:16:53 chtephan ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Aug 27 02:16:53 chtephan ohci-hcd: block sizes: ed 64 td 64
Aug 27 02:16:53 chtephan drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
Aug 27 02:16:53 chtephan uhci-hcd 0000:00:10.0: UHCI Host Controller
Aug 27 02:16:53 chtephan uhci-hcd 0000:00:10.0: irq 10, io base 0000dc00
Aug 27 02:16:53 chtephan uhci-hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
Aug 27 02:16:53 chtephan PM: Adding info for usb:usb2
Aug 27 02:16:53 chtephan hub 2-0:0: USB hub found
Aug 27 02:16:53 chtephan hub 2-0:0: 2 ports detected
Aug 27 02:16:53 chtephan PM: Adding info for usb:2-0:0
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: No IRQ known for interrupt pin B of device 0000:00:10.1
Aug 27 02:16:53 chtephan uhci-hcd 0000:00:10.1: UHCI Host Controller
Aug 27 02:16:53 chtephan uhci-hcd 0000:00:10.1: irq 5, io base 0000e000
Aug 27 02:16:53 chtephan uhci-hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
Aug 27 02:16:53 chtephan PM: Adding info for usb:usb3
Aug 27 02:16:53 chtephan hub 3-0:0: USB hub found
Aug 27 02:16:53 chtephan hub 3-0:0: 2 ports detected
Aug 27 02:16:53 chtephan PM: Adding info for usb:3-0:0
Aug 27 02:16:53 chtephan ACPI: Unable to set IRQ for PCI Interrupt Link [ALKB] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
Aug 27 02:16:53 chtephan ACPI: No IRQ known for interrupt pin C of device 0000:00:10.2
Aug 27 02:16:53 chtephan uhci-hcd 0000:00:10.2: UHCI Host Controller
Aug 27 02:16:53 chtephan uhci-hcd 0000:00:10.2: irq 11, io base 0000e400
Aug 27 02:16:53 chtephan uhci-hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
Aug 27 02:16:53 chtephan PM: Adding info for usb:usb4
Aug 27 02:16:53 chtephan hub 4-0:0: USB hub found
Aug 27 02:16:53 chtephan hub 4-0:0: 2 ports detected
Aug 27 02:16:53 chtephan PM: Adding info for usb:4-0:0
Aug 27 02:16:53 chtephan mice: PS/2 mouse device common for all mice
Aug 27 02:16:53 chtephan input: PC Speaker
Aug 27 02:16:53 chtephan input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Aug 27 02:16:53 chtephan serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 27 02:16:53 chtephan input: AT Set 2 keyboard on isa0060/serio0
Aug 27 02:16:53 chtephan serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 27 02:16:53 chtephan i2c /dev entries driver module version 2.7.0 (20021208)
Aug 27 02:16:53 chtephan md: linear personality registered as nr 1
Aug 27 02:16:53 chtephan md: raid0 personality registered as nr 2
Aug 27 02:16:53 chtephan md: raid1 personality registered as nr 3
Aug 27 02:16:53 chtephan md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Aug 27 02:16:53 chtephan device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
Aug 27 02:16:53 chtephan NET4: Linux TCP/IP 1.0 for NET4.0
Aug 27 02:16:53 chtephan IP: routing cache hash table of 4096 buckets, 32Kbytes
Aug 27 02:16:53 chtephan TCP: Hash tables configured (established 32768 bind 65536)
Aug 27 02:16:53 chtephan GRE over IPv4 tunneling driver
Aug 27 02:16:53 chtephan Initializing IPsec netlink socket
Aug 27 02:16:53 chtephan NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Aug 27 02:16:53 chtephan IPv6 v0.8 for NET4.0
Aug 27 02:16:53 chtephan IPv6 over IPv4 tunneling driver
Aug 27 02:16:53 chtephan BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
Aug 27 02:16:53 chtephan ACPI: (supports S0 S1 S3 S4 S5)

--=-7nDb2w3L/vgIHn9kWUgS--

