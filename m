Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVKQTkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVKQTkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVKQTkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:40:47 -0500
Received: from gold.veritas.com ([143.127.12.110]:25913 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964823AbVKQTkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:40:46 -0500
Date: Thu, 17 Nov 2005 19:39:22 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] unpaged: PG_reserved bad_page
In-Reply-To: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511171938490.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Nov 2005 19:40:41.0133 (UTC) FILETIME=[CAED8DD0:01C5EBAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It used to be the case that PG_reserved pages were silently never freed,
but in 2.6.15-rc1 they may be freed with a "Bad page state" message.  We
should work through such cases as they appear, fixing the code; but for
now it's safer to issue the message without freeing the page, leaving
PG_reserved set.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/page_alloc.c |   46 ++++++++++++++++++++++++++++++++++------------
 1 files changed, 34 insertions(+), 12 deletions(-)

--- unpaged09/mm/page_alloc.c	2005-11-17 15:10:50.000000000 +0000
+++ unpaged10/mm/page_alloc.c	2005-11-17 15:12:12.000000000 +0000
@@ -140,8 +140,7 @@ static void bad_page(const char *functio
 			1 << PG_reclaim |
 			1 << PG_slab    |
 			1 << PG_swapcache |
-			1 << PG_writeback |
-			1 << PG_reserved );
+			1 << PG_writeback );
 	set_page_count(page, 0);
 	reset_page_mapcount(page);
 	page->mapping = NULL;
@@ -335,7 +334,7 @@ static inline void __free_pages_bulk (st
 	zone->free_area[order].nr_free++;
 }
 
-static inline void free_pages_check(const char *function, struct page *page)
+static inline int free_pages_check(const char *function, struct page *page)
 {
 	if (	page_mapcount(page) ||
 		page->mapping != NULL ||
@@ -353,6 +352,12 @@ static inline void free_pages_check(cons
 		bad_page(function, page);
 	if (PageDirty(page))
 		__ClearPageDirty(page);
+	/*
+	 * For now, we report if PG_reserved was found set, but do not
+	 * clear it, and do not free the page.  But we shall soon need
+	 * to do more, for when the ZERO_PAGE count wraps negative.
+	 */
+	return PageReserved(page);
 }
 
 /*
@@ -392,11 +397,10 @@ void __free_pages_ok(struct page *page, 
 {
 	LIST_HEAD(list);
 	int i;
+	int reserved = 0;
 
 	arch_free_page(page, order);
 
-	mod_page_state(pgfree, 1 << order);
-
 #ifndef CONFIG_MMU
 	if (order > 0)
 		for (i = 1 ; i < (1 << order) ; ++i)
@@ -404,8 +408,12 @@ void __free_pages_ok(struct page *page, 
 #endif
 
 	for (i = 0 ; i < (1 << order) ; ++i)
-		free_pages_check(__FUNCTION__, page + i);
+		reserved += free_pages_check(__FUNCTION__, page + i);
+	if (reserved)
+		return;
+
 	list_add(&page->lru, &list);
+	mod_page_state(pgfree, 1 << order);
 	kernel_map_pages(page, 1<<order, 0);
 	free_pages_bulk(page_zone(page), 1, &list, order);
 }
@@ -463,7 +471,7 @@ void set_page_refs(struct page *page, in
 /*
  * This page is about to be returned from the page allocator
  */
-static void prep_new_page(struct page *page, int order)
+static int prep_new_page(struct page *page, int order)
 {
 	if (	page_mapcount(page) ||
 		page->mapping != NULL ||
@@ -481,12 +489,20 @@ static void prep_new_page(struct page *p
 			1 << PG_reserved )))
 		bad_page(__FUNCTION__, page);
 
+	/*
+	 * For now, we report if PG_reserved was found set, but do not
+	 * clear it, and do not allocate the page: as a safety net.
+	 */
+	if (PageReserved(page))
+		return 1;
+
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	set_page_private(page, 0);
 	set_page_refs(page, order);
 	kernel_map_pages(page, 1 << order, 1);
+	return 0;
 }
 
 /* 
@@ -669,11 +685,14 @@ static void fastcall free_hot_cold_page(
 
 	arch_free_page(page, 0);
 
-	kernel_map_pages(page, 1, 0);
-	inc_page_state(pgfree);
 	if (PageAnon(page))
 		page->mapping = NULL;
-	free_pages_check(__FUNCTION__, page);
+	if (free_pages_check(__FUNCTION__, page))
+		return;
+
+	inc_page_state(pgfree);
+	kernel_map_pages(page, 1, 0);
+
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 	local_irq_save(flags);
 	list_add(&page->lru, &pcp->list);
@@ -712,12 +731,14 @@ static struct page *
 buffered_rmqueue(struct zone *zone, int order, gfp_t gfp_flags)
 {
 	unsigned long flags;
-	struct page *page = NULL;
+	struct page *page;
 	int cold = !!(gfp_flags & __GFP_COLD);
 
+again:
 	if (order == 0) {
 		struct per_cpu_pages *pcp;
 
+		page = NULL;
 		pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
@@ -739,7 +760,8 @@ buffered_rmqueue(struct zone *zone, int 
 	if (page != NULL) {
 		BUG_ON(bad_range(zone, page));
 		mod_page_state_zone(zone, pgalloc, 1 << order);
-		prep_new_page(page, order);
+		if (prep_new_page(page, order))
+			goto again;
 
 		if (gfp_flags & __GFP_ZERO)
 			prep_zero_page(page, order, gfp_flags);
