Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262865AbSJLDUq>; Fri, 11 Oct 2002 23:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262866AbSJLDUq>; Fri, 11 Oct 2002 23:20:46 -0400
Received: from packet.digeo.com ([12.110.80.53]:46060 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262865AbSJLDUn>;
	Fri, 11 Oct 2002 23:20:43 -0400
Message-ID: <3DA7965F.D58E5FA1@digeo.com>
Date: Fri, 11 Oct 2002 20:26:23 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.41-mm3
References: <3DA699AA.BBA05716@digeo.com> <E180C1o-0000Uz-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2002 03:26:24.0089 (UTC) FILETIME=[24338490:01C2719F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Friday 11 October 2002 11:28, Andrew Morton wrote:
> > . Turns out that the idea of unmapped mapped pagecache a little earlier
> >   than swapping out anon memory was a poor one.
> 
> Translation into English?
> 

Sorry.  Twas a strategic typo.  "unmapping mapped pagecache".

What I was doing was to reclaim file-backed mmapped data a little
more eagerly than to start swapping anonymous memory.  Under the
theory that program text can be reestablished with one IO, but swapout
needs two.

Disabling that cool idea made things heaps better, so....

I assume what was happening was that we'd reach the "reclaim mapped
pagecache" level, reclaim a ton of memory and then never start
swapping.

Actually, the thing which throws the spanner in the works, again and
again and again and again is having lots of dirty pagecache around. 
The more stuff I put in over there, and the more the kernel clamps
down on the heavy writers, makes them write back their own data (actually
their own spindle....) the better things get.

Here's the diff.  It is really just 2.4 in disguise.



 include/linux/swap.h   |    1 
 include/linux/sysctl.h |    1 
 kernel/sysctl.c        |    3 +
 mm/vmscan.c            |  103 +++++++++++++++++++++++++++++++++++++++----------
 4 files changed, 89 insertions(+), 19 deletions(-)

--- 2.5.41/mm/vmscan.c~swappiness	Fri Oct 11 11:18:11 2002
+++ 2.5.41-akpm/mm/vmscan.c	Fri Oct 11 11:18:47 2002
@@ -35,13 +35,18 @@
 #include <linux/swapops.h>
 
 /*
- * The "priority" of VM scanning is how much of the queues we
- * will scan in one go. A value of 12 for DEF_PRIORITY implies
- * that we'll scan 1/4096th of the queues ("queue_length >> 12")
- * during a normal aging round.
+ * The "priority" of VM scanning is how much of the queues we will scan in one
+ * go. A value of 12 for DEF_PRIORITY implies that we will scan 1/4096th of the
+ * queues ("queue_length >> 12") during an aging round.
  */
 #define DEF_PRIORITY 12
 
+/*
+ * From 0 .. 100.  Higher means more swappy.
+ */
+int vm_swappiness = 60;
+static long total_memory;
+
 #ifdef ARCH_HAS_PREFETCH
 #define prefetch_prev_lru_page(_page, _base, _field)			\
 	do {								\
@@ -101,7 +106,6 @@ static inline int is_page_cache_freeable
 	return page_count(page) - !!PagePrivate(page) == 2;
 }
 
-
 /*
  * shrink_list returns the number of reclaimed pages
  */
@@ -439,7 +443,8 @@ done:
  * But we had to alter page->flags anyway.
  */
 static /* inline */ void
-refill_inactive_zone(struct zone *zone, const int nr_pages_in)
+refill_inactive_zone(struct zone *zone, const int nr_pages_in,
+			struct page_state *ps, int priority)
 {
 	int pgdeactivate = 0;
 	int nr_pages = nr_pages_in;
@@ -448,6 +453,10 @@ refill_inactive_zone(struct zone *zone, 
 	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
 	struct page *page;
 	struct pagevec pvec;
+	int reclaim_mapped = 0;
+	long mapped_ratio;
+	long distress;
+	long swap_tendency;
 
 	lru_add_drain();
 	spin_lock_irq(&zone->lru_lock);
@@ -469,6 +478,37 @@ refill_inactive_zone(struct zone *zone, 
 	}
 	spin_unlock_irq(&zone->lru_lock);
 
+	/*
+	 * `distress' is a measure of how much trouble we're having reclaiming
+	 * pages.  0 -> no problems.  100 -> great trouble.
+	 */
+	distress = 100 >> priority;
+
+	/*
+	 * The point of this algorithm is to decide when to start reclaiming
+	 * mapped memory instead of just pagecache.  Work out how much memory
+	 * is mapped.
+	 */
+	mapped_ratio = (ps->nr_mapped * 100) / total_memory;
+
+	/*
+	 * Now decide how much we really want to unmap some pages.  The mapped
+	 * ratio is downgraded - just because there's a lot of mapped memory
+	 * doesn't necessarily mean that page reclaim isn't succeeding.
+	 *
+	 * The distress ratio is important - we don't want to start going oom.
+	 *
+	 * A 100% value of vm_swappiness overrides this algorithm altogether.
+	 */
+	swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
+
+	/*
+	 * Now use this metric to decide whether to start moving mapped memory
+	 * onto the inactive list.
+	 */
+	if (swap_tendency >= 100)
+		reclaim_mapped = 1;
+
 	while (!list_empty(&l_hold)) {
 		page = list_entry(l_hold.prev, struct page, lru);
 		list_del(&page->lru);
@@ -480,6 +520,10 @@ refill_inactive_zone(struct zone *zone, 
 				continue;
 			}
 			pte_chain_unlock(page);
+			if (!reclaim_mapped) {
+				list_add(&page->lru, &l_active);
+				continue;
+			}
 		}
 		/*
 		 * FIXME: need to consider page_count(page) here if/when we
@@ -546,7 +590,7 @@ refill_inactive_zone(struct zone *zone, 
  */
 static /* inline */ int
 shrink_zone(struct zone *zone, int max_scan, unsigned int gfp_mask,
-		const int nr_pages, int *nr_mapped)
+	const int nr_pages, int *nr_mapped, struct page_state *ps, int priority)
 {
 	unsigned long ratio;
 
@@ -563,11 +607,23 @@ shrink_zone(struct zone *zone, int max_s
 	ratio = (unsigned long)nr_pages * zone->nr_active /
 				((zone->nr_inactive | 1) * 2);
 	atomic_add(ratio+1, &zone->refill_counter);
-	while (atomic_read(&zone->refill_counter) > SWAP_CLUSTER_MAX) {
-		atomic_sub(SWAP_CLUSTER_MAX, &zone->refill_counter);
-		refill_inactive_zone(zone, SWAP_CLUSTER_MAX);
+	if (atomic_read(&zone->refill_counter) > SWAP_CLUSTER_MAX) {
+		int count;
+
+		/*
+		 * Don't try to bring down too many pages in one attempt.
+		 * If this fails, the caller will increase `priority' and
+		 * we'll try again, with an increased chance of reclaiming
+		 * mapped memory.
+		 */
+		count = atomic_read(&zone->refill_counter);
+		if (count > SWAP_CLUSTER_MAX * 4)
+			count = SWAP_CLUSTER_MAX * 4;
+		atomic_sub(count, &zone->refill_counter);
+		refill_inactive_zone(zone, count, ps, priority);
 	}
-	return shrink_cache(nr_pages, zone, gfp_mask, max_scan, nr_mapped);
+	return shrink_cache(nr_pages, zone, gfp_mask,
+				max_scan, nr_mapped);
 }
 
 /*
@@ -603,7 +659,8 @@ static void shrink_slab(int total_scanne
  */
 static int
 shrink_caches(struct zone *classzone, int priority, int *total_scanned,
-		int gfp_mask, const int nr_pages, int order)
+		int gfp_mask, const int nr_pages, int order,
+		struct page_state *ps)
 {
 	struct zone *first_classzone;
 	struct zone *zone;
@@ -630,7 +687,7 @@ shrink_caches(struct zone *classzone, in
 		if (max_scan < to_reclaim * 2)
 			max_scan = to_reclaim * 2;
 		ret += shrink_zone(zone, max_scan, gfp_mask,
-				to_reclaim, &nr_mapped);
+				to_reclaim, &nr_mapped, ps, priority);
 		*total_scanned += max_scan;
 		*total_scanned += nr_mapped;
 		if (ret >= nr_pages)
@@ -666,12 +723,14 @@ try_to_free_pages(struct zone *classzone
 
 	inc_page_state(pageoutrun);
 
-	for (priority = DEF_PRIORITY; priority; priority--) {
+	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int total_scanned = 0;
+		struct page_state ps;
 
+		get_page_state(&ps);
 		nr_reclaimed += shrink_caches(classzone, priority,
 					&total_scanned, gfp_mask,
-					nr_pages, order);
+					nr_pages, order, &ps);
 		if (nr_reclaimed >= nr_pages)
 			return 1;
 		if (total_scanned == 0)
@@ -704,7 +763,7 @@ try_to_free_pages(struct zone *classzone
  *
  * Returns the number of pages which were actually freed.
  */
-static int balance_pgdat(pg_data_t *pgdat, int nr_pages)
+static int balance_pgdat(pg_data_t *pgdat, int nr_pages, struct page_state *ps)
 {
 	int to_free = nr_pages;
 	int priority;
@@ -729,7 +788,7 @@ static int balance_pgdat(pg_data_t *pgda
 			if (max_scan < to_reclaim * 2)
 				max_scan = to_reclaim * 2;
 			to_free -= shrink_zone(zone, max_scan, GFP_KSWAPD,
-					to_reclaim, &nr_mapped);
+					to_reclaim, &nr_mapped, ps, priority);
 			shrink_slab(max_scan + nr_mapped, GFP_KSWAPD);
 		}
 		if (success)
@@ -778,12 +837,15 @@ int kswapd(void *p)
 	tsk->flags |= PF_MEMALLOC|PF_KSWAPD;
 
 	for ( ; ; ) {
+		struct page_state ps;
+
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_IOTHREAD);
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
 		schedule();
 		finish_wait(&pgdat->kswapd_wait, &wait);
-		balance_pgdat(pgdat, 0);
+		get_page_state(&ps);
+		balance_pgdat(pgdat, 0, &ps);
 		blk_run_queues();
 	}
 }
@@ -801,8 +863,10 @@ int shrink_all_memory(int nr_pages)
 
 	for_each_pgdat(pgdat) {
 		int freed;
+		struct page_state ps;
 
-		freed = balance_pgdat(pgdat, nr_to_free);
+		get_page_state(&ps);
+		freed = balance_pgdat(pgdat, nr_to_free, &ps);
 		ret += freed;
 		nr_to_free -= freed;
 		if (nr_to_free <= 0)
@@ -819,6 +883,7 @@ static int __init kswapd_init(void)
 	swap_setup();
 	for_each_pgdat(pgdat)
 		kernel_thread(kswapd, pgdat, CLONE_KERNEL);
+	total_memory = nr_free_pagecache_pages();
 	return 0;
 }
 
--- 2.5.41/kernel/sysctl.c~swappiness	Fri Oct 11 11:18:11 2002
+++ 2.5.41-akpm/kernel/sysctl.c	Fri Oct 11 11:18:12 2002
@@ -308,6 +308,9 @@ static ctl_table vm_table[] = {
 	{ VM_NR_PDFLUSH_THREADS, "nr_pdflush_threads",
 	  &nr_pdflush_threads, sizeof nr_pdflush_threads,
 	  0444 /* read-only*/, NULL, &proc_dointvec},
+	{VM_SWAPPINESS, "swappiness", &vm_swappiness, sizeof(vm_swappiness),
+	 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL, &zero,
+	 &one_hundred },
 #ifdef CONFIG_HUGETLB_PAGE
 	 {VM_HUGETLB_PAGES, "nr_hugepages", &htlbpage_max, sizeof(int), 0644, NULL, 
 	  &proc_dointvec},
--- 2.5.41/include/linux/sysctl.h~swappiness	Fri Oct 11 11:18:11 2002
+++ 2.5.41-akpm/include/linux/sysctl.h	Fri Oct 11 11:18:12 2002
@@ -152,6 +152,7 @@ enum
 	VM_OVERCOMMIT_RATIO=16, /* percent of RAM to allow overcommit in */
 	VM_PAGEBUF=17,		/* struct: Control pagebuf parameters */
 	VM_HUGETLB_PAGES=18,	/* int: Number of available Huge Pages */
+	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
 };
 
 
--- 2.5.41/include/linux/swap.h~swappiness	Fri Oct 11 11:18:11 2002
+++ 2.5.41-akpm/include/linux/swap.h	Fri Oct 11 11:18:12 2002
@@ -164,6 +164,7 @@ extern void swap_setup(void);
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone *, unsigned int, unsigned int);
 int shrink_all_memory(int nr_pages);
+extern int vm_swappiness;
 
 /* linux/mm/page_io.c */
 int swap_readpage(struct file *file, struct page *page);

.
