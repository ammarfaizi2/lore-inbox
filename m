Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264730AbTF0TFp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 15:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbTF0TFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 15:05:45 -0400
Received: from california.sandia.gov ([146.246.250.1]:44306 "EHLO
	ca.sandia.gov") by vger.kernel.org with ESMTP id S264730AbTF0TF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 15:05:28 -0400
From: Mitch Sukalski <mwsukal@ca.sandia.gov>
Reply-To: mwsukal@ca.sandia.gov
Organization: Sandia National Laboratories
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: non-transparent Intel 82801BAM/CAM PCI-to-PCI bridge (rev. 81 chip, in IBM T40 2373-92U 4/2003 laptop)
Date: Fri, 27 Jun 2003 12:19:39 -0700
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LjJ/+QLkqb34L2o"
Message-Id: <200306271219.39519.mwsukal@ca.sandia.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_LjJ/+QLkqb34L2o
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

If you have a new IBM T40 (mine is a model 2372-92U, build 4/03, 2GB RAM), the 
latest 2.4.21 kernel (and 2.4.20 as well), and PCMCIA support is broken, then 
you may have the same problem that I've just isolated. My symptoms included 
crazy values for socket status, and many "timed out during reset" messages 
(see dmesg output below).

Jun 12 15:00:36 juggler kernel: Yenta IRQ list 0000, PCI irq11 
Jun 12 15:00:36 juggler kernel: Socket status: 080c2420 
Jun 12 15:00:36 juggler kernel: Yenta IRQ list 0000, PCI irq11 
Jun 12 15:00:36 juggler kernel: Socket status: 000dd9e2 
Jun 12 15:00:39 juggler kernel: cs: socket f74a8000 timed out during reset. 
Try increasing setup_delay. 
<last line repeated...>

The root of the problem is that PCI fixup code currently assumes that all 
Intel 82801 family PCI bridge chips operate in transparent mode, no matter 
what they self-report or how they are configured. With that assumption, the 
Cardbus controller will have its I/O regions fortuitously mapped into the 
right space (at least on my machine), but the memory regions are mapped right 
at the end of RAM (instead of memory the bridge is configured to access).

If you remove the next-to-last entry for pcibios_fixup[] in file 
arch/i386/kernel/pci-pc.c for pci_fixup_transparent_bridge() and recompile, 
then everything will be mapped correctly. I realize that this is not a 
general fix, since many 82801 chips are broken. Still, I thought the user 
community might want this information to save time in tracking down this 
problem. I've attached "/sbin/lspci -vv -x" output running under this 
modified working kernel for the experts.

Cheers,

Mitch

-- 
Mitch Sukalski <mwsukal@ca.sandia.gov> 
HPC and Networking Research (8961) 
Sandia National Laboratories 
P.O. Box 969, Mail Stop 9915, Livermore, CA. 94551-0969 
phone: (925) 294-4713 
fax: (925) 294-2776
--Boundary-00=_LjJ/+QLkqb34L2o
Content-Type: text/plain;
  charset="iso-8859-1";
  name="pci_info.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="pci_info.txt"

00:00.0 Host bridge: Intel Corp.: Unknown device 3340 (rev 03)
	Subsystem: IBM: Unknown device 0529
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: <available only to root>
00: 86 80 40 33 06 01 90 20 03 00 00 06 00 00 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 29 05
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp.: Unknown device 3341 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c0100000-c01fffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 41 33 07 01 a0 00 03 00 04 06 00 60 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 30 30 a0 22
20: 10 c0 10 c0 00 e0 f0 e7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 1800 [size=32]
00: 86 80 c2 24 05 00 80 02 01 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 18 00 00 00 00 00 00 00 00 00 00 14 10 2d 05
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 1820 [size=32]
00: 86 80 c4 24 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 18 00 00 00 00 00 00 00 00 00 00 14 10 2d 05
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at 1840 [size=32]
00: 86 80 c7 24 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 18 00 00 00 00 00 00 00 00 00 00 14 10 2d 05
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 00

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 052e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>
00: 86 80 cd 24 06 01 90 02 01 20 03 0c 00 00 00 00
10: 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 2e 05
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 04 00 00

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=08, sec-latency=168
	I/O behind bridge: 00004000-00008fff
	Memory behind bridge: c0200000-cfffffff
	Prefetchable memory behind bridge: e8000000-efffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
00: 86 80 48 24 07 01 80 80 81 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 08 a8 40 80 80 22
20: 20 c0 f0 cf 00 e8 f0 ef 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24cc (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 cc 24 0f 00 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corp.: Unknown device 24ca (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at 7ff7b000 (32-bit, non-prefetchable) [size=1K]
00: 86 80 ca 24 07 00 80 02 01 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 61 18 00 00 00 b0 f7 7f 00 00 00 00 14 10 2d 05
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 1880 [size=32]
00: 86 80 c3 24 01 00 80 02 01 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 18 00 00 00 00 00 00 00 00 00 00 14 10 2d 05
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 01)
	Subsystem: IBM: Unknown device 0537
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 18c0 [size=64]
	Region 2: Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at c0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>
00: 86 80 c5 24 07 00 90 02 01 00 01 04 00 00 00 00
10: 01 1c 00 00 c1 18 00 00 00 0c 00 c0 00 08 00 c0
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 37 05
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 02 00 00

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem (rev 01) (prog-if 00 [Generic])
	Subsystem: IBM: Unknown device 0525
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]
	Capabilities: <available only to root>
00: 86 80 c6 24 05 00 90 02 01 00 03 07 00 00 00 00
10: 01 24 00 00 01 20 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 25 05
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 02 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000] (rev 02) (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 0531
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>
00: 02 10 66 4c 87 03 b0 02 02 00 00 03 08 42 00 00
10: 08 00 00 e0 01 30 00 00 00 00 10 c0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 31 05
30: 00 00 00 00 58 00 00 00 00 00 00 00 0b 01 08 00

02:00.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller (rev 01)
	Subsystem: IBM ThinkPad T30
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c0240000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=05, sec-latency=176
	Memory window 0: e8000000-e83ff000 (prefetchable)
	Memory window 1: c0400000-c07ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 55 ac 07 00 10 02 01 00 07 06 08 a8 82 00
10: 00 00 24 c0 a0 00 00 02 02 03 05 b0 00 00 00 e8
20: 00 f0 3f e8 00 00 40 c0 00 f0 7f c0 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 0b 01 c0 05
40: 14 10 12 05 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:00.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller (rev 01)
	Subsystem: IBM ThinkPad T30
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at c0241000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=06, subordinate=08, sec-latency=176
	Memory window 0: e8400000-e87ff000 (prefetchable)
	Memory window 1: c0800000-c0bff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 55 ac 07 00 10 02 01 00 07 06 08 a8 82 00
10: 00 10 24 c0 a0 00 00 02 02 06 08 b0 00 00 40 e8
20: 00 f0 7f e8 00 00 80 c0 00 f0 bf c0 00 48 00 00
30: fc 48 00 00 00 4c 00 00 fc 4c 00 00 0b 02 c0 05
40: 14 10 12 05 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:01.0 Ethernet controller: Intel Corp.: Unknown device 101e (rev 03)
	Subsystem: IBM: Unknown device 0549
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c0220000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at 8000 [size=64]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>
00: 86 80 1e 10 07 01 30 02 03 00 00 02 08 40 00 00
10: 00 00 22 c0 00 00 20 c0 01 80 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 22 00 00 00 14 10 49 05
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 ff 00

02:02.0 Ethernet controller: Unknown device 168c:0012 (rev 01)
	Subsystem: Unknown device 17ab:8310
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 7000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c0210000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>
00: 8c 16 12 00 16 01 90 02 01 00 00 02 08 50 00 00
10: 00 00 21 c0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 01 50 00 00 ab 17 10 83
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 0a 1c


--Boundary-00=_LjJ/+QLkqb34L2o--

