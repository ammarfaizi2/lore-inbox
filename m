Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbVLVJ1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbVLVJ1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 04:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbVLVJ1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 04:27:55 -0500
Received: from ns1.siteground.net ([207.218.208.2]:18051 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S965145AbVLVJ1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 04:27:54 -0500
Date: Thu, 22 Dec 2005 01:27:43 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Sonny Rao <sonny@burdell.org>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com, clameter@sgi.com,
       anton@samba.org, sonnyrao@us.ibm.com, shai@scalex86.org
Subject: Re: cpu hotplug oops on 2.6.15-rc5
Message-ID: <20051222092743.GE3915@localhost.localdomain>
References: <20051219051659.GA6299@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219051659.GA6299@kevlar.burdell.org>
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

On Mon, Dec 19, 2005 at 12:16:59AM -0500, Sonny Rao wrote:
> (apologies if this is a dup)
> 
> Hi, I'm crashing 2.6.15-rc5 when I try and offline the last and only CPU in a node on a ppc64 Power5, SMT was disabled.
> 
> Here's the backtrace:
> 
> 0:mon> t
> [c0000001ad033820] c000000000096a7c .kfree+0x250/0x280
> [c0000001ad0338d0] c00000000009a544 .cpuup_callback+0x238/0x5fc
> [c0000001ad0339c0] c000000000068114 .notifier_call_chain+0x68/0x9c
> [c0000001ad033a50] c0000000000789fc .cpu_down+0x1fc/0x368
> [c0000001ad033b40] c0000000002ac658 .store_online+0x88/0xe8
> [c0000001ad033bd0] c0000000002a6f14 .sysdev_store+0x4c/0x68
> [c0000001ad033c50] c000000000110368 .sysfs_write_file+0x100/0x1a0
> [c0000001ad033cf0] c0000000000be854 .vfs_write+0x100/0x200
> [c0000001ad033d90] c0000000000bea64 .sys_write+0x54/0x9c
> [c0000001ad033e30] c000000000008600 syscall_exit+0x0/0x18
> --- Exception: c01 (System Call) at 000000000fe5ec10
> SP (ffc4c4f0) is in userspace
> 
> 0:mon> e
> cpu 0x0: Vector: 300 (Data Access) at [c0000001ad033520]
>     pc: c00000000048bd30: ._spin_lock+0x18/0x80
>     lr: c000000000096a7c: .kfree+0x250/0x280
>     sp: c0000001ad0337a0
>    msr: 8000000000001032
>    dar: 48
>  dsisr: 40000000
>   current = 0xc0000001aff12040
>   paca    = 0xc0000000005c1000
>     pid   = 17376, comm = bash
> 
> 

Sonny,
Does this patch fix the issue?   This one applies cleanly on 2.6.15-rc6
unlike the one that was sent to you earlier.

Thanks,
Kiran

From: Alok N Kataria <alokk@calsoftinc.com>

Fixes a bug in the CPU_DOWN call path, we shouldn't call kfree while
holding kmem_list3's list lock, nor should drain_alien_cache be called
with l3's list lock.

Signed-off-by : Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by : Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by : Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.15-rc6/mm/slab.c
===================================================================
--- linux-2.6.15-rc6.orig/mm/slab.c	2005-12-21 22:32:14.000000000 -0800
+++ linux-2.6.15-rc6/mm/slab.c	2005-12-21 22:32:58.000000000 -0800
@@ -824,14 +824,14 @@ static inline void __drain_alien_cache(k
 	}
 }
 
-static void drain_alien_cache(kmem_cache_t *cachep, struct kmem_list3 *l3)
+static void drain_alien_cache(kmem_cache_t *cachep, struct array_cache **alien)
 {
 	int i=0;
 	struct array_cache *ac;
 	unsigned long flags;
 
 	for_each_online_node(i) {
-		ac = l3->alien[i];
+		ac = alien[i];
 		if (ac) {
 			spin_lock_irqsave(&ac->lock, flags);
 			__drain_alien_cache(cachep, ac, i);
@@ -842,7 +842,7 @@ static void drain_alien_cache(kmem_cache
 #else
 #define alloc_alien_cache(node, limit) do { } while (0)
 #define free_alien_cache(ac_ptr) do { } while (0)
-#define drain_alien_cache(cachep, l3) do { } while (0)
+#define drain_alien_cache(cachep, alien) do { } while (0)
 #endif
 
 static int __devinit cpuup_callback(struct notifier_block *nfb,
@@ -921,7 +921,7 @@ static int __devinit cpuup_callback(stru
 		down(&cache_chain_sem);
 
 		list_for_each_entry(cachep, &cache_chain, next) {
-			struct array_cache *nc;
+			struct array_cache *nc, *shared, **alien;
 			cpumask_t mask;
 
 			mask = node_to_cpumask(node);
@@ -932,7 +932,7 @@ static int __devinit cpuup_callback(stru
 			l3 = cachep->nodelists[node];
 
 			if (!l3)
-				goto unlock_cache;
+				goto free_array_cache;
 
 			spin_lock(&l3->list_lock);
 
@@ -943,32 +943,40 @@ static int __devinit cpuup_callback(stru
 
 			if (!cpus_empty(mask)) {
                                 spin_unlock(&l3->list_lock);
-                                goto unlock_cache;
+                                goto free_array_cache;
                         }
 
-			if (l3->shared) {
+			if ((shared = l3->shared)) {
 				free_block(cachep, l3->shared->entry,
 						l3->shared->avail, node);
 				kfree(l3->shared);
 				l3->shared = NULL;
 			}
-			if (l3->alien) {
-				drain_alien_cache(cachep, l3);
-				free_alien_cache(l3->alien);
-				l3->alien = NULL;
+
+			alien = l3->alien;
+			l3->alien = NULL;
+
+			spin_unlock(&l3->list_lock);
+
+			kfree(nc);
+			kfree(shared);
+			if (alien) {
+				drain_alien_cache(cachep, alien);
+				free_alien_cache(alien);
 			}
 
 			/* free slabs belonging to this node */
 			if (__node_shrink(cachep, node)) {
+				spin_lock(&l3->list_lock);
 				cachep->nodelists[node] = NULL;
 				spin_unlock(&l3->list_lock);
 				kfree(l3);
-			} else {
-				spin_unlock(&l3->list_lock);
 			}
+			goto unlock_cache;
+free_array_cache:
+			kfree(nc);
 unlock_cache:
 			spin_unlock_irq(&cachep->spinlock);
-			kfree(nc);
 		}
 		up(&cache_chain_sem);
 		break;
@@ -1918,7 +1926,7 @@ static void drain_cpu_caches(kmem_cache_
 			drain_array_locked(cachep, l3->shared, 1, node);
 			spin_unlock(&l3->list_lock);
 			if (l3->alien)
-				drain_alien_cache(cachep, l3);
+				drain_alien_cache(cachep, l3->alien);
 		}
 	}
 	spin_unlock_irq(&cachep->spinlock);
@@ -3310,7 +3318,7 @@ static void cache_reap(void *unused)
 
 		l3 = searchp->nodelists[numa_node_id()];
 		if (l3->alien)
-			drain_alien_cache(searchp, l3);
+			drain_alien_cache(searchp, l3->alien);
 		spin_lock_irq(&l3->list_lock);
 
 		drain_array_locked(searchp, ac_data(searchp), 0,
