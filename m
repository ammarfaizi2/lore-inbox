Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281923AbRLOF3r>; Sat, 15 Dec 2001 00:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281926AbRLOF3i>; Sat, 15 Dec 2001 00:29:38 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:28407 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281923AbRLOF3W>; Sat, 15 Dec 2001 00:29:22 -0500
Date: Sat, 15 Dec 2001 00:29:21 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] mempool-2.5.1-D2
Message-ID: <20011215002920.A29284@redhat.com>
In-Reply-To: <20011214172728.B26535@redhat.com> <Pine.LNX.4.33.0112150653310.22818-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112150653310.22818-100000@localhost.localdomain>; from mingo@elte.hu on Sat, Dec 15, 2001 at 07:41:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2001 at 07:41:12AM +0100, Ingo Molnar wrote:
> exactly what kind of SLAB based reservation system do you have in mind?
> (what interface, how would it work, etc.) Take a look at how bio.c,
> highmem.c and raid1.c uses the mempool mechanizm, the main properties of
> mempool cannot be expressed via SLAB reservation:
> 
>  - mempool allows the use of non-SLAB allocators as the underlying
>    allocator. (eg. the highmem.c mempool uses the page allocator to alloc
>    lowmem pages. raid1.c uses 4 allocators: kmalloc(), page_alloc(),
>    bio_alloc() and mempool_alloc() of a different pool.)

That's of dubious value.  Personally, I think there should be two 
allocators: slab and page allocs.  Anything beyond that seems to be 
duplicating functionality.

>  - mempool_alloc(), if called from a process context, never fails. This
>    simplifies lowlevel IO code (which often must not fail) visibly.

Arguably, the same should be possible with normal allocations.  Btw, if 
you looked at the page level reservations, it did so but still left the 
details of how that memory is reserved up to the vm.  The idea behind that 
is to reserve memory, but still allow clean and immediately reclaimable 
pages to populate the memory until it is allocate (many reservations will 
never be touched as they're worst case journal/whatnot protection).  Plus, 
with a reservation in hand, an allocation from that reservation will 
never fail.

>  - mempool handles allocation in a more deadlock-avoidance-aware way than
>    a normal allocator would do:
> 
>         - first it ->alloc()'s atomically

Great.  Function calls through pointers are really not a good idea on 
modern cpus.

>         - then it tries to take from the pool if the pool is at least
>           half full
>         - then it ->alloc()'s non-atomically
>         - then it takes from the pool if it's non-empty
>         - then it waits for pool elements to be freed

Oh dear.  Another set of vm logic that has to be kept in sync with the 
behaviour of the slab, alloc_pages and try_to_free_pages.  We're already 
failing to keep alloc_pages deadlock free; how can you be certain that 
this arbitary "half full pool" condition is not going to cause deadlocks 
for $random_arbitary_driver?

>    this makes for five different levels of allocation, ordered for
>    performance and blocking-avoidance, while still kicking the VM and
>    trying as hard as possible if there is a resource squeeze. In the
>    normal case we never touch the mempool spinlocks, we just call
>    ->alloc() and if the core allocator does per-CPU caching then we'll
>    have the exact same high level of scalability as the underlying
>    allocator.

Again, this is duplicating functionality that doesn't need to be.  The 
1 additional branch for the uncommon case that reservations adds is 
far, far cheaper and easier to understand.

>  - mempool adds reservation without increasing the complexity of the
>    underlying allocators.

This is where my basic disagreement with the approach comes from.  As 
I see it, all of the logic that mempools adds is already present in the 
current system (or at the very least should be).  To give you some insight 
to how I think reservations should work and how they can simplify code in 
the current allocators, take the case of an ordinary memory allocation of 
a single page.  Quite simply, if there are no immediately free pages, we 
need to wait for another page to be returned to the free pool (this is 
identical to the logic you added in mempool that prevents a pool from 
failing an allocation).  Right now, memory allocations can fail because 
we allow ourselves to grossly overcommit memory usage.  That you're adding 
mempool to patch over that behaviour, is *wrong*, imo.  The correct way to 
fix this is to make the underlying allocator behave properly: the system 
has enough information at the time of the initial allocation to 
deterministically say "yes, the vm will be able to allocate this page" or 
"no, i have to wait until another user frees up memory".  Yes, you can 
argue that we don't currently keep all the necessary statistics on hand 
to make this determination, but that's a small matter of programming.

The above is looks like a bit more of a rant than I'd meant to write, but 
I think the current allocator is broken and in need of fixing, and once 
fixed there should be no need for yet another layer on top of it.

		-ben
-- 
Fish.
