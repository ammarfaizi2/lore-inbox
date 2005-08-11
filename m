Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbVHKWsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbVHKWsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbVHKWsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:48:12 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:2688 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932516AbVHKWsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:48:11 -0400
Subject: [PATCH 1/2] sparsemem extreme implementation
To: akpm@osdl.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Thu, 11 Aug 2005 15:48:07 -0700
Message-Id: <20050811224807.D1B56AC2@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This applies to 2.6.13-rc5-mm1 and replaces the existing
sparsemem-extreme.patch

----

From: Bob Picco <bob.picco@hp.com>
With cleanups from Dave Hansen <haveblue@us.ibm.com>

SPARSEMEM_EXTREME makes mem_section a one dimensional array of
pointers to mem_sections. This two level layout scheme is able to achieve
smaller memory requirements for SPARSEMEM with the tradeoff of an additional
shift and load when fetching the memory section.  The current SPARSEMEM
implementation is a one dimensional array of mem_sections which is the default 
SPARSEMEM configuration.  The patch attempts isolates the implementation details
of the physical layout of the sparsemem section array.

SPARSEMEM_EXTREME requires bootmem to be functioning at the time of
memory_present() calls.  This is not always feasible, so architectures which
do not need it may allocate everything statically by using SPARSEMEM_STATIC.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Bob Picco <bob.picco@hp.com>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/Kconfig      |    1 
 memhotplug-dave/include/linux/mmzone.h |   24 ++++++++++++++---
 memhotplug-dave/mm/Kconfig             |   22 +++++++++++++++
 memhotplug-dave/mm/sparse.c            |   46 ++++++++++++++++++++++++++++-----
 4 files changed, 83 insertions(+), 10 deletions(-)

diff -puN include/linux/mmzone.h~A3-sparsemem-extreme include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~A3-sparsemem-extreme	2005-08-11 15:46:16.000000000 -0700
+++ memhotplug-dave/include/linux/mmzone.h	2005-08-11 15:46:16.000000000 -0700
@@ -487,11 +487,27 @@ struct mem_section {
 	unsigned long section_mem_map;
 };
 
-extern struct mem_section mem_section[NR_MEM_SECTIONS];
+#ifdef CONFIG_SPARSEMEM_EXTREME
+#define SECTIONS_PER_ROOT       (PAGE_SIZE / sizeof (struct mem_section))
+#else
+#define SECTIONS_PER_ROOT	1
+#endif
+
+#define SECTION_NR_TO_ROOT(sec)	((sec) / SECTIONS_PER_ROOT)
+#define NR_SECTION_ROOTS	(NR_MEM_SECTIONS / SECTIONS_PER_ROOT)
+#define SECTION_ROOT_MASK	(SECTIONS_PER_ROOT - 1)
+
+#ifdef CONFIG_SPARSEMEM_EXTREME
+extern struct mem_section *mem_section[NR_SECTION_ROOTS];
+#else
+extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
+#endif
 
 static inline struct mem_section *__nr_to_section(unsigned long nr)
 {
-	return &mem_section[nr];
+	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
+		return NULL;
+	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
 }
 
 /*
@@ -513,12 +529,12 @@ static inline struct page *__section_mem
 
 static inline int valid_section(struct mem_section *section)
 {
-	return (section->section_mem_map & SECTION_MARKED_PRESENT);
+	return (section && (section->section_mem_map & SECTION_MARKED_PRESENT));
 }
 
 static inline int section_has_mem_map(struct mem_section *section)
 {
-	return (section->section_mem_map & SECTION_HAS_MEM_MAP);
+	return (section && (section->section_mem_map & SECTION_HAS_MEM_MAP));
 }
 
 static inline int valid_section_nr(unsigned long nr)
diff -puN mm/Kconfig~A3-sparsemem-extreme mm/Kconfig
--- memhotplug/mm/Kconfig~A3-sparsemem-extreme	2005-08-11 15:46:16.000000000 -0700
+++ memhotplug-dave/mm/Kconfig	2005-08-11 15:46:16.000000000 -0700
@@ -89,3 +89,25 @@ config NEED_MULTIPLE_NODES
 config HAVE_MEMORY_PRESENT
 	def_bool y
 	depends on ARCH_HAVE_MEMORY_PRESENT || SPARSEMEM
+
+#
+# SPARSEMEM_EXTREME (which is the default) does some bootmem
+# allocations when memory_present() is called.  If this can not
+# be done on your architecture, select this option.  However,
+# statically allocating the mem_section[] array can potentially
+# consume vast quantities of .bss, so be careful.
+#
+# This option will also potentially produce smaller runtime code
+# with gcc 3.4 and later.
+#
+config SPARSEMEM_STATIC
+	def_bool n
+
+#
+# Architectecture platforms which require a two level mem_section in SPARSEMEM
+# must select this option. This is usually for architecture platforms with
+# an extremely sparse physical address space.
+#
+config SPARSEMEM_EXTREME
+	def_bool y
+	depends on SPARSEMEM && !SPARSEMEM_STATIC
diff -puN mm/sparse.c~A3-sparsemem-extreme mm/sparse.c
--- memhotplug/mm/sparse.c~A3-sparsemem-extreme	2005-08-11 15:46:16.000000000 -0700
+++ memhotplug-dave/mm/sparse.c	2005-08-11 15:46:16.000000000 -0700
@@ -13,9 +13,36 @@
  *
  * 1) mem_section	- memory sections, mem_map's for valid memory
  */
-struct mem_section mem_section[NR_MEM_SECTIONS];
+#ifdef CONFIG_SPARSEMEM_EXTREME
+struct mem_section *mem_section[NR_SECTION_ROOTS]
+	____cacheline_maxaligned_in_smp;
+#else
+struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
+	____cacheline_maxaligned_in_smp;
+#endif
 EXPORT_SYMBOL(mem_section);
 
+static void sparse_alloc_root(unsigned long root, int nid)
+{
+#ifdef CONFIG_SPARSEMEM_EXTREME
+	mem_section[root] = alloc_bootmem_node(NODE_DATA(nid), PAGE_SIZE);
+#endif
+}
+
+static void sparse_index_init(unsigned long section, int nid)
+{
+	unsigned long root = SECTION_NR_TO_ROOT(section);
+
+	if (mem_section[root])
+		return;
+
+	sparse_alloc_root(root, nid);
+
+	if (mem_section[root])
+		memset(mem_section[root], 0, PAGE_SIZE);
+	else
+		panic("memory_present: NO MEMORY\n");
+}
 /* Record a memory area against a node. */
 void memory_present(int nid, unsigned long start, unsigned long end)
 {
@@ -24,8 +51,13 @@ void memory_present(int nid, unsigned lo
 	start &= PAGE_SECTION_MASK;
 	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
 		unsigned long section = pfn_to_section_nr(pfn);
-		if (!mem_section[section].section_mem_map)
-			mem_section[section].section_mem_map = SECTION_MARKED_PRESENT;
+		struct mem_section *ms;
+
+		sparse_index_init(section, nid);
+
+		ms = __nr_to_section(section);
+		if (!ms->section_mem_map)
+			ms->section_mem_map = SECTION_MARKED_PRESENT;
 	}
 }
 
@@ -85,6 +117,7 @@ static struct page *sparse_early_mem_map
 {
 	struct page *map;
 	int nid = early_pfn_to_nid(section_nr_to_pfn(pnum));
+	struct mem_section *ms = __nr_to_section(pnum);
 
 	map = alloc_remap(nid, sizeof(struct page) * PAGES_PER_SECTION);
 	if (map)
@@ -96,7 +129,7 @@ static struct page *sparse_early_mem_map
 		return map;
 
 	printk(KERN_WARNING "%s: allocation failed\n", __FUNCTION__);
-	mem_section[pnum].section_mem_map = 0;
+	ms->section_mem_map = 0;
 	return NULL;
 }
 
@@ -114,8 +147,9 @@ void sparse_init(void)
 			continue;
 
 		map = sparse_early_mem_map_alloc(pnum);
-		if (map)
-			sparse_init_one_section(&mem_section[pnum], pnum, map);
+		if (!map)
+			continue;
+		sparse_init_one_section(__nr_to_section(pnum), pnum, map);
 	}
 }
 
diff -puN arch/i386/Kconfig~A3-sparsemem-extreme arch/i386/Kconfig
--- memhotplug/arch/i386/Kconfig~A3-sparsemem-extreme	2005-08-11 15:46:16.000000000 -0700
+++ memhotplug-dave/arch/i386/Kconfig	2005-08-11 15:46:16.000000000 -0700
@@ -754,6 +754,7 @@ config NUMA
 	depends on SMP && HIGHMEM64G && (X86_NUMAQ || X86_GENERICARCH || (X86_SUMMIT && ACPI))
 	default n if X86_PC
 	default y if (X86_NUMAQ || X86_SUMMIT)
+	select SPARSEMEM_STATIC
 
 # Need comments to help the hapless user trying to turn on NUMA support
 comment "NUMA (NUMA-Q) requires SMP, 64GB highmem support"
_
