Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262083AbTCZUUL>; Wed, 26 Mar 2003 15:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262085AbTCZUUK>; Wed, 26 Mar 2003 15:20:10 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:11461 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S262083AbTCZUUF>; Wed, 26 Mar 2003 15:20:05 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Delaying writes to disk when there's no need
Date: Wed, 26 Mar 2003 20:31:16 +0000 (UTC)
Message-ID: <slrnb843gi.2tt.usenet@bender.home.hensema.net>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In all kernels I've tested writes to disk are delayed a long time even when
there's no need to do so.

A very simple test shows this: on an otherwise idle system, create a tar of
a NFS-mounted filesystem to a local disk. The kernel starts writing out the
data after 30 seconds, while a slow and steady stream would be much nicer
to the system, I think.

On 2.4.x this can block the system for several seconds. 2.5.6x and
2.5.6x-mm (with AS) also show this behaviour, but the system doesn't block
anymore. I'm using a preemtable kernel.

I only started to notice this behaviour when I upgraded from 256 MB ram to
512 MB. In other words: Linux behaves more nicely with 256 MB.

Attached is a vmstat trace, it starts at the moment the tar process starts
too. It's a simple tar cf /local/test.tar /home (/home being mounted over
NFS).

Further data:
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS745    ATA 100 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 6L080J4, ATA DISK drive

It's an 80 GB ATA 133 drive.

AMD Athlon XP 1800+, 512 MB ram.

Attached vmstat was created on:
Linux bender 2.5.66-mm1 #10 Wed Mar 26 15:16:17 CET 2003 i686 unknown

tar output was going to a logical volume formatted with reiserfs.

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 5  0  0      0 123720  45068 200044    0    0     9    10 1038   766 73  1 26
 0  1  0      0 144640  45488 178568    0    0   420     0 1587  2139  9 15 76
 0  1  0      0 137976  45496 184624    0    0     4     0 4543  3415 17 28 54
 0  1  0      0 134848  45496 188112    0    0     0     0 2877  2311 21 29 50
 0  1  0      0 124992  45500 197848    0    0     0     0 5313  2795 32 59  9
 4  1  0      0 110528  45604 212088    0    0     0   496 7460  3510 24 72  4
 3  1  0      0 105408  45608 217068    0    0     0     0 3594  2436 20 27 53
 6  0  0      0 104192  45608 218160    0    0     0     0 2037  2068 15 18 68
 3  0  0      0  99328  45608 222736    0    0     0     0 4064  3484 16 26 57
 4  1  0      0  95040  45612 226888    0    0     0     0 3379  2500 24 30 45
 5  1  0      0  90752  45656 230936    0    0     0   116 3497  2821 19 21 60
 1  1  0      0  85056  45660 236568    0    0     0     0 3744  2369 25 45 30
 1  1  0      0  83200  45660 238308    0    0     0     0 2786  3216 40 18 42
 3  1  0      0  81400  45660 239876    0    0     0     0 3020  3587 22 21 57
 1  1  0      0  71608  45664 249512    0    0     0     0 5742  3378 23 48 29
 0  1  1      0  63872  45716 257040    0    0     0   124 5063  3405 25 36 39
 2  1  1      0  56064  45720 264752    0    0     0     0 4652  2694 26 52 22
 2  1  0      0  47936  45724 272660    0    0     0     0 5443  3850 27 41 32
 1  1  0      0  46912  45724 273664    0    0     0     0 2300  4372 66 21 13
 3  1  0      0  41728  45728 278732    0    0     0     0 3755  3370 50 37 13
 2  1  0      0  36928  45780 283368    0    0     0   124 4549  4094 33 33 35
 1  1  1      0  31680  45780 288508    0    0     0     0 4116  2931 23 31 46
 0  1  0      0  28672  45780 291436    0    0     0     0 2694  2183 33 33 33
 3  1  0      0  24448  45784 295556    0    0     0     0 3152  2322 19 30 51
 0  1  0      0  24256  45784 295724    0    0     0     0 1354  1414  6  4 90
 4  0  1      0  20800  45824 298184    0    0     0 21120 3267  3374 22 20 57
 4  0  1      0  18304  45828 300440    0    0     0 36328 3583  4013 47 53  0
 3  0  0      0  16640  45828 302468    0    0     0     0 3594  4084 16 15 69
 4  1  1      0  14456  45828 304332    0    0     0     0 3531  3946 23 20 57


-- 
Erik Hensema <erik@hensema.net>
