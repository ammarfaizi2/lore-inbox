Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVCIEBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVCIEBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 23:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVCIEBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 23:01:42 -0500
Received: from ozlabs.org ([203.10.76.45]:34743 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261508AbVCIEB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 23:01:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16942.30144.513313.26103@cargo.ozlabs.ibm.com>
Date: Wed, 9 Mar 2005 15:04:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: kravetz@us.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 NUMA memory fixup
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Mike Kravetz <kravetz@us.ibm.com>.

When I booted my new 720 on a kernel configured for NUMA, I received
the following during bootup:

WARNING: Unexpected node layout: region start 44000000 length 2000000
NUMA is disabled

This is due to memory 'holes' within nodes.  If such holes are
encountered, then NUMA is disabled.  The following patch adds support
for such configurations.  My 720 now boots with the following message:

[boot]0012 Setup Arch
Node 0 Memory: 0x0-0x8000000 0x44000000-0x12a000000
Node 1 Memory: 0x8000000-0x44000000 0x12a000000-0x1ea000000

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -Naupr linux-2.6.11-rc3/arch/ppc64/mm/numa.c linux-2.6.11-rc3.work/arch/ppc64/mm/numa.c
--- linux-2.6.11-rc3/arch/ppc64/mm/numa.c	2005-02-03 01:57:16.000000000 +0000
+++ linux-2.6.11-rc3.work/arch/ppc64/mm/numa.c	2005-03-01 19:39:21.000000000 +0000
@@ -40,7 +40,6 @@ int nr_cpus_in_node[MAX_NUMNODES] = { [0
 
 struct pglist_data *node_data[MAX_NUMNODES];
 bootmem_data_t __initdata plat_node_bdata[MAX_NUMNODES];
-static unsigned long node0_io_hole_size;
 static int min_common_depth;
 
 /*
@@ -49,7 +48,8 @@ static int min_common_depth;
  */
 static struct {
 	unsigned long node_start_pfn;
-	unsigned long node_spanned_pages;
+	unsigned long node_end_pfn;
+	unsigned long node_present_pages;
 } init_node_data[MAX_NUMNODES] __initdata;
 
 EXPORT_SYMBOL(node_data);
@@ -348,33 +348,28 @@ new_range:
 		if (max_domain < numa_domain)
 			max_domain = numa_domain;
 
-		/* 
-		 * For backwards compatibility, OF splits the first node
-		 * into two regions (the first being 0-4GB). Check for
-		 * this simple case and complain if there is a gap in
-		 * memory
+		/*
+		 * Initialize new node struct, or add to an existing one.
 		 */
-		if (init_node_data[numa_domain].node_spanned_pages) {
-			unsigned long shouldstart =
-				init_node_data[numa_domain].node_start_pfn +
-				init_node_data[numa_domain].node_spanned_pages;
-			if (shouldstart != (start / PAGE_SIZE)) {
-				/* Revert to non-numa for now */
-				printk(KERN_ERR
-				       "WARNING: Unexpected node layout: "
-				       "region start %lx length %lx\n",
-				       start, size);
-				printk(KERN_ERR "NUMA is disabled\n");
-				goto err;
-			}
-			init_node_data[numa_domain].node_spanned_pages +=
+		if (init_node_data[numa_domain].node_end_pfn) {
+			if ((start / PAGE_SIZE) <
+			    init_node_data[numa_domain].node_start_pfn)
+				init_node_data[numa_domain].node_start_pfn =
+					start / PAGE_SIZE;
+			else
+				init_node_data[numa_domain].node_end_pfn =
+					(start / PAGE_SIZE) +
+					(size / PAGE_SIZE);
+
+			init_node_data[numa_domain].node_present_pages +=
 				size / PAGE_SIZE;
 		} else {
 			node_set_online(numa_domain);
 
 			init_node_data[numa_domain].node_start_pfn =
 				start / PAGE_SIZE;
-			init_node_data[numa_domain].node_spanned_pages =
+			init_node_data[numa_domain].node_end_pfn =
+				init_node_data[numa_domain].node_start_pfn +
 				size / PAGE_SIZE;
 		}
 
@@ -391,14 +386,6 @@ new_range:
 		node_set_online(i);
 
 	return 0;
-err:
-	/* Something has gone wrong; revert any setup we've done */
-	for_each_node(i) {
-		node_set_offline(i);
-		init_node_data[i].node_start_pfn = 0;
-		init_node_data[i].node_spanned_pages = 0;
-	}
-	return -1;
 }
 
 static void __init setup_nonnuma(void)
@@ -426,12 +413,11 @@ static void __init setup_nonnuma(void)
 	node_set_online(0);
 
 	init_node_data[0].node_start_pfn = 0;
-	init_node_data[0].node_spanned_pages = lmb_end_of_DRAM() / PAGE_SIZE;
+	init_node_data[0].node_end_pfn = lmb_end_of_DRAM() / PAGE_SIZE;
+	init_node_data[0].node_present_pages = total_ram / PAGE_SIZE;
 
 	for (i = 0 ; i < top_of_ram; i += MEMORY_INCREMENT)
 		numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] = 0;
-
-	node0_io_hole_size = top_of_ram - total_ram;
 }
 
 static void __init dump_numa_topology(void)
@@ -512,6 +498,7 @@ static unsigned long careful_allocation(
 void __init do_init_bootmem(void)
 {
 	int nid;
+	struct device_node *memory = NULL;
 	static struct notifier_block ppc64_numa_nb = {
 		.notifier_call = cpu_numa_callback,
 		.priority = 1 /* Must run before sched domains notifier. */
@@ -535,7 +522,7 @@ void __init do_init_bootmem(void)
 		unsigned long bootmap_pages;
 
 		start_paddr = init_node_data[nid].node_start_pfn * PAGE_SIZE;
-		end_paddr = start_paddr + (init_node_data[nid].node_spanned_pages * PAGE_SIZE);
+		end_paddr = init_node_data[nid].node_end_pfn * PAGE_SIZE;
 
 		/* Allocate the node structure node local if possible */
 		NODE_DATA(nid) = (struct pglist_data *)careful_allocation(nid,
@@ -551,9 +538,9 @@ void __init do_init_bootmem(void)
 		NODE_DATA(nid)->node_start_pfn =
 			init_node_data[nid].node_start_pfn;
 		NODE_DATA(nid)->node_spanned_pages =
-			init_node_data[nid].node_spanned_pages;
+			end_paddr - start_paddr;
 
-		if (init_node_data[nid].node_spanned_pages == 0)
+		if (NODE_DATA(nid)->node_spanned_pages == 0)
   			continue;
 
   		dbg("start_paddr = %lx\n", start_paddr);
@@ -572,33 +559,48 @@ void __init do_init_bootmem(void)
 				  start_paddr >> PAGE_SHIFT,
 				  end_paddr >> PAGE_SHIFT);
 
-		for (i = 0; i < lmb.memory.cnt; i++) {
-			unsigned long physbase, size;
-
-			physbase = lmb.memory.region[i].physbase;
-			size = lmb.memory.region[i].size;
-
-			if (physbase < end_paddr &&
-			    (physbase+size) > start_paddr) {
-				/* overlaps */
-				if (physbase < start_paddr) {
-					size -= start_paddr - physbase;
-					physbase = start_paddr;
-				}
-
-				if (size > end_paddr - physbase)
-					size = end_paddr - physbase;
-
-				dbg("free_bootmem %lx %lx\n", physbase, size);
-				free_bootmem_node(NODE_DATA(nid), physbase,
-						  size);
+		/*
+		 * We need to do another scan of all memory sections to
+		 * associate memory with the correct node.
+		 */
+		memory = NULL;
+		while ((memory = of_find_node_by_type(memory, "memory")) != NULL) {
+			unsigned long mem_start, mem_size;
+			int numa_domain;
+			unsigned int *memcell_buf;
+			unsigned int len;
+
+			memcell_buf = (unsigned int *)get_property(memory, "reg", &len);
+			if (!memcell_buf || len <= 0)
+				continue;
+
+			mem_start = read_cell_ul(memory, &memcell_buf);
+			mem_size = read_cell_ul(memory, &memcell_buf);
+			numa_domain = of_node_numa_domain(memory);
+
+			if (numa_domain != nid)
+				continue;
+
+			if (mem_start < end_paddr &&
+			    (mem_start+mem_size) > start_paddr) {
+				/* should be no overlaps ! */
+				dbg("free_bootmem %lx %lx\n", mem_start, mem_size);
+				free_bootmem_node(NODE_DATA(nid), mem_start,
+						  mem_size);
 			}
 		}
 
+		/*
+		 * Mark reserved regions on this node
+		 */
 		for (i = 0; i < lmb.reserved.cnt; i++) {
 			unsigned long physbase = lmb.reserved.region[i].physbase;
 			unsigned long size = lmb.reserved.region[i].size;
 
+			if (pa_to_nid(physbase) != nid &&
+			    pa_to_nid(physbase+size-1) != nid)
+				continue;
+
 			if (physbase < end_paddr &&
 			    (physbase+size) > start_paddr) {
 				/* overlaps */
@@ -632,13 +634,12 @@ void __init paging_init(void)
 		unsigned long start_pfn;
 		unsigned long end_pfn;
 
-		start_pfn = plat_node_bdata[nid].node_boot_start >> PAGE_SHIFT;
-		end_pfn = plat_node_bdata[nid].node_low_pfn;
+		start_pfn = init_node_data[nid].node_start_pfn;
+		end_pfn = init_node_data[nid].node_end_pfn;
 
 		zones_size[ZONE_DMA] = end_pfn - start_pfn;
-		zholes_size[ZONE_DMA] = 0;
-		if (nid == 0)
-			zholes_size[ZONE_DMA] = node0_io_hole_size >> PAGE_SHIFT;
+		zholes_size[ZONE_DMA] = zones_size[ZONE_DMA] -
+			init_node_data[nid].node_present_pages;
 
 		dbg("free_area_init node %d %lx %lx (hole: %lx)\n", nid,
 		    zones_size[ZONE_DMA], start_pfn, zholes_size[ZONE_DMA]);
