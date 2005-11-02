Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965323AbVKBWcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965323AbVKBWcX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965330AbVKBWcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:32:22 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:47780 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S965325AbVKBWcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:32:21 -0500
Date: Thu, 3 Nov 2005 00:32:20 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] sh: Drop hp690 discontig support.
Message-ID: <20051102223220.GF27200@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was only one board using this (hp690 specifically), and it just so
happens that it's only physically discontiguous at the "normal" P1
offset. If we bump up the P1 offset, it's possible to hit a shadowed
region of memory where we suddenly become magically contiguous.

As people have been using this shadowed region workaround for quite some
time (and without any adverse effects), it's time to drop the left over
discontig bits that no longer have any practical use (it was always very
much hp690-centric to begin with).

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/Kconfig         |   10 --------
 arch/sh/kernel/setup.c  |   26 +++++---------------
 arch/sh/mm/init.c       |   21 ++--------------
 include/asm-sh/mmzone.h |   61 -----------------------------------------------
 include/asm-sh/page.h   |    7 -----
 5 files changed, 9 insertions(+), 116 deletions(-)
 delete mode 100644 include/asm-sh/mmzone.h

applies-to: b87f4a86b1260d0af555a22574e5e65aef94f7c5
a4f419994baed1c940814a0bfb9cdedc371b9d82
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7d31d62..64f5ae0 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -490,16 +490,6 @@ config CPU_SUBTYPE_ST40
        depends on CPU_SUBTYPE_ST40STB1 || CPU_SUBTYPE_ST40GX1
        default y
 
-config ARCH_DISCONTIGMEM_ENABLE
-	bool
-	depends on SH_HP690
-	default y
-	help
-	  Say Y to upport efficient handling of discontiguous physical memory,
-	  for architectures which are either NUMA (Non-Uniform Memory Access)
-	  or have huge holes in the physical address space for other reasons.
-	  See <file:Documentation/vm/numa> for more.
-
 source "mm/Kconfig"
 
 config ZERO_PAGE_OFFSET
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 25b9d9e..036050b 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -83,9 +83,9 @@ static struct sh_machine_vector* __init 
 /* ... */
 #define COMMAND_LINE ((char *) (PARAM+0x100))
 
-#define RAMDISK_IMAGE_START_MASK  	0x07FF
+#define RAMDISK_IMAGE_START_MASK	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000	
+#define RAMDISK_LOAD_FLAG		0x4000
 
 static char command_line[COMMAND_LINE_SIZE] = { 0, };
 
@@ -284,18 +284,6 @@ void __init setup_arch(char **cmdline_p)
 #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
 #define PFN_PHYS(x)	((x) << PAGE_SHIFT)
 
-#ifdef CONFIG_DISCONTIGMEM
-	NODE_DATA(0)->bdata = &discontig_node_bdata[0];
-	NODE_DATA(1)->bdata = &discontig_node_bdata[1];
-
-	bootmap_size = init_bootmem_node(NODE_DATA(1), 
-					 PFN_UP(__MEMORY_START_2ND),
-					 PFN_UP(__MEMORY_START_2ND),
-					 PFN_DOWN(__MEMORY_START_2ND+__MEMORY_SIZE_2ND));
-	free_bootmem_node(NODE_DATA(1), __MEMORY_START_2ND, __MEMORY_SIZE_2ND);
-	reserve_bootmem_node(NODE_DATA(1), __MEMORY_START_2ND, bootmap_size);
-#endif
-
 	/*
 	 * Find the highest page frame number we have available
 	 */
@@ -306,10 +294,10 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	max_low_pfn = max_pfn;
 
- 	/*
+	/*
 	 * Partially used pages are not usable - thus
 	 * we are rounding upwards:
- 	 */
+	 */
 	start_pfn = PFN_UP(__pa(_end));
 
 	/*
@@ -360,12 +348,12 @@ void __init setup_arch(char **cmdline_p)
 	reserve_bootmem_node(NODE_DATA(0), __MEMORY_START, PAGE_SIZE);
 
 #ifdef CONFIG_BLK_DEV_INITRD
- 	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
- 	if (&__rd_start != &__rd_end) {
+	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
+	if (&__rd_start != &__rd_end) {
 		LOADER_TYPE = 1;
 		INITRD_START = PHYSADDR((unsigned long)&__rd_start) - __MEMORY_START;
 		INITRD_SIZE = (unsigned long)&__rd_end - (unsigned long)&__rd_start;
- 	}
+	}
 
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 4e9c854..e342565 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -51,11 +51,6 @@ unsigned long mmu_context_cache = NO_CON
 #define MAX_LOW_PFN	(NODE_DATA(0)->bdata->node_low_pfn)
 #endif
 
-#ifdef CONFIG_DISCONTIGMEM
-pg_data_t discontig_page_data[MAX_NUMNODES];
-bootmem_data_t discontig_node_bdata[MAX_NUMNODES];
-#endif
-
 void (*copy_page)(void *from, void *to);
 void (*clear_page)(void *to);
 
@@ -216,15 +211,6 @@ void __init paging_init(void)
 #endif
 	NODE_DATA(0)->node_mem_map = NULL;
 	free_area_init_node(0, NODE_DATA(0), zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
-
-#ifdef CONFIG_DISCONTIGMEM
-	/*
-	 * And for discontig, do some more fixups on the zone sizes..
-	 */
-	zones_size[ZONE_DMA] = __MEMORY_SIZE_2ND >> PAGE_SHIFT;
-	zones_size[ZONE_NORMAL] = 0;
-	free_area_init_node(1, NODE_DATA(1), zones_size, __MEMORY_START_2ND >> PAGE_SHIFT, 0);
-#endif
 }
 
 void __init mem_init(void)
@@ -248,7 +234,7 @@ void __init mem_init(void)
 	memset(empty_zero_page, 0, PAGE_SIZE);
 	__flush_wback_region(empty_zero_page, PAGE_SIZE);
 
-	/* 
+	/*
 	 * Setup wrappers for copy/clear_page(), these will get overridden
 	 * later in the boot process if a better method is available.
 	 */
@@ -257,9 +243,6 @@ void __init mem_init(void)
 
 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem_node(NODE_DATA(0));
-#ifdef CONFIG_DISCONTIGMEM
-	totalram_pages += free_all_bootmem_node(NODE_DATA(1));
-#endif
 	reservedpages = 0;
 	for (tmp = 0; tmp < num_physpages; tmp++)
 		/*
@@ -286,7 +269,7 @@ void __init mem_init(void)
 void free_initmem(void)
 {
 	unsigned long addr;
-	
+
 	addr = (unsigned long)(&__init_begin);
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
diff --git a/include/asm-sh/mmzone.h b/include/asm-sh/mmzone.h
deleted file mode 100644
index 0e74066..0000000
--- a/include/asm-sh/mmzone.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- *  linux/include/asm-sh/mmzone.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ASM_SH_MMZONE_H
-#define __ASM_SH_MMZONE_H
-
-#include <linux/config.h>
-
-#ifdef CONFIG_DISCONTIGMEM
-
-/* Currently, just for HP690 */
-#define PHYSADDR_TO_NID(phys)	((((phys) - __MEMORY_START) >= 0x01000000)?1:0)
-
-extern pg_data_t discontig_page_data[MAX_NUMNODES];
-extern bootmem_data_t discontig_node_bdata[MAX_NUMNODES];
-
-/*
- * Following are macros that each numa implmentation must define.
- */
-
-/*
- * Given a kernel address, find the home node of the underlying memory.
- */
-#define KVADDR_TO_NID(kaddr)	PHYSADDR_TO_NID(__pa(kaddr))
-
-/*
- * Return a pointer to the node data for node n.
- */
-#define NODE_DATA(nid)		(&discontig_page_data[nid])
-
-/*
- * NODE_MEM_MAP gives the kaddr for the mem_map of the node.
- */
-#define NODE_MEM_MAP(nid)	(NODE_DATA(nid)->node_mem_map)
-
-#define phys_to_page(phys)						\
-({ unsigned int node = PHYSADDR_TO_NID(phys); 		      		\
-   NODE_MEM_MAP(node)				 		 	\
-     + (((phys) - NODE_DATA(node)->node_start_paddr) >> PAGE_SHIFT); })
-
-static inline int is_valid_page(struct page *page)
-{
-	unsigned int i;
-
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		if (page >= NODE_MEM_MAP(i) &&
-		    page < NODE_MEM_MAP(i) + NODE_DATA(i)->node_size)
-			return 1;
-	}
-	return 0;
-}
-
-#define VALID_PAGE(page)	is_valid_page(page)
-#define page_to_phys(page)	PHYSADDR(page_address(page))
-
-#endif /* CONFIG_DISCONTIGMEM */
-#endif
diff --git a/include/asm-sh/page.h b/include/asm-sh/page.h
index 324e6cc..972c3f6 100644
--- a/include/asm-sh/page.h
+++ b/include/asm-sh/page.h
@@ -93,11 +93,6 @@ typedef struct { unsigned long pgprot; }
 
 #define __MEMORY_START		CONFIG_MEMORY_START
 #define __MEMORY_SIZE		CONFIG_MEMORY_SIZE
-#ifdef CONFIG_DISCONTIGMEM
-/* Just for HP690, for now.. */
-#define __MEMORY_START_2ND	(__MEMORY_START+0x02000000)
-#define __MEMORY_SIZE_2ND	0x001000000 /* 16MB */
-#endif
 
 #define PAGE_OFFSET		(0x80000000UL)
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
@@ -105,10 +100,8 @@ typedef struct { unsigned long pgprot; }
 
 #define MAP_NR(addr)		(((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT)
 
-#ifndef CONFIG_DISCONTIGMEM
 #define phys_to_page(phys)	(mem_map + (((phys)-__MEMORY_START) >> PAGE_SHIFT))
 #define page_to_phys(page)	(((page - mem_map) << PAGE_SHIFT) + __MEMORY_START)
-#endif
 
 /* PFN start number, because of __MEMORY_START */
 #define PFN_START		(__MEMORY_START >> PAGE_SHIFT)
---
0.99.8.GIT
