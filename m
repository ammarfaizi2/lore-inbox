Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316915AbSFBWZ2>; Sun, 2 Jun 2002 18:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317018AbSFBWZ1>; Sun, 2 Jun 2002 18:25:27 -0400
Received: from holomorphy.com ([66.224.33.161]:34210 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316915AbSFBWZ0>;
	Sun, 2 Jun 2002 18:25:26 -0400
Date: Sun, 2 Jun 2002 15:25:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: convert page_alloc.c bugchecks to BUG_ON()
Message-ID: <20020602222504.GN14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given the BUG_ON() framework it is possible to reduce the number of
lines of code within page_alloc.c by converting many of its integrity
checks to use the BUG_ON() macro. This patch does so.


Against 2.5.19.


Cheers,
Bill


===== mm/page_alloc.c 1.68 vs edited =====
--- 1.68/mm/page_alloc.c	Sun Jun  2 15:15:46 2002
+++ edited/mm/page_alloc.c	Sun Jun  2 15:23:27 2002
@@ -85,18 +85,12 @@
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
 
@@ -109,8 +103,7 @@
 	mask = (~0UL) << order;
 	base = zone->zone_mem_map;
 	page_idx = page - base;
-	if (page_idx & ~mask)
-		BUG();
+	BUG_ON(page_idx & ~mask);
 	index = page_idx >> (1 + order);
 
 	area = zone->free_area + order;
@@ -122,8 +115,7 @@
 	while (mask + (1 << (MAX_ORDER-1))) {
 		struct page *buddy1, *buddy2;
 
-		if (area >= zone->free_area + MAX_ORDER)
-			BUG();
+		BUG_ON(area >= zone->free_area + MAX_ORDER);
 		if (!__test_and_change_bit(index, area->map))
 			/*
 			 * the buddy page is still allocated.
@@ -136,10 +128,8 @@
 		 */
 		buddy1 = base + (page_idx ^ -mask);
 		buddy2 = base + page_idx;
-		if (BAD_RANGE(zone,buddy1))
-			BUG();
-		if (BAD_RANGE(zone,buddy2))
-			BUG();
+		BUG_ON(BAD_RANGE(zone,buddy1));
+		BUG_ON(BAD_RANGE(zone,buddy2));
 
 		list_del(&buddy1->list);
 		mask <<= 1;
@@ -172,8 +162,7 @@
 	unsigned long size = 1 << high;
 
 	while (high > low) {
-		if (BAD_RANGE(zone,page))
-			BUG();
+		BUG_ON(BAD_RANGE(zone,page));
 		area--;
 		high--;
 		size >>= 1;
@@ -182,8 +171,7 @@
 		index += size;
 		page += size;
 	}
-	if (BAD_RANGE(zone,page))
-		BUG();
+	BUG_ON(BAD_RANGE(zone,page));
 	return page;
 }
 
@@ -205,8 +193,7 @@
 			unsigned int index;
 
 			page = list_entry(curr, struct page, list);
-			if (BAD_RANGE(zone,page))
-				BUG();
+			BUG_ON(BAD_RANGE(zone,page));
 			list_del(curr);
 			index = page - zone->zone_mem_map;
 			if (curr_order != MAX_ORDER-1)
@@ -217,12 +204,9 @@
 			spin_unlock_irqrestore(&zone->lock, flags);
 
 			set_page_count(page, 1);
-			if (BAD_RANGE(zone,page))
-				BUG();
-			if (PageLRU(page))
-				BUG();
-			if (PageActive(page))
-				BUG();
+			BUG_ON(BAD_RANGE(zone,page));
+			BUG_ON(PageLRU(page));
+			BUG_ON(PageActive(page));
 			return page;	
 		}
 		curr_order++;
@@ -273,8 +257,7 @@
 
 	if (!(gfp_mask & __GFP_WAIT))
 		goto out;
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 
 	current->allocation_order = order;
 	current->flags |= PF_MEMALLOC | PF_FREE_PAGES;
@@ -301,21 +284,13 @@
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
-
+					BUG_ON(PagePrivate(page));
+					BUG_ON(page->mapping);
+					BUG_ON(PageLocked(page));
+					BUG_ON(PageLRU(page));
+					BUG_ON(PageActive(page));
+					BUG_ON(PageDirty(page));
+					BUG_ON(PageWriteback(page));
 					break;
 				}
 			} while ((entry = entry->next) != local_pages);
@@ -327,8 +302,7 @@
 			list_del(entry);
 			tmp = list_entry(entry, struct page, list);
 			__free_pages_ok(tmp, tmp->index);
-			if (!nr_pages--)
-				BUG();
+			BUG_ON(!nr_pages--);
 		}
 		current->nr_local_pages = 0;
 	}
@@ -799,8 +773,7 @@
 	unsigned long totalpages, offset, realtotalpages;
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 
-	if (zone_start_paddr & ~PAGE_MASK)
-		BUG();
+	BUG_ON(zone_start_paddr & ~PAGE_MASK);
 
 	totalpages = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
