Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129915AbRCAUsg>; Thu, 1 Mar 2001 15:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129948AbRCAUs2>; Thu, 1 Mar 2001 15:48:28 -0500
Received: from 203-79-82-83.adsl-wns.paradise.net.nz ([203.79.82.83]:10956
	"HELO volcano.plumtree.co.nz") by vger.kernel.org with SMTP
	id <S129915AbRCAUsI>; Thu, 1 Mar 2001 15:48:08 -0500
Date: Fri, 2 Mar 2001 09:48:03 +1300
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: Harold Oga <ogah@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange hdparm behaviour with Via 686b and 2.4.2
Message-ID: <20010302094803.A5170@cone.kiwa.co.nz>
In-Reply-To: <20010301205930.B9243@cone.kiwa.co.nz> <20010301050007.A1370@ogah.cgma1.ab.wave.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010301050007.A1370@ogah.cgma1.ab.wave.home.com>; from ogah@home.com on Thu, Mar 01, 2001 at 05:00:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 05:00:07AM -0700, Harold Oga wrote:

> Hi Nicholas,
>    I don't see a similar slowdown on my system.  I have an Athlon 900 with
> a MSI K7T Pro-2a motherboard and a 15Gig Maxtor 31536H2 5400 ATA100 HD.
> This motherboard is a KT133 board, but it does also have a 686B chip.
> Running the same steps you did, I get the following:
> 
> [ogah@ogah /Junk]> ./dnetc -hide -nice 19
> [ogah@ogah /Junk]> sudo nice -n '-19' hdparm -m16 -tT /dev/hda
> 
> /dev/hda:
>  setting multcount to 16
>  multcount    = 16 (on)
>  Timing buffer-cache reads:   128 MB in  0.70 seconds =182.86 MB/sec
>  Timing buffered disk reads:  64 MB in  2.41 seconds = 26.56 MB/sec
> [ogah@ogah /Junk]> ./dnetc -shutdown
> dnetc: 1 distributed.net client was shutdown. 0 failures.
> [ogah@ogah /Junk]> sudo nice -n '-19' hdparm -m16 -tT /dev/hda
> 
> /dev/hda:
>  setting multcount to 16
>  multcount    = 16 (on)
>  Timing buffer-cache reads:   128 MB in  0.67 seconds =191.04 MB/sec
>  Timing buffered disk reads:  64 MB in  2.42 seconds = 26.45 MB/sec
> 

> One thing that comes to mind is that we are probably not using the same
> version of the via82cxxx ide driver.  I assume that you are using the
> via82cxxx v3.20 driver that came with 2.4.2.  You can check which version
> of the via driver you are using by looking at /proc/ide/via.  I am using
> v4.3 of the via82cxxx driver which Vojtech Pavlik (the via82cxxx
> maintainer) sent to the linux-kernel mailing list a while back.  I have

Yep I was.  Couldn't find that particular message on the mailing list
although I did find an earlier set.  (See below.)

Is there a central web location for these files?


> attached the 2 files you need.  Just copy the 2 files to
> /usr/src/linux/drivers/ide/, replacing the versions that already exist in
> that directory.  That might fix your problems, as Vojtech fixed quite a
> few bugs with regards to the 686b support between versions v3.20 and v4.3.
> I know that for me, I was never able to get my ATA66 drive (hdb) to run at 
> full speed until driver v4.3.  Until then, hda would get set correctly to 
> udma5, but hdb would get set to udma2 (ATA33) instead of udma4 (ATA66).

First up, thanks for the help.

I installed the two files you gave me, plus I added another file I
found in archives:

nic@thunder:~$ grep Id *.h *.c   
ide-timing.h: * $Id: ide-timing.h,v 2.1 2001/02/08 19:32:56 vojtech Exp $
amd7409.c: * $Id: amd7409.c,v 2.0 2001/02/08 21:08:60 vojtech Exp $
via82cxxx.c: * $Id: via82cxxx.c,v 4.3 2001/02/21 08:10:60 vojtech Exp $


amd7409.c was with:
ide-timing.h: * $Id: ide-timing.h,v 2.0 2001/02/08 19:32:56 vojtech Exp $
via82cxxx.c: * $Id: via82cxxx.c,v 4.0 2001/02/08 19:32:60 vojtech Exp $

not sure if that would affect things.


Anyway seems to have greater improved performance, but not without load on the system.


Nic@thunder:~$ sudo nice -n '-19' hdparm -m16 -tT /dev/hda

/dev/hda:
 setting multcount to 16
 multcount    = 16 (on)
 Timing buffer-cache reads:   128 MB in  0.78 seconds =164.10 MB/sec
 Timing buffered disk reads:  64 MB in  4.33 seconds = 14.78 MB/sec
nic@thunder:~$ dnetc/dnetc -hide -nice 19
nic@thunder:~$ sudo nice -n '-19' hdparm -m16 -tT /dev/hda

/dev/hda:
 setting multcount to 16
 multcount    = 16 (on)
 Timing buffer-cache reads:   128 MB in  0.80 seconds =160.00 MB/sec
 Timing buffered disk reads:  64 MB in  1.69 seconds = 37.87 MB/sec



nic@thunder:~$ cat /proc/ide/via 
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     4.3
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xe000
PCI clock:                          34MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       PIO       PIO
Address Setup:       29ns     116ns     116ns     116ns
Cmd Active:          87ns      87ns     464ns     464ns
Cmd Recovery:        58ns      58ns     464ns     464ns
Data Active:         87ns     319ns     319ns     319ns
Data Recovery:       58ns     261ns     261ns     261ns
Cycle Time:          20ns     580ns     580ns     580ns
Transfer Rate:  100.0MB/s   3.4MB/s   3.4MB/s   3.4MB/s



Here are some bonnie++ stats comparisions.

With dnetc running:

Version 1.00h       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP /sec %CP
thunder          1G  7012  85 49441  24  7558   5  6210  57 38020  11 170.8   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP /sec %CP
                 16   827  85 +++++ +++ 15949  85   830  85 +++++ +++ 3703  85
thunder,1G,7012,85,49441,24,7558,5,6210,57,38020,11,170.8,0,16,827,85,+++++,+++,15949,85,830,85,+++++,+++,3703,85


Without dnetc running:
Version 1.00h       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP /sec %CP
thunder          1G  7990  99 44434  23  6905   6  5429  65 17395   5 163.4   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP /sec %CP
                 16   824  99 +++++ +++ 16754 100   827  99 +++++ +++ 4346 100
thunder,1G,7990,99,44434,23,6905,6,5429,65,17395,5,163.4,0,16,824,99,+++++,+++,16754,100,827,99,+++++,+++,4346,100


The Block Sequential Input test seems to be the only telling difference.


If I get a change I'll borrow my Abit KT7 (686a) over the weekend and attempt
to just swap HDDs and test again.

Nicholas
