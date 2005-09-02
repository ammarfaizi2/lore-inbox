Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbVIBU64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbVIBU64 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVIBU5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:57:05 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:21662 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751336AbVIBU45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:56:57 -0400
Subject: [PATCH 11/11] memory hotplug: ppc64 specific hot-add functions
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 02 Sep 2005 13:56:52 -0700
References: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
In-Reply-To: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
Message-Id: <20050902205652.59260842@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a set of ppc64 specific patches that at least allow
compilation/booting with the following configurations:

FLATMEM
SPARSEMEN
SPARSEMEM + MEMORY_HOTPLUG

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

---

 memhotplug-dave/arch/ppc64/mm/init.c         |   77 +++++++++++++++++++++++++++
 memhotplug-dave/include/asm-ppc64/abs_addr.h |    2 
 2 files changed, 79 insertions(+)

diff -puN arch/ppc64/mm/init.c~D2-ppc64-hotplug-functions arch/ppc64/mm/init.c
--- memhotplug/arch/ppc64/mm/init.c~D2-ppc64-hotplug-functions	2005-08-18 14:59:50.000000000 -0700
+++ memhotplug-dave/arch/ppc64/mm/init.c	2005-08-18 14:59:50.000000000 -0700
@@ -870,3 +870,80 @@ pgprot_t phys_mem_access_prot(struct fil
 	return vma_prot;
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+
+void online_page(struct page *page)
+{
+	ClearPageReserved(page);
+	free_cold_page(page);
+	totalram_pages++;
+	num_physpages++;
+}
+
+/*
+ * This works only for the non-NUMA case.  Later, we'll need a lookup
+ * to convert from real physical addresses to nid, that doesn't use
+ * pfn_to_nid().
+ */
+int __devinit add_memory(u64 start, u64 size)
+{
+	struct pglist_data *pgdata = NODE_DATA(0);
+	struct zone *zone;
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+
+	/* this should work for most non-highmem platforms */
+	zone = pgdata->node_zones;
+
+	return __add_pages(zone, start_pfn, nr_pages);
+
+	return 0;
+}
+
+/*
+ * First pass at this code will check to determine if the remove
+ * request is within the RMO.  Do not allow removal within the RMO.
+ */
+int __devinit remove_memory(u64 start, u64 size)
+{
+	struct zone *zone;
+	unsigned long start_pfn, end_pfn, nr_pages;
+
+	start_pfn = start >> PAGE_SHIFT;
+	nr_pages = size >> PAGE_SHIFT;
+	end_pfn = start_pfn + nr_pages;
+
+	printk("%s(): Attempting to remove memoy in range "
+			"%lx to %lx\n", __func__, start, start+size);
+	/*
+	 * check for range within RMO
+	 */
+	zone = page_zone(pfn_to_page(start_pfn));
+
+	printk("%s(): memory will be removed from "
+			"the %s zone\n", __func__, zone->name);
+
+	/*
+	 * not handling removing memory ranges that
+	 * overlap multiple zones yet
+	 */
+	if (end_pfn > (zone->zone_start_pfn + zone->spanned_pages))
+		goto overlap;
+
+	/* make sure it is NOT in RMO */
+	if ((start < lmb.rmo_size) || ((start+size) < lmb.rmo_size)) {
+		printk("%s(): range to be removed must NOT be in RMO!\n",
+			__func__);
+		goto in_rmo;
+	}
+
+	return __remove_pages(zone, start_pfn, nr_pages);
+
+overlap:
+	printk("%s(): memory range to be removed overlaps "
+		"multiple zones!!!\n", __func__);
+in_rmo:
+	return -1;
+}
+#endif /* CONFIG_MEMORY_HOTPLUG */
