Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUGTJV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUGTJV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 05:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUGTJV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 05:21:59 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:5258 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265777AbUGTJVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 05:21:44 -0400
Date: Tue, 20 Jul 2004 18:21:34 +0900
From: Fumihiro Tersawa <terasawa@pst.fujitsu.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>
Subject: [PATCH] memory hotplug for ia64 (linux-2.6.7) [1/2]
Message-Id: <20040720181808.12B8.TERASAWA@pst.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a main patch of memory hotplug for ia64.


diff -dupr linux-2.6.7-orig/arch/ia64/Kconfig linux-2.6.7-ia64-remap/arch/ia64/Kconfig
--- linux-2.6.7-orig/arch/ia64/Kconfig	2004-07-13 10:39:42.000000000 +0900
+++ linux-2.6.7-ia64-remap/arch/ia64/Kconfig	2004-07-20 13:27:41.017429839 +0900
@@ -182,10 +182,14 @@ config VIRTUAL_MEM_MAP
 	  require the DISCONTIGMEM option for your machine. If you are
 	  unsure, say Y.
 
+config MEMHOTPLUG
+	bool "Memory hotplug test"
+	default n
+
 config DISCONTIGMEM
 	bool "Discontiguous memory support"
 	depends on (IA64_DIG || IA64_SGI_SN2 || IA64_GENERIC) && NUMA && VIRTUAL_MEM_MAP
-	default y if (IA64_SGI_SN2 || IA64_GENERIC) && NUMA
+	default y if (IA64_SGI_SN2 || IA64_GENERIC) && (NUMA || MEMHOTPLUG)
 	help
 	  Say Y to support efficient handling of discontiguous physical memory,
 	  for architectures which are either NUMA (Non-Uniform Memory Access)
diff -dupr linux-2.6.7-orig/arch/ia64/mm/discontig.c linux-2.6.7-ia64-remap/arch/ia64/mm/discontig.c
--- linux-2.6.7-orig/arch/ia64/mm/discontig.c	2004-07-13 10:39:42.000000000 +0900
+++ linux-2.6.7-ia64-remap/arch/ia64/mm/discontig.c	2004-07-20 13:30:12.864107667 +0900
@@ -664,7 +664,84 @@ void paging_init(void)
 		free_area_init_node(node, NODE_DATA(node),
 				    vmem_map + pfn_offset, zones_size,
 				    pfn_offset, zholes_size);
+#ifdef CONFIG_MEMHOTPLUG
+		NODE_DATA(node)->enabled = 1;
+		if (node > 0) 
+			NODE_DATA(node)->removable = 1;
+#endif
 	}
 
 	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
 }
+
+/* Not support HotAdd memory */
+void
+plug_node(int nid)
+{}
+
+void
+enable_node(int node)
+{
+
+	NODE_DATA(node)->enabled = 1;
+	build_all_zonelists();
+}
+
+void
+makepermanent_node(int node)
+{
+
+	NODE_DATA(node)->removable = 0;
+	build_all_zonelists();
+}
+
+void
+disable_node(int node)
+{
+	int i;
+	struct zone *z;
+
+	NODE_DATA(node)->enabled = 0;
+	build_all_zonelists();
+
+	for(i = 0; i < MAX_NR_ZONES; i++) {
+		z = zone_table[NODEZONE(node, i)];
+		totalram_pages -= z->present_pages;
+	}
+}
+
+int
+unplug_node(int nid)
+{
+        int i;
+        struct zone *z;
+        pg_data_t *pgdat;
+        unsigned long node_free_pages = 0;
+
+        if (NODE_DATA(nid)->enabled)
+                return -1;
+
+	for(i = 0; i < MAX_NR_ZONES; i++) {
+		z = zone_table[NODEZONE(nid, i)];
+		node_free_pages += z->free_pages;
+	}
+	if (node_free_pages != NODE_DATA(nid)->node_totalram_pages) {
+		printk("%s:free_pages=%d totalram_pages=%d\n", __FUNCTION__,
+			node_free_pages, NODE_DATA(nid)->node_totalram_pages);
+		return -1;
+	}
+
+        /* lock? */
+        for(pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
+                if (pgdat->pgdat_next == NODE_DATA(nid)) {
+                        pgdat->pgdat_next = pgdat->pgdat_next->pgdat_next;
+                        break;
+                }
+        BUG_ON(pgdat == NULL);
+
+        for(i = 0; i < MAX_NR_ZONES; i++)
+                zone_table[NODEZONE(nid, i)] = NULL;
+        NODE_DATA(nid) = NULL;
+
+        return 0;
+} 
diff -dupr linux-2.6.7-orig/arch/ia64/mm/init.c linux-2.6.7-ia64-remap/arch/ia64/mm/init.c
--- linux-2.6.7-orig/arch/ia64/mm/init.c	2004-07-13 10:39:42.000000000 +0900
+++ linux-2.6.7-ia64-remap/arch/ia64/mm/init.c	2004-07-20 13:27:41.019382964 +0900
@@ -540,8 +540,15 @@ mem_init (void)
 	kclist_add(&kcore_vmem, (void *)VMALLOC_START, VMALLOC_END-VMALLOC_START);
 	kclist_add(&kcore_kernel, _stext, _end - _stext);
 
+#ifdef CONFIG_MEMHOTPLUG
+	for_each_pgdat(pgdat){
+		pgdat->node_totalram_pages = free_all_bootmem_node(pgdat);
+		totalram_pages += pgdat->node_totalram_pages;
+	}
+#else
 	for_each_pgdat(pgdat)
 		totalram_pages += free_all_bootmem_node(pgdat);
+#endif
 
 	reserved_pages = 0;
 	efi_memmap_walk(count_reserved_pages, &reserved_pages);
diff -dupr linux-2.6.7-orig/include/linux/mmzone.h linux-2.6.7-ia64-remap/include/linux/mmzone.h
--- linux-2.6.7-orig/include/linux/mmzone.h	2004-07-13 10:39:43.000000000 +0900
+++ linux-2.6.7-ia64-remap/include/linux/mmzone.h	2004-07-20 13:27:41.020359527 +0900
@@ -240,6 +240,9 @@ typedef struct pglist_data {
 	wait_queue_head_t       kswapd_wait;
 	struct task_struct *kswapd;
 	char removable, enabled;
+#ifdef CONFIG_MEMHOTPLUG
+	unsigned long node_totalram_pages;
+#endif
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
diff -dupr linux-2.6.7-orig/mm/page_alloc.c linux-2.6.7-ia64-remap/mm/page_alloc.c
--- linux-2.6.7-orig/mm/page_alloc.c	2004-07-13 10:39:45.000000000 +0900
+++ linux-2.6.7-ia64-remap/mm/page_alloc.c	2004-07-20 13:27:41.022312652 +0900
@@ -1218,6 +1218,7 @@ static int build_zonelists_node(pg_data_
 }
 
 #ifdef CONFIG_NUMA
+#if 0
 #define MAX_NODE_LOAD (numnodes)
 static int __initdata node_load[MAX_NUMNODES];
 /**
@@ -1322,6 +1323,7 @@ static void __init build_zonelists(pg_da
 }
 
 #else	/* CONFIG_NUMA */
+#endif
 
 static void build_zonelists(pg_data_t *pgdat)
 {
@@ -1621,6 +1623,7 @@ free_area_init_core(struct pglist_data *
 		zone->wait_table_size = wait_table_size(size);
 		zone->wait_table_bits =
 			wait_table_bits(zone->wait_table_size);
+#if 0
 #ifdef CONFIG_MEMHOTPLUG
 		if (!cold)
 			zone->wait_table = (wait_queue_head_t *)
@@ -1628,10 +1631,11 @@ free_area_init_core(struct pglist_data *
 				* sizeof(wait_queue_head_t), GFP_KERNEL);
 		else
 #endif
+#endif
 		zone->wait_table = (wait_queue_head_t *)
 			alloc_bootmem_node(pgdat, zone->wait_table_size
 						* sizeof(wait_queue_head_t));
-
+		
 		for(i = 0; i < zone->wait_table_size; ++i)
 			init_waitqueue_head(zone->wait_table + i);
 
@@ -1682,6 +1686,7 @@ free_area_init_core(struct pglist_data *
 			 */
 			bitmap_size = (size-1) >> (i+4);
 			bitmap_size = LONG_ALIGN(bitmap_size+1);
+#if 0
 #ifdef CONFIG_MEMHOTPLUG
 			if (!cold) {
 			zone->free_area[i].map = 
@@ -1689,6 +1694,7 @@ free_area_init_core(struct pglist_data *
 			memset(zone->free_area[i].map, 0, bitmap_size);
 			} else
 #endif
+#endif
 			zone->free_area[i].map = 
 			  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
 		}


