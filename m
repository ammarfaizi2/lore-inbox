Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUHTCYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUHTCYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 22:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUHTCYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 22:24:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7567 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266003AbUHTCXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 22:23:42 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org
Subject: Re: [PATCH] add scheduler domains for ia64
Date: Thu, 19 Aug 2004 22:22:35 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>, Ingo Molnar <mingo@elte.hu>
References: <200408131108.40502.jbarnes@engr.sgi.com> <200408171657.32357.jbarnes@engr.sgi.com> <41255DBA.3030909@yahoo.com.au>
In-Reply-To: <41255DBA.3030909@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rBWJBvEaxld3nqJ"
Message-Id: <200408192222.35512.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_rBWJBvEaxld3nqJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday, August 19, 2004 10:11 pm, Nick Piggin wrote:
> Sorry I haven't replied earlier.  I think this looks good, provided
> it does the right thing for you (I can't test it myself). Send it to
> Andrew to get merged if you'd like.

Yep, it's been working ok so far.  There's still more we can do, but this is a 
good start I think.  Andrew, this version applies on top of 2.6.8.1-mm2 but 
overwrites most of the earlier node-span patch by moving bits from arch/ia64 
to kernel/sched.c, so let me know if you want the patch in a different 
format.

This patch adds some more NUMA specific logic to the creation of scheduler 
domains.  Domains spanning all CPUs in a large system are too large to 
schedule across efficiently, leading to livelocks and inordinate amounts of 
time being spent in scheduler routines.  With this patch applied, the node 
scheduling domains for NUMA platforms will only contain a specified number of 
nearby CPUs, based on the value of SD_NODES_PER_DOMAIN.  It also allows 
arches to override SD_NODE_INIT, which sets the domain scheduling parameters 
for each node's domain.  This is necessary especially for large systems.

Possible future directions:
  o multilevel node hierarchy (e.g. node domains could contain 4 nodes worth 
of CPUs, supernode domains could contain 32 nodes worth, etc. each with their 
own SD_NODE_INIT values)
  o more tweaking of SD_NODE_INIT values for good load balancing vs. overhead 
tradeoffs

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_rBWJBvEaxld3nqJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="node-span.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="node-span.patch"

diff -Napur -X /home/jbarnes/dontdiff linux-2.6.8.1-mm1/arch/ia64/kernel/smpboot.c linux-2.6.8.1-mm1.nodespan/arch/ia64/kernel/smpboot.c
--- linux-2.6.8.1-mm1/arch/ia64/kernel/smpboot.c	2004-08-17 13:41:43.000000000 -0700
+++ linux-2.6.8.1-mm1.nodespan/arch/ia64/kernel/smpboot.c	2004-08-17 13:34:28.000000000 -0700
@@ -707,69 +707,3 @@ init_smp_config(void)
 		       ia64_sal_strerror(sal_ret));
 }
 
-#ifdef CONFIG_NUMA
-
-/**
- * find_next_best_node - find the next node to include in a sched_domain
- * @node: node whose sched_domain we're building
- * @used_nodes: nodes already in the sched_domain
- *
- * Find the next node to include in a given scheduling domain.  Simply
- * finds the closest node not already in the @used_nodes map.
- *
- * Should use nodemask_t.
- */
-static int __init find_next_best_node(int node, unsigned long *used_nodes)
-{
-	int i, n, val, min_val, best_node = 0;
-
-	min_val = INT_MAX;
-
-	for (i = 0; i < numnodes; i++) {
-		/* Start at @node */
-		n = (node + i) % numnodes;
-
-		/* Skip already used nodes */
-		if (test_bit(n, used_nodes))
-			continue;
-
-		/* Simple min distance search */
-		val = node_distance(node, i);
-
-		if (val < min_val) {
-			min_val = val;
-			best_node = n;
-		}
-	}
-
-	set_bit(best_node, used_nodes);
-	return best_node;
-}
-
-/**
- * sched_domain_node_span - get a cpumask for a node's sched_domain
- * @node: node whose cpumask we're constructing
- * @size: number of nodes to include in this span
- *
- * Given a node, construct a good cpumask for its sched_domain to span.  It
- * should be one that prevents unnecessary balancing, but also spreads tasks
- * out optimally.
- */
-cpumask_t __init sched_domain_node_span(int node, int size)
-{
-	int i;
-	cpumask_t span;
-	DECLARE_BITMAP(used_nodes, MAX_NUMNODES);
-
-	cpus_clear(span);
-	bitmap_zero(used_nodes, MAX_NUMNODES);
-
-	for (i = 0; i < size; i++) {
-		int next_node = find_next_best_node(node, used_nodes);
-		cpus_or(span, span, node_to_cpumask(next_node));
-	}
-
-	return span;
-}
-#endif /* CONFIG_NUMA */
-
diff -Napur -X /home/jbarnes/dontdiff linux-2.6.8.1-mm1/include/asm-ia64/processor.h linux-2.6.8.1-mm1.nodespan/include/asm-ia64/processor.h
--- linux-2.6.8.1-mm1/include/asm-ia64/processor.h	2004-08-17 13:41:22.000000000 -0700
+++ linux-2.6.8.1-mm1.nodespan/include/asm-ia64/processor.h	2004-08-17 13:37:13.000000000 -0700
@@ -335,8 +335,23 @@ struct task_struct;
 #define prepare_to_copy(tsk)	do { } while (0)
 
 #ifdef CONFIG_NUMA
-/* smpboot.c defines a numa specific scheduler domain routine */
-#define ARCH_HAS_SCHED_DOMAIN
+#define SD_NODE_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 80,			\
+	.max_interval		= 320,			\
+	.busy_factor		= 320,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (10*1000000),		\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_BALANCE_EXEC	\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 10,			\
+	.nr_balance_failed	= 0,			\
+}
 #endif
 
 /*
diff -Napur -X /home/jbarnes/dontdiff linux-2.6.8.1-mm1/kernel/sched.c linux-2.6.8.1-mm1.nodespan/kernel/sched.c
--- linux-2.6.8.1-mm1/kernel/sched.c	2004-08-17 13:41:37.000000000 -0700
+++ linux-2.6.8.1-mm1.nodespan/kernel/sched.c	2004-08-17 13:43:36.000000000 -0700
@@ -401,7 +401,8 @@ struct sched_domain {
 	.nr_balance_failed	= 0,			\
 }
 
-#ifdef CONFIG_NUMA
+/* Arch can override this macro in processor.h */
+#if defined(CONFIG_NUMA) && !defined(SD_NODE_INIT)
 /* Common values for NUMA nodes */
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
@@ -2218,10 +2219,8 @@ static void active_load_balance(runqueue
 	for_each_domain(busiest_cpu, sd)
 		if (cpu_isset(busiest->push_cpu, sd->span))
 			break;
-	if (!sd) {
-		WARN_ON(1);
+	if (!sd)
 		return;
-	}
 
 	group = sd->groups;
 	while (!cpu_isset(busiest_cpu, group->cpumask))
@@ -4121,15 +4120,74 @@ static void cpu_attach_domain(struct sch
 }
 
 #ifdef CONFIG_NUMA
-#ifdef ARCH_HAS_SCHED_DOMAIN
-extern cpumask_t __init sched_domain_node_span(int node, int size);
-#else
+/**
+ * find_next_best_node - find the next node to include in a sched_domain
+ * @node: node whose sched_domain we're building
+ * @used_nodes: nodes already in the sched_domain
+ *
+ * Find the next node to include in a given scheduling domain.  Simply
+ * finds the closest node not already in the @used_nodes map.
+ *
+ * Should use nodemask_t.
+ */
+static int __init find_next_best_node(int node, unsigned long *used_nodes)
+{
+	int i, n, val, min_val, best_node = 0;
+
+	min_val = INT_MAX;
+
+	for (i = 0; i < numnodes; i++) {
+		/* Start at @node */
+		n = (node + i) % numnodes;
+
+		/* Skip already used nodes */
+		if (test_bit(n, used_nodes))
+			continue;
+
+		/* Simple min distance search */
+		val = node_distance(node, i);
+
+		if (val < min_val) {
+			min_val = val;
+			best_node = n;
+		}
+	}
+
+	set_bit(best_node, used_nodes);
+	return best_node;
+}
+
+/**
+ * sched_domain_node_span - get a cpumask for a node's sched_domain
+ * @node: node whose cpumask we're constructing
+ * @size: number of nodes to include in this span
+ *
+ * Given a node, construct a good cpumask for its sched_domain to span.  It
+ * should be one that prevents unnecessary balancing, but also spreads tasks
+ * out optimally.
+ */
+cpumask_t __init sched_domain_node_span(int node, int size)
+{
+	int i;
+	cpumask_t span;
+	DECLARE_BITMAP(used_nodes, MAX_NUMNODES);
+
+	cpus_clear(span);
+	bitmap_zero(used_nodes, MAX_NUMNODES);
+
+	for (i = 0; i < size; i++) {
+		int next_node = find_next_best_node(node, used_nodes);
+		cpus_or(span, span, node_to_cpumask(next_node));
+	}
+
+	return span;
+}
+#else /* !CONFIG_NUMA */
 static cpumask_t __init sched_domain_node_span(int node, int size)
 {
 	return cpu_possible_map;
 }
-#endif /* ARCH_HAS_SCHED_DOMAIN */
-#endif
+#endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_SCHED_SMT
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);

--Boundary-00=_rBWJBvEaxld3nqJ--
