Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268240AbUIBLs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268240AbUIBLs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268247AbUIBLs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 07:48:59 -0400
Received: from ozlabs.org ([203.10.76.45]:59792 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268240AbUIBLss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 07:48:48 -0400
Date: Thu, 2 Sep 2004 21:45:51 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc64] Allocate NUMA node data node locally
Message-ID: <20040902114551.GC26072@krispykreme>
References: <20040902111903.GB26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902111903.GB26072@krispykreme>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Instead of statically allocating the NUMA node structures, do it at
runtime with node local memory where possible. With NR_CPUS=128 we
had over 800kB of memory allocated before this patch, now we allocate
only as many nodes as the machine requires.

We have to do some fancy footwork in do_init_bootmem since we use both
the LMB allocator and the bootmem allocator at the same time. The
problem has always been there although I only recently found a test case
that hit it. Wrap that logic in careful_allocation which uses the LMB
allocator then falls back to the bootmem allocator if required.

Now alloc_bootmem on a node with no memory doesnt panic, we dont need
the hack in paging_init so remove it.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/mm/init.c~bootmem_fixes arch/ppc64/mm/init.c
--- foobar2/arch/ppc64/mm/init.c~bootmem_fixes	2004-09-02 17:42:23.148580947 +1000
+++ foobar2-anton/arch/ppc64/mm/init.c	2004-09-02 17:42:23.192577565 +1000
@@ -663,7 +663,7 @@ void __init mem_init(void)
 	int nid;
 
         for (nid = 0; nid < numnodes; nid++) {
-		if (node_data[nid].node_spanned_pages != 0) {
+		if (NODE_DATA(nid)->node_spanned_pages != 0) {
 			printk("freeing bootmem node %x\n", nid);
 			totalram_pages +=
 				free_all_bootmem_node(NODE_DATA(nid));
diff -puN arch/ppc64/mm/numa.c~bootmem_fixes arch/ppc64/mm/numa.c
--- foobar2/arch/ppc64/mm/numa.c~bootmem_fixes	2004-09-02 17:42:23.155580409 +1000
+++ foobar2-anton/arch/ppc64/mm/numa.c	2004-09-02 17:43:22.000873574 +1000
@@ -33,10 +33,19 @@ char *numa_memory_lookup_table;
 cpumask_t numa_cpumask_lookup_table[MAX_NUMNODES];
 int nr_cpus_in_node[MAX_NUMNODES] = { [0 ... (MAX_NUMNODES -1)] = 0};
 
-struct pglist_data node_data[MAX_NUMNODES];
-bootmem_data_t plat_node_bdata[MAX_NUMNODES];
+struct pglist_data *node_data[MAX_NUMNODES];
+bootmem_data_t __initdata plat_node_bdata[MAX_NUMNODES];
 static unsigned long node0_io_hole_size;
 
+/*
+ * We need somewhere to store start/span for each node until we have
+ * allocated the real node_data structures.
+ */
+static struct {
+	unsigned long node_start_pfn;
+	unsigned long node_spanned_pages;
+} init_node_data[MAX_NUMNODES] __initdata;
+
 EXPORT_SYMBOL(node_data);
 EXPORT_SYMBOL(numa_cpu_lookup_table);
 EXPORT_SYMBOL(numa_memory_lookup_table);
@@ -190,6 +199,7 @@ static int __init parse_numa_properties(
 
 	numa_memory_lookup_table =
 		(char *)abs_to_virt(lmb_alloc(entries * sizeof(char), 1));
+	memset(numa_memory_lookup_table, 0, entries * sizeof(char));
 
 	for (i = 0; i < entries ; i++)
 		numa_memory_lookup_table[i] = ARRAY_INITIALISER;
@@ -276,22 +286,22 @@ new_range:
 		 * this simple case and complain if there is a gap in
 		 * memory
 		 */
-		if (node_data[numa_domain].node_spanned_pages) {
+		if (init_node_data[numa_domain].node_spanned_pages) {
 			unsigned long shouldstart =
-				node_data[numa_domain].node_start_pfn + 
-				node_data[numa_domain].node_spanned_pages;
+				init_node_data[numa_domain].node_start_pfn + 
+				init_node_data[numa_domain].node_spanned_pages;
 			if (shouldstart != (start / PAGE_SIZE)) {
 				printk(KERN_ERR "WARNING: Hole in node, "
 						"disabling region start %lx "
 						"length %lx\n", start, size);
 				continue;
 			}
-			node_data[numa_domain].node_spanned_pages +=
+			init_node_data[numa_domain].node_spanned_pages +=
 				size / PAGE_SIZE;
 		} else {
-			node_data[numa_domain].node_start_pfn =
+			init_node_data[numa_domain].node_start_pfn =
 				start / PAGE_SIZE;
-			node_data[numa_domain].node_spanned_pages =
+			init_node_data[numa_domain].node_spanned_pages =
 				size / PAGE_SIZE;
 		}
 
@@ -324,6 +334,7 @@ static void __init setup_nonnuma(void)
 		long entries = top_of_ram >> MEMORY_INCREMENT_SHIFT;
 		numa_memory_lookup_table =
 			(char *)abs_to_virt(lmb_alloc(entries * sizeof(char), 1));
+		memset(numa_memory_lookup_table, 0, entries * sizeof(char));
 		for (i = 0; i < entries ; i++)
 			numa_memory_lookup_table[i] = ARRAY_INITIALISER;
 	}
@@ -333,8 +344,8 @@ static void __init setup_nonnuma(void)
 
 	node_set_online(0);
 
-	node_data[0].node_start_pfn = 0;
-	node_data[0].node_spanned_pages = lmb_end_of_DRAM() / PAGE_SIZE;
+	init_node_data[0].node_start_pfn = 0;
+	init_node_data[0].node_spanned_pages = lmb_end_of_DRAM() / PAGE_SIZE;
 
 	for (i = 0 ; i < top_of_ram; i += MEMORY_INCREMENT)
 		numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] = 0;
@@ -403,6 +414,47 @@ static void __init dump_numa_topology(vo
 	}
 }
 
+/* 
+ * Allocate some memory, satisfying the lmb or bootmem allocator where
+ * required. nid is the preferred node and end is the physical address of
+ * the highest address in the node.
+ *
+ * Returns the physical address of the memory.
+ */
+static unsigned long careful_allocation(int nid, unsigned long size,
+					unsigned long align, unsigned long end)
+{
+	unsigned long ret = lmb_alloc_base(size, align, end);
+
+	/* retry over all memory */
+	if (!ret)
+		ret = lmb_alloc_base(size, align, lmb_end_of_DRAM());
+
+	if (!ret)
+		panic("numa.c: cannot allocate %lu bytes on node %d",
+		      size, nid);
+
+	/*
+	 * If the memory came from a previously allocated node, we must
+	 * retry with the bootmem allocator.
+	 */
+	if (pa_to_nid(ret) < nid) {
+		nid = pa_to_nid(ret);
+		ret = (unsigned long)__alloc_bootmem_node(NODE_DATA(nid),
+				size, align, 0);
+
+		if (!ret)
+			panic("numa.c: cannot allocate %lu bytes on node %d",
+			      size, nid);
+
+		ret = virt_to_abs(ret);
+
+		dbg("alloc_bootmem %lx %lx\n", ret, size);
+	}
+
+	return ret;
+}
+
 void __init do_init_bootmem(void)
 {
 	int nid;
@@ -422,24 +474,38 @@ void __init do_init_bootmem(void)
 		unsigned long bootmem_paddr;
 		unsigned long bootmap_pages;
 
-		if (node_data[nid].node_spanned_pages == 0)
-			continue;
+		start_paddr = init_node_data[nid].node_start_pfn * PAGE_SIZE;
+		end_paddr = start_paddr + (init_node_data[nid].node_spanned_pages * PAGE_SIZE);
 
-		start_paddr = node_data[nid].node_start_pfn * PAGE_SIZE;
-		end_paddr = start_paddr + 
-				(node_data[nid].node_spanned_pages * PAGE_SIZE);
-
-		dbg("node %d\n", nid);
-		dbg("start_paddr = %lx\n", start_paddr);
-		dbg("end_paddr = %lx\n", end_paddr);
+		/* Allocate the node structure node local if possible */
+		NODE_DATA(nid) = (struct pglist_data *)careful_allocation(nid,
+					sizeof(struct pglist_data),
+					SMP_CACHE_BYTES, end_paddr);
+		NODE_DATA(nid) = abs_to_virt(NODE_DATA(nid));
+		memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
 
-		NODE_DATA(nid)->bdata = &plat_node_bdata[nid];
+  		dbg("node %d\n", nid);
+		dbg("NODE_DATA() = %p\n", NODE_DATA(nid));
 
+		NODE_DATA(nid)->bdata = &plat_node_bdata[nid];
+		NODE_DATA(nid)->node_start_pfn =
+			init_node_data[nid].node_start_pfn;
+		NODE_DATA(nid)->node_spanned_pages =
+			init_node_data[nid].node_spanned_pages;
+
+		if (init_node_data[nid].node_spanned_pages == 0)
+  			continue;
+  
+  		dbg("start_paddr = %lx\n", start_paddr);
+  		dbg("end_paddr = %lx\n", end_paddr);
+  
 		bootmap_pages = bootmem_bootmap_pages((end_paddr - start_paddr) >> PAGE_SHIFT);
-		dbg("bootmap_pages = %lx\n", bootmap_pages);
 
-		bootmem_paddr = lmb_alloc_base(bootmap_pages << PAGE_SHIFT,
+		bootmem_paddr = careful_allocation(nid, 
+				bootmap_pages << PAGE_SHIFT,
 				PAGE_SIZE, end_paddr);
+		memset(abs_to_virt(bootmem_paddr), 0,
+		       bootmap_pages << PAGE_SHIFT);
 		dbg("bootmap_paddr = %lx\n", bootmem_paddr);
 
 		init_bootmem_node(NODE_DATA(nid), bootmem_paddr >> PAGE_SHIFT,
@@ -517,16 +583,6 @@ void __init paging_init(void)
 		dbg("free_area_init node %d %lx %lx (hole: %lx)\n", nid,
 		    zones_size[ZONE_DMA], start_pfn, zholes_size[ZONE_DMA]);
 
-		/* 
-		 * Give this empty node a dummy struct page to avoid
-		 * us from trying to allocate a node local mem_map
-		 * in free_area_init_node (which will fail).
-		 */
-		if (!node_data[nid].node_spanned_pages)
-			NODE_DATA(nid)->node_mem_map
-					= alloc_bootmem(sizeof(struct page));
-		else
-			NODE_DATA(nid)->node_mem_map = NULL;
 		free_area_init_node(nid, NODE_DATA(nid), zones_size,
 							start_pfn, zholes_size);
 	}
diff -puN include/asm-ppc64/mmzone.h~bootmem_fixes include/asm-ppc64/mmzone.h
--- foobar2/include/asm-ppc64/mmzone.h~bootmem_fixes	2004-09-02 17:42:23.161579947 +1000
+++ foobar2-anton/include/asm-ppc64/mmzone.h	2004-09-02 17:42:23.193577488 +1000
@@ -12,7 +12,7 @@
 
 #ifdef CONFIG_DISCONTIGMEM
 
-extern struct pglist_data node_data[];
+extern struct pglist_data *node_data[];
 
 /*
  * Following are specific to this numa platform.
@@ -52,7 +52,7 @@ static inline int pa_to_nid(unsigned lon
 /*
  * Return a pointer to the node data for node n.
  */
-#define NODE_DATA(nid)		(&node_data[nid])
+#define NODE_DATA(nid)		(node_data[nid])
 
 #define node_localnr(pfn, nid)	((pfn) - NODE_DATA(nid)->node_start_pfn)
 
_
