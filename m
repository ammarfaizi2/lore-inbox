Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265340AbUAAJNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 04:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265342AbUAAJNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 04:13:20 -0500
Received: from shadow02.cubit.at ([80.78.231.91]:52146 "EHLO
	skeletor.netshadow.at") by vger.kernel.org with ESMTP
	id S265340AbUAAJM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 04:12:58 -0500
Subject: Re: 2.6.1-rc1
From: Andreas Unterkircher <unki@netshadow.at>
Reply-To: unki@netshadow.at
To: linux-kernel@vger.kernel.org
In-Reply-To: <200312311434.17036.ornati@lycos.it>
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org>
	 <200312311434.17036.ornati@lycos.it>
Content-Type: text/plain
Message-Id: <1072948374.842.7.camel@kuecken>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jan 2004 10:12:55 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

One short Question. When setting readahead with hdparm to a value
> 128 i got:

/dev/hde:
 setting fs readahead to 8192
 BLKRASET failed: Invalid argument
 readahead    = 128 (on)

/dev/hde:
 Timing buffered disk reads:  154 MB in  3.03 seconds =  50.83 MB/sec
/dev/hde:
 Timing buffered disk reads:  144 MB in  3.00 seconds =  48.00 MB/sec
/dev/hde:
 Timing buffered disk reads:  148 MB in  3.00 seconds =  49.33 MB/sec

does this meen the disks cannot more then 128, or the ide-chipset? or is
it for the filesystem? (disks are on a promise fasttrack controller#)

andi


Am Mit, den 31.12.2003 schrieb Paolo Ornati um 15:50:
> On Wednesday 31 December 2003 09:36, Linus Torvalds wrote:
> > Ok, I've merged a lot of pending patches into 2.6.1-rc1, and will now
> > calm down for a while again, to make sure that the final 2.6.1 is ok.
> >
> > Most of the updates is for stuff that has been in -mm for a long while
> > and is stable, along with driver updates (SCSI, network, i2c and USB).
> >
> > 		Linus
> >
> > ----
> 
> With 2.6.1-rc1 I have noticed a strange IDE performance change.
> 
> Results of "hdparm -t /dev/hda" with 2.6.0 kernel:
> (readahead = 256):		~26.31 MB/s
> (readahead = 128):		~31.82 MB/s
> 
> PS = readahead is set to 256 by default on my system, 128 seems to be the 
> best value
> 
> Results of "hdparm -t /dev/hda" with 2.6.1-rc1 kernel:
> (readahead = 256):		~26.41 MB/s
> (readahead = 128):		~26.27 MB/s
> 
> Setting readahead to 128 doesn't have the same effect with the new kernel...
> 
> INFO on my HD:
> 
> /dev/hda:
>  multcount    = 16 (on)
>  IO_support   =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 128 (on)
>  geometry     = 38792/16/63, sectors = 39102336, start = 0
> 
> /dev/hda:
> 
>  Model=WDC WD200BB-53AUA1, FwRev=18.20D18, SerialNo=WD-WMA6Y1501425
>  Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
>  RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
>  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39102336
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5
>  AdvancedPM=no WriteCache=enabled
>  Drive conforms to: device does not report version:  1 2 3 4 5
> 
> 
> IDE controller:
> 
> 00:04.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
> Master IDE (rev 10) (prog-if 8a
> [Master SecP PriP])
>         Flags: bus master, medium devsel, latency 32
>         I/O ports at b800 [size=16]
>         Capabilities: [c0] Power Management version 2
> 
> 
> I don't understand how this happens... the only changes to IDE driver seems 
> to be these:
> 
> >
> > Summary of changes from v2.6.0 to v2.6.1-rc1
> > ============================================
> > Andrew Morton:
> >   o Can't disable IDE DMA
> >   o IDE MMIO fix
> >   o IDE capability elevation fix
> >
> > Linus Torvalds:
> >   o Make IDE DRQ and READY timeouts longer
> 
> For my tests I have used this stupid shell script:
> 
> #!/bin/bash
> 
> echo "HD test for linux `uname -r`"
> echo
> 
> ra=8
> for i in `seq 12`; do
>     echo "READAHEAD = $ra";
>     hdparm -a $ra /dev/hda;
>     for j in `seq 3`; do
> 	hdparm -t /dev/hda;
>     done;
>     ra=$(($ra*2));
> done
> 
> Results for 2.6.0 && 2.6.1-rc1 are attached.
> 
> Bye

