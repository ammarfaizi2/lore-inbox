Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUEEAUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUEEAUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 20:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUEEAUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 20:20:52 -0400
Received: from web12821.mail.yahoo.com ([216.136.174.202]:33647 "HELO
	web12821.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261830AbUEEAUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 20:20:30 -0400
Message-ID: <20040505002029.11785.qmail@web12821.mail.yahoo.com>
Date: Tue, 4 May 2004 17:20:29 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: [VM PATCH 2.6.6-rc3-bk5] Dirty balancing in the presence of mapped pages
To: Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1940874318-1083716429=:11112"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1940874318-1083716429=:11112
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hi,

Presently the kernel does not collection information
about the percentage of memory that processes have
dirtied via mmap until reclamation.  Nothing analogous
to balance_dirty_pages() is being done for mmap'ed
pages.  The attached patch adds collection of dirty
page information during kswapd() scans and initiation
of background writeback by waking up bdflush.

Thanks,
Shantanu


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
--0-1940874318-1083716429=:11112
Content-Type: text/x-patch; name="vm-bdflush.patch"
Content-Description: vm-bdflush.patch
Content-Disposition: inline; filename="vm-bdflush.patch"

--- .orig/include/linux/page-flags.h	2004-05-04 20:03:07.000000000 -0400
+++ 2.6.6-rc3-bk5-sg-x86_64/include/linux/page-flags.h	2004-05-03 21:00:54.000000000 -0400
@@ -133,6 +133,7 @@
 	unsigned long allocstall;	/* direct reclaim calls */
 
 	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
+	unsigned long bdflush;		/* bdflush wakeups due to dirty mapped pages */
 } ____cacheline_aligned;
 
 DECLARE_PER_CPU(struct page_state, page_states);
--- .orig/include/linux/rmap.h	2004-05-04 20:03:07.000000000 -0400
+++ 2.6.6-rc3-bk5-sg-x86_64/include/linux/rmap.h	2004-05-03 18:41:00.000000000 -0400
@@ -28,6 +28,7 @@
 struct pte_chain * fastcall
 	page_add_rmap(struct page *, pte_t *, struct pte_chain *);
 void fastcall page_remove_rmap(struct page *, pte_t *);
+int fastcall page_is_dirty(struct page *);
 
 /*
  * Called from mm/vmscan.c to handle paging out
--- .orig/mm/page_alloc.c	2004-05-04 20:03:07.000000000 -0400
+++ 2.6.6-rc3-bk5-sg-x86_64/mm/page_alloc.c	2004-05-03 21:03:57.000000000 -0400
@@ -1681,6 +1681,7 @@
 	"allocstall",
 
 	"pgrotated",
+	"bdflush",
 };
 
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
--- .orig/mm/rmap.c	2004-05-04 20:03:07.000000000 -0400
+++ 2.6.6-rc3-bk5-sg-x86_64/mm/rmap.c	2004-05-03 18:44:00.000000000 -0400
@@ -170,6 +170,43 @@
 }
 
 /**
+ * page_is_dirty - test if the page was modified
+ * @page: the page to test
+ *
+ * Quick test_and_clear_dirty for all mappings to a page,
+ * returns the number of processes which modified the page.
+ * Caller needs to hold the rmap lock.
+ */
+int fastcall page_is_dirty(struct page * page)
+{
+	struct pte_chain *pc;
+	int dirty = 0;
+
+	if (PageDirect(page)) {
+		pte_t *pte = rmap_ptep_map(page->pte.direct);
+		if (ptep_test_and_clear_dirty(pte))
+			dirty++;
+		rmap_ptep_unmap(pte);
+	} else {
+		/* Check all the page tables mapping this page. */
+		for (pc = page->pte.chain; pc; pc = pte_chain_next(pc)) {
+			int i;
+
+			for (i = pte_chain_idx(pc); i < NRPTE; i++) {
+				pte_addr_t pte_paddr = pc->ptes[i];
+				pte_t *p;
+
+				p = rmap_ptep_map(pte_paddr);
+				if (ptep_test_and_clear_dirty(p))
+					dirty++;
+				rmap_ptep_unmap(p);
+			}
+		}
+	}
+	return dirty;
+}
+
+/**
  * page_add_rmap - add reverse mapping entry to a page
  * @page: the page to add the mapping to
  * @ptep: the page table entry mapping this page
--- .orig/mm/vmscan.c	2004-05-04 20:03:07.000000000 -0400
+++ 2.6.6-rc3-bk5-sg-x86_64/mm/vmscan.c	2004-05-04 18:30:05.000000000 -0400
@@ -242,7 +242,7 @@
  */
 static int
 shrink_list(struct list_head *page_list, unsigned int gfp_mask,
-		int *nr_scanned, int do_writepage)
+		int *nr_scanned, int do_writepage, int *nr_dirty)
 {
 	struct address_space *mapping;
 	LIST_HEAD(ret_pages);
@@ -277,6 +277,10 @@
 		referenced = page_referenced(page);
 		if (referenced && page_mapping_inuse(page)) {
 			/* In active use or really unfreeable.  Activate it. */
+			if (!PageDirty(page) && page_mapped(page) && page_mapping(page) && page_is_dirty(page)) {
+				set_page_dirty(page);
+				(*nr_dirty)++;
+			}
 			rmap_unlock(page);
 			goto activate_locked;
 		}
@@ -472,7 +476,7 @@
  */
 static int
 shrink_cache(struct zone *zone, unsigned int gfp_mask,
-		int max_scan, int *total_scanned, int do_writepage)
+		int max_scan, int *total_scanned, int do_writepage, int *nr_dirty)
 {
 	LIST_HEAD(page_list);
 	struct pagevec pvec;
@@ -521,7 +525,7 @@
 		else
 			mod_page_state_zone(zone, pgscan_direct, nr_scan);
 		nr_freed = shrink_list(&page_list, gfp_mask,
-					total_scanned, do_writepage);
+					total_scanned, do_writepage, nr_dirty);
 		*total_scanned += nr_taken;
 		if (current_is_kswapd())
 			mod_page_state(kswapd_steal, nr_freed);
@@ -576,7 +580,7 @@
  */
 static void
 refill_inactive_zone(struct zone *zone, const int nr_pages_in,
-			struct page_state *ps)
+			struct page_state *ps, int *nr_dirty)
 {
 	int pgmoved;
 	int pgdeactivate = 0;
@@ -649,12 +653,15 @@
 		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
 		if (page_mapped(page)) {
-			if (!reclaim_mapped) {
-				list_add(&page->lru, &l_active);
-				continue;
-			}
 			rmap_lock(page);
-			if (page_referenced(page)) {
+			if (!PageDirty(page) && page_mapping(page) && !TestSetPageLocked(page)) {
+				if (page_is_dirty(page)) {
+					set_page_dirty(page);
+					(*nr_dirty)++;
+				}
+				unlock_page(page);
+			}
+			if (!reclaim_mapped || page_referenced(page)) {
 				rmap_unlock(page);
 				list_add(&page->lru, &l_active);
 				continue;
@@ -734,7 +741,7 @@
  */
 static int
 shrink_zone(struct zone *zone, int max_scan, unsigned int gfp_mask,
-		int *total_scanned, struct page_state *ps, int do_writepage)
+		int *total_scanned, struct page_state *ps, int do_writepage, int *nr_dirty)
 {
 	unsigned long ratio;
 	int count;
@@ -756,7 +763,7 @@
 	count = atomic_read(&zone->nr_scan_active);
 	if (count >= SWAP_CLUSTER_MAX) {
 		atomic_set(&zone->nr_scan_active, 0);
-		refill_inactive_zone(zone, count, ps);
+		refill_inactive_zone(zone, count, ps, nr_dirty);
 	}
 
 	atomic_add(max_scan, &zone->nr_scan_inactive);
@@ -764,7 +771,7 @@
 	if (count >= SWAP_CLUSTER_MAX) {
 		atomic_set(&zone->nr_scan_inactive, 0);
 		return shrink_cache(zone, gfp_mask, count,
-					total_scanned, do_writepage);
+					total_scanned, do_writepage, nr_dirty);
 	}
 	return 0;
 }
@@ -794,7 +801,7 @@
 
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
-		int max_scan;
+		int max_scan, nr_dirty = 0;
 
 		if (zone->free_pages < zone->pages_high)
 			zone->temp_priority = priority;
@@ -804,7 +811,7 @@
 
 		max_scan = zone->nr_inactive >> priority;
 		ret += shrink_zone(zone, max_scan, gfp_mask,
-					total_scanned, ps, do_writepage);
+					total_scanned, ps, do_writepage, &nr_dirty);
 	}
 	return ret;
 }
@@ -919,6 +926,7 @@
 	unsigned long total_scanned = 0;
 	unsigned long total_reclaimed = 0;
 	int do_writepage = 0;
+	int nr_dirty = 0;
 
 	inc_page_state(pageoutrun);
 
@@ -980,7 +988,7 @@
 			zone->temp_priority = priority;
 			max_scan = zone->nr_inactive >> priority;
 			reclaimed = shrink_zone(zone, max_scan, GFP_KERNEL,
-					&scanned, ps, do_writepage);
+					&scanned, ps, do_writepage, &nr_dirty);
 			total_scanned += scanned;
 			reclaim_state->reclaimed_slab = 0;
 			shrink_slab(scanned, GFP_KERNEL);
@@ -1017,6 +1025,10 @@
 
 		zone->prev_priority = zone->temp_priority;
 	}
+	if (!laptop_mode && nr_dirty >= SWAP_CLUSTER_MAX) {
+		wakeup_bdflush(-1);
+		inc_page_state(bdflush);
+	}
 	return total_reclaimed;
 }
 

--0-1940874318-1083716429=:11112--
