Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVAZA1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVAZA1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVAZA0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:26:31 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:19371 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262261AbVAZAXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:23:52 -0500
Subject: [RFC][PATCH 4/5] memset the i386 numa pgdats in arch code
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 25 Jan 2005 16:23:44 -0800
Message-Id: <E1CtayH-00071O-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The next patch in this series will remove the  arch-independent
clearing of the pgdat's, which only i386 depends on.  This removes
the i386 dependency on that behavior.

The new i386 function, remapped_pgdat_init() takes care of
initializing the pgdats which are finally mapped after
paging_init() is done.  The zone_sizes_init() call has to occur
after the pgdat clearing

zone_sizes_init() is currently called from the end of paging_init(),
because that's the first place where the pgdats could have been
zeroed.  However, zone_sizes_init() really doesn't have anything
to do with paging, and probably shouldn't be in paging_init().

Moving this call into setup_memory() allows the declaration of
zone_sizes_init() to change files as well, which means a net
removal of one #ifdef.  It also provides a handy place to put
the new function, far away from the paging code that it really
has nothing to do with.


---

 memhotplug-dave/arch/i386/kernel/setup.c |   42 +++++++++++++++++++++++++++++++
 memhotplug-dave/arch/i386/mm/discontig.c |    4 --
 memhotplug-dave/arch/i386/mm/init.c      |   26 -------------------
 3 files changed, 43 insertions(+), 29 deletions(-)

diff -puN arch/i386/kernel/setup.c~A2.1-re-memset-i386-pgdats arch/i386/kernel/setup.c
--- memhotplug/arch/i386/kernel/setup.c~A2.1-re-memset-i386-pgdats	2005-01-25 13:04:30.000000000 -0800
+++ memhotplug-dave/arch/i386/kernel/setup.c	2005-01-25 13:41:12.000000000 -0800
@@ -1100,8 +1100,30 @@ static unsigned long __init setup_memory
 
 	setup_bootmem_allocator();
 }
+
+void __init zone_sizes_init(void)
+{
+	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned int max_dma, high, low;
+
+	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+	low = max_low_pfn;
+	high = highend_pfn;
+
+	if (low < max_dma)
+		zones_size[ZONE_DMA] = low;
+	else {
+		zones_size[ZONE_DMA] = max_dma;
+		zones_size[ZONE_NORMAL] = low - max_dma;
+#ifdef CONFIG_HIGHMEM
+		zones_size[ZONE_HIGHMEM] = high - low;
+#endif
+	}
+	free_area_init(zones_size);
+}
 #else
 extern unsigned long setup_memory(void);
+extern void zone_sizes_init(void);
 #endif /* !CONFIG_DISCONTIGMEM */
 
 void __init setup_bootmem_allocator(void)
@@ -1194,6 +1216,24 @@ void __init setup_bootmem_allocator(void
 }
 
 /*
+ * The node 0 pgdat is initialized before all of these because
+ * it's needed for bootmem.  node>0 pgdats have their virtual
+ * space allocated before the pagetables are in place to access
+ * them, so they can't be cleared then.
+ *
+ * This should all compile down to nothing when NUMA is off.
+ */
+void __init remapped_pgdat_init(void)
+{
+	int nid;
+
+	for_each_online_node(nid) {
+		if (nid != 0)
+			memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
+	}
+}
+
+/*
  * Request address space for all standard RAM and ROM resources
  * and also for regions reported as reserved by the e820.
  */
@@ -1465,6 +1505,8 @@ void __init setup_arch(char **cmdline_p)
 	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
 #endif
 	paging_init();
+	remapped_pgdat_init();
+	zone_sizes_init();
 
 	/*
 	 * NOTE: at this point the bootmem allocator is fully available.
diff -puN arch/i386/mm/discontig.c~A2.1-re-memset-i386-pgdats arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~A2.1-re-memset-i386-pgdats	2005-01-25 13:04:30.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/discontig.c	2005-01-25 13:40:15.000000000 -0800
@@ -135,7 +135,6 @@ static void __init allocate_pgdat(int ni
 	else {
 		NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
 		min_low_pfn += PFN_UP(sizeof(pg_data_t));
-		memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
 	}
 }
 
@@ -256,6 +255,7 @@ unsigned long __init setup_memory(void)
 	for_each_online_node(nid)
 		find_max_pfn_node(nid);
 
+	memset(NODE_DATA(0), 0, sizeof(struct pglist_data));
 	NODE_DATA(0)->bdata = &node0_bdata;
 
 #ifdef CONFIG_KEXEC
@@ -286,8 +286,6 @@ void __init zone_sizes_init(void)
 	for (nid = MAX_NUMNODES - 1; nid >= 0; nid--) {
 		if (!node_online(nid))
 			continue;
-		if (nid)
-			memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
 		NODE_DATA(nid)->pgdat_next = pgdat_list;
 		pgdat_list = NODE_DATA(nid);
 	}
diff -puN include/asm-i386/mmzone.h~A2.1-re-memset-i386-pgdats include/asm-i386/mmzone.h
diff -puN mm/page_alloc.c~A2.1-re-memset-i386-pgdats mm/page_alloc.c
diff -puN arch/i386/mm/init.c~A2.1-re-memset-i386-pgdats arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~A2.1-re-memset-i386-pgdats	2005-01-25 13:04:30.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/init.c	2005-01-25 13:41:01.000000000 -0800
@@ -413,31 +413,6 @@ void zap_low_mappings (void)
 	flush_tlb_all();
 }
 
-#ifndef CONFIG_DISCONTIGMEM
-static void __init zone_sizes_init(void)
-{
-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
-	unsigned int max_dma, high, low;
-	
-	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-	low = max_low_pfn;
-	high = highend_pfn;
-	
-	if (low < max_dma)
-		zones_size[ZONE_DMA] = low;
-	else {
-		zones_size[ZONE_DMA] = max_dma;
-		zones_size[ZONE_NORMAL] = low - max_dma;
-#ifdef CONFIG_HIGHMEM
-		zones_size[ZONE_HIGHMEM] = high - low;
-#endif
-	}
-	free_area_init(zones_size);	
-}
-#else
-extern void zone_sizes_init(void);
-#endif /* !CONFIG_DISCONTIGMEM */
-
 static int disable_nx __initdata = 0;
 u64 __supported_pte_mask = ~_PAGE_NX;
 
@@ -538,7 +513,6 @@ void __init paging_init(void)
 	__flush_tlb_all();
 
 	kmap_init();
-	zone_sizes_init();
 }
 
 /*
_
