Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbUCOSvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbUCOSvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:51:14 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15633
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262662AbUCOSvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:51:07 -0500
Date: Mon, 15 Mar 2004 19:51:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: piggin@cyberone.com.au, riel@redhat.com, marcelo.tosatti@cyclades.com,
       j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
Message-ID: <20040315185147.GH30940@dualathlon.random>
References: <Pine.LNX.4.44.0403150822040.12895-100000@chimarrao.boston.redhat.com> <4055BF90.5030806@cyberone.com.au> <20040315145020.GC30940@dualathlon.random> <20040315103510.25c955a3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315103510.25c955a3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 10:35:10AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > On Tue, Mar 16, 2004 at 01:37:04AM +1100, Nick Piggin wrote:
> > > This case I think is well worth the unfairness it causes, because it
> > > means your zone's pages can be freed quickly and without freeing pages
> > > from other zones.
> > 
> > freeing pages from other zones is perfectly fine, the classzone design
> > gets it right, you have to free memory from the other zones too or you
> > have no way to work on a 1G machine. you call the thing "unfair" when it
> > has nothing to do with fariness, your unfariness is the slowdown I
> > pointed out,
> 
> This "slowdown" is purely theoretical and has never been demonstrated.

on a 32G box the slowdown is zero, as it's zero on a 1G box too, you
definitely need a 2G box to measure it.

The effect is that you can do stuff like 'cvs up' and you will end up
caching just 1G instead of 2G. Or do I miss something? If I would own a
2G box I would hate to be able to cache just 1 G (yeah, the cache is 2G
but half of that cache is pinned and it sits there with years old data,
so effectively you lose 50% of the ram in the box in terms of cache
utilization).

> One could just as easily point at the fact that on a 32GB machine with a
> single LRU we have to send 64 highmem pages to the wrong end of the LRU for
> each scanned lowmem page, thus utterly destroying any concept of it being
> an LRU in the first place.  But this is also theoretical, and has never
> been demonstrated and is thus uninteresting.

the lowmem zone on a 32G box is completely reserved for zone-normal
allocation, and dcache shrinks aren't too frequent in some workload, but
you're certainly right that on a 32G box per-zone lru is optimal in
terms of cpu utilization (on 64bit either ways doesn't make any
difference, the GFP_DMA allocations are so seldom that throwing a bit of
cpu at those seldom allocation is fine).

> 
> Worked out why my box is going into a 3-5 minute coma with one test.
> Think what the LRUs look like when the test first hits page reclaim
> on this 2.5G ia32 box:
> 
>                head                           tail
> active_list:   <800M of ZONE_NORMAL> <200M of ZONE_HIGHMEM>
> inactive_list:          <1.5G of ZONE_HIGHMEM>
> 
> now, somebody does a GFP_KERNEL allocation.
> 
> uh-oh.
> 
> VM calls refill_inactive.  That moves 25 ZONE_HIGHMEM pages onto
> the inactive list.  It then scans 5000 pages, achieving nothing.

I fixed this in my tree a long time ago, you certainly don't need
per-zone lru to fix this (though for a 32G box the per-zone lru doesn't
only fix it, it also save lots of cpu too compared to the global lru).
See the refill_inactive code in my tree:

static void refill_inactive(int nr_pages, zone_t * classzone)
{
	struct list_head * entry;
	unsigned long ratio;

	ratio = (unsigned long) nr_pages * classzone->nr_active_pages /
(((unsigned long) classzone->nr_inactive_pages * vm_lru_balance_ratio) +
1);

	entry = active_list.prev;
	while (ratio && entry != &active_list) {
		struct page * page;
		int related_metadata = 0;

		page = list_entry(entry, struct page, lru);
		entry = entry->prev;

		if (!memclass(page_zone(page), classzone)) {
			/*
			 * Hack to address an issue found by Rik. The
			 * problem is that
			 * highmem pages can hold buffer headers
			 * allocated
			 * from the slab on lowmem, and so if we are
			 * working
			 * on the NORMAL classzone here, it is correct
			 * not to
			 * try to free the highmem pages themself (that
			 * would be useless)
			 * but we must make sure to drop any lowmem
			 * metadata related to those
			 * highmem pages.
			 */
			if (page->buffers && page->mapping) { /* fast path racy check */
				if (unlikely(TryLockPage(page)))
					continue;
				if (page->buffers && page->mapping && memclass_related_bhs(page, classzone)) /* non racy check */
					related_metadata = 1;
				UnlockPage(page);
			}
			if (!related_metadata)
				continue;
		}

		if (PageTestandClearReferenced(page)) {
			list_del(&page->lru);
			list_add(&page->lru, &active_list);
			continue;
		}

		if (!related_metadata)
			ratio--;

		del_page_from_active_list(page);
		add_page_to_inactive_list(page);
		SetPageReferenced(page);
	}
	if (entry != &active_list) {
		list_del(&active_list);
		list_add(&active_list, entry);
	}
}


the memclass checks guarantees that we make progress. the old vm code
(that you inherit in 2.5) missed those bits I believe.

without those fixes the 2.4 vm wouldn't perform on 32G (as you also
found during 2.5).
