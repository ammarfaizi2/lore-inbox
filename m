Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVAPQNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVAPQNX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 11:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVAPQNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 11:13:23 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:19871 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262531AbVAPQNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 11:13:12 -0500
Date: Sun, 16 Jan 2005 16:13:11 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoiding fragmentation through different allocator V2
In-Reply-To: <20050115171006.GD7397@logos.cnet>
Message-ID: <Pine.LNX.4.58.0501161602500.16492@skynet>
References: <Pine.LNX.4.58.0501131552400.31154@skynet> <20050114213619.GA3336@logos.cnet>
 <Pine.LNX.4.58.0501151858360.17278@skynet> <20050115171006.GD7397@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > That is possible but it I haven't thought of a way of measuring the cache
> > colouring effects (if any). There is also the problem that the additional
> > complexity of the allocator will offset this benefit. The two main loss
> > points of the allocator are increased complexity and the increased size of
> > the zone struct.
>
> We should be able to measure that too...
>
> If you look at the performance numbers of applications which do data
> crunching, reading/writing data to disk (scientific applications). Or
> even databases, plus standard set of IO benchmarks...
>

I used two benchmarks to test this. The first was a test that ran gs
against a large postscript file 10 times and measured the average. The
hypothesis was that if I was trashing the CPU cache with the allocator,
there would be a marked difference between the results. The results are;

==> gsbench-2.6.11-rc1MBuddy.txt <==
Average: 115.47 real, 115.136 user, 0.338 sys

==> gsbench-2.6.11-rc1Standard.txt <==
Average: 115.468 real, 115.092 user, 0.337 sys

So, there is no significance there. I think we are safe for the CPU cache
as neither allocator is particularly cache aware.

The second test was a portion of the tests from aim9. The results are

MBuddy
     7 page_test          120.01       9452   78.76010       133892.18 System Allocations & Pages/second
     8 brk_test           120.03       3386   28.20961       479563.44 System Memory Allocations/second
     9 jmp_test           120.00     501496 4179.13333      4179133.33 Non-local gotos/second
    10 signal_test        120.01      11632   96.92526        96925.26 Signal Traps/second
    11 exec_test          120.07       1587   13.21729           66.09 Program Loads/second
    12 fork_test          120.03       1890   15.74606         1574.61 Task Creations/second
    13 link_test          120.00      11152   92.93333         5854.80 Link/Unlink Pairs/second
    56 fifo_test          120.00     173450 1445.41667       144541.67
FIFO Messages/second

Vanilla
     7 page_test          120.01       9536   79.46004       135082.08 System Allocations & Pages/second
     8 brk_test           120.01       3394   28.28098       480776.60 System Memory Allocations/second
     9 jmp_test           120.00     498770 4156.41667      4156416.67 Non-local gotos/second
    10 signal_test        120.00      11773   98.10833        98108.33 Signal Traps/second
    11 exec_test          120.01       1591   13.25723           66.29 Program Loads/second
    12 fork_test          120.00       1941   16.17500         1617.50 Task Creations/second
    13 link_test          120.00      11188   93.23333         5873.70 Link/Unlink Pairs/second
    56 fifo_test          120.00     179156 1492.96667       149296.67 FIFO Messages/second

Here, there are worrying differences all right. The modified allocator for
example is getting 1000 faults a second less than the standard allocator
but that is still less than 1%.  This is something I need to work on
although I think it's optimisation work rather than a fundamental problem
with the approach.

I'm looking into using bonnie++ as another IO benchmark.

> We should be able to use the CPU performance counters to get exact
> miss/hit numbers, but it seems its not yet possible to use Mikael's
> Pettersson pmc inside the kernel, I asked him sometime ago but never got
> along to trying anything:
>
> <SNIP>

This is stuff I was not aware of before and will need to follow up on.

> I think some CPU/memory intensive benchmarks should give us a hint of the total
> impact ?
>

The ghostscript test was the one I choose. Script is below

> > However, I also know the linear scanner trashed the LRU lists and probably
> > comes with all sorts of performance regressions just to make the
> > high-order allocations.
>
> Migrating pages instead of freeing them can greatly reduce the overhead I believe
> and might be a low impact way of defragmenting memory.
>

Very likely. As it is, the scanner I used is really stupid but I wanted to
show that using a mechanism like it, we should be able to almost guarentee
the allocation of a high-order block, something we cannot currently do.

> I've added your patch to STP but:
>
> [STP 300030]Kernel Patch Error  Kernel: mel-three-type-allocator-v2 PLM # 4073
>

I posted a new version under the subject "[PATCH] 1/2 Reducing
fragmentation through better allocation". It should apply cleanly to a
vanilla kernel. Sorry about the mess of the other patch.

> It failed to apply to 2.6.10-rc1 - I'll work the rejects and rerun the tests.
>

The patch is against 2.6.11-rc1, but I'm guessing you typos 2.6.10-rc1.

-- 
Mel Gorman
