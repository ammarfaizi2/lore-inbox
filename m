Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWFALCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWFALCZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 07:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWFALCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 07:02:24 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:906 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965061AbWFALCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 07:02:23 -0400
Date: Thu, 1 Jun 2006 20:04:36 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: linux-ia64@vger.kernel.org
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] remove empty node at boot time
Message-Id: <20060601200436.6bf7c4e5.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty node -- a node which containes no cpu, no memory (and no I/O).
for ia64.

This patch online nodes which has available resouces and avoid onlining 
nodes which has only possible resouces.

SRAT describes possible resources, cpu and memory.  It also shows proximity
domain, pxm. Each numa node is created according to pxm.

Current ia64 SRAT parser onlining node when new pxm is found. But sometimes
pxm just includes 'possible' resources, doesn't includes available resources.
Such pxms will create an empty node.

When an empty node is onlined, it allocates a pgdat for an empty node.

Now, fundamental codes for node-hot-plug are ready in -mm. We can add
cpu and memory dynamically to the created new node. (memory-less-node hotplug is
not ready. But I don't know whether there are demands for it now.)
Then, we can remove empty nodes, which just includes possible resource.

And, I'm now considering allocating new pgdat on-node. Empty nodes are
obstacles to do that.

TBD: I/O only node detections scheme should be fixed (if necessary).
     Does anyone have a suggestion ?

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: linux-2.6.17-rc5-mm2/arch/ia64/kernel/setup.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/arch/ia64/kernel/setup.c	2006-06-01 18:34:08.000000000 +0900
+++ linux-2.6.17-rc5-mm2/arch/ia64/kernel/setup.c	2006-06-01 19:09:19.000000000 +0900
@@ -418,7 +418,7 @@
 
 	if (early_console_setup(*cmdline_p) == 0)
 		mark_bsp_online();
-
+	reserve_memory();
 #ifdef CONFIG_ACPI
 	/* Initialize the ACPI boot-time table parser */
 	acpi_table_init();
Index: linux-2.6.17-rc5-mm2/arch/ia64/mm/contig.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/arch/ia64/mm/contig.c	2006-06-01 18:32:18.000000000 +0900
+++ linux-2.6.17-rc5-mm2/arch/ia64/mm/contig.c	2006-06-01 19:09:19.000000000 +0900
@@ -146,8 +146,6 @@
 {
 	unsigned long bootmap_size;
 
-	reserve_memory();
-
 	/* first find highest page frame number */
 	max_pfn = 0;
 	efi_memmap_walk(find_max_pfn, &max_pfn);
Index: linux-2.6.17-rc5-mm2/arch/ia64/mm/discontig.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/arch/ia64/mm/discontig.c	2006-06-01 18:34:08.000000000 +0900
+++ linux-2.6.17-rc5-mm2/arch/ia64/mm/discontig.c	2006-06-01 19:09:19.000000000 +0900
@@ -443,8 +443,6 @@
 {
 	int node;
 
-	reserve_memory();
-
 	if (num_online_nodes() == 0) {
 		printk(KERN_ERR "node info missing!\n");
 		node_set_online(0);
Index: linux-2.6.17-rc5-mm2/arch/ia64/kernel/acpi.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/arch/ia64/kernel/acpi.c	2006-06-01 18:34:08.000000000 +0900
+++ linux-2.6.17-rc5-mm2/arch/ia64/kernel/acpi.c	2006-06-01 19:09:19.000000000 +0900
@@ -515,6 +515,43 @@
 	num_node_memblks++;
 }
 
+/* online node if node has valid memory */
+static
+int find_valid_memory_range(unsigned long start, unsigned long end, void *arg)
+{
+	int i;
+	struct node_memblk_s *p;
+	start = __pa(start);
+	end = __pa(end);
+	for (i = 0; i < num_node_memblks; ++i) {
+		p = &node_memblk[i];
+		if (end < p->start_paddr)
+			continue;
+		if (p->start_paddr + p->size <= start)
+			continue;
+		node_set_online(p->nid);
+	}
+	return 0;
+}
+
+static void
+acpi_online_node_fixup(void)
+{
+	int i, cpu;
+	/* online node if a node has available cpus */
+	for (i = 0; i < srat_num_cpus; ++i)
+		for (cpu = 0; cpu < available_cpus; ++cpu)
+			if (smp_boot_data.cpu_phys_id[cpu] ==
+				node_cpuid[i].phys_id) {
+				node_set_online(node_cpuid[i].nid);
+				break;
+			}
+	/* memory */
+	efi_memmap_walk(find_valid_memory_range, NULL);
+
+	/* TBD: check I/O devices which have valid nid. and online it*/
+}
+
 void __init acpi_numa_arch_fixup(void)
 {
 	int i, j, node_from, node_to;
@@ -526,22 +563,28 @@
 		return;
 	}
 
-	/*
-	 * MCD - This can probably be dropped now.  No need for pxm ID to node ID
-	 * mapping with sparse node numbering iff MAX_PXM_DOMAINS <= MAX_NUMNODES.
-	 */
 	nodes_clear(node_online_map);
+	/* MAP pxm to nid */
 	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
 		if (pxm_bit_test(i)) {
-			int nid = acpi_map_pxm_to_node(i);
-			node_set_online(nid);
+			/* this makes pxm <-> nid mapping */
+			acpi_map_pxm_to_node(i);
 		}
 	}
+	/* convert pxm information to nid information */
 
-	/* set logical node id in memory chunk structure */
 	for (i = 0; i < num_node_memblks; i++)
 		node_memblk[i].nid = pxm_to_node(node_memblk[i].nid);
 
+	for (i = 0; i < srat_num_cpus; i++)
+		node_cpuid[i].nid = pxm_to_node(node_cpuid[i].nid);
+
+	/*
+         * confirm node is online or not.
+         * onlined node will have their own NODE_DATA
+	 */
+	acpi_online_node_fixup();
+
 	/* assign memory bank numbers for each chunk on each node */
 	for_each_online_node(i) {
 		int bank;
@@ -552,9 +595,6 @@
 				node_memblk[j].bank = bank++;
 	}
 
-	/* set logical node id in cpu structure */
-	for (i = 0; i < srat_num_cpus; i++)
-		node_cpuid[i].nid = pxm_to_node(node_cpuid[i].nid);
 
 	printk(KERN_INFO "Number of logical nodes in system = %d\n",
 	       num_online_nodes());

