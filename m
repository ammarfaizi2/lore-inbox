Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbTJKNrr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 09:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTJKNrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 09:47:47 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33735
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263314AbTJKNro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 09:47:44 -0400
Date: Sat, 11 Oct 2003 15:48:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Matt_Domsch@Dell.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [PATCH] page->flags corruption fix
Message-ID: <20031011134831.GJ16013@velociraptor.random>
References: <Pine.LNX.4.44.0310081648560.3138-100000@localhost.localdomain> <Pine.LNX.4.44.0310081156320.5568-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310081156320.5568-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 11:59:06AM -0400, Rik van Riel wrote:
> On Wed, 8 Oct 2003, Hugh Dickins wrote:
> > On Wed, 8 Oct 2003 Matt_Domsch@Dell.com wrote:
> 
> > > We've seen a similar failure with the RHEL2.1 kernel w/o RMAP patches
> > > too.  So we fully believe it's possible in stock 2.4.x.
> > 
> > A similar failure - but what exactly?
> > And what is the actual race which would account for it?
> > 
> > I don't mind you and Rik fixing bugs!
> > I'd just like to understand the bug before it's fixed.
> 
> 1) cpu A adds page P to the swap cache, loading page->flags
>    and modifying it locally
> 
> 2) a second thread scans a page table entry and sees that
>    the page was accessed, so cpu B moves page P to the
>    active list
> 
> 3) cpu A undoes the PG_inactive -> PG_active bit change,
>    corrupting the page->flags of P
> 
> The -rmap VM doesn't do anything to this bug, except making
> it easy to trigger due to some side effects.

I believe the more correct fix is to hold the pagemap_lru_lock during
__add_to_page_cache. The race exists between pages with PG_lru set (in
the lru) that are being added to the pagecache/swapcache. Holding both
spinlocks really avoids the race, your patch sounds less obviously safe
(since the race still happens but it's more "controlled") and a single
spinlock should be more efficient than the flood of atomic bitops
anyways. Comments?  Hugh?

I also can't see why you care about the page->flags in __free_pages_ok.
by that time, if the page is still visible anywhere that's a _real_
huge bug, so that second part really looks wrong and it should be backed
out IMHO. For sure at that time the page can't be in any lru list, at
least in my tree, see what the correct code is there, this's the only
way to handle that case right (the in_interrupt() part is needed only if
you've aio like in your tree like in my tree). So your changes in
free_pages are definitely superflous in page_alloc.c, and I guess
they're not closing all the bugs in your tree too (you need the below
too, if you allow anon pages to be freed while in the lru still with
asynchronous io).

The first part of your patch I agree fixes the race, but I'd prefer just
taking one more spinlock to avoid the race at all, instead of trying to
control it with a flood of bitops.

static void __free_pages_ok (struct page *page, unsigned int order)
{
	unsigned long index, page_idx, mask, flags;
	free_area_t *area;
	struct page *base;
	zone_t *zone;
#ifdef CONFIG_SMP
	per_cpu_pages_t *per_cpu_pages;
#endif

	/*
	 * Yes, think what happens when other parts of the kernel take 
	 * a reference to a page in order to pin it for io. -ben
	 */
	if (PageLRU(page)) {
		if (unlikely(in_interrupt())) {
			unsigned long flags;

			spin_lock_irqsave(&free_pages_ok_no_irq_lock, flags);

			page->next_hash = free_pages_ok_no_irq_head;
			free_pages_ok_no_irq_head = page;
			page->index = order;

			spin_unlock_irqrestore(&free_pages_ok_no_irq_lock, flags);

			schedule_task(&free_pages_ok_no_irq_task);
			return;
		}
		lru_cache_del(page);
	}
[..]

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
