Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVHLOrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVHLOrn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVHLOrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:47:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:57493 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751192AbVHLOrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:47:37 -0400
Subject: [RFC][PATCH 12/12] memory hotplug: ppc64 specific hot-add functions
To: linux-kernel@vger.kernel.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 12 Aug 2005 07:47:34 -0700
References: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
In-Reply-To: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
Message-Id: <20050812144734.D3A291B4@kernel.beaverton.ibm.com>
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

 include/asm-ppc64/mmzone.h                   |    0 
 memhotplug-dave/arch/ppc64/mm/init.c         |   77 +++++++++++++++++++++++++++
 memhotplug-dave/include/asm-ppc64/abs_addr.h |    2 
 3 files changed, 79 insertions(+)

diff -puN arch/ppc64/mm/init.c~D2-ppc64-hotplug-functions arch/ppc64/mm/init.c
--- memhotplug/arch/ppc64/mm/init.c~D2-ppc64-hotplug-functions	2005-08-12 07:43:51.000000000 -0700
+++ memhotplug-dave/arch/ppc64/mm/init.c	2005-08-12 07:43:51.000000000 -0700
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
diff -puN include/asm-ppc64/abs_addr.h~D2-ppc64-hotplug-functions include/asm-ppc64/abs_addr.h
--- memhotplug/include/asm-ppc64/abs_addr.h~D2-ppc64-hotplug-functions	2005-08-12 07:43:51.000000000 -0700
+++ memhotplug-dave/include/asm-ppc64/abs_addr.h	2005-08-12 07:43:51.000000000 -0700
@@ -104,5 +104,7 @@ physRpn_to_absRpn(unsigned long rpn)
 /* Convenience macros */
 #define virt_to_abs(va) phys_to_abs(__pa(va))
 #define abs_to_virt(aa) __va(abs_to_phys(aa))
+#define boot_virt_to_abs(va) phys_to_abs(__boot_pa(va))
+#define boot_abs_to_virt(aa) __boot_va(abs_to_phys(aa))
 
 #endif /* _ABS_ADDR_H */
diff -puN include/asm-ppc64/mmzone.h~D2-ppc64-hotplug-functions include/asm-ppc64/mmzone.h
_
