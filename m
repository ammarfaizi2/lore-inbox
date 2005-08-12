Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVHLOug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVHLOug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVHLOrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:47:49 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:33685 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751035AbVHLOr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:47:28 -0400
Subject: [RFC][PATCH 06/12] memory hotplug locking: node_size_lock
To: linux-kernel@vger.kernel.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 12 Aug 2005 07:47:25 -0700
References: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
In-Reply-To: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
Message-Id: <20050812144725.5BBEED61@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pgdat->node_size_lock is basically only neeeded in one place in the
normal code: show_mem(), which is the arch-specific sysrq-m printing
function.

This lock is also held in the sparsemem code during a memory removal,
as sections are invalidated.  This is the place there pfn_valid() is
made false for a memory area that's being removed.  The lock is
only required when doing pfn_valid() operations on memory which the
user does not already have a reference on the page, such as in
show_mem().

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/alpha/mm/numa.c           |    3 ++
 memhotplug-dave/arch/i386/mm/pgtable.c         |    3 ++
 memhotplug-dave/arch/ia64/mm/discontig.c       |    7 ++++-
 memhotplug-dave/arch/m32r/mm/init.c            |    9 +++++-
 memhotplug-dave/arch/parisc/mm/init.c          |    3 ++
 memhotplug-dave/arch/ppc64/mm/init.c           |    6 ++++
 memhotplug-dave/include/linux/memory_hotplug.h |   34 +++++++++++++++++++++++++
 memhotplug-dave/include/linux/mmzone.h         |   12 ++++++++
 memhotplug-dave/mm/page_alloc.c                |    1 
 9 files changed, 76 insertions(+), 2 deletions(-)

diff -puN include/linux/mmzone.h~C5.2-pgdat_size_lock include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~C5.2-pgdat_size_lock	2005-08-12 07:43:46.000000000 -0700
+++ memhotplug-dave/include/linux/mmzone.h	2005-08-12 07:43:47.000000000 -0700
@@ -273,6 +273,16 @@ typedef struct pglist_data {
 	struct page *node_mem_map;
 #endif
 	struct bootmem_data *bdata;
+#ifdef CONFIG_MEMORY_HOTPLUG
+	/*
+	 * Must be held any time you expect node_start_pfn, node_present_pages
+	 * or node_spanned_pages stay constant.  Holding this will also
+	 * guarantee that any pfn_valid() stays that way.
+	 *
+	 * Nests above zone->lock and zone->size_seqlock.
+	 */
+	spinlock_t node_size_lock;
+#endif
 	unsigned long node_start_pfn;
 	unsigned long node_present_pages; /* total number of physical pages */
 	unsigned long node_spanned_pages; /* total size of physical page
@@ -293,6 +303,8 @@ typedef struct pglist_data {
 #endif
 #define nid_page_nr(nid, pagenr) 	pgdat_page_nr(NODE_DATA(nid),(pagenr))
 
+#include <linux/memory_hotplug.h>
+
 extern struct pglist_data *pgdat_list;
 
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
diff -puN mm/page_alloc.c~C5.2-pgdat_size_lock mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~C5.2-pgdat_size_lock	2005-08-12 07:43:46.000000000 -0700
+++ memhotplug-dave/mm/page_alloc.c	2005-08-12 07:43:47.000000000 -0700
@@ -1937,6 +1937,7 @@ static void __init free_area_init_core(s
 	int nid = pgdat->node_id;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
 
+	pgdat_resize_init(pgdat);
 	pgdat->nr_zones = 0;
 	init_waitqueue_head(&pgdat->kswapd_wait);
 	pgdat->kswapd_max_order = 0;
diff -puN arch/alpha/mm/numa.c~C5.2-pgdat_size_lock arch/alpha/mm/numa.c
--- memhotplug/arch/alpha/mm/numa.c~C5.2-pgdat_size_lock	2005-08-12 07:43:46.000000000 -0700
+++ memhotplug-dave/arch/alpha/mm/numa.c	2005-08-12 07:43:47.000000000 -0700
@@ -371,6 +371,8 @@ show_mem(void)
 	show_free_areas();
 	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
 	for_each_online_node(nid) {
+		unsigned long flags;
+		pgdat_resize_lock(NODE_DATA(nid), &flags);
 		i = node_spanned_pages(nid);
 		while (i-- > 0) {
 			struct page *page = nid_page_nr(nid, i);
@@ -384,6 +386,7 @@ show_mem(void)
 			else
 				shared += page_count(page) - 1;
 		}
+		pgdat_resize_unlock(NODE_DATA(nid), &flags);
 	}
 	printk("%ld pages of RAM\n",total);
 	printk("%ld free pages\n",free);
diff -puN arch/i386/mm/pgtable.c~C5.2-pgdat_size_lock arch/i386/mm/pgtable.c
--- memhotplug/arch/i386/mm/pgtable.c~C5.2-pgdat_size_lock	2005-08-12 07:43:46.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/pgtable.c	2005-08-12 07:43:47.000000000 -0700
@@ -31,11 +31,13 @@ void show_mem(void)
 	pg_data_t *pgdat;
 	unsigned long i;
 	struct page_state ps;
+	unsigned long flags;
 
 	printk(KERN_INFO "Mem-info:\n");
 	show_free_areas();
 	printk(KERN_INFO "Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
 	for_each_pgdat(pgdat) {
+		pgdat_resize_lock(pgdat, &flags);
 		for (i = 0; i < pgdat->node_spanned_pages; ++i) {
 			page = pgdat_page_nr(pgdat, i);
 			total++;
@@ -48,6 +50,7 @@ void show_mem(void)
 			else if (page_count(page))
 				shared += page_count(page) - 1;
 		}
+		pgdat_resize_unlock(pgdat, &flags);
 	}
 	printk(KERN_INFO "%d pages of RAM\n", total);
 	printk(KERN_INFO "%d pages of HIGHMEM\n", highmem);
diff -puN arch/ia64/mm/discontig.c~C5.2-pgdat_size_lock arch/ia64/mm/discontig.c
--- memhotplug/arch/ia64/mm/discontig.c~C5.2-pgdat_size_lock	2005-08-12 07:43:46.000000000 -0700
+++ memhotplug-dave/arch/ia64/mm/discontig.c	2005-08-12 07:43:47.000000000 -0700
@@ -524,9 +524,13 @@ void show_mem(void)
 	show_free_areas();
 	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
 	for_each_pgdat(pgdat) {
-		unsigned long present = pgdat->node_present_pages;
+		unsigned long present;
+		unsigned long flags;
 		int shared = 0, cached = 0, reserved = 0;
+
 		printk("Node ID: %d\n", pgdat->node_id);
+		pgdat_resize_lock(pgdat, &flags);
+		present = pgdat->node_present_pages;
 		for(i = 0; i < pgdat->node_spanned_pages; i++) {
 			struct page *page = pgdat_page_nr(pgdat, i);
 			if (!ia64_pfn_valid(pgdat->node_start_pfn+i))
@@ -538,6 +542,7 @@ void show_mem(void)
 			else if (page_count(page))
 				shared += page_count(page)-1;
 		}
+		pgdat_resize_unlock(pgdat, &flags);
 		total_present += present;
 		total_reserved += reserved;
 		total_cached += cached;
diff -puN include/asm-x86_64/mmzone.h~C5.2-pgdat_size_lock include/asm-x86_64/mmzone.h
diff -puN include/asm-parisc/mmzone.h~C5.2-pgdat_size_lock include/asm-parisc/mmzone.h
diff -puN include/asm-ppc64/mmzone.h~C5.2-pgdat_size_lock include/asm-ppc64/mmzone.h
diff -puN include/asm-alpha/mmzone.h~C5.2-pgdat_size_lock include/asm-alpha/mmzone.h
diff -puN include/asm-i386/mmzone.h~C5.2-pgdat_size_lock include/asm-i386/mmzone.h
diff -puN include/asm-m32r/mmzone.h~C5.2-pgdat_size_lock include/asm-m32r/mmzone.h
diff -puN arch/m32r/mm/init.c~C5.2-pgdat_size_lock arch/m32r/mm/init.c
--- memhotplug/arch/m32r/mm/init.c~C5.2-pgdat_size_lock	2005-08-12 07:43:46.000000000 -0700
+++ memhotplug-dave/arch/m32r/mm/init.c	2005-08-12 07:43:47.000000000 -0700
@@ -48,6 +48,8 @@ void show_mem(void)
 	show_free_areas();
 	printk("Free swap:       %6ldkB\n",nr_swap_pages<<(PAGE_SHIFT-10));
 	for_each_pgdat(pgdat) {
+		unsigned long flags;
+		pgdat_resize_lock(pgdat, &flags);
 		for (i = 0; i < pgdat->node_spanned_pages; ++i) {
 			page = pgdat_page_nr(pgdat, i);
 			total++;
@@ -60,6 +62,7 @@ void show_mem(void)
 			else if (page_count(page))
 				shared += page_count(page) - 1;
 		}
+		pgdat_resize_unlock(pgdat, &flags);
 	}
 	printk("%d pages of RAM\n", total);
 	printk("%d pages of HIGHMEM\n",highmem);
@@ -150,10 +153,14 @@ int __init reservedpages_count(void)
 	int reservedpages, nid, i;
 
 	reservedpages = 0;
-	for_each_online_node(nid)
+	for_each_online_node(nid) {
+		unsigned long flags;
+		pgdat_resize_lock(NODE_DATA(nid), &flags);
 		for (i = 0 ; i < MAX_LOW_PFN(nid) - START_PFN(nid) ; i++)
 			if (PageReserved(nid_page_nr(nid, i)))
 				reservedpages++;
+		pgdat_resize_unlock(NODE_DATA(nid), &flags);
+	}
 
 	return reservedpages;
 }
diff -puN arch/ppc64/mm/init.c~C5.2-pgdat_size_lock arch/ppc64/mm/init.c
--- memhotplug/arch/ppc64/mm/init.c~C5.2-pgdat_size_lock	2005-08-12 07:43:46.000000000 -0700
+++ memhotplug-dave/arch/ppc64/mm/init.c	2005-08-12 07:43:47.000000000 -0700
@@ -97,6 +97,8 @@ void show_mem(void)
 	show_free_areas();
 	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
 	for_each_pgdat(pgdat) {
+		unsigned long flags;
+		pgdat_resize_lock(pgdat, &flags);
 		for (i = 0; i < pgdat->node_spanned_pages; i++) {
 			page = pgdat_page_nr(pgdat, i);
 			total++;
@@ -107,6 +109,7 @@ void show_mem(void)
 			else if (page_count(page))
 				shared += page_count(page) - 1;
 		}
+		pgdat_resize_unlock(pgdat, &flags);
 	}
 	printk("%ld pages of RAM\n", total);
 	printk("%ld reserved pages\n", reserved);
@@ -662,11 +665,14 @@ void __init mem_init(void)
 #endif
 
 	for_each_pgdat(pgdat) {
+		unsigned long flags;
+		pgdat_resize_lock(pgdat, &flags);
 		for (i = 0; i < pgdat->node_spanned_pages; i++) {
 			page = pgdat_page_nr(pgdat, i);
 			if (PageReserved(page))
 				reservedpages++;
 		}
+		pgdat_resize_unlock(pgdat, &flags);
 	}
 
 	codesize = (unsigned long)&_etext - (unsigned long)&_stext;
diff -puN arch/parisc/mm/init.c~C5.2-pgdat_size_lock arch/parisc/mm/init.c
--- memhotplug/arch/parisc/mm/init.c~C5.2-pgdat_size_lock	2005-08-12 07:43:46.000000000 -0700
+++ memhotplug-dave/arch/parisc/mm/init.c	2005-08-12 07:43:47.000000000 -0700
@@ -505,7 +505,9 @@ void show_mem(void)
 
 		for (j = node_start_pfn(i); j < node_end_pfn(i); j++) {
 			struct page *p;
+			unsigned long flags;
 
+			pgdat_resize_lock(NODE_DATA(i), &flags);
 			p = nid_page_nr(i, j) - node_start_pfn(i);
 
 			total++;
@@ -517,6 +519,7 @@ void show_mem(void)
 				free++;
 			else
 				shared += page_count(p) - 1;
+			pgdat_resize_unlock(NODE_DATA(i), &flags);
         	}
 	}
 #endif
diff -puN /dev/null include/linux/memory_hotplug.h
--- /dev/null	2005-03-30 22:36:15.000000000 -0800
+++ memhotplug-dave/include/linux/memory_hotplug.h	2005-08-12 07:43:47.000000000 -0700
@@ -0,0 +1,34 @@
+#ifndef __LINUX_MEMORY_HOTPLUG_H
+#define __LINUX_MEMORY_HOTPLUG_H
+
+#include <linux/mmzone.h>
+#include <linux/spinlock.h>
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+/*
+ * pgdat resizing functions
+ */
+static inline
+void pgdat_resize_lock(struct pglist_data *pgdat, unsigned long *flags)
+{
+	spin_lock_irqsave(&pgdat->node_size_lock, *flags);
+}
+static inline
+void pgdat_resize_unlock(struct pglist_data *pgdat, unsigned long *flags)
+{
+	spin_lock_irqrestore(&pgdat->node_size_lock, *flags);
+}
+static inline
+void pgdat_resize_init(struct pglist_data *pgdat)
+{
+	spin_lock_init(&pgdat->node_size_lock);
+}
+#else /* ! CONFIG_MEMORY_HOTPLUG */
+/*
+ * Stub functions for when hotplug is off
+ */
+static inline void pgdat_resize_lock(struct pglist_data *p, unsigned long *f) {}
+static inline void pgdat_resize_unlock(struct pglist_data *p, unsigned long *f) {}
+static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
+#endif
+#endif /* __LINUX_MEMORY_HOTPLUG_H */
_
