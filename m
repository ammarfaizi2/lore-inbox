Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWARKky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWARKky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWARKky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:40:54 -0500
Received: from ns2.suse.de ([195.135.220.15]:18401 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932455AbWARKkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:40:53 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>
Message-Id: <20060118024128.10241.82524.sendpatchset@linux.site>
In-Reply-To: <20060118024106.10241.69438.sendpatchset@linux.site>
References: <20060118024106.10241.69438.sendpatchset@linux.site>
Subject: [patch 2/4] mm: PageLRU no testset
Date: Wed, 18 Jan 2006 11:40:47 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PG_lru is protected by zone->lru_lock. It does not need TestSet/TestClear
operations.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -775,9 +775,10 @@ int isolate_lru_page(struct page *page)
 	if (PageLRU(page)) {
 		struct zone *zone = page_zone(page);
 		spin_lock_irq(&zone->lru_lock);
-		if (TestClearPageLRU(page)) {
+		if (PageLRU(page)) {
 			ret = 1;
 			get_page(page);
+			ClearPageLRU(page);
 			if (PageActive(page))
 				del_page_from_active_list(zone, page);
 			else
@@ -881,8 +882,8 @@ static void shrink_cache(struct zone *zo
 		 */
 		while (!list_empty(&page_list)) {
 			page = lru_to_page(&page_list);
-			if (TestSetPageLRU(page))
-				BUG();
+			BUG_ON(PageLRU(page));
+			SetPageLRU(page);
 			list_del(&page->lru);
 			if (PageActive(page))
 				add_page_to_active_list(zone, page);
@@ -994,8 +995,8 @@ refill_inactive_zone(struct zone *zone, 
 	while (!list_empty(&l_inactive)) {
 		page = lru_to_page(&l_inactive);
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
-		if (TestSetPageLRU(page))
-			BUG();
+		BUG_ON(PageLRU(page));
+		SetPageLRU(page);
 		if (!TestClearPageActive(page))
 			BUG();
 		list_move(&page->lru, &zone->inactive_list);
@@ -1023,8 +1024,8 @@ refill_inactive_zone(struct zone *zone, 
 	while (!list_empty(&l_active)) {
 		page = lru_to_page(&l_active);
 		prefetchw_prev_lru_page(page, &l_active, flags);
-		if (TestSetPageLRU(page))
-			BUG();
+		BUG_ON(PageLRU(page));
+		SetPageLRU(page);
 		BUG_ON(!PageActive(page));
 		list_move(&page->lru, &zone->active_list);
 		pgmoved++;
Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c
+++ linux-2.6/mm/swap.c
@@ -203,8 +203,8 @@ void fastcall __page_cache_release(struc
 
 		struct zone *zone = page_zone(page);
 		spin_lock_irqsave(&zone->lru_lock, flags);
-		if (!TestClearPageLRU(page))
-			BUG();
+		BUG_ON(!PageLRU(page));
+		ClearPageLRU(page);
 		del_page_from_lru(zone, page);
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
@@ -247,8 +247,8 @@ void release_pages(struct page **pages, 
 				zone = pagezone;
 				spin_lock_irq(&zone->lru_lock);
 			}
-			if (!TestClearPageLRU(page))
-				BUG();
+			BUG_ON(!PageLRU(page));
+			ClearPageLRU(page);
 			del_page_from_lru(zone, page);
 		}
 
@@ -327,8 +327,8 @@ void __pagevec_lru_add(struct pagevec *p
 			zone = pagezone;
 			spin_lock_irq(&zone->lru_lock);
 		}
-		if (TestSetPageLRU(page))
-			BUG();
+		BUG_ON(PageLRU(page));
+		SetPageLRU(page);
 		add_page_to_inactive_list(zone, page);
 	}
 	if (zone)
@@ -354,8 +354,8 @@ void __pagevec_lru_add_active(struct pag
 			zone = pagezone;
 			spin_lock_irq(&zone->lru_lock);
 		}
-		if (TestSetPageLRU(page))
-			BUG();
+		BUG_ON(PageLRU(page));
+		SetPageLRU(page);
 		if (TestSetPageActive(page))
 			BUG();
 		add_page_to_active_list(zone, page);
Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -244,10 +244,9 @@ extern void __mod_page_state_offset(unsi
 #define __ClearPageDirty(page)	__clear_bit(PG_dirty, &(page)->flags)
 #define TestClearPageDirty(page) test_and_clear_bit(PG_dirty, &(page)->flags)
 
-#define SetPageLRU(page)	set_bit(PG_lru, &(page)->flags)
 #define PageLRU(page)		test_bit(PG_lru, &(page)->flags)
-#define TestSetPageLRU(page)	test_and_set_bit(PG_lru, &(page)->flags)
-#define TestClearPageLRU(page)	test_and_clear_bit(PG_lru, &(page)->flags)
+#define SetPageLRU(page)	set_bit(PG_lru, &(page)->flags)
+#define ClearPageLRU(page)	clear_bit(PG_lru, &(page)->flags)
 
 #define PageActive(page)	test_bit(PG_active, &(page)->flags)
 #define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
