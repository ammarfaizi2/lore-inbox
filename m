Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbTAQO7T>; Fri, 17 Jan 2003 09:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267513AbTAQO7S>; Fri, 17 Jan 2003 09:59:18 -0500
Received: from mx2.elte.hu ([157.181.151.9]:19103 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267510AbTAQO7L>;
	Fri, 17 Jan 2003 09:59:11 -0500
Date: Fri, 17 Jan 2003 16:11:59 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
In-Reply-To: <200301171535.21226.efocht@ess.nec.de>
Message-ID: <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Jan 2003, Erich Focht wrote:

> I like the cleanup of the topology.h. Also the renaming to
> prev_cpu_load. There was a mistake (I think) in the call to
> load_balance() in the idle path, guess you wanted to have:
> +           load_balance(this_rq, 1, __node_to_cpu_mask(this_node));
> instead of
> +           load_balance(this_rq, 1, this_cpumask);
> otherwise you won't load balance at all for idle cpus.

indeed - there was another bug as well, the 'idle' parameter to
load_balance() was 1 even in the busy branch, causing too slow balancing.

> From these results I would prefer to either leave the numa scheduler as
> it is or to introduce an IDLE_NODEBALANCE_TICK and a
> BUSY_NODEBALANCE_TICK instead of just having one NODE_REBALANCE_TICK
> which balances very rarely.

agreed, i've attached the -B0 patch that does this. The balancing rates
are 1 msec, 2 msec, 200 and 400 msec (idle-local, idle-global, busy-local,
busy-global).

	Ingo

--- linux/drivers/base/cpu.c.orig	2003-01-17 10:02:19.000000000 +0100
+++ linux/drivers/base/cpu.c	2003-01-17 10:02:25.000000000 +0100
@@ -6,8 +6,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 
 static int cpu_add_device(struct device * dev)
--- linux/drivers/base/node.c.orig	2003-01-17 10:02:50.000000000 +0100
+++ linux/drivers/base/node.c	2003-01-17 10:03:03.000000000 +0100
@@ -7,8 +7,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/node.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 
 static int node_add_device(struct device * dev)
--- linux/drivers/base/memblk.c.orig	2003-01-17 10:02:33.000000000 +0100
+++ linux/drivers/base/memblk.c	2003-01-17 10:02:38.000000000 +0100
@@ -7,8 +7,7 @@
 #include <linux/init.h>
 #include <linux/memblk.h>
 #include <linux/node.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 
 static int memblk_add_device(struct device * dev)
--- linux/include/asm-generic/topology.h.orig	2003-01-17 09:49:38.000000000 +0100
+++ linux/include/asm-generic/topology.h	2003-01-17 10:02:08.000000000 +0100
@@ -1,56 +0,0 @@
-/*
- * linux/include/asm-generic/topology.h
- *
- * Written by: Matthew Dobson, IBM Corporation
- *
- * Copyright (C) 2002, IBM Corp.
- *
- * All rights reserved.          
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send feedback to <colpatch@us.ibm.com>
- */
-#ifndef _ASM_GENERIC_TOPOLOGY_H
-#define _ASM_GENERIC_TOPOLOGY_H
-
-/* Other architectures wishing to use this simple topology API should fill
-   in the below functions as appropriate in their own <asm/topology.h> file. */
-#ifndef __cpu_to_node
-#define __cpu_to_node(cpu)		(0)
-#endif
-#ifndef __memblk_to_node
-#define __memblk_to_node(memblk)	(0)
-#endif
-#ifndef __parent_node
-#define __parent_node(node)		(0)
-#endif
-#ifndef __node_to_first_cpu
-#define __node_to_first_cpu(node)	(0)
-#endif
-#ifndef __node_to_cpu_mask
-#define __node_to_cpu_mask(node)	(cpu_online_map)
-#endif
-#ifndef __node_to_memblk
-#define __node_to_memblk(node)		(0)
-#endif
-
-/* Cross-node load balancing interval. */
-#ifndef NODE_BALANCE_RATE
-#define NODE_BALANCE_RATE 10
-#endif
-
-#endif /* _ASM_GENERIC_TOPOLOGY_H */
--- linux/include/asm-ppc64/topology.h.orig	2003-01-17 09:54:46.000000000 +0100
+++ linux/include/asm-ppc64/topology.h	2003-01-17 09:55:18.000000000 +0100
@@ -46,18 +46,6 @@
 	return mask;
 }
 
-/* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 10
-
-#else /* !CONFIG_NUMA */
-
-#define __cpu_to_node(cpu)		(0)
-#define __memblk_to_node(memblk)	(0)
-#define __parent_node(nid)		(0)
-#define __node_to_first_cpu(node)	(0)
-#define __node_to_cpu_mask(node)	(cpu_online_map)
-#define __node_to_memblk(node)		(0)
-
 #endif /* CONFIG_NUMA */
 
 #endif /* _ASM_PPC64_TOPOLOGY_H */
--- linux/include/linux/topology.h.orig	2003-01-17 09:57:20.000000000 +0100
+++ linux/include/linux/topology.h	2003-01-17 10:09:38.000000000 +0100
@@ -0,0 +1,43 @@
+/*
+ * linux/include/linux/topology.h
+ */
+#ifndef _LINUX_TOPOLOGY_H
+#define _LINUX_TOPOLOGY_H
+
+#include <asm/topology.h>
+
+/*
+ * The default (non-NUMA) topology definitions:
+ */
+#ifndef __cpu_to_node
+#define __cpu_to_node(cpu)		(0)
+#endif
+#ifndef __memblk_to_node
+#define __memblk_to_node(memblk)	(0)
+#endif
+#ifndef __parent_node
+#define __parent_node(node)		(0)
+#endif
+#ifndef __node_to_first_cpu
+#define __node_to_first_cpu(node)	(0)
+#endif
+#ifndef __cpu_to_node_mask
+#define __cpu_to_node_mask(cpu)		(cpu_online_map)
+#endif
+#ifndef __node_to_cpu_mask
+#define __node_to_cpu_mask(node)		(cpu_online_map)
+#endif
+#ifndef __node_to_memblk
+#define __node_to_memblk(node)		(0)
+#endif
+
+#ifndef __cpu_to_node_mask
+#define __cpu_to_node_mask(cpu)		__node_to_cpu_mask(__cpu_to_node(cpu))
+#endif
+
+/*
+ * Generic defintions:
+ */
+#define numa_node_id()			(__cpu_to_node(smp_processor_id()))
+
+#endif /* _LINUX_TOPOLOGY_H */
--- linux/include/linux/mmzone.h.orig	2003-01-17 09:58:20.000000000 +0100
+++ linux/include/linux/mmzone.h	2003-01-17 10:01:17.000000000 +0100
@@ -255,9 +255,7 @@
 #define MAX_NR_MEMBLKS	1
 #endif /* CONFIG_NUMA */
 
-#include <asm/topology.h>
-/* Returns the number of the current Node. */
-#define numa_node_id()		(__cpu_to_node(smp_processor_id()))
+#include <linux/topology.h>
 
 #ifndef CONFIG_DISCONTIGMEM
 extern struct pglist_data contig_page_data;
--- linux/include/asm-ia64/topology.h.orig	2003-01-17 09:54:33.000000000 +0100
+++ linux/include/asm-ia64/topology.h	2003-01-17 09:54:38.000000000 +0100
@@ -60,7 +60,4 @@
  */
 #define __node_to_memblk(node) (node)
 
-/* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 10
-
 #endif /* _ASM_IA64_TOPOLOGY_H */
--- linux/include/asm-i386/topology.h.orig	2003-01-17 09:55:28.000000000 +0100
+++ linux/include/asm-i386/topology.h	2003-01-17 09:56:27.000000000 +0100
@@ -61,17 +61,6 @@
 /* Returns the number of the first MemBlk on Node 'node' */
 #define __node_to_memblk(node) (node)
 
-/* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 100
-
-#else /* !CONFIG_NUMA */
-/*
- * Other i386 platforms should define their own version of the 
- * above macros here.
- */
-
-#include <asm-generic/topology.h>
-
 #endif /* CONFIG_NUMA */
 
 #endif /* _ASM_I386_TOPOLOGY_H */
--- linux/include/asm-i386/cpu.h.orig	2003-01-17 10:03:22.000000000 +0100
+++ linux/include/asm-i386/cpu.h	2003-01-17 10:03:31.000000000 +0100
@@ -3,8 +3,8 @@
 
 #include <linux/device.h>
 #include <linux/cpu.h>
+#include <linux/topology.h>
 
-#include <asm/topology.h>
 #include <asm/node.h>
 
 struct i386_cpu {
--- linux/include/asm-i386/node.h.orig	2003-01-17 10:04:02.000000000 +0100
+++ linux/include/asm-i386/node.h	2003-01-17 10:04:08.000000000 +0100
@@ -4,8 +4,7 @@
 #include <linux/device.h>
 #include <linux/mmzone.h>
 #include <linux/node.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 struct i386_node {
 	struct node node;
--- linux/include/asm-i386/memblk.h.orig	2003-01-17 10:03:51.000000000 +0100
+++ linux/include/asm-i386/memblk.h	2003-01-17 10:03:56.000000000 +0100
@@ -4,8 +4,8 @@
 #include <linux/device.h>
 #include <linux/mmzone.h>
 #include <linux/memblk.h>
+#include <linux/topology.h>
 
-#include <asm/topology.h>
 #include <asm/node.h>
 
 struct i386_memblk {
--- linux/kernel/sched.c.orig	2003-01-17 09:22:24.000000000 +0100
+++ linux/kernel/sched.c	2003-01-17 17:01:47.000000000 +0100
@@ -153,10 +153,9 @@
 			nr_uninterruptible;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
-	int prev_nr_running[NR_CPUS];
+	int prev_cpu_load[NR_CPUS];
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
-	unsigned int nr_balanced;
 	int prev_node_load[MAX_NUMNODES];
 #endif
 	task_t *migration_thread;
@@ -765,29 +764,6 @@
 	return node;
 }
 
-static inline unsigned long cpus_to_balance(int this_cpu, runqueue_t *this_rq)
-{
-	int this_node = __cpu_to_node(this_cpu);
-	/*
-	 * Avoid rebalancing between nodes too often.
-	 * We rebalance globally once every NODE_BALANCE_RATE load balances.
-	 */
-	if (++(this_rq->nr_balanced) == NODE_BALANCE_RATE) {
-		int node = find_busiest_node(this_node);
-		this_rq->nr_balanced = 0;
-		if (node >= 0)
-			return (__node_to_cpu_mask(node) | (1UL << this_cpu));
-	}
-	return __node_to_cpu_mask(this_node);
-}
-
-#else /* !CONFIG_NUMA */
-
-static inline unsigned long cpus_to_balance(int this_cpu, runqueue_t *this_rq)
-{
-	return cpu_online_map;
-}
-
 #endif /* CONFIG_NUMA */
 
 #if CONFIG_SMP
@@ -807,10 +783,10 @@
 			spin_lock(&busiest->lock);
 			spin_lock(&this_rq->lock);
 			/* Need to recalculate nr_running */
-			if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
+			if (idle || (this_rq->nr_running > this_rq->prev_cpu_load[this_cpu]))
 				nr_running = this_rq->nr_running;
 			else
-				nr_running = this_rq->prev_nr_running[this_cpu];
+				nr_running = this_rq->prev_cpu_load[this_cpu];
 		} else
 			spin_lock(&busiest->lock);
 	}
@@ -847,10 +823,10 @@
 	 * that case we are less picky about moving a task across CPUs and
 	 * take what can be taken.
 	 */
-	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
+	if (idle || (this_rq->nr_running > this_rq->prev_cpu_load[this_cpu]))
 		nr_running = this_rq->nr_running;
 	else
-		nr_running = this_rq->prev_nr_running[this_cpu];
+		nr_running = this_rq->prev_cpu_load[this_cpu];
 
 	busiest = NULL;
 	max_load = 1;
@@ -859,11 +835,11 @@
 			continue;
 
 		rq_src = cpu_rq(i);
-		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
+		if (idle || (rq_src->nr_running < this_rq->prev_cpu_load[i]))
 			load = rq_src->nr_running;
 		else
-			load = this_rq->prev_nr_running[i];
-		this_rq->prev_nr_running[i] = rq_src->nr_running;
+			load = this_rq->prev_cpu_load[i];
+		this_rq->prev_cpu_load[i] = rq_src->nr_running;
 
 		if ((load > max_load) && (rq_src != this_rq)) {
 			busiest = rq_src;
@@ -922,7 +898,7 @@
  * We call this with the current runqueue locked,
  * irqs disabled.
  */
-static void load_balance(runqueue_t *this_rq, int idle)
+static void load_balance(runqueue_t *this_rq, int idle, unsigned long cpumask)
 {
 	int imbalance, idx, this_cpu = smp_processor_id();
 	runqueue_t *busiest;
@@ -930,8 +906,7 @@
 	struct list_head *head, *curr;
 	task_t *tmp;
 
-	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance,
-					cpus_to_balance(this_cpu, this_rq));
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance, cpumask);
 	if (!busiest)
 		goto out;
 
@@ -1006,21 +981,75 @@
  * frequency and balancing agressivity depends on whether the CPU is
  * idle or not.
  *
- * busy-rebalance every 250 msecs. idle-rebalance every 1 msec. (or on
+ * busy-rebalance every 200 msecs. idle-rebalance every 1 msec. (or on
  * systems with HZ=100, every 10 msecs.)
+ *
+ * On NUMA, do a node-rebalance every 400 msecs.
  */
-#define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
 #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
+#define BUSY_REBALANCE_TICK (HZ/5 ?: 1)
+#define IDLE_NODE_REBALANCE_TICK (IDLE_REBALANCE_TICK * 2)
+#define BUSY_NODE_REBALANCE_TICK (BUSY_REBALANCE_TICK * 2)
 
-static inline void idle_tick(runqueue_t *rq)
+#if CONFIG_NUMA
+static void balance_node(runqueue_t *this_rq, int idle, int this_cpu)
 {
-	if (jiffies % IDLE_REBALANCE_TICK)
-		return;
-	spin_lock(&rq->lock);
-	load_balance(rq, 1);
-	spin_unlock(&rq->lock);
+	int node = find_busiest_node(__cpu_to_node(this_cpu));
+	unsigned long cpumask, this_cpumask = 1UL << this_cpu;
+
+	if (node >= 0) {
+		cpumask = __node_to_cpu_mask(node) | this_cpumask;
+		spin_lock(&this_rq->lock);
+		load_balance(this_rq, idle, cpumask);
+		spin_unlock(&this_rq->lock);
+	}
 }
+#endif
 
+static void rebalance_tick(runqueue_t *this_rq, int idle)
+{
+#if CONFIG_NUMA
+	int this_cpu = smp_processor_id();
+#endif
+	unsigned long j = jiffies;
+
+	/*
+	 * First do inter-node rebalancing, then intra-node rebalancing,
+	 * if both events happen in the same tick. The inter-node
+	 * rebalancing does not necessarily have to create a perfect
+	 * balance within the node, since we load-balance the most loaded
+	 * node with the current CPU. (ie. other CPUs in the local node
+	 * are not balanced.)
+	 */
+	if (idle) {
+#if CONFIG_NUMA
+		if (!(j % IDLE_NODE_REBALANCE_TICK))
+			balance_node(this_rq, idle, this_cpu);
+#endif
+		if (!(j % IDLE_REBALANCE_TICK)) {
+			spin_lock(&this_rq->lock);
+			load_balance(this_rq, 0, __cpu_to_node_mask(this_cpu));
+			spin_unlock(&this_rq->lock);
+		}
+		return;
+	}
+#if CONFIG_NUMA
+	if (!(j % BUSY_NODE_REBALANCE_TICK))
+		balance_node(this_rq, idle, this_cpu);
+#endif
+	if (!(j % BUSY_REBALANCE_TICK)) {
+		spin_lock(&this_rq->lock);
+		load_balance(this_rq, idle, __cpu_to_node_mask(this_cpu));
+		spin_unlock(&this_rq->lock);
+	}
+}
+#else
+/*
+ * on UP we do not need to balance between CPUs:
+ */
+static inline void rebalance_tick(runqueue_t *this_rq, int idle)
+{
+}
 #endif
 
 DEFINE_PER_CPU(struct kernel_stat, kstat) = { { 0 } };
@@ -1063,9 +1092,7 @@
 			kstat_cpu(cpu).cpustat.iowait += sys_ticks;
 		else
 			kstat_cpu(cpu).cpustat.idle += sys_ticks;
-#if CONFIG_SMP
-		idle_tick(rq);
-#endif
+		rebalance_tick(rq, 1);
 		return;
 	}
 	if (TASK_NICE(p) > 0)
@@ -1121,11 +1148,8 @@
 			enqueue_task(p, rq->active);
 	}
 out:
-#if CONFIG_SMP
-	if (!(jiffies % BUSY_REBALANCE_TICK))
-		load_balance(rq, 0);
-#endif
 	spin_unlock(&rq->lock);
+	rebalance_tick(rq, 0);
 }
 
 void scheduling_functions_start_here(void) { }
@@ -1184,7 +1208,7 @@
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
 #if CONFIG_SMP
-		load_balance(rq, 1);
+		load_balance(rq, 1, __cpu_to_node_mask(smp_processor_id()));
 		if (rq->nr_running)
 			goto pick_next_task;
 #endif
--- linux/mm/page_alloc.c.orig	2003-01-17 10:01:29.000000000 +0100
+++ linux/mm/page_alloc.c	2003-01-17 10:01:35.000000000 +0100
@@ -28,8 +28,7 @@
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/notifier.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
 DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
--- linux/mm/vmscan.c.orig	2003-01-17 10:01:44.000000000 +0100
+++ linux/mm/vmscan.c	2003-01-17 10:01:52.000000000 +0100
@@ -27,10 +27,10 @@
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
 #include <linux/rmap-locking.h>
+#include <linux/topology.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-#include <asm/topology.h>
 #include <asm/div64.h>
 
 #include <linux/swapops.h>

