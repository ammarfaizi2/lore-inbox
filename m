Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbSKOLzl>; Fri, 15 Nov 2002 06:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSKOLzl>; Fri, 15 Nov 2002 06:55:41 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9737 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265402AbSKOLzj>; Fri, 15 Nov 2002 06:55:39 -0500
Date: Fri, 15 Nov 2002 13:02:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
Message-ID: <20021115120233.GC25902@atrey.karlin.mff.cuni.cz>
References: <20021115081044.GI18180@conectiva.com.br> <20021115084915.GS23425@holomorphy.com> <20021115094827.GT23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115094827.GT23425@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The following dropped hunk from Pavel should repair it:
> 
> [cc: list trimmed to spare the uninterested]
> 
> Hmm, there are some oddities here in count_and_copy_data_pages(). It
> looks like the CONFIG_HIGHMEM panic() is there because copy_page() is
> done without kmapping, and the CONFIG_DISCONTIGMEM panic() is there
> because the pgdat list etc. are not walked according to VM
> conventions.

How much memory is needed for HIGHMEM to be neccessary? Is it 1GB? If
so, I can well imagine 1GB laptop....

> So the traversal looks like it should go something like:
> 
> 	for_each_zone(zone) {
> 		for (k = 0; k < zone->present_pages; ++k) {
> 			struct page *page = &zone->zone_mem_map[k];
> 
> 			if (!PageReserved) {
> 				if (PageNosave(page))
> 					continue;
> 
> 				chunk_size = is_head_of_free_region(page);
> 
> 				/* c.f. k++ above */
> 				if (chunk_size) {
> 					k += chunk_size - 1;
> 					continue;
> 				}
> 			} else if (PageReserved(page)) {
> 				BUG_ON(PageNosave(page));
> 
> 				if (page_to_pfn(page) >= nosave_begin_pfn
> 					&& page_to_pfn(page) < nosave_end_pfn)
> 					continue;
> 			}
> 
> 			nr_copy_pages++;
> 
> 			/*
> 			 * The general usage of page backup entries
> 			 * is unclear; this is probably incorrect in
> 			 * some cases, and needs some idea of the size
> 			 * and layout of the page backup entry array(s)
> 			 * if they cannot be contiguously allocated or
> 			 * simultaneously mapped by kernel pagetables.
> 			 */
> 			if (pagedir_p) {
> 				char *src, *dst;
> 				src = kmap_atomic(page, KM_SWSUSP0);
> 				dst = kmap_atomic(pagedir_p->page, KM_SWSUSP1);
> 				copy_page(dst, src);
> 				kunmap_atomic(dst, KM_SWSUSP0);
> 				kunmap_atomic(src, KM_SWSUSP1);
> 				++pagedir_p;

This certainly does not work. We'd need to do some deep magic in
suspend_asm.S to copy pages back. [Well, deep magic... Same
kmap_atomic.] But suspend_asm.S has to guarantee not touching any
memory so the change is not quite trivial.

> I don't know what to make of highmem on laptops etc., but the VM's
> conventions should not be that hard to follow; also, there are uses for
> the swsusp functionality on other kinds of machines (e.g. checkpointing).
> Pure computationally-oriented systems such as would make use of this
> are somewhat different from my primary userbase to support, but I think
> it would be valuable to generalize swsusp in this way, and so provide
> rudimentary support for such users in addition to some small measure of
> cleanup (i.e. the cleanup adds functionality).
> 
> Pavel, what do you think?

I definitely want to support swsusp for server boxes, but I'm not 100%
sure how to do that easily.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
