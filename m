Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVCKWM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVCKWM4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVCKWM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:12:56 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:13237 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261538AbVCKWLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:11:40 -0500
Date: Fri, 11 Mar 2005 14:11:10 -0800
From: mike kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 NUMA memory fixup
Message-ID: <20050311221110.GG6360@w-mikek2.ibm.com>
References: <16942.30144.513313.26103@cargo.ozlabs.ibm.com> <20050310023613.23499386.akpm@osdl.org> <16945.23578.505529.220972@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16945.23578.505529.220972@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another version of the patch.  This one gets the cell sizes
before extracting the cells.  I have made this change to existing
code in the file, as well as the code I added.  This works fine on
my 720, but so did the previous patch. :)  I'd appreciate it if
someone could touch test this on a machine known to break with
the previous version (such as G5).

-- 
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>


diff -Naupr linux-2.6.11/arch/ppc64/mm/numa.c linux-2.6.11.work/arch/ppc64/mm/numa.c
--- linux-2.6.11/arch/ppc64/mm/numa.c	2005-03-02 07:38:38.000000000 +0000
+++ linux-2.6.11.work/arch/ppc64/mm/numa.c	2005-03-11 21:08:29.000000000 +0000
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
@@ -186,14 +186,31 @@ static int __init find_min_common_depth(
 	return depth;
 }
 
-static unsigned long read_cell_ul(struct device_node *device, unsigned int **buf)
+static int __init get_mem_addr_cells(void)
+{
+	struct device_node *memory = NULL;
+
+	memory = of_find_node_by_type(memory, "memory");
+	if (!memory)
+		return 0; /* it won't matter */
+	return(prom_n_addr_cells(memory));
+}
+
+static int __init get_mem_size_cells(void)
+{
+	struct device_node *memory = NULL;
+
+	memory = of_find_node_by_type(memory, "memory");
+	if (!memory)
+		return 0; /* it won't matter */
+	return(prom_n_size_cells(memory));
+}
+
+static unsigned long read_n_cells(int n, unsigned int **buf)
 {
-	int i;
 	unsigned long result = 0;
 
-	i = prom_n_size_cells(device);
-	/* bug on i>2 ?? */
-	while (i--) {
+	while (n--) {
 		result = (result << 32) | **buf;
 		(*buf)++;
 	}
@@ -267,6 +284,7 @@ static int __init parse_numa_properties(
 {
 	struct device_node *cpu = NULL;
 	struct device_node *memory = NULL;
+	int addr_cells, size_cells;
 	int max_domain = 0;
 	long entries = lmb_end_of_DRAM() >> MEMORY_INCREMENT_SHIFT;
 	unsigned long i;
@@ -313,6 +331,8 @@ static int __init parse_numa_properties(
 		}
 	}
 
+	addr_cells = get_mem_addr_cells();
+	size_cells = get_mem_size_cells();
 	memory = NULL;
 	while ((memory = of_find_node_by_type(memory, "memory")) != NULL) {
 		unsigned long start;
@@ -329,8 +349,8 @@ static int __init parse_numa_properties(
 		ranges = memory->n_addrs;
 new_range:
 		/* these are order-sensitive, and modify the buffer pointer */
-		start = read_cell_ul(memory, &memcell_buf);
-		size = read_cell_ul(memory, &memcell_buf);
+		start = read_n_cells(addr_cells, &memcell_buf);
+		size = read_n_cells(size_cells, &memcell_buf);
 
 		start = _ALIGN_DOWN(start, MEMORY_INCREMENT);
 		size = _ALIGN_UP(size, MEMORY_INCREMENT);
@@ -348,33 +368,28 @@ new_range:
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
 
@@ -391,14 +406,6 @@ new_range:
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
@@ -426,12 +433,11 @@ static void __init setup_nonnuma(void)
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
@@ -512,6 +518,8 @@ static unsigned long careful_allocation(
 void __init do_init_bootmem(void)
 {
 	int nid;
+	int addr_cells, size_cells;
+	struct device_node *memory = NULL;
 	static struct notifier_block ppc64_numa_nb = {
 		.notifier_call = cpu_numa_callback,
 		.priority = 1 /* Must run before sched domains notifier. */
@@ -535,7 +543,7 @@ void __init do_init_bootmem(void)
 		unsigned long bootmap_pages;
 
 		start_paddr = init_node_data[nid].node_start_pfn * PAGE_SIZE;
-		end_paddr = start_paddr + (init_node_data[nid].node_spanned_pages * PAGE_SIZE);
+		end_paddr = init_node_data[nid].node_end_pfn * PAGE_SIZE;
 
 		/* Allocate the node structure node local if possible */
 		NODE_DATA(nid) = (struct pglist_data *)careful_allocation(nid,
@@ -551,9 +559,9 @@ void __init do_init_bootmem(void)
 		NODE_DATA(nid)->node_start_pfn =
 			init_node_data[nid].node_start_pfn;
 		NODE_DATA(nid)->node_spanned_pages =
-			init_node_data[nid].node_spanned_pages;
+			end_paddr - start_paddr;
 
-		if (init_node_data[nid].node_spanned_pages == 0)
+		if (NODE_DATA(nid)->node_spanned_pages == 0)
   			continue;
 
   		dbg("start_paddr = %lx\n", start_paddr);
@@ -572,33 +580,50 @@ void __init do_init_bootmem(void)
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
+		addr_cells = get_mem_addr_cells();
+		size_cells = get_mem_size_cells();
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
+			mem_start = read_n_cells(addr_cells, &memcell_buf);
+			mem_size = read_n_cells(size_cells, &memcell_buf);
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
@@ -632,13 +657,12 @@ void __init paging_init(void)
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
