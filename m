Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTFYJPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 05:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTFYJPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 05:15:51 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:33411 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262464AbTFYJPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 05:15:49 -0400
Date: Wed, 25 Jun 2003 10:29:58 +0100
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] My research agenda for 2.7
Message-ID: <20030625092938.GA13771@skynet.ie>
References: <200306250111.01498.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306250111.01498.phillips@arcor.de>
User-Agent: Mutt/1.3.28i
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) Active memory defragmentation
> 
> I doubt anyone will deny that this is desirable.  Active defragmentation will 
> eliminate higher order allocation failures for non-atomic allocations, and I 
> hope, generally improve the efficiency and transparency of the kernel memory 
> allocator.
> 

It might be just me, but this scheme sounds a bit complicated (I'm still
absorbing the other two). I find it difficult to see what happens when a
page used by a kernel pointer changes for any case other than vmalloc()
but I probably am missing something.

How about: Move order-0 allocations to slab (ignoring bootstrap issues for 
now but shouldn't be hard anyway)

Each cache slab is 2^MAX_GFP_ORDER large and there is three caches
  o order0-user
  o order0-kreclaim
  o order0-knoreclaim

order0-user is for any userspace allocation. These pages should be
trivially reclaimable with rmap available. If a large order block is
necessary, select one slab and reclaim it. This will break LRU ordering
something rotten but I am guessing that LRU ordering is not the prime
concern here. If a defrag daemon exists, scan MAX_DEFRAG_SCAN slabs and 
pick the one with the most clean filesystem backed pages to chuck out 
(least IO involved in reclaim).

order0-kreclaim is for kernel allocations which are trivially reclaimable
and that can be safely discared knowing that no pointer exists to them.  
This is most likely to be usable for slab allocations of caches like
dentry's which can be safely thrown out. A quick look of /proc/slabinfo
shows that most slabs are just 1 page large. Slabs already have a
set_shrinker() callback for the removal of objects so it is likely that
this could be extended for telling caches to clear all objects and discard
a particular slab.

order0-knoreclaim is for kernel allocations which cannot be easily 
reclaimed and have pointers to the allocation which are difficult to 
reclaim. For all intents and purposes, these are not reclaimable without 
impementing swapping in kernel space.

This has a couple of things going for it

o Reclaimable pages are in easy to search globs
o Gets nifty per-cpu alloc and caching that comes with slab automatically
o Freeing high order pages is a case of discarding pages in one slab
o Doesn't require fancy pants updating of pointers or page tables
o Possible ditch the mempool interface as slab already has similar functionality
o Seems simple

Opinions?

-- 
Mel Gorman
