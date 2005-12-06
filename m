Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVLFS24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVLFS24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVLFS24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:28:56 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45740 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932437AbVLFS24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:28:56 -0500
Date: Tue, 6 Dec 2005 10:28:43 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 1/3] Framework for accurate node based statistics
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC] Framework for accurate node based statistics

Currently we have various vm counters that are split per cpu. This arrangement
does not allow access to per node statistics that are important to optimize
VM behavior for NUMA architectures. All one can say from the per_cpu
differential variables is how much a certain variable was changed by this cpu
without being able to deduce how many pages in each node are of a certain type.

This patch introduces a generic framework to allow accurate per node vm
statistics through a large per node and per cpu array. The numbers are
consolidated when the slab drainer runs (every 3 seconds or so) into global
and per node counters. VM functions can then check these statistics by
simply accessing the node specific or global counter.

A significant problem with this approach is that the statistics are only
accumulated every 3 seconds or so. I have tried various other approaches
but they typically end up with having to add atomic variables to critical
VM paths. I'd be glad if someone else had a bright idea on how to improve
the situation.

There are two patches following that convert two important counters to
work per node but there may be many more that may be useful in the future.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc3/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc3.orig/mm/page_alloc.c	2005-11-28 19:51:27.000000000 -0800
+++ linux-2.6.15-rc3/mm/page_alloc.c	2005-12-01 00:38:05.000000000 -0800
@@ -557,6 +557,33 @@ static int rmqueue_bulk(struct zone *zon
 }
 
 #ifdef CONFIG_NUMA
+static spinlock_t node_stat_lock;
+unsigned long vm_stat_global[NR_STAT_ITEMS];
+unsigned long vm_stat_node[MAX_NUMNODES][NR_STAT_ITEMS];
+int vm_stat_diff[NR_CPUS][MAX_NUMNODES][NR_STAT_ITEMS];
+
+void refresh_vm_stats(void) {
+	int cpu;
+	int node;
+	int i;
+
+	spin_lock(&node_stat_lock);
+
+	cpu = get_cpu();
+	for_each_online_node(node)
+		for(i = 0; i < NR_STAT_ITEMS; i++) {
+			int * p = vm_stat_diff[cpu][node]+i;
+			if (*p) {
+				vm_stat_node[node][i] += *p;
+				vm_stat_global[i] += *p;
+				*p = 0;
+			}
+		}
+	put_cpu();
+
+	spin_unlock(&node_stat_lock);
+}
+
 /* Called from the slab reaper to drain remote pagesets */
 void drain_remote_pages(void)
 {
Index: linux-2.6.15-rc3/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc3.orig/include/linux/page-flags.h	2005-11-28 19:51:27.000000000 -0800
+++ linux-2.6.15-rc3/include/linux/page-flags.h	2005-12-01 00:35:38.000000000 -0800
@@ -163,6 +163,27 @@ extern void __mod_page_state(unsigned lo
 	} while (0)
 
 /*
+ * Node based accounting with per cpu differentials.
+ */
+enum node_stat_item { };
+#define NR_STAT_ITEMS 0
+
+extern unsigned long vm_stat_global[NR_STAT_ITEMS];
+extern unsigned long vm_stat_node[MAX_NUMNODES][NR_STAT_ITEMS];
+extern int vm_stat_diff[NR_CPUS][MAX_NUMNODES][NR_STAT_ITEMS];
+
+static inline void mod_node_page_state(int node, enum node_stat_item item, int delta)
+{
+	vm_stat_diff[get_cpu()][node][item] += delta;
+	put_cpu();
+}
+
+#define inc_node_page_state(node, item) mod_node_page_state(node, item, 1)
+#define dec_node_page_state(node, item) mod_node_page_state(node, item, -1)
+#define add_node_page_state(node, item) mod_node_page_state(node, item, delta)
+#define sub_node_page_state(node, item) mod_node_page_state(node, item, -(delta))
+
+/*
  * Manipulation of page state flags
  */
 #define PageLocked(page)		\
Index: linux-2.6.15-rc3/include/linux/gfp.h
===================================================================
--- linux-2.6.15-rc3.orig/include/linux/gfp.h	2005-11-28 19:51:27.000000000 -0800
+++ linux-2.6.15-rc3/include/linux/gfp.h	2005-12-01 00:34:02.000000000 -0800
@@ -153,8 +153,10 @@ extern void FASTCALL(free_cold_page(stru
 void page_alloc_init(void);
 #ifdef CONFIG_NUMA
 void drain_remote_pages(void);
+void refresh_vm_stats(void);
 #else
 static inline void drain_remote_pages(void) { };
+static inline void refresh_vm_stats(void) { }
 #endif
 
 #endif /* __LINUX_GFP_H */
Index: linux-2.6.15-rc3/mm/slab.c
===================================================================
--- linux-2.6.15-rc3.orig/mm/slab.c	2005-11-28 19:51:27.000000000 -0800
+++ linux-2.6.15-rc3/mm/slab.c	2005-12-01 00:34:02.000000000 -0800
@@ -3359,6 +3359,7 @@ next:
 	check_irq_on();
 	up(&cache_chain_sem);
 	drain_remote_pages();
+	refresh_vm_stats();
 	/* Setup the next iteration */
 	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC);
 }
