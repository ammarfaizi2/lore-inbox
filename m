Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVAOUKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVAOUKi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 15:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVAOUKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 15:10:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46760 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262312AbVAOUJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 15:09:49 -0500
Date: Sat, 15 Jan 2005 15:10:06 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoiding fragmentation through different allocator V2
Message-ID: <20050115171006.GD7397@logos.cnet>
References: <Pine.LNX.4.58.0501131552400.31154@skynet> <20050114213619.GA3336@logos.cnet> <Pine.LNX.4.58.0501151858360.17278@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501151858360.17278@skynet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 07:18:42PM +0000, Mel Gorman wrote:
> On Fri, 14 Jan 2005, Marcelo Tosatti wrote:
> 
> > On Thu, Jan 13, 2005 at 03:56:46PM +0000, Mel Gorman wrote:
> > > The patch is against 2.6.11-rc1 and I'm willing to stand by it's
> > > stability. I'm also confident it does it's job pretty well so I'd like it
> > > to be considered for inclusion.
> >
> > This is very interesting!
> >
> 
> Thanks
> 
> > Other than the advantage of decreased fragmentation which you aim, by
> > providing clustering of different types of allocations you might have a
> > performance gain (or loss :))  due to changes in cache colouring
> > effects.
> >
> 
> That is possible but it I haven't thought of a way of measuring the cache
> colouring effects (if any). There is also the problem that the additional
> complexity of the allocator will offset this benefit. The two main loss
> points of the allocator are increased complexity and the increased size of
> the zone struct.

We should be able to measure that too...

If you look at the performance numbers of applications which do data crunching,
reading/writing data to disk (scientific applications). Or even databases,
plus standard set of IO benchmarks...

Of course you're not able to measure the change in cache hits/misses (which would be nice),
but you can get an idea how measurable is the final performance impact, including
the page allocator overhead and the increase zone struct size (I dont think the struct zone 
size increase makes much difference).

We should be able to use the CPU performance counters to get exact miss/hit numbers, 
but it seems its not yet possible to use Mikael's Pettersson pmc inside the kernel, I asked him
sometime ago but never got along to trying anything:

Subject: Re: Measuring kernel-level code cache hits/misses with perfctr     

 > Hi Mikael,                                                                                                                                                     
 >                                                                                                                                                                
 > I've been wondering if its possible to use PMC's                                                                                                               
 > to monitor L1 and/or L2 cache hits from kernel code? 

You can count them by using the global-mode counters interface
(present in the perfctr-2.6 package but not in the 2.6-mm kernel
unfortunately) and restricting the counters to CPL 0.

However, for profiling purposes you probably want to catch overflow
interrupts, and that's not supported for global-mode counters.
I simply haven't had time to implement that feature.


> > It depends on the workload/application mix and type of cache of course,
> > but I think there will be a significant measurable difference on most
> > common workloads.
> >
> 
> If I could only measure it :/
> 
> > Have you done any investigation with that respect? IMHO such
> > verification is really important before attempting to merge it.
> >
> 
> No unfortunately. Do you know of a test I can use?

I think some CPU/memory intensive benchmarks should give us a hint of the total
impact ?

> > BTW talking about cache colouring, I this is an area which has a HUGE
> > space for improvement. The allocator is completly unaware of colouring
> > (except the SLAB) - we should try to come up with a light per-process
> > allocation colouring optimizer. But thats another history.
> >
> 
> This also was tried and dropped. The allocator was a lot more complex and
> the implementor was unable to measure it. IIRC, the patch was not accepted
> with a comment along the lines of "If you can't measure it, it doesn't
> exist". Before I walk down the page coloring path again, I'll need some
> scheme that measures the cache-effect.

Someone needs to write the helper functions to use the PMC's and test that.

> Totally aside, I'm doing this work because I've started a PhD on
> developing solid metrics for measuring VM performance and then devising
> new or modified algorithms using the metrics to see if the changes are any
> good.

Nice! Make your work public! I'm personally very interested in this area.

> > > For me, the next stage is to write a linear scanner that goes through the
> > > address space to free up a high-order block of pages on demand. This will
> > > be a tricky job so it'll take me quite a while.
> >
> > We're paving the road to implement a generic "weak" migration function on top
> > of the current page migration infrastructure. With "weak" I mean that it bails
> > out easily if the page cannot be migrated, unlike the "strong" version which
> > _has_ to migrate the page(s) (for memory hotplug purpose).
> >
> > With such function in place its easier to have different implementations of defragmentation
> > logic - we might want to coolaborate on that.
> >
> 
> I've also started something like this although I think you'll find my
> first approach childishly simple. I implemented a linear scanner that
> finds the KernRclm and UserRclm areas. It then makes a list of the PageLRU
> pages and sends them to shrink_list(). I ran a test which put the machine
> under heavy stress and then tried to allocate 75% of ZONE_NORMAL with
> 2^_MAX_ORDER pages (allocations done via a kernel module). I found that
> the standard allocator was only able to successfully allocate 1% of the
> allocations (3 blocks), my modified allocator managed 50% (81 blocks) and
> with linear scanning in place, it was 76% (122 blocks). I figure I could
> get the linear scanning figures even higher if I taught the allocator to
> reserve the pages it frees for the process performing the linear scanning.

Cool.

> However, I also know the linear scanner trashed the LRU lists and probably
> comes with all sorts of performance regressions just to make the
> high-order allocations.

Migrating pages instead of freeing them can greatly reduce the overhead I believe 
and might be a low impact way of defragmenting memory. 

> The new patches for the allocator (last patch I posted has a serious bug
> in it), the linear scanner and the results will be posted as another mail.
>
> 
> > Your bitmap also allows a hint for the "defragmentator" to know the type
> > of pages, and possibly size of the block, so it can avoid earlier trying
> > to migrate non reclaimable memory. It possibly makes the scanning
> > procedure much lightweight.
> >
> 
> Potentially. I need to catch up more on the existing schemes. I've been
> out of the VM loop for a long time now so I'm still playing the Catch-Up
> game.
> 
> > > <SNIP>
> >
> > You want to do
> > 		free_pages -= (z->free_area_lists[0][o].nr_free + z->free_area_lists[2][o].nr_free +
> >                 		z->free_area_lists[2][o].nr_free) << o;
> >
> > So not to interfere with the "min" decay (and remove the allocation type loop).
> >
> 
> Agreed. New patch has this in place
> 
> > >
> > > -		/* Require fewer higher order pages to be free */
> > > -		min >>= 1;
> > > +			/* Require fewer higher order pages to be free */
> > > +			min >>= 1;
> > >
> > > -		if (free_pages <= min)
> > > -			return 0;
> > > +			if (free_pages <= min)
> > > +				return 0;
> > > +		}
> >
> > I'll play with your patch during the weekend, run some benchmarks (STP
> > is our friend), try to measure the overhead, etc.
> >
> 
> I'll also look at STP again and start trying to move some of my tests to
> it (I have a fairly involved testing scheme right now). I recall that STP
> was very easy to get setup with, I was just pressed for time.

:)

> > Congrats, this is very cool!
> >
> 
> Thanks a lot :)

I've added your patch to STP but:

[STP 300030]Kernel Patch Error  Kernel: mel-three-type-allocator-v2 PLM # 4073

patching file usr/gen_init_cpio.c
patching file fs/buffer.c
Hunk #2 succeeded at 2998 with fuzz 1.
patching file fs/dcache.c
Hunk #1 FAILED at 715.
1 out of 1 hunk FAILED -- saving rejects to file fs/dcache.c.rej
patching file fs/ext2/super.c
patching file fs/ext3/super.c
patching file fs/ntfs/inode.c
patching file include/linux/gfp.h
patching file include/linux/mmzone.h
patching file mm/page_alloc.c
Hunk #10 FAILED at 581.
Hunk #11 succeeded at 591 with fuzz 1.
1 out of 22 hunks FAILED -- saving rejects to file mm/page_alloc.c.rej

It failed to apply to 2.6.10-rc1 - I'll work the rejects and rerun the tests.

Can you send me your last patch please?



