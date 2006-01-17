Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWAQMhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWAQMhN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 07:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWAQMhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 07:37:12 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:8141 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932456AbWAQMhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 07:37:09 -0500
Date: Tue, 17 Jan 2006 21:36:07 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: [PATCH/RFC] Unify mapping from PXM to node id.
Cc: Andi Kleen <ak@suse.de>, "Luck, Tony" <tony.luck@intel.com>,
       "Brown, Len" <len.brown@intel.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060117205442.5B9A.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This patch is to unify mapping from pxm to node id as a common code.
In current code, i386, x86-64, and ia64 have its mapping by each own code.
But PXM is defined by ACPI and node id is used generically. So,
I think there is no reason to define it on each arch's code.
This mapping should be written at drivers/acpi/numa.c.

I tested on just ia64 box(Tiger4) yet. But if there is no objection,
I would like to test other archs.

This patch is for 2.6.15.

Please comment.
Of course, report of test is welcome! :-)

Thanks.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
Index: unify_pxm/arch/i386/kernel/srat.c
===================================================================
--- unify_pxm.orig/arch/i386/kernel/srat.c	2006-01-17 19:59:15.000000000 +0900
+++ unify_pxm/arch/i386/kernel/srat.c	2006-01-17 19:59:18.000000000 +0900
@@ -213,13 +213,6 @@ static __init void node_read_chunk(int n
 		node_end_pfn[nid] = memory_chunk->end_pfn;
 }
 
-static u8 pxm_to_nid_map[MAX_PXM_DOMAINS];/* _PXM to logical node ID map */
-
-int pxm_to_node(int pxm)
-{
-	return pxm_to_nid_map[pxm];
-}
-
 /* Parse the ACPI Static Resource Affinity Table */
 static int __init acpi20_parse_srat(struct acpi_table_srat *sratp)
 {
@@ -235,10 +228,6 @@ static int __init acpi20_parse_srat(stru
 	memset(node_memory_chunk, 0, sizeof(node_memory_chunk));
 	memset(zholes_size, 0, sizeof(zholes_size));
 
-	/* -1 in these maps means not available */
-	memset(pxm_to_nid_map, -1, sizeof(pxm_to_nid_map));
-	memset(nid_to_pxm_map, -1, sizeof(nid_to_pxm_map));
-
 	num_memory_chunks = 0;
 	while (p < end) {
 		switch (*p) {
@@ -278,9 +267,7 @@ static int __init acpi20_parse_srat(stru
 	nodes_clear(node_online_map);
 	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
 		if (BMAP_TEST(pxm_bitmap, i)) {
-			nid = num_online_nodes();
-			pxm_to_nid_map[i] = nid;
-			nid_to_pxm_map[nid] = i;
+			int nid = acpi_map_pxm_to_node(i);
 			node_set_online(nid);
 		}
 	}
@@ -288,7 +275,7 @@ static int __init acpi20_parse_srat(stru
 
 	/* set cnode id in memory chunk structure */
 	for (i = 0; i < num_memory_chunks; i++)
-		node_memory_chunk[i].nid = pxm_to_nid_map[node_memory_chunk[i].pxm];
+		node_memory_chunk[i].nid = pxm_to_node(node_memory_chunk[i].pxm);
 
 	printk("pxm bitmap: ");
 	for (i = 0; i < sizeof(pxm_bitmap); i++) {
Index: unify_pxm/arch/ia64/kernel/acpi.c
===================================================================
--- unify_pxm.orig/arch/ia64/kernel/acpi.c	2006-01-17 19:59:15.000000000 +0900
+++ unify_pxm/arch/ia64/kernel/acpi.c	2006-01-17 21:12:12.000000000 +0900
@@ -409,9 +409,6 @@ static int __initdata srat_num_cpus;	/* 
 static u32 __devinitdata pxm_flag[PXM_FLAG_LEN];
 #define pxm_bit_set(bit)	(set_bit(bit,(void *)pxm_flag))
 #define pxm_bit_test(bit)	(test_bit(bit,(void *)pxm_flag))
-/* maps to convert between proximity domain and logical node ID */
-int __devinitdata pxm_to_nid_map[MAX_PXM_DOMAINS];
-int __initdata nid_to_pxm_map[MAX_NUMNODES];
 static struct acpi_table_slit __initdata *slit_table;
 
 /*
@@ -500,22 +497,18 @@ void __init acpi_numa_arch_fixup(void)
 	 * MCD - This can probably be dropped now.  No need for pxm ID to node ID
 	 * mapping with sparse node numbering iff MAX_PXM_DOMAINS <= MAX_NUMNODES.
 	 */
-	/* calculate total number of nodes in system from PXM bitmap */
-	memset(pxm_to_nid_map, -1, sizeof(pxm_to_nid_map));
-	memset(nid_to_pxm_map, -1, sizeof(nid_to_pxm_map));
 	nodes_clear(node_online_map);
 	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
 		if (pxm_bit_test(i)) {
-			int nid = num_online_nodes();
-			pxm_to_nid_map[i] = nid;
-			nid_to_pxm_map[nid] = i;
+			int nid = acpi_map_pxm_to_node(i);
+			pxm_bit_set(i);
 			node_set_online(nid);
 		}
 	}
 
 	/* set logical node id in memory chunk structure */
 	for (i = 0; i < num_node_memblks; i++)
-		node_memblk[i].nid = pxm_to_nid_map[node_memblk[i].nid];
+		node_memblk[i].nid = pxm_to_node(node_memblk[i].nid);
 
 	/* assign memory bank numbers for each chunk on each node */
 	for_each_online_node(i) {
@@ -529,7 +522,7 @@ void __init acpi_numa_arch_fixup(void)
 
 	/* set logical node id in cpu structure */
 	for (i = 0; i < srat_num_cpus; i++)
-		node_cpuid[i].nid = pxm_to_nid_map[node_cpuid[i].nid];
+		node_cpuid[i].nid = pxm_to_node(node_cpuid[i].nid);
 
 	printk(KERN_INFO "Number of logical nodes in system = %d\n",
 	       num_online_nodes());
@@ -542,11 +535,11 @@ void __init acpi_numa_arch_fixup(void)
 	for (i = 0; i < slit_table->localities; i++) {
 		if (!pxm_bit_test(i))
 			continue;
-		node_from = pxm_to_nid_map[i];
+		node_from = pxm_to_node(i);
 		for (j = 0; j < slit_table->localities; j++) {
 			if (!pxm_bit_test(j))
 				continue;
-			node_to = pxm_to_nid_map[j];
+			node_to = pxm_to_node(j);
 			node_distance(node_from, node_to) =
 			    slit_table->entry[i * slit_table->localities + j];
 		}
@@ -752,9 +745,9 @@ int acpi_map_cpu2node(acpi_handle handle
 
 	/*
 	 * Assuming that the container driver would have set the proximity
-	 * domain and would have initialized pxm_to_nid_map[pxm_id] && pxm_flag
+	 * domain and would have initialized pxm_to_node(pxm_id) && pxm_flag
 	 */
-	node_cpuid[cpu].nid = (pxm_id < 0) ? 0 : pxm_to_nid_map[pxm_id];
+	node_cpuid[cpu].nid = (pxm_id < 0) ? 0 : pxm_to_node(pxm_id);
 
 	node_cpuid[cpu].phys_id = physid;
 #endif
@@ -880,7 +873,7 @@ acpi_map_iosapic(acpi_handle handle, u32
 	if (pxm < 0)
 		return AE_OK;
 
-	node = pxm_to_nid_map[pxm];
+	node = pxm_to_node(pxm);
 
 	if (node >= MAX_NUMNODES || !node_online(node) ||
 	    cpus_empty(node_to_cpumask(node)))
Index: unify_pxm/drivers/acpi/numa.c
===================================================================
--- unify_pxm.orig/drivers/acpi/numa.c	2006-01-17 19:59:15.000000000 +0900
+++ unify_pxm/drivers/acpi/numa.c	2006-01-17 19:59:47.000000000 +0900
@@ -36,12 +36,54 @@
 #define _COMPONENT	ACPI_NUMA
 ACPI_MODULE_NAME("numa")
 
+static nodemask_t nodes_found_map = NODE_MASK_NONE;
+
+/* maps to convert between proximity domain and logical node ID */
+int __devinitdata pxm_to_node_map[MAX_PXM_DOMAINS]
+				= { [0 ... MAX_PXM_DOMAINS - 1] = -1 };
+int __devinitdata node_to_pxm_map[MAX_NUMNODES]
+				= { [0 ... MAX_NUMNODES - 1] = -1 };
+
 extern int __init acpi_table_parse_madt_family(enum acpi_table_id id,
 					       unsigned long madt_size,
 					       int entry_id,
 					       acpi_madt_entry_handler handler,
 					       unsigned int max_entries);
 
+int pxm_to_node(int pxm)
+{
+	return pxm_to_node_map[pxm];
+}
+
+int node_to_pxm(int node)
+{
+	return node_to_pxm_map[node];
+}
+
+int acpi_map_pxm_to_node(int pxm)
+{
+	int node = pxm_to_node_map[pxm];
+
+	if (node < 0){
+		if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
+			return -1;
+		node = first_unset_node(nodes_found_map);
+		pxm_to_node_map[pxm] = node;
+		node_to_pxm_map[node] = pxm;
+		node_set(node, nodes_found_map);
+	}
+
+	return node;
+}
+
+void acpi_unmap_pxm_to_node(int node)
+{
+	int pxm = node_to_pxm_map[node];
+	node_clear(node, nodes_found_map);
+	pxm_to_node_map[pxm] = -1;
+	node_to_pxm_map[node] = -1;
+}
+
 void __init acpi_table_print_srat_entry(acpi_table_entry_header * header)
 {
 
Index: unify_pxm/arch/x86_64/mm/srat.c
===================================================================
--- unify_pxm.orig/arch/x86_64/mm/srat.c	2006-01-17 19:59:15.000000000 +0900
+++ unify_pxm/arch/x86_64/mm/srat.c	2006-01-17 19:59:18.000000000 +0900
@@ -21,30 +21,11 @@
 static struct acpi_table_slit *acpi_slit;
 
 static nodemask_t nodes_parsed __initdata;
-static nodemask_t nodes_found __initdata;
 static struct node nodes[MAX_NUMNODES] __initdata;
-static __u8  pxm2node[256] = { [0 ... 255] = 0xff };
-
-static int node_to_pxm(int n);
-
-int pxm_to_node(int pxm)
-{
-	if ((unsigned)pxm >= 256)
-		return 0;
-	return pxm2node[pxm];
-}
 
 static __init int setup_node(int pxm)
 {
-	unsigned node = pxm2node[pxm];
-	if (node == 0xff) {
-		if (nodes_weight(nodes_found) >= MAX_NUMNODES)
-			return -1;
-		node = first_unset_node(nodes_found); 
-		node_set(node, nodes_found);
-		pxm2node[pxm] = node;
-	}
-	return pxm2node[pxm];
+	return acpi_map_pxm_to_node(pxm);
 }
 
 static __init int conflicting_nodes(unsigned long start, unsigned long end)
@@ -205,17 +186,6 @@ int __init acpi_scan_nodes(unsigned long
 	return 0;
 }
 
-static int node_to_pxm(int n)
-{
-       int i;
-       if (pxm2node[n] == n)
-               return n;
-       for (i = 0; i < 256; i++)
-               if (pxm2node[i] == n)
-                       return i;
-       return 0;
-}
-
 int __node_distance(int a, int b)
 {
 	int index;
Index: unify_pxm/include/asm-x86_64/numa.h
===================================================================
--- unify_pxm.orig/include/asm-x86_64/numa.h	2006-01-17 19:59:15.000000000 +0900
+++ unify_pxm/include/asm-x86_64/numa.h	2006-01-17 19:59:18.000000000 +0900
@@ -9,7 +9,6 @@ struct node { 
 };
 
 extern int compute_hash_shift(struct node *nodes, int numnodes);
-extern int pxm_to_node(int nid);
 
 #define ZONE_ALIGN (1UL << (MAX_ORDER+PAGE_SHIFT))
 
Index: unify_pxm/include/acpi/acpi_numa.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ unify_pxm/include/acpi/acpi_numa.h	2006-01-17 19:59:18.000000000 +0900
@@ -0,0 +1,18 @@
+#ifndef __ACPI_NUMA_H
+#define __ACPI_NUMA_H
+
+#ifdef CONFIG_ACPI_NUMA
+#include <linux/kernel.h>
+
+/* Proximity bitmap length; _PXM is at most 255 (8 bit)*/
+#define MAX_PXM_DOMAINS (256)
+extern int __devinitdata pxm_to_node_map[MAX_PXM_DOMAINS];
+extern int __devinitdata node_to_pxm_map[MAX_NUMNODES];
+
+extern int __devinit pxm_to_node(int);
+extern int __devinit node_to_pxm(int);
+extern int __devinit acpi_map_pxm_to_node(int);
+extern void __devinit acpi_unmap_pxm_to_node(int);
+
+#endif				/* CONFIG_ACPI_NUMA */
+#endif				/* __ACP_NUMA_H */
Index: unify_pxm/arch/ia64/pci/pci.c
===================================================================
--- unify_pxm.orig/arch/ia64/pci/pci.c	2006-01-17 19:59:15.000000000 +0900
+++ unify_pxm/arch/ia64/pci/pci.c	2006-01-17 19:59:18.000000000 +0900
@@ -353,7 +353,7 @@ pci_acpi_scan_root(struct acpi_device *d
 	pxm = acpi_get_pxm(controller->acpi_handle);
 #ifdef CONFIG_NUMA
 	if (pxm >= 0)
-		controller->node = pxm_to_nid_map[pxm];
+		controller->node = pxm_to_node(pxm);
 #endif
 
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS, count_window,
Index: unify_pxm/include/linux/acpi.h
===================================================================
--- unify_pxm.orig/include/linux/acpi.h	2006-01-17 19:59:15.000000000 +0900
+++ unify_pxm/include/linux/acpi.h	2006-01-17 19:59:18.000000000 +0900
@@ -38,6 +38,7 @@
 #include <acpi/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <acpi/acpi_numa.h>
 #include <asm/acpi.h>
 
 

-- 
Yasunori Goto 


