Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266450AbUG0QWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266450AbUG0QWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUG0QWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:22:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:21167 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266458AbUG0QWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:22:10 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] consolidate sched domains
Date: Tue, 27 Jul 2004 09:15:40 -0700
User-Agent: KMail/1.6.2
Cc: Dimitri Sivanich <sivanich@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       John Hawkes <hawkes@sgi.com>
References: <41008386.9060009@yahoo.com.au> <200407261106.33173.jbarnes@engr.sgi.com> <4105CBD9.7080209@yahoo.com.au>
In-Reply-To: <4105CBD9.7080209@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_s+nBBl5N9gyU+ju"
Message-Id: <200407270915.40600.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_s+nBBl5N9gyU+ju
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday, July 26, 2004 8:28 pm, Nick Piggin wrote:
> You'll also want Jack Steiner's one liner. (I've sent all these to Andrew.)

Including the consolidation patch?

> Looks pretty neat. It may even be usable in the generic setup code if more
> architectures start needing it.
>
> For now, put it in your arch code when it is ready to be merged up of
> course.
> I would be very interested to see what sort of performance improvements you
> get out of the scheduler...

Ok, this new patch has no effect on platforms that don't define 
ARCH_HAS_SCHED_DOMAIN, but changes the arch specific callback.  I didn't want 
to duplicate all the code you just ripped out, but if you think that's best I 
can...

Thanks,
Jesse

--Boundary-00=_s+nBBl5N9gyU+ju
Content-Type: text/plain;
  charset="iso-8859-1";
  name="sched-domain-node-span-4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sched-domain-node-span-4.patch"

===== arch/ia64/kernel/smpboot.c 1.55 vs edited =====
--- 1.55/arch/ia64/kernel/smpboot.c	2004-06-04 02:21:54 -07:00
+++ edited/arch/ia64/kernel/smpboot.c	2004-07-27 09:09:42 -07:00
@@ -719,3 +719,70 @@
 		printk(KERN_ERR "SMP: Can't set SAL AP Boot Rendezvous: %s\n",
 		       ia64_sal_strerror(sal_ret));
 }
+
+#ifdef CONFIG_NUMA
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
+#endif /* CONFIG_NUMA */
+
===== include/asm-ia64/processor.h 1.60 vs edited =====
--- 1.60/include/asm-ia64/processor.h	2004-06-04 18:14:13 -07:00
+++ edited/include/asm-ia64/processor.h	2004-07-27 09:07:15 -07:00
@@ -335,6 +335,11 @@
 /* Prepare to copy thread state - unlazy all lazy status */
 #define prepare_to_copy(tsk)	do { } while (0)
 
+#ifdef CONFIG_NUMA
+/* smpboot.c defines a numa specific scheduler domain routine */
+#define ARCH_HAS_SCHED_DOMAIN
+#endif
+
 /*
  * This is the mechanism for creating a new kernel thread.
  *
===== kernel/sched.c 1.318 vs edited =====
--- 1.318/kernel/sched.c	2004-07-27 08:55:58 -07:00
+++ edited/kernel/sched.c	2004-07-27 09:10:22 -07:00
@@ -3692,8 +3692,13 @@
 }
 
 #ifdef ARCH_HAS_SCHED_DOMAIN
-extern void __init arch_init_sched_domains(void);
+extern cpumask_t __init sched_domain_node_span(int node, int size);
 #else
+static cpumask_t __init sched_domain_node_span(int node, int size)
+{
+	return cpu_possible_map;
+}
+#endif /* ARCH_HAS_SCHED_DOMAIN */
 
 #ifdef CONFIG_SCHED_SMT
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
@@ -3708,10 +3713,18 @@
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
@@ -3779,7 +3792,8 @@
 		sd = &per_cpu(node_domains, i);
 		group = cpu_to_node_group(i);
 		*sd = SD_NODE_INIT;
-		sd->span = cpu_possible_map;
+		/* FIXME: should be multilevel, in arch code */
+		sd->span = sched_domain_node_span(i, SD_NODES_PER_DOMAIN);
 		sd->groups = &sched_group_nodes[group];
 #endif
 
@@ -3847,6 +3861,8 @@
 		sd->groups->cpu_power = power;
 
 #ifdef CONFIG_NUMA
+		if (i != first_cpu(sd->groups->cpumask))
+			continue;
 		sd = &per_cpu(node_domains, i);
 		sd->groups->cpu_power += power;
 #endif
@@ -3863,7 +3879,6 @@
 		cpu_attach_domain(sd, i);
 	}
 }
-#endif /* ARCH_HAS_SCHED_DOMAIN */
 
 #define SCHED_DOMAIN_DEBUG
 #ifdef SCHED_DOMAIN_DEBUG

--Boundary-00=_s+nBBl5N9gyU+ju--
