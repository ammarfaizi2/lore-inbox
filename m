Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262922AbVCQAkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbVCQAkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVCQAjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:39:55 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:44185 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262902AbVCQA2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:28:12 -0500
Subject: [RFC][PATCH 1/6] sparsemem: chop up the global mem_map[]
To: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 16 Mar 2005 16:28:08 -0800
Message-Id: <E1DBirx-0000P4-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sparsemem abstracts the use of discontiguous mem_maps[].  This kind
of mem_map[] is needed by discontiguous memory machines (like in the
old CONFIG_DISCONTIGMEM case) as well as memory hotplug systems.
Sparsemem replaces DISCONTIGMEM when enabled, and it is hoped that
it can eventually become a complete replacement.

A significant advantage over DISCONTIGMEM is that it's completely
separated from CONFIG_NUMA.  When producing this patch, it became
apparent in that NUMA and DISCONTIG are often confused.

Another advantage is that sparse doesn't require each NUMA node's
ranges to be contiguous.  It can handle overlapping ranges between
nodes with no problems, where DISCONTIGMEM currently throws away
that memory.

Sparsemem uses an array to provide different pfn_to_page()
translations for each SECTION_SIZE area of physical memory.  This
is what allows the mem_map[] to be chopped up.

In order to do quick pfn_to_page() operations, the section number
of the page is encoded in page->flags.  Part of the sparsemem
infrastructure enables sharing of these bits more dynamically (at
compile-time) between the page_zone() and sparsemem operations.
However, on 32-bit architectures, the number of bits is quite
limited, and may require growing the size of the page->flags
type in certain conditions.  Several things might force this to
occur: a decrease in the SECTION_SIZE (if you want to hotplug smaller
areas of memory), an increase in the physical address space, or an
increase in the number of used page->flags.

One thing to note is that, once sparsemem is present, the NUMA node
information no longer needs to be stored in the page->flags.  It
might provide speed increases on certain platforms and will be
stored there if there is room.  But, if out of room, an alternate
(theoretically slower) mechanism is used.

This patch introduces CONFIG_FLATMEM.  It is used in almost all
cases where there used to be an #ifndef DISCONTIG, because
SPARSEMEM and DISCONTIGMEM often have to compile out the same areas
of code.

Another addition is mm/Kconfig.  With sparsemem and memory hotplug
there are quite a few options that we kept adding identically in
several different architectures.  The new file allows some of these
to be consolidated.

In this series is a i386.  However, there also exist ppc64, ia64,
and x86_64 patches.  Expect these to come via the architecture
maintainers very soon.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 arch/i386/Kconfig                        |    0 
 memhotplug-dave/arch/i386/mm/discontig.c |    2 
 memhotplug-dave/include/linux/mm.h       |   86 +++++++++++++++++++++++-----
 memhotplug-dave/include/linux/mmzone.h   |   94 ++++++++++++++++++++++++++++++-
 memhotplug-dave/include/linux/numa.h     |    2 
 memhotplug-dave/mm/Kconfig               |   53 +++++++++++++++++
 memhotplug-dave/mm/Makefile              |    1 
 memhotplug-dave/mm/bootmem.c             |    8 +-
 memhotplug-dave/mm/memory.c              |    2 
 memhotplug-dave/mm/page_alloc.c          |   33 ++++++++--
 memhotplug-dave/mm/sparse.c              |   87 ++++++++++++++++++++++++++++
 11 files changed, 340 insertions(+), 28 deletions(-)

diff -puN arch/i386/mm/discontig.c~B-sparse-150-sparsemem arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~B-sparse-150-sparsemem	2005-03-16 15:46:37.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/discontig.c	2005-03-16 15:46:37.000000000 -0800
@@ -46,6 +46,8 @@ bootmem_data_t node0_bdata;
  * 3) node_start_pfn   - the starting page frame number for a node
  * 3) node_end_pfn     - the ending page fram number for a node
  */
+unsigned long node_start_pfn[MAX_NUMNODES];
+unsigned long node_end_pfn[MAX_NUMNODES];
 
 /*
  * physnode_map keeps track of the physical memory layout of a generic
diff -puN include/linux/mm.h~B-sparse-150-sparsemem include/linux/mm.h
--- memhotplug/include/linux/mm.h~B-sparse-150-sparsemem	2005-03-16 15:46:37.000000000 -0800
+++ memhotplug-dave/include/linux/mm.h	2005-03-16 15:46:37.000000000 -0800
@@ -400,39 +400,91 @@ static inline void put_page(struct page 
  * sets it, so none of the operations on it need to be atomic.
  */
 
-/* Page flags: | NODE | ZONE | ... | FLAGS | */
-#define NODES_PGOFF		((sizeof(page_flags_t)*8) - NODES_SHIFT)
-#define ZONES_PGOFF		(NODES_PGOFF - ZONES_SHIFT)
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
 
 /*
  * Define the bit shifts to access each section.  For non-existant
  * sections we define the shift as 0; that plus a 0 mask ensures
  * the compiler will optimise away reference to them.
  */
-#define NODES_PGSHIFT		(NODES_PGOFF * (NODES_SHIFT != 0))
-#define ZONES_PGSHIFT		(ZONES_PGOFF * (ZONES_SHIFT != 0))
+#define SECTIONS_PGSHIFT	(SECTIONS_PGOFF * (SECTIONS_WIDTH != 0))
+#define NODES_PGSHIFT		(NODES_PGOFF * (NODES_WIDTH != 0))
+#define ZONES_PGSHIFT		(ZONES_PGOFF * (ZONES_WIDTH != 0))
 
-/* NODE:ZONE is used to lookup the zone from a page. */
+/* NODE:ZONE or SECTION:ZONE is used to lookup the zone from a page. */
+#if FLAGS_HAS_NODE
 #define ZONETABLE_SHIFT		(NODES_SHIFT + ZONES_SHIFT)
+#else
+#define ZONETABLE_SHIFT		(SECTIONS_SHIFT + ZONES_SHIFT)
+#endif
 #define ZONETABLE_PGSHIFT	ZONES_PGSHIFT
 
-#if NODES_SHIFT+ZONES_SHIFT > FLAGS_RESERVED
-#error NODES_SHIFT+ZONES_SHIFT > FLAGS_RESERVED
+#if SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
+#error SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
 #endif
 
-#define NODEZONE(node, zone)	((node << ZONES_SHIFT) | zone)
-
-#define ZONES_MASK		((1UL << ZONES_SHIFT) - 1)
-#define NODES_MASK		((1UL << NODES_SHIFT) - 1)
+#define ZONES_MASK		((1UL << ZONES_WIDTH) - 1)
+#define NODES_MASK		((1UL << NODES_WIDTH) - 1)
+#define SECTIONS_MASK		((1UL << SECTIONS_WIDTH) - 1)
 #define ZONETABLE_MASK		((1UL << ZONETABLE_SHIFT) - 1)
 
 static inline unsigned long page_zonenum(struct page *page)
 {
 	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
 }
+static inline struct zone *page_zone(struct page *page);
 static inline unsigned long page_to_nid(struct page *page)
 {
-	return (page->flags >> NODES_PGSHIFT) & NODES_MASK;
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
@@ -454,12 +506,18 @@ static inline void set_page_node(struct 
 	page->flags &= ~(NODES_MASK << NODES_PGSHIFT);
 	page->flags |= (node & NODES_MASK) << NODES_PGSHIFT;
 }
+static inline void set_page_section(struct page *page, unsigned long section)
+{
+	page->flags &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
+	page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
+}
 
 static inline void set_page_links(struct page *page, unsigned long zone,
-	unsigned long node)
+	unsigned long node, unsigned long pfn)
 {
 	set_page_zone(page, zone);
 	set_page_node(page, node);
+	set_page_section(page, pfn >> PFN_SECTION_SHIFT);
 }
 
 #ifndef CONFIG_DISCONTIGMEM
diff -puN include/linux/mmzone.h~B-sparse-150-sparsemem include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~B-sparse-150-sparsemem	2005-03-16 15:46:37.000000000 -0800
+++ memhotplug-dave/include/linux/mmzone.h	2005-03-16 15:46:37.000000000 -0800
@@ -383,7 +383,7 @@ int lowmem_reserve_ratio_sysctl_handler(
 /* Returns the number of the current Node. */
 #define numa_node_id()		(cpu_to_node(_smp_processor_id()))
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 
 extern struct pglist_data contig_page_data;
 #define NODE_DATA(nid)		(&contig_page_data)
@@ -391,11 +391,11 @@ extern struct pglist_data contig_page_da
 #define MAX_NODES_SHIFT		1
 #define pfn_to_nid(pfn)		(0)
 
-#else /* CONFIG_DISCONTIGMEM */
+#else /* !CONFIG_FLATMEM */
 
 #include <asm/mmzone.h>
 
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_FLATMEM */
 
 #if BITS_PER_LONG == 32 || defined(ARCH_HAS_ATOMIC_UNSIGNED)
 /*
@@ -416,6 +416,94 @@ extern struct pglist_data contig_page_da
 
 #endif
 
+#ifdef CONFIG_SPARSEMEM
+
+/*
+ * SECTION_SHIFT    		#bits space required to store a section #
+ *
+ * PA_SECTION_SHIFT		physical address to/from section number
+ * PFN_SECTION_SHIFT		pfn to/from section number
+ */
+#define SECTIONS_SHIFT		(MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
+
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
+#endif
+
+struct page;
+struct mem_section {
+	struct page *section_mem_map;
+};
+
+extern struct mem_section mem_section[NR_MEM_SECTIONS];
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
+	__pfn_to_section(__pfn)->section_mem_map + __pfn;		\
+})
+#define page_to_pfn(page)						\
+({									\
+	page - mem_section[page_to_section(page)].section_mem_map;	\
+})
+
+static inline int pfn_valid(unsigned long pfn)
+{
+	if ((pfn >> PFN_SECTION_SHIFT) >= NR_MEM_SECTIONS)
+		return 0;
+	return mem_section[pfn >> PFN_SECTION_SHIFT].section_mem_map != 0;
+}
+
+/*
+ * These are _only_ used during initialisation, therefore they
+ * can use __initdata ...  They could have names to indicate
+ * this restriction.
+ */
+#ifdef CONFIG_NUMA
+#define pfn_to_nid		early_pfn_to_nid
+#else
+#define pfn_to_nid(pfn) 0
+#endif
+
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
+void memory_present(int nid, unsigned long start, unsigned long end);
+unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MMZONE_H */
diff -puN include/linux/numa.h~B-sparse-150-sparsemem include/linux/numa.h
--- memhotplug/include/linux/numa.h~B-sparse-150-sparsemem	2005-03-16 15:46:37.000000000 -0800
+++ memhotplug-dave/include/linux/numa.h	2005-03-16 15:46:37.000000000 -0800
@@ -3,7 +3,7 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_FLATMEM
 #include <asm/numnodes.h>
 #endif
 
diff -puN mm/Makefile~B-sparse-150-sparsemem mm/Makefile
--- memhotplug/mm/Makefile~B-sparse-150-sparsemem	2005-03-16 15:46:37.000000000 -0800
+++ memhotplug-dave/mm/Makefile	2005-03-16 15:46:37.000000000 -0800
@@ -15,6 +15,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
+obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SHMEM) += shmem.o
 obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
 
diff -puN mm/bootmem.c~B-sparse-150-sparsemem mm/bootmem.c
--- memhotplug/mm/bootmem.c~B-sparse-150-sparsemem	2005-03-16 15:46:37.000000000 -0800
+++ memhotplug-dave/mm/bootmem.c	2005-03-16 15:46:37.000000000 -0800
@@ -256,6 +256,7 @@ found:
 static unsigned long __init free_all_bootmem_core(pg_data_t *pgdat)
 {
 	struct page *page;
+	unsigned long pfn;
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long i, count, total = 0;
 	unsigned long idx;
@@ -266,7 +267,7 @@ static unsigned long __init free_all_boo
 
 	count = 0;
 	/* first extant page of the node */
-	page = virt_to_page(phys_to_virt(bdata->node_boot_start));
+	pfn = bdata->node_boot_start >> PAGE_SHIFT;
 	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
 	map = bdata->node_bootmem_map;
 	/* Check physaddr is O(LOG2(BITS_PER_LONG)) page aligned */
@@ -275,6 +276,9 @@ static unsigned long __init free_all_boo
 		gofast = 1;
 	for (i = 0; i < idx; ) {
 		unsigned long v = ~map[i / BITS_PER_LONG];
+
+		page = pfn_to_page(pfn);
+
 		if (gofast && v == ~0UL) {
 			int j, order;
 
@@ -302,8 +306,8 @@ static unsigned long __init free_all_boo
 			}
 		} else {
 			i+=BITS_PER_LONG;
-			page += BITS_PER_LONG;
 		}
+		pfn += BITS_PER_LONG;
 	}
 	total += count;
 
diff -puN mm/memory.c~B-sparse-150-sparsemem mm/memory.c
--- memhotplug/mm/memory.c~B-sparse-150-sparsemem	2005-03-16 15:46:37.000000000 -0800
+++ memhotplug-dave/mm/memory.c	2005-03-16 15:46:37.000000000 -0800
@@ -58,7 +58,7 @@
 #include <linux/swapops.h>
 #include <linux/elf.h>
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 /* use the per-pgdat data instead for discontigmem - mbligh */
 unsigned long max_mapnr;
 struct page *mem_map;
diff -puN mm/page_alloc.c~B-sparse-150-sparsemem mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~B-sparse-150-sparsemem	2005-03-16 15:46:37.000000000 -0800
+++ memhotplug-dave/mm/page_alloc.c	2005-03-16 15:46:37.000000000 -0800
@@ -66,7 +66,7 @@ EXPORT_SYMBOL(nr_swap_pages);
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
-struct zone *zone_table[1 << (ZONES_SHIFT + NODES_SHIFT)];
+struct zone *zone_table[1 << ZONETABLE_SHIFT];
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
@@ -1579,11 +1579,15 @@ static void __init calculate_zone_totalp
 void __init memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		unsigned long start_pfn)
 {
-	struct page *start = pfn_to_page(start_pfn);
 	struct page *page;
+	int end_pfn = start_pfn + size;
+	int pfn;
 
-	for (page = start; page < (start + size); page++) {
-		set_page_links(page, zone, nid);
+	for (pfn = start_pfn; pfn < end_pfn; pfn++, page++) {
+		if (!early_pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+		set_page_links(page, zone, nid, pfn);
 		set_page_count(page, 0);
 		reset_page_mapcount(page);
 		SetPageReserved(page);
@@ -1607,6 +1611,20 @@ void zone_init_free_lists(struct pglist_
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
@@ -1635,7 +1653,6 @@ static void __init free_area_init_core(s
 		unsigned long size, realsize;
 		unsigned long batch;
 
-		zone_table[NODEZONE(nid, j)] = zone;
 		realsize = size = zones_size[j];
 		if (zholes_size)
 			realsize -= zholes_size[j];
@@ -1720,6 +1737,8 @@ static void __init free_area_init_core(s
 
 		memmap_init(size, nid, j, zone_start_pfn);
 
+		zonetable_add(zone, nid, j, zone_start_pfn, size);
+
 		zone_start_pfn += size;
 
 		zone_init_free_lists(pgdat, zone, zone->spanned_pages);
@@ -1743,7 +1762,7 @@ static void __init alloc_node_mem_map(st
 			map = alloc_bootmem_node(pgdat, size);
 		pgdat->node_mem_map = map;
 	}
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 	/*
 	 * With no DISCONTIG, the global mem_map is just set as node 0's
 	 */
@@ -1765,7 +1784,7 @@ void __init free_area_init_node(int nid,
 	free_area_init_core(pgdat, zones_size, zholes_size);
 }
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 static bootmem_data_t contig_bootmem_data;
 struct pglist_data contig_page_data = { .bdata = &contig_bootmem_data };
 
diff -puN /dev/null mm/sparse.c
--- /dev/null	2004-11-08 15:18:04.000000000 -0800
+++ memhotplug-dave/mm/sparse.c	2005-03-16 15:46:37.000000000 -0800
@@ -0,0 +1,87 @@
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
+void memory_present(int nid, unsigned long start, unsigned long end)
+{
+	unsigned long pfn = start;
+	unsigned long size = 0;
+
+	start &= PAGE_SECTION_MASK;
+	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
+		int section = pfn >> PFN_SECTION_SHIFT;
+		if (!mem_section[section].section_mem_map) {
+			mem_section[section].section_mem_map = (void *) -1;
+			size += (PAGES_PER_SECTION * sizeof (struct page));
+		}
+	}
+}
+
+/*
+ * Only used by the i386 NUMA architecures, but relatively
+ * generic code.
+ */
+unsigned long __init node_memmap_size_bytes(int nid, unsigned long start_pfn,
+						     unsigned long end_pfn)
+{
+	unsigned long pfn;
+	unsigned long nr_pages = 0;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+		if (nid != early_pfn_to_nid(pfn))
+			continue;
+
+		if (pfn_valid(pfn))
+			nr_pages += PAGES_PER_SECTION;
+	}
+
+	return nr_pages * sizeof(struct page);
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
+	int nid;
+
+	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
+		if (!mem_section[pnum].section_mem_map)
+			continue;
+
+		nid = early_pfn_to_nid(pnum << PFN_SECTION_SHIFT);
+		map = alloc_remap(nid, sizeof(struct page) * PAGES_PER_SECTION);
+		if (!map)
+			map = alloc_bootmem_node(NODE_DATA(nid),
+				sizeof(struct page) * PAGES_PER_SECTION);
+		if (!map) {
+			mem_section[pnum].section_mem_map = 0;
+			continue;
+		}
+
+		/*
+		 * Subtle, we encode the real pfn into the mem_map such that
+		 * the identity pfn - section_mem_map will return the actual
+		 * physical page frame number.
+		 */
+		mem_section[pnum].section_mem_map = map -
+			(pnum << PFN_SECTION_SHIFT);
+	}
+}
diff -puN /dev/null mm/Kconfig
--- /dev/null	2004-11-08 15:18:04.000000000 -0800
+++ memhotplug-dave/mm/Kconfig	2005-03-16 15:46:37.000000000 -0800
@@ -0,0 +1,53 @@
+# It is assumed that, before you include this file for your
+# architecture you have:
+#
+#   1. Enabled SPARSEMEM and DISCONTIGMEM if you architecture
+#      needs them.
+#   2. Implemented memory_present() in your architecture's
+#      DISCONTIGMEM code
+
+choice
+	prompt "Memory model"
+	default FLATMEM
+	default SPARSEMEM if ARCH_SPARSEMEM_DEFAULT
+	default DISCONTIGMEM if ARCH_DISCONTIGMEM_DEFAULT
+
+config FLATMEM
+	bool "Flat Memory"
+	depends on !ARCH_FLATMEM_DISABLE
+	help
+	  This option allows you to change some of the ways that
+	  Linux manages its memory internally.  Most users will
+	  only have one option here: FLATMEM.  This is normal
+	  and a correct option.
+
+	  Some users of more advanced features like NUMA and
+	  memory hotplug may have different options here.
+	  DISCONTIGMEM is an more mature, better tested system,
+	  but is incompatible with memory hotplug and may suffer
+	  decreased performance over SPARSEMEM.  If unsure between
+	  "Sparse Memory" and "Discontiguous Memory", choose
+	  "Discontiguous Memory".
+
+	  If unsure, choose FLATMEM.
+
+config DISCONTIGMEM
+	bool "Discontigious Memory"
+	depends on ARCH_DISCONTIGMEM_ENABLE
+	help
+	  If unsure, choose this option over "Sparse Memory".
+
+config SPARSEMEM
+	bool "Sparse Memory"
+	depends on ARCH_SPARSEMEM_ENABLE
+	help
+	  If unsure, choose "Discontiguous Memory" over this option.
+
+endchoice
+
+config HAVE_MEMORY_PRESENT
+	bool
+	depends on ARCH_HAVE_MEMORY_PRESENT || SPARSEMEM
+	default y
+
+
diff -puN arch/i386/Kconfig~B-sparse-150-sparsemem arch/i386/Kconfig
_
