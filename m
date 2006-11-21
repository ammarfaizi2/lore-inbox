Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031341AbWKUWyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031341AbWKUWyq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031308AbWKUWyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:54:37 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:39335 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1031291AbWKUWyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:54:04 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, clameter@sgi.com
Message-Id: <20061121225403.11710.37011.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 11/11] Use pageblock flags for page clustering
Date: Tue, 21 Nov 2006 22:54:03 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch alters page clustering to use the pageblock bits for track how
movable a block of pages is.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 include/linux/pageblock-flags.h |    4 ++++
 mm/page_alloc.c                 |   27 ++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-102_remove_clustering_flags/include/linux/pageblock-flags.h linux-2.6.19-rc5-mm2-103_clustering_pageblock/include/linux/pageblock-flags.h
--- linux-2.6.19-rc5-mm2-102_remove_clustering_flags/include/linux/pageblock-flags.h	2006-11-21 11:23:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-103_clustering_pageblock/include/linux/pageblock-flags.h	2006-11-21 11:27:10.000000000 +0000
@@ -27,6 +27,10 @@
 
 /* Bit indices that affect a whole block of pages */
 enum pageblock_bits {
+#ifdef CONFIG_PAGE_CLUSTERING
+	PB_migrate,
+	PB_migrate_end = (PB_migrate + 2) - 1, /* 2 bits for migrate types */
+#endif /* CONFIG_PAGE_CLUSTERING */
 	NR_PAGEBLOCK_BITS
 };
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-102_remove_clustering_flags/mm/page_alloc.c linux-2.6.19-rc5-mm2-103_clustering_pageblock/mm/page_alloc.c
--- linux-2.6.19-rc5-mm2-102_remove_clustering_flags/mm/page_alloc.c	2006-11-21 11:52:50.000000000 +0000
+++ linux-2.6.19-rc5-mm2-103_clustering_pageblock/mm/page_alloc.c	2006-11-21 11:52:53.000000000 +0000
@@ -143,8 +143,15 @@ static unsigned long __initdata dma_rese
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 
 #ifdef CONFIG_PAGE_CLUSTERING
-static inline int get_page_migratetype(struct page *page)
+static inline int get_pageblock_migratetype(struct page *page)
 {
+	return get_pageblock_flags_group(page, PB_migrate, PB_migrate_end);
+}
+
+static void set_pageblock_migratetype(struct page *page, int migratetype)
+{
+	set_pageblock_flags_group(page, (unsigned long)migratetype,
+					PB_migrate, PB_migrate_end);
 }
 
 static inline int gfpflags_to_migratetype(gfp_t gfp_flags)
@@ -155,11 +162,15 @@ static inline int gfpflags_to_migratetyp
 		((gfp_flags & __GFP_RECLAIMABLE) != 0);
 }
 #else
-static inline int get_page_migratetype(struct page *page)
+static inline int get_pageblock_migratetype(struct page *page)
 {
 	return MIGRATE_UNMOVABLE;
 }
 
+static inline void set_pageblock_migratetype(struct page *page, int rclmtype)
+{
+}
+
 static inline int gfpflags_to_migratetype(gfp_t gfp_flags)
 {
 	return MIGRATE_UNMOVABLE;
@@ -435,7 +446,7 @@ static inline void __free_one_page(struc
 {
 	unsigned long page_idx;
 	int order_size = 1 << order;
-	int migratetype = get_page_migratetype(page);
+	int migratetype = get_pageblock_migratetype(page);
 
 	if (unlikely(PageCompound(page)))
 		destroy_compound_page(page, order);
@@ -715,6 +726,7 @@ int move_freepages_block(struct zone *zo
 	if (page_zone(page) != page_zone(end_page))
 		return 0;
 
+	set_pageblock_migratetype(start_page, migratetype);
 	return move_freepages(zone, start_page, end_page, migratetype);
 }
 
@@ -834,6 +846,10 @@ static struct page *__rmqueue(struct zon
 		rmv_page_order(page);
 		area->nr_free--;
 		zone->free_pages -= 1UL << order;
+
+		if (current_order == MAX_ORDER - 1)
+			set_pageblock_migratetype(page, migratetype);
+
 		expand(zone, page, order, current_order, area, migratetype);
 		goto got_page;
 	}
@@ -1022,7 +1038,7 @@ static void fastcall free_hot_cold_page(
 	local_irq_save(flags);
 	__count_vm_event(PGFREE);
 	list_add(&page->lru, &pcp->list);
-	set_page_private(page, get_page_migratetype(page));
+	set_page_private(page, get_pageblock_migratetype(page));
 	pcp->count++;
 	if (pcp->count >= pcp->high) {
 		free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
@@ -2291,12 +2307,13 @@ void __meminit memmap_init_zone(unsigned
 		SetPageReserved(page);
 
 		/*
-		 * Mark the page movable so that blocks are reserved for
+		 * Mark the block movable so that blocks are reserved for
 		 * movable at startup. This will force kernel allocations
 		 * to reserve their blocks rather than leaking throughout
 		 * the address space during boot when many long-lived
 		 * kernel allocations are made
 		 */
+		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 
 		INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
