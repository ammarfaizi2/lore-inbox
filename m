Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbVCQAbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbVCQAbR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVCQA37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:29:59 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:65249 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262912AbVCQA23
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:28:29 -0500
Subject: [RFC][PATCH 5/6] sparsemem: more separation between NUMA and DISCONTIG
To: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 16 Mar 2005 16:28:22 -0800
Message-Id: <E1DBisA-0000l4-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is some confusion with the SPARSEMEM patch between what
is needed for DISCONTIG vs. NUMA.  For instance, the NODE_DATA()
macro needs to be switched on NUMA, but not on FLATMEM.

This patch is required if the previous patch is applied.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/mm/init.c       |   12 ++++++------
 memhotplug-dave/include/asm-i386/mmzone.h |    4 ++--
 memhotplug-dave/include/linux/mmzone.h    |    8 ++++++--
 memhotplug-dave/mm/page_alloc.c           |    2 +-
 mm/memory.c                               |    0 
 5 files changed, 15 insertions(+), 11 deletions(-)

diff -puN arch/i386/Kconfig~B-sparse-161-i386-separate-flatmem-and-numa arch/i386/Kconfig
diff -puN include/asm-i386/mmzone.h~B-sparse-161-i386-separate-flatmem-and-numa include/asm-i386/mmzone.h
--- memhotplug/include/asm-i386/mmzone.h~B-sparse-161-i386-separate-flatmem-and-numa	2005-03-16 15:46:40.000000000 -0800
+++ memhotplug-dave/include/asm-i386/mmzone.h	2005-03-16 15:46:40.000000000 -0800
@@ -8,7 +8,7 @@
 
 #include <asm/smp.h>
 
-#if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_SPARSEMEM)
+#if CONFIG_NUMA
 extern struct pglist_data *node_data[];
 #define NODE_DATA(nid)	(node_data[nid])
 
@@ -42,7 +42,7 @@ static inline void get_memcfg_numa(void)
 	get_memcfg_numa_flat();
 }
 
-#endif /* !CONFIG_DISCONTIGMEM || !CONFIG_SPARSEMEM */
+#endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_DISCONTIGMEM
 
diff -puN include/linux/bootmem.h~B-sparse-161-i386-separate-flatmem-and-numa include/linux/bootmem.h
diff -puN include/linux/mmzone.h~B-sparse-161-i386-separate-flatmem-and-numa include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~B-sparse-161-i386-separate-flatmem-and-numa	2005-03-16 15:46:40.000000000 -0800
+++ memhotplug-dave/include/linux/mmzone.h	2005-03-16 15:46:40.000000000 -0800
@@ -383,10 +383,13 @@ int lowmem_reserve_ratio_sysctl_handler(
 /* Returns the number of the current Node. */
 #define numa_node_id()		(cpu_to_node(_smp_processor_id()))
 
+#ifndef CONFIG_NUMA
+#define NODE_DATA(nid)		(&contig_page_data)
+extern struct pglist_data contig_page_data;
+#endif
+
 #ifdef CONFIG_FLATMEM
 
-extern struct pglist_data contig_page_data;
-#define NODE_DATA(nid)		(&contig_page_data)
 #define NODE_MEM_MAP(nid)	mem_map
 #define MAX_NODES_SHIFT		1
 #define pfn_to_nid(pfn)		(0)
@@ -521,6 +524,7 @@ static inline int pfn_valid(unsigned lon
 #define pfn_to_nid		early_pfn_to_nid
 #else
 #define pfn_to_nid(pfn) 0
+#define early_pfn_to_nid(pfn)	0
 #endif
 
 #define pfn_to_pgdat(pfn)						\
diff -puN mm/page_alloc.c~B-sparse-161-i386-separate-flatmem-and-numa mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~B-sparse-161-i386-separate-flatmem-and-numa	2005-03-16 15:46:40.000000000 -0800
+++ memhotplug-dave/mm/page_alloc.c	2005-03-16 15:46:40.000000000 -0800
@@ -1784,7 +1784,7 @@ void __init free_area_init_node(int nid,
 	free_area_init_core(pgdat, zones_size, zholes_size);
 }
 
-#ifdef CONFIG_FLATMEM
+#ifndef CONFIG_DISCONTIGMEM
 static bootmem_data_t contig_bootmem_data;
 struct pglist_data contig_page_data = { .bdata = &contig_bootmem_data };
 
diff -puN arch/i386/kernel/setup.c~B-sparse-161-i386-separate-flatmem-and-numa arch/i386/kernel/setup.c
diff -puN arch/i386/mm/init.c~B-sparse-161-i386-separate-flatmem-and-numa arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~B-sparse-161-i386-separate-flatmem-and-numa	2005-03-16 15:46:40.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/init.c	2005-03-16 15:46:40.000000000 -0800
@@ -277,7 +277,9 @@ void __init one_highpage_init(struct pag
 		SetPageReserved(page);
 }
 
-#ifdef CONFIG_FLATMEM
+#ifdef CONFIG_NUMA
+extern void set_highmem_pages_init(int);
+#else
 static void __init set_highmem_pages_init(int bad_ppro)
 {
 	int pfn;
@@ -285,8 +287,6 @@ static void __init set_highmem_pages_ini
 		one_highpage_init(pfn_to_page(pfn), pfn, bad_ppro);
 	totalram_pages += totalhigh_pages;
 }
-#else
-extern void set_highmem_pages_init(int);
 #endif /* CONFIG_FLATMEM */
 
 #else
@@ -298,10 +298,10 @@ extern void set_highmem_pages_init(int);
 unsigned long long __PAGE_KERNEL = _PAGE_KERNEL;
 unsigned long long __PAGE_KERNEL_EXEC = _PAGE_KERNEL_EXEC;
 
-#ifdef CONFIG_FLATMEM
-#define remap_numa_kva() do {} while (0)
-#else
+#ifdef CONFIG_NUMA
 extern void __init remap_numa_kva(void);
+#else
+#define remap_numa_kva() do {} while (0)
 #endif
 
 static void __init pagetable_init (void)
diff -puN mm/memory.c~B-sparse-161-i386-separate-flatmem-and-numa mm/memory.c
_
