Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWFSSsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWFSSsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWFSSrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:47:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:4072 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964837AbWFSSrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:47:15 -0400
Date: Mon, 19 Jun 2006 11:46:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060619184656.23130.69473.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 1/4] slab freeing consolidation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

slab: consolidate code to free slabs from freelist

Code in __shrink_node() duplicates code in cache_reap()

Add a new function drop_freelist that removes slabs with objects
that are already free and use that in various places.

This eliminates the __node_shrink() function and provides
the interrupt holdoff reduction from slab_free to code that
used to call __node_shrink.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm2/mm/slab.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/mm/slab.c	2006-06-16 11:48:52.882541096 -0700
+++ linux-2.6.17-rc6-mm2/mm/slab.c	2006-06-17 14:28:47.626589639 -0700
@@ -459,7 +459,7 @@ struct kmem_cache {
 #define	STATS_DEC_ACTIVE(x)	((x)->num_active--)
 #define	STATS_INC_ALLOCED(x)	((x)->num_allocations++)
 #define	STATS_INC_GROWN(x)	((x)->grown++)
-#define	STATS_INC_REAPED(x)	((x)->reaped++)
+#define	STATS_ADD_REAPED(x,y)	((x)->reaped += (y))
 #define	STATS_SET_HIGH(x)						\
 	do {								\
 		if ((x)->num_active > (x)->high_mark)			\
@@ -483,7 +483,7 @@ struct kmem_cache {
 #define	STATS_DEC_ACTIVE(x)	do { } while (0)
 #define	STATS_INC_ALLOCED(x)	do { } while (0)
 #define	STATS_INC_GROWN(x)	do { } while (0)
-#define	STATS_INC_REAPED(x)	do { } while (0)
+#define	STATS_ADD_REAPED(x,y)	do { } while (0)
 #define	STATS_SET_HIGH(x)	do { } while (0)
 #define	STATS_INC_ERR(x)	do { } while (0)
 #define	STATS_INC_NODEALLOCS(x)	do { } while (0)
@@ -707,7 +707,6 @@ static void free_block(struct kmem_cache
 			int node);
 static void enable_cpucache(struct kmem_cache *cachep);
 static void cache_reap(void *unused);
-static int __node_shrink(struct kmem_cache *cachep, int node);
 
 static inline struct array_cache *cpu_cache_get(struct kmem_cache *cachep)
 {
@@ -1246,10 +1245,7 @@ free_array_cache:
 			l3 = cachep->nodelists[node];
 			if (!l3)
 				continue;
-			spin_lock_irq(&l3->list_lock);
-			/* free slabs belonging to this node */
-			__node_shrink(cachep, node);
-			spin_unlock_irq(&l3->list_lock);
+			drain_freelist(cachep, l3, l3->free_objects);
 		}
 		mutex_unlock(&cache_chain_mutex);
 		break;
@@ -2277,34 +2273,47 @@ static void drain_cpu_caches(struct kmem
 	}
 }
 
-static int __node_shrink(struct kmem_cache *cachep, int node)
+/*
+ * Remove slabs from the list of free slabs.
+ * Specify the number of slabs to drain in tofree.
+ *
+ * Returns the actual number of slabs released.
+ */
+static int long drain_freelist(struct kmem_cache *cachep,
+		struct kmem_list3 *l3, int tofree)
 {
+	struct list_head *p;
+	int nr_freed;
 	struct slab *slabp;
-	struct kmem_list3 *l3 = cachep->nodelists[node];
-	int ret;
 
-	for (;;) {
-		struct list_head *p;
+	nr_freed = 0;
+	while (nr_freed < tofree && !list_empty(&l3->slabs_free)) {
 
-		p = l3->slabs_free.prev;
-		if (p == &l3->slabs_free)
-			break;
+		spin_lock_irq(&l3->list_lock);
+		p = l3->slabs_free.next;
+		if (p == &(l3->slabs_free)) {
+			spin_unlock_irq(&l3->list_lock);
+			return nr_freed;
+		}
 
-		slabp = list_entry(l3->slabs_free.prev, struct slab, list);
+		slabp = list_entry(p, struct slab, list);
 #if DEBUG
 		BUG_ON(slabp->inuse);
 #endif
 		list_del(&slabp->list);
-
+		/*
+		 * Safe to drop the lock. The slab is no longer linked
+		 * to the cache.
+		 */
 		l3->free_objects -= cachep->num;
 		spin_unlock_irq(&l3->list_lock);
 		slab_destroy(cachep, slabp);
-		spin_lock_irq(&l3->list_lock);
-	}
-	ret = !list_empty(&l3->slabs_full) || !list_empty(&l3->slabs_partial);
-	return ret;
+		nr_freed ++;
+	};
+	return nr_freed;
 }
 
+
 static int __cache_shrink(struct kmem_cache *cachep)
 {
 	int ret = 0, i = 0;
@@ -2315,11 +2324,10 @@ static int __cache_shrink(struct kmem_ca
 	check_irq_on();
 	for_each_online_node(i) {
 		l3 = cachep->nodelists[i];
-		if (l3) {
-			spin_lock_irq(&l3->list_lock);
-			ret += __node_shrink(cachep, i);
-			spin_unlock_irq(&l3->list_lock);
-		}
+		drain_freelist(cachep, l3, l3->free_objects);
+
+		ret += !list_empty(&l3->slabs_full) ||
+			!list_empty(&l3->slabs_partial);
 	}
 	return (ret ? 1 : 0);
 }
@@ -3757,9 +3765,6 @@ static void cache_reap(void *unused)
 	}
 
 	list_for_each_entry(searchp, &cache_chain, next) {
-		struct list_head *p;
-		int tofree;
-		struct slab *slabp;
 
 		check_irq_on();
 
@@ -3785,41 +3790,15 @@ static void cache_reap(void *unused)
 
 		drain_array(searchp, l3, l3->shared, 0, node);
 
-		if (l3->free_touched) {
+		if (l3->free_touched)
 			l3->free_touched = 0;
-			goto next;
-		}
-
-		tofree = (l3->free_limit + 5 * searchp->num - 1) /
-				(5 * searchp->num);
-		do {
-			/*
-			 * Do not lock if there are no free blocks.
-			 */
-			if (list_empty(&l3->slabs_free))
-				break;
-
-			spin_lock_irq(&l3->list_lock);
-			p = l3->slabs_free.next;
-			if (p == &(l3->slabs_free)) {
-				spin_unlock_irq(&l3->list_lock);
-				break;
-			}
+		else {
+			int x;
 
-			slabp = list_entry(p, struct slab, list);
-			BUG_ON(slabp->inuse);
-			list_del(&slabp->list);
-			STATS_INC_REAPED(searchp);
-
-			/*
-			 * Safe to drop the lock. The slab is no longer linked
-			 * to the cache. searchp cannot disappear, we hold
-			 * cache_chain_lock
-			 */
-			l3->free_objects -= searchp->num;
-			spin_unlock_irq(&l3->list_lock);
-			slab_destroy(searchp, slabp);
-		} while (--tofree > 0);
+			x = drain_freelist(searchp, l3, (l3->free_limit +
+				5 * searchp->num - 1) / (5 * searchp->num));
+			STATS_ADD_REAPED(searchp, x);
+		}
 next:
 		cond_resched();
 	}
