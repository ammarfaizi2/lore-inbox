Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWCCXxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWCCXxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWCCXxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:53:13 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:47033 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751120AbWCCXxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:53:12 -0500
Date: Fri, 3 Mar 2006 15:36:58 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, kiran@scalex86.org, alokk@calsoftinc.com,
       Pekka Enberg <penberg@gmail.com>
Subject: cache_reap(): Further reduction in interrupt holdoff
Message-ID: <Pine.LNX.4.64.0603031530380.15581@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cache_reap takes the l3->list_lock (disabling interrupts) unconditionally and
then does a few checks and maybe does some cleanup. This patch makes
cache_reap() only take the lock if there is work to do and then the lock
is taken and released for each cleaning action.

The checking of when to do the next reaping is done without any locking
and becomes racy. Should not matter since reaping can also be skipped
if the slab mutex cannot be acquired.

The same is true for the touched processing. If we get this wrong once
in awhile then we will mistakenly clean or not clean the shared cache.
This will impact performance slightly.

Note that the additional drain_array() function introduced here
will fall out in a subsequent patch since array cleaning will now be
very similar from all callers.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc5-mm2/mm/slab.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/mm/slab.c	2006-03-03 07:50:57.000000000 -0800
+++ linux-2.6.16-rc5-mm2/mm/slab.c	2006-03-03 15:32:49.000000000 -0800
@@ -293,13 +293,13 @@ struct kmem_list3 {
 	struct list_head slabs_full;
 	struct list_head slabs_free;
 	unsigned long free_objects;
-	unsigned long next_reap;
-	int free_touched;
 	unsigned int free_limit;
 	unsigned int colour_next;	/* Per-node cache coloring */
 	spinlock_t list_lock;
 	struct array_cache *shared;	/* shared per node */
 	struct array_cache **alien;	/* on other nodes */
+	unsigned long next_reap;	/* updated without locking */
+	int free_touched;		/* updated without locking */
 };
 
 /*
@@ -3572,6 +3572,22 @@ static void drain_array_locked(struct km
 	}
 }
 
+
+/*
+ * Drain an array if it contains any elements taking the l3 lock only if
+ * necessary.
+ */
+void drain_array(struct kmem_cache *searchp, struct kmem_list3 *l3,
+					 struct array_cache *ac)
+{
+	if (ac && ac->avail) {
+		spin_lock_irq(&l3->list_lock);
+		drain_array_locked(searchp, ac, 0,
+				   numa_node_id());
+		spin_unlock_irq(&l3->list_lock);
+	}
+}
+
 /**
  * cache_reap - Reclaim memory from caches.
  * @unused: unused parameter
@@ -3605,33 +3621,48 @@ static void cache_reap(void *unused)
 		searchp = list_entry(walk, struct kmem_cache, next);
 		check_irq_on();
 
+		/*
+		 * We only take the l3 lock if absolutely necessary and we
+		 * have established with reasonable certainty that
+		 * we can do some work if the lock was obtained.
+		 */
 		l3 = searchp->nodelists[numa_node_id()];
+
 		reap_alien(searchp, l3);
-		spin_lock_irq(&l3->list_lock);
 
-		drain_array_locked(searchp, cpu_cache_get(searchp), 0,
-				   numa_node_id());
+		drain_array(searchp, l3, cpu_cache_get(searchp));
 
+		/*
+		 * These are racy checks but it does not matter
+		 * if we skip one check or scan twice.
+		 */
 		if (time_after(l3->next_reap, jiffies))
-			goto next_unlock;
+			goto next;
 
 		l3->next_reap = jiffies + REAPTIMEOUT_LIST3;
 
-		if (l3->shared)
-			drain_array_locked(searchp, l3->shared, 0,
-					   numa_node_id());
+		drain_array(searchp, l3, l3->shared);
 
 		if (l3->free_touched) {
 			l3->free_touched = 0;
-			goto next_unlock;
+			goto next;
 		}
 
 		tofree = (l3->free_limit + 5 * searchp->num - 1) /
 				(5 * searchp->num);
 		do {
+			/*
+			 * Do not lock if there are no free blocks.
+			 */
+			if (list_empty(&l3->slabs_free))
+				break;
+
+			spin_lock_irq(&l3->list_lock);
 			p = l3->slabs_free.next;
-			if (p == &(l3->slabs_free))
+			if (p == &(l3->slabs_free)) {
+				spin_unlock_irq(&l3->list_lock);
 				break;
+			}
 
 			slabp = list_entry(p, struct slab, list);
 			BUG_ON(slabp->inuse);
@@ -3646,10 +3677,8 @@ static void cache_reap(void *unused)
 			l3->free_objects -= searchp->num;
 			spin_unlock_irq(&l3->list_lock);
 			slab_destroy(searchp, slabp);
-			spin_lock_irq(&l3->list_lock);
 		} while (--tofree > 0);
-next_unlock:
-		spin_unlock_irq(&l3->list_lock);
+next:
 		cond_resched();
 	}
 	check_irq_on();
