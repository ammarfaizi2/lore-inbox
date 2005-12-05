Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVLEL77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVLEL77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 06:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVLEL77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 06:59:59 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:36199 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932379AbVLEL76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 06:59:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=lx+5se6qjOpINkv0vj+qMhJT7pxoMbqX5ONJLDdyxy8Jder9Gy4GFEMHYp33NOBk6GkjfmxIHct0ZPxlvZQTiL+UlekcrO9byPDtJpqDMb+zcnoXa3G471jMzXZHg2NLqjOieA/kK6M7E18JZVUslyEYT8kzyPoaEzZwoMGZffs=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051205115939.3480.92812.sendpatchset@didi.local0.net>
In-Reply-To: <20051205115901.3480.60596.sendpatchset@didi.local0.net>
References: <20051205115901.3480.60596.sendpatchset@didi.local0.net>
Subject: [patch 2/4] mm: PageLRU no testset
Date: Mon, 5 Dec 2005 06:59:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PG_lru is protected by zone->lru_lock. It does not need TestSet/TestClear
operations.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -666,8 +666,8 @@ static void shrink_cache(struct zone *zo
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
@@ -779,8 +779,8 @@ refill_inactive_zone(struct zone *zone, 
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
@@ -808,8 +808,8 @@ refill_inactive_zone(struct zone *zone, 
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
@@ -179,8 +179,8 @@ void fastcall __page_cache_release(struc
 
 		struct zone *zone = page_zone(page);
 		spin_lock_irqsave(&zone->lru_lock, flags);
-		if (!TestClearPageLRU(page))
-			BUG();
+		BUG_ON(!PageLRU(page));
+		ClearPageLRU(page);
 		del_page_from_lru(zone, page);
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
@@ -224,8 +224,8 @@ void release_pages(struct page **pages, 
 				zone = pagezone;
 				spin_lock_irq(&zone->lru_lock);
 			}
-			if (!TestClearPageLRU(page))
-				BUG();
+			BUG_ON(!PageLRU(page));
+			ClearPageLRU(page);
 			del_page_from_lru(zone, page);
 		}
 		BUG_ON(page_count(page));
@@ -305,8 +305,8 @@ void __pagevec_lru_add(struct pagevec *p
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
@@ -332,8 +332,8 @@ void __pagevec_lru_add_active(struct pag
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
@@ -233,10 +233,9 @@ extern void __mod_page_state_offset(unsi
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
Send instant messages to your online friends http://au.messenger.yahoo.com 
