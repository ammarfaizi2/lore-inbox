Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTKAMCh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 07:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTKAMCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 07:02:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14341 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263758AbTKAMCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 07:02:34 -0500
Subject: New: Documentation/vm/slabinfo.txt
From: Doug Ledford <dledford@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1067688069.3112.559.camel@compaq.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Sat, 01 Nov 2003 07:01:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote this by looking at the 2.4 kernel sources, so it may not be
totally accurate as far as 2.6 is concerned, but since there is no
documentation on it at the moment, it's certainly better than what's
there.

------Snip--------
> cat /proc/slabinfo:
> inode_cache       423370 423556    512 60482 60508    1 :  248   62
> dentry_cache      435756 436260    128 14526 14542    1 :  504  126

Hmmm...those lines looked suspicious, but I didn't really know how to
read the slabinfo output.  So I just went and read up on it.  For those
people like me that didn't know what all these numbers mean, here's my
understanding after reading the source:

                  active-objects
                  |      allocated-objects
                  |      |         object-size
                  |      |         |   active-slab-allocations
                  |      |         |   |     total-slab-allocations
                  |      |         |   |     |        alloc-size
                  |      |         |   |     |        |
inode_cache       423370 423556    512 60482 60508    1 :  248   62
                                                           |     |
                                                       limit     |
                                                       batch-count

active-objects: after creating a slab cache, you allocate your objects
out of that slab cache.  This is the count of objects you currently have
allocated out of the cache.

allocated-objects: this is the current total number of objects in the
cache.

object-size: this is the size of each allocated object.  There is
overhead to maintaining the cache, so with a 512byte object and a
4096byte page size, you could fit 7 objects in a single page and you
would waste 512-slab_overhead bytes per allocation.  Slab overhead
varies with object size (smaller objects have more objects per
allocation and require more overhead to track used vs. unused objects). 
You can determine how many objects are being put on each allocation
chunk by dividing allocated-objects by total-allocations.

active-slab-allocs: This is the number of allocations that have at least
one of that allocations objects in use.

total-slab-allocs: The total number of allocations in the current slab
cache.

alloc-size: This is the size of each allocation in units of memory
pages.   Page size is architecture specific, but the most common size is
4k.  A couple architectures have an 8k page size, and ia64 can do a 16k
page size.  Each allocation for the cache is alloc-size * arch_page_size
bytes at a time, and total memory used by this particular slab cache is
total_slab_allocs * alloc_size * arch_page_size.

The last 2 items are SMP specific and don't show up at all on UP
kernels.  On SMP machines, the slab cache will keep a per CPU cache of
objects so that an object freed on CPU0 will be reused on CPU0 instead
of CPU1 if possible.  This improves cache performance on SMP systems
greatly.

limit:  This is the limit on the number of free objects that can be
stored in the per-CPU free list for this slab cache.

batch-count:  On SMP systems, when we refill the available object list,
instead of doing one object at a time, we do batch-count objects at a
time.

One last thing, if slab statistics are enabled, then you'll get more
numbers on each line and the lines will look like this:

UP
name active-objects total-objects object-size active-allocs total-allocs
alloc-size: high-size num-allocations times-grown allocs-reaped errors

SMP
name active-objects total-objects object-size active-allocs total-allocs
alloc-size: high-size num-allocations times-grown allocs-reaped errors:
limit batch-count: alloc-hits alloc-misses free-hits free-misses

For the most part, the statistics numbers are pretty self explanatory,
so I won't bother with them.

HTH

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606


