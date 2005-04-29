Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVD2BPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVD2BPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 21:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVD2BPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 21:15:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:13290 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262367AbVD2BPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 21:15:18 -0400
Message-ID: <42718AA1.5010805@us.ibm.com>
Date: Thu, 28 Apr 2005 18:15:13 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>,
       "Bligh, Martin J." <mbligh@aracnet.com>
Subject: [PATCH] Remove struct reclaim_state
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000100050503070207000901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000100050503070207000901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

So I made a note to myself a while back to have a look at what this struct
reclaim_state thing was all about.  It turns out it's referenced in WAY too
many places for what it does.

The idea is that during memory reclaim, we want to keep track of how many
pages get freed up by the various slab shrinkers.  The memory is eventually
freed in kmem_freepages() and there is not convenient place to store the
number of slab pages we freed.  So, at some point in history, we decided to
store it in the current task's task structure.  Unfortunately we decided to
store it in a really obfuscated way that made my brain hurt.  So I ripped
it out.

The only place that *ever* updates current->reclaim_state->reclaimed_slab
to be anything but 0 is kmem_freepages().  The only places that give a
woozy wombat's bottom about the value of reclaimed_slab are
try_to_free_pages() & balance_pgdat().  These two functions zero
current->reclaim_state->reclaimed_slab, call shrink_slab(), then look at
the value.  Since shrink_slab() currently returns 0 no matter what happens,
I changed it to return the number of slab pages freed.  This saves us 30
lines of code, makes the what's going on much more clear, and may even be a
smidge faster.  It builds, boots, and survives kernbench runs on i386.

mcd@arrakis:~/linux/source $ diffstat
~/linux/patches/remove-reclaim_state.patch
 include/linux/sched.h |    3 +--
 include/linux/swap.h  |    8 --------
 mm/page_alloc.c       |    6 ------
 mm/slab.c             |    3 +--
 mm/vmscan.c           |   26 ++++++--------------------
 5 files changed, 8 insertions(+), 38 deletions(-)

-Matt

--------------000100050503070207000901
Content-Type: text/x-patch;
 name="remove-reclaim_state.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove-reclaim_state.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.12-rc3/include/linux/sched.h linux-2.6.12-rc3+remove-reclaim_state/include/linux/sched.h
--- linux-2.6.12-rc3/include/linux/sched.h	2005-04-27 10:59:19.000000000 -0700
+++ linux-2.6.12-rc3+remove-reclaim_state/include/linux/sched.h	2005-04-28 17:30:09.474874296 -0700
@@ -425,7 +425,6 @@ extern struct user_struct root_user;
 
 typedef struct prio_array prio_array_t;
 struct backing_dev_info;
-struct reclaim_state;
 
 #ifdef CONFIG_SCHEDSTATS
 struct sched_info {
@@ -705,7 +704,7 @@ struct task_struct {
 	void *journal_info;
 
 /* VM state */
-	struct reclaim_state *reclaim_state;
+	unsigned long reclaimed_slab;
 
 	struct dentry *proc_dentry;
 	struct backing_dev_info *backing_dev_info;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.12-rc3/include/linux/swap.h linux-2.6.12-rc3+remove-reclaim_state/include/linux/swap.h
--- linux-2.6.12-rc3/include/linux/swap.h	2005-04-27 10:59:18.000000000 -0700
+++ linux-2.6.12-rc3+remove-reclaim_state/include/linux/swap.h	2005-04-27 15:54:49.000000000 -0700
@@ -65,14 +65,6 @@ typedef struct {
 	unsigned long val;
 } swp_entry_t;
 
-/*
- * current->reclaim_state points to one of these when a task is running
- * memory reclaim
- */
-struct reclaim_state {
-	unsigned long reclaimed_slab;
-};
-
 #ifdef __KERNEL__
 
 struct address_space;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.12-rc3/mm/page_alloc.c linux-2.6.12-rc3+remove-reclaim_state/mm/page_alloc.c
--- linux-2.6.12-rc3/mm/page_alloc.c	2005-04-27 11:00:00.000000000 -0700
+++ linux-2.6.12-rc3+remove-reclaim_state/mm/page_alloc.c	2005-04-27 17:08:33.000000000 -0700
@@ -732,7 +732,6 @@ __alloc_pages(unsigned int __nocast gfp_
 	const int wait = gfp_mask & __GFP_WAIT;
 	struct zone **zones, *z;
 	struct page *page;
-	struct reclaim_state reclaim_state;
 	struct task_struct *p = current;
 	int i;
 	int classzone_idx;
@@ -820,12 +819,7 @@ rebalance:
 
 	/* We now go into synchronous reclaim */
 	p->flags |= PF_MEMALLOC;
-	reclaim_state.reclaimed_slab = 0;
-	p->reclaim_state = &reclaim_state;
-
 	did_some_progress = try_to_free_pages(zones, gfp_mask, order);
-
-	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
 
 	cond_resched();
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.12-rc3/mm/slab.c linux-2.6.12-rc3+remove-reclaim_state/mm/slab.c
--- linux-2.6.12-rc3/mm/slab.c	2005-04-27 11:00:00.000000000 -0700
+++ linux-2.6.12-rc3+remove-reclaim_state/mm/slab.c	2005-04-28 17:30:25.472442296 -0700
@@ -937,8 +937,7 @@ static void kmem_freepages(kmem_cache_t 
 		page++;
 	}
 	sub_page_state(nr_slab, nr_freed);
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += nr_freed;
+	current->reclaimed_slab += nr_freed;
 	free_pages((unsigned long)addr, cachep->gfporder);
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT) 
 		atomic_sub(1<<cachep->gfporder, &slab_reclaim_pages);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.12-rc3/mm/vmscan.c linux-2.6.12-rc3+remove-reclaim_state/mm/vmscan.c
--- linux-2.6.12-rc3/mm/vmscan.c	2005-04-27 11:00:00.000000000 -0700
+++ linux-2.6.12-rc3+remove-reclaim_state/mm/vmscan.c	2005-04-28 17:31:05.579345120 -0700
@@ -180,6 +180,8 @@ EXPORT_SYMBOL(remove_shrinker);
  * `lru_pages' represents the number of on-LRU pages in all the zones which
  * are eligible for the caller's allocation attempt.  It is used for balancing
  * slab reclaim versus page reclaim.
+ *
+ * Return number of slab pages freed.
  */
 static int shrink_slab(unsigned long scanned, unsigned int gfp_mask,
 			unsigned long lru_pages)
@@ -192,6 +194,7 @@ static int shrink_slab(unsigned long sca
 	if (!down_read_trylock(&shrinker_rwsem))
 		return 0;
 
+	current->reclaimed_slab = 0;
 	list_for_each_entry(shrinker, &shrinker_list, list) {
 		unsigned long long delta;
 		unsigned long total_scan;
@@ -222,7 +225,7 @@ static int shrink_slab(unsigned long sca
 		shrinker->nr += total_scan;
 	}
 	up_read(&shrinker_rwsem);
-	return 0;
+	return current->reclaimed_slab;
 }
 
 /* Called without lock on whether page is mapped, so answer is unstable */
@@ -913,7 +916,6 @@ int try_to_free_pages(struct zone **zone
 	int priority;
 	int ret = 0;
 	int total_scanned = 0, total_reclaimed = 0;
-	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 	unsigned long lru_pages = 0;
 	int i;
@@ -940,11 +942,7 @@ int try_to_free_pages(struct zone **zone
 		sc.priority = priority;
 		sc.swap_cluster_max = SWAP_CLUSTER_MAX;
 		shrink_caches(zones, &sc);
-		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
-		if (reclaim_state) {
-			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
-			reclaim_state->reclaimed_slab = 0;
-		}
+		sc.nr_reclaimed += shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
 		total_scanned += sc.nr_scanned;
 		total_reclaimed += sc.nr_reclaimed;
 		if (total_reclaimed >= sc.swap_cluster_max) {
@@ -1012,7 +1010,6 @@ static int balance_pgdat(pg_data_t *pgda
 	int priority;
 	int i;
 	int total_scanned, total_reclaimed;
-	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 
 loop_again:
@@ -1099,9 +1096,7 @@ scan:
 			sc.priority = priority;
 			sc.swap_cluster_max = nr_pages? nr_pages : SWAP_CLUSTER_MAX;
 			shrink_zone(zone, &sc);
-			reclaim_state->reclaimed_slab = 0;
-			shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
-			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
+			sc.nr_reclaimed += shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
 			total_reclaimed += sc.nr_reclaimed;
 			total_scanned += sc.nr_scanned;
 			if (zone->all_unreclaimable)
@@ -1171,16 +1166,12 @@ static int kswapd(void *p)
 	pg_data_t *pgdat = (pg_data_t*)p;
 	struct task_struct *tsk = current;
 	DEFINE_WAIT(wait);
-	struct reclaim_state reclaim_state = {
-		.reclaimed_slab = 0,
-	};
 	cpumask_t cpumask;
 
 	daemonize("kswapd%d", pgdat->node_id);
 	cpumask = node_to_cpumask(pgdat->node_id);
 	if (!cpus_empty(cpumask))
 		set_cpus_allowed(tsk, cpumask);
-	current->reclaim_state = &reclaim_state;
 
 	/*
 	 * Tell the memory management that we're a "memory allocator",
@@ -1254,11 +1245,7 @@ int shrink_all_memory(int nr_pages)
 	pg_data_t *pgdat;
 	int nr_to_free = nr_pages;
 	int ret = 0;
-	struct reclaim_state reclaim_state = {
-		.reclaimed_slab = 0,
-	};
 
-	current->reclaim_state = &reclaim_state;
 	for_each_pgdat(pgdat) {
 		int freed;
 		freed = balance_pgdat(pgdat, nr_to_free, 0);
@@ -1267,7 +1254,6 @@ int shrink_all_memory(int nr_pages)
 		if (nr_to_free <= 0)
 			break;
 	}
-	current->reclaim_state = NULL;
 	return ret;
 }
 #endif

--------------000100050503070207000901--
