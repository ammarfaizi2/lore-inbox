Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266546AbUA3Dfe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 22:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266562AbUA3Dfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 22:35:34 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:64406 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266546AbUA3Dd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 22:33:29 -0500
Message-ID: <4019CF5D.4050608@cyberone.com.au>
Date: Fri, 30 Jan 2004 14:28:29 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][CFT] mm swapping improvements
Content-Type: multipart/mixed;
 boundary="------------040007090102030907020501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040007090102030907020501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi list,

Attached is a patchset against 2.6.2-rc2-mm1 which includes two of
Nikita's patches and one of my own, and backs out the RSS limit patch
due to some problems (discussion of these patches on linux-mm).
The patchset improves VM performance under swapping quite significantly
for kbuild - its now close 2.4 or better in some cases.

I haven't done many other tests so I would like anyone who's had
swapping related slowdowns when moving from 2.4 to 2.6, and is
interested in helping improve it to test out the patch please.
I can make a patch against the -linus kernel if anyone would like.

Some benchmarks: http://www.kerneltrap.org/~npiggin/vm/3/
Green is 2.6, red is 2.4, purple is 2.6 with this patch.

Thank you.
Nick

PS (the usual disclaimer about mm patches vs your data)



--------------040007090102030907020501
Content-Type: text/plain;
 name="vm-swap-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-swap-1"

 linux-2.6-npiggin/include/linux/init_task.h |    2 
 linux-2.6-npiggin/include/linux/mmzone.h    |    6 +
 linux-2.6-npiggin/include/linux/sched.h     |    1 
 linux-2.6-npiggin/include/linux/swap.h      |    4 
 linux-2.6-npiggin/kernel/sys.c              |    8 -
 linux-2.6-npiggin/mm/page_alloc.c           |   20 +++
 linux-2.6-npiggin/mm/rmap.c                 |   19 ---
 linux-2.6-npiggin/mm/vmscan.c               |  162 +++++++++++++++++-----------
 8 files changed, 130 insertions(+), 92 deletions(-)

diff -puN include/linux/init_task.h~rollup include/linux/init_task.h
--- linux-2.6/include/linux/init_task.h~rollup	2004-01-30 14:10:31.000000000 +1100
+++ linux-2.6-npiggin/include/linux/init_task.h	2004-01-30 14:10:32.000000000 +1100
@@ -2,7 +2,6 @@
 #define _LINUX__INIT_TASK_H
 
 #include <linux/file.h>
-#include <asm/resource.h>
 
 #define INIT_FILES \
 { 							\
@@ -43,7 +42,6 @@
 	.mmlist		= LIST_HEAD_INIT(name.mmlist),		\
 	.cpu_vm_mask	= CPU_MASK_ALL,				\
 	.default_kioctx = INIT_KIOCTX(name.default_kioctx, name),	\
-	.rlimit_rss	= RLIM_INFINITY			\
 }
 
 #define INIT_SIGNALS(sig) {	\
diff -puN include/linux/mmzone.h~rollup include/linux/mmzone.h
--- linux-2.6/include/linux/mmzone.h~rollup	2004-01-30 14:10:31.000000000 +1100
+++ linux-2.6-npiggin/include/linux/mmzone.h	2004-01-30 14:10:32.000000000 +1100
@@ -149,6 +149,12 @@ struct zone {
 	unsigned long		zone_start_pfn;
 
 	/*
+	 * dummy page used as place holder during scanning of
+	 * active_list in refill_inactive_zone()
+	 */
+	struct page *scan_page;
+
+	/*
 	 * rarely used fields:
 	 */
 	char			*name;
diff -puN include/linux/sched.h~rollup include/linux/sched.h
--- linux-2.6/include/linux/sched.h~rollup	2004-01-30 14:10:31.000000000 +1100
+++ linux-2.6-npiggin/include/linux/sched.h	2004-01-30 14:10:32.000000000 +1100
@@ -206,7 +206,6 @@ struct mm_struct {
 	unsigned long arg_start, arg_end, env_start, env_end;
 	unsigned long rss, total_vm, locked_vm;
 	unsigned long def_flags;
-	unsigned long rlimit_rss;
 	cpumask_t cpu_vm_mask;
 
 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
diff -puN include/linux/swap.h~rollup include/linux/swap.h
--- linux-2.6/include/linux/swap.h~rollup	2004-01-30 14:10:32.000000000 +1100
+++ linux-2.6-npiggin/include/linux/swap.h	2004-01-30 14:10:32.000000000 +1100
@@ -179,7 +179,7 @@ extern int vm_swappiness;
 
 /* linux/mm/rmap.c */
 #ifdef CONFIG_MMU
-int FASTCALL(page_referenced(struct page *, int *));
+int FASTCALL(page_referenced(struct page *));
 struct pte_chain *FASTCALL(page_add_rmap(struct page *, pte_t *,
 					struct pte_chain *));
 void FASTCALL(page_remove_rmap(struct page *, pte_t *));
@@ -188,7 +188,7 @@ int FASTCALL(try_to_unmap(struct page *)
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
 #else
-#define page_referenced(page, _x)	TestClearPageReferenced(page)
+#define page_referenced(page)	TestClearPageReferenced(page)
 #define try_to_unmap(page)	SWAP_FAIL
 #endif /* CONFIG_MMU */
 
diff -puN kernel/sys.c~rollup kernel/sys.c
--- linux-2.6/kernel/sys.c~rollup	2004-01-30 14:10:32.000000000 +1100
+++ linux-2.6-npiggin/kernel/sys.c	2004-01-30 14:10:32.000000000 +1100
@@ -1306,14 +1306,6 @@ asmlinkage long sys_setrlimit(unsigned i
 	if (retval)
 		return retval;
 
-	/* The rlimit is specified in bytes, convert to pages for mm. */
-	if (resource == RLIMIT_RSS && current->mm) {
-		unsigned long pages = RLIM_INFINITY;
-		if (new_rlim.rlim_cur != RLIM_INFINITY)
-			pages = new_rlim.rlim_cur >> PAGE_SHIFT;
-		current->mm->rlimit_rss = pages;
-	}
-
 	*old_rlim = new_rlim;
 	return 0;
 }
diff -puN mm/page_alloc.c~rollup mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~rollup	2004-01-30 14:10:32.000000000 +1100
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-01-30 14:10:32.000000000 +1100
@@ -1211,6 +1211,9 @@ void __init memmap_init_zone(struct page
 	memmap_init_zone((start), (size), (nid), (zone), (start_pfn))
 #endif
 
+/* dummy pages used to scan active lists */
+static struct page scan_pages[MAX_NUMNODES][MAX_NR_ZONES];
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -1233,6 +1236,7 @@ static void __init free_area_init_core(s
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, realsize;
 		unsigned long batch;
+		struct page *scan_page;
 
 		zone_table[NODEZONE(nid, j)] = zone;
 		realsize = size = zones_size[j];
@@ -1287,6 +1291,22 @@ static void __init free_area_init_core(s
 		atomic_set(&zone->refill_counter, 0);
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+
+		/* initialize dummy page used for scanning */
+		scan_page = &scan_pages[nid][j];
+		zone->scan_page = scan_page;
+		memset(scan_page, 0, sizeof *scan_page);
+		scan_page->flags =
+			(1 << PG_locked) |
+			(1 << PG_error) |
+			(1 << PG_lru) |
+			(1 << PG_active) |
+			(1 << PG_reserved);
+		set_page_zone(scan_page, j);
+		page_cache_get(scan_page);
+		INIT_LIST_HEAD(&scan_page->list);
+		list_add(&scan_page->lru, &zone->active_list);
+
 		if (!size)
 			continue;
 
diff -puN mm/rmap.c~rollup mm/rmap.c
--- linux-2.6/mm/rmap.c~rollup	2004-01-30 14:10:32.000000000 +1100
+++ linux-2.6-npiggin/mm/rmap.c	2004-01-30 14:10:32.000000000 +1100
@@ -104,8 +104,6 @@ pte_chain_encode(struct pte_chain *pte_c
 /**
  * page_referenced - test if the page was referenced
  * @page: the page to test
- * @rsslimit: set if the process(es) using the page is(are) over RSS limit.
- *            Cleared otherwise.
  *
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of processes which referenced the page.
@@ -113,13 +111,9 @@ pte_chain_encode(struct pte_chain *pte_c
  *
  * If the page has a single-entry pte_chain, collapse that back to a PageDirect
  * representation.  This way, it's only done under memory pressure.
- *
- * The pte_chain_lock() is sufficient to pin down mm_structs which we examine
- * them.
  */
-int page_referenced(struct page *page, int *rsslimit)
+int page_referenced(struct page * page)
 {
-	struct mm_struct * mm;
 	struct pte_chain *pc;
 	int referenced = 0;
 
@@ -133,17 +127,10 @@ int page_referenced(struct page *page, i
 		pte_t *pte = rmap_ptep_map(page->pte.direct);
 		if (ptep_test_and_clear_young(pte))
 			referenced++;
-
-		mm = ptep_to_mm(pte);
-		if (mm->rss > mm->rlimit_rss)
-			*rsslimit = 1;
 		rmap_ptep_unmap(pte);
 	} else {
 		int nr_chains = 0;
 
-		/* We clear it if any task using the page is under its limit. */
-		*rsslimit = 1;
-
 		/* Check all the page tables mapping this page. */
 		for (pc = page->pte.chain; pc; pc = pte_chain_next(pc)) {
 			int i;
@@ -155,10 +142,6 @@ int page_referenced(struct page *page, i
 				p = rmap_ptep_map(pte_paddr);
 				if (ptep_test_and_clear_young(p))
 					referenced++;
-
-				mm = ptep_to_mm(p);
-				if (mm->rss < mm->rlimit_rss)
-					*rsslimit = 0;
 				rmap_ptep_unmap(p);
 				nr_chains++;
 			}
diff -puN mm/vmscan.c~rollup mm/vmscan.c
--- linux-2.6/mm/vmscan.c~rollup	2004-01-30 14:10:32.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2004-01-30 14:10:32.000000000 +1100
@@ -43,14 +43,15 @@
 int vm_swappiness = 60;
 static long total_memory;
 
+#define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
+
 #ifdef ARCH_HAS_PREFETCH
 #define prefetch_prev_lru_page(_page, _base, _field)			\
 	do {								\
 		if ((_page)->lru.prev != _base) {			\
 			struct page *prev;				\
 									\
-			prev = list_entry(_page->lru.prev,		\
-					struct page, lru);		\
+			prev = lru_to_page(&(_page)->lru);		\
 			prefetch(&prev->_field);			\
 		}							\
 	} while (0)
@@ -64,8 +65,7 @@ static long total_memory;
 		if ((_page)->lru.prev != _base) {			\
 			struct page *prev;				\
 									\
-			prev = list_entry(_page->lru.prev,		\
-					struct page, lru);		\
+			prev = lru_to_page(&(_page)->lru);		\
 			prefetchw(&prev->_field);			\
 		}							\
 	} while (0)
@@ -250,7 +250,6 @@ shrink_list(struct list_head *page_list,
 	LIST_HEAD(ret_pages);
 	struct pagevec freed_pvec;
 	int pgactivate = 0;
-	int over_rsslimit;
 	int ret = 0;
 
 	cond_resched();
@@ -261,7 +260,7 @@ shrink_list(struct list_head *page_list,
 		int may_enter_fs;
 		int referenced;
 
-		page = list_entry(page_list->prev, struct page, lru);
+		page = lru_to_page(page_list);
 		list_del(&page->lru);
 
 		if (TestSetPageLocked(page))
@@ -279,8 +278,8 @@ shrink_list(struct list_head *page_list,
 			goto keep_locked;
 
 		pte_chain_lock(page);
-		referenced = page_referenced(page, &over_rsslimit);
-		if (referenced && page_mapping_inuse(page) && !over_rsslimit) {
+		referenced = page_referenced(page);
+		if (referenced && page_mapping_inuse(page)) {
 			/* In active use or really unfreeable.  Activate it. */
 			pte_chain_unlock(page);
 			goto activate_locked;
@@ -505,8 +504,7 @@ shrink_cache(const int nr_pages, struct 
 
 		while (nr_scan++ < nr_to_process &&
 				!list_empty(&zone->inactive_list)) {
-			page = list_entry(zone->inactive_list.prev,
-						struct page, lru);
+			page = lru_to_page(&zone->inactive_list);
 
 			prefetchw_prev_lru_page(page,
 						&zone->inactive_list, flags);
@@ -544,7 +542,7 @@ shrink_cache(const int nr_pages, struct 
 		 * Put back any unfreeable pages.
 		 */
 		while (!list_empty(&page_list)) {
-			page = list_entry(page_list.prev, struct page, lru);
+			page = lru_to_page(&page_list);
 			if (TestSetPageLRU(page))
 				BUG();
 			list_del(&page->lru);
@@ -565,6 +563,39 @@ done:
 	return ret;
 }
 
+
+/* move pages from @page_list to the @spot, that should be somewhere on the
+ * @zone->active_list */
+static int
+spill_on_spot(struct zone *zone,
+	      struct list_head *page_list, struct list_head *spot,
+	      struct pagevec *pvec)
+{
+	struct page *page;
+	int          moved;
+
+	moved = 0;
+	while (!list_empty(page_list)) {
+		page = lru_to_page(page_list);
+		prefetchw_prev_lru_page(page, page_list, flags);
+		if (TestSetPageLRU(page))
+			BUG();
+		BUG_ON(!PageActive(page));
+		list_move(&page->lru, spot);
+		moved++;
+		if (!pagevec_add(pvec, page)) {
+			zone->nr_active += moved;
+			moved = 0;
+			spin_unlock_irq(&zone->lru_lock);
+			__pagevec_release(pvec);
+			spin_lock_irq(&zone->lru_lock);
+		}
+	}
+	return moved;
+}
+
+
+
 /*
  * This moves pages from the active list to the inactive list.
  *
@@ -591,37 +622,17 @@ refill_inactive_zone(struct zone *zone, 
 	int nr_pages = nr_pages_in;
 	LIST_HEAD(l_hold);	/* The pages which were snipped off */
 	LIST_HEAD(l_inactive);	/* Pages to go onto the inactive_list */
-	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
+	LIST_HEAD(l_ignore);	/* Pages to be returned to the active_list */
+	LIST_HEAD(l_active);	/* Pages to go onto the head of the
+				 * active_list */
+
 	struct page *page;
+	struct page *scan;
 	struct pagevec pvec;
 	int reclaim_mapped = 0;
 	long mapped_ratio;
 	long distress;
 	long swap_tendency;
-	int over_rsslimit;
-
-	lru_add_drain();
-	pgmoved = 0;
-	spin_lock_irq(&zone->lru_lock);
-	while (nr_pages && !list_empty(&zone->active_list)) {
-		page = list_entry(zone->active_list.prev, struct page, lru);
-		prefetchw_prev_lru_page(page, &zone->active_list, flags);
-		if (!TestClearPageLRU(page))
-			BUG();
-		list_del(&page->lru);
-		if (page_count(page) == 0) {
-			/* It is currently in pagevec_release() */
-			SetPageLRU(page);
-			list_add(&page->lru, &zone->active_list);
-		} else {
-			page_cache_get(page);
-			list_add(&page->lru, &l_hold);
-			pgmoved++;
-		}
-		nr_pages--;
-	}
-	zone->nr_active -= pgmoved;
-	spin_unlock_irq(&zone->lru_lock);
 
 	/*
 	 * `distress' is a measure of how much trouble we're having reclaiming
@@ -654,23 +665,66 @@ refill_inactive_zone(struct zone *zone, 
 	if (swap_tendency >= 100)
 		reclaim_mapped = 1;
 
+	scan = zone->scan_page;
+	lru_add_drain();
+	pgmoved = 0;
+	spin_lock_irq(&zone->lru_lock);
+	if (reclaim_mapped) {
+		/*
+		 * When scanning active_list with !reclaim_mapped mapped
+		 * inactive pages are left behind zone->scan_page. If zone is
+		 * switched to reclaim_mapped mode reset zone->scan_page to
+		 * the end of inactive list so that inactive mapped pages are
+		 * re-scanned.
+		 */
+		list_move_tail(&scan->lru, &zone->active_list);
+	}
+	while (nr_pages && zone->active_list.prev != zone->active_list.next) {
+		/*
+		 * if head of active list reached---wrap to the tail
+		 */
+		if (scan->lru.prev == &zone->active_list)
+			list_move_tail(&scan->lru, &zone->active_list);
+		page = lru_to_page(&scan->lru);
+		prefetchw_prev_lru_page(page, &zone->active_list, flags);
+		if (!TestClearPageLRU(page))
+			BUG();
+		list_del(&page->lru);
+		if (page_count(page) == 0) {
+			/* It is currently in pagevec_release() */
+			SetPageLRU(page);
+			list_add(&page->lru, &zone->active_list);
+		} else {
+			page_cache_get(page);
+			list_add(&page->lru, &l_hold);
+			pgmoved++;
+		}
+		nr_pages--;
+	}
+	zone->nr_active -= pgmoved;
+	spin_unlock_irq(&zone->lru_lock);
+
 	while (!list_empty(&l_hold)) {
-		page = list_entry(l_hold.prev, struct page, lru);
+		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
 		if (page_mapped(page)) {
+
+			if (!reclaim_mapped) {
+				list_add(&page->lru, &l_ignore);
+				continue;
+			}
+
+			/*
+			 * probably it would be useful to transfer dirty bit
+			 * from pte to the @page here.
+			 */
 			pte_chain_lock(page);
-			if (page_mapped(page) &&
-					page_referenced(page, &over_rsslimit) &&
-					!over_rsslimit) {
+			if (page_mapped(page) && page_referenced(page)) {
 				pte_chain_unlock(page);
 				list_add(&page->lru, &l_active);
 				continue;
 			}
 			pte_chain_unlock(page);
-			if (!reclaim_mapped) {
-				list_add(&page->lru, &l_active);
-				continue;
-			}
 		}
 		/*
 		 * FIXME: need to consider page_count(page) here if/when we
@@ -688,7 +742,7 @@ refill_inactive_zone(struct zone *zone, 
 	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
 	while (!list_empty(&l_inactive)) {
-		page = list_entry(l_inactive.prev, struct page, lru);
+		page = lru_to_page(&l_inactive);
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
 		if (TestSetPageLRU(page))
 			BUG();
@@ -715,23 +769,9 @@ refill_inactive_zone(struct zone *zone, 
 		spin_lock_irq(&zone->lru_lock);
 	}
 
-	pgmoved = 0;
-	while (!list_empty(&l_active)) {
-		page = list_entry(l_active.prev, struct page, lru);
-		prefetchw_prev_lru_page(page, &l_active, flags);
-		if (TestSetPageLRU(page))
-			BUG();
-		BUG_ON(!PageActive(page));
-		list_move(&page->lru, &zone->active_list);
-		pgmoved++;
-		if (!pagevec_add(&pvec, page)) {
+	pgmoved = spill_on_spot(zone, &l_active, &zone->active_list, &pvec);
 			zone->nr_active += pgmoved;
-			pgmoved = 0;
-			spin_unlock_irq(&zone->lru_lock);
-			__pagevec_release(&pvec);
-			spin_lock_irq(&zone->lru_lock);
-		}
-	}
+	pgmoved = spill_on_spot(zone, &l_ignore, &scan->lru, &pvec);
 	zone->nr_active += pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(&pvec);

_

--------------040007090102030907020501--
