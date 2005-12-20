Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbVLTSUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbVLTSUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVLTSUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:20:51 -0500
Received: from waste.org ([64.81.244.121]:8915 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750842AbVLTSUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:20:49 -0500
Date: Tue, 20 Dec 2005 12:19:22 -0600
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
Message-ID: <20051220181921.GF3356@waste.org>
References: <dnu8ku$ie4$1@sea.gmane.org> <1134790400.13138.160.camel@localhost.localdomain> <1134860251.13138.193.camel@localhost.localdomain> <20051220133230.GC24408@elte.hu> <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu> <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> <1135093460.13138.302.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135093460.13138.302.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 10:44:20AM -0500, Steven Rostedt wrote:
> (Andrew, I'm CC'ing you and Matt to see if you would like this in -mm)
> 
> OK Ingo, here it is.
> 
> The old SLOB did the old K&R memory allocations.
> 
> It had a global link list "slobfree".  When it needed memory it would
> search this list linearly to find the first spot that fit and then
> return it.  It was broken up into SLOB_UNITS which was the number of
> bytes to hold slob_t.
> 
> Since the sizes of the allocations would greatly fluctuate, the chances
> for fragmentation was very high.  This would also cause the looking for
> free locations to increase, since the number of free blocks would also
> increase due to the fragmentation.

On the target systems for the original SLOB design, we have less than
16MB of memory, so the linked list walking is pretty well bounded.
 
> It also had one global spinlock for ALL allocations.  This would
> obviously kill SMP performance.

And again, the locking primarily exists for PREEMPT and small dual-core.
So I'm still a bit amused that you guys are using it for -RT.

> When any block was freed via kfree, it would first search all the big
> blocks to see if it was a large allocation, and if not, then it would
> search the slobfree list to find where it goes.  Both taking two global
> spinlocks!

I don't think this is correct, or else indicates a bug. We should only
scan the big block list when the freed block was page-aligned.

> First things first, the first patch was to get rid of the bigblock list.
> I'm simple used the method of SLAB to use the lru list field of the
> corresponding page to store the pointer to the bigblock descriptor which
> has the information to free it. This got rid of the bigblock link list
> and global spinlock.

This I like a lot. I'd like to see a size/performance measurement of
this by itself. I suspect it's an unambiguous win in both categories.
 
> The next patch was the big improvement, with the largest changes.  I
> took advantage of how the kmem_cache usage that SLAB also takes
> advantage of.  I created a memory pool like the global one, but for
> every cache with a size less then PAGE_SIZE >> 1.

Hmm. By every size, I assume you mean powers of two. Which negates
some of the fine-grained allocation savings that current SLOB provides.

[...]
> So I have improved the speed of SLOB to almost that of SLAB!

Nice.

For what it's worth, I think we really ought to consider a generalized
allocator approach like Sun's VMEM, with various removable pieces.

Currently we've got something like this:

 get_free_pages     boot_mem         idr    resource_*   vmalloc ...
        |
      slab
        |
  per_cpu/node
        |
  kmem_cache_alloc
        |
     kmalloc

We could take it in a direction like this:

 generic range allocator          (completely agnostic)
          |
  optional size buckets           (reduced fragmentation, O(1))
          |    
    optional slab                 (cache-friendly, pre-initialized)
          |
 optional per cpu/node caches     (cache-hot and lockless)
          |
 kmalloc / kmem_cache_alloc / boot_mem / idr / resource_* / vmalloc / ...

(You read that right, the top level allocator can replace all the
different allocators that hand back integers or non-overlapping ranges.)

Each user of, say, kmem_create() could then pass in flags to specify
which caching layers ought to be bypassed. IDR, for example, would
probably disable all the layers and specify a first-fit policy.

And then depending on our global size and performance requirements, we
could globally disable some layers like SLAB, buckets, or per_cpu
caches. With all the optional layers disabled, we'd end up with
something much like SLOB (but underneath get_free_page!).

-- 
Mathematics is the supreme nostalgia of our time.
