Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264740AbSJUFWz>; Mon, 21 Oct 2002 01:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264741AbSJUFWx>; Mon, 21 Oct 2002 01:22:53 -0400
Received: from packet.digeo.com ([12.110.80.53]:4993 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264740AbSJUFWu>;
	Mon, 21 Oct 2002 01:22:50 -0400
Message-ID: <3DB39091.95C07598@digeo.com>
Date: Sun, 20 Oct 2002 22:28:49 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.44-mm1 with contest
References: <1035173759.3db37f7f3c495@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2002 05:28:50.0127 (UTC) FILETIME=[BC7FB5F0:01C278C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> Here are contest 0.51 benchmarks for 2.5.44-mm1 with shared pagetables enabled:
> 
> noload:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.43-mm2 [2]          73.4    93      0       0       1.03
> 2.5.44 [3]              74.6    93      0       0       1.04
> 2.5.44-mm1 [3]          75.0    93      0       0       1.05

Not really sure what's going on here.  I hope you don't have one of
those CPUs which magically slows down when it gets hot.

I tried it:

2.4.19
make -j6 bzImage  408.52s user 27.74s system 369% cpu 1:58.19 total
make -j6 bzImage  406.61s user 26.79s system 376% cpu 1:55.24 total

slightly faster on the second run, more stuff was in cache.

2.5.44-mm2ish
1st make -j6 bzImage  417.03s user 34.95s system 376% cpu 2:00.14 total
2nd make -j6 bzImage  414.78s user 33.08s system 375% cpu 1:59.17 total

bit slower.  So let's set HZ to 100:

2.5.44-mm2ish HZ=100
make -j6 bzImage  406.67s user 32.17s system 370% cpu 1:58.33 total
make -j6 bzImage  404.79s user 30.66s system 377% cpu 1:55.27 total


> process_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.43-mm2 [2]          105.8   71      44      31      1.48
> 2.5.44 [3]              90.9    76      32      26      1.27
> 2.5.44-mm1 [3]          191.5   36      168     64      2.68
> 
> These were all checked to ensure it was not one pathological run making the
> value high. The range was 190.6->192.7.

That'll be the pipe change I guess.

> ctar_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.43-mm2 [1]          92.3    82      1       5       1.29
> 2.5.44 [3]              97.7    80      1       6       1.37
> 2.5.44-mm1 [3]          99.2    78      1       6       1.39
> 
> xtar_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.43-mm2 [2]          171.0   45      2       8       2.39
> 2.5.44 [3]              117.0   65      1       7       1.64
> 2.5.44-mm1 [3]          156.2   49      2       7       2.19
> 
> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.43-mm2 [2]          301.1   26      21      11      4.22
> 2.5.44 [3]              873.8   9       69      12      12.24
> 2.5.44-mm1 [3]          347.3   22      35      15      4.86
> 
> read_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.43-mm2 [1]          105.7   73      6       4       1.48
> 2.5.44 [3]              110.8   68      6       3       1.55
> 2.5.44-mm1 [3]          110.5   69      7       3       1.55
> 
> list_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.43-mm2 [1]          98.9    72      1       23      1.39
> 2.5.44 [3]              99.1    71      1       21      1.39
> 2.5.44-mm1 [3]          96.5    74      1       22      1.35
> 
> mem_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.43-mm2 [2]          106.5   69      27      2       1.49
> 2.5.44 [3]              114.3   67      30      2       1.60
> 2.5.44-mm1 [3]          159.7   47      38      2       2.24
> 
> Notably different results in many places. This is a similar pattern to the last
> time I enabled shared pagetables. I haven't had the time to try without it
> enabled yet.
> 

It's not shared pagetables.  It's lots of other things though.  Mainly
the IO scheduler.

Almost all of your tests are testing reads competing with reads, and
reads competing with writes.  We fiddled with that pretty fundamentally.
The -mm patches have fifo_batch at 16 rather than 32, which explains 
most of the above differences.  That change will cause an overall 
reduction in throughput for these sorts of loads.
