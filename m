Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263145AbSJHA4S>; Mon, 7 Oct 2002 20:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263153AbSJHA4R>; Mon, 7 Oct 2002 20:56:17 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:4031 "EHLO
	kolivas.net") by vger.kernel.org with ESMTP id <S263145AbSJHA4P>;
	Mon, 7 Oct 2002 20:56:15 -0400
Message-ID: <1034038912.3da22e805c7c0@kolivas.net>
Date: Tue,  8 Oct 2002 11:01:52 +1000
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.40-mm2 with contest
References: <1033960902.3da0fdc6839aa@kolivas.net> <3DA139EC.8A34A593@digeo.com>
In-Reply-To: <3DA139EC.8A34A593@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew

Quoting Andrew Morton <akpm@digeo.com>:

> -mm2 has the "don't swap so much" knob.  By default it is set at 50%.
> The VM _wants_ to reclaim lots of memory from mem_load so that
> gcc has some cache to chew on.  But you the operator have said
> "I know better and I don't want you to do that".
> 
> Because it is prevented from building enough cache, gcc is issuing
> a ton of reads, which are hampering the swapstorm which is happening
> at the other end of the disk.  It's a lose-lose.
> 
> There's not much that can be done about that really (apart from
> some heavy-handed load control) - if you want to optimise for
> throughput above all else,
> 
> 	echo 100 > /proc/sys/vm/swappiness
> 
> (I suspect our swap performance right now is fairly poor, in terms
> of block allocation, readaround, etc.  Nobody has looked at that in
> some time afaik.  But tuning in there is unlikely to make a huge
> difference).


I like the idea of the swappiness switch. It seems to me that this shouldn't be
a magic number though. I've experimented with making it auto-regulating and
found that with a positive feedback arm being ten times greater than the
negative feedback arm it gives good results. Here is a patch describing that:

--- vmscan.old  2002-10-08 10:45:45.000000000 +1000
+++ vmscan.c    2002-10-08 10:48:35.000000000 +1000
@@ -44,7 +44,7 @@
 /*
  * From 0 .. 100.  Higher means more swappy.
  */
-int vm_swappiness = 50;
+int vm_swappiness = 0;

 #ifdef ARCH_HAS_PREFETCH
 #define prefetch_prev_lru_page(_page, _base, _field)                   \
@@ -535,7 +535,13 @@
         * A 100% value of vm_swappiness will override this algorithm almost
         * altogether.
         */
-       swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
+       swap_tendency = mapped_ratio / 2 + distress ;
+       if (swap_tendency > 50){
+               if (vm_swappiness <= 990) vm_swappiness+=10;
+               }
+               else
+               if (vm_swappiness > 0) vm_swappiness--;
+       swap_tendency += (vm_swappiness / 10);
        if (akpm_print) printk(" st:%ld\n", swap_tendency);

        if (akpm_print) printk("\n");

----------------------

And here are the results I have obtained with that (mm2v is mm2 with variable
vm_swappiness):

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.40-mm1 [1]          72.9    93      0       0       1.09
2.5.40-mm2 [1]          72.2    93      0       0       1.07
2.5.40-mm2v [2]         73.1    92      0       0       1.09

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.40-mm1 [2]          86.9    77      30      25      1.29
2.5.40-mm2 [1]          98.0    69      45      33      1.46
2.5.40-mm2v [2]         85.6    77      29      25      1.27

tarc_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.40-mm1 [1]          94.4    81      1       6       1.41
2.5.40-mm2 [1]          91.9    82      1       6       1.37
2.5.40-mm2v [2]         91.2    82      1       6       1.36

tarx_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.40-mm1 [1]          191.5   39      3       7       2.85
2.5.40-mm2 [1]          188.1   39      3       7       2.80
2.5.40-mm2v [2]         174.6   46      2       7       2.60

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.40-mm1 [1]          326.2   24      23      11      4.86
2.5.40-mm2 [2]          208.0   38      12      10      3.10
2.5.40-mm2v [3]         254.0   31      15      10      3.78

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.40-mm1 [1]          104.5   74      9       5       1.56
2.5.40-mm2 [1]          102.7   75      7       4       1.53
2.5.40-mm2v [2]         105.0   72      7       4       1.56

lslr_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.40-mm1 [1]          96.6    73      1       22      1.44
2.5.40-mm2 [1]          94.3    75      1       21      1.40
2.5.40-mm2v [2]         97.9    71      1       20      1.46

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.40-mm1 [2]          107.7   68      29      2       1.60
2.5.40-mm2 [2]          165.1   44      38      2       2.46
2.5.40-mm2v [3]         118.1   62      30      2       1.76

Most of the time it seems to hover around the 500 number during normal use
(equivalent to 50 of the original vm_swappiness).

What do you think?
Con
