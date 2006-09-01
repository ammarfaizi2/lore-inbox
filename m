Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWIAWec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWIAWec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWIAWec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:34:32 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:34788 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751124AbWIAWeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:34:31 -0400
Date: Fri, 1 Sep 2006 15:33:58 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       mpm@selenic.com, Manfred Spraul <manfred@colorfullife.com>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060901223358.21034.83736.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 0/5] Modular slab allocator V3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modular Slab Allocator:

Why would one use this?

1. Reduced memory requirements.

  Saving range from a few hundred kbyte on i386 to 5GB on a 1024p 4TB
  Altix NUMA system.

  The slabifier has no caches in the sense of the slab allocator. No storage
  is allocated for per cpu, shared or alien caches. A slab in itself functions
  as the cache. Objects are served directly from a per cpu slab (an "active"
  slab). The management overhead for caches is gone.

  Slabs do not contain metadata but only the payload. Metadata is kept
  in the associated page struct. This means that object can begin at the
  start of a slab and are always properly aligned.

2. No cache reaper

  The current slab allocator needs to periodically check its slab caches and
  move objects back into the slabs. Every 2 seconds on every cpu all slab caches
  are scanned and object move around the system. The system cannot really
  enter a quiescent state.

  The slabifier needs no such mechanism in the single processor case. In the
  SMP case we have a per slab flusher that is active as long as processors
  have active slabs. After a timeout it flushes the active slabs back into
  the slab lists. If no active slabs exist then the flusher is deactivated.

  The cache_reaper has been a consistent trouble spot for interrupt holdoffs
  and scheduling latencies in the SLES9 and SLES10 development cycle. I
  would be grateful if we would not have to deal again with that.

3. Can use the NUMA policies of the page allocator.

  The current slab allocator implements NUMA support through per node lists of
  slabs. If a memory policy or cpuset restrict access to certain node then the
  slab allocator itself must enforce these policies. This is only partially
  implemented and as a result cpusets, memory policies and the NUMA slab do
  not mix too well which leads to per node slabs containing slabs that are
  actually located on different nodes, which causes latencies during
  cache draining (in the cache reaper and elsewhere....).

  The Slabifier does not implement per node slabs. Instead it uses a single
  global pool of partial pages. Memory policies only come into play
  when the active slab is empty and new pages are allocated from the
  page allocator. In that case the page is allocated given the current cpuset
  and the current memory policies by the page allocator and then the slabifier
  serves objects from the slab to the application. The Slabifier does not
  attempt to guarantee that the allocations by kmalloc() are node local. It
  only does a best effort approach. Only kmalloc_node() guarantees that an
  object is allocated on a particular node. kmalloc_node() accomplishes that
  by searching the partial list for a fitting page and allocating a page
  from the requested node if none can be found.

4. Reduced amount of partial slabs.

  The current NUMA slab allocator contains per node partial lists. This
  means that fragmentation of slabs occurs on a per node basis. The more
  nodes are in the system the more potentially partially allocated slabs.

  The slabifier contains a global partial lists. Allocations on other
  nodes can cause the partial list to be shrunk. The existing slab pages
  of a slab cache have therefore a higher usage rate.

  The locking of the partial list is potential scalability problem that is
  addressed in the following ways:

  A. The partial list is only modified (and the lock taken) when necessary.
     Locking is only necessary when a page enters the partial list (it was
     full and the first object was deleted), or it becomes completely
     depleted (slab has to be freed) or it is retrieved to become an
     active slab for allocations of a particular cpu.

  B. A "min_slab_order=" kernel boot option is added. This allows to increase
    the size of the slab pages. Bigger slabs mean less lock taking and larger
    per cpu caches. It also reduces slab fragmentation but comes with the
    danger that the kernel cannot satisfy higher order allocations. However,
    order 1,2,3 allocations should usually be fine. In my tests up to 32p
    I have not yet seen a need to use this to reduce lock contention.

5. Ability to compactify partial lists.

   The slab shrinker of the slabifier can take an argument of a function
   that is capable of moving an object. With that the slabifier is able to
   reduce the amount of partial slabs.

6. Maintainability,

  The Modular Slab is made up out of components that can individually
  be replaced. Modifications are easy and it is easier to add new features.

7. Performance

  The performance of the Modular Slab is roughly comparable with the existing
  slab allocator since both rely on managing a per cpu cache of objects.
  The slab allocator does that by explicitly managing object lists and the
  slabifier does it by reserving a slab per cpu for allocations.

TODO:

- More performance tests than just with AIM7.... Higher CPU
  counts than 32.

Changes V2->V3:

- Tested on i386 (UP + SMP) , x86_64(up), IA64(NUMA up to 32p)

- Overload struct page in mm.h with slab definitions. That
  reduces the macros significantly and makes code more
  readable.

- Debug and optimize functions, Reduce cacheline footprint.

- Add support for specifying slab_min_order= at bootup in order
  to be able to influence fragmentation and lock scaling.

Changes V1-V2:
- Drop pageslab and numaslab. Drop support for VMALLOC allocations.

- Enhance slabifier with some numa capability. Bypass
  free list management for slabs with a single object.
  Drop slab full lists and minimize lock taking
  for partial lists.

- Optimize code: Generate general slab array immediately
  and pass the address of the slab cache in kmalloc(). DMA
  caches remain dynamic.

- Add support for non power of 2 general caches.

- Tested on i386, x86_64 and ia64.

The main intend of this patchset is to modularize
the slab allocator so that development of additions
or modification to the allocator layer become easier.
The framework enables the use of multiple slab allocator
and allows the generation of additional underlying
page allocators (as f.e. needed for mempools and other
specialized things).

The modularization is accomplished through the use of a few
concepts from object oriented programming. Allocators are
described by methods and functions can produce new allocators
based on existing ones by modifying their methods.

So what the patches provide here is:

1. A framework for page allocators and slab allocators

2. Various methods to derive new allocators from old ones
   (add rcu support, destructors, constructors, dma etc)

3. A layer that emulates the exist slab interface (the slabulator).

4. A layer that provides kmalloc functionality.

5. The Slabifier. This is conceptually the Simple Slab (See my RFC
   from last week) but with the additional allocator modifications
   possible it grows like on steroids and then can supply most of
   the functionality of the existing slab allocator and can go even
   beyond it. My tests with AIM7 seem indicates that it is
   equal in performance to the existing slab allocator.

Some new features:

1. The slabifier can flag double frees when the act occurs
   and will attempt to continue.

2. Ability to merge slabs of the same type.

Notably missing features:

- Slab Debugging
  (This should be implemented by deriving a new slab allocator from
  existing ones and adding the necessary processing in alloc and free).

Performance tests on an 8p and 32p machine show consistently that the
performance is equal to the standard slab allocator. Memory use is much
less with this since there is no meta data overhead per slab.

This patchset should just leave the existing slab allocator unharmed. It
adds a hook to include/linux/slab.h to redirect includes to the definitions
for the allocation framework by the slabulator.

Deactivate the "Traditional Slab allocator" in order to activate the modular
slab allocator.

More details may be found in the header of each of the following 4 patches.


-- 
VGER BF report: U 0.5
