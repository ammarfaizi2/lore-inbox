Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268435AbUHQU7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268435AbUHQU7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268432AbUHQU7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:59:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50349 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268436AbUHQU6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:58:09 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] add scheduler domains for ia64
Date: Tue, 17 Aug 2004 16:57:32 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>, Ingo Molnar <mingo@elte.hu>
References: <200408131108.40502.jbarnes@engr.sgi.com> <200408141352.01486.jbarnes@engr.sgi.com> <411EB463.5090809@yahoo.com.au>
In-Reply-To: <411EB463.5090809@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8EnIBhHkp32SfzF"
Message-Id: <200408171657.32357.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_8EnIBhHkp32SfzF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday, August 14, 2004 8:54 pm, Nick Piggin wrote:
> Yeah, all the SD_*_INIT values are overridable. We could even say, put
> in an SD_NODE2_INIT for a 2nd level NUMA domain in the generic code,
> for example.

Yeah, we'll need different values for each level in the hierarchy.

> I'd say your closest-node setup would probably get close to what you want.
> The main thing you want is to not do huge amounts of balancing work in
> interrupt context, and also not to move a task from one side of the
> system to the other when one node is a little bit out of balance.
>
> I guess if you want to do anything fancier then we can take a look at
> re-exporting the domain setup.

Ok, sounds good.  How does this look?  It sits on top of 2.6.8.1-mm1, ripping 
out the ia64 specific bits and moving things to sched.c.  I've also added an 
ia64 specific SD_NODE_INIT and an #if !defined to sched.c

Jesse

--Boundary-00=_8EnIBhHkp32SfzF
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

--Boundary-00=_8EnIBhHkp32SfzF--
