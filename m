Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbTDUQRr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 12:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTDUQRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 12:17:47 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:63656 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261572AbTDUQRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 12:17:40 -0400
From: rankincj@yahoo.com
Message-Id: <200304211629.h3LGTd88003746@twopit.underworld>
Subject: IDE/DMA timeout with Linux-2.4.20-SMP
To: linux-kernel@vger.kernel.org
Date: Mon, 21 Apr 2003 17:29:39 +0100 (BST)
Cc: axboe@suse.de
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just tried burning a data CD using Linux 2.4.20-SMP (1 GB, devfs,
dual 933 Coppermine PIII) plus the following patch:

--- linux-2.4.20/drivers/block/ll_rw_blk.c.orig Mon Apr 14 22:03:14 2003
+++ linux-2.4.20/drivers/block/ll_rw_blk.c  Mon Apr 14 22:06:54 2003
@@ -1376,11 +1376,12 @@

 void end_that_request_last(struct request *req)
 {
- if (req->waiting != NULL)
-   complete(req->waiting);
- req_finished_io(req);
+ struct completion *waiting = req->waiting;

+ req_finished_io(req);
  blkdev_release_request(req);
+ if (waiting)
+   complete(waiting);
 }

 int __init blk_dev_init(void)

I grabbed that patch off the list last week; it looked like a good idea
for an SMP system. Anyway, a dummy write worked fine and so I tried
burning for real:

# time cdrecord dev=0,0,0 -data /tmp/backup.iso 
Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
scsidev: '0,0,0'
scsibus: 0 target: 0 lun: 0
Linux sg driver version: 3.1.24
Using libscg version 'schily-0.7'
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'SONY    '
Identifikation : 'CD-RW  CRX145E  '
Revision       : '1.0b'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : MMC-2 SWABAUDIO 
Supported modes: TAO PACKET SAO SAO/R96R RAW/R96R
Starting to write CD/DVD at speed 4 in real TAO mode for single session.
Last chance to quit, starting real write    0 seconds. Operation starts.
Track 01: Total bytes read/written: 674201600/674201600 (329200 sectors).

real    19m48.522s
user    0m0.370s
sys     0m9.270s

Unfortunately, the process hung briefly after writing the "Track 01"
message, and then wrote the following message into the log file:

Apr 21 16:39:48 twopit kernel: scsi : aborting command due to timeout : pid 64715, scsi0, channel 0, id 0, lun 0 Request Sense 00 00 00 40 00 
Apr 21 16:40:18 twopit kernel: scsi : aborting command due to timeout : pid 64715, scsi0, channel 0, id 0, lun 0 Request Sense 00 00 00 40 00 
Apr 21 16:40:18 twopit kernel: SCSI host 0 abort (pid 64715) timed out - resetting
Apr 21 16:40:18 twopit kernel: SCSI bus is being reset for host 0 channel 0.
Apr 21 16:40:19 twopit kernel: hdd: irq timeout: status=0xd0 { Busy }
Apr 21 16:40:19 twopit kernel: hdd: DMA disabled
Apr 21 16:40:22 twopit kernel: scsi : aborting command due to timeout : pid 64715, scsi0, channel 0, id 0, lun 0 Request Sense 00 00 00 40 00 
Apr 21 16:40:22 twopit kernel: SCSI host 0 abort (pid 64715) timed out - resetting
Apr 21 16:40:22 twopit kernel: SCSI bus is being reset for host 0 channel 0.
Apr 21 16:40:22 twopit kernel: hdd: ATAPI reset complete
Apr 21 16:40:22 twopit kernel: hdd: irq timeout: status=0x80 { Busy }
Apr 21 16:40:22 twopit kernel: hdd: ATAPI reset complete
Apr 21 16:40:22 twopit kernel: hdd: irq timeout: status=0x80 { Busy }
Apr 21 16:40:22 twopit kernel: hdd: status error: status=0x08 { DataRequest }
Apr 21 16:40:22 twopit kernel: hdd: drive not ready for command
Apr 21 16:40:22 twopit kernel: hdd: status timeout: status=0x80 { Busy }
Apr 21 16:40:22 twopit kernel: hdd: drive not ready for command
Apr 21 16:40:22 twopit kernel: hdd: ATAPI reset complete
Apr 21 16:40:22 twopit kernel: sr0: CDROM (ioctl) error, command: Read TOC 00 00 00 00 00 00 00 0c 00 
Apr 21 16:40:22 twopit kernel: Current sr00:00: sense key None


Now the machine recovered and the data CD *seems* to have been written OK,
but I am obviously concerned about the "hiccup" in the IDE subsystem. (I was
using the ide-scsi module to do all this.) The machine was not doing anything
besides burning my CD-RW at the time.


This is a full description of the PCI bus:

00:00.0 Host bridge: Intel Corp. 82840 840 (Carmel) Chipset Host Bridge (Hub A) (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at fa000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

00:01.0 PCI bridge: Intel Corp. 82840 840 (Carmel) Chipset AGP Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fda00000-feafffff
	Prefetchable memory behind bridge: f5000000-f90fffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 PCI bridge: Intel Corp. 82840 840 (Carmel) Chipset PCI Bridge (Hub B) (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=03, subordinate=04, sec-latency=64
	I/O behind bridge: 0000b000-0000cfff
	Memory behind bridge: fd800000-fd9fffff
	Prefetchable memory behind bridge: f4e00000-f4ffffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=64
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: fd200000-fd7fffff
	Prefetchable memory behind bridge: f4c00000-f4dfffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corp. 82801AA IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp. 82801AA USB
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at ef80 [size=32]

00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
	Subsystem: Intel Corp. 82801AA SMBus
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at efa0 [size=16]

00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
	Subsystem: Unknown device 4352:5934
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at e800 [size=256]
	Region 1: I/O ports at ef00 [size=64]

01:01.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs SBLive! Player 5.1
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at af80 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:01.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at aff0 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:06.0 PCI bridge: Hint Corp HB1-SE33 PCI-PCI Bridge (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: fd200000-fd2fffff
	Prefetchable memory behind bridge: f4c00000-f4cfffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [90] #06 [0000]

01:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fd7fe800 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at ac00 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Alert On LAN II* Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fd7ff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at af00 [size=64]
	Region 2: Memory at fd600000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fd500000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:0c.0 FireWire (IEEE 1394): NEC Corporation IEEE 1394 [OrangeLink] Host Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Orange Micro Root hub
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fd2fc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0d.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Orange Micro Root Hub
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fd2fd000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0d.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Orange Micro Root Hub
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 16
	Region 0: Memory at fd2fe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0d.2 USB Controller: NEC Corporation USB 2.0 (rev 01) (prog-if 20 [EHCI])
	Subsystem: Orange Micro Root hub
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8500ns max), cache line size 08
	Interrupt: pin C routed to IRQ 17
	Region 0: Memory at fd2fff00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:1f.0 PCI bridge: Intel Corp. 82806AA PCI64 Hub PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=03, secondary=04, subordinate=04, sec-latency=64
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fd800000-fd8fffff
	Prefetchable memory behind bridge: f4e00000-f4efffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

04:00.0 PIC: Intel Corp. 82806AA PCI64 Hub Advanced Programmable Interrupt Controller (rev 01) (prog-if 20 [IO(X)-APIC])
	Subsystem: Intel Corp. 82806AA PCI64 Hub APIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fd8ff000 (32-bit, non-prefetchable) [size=4K]

05:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 05) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f6000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at feafc000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at feae0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4


These are the boot messages for IDE:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller on PCI bus 00 dev f9
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: ST320420A, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-116 0122, ATAPI CD/DVD-ROM drive
hdd: SONY CD-RW CRX145E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c031eb24, I/O limit 4095Mb (mask 0xffffffff)
hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=2480/255/63, UDMA(66)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4


And this is what the SCSI layer was looking like:

SCSI subsystem driver Revision: 1.00
scsi: host order: ide-scsi:sbp2:sbp2:usb-storage-0:usb-storage-1:ppa
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-RW  CRX145E    Rev: 1.0b
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray


I haven't tried reenabling DMA on this drive yet. Previous experience with
reenabling DMA after it has been explicitly disabled suggests that it might
hang the machine! This is what the IDE settings for the drive used to look
like:

# cat /proc/ide/hdd/settings 
name                    value           min             max             mode
----                    -----           ---             ---             ----
bios_cyl                0               0               1023            rw
bios_head               0               0               255             rw
bios_sect               0               0               63              rw
current_speed           66              0               69              rw
ide_scsi                0               0               1               rw
init_speed              66              0               69              rw
io_32bit                3               0               3               rw
keepsettings            0               0               1               rw
log                     0               0               1               rw
nice1                   1               0               1               rw
number                  3               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
transform               1               0               3               rw
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw


Does anyone have any idea why the DMA failed, please? Is it a known issue
with 2.4.20? If anyone would like any further information then please let
me know,

Cheers,
Chris


