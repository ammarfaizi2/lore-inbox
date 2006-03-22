Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932898AbWCVWgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbWCVWgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932882AbWCVWfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:35:41 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:9425 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S932886AbWCVWfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:35:14 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223418.12658.8364.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 19/34] mm: page-replace-data.patch
Date: Wed, 22 Mar 2006 23:34:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Abstract the policy specific variables from struct zone.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace_data.h |   13 +++++++
 include/linux/mm_use_once_data.h     |   16 +++++++++
 include/linux/mm_use_once_policy.h   |   14 ++++----
 include/linux/mmzone.h               |    8 +---
 mm/useonce.c                         |   60 +++++++++++++++++------------------
 5 files changed, 68 insertions(+), 43 deletions(-)

Index: linux-2.6-git/include/linux/mm_use_once_data.h
===================================================================
--- /dev/null
+++ linux-2.6-git/include/linux/mm_use_once_data.h
@@ -0,0 +1,16 @@
+#ifndef _LINUX_MM_USEONCE_DATA_H
+#define _LINUX_MM_USEONCE_DATA_H
+
+#ifdef __KERNEL__
+
+struct page_replace_data {
+	struct list_head	active_list;
+	struct list_head	inactive_list;
+	unsigned long		nr_scan_active;
+	unsigned long		nr_scan_inactive;
+	unsigned long		nr_active;
+	unsigned long		nr_inactive;
+};
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_MM_USEONCE_DATA_H */
Index: linux-2.6-git/mm/useonce.c
===================================================================
--- linux-2.6-git.orig/mm/useonce.c
+++ linux-2.6-git/mm/useonce.c
@@ -13,19 +13,19 @@ void __init page_replace_init(void)
 
 void __init page_replace_init_zone(struct zone *zone)
 {
-	INIT_LIST_HEAD(&zone->active_list);
-	INIT_LIST_HEAD(&zone->inactive_list);
-	zone->nr_scan_active = 0;
-	zone->nr_scan_inactive = 0;
-	zone->nr_active = 0;
-	zone->nr_inactive = 0;
+	INIT_LIST_HEAD(&zone->policy.active_list);
+	INIT_LIST_HEAD(&zone->policy.inactive_list);
+	zone->policy.nr_scan_active = 0;
+	zone->policy.nr_scan_inactive = 0;
+	zone->policy.nr_active = 0;
+	zone->policy.nr_inactive = 0;
 }
 
 static inline void
 del_page_from_active_list(struct zone *zone, struct page *page)
 {
        list_del(&page->lru);
-       zone->nr_active--;
+       zone->policy.nr_active--;
 }
 
 /**
@@ -211,9 +211,9 @@ static void shrink_cache(struct zone *zo
 		int nr_freed;
 
 		nr_taken = isolate_lru_pages(sc->swap_cluster_max,
-					     &zone->inactive_list,
+					     &zone->policy.inactive_list,
 					     &page_list, &nr_scan);
-		zone->nr_inactive -= nr_taken;
+		zone->policy.nr_inactive -= nr_taken;
 		zone->pages_scanned += nr_scan;
 		spin_unlock_irq(&zone->lru_lock);
 
@@ -292,10 +292,10 @@ refill_inactive_zone(struct zone *zone, 
 
 	page_replace_add_drain();
 	spin_lock_irq(&zone->lru_lock);
-	pgmoved = isolate_lru_pages(nr_pages, &zone->active_list,
+	pgmoved = isolate_lru_pages(nr_pages, &zone->policy.active_list,
 				    &l_hold, &pgscanned);
 	zone->pages_scanned += pgscanned;
-	zone->nr_active -= pgmoved;
+	zone->policy.nr_active -= pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 
 	while (!list_empty(&l_hold)) {
@@ -323,10 +323,10 @@ refill_inactive_zone(struct zone *zone, 
 			BUG();
 		if (!TestClearPageActive(page))
 			BUG();
-		list_move(&page->lru, &zone->inactive_list);
+		list_move(&page->lru, &zone->policy.inactive_list);
 		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
-			zone->nr_inactive += pgmoved;
+			zone->policy.nr_inactive += pgmoved;
 			spin_unlock_irq(&zone->lru_lock);
 			pgdeactivate += pgmoved;
 			pgmoved = 0;
@@ -336,7 +336,7 @@ refill_inactive_zone(struct zone *zone, 
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
-	zone->nr_inactive += pgmoved;
+	zone->policy.nr_inactive += pgmoved;
 	pgdeactivate += pgmoved;
 	if (buffer_heads_over_limit) {
 		spin_unlock_irq(&zone->lru_lock);
@@ -351,17 +351,17 @@ refill_inactive_zone(struct zone *zone, 
 		if (TestSetPageLRU(page))
 			BUG();
 		BUG_ON(!PageActive(page));
-		list_move(&page->lru, &zone->active_list);
+		list_move(&page->lru, &zone->policy.active_list);
 		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
-			zone->nr_active += pgmoved;
+			zone->policy.nr_active += pgmoved;
 			pgmoved = 0;
 			spin_unlock_irq(&zone->lru_lock);
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
-	zone->nr_active += pgmoved;
+	zone->policy.nr_active += pgmoved;
 	spin_unlock(&zone->lru_lock);
 
 	__mod_page_state_zone(zone, pgrefill, pgscanned);
@@ -385,17 +385,17 @@ void page_replace_shrink(struct zone *zo
 	 * Add one to `nr_to_scan' just to make sure that the kernel will
 	 * slowly sift through the active list.
 	 */
-	zone->nr_scan_active += (zone->nr_active >> sc->priority) + 1;
-	nr_active = zone->nr_scan_active;
+	zone->policy.nr_scan_active += (zone->policy.nr_active >> sc->priority) + 1;
+	nr_active = zone->policy.nr_scan_active;
 	if (nr_active >= sc->swap_cluster_max)
-		zone->nr_scan_active = 0;
+		zone->policy.nr_scan_active = 0;
 	else
 		nr_active = 0;
 
-	zone->nr_scan_inactive += (zone->nr_inactive >> sc->priority) + 1;
-	nr_inactive = zone->nr_scan_inactive;
+	zone->policy.nr_scan_inactive += (zone->policy.nr_inactive >> sc->priority) + 1;
+	nr_inactive = zone->policy.nr_scan_inactive;
 	if (nr_inactive >= sc->swap_cluster_max)
-		zone->nr_scan_inactive = 0;
+		zone->policy.nr_scan_inactive = 0;
 	else
 		nr_inactive = 0;
 
@@ -440,8 +440,8 @@ void page_replace_show(struct zone *zone
 	       K(zone->pages_min),
 	       K(zone->pages_low),
 	       K(zone->pages_high),
-	       K(zone->nr_active),
-	       K(zone->nr_inactive),
+	       K(zone->policy.nr_active),
+	       K(zone->policy.nr_inactive),
 	       K(zone->present_pages),
 	       zone->pages_scanned,
 	       (zone->all_unreclaimable ? "yes" : "no")
@@ -464,10 +464,10 @@ void page_replace_zoneinfo(struct zone *
 		   zone->pages_min,
 		   zone->pages_low,
 		   zone->pages_high,
-		   zone->nr_active,
-		   zone->nr_inactive,
+		   zone->policy.nr_active,
+		   zone->policy.nr_inactive,
 		   zone->pages_scanned,
-		   zone->nr_scan_active, zone->nr_scan_inactive,
+		   zone->policy.nr_scan_active, zone->policy.nr_scan_inactive,
 		   zone->spanned_pages,
 		   zone->present_pages);
 }
@@ -482,8 +482,8 @@ void __page_replace_counts(unsigned long
 	*inactive = 0;
 	*free = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
-		*active += zones[i].nr_active;
-		*inactive += zones[i].nr_inactive;
+		*active += zones[i].policy.nr_active;
+		*inactive += zones[i].policy.nr_inactive;
 		*free += zones[i].free_pages;
 	}
 }
Index: linux-2.6-git/include/linux/mm_page_replace_data.h
===================================================================
--- /dev/null
+++ linux-2.6-git/include/linux/mm_page_replace_data.h
@@ -0,0 +1,13 @@
+#ifndef _LINUX_MM_PAGE_REPLACE_DATA_H
+#define _LINUX_MM_PAGE_REPLACE_DATA_H
+
+#ifdef __KERNEL__
+
+#ifdef CONFIG_MM_POLICY_USEONCE
+#include <linux/mm_use_once_data.h>
+#else
+#error no mm policy
+#endif
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_MM_PAGE_REPLACE_DATA_H */
Index: linux-2.6-git/include/linux/mmzone.h
===================================================================
--- linux-2.6-git.orig/include/linux/mmzone.h
+++ linux-2.6-git/include/linux/mmzone.h
@@ -13,6 +13,7 @@
 #include <linux/numa.h>
 #include <linux/init.h>
 #include <linux/seqlock.h>
+#include <linux/mm_page_replace_data.h>
 #include <asm/atomic.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -151,12 +152,7 @@ struct zone {
 
 	/* Fields commonly accessed by the page reclaim scanner */
 	spinlock_t		lru_lock;	
-	struct list_head	active_list;
-	struct list_head	inactive_list;
-	unsigned long		nr_scan_active;
-	unsigned long		nr_scan_inactive;
-	unsigned long		nr_active;
-	unsigned long		nr_inactive;
+	struct page_replace_data policy;
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_use_once_policy.h
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -15,14 +15,14 @@ static inline void
 del_page_from_inactive_list(struct zone *zone, struct page *page)
 {
        list_del(&page->lru);
-       zone->nr_inactive--;
+       zone->policy.nr_inactive--;
 }
 
 static inline void
 add_page_to_active_list(struct zone *zone, struct page *page)
 {
-	list_add(&page->lru, &zone->active_list);
-	zone->nr_active++;
+	list_add(&page->lru, &zone->policy.active_list);
+	zone->policy.nr_active++;
 }
 
 static inline void
@@ -121,23 +121,23 @@ static inline void page_replace_remove(s
 	list_del(&page->lru);
 	if (PageActive(page)) {
 		ClearPageActive(page);
-		zone->nr_active--;
+		zone->policy.nr_active--;
 	} else {
-		zone->nr_inactive--;
+		zone->policy.nr_inactive--;
 	}
 }
 
 static inline void __page_replace_rotate_reclaimable(struct zone *zone, struct page *page)
 {
 	if (PageLRU(page) && !PageActive(page)) {
-		list_move_tail(&page->lru, &zone->inactive_list);
+		list_move_tail(&page->lru, &zone->policy.inactive_list);
 		inc_page_state(pgrotated);
 	}
 }
 
 static inline unsigned long __page_replace_nr_pages(struct zone *zone)
 {
-	return zone->nr_active + zone->nr_inactive;
+	return zone->policy.nr_active + zone->policy.nr_inactive;
 }
 
 #endif /* __KERNEL__ */
