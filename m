Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWBJOVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWBJOVH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWBJOVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:21:06 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:59851 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932107AbWBJOVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:21:04 -0500
Date: Fri, 10 Feb 2006 23:20:38 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Subject: [RFC/PATCH: 001/010] Memory hotplug for new nodes with pgdat allocation. (pgdat allocation)
Cc: linux-ia64@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060210223757.C530.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is main patch for pgdat allocation for new node.
When, new pgdat is required, kernel allocates memory for it
and initialize it by calling free_area_init_node().

Finally, NODE_DATA() macro can use by registering node_data[] array.
Ia64 needs special code for node_data[], but 
  node_data[node] = pgdat;
is enough for other archtectures. 

To allocate pgdat, this patch use kmalloc() for it.
This means its place is not appropriate. 
Kmalloc() will use other node for new pgdat. Because new node's memory
management structure (it means new pgdat) must be initalized ITSELF
for kmalloc. But I use kemalloc to simplify patch now....

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat2/include/linux/bootmem.h
===================================================================
--- pgdat2.orig/include/linux/bootmem.h	2006-02-10 16:49:57.000000000 +0900
+++ pgdat2/include/linux/bootmem.h	2006-02-10 17:01:48.000000000 +0900
@@ -86,8 +86,8 @@ static inline void *alloc_remap(int nid,
 }
 #endif
 
-extern unsigned long __initdata nr_kernel_pages;
-extern unsigned long __initdata nr_all_pages;
+extern unsigned long __meminitdata nr_kernel_pages;
+extern unsigned long __meminitdata nr_all_pages;
 
 extern void *__init alloc_large_system_hash(const char *tablename,
 					    unsigned long bucketsize,
Index: pgdat2/mm/memory_hotplug.c
===================================================================
--- pgdat2.orig/mm/memory_hotplug.c	2006-02-10 16:49:57.000000000 +0900
+++ pgdat2/mm/memory_hotplug.c	2006-02-10 16:59:51.000000000 +0900
@@ -21,6 +21,7 @@
 #include <linux/memory_hotplug.h>
 #include <linux/highmem.h>
 #include <linux/vmalloc.h>
+#include <linux/kthread.h>
 
 #include <asm/tlbflush.h>
 
@@ -54,6 +55,44 @@ static int __add_section(struct zone *zo
 	return register_new_memory(__pfn_to_section(phys_start_pfn));
 }
 
+extern int kswapd(void *);
+int new_pgdat_init(int nid, unsigned long start_pfn, unsigned long nr_pages)
+{
+	unsigned long zones_size[MAX_NR_ZONES] = {0};
+	unsigned long zholes_size[MAX_NR_ZONES] = {0};
+        unsigned long size = arch_pernode_size(nid);
+	pg_data_t *pgdat;
+
+	pgdat = kmalloc(size, GFP_KERNEL);
+	if (!pgdat){
+		printk("%s node_data allocation failed\n", __FUNCTION__);
+		return -ENODEV;
+	}
+
+	memset(pgdat, 0, size);
+	set_node_data_array(nid, pgdat);
+	/* NODE_DATA(nid) macro can use from here */
+
+	free_area_init_node(nid, NODE_DATA(nid), zones_size, start_pfn, zholes_size);
+
+	NODE_DATA(nid)->kswapd = kthread_create(kswapd, NODE_DATA(nid), "kswapd%d", nid);
+
+	node_set_online(nid);
+	arch_register_node(nid);
+
+	return 0;
+
+}
+
+void release_pgdat(pg_data_t *pgdat)
+{
+	arch_unregister_node(pgdat->node_id);
+	node_set_offline(pgdat->node_id);
+	clear_node_data_array(pgdat);
+	kfree(pgdat);
+}
+
+
 /*
  * Reasonably generic function for adding memory.  It is
  * expected that archs that support memory hotplug will
Index: pgdat2/mm/page_alloc.c
===================================================================
--- pgdat2.orig/mm/page_alloc.c	2006-02-10 16:49:57.000000000 +0900
+++ pgdat2/mm/page_alloc.c	2006-02-10 17:02:22.000000000 +0900
@@ -80,8 +80,8 @@ EXPORT_SYMBOL(zone_table);
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
 
-unsigned long __initdata nr_kernel_pages;
-unsigned long __initdata nr_all_pages;
+unsigned long __meminitdata nr_kernel_pages;
+unsigned long __meminitdata nr_all_pages;
 
 #ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
@@ -2128,7 +2128,7 @@ static __meminit void init_currently_emp
  *   - mark all memory queues empty
  *   - clear the memory bitmaps
  */
-static void __init free_area_init_core(struct pglist_data *pgdat,
+void __meminit free_area_init_core(struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long *zholes_size)
 {
 	unsigned long j;
@@ -2208,7 +2208,7 @@ static void __init alloc_node_mem_map(st
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 }
 
-void __init free_area_init_node(int nid, struct pglist_data *pgdat,
+void __meminit free_area_init_node(int nid, struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long node_start_pfn,
 		unsigned long *zholes_size)
 {
Index: pgdat2/mm/vmscan.c
===================================================================
--- pgdat2.orig/mm/vmscan.c	2006-02-10 16:49:57.000000000 +0900
+++ pgdat2/mm/vmscan.c	2006-02-10 16:59:47.000000000 +0900
@@ -1664,7 +1664,7 @@ out:
  * If there are applications that are active memory-allocators
  * (most normal use), this basically shouldn't matter.
  */
-static int kswapd(void *p)
+int kswapd(void *p)
 {
 	unsigned long order;
 	pg_data_t *pgdat = (pg_data_t*)p;
Index: pgdat2/include/linux/memory_hotplug.h
===================================================================
--- pgdat2.orig/include/linux/memory_hotplug.h	2006-02-10 16:49:57.000000000 +0900
+++ pgdat2/include/linux/memory_hotplug.h	2006-02-10 16:59:47.000000000 +0900
@@ -61,6 +61,34 @@ extern int online_pages(unsigned long, u
 /* reasonably generic interface to expand the physical pages in a zone  */
 extern int __add_pages(struct zone *zone, unsigned long start_pfn,
 	unsigned long nr_pages);
+
+#ifdef CONFIG_ARCH_PERNODE_SIZE
+extern unsigned long arch_pernode_size(int node);
+#else /* CONFIG_ARCH_PERNODE_SIZE */
+static inline unsigned long arch_pernode_size(int)
+{
+	return ALIGN(sizeof(pg_data_t), PAGE_SIZE);
+}
+#endif /* CONFIG_ARCH_PERNODE_SIZE */
+
+#ifdef CONFIG_ARCH_UPDATE_NODE_DATA
+extern void set_node_data_array(int, pg_data_t *);
+extern void clear_node_data_array(pg_data_t *);
+#else /* CONFIG_ARCH_UPDATE_NODE_DATA */
+static inline void set_node_data_array(int nid, pg_data_t *pgdat)
+{
+	NODE_DATA(nid) = pgdat;
+}
+
+static inline void clear_node_data_array(pg_data_t *pgdat)
+{
+	NODE_DATA(pgdat->node_id) = NULL;
+}
+#endif /* CONFIG_ARCH_UPDATE_NODE_DATA */
+
+extern int new_pgdat_init(int, unsigned long, unsigned long);
+extern void release_pgdat(pg_data_t *);
+
 #else /* ! CONFIG_MEMORY_HOTPLUG */
 /*
  * Stub functions for when hotplug is off

-- 
Yasunori Goto 


