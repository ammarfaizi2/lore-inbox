Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293122AbSCRWM4>; Mon, 18 Mar 2002 17:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293109AbSCRWMr>; Mon, 18 Mar 2002 17:12:47 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:63138 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S293092AbSCRWMe>; Mon, 18 Mar 2002 17:12:34 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 7.52 second kernel compile
Date: Mon, 18 Mar 2002 23:12:24 +0100
X-Mailer: KMail [version 1.3.9]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200203182312.24958.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, 20:23:48 Linus Torvalds wrote:
> On Mon, 18 Mar 2002, Linus Torvalds wrote:
> >
> > Well, I actually hink that an x86 comes fairly close.
>
> Btw, here's a program that does a simple histogram of TLB miss cost, and
> shows the interesting pattern on intel I was talking about: every 8th miss
> is most costly, apparently because Intel pre-fetches 8 TLB entries at a
> time.
>
> So on a PII core, you'll see something like
>
>          87.50: 36
>          12.39: 40
>
> ie 87.5% (exactly 7/8) of the TLB misses take 36 cycles, while 12.4% (ie
> 1/8) takes 40 cycles (and I assuem that the extra 4 cycles is due to
> actually loading the thing from the data cache).
>
> Yeah, my program might be buggy, so take the numbers with a pinch of salt.
> But it's interesting to see how on an athlon the numbers are
>
>           3.17: 59
>          34.94: 62
>           4.71: 85
>          54.83: 88
>
> ie roughly 60% take 85-90 cycles, and 40% take ~60 cycles. I don't know
> where that pattern would come from..

Linus,

it seems to be that it depends on gcc and flags.

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 2
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 998.068
cache size      : 512 KB

/home/nuetzel> gcc -v
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/2.95.3/specs
gcc version 2.95.3 20010315 (SuSE)

SuSE default (-march=i486 -mcpu=i486)
/home/nuetzel> gcc -o TLB_miss TLB_miss.c
/home/nuetzel> time ./TLB_miss
  12.72: 19
  85.15: 21
0.460u 0.050s 0:00.50 102.0%    0+0k 0+0io 101pf+0w

/home/nuetzel> gcc -mcpu=i486 -o TLB_miss TLB_miss.c
/home/nuetzel> time ./TLB_miss
  12.75: 19
  84.92: 21
0.510u 0.010s 0:00.51 101.9%    0+0k 0+0io 101pf+0w

/home/nuetzel> gcc -mcpu=i686 -o TLB_miss TLB_miss.c
/home/nuetzel> time ./TLB_miss
  12.96: 19
  84.57: 21
0.460u 0.050s 0:00.50 102.0%    0+0k 0+0io 101pf+0w

/home/nuetzel> gcc -mcpu=k6 -o TLB_miss TLB_miss.c
/home/nuetzel> time ./TLB_miss
  13.16: 19
  84.88: 21
0.490u 0.010s 0:00.50 100.0%    0+0k 0+0io 101pf+0w

/home/nuetzel> gcc -O2 -mcpu=i686 -o TLB_miss TLB_miss.c
/home/nuetzel> time ./TLB_miss
   2.03: 67
   1.33: 80
   3.50: 82
  19.65: 91
   1.37: 92
  18.17: 93
   1.59: 94
  41.68: 97
   2.83: 98
   1.82: 106
   1.60: 107
0.450u 0.000s 0:00.46 97.8%     0+0k 0+0io 101pf+0w

/home/nuetzel> gcc -O2 -mcpu=i486 -o TLB_miss TLB_miss.c
/home/nuetzel> time ./TLB_miss
   1.98: 67
   1.28: 80
   3.37: 82
  19.78: 91
   1.37: 92
  18.30: 93
   1.59: 94
  41.71: 97
   2.84: 98
   1.82: 106
   1.60: 107
0.440u 0.010s 0:00.46 97.8%     0+0k 0+0io 101pf+0w

/home/nuetzel> gcc -O -mcpu=i486 -o TLB_miss TLB_miss.c
/home/nuetzel> time ./TLB_miss
  31.73: 19
  46.76: 22
   9.90: 29
   8.23: 30
0.430u 0.030s 0:00.45 102.2%    0+0k 0+0io 101pf+0w

/home/nuetzel> gcc -O1 -mcpu=i486 -o TLB_miss TLB_miss.c
/home/nuetzel> time ./TLB_miss
  35.17: 19
  47.28: 22
   7.92: 29
   6.70: 30
0.420u 0.040s 0:00.45 102.2%    0+0k 0+0io 101pf+0w

/home/nuetzel> gcc -Os -mcpu=i486 -o TLB_miss TLB_miss.c
/home/nuetzel> time ./TLB_miss
   2.66: 67
   1.79: 80
   4.51: 82
  18.58: 91
   1.31: 92
  17.11: 93
   1.68: 94
  40.38: 97
   2.87: 98
   1.80: 106
   1.68: 107
0.470u 0.010s 0:00.49 97.9%     0+0k 0+0io 101pf+0w

/home/nuetzel> gcc -march=i486 -mcpu=i486 -o TLB_miss TLB_miss.c
/home/nuetzel> time ./TLB_miss
  17.12: 19
  80.45: 21
0.480u 0.030s 0:00.50 102.0%    0+0k 0+0io 101pf+0w

/home/nuetzel> gcc -march=i686 -mcpu=i686 -o TLB_miss TLB_miss.c
/home/nuetzel> time ./TLB_miss
  17.23: 19
  80.57: 21
0.480u 0.010s 0:00.50 98.0%     0+0k 0+0io 101pf+0w

/home/nuetzel> gcc -march=k6 -mcpu=k6 -o TLB_miss TLB_miss.c
/home/nuetzel> time ./TLB_miss
  14.15: 19
  83.81: 21
0.480u 0.030s 0:00.50 102.0%    0+0k 0+0io 101pf+0w

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

