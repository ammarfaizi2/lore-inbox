Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVCNVRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVCNVRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVCNVQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:16:37 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:48007 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261921AbVCNVPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:15:30 -0500
Subject: [PATCH 2/4] sparsemem base: simple NUMA remap space allocator
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 14 Mar 2005 13:15:27 -0800
Message-Id: <E1DAwuO-0007o1-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce a simple allocator for the NUMA remap space.  This space is
very scarce, used for structures which are best allocated node local.

This mechanism is also used on non-NUMA ia64 systems with a vmem_map
to keep the pgdat->node_mem_map initialized in a consistent place for
all architectures.

Issues:
o alloc_remap takes a node_id where we might expect a pgdat which was intended
  to allow us to allocate the pgdat's using this mechanism; which we do not yet
  do.  Could have alloc_remap_node() and alloc_remap_nid() for this purpose.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/Kconfig        |    5 ++
 memhotplug-dave/arch/i386/mm/discontig.c |   59 ++++++++++++++++---------------
 memhotplug-dave/include/linux/bootmem.h  |    9 ++++
 memhotplug-dave/mm/page_alloc.c          |    6 ++-
 4 files changed, 50 insertions(+), 29 deletions(-)

diff -puN arch/i386/Kconfig~B-sparse-080-alloc_remap-i386 arch/i386/Kconfig
--- memhotplug/arch/i386/Kconfig~B-sparse-080-alloc_remap-i386	2005-03-14 10:57:46.000000000 -0800
+++ memhotplug-dave/arch/i386/Kconfig	2005-03-14 10:57:46.000000000 -0800
@@ -787,6 +787,11 @@ config NEED_NODE_MEMMAP_SIZE
 	depends on DISCONTIGMEM
 	default y
 
+config HAVE_ARCH_ALLOC_REMAP
+	bool
+	depends on NUMA
+	default y
+
 config HIGHPTE
 	bool "Allocate 3rd-level pagetables from highmem"
 	depends on HIGHMEM4G || HIGHMEM64G
diff -puN arch/i386/mm/discontig.c~B-sparse-080-alloc_remap-i386 arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~B-sparse-080-alloc_remap-i386	2005-03-14 10:57:46.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/discontig.c	2005-03-14 10:57:46.000000000 -0800
@@ -108,6 +108,9 @@ unsigned long node_remap_offset[MAX_NUMN
 void *node_remap_start_vaddr[MAX_NUMNODES];
 void set_pmd_pfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
 
+void *node_remap_end_vaddr[MAX_NUMNODES];
+void *node_remap_alloc_vaddr[MAX_NUMNODES];
+
 /*
  * FLAT - support for basic PC memory model with discontig enabled, essentially
  *        a single node with all available processors in it with a flat
@@ -163,6 +166,21 @@ static void __init allocate_pgdat(int ni
 	}
 }
 
+void *alloc_remap(int nid, unsigned long size)
+{
+	void *allocation = node_remap_alloc_vaddr[nid];
+
+	size = ALIGN(size, L1_CACHE_BYTES);
+
+	if (!allocation || (allocation + size) >= node_remap_end_vaddr[nid])
+		return 0;
+
+	node_remap_alloc_vaddr[nid] += size;
+	memset(allocation, 0, size);
+
+	return allocation;
+}
+
 void __init remap_numa_kva(void)
 {
 	void *vaddr;
@@ -170,8 +188,6 @@ void __init remap_numa_kva(void)
 	int node;
 
 	for_each_online_node(node) {
-		if (node == 0)
-			continue;
 		for (pfn=0; pfn < node_remap_size[node]; pfn += PTRS_PER_PTE) {
 			vaddr = node_remap_start_vaddr[node]+(pfn<<PAGE_SHIFT);
 			set_pmd_pfn((ulong) vaddr, 
@@ -188,11 +204,6 @@ static unsigned long calculate_numa_rema
 	unsigned long pfn;
 
 	for_each_online_node(nid) {
-		if (nid == 0)
-			continue;
-		if (!node_remap_size[nid])
-			continue;
-
 		/*
 		 * The acpi/srat node info can show hot-add memroy zones
 		 * where memory could be added but not currently present.
@@ -225,8 +236,8 @@ static unsigned long calculate_numa_rema
 		printk("Reserving %ld pages of KVA for lmem_map of node %d\n",
 				size, nid);
 		node_remap_size[nid] = size;
-		reserve_pages += size;
 		node_remap_offset[nid] = reserve_pages;
+		reserve_pages += size;
 		printk("Shrinking node %d from %ld pages to %ld pages\n",
 			nid, node_end_pfn[nid], node_end_pfn[nid] - size);
 		node_end_pfn[nid] -= size;
@@ -279,12 +290,18 @@ unsigned long __init setup_memory(void)
 			(ulong) pfn_to_kaddr(max_low_pfn));
 	for_each_online_node(nid) {
 		node_remap_start_vaddr[nid] = pfn_to_kaddr(
-			(highstart_pfn + reserve_pages) - node_remap_offset[nid]);
+				highstart_pfn + node_remap_offset[nid]);
+		/* Init the node remap allocator */
+		node_remap_end_vaddr[nid] = node_remap_start_vaddr[nid] +
+			(node_remap_size[nid] * PAGE_SIZE);
+		node_remap_alloc_vaddr[nid] = node_remap_start_vaddr[nid] +
+			ALIGN(sizeof(pg_data_t), PAGE_SIZE);
+
 		allocate_pgdat(nid);
 		printk ("node %d will remap to vaddr %08lx - %08lx\n", nid,
 			(ulong) node_remap_start_vaddr[nid],
-			(ulong) pfn_to_kaddr(highstart_pfn + reserve_pages
-			    - node_remap_offset[nid] + node_remap_size[nid]));
+			(ulong) pfn_to_kaddr(highstart_pfn
+			   + node_remap_offset[nid] + node_remap_size[nid]));
 	}
 	printk("High memory starts at vaddr %08lx\n",
 			(ulong) pfn_to_kaddr(highstart_pfn));
@@ -347,23 +364,9 @@ void __init zone_sizes_init(void)
 		}
 
 		zholes_size = get_zholes_size(nid);
-		/*
-		 * We let the lmem_map for node 0 be allocated from the
-		 * normal bootmem allocator, but other nodes come from the
-		 * remapped KVA area - mbligh
-		 */
-		if (!nid)
-			free_area_init_node(nid, NODE_DATA(nid),
-					zones_size, start, zholes_size);
-		else {
-			unsigned long lmem_map;
-			lmem_map = (unsigned long)node_remap_start_vaddr[nid];
-			lmem_map += sizeof(pg_data_t) + PAGE_SIZE - 1;
-			lmem_map &= PAGE_MASK;
-			NODE_DATA(nid)->node_mem_map = (struct page *)lmem_map;
-			free_area_init_node(nid, NODE_DATA(nid), zones_size,
-				start, zholes_size);
-		}
+
+		free_area_init_node(nid, NODE_DATA(nid), zones_size, start,
+				zholes_size);
 	}
 	return;
 }
diff -puN include/linux/bootmem.h~B-sparse-080-alloc_remap-i386 include/linux/bootmem.h
--- memhotplug/include/linux/bootmem.h~B-sparse-080-alloc_remap-i386	2005-03-14 10:57:46.000000000 -0800
+++ memhotplug-dave/include/linux/bootmem.h	2005-03-14 10:57:46.000000000 -0800
@@ -67,6 +67,15 @@ extern void * __init __alloc_bootmem_nod
 	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
 
+#ifdef CONFIG_HAVE_ARCH_ALLOC_REMAP
+extern void *alloc_remap(int nid, unsigned long size);
+#else
+static inline void *alloc_remap(int nid, unsigned long size)
+{
+	return NULL;
+}
+#endif
+
 extern unsigned long __initdata nr_kernel_pages;
 extern unsigned long __initdata nr_all_pages;
 
diff -puN mm/page_alloc.c~B-sparse-080-alloc_remap-i386 mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~B-sparse-080-alloc_remap-i386	2005-03-14 10:57:46.000000000 -0800
+++ memhotplug-dave/mm/page_alloc.c	2005-03-14 10:58:20.000000000 -0800
@@ -1729,6 +1729,7 @@ static void __init free_area_init_core(s
 static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 {
 	unsigned long size;
+	struct page *map;
 
 	/* Skip empty nodes */
 	if (!pgdat->node_spanned_pages)
@@ -1737,7 +1738,10 @@ static void __init alloc_node_mem_map(st
 	/* ia64 gets its own node_mem_map, before this, without bootmem */
 	if (!pgdat->node_mem_map) {
 		size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
-		pgdat->node_mem_map = alloc_bootmem_node(pgdat, size);
+		map = alloc_remap(pgdat->node_id, size);
+		if (!map)
+			map = alloc_bootmem_node(pgdat, size);
+		pgdat->node_mem_map = map;
 	}
 #ifndef CONFIG_DISCONTIGMEM
 	/*
_
