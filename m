Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315924AbSEWDuO>; Wed, 22 May 2002 23:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315956AbSEWDuM>; Wed, 22 May 2002 23:50:12 -0400
Received: from gear.torque.net ([204.138.244.1]:10506 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S315924AbSEWDuK>;
	Wed, 22 May 2002 23:50:10 -0400
Message-ID: <3CEC64EE.A26D121C@torque.net>
Date: Wed, 22 May 2002 23:41:34 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Linux 2.4/2.5 SCSI considerably slower than FreeBSD
In-Reply-To: <3CE5D4FC.DB2CC47E@torque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> 
> Matthias Andree wrote:
> >
> > Marco Flohrer has posted an inquiry to de.comp.os.unix.linux.hardware
> > [German] <slrnae8q66.go4.marco.flohrer@diamond.csn.tu-chemnitz.de> that his
> > Seagate 36ES2 was slow with a DawiControl 2976UW (SYM53C875), only
> > around 25 MB/s. I have the same observation with a Fujitsu MAH3182MP
> > with an Adaptec 2940UW Pro which is not much faster. Either bus has an
> > active LVD/SE terminator.
> >
> > Single-user mode,
> > time dd if=/dev/XXX of=/dev/null bs=65536 count=10240
> > (671,1 MB) linear read.
> >
> > Table shows throughput in decimal MB/s (M = 1,000,000)
> >
> >                                2.5  2.4  FBSD        max.
> > UWSCSI Fuj MAH3182MP  7200/min 32,1 29,4 35,1 TQ     40
> > UDMA66 Max 4W060H4    5400/min 27,1 26,7 25,7        66
> > UDMA66 IBM DTLA307045 7200/min 37,2 37,5 37,2 TQ 2.5 66
> > UDMA66 WDC AC420400D  5400/min 15,5 15,5 15,5 TQ 2.5 66
> >                                --------------
> > table is in decimal MB/s.
> >
> > 2.4:  Linux 2.4.19-pre2-ac3
> > 2.5:  Linux 2.5.15
> > FBSD: FreeBSD 4.6-RC (Tagged Queueing Broken)
> >
> > The IDE drives are attached to a VIA 82C686 (KT133), the Fujitsu
> > (actually an U-160 drive) to the mentioned Adaptec.
> >
> > FBSD gets about 20% better throughput. It's far from perfect, but 90% of
> > the maximum is probably almost as good as we can get.
> >
> > Why is Linux SCSI so slow?

Matthias,
It is difficult to answer your main question but here are
some more figures on a pretty fast disk restricted by
a SCSI UW parallel bus (maximum bandwidth: 40 MB/sec).


       Disk read speeds (MB/sec) for various block sizes
       =================================================

block  ||        dd          |       sg_dd       |       sgm_dd
size   ||  lk2.4  | lk2.5    |  lk2.4  | lk2.5   |  lk2.4  | lk2.5
==================================================================
2 KB   ||   31.5     35.1    |   16.3     15.6   |   17.0     16.2
4 KB   ||   31.4     35.0    |   22.4     22.4   |   23.9     23.8
8 KB   ||   31.3     35.7    |   27.7     27.7   |   29.9     29.8
16 KB  ||   31.4     35.7    |   31.3     31.4   |   34.2     34.2
32 KB  ||   31.4     35.7    |   33.6     33.6   |   36.9     36.9
64 KB  ||   31.5     35.7    |   34.7     34.7   |   38.2     38.2
128 KB ||   31.5     35.5    |   34.9     34.9   |   39.0     39.0
256 KB ||   31.5     35.5    |   33.3     33.4   |   39.3     39.3

Reading a Fujitsu MAM 3184MP disk (SCSI u160 capable) on the
Ultra Wide channel (max bandwidth 40 MB/sec) of a Tekram DC-390U3W
dual controller. The HBA driver is sym53c8xx_2 (version sym-2.1.17a 
for lk 2.4.19-pre7 and version sym-2.1.16a for lk 2.5.17).

The block size for the dd command was the figure given to the "bs"
argument and the effective figure given to "bpt" for sg_dd and
sgm_dd (i.e. bpt=block_size/512). [Dropping the block size for
dd to 512 and 256 bytes made virtually no difference either.]
sg_dd uses the sg interface to access the disk and copies data
via kernel buffers while sgm_dd memory maps those kernel
buffers to the user space. In all cases 1 GB of data was read
from the outer tracks (lba==0).

Conclusions:
  - the block size given to dd has very little impact on its
    performance
  - the dd in lk 2.5 performs better than the one in lk 2.4
  - otherwise performance is roughly similar
  - obviously the 40 MB/sec bandwidth of the scsi UW bus is
    the limiting factor with larger block sizes


Here are some numbers for the same disk on the U160 channel of the
same DC-390U3W controller in lk 2.5.17:

          dd         sg_dd       sgm_dd
2 KB     56.2        20.5        22.8
8 KB     56.8        50.0        56.7
32 KB    56.7        57.0        57.2

The test system is a 1.2 GHz Athlon on a Asus A7M266 MoBo with
512 MB of DDR ram. The test disk had no fs mounted and was on
a bus by itself.

Doug Gilbert
22nd May 2002

