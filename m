Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261466AbSIZToC>; Thu, 26 Sep 2002 15:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261389AbSIZToC>; Thu, 26 Sep 2002 15:44:02 -0400
Received: from packet.digeo.com ([12.110.80.53]:2026 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261466AbSIZToA>;
	Thu, 26 Sep 2002 15:44:00 -0400
Message-ID: <3D9364BA.A2CA02C5@digeo.com>
Date: Thu, 26 Sep 2002 12:49:14 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] slab reclaim balancing
References: <3D931608.3040702@colorfullife.com> <3D9345C4.74CD73B8@digeo.com> <3D935655.1030606@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 19:49:11.0603 (UTC) FILETIME=[C8F81830:01C26595]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> Andrew Morton wrote:
> >
> > (What Ed said - we do hang onto one page.  And I _have_ measured
> > cost in kmem_cache_shrink...)
> >
> I totally agree about kmem_cache_shrink - it's total abuse that
> fs/dcache.c calls it regularly. It was intended to be called before
> module unload, or during ifdown, etc.
> On NUMA, it's probably worse, because it does an IPI to all cpus.
> dcache.c should not call kmem_cache_shrink, and kmem_cache_reap should
> be improved.

Sorry, I meant kmem_cache_reap. It was the call into there from
vmscan.c which was the problem.  On my 4-way (which is fairly
immune to lock contention for some reason), I was seeing *25%*
contention on the spinlock inside the cache_chain_sem semaphore.
With, of course, tons of context switching going on.

And it was giving a sort of turnstile effect, where each CPU needed
to pass through kmem_cache_reap before entering page reclaim proper.
Which maybe wasn't so bad in the 2.4 setup.  But in 2.5 the VM is
basically per-zone, so different CPUs can run reclaim against different
zones with no contention of any form.  This is especially important on
NUMA.

But the above could have been solved in different ways, and there are
still global effects with the requirement to prune slab.  I expect that
the batching and perhaps a per-slab exclusion mechanism will fix up
any remaining problems.

> > Before:
> > Elapsed: 20.18s User: 192.914s System: 48.292s CPU: 1195.6%
> >
> > After:
> > Elapsed: 19.798s User: 191.61s System: 43.322s CPU: 1186.4%
> >
> > That's for a kernel compile.
> >
> UP or SMP?
> And was that the complete patch, or just the modification to slab.c?

That is the effect of per-cpu hotlist within the page allocator
on a 16- or 32-way NUMAQ.

It shows some of the benefit which we can get by carefully recycling
known-to-be-hot pages back into places where the page is known to
soon be touched by this CPU.  Most of the gains were in do_anonymous_page,
copy_foo_user(), zap_pte_range(), etc.  Where you'd expect.

I expect to end up with two forms of page allocation and freeing:
alloc_hot_page/alloc_cold_page and free_hot_page/free_cold_page

> I've made a microbenchmark of kmem_cache_alloc/free of 4 kb objects, on
> UP, AMD Duron:
>                 1 object        4 objects
> cur             145 cycles       662 cycles
> patched         133 cycles      2733 cycles
> 
> Summary:
> * for one object, the patch is a slight performance improvement. The
> reason is that the fallback from partial to free list in
> kmem_cache_alloc_one is avoided.
> * the overhead of kmem_cache_grow/shrink is around 500 cycles, nearly a
> slowdown of factor 4. The cache had no constructor/destructor.
> * everything cache hot state. [100 runs in a loop, loop overhead
> substracted. 98 or 99 runs completed in the given time, except for
> patched-4obj, where 24 runs completed in 2735 cycles, 72 in 2733 cycles]

Was the microbenchmark actually touching the memory which it was
allocating from slab?  If so then yes, we'd expect to see cache
misses against those cold pages coming out of the buddy.
 
> For SMP and slabs that are per-cpu cached, the change could be right,
> because the arrays should absorb bursts. But I do not think that the
> change is the right approach for UP.

I'd suggest that we wait until we have slab freeing its pages into
the hotlists, and allocating from them.  That should pull things back.
