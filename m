Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263115AbTC1TQH>; Fri, 28 Mar 2003 14:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263116AbTC1TQH>; Fri, 28 Mar 2003 14:16:07 -0500
Received: from nms.rz.uni-kiel.de ([134.245.1.2]:50862 "EHLO uni-kiel.de")
	by vger.kernel.org with ESMTP id <S263115AbTC1TQE>;
	Fri, 28 Mar 2003 14:16:04 -0500
Date: Fri, 28 Mar 2003 20:27:17 +0100
From: Torsten Landschoff <torsten@debian.org>
To: linux-kernel@vger.kernel.org
Subject: IDE DMA problems
Message-ID: <20030328192717.GA16621@pclab.ifg.uni-kiel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi *, 

After I lost all my data due to two disk crashes I am now building a 
raid5 on my file server. I got 3 120GB IDE drives - but I can't get
one of them to work in udma2 mode:

stargate:~# hdparm -i /dev/hda

/dev/hda:

 Model=SAMSUNG SV8004H, FwRev=QR100-09, SerialNo=0357J1FW108136
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=38997, SectSize=619, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1945kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156368016
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5
 AdvancedPM=no WriteCache=enabled
 Drive Supports : fastATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6

Using hdparm -X 66 to set it to udma2 just kills off dma with these
error messages:

  hda: timeout waiting for DMA
  ide_dmaproc: chipset supported ide_dma_timeout func only: 14
  hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hda: drive not ready for command
  blk: queue c0370084, I/O limit 4095Mb (mask 0xffffffff)
  hda: lost interrupt

The kernel I am using is 2.4.20 + xfs patches + ptrace patch:
  stargate:~# uname -a
  Linux stargate 2.4.20 #1 SMP Thu Mar 27 03:08:54 CET 2003 i686 unknown

Because of this I can't get decent performance out of my RAID5. The 
controller is on-board of a Soyo 6KD:

stargate:~# lspci -s 00:07.01 -vvvvv
00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at ffa0 [size=16]

What's worse is that accessing the CD-ROM on /dev/hdc locks the system hard.
No keyboard, network, nothing. The last lines on the screen are always those:

  hdc: timeout waiting for DMA
  ide_dmaproc: chipset supported ide_dma_timeout func only: 14

The relevant drive is this:

stargate:~# hdparm -i /dev/hdc

/dev/hdc:

 Model=LITE-ON LTR-48246S, FwRev=SS0B, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 *mdma2 udma0 udma1 udma2
 AdvancedPM=no
 Drive Supports : Reserved : ATA-5

Using PIO works. The same cable can drive a hard drive using udma5 on 
the off board ATA/133 controller.


Two things bother me: 

a) How on earth can I get udma2 to work on the first controller? It worked
   before the crash... Whatever I do, /proc/ide/piix always tells me this:

                                Intel PIIX4 Ultra 33 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              no              no                no
UDMA enabled:   no               no              yes               no
UDMA enabled:   X                X               2                 X

b) What's going on with /dev/hdc? More interestingly this worked with 
   knoppix 2.0 which is running some 2.4.5 kernel iirc.

Any help would be welcome. 

Thanks

	Torsten
