Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267926AbUIPLDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267926AbUIPLDe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUIPLDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:03:33 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:4829 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267939AbUIPLBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:01:45 -0400
Subject: Suspend2 Merge: e820 table support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095332590.3324.166.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 21:03:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch adds support for the e820 table for swsusp and Suspend2. It
does so by setting the NoSave flag for unsavable pages at boot time.

Regards,

Nigel

diff -ruN linux-2.6.9-rc1/arch/i386/mm/init.c software-suspend-linux-2.6.9-rc1-rev3/arch/i386/mm/init.c
--- linux-2.6.9-rc1/arch/i386/mm/init.c	2004-09-07 21:58:22.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/arch/i386/mm/init.c	2004-09-09 19:36:24.000000000 +1000
@@ -27,6 +27,9 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/efi.h>
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+#include <linux/suspend-common.h>
+#endif
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -264,12 +267,19 @@
 {
 	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
 		ClearPageReserved(page);
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+		ClearPageNosave(page);
+#endif
 		set_bit(PG_highmem, &page->flags);
 		set_page_count(page, 1);
 		__free_page(page);
 		totalhigh_pages++;
-	} else
+	} else {
 		SetPageReserved(page);
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+		SetPageNosave(page);
+#endif
+	}
 }
 
 #ifndef CONFIG_DISCONTIGMEM
@@ -347,7 +357,7 @@
 #endif
 }
 
-#if defined(CONFIG_PM_DISK) || defined(CONFIG_SOFTWARE_SUSPEND)
+#if defined(CONFIG_PM_DISK) || defined(CONFIG_SOFTWARE_SUSPEND) || defined(CONFIG_SOFTWARE_SUSPEND2)
 /*
  * Swap suspend & friends need this for resume because things like the intel-agp
  * driver might have split up a kernel 4MB mapping.
@@ -567,6 +577,7 @@
 	int codesize, reservedpages, datasize, initsize;
 	int tmp;
 	int bad_ppro;
+	void * addr;
 
 #ifndef CONFIG_DISCONTIGMEM
 	if (!mem_map)
@@ -597,12 +608,29 @@
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
+#ifdef CONFIG_SOFTWARE_SUSPEND2
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
+#else
+		}
+#endif
+	}
 
 	set_highmem_pages_init(bad_ppro);
 
@@ -701,6 +729,9 @@
 	addr = (unsigned long)(&__init_begin);
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+		ClearPageNosave(virt_to_page(addr));
+#endif
 		set_page_count(virt_to_page(addr), 1);
 		free_page(addr);
 		totalram_pages++;
@@ -715,9 +746,15 @@
 		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+		ClearPageNosave(virt_to_page(start));
+#endif
 		set_page_count(virt_to_page(start), 1);
 		free_page(start);
 		totalram_pages++;
 	}
 }
 #endif
+
+/* Exported for Software Suspend 2 */
+EXPORT_SYMBOL(highstart_pfn);
diff -ruN linux-2.6.9-rc1/mm/bootmem.c software-suspend-linux-2.6.9-rc1-rev3/mm/bootmem.c
--- linux-2.6.9-rc1/mm/bootmem.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/mm/bootmem.c	2004-09-09 19:36:24.000000000 +1000
@@ -275,6 +275,7 @@
 				if (v & m) {
 					count++;
 					ClearPageReserved(page);
+					ClearPageNosave(page);
 					set_page_count(page, 1);
 					__free_page(page);
 				}
@@ -295,6 +296,7 @@
 	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
 		count++;
 		ClearPageReserved(page);
+		ClearPageNosave(page);
 		set_page_count(page, 1);
 		__free_page(page);
 	}

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

