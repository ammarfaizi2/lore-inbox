Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVEQAP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVEQAP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 20:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVEQAP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 20:15:57 -0400
Received: from graphe.net ([209.204.138.32]:54033 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261320AbVEQAPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 20:15:13 -0400
Date: Mon, 16 May 2005 17:14:53 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
In-Reply-To: <740100000.1116278461@flay>
Message-ID: <Pine.LNX.4.62.0505161713130.21512@graphe.net>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
 <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>
 <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org>
 <740100000.1116278461@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Martin J. Bligh wrote:

> > Yeah, makes sense for the NUMA aware slab allocator to depend on 
> > CONFIG_NUMA.
> 
> Andy confirmed offline that this is really CONFIG_NEED_MULTIPLE_PGDATS,
> and is just named wrong.

Hmmm.. In this case it may be necessary for the slab allocator to 
determine what is the proper number of NUMA nodes. I do not really like it 
but it seems that we need the following patch to rectify the situation.

Index: linux-2.6.12-rc4/mm/slab.c
===================================================================
--- linux-2.6.12-rc4.orig/mm/slab.c	2005-05-16 16:58:44.000000000 -0700
+++ linux-2.6.12-rc4/mm/slab.c	2005-05-16 17:04:11.000000000 -0700
@@ -112,10 +112,12 @@
  * there is only a single node if CONFIG_NUMA is not set. Remove this check
  * after the situation has stabilized.
  */
-#ifndef CONFIG_NUMA
-#if MAX_NUMNODES != 1
-#error "Broken Configuration: CONFIG_NUMA not set but MAX_NUMNODES !=1 !!"
-#endif
+#ifdef CONFIG_NUMA
+#define NUMA_NODES MAX_NUMNODES
+#define NUMA_NODE_ID numa_node_id()
+#else
+#define NUMA_NODES 1
+#define NUMA_NODE_ID 0
 #endif
 
 /*
@@ -311,7 +313,7 @@
 /*
  * Need this for bootstrapping a per node allocator.
  */
-#define NUM_INIT_LISTS (2 + MAX_NUMNODES)
+#define NUM_INIT_LISTS (2 + NUMA_NODES)
 struct kmem_list3 __initdata initkmem_list3[NUM_INIT_LISTS];
 #define	CACHE_CACHE 0
 #define	SIZE_AC 1
@@ -385,7 +387,7 @@
 	} while (0)
 
 #define list3_data(cachep) \
-	((cachep->nodelists[numa_node_id()]))
+	((cachep->nodelists[NUMA_NODE_ID]))
 
 /* NUMA: per-node */
 #define list3_data_ptr(cachep, ptr) \
@@ -405,7 +407,7 @@
 	unsigned int 		shared;
 	unsigned int		objsize;
 /* 2) touched by every alloc & free from the backend */
-	struct kmem_list3	*nodelists[MAX_NUMNODES];
+	struct kmem_list3	*nodelists[NUMA_NODES];
 	unsigned int	 	flags;	/* constant flags */
 	unsigned int		num;	/* # of objs per slab */
 	spinlock_t		spinlock;
@@ -792,7 +794,7 @@
 static inline struct array_cache **alloc_alien_cache(int cpu, int limit)
 {
 	struct array_cache **ac_ptr;
-	int memsize = sizeof(void*)*MAX_NUMNODES;
+	int memsize = sizeof(void*)*NUMA_NODES;
 	int node = cpu_to_node(cpu);
 	int i;
 
@@ -800,7 +802,7 @@
 		limit = 12;
 	ac_ptr = kmalloc_node(memsize, GFP_KERNEL, node);
 	if (ac_ptr) {
-		for (i = 0; i < MAX_NUMNODES; i++) {
+		for (i = 0; i < NUMA_NODES; i++) {
 			if (i == node) {
 				ac_ptr[i] = NULL;
 				continue;
@@ -823,7 +825,7 @@
 
 	if (!ac_ptr)
 		return;
-	for (i = 0; i < MAX_NUMNODES; i++)
+	for (i = 0; i < NUMA_NODES; i++)
 		kfree(ac_ptr[i]);
 
 	kfree(ac_ptr);
@@ -847,7 +849,7 @@
 	struct array_cache *ac;
 	unsigned long flags;
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
+	for (i = 0; i < NUMA_NODES; i++) {
 		ac = l3->alien[i];
 		if (ac) {
 			spin_lock_irqsave(&ac->lock, flags);
@@ -1028,7 +1030,7 @@
 
 	for (i = 0; i < NUM_INIT_LISTS; i++) {
 		LIST3_INIT(&initkmem_list3[i]);
-		if (i < MAX_NUMNODES)
+		if (i < NUMA_NODES)
 			cache_cache.nodelists[i] = NULL;
 	}
 
@@ -1065,7 +1067,7 @@
 	list_add(&cache_cache.next, &cache_chain);
 	cache_cache.colour_off = cache_line_size();
 	cache_cache.array[smp_processor_id()] = &initarray_cache.cache;
-	cache_cache.nodelists[numa_node_id()] = &initkmem_list3[CACHE_CACHE];
+	cache_cache.nodelists[NUMA_NODE_ID] = &initkmem_list3[CACHE_CACHE];
 
 	cache_cache.objsize = ALIGN(cache_cache.objsize, cache_line_size());
 
@@ -1154,7 +1156,7 @@
 		int node;
 		/* Replace the static kmem_list3 structures for the boot cpu */
 		init_list(&cache_cache, &initkmem_list3[CACHE_CACHE],
-				numa_node_id());
+				NUMA_NODE_ID);
 
 		for_each_online_node(node) {
 				init_list(malloc_sizes[INDEX_L3].cs_cachep,
@@ -1163,7 +1165,7 @@
 		if (INDEX_AC != INDEX_L3) {
 			init_list(malloc_sizes[INDEX_AC].cs_cachep,
 					&initkmem_list3[SIZE_AC],
-					numa_node_id());
+					NUMA_NODE_ID);
 		}
 	}
 
@@ -1778,7 +1780,7 @@
 				set_up_list3s(cachep);
 				g_cpucache_up = PARTIAL_L3;
 			} else {
-				cachep->nodelists[numa_node_id()] =
+				cachep->nodelists[NUMA_NODE_ID] =
 					&initkmem_list3[SIZE_AC];
 				g_cpucache_up = PARTIAL_AC;
 			}
@@ -1791,18 +1793,18 @@
 				set_up_list3s(cachep);
 				g_cpucache_up = PARTIAL_L3;
 			} else {
-				cachep->nodelists[numa_node_id()] =
+				cachep->nodelists[NUMA_NODE_ID] =
 					kmalloc(sizeof(struct kmem_list3),
 						GFP_KERNEL);
-				LIST3_INIT(cachep->nodelists[numa_node_id()]);
+				LIST3_INIT(cachep->nodelists[NUMA_NODE_ID]);
 			}
 		}
-		cachep->nodelists[numa_node_id()]->next_reap =
+		cachep->nodelists[NUMA_NODE_ID]->next_reap =
 			jiffies + REAPTIMEOUT_LIST3 +
 			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
 
 		BUG_ON(!ac_data(cachep));
-		BUG_ON(!cachep->nodelists[numa_node_id()]);
+		BUG_ON(!cachep->nodelists[NUMA_NODE_ID]);
 		ac_data(cachep)->avail = 0;
 		ac_data(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
 		ac_data(cachep)->batchcount = 1;
@@ -1986,7 +1988,7 @@
 	drain_cpu_caches(cachep);
 
 	check_irq_on();
-	for (i = 0; i < MAX_NUMNODES; i++) {
+	for (i = 0; i < NUMA_NODES; i++) {
 		l3 = cachep->nodelists[i];
 		if (l3) {
 			spin_lock_irq(&l3->list_lock);
@@ -2068,7 +2070,7 @@
 		kfree(cachep->array[i]);
 
 	/* NUMA: free the list3 structures */
-	for (i = 0; i < MAX_NUMNODES; i++) {
+	for (i = 0; i < NUMA_NODES; i++) {
 		if ((l3 = cachep->nodelists[i])) {
 			kfree(l3->shared);
 #ifdef CONFIG_NUMA
@@ -2482,7 +2484,7 @@
 
 	if (unlikely(!ac->avail)) {
 		int x;
-		x = cache_grow(cachep, flags, numa_node_id());
+		x = cache_grow(cachep, flags, NUMA_NODE_ID);
 
 		// cache_grow can reenable interrupts, then ac could change.
 		ac = ac_data(cachep);
@@ -2786,7 +2788,7 @@
 	{
 		struct slab *slabp;
 		slabp = GET_PAGE_SLAB(virt_to_page(objp));
-		if (unlikely(slabp->nodeid != numa_node_id())) {
+		if (unlikely(slabp->nodeid != NUMA_NODE_ID)) {
 			struct array_cache *alien = NULL;
 			int nodeid = slabp->nodeid;
 			struct kmem_list3 *l3 = list3_data(cachep);
@@ -2896,7 +2898,7 @@
 	unsigned long save_flags;
 	void *ptr;
 
-	if (nodeid == numa_node_id() || nodeid == -1)
+	if (nodeid == NUMA_NODE_ID || nodeid == -1)
 		return __cache_alloc(cachep, flags);
 
 	cache_alloc_debugcheck_before(cachep, flags);
@@ -3437,7 +3439,7 @@
 		spin_lock_irq(&l3->list_lock);
 
 		drain_array_locked(searchp, ac_data(searchp), 0,
-				numa_node_id());
+				NUMA_NODE_ID);
 
 #if DEBUG
 		if (time_before(searchp->redzonetest, jiffies)) {
@@ -3452,7 +3454,7 @@
 
 		if (l3->shared)
 			drain_array_locked(searchp, l3->shared, 0,
-				numa_node_id());
+				NUMA_NODE_ID);
 
 		if (l3->free_touched) {
 			l3->free_touched = 0;
