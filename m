Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287848AbSAFMkW>; Sun, 6 Jan 2002 07:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287852AbSAFMkL>; Sun, 6 Jan 2002 07:40:11 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:18451 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287848AbSAFMj4>;
	Sun, 6 Jan 2002 07:39:56 -0500
Date: Sun, 6 Jan 2002 23:39:14 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove 8 bytes from struct page on 64bit archs
Message-ID: <20020106123913.GA5407@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It seems shortening struct page is all the rage at the moment and I
didnt want to be left out. On some 64bit architectures (sparc64 and
ppc64 for example) all memory is allocated in the DMA zone. Therefore
there is no reason to waste 8 bytes per page when every page points to
the same zone!

Here is a very simple patch (ppc64 only so far). For archs that have
more than one memory zone, they should define the following:

#define ARCH_NR_ZONES 3
#define GET_PAGE_ZONE(page)		(page)->zone
#define SET_PAGE_ZONE(page, __zone)	(page)->zone = (__zone)

Next up will be modifying the VM so it doesnt iterate over all 3 zones
if ARCH_NR_ZONES = 1. I did this a while ago with the old VM and it made
a noticable difference but I need to retry it to see if this is still
the case.

Anton

diff -ru --exclude-from=exclude linuxppc_2_4_devel_work/include/asm-ppc64/page.h linuxppc_2_4_devel_work_onezone/include/asm-ppc64/page.h
--- linuxppc_2_4_devel_work/include/asm-ppc64/page.h	Tue Dec 18 18:50:35 2001
+++ linuxppc_2_4_devel_work_onezone/include/asm-ppc64/page.h	Sun Jan  6 22:18:45 2002
@@ -223,5 +223,9 @@
 
 #define MAP_NR(addr)        (__pa(addr) >> PAGE_SHIFT)
 
+#define ARCH_NR_ZONES 1
+#define GET_PAGE_ZONE(page) (contig_page_data.node_zones)
+#define SET_PAGE_ZONE(page, zone)
+
 #endif /* __KERNEL__ */
 #endif /* _PPC64_PAGE_H */
diff -ru --exclude-from=exclude linuxppc_2_4_devel_work/include/linux/mm.h linuxppc_2_4_devel_work_onezone/include/linux/mm.h
--- linuxppc_2_4_devel_work/include/linux/mm.h	Sun Jan  6 15:50:56 2002
+++ linuxppc_2_4_devel_work_onezone/include/linux/mm.h	Sun Jan  6 23:19:58 2002
@@ -164,7 +164,9 @@
 	struct buffer_head * buffers;	/* Buffer maps us to a disk block. */
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
+#if ARCH_NR_ZONES > 1
 	struct zone_struct *zone;	/* Memory zone we are in. */
+#endif
 } mem_map_t;
 
 /*
diff -ru --exclude-from=exclude linuxppc_2_4_devel_work/mm/page_alloc.c linuxppc_2_4_devel_work_onezone/mm/page_alloc.c
--- linuxppc_2_4_devel_work/mm/page_alloc.c	Wed Nov 21 13:43:40 2001
+++ linuxppc_2_4_devel_work_onezone/mm/page_alloc.c	Sun Jan  6 22:18:45 2002
@@ -54,7 +54,11 @@
 /*
  * Temporary debugging check.
  */
+#if ARCH_NR_ZONES > 1
 #define BAD_RANGE(zone,x) (((zone) != (x)->zone) || (((x)-mem_map) < (zone)->zone_start_mapnr) || (((x)-mem_map) >= (zone)->zone_start_mapnr+(zone)->size))
+#else
+#define BAD_RANGE(zone,x) 0
+#endif
 
 /*
  * Buddy system. Hairy. You really aren't expected to understand this
@@ -90,7 +94,7 @@
 		goto local_freelist;
  back_local_freelist:
 
-	zone = page->zone;
+	zone = GET_PAGE_ZONE(page);
 
 	mask = (~0UL) << order;
 	base = zone->zone_mem_map;
@@ -255,7 +259,7 @@
 			entry = local_pages->next;
 			do {
 				tmp = list_entry(entry, struct page, list);
-				if (tmp->index == order && memclass(tmp->zone, classzone)) {
+				if (tmp->index == order && memclass(GET_PAGE_ZONE(tmp), classzone)) {
 					list_del(entry);
 					current->nr_local_pages--;
 					set_page_count(tmp, 1);
@@ -732,7 +736,7 @@
 
 		for (i = 0; i < size; i++) {
 			struct page *page = mem_map + offset + i;
-			page->zone = zone;
+			SET_PAGE_ZONE(page, zone);
 			if (j != ZONE_HIGHMEM)
 				page->virtual = __va(zone_start_paddr);
 			zone_start_paddr += PAGE_SIZE;
diff -ru --exclude-from=exclude linuxppc_2_4_devel_work/mm/vmscan.c linuxppc_2_4_devel_work_onezone/mm/vmscan.c
--- linuxppc_2_4_devel_work/mm/vmscan.c	Sat Dec 22 11:50:21 2001
+++ linuxppc_2_4_devel_work_onezone/mm/vmscan.c	Sun Jan  6 22:18:45 2002
@@ -58,7 +58,7 @@
 		return 0;
 
 	/* Don't bother replenishing zones not under pressure.. */
-	if (!memclass(page->zone, classzone))
+	if (!memclass(GET_PAGE_ZONE(page), classzone))
 		return 0;
 
 	if (TryLockPage(page))
@@ -369,7 +369,7 @@
 		if (unlikely(!page_count(page)))
 			continue;
 
-		if (!memclass(page->zone, classzone))
+		if (!memclass(GET_PAGE_ZONE(page), classzone))
 			continue;
 
 		/* Racy check to avoid trylocking when not worthwhile */
