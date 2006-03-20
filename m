Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWCTNix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWCTNix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWCTNiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:38:52 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:45982 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964792AbWCTNih convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:38:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HjuGq/QNjxwPRIb7zYGELdL3OtLa6nz+xyHMy95rFfJAYRdzhYlMQSPdHJMtifbzoR6szGES1qpoE5F1WbCQpK+pbOkXlhgA2SC9vLDLr2ge/fgbDdiKjweOTDxlAt3seh9yTD6LjNu+4RaR0XJGAt3YdQ9XA7Vg2sr3gSU8Zdw=
Message-ID: <bc56f2f0603200538g3d6aa712i@mail.gmail.com>
Date: Mon, 20 Mar 2006 08:38:36 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: akpm@osdl.org
Subject: [PATCH][8/8] mm: lru interface change
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add Wired list to LRU.
Add PG_Wired bit to page.

Signed-off-by: Shaoping Wang <pwstone@gmail.com>

--
 include/linux/mm_inline.h  |   25 +++++++++++++
 include/linux/mmzone.h     |    2 +
 include/linux/page-flags.h |    9 +++++
 include/linux/swap.h       |    2 +
 mm/page_alloc.c            |    4 +-
 mm/swap.c                  |   81 +++++++++++++++++++++++++++++++++++++--------
 6 files changed, 107 insertions(+), 16 deletions(-)

diff -urN  linux-2.6.15.orig/include/linux/mm_inline.h
linux-2.6.15/include/linux/mm_inline.h
--- linux-2.6.15.orig/include/linux/mm_inline.h	2006-01-02
22:21:10.000000000 -0500
+++ linux-2.6.15/include/linux/mm_inline.h	2006-03-07 01:56:10.000000000 -0500
@@ -1,3 +1,9 @@
+/*
+ * There are 3 per-zone lists in LRU:
+ * 			Active: pages which were accessed more frequently.
+ *			Inactive: pages accessed less frequently.
+ *			Wired: pages mlocked by some tasks.
+ */

 static inline void
 add_page_to_active_list(struct zone *zone, struct page *page)
@@ -14,6 +20,13 @@
 }

 static inline void
+add_page_to_wired_list(struct zone *zone, struct page *page)
+{
+	list_add(&page->lru, &zone->wired_list);
+	zone->nr_wired++;
+}
+
+static inline void
 del_page_from_active_list(struct zone *zone, struct page *page)
 {
 	list_del(&page->lru);
@@ -28,10 +41,20 @@
 }

 static inline void
+del_page_from_wired_list(struct zone *zone, struct page *page)
+{
+	list_del(&page->lru);
+	zone->nr_wired--;
+}
+
+static inline void
 del_page_from_lru(struct zone *zone, struct page *page)
 {
 	list_del(&page->lru);
-	if (PageActive(page)) {
+	if(PageWired(page)){
+		ClearPageWired(page);
+		zone->nr_wired--;
+	} else if (PageActive(page)) {
 		ClearPageActive(page);
 		zone->nr_active--;
 	} else {
diff -urN  linux-2.6.15.orig/include/linux/mmzone.h
linux-2.6.15/include/linux/mmzone.h
--- linux-2.6.15.orig/include/linux/mmzone.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/include/linux/mmzone.h	2006-03-07 01:58:26.000000000 -0500
@@ -143,10 +143,12 @@
 	spinlock_t		lru_lock;	
 	struct list_head	active_list;
 	struct list_head	inactive_list;
+	struct list_head	wired_list; /* Pages wired. */
 	unsigned long		nr_scan_active;
 	unsigned long		nr_scan_inactive;
 	unsigned long		nr_active;
 	unsigned long		nr_inactive;
+	unsigned long		nr_wired;
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */

diff -urN  linux-2.6.15.orig/include/linux/page-flags.h
linux-2.6.15/include/linux/page-flags.h
--- linux-2.6.15.orig/include/linux/page-flags.h	2006-01-02
22:21:10.000000000 -0500
+++ linux-2.6.15/include/linux/page-flags.h	2006-03-06 06:30:07.000000000 -0500
@@ -76,6 +76,8 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */

+#define PG_wired		20  /* Page is on Wired list */
+
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
@@ -198,7 +200,14 @@
 #define __ClearPageDirty(page)	__clear_bit(PG_dirty, &(page)->flags)
 #define TestClearPageDirty(page) test_and_clear_bit(PG_dirty, &(page)->flags)

+#define SetPageWired(page)	set_bit(PG_wired, &(page)->flags)
+#define ClearPageWired(page) clear_bit(PG_wired,&(page)->flags)
+#define PageWired(page)		test_bit(PG_wired, &(page)->flags)
+#define TestSetPageWired(page)	test_and_set_bit(PG_wired, &(page)->flags)
+#define TestClearPageWired(page)	test_and_clear_bit(PG_wired, &(page)->flags)
+
 #define SetPageLRU(page)	set_bit(PG_lru, &(page)->flags)
+#define ClearPageLRU(page)	clear_bit(PG_lru, &(page)->flags)
 #define PageLRU(page)		test_bit(PG_lru, &(page)->flags)
 #define TestSetPageLRU(page)	test_and_set_bit(PG_lru, &(page)->flags)
 #define TestClearPageLRU(page)	test_and_clear_bit(PG_lru, &(page)->flags)
diff -urN  linux-2.6.15.orig/include/linux/swap.h
linux-2.6.15/include/linux/swap.h
--- linux-2.6.15.orig/include/linux/swap.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/include/linux/swap.h	2006-03-06 06:30:07.000000000 -0500
@@ -165,6 +165,8 @@
 extern void FASTCALL(lru_cache_add(struct page *));
 extern void FASTCALL(lru_cache_add_active(struct page *));
 extern void FASTCALL(activate_page(struct page *));
+extern void FASTCALL(wire_page(struct page *));
+extern void FASTCALL(unwire_page(struct page *));
 extern void FASTCALL(mark_page_accessed(struct page *));
 extern void lru_add_drain(void);
 extern int rotate_reclaimable_page(struct page *page);
diff -urN  linux-2.6.15.orig/mm/swap.c linux-2.6.15/mm/swap.c
--- linux-2.6.15.orig/mm/swap.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/swap.c	2006-03-07 11:45:37.000000000 -0500
@@ -110,6 +110,44 @@
 	spin_unlock_irq(&zone->lru_lock);
 }

+/* Wire the page; if the page is in LRU,
+ * try move it to Wired list.
+ */
+void fastcall wire_page(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+
+	spin_lock_irq(&zone->lru_lock);
+	page->wired_count ++;
+	if(!PageWired(page)){
+		if(PageLRU(page)){
+			del_page_from_lru(zone, page);
+			add_page_to_wired_list(zone,page);
+			SetPageWired(page);
+		}
+	}
+	spin_unlock_irq(&zone->lru_lock);
+}
+
+/* Unwire the page.
+ * If it isnt wired by any process, try move it to active list.
+ */
+void fastcall unwire_page(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+
+	spin_lock_irq(&zone->lru_lock);
+	page->wired_count --;
+	if(!page->wired_count){
+		if(PageLRU(page) && TestClearPageWired(page)){
+			del_page_from_wired_list(zone,page);
+			add_page_to_active_list(zone,page);
+			SetPageActive(page);
+		}
+	}
+	spin_unlock_irq(&zone->lru_lock);
+}
+
 /*
  * Mark a page as having seen activity.
  *
@@ -119,11 +157,13 @@
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
-		ClearPageReferenced(page);
-	} else if (!PageReferenced(page)) {
-		SetPageReferenced(page);
+	if(!PageWired(page)) {
+		if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
+			activate_page(page);
+			ClearPageReferenced(page);
+		} else if (!PageReferenced(page)) {
+			SetPageReferenced(page);
+		}
 	}
 }

@@ -178,13 +218,15 @@
 	struct zone *zone = page_zone(page);

 	spin_lock_irqsave(&zone->lru_lock, flags);
-	if (TestClearPageLRU(page))
-		del_page_from_lru(zone, page);
-	if (page_count(page) != 0)
-		page = NULL;
+	if(!PageWired(page)) {
+		if (TestClearPageLRU(page))
+			del_page_from_lru(zone, page);
+		if (page_count(page) != 0)
+			page = NULL;
+		if (page)
+			free_hot_page(page);
+	}
 	spin_unlock_irqrestore(&zone->lru_lock, flags);
-	if (page)
-		free_hot_page(page);
 }

 EXPORT_SYMBOL(__page_cache_release);
@@ -214,7 +256,8 @@

 		if (!put_page_testzero(page))
 			continue;
-
+		if(PageWired(page))
+			continue;
 		pagezone = page_zone(page);
 		if (pagezone != zone) {
 			if (zone)
@@ -301,7 +344,12 @@
 		}
 		if (TestSetPageLRU(page))
 			BUG();
-		add_page_to_inactive_list(zone, page);
+		if(!page->wired_count)
+			add_page_to_inactive_list(zone, page);
+		else {
+			SetPageWired(page);
+			add_page_to_wired_list(zone,page);
+		}
 	}
 	if (zone)
 		spin_unlock_irq(&zone->lru_lock);
@@ -330,7 +378,12 @@
 			BUG();
 		if (TestSetPageActive(page))
 			BUG();
-		add_page_to_active_list(zone, page);
+		if(!page->wired_count)
+			add_page_to_active_list(zone, page);
+		else{
+			SetPageWired(page);
+			add_page_to_wired_list(zone,page);
+		}
 	}
 	if (zone)
 		spin_unlock_irq(&zone->lru_lock);
diff -urN  linux-2.6.15.orig/mm/page_alloc.c linux-2.6.15/mm/page_alloc.c
--- linux-2.6.15.orig/mm/page_alloc.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/page_alloc.c	2006-03-06 06:30:08.000000000 -0500
@@ -348,7 +348,8 @@
 			1 << PG_slab	|
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_reserved )))
+			1 << PG_reserved |
+			1 << PG_wired )))
 		bad_page(function, page);
 	if (PageDirty(page))
 		__ClearPageDirty(page);
@@ -481,6 +482,7 @@
 			1 << PG_private	|
 			1 << PG_locked	|
 			1 << PG_active	|
+			1 << PG_wired   |
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
 			1 << PG_slab    |
