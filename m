Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbVGHVQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbVGHVQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 17:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbVGHVOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 17:14:32 -0400
Received: from st.cuni.cz ([195.113.20.8]:52443 "EHLO ss1000.ms.mff.cuni.cz")
	by vger.kernel.org with ESMTP id S262904AbVGHVMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:12:15 -0400
Date: Fri, 8 Jul 2005 23:12:03 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12.2 -- time passes faster; related to the acpi_register_gsi() call
Message-ID: <20050708211203.GC382@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, guys.

Time started to pass faster with 2.6.12.2 (actually, it was 2.6.12-ck3
which is based on it). I have isolated the cause of the problem:

--- linux-2.6.12-ck2-rudo/drivers/acpi/pci_irq.c        2005-07-08 10:16:53.000000000 +0200
+++ linux-2.6.12-ck-rudo/drivers/acpi/pci_irq.c 2005-07-03 21:06:10.000000000 +0200
@@ -435,6 +435,7 @@
                /* Interrupt Line values above 0xF are forbidden */
                if (dev->irq >= 0 && (dev->irq <= 0xF)) {
                        printk(" - using IRQ %d\n", dev->irq);
+                       acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
                        return_VALUE(0);
                }
                else {

2.6.12, which does not have this change, works obviously fine. It this a
bug in my hardware?

Dmesg did not reveal anything extraordinary, compared to previous
kernels (apart from the DMA timeout on hdd, that is). Both dmesg and
lspci -vv outputs are attached.

Thanks for any help.

Rudo.

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="lspci.txt"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
	Subsystem: ASUSTeK Computer Inc. A7V333 Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: ed000000-eeefffff
	Prefetchable memory behind bridge: eef00000-efffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: ASUSTeK Computer Inc. CMI8738 6ch-MX
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at d800
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 16
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 10
	Interrupt: pin C routed to IRQ 17
	Region 0: Memory at ec800000 (32-bit, non-prefetchable)
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0e.0 Multimedia controller: Philips Semiconductors SAA713X Audio+video broadcast decoder (rev f0)
	Subsystem: KYE Systems Corporation Genius VideoWonder ProTV/LifeView FlyTV Platinum FM
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at ec000000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=3 PME-

0000:00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at b800
	Region 1: Memory at eb800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs SBLive! Player 5.1
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at b400
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at b000
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
	Subsystem: ASUSTeK Computer Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at a800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 23) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. VT6202 USB2.0 4 port controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 21
	Region 4: I/O ports at a400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 23) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. VT6202 USB2.0 4 port controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 21
	Region 4: I/O ports at a000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV4 [RIVA TNT] (rev 04) (prog-if 00 [VGA])
	Subsystem: Diamond Multimedia Systems Viper V550
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ed000000 (32-bit, non-prefetchable) [size=eeff0000]
	Region 1: Memory at ef000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at 00010000 [disabled]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 1.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dmesg-2.6.12-ck3.txt"

Linux version 2.6.12-ck3-rudo (rudo@rudo.kolej.mff.cuni.cz) (gcc version 3.3.5-20050130 (Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #5 Sun Jul 3 21:19:58 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fffc000 (usable)
 BIOS-e820: 000000002fffc000 - 000000002ffff000 (ACPI data)
 BIOS-e820: 000000002ffff000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
767MB LOWMEM available.
On node 0 totalpages: 196604
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192508 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5c10
ACPI: RSDT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x2fffc000
ACPI: FADT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x2fffc0b2
ACPI: BOOT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x2fffc030
ACPI: MADT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x2fffc058
ACPI: DSDT (v001   ASUS A7V333   0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 30000000:cec00000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=linux-old ro root=0 preempt=1
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1535.887 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 775120k/786416k available (1476k kernel code, 10728k reserved, 460k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3022.84 BogoMIPS (lpj=1511424)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1464k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf17e0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14) *9
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
Initializing Cryptographic API
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI - using IRQ 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6Y120P0, ATA DISK drive
input: AT Translated Set 2 keyboard on isa0060/serio0
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
hdd: CD-RW CR52, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2 hda3
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
VFS: Can't find an ext2 filesystem on dev dm-0.
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
Freeing unused kernel memory: 156k freed
Adding 525160k swap on /dev/discs/disc0/part2.  Priority:-1 extents:1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
hdd: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdd: DMA disabled
hdd: ATAPI reset complete
ACPI: Power Button (FF) [PWRF]
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:00:0f.0[A] -> GSI 18 (level, low) -> IRQ 18
eth0: RealTek RTL8139 at 0xf087a000, 00:0a:cd:03:b6:03, IRQ 18
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Real Time Clock Driver v1.12
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 17 (level, low) -> IRQ 17
Linux video capture interface: v1.00
saa7130/34: v4l2 driver version 0.2.12 loaded
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 17
saa7133[0]: found at 0000:00:0e.0, rev: 240, irq: 17, latency: 32, mmio: 0xec000000
saa7133[0]: subsystem: 1489:0214, board: LifeView FlyTV Platinum FM [card=54,autodetected]
saa7133[0]: board init: gpio is 31c00
saa7133[0]: registered input device for IR
saa7133[0]: dsp access wait timeout [bit=WRR]
saa7133[0]: dsp access wait timeout [bit=WRR]
saa7133[0]: i2c eeprom 00: 89 14 14 02 10 28 ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
tuner 0-004b: chip found @ 0x96 (saa7133[0])
tuner 0-004b: tuner: type set to tda8290+75
saa7133[0]: registered device video0 [v4l2]
saa7133[0]: registered device vbi0
saa7133[0]: registered device radio0
saa7133[0]: registered device dsp2
saa7133[0]: registered device mixer2
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:09.0, from 5 to 3
uhci_hcd 0000:00:09.0: UHCI Host Controller
uhci_hcd 0000:00:09.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:09.0: irq 19, io base 0x0000d400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:09.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:00:09.1, from 11 to 0
uhci_hcd 0000:00:09.1: UHCI Host Controller
uhci_hcd 0000:00:09.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:09.1: irq 16, io base 0x0000d000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:11.2[D] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:11.2, from 0 to 5
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:11.2: irq 21, io base 0x0000a400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:11.3[D] -> GSI 21 (level, low) -> IRQ 21
PCI: Via IRQ fixup for 0000:00:11.3, from 9 to 5
uhci_hcd 0000:00:11.3: UHCI Host Controller
usb 1-1: new full speed USB device using uhci_hcd and address 2
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:11.3: irq 21, io base 0x0000a000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 3-2: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:09.2[C] -> GSI 17 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:09.2, from 10 to 1
ehci_hcd 0000:00:09.2: EHCI Host Controller
ehci_hcd 0000:00:09.2: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:09.2: irq 17, io mem 0xec800000
ehci_hcd 0000:00:09.2: USB 2.0 initialized, EHCI 0.95, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 4 ports detected
usb 1-1: USB disconnect, address 2
usb 1-1: new full speed USB device using uhci_hcd and address 3
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI SIO
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI 8U232AM Compatible
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI FT232BM Compatible
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI FT2232C Compatible
drivers/usb/serial/usb-serial.c: USB Serial support registered for USB-UIRT Infrared Tranceiver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Home-Electronics TIRA-1 IR Transceiver
ftdi_sio 1-1:1.0: FTDI FT232BM Compatible converter detected
usb 1-1: FTDI FT232BM Compatible converter now attached to ttyUSB0
usbcore: registered new driver ftdi_sio
drivers/usb/serial/ftdi_sio.c: v1.4.2:USB FTDI Serial Converters Driver
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:11.2-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
cdrom: open failed.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (6143 buckets, 49144 max) - 212 bytes per conntrack
hdd: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdd: DMA disabled
hdd: ATAPI reset complete
hdd: command error: status=0x51 { DriveReady SeekComplete Error }
hdd: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdd, sector 0
Buffer I/O error on device hdd, logical block 0
hdd: command error: status=0x51 { DriveReady SeekComplete Error }
hdd: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdd, sector 8
Buffer I/O error on device hdd, logical block 1
hdd: command error: status=0x51 { DriveReady SeekComplete Error }
hdd: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdd, sector 16
Buffer I/O error on device hdd, logical block 2
hdd: command error: status=0x51 { DriveReady SeekComplete Error }
hdd: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdd, sector 24
Buffer I/O error on device hdd, logical block 3
hdd: command error: status=0x51 { DriveReady SeekComplete Error }
hdd: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdd, sector 32
Buffer I/O error on device hdd, logical block 4
hdd: command error: status=0x51 { DriveReady SeekComplete Error }
hdd: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdd, sector 40
Buffer I/O error on device hdd, logical block 5
hdd: command error: status=0x51 { DriveReady SeekComplete Error }
hdd: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdd, sector 48
Buffer I/O error on device hdd, logical block 6
hdd: command error: status=0x51 { DriveReady SeekComplete Error }
hdd: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdd, sector 56
Buffer I/O error on device hdd, logical block 7
hdd: command error: status=0x51 { DriveReady SeekComplete Error }
hdd: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdd, sector 0
Buffer I/O error on device hdd, logical block 0
hdd: command error: status=0x51 { DriveReady SeekComplete Error }
hdd: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdd, sector 512
Buffer I/O error on device hdd, logical block 64
hdd: command error: status=0x51 { DriveReady SeekComplete Error }
hdd: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdd, sector 512
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1

--2B/JsCI69OhZNC5r--
