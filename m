Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbTBQIIu>; Mon, 17 Feb 2003 03:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbTBQIIj>; Mon, 17 Feb 2003 03:08:39 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:32158
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266959AbTBQIFz>; Mon, 17 Feb 2003 03:05:55 -0500
Date: Mon, 17 Feb 2003 03:14:33 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH][2.5][4/5] CPU Hotplug mm/
Message-ID: <Pine.LNX.4.50.0302170306420.18087-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 slab.c   |   39 +++++++++++++++++++++++++++++++++++++++
 vmscan.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

Index: linux-2.5.61-trojan/mm/slab.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/mm/slab.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 slab.c
--- linux-2.5.61-trojan/mm/slab.c	15 Feb 2003 12:32:45 -0000	1.1.1.1
+++ linux-2.5.61-trojan/mm/slab.c	17 Feb 2003 05:32:26 -0000
@@ -464,6 +464,7 @@
 } g_cpucache_up;
 
 static struct timer_list reap_timers[NR_CPUS];
+static unsigned long stop_reap_timer_mask;
 
 static void reap_timer_fnc(unsigned long data);
 
@@ -523,10 +524,20 @@
 		init_timer(rt);
 		rt->expires = jiffies + HZ + 3*cpu;
 		rt->function = reap_timer_fnc;
+		clear_bit(cpu, &stop_reap_timer_mask);
 		add_timer_on(rt, cpu);
 	}
 }
 
+static void stop_cpu_timer(int cpu)
+{
+	struct timer_list *rt = &reap_timers[cpu];
+
+	set_bit(cpu, &stop_reap_timer_mask);
+	while (rt->function)
+		cpu_relax();
+}
+
 /*
  * Note: if someone calls kmem_cache_alloc() on the new
  * cpu before the cpuup callback had a chance to allocate
@@ -583,6 +594,26 @@
 		}
 		up(&cache_chain_sem);
 		break;
+	case CPU_OFFLINE:
+		stop_cpu_timer(cpu);
+		break;
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
+		break;
 	}
 	return NOTIFY_OK;
 bad:
@@ -1235,6 +1266,9 @@
 	}
 	{
 		int i;
+		/* no cpu_online check required here since we clear the percpu
+		 * array on cpu offline and set this to NULL.
+		 */
 		for (i = 0; i < NR_CPUS; i++)
 			kfree(cachep->array[i]);
 		/* NUMA: free the list3 structures */
@@ -2183,6 +2217,11 @@
 	int cpu = smp_processor_id();
 	struct timer_list *rt = &reap_timers[cpu];
 
+	if (unlikely(test_bit(cpu, &stop_reap_timer_mask))) {
+		del_timer(rt);
+		rt->function = NULL;
+		return;
+	}
 	cache_reap();
 	mod_timer(rt, jiffies + REAPTIMEOUT_CPUC + cpu);
 }
Index: linux-2.5.61-trojan/mm/vmscan.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/mm/vmscan.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 vmscan.c
--- linux-2.5.61-trojan/mm/vmscan.c	15 Feb 2003 12:32:45 -0000	1.1.1.1
+++ linux-2.5.61-trojan/mm/vmscan.c	17 Feb 2003 06:47:05 -0000
@@ -27,6 +27,7 @@
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
 #include <linux/rmap-locking.h>
+#include <linux/notifier.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -931,6 +932,7 @@
 	daemonize("kswapd%d", pgdat->node_id);
 	set_cpus_allowed(tsk, node_to_cpumask(pgdat->node_id));
 	
+	printk("Set %s affinity to %08lX\n", tsk->comm, tsk->cpus_allowed);
 	/*
 	 * Tell the memory management that we're a "memory allocator",
 	 * and that if we need more memory we should get access to it
@@ -996,6 +998,47 @@
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
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_SMP)
+	pg_data_t *pgdat;
+	unsigned int hotcpu = (unsigned long)hcpu;
+	unsigned long mask;
+
+	if (action == CPU_OFFLINE) {
+		/* Make sure that kswapd never becomes unschedulable. */
+		for_each_pgdat(pgdat) {
+			mask = node_to_cpumask(pgdat->node_id);
+			if (any_online_cpu(mask) < 0) {
+				mask = ~0UL;
+				set_cpus_allowed(pgdat->kswapd, mask);
+			}
+		}
+	}
+
+	if (action == CPU_ONLINE) {
+		for_each_pgdat(pgdat) {
+			mask = node_to_cpumask(pgdat->node_id);
+			mask &= ~(1UL << hotcpu);
+			if (any_online_cpu(mask) < 0) {
+				mask |= (1UL << hotcpu);
+				/* One of our CPUs came back: restore mask */
+				set_cpus_allowed(pgdat->kswapd, mask);
+			}
+		}
+	}
+#endif
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpu_nfb = { &cpu_callback, NULL, 0 };
+
 static int __init kswapd_init(void)
 {
 	pg_data_t *pgdat;
@@ -1003,6 +1046,7 @@
 	for_each_pgdat(pgdat)
 		kernel_thread(kswapd, pgdat, CLONE_KERNEL);
 	total_memory = nr_free_pagecache_pages();
+	register_cpu_notifier(&cpu_nfb);
 	return 0;
 }
 
