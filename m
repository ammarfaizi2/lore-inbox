Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWDTKKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWDTKKf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWDTKKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:10:35 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:50065 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750824AbWDTKKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:10:33 -0400
Date: Thu, 20 Apr 2006 19:10:00 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch: 001/006] pgdat allocation for new node add (specify node id)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060420185123.EE48.Y-GOTO@jp.fujitsu.com>
References: <20060420185123.EE48.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060420190338.EE4A.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes name of old add_memory() to arch_add_memory.
and use node id to get pgdat for the node at NODE_DATA().

Note: Powerpc's old add_memory() is defined as __devinit. However,
      add_memory() is usually called only after bootup. 
      I suppose it may be redundant. But, I'm not well known about powerpc.
      So, I keep it. (But, __meminit is better at least.)

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 arch/i386/mm/init.c            |    2 +-
 arch/ia64/mm/init.c            |    4 ++--
 arch/powerpc/mm/mem.c          |    9 ++++++---
 arch/x86_64/mm/init.c          |    6 +++---
 drivers/acpi/acpi_memhotplug.c |    3 ++-
 drivers/base/memory.c          |    4 +++-
 include/linux/memory_hotplug.h |   13 ++++++++++++-
 mm/memory_hotplug.c            |   10 ++++++++++
 8 files changed, 39 insertions(+), 12 deletions(-)

Index: pgdat11/arch/i386/mm/init.c
===================================================================
--- pgdat11.orig/arch/i386/mm/init.c	2006-04-20 11:00:04.000000000 +0900
+++ pgdat11/arch/i386/mm/init.c	2006-04-20 16:08:21.000000000 +0900
@@ -654,7 +654,7 @@ void __init mem_init(void)
  */
 #ifdef CONFIG_MEMORY_HOTPLUG
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-int add_memory(u64 start, u64 size)
+int arch_add_memory(int nid, u64 start , u64 size)
 {
 	struct pglist_data *pgdata = &contig_page_data;
 	struct zone *zone = pgdata->node_zones + MAX_NR_ZONES-1;
Index: pgdat11/arch/ia64/mm/init.c
===================================================================
--- pgdat11.orig/arch/ia64/mm/init.c	2006-04-20 11:00:04.000000000 +0900
+++ pgdat11/arch/ia64/mm/init.c	2006-04-20 16:04:14.000000000 +0900
@@ -652,7 +652,7 @@ void online_page(struct page *page)
 	num_physpages++;
 }
 
-int add_memory(u64 start, u64 size)
+int arch_add_memory(int nid, u64 start, u64 size)
 {
 	pg_data_t *pgdat;
 	struct zone *zone;
@@ -660,7 +660,7 @@ int add_memory(u64 start, u64 size)
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
 
-	pgdat = NODE_DATA(0);
+	pgdat = NODE_DATA(nid);
 
 	zone = pgdat->node_zones + ZONE_NORMAL;
 	ret = __add_pages(zone, start_pfn, nr_pages);
Index: pgdat11/arch/powerpc/mm/mem.c
===================================================================
--- pgdat11.orig/arch/powerpc/mm/mem.c	2006-04-20 10:59:54.000000000 +0900
+++ pgdat11/arch/powerpc/mm/mem.c	2006-04-20 16:06:58.000000000 +0900
@@ -114,15 +114,18 @@ void online_page(struct page *page)
 	num_physpages++;
 }
 
-int __devinit add_memory(u64 start, u64 size)
+int memory_add_physaddr_to_nid(u64 start)
+{
+	return hot_add_scn_to_nid(start);
+}
+
+int __devinit arch_add_memory(in nid, u64 start, u64 size)
 {
 	struct pglist_data *pgdata;
 	struct zone *zone;
-	int nid;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	nid = hot_add_scn_to_nid(start);
 	pgdata = NODE_DATA(nid);
 
 	start = (unsigned long)__va(start);
Index: pgdat11/arch/x86_64/mm/init.c
===================================================================
--- pgdat11.orig/arch/x86_64/mm/init.c	2006-04-20 11:00:04.000000000 +0900
+++ pgdat11/arch/x86_64/mm/init.c	2006-04-20 16:10:38.000000000 +0900
@@ -552,9 +552,9 @@ int __add_pages(struct zone *z, unsigned
  * Memory is added always to NORMAL zone. This means you will never get
  * additional DMA/DMA32 memory.
  */
-int add_memory(u64 start, u64 size)
+int arch_add_memory(int nid, u64 start, u64 size)
 {
-	struct pglist_data *pgdat = NODE_DATA(0);
+	struct pglist_data *pgdat = NODE_DATA(nid);
 	struct zone *zone = pgdat->node_zones + MAX_NR_ZONES-2;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
@@ -571,7 +571,7 @@ error:
 	printk("%s: Problem encountered in __add_pages!\n", __func__);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(add_memory);
+EXPORT_SYMBOL_GPL(arch_add_memory);
 
 int remove_memory(u64 start, u64 size)
 {
Index: pgdat11/drivers/acpi/acpi_memhotplug.c
===================================================================
--- pgdat11.orig/drivers/acpi/acpi_memhotplug.c	2006-04-20 11:00:04.000000000 +0900
+++ pgdat11/drivers/acpi/acpi_memhotplug.c	2006-04-20 16:35:24.000000000 +0900
@@ -215,6 +215,7 @@ static int acpi_memory_enable_device(str
 {
 	int result, num_enabled = 0;
 	struct acpi_memory_info *info;
+	int node = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_enable_device");
 
@@ -244,7 +245,7 @@ static int acpi_memory_enable_device(str
 			continue;
 		}
 
-		result = add_memory(info->start_addr, info->length);
+		result = add_memory(node, info->start_addr, info->length);
 		if (result)
 			continue;
 		info->enabled = 1;
Index: pgdat11/include/linux/memory_hotplug.h
===================================================================
--- pgdat11.orig/include/linux/memory_hotplug.h	2006-04-20 11:00:07.000000000 +0900
+++ pgdat11/include/linux/memory_hotplug.h	2006-04-20 16:35:23.000000000 +0900
@@ -63,6 +63,16 @@ extern int online_pages(unsigned long, u
 /* reasonably generic interface to expand the physical pages in a zone  */
 extern int __add_pages(struct zone *zone, unsigned long start_pfn,
 	unsigned long nr_pages);
+
+#if defined(CONFIG_NUMA)
+extern int memory_add_physaddr_to_nid(u64 start);
+#else
+static inline int memofy_add_physaddr_to_nid(u64 start)
+{
+	return 0;
+}
+#endif
+
 #else /* ! CONFIG_MEMORY_HOTPLUG */
 /*
  * Stub functions for when hotplug is off
@@ -99,7 +109,8 @@ static inline int __remove_pages(struct 
 	return -ENOSYS;
 }
 
-extern int add_memory(u64 start, u64 size);
+extern int add_memory(int nid, u64 start, u64 size);
+extern int arch_add_memory(int nid, u64 start, u64 size);
 extern int remove_memory(u64 start, u64 size);
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
Index: pgdat11/mm/memory_hotplug.c
===================================================================
--- pgdat11.orig/mm/memory_hotplug.c	2006-04-20 11:00:07.000000000 +0900
+++ pgdat11/mm/memory_hotplug.c	2006-04-20 16:35:53.000000000 +0900
@@ -159,3 +159,13 @@ int online_pages(unsigned long pfn, unsi
 
 	return 0;
 }
+
+int add_memory(int nid, u64 start, u64 size)
+{
+	int ret;
+
+	/* call arch's memory hotadd */
+	ret = arch_add_memory(nid, start, size;
+
+	return ret;
+}
Index: pgdat11/drivers/base/memory.c
===================================================================
--- pgdat11.orig/drivers/base/memory.c	2006-04-20 10:59:54.000000000 +0900
+++ pgdat11/drivers/base/memory.c	2006-04-20 11:00:09.000000000 +0900
@@ -306,11 +306,13 @@ static ssize_t
 memory_probe_store(struct class *class, const char *buf, size_t count)
 {
 	u64 phys_addr;
+	int nid;
 	int ret;
 
 	phys_addr = simple_strtoull(buf, NULL, 0);
 
-	ret = add_memory(phys_addr, PAGES_PER_SECTION << PAGE_SHIFT);
+	nid = memory_add_physaddr_to_nid(phys_addr);
+	ret = add_memory(nid, phys_addr, PAGES_PER_SECTION << PAGE_SHIFT);
 
 	if (ret)
 		count = ret;

-- 
Yasunori Goto 


