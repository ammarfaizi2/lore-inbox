Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWD2OEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWD2OEq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 10:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWD2OEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 10:04:46 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:32191 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750730AbWD2OEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 10:04:45 -0400
Date: Sat, 29 Apr 2006 23:03:17 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix compile error of memory hotplug
Cc: Andi Kleen <ak@suse.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060429225607.33EC.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. Andrew-san.

I'm really sorry to waste your time by my fault.

This is for fix compile errors of memory hotplug.
Fix point was 3.

  - x86_64 is required memory hotplug even if CONFIG_MEMORY_HOTPLUG is off.
    But, its #ifdef looks broken. I changed #ifdef by using
    CONFIG_MEMORY_HOTPLUG.
  - memory_add_physaddr_to_nid()
     It was not defined for x86-64.
     Fix silly typo in include/linux/memory_hotplug.h
     It is just for NUMA. So, I add #ifdef for powerpc.
  - export symbol for add_memory of mm/memory_hotplug.c
    driver/acpi/acpi_memhotplug.c can be module. add_memory() is called by it.

This patch is for 2.6.17-rc2-mm1.

Please apply.


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
 arch/powerpc/mm/mem.c          |    2 +
 arch/x86_64/mm/init.c          |   60 +++++++++++++++++++++++------------------
 include/linux/memory_hotplug.h |    2 -
 mm/memory_hotplug.c            |    1 
 4 files changed, 39 insertions(+), 26 deletions(-)

Index: pgdat12/arch/x86_64/mm/init.c
===================================================================
--- pgdat12.orig/arch/x86_64/mm/init.c	2006-04-29 16:16:35.000000000 -0400
+++ pgdat12/arch/x86_64/mm/init.c	2006-04-29 21:06:31.000000000 -0400
@@ -509,8 +509,6 @@
 /*
  * Memory hotplug specific functions
  */
-#if defined(CONFIG_ACPI_HOTPLUG_MEMORY) || defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)
-
 void online_page(struct page *page)
 {
 	ClearPageReserved(page);
@@ -520,31 +518,17 @@
 	num_physpages++;
 }
 
-#ifndef CONFIG_MEMORY_HOTPLUG
+#ifdef CONFIG_MEMORY_HOTPLUG
 /*
- * Memory Hotadd without sparsemem. The mem_maps have been allocated in advance,
- * just online the pages.
+ * XXX: memory_add_physaddr_to_nid() is to find node id from physical address
+ *	via probe interface of sysfs. If acpi notifies hot-add event, then it
+ *	can tell node id by searching dsdt. But, probe interface doesn't have
+ *	node id. So, return 0 as node id at this time.
  */
-int __add_pages(struct zone *z, unsigned long start_pfn, unsigned long nr_pages)
+#ifdef CONFIG_NUMA
+int memory_add_physaddr_to_nid(u64 start)
 {
-	int err = -EIO;
-	unsigned long pfn;
-	unsigned long total = 0, mem = 0;
-	for (pfn = start_pfn; pfn < start_pfn + nr_pages; pfn++) {
-		if (pfn_valid(pfn)) {
-			online_page(pfn_to_page(pfn));
-			err = 0;
-			mem++;
-		}
-		total++;
-	}
-	if (!err) {
-		z->spanned_pages += total;
-		z->present_pages += mem;
-		z->zone_pgdat->node_spanned_pages += total;
-		z->zone_pgdat->node_present_pages += mem;
-	}
-	return err;
+	return 0;
 }
 #endif
 
@@ -579,7 +563,33 @@
 }
 EXPORT_SYMBOL_GPL(remove_memory);
 
-#endif
+#else /* CONFIG_MEMORY_HOTPLUG */
+/*
+ * Memory Hotadd without sparsemem. The mem_maps have been allocated in advance,
+ * just online the pages.
+ */
+int __add_pages(struct zone *z, unsigned long start_pfn, unsigned long nr_pages)
+{
+	int err = -EIO;
+	unsigned long pfn;
+	unsigned long total = 0, mem = 0;
+	for (pfn = start_pfn; pfn < start_pfn + nr_pages; pfn++) {
+		if (pfn_valid(pfn)) {
+			online_page(pfn_to_page(pfn));
+			err = 0;
+			mem++;
+		}
+		total++;
+	}
+	if (!err) {
+		z->spanned_pages += total;
+		z->present_pages += mem;
+		z->zone_pgdat->node_spanned_pages += total;
+		z->zone_pgdat->node_present_pages += mem;
+	}
+	return err;
+}
+#endif /* CONFIG_MEMORY_HOTPLUG */
 
 static struct kcore_list kcore_mem, kcore_vmalloc, kcore_kernel, kcore_modules,
 			 kcore_vsyscall;
Index: pgdat12/include/linux/memory_hotplug.h
===================================================================
--- pgdat12.orig/include/linux/memory_hotplug.h	2006-04-29 16:16:36.000000000 -0400
+++ pgdat12/include/linux/memory_hotplug.h	2006-04-29 21:02:29.000000000 -0400
@@ -67,7 +67,7 @@
 #ifdef CONFIG_NUMA
 extern int memory_add_physaddr_to_nid(u64 start);
 #else
-static inline int memofy_add_physaddr_to_nid(u64 start)
+static inline int memory_add_physaddr_to_nid(u64 start)
 {
 	return 0;
 }
Index: pgdat12/arch/powerpc/mm/mem.c
===================================================================
--- pgdat12.orig/arch/powerpc/mm/mem.c	2006-04-29 16:16:34.000000000 -0400
+++ pgdat12/arch/powerpc/mm/mem.c	2006-04-29 21:26:44.000000000 -0400
@@ -114,10 +114,12 @@
 	num_physpages++;
 }
 
+#ifdef CONFIG_NUMA
 int memory_add_physaddr_to_nid(u64 start)
 {
 	return hot_add_scn_to_nid(start);
 }
+#endif
 
 int __devinit arch_add_memory(int nid, u64 start, u64 size)
 {
Index: pgdat12/mm/memory_hotplug.c
===================================================================
--- pgdat12.orig/mm/memory_hotplug.c	2006-04-29 16:16:36.000000000 -0400
+++ pgdat12/mm/memory_hotplug.c	2006-04-29 22:48:29.000000000 -0400
@@ -221,3 +221,4 @@
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(add_memory);

-- 
Yasunori Goto 


