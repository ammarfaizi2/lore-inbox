Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbUCRXIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbUCRXG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:06:58 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:46298 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263192AbUCRXFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:05:18 -0500
Subject: [PATCH] nodemask_t core changes [2/7]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com
Content-Type: multipart/mixed; boundary="=-0BgpYIj06iaKNUkJLCPM"
Organization: IBM LTC
Message-Id: <1079651074.8149.169.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 15:04:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0BgpYIj06iaKNUkJLCPM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

nodemask_t-02-core.patch - Changes to arch-independent code. 
Surprisingly few references to numnodes, open-coded node loops, etc. in
generic code.  Most important result of this patch is that no generic
code assumes anything about node numbering.  This allows individual
arches to use sparse numbering if they care to.

--=-0BgpYIj06iaKNUkJLCPM
Content-Disposition: attachment; filename=nodemask_t-02-core.patch
Content-Type: text/x-patch; name=nodemask_t-02-core.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/Documentation/vm/numa linux-2.6.4-nodemask_t-core/Documentation/vm/numa
--- linux-2.6.4-vanilla/Documentation/vm/numa	Wed Mar 10 18:55:35 2004
+++ linux-2.6.4-nodemask_t-core/Documentation/vm/numa	Thu Mar 11 11:59:01 2004
@@ -29,7 +29,7 @@ Each node's page allocation data structu
 into a pg_data_t. The bootmem_data_t is just one part of this. To 
 make the code look uniform between NUMA and regular UMA platforms, 
 UMA platforms have a statically allocated pg_data_t too (contig_page_data).
-For the sake of uniformity, the variable "numnodes" is also defined
+For the sake of uniformity, the variable "node_online_map" is also defined
 for all platforms. As we run benchmarks, we might decide to NUMAize 
 more variables like low_on_memory, nr_free_pages etc into the pg_data_t.
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/linux/gfp.h linux-2.6.4-nodemask_t-core/include/linux/gfp.h
--- linux-2.6.4-vanilla/include/linux/gfp.h	Wed Mar 10 18:55:24 2004
+++ linux-2.6.4-nodemask_t-core/include/linux/gfp.h	Thu Mar 11 11:59:01 2004
@@ -58,7 +58,7 @@
 
 /*
  * We get the zone list from the current node and the gfp_mask.
- * This zone list contains a maximum of MAXNODES*MAX_NR_ZONES zones.
+ * This zone list contains a maximum of MAX_NUMNODES*MAX_NR_ZONES zones.
  *
  * For the normal case of non-DISCONTIGMEM systems the NODE_DATA() gets
  * optimized to &contig_page_data at compile-time.
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/linux/topology.h linux-2.6.4-nodemask_t-core/include/linux/topology.h
--- linux-2.6.4-vanilla/include/linux/topology.h	Wed Mar 10 18:55:36 2004
+++ linux-2.6.4-nodemask_t-core/include/linux/topology.h	Mon Mar 15 17:11:33 2004
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
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/kernel/sched.c linux-2.6.4-nodemask_t-core/kernel/sched.c
--- linux-2.6.4-vanilla/kernel/sched.c	Wed Mar 10 18:55:43 2004
+++ linux-2.6.4-nodemask_t-core/kernel/sched.c	Thu Mar 11 11:59:01 2004
@@ -1088,7 +1088,7 @@ void sched_balance_exec(void)
 {
 	int new_cpu;
 
-	if (numnodes > 1) {
+	if (num_online_nodes() > 1) {
 		new_cpu = sched_best_cpu(current);
 		if (new_cpu != smp_processor_id())
 			sched_migrate_task(current, new_cpu);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/mm/page_alloc.c linux-2.6.4-nodemask_t-core/mm/page_alloc.c
--- linux-2.6.4-vanilla/mm/page_alloc.c	Wed Mar 10 18:55:22 2004
+++ linux-2.6.4-nodemask_t-core/mm/page_alloc.c	Mon Mar 15 17:24:48 2004
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
@@ -1115,9 +1115,13 @@ static void __init build_zonelists(pg_da
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
@@ -1128,9 +1132,9 @@ void __init build_all_zonelists(void)
 {
 	int i;
 
-	for(i = 0 ; i < numnodes ; i++)
+	for_each_online_node(i)
 		build_zonelists(NODE_DATA(i));
-	printk("Built %i zonelists\n", numnodes);
+	printk("Built %i zonelists\n", num_online_nodes());
 }
 
 /*

--=-0BgpYIj06iaKNUkJLCPM--

