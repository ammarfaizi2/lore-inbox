Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbTBCL1H>; Mon, 3 Feb 2003 06:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbTBCL1G>; Mon, 3 Feb 2003 06:27:06 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:4971
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265787AbTBCL05>; Mon, 3 Feb 2003 06:26:57 -0500
Date: Mon, 3 Feb 2003 06:35:03 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@digeo.com>
Subject: [PATCH][2/6] CPU Hotplug mm/
Message-ID: <Pine.LNX.4.44.0302030545300.9361-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 page-writeback.c |    1 +
 page_alloc.c     |    3 ++-
 slab.c           |   33 ++++++++++++++++++++++++++++++++-
 vmscan.c         |   42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 2 deletions(-)

Index: linux-2.5.59-lch2/mm/page-writeback.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/mm/page-writeback.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 page-writeback.c
--- linux-2.5.59-lch2/mm/page-writeback.c	17 Jan 2003 11:16:41 -0000	1.1.1.1
+++ linux-2.5.59-lch2/mm/page-writeback.c	21 Jan 2003 04:48:29 -0000
@@ -350,6 +350,7 @@
 static int
 ratelimit_handler(struct notifier_block *self, unsigned long u, void *v)
 {
+	/* This should be fine for all cases */
 	set_ratelimit();
 	return 0;
 }
Index: linux-2.5.59-lch2/mm/slab.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/mm/slab.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 slab.c
--- linux-2.5.59-lch2/mm/slab.c	17 Jan 2003 11:16:41 -0000	1.1.1.1
+++ linux-2.5.59-lch2/mm/slab.c	3 Feb 2003 11:14:50 -0000
@@ -528,6 +528,16 @@
 	}
 }
 
+static void stop_cpu_timer(int cpu)
+{
+	struct timer_list *rt = &reap_timers[cpu];
+
+	if (rt->function) {
+		del_timer_sync(rt);
+		rt->function = NULL;
+	}
+}
+
 /*
  * Note: if someone calls kmem_cache_alloc() on the new
  * cpu before the cpuup callback had a chance to allocate
@@ -584,6 +594,24 @@
 		}
 		up(&cache_chain_sem);
 		break;
+
+	case CPU_DEAD:
+		down(&cache_chain_sem);
+		list_for_each(p, &cache_chain) {
+			struct array_cache *nc;
+
+			kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
+			spin_lock_irq(&cachep->spinlock);
+			nc = cachep->array[cpu];
+			cachep->array[cpu] = NULL;
+			cachep->free_limit = (num_online_cpus())*cachep->batchcount
+						+ cachep->num;
+			kfree(nc);
+			spin_unlock_irq(&cachep->spinlock);
+		}
+		up(&cache_chain_sem);
+		stop_cpu_timer(cpu);
+		break;
 	}
 	return NOTIFY_OK;
 bad:
@@ -591,7 +619,7 @@
 	return NOTIFY_BAD;
 }
 
-static struct notifier_block cpucache_notifier = { &cpuup_callback, NULL, 0 };
+static struct notifier_block __devinitdata cpucache_notifier = { &cpuup_callback, NULL, 0 };
 
 static inline void ** ac_entry(struct array_cache *ac)
 {
@@ -1236,6 +1264,9 @@
 	}
 	{
 		int i;
+		/* no cpu_online check required here since we clear the percpu
+		 * array on cpu offline and set this to NULL.
+		 */
 		for (i = 0; i < NR_CPUS; i++)
 			kfree(cachep->array[i]);
 		/* NUMA: free the list3 structures */
Index: linux-2.5.59-lch2/mm/vmscan.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/mm/vmscan.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/mm/vmscan.c	17 Jan 2003 11:16:41 -0000	1.1.1.1
+++ linux-2.5.59-lch2/mm/vmscan.c	20 Jan 2003 13:48:28 -0000	1.1.1.1.2.1
@@ -27,6 +27,7 @@
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
 #include <linux/rmap-locking.h>
+#include <linux/notifier.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -931,6 +932,7 @@
 	daemonize();
 	set_cpus_allowed(tsk, __node_to_cpu_mask(pgdat->node_id));
 	sprintf(tsk->comm, "kswapd%d", pgdat->node_id);
+	printk("Set %s affinity to %08lX\n", tsk->comm, tsk->cpus_allowed);
 	sigfillset(&tsk->blocked);
 	
 	/*
@@ -999,6 +1001,45 @@
 }
 #endif
 
+/* It's optimal to keep kswapds on the same CPUs as their memory, but
+   not required for correctness.  So if the last cpu in a node goes
+   away, let them run anywhere, and as the first one comes back,
+   restore their cpu bindings. */
+static int __devinit cpu_callback(struct notifier_block *nfb,
+				  unsigned long action,
+				  void *hcpu)
+{
+	pg_data_t *pgdat;
+	unsigned int hotcpu = (unsigned long)hcpu;
+	unsigned long mask;
+
+	if (action == CPU_OFFLINE) {
+		/* Make sure that kswapd never becomes unschedulable. */
+		for_each_pgdat(pgdat) {
+			mask = __node_to_cpu_mask(pgdat->node_id);
+			if (any_online_cpu(mask) < 0) {
+				mask = ~0UL;
+				set_cpus_allowed(pgdat->kswapd, mask);
+			}
+		}
+	}
+
+	if (action == CPU_ONLINE) {
+		for_each_pgdat(pgdat) {
+			mask = __node_to_cpu_mask(pgdat->node_id);
+			mask &= ~(1UL << hotcpu);
+			if (any_online_cpu(mask) < 0) {
+				mask |= (1UL << hotcpu);
+				/* One of our CPUs came back: restore mask */
+				set_cpus_allowed(pgdat->kswapd, mask);
+			}
+		}
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpu_nfb = { &cpu_callback, NULL, 0 };
+
 static int __init kswapd_init(void)
 {
 	pg_data_t *pgdat;
@@ -1006,6 +1047,7 @@
 	for_each_pgdat(pgdat)
 		kernel_thread(kswapd, pgdat, CLONE_KERNEL);
 	total_memory = nr_free_pagecache_pages();
+	register_cpu_notifier(&cpu_nfb);
 	return 0;
 }
 


