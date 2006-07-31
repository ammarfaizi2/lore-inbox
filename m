Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWGaN4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWGaN4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 09:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWGaN4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 09:56:14 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:459 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750849AbWGaN4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 09:56:12 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 6/6] AVR32: Kill CONFIG_DISCONTIGMEM support completely
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Mon, 31 Jul 2006 15:56:00 +0200
Message-Id: <1154354160983-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11543541603922-git-send-email-hskinnemoen@atmel.com>
References: <1154354160566-git-send-email-hskinnemoen@atmel.com> <11543541601753-git-send-email-hskinnemoen@atmel.com> <11543541602148-git-send-email-hskinnemoen@atmel.com> <11543541601135-git-send-email-hskinnemoen@atmel.com> <11543541603922-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen called discontigmem as "legacy", so since there are no
AVR32 boards that actually need it, we might as well kill it
completely. Which is what this patch does.

Whenever someone stumbles across a board with multiple memory banks,
I'll implement sparsemem support instead, hopefully with help from
Dave and Andy.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Dave Hansen <haveblue@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>
---
 arch/avr32/mm/Makefile     |    1 -
 arch/avr32/mm/discontig.c  |   27 ---------------------------
 arch/avr32/mm/init.c       |   28 +++++-----------------------
 include/asm-avr32/mmzone.h |   29 -----------------------------
 4 files changed, 5 insertions(+), 80 deletions(-)

diff --git a/arch/avr32/mm/Makefile b/arch/avr32/mm/Makefile
index 3338374..0066491 100644
--- a/arch/avr32/mm/Makefile
+++ b/arch/avr32/mm/Makefile
@@ -4,4 +4,3 @@ #
 
 obj-y				+= init.o clear_page.o copy_page.o dma-coherent.o
 obj-y				+= ioremap.o cache.o fault.o tlb.o
-obj-$(CONFIG_DISCONTIGMEM)	+= discontig.o
diff --git a/arch/avr32/mm/discontig.c b/arch/avr32/mm/discontig.c
deleted file mode 100644
index d5c18ec..0000000
--- a/arch/avr32/mm/discontig.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Copyright (C) 2004-2006 Atmel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/bootmem.h>
-
-#if MAX_NUMNODES != 4
-#error Fix Me Please
-#endif
-
-static bootmem_data_t node_bootmem_data[MAX_NUMNODES];
-pg_data_t discontig_node_data[MAX_NUMNODES] = {
-	{ .bdata = &node_bootmem_data[0] },
-	{ .bdata = &node_bootmem_data[1] },
-	{ .bdata = &node_bootmem_data[2] },
-	{ .bdata = &node_bootmem_data[3] }
-};
-
-EXPORT_SYMBOL(discontig_node_data);
-
diff --git a/arch/avr32/mm/init.c b/arch/avr32/mm/init.c
index e4b6707..e33b4ff 100644
--- a/arch/avr32/mm/init.c
+++ b/arch/avr32/mm/init.c
@@ -36,10 +36,8 @@ struct page *empty_zero_page;
  */
 unsigned long mmu_context_cache = NO_CONTEXT;
 
-#if !defined(CONFIG_DISCONTIGMEM)
-# define START_PFN	(NODE_DATA(0)->bdata->node_boot_start >> PAGE_SHIFT)
-# define MAX_LOW_PFN	(NODE_DATA(0)->bdata->node_low_pfn)
-#endif
+#define START_PFN	(NODE_DATA(0)->bdata->node_boot_start >> PAGE_SHIFT)
+#define MAX_LOW_PFN	(NODE_DATA(0)->bdata->node_low_pfn)
 
 void show_mem(void)
 {
@@ -223,27 +221,15 @@ #else
 #endif
 	}
 
-#ifndef CONFIG_DISCONTIGMEM
 	if (mem_phys->next)
-		printk(KERN_WARNING "Only using first memory bank "
-		       "since CONFIG_DISCONTIGMEM is off\n");
+		printk(KERN_WARNING "Only using first memory bank\n");
+
 	for (bank = mem_phys; bank; bank = NULL) {
-#else
-	for (bank = mem_phys; bank; bank = bank->next, node++) {
-#endif
 		first_pfn = PFN_UP(bank->addr);
 		max_low_pfn = max_pfn = PFN_DOWN(bank->addr + bank->size);
 		bootmap_pfn = find_bootmap_pfn(bank);
-		if (bootmap_pfn > max_pfn) {
-#ifndef CONFIG_DISCONTIGMEM
+		if (bootmap_pfn > max_pfn)
 			panic("No space for bootmem bitmap!\n");
-#else
-			printk(KERN_WARNING
-			       "Node %u: No space for bootmem bitmap\n",
-				node);
-			continue;
-#endif
-		}
 
 		if (max_low_pfn > MAX_LOWMEM_PFN) {
 			max_low_pfn = MAX_LOWMEM_PFN;
@@ -397,9 +383,7 @@ void __init paging_init(void)
 		       pgdat->node_id, pgdat->node_mem_map);
 	}
 
-#ifndef CONFIG_DISCONTIGMEM
 	mem_map = NODE_DATA(0)->node_mem_map;
-#endif
 
 	memset(zero_page, 0, PAGE_SIZE);
 	empty_zero_page = virt_to_page(zero_page);
@@ -438,9 +422,7 @@ void __init mem_init(void)
 			high_memory = node_high_memory;
 	}
 
-#ifndef CONFIG_DISCONTIGMEM
 	max_mapnr = MAP_NR(high_memory);
-#endif
 
 	codesize = (unsigned long)_etext - (unsigned long)_text;
 	datasize = (unsigned long)_edata - (unsigned long)_data;
diff --git a/include/asm-avr32/mmzone.h b/include/asm-avr32/mmzone.h
deleted file mode 100644
index 13ca94f..0000000
--- a/include/asm-avr32/mmzone.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Copyright (C) 2004-2006 Atmel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ASM_AVR32_MMZONE_H
-#define __ASM_AVR32_MMZONE_H
-
-#include <asm/page.h>
-
-#ifdef CONFIG_DISCONTIGMEM
-
-static inline int pfn_valid(unsigned long pfn)
-{
-	unsigned long __pfn = (pfn);
-	int __n = pfn_to_nid(__pfn);
-
-	if (__n < 0)
-		return 0;
-
-	return __pfn < (NODE_DATA(__n)->node_start_pfn
-			+ NODE_DATA(__n)->node_spanned_pages);
-}
-
-#endif /* CONFIG_DISCONTIGMEM */
-
-#endif /* __ASM_AVR32_MMZONE_H */
-- 
1.4.0

