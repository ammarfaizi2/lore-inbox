Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265638AbTGLNdc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 09:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbTGLNdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 09:33:32 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:28609 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S265638AbTGLNdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 09:33:24 -0400
Date: Sat, 12 Jul 2003 15:48:04 +0200 (MEST)
Message-Id: <200307121348.h6CDm4S4021382@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: andre@linux-ide.org
Subject: any way to speed-limit an IDE interface at boot?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,

Is there a way to ensure that a given IDE interface doesn't
exceed a given speed (mode) during boot? I couldn't find such
a kernel parameter, but I'd like to add one (like ideN=udma3)
if it was a simple matter of setting some hwif flags.

I put a PDC20269 with a UDMA100 drive in an old PowerMac 4400.
This gives _much_ better performance than the mac's built-in
IDE controller, but generates DMA CRC errors from time to time,
once at boot and occasionally during heavy disk access:

hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
 hde:hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
PDC202XX: Primary channel reset.
ide2: reset: success

It's not the controller/drive combo since it works flawlessly when
put in any old PC. I suspect the PowerMac's PCI bus or DMA controller
simply craps out when pushed hard. (hdparm -Tt gives about 17.5MB/s,
which is about half of what I'd get from this combo in a semi-modern PC.)

Setting the drive to udma3 stops these problems, without affecting
performance. The only way I've found to avoid all errors is to boot
with DMA disabled and then upgrade the drive to udma3 from the init
scripts (using hdparm parameters in /etc/sysconfig/harddiskhde).
This works but leaves a window where the drive is in non-DMA mode,
and e.g. fsck during boot will be terribly slow. That's why I want
to tell the kernel to set it to udma3 directly.

I'm including lspci -vv -xxx output below, just in case.

/Mikael

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin ? routed to IRQ 21
00: 6b 10 01 00 16 00 80 22 03 00 00 06 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 40 08 00 00 00 00 00 00 0c 00 00 0f 00 00 00 00
50: 57 00 00 00 00 00 00 00 0f 00 00 00 00 00 00 00
60: 04 00 00 0f 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 4d68
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at 04c0 [size=8]
	Region 1: I/O ports at 04b0 [size=4]
	Region 2: I/O ports at 04a0 [size=8]
	Region 3: I/O ports at 0490 [size=4]
	Region 4: I/O ports at 0480 [size=16]
	Region 5: Memory at 80808000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at 80804000 [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 69 4d 07 00 30 04 02 85 80 01 08 20 00 00
10: c1 04 00 00 b1 04 00 00 a1 04 00 00 91 04 00 00
20: 81 04 00 00 00 80 80 80 00 00 00 00 5a 10 68 4d
30: 01 40 80 80 60 00 00 00 00 00 00 00 17 01 04 12
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 21 02 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Interrupt: pin A routed to IRQ 25
	Region 0: I/O ports at 0400 [size=128]
	Region 1: Memory at 80800000 (32-bit, non-prefetchable) [disabled] [size=128]
	Expansion ROM at 80840000 [disabled] [size=256K]
00: 11 10 14 00 05 00 80 02 21 00 00 02 00 60 00 00
10: 01 04 00 00 00 00 80 80 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 84 80 00 00 00 00 00 00 00 00 19 01 00 00
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

00:10.0 Class ff00: Apple Computer Inc. O'Hare I/O (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32, cache line size 08
	Interrupt: pin ? routed to IRQ 21
	Region 0: Memory at f3000000 (32-bit, non-prefetchable) [size=512K]
00: 6b 10 07 00 16 00 00 82 01 00 00 ff 08 20 00 00
10: 00 00 00 f3 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

00:11.0 VGA compatible controller: ATI Technologies Inc 264VT [Mach64 VT] (rev 40) (prog-if 00 [VGA])
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at 81000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 1000 [disabled] [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 02 10 54 56 82 00 80 02 40 00 00 03 00 00 00 00
10: 00 00 00 81 01 10 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 16 01 00 00
40: 0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

