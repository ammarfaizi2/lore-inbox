Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbUKUPvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbUKUPvu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 10:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbUKUPuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:50:23 -0500
Received: from [213.85.13.118] ([213.85.13.118]:13187 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261736AbUKUPof (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 21 Nov 2004 10:44:35 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16800.47044.75874.56255@gargle.gargle.HOWL>
Date: Sun, 21 Nov 2004 18:44:04 +0300
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Cc: Andrew Morton <AKPM@Osdl.ORG>, Linux MM Mailing List <linux-mm@kvack.org>
Subject: [PATCH]: 1/4 batch mark_page_accessed()
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Batch mark_page_accessed() (a la lru_cache_add() and lru_cache_add_active()):
page to be marked accessed is placed into per-cpu pagevec
(page_accessed_pvec). When pagevec is filled up, all pages are processed in a
batch.

This is supposed to decrease contention on zone->lru_lock.

(Patch is for 2.6.10-rc2)

Signed-off-by: Nikita Danilov <nikita@clusterfs.com>

 mm/swap.c |   47 ++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 40 insertions(+), 7 deletions(-)

diff -puN mm/swap.c~batch-mark_page_accessed mm/swap.c
--- bk-linux/mm/swap.c~batch-mark_page_accessed	2004-11-21 17:01:02.061618792 +0300
+++ bk-linux-nikita/mm/swap.c	2004-11-21 17:01:02.063618488 +0300
@@ -113,6 +113,39 @@ void fastcall activate_page(struct page 
 	spin_unlock_irq(&zone->lru_lock);
 }
 
+static void __pagevec_mark_accessed(struct pagevec *pvec)
+{
+	int i;
+	struct zone *zone = NULL;
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+		struct zone *pagezone = page_zone(page);
+
+		if (pagezone != zone) {
+			if (zone)
+				local_unlock_irq(&zone->lru_lock);
+			zone = pagezone;
+			local_lock_irq(&zone->lru_lock);
+		}
+		if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
+			del_page_from_inactive_list(zone, page);
+			SetPageActive(page);
+			add_page_to_active_list(zone, page);
+			inc_page_state(pgactivate);
+			ClearPageReferenced(page);
+		} else if (!PageReferenced(page)) {
+			SetPageReferenced(page);
+		}
+	}
+	if (zone)
+		local_unlock_irq(&zone->lru_lock);
+	release_pages(pvec->pages, pvec->nr, pvec->cold);
+	pagevec_reinit(pvec);
+}
+
+static DEFINE_PER_CPU(struct pagevec, page_accessed_pvec) = { 0, };
+
 /*
  * Mark a page as having seen activity.
  *
@@ -122,14 +155,14 @@ void fastcall activate_page(struct page 
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
-		ClearPageReferenced(page);
-	} else if (!PageReferenced(page)) {
-		SetPageReferenced(page);
-	}
-}
+	struct pagevec *pvec;
 
+	pvec = &get_cpu_var(page_accessed_pvec);
+	page_cache_get(page);
+	if (!pagevec_add(pvec, page))
+		__pagevec_mark_accessed(pvec);
+	put_cpu_var(page_accessed_pvec);
+}
 EXPORT_SYMBOL(mark_page_accessed);
 
 /**

_
