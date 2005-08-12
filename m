Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVHLOs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVHLOs7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVHLOr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:47:57 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:44693 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751066AbVHLOrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:47:33 -0400
Subject: [RFC][PATCH 09/12] memory hotplug: move section_mem_map alloc to sparse.c
To: linux-kernel@vger.kernel.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 12 Aug 2005 07:47:29 -0700
References: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
In-Reply-To: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
Message-Id: <20050812144729.9990D72C@kernel.beaverton.ibm.com>
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

diff -puN mm/sparse.c~D0.6-move_memmap_kmalloc_to_sparse.c mm/sparse.c
--- memhotplug/mm/sparse.c~D0.6-move_memmap_kmalloc_to_sparse.c	2005-08-12 07:43:49.000000000 -0700
+++ memhotplug-dave/mm/sparse.c	2005-08-12 07:43:49.000000000 -0700
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
diff -puN mm/memory_hotplug.c~D0.6-move_memmap_kmalloc_to_sparse.c mm/memory_hotplug.c
--- memhotplug/mm/memory_hotplug.c~D0.6-move_memmap_kmalloc_to_sparse.c	2005-08-12 07:43:49.000000000 -0700
+++ memhotplug-dave/mm/memory_hotplug.c	2005-08-12 07:43:49.000000000 -0700
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
_
