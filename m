Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbUKBPwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbUKBPwP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUKBPt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 10:49:29 -0500
Received: from jade.aracnet.com ([216.99.193.136]:21178 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261301AbUKBPm0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 10:42:26 -0500
Date: Tue, 02 Nov 2004 07:42:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@novell.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <11900000.1099410137@[10.10.2.4]>
In-Reply-To: <20041102022122.GJ3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random> <20041102022122.GJ3571@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The idea that the quicklist is meant to take the lock once every X pages
> is limiting. The object is to never ever have to enter the buddy, not
> just to "buffer" allocations. 

That'd be nicer, yes.

> The two separated cold/hot lists prevents that. As far as there's a single 
> page available we should use it since bouncing the cacheline is very costly.

Well, it doesn't really prevent it ... it used to work, I think. However, 
the current code appears to be broken - what it's meant to do is refill 
the hot list from the cold list if the hot list was completely empty. 
I could've sworn it used to do that, but no matter ... I think we just 
need to fix up the bit in buffered_rmqueue() here:

     if (pcp->count <= pcp->low)
           pcp->count += rmqueue_bulk(zone, 0, pcp->batch, &pcp->list);

To say something more like:

	if (pcp->count <= pcp->low && !cold)
		<shift some pages from cold to hot>
	if (pcp->count <= pcp->low)		
		pcp->count += rmqueue_bulk(zone, 0, pcp->batch, &pcp->list);
		
Though I'm less than convinced in retrospect that there was any point in
having low watermarks, rather than running it down to zero. Andrew, can
you recall why we did that?

> It's really a question if you believe the cache effects are going to be
> more significant than the cacheline bouncing on the zone lock. 

Exactly. The disadvantage of the single list is that cold allocs can steal 
hot pages, which we believe are precious, and as CPUs get faster, will only 
get more so (insert McKenney's bog roll here).

> I do
> believe the latter is several order of magnitude more severe issue.
> Hence I allow fallbacks both ways (I even allow fallback across the zero
> pages that carry more info than just an hot cache). Mainline doesn't
> allow any fallback at all instead and that's certainly wrong.

Mmmm. Are you actually seeing lock contention on the buddy allocator on
a real benchmark? I haven't seen it since the advent of hot/cold pages.
Remember it's not global at all on the larger systems, since they're NUMA.
 
> all I could see is that it doesn't fallback in 2.6.9, and that's fixed
> with the single list of course ;). Plus I provide hot-cold caching on
> the zero list too (zero list guarantees all pages have PG_zero set, but
> that's the only difference with the hot-cold list). cold info is
> retained in the zero list too so you can freely allocate with __GFP_ZERO
> and __GFP_COLD, or even __GFP_ZERO|__GFP_ONLY_ZERO|__GFP_COLD etc...

Mmmm. I'm still very worried this'll exhaust ZONE_NORMAL on highmem systems,
and keep remote pages around instead of returning them to their home node
on NUMA systems. Not sure that's really what we want, even if we gain a
little in spinlock and immediate cache cost. Nor will it be easy to measure
since it'll only do anything under memory pressure, and the perf there is
notoriously unstable for measurement.

M.
