Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265313AbUFHUvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265313AbUFHUvk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 16:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUFHUvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 16:51:31 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:24976 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264275AbUFHUvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 16:51:15 -0400
Date: Tue, 8 Jun 2004 21:51:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Arjan van de Ven <arjanv@redhat.com>,
       Joern Engel <joern@wohnheim.fh-wedel.de>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] stop page_state stack waste
Message-ID: <Pine.LNX.4.44.0406082144070.9094-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace get_page_state (which memset most of full page_state to 0) by
get_main_page_state, which just sets the small structure needed.  This
helps 4k stacks not to overflow: cuts 224 bytes off try_to_free_pages
and wakeup_bdflush (and sync_inodes_sb) stack usages: wakeup_bdflush
doesn't do much, but is called by try_to_free_pages and mempool_alloc.

(224 bytes saved when building for P4 with 128-byte cacheline, less on
PIII: seems the ____cacheline_aligned struct got aligned on the stack.)

Signed-off-by: Hugh Dickins <hugh@veritas.com>

Patch below against 2.6.7-rc3, in the hope it might get into 2.6.7:
but doesn't apply against the -mm vmscan.c (which just needs struct
page_state replaced by struct main_page_state and get_page_state by
get_main_page_state twice).

 fs/fs-writeback.c          |    4 ++--
 fs/proc/proc_misc.c        |    4 ++--
 include/linux/page-flags.h |   29 ++++++++++++++++-------------
 mm/page-writeback.c        |   22 +++++++++++-----------
 mm/page_alloc.c            |   29 ++++++++++++++---------------
 mm/vmscan.c                |   22 ++++++++++++----------
 6 files changed, 57 insertions(+), 53 deletions(-)

--- 2.6.7-rc3/fs/fs-writeback.c	2004-06-08 14:00:24.000000000 +0100
+++ linux/fs/fs-writeback.c	2004-06-08 20:33:18.577327984 +0100
@@ -423,7 +423,7 @@ restart:
  */
 void sync_inodes_sb(struct super_block *sb, int wait)
 {
-	struct page_state ps;
+	struct main_page_state ps;
 	struct writeback_control wbc = {
 		.bdi		= NULL,
 		.sync_mode	= wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
@@ -431,7 +431,7 @@ void sync_inodes_sb(struct super_block *
 		.nr_to_write	= 0,
 	};
 
-	get_page_state(&ps);
+	get_main_page_state(&ps);
 	wbc.nr_to_write = ps.nr_dirty + ps.nr_unstable +
 			(inodes_stat.nr_inodes - inodes_stat.nr_unused) +
 			ps.nr_dirty + ps.nr_unstable;
--- 2.6.7-rc3/fs/proc/proc_misc.c	2004-06-08 14:00:28.000000000 +0100
+++ linux/fs/proc/proc_misc.c	2004-06-08 20:33:18.578327832 +0100
@@ -158,14 +158,14 @@ static int meminfo_read_proc(char *page,
 {
 	struct sysinfo i;
 	int len, committed;
-	struct page_state ps;
+	struct main_page_state ps;
 	unsigned long inactive;
 	unsigned long active;
 	unsigned long free;
 	unsigned long vmtot;
 	struct vmalloc_info vmi;
 
-	get_page_state(&ps);
+	get_main_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
 
 /*
--- 2.6.7-rc3/include/linux/page-flags.h	2004-06-08 14:00:36.000000000 +0100
+++ linux/include/linux/page-flags.h	2004-06-08 20:33:18.579327680 +0100
@@ -83,19 +83,22 @@
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
  */
-struct page_state {
-	unsigned long nr_dirty;		/* Dirty writeable pages */
-	unsigned long nr_writeback;	/* Pages under writeback */
-	unsigned long nr_unstable;	/* NFS unstable pages */
-	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-	unsigned long nr_mapped;	/* mapped into pagetables */
+
+#define MAIN_PAGE_STATE \
+	unsigned long nr_dirty;		/* Dirty writeable pages */	\
+	unsigned long nr_writeback;	/* Pages under writeback */	\
+	unsigned long nr_unstable;	/* NFS unstable pages */	\
+	unsigned long nr_page_table_pages; /* Used for pagetables */	\
+	unsigned long nr_mapped;	/* Mapped into pagetables */	\
 	unsigned long nr_slab;		/* In slab */
-#define GET_PAGE_STATE_LAST nr_slab
 
-	/*
-	 * The below are zeroed by get_page_state().  Use get_full_page_state()
-	 * to add up all these.
-	 */
+struct main_page_state {
+	MAIN_PAGE_STATE
+};
+
+struct page_state {
+	MAIN_PAGE_STATE			/* Assumed to come first */
+
 	unsigned long pgpgin;		/* Disk reads */
 	unsigned long pgpgout;		/* Disk writes */
 	unsigned long pswpin;		/* swap reads */
@@ -137,8 +140,8 @@ struct page_state {
 
 DECLARE_PER_CPU(struct page_state, page_states);
 
-extern void get_page_state(struct page_state *ret);
-extern void get_full_page_state(struct page_state *ret);
+extern void get_main_page_state(struct main_page_state *mps);
+extern void get_full_page_state(struct page_state *fps);
 
 #define mod_page_state(member, delta)					\
 	do {								\
--- 2.6.7-rc3/mm/page-writeback.c	2004-06-08 14:00:38.000000000 +0100
+++ linux/mm/page-writeback.c	2004-06-08 20:33:18.580327528 +0100
@@ -117,7 +117,7 @@ static void background_writeout(unsigned
  * clamping level.
  */
 static void
-get_dirty_limits(struct page_state *ps, long *pbackground, long *pdirty)
+get_dirty_limits(struct main_page_state *ps, long *pbackground, long *pdirty)
 {
 	int background_ratio;		/* Percentages */
 	int dirty_ratio;
@@ -126,7 +126,7 @@ get_dirty_limits(struct page_state *ps, 
 	long dirty;
 	struct task_struct *tsk;
 
-	get_page_state(ps);
+	get_main_page_state(ps);
 
 	unmapped_ratio = 100 - (ps->nr_mapped * 100) / total_pages;
 
@@ -161,7 +161,7 @@ get_dirty_limits(struct page_state *ps, 
  */
 static void balance_dirty_pages(struct address_space *mapping)
 {
-	struct page_state ps;
+	struct main_page_state ps;
 	long nr_reclaimable;
 	long background_thresh;
 	long dirty_thresh;
@@ -232,7 +232,7 @@ static void balance_dirty_pages(struct a
  * which was newly dirtied.  The function will periodically check the system's
  * dirty state and will initiate writeback if needed.
  *
- * On really big machines, get_page_state is expensive, so try to avoid calling
+ * On really big machines, get_main_page_state is expensive, so try to avoid calling
  * it too often (ratelimiting).  But once we're over the dirty memory limit we
  * decrease the ratelimiting by a lot, to prevent individual processes from
  * overshooting the limit by (ratelimit_pages) each.
@@ -276,7 +276,7 @@ static void background_writeout(unsigned
 	};
 
 	for ( ; ; ) {
-		struct page_state ps;
+		struct main_page_state ps;
 		long background_thresh;
 		long dirty_thresh;
 
@@ -306,9 +306,9 @@ static void background_writeout(unsigned
 int wakeup_bdflush(long nr_pages)
 {
 	if (nr_pages == 0) {
-		struct page_state ps;
+		struct main_page_state ps;
 
-		get_page_state(&ps);
+		get_main_page_state(&ps);
 		nr_pages = ps.nr_dirty + ps.nr_unstable;
 	}
 	return pdflush_operation(background_writeout, nr_pages);
@@ -343,7 +343,7 @@ static void wb_kupdate(unsigned long arg
 	unsigned long start_jif;
 	unsigned long next_jif;
 	long nr_to_write;
-	struct page_state ps;
+	struct main_page_state ps;
 	struct writeback_control wbc = {
 		.bdi		= NULL,
 		.sync_mode	= WB_SYNC_NONE,
@@ -355,7 +355,7 @@ static void wb_kupdate(unsigned long arg
 
 	sync_supers();
 
-	get_page_state(&ps);
+	get_main_page_state(&ps);
 	oldest_jif = jiffies - (dirty_expire_centisecs * HZ) / 100;
 	start_jif = jiffies;
 	next_jif = start_jif + (dirty_writeback_centisecs * HZ) / 100;
@@ -434,8 +434,8 @@ void laptop_sync_completion(void)
 /*
  * If ratelimit_pages is too high then we can get into dirty-data overload
  * if a large number of processes all perform writes at the same time.
- * If it is too low then SMP machines will call the (expensive) get_page_state
- * too often.
+ * If it is too low then SMP machines will call the (expensive)
+ * get_main_page_state too often.
  *
  * Here we set ratelimit_pages to a level which ensures that when all CPUs are
  * dirtying in parallel, we cannot go more than 3% (1/32) over the dirty memory
--- 2.6.7-rc3/mm/page_alloc.c	2004-06-08 14:00:38.000000000 +0100
+++ linux/mm/page_alloc.c	2004-06-08 20:33:18.582327224 +0100
@@ -950,13 +950,13 @@ EXPORT_SYMBOL(nr_pagecache);
 DEFINE_PER_CPU(long, nr_pagecache_local) = 0;
 #endif
 
-void __get_page_state(struct page_state *ret, int nr)
+static void __get_page_state(unsigned long *ret, int nr)
 {
 	int cpu = 0;
 
-	memset(ret, 0, sizeof(*ret));
 	while (cpu < NR_CPUS) {
-		unsigned long *in, *out, off;
+		unsigned long *in, *out;
+		int off;
 
 		if (!cpu_possible(cpu)) {
 			cpu++;
@@ -967,25 +967,24 @@ void __get_page_state(struct page_state 
 		cpu++;
 		if (cpu < NR_CPUS && cpu_possible(cpu))
 			prefetch(&per_cpu(page_states, cpu));
-		out = (unsigned long *)ret;
+		out = ret;
 		for (off = 0; off < nr; off++)
 			*out++ += *in++;
 	}
 }
 
-void get_page_state(struct page_state *ret)
+void get_main_page_state(struct main_page_state *mps)
 {
-	int nr;
-
-	nr = offsetof(struct page_state, GET_PAGE_STATE_LAST);
-	nr /= sizeof(unsigned long);
-
-	__get_page_state(ret, nr + 1);
+	memset(mps, 0, sizeof(*mps));
+	__get_page_state((unsigned long *) mps,
+		sizeof(*mps) / sizeof(unsigned long));
 }
 
-void get_full_page_state(struct page_state *ret)
+void get_full_page_state(struct page_state *fps)
 {
-	__get_page_state(ret, sizeof(*ret) / sizeof(unsigned long));
+	memset(fps, 0, sizeof(*fps));
+	__get_page_state((unsigned long *) fps,
+		sizeof(*fps) / sizeof(unsigned long));
 }
 
 void get_zone_counts(unsigned long *active,
@@ -1043,7 +1042,7 @@ void si_meminfo_node(struct sysinfo *val
  */
 void show_free_areas(void)
 {
-	struct page_state ps;
+	struct main_page_state ps;
 	int cpu, temperature;
 	unsigned long active;
 	unsigned long inactive;
@@ -1078,7 +1077,7 @@ void show_free_areas(void)
 		}
 	}
 
-	get_page_state(&ps);
+	get_main_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
 
 	printk("\nFree pages: %11ukB (%ukB HighMem)\n",
--- 2.6.7-rc3/mm/vmscan.c	2004-06-08 14:00:39.000000000 +0100
+++ linux/mm/vmscan.c	2004-06-08 20:33:18.584326920 +0100
@@ -578,7 +578,7 @@ done:
  */
 static void
 refill_inactive_zone(struct zone *zone, const int nr_pages_in,
-			struct page_state *ps)
+			struct main_page_state *ps)
 {
 	int pgmoved;
 	int pgdeactivate = 0;
@@ -741,7 +741,8 @@ refill_inactive_zone(struct zone *zone, 
  */
 static int
 shrink_zone(struct zone *zone, int max_scan, unsigned int gfp_mask,
-		int *total_scanned, struct page_state *ps, int do_writepage)
+		int *total_scanned, struct main_page_state *ps,
+		int do_writepage)
 {
 	unsigned long scan_active;
 	int count;
@@ -804,7 +805,7 @@ shrink_zone(struct zone *zone, int max_s
  */
 static int
 shrink_caches(struct zone **zones, int priority, int *total_scanned,
-		int gfp_mask, struct page_state *ps, int do_writepage)
+		int gfp_mask, struct main_page_state *ps, int do_writepage)
 {
 	int ret = 0;
 	int i;
@@ -862,9 +863,9 @@ int try_to_free_pages(struct zone **zone
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int scanned = 0;
-		struct page_state ps;
+		struct main_page_state ps;
 
-		get_page_state(&ps);
+		get_main_page_state(&ps);
 		nr_reclaimed += shrink_caches(zones, priority, &scanned,
 						gfp_mask, &ps, do_writepage);
 		shrink_slab(scanned, gfp_mask);
@@ -928,7 +929,8 @@ out:
  * the page allocator fallback scheme to ensure that aging of pages is balanced
  * across the zones.
  */
-static int balance_pgdat(pg_data_t *pgdat, int nr_pages, struct page_state *ps)
+static int balance_pgdat(pg_data_t *pgdat, int nr_pages,
+			struct main_page_state *ps)
 {
 	int to_free = nr_pages;
 	int priority;
@@ -1085,14 +1087,14 @@ int kswapd(void *p)
 	tsk->flags |= PF_MEMALLOC|PF_KSWAPD;
 
 	for ( ; ; ) {
-		struct page_state ps;
+		struct main_page_state ps;
 
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_FREEZE);
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
 		schedule();
 		finish_wait(&pgdat->kswapd_wait, &wait);
-		get_page_state(&ps);
+		get_main_page_state(&ps);
 		balance_pgdat(pgdat, 0, &ps);
 	}
 }
@@ -1126,9 +1128,9 @@ int shrink_all_memory(int nr_pages)
 	current->reclaim_state = &reclaim_state;
 	for_each_pgdat(pgdat) {
 		int freed;
-		struct page_state ps;
+		struct main_page_state ps;
 
-		get_page_state(&ps);
+		get_main_page_state(&ps);
 		freed = balance_pgdat(pgdat, nr_to_free, &ps);
 		ret += freed;
 		nr_to_free -= freed;

