Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVEDUcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVEDUcP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVEDUbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:31:24 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:52189
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S261529AbVEDUZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:25:10 -0400
To: akpm@osdl.org
Subject: [4/6] sparsemem memory model for i386
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, apw@shadowen.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com
Message-Id: <E1DTQQT-0002VM-2U@pinky.shadowen.org>
From: Andy Whitcroft <apw@shadowen.org>
Date: Wed, 04 May 2005 21:24:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the architecture specific implementation for SPARSEMEM for
i386 SMP and NUMA systems.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Martin Bligh <mbligh@aracnet.com>
---
 arch/i386/Kconfig            |   24 ++++++++---
 arch/i386/kernel/setup.c     |    8 ++-
 arch/i386/mm/Makefile        |    2 
 arch/i386/mm/discontig.c     |   36 +++++++++--------
 arch/i386/mm/init.c          |   18 ++++----
 include/asm-i386/mmzone.h    |   89 +++++++++++++++++++++++--------------------
 include/asm-i386/page.h      |    4 -
 include/asm-i386/pgtable.h   |    4 -
 include/asm-i386/sparsemem.h |   31 ++++++++++++++
 9 files changed, 135 insertions(+), 81 deletions(-)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/i386/Kconfig current/arch/i386/Kconfig
--- reference/arch/i386/Kconfig	2005-05-04 20:54:29.000000000 +0100
+++ current/arch/i386/Kconfig	2005-05-04 20:54:34.000000000 +0100
@@ -68,7 +68,6 @@ config X86_VOYAGER
 
 config X86_NUMAQ
 	bool "NUMAQ (IBM/Sequent)"
-	select DISCONTIGMEM
 	select NUMA
 	help
 	  This option is used for getting Linux to run on a (IBM/Sequent) NUMA
@@ -767,11 +766,6 @@ comment "NUMA (NUMA-Q) requires SMP, 64G
 comment "NUMA (Summit) requires SMP, 64GB highmem support, ACPI"
 	depends on X86_SUMMIT && (!HIGHMEM64G || !ACPI)
 
-config ARCH_DISCONTIGMEM_ENABLE
-	bool
-	depends on NUMA
-	default y
-
 config HAVE_ARCH_BOOTMEM_NODE
 	bool
 	depends on NUMA
@@ -784,7 +778,7 @@ config ARCH_HAVE_MEMORY_PRESENT
 
 config NEED_NODE_MEMMAP_SIZE
 	bool
-	depends on DISCONTIGMEM
+	depends on DISCONTIGMEM || SPARSEMEM
 	default y
 
 config HAVE_ARCH_ALLOC_REMAP
@@ -792,6 +786,22 @@ config HAVE_ARCH_ALLOC_REMAP
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
+config SELECT_MEMORY_MODEL
+	def_bool y
+	depends on ARCH_SPARSEMEM_ENABLE
+
 source "mm/Kconfig"
 
 config HAVE_ARCH_EARLY_PFN_TO_NID
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/i386/kernel/setup.c current/arch/i386/kernel/setup.c
--- reference/arch/i386/kernel/setup.c	2005-04-11 19:33:08.000000000 +0100
+++ current/arch/i386/kernel/setup.c	2005-05-04 20:54:35.000000000 +0100
@@ -25,6 +25,7 @@
 
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/mmzone.h>
 #include <linux/tty.h>
 #include <linux/ioport.h>
 #include <linux/acpi.h>
@@ -1022,7 +1023,7 @@ static void __init reserve_ebda_region(v
 		reserve_bootmem(addr, PAGE_SIZE);	
 }
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_NEED_MULTIPLE_NODES
 void __init setup_bootmem_allocator(void);
 static unsigned long __init setup_memory(void)
 {
@@ -1072,9 +1073,9 @@ void __init zone_sizes_init(void)
 	free_area_init(zones_size);
 }
 #else
-extern unsigned long setup_memory(void);
+extern unsigned long __init setup_memory(void);
 extern void zone_sizes_init(void);
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* !CONFIG_NEED_MULTIPLE_NODES */
 
 void __init setup_bootmem_allocator(void)
 {
@@ -1475,6 +1476,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	paging_init();
 	remapped_pgdat_init();
+	sparse_init();
 	zone_sizes_init();
 
 	/*
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/i386/mm/discontig.c current/arch/i386/mm/discontig.c
--- reference/arch/i386/mm/discontig.c	2005-05-04 20:54:20.000000000 +0100
+++ current/arch/i386/mm/discontig.c	2005-05-04 20:54:34.000000000 +0100
@@ -42,12 +42,16 @@ bootmem_data_t node0_bdata;
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
 /*
+ * 4) physnode_map     - the mapping between a pfn and owning node
  * physnode_map keeps track of the physical memory layout of a generic
  * numa node on a 256Mb break (each element of the array will
  * represent 256Mb of memory and will be marked by the node id.  so,
@@ -85,9 +89,7 @@ unsigned long node_memmap_size_bytes(int
 
 	return (nr_pages + 1) * sizeof(struct page);
 }
-
-unsigned long node_start_pfn[MAX_NUMNODES];
-unsigned long node_end_pfn[MAX_NUMNODES];
+#endif
 
 extern unsigned long find_max_low_pfn(void);
 extern void find_max_pfn(void);
@@ -390,24 +392,26 @@ void __init set_highmem_pages_init(int b
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
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/i386/mm/init.c current/arch/i386/mm/init.c
--- reference/arch/i386/mm/init.c	2005-05-04 20:54:20.000000000 +0100
+++ current/arch/i386/mm/init.c	2005-05-04 20:54:35.000000000 +0100
@@ -277,7 +277,9 @@ void __init one_highpage_init(struct pag
 		SetPageReserved(page);
 }
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_NUMA
+extern void set_highmem_pages_init(int);
+#else
 static void __init set_highmem_pages_init(int bad_ppro)
 {
 	int pfn;
@@ -285,9 +287,7 @@ static void __init set_highmem_pages_ini
 		one_highpage_init(pfn_to_page(pfn), pfn, bad_ppro);
 	totalram_pages += totalhigh_pages;
 }
-#else
-extern void set_highmem_pages_init(int);
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_FLATMEM */
 
 #else
 #define kmap_init() do { } while (0)
@@ -298,10 +298,10 @@ extern void set_highmem_pages_init(int);
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
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/i386/mm/Makefile current/arch/i386/mm/Makefile
--- reference/arch/i386/mm/Makefile	2005-01-21 14:04:05.000000000 +0000
+++ current/arch/i386/mm/Makefile	2005-05-04 20:54:34.000000000 +0100
@@ -4,7 +4,7 @@
 
 obj-y	:= init.o pgtable.o fault.o ioremap.o extable.o pageattr.o mmap.o
 
-obj-$(CONFIG_DISCONTIGMEM)	+= discontig.o
+obj-$(CONFIG_NUMA) += discontig.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_BOOT_IOREMAP) += boot_ioremap.o
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/asm-i386/mmzone.h current/include/asm-i386/mmzone.h
--- reference/include/asm-i386/mmzone.h	2005-05-04 20:54:26.000000000 +0100
+++ current/include/asm-i386/mmzone.h	2005-05-04 20:54:35.000000000 +0100
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
@@ -48,26 +70,6 @@ static inline int pfn_to_nid(unsigned lo
 #endif
 }
 
-/*
- * Following are macros that are specific to this numa platform.
- */
-#define reserve_bootmem(addr, size) \
-	reserve_bootmem_node(NODE_DATA(0), (addr), (size))
-#define alloc_bootmem(x) \
-	__alloc_bootmem_node(NODE_DATA(0), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
-#define alloc_bootmem_low(x) \
-	__alloc_bootmem_node(NODE_DATA(0), (x), SMP_CACHE_BYTES, 0)
-#define alloc_bootmem_pages(x) \
-	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
-#define alloc_bootmem_low_pages(x) \
-	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, 0)
-#define alloc_bootmem_node(ignore, x) \
-	__alloc_bootmem_node(NODE_DATA(0), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
-#define alloc_bootmem_pages_node(ignore, x) \
-	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
-#define alloc_bootmem_low_pages_node(ignore, x) \
-	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, 0)
-
 #define node_localnr(pfn, nid)		((pfn) - node_data[nid]->node_start_pfn)
 
 /*
@@ -121,28 +123,33 @@ static inline int pfn_valid(int pfn)
 		return (pfn < node_end_pfn(nid));
 	return 0;
 }
-#endif
+#endif /* CONFIG_X86_NUMAQ */
+
+#endif /* CONFIG_DISCONTIGMEM */
+
+#ifdef CONFIG_NEED_MULTIPLE_NODES
 
-extern int get_memcfg_numa_flat(void );
 /*
- * This allows any one NUMA architecture to be compiled
- * for, and still fall back to the flat function if it
- * fails.
+ * Following are macros that are specific to this numa platform.
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
-
-	get_memcfg_numa_flat();
-}
+#define reserve_bootmem(addr, size) \
+	reserve_bootmem_node(NODE_DATA(0), (addr), (size))
+#define alloc_bootmem(x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
+#define alloc_bootmem_low(x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), SMP_CACHE_BYTES, 0)
+#define alloc_bootmem_pages(x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
+#define alloc_bootmem_low_pages(x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, 0)
+#define alloc_bootmem_node(ignore, x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
+#define alloc_bootmem_pages_node(ignore, x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
+#define alloc_bootmem_low_pages_node(ignore, x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, 0)
 
-#endif /* CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_NEED_MULTIPLE_NODES */
 
 extern int early_pfn_to_nid(unsigned long pfn);
 
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/asm-i386/page.h current/include/asm-i386/page.h
--- reference/include/asm-i386/page.h	2005-05-04 20:54:20.000000000 +0100
+++ current/include/asm-i386/page.h	2005-05-04 20:54:34.000000000 +0100
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
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/asm-i386/pgtable.h current/include/asm-i386/pgtable.h
--- reference/include/asm-i386/pgtable.h	2005-04-11 19:33:43.000000000 +0100
+++ current/include/asm-i386/pgtable.h	2005-05-04 20:54:34.000000000 +0100
@@ -398,9 +398,9 @@ extern void noexec_setup(const char *str
 
 #endif /* !__ASSEMBLY__ */
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 #define kern_addr_valid(addr)	(1)
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_FLATMEM */
 
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
 		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/asm-i386/sparsemem.h current/include/asm-i386/sparsemem.h
--- reference/include/asm-i386/sparsemem.h	1970-01-01 01:00:00.000000000 +0100
+++ current/include/asm-i386/sparsemem.h	2005-05-04 20:54:34.000000000 +0100
@@ -0,0 +1,31 @@
+#ifndef _I386_SPARSEMEM_H
+#define _I386_SPARSEMEM_H
+#ifdef CONFIG_SPARSEMEM
+
+/*
+ * generic non-linear memory support:
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
+#ifdef CONFIG_X86_PAE
+#define SECTION_SIZE_BITS       30
+#define MAX_PHYSADDR_BITS       36
+#define MAX_PHYSMEM_BITS	36
+#else
+#define SECTION_SIZE_BITS       26
+#define MAX_PHYSADDR_BITS       32
+#define MAX_PHYSMEM_BITS	32
+#endif
+
+/* XXX: FIXME -- wli */
+#define kern_addr_valid(kaddr)  (0)
+
+#endif /* CONFIG_SPARSEMEM */
+#endif /* _I386_SPARSEMEM_H */
