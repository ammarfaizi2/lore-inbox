Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945996AbWBDKEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945996AbWBDKEW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 05:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945999AbWBDKEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 05:04:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945996AbWBDKEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 05:04:21 -0500
Date: Sat, 4 Feb 2006 02:03:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, shai@scalex86.org,
       alok.kataria@calsoftinc.com, sonny@burdell.org
Subject: Re: [patch 3/3] NUMA slab locking fixes -- fix cpu down and up
 locking
Message-Id: <20060204020341.6a5a73ab.akpm@osdl.org>
In-Reply-To: <20060204012953.GJ3653@localhost.localdomain>
References: <20060203205341.GC3653@localhost.localdomain>
	<20060203140748.082c11ee.akpm@osdl.org>
	<Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com>
	<20060204010857.GG3653@localhost.localdomain>
	<20060204012953.GJ3653@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> This fixes locking and bugs in cpu_down and cpu_up paths of the NUMA slab
> allocator.  Sonny Rao <sonny@burdell.org> reported problems sometime back 
> on POWER5 boxes, when the last cpu on the nodes were being offlined.  We could
> not reproduce the same on x86_64 because the cpumask (node_to_cpumask) was not
> being updated on cpu down.  Since that issue is now fixed, we can reproduce
> Sonny's problems on x86_64 NUMA, and here is the fix.
> 
> The problem earlier was on CPU_DOWN, if it was the last cpu on the node to go 
> down, the array_caches (shared, alien)  and the kmem_list3 of the node were 
> being freed (kfree) with the kmem_list3 lock held.  If the l3 or the 
> array_caches were to come from the same cache being cleared, we hit on badness.
> 
> This patch cleans up the locking in cpu_up and cpu_down path.  
> We cannot really free l3 on cpu down because, there is no node offlining yet
> and even though a cpu is not yet up, node local memory can be allocated
> for it. So l3s are usually allocated at keme_cache_create and destroyed at kmem_cache_destroy.  Hence, we don't need cachep->spinlock protection to get
> to the cachep->nodelist[nodeid] either.
> 
> Patch survived onlining and offlining on a 4 core 2 node Tyan box with a 
> 4 dbench process running all the time.
> 
> ...
>
> +			if (!(nc = alloc_arraycache(node, 
> +			      cachep->limit, cachep->batchcount)))
>  				goto bad;
> +			if (!(shared = alloc_arraycache(node,
> +			      cachep->shared*cachep->batchcount, 0xbaadf00d)))
> +				goto bad;

Please don't do things like that - it's quite hard to read and we avoid it.
Cleanup patch below.

--- devel/mm/slab.c~numa-slab-locking-fixes-fix-cpu-down-and-up-locking-tidy	2006-02-04 02:01:33.000000000 -0800
+++ devel-akpm/mm/slab.c	2006-02-04 02:01:33.000000000 -0800
@@ -936,9 +936,11 @@ static int __devinit cpuup_callback(stru
 				l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
 				    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 
-				/* The l3s don't come and go as cpus come and
-				   go.  cache_chain_mutex is sufficient
-				   protection here */
+				/*
+				 * The l3s don't come and go as CPUs come and
+				 * go.  cache_chain_mutex is sufficient
+				 * protection here.
+				 */
 				cachep->nodelists[node] = l3;
 			}
 
@@ -952,17 +954,22 @@ static int __devinit cpuup_callback(stru
 		/* Now we can go ahead with allocating the shared array's
 		   & array cache's */
 		list_for_each_entry(cachep, &cache_chain, next) {
-			struct array_cache *nc, *shared, **alien;
-
-			if (!(nc = alloc_arraycache(node,
-			      cachep->limit, cachep->batchcount)))
+			struct array_cache *nc;
+			struct array_cache *shared;
+			struct array_cache **alien;
+
+			nc = alloc_arraycache(node, cachep->limit,
+						cachep->batchcount);
+			if (!nc)
 				goto bad;
-			if (!(shared = alloc_arraycache(node,
-			      cachep->shared*cachep->batchcount, 0xbaadf00d)))
+			shared = alloc_arraycache(node,
+					cachep->shared * cachep->batchcount,
+					0xbaadf00d);
+			if (!shared)
 				goto bad;
 #ifdef CONFIG_NUMA
-			if (!(alien = alloc_alien_cache(node,
-			      cachep->limit)))
+			alien = alloc_alien_cache(node, cachep->limit);
+			if (!alien)
 				goto bad;
 #endif
 			cachep->array[cpu] = nc;
@@ -972,8 +979,10 @@ static int __devinit cpuup_callback(stru
 
 			spin_lock_irq(&l3->list_lock);
 			if (!l3->shared) {
-				/* we are serialised from CPU_DEAD or
-				   CPU_UP_CANCELLED by the cpucontrol lock */
+				/*
+				 * We are serialised from CPU_DEAD or
+				 * CPU_UP_CANCELLED by the cpucontrol lock
+				 */
 				l3->shared = shared;
 				shared = NULL;
 			}
@@ -993,19 +1002,22 @@ static int __devinit cpuup_callback(stru
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_DEAD:
-		/* Even if all the cpus of a node are down, we don't
-		 * free the kmem_list3 of any cache. This to avoid a race
-		 * between cpu_down, and a kmalloc allocation from another
-		 * cpu for memory from the node of the cpu going down.
-		 * The list3 structure is usually allocated from
-		 * kmem_cache_create and gets destroyed at kmem_cache_destroy
+		/*
+		 * Even if all the cpus of a node are down, we don't free the
+		 * kmem_list3 of any cache. This to avoid a race between
+		 * cpu_down, and a kmalloc allocation from another cpu for
+		 * memory from the node of the cpu going down.  The list3
+		 * structure is usually allocated from kmem_cache_create() and
+		 * gets destroyed at kmem_cache_destroy().
 		 */
 		/* fall thru */
 	case CPU_UP_CANCELED:
 		mutex_lock(&cache_chain_mutex);
 
 		list_for_each_entry(cachep, &cache_chain, next) {
-			struct array_cache *nc, *shared, **alien;
+			struct array_cache *nc;
+			struct array_cache *shared;
+			struct array_cache **alien;
 			cpumask_t mask;
 
 			mask = node_to_cpumask(node);
@@ -1029,7 +1041,8 @@ static int __devinit cpuup_callback(stru
 				goto free_array_cache;
 			}
 
-			if ((shared = l3->shared)) {
+			shared = l3->shared;
+			if (shared) {
 				free_block(cachep, l3->shared->entry,
 					   l3->shared->avail, node);
 				l3->shared = NULL;
@@ -1045,7 +1058,7 @@ static int __devinit cpuup_callback(stru
 				drain_alien_cache(cachep, alien);
 				free_alien_cache(alien);
 			}
-      free_array_cache:
+free_array_cache:
 			kfree(nc);
 		}
 		/*
@@ -1054,7 +1067,6 @@ static int __devinit cpuup_callback(stru
 		 * shrink each nodelist to its limit.
 		 */
 		list_for_each_entry(cachep, &cache_chain, next) {
-
 			l3 = cachep->nodelists[node];
 			if (!l3)
 				continue;
_

