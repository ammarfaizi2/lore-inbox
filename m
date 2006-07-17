Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWGQUYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWGQUYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 16:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWGQUYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 16:24:43 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:33197 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751182AbWGQUYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 16:24:42 -0400
Subject: [PATCH] mm: inactive-clean list
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm <linux-mm@kvack.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 22:24:16 +0200
Message-Id: <1153167857.31891.78.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch implements the inactive_clean list spoken of during the VM summit.
The LRU tail pages will be unmapped and ready to free, but not freeed.
This gives reclaim an extra chance.

The only down-side to this patch is that it puts another requirement for
the zone lock into mark_page_accessed(), meaning that the use-once
cleanup cannot get fully rid of that zone lock there.

Signed-Off-By: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/linux/mm_inline.h  |   23 +++++++++
 include/linux/mmzone.h     |    5 ++
 include/linux/page-flags.h |    6 ++
 include/linux/swap.h       |    1 
 include/linux/sysctl.h     |    1 
 kernel/sysctl.c            |   11 ++++
 mm/page_alloc.c            |   62 ++++++++++++++++++++++++-
 mm/swap.c                  |   44 ++++++++++--------
 mm/swapfile.c              |    4 -
 mm/vmscan.c                |  108 ++++++++++++++++++++++++++++++++++++++-------
 10 files changed, 225 insertions(+), 40 deletions(-)

Index: linux-2.6-dirty/include/linux/swap.h
===================================================================
--- linux-2.6-dirty.orig/include/linux/swap.h	2006-06-30 08:58:08.000000000 +0200
+++ linux-2.6-dirty/include/linux/swap.h	2006-06-30 10:39:37.000000000 +0200
@@ -173,7 +173,6 @@ extern unsigned int nr_free_pagecache_pa
 /* linux/mm/swap.c */
 extern void FASTCALL(lru_cache_add(struct page *));
 extern void FASTCALL(lru_cache_add_active(struct page *));
-extern void FASTCALL(activate_page(struct page *));
 extern void FASTCALL(mark_page_accessed(struct page *));
 extern void lru_add_drain(void);
 extern int lru_add_drain_all(void);
Index: linux-2.6-dirty/mm/swapfile.c
===================================================================
--- linux-2.6-dirty.orig/mm/swapfile.c	2006-06-30 08:58:08.000000000 +0200
+++ linux-2.6-dirty/mm/swapfile.c	2006-06-30 10:39:37.000000000 +0200
@@ -499,7 +499,7 @@ static void unuse_pte(struct vm_area_str
 	 * Move the page to the active list so it is not
 	 * immediately swapped out again after swapon.
 	 */
-	activate_page(page);
+	mark_page_accessed(page);
 }
 
 static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
@@ -601,7 +601,7 @@ static int unuse_mm(struct mm_struct *mm
 		 * Activate page so shrink_cache is unlikely to unmap its
 		 * ptes while lock is dropped, so swapoff can make progress.
 		 */
-		activate_page(page);
+		mark_page_accessed(page);
 		unlock_page(page);
 		down_read(&mm->mmap_sem);
 		lock_page(page);
Index: linux-2.6-dirty/mm/swap.c
===================================================================
--- linux-2.6-dirty.orig/mm/swap.c	2006-06-30 08:58:08.000000000 +0200
+++ linux-2.6-dirty/mm/swap.c	2006-06-30 10:39:37.000000000 +0200
@@ -96,37 +96,45 @@ int rotate_reclaimable_page(struct page 
 }
 
 /*
- * FIXME: speed this up?
- */
-void fastcall activate_page(struct page *page)
-{
-	struct zone *zone = page_zone(page);
-
-	spin_lock_irq(&zone->lru_lock);
-	if (PageLRU(page) && !PageActive(page)) {
-		del_page_from_inactive_list(zone, page);
-		SetPageActive(page);
-		add_page_to_active_list(zone, page);
-		inc_page_state(pgactivate);
-	}
-	spin_unlock_irq(&zone->lru_lock);
-}
-
-/*
  * Mark a page as having seen activity.
  *
+ * clean -> inactive
+ *
  * inactive,unreferenced	->	inactive,referenced
  * inactive,referenced		->	active,unreferenced
  * active,unreferenced		->	active,referenced
+ *
+ * FIXME: speed this up?
  */
 void fastcall mark_page_accessed(struct page *page)
 {
+	struct zone *zone = NULL;
+	if (PageClean(page) && PageLRU(page)) {
+		zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+		if (PageClean(page) && PageLRU(page)) {
+			del_page_from_clean_list(zone, page);
+			ClearPageClean(page);
+			add_page_to_inactive_list(zone, page);
+		}
+	}
 	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
+		if (!zone) {
+			zone = page_zone(page);
+			spin_lock_irq(&zone->lru_lock);
+		}
+		if (PageLRU(page) && !PageActive(page)) {
+			del_page_from_inactive_list(zone, page);
+			SetPageActive(page);
+			add_page_to_active_list(zone, page);
+			inc_page_state(pgactivate);
+		}
 		ClearPageReferenced(page);
 	} else if (!PageReferenced(page)) {
 		SetPageReferenced(page);
 	}
+	if (zone)
+		spin_unlock_irq(&zone->lru_lock);
 }
 
 EXPORT_SYMBOL(mark_page_accessed);
Index: linux-2.6-dirty/include/linux/mm_inline.h
===================================================================
--- linux-2.6-dirty.orig/include/linux/mm_inline.h	2006-06-30 08:58:08.000000000 +0200
+++ linux-2.6-dirty/include/linux/mm_inline.h	2006-06-30 10:39:37.000000000 +0200
@@ -14,6 +14,13 @@ add_page_to_inactive_list(struct zone *z
 }
 
 static inline void
+add_page_to_clean_list(struct zone *zone, struct page *page)
+{
+	list_add(&page->lru, &zone->clean_list);
+	zone->nr_clean++;
+}
+
+static inline void
 del_page_from_active_list(struct zone *zone, struct page *page)
 {
 	list_del(&page->lru);
@@ -27,6 +34,17 @@ del_page_from_inactive_list(struct zone 
 	zone->nr_inactive--;
 }
 
+void wakeup_kswapd(struct zone *zone, int order);
+
+static inline void
+del_page_from_clean_list(struct zone *zone, struct page *page)
+{
+	list_del(&page->lru);
+	zone->nr_clean--;
+	if (zone->nr_clean + zone->free_pages < zone->clean_low)
+		wakeup_kswapd(zone, 0);
+}
+
 static inline void
 del_page_from_lru(struct zone *zone, struct page *page)
 {
@@ -34,6 +52,11 @@ del_page_from_lru(struct zone *zone, str
 	if (PageActive(page)) {
 		__ClearPageActive(page);
 		zone->nr_active--;
+	} else if (PageClean(page)) {
+		__ClearPageClean(page);
+		zone->nr_clean--;
+		if (zone->nr_clean + zone->free_pages < zone->clean_low)
+			wakeup_kswapd(zone, 0);
 	} else {
 		zone->nr_inactive--;
 	}
Index: linux-2.6-dirty/include/linux/mmzone.h
===================================================================
--- linux-2.6-dirty.orig/include/linux/mmzone.h	2006-06-30 08:58:08.000000000 +0200
+++ linux-2.6-dirty/include/linux/mmzone.h	2006-06-30 10:39:37.000000000 +0200
@@ -155,10 +155,13 @@ struct zone {
 	spinlock_t		lru_lock;	
 	struct list_head	active_list;
 	struct list_head	inactive_list;
+	struct list_head	clean_list;
 	unsigned long		nr_scan_active;
 	unsigned long		nr_scan_inactive;
 	unsigned long		nr_active;
 	unsigned long		nr_inactive;
+	unsigned long		nr_clean;
+	unsigned long		clean_low, clean_high;
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
@@ -397,6 +400,8 @@ struct ctl_table;
 struct file;
 int min_free_kbytes_sysctl_handler(struct ctl_table *, int, struct file *, 
 					void __user *, size_t *, loff_t *);
+int min_clean_kbytes_sysctl_handler(struct ctl_table *, int, struct file *,
+					void __user *, size_t *, loff_t *);
 extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1];
 int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
Index: linux-2.6-dirty/include/linux/page-flags.h
===================================================================
--- linux-2.6-dirty.orig/include/linux/page-flags.h	2006-06-30 08:58:08.000000000 +0200
+++ linux-2.6-dirty/include/linux/page-flags.h	2006-06-30 10:39:37.000000000 +0200
@@ -90,6 +90,7 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_buddy		19	/* Page is free, on buddy lists */
 
+#define PG_clean		20	/* Page is on the clean list */
 
 #if (BITS_PER_LONG > 32)
 /*
@@ -372,6 +373,11 @@ extern void __mod_page_state_offset(unsi
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageClean(page)		test_bit(PG_clean, &(page)->flags)
+#define SetPageClean(page)	set_bit(PG_clean, &(page)->flags)
+#define ClearPageClean(page)	clear_bit(PG_clean, &(page)->flags)
+#define __ClearPageClean(page)	__clear_bit(PG_clean, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
Index: linux-2.6-dirty/mm/page_alloc.c
===================================================================
--- linux-2.6-dirty.orig/mm/page_alloc.c	2006-06-30 08:58:08.000000000 +0200
+++ linux-2.6-dirty/mm/page_alloc.c	2006-06-30 11:28:14.000000000 +0200
@@ -83,6 +83,7 @@ EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
+int min_clean_kbytes = 8192;
 
 unsigned long __meminitdata nr_kernel_pages;
 unsigned long __meminitdata nr_all_pages;
@@ -155,7 +156,8 @@ static void bad_page(struct page *page)
 			1 << PG_slab    |
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_buddy );
+			1 << PG_buddy |
+		        1 << PG_clean );
 	set_page_count(page, 0);
 	reset_page_mapcount(page);
 	page->mapping = NULL;
@@ -390,7 +392,8 @@ static inline int free_pages_check(struc
 			1 << PG_swapcache |
 			1 << PG_writeback |
 			1 << PG_reserved |
-			1 << PG_buddy ))))
+			1 << PG_buddy |
+			1 << PG_clean ))))
 		bad_page(page);
 	if (PageDirty(page))
 		__ClearPageDirty(page);
@@ -539,7 +542,8 @@ static int prep_new_page(struct page *pa
 			1 << PG_swapcache |
 			1 << PG_writeback |
 			1 << PG_reserved |
-			1 << PG_buddy ))))
+			1 << PG_buddy |
+			1 << PG_clean ))))
 		bad_page(page);
 
 	/*
@@ -1466,6 +1470,9 @@ void show_free_areas(void)
 			" min:%lukB"
 			" low:%lukB"
 			" high:%lukB"
+			" clean: %lukB"
+			" low: %lukB"
+			" high: %lukB"
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
@@ -1477,6 +1484,9 @@ void show_free_areas(void)
 			K(zone->pages_min),
 			K(zone->pages_low),
 			K(zone->pages_high),
+			K(zone->nr_clean),
+			K(zone->clean_low),
+			K(zone->clean_high),
 			K(zone->nr_active),
 			K(zone->nr_inactive),
 			K(zone->present_pages),
@@ -2176,10 +2186,12 @@ static void __meminit free_area_init_cor
 		zone_pcp_init(zone);
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
+		INIT_LIST_HEAD(&zone->clean_list);
 		zone->nr_scan_active = 0;
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		zone->nr_clean = 0;
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
@@ -2336,6 +2348,9 @@ static int zoneinfo_show(struct seq_file
 			   "\n        min      %lu"
 			   "\n        low      %lu"
 			   "\n        high     %lu"
+			   "\n        clean    %lu"
+			   "\n        low      %lu"
+			   "\n        high     %lu"
 			   "\n        active   %lu"
 			   "\n        inactive %lu"
 			   "\n        scanned  %lu (a: %lu i: %lu)"
@@ -2345,6 +2360,9 @@ static int zoneinfo_show(struct seq_file
 			   zone->pages_min,
 			   zone->pages_low,
 			   zone->pages_high,
+			   zone->nr_clean,
+			   zone->clean_low,
+			   zone->clean_high,
 			   zone->nr_active,
 			   zone->nr_inactive,
 			   zone->pages_scanned,
@@ -2632,6 +2650,34 @@ static void setup_per_zone_lowmem_reserv
 	calculate_totalreserve_pages();
 }
 
+void setup_per_zone_pages_clean(void)
+{
+	unsigned long pages_clean = min_clean_kbytes >> (PAGE_SHIFT - 10);
+	unsigned long lowmem_pages = 0;
+	struct zone *zone;
+	unsigned long flags;
+
+	/* Calculate total number of !ZONE_HIGHMEM pages */
+	for_each_zone(zone) {
+		if (!is_highmem(zone))
+			lowmem_pages += zone->present_pages;
+	}
+
+	for_each_zone(zone) {
+		u64 tmp = pages_clean;
+
+		spin_lock_irqsave(&zone->lru_lock, flags);
+		if (!is_highmem(zone)) {
+			tmp *= zone->present_pages;
+			do_div(tmp, lowmem_pages);
+		}
+
+		zone->clean_low   = zone->pages_min + tmp - (tmp >> 2);
+		zone->clean_high  = zone->pages_min + tmp + (tmp >> 2);
+		spin_unlock_irqrestore(&zone->lru_lock, flags);
+	}
+}
+
 /*
  * setup_per_zone_pages_min - called when min_free_kbytes changes.  Ensures 
  *	that the pages_{min,low,high} values for each zone are set correctly 
@@ -2689,6 +2735,8 @@ void setup_per_zone_pages_min(void)
 
 	/* update totalreserve_pages */
 	calculate_totalreserve_pages();
+	/* update the clean pages watermarks */
+	setup_per_zone_pages_clean();
 }
 
 /*
@@ -2745,6 +2793,14 @@ int min_free_kbytes_sysctl_handler(ctl_t
 	return 0;
 }
 
+int min_clean_kbytes_sysctl_handler(ctl_table *table, int write,
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+	proc_dointvec(table, write, file, buffer, length, ppos);
+	setup_per_zone_pages_clean();
+	return 0;
+}
+
 /*
  * lowmem_reserve_ratio_sysctl_handler - just a wrapper around
  *	proc_dointvec() so that we can call setup_per_zone_lowmem_reserve()
Index: linux-2.6-dirty/mm/vmscan.c
===================================================================
--- linux-2.6-dirty.orig/mm/vmscan.c	2006-06-30 08:58:08.000000000 +0200
+++ linux-2.6-dirty/mm/vmscan.c	2006-06-30 10:39:37.000000000 +0200
@@ -549,8 +549,8 @@ static unsigned long shrink_page_list(st
 				goto free_it;
 		}
 
-		if (!remove_mapping(mapping, page))
-			goto keep_locked;
+		SetPageClean(page);
+		goto keep_locked;
 
 free_it:
 		unlock_page(page);
@@ -627,12 +627,14 @@ static unsigned long isolate_lru_pages(u
 	return nr_taken;
 }
 
-/*
- * shrink_inactive_list() is a helper for shrink_zone().  It returns the number
- * of reclaimed pages
- */
-static unsigned long shrink_inactive_list(unsigned long max_scan,
-				struct zone *zone, struct scan_control *sc)
+typedef unsigned long (*shrink_func_t)(struct list_head *,
+		struct scan_control *);
+
+static unsigned long shrink_list(unsigned long max_scan,
+				struct zone *zone, struct scan_control *sc,
+				struct list_head *src_list,
+				unsigned long *src_count,
+			       	shrink_func_t shrink_func)
 {
 	LIST_HEAD(page_list);
 	struct pagevec pvec;
@@ -650,14 +652,13 @@ static unsigned long shrink_inactive_lis
 		unsigned long nr_freed;
 
 		nr_taken = isolate_lru_pages(sc->swap_cluster_max,
-					     &zone->inactive_list,
-					     &page_list, &nr_scan);
-		zone->nr_inactive -= nr_taken;
+				src_list, &page_list, &nr_scan);
+		*src_count -= nr_taken;
 		zone->pages_scanned += nr_scan;
 		spin_unlock_irq(&zone->lru_lock);
 
 		nr_scanned += nr_scan;
-		nr_freed = shrink_page_list(&page_list, sc);
+		nr_freed = shrink_func(&page_list, sc);
 		nr_reclaimed += nr_freed;
 		local_irq_disable();
 		if (current_is_kswapd()) {
@@ -681,6 +682,8 @@ static unsigned long shrink_inactive_lis
 			list_del(&page->lru);
 			if (PageActive(page))
 				add_page_to_active_list(zone, page);
+			else if (PageClean(page))
+				add_page_to_clean_list(zone, page);
 			else
 				add_page_to_inactive_list(zone, page);
 			if (!pagevec_add(&pvec, page)) {
@@ -689,7 +692,7 @@ static unsigned long shrink_inactive_lis
 				spin_lock_irq(&zone->lru_lock);
 			}
 		}
-  	} while (nr_scanned < max_scan);
+	} while (nr_scanned < max_scan);
 	spin_unlock(&zone->lru_lock);
 done:
 	local_irq_enable();
@@ -698,6 +701,17 @@ done:
 }
 
 /*
+ * shrink_inactive_list() is a helper for shrink_zone().  It returns the number
+ * of reclaimed pages
+ */
+static inline unsigned long shrink_inactive_list(unsigned long max_scan,
+		struct zone *zone, struct scan_control *sc)
+{
+	return shrink_list(max_scan, zone, sc, &zone->inactive_list,
+			&zone->nr_inactive, shrink_page_list);
+}
+
+/*
  * This moves pages from the active list to the inactive list.
  *
  * We move them the other way if the page is referenced by one or more
@@ -850,6 +864,59 @@ static void shrink_active_list(unsigned 
 	pagevec_release(&pvec);
 }
 
+static unsigned long shrink_clean_page_list(struct list_head *page_list,
+		struct scan_control *sc)
+{
+	LIST_HEAD(ret_pages);
+	struct pagevec freed_pvec;
+	unsigned long nr_reclaimed = 0;
+
+	pagevec_init(&freed_pvec, 1);
+	while (!list_empty(page_list)) {
+		struct address_space *mapping;
+		struct page *page;
+
+		cond_resched();
+
+		page = lru_to_page(page_list);
+		prefetchw_prev_lru_page(page, page_list, flags);
+
+		list_del(&page->lru);
+
+		if (TestSetPageLocked(page))
+			goto keep;
+
+		mapping = page_mapping(page);
+
+		if (!remove_mapping(mapping, page))
+			goto keep_locked;
+
+		ClearPageClean(page);
+		unlock_page(page);
+		nr_reclaimed++;
+		if (!pagevec_add(&freed_pvec, page))
+			__pagevec_release_nonlru(&freed_pvec);
+		continue;
+
+keep_locked:
+		ClearPageClean(page);
+		unlock_page(page);
+keep:
+		list_add(&page->lru, &ret_pages);
+	}
+	list_splice(&ret_pages, page_list);
+	if (pagevec_count(&freed_pvec))
+		__pagevec_release_nonlru(&freed_pvec);
+	return nr_reclaimed;
+}
+
+static inline unsigned long shrink_clean_list(unsigned long max_scan,
+		struct zone *zone, struct scan_control *sc)
+{
+	return shrink_list(max_scan, zone, sc, &zone->clean_list,
+			&zone->nr_clean, shrink_clean_page_list);
+}
+
 /*
  * This is a basic per-zone page freer.  Used by both kswapd and direct reclaim.
  */
@@ -863,6 +930,13 @@ static unsigned long shrink_zone(int pri
 
 	atomic_inc(&zone->reclaim_in_progress);
 
+	if (!priority || zone->nr_clean + zone->free_pages > zone->clean_high)
+		nr_reclaimed +=
+			shrink_clean_list(sc->swap_cluster_max, zone, sc);
+
+	if (nr_reclaimed && zone->nr_clean > zone->clean_high)
+		goto done;
+
 	/*
 	 * Add one to `nr_to_scan' just to make sure that the kernel will
 	 * slowly sift through the active list.
@@ -900,6 +974,7 @@ static unsigned long shrink_zone(int pri
 
 	throttle_vm_writeout();
 
+done:
 	atomic_dec(&zone->reclaim_in_progress);
 	return nr_reclaimed;
 }
@@ -986,7 +1061,7 @@ unsigned long try_to_free_pages(struct z
 			continue;
 
 		zone->temp_priority = DEF_PRIORITY;
-		lru_pages += zone->nr_active + zone->nr_inactive;
+		lru_pages += zone->nr_active + zone->nr_inactive + zone->nr_clean;
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
@@ -1119,7 +1194,7 @@ scan:
 		for (i = 0; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 
-			lru_pages += zone->nr_active + zone->nr_inactive;
+			lru_pages += zone->nr_active + zone->nr_inactive + zone->nr_clean;
 		}
 
 		/*
@@ -1280,7 +1355,8 @@ void wakeup_kswapd(struct zone *zone, in
 		return;
 
 	pgdat = zone->zone_pgdat;
-	if (zone_watermark_ok(zone, order, zone->pages_low, 0, 0))
+	if (zone_watermark_ok(zone, order, zone->pages_low, 0, 0) &&
+			zone->nr_clean + zone->free_pages > zone->clean_high)
 		return;
 	if (pgdat->kswapd_max_order < order)
 		pgdat->kswapd_max_order = order;
Index: linux-2.6-dirty/include/linux/sysctl.h
===================================================================
--- linux-2.6-dirty.orig/include/linux/sysctl.h	2006-06-30 08:58:08.000000000 +0200
+++ linux-2.6-dirty/include/linux/sysctl.h	2006-06-30 10:39:37.000000000 +0200
@@ -191,6 +191,7 @@ enum
 	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
+	VM_MIN_CLEAN_KBYTES=35, /* Minimun clean kilobytes to maintain */
 };
 

Index: linux-2.6-dirty/kernel/sysctl.c
===================================================================
--- linux-2.6-dirty.orig/kernel/sysctl.c	2006-06-30 08:58:09.000000000 +0200
+++ linux-2.6-dirty/kernel/sysctl.c	2006-06-30 10:39:37.000000000 +0200
@@ -68,6 +68,7 @@ extern char core_pattern[];
 extern int cad_pid;
 extern int pid_max;
 extern int min_free_kbytes;
+extern int min_clean_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
@@ -851,6 +852,16 @@ static ctl_table vm_table[] = {
 		.extra1		= &zero,
 	},
 	{
+		.ctl_name	= VM_MIN_CLEAN_KBYTES,
+		.procname	= "min_clean_kbytes",
+		.data		= &min_clean_kbytes,
+		.maxlen		= sizeof(min_clean_kbytes),
+		.mode		= 0644,
+		.proc_handler	= &min_clean_kbytes_sysctl_handler,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
+	{
 		.ctl_name	= VM_PERCPU_PAGELIST_FRACTION,
 		.procname	= "percpu_pagelist_fraction",
 		.data		= &percpu_pagelist_fraction,


