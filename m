Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVFCNOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVFCNOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 09:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVFCNOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 09:14:23 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:44992 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261250AbVFCNOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 09:14:01 -0400
Date: Fri, 3 Jun 2005 14:13:56 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: "David S. Miller" <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       jschopp@austin.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
In-Reply-To: <358040000.1117777372@[10.10.2.4]>
Message-ID: <Pine.LNX.4.58.0506031408560.10779@skynet>
References: <1117770488.5084.25.camel@npiggin-nld.site><20050602.214927.59657656.davem@davemloft.net><357240000.1117776882@[10.10.2.4]>
 <20050602.223712.41634750.davem@davemloft.net> <358040000.1117777372@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005, Martin J. Bligh wrote:

> > From: "Martin J. Bligh" <mbligh@mbligh.org>
> > Date: Thu, 02 Jun 2005 22:34:42 -0700
> >
> >> One of the calls I got the other day was for loopback interface.
> >> Default MTU is 16K, which seems to screw everything up and do higher
> >> order allocs. Turning it down to under 4K seemed to fix things. I'm
> >> fairly sure loopback doesn't really need phys contig memory, but it
> >> seems to use it at the moment ;-)
> >
> > It helps get better bandwidth to have larger buffers.
> > That's why AF_UNIX tries to use larger orders as well.
>
> Though surely the reality will be that after your system is up for a
> while, and is thorougly fragmented, your latency becomes frigging horrible
> for most allocs though? You risk writing a crapload of pages out to disk
> for every alloc ...
>

That would be interesting to find out. I've it on my TODO list to teach
bench-stresshighalloc to time how long allocations are taking. It'll be at
least a week before I get around to it though.

> > With all these processors using prefetching in their
> > memcpy() implementations, reducing the number of memcpy()
> > calls per byte is getting more and more important.
> > Each memcpy() call makes you hit the memory latency
> > cost since the first prefetch can't be done early
> > enough.
>
> but it's vastly different order of magnitude than touching disk.
> Can we not do a "sniff alloc" first (ie if this is easy, give it
> to me, else just fail and return w/o reclaim), then fall back to
> smaller allocs?

rmqueue_bulk() in the patch does something like this. It tries to allocate
in the largest possible blocks and falls back to the lower orders as
necessary. It could always be trying to reclaim though. I think the only
easy way to fail and return w/o reclaim is to use GFP_ATOMIC which would
have other consequences.

> Though I suspect the reality is that on any real
> system, a order 4 alloc will never actually succeed in any sensible
> amount of time anyway? Perhaps us lot just reboot too often ;-)
>

That is quite possible :) . I'll see about teaching the benchmarks to time
allocations to see how much time we spend satisfying order 4 allocations
on the standard kernel and with the patch.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
