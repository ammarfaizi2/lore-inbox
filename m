Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSKOJoN>; Fri, 15 Nov 2002 04:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbSKOJoN>; Fri, 15 Nov 2002 04:44:13 -0500
Received: from holomorphy.com ([66.224.33.161]:4046 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261645AbSKOJoI>;
	Fri, 15 Nov 2002 04:44:08 -0500
Date: Fri, 15 Nov 2002 01:48:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: pavel@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
Message-ID: <20021115094827.GT23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, pavel@suse.cz,
	linux-kernel@vger.kernel.org
References: <20021115081044.GI18180@conectiva.com.br> <20021115084915.GS23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115084915.GS23425@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 12:49:15AM -0800, William Lee Irwin III wrote:
> The following dropped hunk from Pavel should repair it:

[cc: list trimmed to spare the uninterested]

Hmm, there are some oddities here in count_and_copy_data_pages(). It
looks like the CONFIG_HIGHMEM panic() is there because copy_page() is
done without kmapping, and the CONFIG_DISCONTIGMEM panic() is there
because the pgdat list etc. are not walked according to VM conventions.

So the traversal looks like it should go something like:

	for_each_zone(zone) {
		for (k = 0; k < zone->present_pages; ++k) {
			struct page *page = &zone->zone_mem_map[k];

			if (!PageReserved) {
				if (PageNosave(page))
					continue;

				chunk_size = is_head_of_free_region(page);

				/* c.f. k++ above */
				if (chunk_size) {
					k += chunk_size - 1;
					continue;
				}
			} else if (PageReserved(page)) {
				BUG_ON(PageNosave(page));

				if (page_to_pfn(page) >= nosave_begin_pfn
					&& page_to_pfn(page) < nosave_end_pfn)
					continue;
			}

			nr_copy_pages++;

			/*
			 * The general usage of page backup entries
			 * is unclear; this is probably incorrect in
			 * some cases, and needs some idea of the size
			 * and layout of the page backup entry array(s)
			 * if they cannot be contiguously allocated or
			 * simultaneously mapped by kernel pagetables.
			 */
			if (pagedir_p) {
				char *src, *dst;
				src = kmap_atomic(page, KM_SWSUSP0);
				dst = kmap_atomic(pagedir_p->page, KM_SWSUSP1);
				copy_page(dst, src);
				kunmap_atomic(dst, KM_SWSUSP0);
				kunmap_atomic(src, KM_SWSUSP1);
				++pagedir_p;
			}
		}
		return nr_copy_pages;
	}

I don't know what to make of highmem on laptops etc., but the VM's
conventions should not be that hard to follow; also, there are uses for
the swsusp functionality on other kinds of machines (e.g. checkpointing).
Pure computationally-oriented systems such as would make use of this
are somewhat different from my primary userbase to support, but I think
it would be valuable to generalize swsusp in this way, and so provide
rudimentary support for such users in addition to some small measure of
cleanup (i.e. the cleanup adds functionality).

Pavel, what do you think?


Bill
