Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWEENzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWEENzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 09:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWEENzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 09:55:15 -0400
Received: from mailhub.hp.com ([192.151.27.10]:65225 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S1751117AbWEENzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 09:55:13 -0400
From: "Bob Picco" <bob.picco@hp.com>
Date: Fri, 5 May 2006 09:55:03 -0400
To: Andy Whitcroft <apw@shadowen.org>
Cc: Bob Picco <bob.picco@hp.com>, Ingo Molnar <mingo@elte.hu>,
       Dave Hansen <haveblue@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060505135503.GA5708@localhost>
References: <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de> <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au> <20060504013239.GG19859@localhost> <1146756066.22503.17.camel@localhost.localdomain> <20060504154652.GA4530@localhost> <20060504192528.GA26759@elte.hu> <20060504194334.GH19859@localhost> <445A7725.8030401@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445A7725.8030401@shadowen.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Wihitcroft wrote:	[Thu May 04 2006, 05:50:29PM EDT]
> Bob Picco wrote:
> > Ingo Molnar wrote:	[Thu May 04 2006, 03:25:28PM EDT]
> > 
> >>* Bob Picco <bob.picco@hp.com> wrote:
> >>
> >>
> >>>Dave Hansen wrote:	[Thu May 04 2006, 11:21:06AM EDT]
> >>>
> >>>>I haven't thought through it completely, but these two lines worry me:
> >>>>
> >>>>
> >>>>>+ start = pgdat->node_start_pfn & ~((1 << (MAX_ORDER - 1)) - 1);
> >>>>>+ end = start + pgdat->node_spanned_pages;
> >>>>
> >>>>Should the "end" be based off of the original "start", or the aligned
> >>>>"start"?
> >>>
> >>>Yes. I failed to quilt refresh before sending. You mean end should be 
> >>>end = pgdat->node_start_pfn + pgdat->node_spanned_pages before 
> >>>rounding up.
> >>
> >>do you have an updated patch i should try?
> >>
> >>	Ingo
> > 
> > You can try this but don't believe it will change your outcome. I've
> > booted this on ia64 with slight modification to eliminate
> > VIRTUAL_MEM_MAP and have only DISCONTIGMEM. Your case is failing at the
> > front edge of of the zone and not the ending edge which had a flaw in my
> > first post of the patch. I would have expected the first patch to handle
> > the front edge correctly.
> > 
> > I don't remember seeing your .config in the thread (or blind and unable
> > to see it). Would you please send it my way.
> > 
> > I'm also hoping Andy has time to look into this.
> > 
> > bob
> 
> Yeah will have a look tommorrow my time.  Could you drop me the .config
> too.  There is definatly some unstated requirements on alignment, which
> I was testing today.  I presume its one of those thats being violated.
> 
> -apw
I think the problem was my not looking closely at the full email thread. 
I finally found time to read entire thread (found Ingo's config and boot logs). The patch below should fix Ingo's problem.  It's probably only required for 
ZONE_HIGHMEM.  To be safe, I think we should apply it generically. 

Not only must node_mem_map array be MAX_ORDER aligned but the the distance 
between interior zones covered by node_mem_map must satisfy this alignment. 
While in the buddy allocator before checking for a valid buddy the buddy page 
must reside in the parent's zone too. ZONE_HIGHMEM doesn't satisfy the zone 
alignment condition and requires this new check that the parent's buddy and 
parent are within by the same zone.

The other possible solution is aligning HIGHMEM zone to satisfy MAX_ORDER.
This I didn't pursue and possibly is what Andy refers to above.

Adding a printk for the line with the zonenum mismatch condition caught two
instances in boot up on my x86 which was configured similarly to Ingo's config.

bob

Index: linux-2.6.17-rc3/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc3.orig/mm/page_alloc.c	2006-04-27 09:44:02.000000000 -0400
+++ linux-2.6.17-rc3/mm/page_alloc.c	2006-05-05 07:42:40.000000000 -0400
@@ -280,6 +280,15 @@ __find_combined_index(unsigned long page
 	return (page_idx & ~(1 << order));
 }
 
+static inline int page_in_zone_hole(struct page *page)
+{
+#ifdef CONFIG_HOLES_IN_ZONE
+	if (!pfn_valid(page_to_pfn(page)))
+		return 1;
+#endif
+	return 0;
+}
+
 /*
  * This function checks whether a page is free && is the buddy
  * we can do coalesce a page and its buddy if
@@ -294,11 +303,6 @@ __find_combined_index(unsigned long page
  */
 static inline int page_is_buddy(struct page *page, int order)
 {
-#ifdef CONFIG_HOLES_IN_ZONE
-	if (!pfn_valid(page_to_pfn(page)))
-		return 0;
-#endif
-
 	if (PageBuddy(page) && page_order(page) == order) {
 		BUG_ON(page_count(page) != 0);
 		return 1;
@@ -351,7 +355,11 @@ static inline void __free_one_page(struc
 		struct page *buddy;
 
 		buddy = __page_find_buddy(page, page_idx, order);
-		if (!page_is_buddy(buddy, order))
+		if (page_in_zone_hole(buddy))
+			break;
+		else if (page_zonenum(buddy) != page_zonenum(page))
+			break;
+		else if (!page_is_buddy(buddy, order))
 			break;		/* Move the buddy up one level. */
 
 		list_del(&buddy->lru);
@@ -2123,14 +2131,22 @@ static void __init alloc_node_mem_map(st
 #ifdef CONFIG_FLAT_NODE_MEM_MAP
 	/* ia64 gets its own node_mem_map, before this, without bootmem */
 	if (!pgdat->node_mem_map) {
-		unsigned long size;
+		unsigned long size, start, end;
 		struct page *map;
 
-		size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
+		/*
+		 * The zone's endpoints aren't required to be MAX_ORDER
+		 * aligned but the node_mem_map endpoints must be in order
+		 * for the buddy allocator to function correctly.
+		 */
+		start = pgdat->node_start_pfn & ~(MAX_ORDER_NR_PAGES - 1);
+		end = pgdat->node_start_pfn + pgdat->node_spanned_pages;
+		end = ALIGN(end, MAX_ORDER_NR_PAGES);
+		size =  (end - start) * sizeof(struct page);
 		map = alloc_remap(pgdat->node_id, size);
 		if (!map)
 			map = alloc_bootmem_node(pgdat, size);
-		pgdat->node_mem_map = map;
+		pgdat->node_mem_map = map + (pgdat->node_start_pfn - start);
 	}
 #ifdef CONFIG_FLATMEM
 	/*
Index: linux-2.6.17-rc3/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc3.orig/include/linux/mmzone.h	2006-04-27 09:44:02.000000000 -0400
+++ linux-2.6.17-rc3/include/linux/mmzone.h	2006-05-04 13:01:39.000000000 -0400
@@ -22,6 +22,7 @@
 #else
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
+#define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
 
 struct free_area {
 	struct list_head	free_list;
