Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVBRAIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVBRAIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 19:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVBRAIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 19:08:51 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:51615 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261255AbVBRAEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 19:04:04 -0500
Subject: [RFC][PATCH] Sparse Memory Handling (hot-add foundation)
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
       "David C. Hansen [imap]" <haveblue@us.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>
Content-Type: multipart/mixed; boundary="=-A3i1EPyLLA3BSUWJ5xIF"
Date: Thu, 17 Feb 2005 16:03:53 -0800
Message-Id: <1108685033.6482.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-A3i1EPyLLA3BSUWJ5xIF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch, largely written by Andy Whitcroft, implements a
feature which is similar to DISCONTIGMEM, but has some added features.
Instead of splitting up the mem_map for each NUMA node, this splits it
up into areas that represent fixed blocks of memory.  This allows
individual pieces of that memory to be easily added and removed.

Because it is so similar to DISCONTIGMEM, it can actually be used in
place of it on NUMA systems such as the NUMAQ, or Summit architectures.
This patch includes an i386 and ppc64 implementation, but there are
x86_64 and ia64 implementations as well.

There are a number of individual patches (with descriptions) which are
rolled up in the attached patch: all of the files up to and including
"G2-no-memory-at-high_memory-ppc64.patch" from this directory:
http://www.sr71.net/patches/2.6.11/2.6.11-rc3-mhp1/broken-out/

I can post individual patches if anyone would like to comment on them.  

-- Dave

--=-A3i1EPyLLA3BSUWJ5xIF
Content-Disposition: attachment; filename=sparse-2.6.11-rc3.patch
Content-Type: text/x-patch; name=sparse-2.6.11-rc3.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- sparse/arch/arm/mm/init.c~A6-no_arch_mem_map_init	2005-02-17 15:47:42.000000000 -0800
+++ /arch/arm/mm/init.c	2005-02-17 15:47:42.000000000 -0800
@@ -501,10 +501,6 @@
 				bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
 	}
 
-#ifndef CONFIG_DISCONTIGMEM
-	mem_map = contig_page_data.node_mem_map;
-#endif
-
 	/*
 	 * finish off the bad pages once
 	 * the mem_map is initialised
--- sparse/arch/arm26/mm/init.c~A6-no_arch_mem_map_init	2005-02-17 15:47:42.000000000 -0800
+++ /arch/arm26/mm/init.c	2005-02-17 15:47:42.000000000 -0800
@@ -309,8 +309,6 @@
 	free_area_init_node(0, pgdat, zone_size,
 			bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
 
-	mem_map = NODE_DATA(0)->node_mem_map;
-
 	/*
 	 * finish off the bad pages once
 	 * the mem_map is initialised
--- sparse/arch/cris/arch-v10/mm/init.c~A6-no_arch_mem_map_init	2005-02-17 15:47:42.000000000 -0800
+++ /arch/cris/arch-v10/mm/init.c	2005-02-17 15:47:42.000000000 -0800
@@ -184,7 +184,6 @@
 	 */
 
 	free_area_init_node(0, &contig_page_data, zones_size, PAGE_OFFSET >> PAGE_SHIFT, 0);
-	mem_map = contig_page_data.node_mem_map;
 }
 
 /* Initialize remaps of some I/O-ports. It is important that this
--- sparse/arch/i386/Kconfig~B-sparse-080-alloc_remap-i386	2005-02-17 15:47:43.000000000 -0800
+++ /arch/i386/Kconfig	2005-02-17 15:47:47.000000000 -0800
@@ -68,7 +68,7 @@
 
 config X86_NUMAQ
 	bool "NUMAQ (IBM/Sequent)"
-	select DISCONTIGMEM
+	#select DISCONTIGMEM
 	select NUMA
 	help
 	  This option is used for getting Linux to run on a (IBM/Sequent) NUMA
@@ -759,16 +759,22 @@
 comment "NUMA (Summit) requires SMP, 64GB highmem support, ACPI"
 	depends on X86_SUMMIT && (!HIGHMEM64G || !ACPI)
 
-config DISCONTIGMEM
+config HAVE_ARCH_BOOTMEM_NODE
 	bool
 	depends on NUMA
 	default y
 
-config HAVE_ARCH_BOOTMEM_NODE
+config HAVE_ARCH_ALLOC_REMAP
 	bool
 	depends on NUMA
 	default y
 
+config ARCH_SPARSEMEM_DEFAULT
+	bool
+	depends on (X86_NUMAQ || X86_SUMMIT)
+
+source "mm/Kconfig"
+
 config HIGHPTE
 	bool "Allocate 3rd-level pagetables from highmem"
 	depends on HIGHMEM4G || HIGHMEM64G
--- sparse/arch/i386/kernel/numaq.c~B-sparse-140-abstract-discontig	2005-02-17 15:47:45.000000000 -0800
+++ /arch/i386/kernel/numaq.c	2005-02-17 15:47:45.000000000 -0800
@@ -32,7 +32,7 @@
 #include <asm/numaq.h>
 
 /* These are needed before the pgdat's are created */
-extern long node_start_pfn[], node_end_pfn[];
+extern long node_start_pfn[], node_end_pfn[], node_remap_size[];
 
 #define	MB_TO_PAGES(addr) ((addr) << (20 - PAGE_SHIFT))
 
@@ -59,6 +59,8 @@
 				eq->hi_shrd_mem_start - eq->priv_mem_size);
 			node_end_pfn[node] = MB_TO_PAGES(
 				eq->hi_shrd_mem_start + eq->hi_shrd_mem_size);
+			node_remap_size[node] += memory_present(node,
+				node_start_pfn[node], node_end_pfn[node]);
 		}
 	}
 }
--- sparse/arch/i386/kernel/setup.c~FROM-MM-refactor-i386-memory-setup	2005-02-17 15:47:38.000000000 -0800
+++ /arch/i386/kernel/setup.c	2005-02-17 15:48:55.000000000 -0800
@@ -40,6 +40,8 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/edd.h>
+#include <linux/nodemask.h>
+#include <linux/mmzone.h>
 #include <video/edid.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
@@ -951,8 +953,6 @@
 	return max_low_pfn;
 }
 
-#ifndef CONFIG_DISCONTIGMEM
-
 /*
  * Free all available memory for boot time allocation.  Used
  * as a callback function by efi_memory_walk()
@@ -1026,15 +1026,15 @@
 		reserve_bootmem(addr, PAGE_SIZE);	
 }
 
+#ifndef CONFIG_DISCONTIGMEM
+void __init setup_bootmem_allocator(void);
 static unsigned long __init setup_memory(void)
 {
-	unsigned long bootmap_size, start_pfn, max_low_pfn;
-
 	/*
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
 	 */
-	start_pfn = PFN_UP(init_pg_tables_end);
+	min_low_pfn = PFN_UP(init_pg_tables_end);
 
 	find_max_pfn();
 
@@ -1050,10 +1050,52 @@
 #endif
 	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
 			pages_to_mb(max_low_pfn));
+
+	setup_bootmem_allocator();
+
+	/*
+	 * This will only work for contiguous memory systems.
+	 *
+	 * Leave the evil #ifdef as a big FIXME until you do
+	 * this properly
+	 */
+#ifdef CONFIG_SPARSEMEM
+	memory_present(/*node*/0, /*start_pfn*/0, max_pfn);
+#endif
+	return max_low_pfn;
+}
+
+void __init zone_sizes_init(void)
+{
+	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned int max_dma, low;
+
+	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+	low = max_low_pfn;
+
+	if (low < max_dma)
+		zones_size[ZONE_DMA] = low;
+	else {
+		zones_size[ZONE_DMA] = max_dma;
+		zones_size[ZONE_NORMAL] = low - max_dma;
+#ifdef CONFIG_HIGHMEM
+		zones_size[ZONE_HIGHMEM] = highend_pfn - low;
+#endif
+	}
+	free_area_init(zones_size);
+}
+#else
+extern unsigned long __init setup_memory(void);
+extern void zone_sizes_init(void);
+#endif /* !CONFIG_DISCONTIGMEM */
+
+void __init setup_bootmem_allocator(void)
+{
+	unsigned long bootmap_size;
 	/*
 	 * Initialize the boot-time allocator (with low memory only):
 	 */
-	bootmap_size = init_bootmem(start_pfn, max_low_pfn);
+	bootmap_size = init_bootmem(min_low_pfn, max_low_pfn);
 
 	register_bootmem_low_pages(max_low_pfn);
 
@@ -1063,7 +1105,7 @@
 	 * the (very unlikely) case of us accidentally initializing the
 	 * bootmem allocator with an invalid RAM area.
 	 */
-	reserve_bootmem(HIGH_MEMORY, (PFN_PHYS(start_pfn) +
+	reserve_bootmem(HIGH_MEMORY, (PFN_PHYS(min_low_pfn) +
 			 bootmap_size + PAGE_SIZE-1) - (HIGH_MEMORY));
 
 	/*
@@ -1120,11 +1162,25 @@
 		}
 	}
 #endif
-	return max_low_pfn;
 }
-#else
-extern unsigned long setup_memory(void);
-#endif /* !CONFIG_DISCONTIGMEM */
+
+/*
+ * The node 0 pgdat is initialized before all of these because
+ * it's needed for bootmem.  node>0 pgdats have their virtual
+ * space allocated before the pagetables are in place to access
+ * them, so they can't be cleared then.
+ *
+ * This should all compile down to nothing when NUMA is off.
+ */
+void __init remapped_pgdat_init(void)
+{
+	int nid;
+
+	for_each_online_node(nid) {
+		if (nid != 0)
+			memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
+	}
+}
 
 /*
  * Request address space for all standard RAM and ROM resources
@@ -1395,6 +1451,9 @@
 	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
 #endif
 	paging_init();
+	remapped_pgdat_init();
+	sparse_init();
+	zone_sizes_init();
 
 	/*
 	 * NOTE: at this point the bootmem allocator is fully available.
--- sparse/arch/i386/kernel/srat.c~B-sparse-140-abstract-discontig	2005-02-17 15:47:45.000000000 -0800
+++ /arch/i386/kernel/srat.c	2005-02-17 15:47:45.000000000 -0800
@@ -58,7 +58,7 @@
 static int zholes_size_init;
 static unsigned long zholes_size[MAX_NUMNODES * MAX_NR_ZONES];
 
-extern unsigned long node_start_pfn[], node_end_pfn[];
+extern unsigned long node_start_pfn[], node_end_pfn[], node_remap_size[];
 
 extern void * boot_ioremap(unsigned long, unsigned long);
 
@@ -266,6 +266,10 @@
 		       j, node_memory_chunk[j].nid,
 		       node_memory_chunk[j].start_pfn,
 		       node_memory_chunk[j].end_pfn);
+		node_remap_size[node_memory_chunk[j].nid] += memory_present(
+						node_memory_chunk[j].nid,
+						node_memory_chunk[j].start_pfn,
+						node_memory_chunk[j].end_pfn);
 	}
  
 	/*calculate node_start_pfn/node_end_pfn arrays*/
--- sparse/arch/i386/mm/Makefile~B-sparse-160-sparsemem-i386	2005-02-17 15:47:47.000000000 -0800
+++ /arch/i386/mm/Makefile	2005-02-17 15:47:47.000000000 -0800
@@ -4,7 +4,7 @@
 
 obj-y	:= init.o pgtable.o fault.o ioremap.o extable.o pageattr.o mmap.o
 
-obj-$(CONFIG_DISCONTIGMEM)	+= discontig.o
+obj-$(CONFIG_NUMA) += discontig.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_BOOT_IOREMAP) += boot_ioremap.o
--- sparse/arch/i386/mm/boot_ioremap.c~FROM-MM-mostly-i386-mm-cleanup	2005-02-17 15:47:39.000000000 -0800
+++ /arch/i386/mm/boot_ioremap.c	2005-02-17 15:47:39.000000000 -0800
@@ -61,8 +61,8 @@
 /* the virtual space we're going to remap comes from this array */
 #define BOOT_IOREMAP_PAGES 4
 #define BOOT_IOREMAP_SIZE (BOOT_IOREMAP_PAGES*PAGE_SIZE)
-__initdata char boot_ioremap_space[BOOT_IOREMAP_SIZE] 
-		__attribute__ ((aligned (PAGE_SIZE)));
+static __initdata char boot_ioremap_space[BOOT_IOREMAP_SIZE]
+		       __attribute__ ((aligned (PAGE_SIZE)));
 
 /*
  * This only applies to things which need to ioremap before paging_init()
--- sparse/arch/i386/mm/discontig.c~FROM-MM-consolidate-set_max_mapnr_init-implementations	2005-02-17 15:47:37.000000000 -0800
+++ /arch/i386/mm/discontig.c	2005-02-17 15:47:49.000000000 -0800
@@ -42,12 +42,17 @@
  *                  populated the following initialisation.
  *
  * 1) node_online_map  - the map of all nodes configured (online) in the system
- * 2) physnode_map     - the mapping between a pfn and owning node
- * 3) node_start_pfn   - the starting page frame number for a node
+ * 2) node_start_pfn   - the starting page frame number for a node
  * 3) node_end_pfn     - the ending page fram number for a node
  */
+unsigned long node_start_pfn[MAX_NUMNODES];
+unsigned long node_end_pfn[MAX_NUMNODES];
+
+#ifdef CONFIG_DISCONTIGMEM
+/* XXX: this chunk is really the correct contents of discontig.c */
 
 /*
+ * 4) physnode_map     - the mapping between a pfn and owning node
  * physnode_map keeps track of the physical memory layout of a generic
  * numa node on a 256Mb break (each element of the array will
  * represent 256Mb of memory and will be marked by the node id.  so,
@@ -60,8 +65,23 @@
  */
 s8 physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
 
-unsigned long node_start_pfn[MAX_NUMNODES];
-unsigned long node_end_pfn[MAX_NUMNODES];
+unsigned long memory_present(int nid, unsigned long start, unsigned long end)
+{
+	unsigned long pfn;
+
+	printk(KERN_INFO "Node: %d, start_pfn: %ld, end_pfn: %ld\n",
+			nid, start, end);
+	printk(KERN_DEBUG "  Setting physnode_map array to node %d for pfns:\n", nid);
+	printk(KERN_DEBUG "  ");
+	for (pfn = start; pfn < end; pfn += PAGES_PER_ELEMENT) {
+		physnode_map[pfn / PAGES_PER_ELEMENT] = nid;
+		printk(KERN_DEBUG "%ld ", pfn);
+	}
+	printk(KERN_DEBUG "\n");
+
+	return (end - start + 1) * sizeof(struct page);
+}
+#endif
 
 extern unsigned long find_max_low_pfn(void);
 extern void find_max_pfn(void);
@@ -82,6 +102,9 @@
 void *node_remap_start_vaddr[MAX_NUMNODES];
 void set_pmd_pfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
 
+void *node_remap_end_vaddr[MAX_NUMNODES];
+void *node_remap_alloc_vaddr[MAX_NUMNODES];
+
 /*
  * FLAT - support for basic PC memory model with discontig enabled, essentially
  *        a single node with all available processors in it with a flat
@@ -119,6 +142,18 @@
 		BUG();
 }
 
+/* Find the owning node for a pfn. */
+int early_pfn_to_nid(unsigned long pfn)
+{
+	int nid;
+
+	for (nid = 0; nid < MAX_NUMNODES && node_end_pfn[nid] != 0; nid++)
+		if (node_start_pfn[nid] <= pfn && node_end_pfn[nid] >= pfn)
+			return nid;
+
+	return 0;
+}
+
 /* 
  * Allocate memory for the pg_data_t for this node via a crude pre-bootmem
  * method.  For node zero take this from the bottom of memory, for
@@ -133,48 +168,22 @@
 	else {
 		NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
 		min_low_pfn += PFN_UP(sizeof(pg_data_t));
-		memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
 	}
 }
 
-/*
- * Register fully available low RAM pages with the bootmem allocator.
- */
-static void __init register_bootmem_low_pages(unsigned long system_max_low_pfn)
+void *alloc_remap(int nid, unsigned long size)
 {
-	int i;
+	void *allocation = node_remap_alloc_vaddr[nid];
 
-	for (i = 0; i < e820.nr_map; i++) {
-		unsigned long curr_pfn, last_pfn, size;
-		/*
-		 * Reserve usable low memory
-		 */
-		if (e820.map[i].type != E820_RAM)
-			continue;
-		/*
-		 * We are rounding up the start address of usable memory:
-		 */
-		curr_pfn = PFN_UP(e820.map[i].addr);
-		if (curr_pfn >= system_max_low_pfn)
-			continue;
-		/*
-		 * ... and at the end of the usable range downwards:
-		 */
-		last_pfn = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
+	size = ALIGN(size, L1_CACHE_BYTES);
 
-		if (last_pfn > system_max_low_pfn)
-			last_pfn = system_max_low_pfn;
+	if (!allocation || (allocation + size) >= node_remap_end_vaddr[nid])
+		return 0;
 
-		/*
-		 * .. finally, did all the rounding and playing
-		 * around just make the area go away?
-		 */
-		if (last_pfn <= curr_pfn)
-			continue;
+	node_remap_alloc_vaddr[nid] += size;
+	memset(allocation, 0, size);
 
-		size = last_pfn - curr_pfn;
-		free_bootmem_node(NODE_DATA(0), PFN_PHYS(curr_pfn), PFN_PHYS(size));
-	}
+	return allocation;
 }
 
 void __init remap_numa_kva(void)
@@ -184,8 +193,6 @@
 	int node;
 
 	for_each_online_node(node) {
-		if (node == 0)
-			continue;
 		for (pfn=0; pfn < node_remap_size[node]; pfn += PTRS_PER_PTE) {
 			vaddr = node_remap_start_vaddr[node]+(pfn<<PAGE_SHIFT);
 			set_pmd_pfn((ulong) vaddr, 
@@ -199,22 +206,44 @@
 {
 	int nid;
 	unsigned long size, reserve_pages = 0;
+	unsigned long pfn;
 
 	for_each_online_node(nid) {
-		if (nid == 0)
+		/*
+		 * The acpi/srat node info can show hot-add memroy zones
+		 * where memory could be added but not currently present.
+		 */
+		if (node_start_pfn[nid] > max_pfn)
 			continue;
-		/* calculate the size of the mem_map needed in bytes */
-		size = (node_end_pfn[nid] - node_start_pfn[nid] + 1) 
-			* sizeof(struct page) + sizeof(pg_data_t);
+
+		if (node_end_pfn[nid] > max_pfn)
+			node_end_pfn[nid] = max_pfn;
+
+		/* ensure the remap includes space for the pgdat. */
+		size = node_remap_size[nid] + sizeof(pg_data_t);
+
 		/* convert size to large (pmd size) pages, rounding up */
 		size = (size + LARGE_PAGE_BYTES - 1) / LARGE_PAGE_BYTES;
 		/* now the roundup is correct, convert to PAGE_SIZE pages */
 		size = size * PTRS_PER_PTE;
+
+		/*
+		 * Validate the region we are allocating only contains valid
+		 * pages.
+		 */
+		for (pfn = node_end_pfn[nid] - size;
+		     pfn < node_end_pfn[nid]; pfn++)
+			if (!page_is_ram(pfn))
+				break;
+
+		if (pfn != node_end_pfn[nid])
+			size = 0;
+
 		printk("Reserving %ld pages of KVA for lmem_map of node %d\n",
 				size, nid);
 		node_remap_size[nid] = size;
-		reserve_pages += size;
 		node_remap_offset[nid] = reserve_pages;
+		reserve_pages += size;
 		printk("Shrinking node %d from %ld pages to %ld pages\n",
 			nid, node_end_pfn[nid], node_end_pfn[nid] - size);
 		node_end_pfn[nid] -= size;
@@ -225,22 +254,12 @@
 	return reserve_pages;
 }
 
-/*
- * workaround for Dell systems that neglect to reserve EBDA
- */
-static void __init reserve_ebda_region_node(void)
-{
-	unsigned int addr;
-	addr = get_bios_ebda();
-	if (addr)
-		reserve_bootmem_node(NODE_DATA(0), addr, PAGE_SIZE);
-}
-
+extern void setup_bootmem_allocator(void);
 unsigned long __init setup_memory(void)
 {
 	int nid;
-	unsigned long bootmap_size, system_start_pfn, system_max_low_pfn;
-	unsigned long reserve_pages, pfn;
+	unsigned long system_start_pfn, system_max_low_pfn;
+	unsigned long reserve_pages;
 
 	/*
 	 * When mapping a NUMA machine we allocate the node_mem_map arrays
@@ -251,26 +270,11 @@
 	 */
 	get_memcfg_numa();
 
-	/* Fill in the physnode_map */
-	for_each_online_node(nid) {
-		printk("Node: %d, start_pfn: %ld, end_pfn: %ld\n",
-				nid, node_start_pfn[nid], node_end_pfn[nid]);
-		printk("  Setting physnode_map array to node %d for pfns:\n  ",
-				nid);
-		for (pfn = node_start_pfn[nid]; pfn < node_end_pfn[nid];
-	       				pfn += PAGES_PER_ELEMENT) {
-			physnode_map[pfn / PAGES_PER_ELEMENT] = nid;
-			printk("%ld ", pfn);
-		}
-		printk("\n");
-	}
-
 	reserve_pages = calculate_numa_remap_pages();
 
 	/* partially used pages are not usable - thus round upwards */
 	system_start_pfn = min_low_pfn = PFN_UP(init_pg_tables_end);
 
-	find_max_pfn();
 	system_max_low_pfn = max_low_pfn = find_max_low_pfn() - reserve_pages;
 	printk("reserve_pages = %ld find_max_low_pfn() ~ %ld\n",
 			reserve_pages, max_low_pfn + reserve_pages);
@@ -291,12 +295,18 @@
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
@@ -304,70 +314,10 @@
 	for_each_online_node(nid)
 		find_max_pfn_node(nid);
 
+	memset(NODE_DATA(0), 0, sizeof(struct pglist_data));
 	NODE_DATA(0)->bdata = &node0_bdata;
-
-	/*
-	 * Initialize the boot-time allocator (with low memory only):
-	 */
-	bootmap_size = init_bootmem_node(NODE_DATA(0), min_low_pfn, 0, system_max_low_pfn);
-
-	register_bootmem_low_pages(system_max_low_pfn);
-
-	/*
-	 * Reserve the bootmem bitmap itself as well. We do this in two
-	 * steps (first step was init_bootmem()) because this catches
-	 * the (very unlikely) case of us accidentally initializing the
-	 * bootmem allocator with an invalid RAM area.
-	 */
-	reserve_bootmem_node(NODE_DATA(0), HIGH_MEMORY, (PFN_PHYS(min_low_pfn) +
-		 bootmap_size + PAGE_SIZE-1) - (HIGH_MEMORY));
-
-	/*
-	 * reserve physical page 0 - it's a special BIOS page on many boxes,
-	 * enabling clean reboots, SMP operation, laptop functions.
-	 */
-	reserve_bootmem_node(NODE_DATA(0), 0, PAGE_SIZE);
-
-	/*
-	 * But first pinch a few for the stack/trampoline stuff
-	 * FIXME: Don't need the extra page at 4K, but need to fix
-	 * trampoline before removing it. (see the GDT stuff)
-	 */
-	reserve_bootmem_node(NODE_DATA(0), PAGE_SIZE, PAGE_SIZE);
-
-	/* reserve EBDA region, it's a 4K region */
-	reserve_ebda_region_node();
-
-#ifdef CONFIG_ACPI_SLEEP
-	/*
-	 * Reserve low memory region for sleep support.
-	 */
-	acpi_reserve_bootmem();
-#endif
-
-	/*
-	 * Find and reserve possible boot-time SMP configuration:
-	 */
-	find_smp_config();
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (LOADER_TYPE && INITRD_START) {
-		if (INITRD_START + INITRD_SIZE <= (system_max_low_pfn << PAGE_SHIFT)) {
-			reserve_bootmem_node(NODE_DATA(0), INITRD_START, INITRD_SIZE);
-			initrd_start =
-				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
-			initrd_end = initrd_start+INITRD_SIZE;
-		}
-		else {
-			printk(KERN_ERR "initrd extends beyond end of memory "
-			    "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
-			    INITRD_START + INITRD_SIZE,
-			    system_max_low_pfn << PAGE_SHIFT);
-			initrd_start = 0;
-		}
-	}
-#endif
-	return system_max_low_pfn;
+	setup_bootmem_allocator();
+	return max_low_pfn;
 }
 
 void __init zone_sizes_init(void)
@@ -382,8 +332,6 @@
 	for (nid = MAX_NUMNODES - 1; nid >= 0; nid--) {
 		if (!node_online(nid))
 			continue;
-		if (nid)
-			memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
 		NODE_DATA(nid)->pgdat_next = pgdat_list;
 		pgdat_list = NODE_DATA(nid);
 	}
@@ -418,23 +366,9 @@
 			}
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
@@ -443,35 +377,34 @@
 {
 #ifdef CONFIG_HIGHMEM
 	struct zone *zone;
+	struct page *page;
 
 	for_each_zone(zone) {
-		unsigned long node_pfn, node_high_size, zone_start_pfn;
-		struct page * zone_mem_map;
-		
+		unsigned long node_pfn, zone_start_pfn, zone_end_pfn;
+
 		if (!is_highmem(zone))
 			continue;
 
-		printk("Initializing %s for node %d\n", zone->name,
-			zone->zone_pgdat->node_id);
-
-		node_high_size = zone->spanned_pages;
-		zone_mem_map = zone->zone_mem_map;
 		zone_start_pfn = zone->zone_start_pfn;
+		zone_end_pfn = zone_start_pfn + zone->spanned_pages;
+
+		printk("Initializing %s for node %d (%08lx:%08lx)\n",
+				zone->name, zone->zone_pgdat->node_id,
+				zone_start_pfn, zone_end_pfn);
 
-		for (node_pfn = 0; node_pfn < node_high_size; node_pfn++) {
-			one_highpage_init((struct page *)(zone_mem_map + node_pfn),
-					  zone_start_pfn + node_pfn, bad_ppro);
+		/*
+		 * Make use of the guarentee that *_mem_map will be
+		 * contigious in sections aligned at MAX_ORDER.
+		 */
+		page = pfn_to_page(zone_start_pfn);
+		for (node_pfn = zone_start_pfn; node_pfn < zone_end_pfn; node_pfn++, page++) {
+			if (!pfn_valid(node_pfn))
+				continue;
+			if ((node_pfn & ((1 << MAX_ORDER) - 1)) == 0)
+				page = pfn_to_page(node_pfn);
+			one_highpage_init(page, node_pfn, bad_ppro);
 		}
 	}
 	totalram_pages += totalhigh_pages;
 #endif
 }
-
-void __init set_max_mapnr_init(void)
-{
-#ifdef CONFIG_HIGHMEM
-	num_physpages = highend_pfn;
-#else
-	num_physpages = max_low_pfn;
-#endif
-}
--- sparse/arch/i386/mm/init.c~FROM-MM-consolidate-set_max_mapnr_init-implementations	2005-02-17 15:47:37.000000000 -0800
+++ /arch/i386/mm/init.c	2005-02-17 15:48:56.000000000 -0800
@@ -191,7 +191,7 @@
 
 extern int is_available_memory(efi_memory_desc_t *);
 
-static inline int page_is_ram(unsigned long pagenr)
+int page_is_ram(unsigned long pagenr)
 {
 	int i;
 	unsigned long addr, end;
@@ -239,7 +239,7 @@
 #define kmap_get_fixmap_pte(vaddr)					\
 	pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(vaddr), vaddr), (vaddr)), (vaddr))
 
-void __init kmap_init(void)
+static void __init kmap_init(void)
 {
 	unsigned long kmap_vstart;
 
@@ -250,7 +250,7 @@
 	kmap_prot = PAGE_KERNEL;
 }
 
-void __init permanent_kmaps_init(pgd_t *pgd_base)
+static void __init permanent_kmaps_init(pgd_t *pgd_base)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -280,17 +280,17 @@
 		SetPageReserved(page);
 }
 
-#ifndef CONFIG_DISCONTIGMEM
-void __init set_highmem_pages_init(int bad_ppro) 
+#ifdef CONFIG_NUMA
+extern void set_highmem_pages_init(int);
+#else
+static void __init set_highmem_pages_init(int bad_ppro)
 {
 	int pfn;
 	for (pfn = highstart_pfn; pfn < highend_pfn; pfn++)
 		one_highpage_init(pfn_to_page(pfn), pfn, bad_ppro);
 	totalram_pages += totalhigh_pages;
 }
-#else
-extern void set_highmem_pages_init(int);
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_FLATMEM */
 
 #else
 #define kmap_init() do { } while (0)
@@ -301,10 +301,10 @@
 unsigned long long __PAGE_KERNEL = _PAGE_KERNEL;
 unsigned long long __PAGE_KERNEL_EXEC = _PAGE_KERNEL_EXEC;
 
-#ifndef CONFIG_DISCONTIGMEM
-#define remap_numa_kva() do {} while (0)
-#else
+#ifdef CONFIG_NUMA
 extern void __init remap_numa_kva(void);
+#else
+#define remap_numa_kva() do {} while (0)
 #endif
 
 static void __init pagetable_init (void)
@@ -394,31 +394,6 @@
 	flush_tlb_all();
 }
 
-#ifndef CONFIG_DISCONTIGMEM
-void __init zone_sizes_init(void)
-{
-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
-	unsigned int max_dma, high, low;
-	
-	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-	low = max_low_pfn;
-	high = highend_pfn;
-	
-	if (low < max_dma)
-		zones_size[ZONE_DMA] = low;
-	else {
-		zones_size[ZONE_DMA] = max_dma;
-		zones_size[ZONE_NORMAL] = low - max_dma;
-#ifdef CONFIG_HIGHMEM
-		zones_size[ZONE_HIGHMEM] = high - low;
-#endif
-	}
-	free_area_init(zones_size);	
-}
-#else
-extern void zone_sizes_init(void);
-#endif /* !CONFIG_DISCONTIGMEM */
-
 static int disable_nx __initdata = 0;
 u64 __supported_pte_mask = ~_PAGE_NX;
 
@@ -519,7 +494,6 @@
 	__flush_tlb_all();
 
 	kmap_init();
-	zone_sizes_init();
 }
 
 /*
@@ -529,7 +503,7 @@
  * but fortunately the switch to using exceptions got rid of all that.
  */
 
-void __init test_wp_bit(void)
+static void __init test_wp_bit(void)
 {
 	printk("Checking if this processor honours the WP bit even in supervisor mode... ");
 
@@ -548,20 +522,17 @@
 	}
 }
 
-#ifndef CONFIG_DISCONTIGMEM
 static void __init set_max_mapnr_init(void)
 {
 #ifdef CONFIG_HIGHMEM
-	max_mapnr = num_physpages = highend_pfn;
+	num_physpages = highend_pfn;
 #else
-	max_mapnr = num_physpages = max_low_pfn;
+	num_physpages = max_low_pfn;
+#endif
+#ifdef CONFIG_FLATMEM
+	max_mapnr = num_physpages;
 #endif
 }
-#define __free_all_bootmem() free_all_bootmem()
-#else
-#define __free_all_bootmem() free_all_bootmem_node(NODE_DATA(0))
-extern void set_max_mapnr_init(void);
-#endif /* !CONFIG_DISCONTIGMEM */
 
 static struct kcore_list kcore_mem, kcore_vmalloc; 
 
@@ -572,7 +543,7 @@
 	int tmp;
 	int bad_ppro;
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 	if (!mem_map)
 		BUG();
 #endif
@@ -592,13 +563,13 @@
 	set_max_mapnr_init();
 
 #ifdef CONFIG_HIGHMEM
-	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE);
+	high_memory = (char *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
 #else
-	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
+	high_memory = (char *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
 #endif
 
 	/* this will put all low memory onto the freelists */
-	totalram_pages += __free_all_bootmem();
+	totalram_pages += free_all_bootmem();
 
 	reservedpages = 0;
 	for (tmp = 0; tmp < max_low_pfn; tmp++)
--- sparse/arch/ia64/mm/contig.c~A6-no_arch_mem_map_init	2005-02-17 15:47:42.000000000 -0800
+++ /arch/ia64/mm/contig.c	2005-02-17 15:47:42.000000000 -0800
@@ -283,7 +283,7 @@
 		vmem_map = (struct page *) vmalloc_end;
 		efi_memmap_walk(create_mem_map_page_table, NULL);
 
-		mem_map = contig_page_data.node_mem_map = vmem_map;
+		NODE_DATA(0)->node_mem_map = vmem_map;
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    0, zholes_size);
 
--- sparse/arch/m32r/mm/init.c~A6-no_arch_mem_map_init	2005-02-17 15:47:42.000000000 -0800
+++ /arch/m32r/mm/init.c	2005-02-17 15:47:42.000000000 -0800
@@ -121,8 +121,6 @@
 
 	free_area_init_node(0, NODE_DATA(0), zones_size, start_pfn, 0);
 
-	mem_map = contig_page_data.node_mem_map;
-
 	return 0;
 }
 #else	/* CONFIG_DISCONTIGMEM */
--- sparse/arch/ppc64/Kconfig~B-sparse-170-sparsemem-ppc64	2005-02-17 15:47:48.000000000 -0800
+++ /arch/ppc64/Kconfig	2005-02-17 15:47:51.000000000 -0800
@@ -192,17 +192,32 @@
 	depends on SMP
 	default "32"
 
+config ARCH_HAS_BOOTPA
+	bool
+	default y
+
 config HMT
 	bool "Hardware multithreading"
 	depends on SMP && PPC_PSERIES
 
-config DISCONTIGMEM
-	bool "Discontiguous Memory Support"
-	depends on SMP && PPC_PSERIES
+source "mm/Kconfig"
+
+config ARCH_SPARSEMEM_DEFAULT
+	bool
+	depends on PPC_PSERIES
+
+config ARCH_DISCONTIGMEM_DISABLE
+	bool
+	depends on !SMP || !PPC_PSERIES
+
+config ARCH_SPARSEMEM_DISABLE
+	bool
+	depends on !SMP || !PPC_PSERIES
 
 config NUMA
 	bool "NUMA support"
-	depends on DISCONTIGMEM
+	default y if (DISCONTIGMEM)
+	default y if (SPARSEMEM)
 
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
--- sparse/arch/ppc64/kernel/prom_init.c~G0-ppc64-__boot-fixes	2005-02-17 15:47:51.000000000 -0800
+++ /arch/ppc64/kernel/prom_init.c	2005-02-17 15:47:51.000000000 -0800
@@ -913,11 +913,11 @@
 	extern unsigned long __secondary_hold_spinloop;
 	extern unsigned long __secondary_hold_acknowledge;
 	unsigned long *spinloop
-		= (void *)virt_to_abs(&__secondary_hold_spinloop);
+		= (void *)boot_virt_to_abs(&__secondary_hold_spinloop);
 	unsigned long *acknowledge
-		= (void *)virt_to_abs(&__secondary_hold_acknowledge);
+		= (void *)boot_virt_to_abs(&__secondary_hold_acknowledge);
 	unsigned long secondary_hold
-		= virt_to_abs(*PTRRELOC((unsigned long *)__secondary_hold));
+		= boot_virt_to_abs(*PTRRELOC((unsigned long *)__secondary_hold));
 	struct prom_t *_prom = PTRRELOC(&prom);
 
 	prom_debug("prom_hold_cpus: start...\n");
@@ -1563,7 +1563,7 @@
 	if ( r3 && r4 && r4 != 0xdeadbeef) {
 		u64 val;
 
-		RELOC(prom_initrd_start) = (r3 >= KERNELBASE) ? __pa(r3) : r3;
+		RELOC(prom_initrd_start) = (r3 >= KERNELBASE) ? __boot_pa(r3) : r3;
 		RELOC(prom_initrd_end) = RELOC(prom_initrd_start) + r4;
 
 		val = (u64)RELOC(prom_initrd_start);
--- sparse/arch/ppc64/kernel/rtas.c~G0-ppc64-__boot-fixes	2005-02-17 15:47:51.000000000 -0800
+++ /arch/ppc64/kernel/rtas.c	2005-02-17 15:47:51.000000000 -0800
@@ -36,6 +36,7 @@
 struct rtas_t rtas = { 
 	.lock = SPIN_LOCK_UNLOCKED
 };
+static unsigned long rtas_args_paddr;
 
 EXPORT_SYMBOL(rtas);
 
@@ -192,8 +193,7 @@
 	for (i = 0; i < nret; ++i)
 		rtas_args->rets[i] = 0;
 
-	PPCDBG(PPCDBG_RTAS, "\tentering rtas with 0x%lx\n",
-		__pa(rtas_args));
+	PPCDBG(PPCDBG_RTAS, "\tentering rtas with 0x%lx\n", rtas_args_paddr);
 	enter_rtas(__pa(rtas_args));
 	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");
 
@@ -605,6 +605,8 @@
 #endif /* CONFIG_HOTPLUG_CPU */
 	}
 
+	/* Get and save off phys address of rtas structure argunemt field */
+	rtas_args_paddr = __boot_pa(&rtas.args);
 }
 
 
--- sparse/arch/ppc64/kernel/setup.c~G0-ppc64-__boot-fixes	2005-02-17 15:47:51.000000000 -0800
+++ /arch/ppc64/kernel/setup.c	2005-02-17 15:47:51.000000000 -0800
@@ -411,7 +411,7 @@
 	 * tree, like retreiving the physical memory map or
 	 * calculating/retreiving the hash table size
 	 */
-	early_init_devtree(__va(dt_ptr));
+	early_init_devtree(__boot_va(dt_ptr));
 
 	/*
 	 * Iterate all ppc_md structures until we find the proper
@@ -544,10 +544,10 @@
 
 	prop = (u64 *)get_property(of_chosen, "linux,initrd-start", NULL);
 	if (prop != NULL) {
-		initrd_start = (unsigned long)__va(*prop);
+		initrd_start = (unsigned long)__boot_va(*prop);
 		prop = (u64 *)get_property(of_chosen, "linux,initrd-end", NULL);
 		if (prop != NULL) {
-			initrd_end = (unsigned long)__va(*prop);
+			initrd_end = (unsigned long)__boot_va(*prop);
 			initrd_below_start_ok = 1;
 		} else
 			initrd_start = 0;
@@ -954,9 +954,9 @@
 	 * SLB misses on them.
 	 */
 	for_each_cpu(i) {
-		softirq_ctx[i] = (struct thread_info *)__va(lmb_alloc_base(THREAD_SIZE,
+		softirq_ctx[i] = (struct thread_info *)__boot_va(lmb_alloc_base(THREAD_SIZE,
 					THREAD_SIZE, 0x10000000));
-		hardirq_ctx[i] = (struct thread_info *)__va(lmb_alloc_base(THREAD_SIZE,
+		hardirq_ctx[i] = (struct thread_info *)__boot_va(lmb_alloc_base(THREAD_SIZE,
 					THREAD_SIZE, 0x10000000));
 	}
 }
@@ -985,7 +985,7 @@
 	limit = min(0x10000000UL, lmb.rmo_size);
 
 	for_each_cpu(i)
-		paca[i].emergency_sp = __va(lmb_alloc_base(PAGE_SIZE, 128,
+		paca[i].emergency_sp = __boot_va(lmb_alloc_base(PAGE_SIZE, 128,
 						limit)) + PAGE_SIZE;
 }
 
@@ -1026,6 +1026,10 @@
 
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
+#ifdef CONFIG_SPARSEMEM
+	sparse_init();
+#endif
+
 
 	ppc_md.setup_arch();
 
--- sparse/arch/ppc64/mm/Makefile~B-sparse-170-sparsemem-ppc64	2005-02-17 15:47:48.000000000 -0800
+++ /arch/ppc64/mm/Makefile	2005-02-17 15:47:49.000000000 -0800
@@ -6,6 +6,6 @@
 
 obj-y := fault.o init.o imalloc.o hash_utils.o hash_low.o tlb.o \
 	slb_low.o slb.o stab.o mmap.o
-obj-$(CONFIG_DISCONTIGMEM) += numa.o
+obj-$(CONFIG_NUMA) += numa.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_PPC_MULTIPLATFORM) += hash_native.o
--- sparse/arch/ppc64/mm/hash_utils.c~G0-ppc64-__boot-fixes	2005-02-17 15:47:51.000000000 -0800
+++ /arch/ppc64/mm/hash_utils.c	2005-02-17 15:47:51.000000000 -0800
@@ -119,12 +119,12 @@
 #ifdef CONFIG_PPC_PSERIES
 		if (systemcfg->platform & PLATFORM_LPAR)
 			ret = pSeries_lpar_hpte_insert(hpteg, va,
-				virt_to_abs(addr) >> PAGE_SHIFT,
+				boot_virt_to_abs(addr) >> PAGE_SHIFT,
 				0, mode, 1, large);
 		else
 #endif /* CONFIG_PPC_PSERIES */
 			ret = native_hpte_insert(hpteg, va,
-				virt_to_abs(addr) >> PAGE_SHIFT,
+				boot_virt_to_abs(addr) >> PAGE_SHIFT,
 				0, mode, 1, large);
 
 		if (ret == -1) {
--- sparse/arch/ppc64/mm/init.c~A6-no_arch_mem_map_init	2005-02-17 15:47:42.000000000 -0800
+++ /arch/ppc64/mm/init.c	2005-02-17 15:48:56.000000000 -0800
@@ -593,13 +593,24 @@
  * Initialize the bootmem system and give it all the memory we
  * have available.
  */
-#ifndef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_NUMA
 void __init do_init_bootmem(void)
 {
 	unsigned long i;
 	unsigned long start, bootmap_pages;
 	unsigned long total_pages = lmb_end_of_DRAM() >> PAGE_SHIFT;
 	int boot_mapsize;
+#ifdef CONFIG_SPARSEMEM
+	unsigned long start_pfn, end_pfn;
+
+	/*
+	 * Note presence of first (logical/coalasced) LMB which will
+	 * contain RMO region
+	 */
+	start_pfn = lmb.memory.region[0].physbase >> PAGE_SHIFT;
+	end_pfn = start_pfn + (lmb.memory.region[0].size >> PAGE_SHIFT);
+	memory_present(0, start_pfn, end_pfn);
+#endif
 
 	/*
 	 * Find an area to use for the bootmem bitmap.  Calculate the size of
@@ -615,12 +626,21 @@
 
 	max_pfn = max_low_pfn;
 
-	/* add all physical memory to the bootmem map. Also find the first */
+	/* add all physical memory to the bootmem map.  Also, note the
+	 * presence of all LMBs */
 	for (i=0; i < lmb.memory.cnt; i++) {
 		unsigned long physbase, size;
 
 		physbase = lmb.memory.region[i].physbase;
 		size = lmb.memory.region[i].size;
+#ifdef CONFIG_SPARSEMEM
+		if (i) { /* already created mappings for first LMB */
+			start_pfn = physbase >> PAGE_SHIFT;
+			end_pfn = start_pfn + (size >> PAGE_SHIFT);
+		}
+		memory_present(0, start_pfn, end_pfn);
+#endif
+
 		free_bootmem(physbase, size);
 	}
 
@@ -658,9 +678,8 @@
 
 	free_area_init_node(0, &contig_page_data, zones_size,
 			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
-	mem_map = contig_page_data.node_mem_map;
 }
-#endif /* CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_NUMA */
 
 static struct kcore_list kcore_vmem;
 
@@ -691,7 +710,7 @@
 
 void __init mem_init(void)
 {
-#ifdef CONFIG_DISCONTIGMEM
+#if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_SPARSEMEM)
 	int nid;
 #endif
 	pg_data_t *pgdat;
@@ -703,7 +722,7 @@
 	/* The strange -1 +1 is to avoid calling __va on an invalid address */
 	high_memory = (void *) (__va(max_low_pfn * PAGE_SIZE - 1) + 1);
 
-#ifdef CONFIG_DISCONTIGMEM
+#if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_SPARSEMEM)
         for_each_online_node(nid) {
 		if (NODE_DATA(nid)->node_spanned_pages != 0) {
 			printk("freeing bootmem node %x\n", nid);
@@ -718,7 +737,7 @@
 
 	for_each_pgdat(pgdat) {
 		for (i = 0; i < pgdat->node_spanned_pages; i++) {
-			page = pgdat->node_mem_map + i;
+			page = pfn_to_page(i);
 			if (PageReserved(page))
 				reservedpages++;
 		}
@@ -901,3 +920,80 @@
 	if (!zero_cache)
 		panic("pgtable_cache_init(): could not create zero_cache!\n");
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+
+void online_page(struct page *page)
+{
+	ClearPageReserved(page);
+	free_cold_page(page);
+	totalram_pages++;
+	num_physpages++;
+}
+
+/*
+ * This works only for the non-NUMA case.  Later, we'll need a lookup
+ * to convert from real physical addresses to nid, that doesn't use
+ * pfn_to_nid().
+ */
+int __devinit add_memory(u64 start, u64 size, unsigned long attr)
+{
+	struct pglist_data *pgdata = NODE_DATA(0);
+	struct zone *zone;
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+
+	/* this should work for most non-highmem platforms */
+	zone = pgdata->node_zones;
+
+	return __add_pages(zone, start_pfn, nr_pages, attr);
+
+	return 0;
+}
+
+/*
+ * First pass at this code will check to determine if the remove
+ * request is within the RMO.  Do not allow removal within the RMO.
+ */
+int __devinit remove_memory(u64 start, u64 size, unsigned long attr)
+{
+	struct zone *zone;
+	unsigned long start_pfn, end_pfn, nr_pages;
+
+	start_pfn = start >> PAGE_SHIFT;
+	nr_pages = size >> PAGE_SHIFT;
+	end_pfn = start_pfn + nr_pages;
+
+	printk("%s(): Attempting to remove memoy in range "
+			"%lx to %lx\n", __func__, start, start+size);
+	/*
+	 * check for range within RMO
+	 */
+	zone = page_zone(pfn_to_page(start_pfn));
+
+	printk("%s(): memory will be removed from "
+			"the %s zone\n", __func__, zone->name);
+
+	/*
+	 * not handling removing memory ranges that
+	 * overlap multiple zones yet
+	 */
+	if (end_pfn > (zone->zone_start_pfn + zone->spanned_pages))
+		goto overlap;
+
+	/* make sure it is NOT in RMO */
+	if ((start < lmb.rmo_size) || ((start+size) < lmb.rmo_size)) {
+		printk("%s(): range to be removed must NOT be in RMO!\n",
+			__func__);
+		goto in_rmo;
+	}
+
+	return __remove_pages(zone, start_pfn, nr_pages, attr);
+
+overlap:
+	printk("%s(): memory range to be removed overlaps "
+		"multiple zones!!!\n", __func__);
+in_rmo:
+	return -1;
+}
+#endif /* CONFIG_MEMORY_HOTPLUG */
--- sparse/arch/ppc64/mm/numa.c~B-sparse-130-add-early_pfn_to_nid	2005-02-17 15:47:44.000000000 -0800
+++ /arch/ppc64/mm/numa.c	2005-02-17 15:47:49.000000000 -0800
@@ -58,6 +58,22 @@
 EXPORT_SYMBOL(numa_cpumask_lookup_table);
 EXPORT_SYMBOL(nr_cpus_in_node);
 
+#ifdef CONFIG_DISCONTIGMEM
+unsigned long memory_present(int nid, unsigned long start, unsigned long end)
+{
+	unsigned long i;
+
+	/* XXX/APW: fix the loop instead ... */
+	start <<= PAGE_SHIFT;
+	end <<= PAGE_SHIFT;
+
+	for (i = start ; i < end; i += MEMORY_INCREMENT)
+		numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] = nid;
+
+	return 0;
+}
+#endif /* CONFIG_DISCONTIGMEM */
+
 static inline void map_cpu_to_node(int cpu, int node)
 {
 	numa_cpu_lookup_table[cpu] = node;
@@ -276,9 +292,12 @@
 		return -1;
 	}
 
+	/* XXX/APW this is another memmodel thing, like memmodel_init() */
+	/* XXX/APW this is DISCONTIG */
 	numa_memory_lookup_table =
 		(char *)abs_to_virt(lmb_alloc(entries * sizeof(char), 1));
 	memset(numa_memory_lookup_table, 0, entries * sizeof(char));
+	/* XXX/APW we should be allocating the phys_section[] here. */
 
 	for (i = 0; i < entries ; i++)
 		numa_memory_lookup_table[i] = ARRAY_INITIALISER;
@@ -378,9 +397,8 @@
 				size / PAGE_SIZE;
 		}
 
-		for (i = start ; i < (start+size); i += MEMORY_INCREMENT)
-			numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] =
-				numa_domain;
+		memory_present(numa_domain, start >> PAGE_SHIFT,
+					       (start + size) >> PAGE_SHIFT);
 
 		ranges--;
 		if (ranges)
@@ -428,8 +446,7 @@
 	init_node_data[0].node_start_pfn = 0;
 	init_node_data[0].node_spanned_pages = lmb_end_of_DRAM() / PAGE_SIZE;
 
-	for (i = 0 ; i < top_of_ram; i += MEMORY_INCREMENT)
-		numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] = 0;
+	memory_present(0, 0, init_node_data[0].node_spanned_pages);
 
 	node0_io_hole_size = top_of_ram - total_ram;
 }
@@ -628,6 +645,8 @@
 	memset(zones_size, 0, sizeof(zones_size));
 	memset(zholes_size, 0, sizeof(zholes_size));
 
+	memmodel_init();
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn;
 		unsigned long end_pfn;
@@ -662,3 +681,20 @@
 	return 0;
 }
 early_param("numa", early_numa);
+
+/* Find the owning node for a pfn. */
+int early_pfn_to_nid(unsigned long pfn)
+{
+	int nid;
+
+	for (nid = 0; nid < MAX_NUMNODES &&
+			init_node_data[nid].node_spanned_pages; nid++) {
+		unsigned long start = init_node_data[nid].node_start_pfn;
+		unsigned long end = start +
+				init_node_data[nid].node_spanned_pages;
+		if (start <= pfn && pfn <= end)
+			return nid;
+	}
+
+	return 0;
+}
--- sparse/arch/sh/mm/init.c~A6-no_arch_mem_map_init	2005-02-17 15:47:42.000000000 -0800
+++ /arch/sh/mm/init.c	2005-02-17 15:47:42.000000000 -0800
@@ -216,8 +216,6 @@
 #endif
 	NODE_DATA(0)->node_mem_map = NULL;
 	free_area_init_node(0, NODE_DATA(0), zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
-	/* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
-	mem_map = NODE_DATA(0)->node_mem_map;
 
 #ifdef CONFIG_DISCONTIGMEM
 	/*
--- sparse/arch/sh64/mm/init.c~A6-no_arch_mem_map_init	2005-02-17 15:47:42.000000000 -0800
+++ /arch/sh64/mm/init.c	2005-02-17 15:47:42.000000000 -0800
@@ -124,9 +124,6 @@
 	zones_size[ZONE_DMA] = MAX_LOW_PFN - START_PFN;
 	NODE_DATA(0)->node_mem_map = NULL;
 	free_area_init_node(0, NODE_DATA(0), zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
-
-	/* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
-	mem_map = NODE_DATA(0)->node_mem_map;
 }
 
 void __init mem_init(void)
--- sparse/arch/sparc/mm/srmmu.c~A6-no_arch_mem_map_init	2005-02-17 15:47:42.000000000 -0800
+++ /arch/sparc/mm/srmmu.c	2005-02-17 15:47:42.000000000 -0800
@@ -1343,7 +1343,6 @@
 
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 }
 
--- sparse/arch/sparc/mm/sun4c.c~A6-no_arch_mem_map_init	2005-02-17 15:47:42.000000000 -0800
+++ /arch/sparc/mm/sun4c.c	2005-02-17 15:47:42.000000000 -0800
@@ -2116,7 +2116,6 @@
 
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 
 	cnt = 0;
--- sparse/arch/sparc64/mm/init.c~A6-no_arch_mem_map_init	2005-02-17 15:47:42.000000000 -0800
+++ /arch/sparc64/mm/init.c	2005-02-17 15:47:42.000000000 -0800
@@ -1512,7 +1512,6 @@
 
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    phys_base >> PAGE_SHIFT, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 
 	device_scan();
--- sparse/arch/um/kernel/mem.c~FROM-MM-mostly-i386-mm-cleanup	2005-02-17 15:47:39.000000000 -0800
+++ /arch/um/kernel/mem.c	2005-02-17 15:47:39.000000000 -0800
@@ -138,7 +138,7 @@
 	pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(vaddr), (vaddr)),\
  			  (vaddr)), (vaddr))
 
-void __init kmap_init(void)
+static void __init kmap_init(void)
 {
 	unsigned long kmap_vstart;
 
--- sparse/arch/um/kernel/physmem.c~A6-no_arch_mem_map_init	2005-02-17 15:47:42.000000000 -0800
+++ /arch/um/kernel/physmem.c	2005-02-17 15:47:42.000000000 -0800
@@ -294,7 +294,6 @@
 		INIT_LIST_HEAD(&p->lru);
 	}
 
-	mem_map = map;
 	max_mapnr = total_pages;
 	return(0);
 }
--- sparse/arch/v850/kernel/setup.c~A6-no_arch_mem_map_init	2005-02-17 15:47:42.000000000 -0800
+++ /arch/v850/kernel/setup.c	2005-02-17 15:47:42.000000000 -0800
@@ -283,5 +283,4 @@
 	NODE_DATA(0)->node_mem_map = NULL;
 	free_area_init_node (0, NODE_DATA(0), zones_size,
 			     ADDR_TO_PAGE (PAGE_OFFSET), 0);
-	mem_map = NODE_DATA(0)->node_mem_map;
 }
--- sparse/include/asm-frv/highmem.h~FROM-MM-mostly-i386-mm-cleanup	2005-02-17 15:47:39.000000000 -0800
+++ /include/asm-frv/highmem.h	2005-02-17 15:47:39.000000000 -0800
@@ -44,8 +44,6 @@
 #define kmap_pte ______kmap_pte_in_TLB
 extern pte_t *pkmap_page_table;
 
-extern void kmap_init(void);
-
 #define flush_cache_kmaps()  do { } while (0)
 
 /*
--- sparse/include/asm-i386/highmem.h~FROM-MM-mostly-i386-mm-cleanup	2005-02-17 15:47:39.000000000 -0800
+++ /include/asm-i386/highmem.h	2005-02-17 15:48:56.000000000 -0800
@@ -33,8 +33,6 @@
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
 
-extern void kmap_init(void);
-
 /*
  * Right now we initialize only a single pte table. It can be extended
  * easily, subsequent pte tables have to be allocated in one physical
--- sparse/include/asm-i386/mmzone.h~A2.1-re-memset-i386-pgdats	2005-02-17 15:47:39.000000000 -0800
+++ /include/asm-i386/mmzone.h	2005-02-17 15:47:47.000000000 -0800
@@ -8,7 +8,9 @@
 
 #include <asm/smp.h>
 
-#ifdef CONFIG_DISCONTIGMEM
+#if CONFIG_NUMA
+extern struct pglist_data *node_data[];
+#define NODE_DATA(nid)	(node_data[nid])
 
 #ifdef CONFIG_NUMA
 	#ifdef CONFIG_X86_NUMAQ
@@ -21,8 +23,28 @@
 	#define get_zholes_size(n) (0)
 #endif /* CONFIG_NUMA */
 
-extern struct pglist_data *node_data[];
-#define NODE_DATA(nid)		(node_data[nid])
+extern int get_memcfg_numa_flat(void );
+/*
+ * This allows any one NUMA architecture to be compiled
+ * for, and still fall back to the flat function if it
+ * fails.
+ */
+static inline void get_memcfg_numa(void)
+{
+#ifdef CONFIG_X86_NUMAQ
+	if (get_memcfg_numaq())
+		return;
+#elif CONFIG_ACPI_SRAT
+	if (get_memcfg_from_srat())
+		return;
+#endif
+
+	get_memcfg_numa_flat();
+}
+
+#endif /* CONFIG_NUMA */
+
+#ifdef CONFIG_DISCONTIGMEM
 
 /*
  * generic node memory support, the following assumptions apply:
@@ -124,24 +146,28 @@
 }
 #endif
 
-extern int get_memcfg_numa_flat(void );
+#endif /* CONFIG_DISCONTIGMEM */
+
+#ifdef CONFIG_SPARSEMEM
+
 /*
- * This allows any one NUMA architecture to be compiled
- * for, and still fall back to the flat function if it
- * fails.
+ * generic non-linear memory support:
+ *
+ * 1) we will not split memory into more chunks than will fit into the
+ *    flags field of the struct page
  */
-static inline void get_memcfg_numa(void)
-{
-#ifdef CONFIG_X86_NUMAQ
-	if (get_memcfg_numaq())
-		return;
-#elif CONFIG_ACPI_SRAT
-	if (get_memcfg_from_srat())
-		return;
-#endif
 
-	get_memcfg_numa_flat();
-}
+/*
+ * SECTION_SIZE_BITS		2^N: how big each section will be
+ * MAX_PHYSADDR_BITS		2^N: how much physical address space we have
+ * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
+ */
+#define SECTION_SIZE_BITS       28
+#define MAX_PHYSADDR_BITS       36
+#define MAX_PHYSMEM_BITS	36
 
-#endif /* CONFIG_DISCONTIGMEM */
+/* XXX: FIXME -- wli */
+#define kern_addr_valid(kaddr)  (0)
+
+#endif /* CONFIG_SPARSEMEM */
 #endif /* _ASM_MMZONE_H_ */
--- sparse/include/asm-i386/page.h~B-sparse-075-validate-remap-pages	2005-02-17 15:47:42.000000000 -0800
+++ /include/asm-i386/page.h	2005-02-17 15:47:49.000000000 -0800
@@ -119,6 +119,8 @@
 
 extern int sysctl_legacy_va_layout;
 
+extern int page_is_ram(unsigned long pagenr);
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef __ASSEMBLY__
@@ -131,14 +133,16 @@
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
 #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
 #define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
-#define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
-#define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
+#define __boot_pa(x)		((unsigned long)(x)-PAGE_OFFSET)
+#define __boot_va(x)		((void *)((unsigned long)(x)+PAGE_OFFSET))
+#define __pa(x)			__boot_pa(x)
+#define __va(x)			__boot_va(x)
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 #define pfn_to_page(pfn)	(mem_map + (pfn))
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map))
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_FLATMEM */
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
--- sparse/include/asm-i386/pgtable.h~B-sparse-160-sparsemem-i386	2005-02-17 15:47:47.000000000 -0800
+++ /include/asm-i386/pgtable.h	2005-02-17 15:47:47.000000000 -0800
@@ -396,9 +396,9 @@
 
 #endif /* !__ASSEMBLY__ */
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 #define kern_addr_valid(addr)	(1)
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_FLATMEM */
 
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
--- sparse/include/asm-ppc/highmem.h~FROM-MM-mostly-i386-mm-cleanup	2005-02-17 15:47:39.000000000 -0800
+++ /include/asm-ppc/highmem.h	2005-02-17 15:47:39.000000000 -0800
@@ -35,8 +35,6 @@
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
 
-extern void kmap_init(void) __init;
-
 /*
  * Right now we initialize only a single pte table. It can be extended
  * easily, subsequent pte tables have to be allocated in one physical
--- sparse/include/asm-ppc64/abs_addr.h~G1-kravetz-ppc64-fixes	2005-02-17 15:47:51.000000000 -0800
+++ /include/asm-ppc64/abs_addr.h	2005-02-17 15:47:51.000000000 -0800
@@ -104,5 +104,7 @@
 /* Convenience macros */
 #define virt_to_abs(va) phys_to_abs(__pa(va))
 #define abs_to_virt(aa) __va(abs_to_phys(aa))
+#define boot_virt_to_abs(va) phys_to_abs(__boot_pa(va))
+#define boot_abs_to_virt(aa) __boot_va(abs_to_phys(aa))
 
 #endif /* _ABS_ADDR_H */
--- sparse/include/asm-ppc64/dma.h~G0-ppc64-__boot-fixes	2005-02-17 15:47:51.000000000 -0800
+++ /include/asm-ppc64/dma.h	2005-02-17 15:47:51.000000000 -0800
@@ -26,6 +26,8 @@
 /* The maximum address that we can perform a DMA transfer to on this platform */
 /* Doesn't really apply... */
 #define MAX_DMA_ADDRESS  (~0UL)
+#define MAX_DMA_PHYSADDR MAX_DMA_ADDRESS
+#define MAX_DMA_PHYSADDR MAX_DMA_ADDRESS
 
 #define dma_outb	outb
 #define dma_inb		inb
--- sparse/include/asm-ppc64/mmzone.h~B-sparse-170-sparsemem-ppc64	2005-02-17 15:47:49.000000000 -0800
+++ /include/asm-ppc64/mmzone.h	2005-02-17 15:47:51.000000000 -0800
@@ -10,9 +10,34 @@
 #include <linux/config.h>
 #include <asm/smp.h>
 
-#ifdef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_SPARSEMEM
+
+/* generic non-linear memory support:
+ *
+ * 1) we will not split memory into more chunks than will fit into the
+ *    flags field of the struct page
+ */
+
+/*
+ * SECTION_SIZE_BITS		2^N: how big each section will be
+ * MAX_PHYSADDR_BITS		2^N: how much physical address space we have
+ * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
+ */
+#define SECTION_SIZE_BITS	24
+#define MAX_PHYSADDR_BITS	38
+#define MAX_PHYSMEM_BITS	36
+
+#endif /* CONFIG_SPARSEMEM */
+
+#if defined(CONFIG_NUMA)
+
+#if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_SPARSEMEM)
 
 extern struct pglist_data *node_data[];
+/*
+ * Return a pointer to the node data for node n.
+ */
+#define NODE_DATA(nid)		(node_data[nid])
 
 /*
  * Following are specific to this numa platform.
@@ -27,6 +52,10 @@
 #define MEMORY_INCREMENT_SHIFT 24
 #define MEMORY_INCREMENT (1UL << MEMORY_INCREMENT_SHIFT)
 
+#endif /* CONFIG_DISCONTIGMEM || CONFIG_SPARSEMEM */
+
+#ifdef CONFIG_DISCONTIGMEM
+
 /* NUMA debugging, will not work on a DLPAR machine */
 #undef DEBUG_NUMA
 
@@ -49,11 +78,6 @@
 
 #define pfn_to_nid(pfn)		pa_to_nid((pfn) << PAGE_SHIFT)
 
-/*
- * Return a pointer to the node data for node n.
- */
-#define NODE_DATA(nid)		(node_data[nid])
-
 #define node_localnr(pfn, nid)	((pfn) - NODE_DATA(nid)->node_start_pfn)
 
 /*
@@ -91,4 +115,16 @@
 #define discontigmem_pfn_valid(pfn)		((pfn) < num_physpages)
 
 #endif /* CONFIG_DISCONTIGMEM */
+
+#ifdef CONFIG_SPARSEMEM
+
+#define pa_to_nid(pa)							\
+({									\
+	pfn_to_nid(pa >> PAGE_SHIFT);					\
+})
+
+#endif /* CONFIG_SPARSEMEM */
+
+#endif /* CONFIG_NUMA */
+
 #endif /* _ASM_MMZONE_H_ */
--- sparse/include/asm-ppc64/page.h~B-sparse-170-sparsemem-ppc64	2005-02-17 15:47:49.000000000 -0800
+++ /include/asm-ppc64/page.h	2005-02-17 15:47:50.000000000 -0800
@@ -179,7 +179,10 @@
 	return order;
 }
 
-#define __pa(x) ((unsigned long)(x)-PAGE_OFFSET)
+#define __boot_pa(x)   ((unsigned long)(x)-PAGE_OFFSET)
+#define __boot_va(x)   ((void *)((unsigned long)(x) + KERNELBASE))
+#define __pa(x)		__boot_pa(x)
+#define __va(x)		__boot_va(x)
 
 extern int page_is_ram(unsigned long pfn);
 
@@ -215,13 +218,13 @@
 #define __bpn_to_ba(x) ((((unsigned long)(x))<<PAGE_SHIFT) + KERNELBASE)
 #define __ba_to_bpn(x) ((((unsigned long)(x)) & ~REGION_MASK) >> PAGE_SHIFT)
 
-#define __va(x) ((void *)((unsigned long)(x) + KERNELBASE))
-
 #ifdef CONFIG_DISCONTIGMEM
 #define page_to_pfn(page)	discontigmem_page_to_pfn(page)
 #define pfn_to_page(pfn)	discontigmem_pfn_to_page(pfn)
 #define pfn_valid(pfn)		discontigmem_pfn_valid(pfn)
-#else
+#endif
+/* XXX/APW: why is SPARSEMEM not here */
+#ifdef CONFIG_FLATMEM
 #define pfn_to_page(pfn)	(mem_map + (pfn))
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map))
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
--- sparse/include/linux/bootmem.h~B-sparse-080-alloc_remap-i386	2005-02-17 15:47:43.000000000 -0800
+++ /include/linux/bootmem.h	2005-02-17 15:47:50.000000000 -0800
@@ -36,6 +36,10 @@
 					 * up searching */
 } bootmem_data_t;
 
+#ifndef MAX_DMA_PHYSADDR
+#define MAX_DMA_PHYSADDR (__boot_pa(MAX_DMA_ADDRESS))
+#endif
+
 extern unsigned long __init bootmem_bootmap_pages (unsigned long);
 extern unsigned long __init init_bootmem (unsigned long addr, unsigned long memend);
 extern void __init free_bootmem (unsigned long addr, unsigned long size);
@@ -43,11 +47,11 @@
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 extern void __init reserve_bootmem (unsigned long addr, unsigned long size);
 #define alloc_bootmem(x) \
-	__alloc_bootmem((x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem((x), SMP_CACHE_BYTES, MAX_DMA_PHYSADDR)
 #define alloc_bootmem_low(x) \
 	__alloc_bootmem((x), SMP_CACHE_BYTES, 0)
 #define alloc_bootmem_pages(x) \
-	__alloc_bootmem((x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem((x), PAGE_SIZE, MAX_DMA_PHYSADDR)
 #define alloc_bootmem_low_pages(x) \
 	__alloc_bootmem((x), PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
@@ -60,13 +64,22 @@
 extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 #define alloc_bootmem_node(pgdat, x) \
-	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, MAX_DMA_PHYSADDR)
 #define alloc_bootmem_pages_node(pgdat, x) \
-	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
+	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, MAX_DMA_PHYSADDR)
 #define alloc_bootmem_low_pages_node(pgdat, x) \
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
 
--- sparse/include/linux/mm.h~B-sparse-100-cleanup-node-zone	2005-02-17 15:47:43.000000000 -0800
+++ /include/linux/mm.h	2005-02-17 15:47:45.000000000 -0800
@@ -398,19 +398,93 @@
 /*
  * The zone field is never updated after free_area_init_core()
  * sets it, so none of the operations on it need to be atomic.
- * We'll have up to (MAX_NUMNODES * MAX_NR_ZONES) zones total,
- * so we use (MAX_NODES_SHIFT + MAX_ZONES_SHIFT) here to get enough bits.
  */
-#define NODEZONE_SHIFT (sizeof(page_flags_t)*8 - MAX_NODES_SHIFT - MAX_ZONES_SHIFT)
-#define NODEZONE(node, zone)	((node << ZONES_SHIFT) | zone)
+
+
+/*
+ * page->flags layout:
+ *
+ * There are three possibilities for how page->flags get
+ * laid out.  The first is for the normal case, without
+ * sparsemem.  The second is for sparsemem when there is
+ * plenty of space for node and section.  The last is when
+ * we have run out of space and have to fall back to an
+ * alternate (slower) way of determining the node.
+ *
+ *        No sparsemem: |       NODE     | ZONE | ... | FLAGS |
+ * with space for node: | SECTION | NODE | ZONE | ... | FLAGS |
+ *   no space for node: | SECTION |     ZONE    | ... | FLAGS |
+ */
+#if SECTIONS_SHIFT+NODES_SHIFT+ZONES_SHIFT <= FLAGS_RESERVED
+#define NODES_WIDTH		NODES_SHIFT
+#else
+#define NODES_WIDTH		0
+#endif
+
+#ifdef CONFIG_SPARSEMEM
+#define SECTIONS_WIDTH		SECTIONS_SHIFT
+#else
+#define SECTIONS_WIDTH		0
+#endif
+
+#define ZONES_WIDTH		ZONES_SHIFT
+
+/* Page flags: | [SECTION] | [NODE] | ZONE | ... | FLAGS | */
+#define SECTIONS_PGOFF		((sizeof(page_flags_t)*8) - SECTIONS_WIDTH)
+#define NODES_PGOFF		(SECTIONS_PGOFF - NODES_WIDTH)
+#define ZONES_PGOFF		(NODES_PGOFF - ZONES_WIDTH)
+
+/*
+ * We are going to use the flags for the page to node mapping if its in
+ * there.  This includes the case where there is no node, so it is implicit.
+ */
+#define FLAGS_HAS_NODE		(NODES_WIDTH > 0 || NODES_SHIFT == 0)
+
+#ifndef PFN_SECTION_SHIFT
+#define PFN_SECTION_SHIFT 0
+#endif
+
+/*
+ * Define the bit shifts to access each section.  For non-existant
+ * sections we define the shift as 0; that plus a 0 mask ensures
+ * the compiler will optimise away reference to them.
+ */
+#define SECTIONS_PGSHIFT	(SECTIONS_PGOFF * (SECTIONS_WIDTH != 0))
+#define NODES_PGSHIFT		(NODES_PGOFF * (NODES_WIDTH != 0))
+#define ZONES_PGSHIFT		(ZONES_PGOFF * (ZONES_WIDTH != 0))
+
+/* NODE:ZONE or SECTION:ZONE is used to lookup the zone from a page. */
+#if FLAGS_HAS_NODE
+#define ZONETABLE_SHIFT		(NODES_SHIFT + ZONES_SHIFT)
+#else
+#define ZONETABLE_SHIFT		(SECTIONS_SHIFT + ZONES_SHIFT)
+#endif
+#define ZONETABLE_PGSHIFT	ZONES_PGSHIFT
+
+#if SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
+#error SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
+#endif
+
+#define ZONES_MASK		((1UL << ZONES_WIDTH) - 1)
+#define NODES_MASK		((1UL << NODES_WIDTH) - 1)
+#define SECTIONS_MASK		((1UL << SECTIONS_WIDTH) - 1)
+#define ZONETABLE_MASK		((1UL << ZONETABLE_SHIFT) - 1)
 
 static inline unsigned long page_zonenum(struct page *page)
 {
-	return (page->flags >> NODEZONE_SHIFT) & (~(~0UL << ZONES_SHIFT));
+	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
 }
+static inline struct zone *page_zone(struct page *page);
 static inline unsigned long page_to_nid(struct page *page)
 {
-	return (page->flags >> (NODEZONE_SHIFT + ZONES_SHIFT));
+	if (FLAGS_HAS_NODE)
+		return (page->flags >> NODES_PGSHIFT) & NODES_MASK;
+	else
+		return page_zone(page)->zone_pgdat->node_id;
+}
+static inline unsigned long page_to_section(struct page *page)
+{
+	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
 }
 
 struct zone;
@@ -418,13 +492,32 @@
 
 static inline struct zone *page_zone(struct page *page)
 {
-	return zone_table[page->flags >> NODEZONE_SHIFT];
+	return zone_table[(page->flags >> ZONETABLE_PGSHIFT) &
+			ZONETABLE_MASK];
+}
+
+static inline void set_page_zone(struct page *page, unsigned long zone)
+{
+	page->flags &= ~(ZONES_MASK << ZONES_PGSHIFT);
+	page->flags |= (zone & ZONES_MASK) << ZONES_PGSHIFT;
+}
+static inline void set_page_node(struct page *page, unsigned long node)
+{
+	page->flags &= ~(NODES_MASK << NODES_PGSHIFT);
+	page->flags |= (node & NODES_MASK) << NODES_PGSHIFT;
+}
+static inline void set_page_section(struct page *page, unsigned long section)
+{
+	page->flags &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
+	page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
 }
 
-static inline void set_page_zone(struct page *page, unsigned long nodezone_num)
+static inline void set_page_links(struct page *page, unsigned long zone,
+	unsigned long node, unsigned long pfn)
 {
-	page->flags &= ~(~0UL << NODEZONE_SHIFT);
-	page->flags |= nodezone_num << NODEZONE_SHIFT;
+	set_page_zone(page, zone);
+	set_page_node(page, node);
+	set_page_section(page, pfn >> PFN_SECTION_SHIFT);
 }
 
 #ifndef CONFIG_DISCONTIGMEM
--- sparse/include/linux/mmzone.h~B-sparse-100-cleanup-node-zone	2005-02-17 15:47:43.000000000 -0800
+++ /include/linux/mmzone.h	2005-02-17 15:48:56.000000000 -0800
@@ -372,44 +372,165 @@
 /* Returns the number of the current Node. */
 #define numa_node_id()		(cpu_to_node(_smp_processor_id()))
 
-#ifndef CONFIG_DISCONTIGMEM
-
-extern struct pglist_data contig_page_data;
+#ifndef CONFIG_NUMA
 #define NODE_DATA(nid)		(&contig_page_data)
+extern struct pglist_data contig_page_data;
+#endif
+
+#ifdef CONFIG_FLATMEM
+
 #define NODE_MEM_MAP(nid)	mem_map
 #define MAX_NODES_SHIFT		1
 #define pfn_to_nid(pfn)		(0)
 
-#else /* CONFIG_DISCONTIGMEM */
+#else /* !CONFIG_FLATMEM */
 
 #include <asm/mmzone.h>
 
+#endif /* CONFIG_FLATMEM */
+
 #if BITS_PER_LONG == 32 || defined(ARCH_HAS_ATOMIC_UNSIGNED)
 /*
  * with 32 bit page->flags field, we reserve 8 bits for node/zone info.
  * there are 3 zones (2 bits) and this leaves 8-2=6 bits for nodes.
  */
-#define MAX_NODES_SHIFT		6
+#define FLAGS_RESERVED		10
+
 #elif BITS_PER_LONG == 64
 /*
  * with 64 bit flags field, there's plenty of room.
  */
-#define MAX_NODES_SHIFT		10
+#define FLAGS_RESERVED		32
+
+#else
+
+#error BITS_PER_LONG not defined
+
 #endif
 
-#endif /* !CONFIG_DISCONTIGMEM */
+#ifdef CONFIG_SPARSEMEM
+
+/*
+ * SECTION_SHIFT    		#bits space required to store a section #
+ *
+ * PA_SECTION_SHIFT		physical address to/from section number
+ * PFN_SECTION_SHIFT		pfn to/from section number
+ */
+#define SECTIONS_SHIFT		(MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
 
-#if NODES_SHIFT > MAX_NODES_SHIFT
-#error NODES_SHIFT > MAX_NODES_SHIFT
+#define PA_SECTION_SHIFT	(SECTION_SIZE_BITS)
+#define PFN_SECTION_SHIFT	(SECTION_SIZE_BITS - PAGE_SHIFT)
+
+#define NR_MEM_SECTIONS	(1 << SECTIONS_SHIFT)
+
+#define PAGES_PER_SECTION       (1 << PFN_SECTION_SHIFT)
+#define PAGE_SECTION_MASK	(~(PAGES_PER_SECTION-1))
+
+#if MAX_ORDER > SECTION_SIZE_BITS
+#error MAX_ORDER exceeds SECTION_SIZE_BITS
 #endif
 
-/* There are currently 3 zones: DMA, Normal & Highmem, thus we need 2 bits */
-#define MAX_ZONES_SHIFT		2
+struct page;
+struct mem_section {
+	/*
+	 * This is, logically, a pointer to an array of struct
+	 * pages.  However, it is stored with some other magic.
+	 * (see sparse.c::sparse_init_one_section())
+	 *
+	 * Making it a UL at least makes someone do a cast
+	 * before using it wrong.
+	 */
+	unsigned long section_mem_map;
+};
+
+extern struct mem_section mem_section[NR_MEM_SECTIONS];
 
-#if ZONES_SHIFT > MAX_ZONES_SHIFT
-#error ZONES_SHIFT > MAX_ZONES_SHIFT
+/*
+ * We use the lower bits of the mem_map pointer to store
+ * a little bit of information.  There should be at least
+ * 3 bits here due to 32-bit alignment.
+ */
+#define	SECTION_MARKED_PRESENT	(1UL<<0)
+#define SECTION_HAS_MEM_MAP	(1UL<<1)
+#define SECTION_MAP_LAST_BIT	(1UL<<2)
+#define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
+
+static inline struct page *__section_mem_map_addr(struct mem_section *section)
+{
+	unsigned long map = section->section_mem_map;
+	map &= SECTION_MAP_MASK;
+	return (struct page *)map;
+}
+
+static inline int valid_section(struct mem_section *section)
+{
+	return (section->section_mem_map & SECTION_MARKED_PRESENT);
+}
+
+static inline int section_has_mem_map(struct mem_section *section)
+{
+	return (section->section_mem_map & SECTION_HAS_MEM_MAP);
+}
+
+/*
+ * Given a kernel address, find the home node of the underlying memory.
+ */
+#define kvaddr_to_nid(kaddr)	pfn_to_nid(__pa(kaddr) >> PAGE_SHIFT)
+
+static inline struct mem_section *__pfn_to_section(unsigned long pfn)
+{
+	return &mem_section[pfn >> PFN_SECTION_SHIFT];
+}
+
+#define pfn_to_page(pfn) 						\
+({ 									\
+	unsigned long __pfn = (pfn);					\
+	__section_mem_map_addr(__pfn_to_section(__pfn)) + __pfn;	\
+})
+#define page_to_pfn(page)						\
+({									\
+	page - __section_mem_map_addr(&mem_section[page_to_section(page)]);	\
+})
+
+static inline int pfn_valid(unsigned long pfn)
+{
+	if ((pfn >> PFN_SECTION_SHIFT) >= NR_MEM_SECTIONS)
+		return 0;
+	return valid_section(&mem_section[pfn >> PFN_SECTION_SHIFT]);
+}
+
+/*
+ * APW/XXX: these are _only_ used during initialisation, therefore they
+ * can use __initdata ... they should have names to indicate this
+ * restriction.
+ */
+#ifdef CONFIG_NUMA
+#define pfn_to_nid		early_pfn_to_nid
+#else
+#define pfn_to_nid(pfn) 0
+#define early_pfn_to_nid(pfn)	0
 #endif
 
+#define pfn_to_pgdat(pfn)						\
+({									\
+	NODE_DATA(pfn_to_nid(pfn));					\
+})
+
+#define early_pfn_valid(pfn)	pfn_valid(pfn)
+void sparse_init(void);
+
+#else
+
+#define sparse_init()	do {} while (0)
+
+#endif /* CONFIG_SPARSEMEM */
+
+#ifndef early_pfn_valid
+#define early_pfn_valid(pfn)	(1)
+#endif
+
+unsigned long memory_present(int nid, unsigned long start, unsigned long end);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MMZONE_H */
--- sparse/include/linux/numa.h~B-sparse-150-sparsemem	2005-02-17 15:47:45.000000000 -0800
+++ /include/linux/numa.h	2005-02-17 15:47:45.000000000 -0800
@@ -3,7 +3,7 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_FLATMEM
 #include <asm/numnodes.h>
 #endif
 
--- /dev/null	2004-11-08 15:18:04.000000000 -0800
+++ /mm/Kconfig	2005-02-17 15:48:56.000000000 -0800
@@ -0,0 +1,19 @@
+choice
+	prompt "Memory model"
+	default SPARSEMEM if ARCH_SPARSEMEM_DEFAULT
+	default FLATMEM
+
+config DISCONTIGMEM
+	bool "Discontigious Memory"
+	depends on !ARCH_DISCONTIGMEM_DISABLE
+
+config SPARSEMEM
+	bool "Sparse Memory"
+	depends on !ARCH_SPARSEMEM_DISABLE
+
+config FLATMEM
+	bool "Flat Memory"
+
+endchoice
+
+
--- sparse/mm/Makefile~B-sparse-150-sparsemem	2005-02-17 15:47:45.000000000 -0800
+++ /mm/Makefile	2005-02-17 15:48:56.000000000 -0800
@@ -15,6 +15,7 @@
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
+obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SHMEM) += shmem.o
 obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
 
--- sparse/mm/bootmem.c~B-sparse-150-sparsemem	2005-02-17 15:47:45.000000000 -0800
+++ /mm/bootmem.c	2005-02-17 15:47:49.000000000 -0800
@@ -256,6 +256,7 @@
 static unsigned long __init free_all_bootmem_core(pg_data_t *pgdat)
 {
 	struct page *page;
+	unsigned long pfn;
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long i, count, total = 0;
 	unsigned long idx;
@@ -266,15 +267,29 @@
 
 	count = 0;
 	/* first extant page of the node */
-	page = virt_to_page(phys_to_virt(bdata->node_boot_start));
+	pfn = bdata->node_boot_start >> PAGE_SHIFT;
 	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
 	map = bdata->node_bootmem_map;
 	/* Check physaddr is O(LOG2(BITS_PER_LONG)) page aligned */
 	if (bdata->node_boot_start == 0 ||
 	    ffs(bdata->node_boot_start) - PAGE_SHIFT > ffs(BITS_PER_LONG))
 		gofast = 1;
+
+	/*
+	 * APW/XXX: we are making an assumption that our node_boot_start
+	 * is aligned to BITS_PER_LONG ... is this valid/enforced.
+	 */
+	/*
+	 * Make use of the guarentee that *_mem_map will be
+	 * contigious in sections aligned at MAX_ORDER.
+	 */
+	page = pfn_to_page(pfn);
 	for (i = 0; i < idx; ) {
 		unsigned long v = ~map[i / BITS_PER_LONG];
+
+		if ((pfn & ((1 << MAX_ORDER) - 1)) == 0)
+			page = pfn_to_page(pfn);
+
 		if (gofast && v == ~0UL) {
 			int j, order;
 
@@ -304,6 +319,7 @@
 			i+=BITS_PER_LONG;
 			page += BITS_PER_LONG;
 		}
+		pfn += BITS_PER_LONG;
 	}
 	total += count;
 
--- sparse/mm/memory.c~B-sparse-150-sparsemem	2005-02-17 15:47:45.000000000 -0800
+++ /mm/memory.c	2005-02-17 15:47:45.000000000 -0800
@@ -59,7 +59,7 @@
 #include <linux/swapops.h>
 #include <linux/elf.h>
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 /* use the per-pgdat data instead for discontigmem - mbligh */
 unsigned long max_mapnr;
 struct page *mem_map;
--- sparse/mm/page_alloc.c~A1-pcp_zone_init	2005-02-17 15:47:38.000000000 -0800
+++ /mm/page_alloc.c	2005-02-17 15:48:56.000000000 -0800
@@ -61,7 +61,7 @@
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
-struct zone *zone_table[1 << (ZONES_SHIFT + NODES_SHIFT)];
+struct zone *zone_table[1 << ZONETABLE_SHIFT];
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
@@ -191,6 +191,35 @@
 }
 
 /*
+ * Locate the struct page for both the matching buddy in our
+ * pair (buddy1) and the combined O(n+1) page they form (page).
+ *
+ * 1) Any buddy B1 will have an order O twin B2 which satisfies
+ * the following equasion:
+ *     B2 = B1 ^ (1 << O)
+ * For example, if the starting buddy (buddy2) is #8 its order
+ * 1 buddy is #10:
+ *     B2 = 8 ^ (1 << 1) = 8 ^ 2 = 10
+ *
+ * 2) Any buddy B will have an order O+1 parent P which
+ * satisfies the following equasion:
+ *     P = B & ~(1 << O)
+ *
+ * Assumption: *_mem_map is contigious at least up to MAX_ORDER
+ */
+static inline struct page *__page_find_buddy(struct page *page, unsigned long page_idx, unsigned int order)
+{
+	unsigned long buddy_idx = page_idx ^ (1 << order);
+
+	return page + (buddy_idx - page_idx);;
+}
+
+static inline unsigned long __find_combined_index(unsigned long page_idx, unsigned int order)
+{
+	return (page_idx & ~(1 << order));
+}
+
+/*
  * This function checks whether a page is free && is the buddy
  * we can do coalesce a page and its buddy if
  * (a) the buddy is free &&
@@ -233,44 +262,43 @@
  * -- wli
  */
 
-static inline void __free_pages_bulk (struct page *page, struct page *base,
+static inline void __free_pages_bulk (struct page *page,
 		struct zone *zone, unsigned int order)
 {
 	unsigned long page_idx;
-	struct page *coalesced;
 	int order_size = 1 << order;
 
 	if (unlikely(order))
 		destroy_compound_page(page, order);
 
-	page_idx = page - base;
+	page_idx = page_to_pfn(page) & ((1 << MAX_ORDER) - 1);
 
 	BUG_ON(page_idx & (order_size - 1));
 	BUG_ON(bad_range(zone, page));
 
 	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
+		unsigned long combined_idx;
 		struct free_area *area;
 		struct page *buddy;
-		int buddy_idx;
 
-		buddy_idx = (page_idx ^ (1 << order));
-		buddy = base + buddy_idx;
+		combined_idx = __find_combined_index(page_idx, order);
+		buddy = __page_find_buddy(page, page_idx, order);
+
 		if (bad_range(zone, buddy))
 			break;
 		if (!page_is_buddy(buddy, order))
-			break;
-		/* Move the buddy up one level. */
+			break;		/* Move the buddy up one level. */
 		list_del(&buddy->lru);
 		area = zone->free_area + order;
 		area->nr_free--;
 		rmv_page_order(buddy);
-		page_idx &= buddy_idx;
+		page = page + (combined_idx - page_idx);
+		page_idx = combined_idx;
 		order++;
 	}
-	coalesced = base + page_idx;
-	set_page_order(coalesced, order);
-	list_add(&coalesced->lru, &zone->free_area[order].free_list);
+	set_page_order(page, order);
+	list_add(&page->lru, &zone->free_area[order].free_list);
 	zone->free_area[order].nr_free++;
 }
 
@@ -309,10 +337,9 @@
 		struct list_head *list, unsigned int order)
 {
 	unsigned long flags;
-	struct page *base, *page = NULL;
+	struct page *page = NULL;
 	int ret = 0;
 
-	base = zone->zone_mem_map;
 	spin_lock_irqsave(&zone->lock, flags);
 	zone->all_unreclaimable = 0;
 	zone->pages_scanned = 0;
@@ -320,7 +347,7 @@
 		page = list_entry(list->prev, struct page, lru);
 		/* have to delete it as __free_pages_bulk list manipulates */
 		list_del(&page->lru);
-		__free_pages_bulk(page, base, zone, order);
+		__free_pages_bulk(page, zone, order);
 		ret++;
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
@@ -1370,7 +1397,6 @@
 	/* initialize zonelists */
 	for (i = 0; i < GFP_ZONETYPES; i++) {
 		zonelist = pgdat->node_zonelists + i;
-		memset(zonelist, 0, sizeof(*zonelist));
 		zonelist->zones[0] = NULL;
 	}
 
@@ -1417,7 +1443,6 @@
 		struct zonelist *zonelist;
 
 		zonelist = pgdat->node_zonelists + i;
-		memset(zonelist, 0, sizeof(*zonelist));
 
 		j = 0;
 		k = ZONE_NORMAL;
@@ -1532,11 +1557,20 @@
 void __init memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		unsigned long start_pfn)
 {
-	struct page *start = pfn_to_page(start_pfn);
 	struct page *page;
+	int pfn;
 
-	for (page = start; page < (start + size); page++) {
-		set_page_zone(page, NODEZONE(nid, zone));
+	/*
+	 * Make use of the guarentee that *_mem_map will be
+	 * contigious in sections aligned at MAX_ORDER.
+	 */
+	page = pfn_to_page(start_pfn);
+	for (pfn = start_pfn; pfn < (start_pfn + size); pfn++, page++) {
+		if (!early_pfn_valid(pfn))
+			continue;
+		if ((pfn & ((1 << MAX_ORDER) - 1)) == 0)
+			page = pfn_to_page(pfn);
+		set_page_links(page, zone, nid, pfn);
 		set_page_count(page, 0);
 		reset_page_mapcount(page);
 		SetPageReserved(page);
@@ -1560,11 +1594,106 @@
 	}
 }
 
+#define ZONETABLE_INDEX(x, zone_nr)	((x << ZONES_SHIFT) | zone_nr)
+void zonetable_add(struct zone *zone, int nid, int zid, unsigned long pfn,
+		unsigned long size)
+{
+	unsigned long snum = pfn >> PFN_SECTION_SHIFT;
+	unsigned long end = (pfn + size) >> PFN_SECTION_SHIFT;
+
+	if (FLAGS_HAS_NODE)
+		zone_table[ZONETABLE_INDEX(nid, zid)] = zone;
+	else
+		for (; snum <= end; snum++)
+			zone_table[ZONETABLE_INDEX(snum, zid)] = zone;
+}
+
 #ifndef __HAVE_ARCH_MEMMAP_INIT
 #define memmap_init(size, nid, zone, start_pfn) \
 	memmap_init_zone((size), (nid), (zone), (start_pfn))
 #endif
 
+static __devinit void zone_pcp_init(struct zone *zone)
+{
+	unsigned long batch;
+	int cpu;
+
+	/*
+	 * The per-cpu-pages pools are set to around 1000th of the
+	 * size of the zone.  But no more than 1/4 of a meg - there's
+	 * no point in going beyond the size of L2 cache.
+	 *
+	 * OK, so we don't know how big the cache is.  So guess.
+	 */
+	batch = zone->present_pages / 1024;
+	if (batch * PAGE_SIZE > 256 * 1024)
+		batch = (256 * 1024) / PAGE_SIZE;
+	batch /= 4;		/* We effectively *= 4 below */
+	if (batch < 1)
+		batch = 1;
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		struct per_cpu_pages *pcp;
+
+		pcp = &zone->pageset[cpu].pcp[0];	/* hot */
+		pcp->count = 0;
+		pcp->low = 2 * batch;
+		pcp->high = 6 * batch;
+		pcp->batch = 1 * batch;
+		INIT_LIST_HEAD(&pcp->list);
+
+		pcp = &zone->pageset[cpu].pcp[1];	/* cold */
+		pcp->count = 0;
+		pcp->low = 0;
+		pcp->high = 2 * batch;
+		pcp->batch = 1 * batch;
+		INIT_LIST_HEAD(&pcp->list);
+	}
+	printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
+			zone->name, zone->present_pages, batch);
+}
+
+static __devinit void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
+{
+	int table_size_bytes;
+	int i;
+	/*
+	 * The per-page waitqueue mechanism uses hashed waitqueues
+	 * per zone.
+	 */
+	zone->wait_table_size = wait_table_size(zone_size_pages);
+	zone->wait_table_bits =
+		wait_table_bits(zone->wait_table_size);
+	table_size_bytes = zone->wait_table_size * sizeof(wait_queue_head_t);
+	if (system_state < SYSTEM_RUNNING)
+		zone->wait_table = alloc_bootmem_node(zone->zone_pgdat,
+						      table_size_bytes);
+	else
+		zone->wait_table = kmalloc(table_size_bytes, GFP_KERNEL);
+
+	for(i = 0; i < zone->wait_table_size; ++i)
+		init_waitqueue_head(zone->wait_table + i);
+}
+
+static void init_currently_empty_zone(struct zone *zone, unsigned long zone_start_pfn, unsigned long size)
+{
+	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
+	struct pglist_data *pgdat = zone->zone_pgdat;
+	int nid = pgdat->node_id;
+
+	zone->zone_mem_map = pfn_to_page(zone_start_pfn);
+	zone->zone_start_pfn = zone_start_pfn;
+
+	if ((zone_start_pfn) & (zone_required_alignment-1))
+		printk("BUG: wrong zone alignment, it will crash\n");
+
+	memmap_init(size, nid, zone_idx(zone), zone_start_pfn);
+
+	zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+
+	pgdat->nr_zones++;
+}
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -1574,9 +1703,8 @@
 static void __init free_area_init_core(struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long *zholes_size)
 {
-	unsigned long i, j;
-	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
-	int cpu, nid = pgdat->node_id;
+	unsigned long j;
+	int nid = pgdat->node_id;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
 
 	pgdat->nr_zones = 0;
@@ -1586,9 +1714,7 @@
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, realsize;
-		unsigned long batch;
 
-		zone_table[NODEZONE(nid, j)] = zone;
 		realsize = size = zones_size[j];
 		if (zholes_size)
 			realsize -= zholes_size[j];
@@ -1606,40 +1732,7 @@
 		zone->free_pages = 0;
 
 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
-
-		/*
-		 * The per-cpu-pages pools are set to around 1000th of the
-		 * size of the zone.  But no more than 1/4 of a meg - there's
-		 * no point in going beyond the size of L2 cache.
-		 *
-		 * OK, so we don't know how big the cache is.  So guess.
-		 */
-		batch = zone->present_pages / 1024;
-		if (batch * PAGE_SIZE > 256 * 1024)
-			batch = (256 * 1024) / PAGE_SIZE;
-		batch /= 4;		/* We effectively *= 4 below */
-		if (batch < 1)
-			batch = 1;
-
-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
-			struct per_cpu_pages *pcp;
-
-			pcp = &zone->pageset[cpu].pcp[0];	/* hot */
-			pcp->count = 0;
-			pcp->low = 2 * batch;
-			pcp->high = 6 * batch;
-			pcp->batch = 1 * batch;
-			INIT_LIST_HEAD(&pcp->list);
-
-			pcp = &zone->pageset[cpu].pcp[1];	/* cold */
-			pcp->count = 0;
-			pcp->low = 0;
-			pcp->high = 2 * batch;
-			pcp->batch = 1 * batch;
-			INIT_LIST_HEAD(&pcp->list);
-		}
-		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
-				zone_names[j], realsize, batch);
+		zone_pcp_init(zone);
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
 		zone->nr_scan_active = 0;
@@ -1649,44 +1742,40 @@
 		if (!size)
 			continue;
 
-		/*
-		 * The per-page waitqueue mechanism uses hashed waitqueues
-		 * per zone.
-		 */
-		zone->wait_table_size = wait_table_size(size);
-		zone->wait_table_bits =
-			wait_table_bits(zone->wait_table_size);
-		zone->wait_table = (wait_queue_head_t *)
-			alloc_bootmem_node(pgdat, zone->wait_table_size
-						* sizeof(wait_queue_head_t));
-
-		for(i = 0; i < zone->wait_table_size; ++i)
-			init_waitqueue_head(zone->wait_table + i);
-
-		pgdat->nr_zones = j+1;
-
-		zone->zone_mem_map = pfn_to_page(zone_start_pfn);
-		zone->zone_start_pfn = zone_start_pfn;
-
-		if ((zone_start_pfn) & (zone_required_alignment-1))
-			printk(KERN_CRIT "BUG: wrong zone alignment, it will crash\n");
-
 		memmap_init(size, nid, j, zone_start_pfn);
 
-		zone_start_pfn += size;
+		zonetable_add(zone, nid, j, zone_start_pfn, size);
 
-		zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+		zone_wait_table_init(zone, size);
+		init_currently_empty_zone(zone, zone_start_pfn, size);
+		zone_start_pfn += size;
 	}
 }
 
-void __init node_alloc_mem_map(struct pglist_data *pgdat)
+static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 {
 	unsigned long size;
+	struct page *map;
+
+	/*
+	 * Make sure that the architecture hasn't already allocated
+	 * a node_mem_map, and that the node contains memory.
+	 */
+	if (pgdat->node_mem_map || !pgdat->node_spanned_pages)
+		return;
 
 	size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
-	pgdat->node_mem_map = alloc_bootmem_node(pgdat, size);
-#ifndef CONFIG_DISCONTIGMEM
-	mem_map = contig_page_data.node_mem_map;
+	map = alloc_remap(pgdat->node_id, size);
+	if (!map)
+		map = alloc_bootmem_node(pgdat, size);
+	pgdat->node_mem_map = map;
+
+#ifdef CONFIG_FLATMEM
+	/*
+	 * With no DISCONTIG, the global mem_map is just set as node 0's
+	 */
+	if (pgdat == NODE_DATA(0))
+		mem_map = NODE_DATA(0)->node_mem_map;
 #endif
 }
 
@@ -1698,8 +1787,7 @@
 	pgdat->node_start_pfn = node_start_pfn;
 	calculate_zone_totalpages(pgdat, zones_size, zholes_size);
 
-	if (!pfn_to_page(node_start_pfn))
-		node_alloc_mem_map(pgdat);
+	alloc_node_mem_map(pgdat);
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
 }
--- /dev/null	2004-11-08 15:18:04.000000000 -0800
+++ /mm/sparse.c	2005-02-17 15:47:46.000000000 -0800
@@ -0,0 +1,115 @@
+/*
+ * Non-linear memory mappings.
+ */
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/module.h>
+#include <asm/dma.h>
+
+/*
+ * Permenant non-linear data:
+ *
+ * 1) mem_section	- memory sections, mem_map's for valid memory
+ */
+struct mem_section mem_section[NR_MEM_SECTIONS];
+EXPORT_SYMBOL(mem_section);
+
+/* Record a memory area against a node. */
+unsigned long memory_present(int nid, unsigned long start, unsigned long end)
+{
+	unsigned long pfn = start;
+	unsigned long size = 0;
+
+	start &= PAGE_SECTION_MASK;
+	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
+		int section = pfn >> PFN_SECTION_SHIFT;
+		if (!mem_section[section].section_mem_map) {
+			mem_section[section].section_mem_map = SECTION_MARKED_PRESENT;
+			size += (PAGES_PER_SECTION * sizeof (struct page));
+		}
+	}
+
+	return size;
+}
+
+/*
+ * Subtle, we encode the real pfn into the mem_map such that
+ * the identity pfn - section_mem_map will return the actual
+ * physical page frame number.
+ */
+static unsigned long sparse_encode_mem_map(struct page *mem_map, int pnum)
+{
+	return (unsigned long)(mem_map - (pnum << PFN_SECTION_SHIFT));
+}
+
+static __attribute((unused))
+struct page *sparse_decode_mem_map(unsigned long coded_mem_map, int pnum)
+{
+	return ((struct page *)coded_mem_map) + (pnum << PFN_SECTION_SHIFT);
+}
+
+static int sparse_init_one_section(struct mem_section *ms, int pnum, struct page *mem_map)
+{
+	if (!valid_section(ms))
+		return -EINVAL;
+
+	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum);
+
+	return 1;
+}
+
+static struct page *sparse_early_mem_map_alloc(int pnum)
+{
+	struct page *map;
+	int nid = early_pfn_to_nid(pnum << PFN_SECTION_SHIFT);
+
+	map = alloc_remap(nid, sizeof(struct page) * PAGES_PER_SECTION);
+	if (map)
+		return map;
+
+	map = alloc_bootmem_node(NODE_DATA(nid),
+			sizeof(struct page) * PAGES_PER_SECTION);
+	if (map)
+		return map;
+
+	printk(KERN_WARNING "%s: allocation failed\n", __FUNCTION__);
+	mem_section[pnum].section_mem_map = 0;
+	return NULL;
+}
+
+/*
+ * Allocate the accumulated non-linear sections, allocate a mem_map
+ * for each and record the physical to section mapping.
+ */
+void sparse_init(void)
+{
+	int pnum;
+	struct page *map;
+
+	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
+		if (!valid_section_nr(pnum))
+			continue;
+
+		map = sparse_early_mem_map_alloc(pnum);
+		if (map)
+			sparse_init_one_section(&mem_section[pnum], pnum, map);
+	}
+}
+
+/*
+ * returns the number of sections whose mem_maps were properly
+ * set.  If this is zero, then that means that the passed-in
+ * map was not consumed and must be freed.
+ */
+int sparse_add_one_section(int phys_start_pfn, int nr_pages, struct page *map)
+{
+	struct mem_section *ms = __pfn_to_section(phys_start_pfn);
+
+	if (ms->section_mem_map & SECTION_MARKED_PRESENT)
+		return -EEXIST;
+
+	ms->section_mem_map |= SECTION_MARKED_PRESENT;
+
+	return sparse_init_one_section(ms, phys_start_pfn >> PFN_SECTION_SHIFT, map);
+}

--=-A3i1EPyLLA3BSUWJ5xIF--

