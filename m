Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbVKVTSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbVKVTSB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbVKVTRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:17:54 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:37352 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S965130AbVKVTRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:17:34 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, nickpiggin@yahoo.com.au, ak@suse.de,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       mingo@elte.hu
Message-Id: <20051122191720.21757.74743.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051122191710.21757.67440.sendpatchset@skynet.csn.ul.ie>
References: <20051122191710.21757.67440.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 2/5] Light fragmentation avoidance without usemap: 002_fragcore
Date: Tue, 22 Nov 2005 19:17:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the core of the anti-fragmentation strategy. It works by
grouping related allocation types together. The idea is that large groups of
pages that may be reclaimed are placed near each other. The zone->free_area
list is broken into RCLM_TYPES number of lists.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.15-rc1-mm2-001_antidefrag_flags/include/linux/mmzone.h linux-2.6.15-rc1-mm2-002_fragcore/include/linux/mmzone.h
--- linux-2.6.15-rc1-mm2-001_antidefrag_flags/include/linux/mmzone.h	2005-11-21 19:44:33.000000000 +0000
+++ linux-2.6.15-rc1-mm2-002_fragcore/include/linux/mmzone.h	2005-11-22 16:50:09.000000000 +0000
@@ -22,8 +22,16 @@
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
 
+#define RCLM_NORCLM 0
+#define RCLM_EASY   1
+#define RCLM_TYPES  2
+
+#define for_each_rclmtype_order(type, order) \
+	for (order = 0; order < MAX_ORDER; order++) \
+		for (type = 0; type < RCLM_TYPES; type++)
+
 struct free_area {
-	struct list_head	free_list;
+	struct list_head	free_list[RCLM_TYPES];
 	unsigned long		nr_free;
 };
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.15-rc1-mm2-001_antidefrag_flags/include/linux/page-flags.h linux-2.6.15-rc1-mm2-002_fragcore/include/linux/page-flags.h
--- linux-2.6.15-rc1-mm2-001_antidefrag_flags/include/linux/page-flags.h	2005-11-21 19:44:33.000000000 +0000
+++ linux-2.6.15-rc1-mm2-002_fragcore/include/linux/page-flags.h	2005-11-22 16:50:09.000000000 +0000
@@ -76,6 +76,7 @@
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
+#define PG_easyrclm		20	/* Page is in an easy reclaim block */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -304,6 +305,12 @@ extern void __mod_page_state(unsigned lo
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageEasyRclm(page)	test_bit(PG_easyrclm, &(page)->flags)
+#define SetPageEasyRclm(page)	set_bit(PG_easyrclm, &(page)->flags)
+#define ClearPageEasyRclm(page)	clear_bit(PG_easyrclm, &(page)->flags)
+#define __SetPageEasyRclm(page)	__set_bit(PG_easyrclm, &(page)->flags)
+#define __ClearPageEasyRclm(page) __clear_bit(PG_easyrclm, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.15-rc1-mm2-001_antidefrag_flags/mm/page_alloc.c linux-2.6.15-rc1-mm2-002_fragcore/mm/page_alloc.c
--- linux-2.6.15-rc1-mm2-001_antidefrag_flags/mm/page_alloc.c	2005-11-21 19:44:33.000000000 +0000
+++ linux-2.6.15-rc1-mm2-002_fragcore/mm/page_alloc.c	2005-11-22 16:50:09.000000000 +0000
@@ -68,6 +68,16 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 
 EXPORT_SYMBOL(totalram_pages);
 
+static inline int get_pageblock_type(struct page *page)
+{
+	return (PageEasyRclm(page) != 0);
+}
+
+static inline int gfpflags_to_alloctype(unsigned long gfp_flags)
+{
+	return ((gfp_flags & __GFP_EASYRCLM) != 0);
+}
+
 /*
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
@@ -314,11 +324,13 @@ static inline void __free_pages_bulk (st
 {
 	unsigned long page_idx;
 	int order_size = 1 << order;
+	int alloctype = get_pageblock_type(page);
 
 	if (unlikely(order))
 		destroy_compound_page(page, order);
 
 	page_idx = page_to_pfn(page) & ((1 << MAX_ORDER) - 1);
+	__SetPageEasyRclm(page);
 
 	BUG_ON(page_idx & (order_size - 1));
 	BUG_ON(bad_range(zone, page));
@@ -326,7 +338,6 @@ static inline void __free_pages_bulk (st
 	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
 		unsigned long combined_idx;
-		struct free_area *area;
 		struct page *buddy;
 
 		combined_idx = __find_combined_index(page_idx, order);
@@ -337,15 +348,14 @@ static inline void __free_pages_bulk (st
 		if (!page_is_buddy(buddy, order))
 			break;		/* Move the buddy up one level. */
 		list_del(&buddy->lru);
-		area = zone->free_area + order;
-		area->nr_free--;
+		zone->free_area[order].nr_free--;
 		rmv_page_order(buddy);
 		page = page + (combined_idx - page_idx);
 		page_idx = combined_idx;
 		order++;
 	}
 	set_page_order(page, order);
-	list_add(&page->lru, &zone->free_area[order].free_list);
+	list_add(&page->lru, &zone->free_area[order].free_list[alloctype]);
 	zone->free_area[order].nr_free++;
 }
 
@@ -450,7 +460,8 @@ void __free_pages_ok(struct page *page, 
  */
 static inline struct page *
 expand(struct zone *zone, struct page *page,
- 	int low, int high, struct free_area *area)
+ 	int low, int high, struct free_area *area,
+	int alloctype)
 {
 	unsigned long size = 1 << high;
 
@@ -459,7 +470,7 @@ expand(struct zone *zone, struct page *p
 		high--;
 		size >>= 1;
 		BUG_ON(bad_range(zone, &page[size]));
-		list_add(&page[size].lru, &area->free_list);
+		list_add(&page[size].lru, &area->free_list[alloctype]);
 		area->nr_free++;
 		set_page_order(&page[size], high);
 	}
@@ -520,30 +531,79 @@ static int prep_new_page(struct page *pa
 	return 0;
 }
 
+/* Remove an element from the buddy allocator from the fallback list */
+static struct page *__rmqueue_fallback(struct zone *zone, int order,
+							int alloctype)
+{
+	struct free_area * area;
+	int current_order;
+	struct page *page;
+
+	/* Find the largest possible block of pages in the other list */
+	alloctype = !alloctype;
+	for (current_order = MAX_ORDER-1; current_order >= order;
+						--current_order) {
+		area = &(zone->free_area[current_order]);
+ 		if (list_empty(&area->free_list[alloctype]))
+ 			continue;
+
+		page = list_entry(area->free_list[alloctype].next,
+					struct page, lru);
+		area->nr_free--;
+
+		/*
+		 * If breaking a large block of pages, place the buddies
+		 * on the preferred allocation list
+		 */
+		if (unlikely(current_order >= MAX_ORDER / 2))
+			alloctype = !alloctype;
+
+		list_del(&page->lru);
+		rmv_page_order(page);
+		zone->free_pages -= 1UL << order;
+		return expand(zone, page, order, current_order, area,
+				alloctype);
+
+	}
+
+	return NULL;
+}
+
 /* 
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order)
+static struct page *__rmqueue(struct zone *zone, unsigned int order,
+					int alloctype)
 {
 	struct free_area * area;
 	unsigned int current_order;
 	struct page *page;
 
+	/* Find a page of the appropriate size in the preferred list */
 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
-		if (list_empty(&area->free_list))
+		area = &(zone->free_area[current_order]);
+		if (list_empty(&area->free_list[alloctype]))
 			continue;
 
-		page = list_entry(area->free_list.next, struct page, lru);
+		page = list_entry(area->free_list[alloctype].next,
+					struct page, lru);
 		list_del(&page->lru);
 		rmv_page_order(page);
 		area->nr_free--;
 		zone->free_pages -= 1UL << order;
-		return expand(zone, page, order, current_order, area);
+		page = expand(zone, page, order, current_order, area,
+				alloctype);
+		goto got_page;
 	}
 
-	return NULL;
+	page = __rmqueue_fallback(zone, order, alloctype);
+
+got_page:
+	if (unlikely(alloctype == RCLM_NORCLM))
+		__ClearPageEasyRclm(page);
+
+	return page;
 }
 
 /* 
@@ -552,7 +612,8 @@ static struct page *__rmqueue(struct zon
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order, 
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list,
+			int alloctype)
 {
 	unsigned long flags;
 	int i;
@@ -561,7 +622,7 @@ static int rmqueue_bulk(struct zone *zon
 	
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, alloctype);
 		if (page == NULL)
 			break;
 		allocated++;
@@ -627,7 +688,7 @@ static void __drain_pages(unsigned int c
 void mark_free_pages(struct zone *zone)
 {
 	unsigned long zone_pfn, flags;
-	int order;
+	int order, t;
 	struct list_head *curr;
 
 	if (!zone->spanned_pages)
@@ -638,13 +699,15 @@ void mark_free_pages(struct zone *zone)
 		ClearPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));
 
 	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list) {
+	for_each_rclmtype_order(t, order) {
+		list_for_each(curr, &zone->free_area[order].free_list[t]) {
 			unsigned long start_pfn, i;
 
 			start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
 
 			for (i=0; i < (1<<order); i++)
 				SetPageNosaveFree(pfn_to_page(start_pfn+i));
+		}
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
@@ -748,6 +811,7 @@ buffered_rmqueue(struct zone *zone, int 
 	unsigned long flags;
 	struct page *page;
 	int cold = !!(gfp_flags & __GFP_COLD);
+	int alloctype = gfpflags_to_alloctype(gfp_flags);
 
 again:
 	if (order == 0) {
@@ -758,7 +822,8 @@ again:
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
+						pcp->batch, &pcp->list,
+						alloctype);
 		if (pcp->count) {
 			page = list_entry(pcp->list.next, struct page, lru);
 			list_del(&page->lru);
@@ -768,7 +833,7 @@ again:
 		put_cpu();
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, alloctype);
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
@@ -1791,7 +1856,8 @@ void zone_init_free_lists(struct pglist_
 {
 	int order;
 	for (order = 0; order < MAX_ORDER ; order++) {
-		INIT_LIST_HEAD(&zone->free_area[order].free_list);
+		INIT_LIST_HEAD(&zone->free_area[order].free_list[RCLM_NORCLM]);
+		INIT_LIST_HEAD(&zone->free_area[order].free_list[RCLM_EASY]);
 		zone->free_area[order].nr_free = 0;
 	}
 }
