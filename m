Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWFSSry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWFSSry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWFSSrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:47:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41668 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964835AbWFSSrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:47:14 -0400
Date: Mon, 19 Jun 2006 11:46:51 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 0/4] Object reclaim via the slab allocator V1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have a set of problem with slab reclaim:

1. On a NUMA system there are excessive cross node accesses.
   Locks are taken remotely which leads to a significant slowdown
   if concurrent reclaim is performeed on the dcache/icache from
   a number of nodes.

2. We need to free an excessive number of elements from the LRU
   in order to reclaim enough pages from the slab.

3. After reclaim we have a large number of sparsely used slab
   objects.

The fundamental problem in the current reclaim approaches with the
icache/dcache is that the reclaim is LRU and object based. Multiple
objects can share the same slab. So removing one object from a slab
just removes some cache information that may have been useful later
but may not give us what we want: More free pages.

I propose that we replace the LRU based object management by using
the slab oriented lists in the slab allocator itself for reclaim.

The slab allocator already has references to all pages used by the
dcache and icache. It has awareness of which objects are located
in a certain slab and therefore would be able to free specific
objects that would make pages freeable if the slab knew
their state.

In order to allow the slab allocator to know about an objects
state we add another flag SLAB_RECLAIM. SLAB_RECLAIM means that
the following is true of a slab:

1. The object contains a reference counter of atomic_t as the
   first element that follows the following conventions:

   Counter = 0	-> Object is being freed or is free.
   Counter = 1  -> Object is not used and contains cache information.
   		   The object may be freed.

   Counter > 1	-> Object is in use and cannot be freed.

2. A destructor was provided during kmem_cache_create().
   If SLAB_DTOR_FREE is passed in the flags of the destructor
   then a best effort attempt will be made to free that object.


Memory can then be reclaimed from a slab by calling

kmem_cache_reclaim(kmem_cache_t *cachep, unsigned long page)

kmem_cache_reclaim returns an error code or the number of pages reclaimed.


The reclaim works by walking through the lists of full and partially
allocated slabs. We begin at the end of thet fully allocated slabs because
these slabs have been around for a long time (This basically preserves the LRU
lists to some extend).

For slab we check all the objects in the slab. If all object have
a refcount of one then we free all the objects and return the pages of the
object to the page allocator.

So we could just free all the truly freeable slabs and leave the rest alone
in order to preserve the cached information.

However, with that a single object with a higher reference count would prevent
the reclaim of all other unused objects in that slab. So we free a couple of
those unused elements in each slab that is fully allocated.

This leads to a slow circulation of unused elements in fully allocated slabs.
So over time it is likely that continually active elements accumulate in slabs
that are in long term use which increases the allocation density of the slab
objects.

The idea of how to do this reclaim was developed a couple of month ago in a
meeting of Nick Piggin, Dave Chinner and me in Melbourne.

Note that this patch is only at the idea stage for now. It has not been tested
and no slab uses the new reclaim functionality until now. In order for the new
scheme to be useful we need to remove the LRU lists from the dcache and icache
and replace their reclaim algorithm.

That in turn will allow a lot of reduction of complexity in both. However, I
am not that familiar with it and so I thought it may be best to first discuss
the idea and maybe get some help with either of those.

The approach could be extended to allow the freeing of slab pages with
one single object by allowing the use of SLAB_DTOR_FREE on objects with higher
refcount. If one thinks further along those lines then we will get the ability
to migrate slab objects.

The current patchset contains 4 patches (the first two could be reviewed
for kernel inclusion):

1. Freelist code consolidation
	We will need to drain freelists repeatedly so consolidate existing code.

2. Mon destructor removal.
	We will change the nature of destructors. USB MON uses an empty
	destructor. Get that out of the way.

3. Make destructors check for SLAB_DTOR_DESTROY
	Only run the existing destructors if SLAB_DTOR_DESTROY is specified.

4. The slab reclaim functionality


