Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266284AbUGWUFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266284AbUGWUFd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 16:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUGWUFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 16:05:33 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:60108 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266284AbUGWUDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 16:03:45 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Dimitri Sivanich <sivanich@sgi.com>, linux-kernel@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC] Patch for isolated scheduler domains
Date: Fri, 23 Jul 2004 16:03:09 -0400
User-Agent: KMail/1.6.2
References: <20040722164126.GB13189@sgi.com>
In-Reply-To: <20040722164126.GB13189@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_97WABeS4ccHQUIX"
Message-Id: <200407231603.09055.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_97WABeS4ccHQUIX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday, July 22, 2004 12:41 pm, Dimitri Sivanich wrote:
> I'm interested in implementing something I'll call isolated sched domains
> for single cpus (to minimize the latencies involved when doing things like
> load balancing on certain select cpus) on IA64.

And here's what I had in mind for restricting the CPU span of a given node's 
domain.  I haven't even compiled it though, so it probably won't work.  I'm 
just posting it for comments.

I think the code can be reused for a hierarchical system too, by simply 
looping in sched_domain_node_span with a few different values of SD_MAX_NODE.

Any thoughts?

Thanks,
Jesse

--Boundary-00=_97WABeS4ccHQUIX
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sched-domain-node-span.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sched-domain-node-span.patch"

===== kernel/sched.c 1.224 vs edited =====
--- 1.224/kernel/sched.c	2004-07-12 18:32:52 -04:00
+++ edited/kernel/sched.c	2004-07-23 15:31:40 -04:00
@@ -3699,26 +3699,97 @@
 #ifdef CONFIG_NUMA
 static struct sched_group sched_group_nodes[MAX_NUMNODES];
 static DEFINE_PER_CPU(struct sched_domain, node_domains);
+
+#define SD_CPUS_PER_NODE 64
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
+	int i, n, val, min_val, best_node;
+
+	min_val = INT_MAX;
+
+	for (i = 0; i < numnodes; i++) {
+		/* Start at @node */
+		n = (node + i) % numnodes;
+
+		/* Skip already used nodes */
+		if (test_bit(used_nodes, n))
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
+	set_bit(used_nodes, best_node);
+	return best_node;
+}
+
+/**
+ * sched_domain_node_span - get a cpumask for a node's sched_domain
+ * @node: node whose cpumask we're constructing
+ *
+ * Given a node, construct a good cpumask for its sched_domain to span.  It
+ * should be one that prevents unnecessary balancing, but also spreads tasks
+ * out optimally.
+ *
+ * Note that this *should* be heirarchical rather than flat, i.e. the
+ * domain above single CPUs should only span nodes or physical chassis, and
+ * a domain above that should contain a larger number of CPUs, though
+ * probably not all of the available ones.
+ */
+static cpumask_t __init sched_domain_node_span(int node)
+{
+	cpumask_t span;
+	DECLARE_BITMAP(used_nodes, MAX_NUMNODES);
+
+	cpu_clear(span);
+	bitmap_zero(used_nodes, MAX_NUMNODES);
+
+	for (i = 0; i < SD_MAX_NODES; i++) {
+		int next_node = find_next_best_node(node, used_nodes);
+		cpu_set(span, node_to_cpumask(next_node));
+	}
+	return span;
+}
+
 static void __init arch_init_sched_domains(void)
 {
 	int i;
 	struct sched_group *first_node = NULL, *last_node = NULL;
 
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		struct sched_domain *node_sd = &per_cpu(node_domains, i);
+
+		*node_sd = SD_NODE_INIT;
+		node_sd->span = sched_domain_node_span(i);
+		node_sd->groups = &sched_group_nodes[cpu_to_node(i)];
+	}
+
 	/* Set up domains */
 	for_each_cpu(i) {
 		int node = cpu_to_node(i);
 		cpumask_t nodemask = node_to_cpumask(node);
-		struct sched_domain *node_sd = &per_cpu(node_domains, i);
 		struct sched_domain *cpu_sd = &per_cpu(cpu_domains, i);
 
-		*node_sd = SD_NODE_INIT;
-		node_sd->span = cpu_possible_map;
-		node_sd->groups = &sched_group_nodes[cpu_to_node(i)];
-
 		*cpu_sd = SD_CPU_INIT;
 		cpus_and(cpu_sd->span, nodemask, cpu_possible_map);
 		cpu_sd->groups = &sched_group_cpus[i];
-		cpu_sd->parent = node_sd;
+		cpu_sd->parent = &per_cpu(node_domains, i);
 	}
 
 	/* Set up groups */

--Boundary-00=_97WABeS4ccHQUIX--
