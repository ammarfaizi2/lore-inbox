Return-Path: <linux-kernel-owner+w=401wt.eu-S1751867AbXARN7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbXARN7A (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbXARN67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:58:59 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:51036 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbXARN66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:58:58 -0500
Date: Thu, 18 Jan 2007 16:58:40 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
Subject: Possible ways of dealing with OOM conditions.
Message-ID: <20070118135839.GA7075@2ka.mipt.ru>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net> <20070116101816.115266000@taijtu.programming.kicks-ass.net> <20070116132503.GA23144@2ka.mipt.ru> <1168955274.22935.47.camel@twins> <20070116153315.GB710@2ka.mipt.ru> <1168963695.22935.78.camel@twins> <20070117045426.GA20921@2ka.mipt.ru> <1169024848.22935.109.camel@twins> <20070118104144.GA20925@2ka.mipt.ru> <1169122724.6197.50.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1169122724.6197.50.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 18 Jan 2007 16:58:40 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 01:18:44PM +0100, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > > How would that end up being different, I would have to replace all
> > > allocations done in the full network processing path.
> > > 
> > > This seems a much less invasive method, all the (allocation) code can
> > > stay the way it is and use the normal allocation functions.
> 
> > And acutally we are starting to talk about different approach - having
> > separated allocator for network, which will be turned on on OOM (reclaim
> > or at any other time).
> 
> I think we might be, I'm more talking about requirements on the
> allocator, while you seem to talk about implementations.
> 
> Replacing the allocator, or splitting it in two based on a condition are
> all fine as long as they observe the requirements.
> 
> The requirement I add is that there is a reserve nobody touches unless
> given express permission.
> 
> You could implement this by modifying each reachable allocator call site
> and stick a branch in and use an alternate allocator when the normal
> route fails and we do have permission; much like:
> 
>    foo = kmalloc(size, gfp_mask);
> +  if (!foo && special)
> +    foo = my_alloc(size)

Network is special in this regard, since it only has one allocation path
(actually it has one cache for skb, and usual kmalloc, but they are
called from only two functions).

So it would become 
ptr = network_alloc();
and network_alloc() would be usual kmalloc or call for own allocator in
case of deadlock.

> And earlier versions of this work did something like that. But it
> litters the code quite badly and its quite easy to miss spots. There can
> be quite a few allocations in processing network data.
> 
> Hence my work on integrating this into the regular memory allocators.
> 
> FYI; 'special' evaluates to something like:
>   !(gfp_mask & __GFP_NOMEMALLOC) &&
>   ((gfp_mask & __GFP_EMERGENCY) || 
>    (!in_irq() && (current->flags & PF_MEMALLOC)))
> 
> 
> >  If you do not mind, I would likw to refresh a
> > discussion about network tree allocator,
> 
> >  which utilizes own pool of
> > pages, 
> 
> very high order pages, no?
>
> This means that you have to either allocate at boot time and cannot
> resize/add pools; which means you waste all that memory if the network
> load never comes near using the reserved amount.
> 
> Or, you get into all the same trouble the hugepages folks are trying so
> very hard to solve.

It is configurable - by default it takes pool of 32k pages for allocations for
jumbo-frames (e1000 requires such allocations for 9k frames
unfortunately), without jumbo-frame support it works with pool of 0-order
pages, which grows dynamically when needed.

> > performs self-defragmentation of the memeory, 
> 
> Does it move memory about? 

It works in a page, not as pages - when neighbour regions are freed,
they are combined into single one with bigger size - it would be
extended to move pages around to combied them into bigger one though
too, but network stack requires high-order allocations in extremely rare
cases of broken design (Intel folks, sorry, but your hardware sucks in
that regard - jumbo frame of 9k should not require 16k of mem plu
network overhead).

NTA also does not align buffers to the power of two - extremely significant 
win of that approach can be found on project's homepage with graps of
failed allocations and state of the mem for different sizes of
allocaions. Power-of-two overhead of SLAB is extremely high.

> All it does is try to avoid fragmentation by policy - a problem
> impossible to solve in general; but can achieve good results in view of
> practical limitations on program behaviour.
> 
> Does your policy work for the given workload? we'll see.
>
> Also, on what level, each level has both internal and external
> fragmentation. I can argue that having large immovable objects in memory
> adds to the fragmentation issues on the page-allocator level.

NTA works with pages, not with contiguous memory, it reduces
fragmentation inside pages, which can not be solved in SLAB, where
objects from the same page can live in different caches and thus _never_
can be combined. Thus, the only soultuin for SLAB is copy, which is not a
good one for big sizes and is just wrong for big pages.
It is not about page moving and VM tricks, which are generally described
as fragmentation avoidance technique, but about how fragmentation
problem is solved in one page.

> > is very SMP
> > friendly in that regard that it is per-cpu like slab and never free
> > objects on different CPUs, so they always stay in the same cache.
> 
> This makes it very hard to guarantee a reserve limit. (Not impossible,
> just more difficult)

The whole pool of pages becomes reserve, since no one (and mainly VFS)
can consume that reserve.

> > Among other goodies it allows to have full sending/receiving zero-copy.
> 
> That won't ever work unless you have page aligned objects, otherwise you
> cannot map them into user-space. Which seems to be at odds with your
> tight packing/reduce internal fragmentation goals.
> 
> Zero-copy entails mapping the page the hardware writes the packet in
> into user-space, right?
> 
> Since its impossible to predict to whoem the next packet is addressed
> the packets must be written (by hardware) to different pages.

Yes, receiving zero-copy without appropriate hardware assist is
impossible, so either absence of such facility at all, or special overhead,
which forces object to lie in different pages. With hardware assist it
would be possible to select a flow in advance, so data would be packet
in the same page.

Sending zero-copy from userspace memory does not suffer with any such
problem.

-- 
	Evgeniy Polyakov
