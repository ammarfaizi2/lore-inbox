Return-Path: <linux-kernel-owner+w=401wt.eu-S932416AbXARPMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbXARPMm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 10:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbXARPMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 10:12:42 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:13327 "EHLO
	amsfep18-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932416AbXARPMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 10:12:40 -0500
Subject: Re: Possible ways of dealing with OOM conditions.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
In-Reply-To: <20070118135839.GA7075@2ka.mipt.ru>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net>
	 <20070116101816.115266000@taijtu.programming.kicks-ass.net>
	 <20070116132503.GA23144@2ka.mipt.ru> <1168955274.22935.47.camel@twins>
	 <20070116153315.GB710@2ka.mipt.ru> <1168963695.22935.78.camel@twins>
	 <20070117045426.GA20921@2ka.mipt.ru> <1169024848.22935.109.camel@twins>
	 <20070118104144.GA20925@2ka.mipt.ru> <1169122724.6197.50.camel@twins>
	 <20070118135839.GA7075@2ka.mipt.ru>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 16:10:52 +0100
Message-Id: <1169133052.6197.96.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 16:58 +0300, Evgeniy Polyakov wrote:

> Network is special in this regard, since it only has one allocation path
> (actually it has one cache for skb, and usual kmalloc, but they are
> called from only two functions).
> 
> So it would become 
> ptr = network_alloc();
> and network_alloc() would be usual kmalloc or call for own allocator in
> case of deadlock.

There is more to networking that skbs only, what about route cache,
there is quite a lot of allocs in this fib_* stuff, IGMP etc...

> > very high order pages, no?
> >
> > This means that you have to either allocate at boot time and cannot
> > resize/add pools; which means you waste all that memory if the network
> > load never comes near using the reserved amount.
> > 
> > Or, you get into all the same trouble the hugepages folks are trying so
> > very hard to solve.
> 
> It is configurable - by default it takes pool of 32k pages for allocations for
> jumbo-frames (e1000 requires such allocations for 9k frames
> unfortunately), without jumbo-frame support it works with pool of 0-order
> pages, which grows dynamically when needed.

With 0-order pages, you can only fit 2 1500 byte packets in there, you
could perhaps stick some small skb heads in there as well, but why
bother, the waste isn't _that_ high.

Esp if you would make a slab for 1500 mtu packets (5*1638 < 2*4096; and
1638 should be enough, right?)

It would make sense to pack related objects into a page so you could
free all together.

> > > performs self-defragmentation of the memeory, 
> > 
> > Does it move memory about? 
> 
> It works in a page, not as pages - when neighbour regions are freed,
> they are combined into single one with bigger size

Yeah, that is not defragmentation, defragmentation is moving active
regions about to create contiguous free space. What you do is free space
coalescence.

>  but network stack requires high-order allocations in extremely rare
> cases of broken design (Intel folks, sorry, but your hardware sucks in
> that regard - jumbo frame of 9k should not require 16k of mem plu
> network overhead).

Well, if you have such hardware its not rare at all, But yeah that
sucks.

> NTA also does not align buffers to the power of two - extremely significant 
> win of that approach can be found on project's homepage with graps of
> failed allocations and state of the mem for different sizes of
> allocaions. Power-of-two overhead of SLAB is extremely high.

Sure you can pack the page a little better(*), but I thought the main
advantage was a speed increase.

(*) memory is generally cheaper than engineering efforts, esp on this
scale. The only advantage in the manual packing is that (with the fancy
hardware stream engine mentioned below) you could ensure they are
grouped together (then again, the hardware stream engine would, together
with a SG-DMA engine, take care of that).

> 
> > All it does is try to avoid fragmentation by policy - a problem
> > impossible to solve in general; but can achieve good results in view of
> > practical limitations on program behaviour.
> > 
> > Does your policy work for the given workload? we'll see.
> >
> > Also, on what level, each level has both internal and external
> > fragmentation. I can argue that having large immovable objects in memory
> > adds to the fragmentation issues on the page-allocator level.
> 
> NTA works with pages, not with contiguous memory, it reduces
> fragmentation inside pages, which can not be solved in SLAB, where
> objects from the same page can live in different caches and thus _never_
> can be combined. Thus, the only soultuin for SLAB is copy, which is not a
> good one for big sizes and is just wrong for big pages.

By allocating, and never returning the page to the page-allocator you've
increased the fragmentation on the page-allocator level significantly.
It will avoid a super page ever forming around that page.

> It is not about page moving and VM tricks, which are generally described
> as fragmentation avoidance technique, but about how fragmentation
> problem is solved in one page.

Short of defragmentation (move active regions about) fragmentation is an
unsolved problem. For any heuristic there is a pattern that will defeat
it. 

Luckily program allocation behaviour is usually very regular (or
decomposable in well behaved groups).

> > > is very SMP
> > > friendly in that regard that it is per-cpu like slab and never free
> > > objects on different CPUs, so they always stay in the same cache.
> > 
> > This makes it very hard to guarantee a reserve limit. (Not impossible,
> > just more difficult)
> 
> The whole pool of pages becomes reserve, since no one (and mainly VFS)
> can consume that reserve.

Ah, but there you violate my requirement, any network allocation can
claim the last bit of memory. The whole idea was that the reserve is
explicitly managed.

It not only needs protection from other users but also from itself.

> > > Among other goodies it allows to have full sending/receiving zero-copy.
> > 
> > That won't ever work unless you have page aligned objects, otherwise you
> > cannot map them into user-space. Which seems to be at odds with your
> > tight packing/reduce internal fragmentation goals.
> > 
> > Zero-copy entails mapping the page the hardware writes the packet in
> > into user-space, right?
> > 
> > Since its impossible to predict to whoem the next packet is addressed
> > the packets must be written (by hardware) to different pages.
> 
> Yes, receiving zero-copy without appropriate hardware assist is
> impossible, so either absence of such facility at all, or special overhead,
> which forces object to lie in different pages. With hardware assist it
> would be possible to select a flow in advance, so data would be packet
> in the same page.

I was not aware that hardware could order the packets in such a fashion.
Yes, if it can do that it becomes doable.

> Sending zero-copy from userspace memory does not suffer with any such
> problem.

True, that is properly ordered. But for that I'm not sure how NTA (you
really should change that name, there is no Tree anymore) helps here.

