Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVJaXwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVJaXwm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVJaXwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:52:41 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:59795 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964875AbVJaXwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:52:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Fii2dwz7cnFkzaD6bGTOTRpPTV60Hyhm7SOX4LxotqgBdQaK977hk5gK1AasmZoVJ7DsySadEx32vgs8rKj8cA45CeGAq4kU7OqBEj/npMLiaIjysbFZeRWIjCN8BpC5MKwPmzEYa2cz4c80hnKLHlIzT2sel8bIlnfhw7nA5AQ=  ;
Message-ID: <4366AE98.7000100@yahoo.com.au>
Date: Tue, 01 Nov 2005 10:54:00 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie> <20051031055725.GA3820@w-mikek2.ibm.com> <4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <4365C39F.2080006@yahoo.com.au> <Pine.LNX.4.58.0510311250170.29390@skynet>
In-Reply-To: <Pine.LNX.4.58.0510311250170.29390@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:

> I recall Rohit's patch from an earlier -mm. Without knowing anything about
> his test, I am guessing he is getting cheap page colouring by preloading
> the per-cpu cache with contiguous pages and his workload is faulting in
> the batch of pages immediately by doing something like linearly reading a
> large array. Hence, the mappings of his workload are getting the right
> colour pages. This makes his workload a "lucky"  workload. The general
> benefit of preloading the percpu magazines is that there is a chance the
> allocator only has to be called once, not pcp->batch times.
> 

Or we could introduce a new allocation mechanism for anon pages that
passes the vaddr to the allocator, and tries to get an odd/even page
according to the vaddr.

> An odd/even allocation scheme could be provided by having two free_lists
> in a free_area. One list for the "left buddy" and the other list for the
> "right buddy". However, at best, that would provide two colours. I'm not
> sure how much benefit it would give for the cost of more linked lists.
> 

2 colours should be a good first order improvement because you will
no longer have adjacent pages of the same colour.

It would definitely be cheaper than fragmentation avoidance + higher
order batch loading.


> To replicate the functionality of these patches with zones would require
> two additional zones for NormalEasy and HighmemEasy (I suck at naming
> things).  The plus side is that once the zone fallback lists are updated,
> the page allocator remains more or less the same as it is today. Then the
> headaches start.
> 
> Problem 1: Zone fallback lists are "one-way" and per-node. Lets assume a
> fallback list of HighMemEasy, HighMem, NormalEasy, Normal, DMA. Assuming
> we are allocating PTEs from high memory, we could fallback to the Normal
> zone even if highmem pages are available because the HighMem zone was out
> of pages. It will require very different fallback logic to say that
> HighMem allocations can also use HighMemEasy rather than falling back to
> Normal.
> 

Just be a different set of GFP flags. Your patches obviously also have
some ordering imposed.... pagecache would want HighMemEasy, HighMem,
NormalEasy, Normal, DMA; ptes will want HighMem, Normal, DMA.

Note that if you do need to make some changes to the zone allocator, then
IMO that is far preferable to add a new layer of things-that-are-blocks-of-
-memory-but-not-zones, complete with their own balancing and other heuristics.

> Problem 2: Setting the zone size will be a very difficult tunable to get
> right.  Right off, we are are introducing a tunable which will make
> foreheads furrow. If the tunable is set wrong, system performance will
> suffer and we could see situations where kernel allocations fail because
> it's zone got depleted.
> 

But even so, when you do automatic resizing, you seem to be adding a
fundamental weak point in fragmentation avoidance.

> Problem 3: To get rid of the tunable, we could try resizing the zones
> dynamically but that will be hard. Obviously, the zones are going to be
> physically adjacent to each other. To resize the zone, the pages at one
> end of the zone will need to be free. Shrinking the NormalEasy zone would
> be easy enough, but shrinking the Normal zone with kernel pages in it
> would be considerably harder, if not outright impossible. One page in the
> wrong place will mean the zone cannot be resized
> 

OK, maybe it is hard ;) Do they really need to be resized, then?

Isn't the big memory hotunplug push aimed at virtual machines and
hypervisors anyway? In which case one would presumably have some
memory that "must" be reclaimable, in which case we can't expand
non-Easy zones into that memory anyway.

> Problem 4: Page reclaim would have two new zones to deal with bringing
> with it a new set of zone balancing problems. That brings it's own special
> brand of fun.
> 
> There may be more problems but these 4 are fairly important. This patchset
> does not suffer from the same problems.
> 

If page reclaim can't deal with 5 zones then it is going to have problems
somewhere at 3 and needs to be fixed. I don't see how your patches get
around this fun by simply introducing their own balancing and fallback
heuristics.

> Problem 1: This patchset has a fallback list for each allocation type. So
> EasyRclm allocations can just as easily use an area reserved for kernel
> allocations and vice versa. Obviously we don't like when this happens, but
> when it does, things start fragmenting rather than breaking.
> 
> Problem 2: The number of pages that get reserved for each type grows and
> shrinks on demand. There is no tunable and no need for one.
> 
> Problem 3: Problem doesn't exist for this patchset
> 
> Problem 4: Problem doesn't exist for this patchset.
> 
> Bottom line, using zones will be more complex than this set of patches and
> bring a lot of tricky issues with it.
> 

Maybe zones don't do exactly what you need, but I think they're better
than you think ;)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
