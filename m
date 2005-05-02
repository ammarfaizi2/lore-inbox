Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVEBSox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVEBSox (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 14:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVEBSox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 14:44:53 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:62868 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261631AbVEBSom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 14:44:42 -0400
Message-ID: <42767516.4020101@us.ibm.com>
Date: Mon, 02 May 2005 11:44:38 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mbligh@aracnet.com
Subject: Re: [PATCH] Remove struct reclaim_state
References: <42718AA1.5010805@us.ibm.com> <20050429175108.242c410e.akpm@osdl.org>
In-Reply-To: <20050429175108.242c410e.akpm@osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030807070009000504000802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030807070009000504000802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
>>Since shrink_slab() currently returns 0 no matter what happens,
>> I changed it to return the number of slab pages freed.
> 
> 
> A sane cleanup, but it conflicts with vmscan-notice-slab-shrinking.patch,
> which returns a different thing from shrink_slab() in order to account for
> slab reclaim only causing internal fragmentation and not actually freeing
> pages yet.
> 
> vmscan-notice-slab-shrinking.patch isn't quite complete yet, but we do need
> to do something along these lines.  I need to get back onto it.

I hadn't seen that patch...  These can coexist fairly easily, though.  I
can change my patch to zero and then read current->reclaimed_slab *outside*
the call to shrink_slab.  It unfortunately shrinks less lines of code, and
leaves the hack that is current->reclaimed_slab exposed to more than one
function, but...

How's this look?

mcd@arrakis:~/linux/patches $ diffstat remove-reclaim_state.patch
 include/linux/sched.h |    3 +--
 include/linux/swap.h  |    8 --------
 mm/page_alloc.c       |    6 ------
 mm/slab.c             |    3 +--
 mm/vmscan.c           |   21 ++++-----------------
 5 files changed, 6 insertions(+), 35 deletions(-)

-Matt


--------------030807070009000504000802
Content-Type: text/x-patch;
 name="remove-reclaim_state.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove-reclaim_state.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.12-rc3/include/linux/sched.h linux-2.6.12-rc3+remove-reclaim_state/include/linux/sched.h
--- linux-2.6.12-rc3/include/linux/sched.h	2005-04-27 10:59:19.000000000 -0700
+++ linux-2.6.12-rc3+remove-reclaim_state/include/linux/sched.h	2005-04-28 17:30:09.000000000 -0700
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
+++ linux-2.6.12-rc3+remove-reclaim_state/mm/slab.c	2005-04-28 17:30:25.000000000 -0700
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
+++ linux-2.6.12-rc3+remove-reclaim_state/mm/vmscan.c	2005-05-02 11:37:28.852114056 -0700
@@ -913,7 +913,6 @@ int try_to_free_pages(struct zone **zone
 	int priority;
 	int ret = 0;
 	int total_scanned = 0, total_reclaimed = 0;
-	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 	unsigned long lru_pages = 0;
 	int i;
@@ -940,11 +939,9 @@ int try_to_free_pages(struct zone **zone
 		sc.priority = priority;
 		sc.swap_cluster_max = SWAP_CLUSTER_MAX;
 		shrink_caches(zones, &sc);
+		current->reclaimed_slab = 0;
 		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
-		if (reclaim_state) {
-			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
-			reclaim_state->reclaimed_slab = 0;
-		}
+		sc.nr_reclaimed += current->reclaimed_slab;
 		total_scanned += sc.nr_scanned;
 		total_reclaimed += sc.nr_reclaimed;
 		if (total_reclaimed >= sc.swap_cluster_max) {
@@ -1012,7 +1009,6 @@ static int balance_pgdat(pg_data_t *pgda
 	int priority;
 	int i;
 	int total_scanned, total_reclaimed;
-	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 
 loop_again:
@@ -1099,9 +1095,9 @@ scan:
 			sc.priority = priority;
 			sc.swap_cluster_max = nr_pages? nr_pages : SWAP_CLUSTER_MAX;
 			shrink_zone(zone, &sc);
-			reclaim_state->reclaimed_slab = 0;
+			current->reclaimed_slab = 0;
 			shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
-			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
+			sc.nr_reclaimed += current->reclaimed_slab;
 			total_reclaimed += sc.nr_reclaimed;
 			total_scanned += sc.nr_scanned;
 			if (zone->all_unreclaimable)
@@ -1171,16 +1167,12 @@ static int kswapd(void *p)
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
@@ -1254,11 +1246,7 @@ int shrink_all_memory(int nr_pages)
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
@@ -1267,7 +1255,6 @@ int shrink_all_memory(int nr_pages)
 		if (nr_to_free <= 0)
 			break;
 	}
-	current->reclaim_state = NULL;
 	return ret;
 }
 #endif

--------------030807070009000504000802--
