Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281987AbRKZSGB>; Mon, 26 Nov 2001 13:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281961AbRKZSFx>; Mon, 26 Nov 2001 13:05:53 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44000 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S281988AbRKZSFt>;
	Mon, 26 Nov 2001 13:05:49 -0500
Date: Mon, 26 Nov 2001 21:03:30 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <9ttu6f$9ve$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0111262049460.16410-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Nov 2001, Linus Torvalds wrote:

> Tree's _do_ have advantages over hashes, though, in having both better
> cache locality and better locking locality.
>
> I don't think a binary tree (even if it is self-balancing) is the
> proper format, though.  Binary trees have bad cache characteristics,
> and as Ingo points out, with large files (and many
> performance-critical things like databases have _huge_ files) you get
> bad behaviour on lookup with a binary tree.
>
> A indexed tree (like the page tables) has much better characteristics,
> and can be looked up in O(1), and might be worth looking into. The
> locality of a indexed tree means that it's MUCH easier to efficiently
> fill in (or get rid of) large contiguous chunks of page cache than it
> is with hashes. This can be especially useful for doing swapping,
> where you don't have to look up adjacent pages - they're right there,
> adjacent to your entry.

i think the pagecache's data structures should be driven by cached access,
not by things like the cache footprint of swapping. In most systems, the
percentage of cached accessed is at least 90%, with 10% of pagecache
accesses being uncached. (i've run a number of pagecache profiles under
various large system and small system workloads.) I agree that if we can
get a data structure that is O(1) and has 2-cachelines footprint, then
other factors (such as integration with other parts of the VM) could
weight against the hash table.

but i dont think lookups can get any better than the current hash solution
- in high performance environments, by far the biggest overhead are
cachemisses and SMP-synchronization costs. Compressing the cache footprint
and spreading out the locking is the highest priority IMO.

right now the hash creates pretty good locality of reference: two pages
that are close to each other in the logical file space are close to each
other in the hash space as well. This is why scanning pages in the logical
space isnt all that bad cache-footprint-wise, i think. We do take/drop a
spinlock per scan, instead of just going on entry forward in the indexed
tree solution, but this is not a significant overhead, given that the hash
has locality of reference as well.

If we can get better cache footprint than this with indexed trees (which i
think are closer to hashes than trees) then i'm all for it, but i cannot
see where the win comes from (even assuming statistically linear access to
the pagecache space, which is not true for a number of important
workloads).

	Ingo

