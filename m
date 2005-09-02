Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbVIBU7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbVIBU7h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVIBU5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:57:02 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:55021 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751242AbVIBU4x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:56:53 -0400
Subject: [PATCH 08/11] memory hotplug: move section_mem_map alloc to sparse.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 02 Sep 2005 13:56:49 -0700
References: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
In-Reply-To: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
Message-Id: <20050902205649.CF14EEEB@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This basically keeps up from having to extern __kmalloc_section_memmap().

The vaddr_in_vmalloc_area() helper could go in a vmalloc header, but
that header gets hard to work with, because it needs some arch-specific
macros.  Just stick it in here for now, instead of creating another header.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/mm/memory_hotplug.c |   43 --------------------
 memhotplug-dave/mm/sparse.c         |   74 +++++++++++++++++++++++++++++++++---
 2 files changed, 70 insertions(+), 47 deletions(-)

diff -puN mm/memory_hotplug.c~D0.6-move_memmap_kmalloc_to_sparse.c mm/memory_hotplug.c
--- memhotplug/mm/memory_hotplug.c~D0.6-move_memmap_kmalloc_to_sparse.c	2005-08-18 14:59:48.000000000 -0700
+++ memhotplug-dave/mm/memory_hotplug.c	2005-08-18 14:59:48.000000000 -0700
@@ -24,28 +24,6 @@
 
 #include <asm/tlbflush.h>
 
-static struct page *__kmalloc_section_memmap(unsigned long nr_pages)
-{
-	struct page *page, *ret;
-	unsigned long memmap_size = sizeof(struct page) * nr_pages;
-
-	page = alloc_pages(GFP_KERNEL, get_order(memmap_size));
-	if (page)
-		goto got_map_page;
-
-	ret = vmalloc(memmap_size);
-	if (ret)
-		goto got_map_ptr;
-
-	return NULL;
-got_map_page:
-	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
-got_map_ptr:
-	memset(ret, 0, memmap_size);
-
-	return ret;
-}
-
 extern void zonetable_add(struct zone *zone, int nid, int zid, unsigned long pfn,
 			  unsigned long size);
 static void __add_zone(struct zone *zone, unsigned long phys_start_pfn)
@@ -60,7 +38,7 @@ static void __add_zone(struct zone *zone
 	zonetable_add(zone, nid, zone_type, phys_start_pfn, nr_pages);
 }
 
-extern int sparse_add_one_section(struct zone *, unsigned long,
+extern int sparse_add_one_section(struct zone *zone, unsigned long start_pfn,
 				  struct page *mem_map);
 int __add_section(struct zone *zone, unsigned long phys_start_pfn)
 {
@@ -69,26 +47,7 @@ int __add_section(struct zone *zone, uns
 	struct page *memmap;
 	int ret;
 
-	/*
-	 * This can potentially allocate memory, and does its own
-	 * internal locking.
-	 */
-	sparse_index_init(pfn_to_section_nr(phys_start_pfn), pgdat->node_id);
-
-	pgdat_resize_lock(pgdat, &flags);
-	memmap = __kmalloc_section_memmap(nr_pages);
 	ret = sparse_add_one_section(zone, phys_start_pfn, memmap);
-	pgdat_resize_unlock(pgdat, &flags);
-
-	if (ret <= 0) {
-		/* the mem_map didn't get used */
-		if (memmap >= (struct page *)VMALLOC_START &&
-		    memmap < (struct page *)VMALLOC_END)
-			vfree(memmap);
-		else
-			free_pages((unsigned long)memmap,
-				   get_order(sizeof(struct page) * nr_pages));
-	}
 
 	if (ret < 0)
 		return ret;
diff -puN mm/sparse.c~D0.6-move_memmap_kmalloc_to_sparse.c mm/sparse.c
--- memhotplug/mm/sparse.c~D0.6-move_memmap_kmalloc_to_sparse.c	2005-08-18 14:59:48.000000000 -0700
+++ memhotplug-dave/mm/sparse.c	2005-08-18 14:59:48.000000000 -0700
@@ -5,8 +5,10 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/bootmem.h>
+#include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/vmalloc.h>
 #include <asm/dma.h>
 
 /*
@@ -164,6 +166,45 @@ static struct page *sparse_early_mem_map
 	return NULL;
 }
 
+static struct page *__kmalloc_section_memmap(unsigned long nr_pages)
+{
+	struct page *page, *ret;
+	unsigned long memmap_size = sizeof(struct page) * nr_pages;
+
+	page = alloc_pages(GFP_KERNEL, get_order(memmap_size));
+	if (page)
+		goto got_map_page;
+
+	ret = vmalloc(memmap_size);
+	if (ret)
+		goto got_map_ptr;
+
+	return NULL;
+got_map_page:
+	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
+got_map_ptr:
+	memset(ret, 0, memmap_size);
+
+	return ret;
+}
+
+static int vaddr_in_vmalloc_area(void *addr)
+{
+	if (addr >= (void *)VMALLOC_START &&
+	    addr < (void *)VMALLOC_END)
+		return 1;
+	return 0;
+}
+
+static void __kfree_section_memmap(struct page *memmap, unsigned long nr_pages)
+{
+	if (vaddr_in_vmalloc_area(memmap))
+		vfree(memmap);
+	else
+		free_pages((unsigned long)memmap,
+			   get_order(sizeof(struct page) * nr_pages));
+}
+
 /*
  * Allocate the accumulated non-linear sections, allocate a mem_map
  * for each and record the physical to section mapping.
@@ -189,14 +230,37 @@ void sparse_init(void)
  * set.  If this is <=0, then that means that the passed-in
  * map was not consumed and must be freed.
  */
-int sparse_add_one_section(unsigned long start_pfn, int nr_pages, struct page *map)
+int sparse_add_one_section(struct zone *zone, unsigned long start_pfn,
+			   int nr_pages)
 {
-	struct mem_section *ms = __pfn_to_section(start_pfn);
+	unsigned long section_nr = pfn_to_section_nr(start_pfn);
+	struct pglist_data *pgdat = zone->zone_pgdat;
+	struct mem_section *ms;
+	struct page *memmap;
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * no locking for this, because it does its own
+	 * plus, it does a kmalloc
+	 */
+	sparse_index_init(section_nr, pgdat->node_id);
+	memmap = __kmalloc_section_memmap(nr_pages);
 
-	if (ms->section_mem_map & SECTION_MARKED_PRESENT)
-		return -EEXIST;
+	pgdat_resize_lock(pgdat, &flags);
 
+	ms = __pfn_to_section(start_pfn);
+	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
+		ret = -EEXIST;
+		goto out;
+	}
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 
-	return sparse_init_one_section(ms, pfn_to_section_nr(start_pfn), map);
+	ret = sparse_init_one_section(ms, section_nr, memmap);
+
+	if (ret <= 0)
+		__kfree_section_memmap(memmap, nr_pages);
+out:
+	pgdat_resize_unlock(pgdat, &flags);
+	return ret;
 }
_
