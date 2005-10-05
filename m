Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbVJEVGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVJEVGr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVJEVGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:06:47 -0400
Received: from [203.171.93.254] ([203.171.93.254]:25002 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S964783AbVJEVGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:06:47 -0400
Subject: [PATCH] Free swap suspend from dependency on PageReserved
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1128546263.10363.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 06 Oct 2005 07:04:23 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nigel Cunningham <nigel@suspend2.net>

This patch removes the dependency that swap suspend currently has on
PageReserved. In the places where PageReserved is currently set and
cleared, we also set and clear PageNosave, and in swap suspend itself,
we only reference PageNosave. The ongoing effort at freeing PageReserved
thus achieves another step forward.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 arch/i386/mm/init.c   |   36 ++++++++++++++++++++++++++++--------
 arch/ppc/mm/init.c    |   22 +++++++++++++++++++---
 arch/x86_64/mm/init.c |    2 ++
 kernel/power/swsusp.c |    7 +++----
 mm/bootmem.c          |    4 ++++
 5 files changed, 56 insertions(+), 15 deletions(-)
diff -ruNp 3120-e820-table-support.patch-old/arch/i386/mm/init.c 3120-e820-table-support.patch-new/arch/i386/mm/init.c
--- 3120-e820-table-support.patch-old/arch/i386/mm/init.c	2005-10-03 09:50:10.000000000 +1000
+++ 3120-e820-table-support.patch-new/arch/i386/mm/init.c	2005-10-04 21:41:12.000000000 +1000
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/efi.h>
+#include <linux/suspend.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -270,11 +271,14 @@ void __init one_highpage_init(struct pag
 {
 	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
 		ClearPageReserved(page);
+		ClearPageNosave(page);
 		set_page_count(page, 1);
 		__free_page(page);
 		totalhigh_pages++;
-	} else
+	} else {
 		SetPageReserved(page);
+		SetPageNosave(page);
+	}
 }
 
 #ifdef CONFIG_NUMA
@@ -353,7 +357,7 @@ static void __init pagetable_init (void)
 #endif
 }
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
+#ifdef CONFIG_PM
 /*
  * Swap suspend & friends need this for resume because things like the intel-agp
  * driver might have split up a kernel 4MB mapping.
@@ -540,6 +544,7 @@ void __init mem_init(void)
 	int codesize, reservedpages, datasize, initsize;
 	int tmp;
 	int bad_ppro;
+	void * addr;
 
 #ifdef CONFIG_FLATMEM
 	if (!mem_map)
@@ -570,12 +575,25 @@ void __init mem_init(void)
 	totalram_pages += free_all_bootmem();
 
 	reservedpages = 0;
-	for (tmp = 0; tmp < max_low_pfn; tmp++)
-		/*
-		 * Only count reserved RAM pages
-		 */
-		if (page_is_ram(tmp) && PageReserved(pfn_to_page(tmp)))
-			reservedpages++;
+	addr = __va(0);
+	for (tmp = 0; tmp < max_low_pfn; tmp++, addr += PAGE_SIZE) {
+		if (page_is_ram(tmp)) {
+			/*
+			 * Only count reserved RAM pages
+			 */
+			if (PageReserved(mem_map+tmp))
+				reservedpages++;
+			/*
+			 * Mark nosave pages
+			 */
+			if (addr >= (void *)&__nosave_begin && addr < (void *)&__nosave_end)
+				SetPageNosave(mem_map+tmp);
+		} else
+			/*
+			 * Non-RAM pages are always nosave
+			 */
+			SetPageNosave(mem_map+tmp);
+	}
 
 	set_highmem_pages_init(bad_ppro);
 
@@ -674,6 +692,7 @@ void free_initmem(void)
 	addr = (unsigned long)(&__init_begin);
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
+		ClearPageNosave(virt_to_page(addr));
 		set_page_count(virt_to_page(addr), 1);
 		memset((void *)addr, 0xcc, PAGE_SIZE);
 		free_page(addr);
@@ -689,6 +708,7 @@ void free_initrd_mem(unsigned long start
 		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
+		ClearPageNosave(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
 		free_page(start);
 		totalram_pages++;
diff -ruNp 3120-e820-table-support.patch-old/arch/ppc/mm/init.c 3120-e820-table-support.patch-new/arch/ppc/mm/init.c
--- 3120-e820-table-support.patch-old/arch/ppc/mm/init.c	2005-10-03 09:50:18.000000000 +1000
+++ 3120-e820-table-support.patch-new/arch/ppc/mm/init.c	2005-10-06 06:49:04.000000000 +1000
@@ -32,6 +32,7 @@
 #include <linux/highmem.h>
 #include <linux/initrd.h>
 #include <linux/pagemap.h>
+#include <linux/suspend.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -147,6 +148,7 @@ static void free_sec(unsigned long start
 
 	while (start < end) {
 		ClearPageReserved(virt_to_page(start));
+		ClearPageNosave(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
 		free_page(start);
 		cnt++;
@@ -187,6 +189,7 @@ void free_initrd_mem(unsigned long start
 
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
+		ClearPageNosave(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
 		free_page(start);
 		totalram_pages++;
@@ -422,8 +425,10 @@ void __init mem_init(void)
 	/* if we are booted from BootX with an initial ramdisk,
 	   make sure the ramdisk pages aren't reserved. */
 	if (initrd_start) {
-		for (addr = initrd_start; addr < initrd_end; addr += PAGE_SIZE)
+		for (addr = initrd_start; addr < initrd_end; addr += PAGE_SIZE) {
 			ClearPageReserved(virt_to_page(addr));
+			ClearPageNosave(virt_to_page(addr));
+		}
 	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
@@ -432,17 +437,27 @@ void __init mem_init(void)
 	if ( rtas_data )
 		for (addr = (ulong)__va(rtas_data);
 		     addr < PAGE_ALIGN((ulong)__va(rtas_data)+rtas_size) ;
-		     addr += PAGE_SIZE)
+		     addr += PAGE_SIZE) {
 			SetPageReserved(virt_to_page(addr));
+			SetPageNosave(virt_to_page(addr));
+		}
 #endif
 #ifdef CONFIG_PPC_PMAC
-	if (agp_special_page)
+	if (agp_special_page) {
 		SetPageReserved(virt_to_page(agp_special_page));
+		SetPageNosave(virt_to_page(agp_special_page));
+	}
 #endif
 	for (addr = PAGE_OFFSET; addr < (unsigned long)high_memory;
 	     addr += PAGE_SIZE) {
 		if (!PageReserved(virt_to_page(addr)))
 			continue;
+		/*
+		 * Mark nosave pages
+		 */
+		if (addr >= (void *)&__nosave_begin && addr < (void *)&__nosave_end)
+			SetPageNosave(virt_to_page(addr));
+
 		if (addr < (ulong) etext)
 			codepages++;
 		else if (addr >= (unsigned long)&__init_begin
@@ -460,6 +475,7 @@ void __init mem_init(void)
 			struct page *page = mem_map + pfn;
 
 			ClearPageReserved(page);
+			ClearPageNosave(page);
 			set_page_count(page, 1);
 			__free_page(page);
 			totalhigh_pages++;
diff -ruNp 3120-e820-table-support.patch-old/arch/x86_64/mm/init.c 3120-e820-table-support.patch-new/arch/x86_64/mm/init.c
--- 3120-e820-table-support.patch-old/arch/x86_64/mm/init.c	2005-10-03 09:50:25.000000000 +1000
+++ 3120-e820-table-support.patch-new/arch/x86_64/mm/init.c	2005-10-06 06:51:25.000000000 +1000
@@ -458,6 +458,7 @@ void free_initmem(void)
 	addr = (unsigned long)(&__init_begin);
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
+		ClearPageNosave(virt_to_page(addr));
 		set_page_count(virt_to_page(addr), 1);
 		memset((void *)(addr & ~(PAGE_SIZE-1)), 0xcc, PAGE_SIZE); 
 		free_page(addr);
@@ -475,6 +476,7 @@ void free_initrd_mem(unsigned long start
 	printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
+		ClearPageNosave(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
 		free_page(start);
 		totalram_pages++;
diff -ruNp 3120-e820-table-support.patch-old/kernel/power/swsusp.c 3120-e820-table-support.patch-new/kernel/power/swsusp.c
--- 3120-e820-table-support.patch-old/kernel/power/swsusp.c	2005-10-03 09:51:29.000000000 +1000
+++ 3120-e820-table-support.patch-new/kernel/power/swsusp.c	2005-10-06 06:51:22.000000000 +1000
@@ -672,13 +672,12 @@ static int saveable(struct zone * zone, 
 		return 0;
 
 	page = pfn_to_page(pfn);
-	BUG_ON(PageReserved(page) && PageNosave(page));
-	if (PageNosave(page))
-		return 0;
-	if (PageReserved(page) && pfn_is_nosave(pfn)) {
+	if (pfn_is_nosave(pfn)) {
 		pr_debug("[nosave pfn 0x%lx]", pfn);
 		return 0;
 	}
+	if (PageNosave(page))
+		return 0;
 	if (PageNosaveFree(page))
 		return 0;
 
diff -ruNp 3120-e820-table-support.patch-old/mm/bootmem.c 3120-e820-table-support.patch-new/mm/bootmem.c
--- 3120-e820-table-support.patch-old/mm/bootmem.c	2005-10-03 09:51:29.000000000 +1000
+++ 3120-e820-table-support.patch-new/mm/bootmem.c	2005-10-04 21:41:12.000000000 +1000
@@ -291,12 +291,14 @@ static unsigned long __init free_all_boo
 			page = pfn_to_page(pfn);
 			count += BITS_PER_LONG;
 			__ClearPageReserved(page);
+			ClearPageNosave(page);
 			order = ffs(BITS_PER_LONG) - 1;
 			set_page_refs(page, order);
 			for (j = 1; j < BITS_PER_LONG; j++) {
 				if (j + 16 < BITS_PER_LONG)
 					prefetchw(page + j + 16);
 				__ClearPageReserved(page + j);
+				ClearPageNosave(page + j);
 			}
 			__free_pages(page, order);
 			i += BITS_PER_LONG;
@@ -309,6 +311,7 @@ static unsigned long __init free_all_boo
 				if (v & m) {
 					count++;
 					__ClearPageReserved(page);
+					ClearPageNosave(page);
 					set_page_refs(page, 0);
 					__free_page(page);
 				}
@@ -329,6 +332,7 @@ static unsigned long __init free_all_boo
 	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
 		count++;
 		__ClearPageReserved(page);
+		ClearPageNosave(page);
 		set_page_count(page, 1);
 		__free_page(page);
 	}


