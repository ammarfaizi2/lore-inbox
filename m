Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVGFCWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVGFCWD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVGFCUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:20:12 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:60056 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262041AbVGFCTO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:14 -0400
Subject: [PATCH] [10/48] Suspend2 2.1.9.8 for 2.6.12: 360-reset-kswapd-max-order-after-resume.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:40 +1000
Message-Id: <11206164403365@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 401-e820-table-support.patch-old/arch/i386/mm/init.c 401-e820-table-support.patch-new/arch/i386/mm/init.c
--- 401-e820-table-support.patch-old/arch/i386/mm/init.c	2005-06-20 11:46:43.000000000 +1000
+++ 401-e820-table-support.patch-new/arch/i386/mm/init.c	2005-07-04 23:14:18.000000000 +1000
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/efi.h>
+#include <linux/suspend.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -269,12 +270,15 @@ void __init one_highpage_init(struct pag
 {
 	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
 		ClearPageReserved(page);
+		ClearPageNosave(page);
 		set_bit(PG_highmem, &page->flags);
 		set_page_count(page, 1);
 		__free_page(page);
 		totalhigh_pages++;
-	} else
+	} else {
 		SetPageReserved(page);
+		SetPageNosave(page);
+	}
 }
 
 #ifndef CONFIG_DISCONTIGMEM
@@ -352,7 +356,7 @@ static void __init pagetable_init (void)
 #endif
 }
 
-#if defined(CONFIG_PM_DISK) || defined(CONFIG_SOFTWARE_SUSPEND)
+#ifdef CONFIG_PM
 /*
  * Swap suspend & friends need this for resume because things like the intel-agp
  * driver might have split up a kernel 4MB mapping.
@@ -539,6 +543,7 @@ void __init mem_init(void)
 	int codesize, reservedpages, datasize, initsize;
 	int tmp;
 	int bad_ppro;
+	void * addr;
 
 #ifndef CONFIG_DISCONTIGMEM
 	if (!mem_map)
@@ -569,12 +574,25 @@ void __init mem_init(void)
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
 
@@ -673,6 +691,7 @@ void free_initmem(void)
 	addr = (unsigned long)(&__init_begin);
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
+		ClearPageNosave(virt_to_page(addr));
 		set_page_count(virt_to_page(addr), 1);
 		memset((void *)addr, 0xcc, PAGE_SIZE);
 		free_page(addr);
@@ -688,6 +707,7 @@ void free_initrd_mem(unsigned long start
 		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
+		ClearPageNosave(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
 		free_page(start);
 		totalram_pages++;
diff -ruNp 401-e820-table-support.patch-old/mm/bootmem.c 401-e820-table-support.patch-new/mm/bootmem.c
--- 401-e820-table-support.patch-old/mm/bootmem.c	2005-02-03 22:33:50.000000000 +1100
+++ 401-e820-table-support.patch-new/mm/bootmem.c	2005-07-04 23:14:18.000000000 +1000
@@ -280,12 +280,14 @@ static unsigned long __init free_all_boo
 
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
@@ -296,6 +298,7 @@ static unsigned long __init free_all_boo
 				if (v & m) {
 					count++;
 					__ClearPageReserved(page);
+					ClearPageNosave(page);
 					set_page_refs(page, 0);
 					__free_page(page);
 				}
@@ -316,6 +319,7 @@ static unsigned long __init free_all_boo
 	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
 		count++;
 		__ClearPageReserved(page);
+		ClearPageNosave(page);
 		set_page_count(page, 1);
 		__free_page(page);
 	}

