Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVKWPJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVKWPJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVKWPJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:09:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7837 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750936AbVKWPJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:09:30 -0500
Date: Wed, 23 Nov 2005 15:09:14 GMT
Message-Id: <200511231509.jANF9EXe000981@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Fcc: outgoing
Subject: [PATCH 2/3] FRV: Clean up bootmem allocator's page freeing algorithm
In-Reply-To: <dhowells1132758553@warthog.cambridge.redhat.com>
References: <dhowells1132758553@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch cleans up the way the bootmem allocator frees pages.

A new function, __free_pages_bootmem(), is provided in mm/page_alloc.c () that
is called from mm/bootmem.c to turn pages over to the main allocator. All the
bits of code to initialise pages (clearing PG_reserved and setting the page
count) are moved to here. The checks on page validity are removed, on the
assumption that the struct page arrays will have been prepared correctly.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-bootmem-2615rc2.diff
 mm/bootmem.c    |   20 +++-------------
 mm/internal.h   |    2 -
 mm/page_alloc.c |   70 +++++++++++++++++++++++++++++++++++++++++---------------
 3 files changed, 57 insertions(+), 35 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc2/mm/bootmem.c linux-2.6.15-rc2-frv/mm/bootmem.c
--- /warthog/kernels/linux-2.6.15-rc2/mm/bootmem.c	2005-11-23 12:09:24.000000000 +0000
+++ linux-2.6.15-rc2-frv/mm/bootmem.c	2005-11-23 14:11:45.000000000 +0000
@@ -294,20 +294,12 @@ static unsigned long __init free_all_boo
 		unsigned long v = ~map[i / BITS_PER_LONG];
 
 		if (gofast && v == ~0UL) {
-			int j, order;
+			int order;
 
 			page = pfn_to_page(pfn);
 			count += BITS_PER_LONG;
-			__ClearPageReserved(page);
 			order = ffs(BITS_PER_LONG) - 1;
-			set_page_refs(page, order);
-			for (j = 1; j < BITS_PER_LONG; j++) {
-				if (j + 16 < BITS_PER_LONG)
-					prefetchw(page + j + 16);
-				__ClearPageReserved(page + j);
-				set_page_count(page + j, 0);
-			}
-			__free_pages(page, order);
+			__free_pages_bootmem(page, order);
 			i += BITS_PER_LONG;
 			page += BITS_PER_LONG;
 		} else if (v) {
@@ -317,9 +309,7 @@ static unsigned long __init free_all_boo
 			for (m = 1; m && i < idx; m<<=1, page++, i++) {
 				if (v & m) {
 					count++;
-					__ClearPageReserved(page);
-					set_page_refs(page, 0);
-					__free_page(page);
+					__free_pages_bootmem(page, 0);
 				}
 			}
 		} else {
@@ -337,9 +327,7 @@ static unsigned long __init free_all_boo
 	count = 0;
 	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
 		count++;
-		__ClearPageReserved(page);
-		set_page_count(page, 1);
-		__free_page(page);
+		__free_pages_bootmem(page, 0);
 	}
 	total += count;
 	bdata->node_bootmem_map = NULL;
diff -uNrp /warthog/kernels/linux-2.6.15-rc2/mm/internal.h linux-2.6.15-rc2-frv/mm/internal.h
--- /warthog/kernels/linux-2.6.15-rc2/mm/internal.h	2005-03-02 12:09:02.000000000 +0000
+++ linux-2.6.15-rc2-frv/mm/internal.h	2005-11-23 14:13:23.000000000 +0000
@@ -10,4 +10,4 @@
  */
 
 /* page_alloc.c */
-extern void set_page_refs(struct page *page, int order);
+extern void fastcall __init __free_pages_bootmem(struct page *page, unsigned int order);
diff -uNrp /warthog/kernels/linux-2.6.15-rc2/mm/page_alloc.c linux-2.6.15-rc2-frv/mm/page_alloc.c
--- /warthog/kernels/linux-2.6.15-rc2/mm/page_alloc.c	2005-11-23 12:09:24.000000000 +0000
+++ linux-2.6.15-rc2-frv/mm/page_alloc.c	2005-11-23 14:24:57.000000000 +0000
@@ -53,6 +53,8 @@ unsigned long totalram_pages __read_most
 unsigned long totalhigh_pages __read_mostly;
 long nr_swap_pages;
 
+static void fastcall free_hot_cold_page(struct page *page, int cold);
+
 /*
  * results with 256, 32 in the lowmem_reserve sysctl:
  *	1G machine -> (16M dma, 800M-16M normal, 1G-800M high)
@@ -148,6 +150,23 @@ static void bad_page(const char *functio
 	add_taint(TAINT_BAD_PAGE);
 }
 
+void set_page_refs(struct page *page, int order)
+{
+#ifdef CONFIG_MMU
+	set_page_count(page, 1);
+#else
+	int i;
+
+	/*
+	 * We need to reference all the pages for this order, otherwise if
+	 * anyone accesses one of the pages with (get/put) it will be freed.
+	 * - eg: access_process_vm()
+	 */
+	for (i = 0; i < (1 << order); i++)
+		set_page_count(page + i, 1);
+#endif /* CONFIG_MMU */
+}
+
 #ifndef CONFIG_HUGETLB_PAGE
 #define prep_compound_page(page, order) do { } while (0)
 #define destroy_compound_page(page, order) do { } while (0)
@@ -415,6 +434,39 @@ void __free_pages_ok(struct page *page, 
 	free_pages_bulk(page_zone(page), 1, &list, order);
 }
 
+/*
+ * permit the bootmem allocator to evade page validation on high-order frees
+ */
+void fastcall __init __free_pages_bootmem(struct page *page, unsigned int order)
+{
+	if (order == 0) {
+		__ClearPageReserved(page);
+		set_page_count(page, 0);
+
+		free_hot_cold_page(page, 0);
+	} else {
+		LIST_HEAD(list);
+		int loop;
+
+		for (loop = 0; loop < BITS_PER_LONG; loop++) {
+			struct page *p = &page[loop];
+
+			if (loop + 16 < BITS_PER_LONG)
+				prefetchw(p + 16);
+			__ClearPageReserved(p);
+			set_page_count(p, 0);
+		}
+
+		arch_free_page(page, order);
+
+		mod_page_state(pgfree, 1 << order);
+
+		list_add(&page->lru, &list);
+		kernel_map_pages(page, 1 << order, 0);
+		free_pages_bulk(page_zone(page), 1, &list, order);
+	}
+}
+
 
 /*
  * The order of subdivision here is critical for the IO subsystem.
@@ -448,23 +500,6 @@ expand(struct zone *zone, struct page *p
 	return page;
 }
 
-void set_page_refs(struct page *page, int order)
-{
-#ifdef CONFIG_MMU
-	set_page_count(page, 1);
-#else
-	int i;
-
-	/*
-	 * We need to reference all the pages for this order, otherwise if
-	 * anyone accesses one of the pages with (get/put) it will be freed.
-	 * - eg: access_process_vm()
-	 */
-	for (i = 0; i < (1 << order); i++)
-		set_page_count(page + i, 1);
-#endif /* CONFIG_MMU */
-}
-
 /*
  * This page is about to be returned from the page allocator
  */
@@ -665,7 +700,6 @@ static void zone_statistics(struct zonel
 /*
  * Free a 0-order page
  */
-static void FASTCALL(free_hot_cold_page(struct page *page, int cold));
 static void fastcall free_hot_cold_page(struct page *page, int cold)
 {
 	struct zone *zone = page_zone(page);
