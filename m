Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946785AbWKALSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946785AbWKALSY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946788AbWKALSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:18:24 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:30091 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1946785AbWKALSW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:18:22 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Message-Id: <20061101111820.18798.35738.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
References: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 6/11] Move free pages between lists on steal
Date: Wed,  1 Nov 2006 11:18:20 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a fallback occurs, there will be free pages for one allocation type
stored on the list for another. When a large steal occurs, this patch
will move all the free pages within one list to one allocation type.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 page_alloc.c |   84 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 75 insertions(+), 9 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-005_drainpercpu/mm/page_alloc.c linux-2.6.19-rc4-mm1-006_movefree/mm/page_alloc.c
--- linux-2.6.19-rc4-mm1-005_drainpercpu/mm/page_alloc.c	2006-10-31 13:44:09.000000000 +0000
+++ linux-2.6.19-rc4-mm1-006_movefree/mm/page_alloc.c	2006-10-31 13:50:10.000000000 +0000
@@ -654,6 +654,62 @@ static int prep_new_page(struct page *pa
 }
 
 #ifdef CONFIG_PAGEALLOC_ANTIFRAG
+/*
+ * Move the free pages in a range to the free lists of the requested type.
+ * Note that start_page and end_pages are not aligned in a MAX_ORDER_NR_PAGES
+ * boundary. If alignment is required, use move_freepages_block()
+ */
+int move_freepages(struct zone *zone,
+			struct page *start_page, struct page *end_page,
+			int rclmtype)
+{
+	struct page *page;
+	unsigned long order;
+	int blocks_moved = 0;
+
+	BUG_ON(page_zone(start_page) != page_zone(end_page));
+
+	for (page = start_page; page < end_page;) {
+		if (!PageBuddy(page)) {
+			page++;
+			continue;
+		}
+#ifdef CONFIG_HOLES_IN_ZONE
+		if (!pfn_valid(page_to_pfn(page))) {
+			page++;
+			continue;
+		}
+#endif
+
+		order = page_order(page);
+		list_del(&page->lru);
+		list_add(&page->lru,
+			&zone->free_area[order].free_list[rclmtype]);
+		page += 1 << order;
+		blocks_moved++;
+	}
+
+	return blocks_moved;
+}
+
+int move_freepages_block(struct zone *zone, struct page *page, int rclmtype)
+{
+	unsigned long start_pfn;
+	struct page *start_page, *end_page;
+
+	start_pfn = page_to_pfn(page);
+	start_pfn = start_pfn & ~(MAX_ORDER_NR_PAGES-1);
+	start_page = pfn_to_page(start_pfn);
+	end_page = start_page + MAX_ORDER_NR_PAGES;
+
+	if (page_zone(page) != page_zone(start_page))
+		start_page = page;
+	if (page_zone(page) != page_zone(end_page))
+		return 0;
+
+	return move_freepages(zone, start_page, end_page, rclmtype);
+}
+
 /* Remove an element from the buddy allocator from the fallback list */
 static struct page *__rmqueue_fallback(struct zone *zone, int order,
 							gfp_t gfp_flags)
@@ -661,10 +717,10 @@ static struct page *__rmqueue_fallback(s
 	struct free_area * area;
 	int current_order;
 	struct page *page;
-	int rclmtype = gfpflags_to_rclmtype(gfp_flags);
+	int start_rclmtype = gfpflags_to_rclmtype(gfp_flags);
+	int rclmtype = !start_rclmtype;
 
 	/* Find the largest possible block of pages in the other list */
-	rclmtype = !rclmtype;
 	for (current_order = MAX_ORDER-1; current_order >= order;
 						--current_order) {
 		area = &(zone->free_area[current_order]);
@@ -675,24 +731,34 @@ static struct page *__rmqueue_fallback(s
 					struct page, lru);
 		area->nr_free--;
 
-		/*
-		 * If breaking a large block of pages, place the buddies
-		 * on the preferred allocation list
-		 */
-		if (unlikely(current_order >= MAX_ORDER / 2))
-			rclmtype = !rclmtype;
-
 		/* Remove the page from the freelists */
 		list_del(&page->lru);
 		rmv_page_order(page);
 		zone->free_pages -= 1UL << order;
 		expand(zone, page, order, current_order, area, rclmtype);
+
+		/* Move free pages between lists if stealing a large block */
+		if (current_order > MAX_ORDER / 2)
+			move_freepages_block(zone, page, start_rclmtype);
+
 		return page;
 	}
 
 	return NULL;
 }
 #else
+int move_freepages(struct zone *zone,
+			struct page *start_page, struct page *end_page,
+			int rclmtype)
+{
+	return 0;
+}
+
+int move_freepages_block(struct zone *zone, struct page *page, int rclmtype)
+{
+	return 0;
+}
+
 static struct page *__rmqueue_fallback(struct zone *zone, unsigned int order,
 							int rclmtype)
 {
