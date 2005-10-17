Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVJQA0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVJQA0V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 20:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVJQA0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 20:26:21 -0400
Received: from host-84-9-202-131.bulldogdsl.com ([84.9.202.131]:64898 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932102AbVJQA0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 20:26:21 -0400
Date: Mon, 17 Oct 2005 01:26:18 +0100
From: Ben Dooks <ben@fluff.org.uk>
To: linux-kernel@vger.kernel.org
Subject: mm/ sparse cleanups
Message-ID: <20051017002618.GA25318@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix the following sparse warnings from the mm directory.

The vread() and vwrite() calls have been added to the
include/linux/vmalloc.h file, as they are used by
drivers/char/mem.c. We do not bother exporting these
as drivers/char/mem.c can only be built into the kernel.

All the rest have been marked static as they are only
being used in their relevant files.

mm/slab.c:305:30: warning: symbol 'initkmem_list3' was not declared. Should it be static?
mm/page_alloc.c:369:6: warning: symbol '__free_pages_ok' was not declared. Should it be static?
mm/page_alloc.c:1138:6: warning: symbol '__get_page_state' was not declared. Should it be static?
mm/page_alloc.c:1688:6: warning: symbol 'zone_init_free_lists' was not declared. Should it be static?
mm/page_alloc.c:1699:6: warning: symbol 'zonetable_add' was not declared. Should it be static?
mm/vmalloc.c:289:6: warning: symbol '__vunmap' was not declared. Should it be static?
mm/vmalloc.c:521:6: warning: symbol 'vread' was not declared. Should it be static?
mm/vmalloc.c:559:6: warning: symbol 'vwrite' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2614-rc4-mm-sparse-fixes.patch"

diff -urpN -X ../dontdiff linux-2.6.14-rc4-git4/include/linux/vmalloc.h linux-2.6.14-rc4-git4-bjd1/include/linux/vmalloc.h
--- linux-2.6.14-rc4-git4/include/linux/vmalloc.h	2005-10-11 10:56:34.000000000 +0100
+++ linux-2.6.14-rc4-git4-bjd1/include/linux/vmalloc.h	2005-10-16 19:41:17.000000000 +0100
@@ -54,6 +54,9 @@ extern int map_vm_area(struct vm_struct 
 			struct page ***pages);
 extern void unmap_vm_area(struct vm_struct *area);
 
+extern long vread(char *buf, char *addr, unsigned long count);
+extern long vwrite(char *buf, char *addr, unsigned long count);
+
 /*
  *	Internals.  Dont't use..
  */
diff -urpN -X ../dontdiff linux-2.6.14-rc4-git4/mm/page_alloc.c linux-2.6.14-rc4-git4-bjd1/mm/page_alloc.c
--- linux-2.6.14-rc4-git4/mm/page_alloc.c	2005-10-11 10:56:34.000000000 +0100
+++ linux-2.6.14-rc4-git4-bjd1/mm/page_alloc.c	2005-10-16 19:38:21.000000000 +0100
@@ -366,7 +366,7 @@ free_pages_bulk(struct zone *zone, int c
 	return ret;
 }
 
-void __free_pages_ok(struct page *page, unsigned int order)
+static void __free_pages_ok(struct page *page, unsigned int order)
 {
 	LIST_HEAD(list);
 	int i;
@@ -1135,7 +1135,7 @@ EXPORT_SYMBOL(nr_pagecache);
 DEFINE_PER_CPU(long, nr_pagecache_local) = 0;
 #endif
 
-void __get_page_state(struct page_state *ret, int nr, cpumask_t *cpumask)
+static void __get_page_state(struct page_state *ret, int nr, cpumask_t *cpumask)
 {
 	int cpu = 0;
 
@@ -1685,8 +1685,8 @@ void __init memmap_init_zone(unsigned lo
 	}
 }
 
-void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone,
-				unsigned long size)
+static void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone,
+				 unsigned long size)
 {
 	int order;
 	for (order = 0; order < MAX_ORDER ; order++) {
@@ -1696,8 +1696,9 @@ void zone_init_free_lists(struct pglist_
 }
 
 #define ZONETABLE_INDEX(x, zone_nr)	((x << ZONES_SHIFT) | zone_nr)
-void zonetable_add(struct zone *zone, int nid, int zid, unsigned long pfn,
-		unsigned long size)
+
+static void zonetable_add(struct zone *zone, int nid, int zid,
+			  unsigned long pfn, unsigned long size)
 {
 	unsigned long snum = pfn_to_section_nr(pfn);
 	unsigned long end = pfn_to_section_nr(pfn + size);
diff -urpN -X ../dontdiff linux-2.6.14-rc4-git4/mm/slab.c linux-2.6.14-rc4-git4-bjd1/mm/slab.c
--- linux-2.6.14-rc4-git4/mm/slab.c	2005-10-11 10:56:34.000000000 +0100
+++ linux-2.6.14-rc4-git4-bjd1/mm/slab.c	2005-10-16 19:44:28.000000000 +0100
@@ -302,7 +302,7 @@ struct kmem_list3 {
  * Need this for bootstrapping a per node allocator.
  */
 #define NUM_INIT_LISTS (2 * MAX_NUMNODES + 1)
-struct kmem_list3 __initdata initkmem_list3[NUM_INIT_LISTS];
+static struct kmem_list3 __initdata initkmem_list3[NUM_INIT_LISTS];
 #define	CACHE_CACHE 0
 #define	SIZE_AC 1
 #define	SIZE_L3 (1 + MAX_NUMNODES)
diff -urpN -X ../dontdiff linux-2.6.14-rc4-git4/mm/vmalloc.c linux-2.6.14-rc4-git4-bjd1/mm/vmalloc.c
--- linux-2.6.14-rc4-git4/mm/vmalloc.c	2005-10-11 10:56:34.000000000 +0100
+++ linux-2.6.14-rc4-git4-bjd1/mm/vmalloc.c	2005-10-16 19:42:02.000000000 +0100
@@ -286,7 +286,7 @@ struct vm_struct *remove_vm_area(void *a
 	return v;
 }
 
-void __vunmap(void *addr, int deallocate_pages)
+static void __vunmap(void *addr, int deallocate_pages)
 {
 	struct vm_struct *area;
 

--pf9I7BMVVzbSWLtt--
