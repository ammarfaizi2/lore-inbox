Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSGDXuY>; Thu, 4 Jul 2002 19:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSGDXsv>; Thu, 4 Jul 2002 19:48:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47629 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315245AbSGDXq7>;
	Thu, 4 Jul 2002 19:46:59 -0400
Message-ID: <3D24E06A.43754238@zip.com.au>
Date: Thu, 04 Jul 2002 16:55:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 25/27] debug: check page refcount in __free_pages_ok()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Add a BUG() check to __free_pages_ok() - to catch someone freeing a
page which has a non-zero refcount.  Actually, this check is mainly to
catch someone (ie: shrink_cache()) incrementing a page's refcount
shortly after it has been freed

Also clean up __free_pages_ok() a bit and convert lots of BUGs to BUG_ON.



 page_alloc.c |   80 ++++++++++++++++++++++-------------------------------------
 1 files changed, 30 insertions(+), 50 deletions(-)

--- 2.5.24/mm/page_alloc.c~free-pages-check	Thu Jul  4 16:17:33 2002
+++ 2.5.24-akpm/mm/page_alloc.c	Thu Jul  4 16:17:33 2002
@@ -86,23 +86,24 @@ static void __free_pages_ok (struct page
 	struct page *base;
 	zone_t *zone;
 
-	if (PagePrivate(page))
-		BUG();
-	if (page->mapping)
-		BUG();
-	if (PageLocked(page))
-		BUG();
-	if (PageLRU(page))
-		BUG();
-	if (PageActive(page))
-		BUG();
-	if (PageWriteback(page))
-		BUG();
-	ClearPageDirty(page);
-
-	if (current->flags & PF_FREE_PAGES)
-		goto local_freelist;
- back_local_freelist:
+	BUG_ON(PagePrivate(page));
+	BUG_ON(page->mapping != NULL);
+	BUG_ON(PageLocked(page));
+	BUG_ON(PageLRU(page));
+	BUG_ON(PageActive(page));
+	BUG_ON(PageWriteback(page));
+	if (PageDirty(page))
+		ClearPageDirty(page);
+	BUG_ON(page_count(page) != 0);
+
+	if (unlikely(current->flags & PF_FREE_PAGES)) {
+		if (!current->nr_local_pages && !in_interrupt()) {
+			list_add(&page->list, &current->local_pages);
+			page->index = order;
+			current->nr_local_pages++;
+			goto out;
+		}
+	}
 
 	zone = page_zone(page);
 
@@ -112,18 +113,14 @@ static void __free_pages_ok (struct page
 	if (page_idx & ~mask)
 		BUG();
 	index = page_idx >> (1 + order);
-
 	area = zone->free_area + order;
 
 	spin_lock_irqsave(&zone->lock, flags);
-
 	zone->free_pages -= mask;
-
 	while (mask + (1 << (MAX_ORDER-1))) {
 		struct page *buddy1, *buddy2;
 
-		if (area >= zone->free_area + MAX_ORDER)
-			BUG();
+		BUG_ON(area >= zone->free_area + MAX_ORDER);
 		if (!__test_and_change_bit(index, area->map))
 			/*
 			 * the buddy page is still allocated.
@@ -136,11 +133,8 @@ static void __free_pages_ok (struct page
 		 */
 		buddy1 = base + (page_idx ^ -mask);
 		buddy2 = base + page_idx;
-		if (bad_range(zone, buddy1))
-			BUG();
-		if (bad_range(zone, buddy2))
-			BUG();
-
+		BUG_ON(bad_range(zone, buddy1));
+		BUG_ON(bad_range(zone, buddy2));
 		list_del(&buddy1->list);
 		mask <<= 1;
 		area++;
@@ -148,19 +142,9 @@ static void __free_pages_ok (struct page
 		page_idx &= mask;
 	}
 	list_add(&(base + page_idx)->list, &area->free_list);
-
 	spin_unlock_irqrestore(&zone->lock, flags);
+out:
 	return;
-
- local_freelist:
-	if (current->nr_local_pages)
-		goto back_local_freelist;
-	if (in_interrupt())
-		goto back_local_freelist;		
-
-	list_add(&page->list, &current->local_pages);
-	page->index = order;
-	current->nr_local_pages++;
 }
 
 #define MARK_USED(index, order, area) \
@@ -172,8 +156,7 @@ static inline struct page * expand (zone
 	unsigned long size = 1 << high;
 
 	while (high > low) {
-		if (bad_range(zone, page))
-			BUG();
+		BUG_ON(bad_range(zone, page));
 		area--;
 		high--;
 		size >>= 1;
@@ -182,8 +165,7 @@ static inline struct page * expand (zone
 		index += size;
 		page += size;
 	}
-	if (bad_range(zone, page))
-		BUG();
+	BUG_ON(bad_range(zone, page));
 	return page;
 }
 
@@ -223,8 +205,7 @@ static struct page * rmqueue(zone_t *zon
 			unsigned int index;
 
 			page = list_entry(curr, struct page, list);
-			if (bad_range(zone, page))
-				BUG();
+			BUG_ON(bad_range(zone, page));
 			list_del(curr);
 			index = page - zone->zone_mem_map;
 			if (curr_order != MAX_ORDER-1)
@@ -279,14 +260,14 @@ struct page *_alloc_pages(unsigned int g
 }
 #endif
 
-static struct page * FASTCALL(balance_classzone(zone_t *, unsigned int, unsigned int, int *));
-static struct page * balance_classzone(zone_t * classzone, unsigned int gfp_mask, unsigned int order, int * freed)
+static /* inline */ struct page *
+balance_classzone(zone_t * classzone, unsigned int gfp_mask,
+			unsigned int order, int * freed)
 {
 	struct page * page = NULL;
 	int __freed = 0;
 
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 
 	current->allocation_order = order;
 	current->flags |= PF_MEMALLOC | PF_FREE_PAGES;
@@ -793,8 +774,7 @@ void __init free_area_init_core(int nid,
 	unsigned long totalpages, offset, realtotalpages;
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 
-	if (zone_start_paddr & ~PAGE_MASK)
-		BUG();
+	BUG_ON(zone_start_paddr & ~PAGE_MASK);
 
 	totalpages = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {

-
