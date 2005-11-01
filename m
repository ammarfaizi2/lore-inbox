Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVKABkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVKABkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 20:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVKABku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 20:40:50 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:62337 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932502AbVKABku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 20:40:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=0C33jSjujyw+9komcp2fAGZeS8CT+6GxgqftKWzsPA9LEqrYdRdp2KVxSg1Gtu0WzrcsxB+rbhGAXIySVHwWQb4Eh45yDGfwc9oFqdySq9Fu/UEMgxO4LK7Xyx1uH2kSpv5EykoJIsyogOkyaQmdiGQGfygKJjdr6XSzUffSBQE=  ;
Message-ID: <4366C7FD.1080602@yahoo.com.au>
Date: Tue, 01 Nov 2005 12:42:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie> <20051031055725.GA3820@w-mikek2.ibm.com> <4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <4365C39F.2080006@yahoo.com.au> <Pine.LNX.4.58.0510311250170.29390@skynet> <4366AE98.7000100@yahoo.com.au> <Pine.LNX.4.58.0511010017170.29390@skynet>
In-Reply-To: <Pine.LNX.4.58.0511010017170.29390@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> On Tue, 1 Nov 2005, Nick Piggin wrote:

> Ok, but the page colours would also need to be in the per-cpu lists this
> new api that supplies vaddrs always takes the spinlock for the free lists.
> I don't believe it would be cheaper and any benefit would only show up on
> benchmarks that are cache sensitive. Judging by previous discussions on
> page colouring in the mail archives, Linus will happily kick the approach
> full of holes.
> 

OK, but I'm just pointing out that improving page colouring doesn't
require contiguous pages.

> As for current performance, the Aim9 benchmarks show that the
> fragmentation avoidance does not have a major performance penalty. A run
> of the patches in the -mm tree should find out if there are performance
> regressions on other machine types.
> 

But I can see that there will be penalties. Cache misses, branches,
etc. Obviously any new feature or more sophisticated behaviour is
going to require that but they obviously need good justification.

>>Just be a different set of GFP flags. Your patches obviously also have
>>some ordering imposed.... pagecache would want HighMemEasy, HighMem,
>>NormalEasy, Normal, DMA; ptes will want HighMem, Normal, DMA.
>>
> 
> 
> As well as a different set of GFP flags, we would also need new zone
> fallback logic which will hit the __alloc_pages() path. It will be adding
> more complexity to the allocator and we're replacing one type of
> complexity with another.
> 

It is complexity that is mostly already handled for us with the zones
logic. Picking out a couple of small points that zones don't get exactly
right isn't a good basis to come up with a completely new zoneing layer.

> 
>>Note that if you do need to make some changes to the zone allocator, then
>>IMO that is far preferable to add a new layer of things-that-are-blocks-of-
>>-memory-but-not-zones, complete with their own balancing and other heuristics.
>>
> 
> 
> Thing is, with my approach, the very worst that happens is that it
> fragments just as bad as the normal allocator. With a zone-based approach,
> the worst that happens is that the kernel zone is too small, kernel caches
> do not grow to a suitable size and overall system performance degrades.
> 

If you don't need to guarantee higher order allocations, then there is
no problem with our current approach. If you do then you simply need to
make a sacrifice.

> 
>>>Problem 2: Setting the zone size will be a very difficult tunable to get
>>>right.  Right off, we are are introducing a tunable which will make
>>>foreheads furrow. If the tunable is set wrong, system performance will
>>>suffer and we could see situations where kernel allocations fail because
>>>it's zone got depleted.
>>>
>>
>>But even so, when you do automatic resizing, you seem to be adding a
>>fundamental weak point in fragmentation avoidance.
>>
> 
> 
> The sizing I do is when a large block is split. Then the region is just
> marked for a particular allocation type. This is very simple. The second
> resizing that occurs is when a kernel allocation "steal" easyrclm pages. I
> do not like the fact that we steal in this fashion but the alternative is
> to teach kswapd how to reclaim easyrclm pages from other areas. I view
> this as "future work" but if it was done, the "steal" mechanism would go
> away.
> 

Weak point, as in: gets fragmented.

> 
>>>Problem 3: To get rid of the tunable, we could try resizing the zones
>>>dynamically but that will be hard. Obviously, the zones are going to be
>>>physically adjacent to each other. To resize the zone, the pages at one
>>>end of the zone will need to be free. Shrinking the NormalEasy zone would
>>>be easy enough, but shrinking the Normal zone with kernel pages in it
>>>would be considerably harder, if not outright impossible. One page in the
>>>wrong place will mean the zone cannot be resized
>>>
>>
>>OK, maybe it is hard ;) Do they really need to be resized, then?
>>
> 
> 
> I think we would need to, yes. If the size of the region is wrong, bad
> things are likely to happen. If the kernel page zone is too small, it'll
> be under pressure even though there is memory available elsewhere. If it's
> too large, then it will get fragmented and high order allocations will
> fail.
> 

But people will just have to get it right then. If they want to be able
to hot unplug 10G of memory, or allocate 4G of hugepages on demand, then
they simply need to specify their requirements. Not too difficult? It is
really nice to be able to place some burden on huge servers and mainframes,
because they have people administering and tuning them full-time. It
allows us to not penalise small servers and desktops.

> 
>>Isn't the big memory hotunplug push aimed at virtual machines and
>>hypervisors anyway? In which case one would presumably have some
>>memory that "must" be reclaimable, in which case we can't expand
>>non-Easy zones into that memory anyway.
>>
> 
> 
> I believe that is the case for hotplug all right, but not the case where
> we just want to satisfy high order allocations in a reasonably reliable
> fashion. In that case, it would be nice to reclaim an easyrclm region.
> 

As I've said before, I think this is a false hope and we need to
move away from higher order allocations.

> It has already been reported by Mike Kravetz that memory remove works a
> whole lot better on PPC64 with this patch than without it. Memory hotplug
> remove was not the problem I was trying to solve, but I consider the fact
> that it is helped to be a big plus. So, even though it is possible that
> this approach still gets fragmented under some workloads, we know that, in
> general, it does a pretty good job.
> 

Sure, but using zones would work too, and on the plus side you would
be able to specify exactly how much removable memory to be.

>>
>>Maybe zones don't do exactly what you need, but I think they're better
>>than you think ;)
>>
> 
> 
> You may be right, but I still think that my approach is simpler and less
> likely to introduce horrible balancing problems.
> 

Simpler? We already have zones though. They are a complexity we need to
deal with already. I really can't see how you can use the simpler argument
in favour of your patches ;)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
