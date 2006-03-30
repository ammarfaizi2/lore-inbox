Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWC3L4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWC3L4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWC3L4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:56:05 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:42437 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932112AbWC3L4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:56:00 -0500
Date: Thu, 30 Mar 2006 20:55:30 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:002/004]Unify pxm_to_node id ver.4. (for ia64)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330204245.A4F5.Y-GOTO@jp.fujitsu.com>
References: <20060330204245.A4F5.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330205037.A4F9.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to use generic pxm_to_node() function instead of
old pxm_to_nid_map for ia64.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 arch/ia64/hp/common/sba_iommu.c |    2 +-
 arch/ia64/kernel/acpi.c         |   24 ++++++++----------------
 arch/ia64/pci/pci.c             |    2 +-
 arch/ia64/sn/kernel/setup.c     |    4 ++--
 include/asm-ia64/acpi.h         |   11 -----------
 5 files changed, 12 insertions(+), 31 deletions(-)

Index: pxm_ver4/arch/ia64/kernel/acpi.c
===================================================================
--- pxm_ver4.orig/arch/ia64/kernel/acpi.c	2006-03-29 22:06:10.000000000 +0900
+++ pxm_ver4/arch/ia64/kernel/acpi.c	2006-03-29 22:10:54.000000000 +0900
@@ -415,9 +415,6 @@ static int __initdata srat_num_cpus;	/* 
 static u32 __devinitdata pxm_flag[PXM_FLAG_LEN];
 #define pxm_bit_set(bit)	(set_bit(bit,(void *)pxm_flag))
 #define pxm_bit_test(bit)	(test_bit(bit,(void *)pxm_flag))
-/* maps to convert between proximity domain and logical node ID */
-int __devinitdata pxm_to_nid_map[MAX_PXM_DOMAINS];
-int __initdata nid_to_pxm_map[MAX_NUMNODES];
 static struct acpi_table_slit __initdata *slit_table;
 
 static int get_processor_proximity_domain(struct acpi_table_processor_affinity *pa)
@@ -533,22 +530,17 @@ void __init acpi_numa_arch_fixup(void)
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
 			node_set_online(nid);
 		}
 	}
 
 	/* set logical node id in memory chunk structure */
 	for (i = 0; i < num_node_memblks; i++)
-		node_memblk[i].nid = pxm_to_nid_map[node_memblk[i].nid];
+		node_memblk[i].nid = pxm_to_node(node_memblk[i].nid);
 
 	/* assign memory bank numbers for each chunk on each node */
 	for_each_online_node(i) {
@@ -562,7 +554,7 @@ void __init acpi_numa_arch_fixup(void)
 
 	/* set logical node id in cpu structure */
 	for (i = 0; i < srat_num_cpus; i++)
-		node_cpuid[i].nid = pxm_to_nid_map[node_cpuid[i].nid];
+		node_cpuid[i].nid = pxm_to_node(node_cpuid[i].nid);
 
 	printk(KERN_INFO "Number of logical nodes in system = %d\n",
 	       num_online_nodes());
@@ -575,11 +567,11 @@ void __init acpi_numa_arch_fixup(void)
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
@@ -785,9 +777,9 @@ int acpi_map_cpu2node(acpi_handle handle
 
 	/*
 	 * Assuming that the container driver would have set the proximity
-	 * domain and would have initialized pxm_to_nid_map[pxm_id] && pxm_flag
+	 * domain and would have initialized pxm_to_node(pxm_id) && pxm_flag
 	 */
-	node_cpuid[cpu].nid = (pxm_id < 0) ? 0 : pxm_to_nid_map[pxm_id];
+	node_cpuid[cpu].nid = (pxm_id < 0) ? 0 : pxm_to_node(pxm_id);
 
 	node_cpuid[cpu].phys_id = physid;
 #endif
@@ -966,7 +958,7 @@ acpi_map_iosapic(acpi_handle handle, u32
 	if (pxm < 0)
 		return AE_OK;
 
-	node = pxm_to_nid_map[pxm];
+	node = pxm_to_node(pxm);
 
 	if (node >= MAX_NUMNODES || !node_online(node) ||
 	    cpus_empty(node_to_cpumask(node)))
Index: pxm_ver4/arch/ia64/pci/pci.c
===================================================================
--- pxm_ver4.orig/arch/ia64/pci/pci.c	2006-03-22 17:25:02.000000000 +0900
+++ pxm_ver4/arch/ia64/pci/pci.c	2006-03-29 22:10:54.000000000 +0900
@@ -353,7 +353,7 @@ pci_acpi_scan_root(struct acpi_device *d
 	pxm = acpi_get_pxm(controller->acpi_handle);
 #ifdef CONFIG_NUMA
 	if (pxm >= 0)
-		controller->node = pxm_to_nid_map[pxm];
+		controller->node = pxm_to_node(pxm);
 #endif
 
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS, count_window,
Index: pxm_ver4/arch/ia64/hp/common/sba_iommu.c
===================================================================
--- pxm_ver4.orig/arch/ia64/hp/common/sba_iommu.c	2006-01-05 15:43:10.000000000 +0900
+++ pxm_ver4/arch/ia64/hp/common/sba_iommu.c	2006-03-29 22:10:54.000000000 +0900
@@ -1958,7 +1958,7 @@ sba_map_ioc_to_node(struct ioc *ioc, acp
 	if (pxm < 0)
 		return;
 
-	node = pxm_to_nid_map[pxm];
+	node = pxm_to_node(pxm);
 
 	if (node >= MAX_NUMNODES || !node_online(node))
 		return;
Index: pxm_ver4/arch/ia64/sn/kernel/setup.c
===================================================================
--- pxm_ver4.orig/arch/ia64/sn/kernel/setup.c	2006-03-29 22:06:10.000000000 +0900
+++ pxm_ver4/arch/ia64/sn/kernel/setup.c	2006-03-29 22:10:54.000000000 +0900
@@ -139,7 +139,7 @@ static int __init pxm_to_nasid(int pxm)
 	int i;
 	int nid;
 
-	nid = pxm_to_nid_map[pxm];
+	nid = pxm_to_node(pxm);
 	for (i = 0; i < num_node_memblks; i++) {
 		if (node_memblk[i].nid == nid) {
 			return NASID_GET(node_memblk[i].start_paddr);
@@ -704,7 +704,7 @@ void __init build_cnode_tables(void)
 	 * cnode == node for all C & M bricks.
 	 */
 	for_each_online_node(node) {
-		nasid = pxm_to_nasid(nid_to_pxm_map[node]);
+		nasid = pxm_to_nasid(node_to_pxm(node));
 		sn_cnodeid_to_nasid[node] = nasid;
 		physical_node_map[nasid] = node;
 	}
Index: pxm_ver4/include/asm-ia64/acpi.h
===================================================================
--- pxm_ver4.orig/include/asm-ia64/acpi.h	2006-03-29 22:06:16.000000000 +0900
+++ pxm_ver4/include/asm-ia64/acpi.h	2006-03-29 22:10:54.000000000 +0900
@@ -109,17 +109,6 @@ extern unsigned int get_cpei_target_cpu(
 extern void prefill_possible_map(void);
 extern int additional_cpus;
 
-#ifdef CONFIG_ACPI_NUMA
-/* Proximity bitmap length; _PXM is at most 255 (8 bit)*/
-#ifdef CONFIG_IA64_NR_NODES
-#define MAX_PXM_DOMAINS CONFIG_IA64_NR_NODES
-#else
-#define MAX_PXM_DOMAINS (256)
-#endif
-extern int __devinitdata pxm_to_nid_map[MAX_PXM_DOMAINS];
-extern int __initdata nid_to_pxm_map[MAX_NUMNODES];
-#endif
-
 extern u16 ia64_acpiid_to_sapicid[];
 
 /*

-- 
Yasunori Goto 


