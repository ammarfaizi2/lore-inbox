Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbVIBU46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVIBU46 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVIBU45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:56:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:51360 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751324AbVIBU4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:56:54 -0400
Subject: [PATCH 10/11] memory hotplug: i386 addition functions
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 02 Sep 2005 13:56:51 -0700
References: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
In-Reply-To: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
Message-Id: <20050902205651.6A83A1D5@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds the necessary for non-NUMA hot-add of highmem
to an existing zone on i386.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/mm/discontig.c |    4 +-
 memhotplug-dave/arch/i386/mm/init.c      |   61 ++++++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 7 deletions(-)

diff -puN arch/i386/mm/discontig.c~D1-i386-hotplug-functions arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~D1-i386-hotplug-functions	2005-08-18 14:59:50.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/discontig.c	2005-08-18 14:59:50.000000000 -0700
@@ -98,7 +98,7 @@ unsigned long node_memmap_size_bytes(int
 
 extern unsigned long find_max_low_pfn(void);
 extern void find_max_pfn(void);
-extern void one_highpage_init(struct page *, int, int);
+extern void add_one_highpage_init(struct page *, int, int);
 
 extern struct e820map e820;
 extern unsigned long init_pg_tables_end;
@@ -427,7 +427,7 @@ void __init set_highmem_pages_init(int b
 			if (!pfn_valid(node_pfn))
 				continue;
 			page = pfn_to_page(node_pfn);
-			one_highpage_init(page, node_pfn, bad_ppro);
+			add_one_highpage_init(page, node_pfn, bad_ppro);
 		}
 	}
 	totalram_pages += totalhigh_pages;
diff -puN arch/i386/mm/init.c~D1-i386-hotplug-functions arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~D1-i386-hotplug-functions	2005-08-18 14:59:50.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/init.c	2005-08-18 14:59:50.000000000 -0700
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/efi.h>
+#include <linux/memory_hotplug.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -265,17 +266,45 @@ static void __init permanent_kmaps_init(
 	pkmap_page_table = pte;	
 }
 
-void __init one_highpage_init(struct page *page, int pfn, int bad_ppro)
+void __devinit free_new_highpage(struct page *page)
+{
+	set_page_count(page, 1);
+	__free_page(page);
+	totalhigh_pages++;
+}
+
+void __init add_one_highpage_init(struct page *page, int pfn, int bad_ppro)
 {
 	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
 		ClearPageReserved(page);
-		set_page_count(page, 1);
-		__free_page(page);
-		totalhigh_pages++;
 	} else
 		SetPageReserved(page);
 }
 
+int add_one_highpage_hotplug(struct page *page, int pfn)
+{
+	free_new_highpage(page);
+	totalram_pages++;
+#ifdef CONFIG_FLATMEM
+	max_mapnr = max(pfn, max_mapnr);
+#endif
+	num_physpages++;
+	return 0;
+}
+
+/*
+ * Not currently handling the NUMA case.
+ * Assuming single node and all memory that
+ * has been added dynamically that would be
+ * onlined here is in HIGHMEM
+ */
+void online_page(struct page *page)
+{
+	ClearPageReserved(page);
+	add_one_highpage_hotplug(page, page_to_pfn(page));
+}
+
+
 #ifdef CONFIG_NUMA
 extern void set_highmem_pages_init(int);
 #else
@@ -283,7 +312,7 @@ static void __init set_highmem_pages_ini
 {
 	int pfn;
 	for (pfn = highstart_pfn; pfn < highend_pfn; pfn++)
-		one_highpage_init(pfn_to_page(pfn), pfn, bad_ppro);
+		add_one_highpage_init(pfn_to_page(pfn), pfn, bad_ppro);
 	totalram_pages += totalhigh_pages;
 }
 #endif /* CONFIG_FLATMEM */
@@ -614,6 +643,28 @@ void __init mem_init(void)
 #endif
 }
 
+/*
+ * this is for the non-NUMA, single node SMP system case.
+ * Specifically, in the case of x86, we will always add
+ * memory to the highmem for now.
+ */
+#ifndef CONFIG_NEED_MULTIPLE_NODES
+int add_memory(u64 start, u64 size)
+{
+	struct pglist_data *pgdata = &contig_page_data;
+	struct zone *zone = pgdata->node_zones + MAX_NR_ZONES-1;
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+
+	return __add_pages(zone, start_pfn, nr_pages);
+}
+
+int remove_memory(u64 start, u64 size)
+{
+	return -EINVAL;
+}
+#endif
+
 kmem_cache_t *pgd_cache;
 kmem_cache_t *pmd_cache;
 
_
