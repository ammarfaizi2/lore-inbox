Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSGAM3B>; Mon, 1 Jul 2002 08:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSGAM3A>; Mon, 1 Jul 2002 08:29:00 -0400
Received: from pD9E23F89.dip.t-dialin.net ([217.226.63.137]:58532 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315503AbSGAM24>; Mon, 1 Jul 2002 08:28:56 -0400
Date: Mon, 1 Jul 2002 06:31:19 -0600
From: Lightweight patch manager <patch@luckynet.dynu.com>
Message-Id: <200207011231.g61CVJLX026313@hawkeye.luckynet.adm>
Subject: BUG_ON(x) instead of if (x) BUG() in mm/page_alloc,swap_state.c
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
X-Originating-IP: 217.86.147.102
X-Mailer: Webmin 0.93
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="--------1025526680"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
----------1025526680
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This replaces if(x) BUG() with BUG_ON(x) where necessarry, at least in mm/page_alloc.c and mm/swap_state.c

This patch is also available from http://luckynet.dynu.com/~thunder/patches/mm_pages-use-BUG_ON.patch

Index: mm/page_alloc.c
===================================================================
RCS file: /var/cvs/thunder-2.5/mm/page_alloc.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 page_alloc.c
--- mm/page_alloc.c	20 Jun 2002 22:53:44 -0000	1.1.1.1
+++ mm/page_alloc.c	1 Jul 2002 12:09:32 -0000
@@ -86,18 +86,12 @@
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
+	BUG_ON(PagePrivate(page));
+	BUG_ON(page->mapping);
+	BUG_ON(PageLocked(page));
+	BUG_ON(PageLRU(page));
+	BUG_ON(PageActive(page));
+	BUG_ON(PageWriteback(page));
 	ClearPageDirty(page);
 	page->flags &= ~(1<<PG_referenced);
 
@@ -110,8 +104,7 @@
 	mask = (~0UL) << order;
 	base = zone->zone_mem_map;
 	page_idx = page - base;
-	if (page_idx & ~mask)
-		BUG();
+	BUG_ON(page_idx & ~mask);
 	index = page_idx >> (1 + order);
 
 	area = zone->free_area + order;
@@ -123,8 +116,8 @@
 	while (mask + (1 << (MAX_ORDER-1))) {
 		struct page *buddy1, *buddy2;
 
-		if (area >= zone->free_area + MAX_ORDER)
-			BUG();
+		BUG_ON(area >= zone->free_area + MAX_ORDER);
+
 		if (!__test_and_change_bit(index, area->map))
 			/*
 			 * the buddy page is still allocated.
@@ -137,10 +130,8 @@
 		 */
 		buddy1 = base + (page_idx ^ -mask);
 		buddy2 = base + page_idx;
-		if (bad_range(zone, buddy1))
-			BUG();
-		if (bad_range(zone, buddy2))
-			BUG();
+		BUG_ON(bad_range(zone, buddy1));
+		BUG_ON(bad_range(zone, buddy2));
 
 		list_del(&buddy1->list);
 		mask <<= 1;
@@ -173,8 +164,7 @@
 	unsigned long size = 1 << high;
 
 	while (high > low) {
-		if (bad_range(zone, page))
-			BUG();
+		BUG_ON(bad_range(zone, page));
 		area--;
 		high--;
 		size >>= 1;
@@ -183,8 +173,7 @@
 		index += size;
 		page += size;
 	}
-	if (bad_range(zone, page))
-		BUG();
+	BUG_ON(bad_range(zone, page));
 	return page;
 }
 
@@ -206,8 +195,7 @@
 			unsigned int index;
 
 			page = list_entry(curr, struct page, list);
-			if (bad_range(zone, page))
-				BUG();
+			BUG_ON(bad_range(zone, page));
 			list_del(curr);
 			index = page - zone->zone_mem_map;
 			if (curr_order != MAX_ORDER-1)
@@ -218,12 +206,9 @@
 			spin_unlock_irqrestore(&zone->lock, flags);
 
 			set_page_count(page, 1);
-			if (bad_range(zone, page))
-				BUG();
-			if (PageLRU(page))
-				BUG();
-			if (PageActive(page))
-				BUG();
+			BUG_ON(bad_range(zone, page));
+			BUG_ON(PageLRU(page));
+			BUG_ON(PageActive(page));
 			return page;	
 		}
 		curr_order++;
@@ -274,8 +259,7 @@
 
 	if (!(gfp_mask & __GFP_WAIT))
 		goto out;
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 
 	current->allocation_order = order;
 	current->flags |= PF_MEMALLOC | PF_FREE_PAGES;
@@ -302,20 +286,13 @@
 					set_page_count(tmp, 1);
 					page = tmp;
 
-					if (PagePrivate(page))
-						BUG();
-					if (page->mapping)
-						BUG();
-					if (PageLocked(page))
-						BUG();
-					if (PageLRU(page))
-						BUG();
-					if (PageActive(page))
-						BUG();
-					if (PageDirty(page))
-						BUG();
-					if (PageWriteback(page))
-						BUG();
+					BUG_ON(PagePrivate(page));
+					BUG_ON(page->mapping)
+					BUG_ON(PageLocked(page))
+					BUG_ON(PageLRU(page))
+					BUG_ON(PageActive(page))
+					BUG_ON(PageDirty(page))
+					BUG_ON(PageWriteback(page))
 
 					break;
 				}
@@ -328,8 +305,7 @@
 			list_del(entry);
 			tmp = list_entry(entry, struct page, list);
 			__free_pages_ok(tmp, tmp->index);
-			if (!nr_pages--)
-				BUG();
+			BUG_ON(!nr_pages--)
 		}
 		current->nr_local_pages = 0;
 	}
@@ -800,8 +776,7 @@
 	unsigned long totalpages, offset, realtotalpages;
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 
-	if (zone_start_paddr & ~PAGE_MASK)
-		BUG();
+	BUG_ON(zone_start_paddr & ~PAGE_MASK);
 
 	totalpages = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
Index: mm/swap_state.c
===================================================================
RCS file: /var/cvs/thunder-2.5/mm/swap_state.c,v
retrieving revision 1.2
diff -u -r1.2 swap_state.c
--- mm/swap_state.c	22 Jun 2002 11:09:20 -0000	1.2
+++ mm/swap_state.c	1 Jul 2002 12:10:46 -0000
@@ -76,8 +76,7 @@
 {
 	int error;
 
-	if (page->mapping)
-		BUG();
+	BUG_ON(page->mapping);
 	if (!swap_duplicate(entry)) {
 		INC_CACHE_INFO(noent_race);
 		return -ENOENT;
@@ -90,10 +89,8 @@
 			INC_CACHE_INFO(exist_race);
 		return error;
 	}
-	if (!PageLocked(page))
-		BUG();
-	if (!PageSwapCache(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
+	BUG_ON(!PageSwapCache(page));
 	INC_CACHE_INFO(add_total);
 	return 0;
 }
@@ -142,8 +139,7 @@
 	void **pslot;
 	int err;
 
-	if (!mapping)
-		BUG();
+	BUG_ON(!mapping);
 
 	if (!swap_duplicate(entry)) {
 		INC_CACHE_INFO(noent_race);
----------1025526680--
