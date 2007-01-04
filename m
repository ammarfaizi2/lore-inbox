Return-Path: <linux-kernel-owner+w=401wt.eu-S965014AbXADQY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbXADQY2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbXADQY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:24:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37554 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965014AbXADQY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:24:26 -0500
Message-ID: <459D2A37.2010400@sgi.com>
Date: Thu, 04 Jan 2007 11:24:23 -0500
From: George Beshers <gbeshers@sgi.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] show_mem() for IA64 sparsemem NUMA
Content-Type: multipart/mixed;
 boundary="------------050307000506060703070600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050307000506060703070600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050307000506060703070600
Content-Type: text/x-patch;
 name="show_mem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="show_mem.patch"


On the ia64 architecture only this patch upgrades show_mem()
for sparse memory to be the same as it was for discontig memory.
It has been shown to work on NUMA and flatmem architectures.

Signed-off-by: George Beshers <gbeshers@sgi.com>

diff -Naur Build-rc2.2/arch/ia64/mm/contig.c Build-rc2.0/arch/ia64/mm/contig.c
--- Build-rc2.2/arch/ia64/mm/contig.c	2006-12-28 10:11:04.000000000 -0500
+++ Build-rc2.0/arch/ia64/mm/contig.c	2007-01-02 09:15:51.000000000 -0500
@@ -30,47 +30,69 @@
 #endif
 
 /**
- * show_mem - display a memory statistics summary
+ * show_mem - give short summary of memory stats
  *
- * Just walks the pages in the system and describes where they're allocated.
+ * Shows a simple page count of reserved and used pages in the system.
+ * For discontig machines, it does this on a per-pgdat basis.
  */
-void
-show_mem (void)
+void show_mem(void)
 {
-	int i, total = 0, reserved = 0;
-	int shared = 0, cached = 0;
+	int i, total_reserved = 0;
+	int total_shared = 0, total_cached = 0;
+	unsigned long total_present = 0;
+	pg_data_t *pgdat;
 
 	printk(KERN_INFO "Mem-info:\n");
 	show_free_areas();
-
 	printk(KERN_INFO "Free swap:       %6ldkB\n",
 	       nr_swap_pages<<(PAGE_SHIFT-10));
-	i = max_mapnr;
-	for (i = 0; i < max_mapnr; i++) {
-		if (!pfn_valid(i)) {
+	printk(KERN_INFO "Node memory in pages:\n");
+	for_each_online_pgdat(pgdat) {
+		unsigned long present;
+		unsigned long flags;
+		int shared = 0, cached = 0, reserved = 0;
+
+		pgdat_resize_lock(pgdat, &flags);
+		present = pgdat->node_present_pages;
+		for(i = 0; i < pgdat->node_spanned_pages; i++) {
+			struct page *page;
+			if (pfn_valid(pgdat->node_start_pfn + i))
+				page = pfn_to_page(pgdat->node_start_pfn + i);
+			else {
 #ifdef CONFIG_VIRTUAL_MEM_MAP
-			if (max_gap < LARGE_GAP)
-				continue;
-			i = vmemmap_find_next_valid_pfn(0, i) - 1;
+				if (max_gap < LARGE_GAP)
+					continue;
 #endif
-			continue;
+				i = vmemmap_find_next_valid_pfn(pgdat->node_id,
+					 i) - 1;
+				continue;
+			}
+			if (PageReserved(page))
+				reserved++;
+			else if (PageSwapCache(page))
+				cached++;
+			else if (page_count(page))
+				shared += page_count(page)-1;
 		}
-		total++;
-		if (PageReserved(mem_map+i))
-			reserved++;
-		else if (PageSwapCache(mem_map+i))
-			cached++;
-		else if (page_count(mem_map + i))
-			shared += page_count(mem_map + i) - 1;
+		pgdat_resize_unlock(pgdat, &flags);
+		total_present += present;
+		total_reserved += reserved;
+		total_cached += cached;
+		total_shared += shared;
+		printk(KERN_INFO "Node %4d:  RAM: %11ld, rsvd: %8d, "
+		       "shrd: %10d, swpd: %10d\n", pgdat->node_id,
+		       present, reserved, shared, cached);
 	}
-	printk(KERN_INFO "%d pages of RAM\n", total);
-	printk(KERN_INFO "%d reserved pages\n", reserved);
-	printk(KERN_INFO "%d pages shared\n", shared);
-	printk(KERN_INFO "%d pages swap cached\n", cached);
-	printk(KERN_INFO "%ld pages in page table cache\n",
+	printk(KERN_INFO "%ld pages of RAM\n", total_present);
+	printk(KERN_INFO "%d reserved pages\n", total_reserved);
+	printk(KERN_INFO "%d pages shared\n", total_shared);
+	printk(KERN_INFO "%d pages swap cached\n", total_cached);
+	printk(KERN_INFO "Total of %ld pages in page table cache\n",
 	       pgtable_quicklist_total_size());
+	printk(KERN_INFO "%d free buffer pages\n", nr_free_buffer_pages());
 }
 
+
 /* physical address where the bootmem map is located */
 unsigned long bootmap_start;
 

--------------050307000506060703070600--
