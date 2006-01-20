Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWATL4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWATL4R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWATL4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:56:07 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:32388 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750859AbWATL4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:56:03 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: jschopp@austin.ibm.com, Mel Gorman <mel@csn.ul.ie>,
       linux-kernel@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060120115455.16475.93688.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060120115415.16475.8529.sendpatchset@skynet.csn.ul.ie>
References: <20060120115415.16475.8529.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 2/4] Split the free lists into kernel and user parts
Date: Fri, 20 Jan 2006 11:54:55 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the core of the anti-fragmentation strategy. It works by
grouping related allocation types together. The idea is that large groups of
pages that may be reclaimed are placed near each other. The zone->free_area
list is broken into RCLM_TYPES number of lists.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/mmzone.h linux-2.6.16-rc1-mm1-002_fragcore/include/linux/mmzone.h
--- linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/mmzone.h	2006-01-19 11:21:59.000000000 +0000
+++ linux-2.6.16-rc1-mm1-002_fragcore/include/linux/mmzone.h	2006-01-19 21:51:05.000000000 +0000
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
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/page-flags.h linux-2.6.16-rc1-mm1-002_fragcore/include/linux/page-flags.h
--- linux-2.6.16-rc1-mm1-001_antifrag_flags/include/linux/page-flags.h	2006-01-19 11:21:59.000000000 +0000
+++ linux-2.6.16-rc1-mm1-002_fragcore/include/linux/page-flags.h	2006-01-19 21:51:05.000000000 +0000
@@ -76,6 +76,7 @@
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
+#define PG_easyrclm		20	/* Page is in an easy reclaim block */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -345,6 +346,12 @@ extern void __mod_page_state_offset(unsi
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
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-001_antifrag_flags/mm/page_alloc.c linux-2.6.16-rc1-mm1-002_fragcore/mm/page_alloc.c
--- linux-2.6.16-rc1-mm1-001_antifrag_flags/mm/page_alloc.c	2006-01-19 11:21:59.000000000 +0000
+++ linux-2.6.16-rc1-mm1-002_fragcore/mm/page_alloc.c	2006-01-19 22:12:09.000000000 +0000
@@ -72,6 +72,16 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 
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
@@ -328,11 +338,13 @@ static inline void __free_one_page(struc
 {
 	unsigned long page_idx;
 	int order_size = 1 << order;
+	int alloctype = get_pageblock_type(page);
 
 	if (unlikely(PageCompound(page)))
 		destroy_compound_page(page, order);
 
 	page_idx = page_to_pfn(page) & ((1 << MAX_ORDER) - 1);
+	__SetPageEasyRclm(page);
 
 	BUG_ON(page_idx & (order_size - 1));
 	BUG_ON(bad_range(zone, page));
@@ -340,7 +352,6 @@ static inline void __free_one_page(struc
 	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
 		unsigned long combined_idx;
-		struct free_area *area;
 		struct page *buddy;
 
 		buddy = __page_find_buddy(page, page_idx, order);
@@ -348,8 +359,7 @@ static inline void __free_one_page(struc
 			break;		/* Move the buddy up one level. */
 
 		list_del(&buddy->lru);
-		area = zone->free_area + order;
-		area->nr_free--;
+		zone->free_area[order].nr_free--;
 		rmv_page_order(buddy);
 		combined_idx = __find_combined_index(page_idx, order);
 		page = page + (combined_idx - page_idx);
@@ -357,7 +367,7 @@ static inline void __free_one_page(struc
 		order++;
 	}
 	set_page_order(page, order);
-	list_add(&page->lru, &zone->free_area[order].free_list);
+	list_add(&page->lru, &zone->free_area[order].free_list[alloctype]);
 	zone->free_area[order].nr_free++;
 }
 
@@ -500,7 +510,8 @@ void fastcall __init __free_pages_bootme
  * -- wli
  */
 static inline void expand(struct zone *zone, struct page *page,
- 	int low, int high, struct free_area *area)
+ 	int low, int high, struct free_area *area,
+	int alloctype)
 {
 	unsigned long size = 1 << high;
 
@@ -509,7 +520,7 @@ static inline void expand(struct zone *z
 		high--;
 		size >>= 1;
 		BUG_ON(bad_range(zone, &page[size]));
-		list_add(&page[size].lru, &area->free_list);
+		list_add(&page[size].lru, &area->free_list[alloctype]);
 		area->nr_free++;
 		set_page_order(&page[size], high);
 	}
@@ -552,31 +563,77 @@ static int prep_new_page(struct page *pa
 	return 0;
 }
 
+/* Remove an element from the buddy allocator from the fallback list */
+ static struct page *__rmqueue_fallback(struct zone *zone, int order,
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
+		expand(zone, page, order, current_order, area, alloctype);
+		return page;
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
+		int alloctype)
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
-		expand(zone, page, order, current_order, area);
-		return page;
+		expand(zone, page, order, current_order, area, alloctype);
+		goto got_page;
 	}
 
-	return NULL;
+	page = __rmqueue_fallback(zone, order, alloctype);
+
+got_page:
+	if (unlikely(alloctype == RCLM_NORCLM) && page)
+		__ClearPageEasyRclm(page);
+
+	return page;
 }
 
 /* 
@@ -585,13 +642,14 @@ static struct page *__rmqueue(struct zon
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order, 
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list,
+			int alloctype)
 {
 	int i;
 	
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
-		struct page *page = __rmqueue(zone, order);
+		struct page *page = __rmqueue(zone, order, alloctype);
 		if (unlikely(page == NULL))
 			break;
 		list_add_tail(&page->lru, list);
@@ -658,7 +716,7 @@ static void __drain_pages(unsigned int c
 void mark_free_pages(struct zone *zone)
 {
 	unsigned long zone_pfn, flags;
-	int order;
+	int order, t;
 	struct list_head *curr;
 
 	if (!zone->spanned_pages)
@@ -669,13 +727,15 @@ void mark_free_pages(struct zone *zone)
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
@@ -775,6 +835,7 @@ static struct page *buffered_rmqueue(str
 	unsigned long flags;
 	struct page *page;
 	int cold = !!(gfp_flags & __GFP_COLD);
+	int alloctype = gfpflags_to_alloctype(gfp_flags);
 	int cpu;
 
 again:
@@ -786,7 +847,8 @@ again:
 		local_irq_save(flags);
 		if (!pcp->count) {
 			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
+						pcp->batch, &pcp->list,
+						alloctype);
 			if (unlikely(!pcp->count))
 				goto failed;
 		}
@@ -795,7 +857,7 @@ again:
 		pcp->count--;
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, alloctype);
 		spin_unlock(&zone->lock);
 		if (!page)
 			goto failed;
@@ -1852,7 +1914,8 @@ void zone_init_free_lists(struct pglist_
 {
 	int order;
 	for (order = 0; order < MAX_ORDER ; order++) {
-		INIT_LIST_HEAD(&zone->free_area[order].free_list);
+		INIT_LIST_HEAD(&zone->free_area[order].free_list[RCLM_NORCLM]);
+		INIT_LIST_HEAD(&zone->free_area[order].free_list[RCLM_EASY]);
 		zone->free_area[order].nr_free = 0;
 	}
 }
