Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVAOTS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVAOTS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 14:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVAOTS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 14:18:58 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:36262 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262341AbVAOTSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 14:18:43 -0500
Date: Sat, 15 Jan 2005 19:18:42 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoiding fragmentation through different allocator V2
In-Reply-To: <20050114213619.GA3336@logos.cnet>
Message-ID: <Pine.LNX.4.58.0501151858360.17278@skynet>
References: <Pine.LNX.4.58.0501131552400.31154@skynet> <20050114213619.GA3336@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005, Marcelo Tosatti wrote:

> On Thu, Jan 13, 2005 at 03:56:46PM +0000, Mel Gorman wrote:
> > The patch is against 2.6.11-rc1 and I'm willing to stand by it's
> > stability. I'm also confident it does it's job pretty well so I'd like it
> > to be considered for inclusion.
>
> This is very interesting!
>

Thanks

> Other than the advantage of decreased fragmentation which you aim, by
> providing clustering of different types of allocations you might have a
> performance gain (or loss :))  due to changes in cache colouring
> effects.
>

That is possible but it I haven't thought of a way of measuring the cache
colouring effects (if any). There is also the problem that the additional
complexity of the allocator will offset this benefit. The two main loss
points of the allocator are increased complexity and the increased size of
the zone struct.

> It depends on the workload/application mix and type of cache of course,
> but I think there will be a significant measurable difference on most
> common workloads.
>

If I could only measure it :/

> Have you done any investigation with that respect? IMHO such
> verification is really important before attempting to merge it.
>

No unfortunately. Do you know of a test I can use?

> BTW talking about cache colouring, I this is an area which has a HUGE
> space for improvement. The allocator is completly unaware of colouring
> (except the SLAB) - we should try to come up with a light per-process
> allocation colouring optimizer. But thats another history.
>

This also was tried and dropped. The allocator was a lot more complex and
the implementor was unable to measure it. IIRC, the patch was not accepted
with a comment along the lines of "If you can't measure it, it doesn't
exist". Before I walk down the page coloring path again, I'll need some
scheme that measures the cache-effect.

Totally aside, I'm doing this work because I've started a PhD on
developing solid metrics for measuring VM performance and then devising
new or modified algorithms using the metrics to see if the changes are any
good.

> > For me, the next stage is to write a linear scanner that goes through the
> > address space to free up a high-order block of pages on demand. This will
> > be a tricky job so it'll take me quite a while.
>
> We're paving the road to implement a generic "weak" migration function on top
> of the current page migration infrastructure. With "weak" I mean that it bails
> out easily if the page cannot be migrated, unlike the "strong" version which
> _has_ to migrate the page(s) (for memory hotplug purpose).
>
> With such function in place its easier to have different implementations of defragmentation
> logic - we might want to coolaborate on that.
>

I've also started something like this although I think you'll find my
first approach childishly simple. I implemented a linear scanner that
finds the KernRclm and UserRclm areas. It then makes a list of the PageLRU
pages and sends them to shrink_list(). I ran a test which put the machine
under heavy stress and then tried to allocate 75% of ZONE_NORMAL with
2^_MAX_ORDER pages (allocations done via a kernel module). I found that
the standard allocator was only able to successfully allocate 1% of the
allocations (3 blocks), my modified allocator managed 50% (81 blocks) and
with linear scanning in place, it was 76% (122 blocks). I figure I could
get the linear scanning figures even higher if I taught the allocator to
reserve the pages it frees for the process performing the linear scanning.

However, I also know the linear scanner trashed the LRU lists and probably
comes with all sorts of performance regressions just to make the
high-order allocations.

The new patches for the allocator (last patch I posted has a serious bug
in it), the linear scanner and the results will be posted as another mail.

> Your bitmap also allows a hint for the "defragmentator" to know the type
> of pages, and possibly size of the block, so it can avoid earlier trying
> to migrate non reclaimable memory. It possibly makes the scanning
> procedure much lightweight.
>

Potentially. I need to catch up more on the existing schemes. I've been
out of the VM loop for a long time now so I'm still playing the Catch-Up
game.

> > <SNIP>
>
> You want to do
> 		free_pages -= (z->free_area_lists[0][o].nr_free + z->free_area_lists[2][o].nr_free +
>                 		z->free_area_lists[2][o].nr_free) << o;
>
> So not to interfere with the "min" decay (and remove the allocation type loop).
>

Agreed. New patch has this in place

> >
> > -		/* Require fewer higher order pages to be free */
> > -		min >>= 1;
> > +			/* Require fewer higher order pages to be free */
> > +			min >>= 1;
> >
> > -		if (free_pages <= min)
> > -			return 0;
> > +			if (free_pages <= min)
> > +				return 0;
> > +		}
>
> I'll play with your patch during the weekend, run some benchmarks (STP
> is our friend), try to measure the overhead, etc.
>

I'll also look at STP again and start trying to move some of my tests to
it (I have a fairly involved testing scheme right now). I recall that STP
was very easy to get setup with, I was just pressed for time.

> Congrats, this is very cool!
>

Thanks a lot :)

-- 
Mel Gorman
