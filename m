Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265993AbUGZTfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUGZTfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 15:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUGZTfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 15:35:17 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:53389 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266048AbUGZSNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 14:13:02 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] consolidate sched domains
Date: Mon, 26 Jul 2004 11:06:33 -0700
User-Agent: KMail/1.6.2
Cc: Dimitri Sivanich <sivanich@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       John Hawkes <hawkes@sgi.com>
References: <41008386.9060009@yahoo.com.au> <20040726022202.GA21602@sgi.com> <41048324.8070302@yahoo.com.au>
In-Reply-To: <41048324.8070302@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pgUBBhRPKQPAIqu"
Message-Id: <200407261106.33173.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_pgUBBhRPKQPAIqu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday, July 25, 2004 9:05 pm, Nick Piggin wrote:
> Yes of course, thank you.
>
> The fix is for cpu_to_phys_group() to just return cpu when
> !CONFIG_SCHED_SMT.

Here's the node domain span stuff on top of your consolidation patch, along 
with the two fixes mentioned in this thread.  It compiles and works fine on 
my small box, but I haven't tested it on a large box yet.

Jesse

--Boundary-00=_pgUBBhRPKQPAIqu
Content-Type: text/plain;
  charset="iso-8859-1";
  name="sched-domain-node-span-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sched-domain-node-span-3.patch"

diff -Napur -X /home/jbarnes/dontdiff linux-2.5-cons/kernel/sched.c linux-2.5-nodedomains/kernel/sched.c
--- linux-2.5-cons/kernel/sched.c	2004-07-26 11:07:18.000000000 -0700
+++ linux-2.5-nodedomains/kernel/sched.c	2004-07-26 11:00:40.000000000 -0700
@@ -3708,17 +3708,88 @@ static DEFINE_PER_CPU(struct sched_domai
 static struct sched_group sched_group_phys[NR_CPUS];
 __init static int cpu_to_phys_group(int cpu)
 {
+#ifdef CONFIG_SCHED_SMT
 	return first_cpu(cpu_sibling_map[cpu]);
+#else
+	return cpu;
+#endif
 }
 
 #ifdef CONFIG_NUMA
+
+/* Number of nearby nodes in a node's scheduling domain */
+#define SD_NODES_PER_DOMAIN 4
+
 static DEFINE_PER_CPU(struct sched_domain, node_domains);
 static struct sched_group sched_group_nodes[MAX_NUMNODES];
 __init static int cpu_to_node_group(int cpu)
 {
 	return cpu_to_node(cpu);
 }
-#endif
+
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
+static cpumask_t __init sched_domain_node_span(int node, int size)
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
+#endif /* CONFIG_NUMA */
 
 /*
  * init_sched_build_groups takes an array of groups, the cpumask we wish
@@ -3765,7 +3836,7 @@ __init static void init_sched_build_grou
 	last->next = first;
 }
 
-__init static void arch_init_sched_domains(void)
+static void __init arch_init_sched_domains(void)
 {
 	int i;
 
@@ -3779,7 +3850,8 @@ __init static void arch_init_sched_domai
 		sd = &per_cpu(node_domains, i);
 		group = cpu_to_node_group(i);
 		*sd = SD_NODE_INIT;
-		sd->span = cpu_possible_map;
+		/* FIXME: should be multilevel, in arch code */
+		sd->span = sched_domain_node_span(i, SD_NODES_PER_DOMAIN);
 		sd->groups = &sched_group_nodes[group];
 #endif
 
@@ -3847,6 +3919,8 @@ __init static void arch_init_sched_domai
 		sd->groups->cpu_power = power;
 
 #ifdef CONFIG_NUMA
+		if (i != first_cpu(sd->groups->cpumask))
+			continue;
 		sd = &per_cpu(node_domains, i);
 		sd->groups->cpu_power += power;
 #endif

--Boundary-00=_pgUBBhRPKQPAIqu--
