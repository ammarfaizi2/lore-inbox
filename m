Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267516AbSLFDCm>; Thu, 5 Dec 2002 22:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267517AbSLFDCm>; Thu, 5 Dec 2002 22:02:42 -0500
Received: from holomorphy.com ([66.224.33.161]:38285 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267516AbSLFDCk>;
	Thu, 5 Dec 2002 22:02:40 -0500
Date: Thu, 5 Dec 2002 19:10:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Martin.Bligh@us.ibm.com
Subject: [numaq] highpage init speedup
Message-ID: <20021206031006.GM18600@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Martin.Bligh@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Speed up highpage init by manual unrolling and large page freeing.
Boots & runs, and gets a small speedup of the boot process (which
is frequently exercised).

Martin, please apply.

 discontig.c |   48 ++++++++++++++++++++++++++++++++++++++++--------
 init.c      |    4 ++--
 2 files changed, 42 insertions(+), 10 deletions(-)


diff -urpN wli-2.5.50-10/arch/i386/mm/discontig.c wli-2.5.50-11/arch/i386/mm/discontig.c
--- wli-2.5.50-10/arch/i386/mm/discontig.c	2002-11-27 14:36:02.000000000 -0800
+++ wli-2.5.50-11/arch/i386/mm/discontig.c	2002-12-05 17:23:23.000000000 -0800
@@ -323,28 +323,60 @@ void __init zone_sizes_init(void)
 	return;
 }
 
+#ifndef CONFIG_HIGHMEM
+void __init set_highmem_pages_init(int bad_ppro) { }
+#else
+int page_kills_ppro(unsigned long);
+int page_is_ram(unsigned long);
 void __init set_highmem_pages_init(int bad_ppro) 
 {
-#ifdef CONFIG_HIGHMEM
 	int nid;
 
 	for (nid = 0; nid < numnodes; nid++) {
-		unsigned long node_pfn, node_high_size, zone_start_pfn;
-		struct page * zone_mem_map;
+		unsigned long start_pfn, end_pfn, zone_max_pfn, zone_start_pfn;
+		struct page *page, *zone_mem_map;
 		
-		node_high_size = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].spanned_pages;
 		zone_mem_map = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].zone_mem_map;
 		zone_start_pfn = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].zone_start_pfn;
+		zone_max_pfn = zone_start_pfn + NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].spanned_pages;
 
 		printk("Initializing highpages for node %d\n", nid);
-		for (node_pfn = 0; node_pfn < node_high_size; node_pfn++) {
-			one_highpage_init((struct page *)(zone_mem_map + node_pfn),
-					  zone_start_pfn + node_pfn, bad_ppro);
+		start_pfn = end_pfn = zone_start_pfn;
+		while (start_pfn < zone_max_pfn && end_pfn < zone_max_pfn) {
+			page = &zone_mem_map[end_pfn - zone_start_pfn];
+			while (end_pfn < zone_max_pfn
+					&& page_is_ram(end_pfn)
+					&& !(bad_ppro && page_kills_ppro(end_pfn))) {
+				ClearPageReserved(page);
+				set_bit(PG_highmem, &page->flags);
+				set_page_count(page, 1);
+				++page;
+				++end_pfn;
+			}
+			totalhigh_pages += end_pfn - start_pfn;
+			while (start_pfn < end_pfn) {
+				/* for we dare not enter when fls(n) == 0 */
+				int order = min(MAX_ORDER, fls(end_pfn - start_pfn)) - 1;
+				__free_pages(&zone_mem_map[start_pfn - zone_start_pfn], order);
+				start_pfn += 1 << order;
+			}
+			if (start_pfn != end_pfn)
+				printk("wli screwed up, it will crash!\n");
+
+			if (end_pfn < zone_max_pfn)
+				SetPageReserved(&zone_mem_map[end_pfn - zone_start_pfn]);
+
+			/*
+			 * end_pfn stopped at a reserved page; now they both
+			 * refer to a reserved page. Slide them forward.
+			 */
+			++start_pfn;
+			++end_pfn;
 		}
 	}
 	totalram_pages += totalhigh_pages;
-#endif
 }
+#endif
 
 void __init set_max_mapnr_init(void)
 {
diff -urpN wli-2.5.50-10/arch/i386/mm/init.c wli-2.5.50-11/arch/i386/mm/init.c
--- wli-2.5.50-10/arch/i386/mm/init.c	2002-11-27 14:36:16.000000000 -0800
+++ wli-2.5.50-11/arch/i386/mm/init.c	2002-12-05 16:14:09.000000000 -0800
@@ -151,14 +151,14 @@ static void __init kernel_physical_mappi
 	}	
 }
 
-static inline int page_kills_ppro(unsigned long pagenr)
+int __init page_kills_ppro(unsigned long pagenr)
 {
 	if (pagenr >= 0x70000 && pagenr <= 0x7003F)
 		return 1;
 	return 0;
 }
 
-static inline int page_is_ram(unsigned long pagenr)
+int __init page_is_ram(unsigned long pagenr)
 {
 	int i;
 
