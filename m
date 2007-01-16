Return-Path: <linux-kernel-owner+w=401wt.eu-S1750899AbXAPK2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbXAPK2j (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 05:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbXAPK2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 05:28:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43219 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbXAPK2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 05:28:23 -0500
Message-Id: <20070116101815.261599000@taijtu.programming.kicks-ass.net>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net>
User-Agent: quilt/0.46-1
Date: Tue, 16 Jan 2007 10:45:59 +0100
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org
Cc: David Miller <davem@davemloft.net>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 2/9] mm: slab allocation fairness
Content-Disposition: inline; filename=slab-ranking.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The slab allocator has some unfairness wrt gfp flags; when the slab cache is
grown the gfp flags are used to allocate more memory, however when there is 
slab cache available (in partial or free slabs, per cpu caches or otherwise)
gfp flags are ignored.

Thus it is possible for less critical slab allocations to succeed and gobble
up precious memory when under memory pressure.

This patch solves that by using the newly introduced page allocation rank.

Page allocation rank is a scalar quantity connecting ALLOC_ and gfp flags which
represents how deep we had to reach into our reserves when allocating a page. 
Rank 0 is the deepest we can reach (ALLOC_NO_WATERMARK) and 16 is the most 
shallow allocation possible (ALLOC_WMARK_HIGH).

When the slab space is grown the rank of the page allocation is stored. For
each slab allocation we test the given gfp flags against this rank. Thereby
asking the question: would these flags have allowed the slab to grow.

If not so, we need to test the current situation. This is done by forcing the
growth of the slab space. (Just testing the free page limits will not work due
to direct reclaim) Failing this we need to fail the slab allocation.

Thus if we grew the slab under great duress while PF_MEMALLOC was set and we 
really did access the memalloc reserve the rank would be set to 0. If the next
allocation to that slab would be GFP_NOFS|__GFP_NOMEMALLOC (which ordinarily
maps to rank 4 and always > 0) we'd want to make sure that memory pressure has
decreased enough to allow an allocation with the given gfp flags.

So in this case we try to force grow the slab cache and on failure we fail the
slab allocation. Thus preserving the available slab cache for more pressing
allocations.

If this newly allocated slab will be trimmed on the next kmem_cache_free
(not unlikely) this is no problem, since 1) it will free memory and 2) the
sole purpose of the allocation was to probe the allocation rank, we didn't
need the space itself.

[AIM9 results go here]

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/slab.c |   61 ++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

Index: linux-2.6-git/mm/slab.c
===================================================================
--- linux-2.6-git.orig/mm/slab.c	2007-01-08 11:53:13.000000000 +0100
+++ linux-2.6-git/mm/slab.c	2007-01-09 11:30:00.000000000 +0100
@@ -114,6 +114,7 @@
 #include	<asm/cacheflush.h>
 #include	<asm/tlbflush.h>
 #include	<asm/page.h>
+#include	"internal.h"
 
 /*
  * DEBUG	- 1 for kmem_cache_create() to honour; SLAB_DEBUG_INITIAL,
@@ -380,6 +381,7 @@ static void kmem_list3_init(struct kmem_
 
 struct kmem_cache {
 /* 1) per-cpu data, touched during every alloc/free */
+	int rank;
 	struct array_cache *array[NR_CPUS];
 /* 2) Cache tunables. Protected by cache_chain_mutex */
 	unsigned int batchcount;
@@ -1021,21 +1023,21 @@ static inline int cache_free_alien(struc
 }
 
 static inline void *alternate_node_alloc(struct kmem_cache *cachep,
-		gfp_t flags)
+		gfp_t flags, int rank)
 {
 	return NULL;
 }
 
 static inline void *____cache_alloc_node(struct kmem_cache *cachep,
-		 gfp_t flags, int nodeid)
+		 gfp_t flags, int nodeid, int rank)
 {
 	return NULL;
 }
 
 #else	/* CONFIG_NUMA */
 
-static void *____cache_alloc_node(struct kmem_cache *, gfp_t, int);
-static void *alternate_node_alloc(struct kmem_cache *, gfp_t);
+static void *____cache_alloc_node(struct kmem_cache *, gfp_t, int, int);
+static void *alternate_node_alloc(struct kmem_cache *, gfp_t, int);
 
 static struct array_cache **alloc_alien_cache(int node, int limit)
 {
@@ -1624,6 +1626,7 @@ static void *kmem_getpages(struct kmem_c
 	if (!page)
 		return NULL;
 
+	cachep->rank = page->index;
 	nr_pages = (1 << cachep->gfporder);
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
 		add_zone_page_state(page_zone(page),
@@ -2272,6 +2275,7 @@ kmem_cache_create (const char *name, siz
 	}
 #endif
 #endif
+	cachep->rank = MAX_ALLOC_RANK;
 
 	/*
 	 * Determine if the slab management is 'on' or 'off' slab.
@@ -2944,7 +2948,7 @@ bad:
 #define check_slabp(x,y) do { } while(0)
 #endif
 
-static void *cache_alloc_refill(struct kmem_cache *cachep, gfp_t flags)
+static void *cache_alloc_refill(struct kmem_cache *cachep, gfp_t flags, int rank)
 {
 	int batchcount;
 	struct kmem_list3 *l3;
@@ -2956,6 +2960,8 @@ static void *cache_alloc_refill(struct k
 	check_irq_off();
 	ac = cpu_cache_get(cachep);
 retry:
+	if (unlikely(rank > cachep->rank))
+		goto force_grow;
 	batchcount = ac->batchcount;
 	if (!ac->touched && batchcount > BATCHREFILL_LIMIT) {
 		/*
@@ -3011,14 +3017,16 @@ must_grow:
 	l3->free_objects -= ac->avail;
 alloc_done:
 	spin_unlock(&l3->list_lock);
-
 	if (unlikely(!ac->avail)) {
 		int x;
+force_grow:
 		x = cache_grow(cachep, flags | GFP_THISNODE, node, NULL);
 
 		/* cache_grow can reenable interrupts, then ac could change. */
 		ac = cpu_cache_get(cachep);
-		if (!x && ac->avail == 0)	/* no objects in sight? abort */
+
+		/* no objects in sight? abort */
+		if (!x && (ac->avail == 0 || rank > cachep->rank))
 			return NULL;
 
 		if (!ac->avail)		/* objects refilled by interrupt? */
@@ -3175,7 +3183,8 @@ static inline int should_failslab(struct
 
 #endif /* CONFIG_FAILSLAB */
 
-static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
+static inline void *____cache_alloc(struct kmem_cache *cachep,
+		gfp_t flags, int rank)
 {
 	void *objp;
 	struct array_cache *ac;
@@ -3186,13 +3195,13 @@ static inline void *____cache_alloc(stru
 		return NULL;
 
 	ac = cpu_cache_get(cachep);
-	if (likely(ac->avail)) {
+	if (likely(ac->avail && rank <= cachep->rank)) {
 		STATS_INC_ALLOCHIT(cachep);
 		ac->touched = 1;
 		objp = ac->entry[--ac->avail];
 	} else {
 		STATS_INC_ALLOCMISS(cachep);
-		objp = cache_alloc_refill(cachep, flags);
+		objp = cache_alloc_refill(cachep, flags, rank);
 	}
 	return objp;
 }
@@ -3202,6 +3211,7 @@ static __always_inline void *__cache_all
 {
 	unsigned long save_flags;
 	void *objp = NULL;
+	int rank = gfp_to_rank(flags);
 
 	cache_alloc_debugcheck_before(cachep, flags);
 
@@ -3209,16 +3219,16 @@ static __always_inline void *__cache_all
 
 	if (unlikely(NUMA_BUILD &&
 			current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY)))
-		objp = alternate_node_alloc(cachep, flags);
+		objp = alternate_node_alloc(cachep, flags, rank);
 
 	if (!objp)
-		objp = ____cache_alloc(cachep, flags);
+		objp = ____cache_alloc(cachep, flags, rank);
 	/*
 	 * We may just have run out of memory on the local node.
 	 * ____cache_alloc_node() knows how to locate memory on other nodes
 	 */
  	if (NUMA_BUILD && !objp)
- 		objp = ____cache_alloc_node(cachep, flags, numa_node_id());
+ 		objp = ____cache_alloc_node(cachep, flags, numa_node_id(), rank);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
 					    caller);
@@ -3233,7 +3243,8 @@ static __always_inline void *__cache_all
  * If we are in_interrupt, then process context, including cpusets and
  * mempolicy, may not apply and should not be used for allocation policy.
  */
-static void *alternate_node_alloc(struct kmem_cache *cachep, gfp_t flags)
+static void *alternate_node_alloc(struct kmem_cache *cachep,
+		gfp_t flags, int rank)
 {
 	int nid_alloc, nid_here;
 
@@ -3245,7 +3256,7 @@ static void *alternate_node_alloc(struct
 	else if (current->mempolicy)
 		nid_alloc = slab_node(current->mempolicy);
 	if (nid_alloc != nid_here)
-		return ____cache_alloc_node(cachep, flags, nid_alloc);
+		return ____cache_alloc_node(cachep, flags, nid_alloc, rank);
 	return NULL;
 }
 
@@ -3257,7 +3268,7 @@ static void *alternate_node_alloc(struct
  * allocator to do its reclaim / fallback magic. We then insert the
  * slab into the proper nodelist and then allocate from it.
  */
-void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
+void *fallback_alloc(struct kmem_cache *cache, gfp_t flags, int rank)
 {
 	struct zonelist *zonelist = &NODE_DATA(slab_node(current->mempolicy))
 					->node_zonelists[gfp_zone(flags)];
@@ -3278,7 +3289,7 @@ retry:
 			cache->nodelists[nid] &&
 			cache->nodelists[nid]->free_objects)
 				obj = ____cache_alloc_node(cache,
-					flags | GFP_THISNODE, nid);
+					flags | GFP_THISNODE, nid, rank);
 	}
 
 	if (!obj && !(flags & __GFP_NO_GROW)) {
@@ -3301,7 +3312,7 @@ retry:
 			nid = page_to_nid(virt_to_page(obj));
 			if (cache_grow(cache, flags, nid, obj)) {
 				obj = ____cache_alloc_node(cache,
-					flags | GFP_THISNODE, nid);
+					flags | GFP_THISNODE, nid, rank);
 				if (!obj)
 					/*
 					 * Another processor may allocate the
@@ -3322,7 +3333,7 @@ retry:
  * A interface to enable slab creation on nodeid
  */
 static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
-				int nodeid)
+				int nodeid, int rank)
 {
 	struct list_head *entry;
 	struct slab *slabp;
@@ -3335,6 +3346,8 @@ static void *____cache_alloc_node(struct
 
 retry:
 	check_irq_off();
+	if (unlikely(rank > cachep->rank))
+		goto force_grow;
 	spin_lock(&l3->list_lock);
 	entry = l3->slabs_partial.next;
 	if (entry == &l3->slabs_partial) {
@@ -3370,13 +3383,14 @@ retry:
 
 must_grow:
 	spin_unlock(&l3->list_lock);
+force_grow:
 	x = cache_grow(cachep, flags | GFP_THISNODE, nodeid, NULL);
 	if (x)
 		goto retry;
 
 	if (!(flags & __GFP_THISNODE))
 		/* Unable to grow the cache. Fall back to other nodes. */
-		return fallback_alloc(cachep, flags);
+		return fallback_alloc(cachep, flags, rank);
 
 	return NULL;
 
@@ -3600,6 +3614,7 @@ __cache_alloc_node(struct kmem_cache *ca
 {
 	unsigned long save_flags;
 	void *ptr = NULL;
+	int rank = gfp_to_rank(flags);
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
@@ -3615,16 +3630,16 @@ __cache_alloc_node(struct kmem_cache *ca
 			 * to other nodes. It may fail while we still have
 			 * objects on other nodes available.
 			 */
-			ptr = ____cache_alloc(cachep, flags);
+			ptr = ____cache_alloc(cachep, flags, rank);
 		}
 		if (!ptr) {
 			/* ___cache_alloc_node can fall back to other nodes */
-			ptr = ____cache_alloc_node(cachep, flags, nodeid);
+			ptr = ____cache_alloc_node(cachep, flags, nodeid, rank);
 		}
 	} else {
 		/* Node not bootstrapped yet */
 		if (!(flags & __GFP_THISNODE))
-			ptr = fallback_alloc(cachep, flags);
+			ptr = fallback_alloc(cachep, flags, rank);
 	}
 
 	local_irq_restore(save_flags);

-- 

