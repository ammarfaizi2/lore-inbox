Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbUKXNHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbUKXNHr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbUKXNG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:06:27 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:29588 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262636AbUKXNAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:00:40 -0500
Subject: Suspend 2 merge: 3/51: e820 table support
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101292920.5805.198.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:57:01 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first of the 'real' candidates for merging.

This adds support for setting and clearing the Nosave status of pages
based on the contents of the e820 table, and clearing Nosave for __init
pages when they're freed.

diff -ruN 208-e820-table-support-old/arch/i386/mm/init.c 208-e820-table-support-new/arch/i386/mm/init.c
--- 208-e820-table-support-old/arch/i386/mm/init.c	2004-11-03 21:54:38.000000000 +1100
+++ 208-e820-table-support-new/arch/i386/mm/init.c	2004-11-04 16:27:39.000000000 +1100
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/efi.h>
+#include <linux/suspend.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -266,12 +267,15 @@
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
@@ -349,7 +353,7 @@
 #endif
 }
 
-#if defined(CONFIG_PM_DISK) || defined(CONFIG_SOFTWARE_SUSPEND)
+#ifdef CONFIG_PM
 /*
  * Swap suspend & friends need this for resume because things like the intel-agp
  * driver might have split up a kernel 4MB mapping.
@@ -569,6 +573,7 @@
 	int codesize, reservedpages, datasize, initsize;
 	int tmp;
 	int bad_ppro;
+	void * addr;
 
 #ifndef CONFIG_DISCONTIGMEM
 	if (!mem_map)
@@ -599,12 +604,25 @@
 	totalram_pages += __free_all_bootmem();
 
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
 
@@ -703,6 +721,7 @@
 	addr = (unsigned long)(&__init_begin);
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
+		ClearPageNosave(virt_to_page(addr));
 		set_page_count(virt_to_page(addr), 1);
 		free_page(addr);
 		totalram_pages++;
@@ -717,6 +736,7 @@
 		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
+		ClearPageNosave(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
 		free_page(start);
 		totalram_pages++;
diff -ruN 208-e820-table-support-old/mm/bootmem.c 208-e820-table-support-new/mm/bootmem.c
--- 208-e820-table-support-old/mm/bootmem.c	2004-11-03 21:53:00.000000000 +1100
+++ 208-e820-table-support-new/mm/bootmem.c	2004-11-04 16:27:39.000000000 +1100
@@ -279,11 +279,13 @@
 
 			count += BITS_PER_LONG;
 			__ClearPageReserved(page);
+			ClearPageNosave(page);
 			set_page_count(page, 1);
 			for (j = 1; j < BITS_PER_LONG; j++) {
 				if (j + 16 < BITS_PER_LONG)
 					prefetchw(page + j + 16);
 				__ClearPageReserved(page + j);
+				ClearPageNosave(page + j);
 			}
 			__free_pages(page, ffs(BITS_PER_LONG)-1);
 			i += BITS_PER_LONG;
@@ -294,6 +296,7 @@
 				if (v & m) {
 					count++;
 					__ClearPageReserved(page);
+					ClearPageNosave(page);
 					set_page_count(page, 1);
 					__free_page(page);
 				}
@@ -314,6 +317,7 @@
 	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
 		count++;
 		__ClearPageReserved(page);
+		ClearPageNosave(page);
 		set_page_count(page, 1);
 		__free_page(page);
 	}


