Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVEDU2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVEDU2t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVEDU2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:28:49 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:50909
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S261526AbVEDUYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:24:17 -0400
To: akpm@osdl.org
Subject: [3/6] sparsemem memory model
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, apw@shadowen.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com
Message-Id: <E1DTQPU-0002VD-Vr@pinky.shadowen.org>
From: Andy Whitcroft <apw@shadowen.org>
Date: Wed, 04 May 2005 21:23:56 +0100
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

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Martin Bligh <mbligh@aracnet.com>
---
 include/linux/mm.h     |   86 ++++++++++++++++++++++++++++++++++++-------
 include/linux/mmzone.h |   96 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/numa.h   |    2 -
 mm/Kconfig             |   38 +++++++++++++++++--
 mm/Makefile            |    1 
 mm/bootmem.c           |    8 +++-
 mm/memory.c            |    2 -
 mm/page_alloc.c        |   39 +++++++++++++++----
 mm/sparse.c            |   85 +++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 327 insertions(+), 30 deletions(-)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/linux/mm.h current/include/linux/mm.h
--- reference/include/linux/mm.h	2005-05-04 20:54:20.000000000 +0100
+++ current/include/linux/mm.h	2005-05-04 20:54:31.000000000 +0100
@@ -401,39 +401,91 @@ static inline void put_page(struct page 
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
@@ -455,12 +507,18 @@ static inline void set_page_node(struct 
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
+	set_page_section(page, pfn_to_section_nr(pfn));
 }
 
 #ifndef CONFIG_DISCONTIGMEM
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h	2005-05-04 20:54:26.000000000 +0100
+++ current/include/linux/mmzone.h	2005-05-04 20:54:31.000000000 +0100
@@ -252,7 +252,9 @@ typedef struct pglist_data {
 	struct zone node_zones[MAX_NR_ZONES];
 	struct zonelist node_zonelists[GFP_ZONETYPES];
 	int nr_zones;
+#ifdef CONFIG_FLAT_NODE_MEM_MAP
 	struct page *node_mem_map;
+#endif
 	struct bootmem_data *bdata;
 	unsigned long node_start_pfn;
 	unsigned long node_present_pages; /* total number of physical pages */
@@ -267,7 +269,11 @@ typedef struct pglist_data {
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
 #define node_spanned_pages(nid)	(NODE_DATA(nid)->node_spanned_pages)
+#ifdef CONFIG_FLAT_NODE_MEM_MAP
 #define pgdat_page_nr(pgdat, pagenr)	((pgdat)->node_mem_map + (pagenr))
+#else
+#define pgdat_page_nr(pgdat, pagenr)	pfn_to_page((pgdat)->node_start_pfn + (pagenr))
+#endif
 #define nid_page_nr(nid, pagenr) 	pgdat_page_nr(NODE_DATA(nid),(pagenr))
 
 extern struct pglist_data *pgdat_list;
@@ -399,6 +405,10 @@ extern struct pglist_data contig_page_da
 
 #endif /* !CONFIG_NEED_MULTIPLE_NODES */
 
+#ifdef CONFIG_SPARSEMEM
+#include <asm/sparsemem.h>
+#endif
+
 #if BITS_PER_LONG == 32 || defined(ARCH_HAS_ATOMIC_UNSIGNED)
 /*
  * with 32 bit page->flags field, we reserve 8 bits for node/zone info.
@@ -422,6 +432,92 @@ extern struct pglist_data contig_page_da
 #define early_pfn_to_nid(nid)  (0UL)
 #endif
 
+#define pfn_to_section_nr(pfn) ((pfn) >> PFN_SECTION_SHIFT)
+#define section_nr_to_pfn(sec) ((sec) << PFN_SECTION_SHIFT)
+
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
+#if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
+#error Allocator MAX_ORDER exceeds SECTION_SIZE
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
+	return &mem_section[pfn_to_section_nr(pfn)];
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
+	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
+		return 0;
+	return mem_section[pfn_to_section_nr(pfn)].section_mem_map != 0;
+}
+
+/*
+ * These are _only_ used during initialisation, therefore they
+ * can use __initdata ...  They could have names to indicate
+ * this restriction.
+ */
+#ifdef CONFIG_NUMA
+#define pfn_to_nid		early_pfn_to_nid
+#endif
+
+#define pfn_to_pgdat(pfn)						\
+({									\
+	NODE_DATA(pfn_to_nid(pfn));					\
+})
+
+#define early_pfn_valid(pfn)	pfn_valid(pfn)
+void sparse_init(void);
+#else
+#define sparse_init()	do {} while (0)
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
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/linux/numa.h current/include/linux/numa.h
--- reference/include/linux/numa.h	2004-01-09 07:00:13.000000000 +0000
+++ current/include/linux/numa.h	2005-05-04 20:54:29.000000000 +0100
@@ -3,7 +3,7 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_FLATMEM
 #include <asm/numnodes.h>
 #endif
 
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/bootmem.c current/mm/bootmem.c
--- reference/mm/bootmem.c	2005-03-07 23:47:43.000000000 +0000
+++ current/mm/bootmem.c	2005-05-04 20:54:29.000000000 +0100
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
 
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/Kconfig current/mm/Kconfig
--- reference/mm/Kconfig	2005-05-04 20:54:29.000000000 +0100
+++ current/mm/Kconfig	2005-05-04 20:54:30.000000000 +0100
@@ -6,6 +6,7 @@ choice
 	prompt "Memory model"
 	depends on SELECT_MEMORY_MODEL
 	default DISCONTIGMEM_MANUAL if ARCH_DISCONTIGMEM_DEFAULT
+	default SPARSEMEM_MANUAL if ARCH_SPARSEMEM_DEFAULT
 	default FLATMEM_MANUAL
 
 config FLATMEM_MANUAL
@@ -17,7 +18,15 @@ config FLATMEM_MANUAL
 	  only have one option here: FLATMEM.  This is normal
 	  and a correct option.
 
-	  If unsure, choose this option over any other.
+	  Some users of more advanced features like NUMA and
+	  memory hotplug may have different options here.
+	  DISCONTIGMEM is an more mature, better tested system,
+	  but is incompatible with memory hotplug and may suffer
+	  decreased performance over SPARSEMEM.  If unsure between
+	  "Sparse Memory" and "Discontiguous Memory", choose
+	  "Discontiguous Memory".
+
+	  If unsure, choose this option (Flat Memory) over any other.
 
 config DISCONTIGMEM_MANUAL
 	bool "Discontigious Memory"
@@ -35,15 +44,38 @@ config DISCONTIGMEM_MANUAL
 
 	  If unsure, choose "Flat Memory" over this option.
 
+config SPARSEMEM_MANUAL
+	bool "Sparse Memory"
+	depends on ARCH_SPARSEMEM_ENABLE
+	help
+	  This will be the only option for some systems, including
+	  memory hotplug systems.  This is normal.
+
+	  For many other systems, this will be an alternative to
+	  "Discontigious Memory".  This option provides some potential
+	  performance benefits, along with decreased code complexity,
+	  but it is newer, and more experimental.
+
+	  If unsure, choose "Discontiguous Memory" or "Flat Memory"
+	  over this option.
+
 endchoice
 
 config DISCONTIGMEM
 	def_bool y
 	depends on (!SELECT_MEMORY_MODEL && ARCH_DISCONTIGMEM_ENABLE) || DISCONTIGMEM_MANUAL
 
+config SPARSEMEM
+	def_bool y
+	depends on SPARSEMEM_MANUAL
+
 config FLATMEM
 	def_bool y
-	depends on !DISCONTIGMEM || FLATMEM_MANUAL
+	depends on (!DISCONTIGMEM && !SPARSEMEM) || FLATMEM_MANUAL
+
+config FLAT_NODE_MEM_MAP
+	def_bool y
+	depends on !SPARSEMEM
 
 #
 # Both the NUMA code and DISCONTIGMEM use arrays of pg_data_t's
@@ -56,4 +88,4 @@ config NEED_MULTIPLE_NODES
 
 config HAVE_MEMORY_PRESENT
 	def_bool y
-	depends on ARCH_HAVE_MEMORY_PRESENT
+	depends on ARCH_HAVE_MEMORY_PRESENT || SPARSEMEM
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/Makefile current/mm/Makefile
--- reference/mm/Makefile	2005-03-07 23:47:43.000000000 +0000
+++ current/mm/Makefile	2005-05-04 20:54:29.000000000 +0100
@@ -15,6 +15,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
+obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SHMEM) += shmem.o
 obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
 
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/memory.c current/mm/memory.c
--- reference/mm/memory.c	2005-04-11 19:33:49.000000000 +0100
+++ current/mm/memory.c	2005-05-04 20:54:31.000000000 +0100
@@ -58,7 +58,7 @@
 #include <linux/swapops.h>
 #include <linux/elf.h>
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_NEED_MULTIPLE_NODES
 /* use the per-pgdat data instead for discontigmem - mbligh */
 unsigned long max_mapnr;
 struct page *mem_map;
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/page_alloc.c current/mm/page_alloc.c
--- reference/mm/page_alloc.c	2005-05-04 20:54:21.000000000 +0100
+++ current/mm/page_alloc.c	2005-05-04 20:54:31.000000000 +0100
@@ -66,7 +66,7 @@ EXPORT_SYMBOL(nr_swap_pages);
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
-struct zone *zone_table[1 << (ZONES_SHIFT + NODES_SHIFT)];
+struct zone *zone_table[1 << ZONETABLE_SHIFT];
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
@@ -1582,11 +1582,15 @@ static void __init calculate_zone_totalp
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
@@ -1610,6 +1614,20 @@ void zone_init_free_lists(struct pglist_
 	}
 }
 
+#define ZONETABLE_INDEX(x, zone_nr)	((x << ZONES_SHIFT) | zone_nr)
+void zonetable_add(struct zone *zone, int nid, int zid, unsigned long pfn,
+		unsigned long size)
+{
+	unsigned long snum = pfn_to_section_nr(pfn);
+	unsigned long end = pfn_to_section_nr(pfn + size);
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
@@ -1638,7 +1656,6 @@ static void __init free_area_init_core(s
 		unsigned long size, realsize;
 		unsigned long batch;
 
-		zone_table[NODEZONE(nid, j)] = zone;
 		realsize = size = zones_size[j];
 		if (zholes_size)
 			realsize -= zholes_size[j];
@@ -1723,6 +1740,8 @@ static void __init free_area_init_core(s
 
 		memmap_init(size, nid, j, zone_start_pfn);
 
+		zonetable_add(zone, nid, j, zone_start_pfn, size);
+
 		zone_start_pfn += size;
 
 		zone_init_free_lists(pgdat, zone, zone->spanned_pages);
@@ -1731,28 +1750,30 @@ static void __init free_area_init_core(s
 
 static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 {
-	unsigned long size;
-	struct page *map;
-
 	/* Skip empty nodes */
 	if (!pgdat->node_spanned_pages)
 		return;
 
+#ifdef CONFIG_FLAT_NODE_MEM_MAP
 	/* ia64 gets its own node_mem_map, before this, without bootmem */
 	if (!pgdat->node_mem_map) {
+		unsigned long size;
+		struct page *map;
+
 		size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
 		map = alloc_remap(pgdat->node_id, size);
 		if (!map)
 			map = alloc_bootmem_node(pgdat, size);
 		pgdat->node_mem_map = map;
 	}
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 	/*
 	 * With no DISCONTIG, the global mem_map is just set as node 0's
 	 */
 	if (pgdat == NODE_DATA(0))
 		mem_map = NODE_DATA(0)->node_mem_map;
 #endif
+#endif /* CONFIG_FLAT_NODE_MEM_MAP */
 }
 
 void __init free_area_init_node(int nid, struct pglist_data *pgdat,
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/sparse.c current/mm/sparse.c
--- reference/mm/sparse.c	1970-01-01 01:00:00.000000000 +0100
+++ current/mm/sparse.c	2005-05-04 20:54:31.000000000 +0100
@@ -0,0 +1,85 @@
+/*
+ * sparse memory mappings.
+ */
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/mmzone.h>
+#include <linux/bootmem.h>
+#include <linux/module.h>
+#include <asm/dma.h>
+
+/*
+ * Permanent SPARSEMEM data:
+ *
+ * 1) mem_section	- memory sections, mem_map's for valid memory
+ */
+struct mem_section mem_section[NR_MEM_SECTIONS];
+EXPORT_SYMBOL(mem_section);
+
+/* Record a memory area against a node. */
+void memory_present(int nid, unsigned long start, unsigned long end)
+{
+	unsigned long pfn;
+
+	start &= PAGE_SECTION_MASK;
+	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
+		unsigned long section = pfn_to_section_nr(pfn);
+		if (!mem_section[section].section_mem_map)
+			mem_section[section].section_mem_map = (void *) -1;
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
+	unsigned long pnum;
+	struct page *map;
+	int nid;
+
+	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
+		if (!mem_section[pnum].section_mem_map)
+			continue;
+
+		nid = early_pfn_to_nid(section_nr_to_pfn(pnum));
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
+						section_nr_to_pfn(pnum);
+	}
+}
