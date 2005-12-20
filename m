Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVLTTPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVLTTPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVLTTPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:15:53 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:36235 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750795AbVLTTPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:15:52 -0500
Subject: Re: [PATCH RT 00/02] SLOB optimizations
From: Steven Rostedt <rostedt@goodmis.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051220181921.GF3356@waste.org>
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134790400.13138.160.camel@localhost.localdomain>
	 <1134860251.13138.193.camel@localhost.localdomain>
	 <20051220133230.GC24408@elte.hu>
	 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
	 <20051220135725.GA29392@elte.hu>
	 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
	 <1135093460.13138.302.camel@localhost.localdomain>
	 <20051220181921.GF3356@waste.org>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 14:15:24 -0500
Message-Id: <1135106124.13138.339.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 12:19 -0600, Matt Mackall wrote:
> On Tue, Dec 20, 2005 at 10:44:20AM -0500, Steven Rostedt wrote:
> > (Andrew, I'm CC'ing you and Matt to see if you would like this in -mm)
> > 
> > OK Ingo, here it is.
> > 
> > The old SLOB did the old K&R memory allocations.
> > 
> > It had a global link list "slobfree".  When it needed memory it would
> > search this list linearly to find the first spot that fit and then
> > return it.  It was broken up into SLOB_UNITS which was the number of
> > bytes to hold slob_t.
> > 
> > Since the sizes of the allocations would greatly fluctuate, the chances
> > for fragmentation was very high.  This would also cause the looking for
> > free locations to increase, since the number of free blocks would also
> > increase due to the fragmentation.
> 
> On the target systems for the original SLOB design, we have less than
> 16MB of memory, so the linked list walking is pretty well bounded.

I bet after a while of running, your performance will still suffer due
to fragmentation.  The more fragmented it is, the more space you lose
and the more steps you need to walk.

Remember, because of the small stack, kmalloc and kfree are used an
awful lot.  And if you slow those down, you will start to take a big hit
in performance.

>  
> > It also had one global spinlock for ALL allocations.  This would
> > obviously kill SMP performance.
> 
> And again, the locking primarily exists for PREEMPT and small dual-core.
> So I'm still a bit amused that you guys are using it for -RT.

I think this is due to the complexity of the current SLAB.  With slab.c
unmodified, the RT kernel doesn't boot.  And it's getting more complex,
so to make the proper changes to have it run under a fully preemptible
kernel, takes knowing all the details of the SLAB.

Ingo can answer this better himself, but I have a feeling he jumped to
your SLOB system just because of the simplicity.

> 
> > When any block was freed via kfree, it would first search all the big
> > blocks to see if it was a large allocation, and if not, then it would
> > search the slobfree list to find where it goes.  Both taking two global
> > spinlocks!
> 
> I don't think this is correct, or else indicates a bug. We should only
> scan the big block list when the freed block was page-aligned.

Yep, you're right here.  I forgot about that since updating the bigblock
list was the first thing I did, and I didn't need that check anymore.
So, I was wrong here, yours does _only_ scan the bigblock list if the
block is page aligned.

> 
> > First things first, the first patch was to get rid of the bigblock list.
> > I'm simple used the method of SLAB to use the lru list field of the
> > corresponding page to store the pointer to the bigblock descriptor which
> > has the information to free it. This got rid of the bigblock link list
> > and global spinlock.
> 
> This I like a lot. I'd like to see a size/performance measurement of
> this by itself. I suspect it's an unambiguous win in both categories.

Actually the performance gain was disappointingly small.  As it was a
separate patch and I though it would gain a lot.  But if IIRC, it only
increased the speed by a second or two (of the 1 minute 27 seconds).
That's why I spent so much time in the next approach.

>  
> > The next patch was the big improvement, with the largest changes.  I
> > took advantage of how the kmem_cache usage that SLAB also takes
> > advantage of.  I created a memory pool like the global one, but for
> > every cache with a size less then PAGE_SIZE >> 1.
> 
> Hmm. By every size, I assume you mean powers of two. Which negates
> some of the fine-grained allocation savings that current SLOB provides.

Yeah its the same as what the slabs use.  But I would like to take
measurements of a running system between the two approaches.  After a
day of heavy network traffic, see what the fragmentation is like and how
much is wasted.  This would require me finishing my cache_chain work,
and adding something similar to your SLOB.

But the powers of two is only for the kmalloc, which this is a know
behavior of the current system.  So it <should> only be used for things
that would alloc and free within a quick time (like for things you would
like to put on a stack but cant), or the size is close to (less than or
equal) a power of two.  Otherwise a kmem_cache is made which is the size
of expected object (off by UNIT_SIZE).

Oh, this reminds me, I probably still need to add a shrink cache
algorithm.  Which would be very hard to do in the current SLOB.

Also note, I don't need to save the descriptor in with each kmalloc as
the current SLOB does.  Since each memory pool is of a fixed size, I
again use the mem_map pages to store the location of the descriptor.  So
I save on memory that way.

> 
> [...]
> > So I have improved the speed of SLOB to almost that of SLAB!
> 
> Nice.
> 
> For what it's worth, I think we really ought to consider a generalized
> allocator approach like Sun's VMEM, with various removable pieces.

Interesting, I don't know how Sun's VMEM works.  Do you have links to
some documentation?

> 
> Currently we've got something like this:
> 
>  get_free_pages     boot_mem         idr    resource_*   vmalloc ...
>         |
>       slab
>         |
>   per_cpu/node
>         |
>   kmem_cache_alloc
>         |
>      kmalloc
> 
> We could take it in a direction like this:
> 
>  generic range allocator          (completely agnostic)
>           |
>   optional size buckets           (reduced fragmentation, O(1))
>           |    
>     optional slab                 (cache-friendly, pre-initialized)
>           |
>  optional per cpu/node caches     (cache-hot and lockless)
>           |
>  kmalloc / kmem_cache_alloc / boot_mem / idr / resource_* / vmalloc / ...
> 
> (You read that right, the top level allocator can replace all the
> different allocators that hand back integers or non-overlapping ranges.)
> 
> Each user of, say, kmem_create() could then pass in flags to specify
> which caching layers ought to be bypassed. IDR, for example, would
> probably disable all the layers and specify a first-fit policy.
> 
> And then depending on our global size and performance requirements, we
> could globally disable some layers like SLAB, buckets, or per_cpu
> caches. With all the optional layers disabled, we'd end up with
> something much like SLOB (but underneath get_free_page!).

That looks like quite an undertaking, but may be well worth it.  I think
Linux's memory management is starting to show it's age.  It's been
through a few transformations, and maybe it's time to go through
another.  The work being done by the NUMA folks, should be taking into
account, and maybe we can come up with a way that can make things easier
and less complex without losing performance.

BTW, the NUMA code in the slabs was the main killer for the RT
conversion.


Thanks for the input,

-- Steve


