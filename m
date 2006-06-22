Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751896AbWFVTis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbWFVTis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWFVTis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:38:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:3512 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751896AbWFVTiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:38:46 -0400
Date: Thu, 22 Jun 2006 12:38:18 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Subject: Re: [RFC 1/4] slab freeing consolidation
In-Reply-To: <Pine.LNX.4.58.0606222211370.5385@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0606221234290.31332@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060619184656.23130.69473.sendpatchset@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0606222211370.5385@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Pekka J Enberg wrote:

> > +static int long drain_freelist(struct kmem_cache *cachep,
> > +		struct kmem_list3 *l3, int tofree)
> 
> I have been trying to slowly kill the 'p' prefix so I'd appreciate if you 
> could just call the parameter 'cache'.  Also, l3 could be 'lists'.

Cache is fine. But l3 needs to stay. l3 is always a pointer to a specific 
and important structure in the slab allcoator.

Fixed up patch:


slab: consolidate code to free slabs from freelist

Code in __shrink_node() duplicates code in cache_reap()

Add a new function drain_freelist that removes slabs with objects
that are already free and use that in various places.

This eliminates the __node_shrink() function and provides
the interrupt holdoff reduction from slab_free to code that
used to call __node_shrink.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17/mm/slab.c
===================================================================
--- linux-2.6.17.orig/mm/slab.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/mm/slab.c	2006-06-22 12:35:58.685386714 -0700
@@ -452,7 +452,7 @@ struct kmem_cache {
 #define	STATS_DEC_ACTIVE(x)	((x)->num_active--)
 #define	STATS_INC_ALLOCED(x)	((x)->num_allocations++)
 #define	STATS_INC_GROWN(x)	((x)->grown++)
-#define	STATS_INC_REAPED(x)	((x)->reaped++)
+#define	STATS_ADD_REAPED(x,y)	((x)->reaped += (y))
 #define	STATS_SET_HIGH(x)						\
 	do {								\
 		if ((x)->num_active > (x)->high_mark)			\
@@ -476,7 +476,7 @@ struct kmem_cache {
 #define	STATS_DEC_ACTIVE(x)	do { } while (0)
 #define	STATS_INC_ALLOCED(x)	do { } while (0)
 #define	STATS_INC_GROWN(x)	do { } while (0)
-#define	STATS_INC_REAPED(x)	do { } while (0)
+#define	STATS_ADD_REAPED(x,y)	do { } while (0)
 #define	STATS_SET_HIGH(x)	do { } while (0)
 #define	STATS_INC_ERR(x)	do { } while (0)
 #define	STATS_INC_NODEALLOCS(x)	do { } while (0)
@@ -709,7 +709,6 @@ static void free_block(struct kmem_cache
 			int node);
 static void enable_cpucache(struct kmem_cache *cachep);
 static void cache_reap(void *unused);
-static int __node_shrink(struct kmem_cache *cachep, int node);
 
 static inline struct array_cache *cpu_cache_get(struct kmem_cache *cachep)
 {
@@ -1207,10 +1206,7 @@ free_array_cache:
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
@@ -2210,34 +2206,48 @@ static void drain_cpu_caches(struct kmem
 	}
 }
 
-static int __node_shrink(struct kmem_cache *cachep, int node)
+/*
+ * Remove slabs from the list of free slabs.
+ * Specify the number of slabs to drain in tofree.
+ *
+ * Returns the actual number of slabs released.
+ */
+static int long drain_freelist(struct kmem_cache *cache,
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
 
+		spin_lock_irq(&l3->list_lock);
 		p = l3->slabs_free.prev;
-		if (p == &l3->slabs_free)
-			break;
+		if (p == &l3->slabs_free) {
+			spin_unlock_irq(&l3->list_lock);
+			goto out;
+		}
 
-		slabp = list_entry(l3->slabs_free.prev, struct slab, list);
+		slabp = list_entry(p, struct slab, list);
 #if DEBUG
 		BUG_ON(slabp->inuse);
 #endif
 		list_del(&slabp->list);
-
-		l3->free_objects -= cachep->num;
+		/*
+		 * Safe to drop the lock. The slab is no longer linked
+		 * to the cache.
+		 */
+		l3->free_objects -= cache->num;
 		spin_unlock_irq(&l3->list_lock);
-		slab_destroy(cachep, slabp);
-		spin_lock_irq(&l3->list_lock);
+		slab_destroy(cache, slabp);
+		nr_freed++;
 	}
-	ret = !list_empty(&l3->slabs_full) || !list_empty(&l3->slabs_partial);
-	return ret;
+out:
+	return nr_freed;
 }
 
+
 static int __cache_shrink(struct kmem_cache *cachep)
 {
 	int ret = 0, i = 0;
@@ -2248,11 +2258,10 @@ static int __cache_shrink(struct kmem_ca
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
@@ -3693,9 +3702,6 @@ static void cache_reap(void *unused)
 
 	list_for_each(walk, &cache_chain) {
 		struct kmem_cache *searchp;
-		struct list_head *p;
-		int tofree;
-		struct slab *slabp;
 
 		searchp = list_entry(walk, struct kmem_cache, next);
 		check_irq_on();
@@ -3722,41 +3728,15 @@ static void cache_reap(void *unused)
 
 		drain_array(searchp, l3, l3->shared, 0, node);
 
-		if (l3->free_touched) {
+		if (l3->free_touched)
 			l3->free_touched = 0;
-			goto next;
-		}
+		else {
+			int freed;
 
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
-
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
+			freed = drain_freelist(searchp, l3, (l3->free_limit +
+				5 * searchp->num - 1) / (5 * searchp->num));
+			STATS_ADD_REAPED(searchp, freed);
+		}
 next:
 		cond_resched();
 	}
