Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313083AbSDLAK3>; Thu, 11 Apr 2002 20:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313084AbSDLAK2>; Thu, 11 Apr 2002 20:10:28 -0400
Received: from p0061.as-l042.contactel.cz ([194.108.237.61]:1664 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S313083AbSDLAKZ>;
	Thu, 11 Apr 2002 20:10:25 -0400
Date: Fri, 12 Apr 2002 02:10:29 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: vojtech@suse.cz, martin@dalecki.de
Cc: linux-kernel@vger.kernel.org
Subject: VIA, 32bit PIO and 2.5.x kernel
Message-ID: <20020412001029.GA1172@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  last friday I found strange problem with 2.5.8-pre1 kernel
corrupting my data. Today I tracked it down to enabled (by
default) 32bit I/O. Problem occurs only in 2.5.x kernels
(2.5.8-pre1, 2.5.8-pre3) and does not occur in 2.4.x
(2.4.19-pre6, 2.4.18-pre4). My tests were done in 
non-multicount mode:

/dev/hdc:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 geometry     = 4865/255/63, sectors = 78165360, start = 0
 busstate     =  1 (on)

/dev/hdc:

 Model=WDC WD400BB-00AUA1, FwRev=18.20D18, SerialNo=WD-WMA6R1306991
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78165360
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
 AdvancedPM=no WriteCache=enabled
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 


  Problem is that if I write 4KB file SOURCE below with 
dd of=/dev/hdc1 bs=512 count=8 to disk, it dies with 
hdc: lost interrupt, and after reboot data shown in DEST below
are read from disk. 

  After looking through code up and down I found that first 
sector is written in 32bit mode, while others in 16bit mode, 
and VIA IDE interface does not cope with this correctly. Can 
anybody explain me, what's wrong with patch at the end of this 
message? As there is dozen of places where io_32bit is cleared, 
I believe that there must be some reason for doing that... And 
do not ask me why it worked in 2.4.x, as it cleared io_32bit
in task_out_intr too.
 					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


SOURCE:

000000 eb 3c 90 4d 53 57 49 4e 34 2e 31 00 02 08 01 00
[random stuff]
0001f0 f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd 55 aa
000200 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
000210 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
[repeats 0..7F four times]
0003f0 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f
000400 80 81 82 83 84 85 86 87 88 89 8a 8b 8c 8d 8e 8f
[...]
000470 f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd fe ff
000480 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
001000


DEST:

000000 eb 3c 90 4d 53 57 49 4e 34 2e 31 00 02 08 01 00
[random stuff written correctly]
0001f0 f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd 55 aa
000200 00 01 f6 f7 02 03 fa fb 04 05 55 aa 06 07 f2 f3
000210 08 09 f6 f7 0a 0b fa fb 0c 0d 55 aa 0e 0f f2 f3
000220 10 11 f6 f7 12 13 fa fb 14 15 55 aa 16 17 f2 f3
000230 18 19 f6 f7 1a 1b fa fb 1c 1d 55 aa 1e 1f f2 f3
[still same, lanes 2,3,6,7,a,b,e,f contains old data
from previous sector]
0003e0 70 71 f6 f7 72 73 fa fb 74 75 55 aa 76 77 f2 f3
0003f0 78 79 f6 f7 7a 7b fa fb 7c 7d 55 aa 7e 7f f2 f3
000400 00 01 1c 1d 55 aa 1e 1f f2 f3 20 21 f6 f7 22 23
000410 fa fb 24 25 55 aa 26 27 f2 f3 28 29 f6 f7 2a 2b
000420 fa fb 2c 2d 55 aa 2e 2f f2 f3 30 31 f6 f7 32 33
[now lanes 0,1,4,5,8,9,c,d contains old data...]
000590 fa fb 64 65 55 aa 66 67 f2 f3 68 69 f6 f7 6a 6b
0005a0 fa fb 6c 6d 55 aa 6e 6f f2 f3 70 71 f6 f7 72 73
0005b0 fa fb 74 75 55 aa 76 77 f2 f3 78 79 f6 f7 7a 7b
0005c0 fa fb 7c 7d 55 aa 7e 7f f2 f3 80 81 f6 f7 82 83
[here at 0x5CC finally begins data which should have
been at 0x400... still interleaved with garbage]
0005d0 fa fb 84 85 55 aa 86 87 f2 f3 88 89 f6 f7 8a 8b
0005e0 fa fb 8c 8d 55 aa 8e 8f f2 f3 90 91 f6 f7 92 93
0005f0 fa fb 94 95 55 aa 96 97 f2 f3 98 99 f6 f7 9a 9b
000600 55 aa b6 b7 f2 f3 b8 b9 f6 f7 ba bb fa fb bc bd
000610 55 aa be bf f2 f3 c0 c1 f6 f7 c2 c3 fa fb c4 c5
000620 55 aa c6 c7 f2 f3 c8 c9 f6 f7 ca cb fa fb cc cd
000630 55 aa ce cf f2 f3 d0 d1 f6 f7 d2 d3 fa fb d4 d5
000640 55 aa d6 d7 f2 f3 d8 d9 f6 f7 da db fa fb dc dd
000650 55 aa de df f2 f3 e0 e1 f6 f7 e2 e3 fa fb e4 e5
000660 55 aa e6 e7 f2 f3 e8 e9 f6 f7 ea eb fa fb ec ed
000670 55 aa ee ef f2 f3 f0 f1 f6 f7 f2 f3 fa fb f4 f5
000680 55 aa f6 f7 f2 f3 f8 f9 f6 f7 fa fb fa fb fc fd
000690 55 aa fe ff f2 f3 00 00 f6 f7 00 00 fa fb 00 00
0006a0 55 aa 00 00 f2 f3 00 00 f6 f7 00 00 fa fb 00 00
*
001000


/proc/ide/via:

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.34
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xd800
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                 yes
Post Write Buffer:             no                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        PIO       PIO       PIO       PIO
Address Setup:       30ns     120ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:         120ns     600ns     120ns     600ns
Transfer Rate:   16.6MB/s   3.3MB/s  16.6MB/s   3.3MB/s



diff -urN linux-2.5.8-pre3.dist/drivers/ide/ide-taskfile.c linux-2.5.8-pre3/drivers/ide/ide-taskfile.c
--- linux-2.5.8-pre3.dist/drivers/ide/ide-taskfile.c	Sun Apr  7 03:43:03 2002
+++ linux-2.5.8-pre3/drivers/ide/ide-taskfile.c	Fri Apr 12 01:50:04 2002
@@ -602,7 +602,7 @@
 		rq = HWGROUP(drive)->rq;
 		pBuf = ide_map_rq(rq, &flags);
 		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
-		drive->io_32bit = 0;
+//		drive->io_32bit = 0;
 		taskfile_output_data(drive, pBuf, SECTOR_WORDS);
 		ide_unmap_rq(rq, pBuf, &flags);
 		drive->io_32bit = io_32bit;
