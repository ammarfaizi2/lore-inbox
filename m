Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSKJCiP>; Sat, 9 Nov 2002 21:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSKJCiP>; Sat, 9 Nov 2002 21:38:15 -0500
Received: from [195.223.140.107] ([195.223.140.107]:21893 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S263039AbSKJCiN>;
	Sat, 9 Nov 2002 21:38:13 -0500
Date: Sun, 10 Nov 2002 03:44:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021110024451.GE2544@x30.random>
References: <200211091300.32127.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211091300.32127.conman@kolivas.net>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2002 at 01:00:19PM +1100, Con Kolivas wrote:
> xtar_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              150.8   49      2       8       2.11
> 2.4.19 [1]              132.4   55      2       9       1.85
> 2.4.19-ck9 [2]          138.6   58      2       11      1.94
> 2.4.20-rc1 [3]          180.7   40      3       8       2.53
> 2.4.20-rc1aa1 [3]       166.6   44      2       7       2.33

these numbers doesn't make sense. Can you describe what xtar_load is
doing?

> First noticeable difference. With repeated extracting of tars while compiling 
> kernels 2.4.20-rc1 seems to be slower and aa1 curbs it just a little.
> 
> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              474.1   15      36      10      6.64
> 2.4.19 [3]              492.6   14      38      10      6.90
> 2.4.19-ck9 [2]          140.6   49      5       5       1.97
> 2.4.20-rc1 [2]          1142.2  6       90      10      16.00
> 2.4.20-rc1aa1 [1]       1132.5  6       90      10      15.86

What are you benchmarking, tar or the kernel compile? I think the
latter. That's the elevator and the size of the I/O queue here. Nothing
else. hacks like read-latency aren't very nice in particular with
async-io aware apps. If this improvement in ck9 was achieved decreasing
the queue size it'll be interesting to see how much the sequential I/O
is slowed down, it's very possible we've too big queues for some device.

> Well this is interesting. 2.4.20-rc1 seems to have improved it's ability to do 
> IO work. Unfortunately it is now busy starving the scheduler in the mean 
> time, much like the 2.5 kernels did before the deadline scheduler was put in.
> 
> read_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              102.3   70      6       3       1.43
> 2.4.19 [2]              134.1   54      14      5       1.88
> 2.4.19-ck9 [2]          77.4    85      11      9       1.08
> 2.4.20-rc1 [3]          173.2   43      20      5       2.43
> 2.4.20-rc1aa1 [3]       150.6   51      16      5       2.11

What is busy starving the scheduler? This sounds like it's again just an
evelator benchmark. I don't buy your scheduler claims, give more
explanations or it'll take it as vapourware wording, I very much doubt
you can find any single problem in the scheduler rc1aa2 or that the
scheduler in rc1aa1 has a chance to run slower than the one of 2.4.19 in
a I/O benchmark, ok it still misses the numa algorithm, but that's not a
bug, just a missing feature and it'll soon be fixed too and it doesn't
matter for normal smp non-numa machines out there.

> Also a noticeable difference, repeatedly reading a large file while trying to 
> compile a kernel has slowed down in 2.4.20-rc1 and aa1 blunts this effect 
> somewhat.
> 
> list_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              90.2    76      1       17      1.26
> 2.4.19 [1]              89.8    77      1       20      1.26
> 2.4.19-ck9 [2]          85.2    79      1       22      1.19
> 2.4.20-rc1 [3]          88.8    77      0       12      1.24
> 2.4.20-rc1aa1 [1]       88.1    78      1       16      1.23
> 
> mem_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              103.3   70      32      3       1.45
> 2.4.19 [3]              100.0   72      33      3       1.40
> 2.4.19-ck9 [2]          78.3    88      31      8       1.10
> 2.4.20-rc1 [3]          105.9   69      32      2       1.48
> 2.4.20-rc1aa1 [1]       106.3   69      33      3       1.49

again ck9 is faster because of elevator hacks ala read-latency.

in short your whole benchmark seems all about interacitivy of reads
during write flood. That's the read-latency thing or whatever else you
could do to ll_rw_block.c. 

In short if somebody runs fast in something like this:

	cp /dev/zero . & time cp bigfile /dev/null

he will win your whole contest too.

please show the difff between
2.4.19-ck9/drivers/block/{ll_rw_blk,elevator}.c and
2.4.19/drivers/block/...

All the difference is there and it will hurt you badly if you do
async-io benchmarks, and possibly dbench too. So you should always
accompain your benchmark with async-io simultanous read/write bandwitdth
and dbench, or I could always win your contest by shipping a very bad
kernel. Either that or change the name of your project, if somebody wins
this context that's probably a bad I/O scheduler in many other aspects,
some of the reason I didn't merge read-latency from Andrew.

Andrea
