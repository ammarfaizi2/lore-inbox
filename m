Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbUKRW2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUKRW2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262970AbUKRVLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:11:40 -0500
Received: from hentges.net ([81.169.178.128]:29116 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S261161AbUKRVF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:05:57 -0500
Subject: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some machines
From: Matthias Hentges <mailinglisten@hentges.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-v897mAW2X2ygCDLGg49g"
Date: Thu, 18 Nov 2004 22:05:50 +0100
Message-Id: <1100811950.3470.23.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v897mAW2X2ygCDLGg49g
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello all,

I'm in the process of debugging S3 on my notebook and found out that I
can resume from S3 with every kernel up to (and including) 2.6.7-rc1
( patch-2.6.6-bk8-bk9.bz2 ).

After 2.6.7-rc1, my notebook freezes upon a resume from S3. Tested with
2.6.7-rc2, -rc3, 2.6.8.1, 2.6.9 and some 2.6.10-rcX-bkX kernels.

Please note that these tests were run in single user mode with a
barebone kernel
.config (attached) just enough to boot (ie no modules, no usb etc)

I have found a hint on the web that the pci-resume code, which was
included in 2.6.7-rc2, might cause this problem. I removed the call to
pci_default_resume in drivers/pci/pci-driver.c and my laptop resumed
into a working state again ( tested
with 2.6.7 and 2.6.9 ).

I've written an email to Arjan van de Ven, the author of the resume
patch and he suggested positing here, along with a full lspci output
(attached)
He thinks that some device is misbehaving and causing trouble if
resumed.

I have the bad feeling that the device in question is the built-in video
card
"ATI Technologies Inc RV250 5c63 [Radeon Mobility 9200 M9+] (rev 01)"
since every try to re-enable it after a resume failed. The screen just
stays dark, even with acpi_sleep=s3_mode. s3_bios freezes the machine on
a resume, as does resuming with radeonfb or accelerated X (DRI or
fglrx). Not even the boot-radeon tool
helps. It either freezes the machine, or just doesn't work.

In the meantime, I'm using the attached patch which disables the new
pci-resume code.

Thanks
-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-v897mAW2X2ygCDLGg49g
Content-Disposition: attachment; filename=lspci-vvvv.txt
Content-Type: text/plain; name=lspci-vvvv.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 21)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [4104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 21) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 1800 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1820 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at 1840 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 5
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: d0200000-d02fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 1880 [size=64]
	Region 2: Memory at d0000c00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at d0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV250 5c63 [Radeon Mobility 9200 M9+] (rev 01) (prog-if 00 [VGA])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 4000 [size=256]
	Region 1: Memory at d0201800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004800-000048ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:02:01.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 20002000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 20c00000-20fff000 (prefetchable)
	Memory window 1: 21000000-213ff000
	I/O window 0: 00004c00-00004cff
	I/O window 1: 00005000-000050ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:02:01.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 04) (prog-if 10 [OHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at d0201000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME+

0000:02:02.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corp.: Unknown device 2522
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 8500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d0200000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-


--=-v897mAW2X2ygCDLGg49g
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6630
ACPI: RSDT (v001 PTLTD  CooperSp 0x06040000  LTP 0x00000000) @ 0x1ff76971
ACPI: FADT (v001 INTEL  ODEM     0x06040000 PTL  0x00000050) @ 0x1ff7bed2
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1ff7bfd8
ACPI: SSDT (v001  INTEL  EISTRef 0x00000001 INTL 0x02002015) @ 0x1ff769a1
ACPI: DSDT (v001 INTEL  ODEM     0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux-2.6.9 ro root=302 console=ttyS0,9600 console=tty0 resume2=swap:/dev/hda3
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1495.713 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513088k/523712k available (3217k kernel code, 10080k reserved, 1469k data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2965.50 BogoMIPS (lpj=1482752)
Security Scaffold v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU: After vendor identify, caps:  a7e9f9bf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        a7e9f9bf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1500MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
   tbget-0291: *** Info: Table [DSDT] replaced by host OS
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9d3, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: Power Resource [CFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6660
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa30c, dseg 0x400
PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 5 (level, low) -> IRQ 5
irda_init()
NET: Registered protocol family 23
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:00' and the driver 'system'
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: match found with the PnP device '00:09' and the driver 'system'
pnp: match found with the PnP device '00:0b' and the driver 'system'
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x1000-0x105f could not be reserved
pnp: 00:0b: ioport range 0x1060-0x107f has been reserved
pnp: 00:0b: ioport range 0x1180-0x11bf has been reserved
pnp: match found with the PnP device '00:0d' and the driver 'system'
pnp: match found with the PnP device '00:0f' and the driver 'system'
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
vesafb: probe of vesafb0 failed with error -6
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (53 C)
Asus Laptop ACPI Extras version 0.29
  Samsung P30 detected, supported
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
ppdev: user-space parallel port driver
i8042.c: Detected active multiplexing controller, rev 1.9.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:11' and the driver 'serial'
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:19' and the driver 'parport_pc'
pnp: Device 00:19 activated.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
lp0: using parport0 (interrupt-driven).
Using anticipatory io scheduler
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 5 (level, low) -> IRQ 5
eth0: RealTek RTL8139 at 0xe0822800, 00:00:f0:7e:bc:08, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8101'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC25N060ATMR04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: DV-W22E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 1419kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[d0201000-d02017ff]  Max Packet=[2048]
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 12.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
input: PC Speaker
I2O Core - (C) Copyright 1999 Red Hat Software
i2o: max_drivers=4
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000f0414010ba78]
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49595 usecs
intel8x0: clocking to 48000
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ALSA device list:
  #0: Intel 82801DB-ICH4 at 0xd0000c00, irq 5
  #1: Intel 82801DB-ICH4 Modem at 0x2400, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4091 buckets, 32728 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
NET: Registered protocol family 1
NET: Registered protocol family 17
IrCOMM protocol (Dag Brattli)
PM: Reading pmdisk image.
swsusp: Resume From Partition: /dev/hda3
<3>swsusp: Invalid partition type.
pmdisk: Error -22 resuming
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices: 
LANC USB0 USB1 USB2 USB7 MODM 
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
EXT3-fs: recovery complete.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding 979956k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xe0000000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 00001820
usb 1-1: new low speed USB device using address 2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on usb-0000:00:1d.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 5 (level, low) -> IRQ 5
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 5, pci mem e091e000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
usb 1-1: USB disconnect, address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usb 1-1: new low speed USB device using address 3
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on usb-0000:00:1d.0-1
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 5 (level, low) -> IRQ 5
Yenta: CardBus bridge found at 0000:02:01.0 [144d:c00c]
Yenta: ISA IRQ mask 0x0418, PCI irq 5
Socket status: 30000006
PCI: Enabling device 0000:02:01.1 (0000 -> 0002)
ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:01.1 [144d:c00c]
Yenta: ISA IRQ mask 0x0418, PCI irq 11
Socket status: 30000006
ieee80211_crypt: registered algorithm 'NULL'
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.61
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 5 (level, low) -> IRQ 5
ipw2100: Detected Intel PRO/Wireless 2100 Network Connection
eth1: Radio is disabled by RF switch.
ieee80211_crypt: registered algorithm 'WEP'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
nfs warning: mount version older than kernel
Access to /proc/cpufreq is deprecated and will be removed from (new) 2.6. kernels soon after 2005-01-01
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
cs: IO port probe 0x0100-0x04ff: clean.
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x807
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0xb000-0xdfff: clean.
cs: IO port probe 0x1000-0x17ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.

--=-v897mAW2X2ygCDLGg49g
Content-Disposition: attachment; filename=old_pci_resume-2.6.9.patch
Content-Type: text/x-patch; name=old_pci_resume-2.6.9.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -Nur linux-2.6.9/drivers/acpi/Kconfig linux-2.6.9-ncpires/drivers/acpi/Kconfig
--- linux-2.6.9/drivers/acpi/Kconfig	2004-10-18 23:55:29.000000000 +0200
+++ linux-2.6.9-ncpires/drivers/acpi/Kconfig	2004-11-18 17:03:50.000000000 +0100
@@ -146,6 +146,20 @@
 	depends on IA64
 	default y if IA64_GENERIC || IA64_SGI_SN2
 
+config OLD_PCI_RESUME
+	bool "Use compatibily PCI resume code"
+	depends on ACPI_INTERPRETER
+	default n
+	help
+	 Some notebooks have problems resuming from S3 (suspend-to-RAM) which
+	 leads to a complete freeze of the computer.
+	 
+	 Enabling this option disables the newer PCI resume code which might
+	 help in this case.
+	 
+	 If you encounter freezes while resuming from S3, say Y,
+	 otherwise say N.
+
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"
 	depends on X86
diff -Nur linux-2.6.9/drivers/pci/pci-driver.c linux-2.6.9-ncpires/drivers/pci/pci-driver.c
--- linux-2.6.9/drivers/pci/pci-driver.c	2004-10-18 23:54:39.000000000 +0200
+++ linux-2.6.9-ncpires/drivers/pci/pci-driver.c	2004-11-18 18:27:23.000000000 +0100
@@ -326,6 +326,8 @@
  * Default resume method for devices that have no driver provided resume,
  * or not even a driver at all.
  */
+ 
+#ifndef CONFIG_OLD_PCI_RESUME
 static void pci_default_resume(struct pci_dev *pci_dev)
 {
 	/* restore the PCI config space */
@@ -337,6 +339,7 @@
 	if (pci_dev->is_busmaster)
 		pci_set_master(pci_dev);
 }
+#endif
 
 static int pci_device_resume(struct device * dev)
 {
@@ -345,8 +348,10 @@
 
 	if (drv && drv->resume)
 		drv->resume(pci_dev);
+#ifndef CONFIG_OLD_PCI_RESUME		
 	else
 		pci_default_resume(pci_dev);
+#endif
 	return 0;
 }
 

--=-v897mAW2X2ygCDLGg49g
Content-Disposition: attachment; filename=config.gz
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64

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
e2P9fwxXP7B9PAAA


--=-v897mAW2X2ygCDLGg49g--

