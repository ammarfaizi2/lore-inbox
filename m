Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbUKBVF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUKBVF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUKBVF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:05:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:37066 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261505AbUKBVFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:05:32 -0500
Date: Tue, 2 Nov 2004 13:09:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: andrea@novell.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-Id: <20041102130910.3e779d32.akpm@osdl.org>
In-Reply-To: <11900000.1099410137@[10.10.2.4]>
References: <20041030141059.GA16861@dualathlon.random>
	<418671AA.6020307@yahoo.com.au>
	<161650000.1099332236@flay>
	<20041101223419.GG3571@dualathlon.random>
	<20041102022122.GJ3571@dualathlon.random>
	<11900000.1099410137@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > The idea that the quicklist is meant to take the lock once every X pages
> > is limiting. The object is to never ever have to enter the buddy, not
> > just to "buffer" allocations. 
> 
> That'd be nicer, yes.
> 
> > The two separated cold/hot lists prevents that. As far as there's a single 
> > page available we should use it since bouncing the cacheline is very costly.
> 
> Well, it doesn't really prevent it ... it used to work, I think. However, 
> the current code appears to be broken - what it's meant to do is refill 
> the hot list from the cold list if the hot list was completely empty. 
> I could've sworn it used to do that, but no matter

We discussed it, but iirc we worked out that it wouldn't have any useful
effect on the frequency at which we take the buddy lock.

It adds more code and it adds special knowledge of hotness and coldness to
the core page allocator.  The intention was that the argument called `cold'
could be renamed to `pcp_index' or whatever so that we could add more head
arrays in the future.  For known-to-be-zero pages.

> ... I think we just 
> need to fix up the bit in buffered_rmqueue() here:
> 
>      if (pcp->count <= pcp->low)
>            pcp->count += rmqueue_bulk(zone, 0, pcp->batch, &pcp->list);
> 
> To say something more like:
> 
> 	if (pcp->count <= pcp->low && !cold)
> 		<shift some pages from cold to hot>
> 	if (pcp->count <= pcp->low)		
> 		pcp->count += rmqueue_bulk(zone, 0, pcp->batch, &pcp->list);
> 		
> Though I'm less than convinced in retrospect that there was any point in
> having low watermarks, rather than running it down to zero. Andrew, can
> you recall why we did that?

Nope.

> > It's really a question if you believe the cache effects are going to be
> > more significant than the cacheline bouncing on the zone lock. 
> 
> Exactly. The disadvantage of the single list is that cold allocs can steal 
> hot pages, which we believe are precious, and as CPUs get faster, will only 
> get more so (insert McKenney's bog roll here).

The cold pages are mainly intended to be the pages which will be placed
under DMA transfers.  We should never return hot pages in response for a
request for a cold page.
