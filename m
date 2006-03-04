Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWCDCpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWCDCpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 21:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWCDCpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 21:45:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53717 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751338AbWCDCpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 21:45:07 -0500
Date: Fri, 3 Mar 2006 18:44:57 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, kiran@scalex86.org, alokk@calsoftinc.com,
       Pekka Enberg <penberg@gmail.com>
Subject: Do not disable interrupts for off node freeing
In-Reply-To: <Pine.LNX.4.64.0603031650440.15966@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0603031839090.16184@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603031530380.15581@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0603031649340.15966@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0603031650440.15966@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a free_block_lock function and remove the node parameter
from free_block. That one can be determined from slabp.

Optimize interrupt holdoff in do_tune_cpucache() and in drain_cache.
Only disable interrupts if we are freeing to the local node.

[Umm... Maybe we ought to think about that a bit more... Seems to be
okay to me but I am very fallible....]

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc5-mm2/mm/slab.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/mm/slab.c	2006-03-03 16:43:43.000000000 -0800
+++ linux-2.6.16-rc5-mm2/mm/slab.c	2006-03-03 18:41:11.000000000 -0800
@@ -701,12 +701,22 @@ static enum {
 
 static DEFINE_PER_CPU(struct work_struct, reap_work);
 
-static void free_block(struct kmem_cache *cachep, void **objpp, int len,
-			int node);
+static void free_block(struct kmem_cache *cachep, void **objpp, int len);
 static void enable_cpucache(struct kmem_cache *cachep);
 static void cache_reap(void *unused);
 static int __node_shrink(struct kmem_cache *cachep, int node);
 
+/*
+ * Interrupts must be off unless we free to a remote node
+ */
+static void free_block_lock(struct kmem_cache *cachep, struct kmem_list3 *l3,
+			void **objp, int len)
+{
+	spin_lock(&l3->list_lock);
+	free_block(cachep, objp, len);
+	spin_unlock(&l3->list_lock);
+}
+
 static inline struct array_cache *cpu_cache_get(struct kmem_cache *cachep)
 {
 	return cachep->array[smp_processor_id()];
@@ -948,10 +958,8 @@ static void __drain_alien_cache(struct k
 	struct kmem_list3 *rl3 = cachep->nodelists[node];
 
 	if (ac->avail) {
-		spin_lock(&rl3->list_lock);
-		free_block(cachep, ac->entry, ac->avail, node);
-		ac->avail = 0;
-		spin_unlock(&rl3->list_lock);
+		free_block_lock(cachep, rl3, ac->entry, ac->avail);
+		ac->avail=0;
 	}
 }
 
@@ -1135,7 +1143,7 @@ static int __devinit cpuup_callback(stru
 			/* Free limit for this kmem_list3 */
 			l3->free_limit -= cachep->batchcount;
 			if (nc)
-				free_block(cachep, nc->entry, nc->avail, node);
+				free_block(cachep, nc->entry, nc->avail);
 
 			if (!cpus_empty(mask)) {
 				spin_unlock_irq(&l3->list_lock);
@@ -1145,7 +1153,7 @@ static int __devinit cpuup_callback(stru
 			shared = l3->shared;
 			if (shared) {
 				free_block(cachep, l3->shared->entry,
-					   l3->shared->avail, node);
+					   l3->shared->avail);
 				l3->shared = NULL;
 			}
 
@@ -2137,9 +2145,8 @@ static void do_drain(void *arg)
 
 	check_irq_off();
 	ac = cpu_cache_get(cachep);
-	spin_lock(&cachep->nodelists[node]->list_lock);
-	free_block(cachep, ac->entry, ac->avail, node);
-	spin_unlock(&cachep->nodelists[node]->list_lock);
+	free_block_lock(cachep, cachep->nodelists[node],
+			ac->entry, ac->avail);
 	ac->avail = 0;
 }
 
@@ -2945,8 +2952,8 @@ done:
 /*
  * Caller needs to acquire correct kmem_list's list_lock
  */
-static void free_block(struct kmem_cache *cachep, void **objpp, int nr_objects,
-		       int node)
+static void free_block(struct kmem_cache *cachep, void **objpp,
+			 int nr_objects)
 {
 	int i;
 	struct kmem_list3 *l3;
@@ -2954,8 +2961,10 @@ static void free_block(struct kmem_cache
 	for (i = 0; i < nr_objects; i++) {
 		void *objp = objpp[i];
 		struct slab *slabp;
+		int node;
 
 		slabp = virt_to_slab(objp);
+		node = slabp->nodeid;
 		l3 = cachep->nodelists[node];
 		list_del(&slabp->list);
 		check_spinlock_acquired_node(cachep, node);
@@ -3009,7 +3018,7 @@ static void cache_flusharray(struct kmem
 		}
 	}
 
-	free_block(cachep, ac->entry, batchcount, node);
+	free_block(cachep, ac->entry, batchcount);
 free_done:
 #if STATS
 	{
@@ -3067,13 +3076,10 @@ static inline void __cache_free(struct k
 							    alien, nodeid);
 				alien->entry[alien->avail++] = objp;
 				spin_unlock(&alien->lock);
-			} else {
-				spin_lock(&(cachep->nodelists[nodeid])->
-					  list_lock);
-				free_block(cachep, &objp, 1, nodeid);
-				spin_unlock(&(cachep->nodelists[nodeid])->
-					    list_lock);
-			}
+			} else
+				free_block_lock(cachep,
+					cachep->nodelists[nodeid],
+					&objp, 1);
 			return;
 		}
 	}
@@ -3402,7 +3408,7 @@ static int alloc_kmemlist(struct kmem_ca
 
 			nc = cachep->nodelists[node]->shared;
 			if (nc)
-				free_block(cachep, nc->entry, nc->avail, node);
+				free_block(cachep, nc->entry, nc->avail);
 
 			l3->shared = new;
 			if (!cachep->nodelists[node]->alien) {
@@ -3480,11 +3486,25 @@ static int do_tune_cpucache(struct kmem_
 
 	for_each_online_cpu(i) {
 		struct array_cache *ccold = new.new[i];
+		int node = cpu_to_node(i);
+
 		if (!ccold)
 			continue;
-		spin_lock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
-		free_block(cachep, ccold->entry, ccold->avail, cpu_to_node(i));
-		spin_unlock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
+
+		/*
+		 * Local interrupts must be disabled only for
+		 * this node because the list_lock may be obtained
+		 * in an interrupt context.
+		 */
+		if (node == numa_node_id())
+			local_irq_disable();
+
+		free_block_lock(cachep, cachep->nodelists[node],
+				ccold->entry, ccold->avail);
+
+		if (node == numa_node_id())
+			local_irq_enable();
+
 		kfree(ccold);
 	}
 
@@ -3570,9 +3590,18 @@ void drain_array(struct kmem_cache *cach
 		tofree = force ? ac->avail : (ac->limit + 4) / 5;
 		if (tofree > ac->avail)
 			tofree = (ac->avail + 1) / 2;
-		spin_lock_irq(&l3->list_lock);
-		free_block(cachep, ac->entry, tofree, node);
-		spin_unlock_irq(&l3->list_lock);
+		/*
+		 * Freeing to the local node also requires that
+		 * interrupts be disabled.
+		 */
+		if (node == numa_node_id())
+			local_irq_disable();
+
+		free_block_lock(cachep, l3, ac->entry, tofree);
+
+		if (node == numa_node_id())
+			local_irq_enable();
+
 		ac->avail -= tofree;
 		memmove(ac->entry, &(ac->entry[tofree]),
 			sizeof(void *) * ac->avail);

