Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTFZTrq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 15:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTFZTrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 15:47:46 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:32755 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S263354AbTFZTrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 15:47:31 -0400
Date: Thu, 26 Jun 2003 21:01:43 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] My research agenda for 2.7
In-Reply-To: <200306262100.40707.phillips@arcor.de>
Message-ID: <Pine.LNX.4.53.0306262030500.5910@skynet>
References: <200306250111.01498.phillips@arcor.de> <20030625092938.GA13771@skynet.ie>
 <200306262100.40707.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jun 2003, Daniel Phillips wrote:

>   * Most process pages are easily movable, since usually only page tables
>     will hold references.
>
>   * Most page cache pages are easily movable, likewise
>
>   * Similarly, page table pages are not too hard to move
>

I think that finding pages like this together is unlikely, especially if
the system has been running a long time. In the worst case you will have
every easily-moved page adjactent to a near-impossible-to-move page. The
buddy allocator could be taught to be selective of which freelists it used
for different types of allocation but that doesn't sound any easier than
moving order0 pages to slab.

There also would be trouble identifing adjactent pages of order 0 which
are are used for these particular task. Buddy allocators, including the
one implemented in Linux, do not record what order allocation a struct
page belongs to. I could be wrong but it just feels like it would be a lot
of work to free up just a few adjacent pages.

Tentatively, I would assert that being able to group these types of pages
together is a pre-requestive for effective defragging and I think moving
order-0 pages to slab would enforce this grouping. For example, the defrag
daemon could scan just order0-user slabs and move pages from sparsly
populated slabs to other fuller slabs and free slabs as it goes.

In other words, order0 caches are not a mutually exclusive goal to
defragging but I bet you a shiny penny it'd make the implementation a lot
easier.

> Most slab pages are hard to move.  We could try to fix that for certain
> common object types, or we could just tell slab to use its own biggish
> chunks of memory, which it can play in as it sees fit.
>

Moving slab pages is probably not an option unless some quick way of
updating all the pointers to the objects is found. I would say the only
slab pages that are "movable" belong to caches which can quickly discard
their objects.

> > I find it difficult to see what happens when a
> > page used by a kernel pointer changes for any case other than vmalloc()
> > but I probably am missing something.
>
> The point you apparently missed is that the defragger will identify and
> update those kernel pointers, being careful about races of course.
>

I didn't miss it as such, but I don't see how it could be implemented
either. I also wonder if moving kernel pages is really worth the hassle.
It's perfectly possible that defragging only user pages will be enough.
The only way to be sure would be to walk all struct pages in the mem_map
and see what the layout looks like.

> > How about: Move order-0 allocations to slab (ignoring bootstrap issues for
> > now but shouldn't be hard anyway)
>
> That sounds like radical surgery to me, but to each his own experiments.
>

I don't think it would be too radical because the buddy allocator would
still remain the principal page allocator. What would be a bitch is the
additional storage requirements required for such a large number of slabs
needed to contain pages. At the very least, the slab allocator would need
a means of discarding the slab descriptors for full slabs and maintaining
just pointers to the first page of each full slab. A comparison of page
allocation from buddy and page allocation from slab would also be
necessary to make sure the page allocation performance wasn't butchered.

> Defragmentation by selective eviction is possible, but isn't necessarily
> optimal.  In the case of memory that isn't swap or file-backed, it isn't even
> possible.  On the other hand, you may think of the page move case as simply
> an optimized evict-and-reload, if that helps understand where I'm going.
>

Well, take this this case

1) Slabs can contain 10 order0 pages
2) Defragger finds two slabs; slabA with 2 pages and slabB with 5
3) Defragger copies 2 pages from slabA to slabB and users rmap to update
   page tables

The alternative sounds like it would be scanning mem_map looking for pages
that can be moved which sounds expensive. With order0 in slab, you can
easily find blocks of pages which when moved immeditaly free up a large
adjacent block.

> > o Reclaimable pages are in easy to search globs
> > o Gets nifty per-cpu alloc and caching that comes with slab automatically
> > o Freeing high order pages is a case of discarding pages in one slab
> > o Doesn't require fancy pants updating of pointers or page tables
>
> Without updating pointers, active defragmentation is not possible.  But
> perhaps you meant to say that active defragmentation is not needed?
>

I am saying that full defragmentation would be a very expensive operation
which might not work if it cannot find suitably freeable adjacent pages.
If order0 pages were in slab, the whole searching problem becomes trivial
(just go to the relevant cache and scan the slabs).

> > o Possible ditch the mempool interface as slab already has similar
> > functionality
> > o Seems simple
> >
> > Opinions?
>
> Yes :-)
>

heh.

-- 
Mel Gorman
