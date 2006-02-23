Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWBWSn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWBWSn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWBWSn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:43:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:11908 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751229AbWBWSn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:43:26 -0500
Date: Thu, 23 Feb 2006 10:43:11 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: alokk@calsoftinc.com, manfred@colorfullife.com,
       Pekka Enberg <penberg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Slab: Node rotor for freeing alien caches and remote per cpu pages.
Message-ID: <Pine.LNX.4.64.0602231036480.13184@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cache reaper currently tries to free all alien caches and all remote
per cpu pages in each pass of cache_reap. For a machines with large number
of nodes (such as Altix) this may lead to sporadic delays of around ~10ms.
Interrupts are disabled while reclaiming creating unacceptable delays.

This patch changes that behavior by adding a per cpu reap_node variable.
Instead of attempting to free all caches, we free only one alien cache
and the per cpu pages from one remote node. That reduces the time
spend in cache_reap. However, doing so will lengthen the time it takes to
completely drain all remote per cpu pagesets and all alien caches. The
time needed will grow with the number of nodes in the system. All caches
are drained when they overflow their respective capacity. So the
drawback here is only that a bit of memory may be wasted for awhile 
longer.

Details:

1. Rename drain_remote_pages to drain_node_pages to allow the specification
   of the node to drain of pcp pages.

2. Add additional functions init_reap_node, next_reap_node for NUMA
   that manage a per cpu reap_node counter.

3. Add a reap_alien function that reaps only from the current reap_node.


Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc4/include/linux/gfp.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/gfp.h	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/include/linux/gfp.h	2006-02-23 09:34:19.000000000 -0800
@@ -157,9 +157,9 @@ extern void FASTCALL(free_cold_page(stru
 
 void page_alloc_init(void);
 #ifdef CONFIG_NUMA
-void drain_remote_pages(void);
+void drain_node_pages(int node);
 #else
-static inline void drain_remote_pages(void) { };
+static inline void drain_node_pages(int node) { };
 #endif
 
 #endif /* __LINUX_GFP_H */
Index: linux-2.6.16-rc4/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc4.orig/mm/page_alloc.c	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/mm/page_alloc.c	2006-02-23 09:34:19.000000000 -0800
@@ -590,21 +590,20 @@ static int rmqueue_bulk(struct zone *zon
 }
 
 #ifdef CONFIG_NUMA
-/* Called from the slab reaper to drain remote pagesets */
-void drain_remote_pages(void)
+/*
+ * Called from the slab reaper to drain pagesets on a particular node that
+ * belong to the currently executing processor.
+ */
+void drain_node_pages(int nodeid)
 {
-	struct zone *zone;
-	int i;
+	int i, z;
 	unsigned long flags;
 
 	local_irq_save(flags);
-	for_each_zone(zone) {
+	for (z = 0; z < MAX_NR_ZONES; z++) {
+		struct zone *zone = NODE_DATA(nodeid)->node_zones + z;
 		struct per_cpu_pageset *pset;
 
-		/* Do not drain local pagesets */
-		if (zone->zone_pgdat->node_id == numa_node_id())
-			continue;
-
 		pset = zone_pcp(zone, smp_processor_id());
 		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
 			struct per_cpu_pages *pcp;
Index: linux-2.6.16-rc4/mm/slab.c
===================================================================
--- linux-2.6.16-rc4.orig/mm/slab.c	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/mm/slab.c	2006-02-23 10:20:16.000000000 -0800
@@ -789,6 +789,54 @@ static void __slab_error(const char *fun
 	dump_stack();
 }
 
+#ifdef CONFIG_NUMA
+/*
+ * Special reaping functions for NUMA systems called from cache_reap().
+ * These take care of doing round robin flushing of alien caches (containing
+ * objects freed on different nodes from which they were allocated) and the
+ * flushing of remote pcps by calling drain_node_pages.
+ */
+static DEFINE_PER_CPU(unsigned long, reap_node);
+
+static void init_reap_node(int cpu)
+{
+	int node;
+
+	node = next_node(cpu_to_node(cpu), node_online_map);
+	if (node >= MAX_NUMNODES)
+		node = 0;
+
+	__get_cpu_var(reap_node) = node;
+}
+
+static void next_reap_node(void)
+{
+	int node = __get_cpu_var(reap_node);
+
+	/*
+	 * Also drain per cpu pages on remote zones
+	 */
+	if (node != numa_node_id())
+		drain_node_pages(node);
+
+	node = next_node(node, node_online_map);
+	if (unlikely(node >= MAX_NUMNODES)) {
+		node = first_node(node_online_map);
+		/*
+		 * If the node_online_map is empty (early boot) then
+		 * only use node zero.
+		*/
+		if (node >= MAX_NUMNODES)
+			node = 0;
+	}
+	__get_cpu_var(reap_node) = node;
+}
+
+#else
+#define init_reap_node(cpu) do { } while (0)
+#define next_reap_node(void) do { } while (0)
+#endif
+
 /*
  * Initiate the reap timer running on the target CPU.  We run at around 1 to 2Hz
  * via the workqueue/eventd.
@@ -806,6 +854,7 @@ static void __devinit start_cpu_timer(in
 	 * at that time.
 	 */
 	if (keventd_up() && reap_work->func == NULL) {
+		init_reap_node(cpu);
 		INIT_WORK(reap_work, cache_reap, NULL);
 		schedule_delayed_work_on(cpu, reap_work, HZ + 3 * cpu);
 	}
@@ -884,6 +933,23 @@ static void __drain_alien_cache(struct k
 	}
 }
 
+/*
+ * Called from cache_reap() to regularly drain alien caches round robin.
+ */
+static void reap_alien(struct kmem_cache *cachep, struct kmem_list3 *l3)
+{
+	int node = __get_cpu_var(reap_node);
+
+	if (l3->alien) {
+		struct array_cache *ac = l3->alien[node];
+		if (ac && ac->avail) {
+			spin_lock_irq(&ac->lock);
+			__drain_alien_cache(cachep, ac, node);
+			spin_unlock_irq(&ac->lock);
+		}
+	}
+}
+
 static void drain_alien_cache(struct kmem_cache *cachep, struct array_cache **alien)
 {
 	int i = 0;
@@ -902,6 +968,7 @@ static void drain_alien_cache(struct kme
 #else
 
 #define drain_alien_cache(cachep, alien) do { } while (0)
+#define reap_alien(cachep, l3) do { } while (0)
 
 static inline struct array_cache **alloc_alien_cache(int node, int limit)
 {
@@ -3494,8 +3561,7 @@ static void cache_reap(void *unused)
 		check_irq_on();
 
 		l3 = searchp->nodelists[numa_node_id()];
-		if (l3->alien)
-			drain_alien_cache(searchp, l3->alien);
+		reap_alien(searchp, l3);
 		spin_lock_irq(&l3->list_lock);
 
 		drain_array_locked(searchp, cpu_cache_get(searchp), 0,
@@ -3545,8 +3611,8 @@ static void cache_reap(void *unused)
 	}
 	check_irq_on();
 	mutex_unlock(&cache_chain_mutex);
-	drain_remote_pages();
 	/* Setup the next iteration */
+	next_reap_node();
 	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC);
 }
 
