Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbUC2MW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbUC2MWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:22:49 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:46008 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262864AbUC2MPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:15:31 -0500
Date: Mon, 29 Mar 2004 04:14:34 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT: core kernel changes from Matthew's nodemask_t
 Patch 2/7 [11/22]
Message-Id: <20040329041434.1b5d7cb4.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_11_of_22 - Matthew Dobson's [PATCH] nodemask_t core changes [2/7]
	nodemask_t-02-core.patch - Changes to arch-independent code.
	Surprisingly few references to numnodes, open-coded node loops,
	etc. in generic code.  Most important result of this patch is
	that no generic code assumes anything about node numbering.
	This allows individual arches to use sparse numbering if they
	care to.

diffstat Patch_11_of_22:
 Documentation/vm/numa    |    2 +-
 include/linux/gfp.h      |    2 +-
 include/linux/topology.h |   19 ++++++++++++-------
 kernel/sched.c           |    2 +-
 mm/page_alloc.c          |   16 ++++++++++------
 5 files changed, 25 insertions(+), 16 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1716  -> 1.1717 
#	     mm/page_alloc.c	1.190   -> 1.191  
#	 include/linux/gfp.h	1.16    -> 1.17   
#	Documentation/vm/numa	1.1     -> 1.2    
#	include/linux/topology.h	1.3     -> 1.4    
#	      kernel/sched.c	1.247   -> 1.248  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/28	pj@sgi.com	1.1717
# Matthew Dobson's [PATCH] nodemask_t core changes [2/7] of 18 Mar 2004:
#   nodemask_t-02-core.patch - Changes to arch-independent code.
#   Surprisingly few references to numnodes, open-coded node loops, etc. in
#   generic code.  Most important result of this patch is that no generic
#   code assumes anything about node numbering.  This allows individual
#   arches to use sparse numbering if they care to.
# --------------------------------------------
#
diff -Nru a/Documentation/vm/numa b/Documentation/vm/numa
--- a/Documentation/vm/numa	Mon Mar 29 01:03:46 2004
+++ b/Documentation/vm/numa	Mon Mar 29 01:03:46 2004
@@ -29,7 +29,7 @@
 into a pg_data_t. The bootmem_data_t is just one part of this. To 
 make the code look uniform between NUMA and regular UMA platforms, 
 UMA platforms have a statically allocated pg_data_t too (contig_page_data).
-For the sake of uniformity, the variable "numnodes" is also defined
+For the sake of uniformity, the variable "node_online_map" is also defined
 for all platforms. As we run benchmarks, we might decide to NUMAize 
 more variables like low_on_memory, nr_free_pages etc into the pg_data_t.
 
diff -Nru a/include/linux/gfp.h b/include/linux/gfp.h
--- a/include/linux/gfp.h	Mon Mar 29 01:03:46 2004
+++ b/include/linux/gfp.h	Mon Mar 29 01:03:46 2004
@@ -58,7 +58,7 @@
 
 /*
  * We get the zone list from the current node and the gfp_mask.
- * This zone list contains a maximum of MAXNODES*MAX_NR_ZONES zones.
+ * This zone list contains a maximum of MAX_NUMNODES*MAX_NR_ZONES zones.
  *
  * For the normal case of non-DISCONTIGMEM systems the NODE_DATA() gets
  * optimized to &contig_page_data at compile-time.
diff -Nru a/include/linux/topology.h b/include/linux/topology.h
--- a/include/linux/topology.h	Mon Mar 29 01:03:46 2004
+++ b/include/linux/topology.h	Mon Mar 29 01:03:46 2004
@@ -43,15 +43,20 @@
 	})
 #endif
 
-static inline int __next_node_with_cpus(int node)
+static inline int __next_node_with_cpus(int last_node)
 {
-	do
-		++node;
-	while (node < numnodes && !nr_cpus_node(node));
-	return node;
+	int nid;
+	for_each_online_node(nid)
+		if (nr_cpus_node(nid) && nid > last_node)
+			return nid;
+
+	return MAX_NUMNODES;
 }
 
-#define for_each_node_with_cpus(node) \
-	for (node = 0; node < numnodes; node = __next_node_with_cpus(node))
+/* Assumes first_node(node_online_map) will have CPUs */
+#define for_each_node_with_cpus(node)			\
+	for(node = first_node(node_online_map);		\
+		node < MAX_NUMNODES;			\
+		node = __next_node_with_cpus(node))
 
 #endif /* _LINUX_TOPOLOGY_H */
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Mon Mar 29 01:03:46 2004
+++ b/kernel/sched.c	Mon Mar 29 01:03:46 2004
@@ -1088,7 +1088,7 @@
 {
 	int new_cpu;
 
-	if (numnodes > 1) {
+	if (num_online_nodes() > 1) {
 		new_cpu = sched_best_cpu(current);
 		if (new_cpu != smp_processor_id())
 			sched_migrate_task(current, new_cpu);
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Mon Mar 29 01:03:46 2004
+++ b/mm/page_alloc.c	Mon Mar 29 01:03:46 2004
@@ -34,12 +34,12 @@
 
 #include <asm/tlbflush.h>
 
-DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
+nodemask_t node_online_map = NODE_MASK_NONE;
+nodemask_t node_possible_map = NODE_MASK_ALL;
 struct pglist_data *pgdat_list;
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
 int nr_swap_pages;
-int numnodes = 1;
 int sysctl_lower_zone_protection = 0;
 
 EXPORT_SYMBOL(totalram_pages);
@@ -1115,9 +1115,13 @@
  		 * zones coming right after the local ones are those from
  		 * node N+1 (modulo N)
  		 */
- 		for (node = local_node + 1; node < numnodes; node++)
+ 		for (node = next_node(local_node, node_online_map);
+		     node < MAX_NUMNODES;
+		     node = next_node(node, node_online_map))
  			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
- 		for (node = 0; node < local_node; node++)
+ 		for (node = first_node(node_online_map);
+		     node < local_node;
+		     node = next_node(node, node_online_map))
  			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
  
 		zonelist->zones[j++] = NULL;
@@ -1128,9 +1132,9 @@
 {
 	int i;
 
-	for(i = 0 ; i < numnodes ; i++)
+	for_each_online_node(i)
 		build_zonelists(NODE_DATA(i));
-	printk("Built %i zonelists\n", numnodes);
+	printk("Built %i zonelists\n", num_online_nodes());
 }
 
 /*


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
