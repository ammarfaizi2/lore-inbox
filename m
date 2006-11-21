Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031259AbWKUWvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031259AbWKUWvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031266AbWKUWvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:51:09 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:64166 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1031258AbWKUWvE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:51:04 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, clameter@sgi.com
Message-Id: <20061121225102.11710.8951.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 2/11] Split the free lists for movable and unmovable allocations
Date: Tue, 21 Nov 2006 22:51:02 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the core of the page clustering strategy. It works by grouping
pages together based on their ability to migrate or reclaimed.  Basically,
it works by breaking the list in zone->free_area list into MIGRATE_TYPES
number of lists.


Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 include/linux/mmzone.h     |   10 ++-
 include/linux/page-flags.h |    7 ++
 mm/page_alloc.c            |  123 ++++++++++++++++++++++++++++++++--------
 3 files changed, 116 insertions(+), 24 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/mmzone.h linux-2.6.19-rc5-mm2-003_clustering_core/include/linux/mmzone.h
--- linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/mmzone.h	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-003_clustering_core/include/linux/mmzone.h	2006-11-21 10:48:55.000000000 +0000
@@ -24,8 +24,16 @@
 #endif
 #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
 
+#define MIGRATE_UNMOVABLE 0
+#define MIGRATE_MOVABLE   1
+#define MIGRATE_TYPES     2
+
+#define for_each_migratetype_order(order, type) \
+	for (order = 0; order < MAX_ORDER; order++) \
+		for (type = 0; type < MIGRATE_TYPES; type++)
+
 struct free_area {
-	struct list_head	free_list;
+	struct list_head	free_list[MIGRATE_TYPES];
 	unsigned long		nr_free;
 };
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/page-flags.h linux-2.6.19-rc5-mm2-003_clustering_core/include/linux/page-flags.h
--- linux-2.6.19-rc5-mm2-001_clustering_flags/include/linux/page-flags.h	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-003_clustering_core/include/linux/page-flags.h	2006-11-21 10:48:55.000000000 +0000
@@ -93,6 +93,7 @@
 
 #define PG_readahead		20	/* Reminder to do readahead */
 
+#define PG_movable		21	/* Page may be moved */
 
 #if (BITS_PER_LONG > 32)
 /*
@@ -253,6 +254,12 @@ static inline void SetPageUptodate(struc
 #define SetPageReadahead(page)	set_bit(PG_readahead, &(page)->flags)
 #define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
 
+#define PageMovable(page)	test_bit(PG_movable, &(page)->flags)
+#define SetPageMovable(page)	set_bit(PG_movable, &(page)->flags)
+#define ClearPageMovable(page)	clear_bit(PG_movable, &(page)->flags)
+#define __SetPageMovable(page)	__set_bit(PG_movable, &(page)->flags)
+#define __ClearPageMovable(page) __clear_bit(PG_movable, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-001_clustering_flags/mm/page_alloc.c linux-2.6.19-rc5-mm2-003_clustering_core/mm/page_alloc.c
--- linux-2.6.19-rc5-mm2-001_clustering_flags/mm/page_alloc.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-003_clustering_core/mm/page_alloc.c	2006-11-21 10:48:55.000000000 +0000
@@ -136,6 +136,16 @@ static unsigned long __initdata dma_rese
 #endif /* CONFIG_MEMORY_HOTPLUG_RESERVE */
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 
+static inline int get_page_migratetype(struct page *page)
+{
+	return (PageMovable(page) != 0);
+}
+
+static inline int gfpflags_to_migratetype(gfp_t gfp_flags)
+{
+	return ((gfp_flags & __GFP_MOVABLE) != 0);
+}
+
 #ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
@@ -411,13 +421,19 @@ static inline void __free_one_page(struc
 
 	page_idx = page_to_pfn(page) & ((1 << MAX_ORDER) - 1);
 
+	/*
+	 * Free pages are always marked movable so the bits are in a known
+	 * state on alloc. As movable allocations are the most common, this
+	 * will result in less bit manipulations
+	 */
+	__SetPageMovable(page);
+
 	VM_BUG_ON(page_idx & (order_size - 1));
 	VM_BUG_ON(bad_range(zone, page));
 
 	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
 		unsigned long combined_idx;
-		struct free_area *area;
 		struct page *buddy;
 
 		buddy = __page_find_buddy(page, page_idx, order);
@@ -425,8 +441,7 @@ static inline void __free_one_page(struc
 			break;		/* Move the buddy up one level. */
 
 		list_del(&buddy->lru);
-		area = zone->free_area + order;
-		area->nr_free--;
+		zone->free_area[order].nr_free--;
 		rmv_page_order(buddy);
 		combined_idx = __find_combined_index(page_idx, order);
 		page = page + (combined_idx - page_idx);
@@ -434,7 +449,8 @@ static inline void __free_one_page(struc
 		order++;
 	}
 	set_page_order(page, order);
-	list_add(&page->lru, &zone->free_area[order].free_list);
+	list_add(&page->lru,
+		&zone->free_area[order].free_list[get_page_migratetype(page)]);
 	zone->free_area[order].nr_free++;
 }
 
@@ -569,7 +585,8 @@ void fastcall __init __free_pages_bootme
  * -- wli
  */
 static inline void expand(struct zone *zone, struct page *page,
- 	int low, int high, struct free_area *area)
+	int low, int high, struct free_area *area,
+	int migratetype)
 {
 	unsigned long size = 1 << high;
 
@@ -578,7 +595,7 @@ static inline void expand(struct zone *z
 		high--;
 		size >>= 1;
 		VM_BUG_ON(bad_range(zone, &page[size]));
-		list_add(&page[size].lru, &area->free_list);
+		list_add(&page[size].lru, &area->free_list[migratetype]);
 		area->nr_free++;
 		set_page_order(&page[size], high);
 	}
@@ -631,31 +648,78 @@ static int prep_new_page(struct page *pa
 	return 0;
 }
 
+/* Remove an element from the buddy allocator from the fallback list */
+static struct page *__rmqueue_fallback(struct zone *zone, int order,
+						int start_migratetype)
+{
+	struct free_area * area;
+	int current_order;
+	struct page *page;
+	int migratetype = !start_migratetype;
+
+	/* Find the largest possible block of pages in the other list */
+	for (current_order = MAX_ORDER-1; current_order >= order;
+						--current_order) {
+		area = &(zone->free_area[current_order]);
+		if (list_empty(&area->free_list[migratetype]))
+			continue;
+
+		page = list_entry(area->free_list[migratetype].next,
+					struct page, lru);
+		area->nr_free--;
+
+		/*
+		 * If breaking a large block of pages, place the buddies
+		 * on the preferred allocation list
+		 */
+		if (unlikely(current_order >= MAX_ORDER / 2))
+			migratetype = !migratetype;
+
+		/* Remove the page from the freelists */
+		list_del(&page->lru);
+		rmv_page_order(page);
+		zone->free_pages -= 1UL << order;
+		expand(zone, page, order, current_order, area, migratetype);
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
+						int migratetype)
 {
 	struct free_area * area;
 	unsigned int current_order;
 	struct page *page;
 
+	/* Find a page of the appropriate size in the preferred list */
 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
-		if (list_empty(&area->free_list))
+		area = &(zone->free_area[current_order]);
+		if (list_empty(&area->free_list[migratetype]))
 			continue;
 
-		page = list_entry(area->free_list.next, struct page, lru);
+		page = list_entry(area->free_list[migratetype].next,
+					struct page, lru);
 		list_del(&page->lru);
 		rmv_page_order(page);
 		area->nr_free--;
 		zone->free_pages -= 1UL << order;
-		expand(zone, page, order, current_order, area);
-		return page;
+		expand(zone, page, order, current_order, area, migratetype);
+		goto got_page;
 	}
 
-	return NULL;
+	page = __rmqueue_fallback(zone, order, migratetype);
+
+got_page:
+	if (unlikely(migratetype == MIGRATE_UNMOVABLE) && page)
+		__ClearPageMovable(page);
+
+	return page;
 }
 
 /* 
@@ -664,13 +728,14 @@ static struct page *__rmqueue(struct zon
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order, 
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list,
+			int migratetype)
 {
 	int i;
 	
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
-		struct page *page = __rmqueue(zone, order);
+		struct page *page = __rmqueue(zone, order, migratetype);
 		if (unlikely(page == NULL))
 			break;
 		list_add_tail(&page->lru, list);
@@ -745,7 +810,7 @@ void mark_free_pages(struct zone *zone)
 {
 	unsigned long pfn, max_zone_pfn;
 	unsigned long flags;
-	int order;
+	int order, t;
 	struct list_head *curr;
 
 	if (!zone->spanned_pages)
@@ -762,14 +827,15 @@ void mark_free_pages(struct zone *zone)
 				ClearPageNosaveFree(page);
 		}
 
-	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list) {
+	for_each_migratetype_order(order, t) {
+		list_for_each(curr, &zone->free_area[order].free_list[t]) {
 			unsigned long i;
 
 			pfn = page_to_pfn(list_entry(curr, struct page, lru));
 			for (i = 0; i < (1UL << order); i++)
 				SetPageNosaveFree(pfn_to_page(pfn + i));
 		}
+	}
 
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
@@ -859,6 +925,7 @@ static struct page *buffered_rmqueue(str
 	struct page *page;
 	int cold = !!(gfp_flags & __GFP_COLD);
 	int cpu;
+	int migratetype = gfpflags_to_migratetype(gfp_flags);
 
 again:
 	cpu  = get_cpu();
@@ -869,7 +936,7 @@ again:
 		local_irq_save(flags);
 		if (!pcp->count) {
 			pcp->count = rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
+					pcp->batch, &pcp->list, migratetype);
 			if (unlikely(!pcp->count))
 				goto failed;
 		}
@@ -878,7 +945,7 @@ again:
 		pcp->count--;
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, migratetype);
 		spin_unlock(&zone->lock);
 		if (!page)
 			goto failed;
@@ -2046,6 +2113,16 @@ void __meminit memmap_init_zone(unsigned
 		init_page_count(page);
 		reset_page_mapcount(page);
 		SetPageReserved(page);
+
+		/*
+		 * Mark the page movable so that blocks are reserved for
+		 * movable at startup. This will force kernel allocations
+		 * to reserve their blocks rather than leaking throughout
+		 * the address space during boot when many long-lived
+		 * kernel allocations are made
+		 */
+		SetPageMovable(page);
+
 		INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
 		/* The shift won't overflow because ZONE_NORMAL is below 4G. */
@@ -2061,9 +2138,9 @@ void __meminit memmap_init_zone(unsigned
 void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone,
 				unsigned long size)
 {
-	int order;
-	for (order = 0; order < MAX_ORDER ; order++) {
-		INIT_LIST_HEAD(&zone->free_area[order].free_list);
+	int order, t;
+	for_each_migratetype_order(order, t) {
+		INIT_LIST_HEAD(&zone->free_area[order].free_list[t]);
 		zone->free_area[order].nr_free = 0;
 	}
 }
