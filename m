Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131588AbRCSWV2>; Mon, 19 Mar 2001 17:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131603AbRCSWVT>; Mon, 19 Mar 2001 17:21:19 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:49163 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131588AbRCSWVJ>; Mon, 19 Mar 2001 17:21:09 -0500
X-Apparently-From: <quintaq@yahoo.co.uk>
Date: Mon, 19 Mar 2001 22:22:35 +0000
From: quintaq@yahoo.co.uk
To: <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <3AB66962.2345BFB7@bigfoot.com>
In-Reply-To: <20010318165246Z131240-406+1417@vger.kernel.org> <3AB65C51.3DF150E5@bigfoot.com> <3AB65F14.26628BEF@coplanar.net>
	<3AB66962.2345BFB7@bigfoot.com>
Reply-To: quintaq@yahoo.co.uk
X-Mailer: Sylpheed version 0.4.62 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010319222113Z131588-406+1752@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2001 12:17:38 -0800
Tim Moore <timothymoore@bigfoot.com> wrote:

> Jeremy Jackson wrote:
> > 
> > Tim Moore wrote:
> > > 15MB/s for hdparm is about right.
> > 
> > Yes, since hdparm -t measures *SUSTAINED* transfers... the actual
> "head rate" of data reads from
> > disk surface.  Only if you read *only* data that is alread in
> harddrive's cache will you get a speed
> > close to the UDMA mode of the drive/controller.  The cache is around
> 1Mbyte, so for a split-second
> > re-read of some data....
> 
> Apologies for the too brief answer.  Sustained real world transfer rates
> for the PIIX4 under ideal
> setup conditions and a quiet bus are 14-18MB/s.  Faster disk
> architecture and forcing ide driver
> parameters will not change this.
> 
> Here's what you might expect from this disk family with an ATA-66
> capable chipset:
> 
> [tim@abit tim]# hdparm -i /dev/hda; hdparm -tT /dev/hda
> 
<snip>

> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.81 seconds =158.02 MB/sec
>  Timing buffered disk reads:  64 MB in  1.85 seconds = 34.59 MB/sec
> 
> Larger sustained transfers are about 75% of the burst/cache influenced
> hdparm timings.
> 
> [tim@abit tim]# time dd if=/dev/hda of=/dev/null bs=1k count=500k
> 512000+0 records in
> 512000+0 records out
> 0.340u 6.780s 0:19.68 36.1%     0+0k 0+0io 115pf+0w
> [tim@abit tim]# echo "512000/19.68" | bc -q
> 26016
> 

Hi,

First, many thanks to you both for responding (and Jerry for his further post mentioned below).  Can I throw in the some actual figures just obtained on my system, and ask if these are consistent with what you are saying ?

cat /proc/ide/piix :

                                Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              no              yes               no 
UDMA enabled:   yes              no              yes               no 
UDMA enabled:   5                X               2                 X
UDMA
DMA
PI

hdparm -tT /dev/hda :

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.04 seconds =123.08 MB/sec
 Timing buffered disk reads:  64 MB in  4.24 seconds = 15.09 MB/sec


time dd if=/dev/hda of=/dev/null bs=1k count=500k :
512000+0 records in
512000+0 records out

real    0m26.636s
user    0m0.220s
sys     0m8.190s


(d) bonnie -s 1000

              ---Sequential Output (nosync)--- ---Sequential Input-- --Rnd Seek-
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --04k (03)-
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /sec %CPU
       1*1000 10532 91.3 17757 11.3  6481  5.2  9604 71.1 20937 12.1  131.7  1.9


I had just written the above when the following post from Jeremy arrived :

"You should be able to get about 30 MB/s at the start of the disk (zone 0) 
so if you were testing say /dev/hda1 which is at the start of the disk it should be faster.

Try hdparm -i /dev/hda (or whatever) .. . note the reported MaxMultSect= value,
and put it in place of X in command:

hdparm -u 1 -d 1 -m X -c 1 /dev/hda

Cheers,

Jeremy

PS - please let me know if this fixed your problem, since I have a system
with the same motherboard."

There is a Win partition - so I do not think I am at the start of the drive.

hdparm -i /dev/hda gives :

/dev/hda:

 Model=IBM-DTLA-307030, FwRev=TX4OA50C, SerialNo=YKDYKLN6151
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=3(DualPortCache), BuffSize=1916kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60036480
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2 
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 mode2 mode3 mode4 *mode5 
 Drive Supports : Reserved : ATA-2 ATA-3 ATA-4 ATA-5 

I therefore tried hdparm -u 1 -d 1 -m 16 -c 1 -X69 /dev/hda :

/dev/hda:
 setting 32-bit I/O support flag to 1
 setting multcount to 16
 setting unmaskirq to 1 (on)
 setting using_dma to 1 (on)
 setting xfermode to 69 (UltraDMA mode5)
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)

Then  hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.04 seconds =123.08 MB/sec
 Timing buffered disk reads:  64 MB in  4.08 seconds = 15.69 MB/sec

These are, I fear, the figures I usually see.

Bed-time for Brits.

Regards,

Geoff

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

