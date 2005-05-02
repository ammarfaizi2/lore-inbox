Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVEBTlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVEBTlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 15:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVEBTlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 15:41:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40393 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261732AbVEBTjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 15:39:18 -0400
Message-ID: <427681DF.4000208@us.ibm.com>
Date: Mon, 02 May 2005 12:39:11 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Dobson <colpatch@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@aracnet.com
Subject: Re: [PATCH] Remove struct reclaim_state
References: <42718AA1.5010805@us.ibm.com> <20050429175108.242c410e.akpm@osdl.org> <42767516.4020101@us.ibm.com>
In-Reply-To: <42767516.4020101@us.ibm.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000204030404010807020101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000204030404010807020101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Matthew Dobson wrote:
> Andrew Morton wrote:
> 
>>Matthew Dobson <colpatch@us.ibm.com> wrote:
>>
>>
>>>Since shrink_slab() currently returns 0 no matter what happens,
>>>I changed it to return the number of slab pages freed.
>>
>>
>>A sane cleanup, but it conflicts with vmscan-notice-slab-shrinking.patch,
>>which returns a different thing from shrink_slab() in order to account for
>>slab reclaim only causing internal fragmentation and not actually freeing
>>pages yet.
>>
>>vmscan-notice-slab-shrinking.patch isn't quite complete yet, but we do need
>>to do something along these lines.  I need to get back onto it.
> 
> 
> I hadn't seen that patch...  These can coexist fairly easily, though.  I
> can change my patch to zero and then read current->reclaimed_slab *outside*
> the call to shrink_slab.  It unfortunately shrinks less lines of code, and
> leaves the hack that is current->reclaimed_slab exposed to more than one
> function, but...
> 
> How's this look?
> 
> mcd@arrakis:~/linux/patches $ diffstat remove-reclaim_state.patch
>  include/linux/sched.h |    3 +--
>  include/linux/swap.h  |    8 --------
>  mm/page_alloc.c       |    6 ------
>  mm/slab.c             |    3 +--
>  mm/vmscan.c           |   21 ++++-----------------
>  5 files changed, 6 insertions(+), 35 deletions(-)
> 
> -Matt

Ok.  Now I'm getting REALLY crazy.  I noticed that try_to_free_pages() &
balance_pgdat() (the two callers of shrink_slab()) do something really
dumb: they set sc.nr_scanned to 0, call shrink_slab() with sc.nr_scanned as
a pass-by-value parameter, then do total_scanned += sc.nr_scanned, despite
knowing damn well that sc.nr_scanned = 0, since _they just set it to that_.
 I doubt we really want to be constantly incrementing total_scanned by 0.
We either don't want to update it, or we want to update it by the value
scanned gets in shrink_slab().

So, you're probably asking yourself, what is the point of all this
rambling?  What if we change shrink_slab() to take a struct scan_control *
instead of an unsigned long for it's first argument?  Then we can
_actually_ update nr_scanned AND nr_reclaimed directly inside of
shrink_slab() instead of trying to pass all this data back to the two
partially brain-dead callers.

Updated to 2.6.12-rc3-mm2, which includes
vmscan-notice-slab-shrinking.patch.  Look at all those -'s!! :)

mcd@arrakis:~/linux/patches $ diffstat remove-reclaim_state.patch
include/linux/sched.h |    3 +--
 include/linux/swap.h  |    8 --------
 mm/page_alloc.c       |    6 ------
 mm/slab.c             |    4 ++--
 mm/vmscan.c           |   36 ++++++++++++------------------------
 5 files changed, 15 insertions(+), 42 deletions(-)

Running it through a build & boot test now.  I'll let you know if it barfs.

-Matt

--------------000204030404010807020101
Content-Type: text/x-patch;
 name="remove-reclaim_state.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove-reclaim_state.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.12-rc3-mm2/include/linux/sched.h linux-2.6.12-rc3-mm2+remove-reclaim_state/include/linux/sched.h
--- linux-2.6.12-rc3-mm2/include/linux/sched.h	2005-05-02 12:16:13.820665112 -0700
+++ linux-2.6.12-rc3-mm2+remove-reclaim_state/include/linux/sched.h	2005-05-02 12:17:24.095981640 -0700
@@ -451,7 +451,6 @@ extern struct user_struct root_user;
 
 typedef struct prio_array prio_array_t;
 struct backing_dev_info;
-struct reclaim_state;
 
 #ifdef CONFIG_SCHEDSTATS
 struct sched_info {
@@ -751,7 +750,7 @@ struct task_struct {
 	void *journal_info;
 
 /* VM state */
-	struct reclaim_state *reclaim_state;
+	unsigned long *reclaimed_slab;
 
 	struct dentry *proc_dentry;
 	struct backing_dev_info *backing_dev_info;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.12-rc3-mm2/include/linux/swap.h linux-2.6.12-rc3-mm2+remove-reclaim_state/include/linux/swap.h
--- linux-2.6.12-rc3-mm2/include/linux/swap.h	2005-05-02 12:16:13.891654320 -0700
+++ linux-2.6.12-rc3-mm2+remove-reclaim_state/include/linux/swap.h	2005-05-02 12:17:24.117978296 -0700
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
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.12-rc3-mm2/mm/page_alloc.c linux-2.6.12-rc3-mm2+remove-reclaim_state/mm/page_alloc.c
--- linux-2.6.12-rc3-mm2/mm/page_alloc.c	2005-05-02 12:16:14.696531960 -0700
+++ linux-2.6.12-rc3-mm2+remove-reclaim_state/mm/page_alloc.c	2005-05-02 12:17:24.141974648 -0700
@@ -768,7 +768,6 @@ __alloc_pages(unsigned int __nocast gfp_
 	const int wait = gfp_mask & __GFP_WAIT;
 	struct zone **zones, *z;
 	struct page *page;
-	struct reclaim_state reclaim_state;
 	struct task_struct *p = current;
 	int i;
 	int classzone_idx;
@@ -860,12 +859,7 @@ rebalance:
 
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
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.12-rc3-mm2/mm/slab.c linux-2.6.12-rc3-mm2+remove-reclaim_state/mm/slab.c
--- linux-2.6.12-rc3-mm2/mm/slab.c	2005-05-02 12:16:14.766521320 -0700
+++ linux-2.6.12-rc3-mm2+remove-reclaim_state/mm/slab.c	2005-05-02 12:17:24.165971000 -0700
@@ -942,8 +942,8 @@ static void kmem_freepages(kmem_cache_t 
 		page++;
 	}
 	sub_page_state(nr_slab, nr_freed);
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += nr_freed;
+	if (current->reclaimed_slab)
+		*current->reclaimed_slab += nr_freed;
 	free_pages((unsigned long)addr, cachep->gfporder);
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT) 
 		atomic_sub(1<<cachep->gfporder, &slab_reclaim_pages);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.12-rc3-mm2/mm/vmscan.c linux-2.6.12-rc3-mm2+remove-reclaim_state/mm/vmscan.c
--- linux-2.6.12-rc3-mm2/mm/vmscan.c	2005-05-02 12:16:14.796516760 -0700
+++ linux-2.6.12-rc3-mm2+remove-reclaim_state/mm/vmscan.c	2005-05-02 12:26:14.313376344 -0700
@@ -190,23 +190,28 @@ EXPORT_SYMBOL(remove_shrinker);
  *
  * Returns the number of slab objects which we shrunk.
  */
-static int shrink_slab(unsigned long scanned, unsigned int gfp_mask,
+static int shrink_slab(struct scan_control *sc, unsigned int gfp_mask,
 			unsigned long lru_pages)
 {
 	struct shrinker *shrinker;
 	int ret = 0;
 
-	if (scanned == 0)
-		scanned = SWAP_CLUSTER_MAX;
+	if (sc->nr_scanned == 0)
+		sc->nr_scanned = SWAP_CLUSTER_MAX;
 
 	if (!down_read_trylock(&shrinker_rwsem))
 		return 1;	/* Assume we'll be able to shrink next time */
 
+	/*
+	 * Each shrinker will now increment sc->nr_reclaimed by the number
+	 * of pages it frees.
+	 */
+	current->reclaimed_slab = &sc->nr_reclaimed;
 	list_for_each_entry(shrinker, &shrinker_list, list) {
 		unsigned long long delta;
 		unsigned long total_scan;
 
-		delta = (4 * scanned) / shrinker->seeks;
+		delta = (4 * sc->nr_scanned) / shrinker->seeks;
 		delta *= (*shrinker->shrinker)(0, gfp_mask);
 		do_div(delta, lru_pages + 1);
 		shrinker->nr += delta;
@@ -235,6 +240,7 @@ static int shrink_slab(unsigned long sca
 
 		shrinker->nr += total_scan;
 	}
+	current->reclaimed_slab = NULL;
 	up_read(&shrinker_rwsem);
 	return ret;
 }
@@ -969,7 +975,6 @@ int try_to_free_pages(struct zone **zone
 	int priority;
 	int ret = 0;
 	int total_scanned = 0, total_reclaimed = 0;
-	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 	unsigned long lru_pages = 0;
 	int i;
@@ -998,11 +1003,7 @@ int try_to_free_pages(struct zone **zone
 		sc.priority = priority;
 		sc.swap_cluster_max = SWAP_CLUSTER_MAX;
 		shrink_caches(zones, &sc);
-		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
-		if (reclaim_state) {
-			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
-			reclaim_state->reclaimed_slab = 0;
-		}
+		shrink_slab(&sc, gfp_mask, lru_pages);
 		total_scanned += sc.nr_scanned;
 		total_reclaimed += sc.nr_reclaimed;
 		if (total_reclaimed >= sc.swap_cluster_max) {
@@ -1070,7 +1071,6 @@ static int balance_pgdat(pg_data_t *pgda
 	int priority;
 	int i;
 	int total_scanned, total_reclaimed;
-	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 
 loop_again:
@@ -1161,10 +1161,7 @@ scan:
 			sc.priority = priority;
 			sc.swap_cluster_max = nr_pages? nr_pages : SWAP_CLUSTER_MAX;
 			shrink_zone(zone, &sc);
-			reclaim_state->reclaimed_slab = 0;
-			nr_slab = shrink_slab(sc.nr_scanned, GFP_KERNEL,
-						lru_pages);
-			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
+			nr_slab = shrink_slab(&sc, GFP_KERNEL, lru_pages);
 			total_reclaimed += sc.nr_reclaimed;
 			total_scanned += sc.nr_scanned;
 			if (zone->unreclaimable == ALL_UNRECLAIMABLE)
@@ -1234,16 +1231,12 @@ static int kswapd(void *p)
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
@@ -1317,11 +1310,7 @@ int shrink_all_memory(int nr_pages)
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
@@ -1330,7 +1319,6 @@ int shrink_all_memory(int nr_pages)
 		if (nr_to_free <= 0)
 			break;
 	}
-	current->reclaim_state = NULL;
 	return ret;
 }
 #endif

--------------000204030404010807020101--
