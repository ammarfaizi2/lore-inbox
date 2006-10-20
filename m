Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWJTPD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWJTPD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWJTPD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:03:57 -0400
Received: from math.ut.ee ([193.40.36.2]:44796 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932260AbWJTPD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:03:56 -0400
Date: Fri, 20 Oct 2006 18:03:53 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: PCI cache line not set - how to set?
Message-ID: <Pine.SOC.4.61.0610201751150.596@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use sii3112 in Motorola Powerstack II computer with 300 Mhz PowerPC 
604r CPU (should use 32-byte cache line size). However, its firmware is 
OF based and seems to literally ignore non-OF PCI cards like the 
sii3112. Linux still sees the cards and I can use them, but...

sata_sil 0000:00:07.0: cache line size not set.  Driver may not function

and a new SATA disk that is 70+ MB/s in a PC yields only 10 MB/s here.

So a wild guess that either PCI latency (set to 0) or PCI cache line 
size need to be set.

setpci -s 00:07.0 CACHE_LINE_SIZE
00

so I do
setpci -s 00:07.0 CACHE_LINE_SIZE=08
and I can read 08 back - fine.

But reloading sata_sil still tells that cache line size not set.
sata_sil uses sil_get_device_cache_line() to read the cache line size 
and that does a simple
pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cache_line);

So should this setpci work?

Setpci PCI_LATENCY works and gives measurable bad results. Setting 
latency timer to 32 (20 hex) drops the performance even more (to 3.5-3.7 
MB/s) so I reset it to 0.

NCR 53C825 SCSI with 36G 10Krpm disk also gives 10 MB/s, cache line size 
08, latency timer 00.

Where to look next?

lspci -vvvxxx is here:

00:00.0 Host bridge: IBM 82660 CPU to PCI Bridge (rev 02)
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
00: 14 10 37 00 06 01 00 02 02 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 20 40 60 00 00 80 a0 00 00 00 00 00 00 00 00
90: 1f 3f 5f 7f 00 00 9f bf 00 00 00 00 00 00 00 00
a0: cf 15 8a 00 66 44 00 44 00 00 00 00 00 00 00 00
b0: 00 43 00 00 07 00 52 00 00 00 07 4f 00 00 00 00
c0: 2c 00 00 40 11 00 00 06 f8 0c 00 80 1f 30 00 01
d0: f8 01 f8 01 05 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 ISA bridge: Symphony Labs W83C553 (rev 10)
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
00: ad 10 65 05 07 00 00 02 10 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 20 04 00 ef fb ab 78 00 01 00 00 00 00 33 44 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 09 0a 0b 0e 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: e0 01 00 80 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 97 01 01 01 00 00 00 00 00 00 00 00 00 00

00:01.1 IDE interface: Symphony Labs SL82c105 (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin A routed to IRQ 0
 	Region 0: I/O ports at 800001f0 [disabled] [size=8]
 	Region 1: I/O ports at 800003f4 [disabled] [size=4]
 	Region 2: I/O ports at 80000170 [disabled] [size=8]
 	Region 3: I/O ports at 80000374 [disabled] [size=4]
 	Region 4: I/O ports at 80000000 [disabled] [size=16]
 	Region 5: I/O ports at 800010b0 [disabled] [size=16]
00: ad 10 05 01 00 00 80 02 05 8f 01 01 08 00 80 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 01 00 00 00 b1 10 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 02 28
40: 91 00 ff 00 09 09 00 00 09 09 00 00 09 09 00 00
50: 09 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 SCSI storage controller: LSI Logic / Symbios Logic 53c825 (rev 13)
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (4250ns min, 16000ns max), Cache Line Size: 32 bytes
 	Interrupt: pin A routed to IRQ 15
 	Region 0: I/O ports at 80001400 [size=256]
 	Region 1: Memory at c4008000 (32-bit, non-prefetchable) [size=256]
 	Region 2: Memory at c4009000 (32-bit, non-prefetchable) [size=4K]
00: 00 10 03 00 17 00 00 02 13 00 00 01 08 00 00 00
10: 01 14 00 00 00 80 00 04 00 90 00 04 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 01 11 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: da 00 00 1b 47 08 00 0f 00 08 80 00 80 00 0f 0a
90: ff 00 69 80 00 ff ff ff 00 f0 35 31 a0 93 00 04
a0: 00 08 24 00 00 00 00 50 b8 93 00 04 c0 93 00 04
b0: 00 90 00 04 d0 12 69 80 46 6d 00 81 c0 23 01 04
c0: 8f 05 00 00 b3 00 60 0f 0c 00 80 00 76 00 00 80
d0: 00 00 00 80 00 00 00 80 00 00 00 80 00 84 00 00
e0: 99 25 18 ac f9 5e ff f9 69 22 28 00 f4 76 f3 bc
f0: 80 10 4d 41 7f cf 9b f6 04 8e 06 20 fa 9b be bb

00:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (5000ns min, 10000ns max), Cache Line Size: 32 bytes
 	Interrupt: pin A routed to IRQ 11
 	Region 0: I/O ports at 80001800 [size=128]
 	Region 1: Memory at c400a000 (32-bit, non-prefetchable) [size=128]
 	Expansion ROM at c1040000 [disabled] [size=256K]
00: 11 10 09 00 17 00 80 02 22 00 00 02 08 00 00 00
10: 01 18 00 00 00 a0 00 04 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 04 01 00 00 00 00 00 00 00 00 0b 01 14 28
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (5000ns min, 10000ns max), Cache Line Size: 32 bytes
 	Interrupt: pin A routed to IRQ 10
 	Region 0: I/O ports at 80001000 [size=128]
 	Region 1: Memory at c2000000 (32-bit, non-prefetchable) [size=128]
 	Expansion ROM at c1040000 [disabled] [size=256K]
00: 11 10 09 00 17 00 80 02 22 00 00 02 08 00 00 00
10: 01 10 00 00 00 00 00 02 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 04 01 00 00 00 00 00 00 00 00 0a 01 14 28
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 Mass storage controller: Silicon Image, Inc. SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
 	Subsystem: Silicon Image, Inc. SiI 3112 SATALink Controller
 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin A routed to IRQ 11
 	Region 0: I/O ports at 80001080 [size=8]
 	Region 1: I/O ports at 80001088 [size=4]
 	Region 2: I/O ports at 80001090 [size=8]
 	Region 3: I/O ports at 80001098 [size=4]
 	Region 4: I/O ports at 800010a0 [size=16]
 	Region 5: Memory at c2000200 (32-bit, non-prefetchable) [size=512]
 	Expansion ROM at c1080000 [disabled] [size=512K]
 	Capabilities: [60] Power Management version 2
 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 95 10 12 31 03 00 b0 02 02 00 80 01 08 00 00 00
10: 81 10 00 00 89 10 00 00 91 10 00 00 99 10 00 00
20: a1 10 00 00 00 02 00 02 00 00 00 00 95 10 12 31
30: 00 00 08 01 60 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 41 00 04 28 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 08 00 00 00 00 80 9d 80
80: 22 00 00 00 03 00 00 00 00 00 c0 00 ec cc de 96
90: 00 00 00 0c 12 31 00 80 00 00 00 18 00 00 00 00
a0: 01 01 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
b0: 01 01 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 VGA compatible controller: Cirrus Logic GD 5446 (rev 45) (prog-if 00 [VGA])
 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin ? routed to IRQ 15
 	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=32M]
 	Region 1: Memory at c2001000 (32-bit, non-prefetchable) [size=4K]
 	Expansion ROM at c4000000 [disabled] [size=32K]
00: 13 10 b8 00 03 00 00 02 45 00 00 03 00 00 00 00
10: 08 00 00 00 00 10 00 02 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 04 00 00 00 00 00 00 00 00 0f 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-- 
Meelis Roos (mroos@linux.ee)
