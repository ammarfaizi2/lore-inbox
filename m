Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUGNOIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUGNOIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUGNOIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:08:06 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:2748 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267405AbUGNODi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:03:38 -0400
Date: Wed, 14 Jul 2004 23:03:20 +0900 (JST)
Message-Id: <20040714.230320.02321470.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [PATCH] memory hotremoval for linux-2.6.7 [3/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.6.7.ORG/arch/i386/Kconfig	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/arch/i386/Kconfig	Sun Jul 11 10:04:58 2032
@@ -734,9 +734,19 @@ comment "NUMA (NUMA-Q) requires SMP, 64G
 comment "NUMA (Summit) requires SMP, 64GB highmem support, ACPI"
 	depends on X86_SUMMIT && (!HIGHMEM64G || !ACPI)
 
+config MEMHOTPLUG
+	bool "Memory hotplug test"
+	depends on !X86_PAE
+	default n
+
+config MEMHOTPLUG_BLKSIZE
+	int "Size of a memory hotplug unit (in MB, must be multiple of 256)."
+	range 256 1024
+	depends on MEMHOTPLUG
+
 config DISCONTIGMEM
 	bool
-	depends on NUMA
+	depends on NUMA || MEMHOTPLUG
 	default y
 
 config HAVE_ARCH_BOOTMEM_NODE
--- linux-2.6.7.ORG/include/linux/gfp.h	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/include/linux/gfp.h	Sat Jul 10 19:37:22 2032
@@ -11,9 +11,10 @@ struct vm_area_struct;
 /*
  * GFP bitmasks..
  */
-/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low two bits) */
-#define __GFP_DMA	0x01
-#define __GFP_HIGHMEM	0x02
+/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low three bits) */
+#define __GFP_DMA		0x01
+#define __GFP_HIGHMEM		0x02
+#define __GFP_HOTREMOVABLE	0x03
 
 /*
  * Action modifiers - doesn't change the zoning
@@ -51,7 +52,7 @@ struct vm_area_struct;
 #define GFP_NOFS	(__GFP_WAIT | __GFP_IO)
 #define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS)
 #define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
+#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM | __GFP_HOTREMOVABLE)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
--- linux-2.6.7.ORG/include/linux/mmzone.h	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/include/linux/mmzone.h	Sun Jul 11 10:04:13 2032
@@ -65,8 +65,10 @@ struct per_cpu_pageset {
 #define ZONE_DMA		0
 #define ZONE_NORMAL		1
 #define ZONE_HIGHMEM		2
+#define ZONE_HOTREMOVABLE	3	/* only for zonelists */
 
 #define MAX_NR_ZONES		3	/* Sync this with ZONES_SHIFT */
+#define MAX_NR_ZONELISTS	4
 #define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
 
 #define GFP_ZONEMASK	0x03
@@ -225,7 +227,7 @@ struct zonelist {
 struct bootmem_data;
 typedef struct pglist_data {
 	struct zone node_zones[MAX_NR_ZONES];
-	struct zonelist node_zonelists[MAX_NR_ZONES];
+	struct zonelist node_zonelists[MAX_NR_ZONELISTS];
 	int nr_zones;
 	struct page *node_mem_map;
 	struct bootmem_data *bdata;
@@ -237,6 +239,7 @@ typedef struct pglist_data {
 	struct pglist_data *pgdat_next;
 	wait_queue_head_t       kswapd_wait;
 	struct task_struct *kswapd;
+	char removable, enabled;
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
--- linux-2.6.7.ORG/include/linux/page-flags.h	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/include/linux/page-flags.h	Sun Jul 11 10:04:13 2032
@@ -78,6 +78,8 @@
 
 #define PG_anon			20	/* Anonymous: anon_vma in mapping */
 
+#define PG_again		21
+
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -297,6 +299,10 @@ extern unsigned long __read_page_state(u
 #define PageCompound(page)	test_bit(PG_compound, &(page)->flags)
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
+
+#define PageAgain(page)	test_bit(PG_again, &(page)->flags)
+#define SetPageAgain(page)	set_bit(PG_again, &(page)->flags)
+#define ClearPageAgain(page)	clear_bit(PG_again, &(page)->flags)
 
 #define PageAnon(page)		test_bit(PG_anon, &(page)->flags)
 #define SetPageAnon(page)	set_bit(PG_anon, &(page)->flags)
--- linux-2.6.7.ORG/include/linux/rmap.h	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/include/linux/rmap.h	Sat Jul 10 19:37:22 2032
@@ -96,7 +96,7 @@ static inline void page_dup_rmap(struct 
  * Called from mm/vmscan.c to handle paging out
  */
 int page_referenced(struct page *);
-int try_to_unmap(struct page *);
+int try_to_unmap(struct page *, struct list_head *);
 
 #else	/* !CONFIG_MMU */
 
@@ -105,7 +105,7 @@ int try_to_unmap(struct page *);
 #define anon_vma_link(vma)	do {} while (0)
 
 #define page_referenced(page)	TestClearPageReferenced(page)
-#define try_to_unmap(page)	SWAP_FAIL
+#define try_to_unmap(page, force)	SWAP_FAIL
 
 #endif	/* CONFIG_MMU */
 
--- linux-2.6.7.ORG/mm/Makefile	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/mm/Makefile	Sat Jul 10 19:37:22 2032
@@ -15,3 +15,5 @@ obj-y			:= bootmem.o filemap.o mempool.o
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
+
+obj-$(CONFIG_MEMHOTPLUG) += memhotplug.o
--- linux-2.6.7.ORG/mm/filemap.c	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/mm/filemap.c	Sat Jul 10 19:37:22 2032
@@ -250,7 +250,8 @@ int filemap_write_and_wait(struct addres
 int add_to_page_cache(struct page *page, struct address_space *mapping,
 		pgoff_t offset, int gfp_mask)
 {
-	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+	int error = radix_tree_preload((gfp_mask & ~GFP_ZONEMASK) |
+	    ((gfp_mask & GFP_ZONEMASK) == __GFP_DMA ? __GFP_DMA : 0));
 
 	if (error == 0) {
 		spin_lock_irq(&mapping->tree_lock);
@@ -495,6 +496,7 @@ repeat:
 				page_cache_release(page);
 				goto repeat;
 			}
+			BUG_ON(PageAgain(page));
 		}
 	}
 	spin_unlock_irq(&mapping->tree_lock);
@@ -738,6 +740,8 @@ page_not_up_to_date:
 			goto page_ok;
 		}
 
+		BUG_ON(PageAgain(page));
+
 readpage:
 		/* ... and start the actual read. The read will unlock the page. */
 		error = mapping->a_ops->readpage(filp, page);
@@ -1206,6 +1210,8 @@ page_not_uptodate:
 		goto success;
 	}
 
+	BUG_ON(PageAgain(page));
+
 	if (!mapping->a_ops->readpage(file, page)) {
 		wait_on_page_locked(page);
 		if (PageUptodate(page))
@@ -1314,6 +1320,8 @@ page_not_uptodate:
 		goto success;
 	}
 
+	BUG_ON(PageAgain(page));
+
 	if (!mapping->a_ops->readpage(file, page)) {
 		wait_on_page_locked(page);
 		if (PageUptodate(page))
@@ -1518,6 +1526,8 @@ retry:
 		unlock_page(page);
 		goto out;
 	}
+	BUG_ON(PageAgain(page));
+
 	err = filler(data, page);
 	if (err < 0) {
 		page_cache_release(page);
--- linux-2.6.7.ORG/mm/memory.c	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/mm/memory.c	Sun Jul 11 10:04:42 2032
@@ -1305,6 +1305,7 @@ static int do_swap_page(struct mm_struct
 
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
+again:
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
@@ -1332,6 +1333,12 @@ static int do_swap_page(struct mm_struct
 
 	mark_page_accessed(page);
 	lock_page(page);
+	if (PageAgain(page)) {
+		unlock_page(page);
+		page_cache_release(page);
+		goto again;
+	}
+	BUG_ON(PageAgain(page));
 
 	/*
 	 * Back out if somebody else faulted in this pte while we
--- linux-2.6.7.ORG/mm/page_alloc.c	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/mm/page_alloc.c	Sun Jul 11 10:04:58 2032
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/pagevec.h>
+#include <linux/memhotplug.h>
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/notifier.h>
@@ -231,6 +232,7 @@ static inline void free_pages_check(cons
 			1 << PG_maplock |
 			1 << PG_anon    |
 			1 << PG_swapcache |
+			1 << PG_again |
 			1 << PG_writeback )))
 		bad_page(function, page);
 	if (PageDirty(page))
@@ -341,12 +343,13 @@ static void prep_new_page(struct page *p
 			1 << PG_maplock |
 			1 << PG_anon    |
 			1 << PG_swapcache |
+			1 << PG_again |
 			1 << PG_writeback )))
 		bad_page(__FUNCTION__, page);
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
-			1 << PG_checked | 1 << PG_mappedtodisk);
+			1 << PG_checked | 1 << PG_mappedtodisk | 1 << PG_again);
 	page->private = 0;
 	set_page_refs(page, order);
 }
@@ -404,7 +407,7 @@ static int rmqueue_bulk(struct zone *zon
 	return allocated;
 }
 
-#if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU)
+#if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMHOTPLUG)
 static void __drain_pages(unsigned int cpu)
 {
 	struct zone *zone;
@@ -447,7 +450,9 @@ int is_head_of_free_region(struct page *
 	spin_unlock_irqrestore(&zone->lock, flags);
         return 0;
 }
+#endif
 
+#if defined(CONFIG_SOFTWARE_SUSPEND) || defined(CONFIG_MEMHOTPLUG)
 /*
  * Spill all of this CPU's per-cpu pages back into the buddy allocator.
  */
@@ -847,7 +852,8 @@ unsigned int nr_free_pages(void)
 	struct zone *zone;
 
 	for_each_zone(zone)
-		sum += zone->free_pages;
+		if (zone->zone_pgdat->enabled)
+			sum += zone->free_pages;
 
 	return sum;
 }
@@ -860,7 +866,8 @@ unsigned int nr_used_zone_pages(void)
 	struct zone *zone;
 
 	for_each_zone(zone)
-		pages += zone->nr_active + zone->nr_inactive;
+		if (zone->zone_pgdat->enabled)
+			pages += zone->nr_active + zone->nr_inactive;
 
 	return pages;
 }
@@ -887,6 +894,8 @@ static unsigned int nr_free_zone_pages(i
 		struct zone **zonep = zonelist->zones;
 		struct zone *zone;
 
+		if (!pgdat->enabled)
+			continue;
 		for (zone = *zonep++; zone; zone = *zonep++) {
 			unsigned long size = zone->present_pages;
 			unsigned long high = zone->pages_high;
@@ -921,7 +930,8 @@ unsigned int nr_free_highpages (void)
 	unsigned int pages = 0;
 
 	for_each_pgdat(pgdat)
-		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+		if (pgdat->enabled)
+			pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
 
 	return pages;
 }
@@ -1171,13 +1181,21 @@ void show_free_areas(void)
 /*
  * Builds allocation fallback zone lists.
  */
-static int __init build_zonelists_node(pg_data_t *pgdat, struct zonelist *zonelist, int j, int k)
+static int build_zonelists_node(pg_data_t *pgdat, struct zonelist *zonelist, int j, int k)
 {
+
+	if (!pgdat->enabled)
+		return j;
+	if (k != ZONE_HOTREMOVABLE &&
+	    pgdat->removable)
+		return j;
+
 	switch (k) {
 		struct zone *zone;
 	default:
 		BUG();
 	case ZONE_HIGHMEM:
+	case ZONE_HOTREMOVABLE:
 		zone = pgdat->node_zones + ZONE_HIGHMEM;
 		if (zone->present_pages) {
 #ifndef CONFIG_HIGHMEM
@@ -1304,24 +1322,48 @@ static void __init build_zonelists(pg_da
 
 #else	/* CONFIG_NUMA */
 
-static void __init build_zonelists(pg_data_t *pgdat)
+static void build_zonelists(pg_data_t *pgdat)
 {
 	int i, j, k, node, local_node;
+	int hotremovable;
+#ifdef CONFIG_MEMHOTPLUG
+	struct zone *zone;
+#endif
 
 	local_node = pgdat->node_id;
-	for (i = 0; i < MAX_NR_ZONES; i++) {
+	for (i = 0; i < MAX_NR_ZONELISTS; i++) {
 		struct zonelist *zonelist;
 
 		zonelist = pgdat->node_zonelists + i;
-		memset(zonelist, 0, sizeof(*zonelist));
+		/* memset(zonelist, 0, sizeof(*zonelist)); */
 
 		j = 0;
 		k = ZONE_NORMAL;
-		if (i & __GFP_HIGHMEM)
+		hotremovable = 0;
+		switch (i) {
+		default:
+			BUG();
+			return;
+		case 0:
+			k = ZONE_NORMAL;
+			break;
+		case __GFP_HIGHMEM:
 			k = ZONE_HIGHMEM;
-		if (i & __GFP_DMA)
+			break;
+		case __GFP_DMA:
 			k = ZONE_DMA;
+			break;
+		case __GFP_HOTREMOVABLE:
+#ifdef CONFIG_MEMHOTPLUG
+			k = ZONE_HIGHMEM;
+#else
+			k = ZONE_HOTREMOVABLE;
+#endif
+			hotremovable = 1;
+			break;
+		}
 
+#ifndef CONFIG_MEMHOTPLUG
  		j = build_zonelists_node(pgdat, zonelist, j, k);
  		/*
  		 * Now we build the zonelist so that it contains the zones
@@ -1335,19 +1377,54 @@ static void __init build_zonelists(pg_da
  			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
  		for (node = 0; node < local_node; node++)
  			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
- 
-		zonelist->zones[j] = NULL;
-	}
+#else
+		while (hotremovable >= 0) {
+			for(; k >= 0; k--) {
+				zone = pgdat->node_zones + k;
+				for (node = local_node; ;) {
+					if (NODE_DATA(node) == NULL ||
+					    !NODE_DATA(node)->enabled ||
+					    (!!NODE_DATA(node)->removable) !=
+					    (!!hotremovable))
+						goto next;
+					zone = NODE_DATA(node)->node_zones + k;
+					if (zone->present_pages)
+						zonelist->zones[j++] = zone;
+				next:
+					node = (node + 1) % numnodes;
+					if (node == local_node)
+						break;
+				}
+			}
+			if (hotremovable) {
+				/* place non-hotremovable after hotremovable */
+				k = ZONE_HIGHMEM;
+			}
+			hotremovable--;
+		}
+#endif
+		BUG_ON(j > sizeof(zonelist->zones) /
+		    sizeof(zonelist->zones[0]) - 1);
+		for(; j < sizeof(zonelist->zones) /
+		    sizeof(zonelist->zones[0]); j++)
+			zonelist->zones[j] = NULL;
+  	} 
 }
 
 #endif	/* CONFIG_NUMA */
 
-void __init build_all_zonelists(void)
+#ifdef CONFIG_MEMHOTPLUG
+void
+#else
+void __init
+#endif
+build_all_zonelists(void)
 {
 	int i;
 
 	for(i = 0 ; i < numnodes ; i++)
-		build_zonelists(NODE_DATA(i));
+		if (NODE_DATA(i) != NULL)
+			build_zonelists(NODE_DATA(i));
 	printk("Built %i zonelists\n", numnodes);
 }
 
@@ -1419,7 +1496,7 @@ static void __init calculate_zone_totalp
  * up by free_all_bootmem() once the early boot process is
  * done. Non-atomic initialization, single-pass.
  */
-void __init memmap_init_zone(struct page *start, unsigned long size, int nid,
+void memmap_init_zone(struct page *start, unsigned long size, int nid,
 		unsigned long zone, unsigned long start_pfn)
 {
 	struct page *page;
@@ -1457,10 +1534,13 @@ static void __init free_area_init_core(s
 	int cpu, nid = pgdat->node_id;
 	struct page *lmem_map = pgdat->node_mem_map;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
+#ifdef CONFIG_MEMHOTPLUG
+	int cold = !nid;
+#endif	
 
 	pgdat->nr_zones = 0;
 	init_waitqueue_head(&pgdat->kswapd_wait);
-	
+
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, realsize;
@@ -1530,6 +1610,13 @@ static void __init free_area_init_core(s
 		zone->wait_table_size = wait_table_size(size);
 		zone->wait_table_bits =
 			wait_table_bits(zone->wait_table_size);
+#ifdef CONFIG_MEMHOTPLUG
+		if (!cold)
+			zone->wait_table = (wait_queue_head_t *)
+				kmalloc(zone->wait_table_size
+				* sizeof(wait_queue_head_t), GFP_KERNEL);
+		else
+#endif
 		zone->wait_table = (wait_queue_head_t *)
 			alloc_bootmem_node(pgdat, zone->wait_table_size
 						* sizeof(wait_queue_head_t));
@@ -1584,6 +1671,13 @@ static void __init free_area_init_core(s
 			 */
 			bitmap_size = (size-1) >> (i+4);
 			bitmap_size = LONG_ALIGN(bitmap_size+1);
+#ifdef CONFIG_MEMHOTPLUG
+			if (!cold) {
+			zone->free_area[i].map = 
+			  (unsigned long *)kmalloc(bitmap_size, GFP_KERNEL);
+			memset(zone->free_area[i].map, 0, bitmap_size);
+			} else
+#endif
 			zone->free_area[i].map = 
 			  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
 		}
@@ -1901,7 +1995,7 @@ static void setup_per_zone_protection(vo
  *	that the pages_{min,low,high} values for each zone are set correctly 
  *	with respect to min_free_kbytes.
  */
-static void setup_per_zone_pages_min(void)
+void setup_per_zone_pages_min(void)
 {
 	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
 	unsigned long lowmem_pages = 0;
--- linux-2.6.7.ORG/mm/rmap.c	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/mm/rmap.c	Sat Jul 10 19:37:22 2032
@@ -30,6 +30,7 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/memhotplug.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/rmap.h>
@@ -421,7 +422,8 @@ void page_remove_rmap(struct page *page)
  * Subfunctions of try_to_unmap: try_to_unmap_one called
  * repeatedly from either try_to_unmap_anon or try_to_unmap_file.
  */
-static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma)
+static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
+    struct list_head *force)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -429,6 +431,9 @@ static int try_to_unmap_one(struct page 
 	pmd_t *pmd;
 	pte_t *pte;
 	pte_t pteval;
+#ifdef CONFIG_MEMHOTPLUG
+	struct page_va_list *vlist;
+#endif
 	int ret = SWAP_AGAIN;
 
 	if (!mm->rss)
@@ -466,8 +471,22 @@ static int try_to_unmap_one(struct page 
 	 */
 	if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED)) ||
 			ptep_test_and_clear_young(pte)) {
-		ret = SWAP_FAIL;
-		goto out_unmap;
+		if (force == NULL || vma->vm_flags & VM_RESERVED) {
+			ret = SWAP_FAIL;
+			goto out_unmap;
+		}
+#ifdef CONFIG_MEMHOTPLUG
+		vlist = kmalloc(sizeof(struct page_va_list), GFP_KERNEL);
+		atomic_inc(&mm->mm_count);
+		vlist->mm = mmgrab(mm);
+		if (vlist->mm == NULL) {
+			mmdrop(mm);
+			kfree(vlist);
+		} else {
+			vlist->addr = address;
+			list_add(&vlist->list, force);
+		}
+#endif
 	}
 
 	/*
@@ -620,7 +639,7 @@ out_unlock:
 	return SWAP_AGAIN;
 }
 
-static inline int try_to_unmap_anon(struct page *page)
+static inline int try_to_unmap_anon(struct page *page, struct list_head *force)
 {
 	struct anon_vma *anon_vma = (struct anon_vma *) page->mapping;
 	struct vm_area_struct *vma;
@@ -629,7 +648,7 @@ static inline int try_to_unmap_anon(stru
 	spin_lock(&anon_vma->lock);
 	BUG_ON(list_empty(&anon_vma->head));
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
-		ret = try_to_unmap_one(page, vma);
+		ret = try_to_unmap_one(page, vma, force);
 		if (ret == SWAP_FAIL || !page->mapcount)
 			break;
 	}
@@ -649,7 +668,7 @@ static inline int try_to_unmap_anon(stru
  * The spinlock address_space->i_mmap_lock is tried.  If it can't be gotten,
  * return a temporary error.
  */
-static inline int try_to_unmap_file(struct page *page)
+static inline int try_to_unmap_file(struct page *page, struct list_head *force)
 {
 	struct address_space *mapping = page->mapping;
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
@@ -666,7 +685,7 @@ static inline int try_to_unmap_file(stru
 
 	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap,
 					&iter, pgoff, pgoff)) != NULL) {
-		ret = try_to_unmap_one(page, vma);
+		ret = try_to_unmap_one(page, vma, force);
 		if (ret == SWAP_FAIL || !page->mapcount)
 			goto out;
 	}
@@ -760,7 +779,7 @@ out:
  * SWAP_AGAIN	- we missed a trylock, try again later
  * SWAP_FAIL	- the page is unswappable
  */
-int try_to_unmap(struct page *page)
+int try_to_unmap(struct page *page, struct list_head *force)
 {
 	int ret;
 
@@ -769,9 +788,9 @@ int try_to_unmap(struct page *page)
 	BUG_ON(!page->mapcount);
 
 	if (PageAnon(page))
-		ret = try_to_unmap_anon(page);
+		ret = try_to_unmap_anon(page, force);
 	else
-		ret = try_to_unmap_file(page);
+		ret = try_to_unmap_file(page, force);
 
 	if (!page->mapcount) {
 		if (page_test_and_clear_dirty(page))
--- linux-2.6.7.ORG/mm/swapfile.c	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/mm/swapfile.c	Sat Jul 10 19:37:22 2032
@@ -662,6 +662,7 @@ static int try_to_unuse(unsigned int typ
 		 */
 		swap_map = &si->swap_map[i];
 		entry = swp_entry(type, i);
+	again:
 		page = read_swap_cache_async(entry, NULL, 0);
 		if (!page) {
 			/*
@@ -696,6 +697,11 @@ static int try_to_unuse(unsigned int typ
 		wait_on_page_locked(page);
 		wait_on_page_writeback(page);
 		lock_page(page);
+		if (PageAgain(page)) {
+			unlock_page(page);
+			page_cache_release(page);
+			goto again;
+		}
 		wait_on_page_writeback(page);
 
 		/*
@@ -804,6 +810,7 @@ static int try_to_unuse(unsigned int typ
 
 			swap_writepage(page, &wbc);
 			lock_page(page);
+			BUG_ON(PageAgain(page));
 			wait_on_page_writeback(page);
 		}
 		if (PageSwapCache(page)) {
--- linux-2.6.7.ORG/mm/truncate.c	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/mm/truncate.c	Sat Jul 10 19:37:22 2032
@@ -132,6 +132,8 @@ void truncate_inode_pages(struct address
 			next++;
 			if (TestSetPageLocked(page))
 				continue;
+			/* no PageAgain(page) check; page->mapping check
+			 * is done in truncate_complete_page */
 			if (PageWriteback(page)) {
 				unlock_page(page);
 				continue;
@@ -165,6 +167,24 @@ void truncate_inode_pages(struct address
 			struct page *page = pvec.pages[i];
 
 			lock_page(page);
+			if (page->mapping == NULL) {
+				/* XXX Is page->index still valid? */
+				unsigned long index = page->index;
+				int again = PageAgain(page);
+
+				unlock_page(page);
+				put_page(page);
+				page = find_lock_page(mapping, index);
+				if (page == NULL) {
+					BUG_ON(again);
+					/* XXX */
+					if (page->index > next)
+						next = page->index;
+					next++;
+				}
+				BUG_ON(!again);
+				pvec.pages[i] = page;
+			}
 			wait_on_page_writeback(page);
 			if (page->index > next)
 				next = page->index;
@@ -257,14 +277,29 @@ void invalidate_inode_pages2(struct addr
 			struct page *page = pvec.pages[i];
 
 			lock_page(page);
-			if (page->mapping == mapping) {	/* truncate race? */
-				wait_on_page_writeback(page);
-				next = page->index + 1;
-				if (page_mapped(page))
-					clear_page_dirty(page);
-				else
-					invalidate_complete_page(mapping, page);
+			while (page->mapping != mapping) {
+				struct page *newpage;
+				unsigned long index = page->index;
+
+				BUG_ON(page->mapping != NULL);
+
+				unlock_page(page);
+				newpage = find_lock_page(mapping, index);
+				if (page == newpage) {
+					put_page(page);
+					break;
+				}
+				BUG_ON(!PageAgain(page));
+				pvec.pages[i] = newpage;
+				put_page(page);
+				page = newpage;
 			}
+			wait_on_page_writeback(page);
+			next = page->index + 1;
+			if (page_mapped(page))
+				clear_page_dirty(page);
+			else
+				invalidate_complete_page(mapping, page);
 			unlock_page(page);
 		}
 		pagevec_release(&pvec);
--- linux-2.6.7.ORG/mm/vmscan.c	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/mm/vmscan.c	Sat Jul 10 19:37:22 2032
@@ -32,6 +32,7 @@
 #include <linux/topology.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
+#include <linux/kthread.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -387,7 +388,7 @@ static int shrink_list(struct list_head 
 		 * processes. Try to unmap it here.
 		 */
 		if (page_mapped(page) && mapping) {
-			switch (try_to_unmap(page)) {
+			switch (try_to_unmap(page, NULL)) {
 			case SWAP_FAIL:
 				page_map_unlock(page);
 				goto activate_locked;
@@ -1091,6 +1092,8 @@ int kswapd(void *p)
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_FREEZE);
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
+		if (kthread_should_stop())
+			return 0;
 		schedule();
 		finish_wait(&pgdat->kswapd_wait, &wait);
 
@@ -1173,5 +1176,15 @@ static int __init kswapd_init(void)
 	hotcpu_notifier(cpu_callback, 0);
 	return 0;
 }
+
+#ifdef CONFIG_MEMHOTPLUG
+void
+kswapd_start_one(pg_data_t *pgdat)
+{
+	pgdat->kswapd = kthread_create(kswapd, pgdat, "kswapd%d",
+	    pgdat->node_id);
+	total_memory = nr_free_pagecache_pages();
+}
+#endif
 
 module_init(kswapd_init)
--- linux-2.6.7.ORG/include/linux/memhotplug.h	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/include/linux/memhotplug.h	Sun Jul 11 10:11:51 2032
@@ -0,0 +1,32 @@
+#ifndef _LINUX_MEMHOTPLUG_H
+#define _LINUX_MEMHOTPLUG_H
+
+#include <linux/config.h>
+#include <linux/mm.h>
+
+#ifdef __KERNEL__
+
+struct page_va_list {
+	struct mm_struct *mm;
+	unsigned long addr;
+	struct list_head list;
+};
+
+struct mmigrate_operations {
+	struct page * (*mmigrate_alloc_page)(int);
+	int (*mmigrate_free_page)(struct page *);
+	int (*mmigrate_copy_page)(struct page *, struct page *);
+	int (*mmigrate_lru_add_page)(struct page *, int);
+	int (*mmigrate_release_buffers)(struct page *);
+	int (*mmigrate_prepare)(struct page *page, int fastmode);
+	int (*mmigrate_stick_page)(struct list_head *vlist);
+};
+
+extern int mmigrated(void *p);
+extern int mmigrate_onepage(struct page *, int, int, struct mmigrate_operations *);
+extern int try_to_migrate_pages(struct zone *, int, struct page * (*)(struct zone *, void *), void *);
+
+#define MIGRATE_ANYNODE  (-1)
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_MEMHOTPLUG_H */
--- linux-2.6.7.ORG/mm/memhotplug.c	Sun Jul 11 10:05:04 2032
+++ linux-2.6.7/mm/memhotplug.c	Sun Jul 11 10:12:48 2032
@@ -0,0 +1,817 @@
+/*
+ *  linux/mm/memhotplug.c
+ *
+ *  Support of memory hotplug
+ *
+ *  Authors:	Toshihiro Iwamoto, <iwamoto@valinux.co.jp>
+ *		Hirokazu Takahashi, <taka@valinux.co.jp>
+ */
+
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/swap.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/highmem.h>
+#include <linux/writeback.h>
+#include <linux/buffer_head.h>
+#include <linux/mm_inline.h>
+#include <linux/rmap.h>
+#include <linux/memhotplug.h>
+
+#ifdef CONFIG_KDB
+#include <linux/kdb.h>
+#endif
+
+/*
+ * The following flow is a way to migrate a oldpage.
+ *  1. allocate a newpage.
+ *  2. lock the newpage and don't set PG_uptodate flag on it.
+ *  3. modify the oldpage entry in the corresponding radix tree with the
+ *     newpage.
+ *  4. clear all PTEs that refer to the oldpage.
+ *  5. wait until all references on the oldpage have gone.
+ *  6. copy from the oldpage to the newpage.
+ *  7. set PG_uptodate flag of the newpage.
+ *  8. release the oldpage.
+ *  9. unlock the newpage and wakeup all waiters.
+ *
+ *
+ *   adress_space                  oldpage
+ *   +-----------+               +---------+
+ *   |           |               |         |        +-----+
+ *   | page_tree------+  -- X -->|         |<-- X --| PTE |.....
+ *   |           |    |          |PG_uptodate       +-----+
+ *   |           |    |          +---------+           :
+ *   +-----------+    |                                :
+ *                    |            newpage         pagefaults
+ *                    |          +---------+           :
+ *                    +--------->|PG_locked|   ........:
+ *                               |         | Blocked
+ *                               |         |   ...........system calls
+ *                               +---------+
+ *
+ *
+ * The key point is to block accesses to the page under operation by
+ * modifying the radix tree. After the radix tree has been modified, no new
+ * access goes to the oldpage.  They will be redirected to the newpage which 
+ * will be blocked until the data is ready because it is locked and not
+ * up to date. Remember that dropping PG_uptodate is important to block
+ * all read accesses, including system call accesses and page fault accesses.
+ *
+ * By this aproach, pages in the swapcache are handled in the same way as
+ * pages in the pagecache are since both pages are on radix trees.
+ * And any kind of pages in the pagecache can be migrated even if they
+ * are not assoiciated with backing store like pages in sysfs, in ramdisk
+ * and so on. We can migrate all pages on the LRU in the same way.
+ */
+
+
+static void
+print_buffer(struct page* page)
+{
+	struct address_space* mapping = page_mapping(page);
+	struct buffer_head *bh, *head;
+
+	spin_lock(&mapping->private_lock);
+	bh = head = page_buffers(page);
+	printk("buffers:");
+	do {
+		printk(" %lx %d", bh->b_state, atomic_read(&bh->b_count));
+
+		bh = bh->b_this_page;
+	} while (bh != head);
+	printk("\n");
+	spin_unlock(&mapping->private_lock);
+}
+
+/*
+ * Make pages on the "vlist" mapped or they may be freed
+ * though there are mlocked.
+ */
+static int
+stick_mlocked_page(struct list_head *vlist)
+{
+	struct page_va_list *v1, *v2;
+	struct vm_area_struct *vma;
+	int error;
+
+	list_for_each_entry_safe(v1, v2, vlist, list) {
+		list_del(&v1->list);
+		down_read(&v1->mm->mmap_sem);
+		vma = find_vma(v1->mm, v1->addr);
+		if (vma == NULL || !(vma->vm_flags & VM_LOCKED))
+			goto out;
+		error = get_user_pages(current, v1->mm, v1->addr, PAGE_SIZE,
+		    (vma->vm_flags & VM_WRITE) != 0, 0, NULL, NULL);
+	out:
+		up_read(&v1->mm->mmap_sem);
+		mmput(v1->mm);
+		kfree(v1);
+	}
+	return 0;
+}
+
+/* helper function for mmigrate_onepage */
+#define	REMAPPREP_WB		1
+#define	REMAPPREP_BUFFER	2
+
+/*
+ * Try to free buffers if "page" has them.
+ * 
+ * TODO:
+ * 	It would be possible to migrate a page without pageout
+ *	if a address_space had a page migration method.
+ */
+static int
+mmigrate_preparepage(struct page *page, int fastmode)
+{
+	struct address_space *mapping;
+	int waitcnt = fastmode ? 0 : 100;
+	int res = -REMAPPREP_BUFFER;
+
+	BUG_ON(!PageLocked(page));
+
+	mapping = page_mapping(page);
+
+	if (!PagePrivate(page) && PageWriteback(page) &&
+	    !PageSwapCache(page)) {
+		printk("mmigrate_preparepage: mapping %p page %p\n",
+		    page->mapping, page);
+		return -REMAPPREP_WB;
+	}
+
+	/*
+	 * TODO: wait_on_page_writeback() would be better if it supports
+	 *       timeout.
+	 */
+	while (PageWriteback(page)) {
+		if (!waitcnt)
+			return -REMAPPREP_WB;
+		__set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(10);
+		__set_current_state(TASK_RUNNING);
+		waitcnt--;
+	}
+	if (PagePrivate(page)) {
+		if (PageDirty(page)) {
+			switch(pageout(page, mapping)) {
+			case PAGE_ACTIVATE:
+				res = -REMAPPREP_WB;
+				waitcnt = 1;
+			case PAGE_KEEP:
+			case PAGE_CLEAN:
+				break;
+			case PAGE_SUCCESS:
+				lock_page(page);
+				mapping = page_mapping(page);
+				if (!PagePrivate(page))
+					return 0;
+			}
+		}
+
+		while (1) {
+			if (try_to_release_page(page, GFP_KERNEL))
+				break;
+			if (!waitcnt)
+				return res;
+			__set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(10);
+			__set_current_state(TASK_RUNNING);
+			waitcnt--;
+			if (!waitcnt)
+				print_buffer(page);
+		}
+	}
+	return 0;
+}
+
+/*
+ * Assign a swap entry to an anonymous page if it doesn't have yet,
+ * so that it can be handled like one in the page cache.
+ */
+static struct address_space *
+make_page_mapped(struct page *page)
+{
+	if (!page_mapped(page)) {
+		if (page_count(page) > 1)
+			printk("page %p not mapped: count %d\n",
+			    page, page_count(page));
+		return NULL;
+	}
+	/* The page is an anon page.  Allocate its swap entry. */
+	page_map_unlock(page);
+	add_to_swap(page);
+	page_map_lock(page);
+	return page_mapping(page);
+}
+
+/*
+ * Replace "page" with "newpage" on the radix tree.  After that, all
+ * new access to "page" will be redirected to "newpage" and it
+ * will be blocked until migrating has been done.
+ */
+static int
+radix_tree_replace_pages(struct page *page, struct page *newpage,
+			 struct address_space *mapping)
+{
+	if (radix_tree_preload(GFP_KERNEL))
+		return -1;
+
+	if (PagePrivate(page)) /* XXX */
+		BUG();
+
+	/* should {__add_to,__remove_from}_page_cache be used instead? */
+	spin_lock_irq(&mapping->tree_lock);
+	if (mapping != page_mapping(page))
+		printk("mapping changed %p -> %p, page %p\n",
+		    mapping, page_mapping(page), page);
+	if (radix_tree_delete(&mapping->page_tree, page_index(page)) == NULL) {
+		/* Page truncated. */
+		spin_unlock_irq(&mapping->tree_lock);
+		radix_tree_preload_end();
+		return -1;
+	}
+	/* Don't __put_page(page) here.  Truncate may be in progress. */
+	newpage->flags |= page->flags & ~(1 << PG_uptodate) &
+	    ~(1 << PG_highmem) & ~(1 << PG_anon) &
+	    ~(1 << PG_maplock) &
+	    ~(1 << PG_active) & ~(~0UL << NODEZONE_SHIFT);
+
+	radix_tree_insert(&mapping->page_tree, page_index(page), newpage);
+	page_cache_get(newpage);
+	newpage->index = page->index;
+	if  (PageSwapCache(page))
+		newpage->private = page->private;
+	else
+		newpage->mapping = page->mapping;
+	spin_unlock_irq(&mapping->tree_lock);
+	radix_tree_preload_end();
+	return 0;
+}
+
+/*
+ * Remove all PTE mappings to "page".
+ */
+static int
+unmap_page(struct page *page, struct list_head *vlist)
+{
+	int error = SWAP_SUCCESS;
+
+	page_map_lock(page);
+	while (page_mapped(page) &&
+	    (error = try_to_unmap(page, vlist)) == SWAP_AGAIN) {
+		/*
+		 * There may be race condition, just wait for a while
+		 */
+		page_map_unlock(page);
+		__set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(1);
+		__set_current_state(TASK_RUNNING);
+		page_map_lock(page);
+	}
+	page_map_unlock(page);
+	if (error == SWAP_FAIL) {
+		/* either during mremap or mlocked */
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * Wait for "page" to become free.  Usually this function waits until
+ * the page count drops to 2.  For a truncated page, it waits until
+ * the count drops to 1.
+ * Returns: 0 on success, 1 on page truncation, -1 on error.
+ */
+static int
+wait_on_page_freeable(struct page *page, struct address_space *mapping,
+			struct list_head *vlist, unsigned long index,
+			int nretry, struct mmigrate_operations *ops)
+{
+	struct address_space *mapping1;
+	void *p;
+	int truncated = 0;
+wait_again:
+	while ((truncated + page_count(page)) > 2) {
+		if (nretry <= 0)
+			return -1;
+		/*
+		 * No lock needed while waiting page count.
+		 * Yield CPU to other accesses which may have to lock the
+		 * page to proceed.
+		 */
+		unlock_page(page);
+
+		/*
+		 * Wait until all references has gone.
+		 */
+		while ((truncated + page_count(page)) > 2) {
+			nretry--;
+			current->state = TASK_INTERRUPTIBLE;
+			schedule_timeout(1);
+			if ((nretry % 5000) == 0) {
+				printk("mmigrate_onepage: still waiting on %p %d\n", page, nretry);
+				break;
+			}
+			/*
+			 * Another remaining access to the page may reassign
+			 * buffers or make it mapped again.
+			 */
+			if (PagePrivate(page) || page_mapped(page))
+				break;		/* see below */
+		}
+
+		lock_page(page);
+		BUG_ON(page_count(page) == 0);
+		mapping1 = page_mapping(page);
+		if (mapping != mapping1 && mapping1 != NULL)
+			printk("mapping changed %p -> %p, page %p\n",
+			    mapping, mapping1, page);
+
+		/*
+		 * Free buffers of the page which may have been
+		 * reassigned.
+		 */
+		if (PagePrivate(page))
+			ops->mmigrate_release_buffers(page);
+
+		/*
+		 * Clear all PTE mappings to the page as it may have
+		 * been mapped again.
+		 */
+		unmap_page(page, vlist);
+	}
+	if (PageReclaim(page) || PageWriteback(page) || PagePrivate(page))
+#ifdef CONFIG_KDB
+		KDB_ENTER();
+#else
+		BUG();
+#endif
+	if (page_count(page) == 1)
+		/* page has been truncated. */
+		return 1;
+	spin_lock_irq(&mapping->tree_lock);
+	p = radix_tree_lookup(&mapping->page_tree, index);
+	spin_unlock_irq(&mapping->tree_lock);
+	if (p == NULL) {
+		BUG_ON(page->mapping != NULL);
+		truncated = 1;
+		BUG_ON(page_mapping(page) != NULL);
+		goto wait_again;
+	}
+	
+	return 0;
+}
+
+/*
+ * A file which "page" belongs to has been truncated.  Free both pages.
+ */
+static void
+free_truncated_pages(struct page *page, struct page *newpage,
+			 struct address_space *mapping)
+{
+	void *p;
+	BUG_ON(page_mapping(page) != NULL);
+	put_page(newpage);
+	if (page_count(newpage) != 1) {
+		printk("newpage count %d != 1, %p\n",
+		    page_count(newpage), newpage);
+		BUG();
+	}
+	newpage->mapping = page->mapping = NULL;
+	ClearPageActive(page);
+	ClearPageActive(newpage);
+	ClearPageSwapCache(page);
+	ClearPageSwapCache(newpage);
+	unlock_page(page);
+	unlock_page(newpage);
+	put_page(newpage);
+}
+
+/*
+ * Roll back a page migration.
+ *
+ * In some cases, a page migration needs to be rolled back and to
+ * be retried later. This is a bit tricky because it is likely that some
+ * processes have already looked up the radix tree and waiting for its
+ * lock. Such processes need to discard a newpage and look up the radix
+ * tree again, as the newpage is now invalid.
+ * A new page flag (PG_again) is used for that purpose.
+ *
+ *   1. Roll back the radix tree change.
+ *   2. Set PG_again flag of the newpage and unlock it.
+ *   3. Woken up processes see the PG_again bit and looks up the radix
+ *      tree again.
+ *   4. Wait until the page count of the newpage falls to 1 (for the
+ *      migrated process).
+ *   5. Roll back is complete. the newpage can be freed.
+ */
+static int
+radix_tree_rewind_page(struct page *page, struct page *newpage,
+		 struct address_space *mapping)
+{
+	int waitcnt;
+	pgoff_t index;
+
+	/*
+	 * Try to unwind by notifying waiters.  If someone misbehaves,
+	 * we die.
+	 */
+	if (radix_tree_preload(GFP_KERNEL))
+		BUG();
+	/* should {__add_to,__remove_from}_page_cache be used instead? */
+	spin_lock_irq(&mapping->tree_lock);
+	index = page_index(page);
+	if (radix_tree_delete(&mapping->page_tree, index) == NULL)
+		/* Hold extra count to handle truncate */
+		page_cache_get(newpage);
+	radix_tree_insert(&mapping->page_tree, index, page);
+	/* no page_cache_get(page); needed */
+	spin_unlock_irq(&mapping->tree_lock);
+	radix_tree_preload_end();
+
+	/*
+	 * PG_again flag notifies waiters that this newpage isn't what
+	 * the waiters expect.
+	 */
+	SetPageAgain(newpage);
+	newpage->mapping = NULL;
+	/* XXX unmap needed?  No, it shouldn't.  Handled by fault handlers. */
+	unlock_page(newpage);
+
+	/*
+	 *  Some accesses may be blocked on the newpage. Wait until the
+	 *  accesses has gone.
+	 */ 
+	waitcnt = HZ;
+	for(; page_count(newpage) > 2; waitcnt--) {
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(10);
+		if (waitcnt == 0) {
+			printk("You are hosed.\n");
+			printk("newpage %p flags %lx %d %d, page %p flags %lx %d\n",
+			    newpage, newpage->flags, page_count(newpage),
+			    newpage->mapcount,
+			    page, page->flags, page_count(page));
+			BUG();
+		}
+	}
+
+	BUG_ON(PageUptodate(newpage));
+	ClearPageDirty(newpage);
+	ClearPageActive(newpage);
+	spin_lock_irq(&mapping->tree_lock);
+	if (page_count(newpage) == 1) {
+		printk("newpage %p truncated. page %p\n", newpage, page);
+		BUG();
+	}
+	spin_unlock_irq(&mapping->tree_lock);
+	unlock_page(page);
+	BUG_ON(page_count(newpage) != 2);
+	ClearPageAgain(newpage);
+	__put_page(newpage);
+	return 1;
+}
+
+/*
+ * Allocate a new page from a specified node.
+ */
+static struct page *
+mmigrate_alloc_page(int nid)
+{
+	if (nid == MIGRATE_ANYNODE)
+		return alloc_page(GFP_HIGHUSER);
+	else
+		return alloc_pages_node(nid, GFP_HIGHUSER, 0);
+}
+
+/*
+ * Release "page" into the Buddy allocator.
+ */
+static int
+mmigrate_free_page(struct page *page)
+{
+	BUG_ON(page_count(page) != 1);
+	put_page(page);
+	return 0;
+}
+
+/*
+ * Copy data from "from" to "to".
+ */
+static int
+mmigrate_copy_page(struct page *to, struct page *from)
+{
+	copy_highpage(to, from);
+	return 0;
+}
+
+/*
+ * Insert "page" into the LRU.
+ */
+static int
+mmigrate_lru_add_page(struct page *page, int active)
+{
+	if (active)
+		lru_cache_add_active(page);
+	else
+		lru_cache_add(page);
+	return 0;
+}
+
+static int
+mmigrate_release_buffer(struct page *page)
+{
+	try_to_release_page(page, GFP_KERNEL);
+	return 0;
+}
+
+/*
+ * This is a migrate-operations for regular pages which include
+ * anonymous pages, pages in the pagecache and pages in the swapcache.
+ */
+static struct mmigrate_operations mmigrate_ops = {
+	.mmigrate_alloc_page	= mmigrate_alloc_page,
+        .mmigrate_free_page	= mmigrate_free_page,
+        .mmigrate_copy_page	= mmigrate_copy_page,
+        .mmigrate_lru_add_page	= mmigrate_lru_add_page,
+        .mmigrate_release_buffers = mmigrate_release_buffer,
+        .mmigrate_prepare	= mmigrate_preparepage,
+        .mmigrate_stick_page	= stick_mlocked_page
+};
+
+/*
+ * Try to migrate one page.  Returns non-zero on failure.
+ */
+int mmigrate_onepage(struct page *page, int nodeid, int fastmode,
+				struct mmigrate_operations *ops)
+{
+	struct page *newpage;
+	struct address_space *mapping;
+	LIST_HEAD(vlist);
+	int nretry = fastmode ? HZ/50: HZ*10; /* XXXX */
+
+	if ((newpage = ops->mmigrate_alloc_page(nodeid)) == NULL)
+		return -ENOMEM;
+
+	/*
+	 * Make sure that the newpage must be locked and keep not up-to-date
+	 * during the page migration, so that it's guaranteed that all
+	 * accesses including read accesses to the newpage will be blocked
+	 * until everything has become ok.
+	 *
+	 * Unlike in the case of swapout mechanism, all accesses which include
+	 * read accesses and write accesses to the page have to be blocked
+	 * since both of the oldpage and the newpage exist at the same time
+	 * and the newpage contains invalid data while some rereferences
+	 * of the oldpage remain.
+	 *
+	 * FYI, swap code allows read accesses during swaping as the
+	 * content of the page is valid and it will never be freed
+	 * while some references of it exist. And write access is also
+	 * possible during swapping, it will pull the page back and
+	 * modify them even if it's under I/O.
+	 */
+	if (TestSetPageLocked(newpage))
+		BUG();
+
+	lock_page(page);
+
+	if (ops->mmigrate_prepare && ops->mmigrate_prepare(page, fastmode))
+		goto radixfail;
+
+	/*
+	 * Put the page in a radix tree if it isn't in the tree yet,
+	 * so that all pages can be handled on radix trees and move
+	 * them in the same way.
+	 */
+	page_map_lock(page);
+	if (PageAnon(page) && !PageSwapCache(page))
+		make_page_mapped(page);
+	mapping = page_mapping(page);
+	page_map_unlock(page);
+
+	if (mapping == NULL)
+		goto radixfail;
+
+	/*
+	 * Replace the oldpage with the newpage in the radix tree,
+	 * after that the newpage can catch all access requests to the
+	 * oldpage instead.
+	 * 
+	 * We cannot leave the oldpage locked in the radix tree because:
+	 *   - It cannot block read access if PG_uptodate is on. PG_uptodate
+	 *     flag cannot be off since it means data in the page is invalid.
+	 *   - Some accesses cannot be finished if someone is holding the
+	 *     lock as they may require the lock to handle the oldpage.
+	 *   - It's hard to determine when the page can be freed if there
+	 *     remain references to the oldpage.
+	 */
+	if (radix_tree_replace_pages(page, newpage, mapping))
+		goto radixfail;
+
+	/*
+	 * With cleared PTEs, any access via PTEs to the oldpages can
+	 * be caught and blocked in a pagefault handler.
+	 */
+	if (unmap_page(page, &vlist))
+		goto unmapfail;
+	if (PagePrivate(page))
+		printk("buffer reappeared\n");
+
+	/*
+	 * We can't proceed if there remain some references on the oldpage.
+	 * 
+	 * This code may sometimes fail because:
+	 *     A page may be grabed twice in the same transaction. During
+	 *     the page migration, the transaction which already have got
+	 *     the oldpage try to grab the newpage, this causes a dead lock.
+	 *
+	 *     The transaction believes both pages are the same, but an access
+	 *     to the newpage is blocked until the oldpage is released.
+	 *
+	 *     Renaming a file in the same directory is a good example.
+	 *     It grabs the same page for the directory twice.
+	 *
+	 *     In this case, try to migrate the page later.
+	 */
+	switch (wait_on_page_freeable(page, mapping, &vlist, page_index(newpage), nretry, ops)) {
+	case 1:
+		/* truncated */
+		free_truncated_pages(page, newpage, mapping);
+		ops->mmigrate_free_page(page);
+		return 0;
+	case -1:
+		/* failed */
+		goto unmapfail;
+	}
+	
+	BUG_ON(mapping != page_mapping(page));
+
+	ops->mmigrate_copy_page(newpage, page);
+
+	if (PageDirty(page))
+		set_page_dirty(newpage);
+	page->mapping = NULL;
+	unlock_page(page);
+	__put_page(page);
+
+	/*
+	 * Finally, the newpage has become ready!
+	 */
+	SetPageUptodate(newpage);
+
+	if (ops->mmigrate_lru_add_page)
+		ops->mmigrate_lru_add_page(newpage, PageActive(page));
+	ClearPageActive(page);
+	ClearPageSwapCache(page);
+
+	ops->mmigrate_free_page(page);
+
+	/*
+ 	 * Wake up all waiters which have been waiting for completion
+	 * of the page migration.
+	 */
+	unlock_page(newpage);
+
+	/*
+	 * Mlock the newpage if the oldpage had been mlocked.
+	 */
+	if (ops->mmigrate_stick_page)
+		ops->mmigrate_stick_page(&vlist);
+	page_cache_release(newpage);
+	return 0;
+
+unmapfail:
+	/*
+	 * Roll back all operations.
+	 */
+	radix_tree_rewind_page(page, newpage, mapping);
+	if (ops->mmigrate_stick_page)
+		ops->mmigrate_stick_page(&vlist);
+	ClearPageActive(newpage);
+	ClearPageSwapCache(newpage);
+	ops->mmigrate_free_page(newpage);
+	return 1;
+
+radixfail:
+	unlock_page(page);
+	unlock_page(newpage);
+	if (ops->mmigrate_stick_page)
+		ops->mmigrate_stick_page(&vlist);
+	ops->mmigrate_free_page(newpage);
+	return 1;
+}
+
+static struct work_struct lru_drain_wq[NR_CPUS];
+static void
+lru_drain_schedule(void *p)
+{
+	int cpu = get_cpu();
+
+	schedule_work(&lru_drain_wq[cpu]);
+	put_cpu();
+}
+
+/*
+ * Find an appropriate page to be migrated on the LRU lists.
+ */
+
+static struct page *
+get_target_page(struct zone *zone, void *arg)
+{
+	struct page *page, *page2;
+	list_for_each_entry_safe(page, page2, &zone->inactive_list, lru) {
+		if (steal_page_from_lru(zone, page) == NULL)
+			continue;
+		return page;
+	}
+	list_for_each_entry_safe(page, page2, &zone->active_list, lru) {
+		if (steal_page_from_lru(zone, page) == NULL)
+			continue;
+		return page;
+	}
+	return NULL;
+}
+
+int try_to_migrate_pages(struct zone *zone, int destnode,
+		struct page * (*func)(struct zone *, void *), void *arg)
+{
+	struct page *page, *page2;
+	int nr_failed = 0;
+	LIST_HEAD(failedp);
+
+	while(nr_failed < 100) {
+		spin_lock_irq(&zone->lru_lock);
+		page = (*func)(zone, arg);
+		spin_unlock_irq(&zone->lru_lock);
+		if (page == NULL)
+			break;
+		if (PageLocked(page) ||
+		    mmigrate_onepage(page, destnode, 1, &mmigrate_ops)) {
+			nr_failed++;
+			list_add(&page->lru, &failedp);
+		}
+	}
+
+	nr_failed = 0;
+	list_for_each_entry_safe(page, page2, &failedp, lru) {
+		list_del(&page->lru);
+		if ( /* !PageLocked(page) && */
+		    !mmigrate_onepage(page, destnode, 0, &mmigrate_ops)) {
+			continue;
+		}
+		nr_failed++;
+		spin_lock_irq(&zone->lru_lock);
+		putback_page_to_lru(zone, page);
+		spin_unlock_irq(&zone->lru_lock);
+		page_cache_release(page);
+	}
+	return nr_failed;
+}
+
+/*
+ * The migrate-daemon, started as a kernel thread on demand.
+ * 
+ * This migrates all pages on a spcified zone one by one. It traverses
+ * the LRU lists of the zone and tries to migrate each page. It doesn't
+ * matter if the page is in the pagecache or in the swapcache or anonymous.
+ * 
+ * TODO:
+ *   Memsection support. The following code assumes that a whole zone are
+ *   going to be removed. You can replace get_target_page() with
+ *   a proper function if you want to remove part of memory in a zone.
+ */
+static DECLARE_MUTEX(mmigrated_sem);
+int mmigrated(void *p)
+{
+	struct zone *zone = p;
+	int nr_failed = 0;
+	LIST_HEAD(failedp);
+
+	daemonize("migrate%d", zone->zone_start_pfn);
+	current->flags |= PF_KSWAPD;	/*  It's fake */
+	if (down_trylock(&mmigrated_sem)) {
+		printk("mmigrated already running\n");
+		return 0;
+	}
+	on_each_cpu(lru_drain_schedule, NULL, 1, 1);
+	nr_failed = try_to_migrate_pages(zone, MIGRATE_ANYNODE, get_target_page, NULL);
+/* 	if (nr_failed) */
+/* 		goto retry; */
+	on_each_cpu(lru_drain_schedule, NULL, 1, 1);
+	up(&mmigrated_sem);
+	return 0;
+}
+
+static int __init mmigrated_init(void)
+{
+	int i;
+
+	for(i = 0; i < NR_CPUS; i++)
+		INIT_WORK(&lru_drain_wq[i], (void (*)(void *))lru_add_drain, NULL);
+	return 0;
+}
+
+module_init(mmigrated_init);
