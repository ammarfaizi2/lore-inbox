Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWH0CdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWH0CdI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 22:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWH0CdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 22:33:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56526 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750938AbWH0CdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 22:33:07 -0400
Date: Sat, 26 Aug 2006 19:32:46 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>, mpm@selenic.com,
       Manfred Spraul <manfred@colorfullife.com>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060827023245.14731.23294.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 0/4] A modular slab allocator V2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

The modularization is accomplished by trying to use a few
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
   beyond it. My tests with AIM7 seem to indicate that it is
   equal in performance to the existing slab allocator. However,
   I am sure that there are specific situtions in which it will
   not behave optimially. Hopefully the modularization will
   lead to a fast way to mature this component.

Some of the other issues in the slab layer are also addressed here:

1. shrink_slab takes a function to move object. Using that
   function slabs can be defragmented to ease slab reclaim
   (This is something discussed at the VM summit).

2. New slabs that are created can be merged into the kmalloc array
   if it is detected that they match. This decreases the number of caches
   and benefits cache use.

3. The slabifier can flag double frees when the act occurs
   and will attempt to continue.

4. There is no 2 second slab reaper tick anymore. Each slab has a 10
   second flusher attached (not needed for UP). The flusher is inactive if
   slab is inactive. System can get to a quiescent state. Currently
   we constantly have a 2 second scan through all slabs in the
   system with expensive processing that causes delays
   that may be significant for real time processing.

Notably missing features:

- Slab Debugging
  (This should be implemented by deriving a new slab allocator from
  existing ones and adding the necessary processing in alloc and free).

Performance tests on an 8p machine show consistently that the performance
is equal to the standard slab allocator. Memory use is much less with
this since there is no meta data overhead per slab.

This patchset should just leave the existing slab allocator unharmed. It only
adds a hook to include/linux/slab.h to redirect includes to the definitions
for the allocation framework by the slabulator.

Deactivate the "Traditional Slab allocator" in order to activate the modular
slab allocator.

More details may be found in the header of each of the following 4 patches.

I am not sure how something like this could be merged. Maybe put in a
special directory?

In the current form the modular framework is definitely fitting the
requirements of the embedded folks since the allocation efficiency
is comparable if not better than SLOB. It is running to my satisfaction
on desktops and small servers. However, a lot of tuning is still
needed. Perhaps a caching framework will be needed to be equal in
speed to slab in some situations. That may perhaps be added as another
derived slab allocator.

Christoph Lameter, August 26, 2006.

