Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291097AbSAaPFd>; Thu, 31 Jan 2002 10:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291098AbSAaPFY>; Thu, 31 Jan 2002 10:05:24 -0500
Received: from mustard.heime.net ([194.234.65.222]:52904 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S291097AbSAaPFO>; Thu, 31 Jan 2002 10:05:14 -0500
Date: Thu, 31 Jan 2002 16:05:12 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: Errors in the VM - detailed
Message-ID: <Pine.LNX.4.30.0201311604470.14025-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

The last month or so, I've been trying to make a particular configuration work
with Linux-2.4.17 and other 2.4.x kernels. Two major bugs have been blocking
my way into the light. Below follows a detailed description on both bugs. One
of them seems to be solved in the latests -rmap patches. The other is still
unsolved.

CONFIGURATION INTRO

The test has been performed on two equally configured computers, giving the
same results, telling the chance of hardware failure is rather small.

Config:

1xAthlon 1133
2x512MB (1GB) SRAM
Asus A7S-VM motherboard with
	Realtek 10/100Mbps card
	ATA100
	Sound+VGA+USB+other crap
1xPromise ATA133 controller
2xWDC 120GB drives (with ATA100 cabeling connected to Promise controller)
1xWDC 20GB drive (connected to motherboard - configured as the boot device)
1xIntel desktop gigE card (e1000 driver - modular)

Server is configured with console on serial port
Highmem is disabled
The two 120GB drives is configured in RAID-0 with chunk size [256|512|1024]
I have tried several different file systems - same error

Versions tested:

Linux-2.4.1([3-7]|8-pre.) tested. All buggy. Bug #1 was fixed in -rmap11c

TEST SETUP

Reading 100 500MB files with dd, tux, apache, cat, something, and redirecting
the output to /dev/null. With tux/apache, I used another computer using wget
to retrieve the same amount of data.

The test scripts look something like this

#!/bin/bash
dd if=file0000 of=/dev/null &
dd if=file0001 of=/dev/null &
dd if=file0002 of=/dev/null &
dd if=file0003 of=/dev/null &
...
dd if=file0099 of=/dev/null &

or similar - just with wget -O /dev/null ... &

BUGS

Bug #1:

When (RAMx2) bytes has been read from disk, I/O as reported from vmstat drops
to a mere 1MB/s

When reading starts, the speed is initially high. Then, slowly, the speed
decreases until it goes to something close to a complete halt (see output from
vmstat below).

# vmstat 2
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy id
 0 200  1   1676   3200   3012 786004   0 292 42034   298  791   745   4  29 67
 0 200  1   1676   3308   3136 785760   0   0 44304     0  748   758   3  15 82
 0 200  1   1676   3296   3232 785676   0   0 44236     0  756   710   2  23 75
 0 200  1   1676   3304   3356 785548   0   0 38662    70  778   791   3  19 78
 0 200  1   1676   3200   3456 785552   0   0 33536     0  693   594   3  13 84
 1 200  0   1676   3224   3528 785192   0   0 35330    24  794   712   3  16 81
 0 200  0   1676   3304   3736 784324   0   0 30524    74  725   793  12  14 74
 0 200  0   1676   3256   3796 783664   0   0 29984     0  718   826   4  10 86
 0 200  0   1676   3288   3868 783592   0   0 25540   152  763   812   3  17 80
 0 200  0   1676   3276   3908 783472   0   0 22820     0  693   731   0   7 92
 0 200  0   1676   3200   3964 783540   0   0 23312     6  759   827   4  11 85
 0 200  0   1676   3308   3984 783452   0   0 17506     0  687   697   0  11 89
 0 200  0   1676   3388   4012 783888   0   0 14512     0  671   638   1   5 93
 0 200  0   2188   3208   4048 784156   0 512 16104   548  707   833   2  10 88
 0 200  0   3468   3204   4048 784788   0  66  8220    66  628   662   0   3 96
 0 200  0   3468   3296   4060 784680   0   0  1036     6  687   714   1   6 93
 0 200  0   3468   3316   4060 784668   0   0  1018     0  613   631   1   2 97
 0 200  0   3468   3292   4060 784688   0   0  1034     0  617   638   0   3 97
 0 200  0   3468   3200   4068 784772   0   0  1066     6  694   727   2   4 94

Bug #2:

Doing the same test on Rik's -rmap(.*) somehow fixes Bug #1, and makes room
for another bug to come out.

Doing the same test, I can, with -rmap, get some 33-35MB/s sustained from
/dev/md0 to memory. This is all good, but when doing this test, only 40 of the
original processes ever finish. The same error occurs both locally (dd) and
remotely (tux). If new i/o requests is issued to the same device, they don't
hang. If tux is restarted, it works fine afterwards.

Please - anyone - help me with this. I've been trying to setup this system for
almost two months now, fighting various bugs.

Best regards

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

