Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTF0AU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 20:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTF0AU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 20:20:26 -0400
Received: from dsl-213-023-141-206.arcor-ip.net ([213.23.141.206]:5042 "EHLO
	starship") by vger.kernel.org with ESMTP id S263103AbTF0AUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 20:20:22 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [RFC] My research agenda for 2.7
Date: Fri, 27 Jun 2003 02:30:23 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <200306262100.40707.phillips@arcor.de> <Pine.LNX.4.53.0306262030500.5910@skynet>
In-Reply-To: <Pine.LNX.4.53.0306262030500.5910@skynet>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306270222.27727.phillips@arcor.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 June 2003 22:01, Mel Gorman wrote:
> I think that finding pages like this together is unlikely, especially if
> the system has been running a long time. In the worst case you will have
> every easily-moved page adjactent to a near-impossible-to-move page.

Mel,

I addressed that in my previous post: "Most slab pages are hard to move ... we 
could just tell slab to use its own biggish chunks of memory, which it can 
play in as it sees fit".  Another way of putting this is, we isolate the type 
of data that's hard to defrag in its own space, so it can't fragment our 
precious movable space.  That separate space can expand and contract 
chunkwise.

To be sure, this solution means we still can't forcibly create higher order 
units in those undefraggable regions, but that is no worse than the current 
situation.  In the defraggable regions, hopefully the majority of memory, we 
have a much improved situation: we can forcibly create as many high order 
allocation units as we need, in order to handle, e.g., an Ext2/3 filesystem 
that's running with a large blocksize.

> Moving slab pages is probably not an option unless some quick way of
> updating all the pointers to the objects is found.

That was the part in my original post about a "new API".  If we choose to do 
so, we could fix up most kinds of slab objects to support some protocol to 
assist in the effort, or use a data structure better suited to relocation.  I 
doubt it's necessary to go that far.  As far as I can see, slab is not a big 
offender in terms of fragmentation at the moment.

> I also wonder if moving kernel pages is really worth the hassle.

That's the question of course.  The benefit is getting rid of high order 
allocation failures, and gaining some confidence that larger filesystem 
blocksizes will work reliably, however the workload evolves.  The cost is 
some additional complexity, no argument about that.  On the other hand, it 
would no longer be necessary to use voodoo to try to get the allocator to 
magically not fragment.

> It's perfectly possible that defragging only user pages will be enough.

Indeed.  That's an excellent place to start.  We'd include page cache pages in 
that, I'd expect.  Then it would be attractive to go on to handle page table 
pages, and with that we'd have the low-hanging fruit.

> The alternative sounds like it would be scanning mem_map looking for pages
> that can be moved which sounds expensive.

It looks linear to me, and it's not supposed to happen often.  It would 
typically be a response to a nasty situation like you'd get by mounting a 
volume that uses 32K blocks after running a long time with mostly 4K blocks.

> > Without updating pointers, active defragmentation is not possible.  But
> > perhaps you meant to say that active defragmentation is not needed?
>
> I am saying that full defragmentation would be a very expensive operation
> which might not work if it cannot find suitably freeable adjacent pages.

Full defragmentation, whatever that is, would be pointless for the 
applications I've described, though perhaps it could be needed by some 
bizarre application like software hotplug memory.  In the latter case you 
wouldn't be too worried about how long it takes.

In general though, the defragger would only run long enough to restore balance  
to the free counts across the various orders.  In rare cases, it would have 
to run synchronously in order to prevent an allocation from failing.

> If order0 pages were in slab, the whole searching problem becomes trivial
> (just go to the relevant cache and scan the slabs).

You might want to write a separate [rfc] to describe your idea.  For one 
thing, I don't see why you'd want to use slab for that.

Regards,

Daniel
