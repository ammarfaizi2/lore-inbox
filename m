Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTIPHG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 03:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTIPHG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 03:06:28 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:32904 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S261782AbTIPHGQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 03:06:16 -0400
Date: Tue, 16 Sep 2003 09:06:12 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: test5-mm2 and test5: problems with interrupts and PM in VIA Chipset
Message-ID: <Pine.LNX.4.44.0309160851590.2141-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an Acer laptop that has lots of problems just trying to boot 
normally. In all kernels since test3 I have to add several options to lore 
or less be able to work: pci=noacpi pci=usepirqmask pci=biosirq

My last try has been test5-mm2 as I also need to suspend the laptop usin
acpi and I have not been able to do so yet.

The most "appealing" messages are the following ones, using the boot 
parametres:
PCI: Cannot allocate resource region 0 of device 0000:00:0a.0
PCI: No IRQ known for interrupt pin D of device 0000:00:10.3.
drivers/usb/core/hcd-pci.c: Found HC with no IRQ.  Check BIOS/PCI 0000:00:10.3 setup!
drivers/usb/core/hcd-pci.c: Found HC with no IRQ.  Check BIOS/PCI 0000:00:10.1 setup!
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0. Bank 0: e665800000000185

When booting without parametres, the ethernet does not work (via-rhine) 
and the messages are different:
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
PCI: Cannot allocate resource region 0 of device 0000:00:0a.0
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 10
PCI: Via IRQ fixup for 0000:00:10.1, from 255 to 10
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1
irq 11: nobody cared!
Call Trace:
 .....
handlers:
[<ee8776c0>] (usb_hcd_irq+0x0/0x60 [usbcore])
Disabling IRQ #11
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 782d, resetting...

I attach the lspci -vv, /proc/interrupts amd dmesg for the case of bootgin
without parametres that I think should be addressed first. I'll do any
tests needed to fix these problems.

$ lspci -vv
00:00.0 Host bridge: VIA Technologies, Inc. P/KN266 Host Bridge
	Subsystem: VIA Technologies, Inc. P/KN266 Host Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at b0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: e0000000-efffffff
	Prefetchable memory behind bridge: a0000000-afffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
	Subsystem: Citicorp TTI: Unknown device 10e7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 2e000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 2e400000-2e7ff000 (prefetchable)
	Memory window 1: 2e800000-2ebff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Citicorp TTI: Unknown device 1162
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (500ns min, 1000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at f0004000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 22
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 1200 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 22
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 1300 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: VIA Technologies, Inc. USB 2.0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 10
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 1100 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0030
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at e000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 80)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0030
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at e100 [size=256]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0030
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (750ns min, 2000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e200 [size=256]
	Region 1: Memory at f0008000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

01:00.0 VGA compatible controller: S3 Inc. [ProSavageDDR K4M266] (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0030
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (1000ns min, 63750ns max), cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0080000 (32-bit, non-prefetchable) [size=512K]
	Region 1: Memory at a8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at 000c0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x4

$ dmesg
Linux version 2.6.0-test5-mm2 (pau@pau.intranet.ct) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #5 Mon Sep 15 23:17:50 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002dff0000 (usable)
 BIOS-e820: 000000002dff0000 - 000000002dffffc0 (ACPI data)
 BIOS-e820: 000000002dffffc0 - 000000002e000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
735MB LOWMEM available.
On node 0 totalpages: 188400
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 184304 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 OID_00                                    ) @ 0x000e5010
ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 _CSI 0x00010101) @ 0x2dfffbc0
ACPI: FADT (v001 INSYDE FACP_000 0x00000100 _CSI 0x00010101) @ 0x2dfffac0
ACPI: BOOT (v001 INSYDE SYS_BOOT 0x00000100 _CSI 0x00010101) @ 0x2dfffb50
ACPI: DBGP (v001 INSYDE DBGP_000 0x00000100 _CSI 0x00010101) @ 0x2dfffb80
ACPI: DSDT (v001 INSYDE    KN266 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: ro root=LABEL=/ resume=/dev/hda10
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
current: c02bb9c0
current->thread_info: c0322000
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1525.924 MHz processor.
Console: colour VGA+ 80x25
Memory: 742556k/753600k available (1549k kernel code, 10292k reserved, 633k data, 232k init, 0k highmem)
zapping low mappings.
Calibrating delay loop... 2981.88 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1800+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1525.0641 MHz.
..... host bus clock speed is 265.0328 MHz.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xe8a04, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
spurious 8259A interrupt: IRQ7.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
00:00:0a[A] -> IRQ 11 Mode 1 Trigger 1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
00:00:0c[A] -> IRQ 5 Mode 1 Trigger 1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
00:00:10[A] -> IRQ 10 Mode 1 Trigger 1
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PIC: IRQ (10) already programmed
PIC: IRQ (5) already programmed
PIC: IRQ (11) already programmed
PIC: IRQ (5) already programmed
PIC: IRQ (11) already programmed
PIC: IRQ (10) already programmed
PIC: IRQ (10) already programmed
PIC: IRQ (10) already programmed
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
PCI: Cannot allocate resource region 0 of device 0000:00:0a.0
divert: not allocating divert_blk for non-ethernet device lo
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 10
PCI: Via IRQ fixup for 0000:00:10.1, from 255 to 10
ACPI: AC Adapter [ADP0] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (79 C)
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N030ATCS04-0, ATA DISK drive
Using anticipatory scheduling io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA740 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(100)
 hda: hda1 < hda5 hda6 hda7 hda8 hda9 hda10 > hda2
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
pmdisk: Resume From Partition: /dev/hda10, Device: hda10
pmdisk: Partition is normal swap space
Resume Machine: Error -22 resuming
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 168k freed
VFS: Mounted root (ext2 filesystem).
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 232k freed
Real Time Clock Driver v1.12
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:10.3: EHCI Host Controller
irq 11: nobody cared!
Call Trace:
 [<c010ebca>] __report_bad_irq+0x2a/0x90
 [<c010ecbc>] note_interrupt+0x6c/0xa0
 [<c010ef90>] do_IRQ+0x130/0x140
 [<c02831cc>] common_interrupt+0x18/0x20
 [<c01271c0>] do_softirq+0x40/0xa0
 [<c010ef66>] do_IRQ+0x106/0x140
 [<c02831cc>] common_interrupt+0x18/0x20
 [<c010f50c>] setup_irq+0x9c/0xf0
 [<ee8776c0>] usb_hcd_irq+0x0/0x60 [usbcore]
 [<c010f048>] request_irq+0xa8/0xe0
 [<ee87ab97>] usb_hcd_pci_probe+0x277/0x490 [usbcore]
 [<ee8776c0>] usb_hcd_irq+0x0/0x60 [usbcore]
 [<c01af0d2>] pci_device_probe_static+0x52/0x70
 [<c01af12b>] __pci_device_probe+0x3b/0x50
 [<c01af16c>] pci_device_probe+0x2c/0x50
 [<c01e8faf>] bus_match+0x3f/0x70
 [<c01e90ff>] driver_attach+0x6f/0xa0
 [<c01e939d>] bus_add_driver+0x8d/0xa0
 [<c01e981f>] driver_register+0x2f/0x40
 [<c01af35f>] pci_register_driver+0x5f/0x90
 [<ee80902b>] init+0x2b/0x51 [ehci_hcd]
 [<c013a27c>] sys_init_module+0x12c/0x250
 [<c028280a>] sysenter_past_esp+0x43/0x65

handlers:
[<ee8776c0>] (usb_hcd_irq+0x0/0x60 [usbcore])
Disabling IRQ #11
ehci_hcd 0000:00:10.3: irq 11, pci mem ee80b000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:0: USB hub found
hub 1-0:0: 4 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:10.0: UHCI Host Controller
uhci-hcd 0000:00:10.0: irq 10, io base 00001200
uhci-hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
uhci-hcd 0000:00:10.1: UHCI Host Controller
uhci-hcd 0000:00:10.1: irq 10, io base 00001300
uhci-hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda6, internal journal
Adding 811240k swap on /dev/hda10.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
blk: queue edd48600, I/O limit 4095Mb (mask 0xffffffff)
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
kudzu: numerical sysctl 1 23 is obsolete.
parport0: PC-style at 0x378 [PCSPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
inserting floppy driver for 2.6.0-test5-mm2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
ip_tables: (C) 2000-2002 Netfilter core team
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
divert: allocating divert_blk for eth0
eth0: VIA VT6102 Rhine-II at 0xf0008000, 00:c0:9f:29:06:73, IRQ 10.
eth0: MII PHY found at address 1, status 0x782d advertising 01e1 Link 0021.
ip_tables: (C) 2000-2002 Netfilter core team
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:00:0a.0 [10cf:10e7]
Yenta: ISA IRQ list 0098, PCI irq11
Socket status: 30000007
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Bluetooth: Core ver 2.2
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem initialized
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
ip_tables: (C) 2000-2002 Netfilter core team
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 782d, resetting...
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 782d, resetting...
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
lp0: using parport0 (polling).
lp0: console ready
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 782d, resetting...
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 782d, resetting...
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 782d, resetting...
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 782d, resetting...
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 782d, resetting...
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 782d, resetting...

$ cat /proc/interrupts
           CPU0       
  0:     177560          XT-PIC  timer
  1:        567          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:         20          XT-PIC  acpi
 10:          0          XT-PIC  uhci-hcd, uhci-hcd, eth0
 11:     100004          XT-PIC  ehci_hcd, yenta
 12:         61          XT-PIC  i8042
 14:      10389          XT-PIC  ide0
 15:          9          XT-PIC  ide1
NMI:          0 
LOC:     177461 
ERR:     118763
MIS:          0

Pau

