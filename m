Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTFZSpz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 14:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTFZSpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 14:45:55 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:28327 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262316AbTFZSpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 14:45:33 -0400
From: Daniel Phillips <phillips@arcor.de>
To: mel@csn.ul.ie (Mel Gorman)
Subject: Re: [RFC] My research agenda for 2.7
Date: Thu, 26 Jun 2003 21:00:40 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <20030625092938.GA13771@skynet.ie>
In-Reply-To: <20030625092938.GA13771@skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306262100.40707.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 June 2003 11:29, Mel Gorman wrote:
> > 1) Active memory defragmentation
> >
> > I doubt anyone will deny that this is desirable.  Active defragmentation
> > will eliminate higher order allocation failures for non-atomic
> > allocations, and I hope, generally improve the efficiency and
> > transparency of the kernel memory allocator.
>
> It might be just me, but this scheme sounds a bit complicated (I'm still
> absorbing the other two).

Mel,

I probably spent too much time dwelling on the hard cases of page moving, and 
didn't sufficiently emphasize that handling a few easy cases would do a 
pretty good job, certainly better than we do now.  For example:

  * Most process pages are easily movable, since usually only page tables
    will hold references.

  * Most page cache pages are easily movable, likewise

  * Similarly, page table pages are not too hard to move 

Most slab pages are hard to move.  We could try to fix that for certain common 
object types, or we could just tell slab to use its own biggish chunks of 
memory, which it can play in as it sees fit.

> I find it difficult to see what happens when a
> page used by a kernel pointer changes for any case other than vmalloc()
> but I probably am missing something.

The point you apparently missed is that the defragger will identify and update 
those kernel pointers, being careful about races of course.

> How about: Move order-0 allocations to slab (ignoring bootstrap issues for
> now but shouldn't be hard anyway)

That sounds like radical surgery to me, but to each his own experiments.

> Each cache slab is 2^MAX_GFP_ORDER large and there is three caches
>   o order0-user
>   o order0-kreclaim
>   o order0-knoreclaim
>
> order0-user is for any userspace allocation. These pages should be
> trivially reclaimable with rmap available. If a large order block is
> necessary, select one slab and reclaim it. This will break LRU ordering
> something rotten but I am guessing that LRU ordering is not the prime
> concern here. If a defrag daemon exists, scan MAX_DEFRAG_SCAN slabs and
> pick the one with the most clean filesystem backed pages to chuck out
> (least IO involved in reclaim).

Defragmentation by selective eviction is possible, but isn't necessarily 
optimal.  In the case of memory that isn't swap or file-backed, it isn't even 
possible.  On the other hand, you may think of the page move case as simply 
an optimized evict-and-reload, if that helps understand where I'm going.

Regardless, it would be good to teach vmscan to evict pages that will help 
build higher order allocation units, when these are in short supply.  This 
would be an optimization heuristic; it would still necessary to handle the 
general case of data moving in order to make any guarantee re fragmentation 
control.

> order0-kreclaim is for kernel allocations which are trivially reclaimable
> and that can be safely discared knowing that no pointer exists to them.
> This is most likely to be usable for slab allocations of caches like
> dentry's which can be safely thrown out. A quick look of /proc/slabinfo
> shows that most slabs are just 1 page large. Slabs already have a
> set_shrinker() callback for the removal of objects so it is likely that
> this could be extended for telling caches to clear all objects and discard
> a particular slab.
>
> order0-knoreclaim is for kernel allocations which cannot be easily
> reclaimed and have pointers to the allocation which are difficult to
> reclaim. For all intents and purposes, these are not reclaimable without
> impementing swapping in kernel space.
>
> This has a couple of things going for it
>
> o Reclaimable pages are in easy to search globs
> o Gets nifty per-cpu alloc and caching that comes with slab automatically
> o Freeing high order pages is a case of discarding pages in one slab
> o Doesn't require fancy pants updating of pointers or page tables

Without updating pointers, active defragmentation is not possible.  But 
perhaps you meant to say that active defragmentation is not needed?

> o Possible ditch the mempool interface as slab already has similar
> functionality
> o Seems simple
>
> Opinions?

Yes :-)

Regards,

Daniel

