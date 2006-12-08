Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424826AbWLHHBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424826AbWLHHBT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 02:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424859AbWLHHBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 02:01:19 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:42259 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424826AbWLHHBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 02:01:18 -0500
Date: Fri, 8 Dec 2006 16:04:54 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org,
       akpm@osdl.org
Subject: [RFC] [PATCH] virtual memmap on sparsemem v3 [2/4] generic virtual
 mem_map on sparsemem
Message-Id: <20061208160454.33fedd3f.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements of virtual mem_map on sparsemem.
This includes only arch independent part and depends on
generic map/unmap in the kernel function in this patch series.

Usual sparsemem(_extreme) have to do global table look up in
pfn_to_page()/page_to_pfn(), this seems a bit costly.

If an arch has enough address space to map all mem_map in linear,
it is good to map sprase mem_map as linear mem_map. This redcuces
cost of pfn_to_page()/page_to_pfn().
This concept is used by ia64's VIRTUAL_MEM_MAP.

pfn_valid() works as same as usual sparsemem.

callbacks to create vmem_map are used for using alloc_bootmem_node() for
allocationg pud/pmd/pte.

How to use:
fix struct page *mem_map's pointing address before calling sparse_init().
that's all.

Note:
I assumes that mem_map per each section is always aligned to PAGE_SIZE.
For example, ia64.
sizeof(struct page) = 56 && PAGES_PER_SECTION=65536. Then mem_map per
section is aligned to 56 * 65536 bytes.
#error will detect this.

Signed-Off-By: KAMEZAWA Hiruyoki <kamezawa.hiroyu@jp.fujitsu.com>


Index: devel-2.6.19/mm/sparse.c
===================================================================
--- devel-2.6.19.orig/mm/sparse.c	2006-11-30 06:57:37.000000000 +0900
+++ devel-2.6.19/mm/sparse.c	2006-12-08 15:03:02.000000000 +0900
@@ -9,6 +9,8 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <asm/dma.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
 
 /*
  * Permanent SPARSEMEM data:
@@ -76,6 +78,106 @@
 }
 #endif
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+
+struct vmemmap_create_arg {
+	int section_nr;
+	int nid;
+};
+
+/* call backs for memory map */
+static int
+__init pte_alloc_vmemmap_boot(pmd_t *pmd, unsigned long addr, void *data)
+{
+	struct vmemmap_create_arg *arg = data;
+	void *pg = alloc_bootmem_pages_node(NODE_DATA(arg->nid), PAGE_SIZE);
+	BUG_ON(!pg);
+	pmd_populate_kernel(&init_mm, pmd, pg);
+	return 0;
+}
+static int
+__init pmd_alloc_vmemmap_boot(pud_t *pud, unsigned long addr, void *data)
+{
+	struct vmemmap_create_arg *arg = data;
+	void *pg = alloc_bootmem_pages_node(NODE_DATA(arg->nid), PAGE_SIZE);
+	BUG_ON(!pg);
+	pud_populate(&init_mm, pud, pg);
+	return 0;
+}
+
+static int
+__init pud_alloc_vmemmap_boot(pgd_t *pgd, unsigned long addr, void *data)
+{
+	struct vmemmap_create_arg *arg = data;
+	void *pg = alloc_bootmem_pages_node(NODE_DATA(arg->nid), PAGE_SIZE);
+	BUG_ON(!pg);
+	pgd_populate(&init_mm, pgd, pg);
+	return 0;
+}
+
+static int
+__init pte_set_vmemmap_boot(pte_t *pte, unsigned long addr, void *data)
+{
+	struct vmemmap_create_arg *arg = data;
+	struct mem_section *ms = __nr_to_section(arg->section_nr);
+	unsigned long pmap, vmap, section_pfn, pfn;
+
+	section_pfn = section_nr_to_pfn(arg->section_nr);
+	/* we already have mem_map in linear address space. calc it */
+
+	/* decode encoded value of base address. */
+	pmap = ms->section_mem_map & SECTION_MAP_MASK;
+	pmap = (unsigned long)((struct page *)pmap + section_pfn);
+	/* section's start */
+	vmap = (unsigned long)pfn_to_page(section_pfn);
+
+	pfn = (__pa(pmap) + (addr - vmap)) >> PAGE_SHIFT;
+	set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
+	return 0;
+}
+
+static int
+__init pte_clear_vmemmap(pte_t *pte, unsigned long addr, void *data)
+{
+	BUG();
+}
+
+struct gen_map_kern_ops vmemmap_boot_ops = {
+	.k_pte_set	= pte_set_vmemmap_boot,
+	.k_pte_clear	= pte_clear_vmemmap,
+	.k_pud_alloc	= pud_alloc_vmemmap_boot,
+	.k_pmd_alloc	= pmd_alloc_vmemmap_boot,
+	.k_pte_alloc	= pte_alloc_vmemmap_boot,
+};
+
+static int
+__init map_virtual_mem_map(unsigned long section, int nid)
+{
+	struct vmemmap_create_arg arg;
+	unsigned long vmap_start, vmap_size;
+	vmap_start = (unsigned long)pfn_to_page(section_nr_to_pfn(section));
+	vmap_size = PAGES_PER_SECTION * sizeof(struct page);
+	arg.section_nr = section;
+	arg.nid = nid;
+
+	if (system_state == SYSTEM_BOOTING) {
+		map_generic_kernel(vmap_start, vmap_size, &vmemmap_boot_ops,
+				   &arg);
+	} else {
+		BUG();
+	}
+	/* if bug, panic occurs.*/
+	return 0;
+}
+#else
+static int
+__init map_virtual_mem_map(unsigned long section, int nid)
+{
+	return 0;
+}
+#endif
+
+
 /*
  * Although written for the SPARSEMEM_EXTREME case, this happens
  * to also work for the flat array case becase
@@ -92,7 +194,7 @@
 			continue;
 
 		if ((ms >= root) && (ms < (root + SECTIONS_PER_ROOT)))
-		     break;
+			break;
 	}
 
 	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
@@ -175,13 +277,14 @@
 }
 
 static int sparse_init_one_section(struct mem_section *ms,
-		unsigned long pnum, struct page *mem_map)
+		unsigned long pnum, struct page *mem_map, int node)
 {
 	if (!valid_section(ms))
 		return -EINVAL;
 
 	ms->section_mem_map &= ~SECTION_MAP_MASK;
 	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum);
+	map_virtual_mem_map(pnum, node);
 
 	return 1;
 }
@@ -261,7 +364,8 @@
 		map = sparse_early_mem_map_alloc(pnum);
 		if (!map)
 			continue;
-		sparse_init_one_section(__nr_to_section(pnum), pnum, map);
+		sparse_init_one_section(__nr_to_section(pnum), pnum, map,
+				sparse_early_nid(__nr_to_section(pnum)));
 	}
 }
 
@@ -296,7 +400,7 @@
 	}
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 
-	ret = sparse_init_one_section(ms, section_nr, memmap);
+	ret = sparse_init_one_section(ms, section_nr, memmap, pgdat->node_id);
 
 out:
 	pgdat_resize_unlock(pgdat, &flags);
Index: devel-2.6.19/mm/Kconfig
===================================================================
--- devel-2.6.19.orig/mm/Kconfig	2006-11-30 06:57:37.000000000 +0900
+++ devel-2.6.19/mm/Kconfig	2006-12-08 15:05:10.000000000 +0900
@@ -112,12 +112,22 @@
 	def_bool y
 	depends on SPARSEMEM && !SPARSEMEM_STATIC
 
+config SPARSEMEM_VMEMMAP
+	bool	"Virutally contiguous mem_map on sparsemem"
+	depends on SPARSEMEM && !SPARSEMEM_STATIC && ARCH_SPARSEMEM_VMEMMAP
+	help
+	  This allows micro optimization to reduce costs of accessing
+	  infrastructure of memory management.
+	  But this consumes huge amount of virtual memory(not physical).
+	  This option is selectable only if your arch supports it.
+
 # eventually, we can have this option just 'select SPARSEMEM'
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
 	depends on SPARSEMEM || X86_64_ACPI_NUMA
 	depends on HOTPLUG && !SOFTWARE_SUSPEND && ARCH_ENABLE_MEMORY_HOTPLUG
 	depends on (IA64 || X86 || PPC64)
+	depends on !SPARSEMEM_VMEMMAP
 
 comment "Memory hotplug is currently incompatible with Software Suspend"
 	depends on SPARSEMEM && HOTPLUG && SOFTWARE_SUSPEND
Index: devel-2.6.19/include/linux/mmzone.h
===================================================================
--- devel-2.6.19.orig/include/linux/mmzone.h	2006-11-30 06:57:37.000000000 +0900
+++ devel-2.6.19/include/linux/mmzone.h	2006-12-08 15:04:30.000000000 +0900
@@ -311,7 +311,7 @@
 };
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 
-#ifndef CONFIG_DISCONTIGMEM
+#if !defined(CONFIG_DISCONTIGMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 /* The array of struct pages - for discontigmem use pgdat->lmem_map */
 extern struct page *mem_map;
 #endif
@@ -614,6 +614,13 @@
 #define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
 #define SECTION_NID_SHIFT	2
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#if (((BITS_PER_LONG/4) * PAGES_PER_SECTION) % PAGE_SIZE) != 0
+#error "PAGE_SIZE/SECTION_SIZE relationship is not suitable for vmem_map"
+#endif
+extern struct page* mem_map;
+#endif
+
 static inline struct page *__section_mem_map_addr(struct mem_section *section)
 {
 	unsigned long map = section->section_mem_map;
Index: devel-2.6.19/include/asm-generic/memory_model.h
===================================================================
--- devel-2.6.19.orig/include/asm-generic/memory_model.h	2006-11-30 06:57:37.000000000 +0900
+++ devel-2.6.19/include/asm-generic/memory_model.h	2006-12-08 15:03:02.000000000 +0900
@@ -47,6 +47,11 @@
 })
 
 #elif defined(CONFIG_SPARSEMEM)
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#define __page_to_pfn(pg)		((pg) - mem_map)
+#define __pfn_to_page(pfn)		(mem_map + (pfn))
+#else
 /*
  * Note: section's mem_map is encorded to reflect its start_pfn.
  * section[i].section_mem_map == mem_map's address - start_pfn;
@@ -62,6 +67,7 @@
 	struct mem_section *__sec = __pfn_to_section(__pfn);	\
 	__section_mem_map_addr(__sec) + __pfn;		\
 })
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
 #endif /* CONFIG_FLATMEM/DISCONTIGMEM/SPARSEMEM */
 
 #ifdef CONFIG_OUT_OF_LINE_PFN_TO_PAGE
Index: devel-2.6.19/mm/memory.c
===================================================================
--- devel-2.6.19.orig/mm/memory.c	2006-11-30 06:57:37.000000000 +0900
+++ devel-2.6.19/mm/memory.c	2006-12-08 15:03:02.000000000 +0900
@@ -69,6 +69,12 @@
 EXPORT_SYMBOL(mem_map);
 #endif
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+/* for the virtual mem_map */
+struct page *mem_map;
+EXPORT_SYMBOL(mem_map);
+#endif
+
 unsigned long num_physpages;
 /*
  * A number of key systems in x86 including ioremap() rely on the assumption

