Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282046AbRLOJCR>; Sat, 15 Dec 2001 04:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282062AbRLOJCJ>; Sat, 15 Dec 2001 04:02:09 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:25504 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S282046AbRLOJBz>; Sat, 15 Dec 2001 04:01:55 -0500
Date: Sat, 15 Dec 2001 04:01:54 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: <mingo@devserv.devel.redhat.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mempool design
Message-ID: <Pine.LNX.4.33.0112150400440.14409-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Dec 2001, Benjamin LaHaise wrote:

> >  - mempool handles allocation in a more deadlock-avoidance-aware way than
> >    a normal allocator would do:
> >
> >         - first it ->alloc()'s atomically
>
> Great.  Function calls through pointers are really not a good idea on
> modern cpus.

Modern cpus with a good BTB have no problems with this. Even a 400 MHz
Celeron has no problem with it:

 <~/loop_perf> ./loop_perf
 0.0405 billion ->fn_ptr() loops per sec.
 0.0412 billion fn() loops per sec.
 0.0274 billion ->fn_ptr(); ->fn_ptr2() loops per sec.
 0.0308 billion fn(); fn2() loops per sec.

and we use function pointers all around the place in the kernel.

> >         - then it tries to take from the pool if the pool is at least
> >           half full
> >         - then it ->alloc()'s non-atomically
> >         - then it takes from the pool if it's non-empty
> >         - then it waits for pool elements to be freed
>
> Oh dear.  Another set of vm logic that has to be kept in sync with the
> behaviour of the slab, alloc_pages and try_to_free_pages. [...]

actually, no. Mempool should be the *only* set of VM logic that should be
deadlock-aware (in the long run, right now the deadlock avoidance code in
the core allocators is still doing more good than harm.). Mempool
guarantees deadlock-free allocation regardless of the behavior of the
underlying allocator.

> We're already failing to keep alloc_pages deadlock free; [...]

because the code tried to be too generic, for too many cases, while via
mempool we solve specific, well-defined problems. Also, as i hope you'll
agree after reading my reply, alloc_pages() and kmem_cache_alloc() has a
fundamental problems why it *cannot* keep things deadlock-free.

> [...] how can you be certain that this arbitary "half full pool"
> condition is not going to cause deadlocks for $random_arbitary_driver?

the half full pool condition is more of a performance optimization than
deadlock avoidance, it gives out buffers without blocking. It has proven
to cause significant speedups in highmem bouncing for example. But it
indeed also has a deadlock avoidance role: if the underlying allocator is
trying to be too smart and deadlocks in that attempt, then we have
guaranteed that half of the pool elements are allocated already => some
progress will happen.

those places which allocate pool elements without guaranteeing their
release within a reasonable timeout should update their logic to first
allocate all necessery elements via a single pool allocation, *then* if
the allocation succeeds then they should start the IO - which IO
completion will free the allocated element(s).

Deadlock avoidance has two sides which are equally important: the pool
code has to guarantee allocation, *and* the pool user has to guarantee
freeing latency. If one part is missing then there is no guarantee against
deadlocks.

obviously a SLAB-based (or even a page-based) reservation system cannot
guarantee this, and will never guarantee this. Since it cannot pool
multiple buffers at once, in cases where there might be allocation
interdependencies (such as raid1.c), it cannot resolve some of the more
complex deadlock scenarios. SLAB cannot guarantee that when there is a
sudden 'rush' in allocations from lots of process contexts, that all the
reserved elements wont be used to just partially fulfill every such
complex allocation request - it will happily deadlock while every process
context is keeping the reserved elements forever.

Eg., if some code does this:

	bio1 = alloc_bio();
	[... do something ...]
	bio2 = alloc_bio();

if the number of reserved bio's is eg. 128 (random limit), and 128
processes rush/stampede in the same code path, then it might happen that
they allocate bio1 128 times, and all will deadlock on the second
allocation. (This scenario is more common in RL tests that it looks like
at first sight.)

The only option to do this via global reserves would be to keep a reserve
of at least max_nr_threads elements for every pool, or serializing the
allocation path via a global mutex. Both solutions are clearly excess and
hurt the common case ...

such scenarios can only be solved by using/creating independent pools,
and/or by using 'composite' pools like raid1.c does. One common reserve
*does not* guarantee deadlock-free progress. This is why i asked for
specifics (interface, actual semantics, etc.) about the SLAB-based and
page-based reservation system you envision, because, IMO, if it's done
correctly, it will end up looking very similar to mempool.c, besides being
ugly and duplicating code. Reserves *must be* kept separate.

It's not enough to just say 'we are going to need 100 more elements in the
common reserve', that can be drained way too easily.

> Again, this is duplicating functionality that doesn't need to be.
> The 1 additional branch for the uncommon case that reservations adds
> is far, far cheaper and easier to understand.

see above - please explain, what interface, what semantics. It's hard to
compare something that is here and is real against something that is only
known by: 'it does everything, and costs less'.

> >  - mempool adds reservation without increasing the complexity of the
> >    underlying allocators.
>
> This is where my basic disagreement with the approach comes from.  As
> I see it, all of the logic that mempools adds is already present in
> the current system (or at the very least should be). [...]

here is where i disagree. The logic *shouldnt be*, and *cannot be* there,
without major modifications to the __alloc_pages(), __free_pages(),
kmem_cache_alloc() and kmem_cache_free() interfaces.

> [...] To give you some insight to how I think reservations should work
> and how they can simplify code in the current allocators, take the
> case of an ordinary memory allocation of a single page.  Quite simply,
> if there are no immediately free pages, we need to wait for another
> page to be returned to the free pool (this is identical to the logic
> you added in mempool that prevents a pool from failing an allocation).
> Right now, memory allocations can fail because we allow ourselves to
> grossly overcommit memory usage.  That you're adding mempool to patch
> over that behaviour, is *wrong*, imo.  The correct way to fix this is
> to make the underlying allocator behave properly: the system has
> enough information at the time of the initial allocation to
> deterministically say "yes, the vm will be able to allocate this page"
> or "no, i have to wait until another user frees up memory".  Yes, you
> can argue that we don't currently keep all the necessary statistics on
> hand to make this determination, but that's a small matter of
> programming.

IMO this is a way too naive picture of what kind of allocations there
might happen which must be deadlock-free. Take for example the above
multi-bio (or any other complex) allocation where this picture fails. I
think this simplicistic approach to deadlock scenarios is what is causing
page_alloc()'s current failure to address deadlocks. Yes, some of the
deadlocks are as simple as you suggest, and those can be solved via a
simple and common reserved pool. In fact GFP_ATOMIC is an attempt to do
just that, and it has worked to a fair degree for years.

But in the generic case (and in fact in some of the simplest IO cases) it
*cannot* be solved via a single common reserved pool. Sources and drains
of allocations must be kept separate (in places where it's needed) to
resolve deadlocks in mildly complex IO code and drivers.

Just to cite an artificially extreme situation: imagine swapping to a swap
file created on a loopback mounted filesystem which loopback file resides
on a filesystem that is mounted over a sw-RAID-5 device that is a
combination of NBD, block-loopback, SCSI, IDE and hardware-RAID devices,
where the NDB devices use IP tunneling.

this setup, no matter how ridiculous, is possible here and today, and i'd
wager that Cerberus will lock up on it within 5 minutes. Not at any stage
does the sysadmin get warned that 'so far and no farther, deadlock
danger'.

and in fact we used to deadlock in a much simpler and more common scenario
as well:  swapping over RAID1. The solution was: the RAID code avoided the
generic allocators and implemented a per-personality reserved pool of
complex structures. This code was duplicated in three files, with minor
modifications. Now it's all done nicely via mempools, it removed hundreds
of lines of code, and it's even faster that way.

If coded correctly all across the IO and FS layer (block and network IO),
then the above extreme scenario should either say '-ENOMEM' at mount time:
"no more memory to allocate/resize the affected pool(s)", or should work
as expected, no matter how ridiculous the config is. And it should not
deadlock just because 100 processes hit swap space in the same moment. It
might be slow, but it should not deadlock.

eg. mkraid already returns -ENOMEM if it cannot create the necessery pool.

this is the same logic we follow in other, normal allocations: if there is
not enough RAM, then we -ENOMEM. The difference for devices is that they
must be kept 'minimally operational' at all times, so the time to -ENOMEM
is at device creation time.

(admittedly, the mempool code should maximize its footprint as some given
percentage of total RAM [5%?], so that mistaken configuration cannot take
up nearly all of the RAM for reserved pools. I've added this to my tree.]

> The above is looks like a bit more of a rant than I'd meant to write,
> but I think the current allocator is broken and in need of fixing, and
> once fixed there should be no need for yet another layer on top of it.

and i think deadlock avoidance should be taken out of the current
allocators (which will also simplify and speed them up), and deadlock
sources should be identified and resolved explicitly instead. Otherwise
we'll always have the current misery of 'dont do anything too complex
because it might deadlock'. Unfortunately, the road to a deadlock-free
kernel is not as easy as one might think at first sight, but it can be
done via some planning, without any significant amount of added
complexity.

	Ingo

