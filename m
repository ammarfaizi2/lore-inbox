Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311739AbSCTQOO>; Wed, 20 Mar 2002 11:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSCTQOH>; Wed, 20 Mar 2002 11:14:07 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:14210 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S311739AbSCTQNy>; Wed, 20 Mar 2002 11:13:54 -0500
Date: Wed, 20 Mar 2002 08:14:31 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
Message-ID: <257350410.1016612071@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yep. What's the profile buffer size? Just make sure to boot with
> profile=2 so you'll have a quite accurate precision.

Yup, I have profile=2.
 
> the frequency is higher during a kernel compile due the pte-highmem, but
> if you just change the workload and you start 16 tasks simultaenous
> reading from a file in cache, you will get the same very frequency no
> matter of pte-highmem or not. What you found is a scalability issue with
> the persistent kmaps, not introduced by pte-highmem (however with
> pte-highmem I have increased its visibility due the additional
> usages of the persistent kmaps for certain pte intensive workload and
> with a larger pool to scan).

I understand that, but if the mechanism doesn't work well, let's not
use it any more that we have to ;-) And I have a crazy plan to fix all
this that I'll send out shortly in another email with a more appropriate
title, but that's a bigger change.
 
> Persistent kmaps aren't meant to scale, 

Indeed. If my thinking is correct, they scale as O(1/N^2) - the pool
size is ultimately fixed as we have a limited virtual address space;
more cpus means we use up the pool N times faster and the cost of
the global tlb_flush_all goes up by a factor of N as well.

> Correct. If shrinking the pool doesn't make significant difference (for

OK, here are the results of shrinking the kmap pool: compile times (with
lockmeter, so they may look different from before) go up from 40s (with
1024 pool) to 43s (with 128 pool) - presumably this is the extra cost
of the extra global tlbflushes. 

The numbers from the profile I gave you yesterday were without lockmeter.
Looking at the profiles from both runs with lockmeter, we can see that
the high cost of kmap_high and kunmap_high themselves does indeed seem
to be due to the anomoly I noted earlier - we must be counting some of
the spin time, and the anomoly goes away with lockmeter installed. Profiles indicate no measurable kunmap_high, and kmap_high goes from about 238 
(with 1024 pool) to 334 (with 128 pool) - the time actually *increases*.

lockstat (1024 pool):

33.4% 63.5%  5.4us(7893us)  155us(  16ms)(37.8%)   2551814 36.5% 63.5%    0%  kmap_lock_cacheline
17.4% 64.9%  5.7us(7893us)  158us(  16ms)(19.7%)   1275907 35.1% 64.9%    0%    kmap_high+0x34

lockstat (128 pool) 

35.5% 67.9%  6.0us(1166us)  171us(  18ms)(43.3%)   2602716 32.1% 67.
9%    0%  kmap_lock_cacheline
19.1% 69.6%  6.4us(1166us)  175us(  17ms)(22.7%)   1301358 30.4% 69.
6%    0%    kmap_high+0x34

So (as expected from the previous sentence) lock times actually go up
by shrinking the pool.

I don't believe that kmap_high is really O(N) on the size of the pool.
Looking at the code for map_new_virtual, note that we start at where
we left off before: last_pkmap_nr = (last_pkmap_nr + 1) & LAST_PKMAP_MASK;
So we don't scan the whole array every time - we just walk through it
one step (on most instances, assuming most of pool is short term use). 
On a smaller pool, more of the pool is clogged with long term usage,
so we have more things to "step over" to find an available mapping,
so it's actually more expensive.

Thus I'd conclude your original idea to increase the size of the kmap
pool was perfectly correct.

> example it may be acceptable if it would reduce the level of overhead
> to the same one of lru_cache_add in the anonymous memory page fault that
> you also don't want on a NUMA-Q just for kernel compiles without the
> need of swapout anything) I can very easily drop the persistent kmap
> usage from my tree so you can try that way too (without adding the
> kernel pagetables in kernel stuff in 2.5 and without dropping the
> quicklist cpu affine cache like what happened in 2.5).

If you could give me a patch to do that, I'd be happy to try it out.
 
> BTW, before I drop the persistent kmaps from the pagetable handling you
> can also make a quick check by removing __GFP_HIGHMEM from the
> allocation in mm/memory.c:pte_alloc_one() and verifying the kmap_high
> overhead goes away during the kernel compiles (that basically disables
> the pte-highmem feature).

I added this change on top of the pool shrinkage (i.e. we're still at 128)
resulting in:

3.4%  4.1%  1.4us(1377us)   31us(1462us)(0.19%)    692386 95.9%  4.1%
    0%  kmap_lock_cacheline
2.9%  4.4%  2.4us(1377us)   39us(1333us)(0.13%)    346193 95.6%  4.4%
    0%    kmap_high+0x34

Much better ;-) And compile times are much better ... hard to say
exactly how much, due to some other complications that I won't
delve into ....

M.

