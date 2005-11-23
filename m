Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVKWTfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVKWTfd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVKWTfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:35:33 -0500
Received: from fmr21.intel.com ([143.183.121.13]:46742 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932235AbVKWTfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:35:32 -0500
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
	conditions
From: Rohit Seth <rohit.seth@intel.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Christoph Lameter <christoph@lameter.com>
In-Reply-To: <Pine.LNX.4.58.0511231754020.7045@skynet>
References: <20051122161000.A22430@unix-os.sc.intel.com>
	 <20051122213612.4adef5d0.akpm@osdl.org>
	 <1132768482.25086.16.camel@akash.sc.intel.com>
	 <Pine.LNX.4.58.0511231754020.7045@skynet>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 23 Nov 2005 11:41:40 -0800
Message-Id: <1132774900.25086.49.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Nov 2005 19:34:42.0548 (UTC) FILETIME=[F3AC5340:01C5F064]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 18:06 +0000, Mel Gorman wrote:
> On Wed, 23 Nov 2005, Rohit Seth wrote:
> 
> >
> I doubt you gain a whole lot by releasing them in batches. There is no way
> to determine if freeing a few will result in contiguous blocks or not and
> the overhead of been cautious will likely exceed the cost of simply
> refilling them on the next order-0 allocation. 

It depends.  If most of the higher order allocations are only order 1
(and may be order 2) then it is possible that we may gain in freeing in
batches.  

> Your worst case is where
> the buddies you need are in different per-cpu caches.
> 

That is why we need another patch that tries to allocate physically
contiguous pages in each per_cpu_pagelist.  Actually this patch used to
be there in Andrew's tree for some time (2.6.14) before couple of corner
cases came up failing where order 1 allocations were unsuccessful.

> As it's easy to refill a per-cpu cache, it would be easier, clearer and
> probably faster to just purge the per-cpu cache and have it refilled on
> the next order-0 allocation. The release-in-batch approach would only be
> worthwhile if you expect an order-1 allocation to be very rare.
> 

Well, my only fear is if this shunting happens too often...

> In 005_drainpercpu.patch from the last version of the anti-defrag, I used
> the smp_call_function() and it did not seem to slow up the system.
> Certainly, by the time it was called, the system was already low on
> memory and trashing a bit so it just wasn't noticable.
> 

I agree at this point in alloaction, speed probably does not matter too
much.  I definitely want to first see for simple workloads how much (and
how deep we have to go into deallocations) this extra logic helps.

> > 2- Do we drain the whole pcp on remote processors or again follow the
> > stepped approach (but may be with a steeper slope).
> >
> 
> I would say do the same on the remote case as you do locally to keep
> things consistent.
> 

Well, I think in bigger scope these allocations/deallocations will get
automatically balanced.
 
> >
> > > We need to verify that this patch actually does something useful.
> > >
> > >
> > I'm working on this.  Will let you know later today if I can come with
> > some workload easily hitting this additional logic.
> >
> 
> I found it hard to generate reliable workloads which hit these sort of
> situations although a fork-heavy workload with 8k stacks will put pressure
> on order-1 allocations. You can artifically force high order allocations
> using vmregress by doing something like this;

Need something more benign/stupid to kick into this logic.  

-rohit

