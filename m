Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbUKUPtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbUKUPtr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 10:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbUKUPtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:49:00 -0500
Received: from [213.85.13.118] ([213.85.13.118]:13955 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261675AbUKUPoj (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 21 Nov 2004 10:44:39 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16800.47052.733779.713175@gargle.gargle.HOWL>
Date: Sun, 21 Nov 2004 18:44:12 +0300
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Cc: Andrew Morton <AKPM@Osdl.ORG>, Linux MM Mailing List <linux-mm@kvack.org>
Subject: [PATCH]: 2/4 mm/swap.c cleanup
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add pagevec_for_each_page() macro to iterate over all pages in a
pagevec. Non-trivial part is to keep track of page zone and relock
zone->lru_lock when switching to new zone.

This simplifies functions in mm/swap.c that process pages from pvec in a
batch.

(Patch is for 2.6.10-rc2)

Signed-off-by: Nikita Danilov <nikita@clusterfs.com>

 include/linux/pagevec.h |   45 +++++++++++++++++++++++++++++++++++++++++++
 mm/swap.c               |   50 +++++++++---------------------------------------
 2 files changed, 55 insertions(+), 40 deletions(-)

diff -puN include/linux/pagevec.h~pvec-cleanup include/linux/pagevec.h
--- bk-linux/include/linux/pagevec.h~pvec-cleanup	2004-11-21 17:01:02.606535952 +0300
+++ bk-linux-nikita/include/linux/pagevec.h	2004-11-21 17:01:02.611535192 +0300
@@ -83,3 +83,48 @@ static inline void pagevec_lru_add(struc
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
 }
+
+/*
+ * Helper macro for pagevec_for_each_page(). This is called on each
+ * iteration before entering loop body. Checks if we are switching to
+ * the new zone so that ->lru_lock should be re-taken.
+ */
+#define __guardloop(_v, _i, _p, _z)				\
+({								\
+	struct zone *pagezone;					\
+								\
+	_p = (_v)->pages[i];					\
+	pagezone = page_zone(_p);				\
+								\
+	if (pagezone != (_z)) {					\
+		if (_z)						\
+			spin_unlock_irq(&(_z)->lru_lock);	\
+		_z = pagezone;					\
+		spin_lock_irq(&(_z)->lru_lock);		\
+	}							\
+})
+
+/*
+ * Helper macro for pagevec_for_each_page(). This is called after last
+ * iteration to release zone->lru_lock if necessary.
+ */
+#define __postloop(_v, _i, _p, _z)			\
+({							\
+	if ((_z) != NULL)				\
+		spin_unlock_irq(&(_z)->lru_lock);	\
+})
+
+/*
+ * Macro to iterate over all pages in pvec. Body of a loop is invoked with
+ * page's zone ->lru_lock held. This is used by various function in mm/swap.c
+ * to batch per-page operations that whould otherwise had to acquire hot
+ * zone->lru_lock for each page.
+ *
+ * This uses ugly preprocessor magic, but that's what preprocessor is all
+ * about.
+ */
+#define pagevec_for_each_page(_v, _i, _p, _z)				\
+for (_i = 0, _z = NULL;							\
+     ((_i) < pagevec_count(_v) && (__guardloop(_v, _i, _p, _z), 1)) ||	\
+     (__postloop(_v, _i, _p, _z), 0);					\
+     (_i)++)
diff -puN mm/swap.c~pvec-cleanup mm/swap.c
--- bk-linux/mm/swap.c~pvec-cleanup	2004-11-21 17:01:02.609535496 +0300
+++ bk-linux-nikita/mm/swap.c	2004-11-21 17:01:02.611535192 +0300
@@ -116,19 +116,11 @@ void fastcall activate_page(struct page 
 static void __pagevec_mark_accessed(struct pagevec *pvec)
 {
 	int i;
-	struct zone *zone = NULL;
+	struct zone *zone;
+	struct page *page;
 
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-		struct zone *pagezone = page_zone(page);
-
-		if (pagezone != zone) {
-			if (zone)
-				local_unlock_irq(&zone->lru_lock);
-			zone = pagezone;
-			local_lock_irq(&zone->lru_lock);
-		}
-		if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
+	pagevec_for_each_page(pvec, i, page, zone) {
+		if (!PageActive(page) && PageReferenced(page) && PageLRU(page)){
 			del_page_from_inactive_list(zone, page);
 			SetPageActive(page);
 			add_page_to_active_list(zone, page);
@@ -138,8 +130,6 @@ static void __pagevec_mark_accessed(stru
 			SetPageReferenced(page);
 		}
 	}
-	if (zone)
-		local_unlock_irq(&zone->lru_lock);
 	release_pages(pvec->pages, pvec->nr, pvec->cold);
 	pagevec_reinit(pvec);
 }
@@ -322,25 +312,15 @@ void __pagevec_release_nonlru(struct pag
 void __pagevec_lru_add(struct pagevec *pvec)
 {
 	int i;
-	struct zone *zone = NULL;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-		struct zone *pagezone = page_zone(page);
+	struct page *page;
+	struct zone *zone;
 
-		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
-			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
-		}
+	pagevec_for_each_page(pvec, i, page, zone) {
 		if (TestSetPageLRU(page))
 			BUG();
 		ClearPageSkipped(page);
 		add_page_to_inactive_list(zone, page);
 	}
-	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
 	release_pages(pvec->pages, pvec->nr, pvec->cold);
 	pagevec_reinit(pvec);
 }
@@ -350,26 +330,16 @@ EXPORT_SYMBOL(__pagevec_lru_add);
 void __pagevec_lru_add_active(struct pagevec *pvec)
 {
 	int i;
-	struct zone *zone = NULL;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-		struct zone *pagezone = page_zone(page);
+	struct page *page;
+	struct zone *zone;
 
-		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
-			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
-		}
+	pagevec_for_each_page(pvec, i, page, zone) {
 		if (TestSetPageLRU(page))
 			BUG();
 		if (TestSetPageActive(page))
 			BUG();
 		add_page_to_active_list(zone, page);
 	}
-	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
 	release_pages(pvec->pages, pvec->nr, pvec->cold);
 	pagevec_reinit(pvec);
 }

_
