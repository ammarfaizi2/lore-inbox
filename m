Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267399AbUGNOC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267399AbUGNOC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267387AbUGNOC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:02:28 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:444 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267399AbUGNOCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:02:24 -0400
Date: Wed, 14 Jul 2004 23:02:07 +0900 (JST)
Message-Id: <20040714.230207.133014512.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: Re: [PATCH] memory hotremoval for linux-2.6.7 [1/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- linux-2.6.7.ORG/include/linux/mm_inline.h	Sat Jul 10 12:42:43 2032
+++ linux-2.6.7/include/linux/mm_inline.h	Sat Jul 10 12:34:19 2032
@@ -38,3 +38,42 @@ del_page_from_lru(struct zone *zone, str
 		zone->nr_inactive--;
 	}
 }
+
+static inline struct page *
+steal_page_from_lru(struct zone *zone, struct page *page)
+{
+	if (!TestClearPageLRU(page))
+		BUG();
+	list_del(&page->lru);
+	if (get_page_testone(page)) {
+		/*
+		 * It was already free!  release_pages() or put_page()
+		 * are about to remove it from the LRU and free it. So
+		 * put the refcount back and put the page back on the
+		 * LRU
+		 */
+		__put_page(page);
+		SetPageLRU(page);
+		if (PageActive(page))
+			list_add(&page->lru, &zone->active_list);
+		else
+			list_add(&page->lru, &zone->inactive_list);
+		return NULL;
+	}
+	if (PageActive(page))
+		zone->nr_active--;
+	else
+		zone->nr_inactive--;
+	return page;
+}
+
+static inline void
+putback_page_to_lru(struct zone *zone, struct page *page)
+{
+	if (TestSetPageLRU(page))
+		BUG();
+	if (PageActive(page))
+		add_page_to_active_list(zone, page);
+	else
+		add_page_to_inactive_list(zone, page);
+}
--- linux-2.6.7.ORG/mm/vmscan.c	Sat Jul 10 12:42:43 2032
+++ linux-2.6.7/mm/vmscan.c	Sat Jul 10 12:41:29 2032
@@ -557,23 +557,11 @@ static void shrink_cache(struct zone *zo
 
 			prefetchw_prev_lru_page(page,
 						&zone->inactive_list, flags);
-
-			if (!TestClearPageLRU(page))
-				BUG();
-			list_del(&page->lru);
-			if (get_page_testone(page)) {
-				/*
-				 * It is being freed elsewhere
-				 */
-				__put_page(page);
-				SetPageLRU(page);
-				list_add(&page->lru, &zone->inactive_list);
+			if (steal_page_from_lru(zone, page) == NULL)
 				continue;
-			}
 			list_add(&page->lru, &page_list);
 			nr_taken++;
 		}
-		zone->nr_inactive -= nr_taken;
 		zone->pages_scanned += nr_taken;
 		spin_unlock_irq(&zone->lru_lock);
 
@@ -596,13 +584,8 @@ static void shrink_cache(struct zone *zo
 		 */
 		while (!list_empty(&page_list)) {
 			page = lru_to_page(&page_list);
-			if (TestSetPageLRU(page))
-				BUG();
 			list_del(&page->lru);
-			if (PageActive(page))
-				add_page_to_active_list(zone, page);
-			else
-				add_page_to_inactive_list(zone, page);
+			putback_page_to_lru(zone, page);
 			if (!pagevec_add(&pvec, page)) {
 				spin_unlock_irq(&zone->lru_lock);
 				__pagevec_release(&pvec);
@@ -655,26 +638,12 @@ refill_inactive_zone(struct zone *zone, 
 	while (pgscanned < nr_pages && !list_empty(&zone->active_list)) {
 		page = lru_to_page(&zone->active_list);
 		prefetchw_prev_lru_page(page, &zone->active_list, flags);
-		if (!TestClearPageLRU(page))
-			BUG();
-		list_del(&page->lru);
-		if (get_page_testone(page)) {
-			/*
-			 * It was already free!  release_pages() or put_page()
-			 * are about to remove it from the LRU and free it. So
-			 * put the refcount back and put the page back on the
-			 * LRU
-			 */
-			__put_page(page);
-			SetPageLRU(page);
-			list_add(&page->lru, &zone->active_list);
-		} else {
+		if (steal_page_from_lru(zone, page) != NULL) {
 			list_add(&page->lru, &l_hold);
 			pgmoved++;
 		}
 		pgscanned++;
 	}
-	zone->nr_active -= pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 
 	/*
