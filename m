Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262916AbVCQAev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbVCQAev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVCQAdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:33:38 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:56801 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262911AbVCQA2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:28:25 -0500
Subject: [RFC][PATCH 4/6] sparsemem: i386 implementation
To: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 16 Mar 2005 16:28:18 -0800
Message-Id: <E1DBis7-0000gu-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Start using mm/Kconfig for i386, use CONFIG_FLATMEM, and straighten
out some NUMA vs. DISCONTIG config confusion.

Also Make sure to disable sparsemem selection if the user doesn't
need it.  Only the NUMA sub-architectures need it for now.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/Kconfig          |   27 ++++++++---
 memhotplug-dave/arch/i386/kernel/setup.c   |    4 +
 memhotplug-dave/arch/i386/mm/Makefile      |    2 
 memhotplug-dave/arch/i386/mm/discontig.c   |   35 ++++++++------
 memhotplug-dave/arch/i386/mm/init.c        |   10 ++--
 memhotplug-dave/include/asm-i386/mmzone.h  |   68 +++++++++++++++++++++--------
 memhotplug-dave/include/asm-i386/page.h    |    4 -
 memhotplug-dave/include/asm-i386/pgtable.h |    4 -
 8 files changed, 102 insertions(+), 52 deletions(-)

diff -puN arch/i386/Kconfig~B-sparse-160-sparsemem-i386 arch/i386/Kconfig
--- memhotplug/arch/i386/Kconfig~B-sparse-160-sparsemem-i386	2005-03-16 16:13:36.000000000 -0800
+++ memhotplug-dave/arch/i386/Kconfig	2005-03-16 16:14:00.000000000 -0800
@@ -68,7 +68,7 @@ config X86_VOYAGER
 
 config X86_NUMAQ
 	bool "NUMAQ (IBM/Sequent)"
-	select DISCONTIGMEM
+	#select DISCONTIGMEM
 	select NUMA
 	help
 	  This option is used for getting Linux to run on a (IBM/Sequent) NUMA
@@ -767,17 +767,12 @@ comment "NUMA (NUMA-Q) requires SMP, 64G
 comment "NUMA (Summit) requires SMP, 64GB highmem support, ACPI"
 	depends on X86_SUMMIT && (!HIGHMEM64G || !ACPI)
 
-config DISCONTIGMEM
-	bool
-	depends on NUMA
-	default y
-
 config HAVE_ARCH_BOOTMEM_NODE
 	bool
 	depends on NUMA
 	default y
 
-config HAVE_MEMORY_PRESENT
+config ARCH_HAVE_MEMORY_PRESENT
 	bool
 	depends on DISCONTIGMEM
 	default y
@@ -792,6 +787,24 @@ config HAVE_ARCH_ALLOC_REMAP
 	depends on NUMA
 	default y
 
+config ARCH_DISCONTIGMEM_ENABLE
+	def_bool y
+	depends on NUMA
+
+config ARCH_DISCONTIGMEM_DEFAULT
+	def_bool y
+	depends on NUMA
+
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+	depends on NUMA
+
+config ARCH_FLATMEM_DISABLE
+	def_bool y
+	depends on NUMA
+
+source "mm/Kconfig"
+
 config HIGHPTE
 	bool "Allocate 3rd-level pagetables from highmem"
 	depends on HIGHMEM4G || HIGHMEM64G
diff -puN arch/i386/kernel/setup.c~B-sparse-160-sparsemem-i386 arch/i386/kernel/setup.c
--- memhotplug/arch/i386/kernel/setup.c~B-sparse-160-sparsemem-i386	2005-03-16 16:13:36.000000000 -0800
+++ memhotplug-dave/arch/i386/kernel/setup.c	2005-03-16 16:13:36.000000000 -0800
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/edd.h>
 #include <linux/nodemask.h>
+#include <linux/mmzone.h>
 #include <video/edid.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
@@ -1072,7 +1073,7 @@ void __init zone_sizes_init(void)
 	free_area_init(zones_size);
 }
 #else
-extern unsigned long setup_memory(void);
+extern unsigned long __init setup_memory(void);
 extern void zone_sizes_init(void);
 #endif /* !CONFIG_DISCONTIGMEM */
 
@@ -1475,6 +1476,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	paging_init();
 	remapped_pgdat_init();
+	sparse_init();
 	zone_sizes_init();
 
 	/*
diff -puN arch/i386/mm/Makefile~B-sparse-160-sparsemem-i386 arch/i386/mm/Makefile
--- memhotplug/arch/i386/mm/Makefile~B-sparse-160-sparsemem-i386	2005-03-16 16:13:36.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/Makefile	2005-03-16 16:13:36.000000000 -0800
@@ -4,7 +4,7 @@
 
 obj-y	:= init.o pgtable.o fault.o ioremap.o extable.o pageattr.o mmap.o
 
-obj-$(CONFIG_DISCONTIGMEM)	+= discontig.o
+obj-$(CONFIG_NUMA) += discontig.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_BOOT_IOREMAP) += boot_ioremap.o
diff -puN arch/i386/mm/discontig.c~B-sparse-160-sparsemem-i386 arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~B-sparse-160-sparsemem-i386	2005-03-16 16:13:36.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/discontig.c	2005-03-16 16:13:36.000000000 -0800
@@ -42,14 +42,17 @@ bootmem_data_t node0_bdata;
  *                  populated the following initialisation.
  *
  * 1) node_online_map  - the map of all nodes configured (online) in the system
- * 2) physnode_map     - the mapping between a pfn and owning node
- * 3) node_start_pfn   - the starting page frame number for a node
+ * 2) node_start_pfn   - the starting page frame number for a node
  * 3) node_end_pfn     - the ending page fram number for a node
  */
 unsigned long node_start_pfn[MAX_NUMNODES];
 unsigned long node_end_pfn[MAX_NUMNODES];
 
+#ifdef CONFIG_DISCONTIGMEM
+/* XXX: this chunk is really the correct contents of discontig.c */
+
 /*
+ * 4) physnode_map     - the mapping between a pfn and owning node
  * physnode_map keeps track of the physical memory layout of a generic
  * numa node on a 256Mb break (each element of the array will
  * represent 256Mb of memory and will be marked by the node id.  so,
@@ -87,9 +90,7 @@ unsigned long node_memmap_size_bytes(int
 
 	return (nr_pages + 1) * sizeof(struct page);
 }
-
-unsigned long node_start_pfn[MAX_NUMNODES];
-unsigned long node_end_pfn[MAX_NUMNODES];
+#endif
 
 extern unsigned long find_max_low_pfn(void);
 extern void find_max_pfn(void);
@@ -392,24 +393,26 @@ void __init set_highmem_pages_init(int b
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
 
-		for (node_pfn = 0; node_pfn < node_high_size; node_pfn++) {
-			one_highpage_init((struct page *)(zone_mem_map + node_pfn),
-					  zone_start_pfn + node_pfn, bad_ppro);
+		printk("Initializing %s for node %d (%08lx:%08lx)\n",
+				zone->name, zone->zone_pgdat->node_id,
+				zone_start_pfn, zone_end_pfn);
+
+		for (node_pfn = zone_start_pfn; node_pfn < zone_end_pfn; node_pfn++) {
+			if (!pfn_valid(node_pfn))
+				continue;
+			page = pfn_to_page(node_pfn);
+			one_highpage_init(page, node_pfn, bad_ppro);
 		}
 	}
 	totalram_pages += totalhigh_pages;
diff -puN arch/i386/mm/init.c~B-sparse-160-sparsemem-i386 arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~B-sparse-160-sparsemem-i386	2005-03-16 16:13:36.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/init.c	2005-03-16 16:13:36.000000000 -0800
@@ -277,7 +277,7 @@ void __init one_highpage_init(struct pag
 		SetPageReserved(page);
 }
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 static void __init set_highmem_pages_init(int bad_ppro)
 {
 	int pfn;
@@ -287,7 +287,7 @@ static void __init set_highmem_pages_ini
 }
 #else
 extern void set_highmem_pages_init(int);
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_FLATMEM */
 
 #else
 #define kmap_init() do { } while (0)
@@ -298,7 +298,7 @@ extern void set_highmem_pages_init(int);
 unsigned long long __PAGE_KERNEL = _PAGE_KERNEL;
 unsigned long long __PAGE_KERNEL_EXEC = _PAGE_KERNEL_EXEC;
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 #define remap_numa_kva() do {} while (0)
 #else
 extern void __init remap_numa_kva(void);
@@ -526,7 +526,7 @@ static void __init set_max_mapnr_init(vo
 #else
 	num_physpages = max_low_pfn;
 #endif
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 	max_mapnr = num_physpages;
 #endif
 }
@@ -540,7 +540,7 @@ void __init mem_init(void)
 	int tmp;
 	int bad_ppro;
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 	if (!mem_map)
 		BUG();
 #endif
diff -puN include/asm-i386/mmzone.h~B-sparse-160-sparsemem-i386 include/asm-i386/mmzone.h
--- memhotplug/include/asm-i386/mmzone.h~B-sparse-160-sparsemem-i386	2005-03-16 16:13:36.000000000 -0800
+++ memhotplug-dave/include/asm-i386/mmzone.h	2005-03-16 16:13:36.000000000 -0800
@@ -8,7 +8,9 @@
 
 #include <asm/smp.h>
 
-#ifdef CONFIG_DISCONTIGMEM
+#if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_SPARSEMEM)
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
+#endif /* !CONFIG_DISCONTIGMEM || !CONFIG_SPARSEMEM */
+
+#ifdef CONFIG_DISCONTIGMEM
 
 /*
  * generic node memory support, the following assumptions apply:
@@ -124,24 +146,34 @@ static inline int pfn_valid(int pfn)
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
+
+/*
+ * SECTION_SIZE_BITS		2^N: how big each section will be
+ * MAX_PHYSADDR_BITS		2^N: how much physical address space we have
+ * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
+ */
+#ifdef CONFIG_X86_PAE
+#define SECTION_SIZE_BITS       30
+#define MAX_PHYSADDR_BITS       36
+#define MAX_PHYSMEM_BITS	36
+#else
+#define SECTION_SIZE_BITS       26
+#define MAX_PHYSADDR_BITS       32
+#define MAX_PHYSMEM_BITS	32
 #endif
 
-	get_memcfg_numa_flat();
-}
+/* XXX: FIXME -- wli */
+#define kern_addr_valid(kaddr)  (0)
 
-#endif /* CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_SPARSEMEM */
 #endif /* _ASM_MMZONE_H_ */
diff -puN include/asm-i386/page.h~B-sparse-160-sparsemem-i386 include/asm-i386/page.h
--- memhotplug/include/asm-i386/page.h~B-sparse-160-sparsemem-i386	2005-03-16 16:13:36.000000000 -0800
+++ memhotplug-dave/include/asm-i386/page.h	2005-03-16 16:13:36.000000000 -0800
@@ -136,11 +136,11 @@ extern int page_is_ram(unsigned long pag
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
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
diff -puN include/asm-i386/pgtable.h~B-sparse-160-sparsemem-i386 include/asm-i386/pgtable.h
--- memhotplug/include/asm-i386/pgtable.h~B-sparse-160-sparsemem-i386	2005-03-16 16:13:36.000000000 -0800
+++ memhotplug-dave/include/asm-i386/pgtable.h	2005-03-16 16:13:36.000000000 -0800
@@ -398,9 +398,9 @@ extern void noexec_setup(const char *str
 
 #endif /* !__ASSEMBLY__ */
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 #define kern_addr_valid(addr)	(1)
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_FLATMEM */
 
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
_
