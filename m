Return-Path: <linux-kernel-owner+w=401wt.eu-S932207AbXARMUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbXARMUh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 07:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbXARMUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 07:20:37 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:16038 "EHLO
	amsfep18-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932207AbXARMUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 07:20:36 -0500
Subject: Re: [PATCH 9/9] net: vm deadlock avoidance core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
In-Reply-To: <20070118104144.GA20925@2ka.mipt.ru>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net>
	 <20070116101816.115266000@taijtu.programming.kicks-ass.net>
	 <20070116132503.GA23144@2ka.mipt.ru> <1168955274.22935.47.camel@twins>
	 <20070116153315.GB710@2ka.mipt.ru> <1168963695.22935.78.camel@twins>
	 <20070117045426.GA20921@2ka.mipt.ru> <1169024848.22935.109.camel@twins>
	 <20070118104144.GA20925@2ka.mipt.ru>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 13:18:44 +0100
Message-Id: <1169122724.6197.50.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 13:41 +0300, Evgeniy Polyakov wrote:

> > > What about 'level-7' ack as you described in introduction?
> > 
> > Take NFS, it does full data traffic in kernel.
> 
> NFS case is exactly the situation, when you only need to generate an ACK.

No it is not, it needs the full RPC response.

> > > You artificially limit system to just add a reserve to generate one ack.
> > > For that purpose you do not need to have all those flags - just reseve
> > > some data in network core and use it when system is in OOM (or reclaim)
> > > for critical data pathes.
> > 
> > How would that end up being different, I would have to replace all
> > allocations done in the full network processing path.
> > 
> > This seems a much less invasive method, all the (allocation) code can
> > stay the way it is and use the normal allocation functions.

> And acutally we are starting to talk about different approach - having
> separated allocator for network, which will be turned on on OOM (reclaim
> or at any other time).

I think we might be, I'm more talking about requirements on the
allocator, while you seem to talk about implementations.

Replacing the allocator, or splitting it in two based on a condition are
all fine as long as they observe the requirements.

The requirement I add is that there is a reserve nobody touches unless
given express permission.

You could implement this by modifying each reachable allocator call site
and stick a branch in and use an alternate allocator when the normal
route fails and we do have permission; much like:

   foo = kmalloc(size, gfp_mask);
+  if (!foo && special)
+    foo = my_alloc(size)

And earlier versions of this work did something like that. But it
litters the code quite badly and its quite easy to miss spots. There can
be quite a few allocations in processing network data.

Hence my work on integrating this into the regular memory allocators.

FYI; 'special' evaluates to something like:
  !(gfp_mask & __GFP_NOMEMALLOC) &&
  ((gfp_mask & __GFP_EMERGENCY) || 
   (!in_irq() && (current->flags & PF_MEMALLOC)))


>  If you do not mind, I would likw to refresh a
> discussion about network tree allocator,

>  which utilizes own pool of
> pages, 

very high order pages, no?

This means that you have to either allocate at boot time and cannot
resize/add pools; which means you waste all that memory if the network
load never comes near using the reserved amount.

Or, you get into all the same trouble the hugepages folks are trying so
very hard to solve.

> performs self-defragmentation of the memeory, 

Does it move memory about? 

All it does is try to avoid fragmentation by policy - a problem
impossible to solve in general; but can achieve good results in view of
practical limitations on program behaviour.

Does your policy work for the given workload? we'll see.

Also, on what level, each level has both internal and external
fragmentation. I can argue that having large immovable objects in memory
adds to the fragmentation issues on the page-allocator level.

> is very SMP
> friendly in that regard that it is per-cpu like slab and never free
> objects on different CPUs, so they always stay in the same cache.

This makes it very hard to guarantee a reserve limit. (Not impossible,
just more difficult)

> Among other goodies it allows to have full sending/receiving zero-copy.

That won't ever work unless you have page aligned objects, otherwise you
cannot map them into user-space. Which seems to be at odds with your
tight packing/reduce internal fragmentation goals.

Zero-copy entails mapping the page the hardware writes the packet in
into user-space, right?

Since its impossible to predict to whoem the next packet is addressed
the packets must be written (by hardware) to different pages.


