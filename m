Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945956AbWBCU4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945956AbWBCU4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945954AbWBCU4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:56:08 -0500
Received: from ns1.siteground.net ([207.218.208.2]:7098 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1422929AbWBCU4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:56:07 -0500
Date: Fri, 3 Feb 2006 12:56:15 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Manfred Spraul <manfred@colorfullife.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Alok Kataria <alok.kataria@calsoftinc.com>, sonny@burdell.org
Subject: [patch 2/3] NUMA slab locking fixes -- slab locking irq optimizations
Message-ID: <20060203205615.GE3653@localhost.localdomain>
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

Earlier, we had to disable on chip interrupts while taking the cachep->spinlock
because, at cache_grow, on every addition of a slab to a slab cache, we 
incremented colour_next which was protected by the cachep->spinlock, and
cache_grow could occur at interrupt context.  Since, now we protect the 
per-node colour_next with the node's list_lock, we do not need to disable 
on chip interrupts while taking the per-cache spinlock, but we
just need to disable interrupts when taking the per-node kmem_list3 list_lock.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16-rc1mm4/mm/slab.c
===================================================================
--- linux-2.6.16-rc1mm4.orig/mm/slab.c	2006-01-29 20:23:28.000000000 -0800
+++ linux-2.6.16-rc1mm4/mm/slab.c	2006-01-29 23:13:14.000000000 -0800
@@ -995,7 +995,7 @@ static int __devinit cpuup_callback(stru
 			cpumask_t mask;
 
 			mask = node_to_cpumask(node);
-			spin_lock_irq(&cachep->spinlock);
+			spin_lock(&cachep->spinlock);
 			/* cpu is dead; no one can alloc from it. */
 			nc = cachep->array[cpu];
 			cachep->array[cpu] = NULL;
@@ -1004,7 +1004,7 @@ static int __devinit cpuup_callback(stru
 			if (!l3)
 				goto unlock_cache;
 
-			spin_lock(&l3->list_lock);
+			spin_lock_irq(&l3->list_lock);
 
 			/* Free limit for this kmem_list3 */
 			l3->free_limit -= cachep->batchcount;
@@ -1012,7 +1012,7 @@ static int __devinit cpuup_callback(stru
 				free_block(cachep, nc->entry, nc->avail, node);
 
 			if (!cpus_empty(mask)) {
-				spin_unlock(&l3->list_lock);
+				spin_unlock_irq(&l3->list_lock);
 				goto unlock_cache;
 			}
 
@@ -1031,13 +1031,13 @@ static int __devinit cpuup_callback(stru
 			/* free slabs belonging to this node */
 			if (__node_shrink(cachep, node)) {
 				cachep->nodelists[node] = NULL;
-				spin_unlock(&l3->list_lock);
+				spin_unlock_irq(&l3->list_lock);
 				kfree(l3);
 			} else {
-				spin_unlock(&l3->list_lock);
+				spin_unlock_irq(&l3->list_lock);
 			}
 		      unlock_cache:
-			spin_unlock_irq(&cachep->spinlock);
+			spin_unlock(&cachep->spinlock);
 			kfree(nc);
 		}
 		mutex_unlock(&cache_chain_mutex);
@@ -2021,18 +2021,18 @@ static void drain_cpu_caches(struct kmem
 
 	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
-	spin_lock_irq(&cachep->spinlock);
+	spin_lock(&cachep->spinlock);
 	for_each_online_node(node) {
 		l3 = cachep->nodelists[node];
 		if (l3) {
-			spin_lock(&l3->list_lock);
+			spin_lock_irq(&l3->list_lock);
 			drain_array_locked(cachep, l3->shared, 1, node);
-			spin_unlock(&l3->list_lock);
+			spin_unlock_irq(&l3->list_lock);
 			if (l3->alien)
 				drain_alien_cache(cachep, l3);
 		}
 	}
-	spin_unlock_irq(&cachep->spinlock);
+	spin_unlock(&cachep->spinlock);
 }
 
 static int __node_shrink(struct kmem_cache *cachep, int node)
@@ -2348,7 +2348,6 @@ static int cache_grow(struct kmem_cache 
 
 	offset *= cachep->colour_off;
 
-	check_irq_off();
 	if (local_flags & __GFP_WAIT)
 		local_irq_enable();
 
@@ -2744,6 +2743,7 @@ static void *__cache_alloc_node(struct k
 	BUG_ON(!l3);
 
       retry:
+	check_irq_off();
 	spin_lock(&l3->list_lock);
 	entry = l3->slabs_partial.next;
 	if (entry == &l3->slabs_partial) {
@@ -3323,11 +3323,11 @@ static int do_tune_cpucache(struct kmem_
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
 
 	check_irq_on();
-	spin_lock_irq(&cachep->spinlock);
+	spin_lock(&cachep->spinlock);
 	cachep->batchcount = batchcount;
 	cachep->limit = limit;
 	cachep->shared = shared;
-	spin_unlock_irq(&cachep->spinlock);
+	spin_unlock(&cachep->spinlock);
 
 	for_each_online_cpu(i) {
 		struct array_cache *ccold = new.new[i];
@@ -3584,8 +3584,7 @@ static int s_show(struct seq_file *m, vo
 	int node;
 	struct kmem_list3 *l3;
 
-	check_irq_on();
-	spin_lock_irq(&cachep->spinlock);
+	spin_lock(&cachep->spinlock);
 	active_objs = 0;
 	num_slabs = 0;
 	for_each_online_node(node) {
@@ -3593,7 +3592,8 @@ static int s_show(struct seq_file *m, vo
 		if (!l3)
 			continue;
 
-		spin_lock(&l3->list_lock);
+		check_irq_on();
+		spin_lock_irq(&l3->list_lock);
 
 		list_for_each(q, &l3->slabs_full) {
 			slabp = list_entry(q, struct slab, list);
@@ -3620,7 +3620,7 @@ static int s_show(struct seq_file *m, vo
 		free_objects += l3->free_objects;
 		shared_avail += l3->shared->avail;
 
-		spin_unlock(&l3->list_lock);
+		spin_unlock_irq(&l3->list_lock);
 	}
 	num_slabs += active_slabs;
 	num_objs = num_slabs * cachep->num;
@@ -3670,7 +3670,7 @@ static int s_show(struct seq_file *m, vo
 			shrinker_stat_read(cachep->shrinker, nr_freed));
 	}
 	seq_putc(m, '\n');
-	spin_unlock_irq(&cachep->spinlock);
+	spin_unlock(&cachep->spinlock);
 	return 0;
 }
 
@@ -3702,10 +3702,10 @@ static void do_dump_slabp(kmem_cache_t *
 	int node;
 
 	check_irq_on();
-	spin_lock_irq(&cachep->spinlock);
+	spin_lock(&cachep->spinlock);
 	for_each_online_node(node) {
 		struct kmem_list3 *rl3 = cachep->nodelists[node];
-		spin_lock(&rl3->list_lock);
+		spin_lock_irq(&rl3->list_lock);
 
 		list_for_each(q, &rl3->slabs_full) {
 			int i;
@@ -3719,9 +3719,9 @@ static void do_dump_slabp(kmem_cache_t *
 				printk("\n");
 			}
 		}
-		spin_unlock(&rl3->list_lock);
+		spin_unlock_irq(&rl3->list_lock);
 	}
-	spin_unlock_irq(&cachep->spinlock);
+	spin_unlock(&cachep->spinlock);
 #endif
 }
 
