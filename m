Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266462AbSKLK5r>; Tue, 12 Nov 2002 05:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbSKLK5r>; Tue, 12 Nov 2002 05:57:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:21377 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266462AbSKLK5p>;
	Tue, 12 Nov 2002 05:57:45 -0500
Message-ID: <3DD0E037.1FC50147@digeo.com>
Date: Tue, 12 Nov 2002 03:04:23 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
References: <1037057498.3dd03dda5a8b9@kolivas.net> <20021112030453.GB15812@vitelus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Nov 2002 11:04:27.0942 (UTC) FILETIME=[44A8EC60:01C28A3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> 
> On Tue, Nov 12, 2002 at 10:31:38AM +1100, Con Kolivas wrote:
> > Here are the latest contest (http://contest.kolivas.net) benchmarks up to and
> > including 2.5.47.
> 
> This is just great to see. Most previous contest runs made me cringe
> when I saw how -mm and recent 2.5 kernels were faring, but it looks
> like Andrew has done something right in 2.5.47-mm1. I hope the
> appropriate get merged so that 2.6.0 has stunning performance across
> the board.

Tuning of 2.5 has really hardly started.  In some ways, it should be
tested against 2.3.99 (well, not really, but...)

It will never be stunningly better than 2.4 for normal workloads on
normal machines, because 2.4 just ain't that bad.

What is being addressed in 2.5 is the areas where 2.4 fell down:
large machines, large numbers of threads, large disks, large amounts
of memory, etc.  There have been really big gains in that area.

For the uniprocessors and small servers, there will be significant
gains in some corner cases.   And some losses.  Quite a lot of work
has gone into "fairness" issues: allowing tasks to make equal progress
when the machine is under load.  Not stalling tasks for unreasonable
amounts of time, etc.   Simple operations such as copying a forest
of files from one part of the disk to another have taken a bit of a
hit from this.  (But copying them to another disk got better).

Generally, 2.6 should be "nicer to use" on the desktop.  But not appreciably
faster.  Significantly slower when there are several processes causing a
lot of swapout.  That is one area where fairness really hurts throughput.
The old `make -j30 bzImage' with mem=128M takes 1.5x as long with 2.5.
Because everyone makes equal progress.

Most of the VM gains involve situations where there are large amounts
of dirty data in the machine.  This has always been a big problem
for Linux, and I think we've largely got it under control now.  There
are still a few issues in the page reclaim code wrt this, but they're
fairly obscure (I'm the only person who has noticed them ;))

There are some things which people simply have not yet noticed.


Andrea's kernel is the fastest which 2.4 has to offer; let's tickle
its weak spots:



Run mke2fs against six disks at the same time, mem=1G:

2.4.20-rc1aa1:
0.04s user 13.16s system 51% cpu 25.782 total
0.05s user 31.53s system 63% cpu 49.542 total
0.05s user 29.04s system 58% cpu 49.544 total
0.05s user 31.07s system 62% cpu 50.017 total
0.06s user 29.80s system 58% cpu 50.983 total
0.06s user 23.30s system 43% cpu 53.214 total

2.5.47-mm2:
0.04s user 2.94s system 48% cpu 6.168 total
0.04s user 2.89s system 39% cpu 7.473 total
0.05s user 3.00s system 37% cpu 8.152 total
0.06s user 4.33s system 43% cpu 9.992 total
0.06s user 4.35s system 42% cpu 10.484 total
0.04s user 4.32s system 32% cpu 13.415 total


Write six 4G files to six disks in parallel, mem=1G:

2.4.20-rc1aa1:
0.01s user 63.17s system 7% cpu 13:53.26 total
0.05s user 63.43s system 7% cpu 14:07.17 total
0.03s user 65.94s system 7% cpu 14:36.25 total
0.01s user 66.29s system 7% cpu 14:38.01 total
0.08s user 63.79s system 7% cpu 14:45.09 total
0.09s user 65.22s system 7% cpu 14:46.95 total

2.5.47-mm2:
0.03s user 53.95s system 39% cpu 2:18.27 total
0.03s user 58.11s system 30% cpu 3:08.23 total
0.02s user 57.43s system 30% cpu 3:08.47 total
0.03s user 54.73s system 23% cpu 3:52.43 total
0.03s user 54.72s system 23% cpu 3:53.22 total
0.03s user 46.14s system 14% cpu 5:29.71 total


Compile a kernel while running `while true;do;./dbench 32;done' against
the same disk.  mem=128m:

2.4.20-rc1aa1:
Throughput 17.7491 MB/sec (NB=22.1863 MB/sec  177.491 MBit/sec)
Throughput 16.6311 MB/sec (NB=20.7888 MB/sec  166.311 MBit/sec)
Throughput 17.0409 MB/sec (NB=21.3012 MB/sec  170.409 MBit/sec)
Throughput 17.4876 MB/sec (NB=21.8595 MB/sec  174.876 MBit/sec)
Throughput 15.3017 MB/sec (NB=19.1271 MB/sec  153.017 MBit/sec)
Throughput 18.0726 MB/sec (NB=22.5907 MB/sec  180.726 MBit/sec)
Throughput 18.2769 MB/sec (NB=22.8461 MB/sec  182.769 MBit/sec)
Throughput 19.152 MB/sec (NB=23.94 MB/sec  191.52 MBit/sec)
Throughput 14.2632 MB/sec (NB=17.8291 MB/sec  142.632 MBit/sec)
Throughput 20.5007 MB/sec (NB=25.6258 MB/sec  205.007 MBit/sec)
Throughput 24.9471 MB/sec (NB=31.1838 MB/sec  249.471 MBit/sec)
Throughput 20.36 MB/sec (NB=25.45 MB/sec  203.6 MBit/sec)
make -j4 bzImage  412.28s user 36.90s system 15% cpu 47:11.14 total

2.5.46:
Throughput 19.3907 MB/sec (NB=24.2383 MB/sec  193.907 MBit/sec)
Throughput 16.6765 MB/sec (NB=20.8456 MB/sec  166.765 MBit/sec)
make -j4 bzImage  412.16s user 36.92s system 83% cpu 8:55.74 total

2.5.47-mm2:
Throughput 15.0539 MB/sec (NB=18.8174 MB/sec  150.539 MBit/sec)
Throughput 21.6388 MB/sec (NB=27.0485 MB/sec  216.388 MBit/sec)
make -j4 bzImage  413.88s user 35.90s system 94% cpu 7:56.68 total  <- fifo_batch strikes again


It's the "doing multiple things at the same time" which gets better; the
straightline throughput of "one thing at a time" won't change much at all.

Corner cases....
