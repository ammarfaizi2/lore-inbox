Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbUKUWjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUKUWjp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 17:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUKUWj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 17:39:27 -0500
Received: from [213.85.13.118] ([213.85.13.118]:6277 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261826AbUKUWhv (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 17:37:51 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2sYXY3mrKJ"
Content-Transfer-Encoding: 7bit
Message-ID: <16801.6313.996546.52706@gargle.gargle.HOWL>
Date: Mon, 22 Nov 2004 01:37:29 +0300
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH]: 2/4 mm/swap.c cleanup
In-Reply-To: <20041121131343.333716cd.akpm@osdl.org>
References: <16800.47052.733779.713175@gargle.gargle.HOWL>
	<20041121131343.333716cd.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2sYXY3mrKJ
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Andrew Morton writes:
 > Nikita Danilov <nikita@clusterfs.com> wrote:
 > >
 > > +#define pagevec_for_each_page(_v, _i, _p, _z)				\
 > >  +for (_i = 0, _z = NULL;							\
 > >  +     ((_i) < pagevec_count(_v) && (__guardloop(_v, _i, _p, _z), 1)) ||	\
 > >  +     (__postloop(_v, _i, _p, _z), 0);					\
 > >  +     (_i)++)
 > 
 > Sorry, this looks more like a dirtyup to me ;)

Don't tell me you are not great fan on comma operator abuse. :)

Anyway, idea is that by hiding complexity it loop macro, we get rid of a
maze of pvec-loops in swap.c all alike.

Attached is next, more typeful variant. Compilebootentested.

Nikita.

--2sYXY3mrKJ
Content-Type: text/plain
Content-Disposition: inline;
	filename="pvec-cleanup.patch"
Content-Transfer-Encoding: 7bit


Add pagevec_for_each_page() macro to iterate over all pages in a
pagevec. Non-trivial part is to keep track of page zone and relock
zone->lru_lock when switching to new zone.

This simplifies functions in mm/swap.c that process pages from pvec in a
batch.

Signed-off-by: Nikita Danilov <nikita@clusterfs.com>


 include/linux/pagevec.h |   14 ++++++++
 mm/swap.c               |   83 ++++++++++++++++++++++++------------------------
 2 files changed, 57 insertions(+), 40 deletions(-)

diff -puN include/linux/pagevec.h~pvec-cleanup include/linux/pagevec.h
--- bk-linux/include/linux/pagevec.h~pvec-cleanup	2004-11-21 18:59:59.000000000 +0300
+++ bk-linux-nikita/include/linux/pagevec.h	2004-11-22 01:13:54.000000000 +0300
@@ -83,3 +83,17 @@ static inline void pagevec_lru_add(struc
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
 }
+
+struct page *__pagevec_loop_next(struct pagevec *pvec,
+				 struct zone **zone, int *i);
+
+/*
+ * Macro to iterate over all pages in pvec. Body of a loop is invoked with
+ * page's zone ->lru_lock held. This is used by various function in mm/swap.c
+ * to batch per-page operations that whould otherwise had to acquire hot
+ * zone->lru_lock for each page.
+ */
+#define pagevec_for_each_page(pvec, i, page, zone)			\
+	for ((i) = 0, (zone) = NULL;					\
+	     ((page) = __pagevec_loop_next((pvec), &(zone), &(i))) != NULL; \
+	     ++ (i))
diff -puN mm/swap.c~pvec-cleanup mm/swap.c
--- bk-linux/mm/swap.c~pvec-cleanup	2004-11-21 18:59:59.000000000 +0300
+++ bk-linux-nikita/mm/swap.c	2004-11-22 01:19:17.758782008 +0300
@@ -55,6 +55,39 @@ EXPORT_SYMBOL(put_page);
 #endif
 
 /*
+ * Helper function for include/linux/pagevec.h:pagevec_for_each_page macro.
+ *
+ * Returns @i-th page from @pvec, with page zone locked. @zone points to
+ * previously locked zone, it's updated (and zone is re-locked) if zone is
+ * changed.
+ */
+struct page *__pagevec_loop_next(struct pagevec *pvec,
+				 struct zone **zone, int *i)
+{
+	struct page *page;
+	struct zone *next_zone;
+	struct zone *prev_zone;
+
+	prev_zone = *zone;
+	if (*i < pagevec_count(pvec)) {
+
+		page = pvec->pages[*i];
+		next_zone = page_zone(page);
+		if (next_zone != prev_zone) {
+			if (prev_zone != NULL)
+				spin_unlock_irq(&prev_zone->lru_lock);
+			*zone = next_zone;
+			spin_lock_irq(&next_zone->lru_lock);
+		}
+	} else {
+		page = NULL;
+		if (prev_zone != NULL)
+			spin_unlock_irq(&prev_zone->lru_lock);
+	}
+	return page;
+}
+
+/*
  * Writeback is about to end against a page which has been marked for immediate
  * reclaim.  If it still appears to be reclaimable, move it to the tail of the
  * inactive list.  The page still has PageWriteback set, which will pin it.
@@ -116,19 +149,11 @@ void fastcall activate_page(struct page 
 static void __pagevec_mark_accessed(struct pagevec *pvec)
 {
 	int i;
-	struct zone *zone = NULL;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-		struct zone *pagezone = page_zone(page);
+	struct zone *zone;
+	struct page *page;
 
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
@@ -138,8 +163,6 @@ static void __pagevec_mark_accessed(stru
 			SetPageReferenced(page);
 		}
 	}
-	if (zone)
-		local_unlock_irq(&zone->lru_lock);
 	release_pages(pvec->pages, pvec->nr, pvec->cold);
 	pagevec_reinit(pvec);
 }
@@ -322,25 +345,15 @@ void __pagevec_release_nonlru(struct pag
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
@@ -350,26 +363,16 @@ EXPORT_SYMBOL(__pagevec_lru_add);
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

--2sYXY3mrKJ--
