Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWI2MGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWI2MGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 08:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWI2MGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 08:06:12 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:60044 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030186AbWI2MGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 08:06:11 -0400
Date: Fri, 29 Sep 2006 15:06:07 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, christoph@lameter.com
Subject: [PATCH] slab: reduce numa text size
Message-ID: <Pine.LNX.4.58.0609291505060.6223@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch reduces NUMA text size of mm/slab.o a little on x86 by using
a local variable to store the result of numa_node_id().

    text    data     bss     dec     hex filename
   16858    2584      16   19458    4c02 mm/slab.o (before)
   16804    2584      16   19404    4bcc mm/slab.o (after)

Cc: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

diff --git a/mm/slab.c b/mm/slab.c
index 792bfe3..baf8355 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1107,15 +1107,18 @@ static inline int cache_free_alien(struc
 	int nodeid = slabp->nodeid;
 	struct kmem_list3 *l3;
 	struct array_cache *alien = NULL;
+	int this_node;
+
+	this_node = numa_node_id();
 
 	/*
 	 * Make sure we are not freeing a object from another node to the array
 	 * cache on this cpu.
 	 */
-	if (likely(slabp->nodeid == numa_node_id()))
+	if (likely(slabp->nodeid == this_node))
 		return 0;
 
-	l3 = cachep->nodelists[numa_node_id()];
+	l3 = cachep->nodelists[this_node];
 	STATS_INC_NODEFREES(cachep);
 	if (l3->alien && l3->alien[nodeid]) {
 		alien = l3->alien[nodeid];
@@ -1353,6 +1356,7 @@ void __init kmem_cache_init(void)
 	struct cache_names *names;
 	int i;
 	int order;
+	int this_node;
 
 	for (i = 0; i < NUM_INIT_LISTS; i++) {
 		kmem_list3_init(&initkmem_list3[i]);
@@ -1387,12 +1391,14 @@ void __init kmem_cache_init(void)
 	 * 6) Resize the head arrays of the kmalloc caches to their final sizes.
 	 */
 
+	this_node = numa_node_id();
+
 	/* 1) create the cache_cache */
 	INIT_LIST_HEAD(&cache_chain);
 	list_add(&cache_cache.next, &cache_chain);
 	cache_cache.colour_off = cache_line_size();
 	cache_cache.array[smp_processor_id()] = &initarray_cache.cache;
-	cache_cache.nodelists[numa_node_id()] = &initkmem_list3[CACHE_CACHE];
+	cache_cache.nodelists[this_node] = &initkmem_list3[CACHE_CACHE];
 
 	cache_cache.buffer_size = ALIGN(cache_cache.buffer_size,
 					cache_line_size());
@@ -1500,7 +1506,7 @@ void __init kmem_cache_init(void)
 		int node;
 		/* Replace the static kmem_list3 structures for the boot cpu */
 		init_list(&cache_cache, &initkmem_list3[CACHE_CACHE],
-			  numa_node_id());
+			  this_node);
 
 		for_each_online_node(node) {
 			init_list(malloc_sizes[INDEX_AC].cs_cachep,
@@ -2897,6 +2903,9 @@ static void *cache_alloc_refill(struct k
 	int batchcount;
 	struct kmem_list3 *l3;
 	struct array_cache *ac;
+	int this_node;
+
+	this_node = numa_node_id();
 
 	check_irq_off();
 	ac = cpu_cache_get(cachep);
@@ -2910,7 +2919,7 @@ retry:
 		 */
 		batchcount = BATCHREFILL_LIMIT;
 	}
-	l3 = cachep->nodelists[numa_node_id()];
+	l3 = cachep->nodelists[this_node];
 
 	BUG_ON(ac->avail > 0 || !l3);
 	spin_lock(&l3->list_lock);
@@ -2940,7 +2949,7 @@ retry:
 			STATS_SET_HIGH(cachep);
 
 			ac->entry[ac->avail++] = slab_get_obj(cachep, slabp,
-							    numa_node_id());
+							    this_node);
 		}
 		check_slabp(cachep, slabp);
 
@@ -2959,7 +2968,7 @@ alloc_done:
 
 	if (unlikely(!ac->avail)) {
 		int x;
-		x = cache_grow(cachep, flags, numa_node_id());
+		x = cache_grow(cachep, flags, this_node);
 
 		/* cache_grow can reenable interrupts, then ac could change. */
 		ac = cpu_cache_get(cachep);
