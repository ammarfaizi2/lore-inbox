Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUAVJlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 04:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265842AbUAVJlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 04:41:46 -0500
Received: from holomorphy.com ([199.26.172.102]:46215 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262355AbUAVJll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 04:41:41 -0500
Date: Thu, 22 Jan 2004 01:41:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: nuke ->valid_addr_bitmap
Message-ID: <20040122094139.GO1016@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

->valid_addr_bitmap is initialized nowhere. Any kern_addr_valid()
testing it returns 0 unconditionally.

This patch converts kern_addr_valid() implementations using it to
return 0 as per the above and removes it from structures and zone
initialization. Untested (not even compiletested), though a similar
patch also nuking d_validate() was in use in -wli for several months.

vs. current bk as of 1:38AM 22 Jan 2004.


-- wli


===== include/asm-alpha/mmzone.h 1.9 vs edited =====
--- 1.9/include/asm-alpha/mmzone.h	Wed Jul  2 21:20:53 2003
+++ edited/include/asm-alpha/mmzone.h	Thu Jan 22 01:22:39 2004
@@ -72,9 +72,8 @@
     ((unsigned long)__va(NODE_DATA(kvaddr_to_nid(kaddr))->node_start_pfn  \
 			 << PAGE_SHIFT))
 
-#define kern_addr_valid(kaddr)						  \
-    test_bit(local_mapnr(kaddr), 					  \
-	     NODE_DATA(kvaddr_to_nid(kaddr))->valid_addr_bitmap)
+/* XXX: FIXME -- wli */
+#define kern_addr_valid(kaddr)	(0)
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 
===== include/asm-i386/mmzone.h 1.15 vs edited =====
--- 1.15/include/asm-i386/mmzone.h	Sun Sep 21 14:50:11 2003
+++ edited/include/asm-i386/mmzone.h	Thu Jan 22 01:23:24 2004
@@ -62,12 +62,8 @@
 	(__pfn - node_start_pfn(pfn_to_nid(__pfn)));			\
 })
 
-#define kern_addr_valid(kaddr)						\
-({									\
-	unsigned long __kaddr = (unsigned long)(kaddr);			\
-	pg_data_t *__pgdat = NODE_DATA(kvaddr_to_nid(__kaddr));		\
-	test_bit(local_mapnr(__kaddr), __pgdat->valid_addr_bitmap);	\
-})
+/* XXX: FIXME -- wli */
+#define kern_addr_valid(kaddr)	(0)
 
 #define pfn_to_page(pfn)						\
 ({									\
===== include/asm-mips/mmzone.h 1.9 vs edited =====
--- 1.9/include/asm-mips/mmzone.h	Mon Jul 28 04:57:50 2003
+++ edited/include/asm-mips/mmzone.h	Thu Jan 22 01:23:51 2004
@@ -75,9 +75,8 @@
 		(((unsigned long)ADDR_TO_MAPBASE((kaddr)) - PAGE_OFFSET) / \
 		sizeof(struct page))))
 
-#define kern_addr_valid(addr)	((KVADDR_TO_NID((unsigned long)addr) > \
-	-1) ? 0 : (test_bit(LOCAL_MAP_NR((addr)), \
-	NODE_DATA(KVADDR_TO_NID((unsigned long)addr))->valid_addr_bitmap)))
+/* XXX: FIXME -- wli */
+#define kern_addr_valid(addr)	(0)
 
 #define pfn_to_page(pfn)	(mem_map + (pfn))
 #define page_to_pfn(page) \
===== include/asm-ppc64/mmzone.h 1.13 vs edited =====
--- 1.13/include/asm-ppc64/mmzone.h	Tue Aug 19 15:05:00 2003
+++ edited/include/asm-ppc64/mmzone.h	Thu Jan 22 01:22:12 2004
@@ -72,11 +72,8 @@
 #define local_mapnr(kvaddr) \
 	( (__pa(kvaddr) >> PAGE_SHIFT) - node_start_pfn(kvaddr_to_nid(kvaddr)) 
 
-#if 0
-/* XXX fix - Anton */
-#define kern_addr_valid(kaddr)	test_bit(local_mapnr(kaddr), \
-		 NODE_DATA(kvaddr_to_nid(kaddr))->valid_addr_bitmap)
-#endif
+/* XXX fix - Anton - and wli */
+#define kern_addr_valid(kaddr)	(0)
 
 /* Written this way to avoid evaluating arguments twice */
 #define discontigmem_pfn_to_page(pfn) \
===== include/linux/mmzone.h 1.49 vs edited =====
--- 1.49/include/linux/mmzone.h	Mon Jan 19 15:38:07 2004
+++ edited/include/linux/mmzone.h	Thu Jan 22 01:20:50 2004
@@ -205,7 +205,6 @@
 	struct zonelist node_zonelists[MAX_NR_ZONES];
 	int nr_zones;
 	struct page *node_mem_map;
-	unsigned long *valid_addr_bitmap;
 	struct bootmem_data *bdata;
 	unsigned long node_start_pfn;
 	unsigned long node_present_pages; /* total number of physical pages */
===== mm/page_alloc.c 1.181 vs edited =====
--- 1.181/mm/page_alloc.c	Mon Jan 19 15:38:07 2004
+++ edited/mm/page_alloc.c	Thu Jan 22 01:24:29 2004
@@ -1182,24 +1182,6 @@
 	printk("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
 }
 
-/*
- * Get space for the valid bitmap.
- */
-static void __init calculate_zone_bitmap(struct pglist_data *pgdat,
-		unsigned long *zones_size)
-{
-	unsigned long size = 0;
-	int i;
-
-	for (i = 0; i < MAX_NR_ZONES; i++)
-		size += zones_size[i];
-	size = LONG_ALIGN((size + 7) >> 3);
-	if (size) {
-		pgdat->valid_addr_bitmap = 
-			(unsigned long *)alloc_bootmem_node(pgdat, size);
-		memset(pgdat->valid_addr_bitmap, 0, size);
-	}
-}
 
 /*
  * Initially all pages are reserved - free ones are freed
@@ -1393,8 +1375,6 @@
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
 	memblk_set_online(node_to_memblk(nid));
-
-	calculate_zone_bitmap(pgdat, zones_size);
 }
 
 #ifndef CONFIG_DISCONTIGMEM
