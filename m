Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSKXQVo>; Sun, 24 Nov 2002 11:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSKXQVo>; Sun, 24 Nov 2002 11:21:44 -0500
Received: from [195.223.140.107] ([195.223.140.107]:56479 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261446AbSKXQVm>;
	Sun, 24 Nov 2002 11:21:42 -0500
Date: Sun, 24 Nov 2002 17:28:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.4.20-rc2-aa1 with contest
Message-ID: <20021124162845.GC12212@dualathlon.random>
References: <200211230929.31413.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211230929.31413.conman@kolivas.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2002 at 09:29:22AM +1100, Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Here is a partial run of contest (http://contest.kolivas.net) benchmarks for 
> rc2aa1 with the disk latency hack
> 
> noload:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [5]              71.7    93      0       0       0.98
> 2.4.19 [5]              69.0    97      0       0       0.94
> 2.4.20-rc1 [3]          72.2    93      0       0       0.99
> 2.4.20-rc1aa1 [1]       71.9    94      0       0       0.98
> 2420rc2aa1 [1]          71.1    94      0       0       0.97
> 
> cacherun:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [2]              66.6    99      0       0       0.91
> 2.4.19 [2]              68.0    99      0       0       0.93
> 2.4.20-rc1 [3]          67.2    99      0       0       0.92
> 2.4.20-rc1aa1 [1]       67.4    99      0       0       0.92
> 2420rc2aa1 [1]          66.6    99      0       0       0.91
> 
> process_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              109.5   57      119     44      1.50
> 2.4.19 [3]              106.5   59      112     43      1.45
> 2.4.20-rc1 [3]          110.7   58      119     43      1.51
> 2.4.20-rc1aa1 [3]       110.5   58      117     43      1.51*
> 2420rc2aa1 [1]          212.5   31      412     69      2.90*
> 
> This load just copies data between 4 processes repeatedly. Seems to take 
> longer.

you go into linux/include/blkdev.h and increase MAX_QUEUE_SECTORS to (2
<< (20 - 9)) and see if it makes any differences here? if it doesn't
make differences it could be the a bit increased readhaead but I doubt
it's the latter.

> ctar_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              117.4   63      1       7       1.60
> 2.4.19 [2]              106.5   70      1       8       1.45
> 2.4.20-rc1 [3]          102.1   72      1       7       1.39
> 2.4.20-rc1aa1 [3]       107.1   69      1       7       1.46
> 2420rc2aa1 [1]          103.3   73      1       8       1.41
> 
> xtar_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              150.8   49      2       8       2.06
> 2.4.19 [1]              132.4   55      2       9       1.81
> 2.4.20-rc1 [3]          180.7   40      3       8       2.47
> 2.4.20-rc1aa1 [3]       166.6   44      2       7       2.28*
> 2420rc2aa1 [1]          217.7   34      4       9       2.97*
> 
> Takes longer. Is only one run though so may not be an accurate average.

This most probably is a too small waitqueue. Of course increasing the
waitqueue will increase a bit the latency too for the other workloads,
it's a tradeoff and there's no way around it. Even read-latency has the
tradeoff when it chooses the "nth" place to be the seventh slot, where
to put the read request if it fails inserction.

> 
> 
> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              474.1   15      36      10      6.48
> 2.4.19 [3]              492.6   14      38      10      6.73
> 2.4.20-rc1 [2]          1142.2  6       90      10      15.60
> 2.4.20-rc1aa1 [1]       1132.5  6       90      10      15.47
> 2420rc2aa1 [1]          164.3   44      10      9       2.24
> 
> This was where the effect of the disk latency hack was expected to have an 
> effect. It sure did.

yes, I certainly can feel the machine much more responsive during the
write load too. Too bad some benchmark like dbench decreased
significantly but I don't see too many ways around it. At least now with
those changes the contigous write case is unaffected, my storage  test
box still reads and writes at over 100mbyte/sec for example, this
clearly means what matters is that we have 512k dma commands, not an
huge size of the queue. Really with a loaded machine and potential
scheduling delays it could matter more to have a larger queue, that
maybe why the performance is decreased for some workload here too, not
only because of a less effective elevator. So probably 2Mbyte of queue
is a much better idea, so at least we can have a ring with 4 elements to refill
after a completion wakeup, I wanted to be strict to see the "lowlatency" effect
at most in the first place. We could also consider to use a /4 instead of my
current /2 for the batch_sectors initialization.

BTW, at first glance it looks 2.5 has the same problem in the queue
sizing too.

> read_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              102.3   70      6       3       1.40
> 2.4.19 [2]              134.1   54      14      5       1.83
> 2.4.20-rc1 [3]          173.2   43      20      5       2.37
> 2.4.20-rc1aa1 [3]       150.6   51      16      5       2.06
> 2420rc2aa1 [1]          140.5   51      13      4       1.92
> 
> list_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              90.2    76      1       17      1.23
> 2.4.19 [1]              89.8    77      1       20      1.23
> 2.4.20-rc1 [3]          88.8    77      0       12      1.21
> 2.4.20-rc1aa1 [1]       88.1    78      1       16      1.20
> 2420rc2aa1 [1]          99.7    69      1       19      1.36
> 
> mem_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              103.3   70      32      3       1.41
> 2.4.19 [3]              100.0   72      33      3       1.37
> 2.4.20-rc1 [3]          105.9   69      32      2       1.45
> 
> Mem load hung the machine. I could not get rc2aa1 through this part of the 
> benchmark no matter how many times I tried to run it. No idea what was going 
> on. Easy to reproduce. Simply run the mem_load out of contest (which runs 
> until it is killed) and the machine will hang. 

sorry but what is mem_load supposed to do other than to loop forever? It
is running for two days on my test box (512m of ram, 2G of swap, 4-way
smp) and nothing happened yet. It's an infinite loop. Sounds like you're
trapping a signal. Wouldn't it be simpler to just finish after a number
of passes? The machine is perfectly usable and responsive during the
mem_load, xmms doesn't skip a beat for istance, this is probably thanks
to the elevator-lowlatency too, I recall xmms wasn't used to be
completely smooth during heavy swapping in previous kernels (because the read()
of the sound file didn't return in rasonable time since I'm swapping in the
same hd where I store the data).

jupiter:~ # uptime
  4:20pm  up 1 day, 14:43,  3 users,  load average: 1.38, 1.28, 1.21
jupiter:~ # vmstat 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  1  0 197408   4504    112   1436  21  34    23    34   36    19   0   2  97
 0  1  0 199984   4768    116   1116 11712 5796 11720  5804  514   851   1   2  97
 0  1  0 234684   4280    108   1116 14344 12356 14344 12360  617  1034   0   3  96
 0  1  0 267880   4312    108   1116 10464 11916 10464 11916  539   790   0   3  97
 1  0  0 268704   5192    108   1116 6220 9336  6220  9336  363   474   0   1  99
 0  1  0 270764   5312    108   1116 13036 18952 13036 18952  584   958   0   1  99
 0  1  0 271368   5088    108   1116 8288 5160  8288  5160  386   576   0   1  99
 0  1  1 269184   4296    108   1116 4352 6420  4352  6416  254   314   0   0 100
 0  1  0 266528   4604    108   1116 9644 4652  9644  4656  428   658   0   1  99

there is no way I can reproduce any stability problem with mem_load here
(tested both on scsi quad xeon and ide dualathlon). Can you provide more
details of your problem and/or a SYSRQ+T during the hang? thanks.

Andrea
