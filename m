Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUDTGFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUDTGFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 02:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUDTGFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 02:05:15 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:45953 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262080AbUDTGE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 02:04:57 -0400
Date: Tue, 20 Apr 2004 15:05:31 +0900
From: Fumihiro Tersawa <terasawa@pst.fujitsu.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>
Subject: [patch 1/2] memory hotplug prototype for ia64
Message-Id: <20040420150355.0FBC.TERASAWA@pst.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a main patch of memory hotplug prototype for ia64.


diff -dupr linux-2.6.5/arch/ia64/Kconfig linux-2.6.5-memhotplug-ia64/arch/ia64/Kconfig
--- linux-2.6.5/arch/ia64/Kconfig	2004-04-04 12:38:18.000000000 +0900
+++ linux-2.6.5-memhotplug-ia64/arch/ia64/Kconfig	2004-04-15 13:42:35.000000000 +0900
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
diff -dupr linux-2.6.5/arch/ia64/mm/discontig.c linux-2.6.5-memhotplug-ia64/arch/ia64/mm/discontig.c
--- linux-2.6.5/arch/ia64/mm/discontig.c	2004-04-04 12:38:12.000000000 +0900
+++ linux-2.6.5-memhotplug-ia64/arch/ia64/mm/discontig.c	2004-04-16 12:44:45.543396304 +0900
@@ -664,7 +664,70 @@ void paging_init(void)
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
+
+	NODE_DATA(node)->enabled = 0;
+	build_all_zonelists();
+}
+unplug_node(int node)
+{
+        int i;
+        struct zone *z;
+        pg_data_t *pgdat;
+
+        if (NODE_DATA(node)->enabled)
+                return -1;
+        for(i = 0; i < MAX_NR_ZONES; i++) {
+                z = zone_table[NODEZONE(node, i)];
+                if (z->present_pages != z->free_pages)
+                        return -1;
+        }
+
+        /* lock? */
+        for(pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
+                if (pgdat->pgdat_next == NODE_DATA(node)) {
+                        pgdat->pgdat_next = pgdat->pgdat_next->pgdat_next;
+                        break;
+                }
+        BUG_ON(pgdat == NULL);
+
+        for(i = 0; i < MAX_NR_ZONES; i++)
+                zone_table[NODEZONE(node, i)] = NULL;
+        NODE_DATA(node) = NULL;
+
+        return 0;
+} 
+
diff -dupr linux-2.6.5/mm/page_alloc.c linux-2.6.5-memhotplug-ia64/mm/page_alloc.c
--- linux-2.6.5/mm/page_alloc.c	2004-04-16 12:24:08.095169275 +0900
+++ linux-2.6.5-memhotplug-ia64/mm/page_alloc.c	2004-04-16 13:20:35.083409035 +0900
@@ -1148,6 +1148,7 @@ static int build_zonelists_node(pg_data_
 }
 
 #ifdef CONFIG_NUMA
+#if 0
 #define MAX_NODE_LOAD (numnodes)
 static int __initdata node_load[MAX_NUMNODES];
 /**
@@ -1252,6 +1253,7 @@ static void __init build_zonelists(pg_da
 }
 
 #else	/* CONFIG_NUMA */
+#endif
 
 static void build_zonelists(pg_data_t *pgdat)
 {
@@ -1553,6 +1555,7 @@ free_area_init_core(struct pglist_data *
 		zone->wait_table_size = wait_table_size(size);
 		zone->wait_table_bits =
 			wait_table_bits(zone->wait_table_size);
+#if 0
 #ifdef CONFIG_MEMHOTPLUG
 		if (! cold)
 			zone->wait_table = (wait_queue_head_t *)
@@ -1560,6 +1563,7 @@ free_area_init_core(struct pglist_data *
 				* sizeof(wait_queue_head_t), GFP_KERNEL);
 		else
 #endif
+#endif
 		zone->wait_table = (wait_queue_head_t *)
 			alloc_bootmem_node(pgdat, zone->wait_table_size
 						* sizeof(wait_queue_head_t));
@@ -1614,6 +1618,7 @@ free_area_init_core(struct pglist_data *
 			 */
 			bitmap_size = (size-1) >> (i+4);
 			bitmap_size = LONG_ALIGN(bitmap_size+1);
+#if 0
 #ifdef CONFIG_MEMHOTPLUG
 			if (! cold) {
 			zone->free_area[i].map = 
@@ -1621,6 +1626,7 @@ free_area_init_core(struct pglist_data *
 			memset(zone->free_area[i].map, 0, bitmap_size);
 			} else
 #endif
+#endif
 			zone->free_area[i].map = 
 			  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
 		}


