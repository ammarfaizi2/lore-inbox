Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267154AbTAPSaw>; Thu, 16 Jan 2003 13:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbTAPSaw>; Thu, 16 Jan 2003 13:30:52 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:28069 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267154AbTAPSar>; Thu, 16 Jan 2003 13:30:47 -0500
Date: Thu, 16 Jan 2003 10:32:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, hohnbaum@us.ibm.com,
       Erich Focht <efocht@ess.nec.de>
Subject: [PATCH] (3/3) NUMA rebalancer
Message-ID: <2140000.1042741927@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Erich Focht

This adds a hook to rebalance globally across nodes every NODE_BALANCE_RATE
iterations of the rebalancer. This allows us to easily tune on an architecture
specific basis how often we wish to rebalance - machines with higher NUMA
ratios (more expensive off-node access) will want to do this less often.
It's currently set to 100 for NUMA-Q and 10 for other machines. If the 
imbalance between nodes is > 125%, we'll rebalance them. The hook for this
is added to the NUMA definition of cpus_to_balance, so again, no impact
on non-NUMA machines.


diff -urpN -X /home/fletch/.diff.exclude numasched2/include/asm-generic/topology.h numasched3/include/asm-generic/topology.h
--- numasched2/include/asm-generic/topology.h	Sun Nov 17 20:29:22 2002
+++ numasched3/include/asm-generic/topology.h	Wed Jan 15 19:26:01 2003
@@ -48,4 +48,9 @@
 #define __node_to_memblk(node)		(0)
 #endif
 
+/* Cross-node load balancing interval. */
+#ifndef NODE_BALANCE_RATE
+#define NODE_BALANCE_RATE 10
+#endif
+
 #endif /* _ASM_GENERIC_TOPOLOGY_H */
diff -urpN -X /home/fletch/.diff.exclude numasched2/include/asm-i386/topology.h numasched3/include/asm-i386/topology.h
--- numasched2/include/asm-i386/topology.h	Thu Jan  9 19:16:11 2003
+++ numasched3/include/asm-i386/topology.h	Wed Jan 15 19:26:01 2003
@@ -61,6 +61,9 @@ static inline int __node_to_first_cpu(in
 /* Returns the number of the first MemBlk on Node 'node' */
 #define __node_to_memblk(node) (node)
 
+/* Cross-node load balancing interval. */
+#define NODE_BALANCE_RATE 100
+
 #else /* !CONFIG_NUMA */
 /*
  * Other i386 platforms should define their own version of the 
diff -urpN -X /home/fletch/.diff.exclude numasched2/include/asm-ia64/topology.h numasched3/include/asm-ia64/topology.h
--- numasched2/include/asm-ia64/topology.h	Sun Nov 17 20:29:20 2002
+++ numasched3/include/asm-ia64/topology.h	Wed Jan 15 19:26:01 2003
@@ -60,4 +60,7 @@
  */
 #define __node_to_memblk(node) (node)
 
+/* Cross-node load balancing interval. */
+#define NODE_BALANCE_RATE 10
+
 #endif /* _ASM_IA64_TOPOLOGY_H */
diff -urpN -X /home/fletch/.diff.exclude numasched2/include/asm-ppc64/topology.h numasched3/include/asm-ppc64/topology.h
--- numasched2/include/asm-ppc64/topology.h	Thu Jan  9 19:16:12 2003
+++ numasched3/include/asm-ppc64/topology.h	Wed Jan 15 19:26:01 2003
@@ -46,6 +46,9 @@ static inline unsigned long __node_to_cp
 	return mask;
 }
 
+/* Cross-node load balancing interval. */
+#define NODE_BALANCE_RATE 10
+
 #else /* !CONFIG_NUMA */
 
 #define __cpu_to_node(cpu)		(0)
diff -urpN -X /home/fletch/.diff.exclude numasched2/kernel/sched.c numasched3/kernel/sched.c
--- numasched2/kernel/sched.c	Wed Jan 15 19:56:42 2003
+++ numasched3/kernel/sched.c	Wed Jan 15 20:01:12 2003
@@ -67,6 +67,7 @@
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(2*HZ)
 #define STARVATION_LIMIT	(2*HZ)
+#define NODE_THRESHOLD          125
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -155,6 +156,8 @@ struct runqueue {
 	int prev_nr_running[NR_CPUS];
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
+	unsigned int nr_balanced;
+	int prev_node_load[MAX_NUMNODES];
 #endif
 	task_t *migration_thread;
 	struct list_head migration_queue;
@@ -735,14 +738,52 @@ void sched_balance_exec(void)
 	}
 }
 
-static inline unsigned long cpus_to_balance(int this_cpu)
+/*
+ * Find the busiest node. All previous node loads contribute with a 
+ * geometrically deccaying weight to the load measure:
+ *      load_{t} = load_{t-1}/2 + nr_node_running_{t}
+ * This way sudden load peaks are flattened out a bit.
+ */
+static int find_busiest_node(int this_node)
+{
+	int i, node = -1, load, this_load, maxload;
+	
+	this_load = maxload = (this_rq()->prev_node_load[this_node] >> 1)
+		+ atomic_read(&node_nr_running[this_node]);
+	this_rq()->prev_node_load[this_node] = this_load;
+	for (i = 0; i < numnodes; i++) {
+		if (i == this_node)
+			continue;
+		load = (this_rq()->prev_node_load[i] >> 1)
+			+ atomic_read(&node_nr_running[i]);
+		this_rq()->prev_node_load[i] = load;
+		if (load > maxload && (100*load > NODE_THRESHOLD*this_load)) {
+			maxload = load;
+			node = i;
+		}
+	}
+	return node;
+}
+
+static inline unsigned long cpus_to_balance(int this_cpu, runqueue_t *this_rq)
 {
-	return __node_to_cpu_mask(__cpu_to_node(this_cpu));
+	int this_node = __cpu_to_node(this_cpu);
+	/*
+	 * Avoid rebalancing between nodes too often.
+	 * We rebalance globally once every NODE_BALANCE_RATE load balances.
+	 */
+	if (++(this_rq->nr_balanced) == NODE_BALANCE_RATE) {
+		int node = find_busiest_node(this_node);
+		this_rq->nr_balanced = 0;
+		if (node >= 0)
+			return (__node_to_cpu_mask(node) | (1UL << this_cpu));
+	}
+	return __node_to_cpu_mask(this_node);
 }
 
 #else /* !CONFIG_NUMA */
 
-static inline unsigned long cpus_to_balance(int this_cpu)
+static inline unsigned long cpus_to_balance(int this_cpu, runqueue_t *this_rq)
 {
 	return cpu_online_map;
 }
@@ -890,7 +931,7 @@ static void load_balance(runqueue_t *thi
 	task_t *tmp;
 
 	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance,
-					cpus_to_balance(this_cpu));
+					cpus_to_balance(this_cpu, this_rq));
 	if (!busiest)
 		goto out;
 

