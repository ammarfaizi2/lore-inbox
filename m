Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVKXJZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVKXJZe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 04:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVKXJZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 04:25:33 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:61608 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751335AbVKXJZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 04:25:32 -0500
Date: Thu, 24 Nov 2005 09:25:15 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Rohit Seth <rohit.seth@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Christoph Lameter <christoph@lameter.com>
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
 conditions
In-Reply-To: <1132774900.25086.49.camel@akash.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0511240913250.15203@skynet>
References: <20051122161000.A22430@unix-os.sc.intel.com> 
 <20051122213612.4adef5d0.akpm@osdl.org>  <1132768482.25086.16.camel@akash.sc.intel.com>
  <Pine.LNX.4.58.0511231754020.7045@skynet> <1132774900.25086.49.camel@akash.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Rohit Seth wrote:

> On Wed, 2005-11-23 at 18:06 +0000, Mel Gorman wrote:
> > On Wed, 23 Nov 2005, Rohit Seth wrote:
> >
> > >
> > I doubt you gain a whole lot by releasing them in batches. There is no way
> > to determine if freeing a few will result in contiguous blocks or not and
> > the overhead of been cautious will likely exceed the cost of simply
> > refilling them on the next order-0 allocation.
>
> It depends.  If most of the higher order allocations are only order 1
> (and may be order 2) then it is possible that we may gain in freeing in
> batches.
>

Possible, but if you are draining, it's just as handy to drain them all
and avoid >0 order failures in the near future.

> > Your worst case is where
> > the buddies you need are in different per-cpu caches.
> >
>
> That is why we need another patch that tries to allocate physically
> contiguous pages in each per_cpu_pagelist.

That will only delay the problem. Pages end up on the per-cpu lists from
either an allocation or a free. While the allocation would make sure the
pages were contiguous and on the same list, the frees will not. The test
case you are running is a tight loop of one process allocating and freeing
order-1 pages. This is probably staying on the one CPU so draining in
batches on just the local CPU will appear successful. On long lived loads,
it will not be as successful. Draining all the pages on all lists would
cover all cases while using the existing code.

When I was testing my version of drain-percpu for anti-defrag and order-10
allocations, I found that draining just the local CPU made little
difference but draining all of them made a massive difference. This is an
extreme case, but it still applies to the smaller orders.

> Actually this patch used to
> be there in Andrew's tree for some time (2.6.14) before couple of corner
> cases came up failing where order 1 allocations were unsuccessful.
>
> > As it's easy to refill a per-cpu cache, it would be easier, clearer and
> > probably faster to just purge the per-cpu cache and have it refilled on
> > the next order-0 allocation. The release-in-batch approach would only be
> > worthwhile if you expect an order-1 allocation to be very rare.
> >
>
> Well, my only fear is if this shunting happens too often...
>

Measure it by counting how often you drain the pages and add it to
frag_show(). This is a hack obviously and not a permanent solution, but
it's the easiest way to find out what's going on.

> > In 005_drainpercpu.patch from the last version of the anti-defrag, I used
> > the smp_call_function() and it did not seem to slow up the system.
> > Certainly, by the time it was called, the system was already low on
> > memory and trashing a bit so it just wasn't noticable.
> >
>
> I agree at this point in alloaction, speed probably does not matter too
> much.  I definitely want to first see for simple workloads how much (and
> how deep we have to go into deallocations) this extra logic helps.
>
> > > 2- Do we drain the whole pcp on remote processors or again follow the
> > > stepped approach (but may be with a steeper slope).
> > >
> >
> > I would say do the same on the remote case as you do locally to keep
> > things consistent.
> >
>
> Well, I think in bigger scope these allocations/deallocations will get
> automatically balanced.
>

Depends on if your workload involves one or more processes. If the load is
multiple processes on multiple CPUs, the per-cpu pages will be spread out
a lot.

> > >
> > > > We need to verify that this patch actually does something useful.
> > > >
> > > >
> > > I'm working on this.  Will let you know later today if I can come with
> > > some workload easily hitting this additional logic.
> > >
> >
> > I found it hard to generate reliable workloads which hit these sort of
> > situations although a fork-heavy workload with 8k stacks will put pressure
> > on order-1 allocations. You can artifically force high order allocations
> > using vmregress by doing something like this;
>
> Need something more benign/stupid to kick into this logic.
>

If CIFS still needs high order allocations, you could try -jN kernel
compiles over the network filesystem. Network benchmarks running over a
loopback device with a large MTU while another load consumes memory might
also trigger it.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
