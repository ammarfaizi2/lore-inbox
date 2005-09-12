Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVILRy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVILRy4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVILRy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:54:56 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:45728 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751113AbVILRyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:54:54 -0400
Subject: [RFC][PATCH 2/2] i386: move NUMA code into numa.c
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 12 Sep 2005 10:53:20 -0700
References: <20050912175319.7C51CF96@kernel.beaverton.ibm.com>
In-Reply-To: <20050912175319.7C51CF96@kernel.beaverton.ibm.com>
Message-Id: <20050912175320.C8FDF9C7@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes the final dependencies of CONFIG_NUMA on
discontig.c.  This is done by moving the NUMA KVA remap
code from discontig.c into a new file: numa.c



---

 memhotplug-dave/arch/i386/kernel/setup.c          |    2 
 memhotplug-dave/arch/i386/mm/Makefile             |    3 
 memhotplug-dave/arch/i386/mm/discontig.c          |  177 ----------------------
 memhotplug-dave/arch/i386/mm/init.c               |    7 
 memhotplug-dave/arch/i386/mm/numa.c               |  167 ++++++++++++++++++++
 memhotplug-dave/include/asm-i386/mmzone.h         |    7 
 memhotplug-dave/include/asm-i386/pgtable-3level.h |    1 
 7 files changed, 177 insertions(+), 187 deletions(-)

diff -puN /dev/null arch/i386/mm/numa.c
--- /dev/null	2005-03-30 22:36:15.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/numa.c	2005-09-12 10:18:29.000000000 -0700
@@ -0,0 +1,167 @@
+#include <linux/bootmem.h>
+#include <linux/module.h>
+#include <linux/numa.h>
+
+#include <asm/pgtable.h>
+#include <asm/setup.h>
+
+unsigned long node_remap_start_pfn[MAX_NUMNODES];
+unsigned long node_remap_size[MAX_NUMNODES];
+unsigned long node_remap_offset[MAX_NUMNODES];
+void *node_remap_start_vaddr[MAX_NUMNODES];
+
+void *node_remap_end_vaddr[MAX_NUMNODES];
+void *node_remap_alloc_vaddr[MAX_NUMNODES];
+
+struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
+EXPORT_SYMBOL(node_data);
+
+/*
+ * Allocate memory for the pg_data_t for this node via a crude pre-bootmem
+ * method.  For node zero take this from the bottom of memory, for
+ * subsequent nodes place them at node_remap_start_vaddr which contains
+ * node local data in physically node local memory.  See setup_memory()
+ * for details.
+ */
+static bootmem_data_t node0_bdata;
+static void __init allocate_pgdat(int nid)
+{
+	if (nid && node_has_online_mem(nid))
+		NODE_DATA(nid) = (pg_data_t *)node_remap_start_vaddr[nid];
+	else {
+		NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
+		min_low_pfn += PFN_UP(sizeof(pg_data_t));
+		memset(NODE_DATA(0), 0, sizeof(struct pglist_data));
+		NODE_DATA(0)->bdata = &node0_bdata;
+	}
+}
+
+void setup_numa_kva_remap(void)
+{
+	int nid;
+	for_each_online_node(nid) {
+		if (NODE_DATA(nid))
+			continue;
+		node_remap_start_vaddr[nid] = pfn_to_kaddr(
+				max_low_pfn + node_remap_offset[nid]);
+		/* Init the node remap allocator */
+		node_remap_end_vaddr[nid] = node_remap_start_vaddr[nid] +
+			(node_remap_size[nid] * PAGE_SIZE);
+		node_remap_alloc_vaddr[nid] = node_remap_start_vaddr[nid] +
+			ALIGN(sizeof(pg_data_t), PAGE_SIZE);
+
+		allocate_pgdat(nid);
+		printk ("node %d will remap to vaddr %08lx - %08lx\n", nid,
+			(ulong) node_remap_start_vaddr[nid],
+			(ulong) pfn_to_kaddr(max_low_pfn
+			   + node_remap_offset[nid] + node_remap_size[nid]));
+	}
+}
+
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
+void __init remap_numa_kva(void)
+{
+	void *vaddr;
+	unsigned long pfn;
+	int node;
+
+	for_each_online_node(node) {
+		for (pfn=0; pfn < node_remap_size[node]; pfn += PTRS_PER_PTE) {
+			vaddr = node_remap_start_vaddr[node]+(pfn<<PAGE_SHIFT);
+			set_pmd_pfn((ulong) vaddr,
+				node_remap_start_pfn[node] + pfn,
+				PAGE_KERNEL_LARGE);
+		}
+	}
+}
+
+unsigned long calculate_numa_remap_pages(void)
+{
+	int nid;
+	unsigned long size, reserve_pages = 0;
+	unsigned long pfn;
+
+	for_each_online_node(nid) {
+		/*
+		 * The acpi/srat node info can show hot-add memroy zones
+		 * where memory could be added but not currently present.
+		 */
+		if (node_start_pfn[nid] > max_pfn)
+			continue;
+		if (node_end_pfn[nid] > max_pfn)
+			node_end_pfn[nid] = max_pfn;
+
+		/* ensure the remap includes space for the pgdat. */
+		size = node_remap_size[nid] + sizeof(pg_data_t);
+
+		/* convert size to large (pmd size) pages, rounding up */
+		size = (size + PMD_SIZE - 1) / PMD_SIZE;
+		/* now the roundup is correct, convert to PAGE_SIZE pages */
+		size = size * PTRS_PER_PTE;
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
+		printk("Reserving %ld pages of KVA for lmem_map of node %d\n",
+				size, nid);
+		node_remap_size[nid] = size;
+		node_remap_offset[nid] = reserve_pages;
+		reserve_pages += size;
+		printk("Shrinking node %d from %ld pages to %ld pages\n",
+			nid, node_end_pfn[nid], node_end_pfn[nid] - size);
+
+		if (node_end_pfn[nid] & (PTRS_PER_PTE-1)) {
+			/*
+			 * Align node_end_pfn[] and node_remap_start_pfn[] to
+			 * pmd boundary. remap_numa_kva will barf otherwise.
+			 */
+			printk("Shrinking node %d further by %ld pages for proper alignment\n",
+				nid, node_end_pfn[nid] & (PTRS_PER_PTE-1));
+			size +=  node_end_pfn[nid] & (PTRS_PER_PTE-1);
+		}
+
+		node_end_pfn[nid] -= size;
+		node_remap_start_pfn[nid] = node_end_pfn[nid];
+	}
+	printk("Reserving total of %ld pages for numa KVA remap\n",
+			reserve_pages);
+	return reserve_pages;
+}
+
+/* Find the owning node for a pfn. */
+int early_pfn_to_nid(unsigned long pfn)
+{
+	int nid;
+
+	for_each_node(nid) {
+		if (node_end_pfn[nid] == 0)
+			break;
+		if (node_start_pfn[nid] <= pfn && node_end_pfn[nid] >= pfn)
+			return nid;
+	}
+
+	return 0;
+}
diff -puN arch/i386/mm/discontig.c~i386-numa.c arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~i386-numa.c	2005-09-12 10:18:29.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/discontig.c	2005-09-12 10:18:29.000000000 -0700
@@ -32,15 +32,10 @@
 #include <linux/module.h>
 #include <linux/kexec.h>
 
-#include <asm/e820.h>
 #include <asm/setup.h>
 #include <asm/mmzone.h>
 #include <bios_ebda.h>
 
-struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
-EXPORT_SYMBOL(node_data);
-
-#ifdef CONFIG_DISCONTIGMEM
 /*
  * 4) physnode_map     - the mapping between a pfn and owning node
  * physnode_map keeps track of the physical memory layout of a generic
@@ -82,175 +77,3 @@ unsigned long node_memmap_size_bytes(int
 
 	return (nr_pages + 1) * sizeof(struct page);
 }
-#endif
-
-extern unsigned long find_max_low_pfn(void);
-extern void find_max_pfn(void);
-extern void add_one_highpage_init(struct page *, int, int);
-
-extern struct e820map e820;
-extern unsigned long init_pg_tables_end;
-extern unsigned long max_low_pfn;
-extern unsigned long totalram_pages;
-extern unsigned long totalhigh_pages;
-
-#define LARGE_PAGE_BYTES (PTRS_PER_PTE * PAGE_SIZE)
-
-unsigned long node_remap_start_pfn[MAX_NUMNODES];
-unsigned long node_remap_size[MAX_NUMNODES];
-unsigned long node_remap_offset[MAX_NUMNODES];
-void *node_remap_start_vaddr[MAX_NUMNODES];
-void set_pmd_pfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
-
-void *node_remap_end_vaddr[MAX_NUMNODES];
-void *node_remap_alloc_vaddr[MAX_NUMNODES];
-
-/* Find the owning node for a pfn. */
-int early_pfn_to_nid(unsigned long pfn)
-{
-	int nid;
-
-	for_each_node(nid) {
-		if (node_end_pfn[nid] == 0)
-			break;
-		if (node_start_pfn[nid] <= pfn && node_end_pfn[nid] >= pfn)
-			return nid;
-	}
-
-	return 0;
-}
-
-/* 
- * Allocate memory for the pg_data_t for this node via a crude pre-bootmem
- * method.  For node zero take this from the bottom of memory, for
- * subsequent nodes place them at node_remap_start_vaddr which contains
- * node local data in physically node local memory.  See setup_memory()
- * for details.
- */
-static bootmem_data_t node0_bdata;
-static void __init allocate_pgdat(int nid)
-{
-	if (nid && node_has_online_mem(nid))
-		NODE_DATA(nid) = (pg_data_t *)node_remap_start_vaddr[nid];
-	else {
-		NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
-		min_low_pfn += PFN_UP(sizeof(pg_data_t));
-		memset(NODE_DATA(0), 0, sizeof(struct pglist_data));
-		NODE_DATA(0)->bdata = &node0_bdata;
-	}
-}
-
-void setup_numa_kva_remap(void)
-{
-	int nid;
-	for_each_online_node(nid) {
-		if (NODE_DATA(nid))
-			continue;
-		node_remap_start_vaddr[nid] = pfn_to_kaddr(
-				max_low_pfn + node_remap_offset[nid]);
-		/* Init the node remap allocator */
-		node_remap_end_vaddr[nid] = node_remap_start_vaddr[nid] +
-			(node_remap_size[nid] * PAGE_SIZE);
-		node_remap_alloc_vaddr[nid] = node_remap_start_vaddr[nid] +
-			ALIGN(sizeof(pg_data_t), PAGE_SIZE);
-
-		allocate_pgdat(nid);
-		printk ("node %d will remap to vaddr %08lx - %08lx\n", nid,
-			(ulong) node_remap_start_vaddr[nid],
-			(ulong) pfn_to_kaddr(max_low_pfn
-			   + node_remap_offset[nid] + node_remap_size[nid]));
-	}
-}
-
-void *alloc_remap(int nid, unsigned long size)
-{
-	void *allocation = node_remap_alloc_vaddr[nid];
-
-	size = ALIGN(size, L1_CACHE_BYTES);
-
-	if (!allocation || (allocation + size) >= node_remap_end_vaddr[nid])
-		return 0;
-
-	node_remap_alloc_vaddr[nid] += size;
-	memset(allocation, 0, size);
-
-	return allocation;
-}
-
-void __init remap_numa_kva(void)
-{
-	void *vaddr;
-	unsigned long pfn;
-	int node;
-
-	for_each_online_node(node) {
-		for (pfn=0; pfn < node_remap_size[node]; pfn += PTRS_PER_PTE) {
-			vaddr = node_remap_start_vaddr[node]+(pfn<<PAGE_SHIFT);
-			set_pmd_pfn((ulong) vaddr, 
-				node_remap_start_pfn[node] + pfn, 
-				PAGE_KERNEL_LARGE);
-		}
-	}
-}
-
-unsigned long calculate_numa_remap_pages(void)
-{
-	int nid;
-	unsigned long size, reserve_pages = 0;
-	unsigned long pfn;
-
-	for_each_online_node(nid) {
-		/*
-		 * The acpi/srat node info can show hot-add memroy zones
-		 * where memory could be added but not currently present.
-		 */
-		if (node_start_pfn[nid] > max_pfn)
-			continue;
-		if (node_end_pfn[nid] > max_pfn)
-			node_end_pfn[nid] = max_pfn;
-
-		/* ensure the remap includes space for the pgdat. */
-		size = node_remap_size[nid] + sizeof(pg_data_t);
-
-		/* convert size to large (pmd size) pages, rounding up */
-		size = (size + LARGE_PAGE_BYTES - 1) / LARGE_PAGE_BYTES;
-		/* now the roundup is correct, convert to PAGE_SIZE pages */
-		size = size * PTRS_PER_PTE;
-
-		/*
-		 * Validate the region we are allocating only contains valid
-		 * pages.
-		 */
-		for (pfn = node_end_pfn[nid] - size;
-		     pfn < node_end_pfn[nid]; pfn++)
-			if (!page_is_ram(pfn))
-				break;
-
-		if (pfn != node_end_pfn[nid])
-			size = 0;
-
-		printk("Reserving %ld pages of KVA for lmem_map of node %d\n",
-				size, nid);
-		node_remap_size[nid] = size;
-		node_remap_offset[nid] = reserve_pages;
-		reserve_pages += size;
-		printk("Shrinking node %d from %ld pages to %ld pages\n",
-			nid, node_end_pfn[nid], node_end_pfn[nid] - size);
-
-		if (node_end_pfn[nid] & (PTRS_PER_PTE-1)) {
-			/*
-			 * Align node_end_pfn[] and node_remap_start_pfn[] to
-			 * pmd boundary. remap_numa_kva will barf otherwise.
-			 */
-			printk("Shrinking node %d further by %ld pages for proper alignment\n",
-				nid, node_end_pfn[nid] & (PTRS_PER_PTE-1));
-			size +=  node_end_pfn[nid] & (PTRS_PER_PTE-1);
-		}
-
-		node_end_pfn[nid] -= size;
-		node_remap_start_pfn[nid] = node_end_pfn[nid];
-	}
-	printk("Reserving total of %ld pages for numa KVA remap\n",
-			reserve_pages);
-	return reserve_pages;
-}
diff -puN arch/i386/mm/Makefile~i386-numa.c arch/i386/mm/Makefile
--- memhotplug/arch/i386/mm/Makefile~i386-numa.c	2005-09-12 10:18:29.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/Makefile	2005-09-12 10:18:29.000000000 -0700
@@ -4,7 +4,8 @@
 
 obj-y	:= init.o pgtable.o fault.o ioremap.o extable.o pageattr.o mmap.o
 
-obj-$(CONFIG_NUMA) += discontig.o
+obj-$(CONFIG_DISCONTIGMEM) += discontig.o
+obj-$(CONFIG_NUMA) += numa.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_BOOT_IOREMAP) += boot_ioremap.o
diff -puN include/linux/mmzone.h~i386-numa.c include/linux/mmzone.h
diff -puN include/asm-i386/mmzone.h~i386-numa.c include/asm-i386/mmzone.h
--- memhotplug/include/asm-i386/mmzone.h~i386-numa.c	2005-09-12 10:18:29.000000000 -0700
+++ memhotplug-dave/include/asm-i386/mmzone.h	2005-09-12 10:18:29.000000000 -0700
@@ -38,10 +38,15 @@ static inline void get_memcfg_numa(void)
 }
 
 extern int early_pfn_to_nid(unsigned long pfn);
-
+extern void __init remap_numa_kva(void);
+extern unsigned long calculate_numa_remap_pages(void);
+extern void setup_numa_kva_remap(void);
 #else /* !CONFIG_NUMA */
 #define get_memcfg_numa get_memcfg_numa_flat
 #define get_zholes_size(n) (0)
+#define remap_numa_kva() do {} while (0)
+#define setup_numa_kva_remap() do {} while (0)
+#define calculate_numa_remap_pages()	(0)
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_DISCONTIGMEM
diff -puN include/asm-i386/pgtable-3level.h~i386-numa.c include/asm-i386/pgtable-3level.h
--- memhotplug/include/asm-i386/pgtable-3level.h~i386-numa.c	2005-09-12 10:18:29.000000000 -0700
+++ memhotplug-dave/include/asm-i386/pgtable-3level.h	2005-09-12 10:18:29.000000000 -0700
@@ -65,6 +65,7 @@ static inline void set_pte(pte_t *ptep, 
 		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
 #define set_pud(pudptr,pudval) \
 		(*(pudptr) = (pudval))
+extern void set_pmd_pfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
 
 /*
  * Pentium-II erratum A13: in PAE mode we explicitly have to flush
diff -puN arch/i386/kernel/setup.c~i386-numa.c arch/i386/kernel/setup.c
--- memhotplug/arch/i386/kernel/setup.c~i386-numa.c	2005-09-12 10:18:29.000000000 -0700
+++ memhotplug-dave/arch/i386/kernel/setup.c	2005-09-12 10:19:48.000000000 -0700
@@ -1157,8 +1157,6 @@ static void __init find_max_pfn_node(int
 		BUG();
 }
 
-unsigned long calculate_numa_remap_pages(void);
-void setup_numa_kva_remap(void);
 void __init setup_bootmem_allocator(void);
 unsigned long __init setup_memory(void)
 {
diff -puN arch/i386/mm/init.c~i386-numa.c arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~i386-numa.c	2005-09-12 10:18:29.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/init.c	2005-09-12 10:18:29.000000000 -0700
@@ -36,6 +36,7 @@
 #include <asm/dma.h>
 #include <asm/fixmap.h>
 #include <asm/e820.h>
+#include <asm/mmzone.h>
 #include <asm/apic.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -347,12 +348,6 @@ unsigned long long __PAGE_KERNEL = _PAGE
 EXPORT_SYMBOL(__PAGE_KERNEL);
 unsigned long long __PAGE_KERNEL_EXEC = _PAGE_KERNEL_EXEC;
 
-#ifdef CONFIG_NUMA
-extern void __init remap_numa_kva(void);
-#else
-#define remap_numa_kva() do {} while (0)
-#endif
-
 static void __init pagetable_init (void)
 {
 	unsigned long vaddr;
_
