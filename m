Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWDDFH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWDDFH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 01:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWDDFH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 01:07:29 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:38087 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964929AbWDDFH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 01:07:28 -0400
Date: Tue, 04 Apr 2006 14:06:46 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch] Change interface of add/remove_memory() from paddr to pfn
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060404135636.ED23.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is to change interfaces of add/remove_memory()
from physicall address to pfn.
Current add_memory() of each architecture changes paddr to pfn,
and __add_pages() are called by pfn after all.
So, it is not for un-alignment memory.
Using pfn is a bit better to avoid misunderstanding to use add_memory().

In addition, this patch reduces a few lines of kernel.
(Unfortunately, x86-64 and powerpc look using paddr for some
 reasons.)

This patch is against 2.6.16-mm2.

Please apply.


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 arch/i386/mm/init.c            |    4 +---
 arch/ia64/mm/init.c            |    6 ++----
 arch/powerpc/mm/mem.c          |   12 +++++-------
 arch/x86_64/mm/init.c          |    6 +++---
 drivers/acpi/acpi_memhotplug.c |    2 +-
 drivers/base/memory.c          |    6 +++---
 include/linux/memory_hotplug.h |    4 ++--
 7 files changed, 17 insertions(+), 23 deletions(-)

Index: pgdat10/arch/ia64/mm/init.c
===================================================================
--- pgdat10.orig/arch/ia64/mm/init.c	2006-03-31 14:43:24.000000000 +0900
+++ pgdat10/arch/ia64/mm/init.c	2006-03-31 15:43:07.000000000 +0900
@@ -646,12 +646,10 @@ void online_page(struct page *page)
 	num_physpages++;
 }
 
-int add_memory(u64 start, u64 size)
+int add_memory(unsigned long start_pfn, unsigned long nr_pages)
 {
 	pg_data_t *pgdat;
 	struct zone *zone;
-	unsigned long start_pfn = start >> PAGE_SHIFT;
-	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
 
 	pgdat = NODE_DATA(0);
@@ -666,7 +664,7 @@ int add_memory(u64 start, u64 size)
 	return ret;
 }
 
-int remove_memory(u64 start, u64 size)
+int remove_memory(unsigned long start_pfn, unsigned long nr_pages)
 {
 	return -EINVAL;
 }
Index: pgdat10/arch/powerpc/mm/mem.c
===================================================================
--- pgdat10.orig/arch/powerpc/mm/mem.c	2006-03-31 14:43:25.000000000 +0900
+++ pgdat10/arch/powerpc/mm/mem.c	2006-03-31 15:43:07.000000000 +0900
@@ -114,13 +114,13 @@ void online_page(struct page *page)
 	num_physpages++;
 }
 
-int __devinit add_memory(u64 start, u64 size)
+int __devinit add_memory(unsigned long start_pfn, unsigned long nr_pages)
 {
 	struct pglist_data *pgdata;
 	struct zone *zone;
+	u64 start = start_pfn << PAGE_SHIFT;
+	u64 size = nr_pages << PAGE_SHIFT;
 	int nid;
-	unsigned long start_pfn = start >> PAGE_SHIFT;
-	unsigned long nr_pages = size >> PAGE_SHIFT;
 
 	nid = hot_add_scn_to_nid(start);
 	pgdata = NODE_DATA(nid);
@@ -140,13 +140,11 @@ int __devinit add_memory(u64 start, u64 
  * First pass at this code will check to determine if the remove
  * request is within the RMO.  Do not allow removal within the RMO.
  */
-int __devinit remove_memory(u64 start, u64 size)
+int __devinit remove_memory(unsigned long start_pfn, unsigned long nr_pages)
 {
 	struct zone *zone;
-	unsigned long start_pfn, end_pfn, nr_pages;
+	unsigned long end_pfn;
 
-	start_pfn = start >> PAGE_SHIFT;
-	nr_pages = size >> PAGE_SHIFT;
 	end_pfn = start_pfn + nr_pages;
 
 	printk("%s(): Attempting to remove memoy in range "
Index: pgdat10/arch/x86_64/mm/init.c
===================================================================
--- pgdat10.orig/arch/x86_64/mm/init.c	2006-03-31 14:43:25.000000000 +0900
+++ pgdat10/arch/x86_64/mm/init.c	2006-03-31 15:43:07.000000000 +0900
@@ -538,12 +538,12 @@ int __add_pages(struct zone *z, unsigned
 }
 #endif
 
-int add_memory(u64 start, u64 size)
+int add_memory(unsigned long start_pfn, unsigned long nr_pages)
 {
 	struct pglist_data *pgdat = NODE_DATA(0);
 	struct zone *zone = pgdat->node_zones + MAX_NR_ZONES-2;
-	unsigned long start_pfn = start >> PAGE_SHIFT;
-	unsigned long nr_pages = size >> PAGE_SHIFT;
+	unsigned long start = start_pfn << PAGE_SHIFT;
+	unsigned long size = nr_pages << PAGE_SHIFT;
 	int ret;
 
 	ret = __add_pages(zone, start_pfn, nr_pages);
Index: pgdat10/drivers/base/memory.c
===================================================================
--- pgdat10.orig/drivers/base/memory.c	2006-03-31 14:43:25.000000000 +0900
+++ pgdat10/drivers/base/memory.c	2006-03-31 15:43:07.000000000 +0900
@@ -186,8 +186,8 @@ memory_block_action(struct memory_block 
 			mem->state = MEM_GOING_OFFLINE;
 			memory_notify(MEM_GOING_OFFLINE, NULL);
 			start_paddr = page_to_pfn(first_page) << PAGE_SHIFT;
-			ret = remove_memory(start_paddr,
-					    PAGES_PER_SECTION << PAGE_SHIFT);
+			ret = remove_memory(start_paddr >> PAGE_SHIFT,
+					    PAGES_PER_SECTION);
 			if (ret) {
 				mem->state = old_state;
 				break;
@@ -310,7 +310,7 @@ memory_probe_store(struct class *class, 
 
 	phys_addr = simple_strtoull(buf, NULL, 0);
 
-	ret = add_memory(phys_addr, PAGES_PER_SECTION << PAGE_SHIFT);
+	ret = add_memory(phys_addr >> PAGE_SHIFT, PAGES_PER_SECTION);
 
 	if (ret)
 		count = ret;
Index: pgdat10/arch/i386/mm/init.c
===================================================================
--- pgdat10.orig/arch/i386/mm/init.c	2006-03-31 14:43:24.000000000 +0900
+++ pgdat10/arch/i386/mm/init.c	2006-03-31 15:43:07.000000000 +0900
@@ -652,12 +652,10 @@ void __init mem_init(void)
  * memory to the highmem for now.
  */
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-int add_memory(u64 start, u64 size)
+int add_memory(unsigned long start_pfn, unsigned long nr_pages)
 {
 	struct pglist_data *pgdata = &contig_page_data;
 	struct zone *zone = pgdata->node_zones + MAX_NR_ZONES-1;
-	unsigned long start_pfn = start >> PAGE_SHIFT;
-	unsigned long nr_pages = size >> PAGE_SHIFT;
 
 	return __add_pages(zone, start_pfn, nr_pages);
 }
Index: pgdat10/include/linux/memory_hotplug.h
===================================================================
--- pgdat10.orig/include/linux/memory_hotplug.h	2006-03-31 14:43:32.000000000 +0900
+++ pgdat10/include/linux/memory_hotplug.h	2006-03-31 15:44:53.000000000 +0900
@@ -106,8 +106,8 @@ static inline int __remove_pages(struct 
 
 #if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_ACPI_HOTPLUG_MEMORY) \
 	|| defined(CONFIG_ACPI_MEMORY_HOTPLUG_MODULE)
-extern int add_memory(u64 start, u64 size);
-extern int remove_memory(u64 start, u64 size);
+extern int add_memory(unsigned long start_pfn, unsigned long nr_pages);
+extern int remove_memory(unsigned long start_pfn, unsigned long nr_pages);
 #endif
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
Index: pgdat10/drivers/acpi/acpi_memhotplug.c
===================================================================
--- pgdat10.orig/drivers/acpi/acpi_memhotplug.c	2006-03-31 14:43:25.000000000 +0900
+++ pgdat10/drivers/acpi/acpi_memhotplug.c	2006-03-31 15:43:07.000000000 +0900
@@ -245,7 +245,7 @@ static int acpi_memory_enable_device(str
 			continue;
 		}
 
-		result = add_memory(info->start_addr, info->length);
+		result = add_memory(start_pfn, info->length >> PAGE_SHIFT);
 		if (result)
 			continue;
 		info->enabled = 1;

-- 
Yasunori Goto 


