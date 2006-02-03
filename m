Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422957AbWBCU5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422957AbWBCU5o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422953AbWBCU5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:57:44 -0500
Received: from ns1.siteground.net ([207.218.208.2]:1772 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1422957AbWBCU5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:57:42 -0500
Date: Fri, 3 Feb 2006 12:57:45 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Manfred Spraul <manfred@colorfullife.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Alok Kataria <alok.kataria@calsoftinc.com>, sonny@burdell.org
Subject: [patch 3/3] NUMA slab locking fixes -- slab cpu hotplug fix
Message-ID: <20060203205745.GF3653@localhost.localdomain>
References: <20060203205341.GC3653@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203205341.GC3653@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes locking and bugs in cpu_down and cpu_up paths of the NUMA slab
allocator.  Sonny Rao <sonny@burdell.org> reported problems sometime back 
on POWER5 boxes, when the last cpu on the nodes were being offlined.  We could
not reproduce the same on x86_64 because the cpumask (node_to_cpumask) was not
being updated on cpu down.  Since that issue is now fixed, we can reproduce
Sonny's problems on x86_64 NUMA, and here is the fix.

The problem earlier was on CPU_DOWN, if it was the last cpu on the node to go 
down, the array_caches (shared, alien)  and the kmem_list3 of the node were 
being freed (kfree) with the kmem_list3 lock held.  If the l3 or the 
array_caches were to come from the same cache being cleared, we hit on badness.

This patch cleans up the locking in cpu_up and cpu_down path.  
We cannot really free l3 on cpu down because, there is no node offlining yet
and even though a cpu is not yet up, node local memory can be allocated
for it. So l3s are usually allocated at keme_cache_create and destroyed at 
kmem_cache_destroy.  Hence, we don't need cachep->spinlock protection to get
to the cachep->nodelist[nodeid] either.

Patch survived onlining and offlining on a 4 core 2 node Tyan box with a 
4 dbench process running all the time.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16-rc1mm4/mm/slab.c
===================================================================
--- linux-2.6.16-rc1mm4.orig/mm/slab.c	2006-02-01 18:04:21.000000000 -0800
+++ linux-2.6.16-rc1mm4/mm/slab.c	2006-02-01 23:44:25.000000000 -0800
@@ -892,14 +892,14 @@ static void __drain_alien_cache(struct k
 	}
 }
 
-static void drain_alien_cache(struct kmem_cache *cachep, struct kmem_list3 *l3)
+static void drain_alien_cache(struct kmem_cache *cachep, struct array_cache **alien)
 {
 	int i = 0;
 	struct array_cache *ac;
 	unsigned long flags;
 
 	for_each_online_node(i) {
-		ac = l3->alien[i];
+		ac = alien[i];
 		if (ac) {
 			spin_lock_irqsave(&ac->lock, flags);
 			__drain_alien_cache(cachep, ac, i);
@@ -910,7 +910,7 @@ static void drain_alien_cache(struct kme
 #else
 #define alloc_alien_cache(node, limit) do { } while (0)
 #define free_alien_cache(ac_ptr) do { } while (0)
-#define drain_alien_cache(cachep, l3) do { } while (0)
+#define drain_alien_cache(cachep, alien) do { } while (0)
 #endif
 
 static int __devinit cpuup_callback(struct notifier_block *nfb,
@@ -944,6 +944,9 @@ static int __devinit cpuup_callback(stru
 				l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
 				    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 
+				/* The l3s don't come and go as cpus come and
+				   go.  cache_chain_mutex is sufficient 
+				   protection here */
 				cachep->nodelists[node] = l3;
 			}
 
@@ -957,27 +960,39 @@ static int __devinit cpuup_callback(stru
 		/* Now we can go ahead with allocating the shared array's
 		   & array cache's */
 		list_for_each_entry(cachep, &cache_chain, next) {
-			struct array_cache *nc;
+			struct array_cache *nc, *shared, **alien;
 
-			nc = alloc_arraycache(node, cachep->limit,
-					      cachep->batchcount);
-			if (!nc)
+			if (!(nc = alloc_arraycache(node, 
+			      cachep->limit, cachep->batchcount)))
 				goto bad;
+			if (!(shared = alloc_arraycache(node,
+			      cachep->shared*cachep->batchcount, 0xbaadf00d)))
+				goto bad;
+#ifdef CONFIG_NUMA
+			if (!(alien = alloc_alien_cache(node,
+			      cachep->limit)))
+				goto bad;
+#endif
 			cachep->array[cpu] = nc;
 
 			l3 = cachep->nodelists[node];
 			BUG_ON(!l3);
-			if (!l3->shared) {
-				if (!(nc = alloc_arraycache(node,
-							    cachep->shared *
-							    cachep->batchcount,
-							    0xbaadf00d)))
-					goto bad;
 
+			spin_lock_irq(&l3->list_lock);
+			if (!l3->shared) {
 				/* we are serialised from CPU_DEAD or
 				   CPU_UP_CANCELLED by the cpucontrol lock */
-				l3->shared = nc;
+				l3->shared = shared;
+				shared = NULL;
+			}
+			if (!l3->alien) {
+				l3->alien = alien;
+				alien = NULL;
 			}
+			spin_unlock_irq(&l3->list_lock);
+
+			kfree(shared);
+			free_alien_cache(alien);
 		}
 		mutex_unlock(&cache_chain_mutex);
 		break;
@@ -986,23 +1001,29 @@ static int __devinit cpuup_callback(stru
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_DEAD:
+		/* Even if all the cpus of a node are down, we don't
+		 * free the kmem_list3 of any cache. This to avoid a race
+		 * between cpu_down, and a kmalloc allocation from another
+		 * cpu for memory from the node of the cpu going down.  
+		 * The list3 structure is usually allocated from 
+		 * kmem_cache_create and gets destroyed at kmem_cache_destroy
+		 */
 		/* fall thru */
 	case CPU_UP_CANCELED:
 		mutex_lock(&cache_chain_mutex);
 
 		list_for_each_entry(cachep, &cache_chain, next) {
-			struct array_cache *nc;
+			struct array_cache *nc, *shared, **alien;
 			cpumask_t mask;
 
 			mask = node_to_cpumask(node);
-			spin_lock(&cachep->spinlock);
 			/* cpu is dead; no one can alloc from it. */
 			nc = cachep->array[cpu];
 			cachep->array[cpu] = NULL;
 			l3 = cachep->nodelists[node];
 
 			if (!l3)
-				goto unlock_cache;
+				goto free_array_cache;
 
 			spin_lock_irq(&l3->list_lock);
 
@@ -1013,33 +1034,43 @@ static int __devinit cpuup_callback(stru
 
 			if (!cpus_empty(mask)) {
 				spin_unlock_irq(&l3->list_lock);
-				goto unlock_cache;
+				goto free_array_cache;
 			}
 
-			if (l3->shared) {
+			if ((shared = l3->shared)) {
 				free_block(cachep, l3->shared->entry,
 					   l3->shared->avail, node);
-				kfree(l3->shared);
 				l3->shared = NULL;
 			}
-			if (l3->alien) {
-				drain_alien_cache(cachep, l3);
-				free_alien_cache(l3->alien);
-				l3->alien = NULL;
-			}
 
-			/* free slabs belonging to this node */
-			if (__node_shrink(cachep, node)) {
-				cachep->nodelists[node] = NULL;
-				spin_unlock_irq(&l3->list_lock);
-				kfree(l3);
-			} else {
-				spin_unlock_irq(&l3->list_lock);
+			alien = l3->alien;
+			l3->alien = NULL;
+
+			spin_unlock_irq(&l3->list_lock);
+
+			kfree(shared);
+			if (alien) {
+				drain_alien_cache(cachep, alien);
+				free_alien_cache(alien);
 			}
-		      unlock_cache:
-			spin_unlock(&cachep->spinlock);
+      free_array_cache:
 			kfree(nc);
 		}
+		/*
+		 * In the previous loop, all the objects were freed to
+		 * the respective cache's slabs,  now we can go ahead and
+		 * shrink each nodelist to its limit.
+		 */
+		list_for_each_entry(cachep, &cache_chain, next) {
+
+			l3 = cachep->nodelists[node];
+			if (!l3)
+				continue;
+			spin_lock_irq(&l3->list_lock);
+			/* free slabs belonging to this node */
+			__node_shrink(cachep, node);
+			spin_unlock_irq(&l3->list_lock);
+		}
 		mutex_unlock(&cache_chain_mutex);
 		break;
 #endif
@@ -2021,7 +2052,6 @@ static void drain_cpu_caches(struct kmem
 
 	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
-	spin_lock(&cachep->spinlock);
 	for_each_online_node(node) {
 		l3 = cachep->nodelists[node];
 		if (l3) {
@@ -2029,10 +2059,9 @@ static void drain_cpu_caches(struct kmem
 			drain_array_locked(cachep, l3->shared, 1, node);
 			spin_unlock_irq(&l3->list_lock);
 			if (l3->alien)
-				drain_alien_cache(cachep, l3);
+				drain_alien_cache(cachep, l3->alien);
 		}
 	}
-	spin_unlock(&cachep->spinlock);
 }
 
 static int __node_shrink(struct kmem_cache *cachep, int node)
@@ -3459,7 +3488,7 @@ static void cache_reap(void *unused)
 
 		l3 = searchp->nodelists[numa_node_id()];
 		if (l3->alien)
-			drain_alien_cache(searchp, l3);
+			drain_alien_cache(searchp, l3->alien);
 		spin_lock_irq(&l3->list_lock);
 
 		drain_array_locked(searchp, cpu_cache_get(searchp), 0,
@@ -3618,7 +3647,8 @@ static int s_show(struct seq_file *m, vo
 			num_slabs++;
 		}
 		free_objects += l3->free_objects;
-		shared_avail += l3->shared->avail;
+		if (l3->shared)
+			shared_avail += l3->shared->avail;
 
 		spin_unlock_irq(&l3->list_lock);
 	}
@@ -3702,7 +3732,6 @@ static void do_dump_slabp(kmem_cache_t *
 	int node;
 
 	check_irq_on();
-	spin_lock(&cachep->spinlock);
 	for_each_online_node(node) {
 		struct kmem_list3 *rl3 = cachep->nodelists[node];
 		spin_lock_irq(&rl3->list_lock);
@@ -3721,7 +3750,6 @@ static void do_dump_slabp(kmem_cache_t *
 		}
 		spin_unlock_irq(&rl3->list_lock);
 	}
-	spin_unlock(&cachep->spinlock);
 #endif
 }
 
