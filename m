Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310118AbSCACUq>; Thu, 28 Feb 2002 21:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310200AbSCACTC>; Thu, 28 Feb 2002 21:19:02 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:1543 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310327AbSCACSe>;
	Thu, 28 Feb 2002 21:18:34 -0500
Date: Thu, 28 Feb 2002 23:17:59 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] cleanups struct page shrinkage
Message-ID: <Pine.LNX.4.33L.0202282315440.2801-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

during the merge of the struct page shrinkage patch with 2.4
two issues came up:

- janitor: clean up i810_dma.c and agpgart_be.c to use the macros
  from mm.h instead of set_bit/clear_bit
- access page->count only through the atomic macros, remove the
  broken init_page_count thing  (DaveM)

I've ported these things to 2.5 now, diffstat and unidiff below
my .sig, you can pull the changeset from:

   bk://linuxvm.bkbits.net/linux-2.5-vmtidbits

please consider for a next 2.5 kernel.

thank you,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/


 drivers/char/agp/agpgart_be.c |   40 +++++++++++++++++-----------------------
 drivers/char/drm/i810_dma.c   |    9 ++++-----
 include/linux/mm.h            |    5 -----
 mm/page_alloc.c               |    2 +-
 4 files changed, 22 insertions(+), 34 deletions(-)


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.454   -> 1.455
#	  include/linux/mm.h	1.39    -> 1.40
#	     mm/page_alloc.c	1.42    -> 1.43
#	drivers/char/agp/agpgart_be.c	1.22    -> 1.23
#	drivers/char/drm/i810_dma.c	1.7     -> 1.8
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/28	riel@imladris.surriel.com	1.455
# - janitor: clean up i810_dma.c and agpgart_be.c to use the macros
#   from mm.h instead of set_bit/clear_bit
# - access page->count only through the atomic macros, remove the
#   broken init_page_count thing  (DaveM)
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/agpgart_be.c b/drivers/char/agp/agpgart_be.c
--- a/drivers/char/agp/agpgart_be.c	Thu Feb 28 23:15:40 2002
+++ b/drivers/char/agp/agpgart_be.c	Thu Feb 28 23:15:40 2002
@@ -622,7 +622,7 @@
 	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);

 	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
-		set_bit(PG_reserved, &page->flags);
+		SetPageReserved(page);

 	agp_bridge.gatt_table_real = (unsigned long *) table;
 	CACHE_FLUSH();
@@ -632,7 +632,7 @@

 	if (agp_bridge.gatt_table == NULL) {
 		for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
-			clear_bit(PG_reserved, &page->flags);
+			ClearPageReserved(page);

 		free_pages((unsigned long) table, page_order);

@@ -699,7 +699,7 @@
 	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);

 	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
-		clear_bit(PG_reserved, &page->flags);
+		ClearPageReserved(page);

 	free_pages((unsigned long) agp_bridge.gatt_table_real, page_order);
 	return 0;
@@ -812,8 +812,8 @@
 	if (page == NULL) {
 		return 0;
 	}
-	atomic_inc(&page->count);
-	set_bit(PG_locked, &page->flags);
+	get_page(page);
+	LockPage(page);
 	atomic_inc(&agp_bridge.current_memory_agp);
 	return (unsigned long)page_address(page);
 }
@@ -828,9 +828,8 @@
 	}

 	page = virt_to_page(pt);
-	atomic_dec(&page->count);
-	clear_bit(PG_locked, &page->flags);
-	wake_up_page(page);
+	put_page(page);
+	UnlockPage(page);
 	free_page((unsigned long) pt);
 	atomic_dec(&agp_bridge.current_memory_agp);
 }
@@ -2278,13 +2277,12 @@
 	if (page_map->real == NULL) {
 		return -ENOMEM;
 	}
-	set_bit(PG_reserved, &virt_to_page(page_map->real)->flags);
+	SetPageReserved(virt_to_page(page_map->real));
 	CACHE_FLUSH();
 	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real),
 					    PAGE_SIZE);
 	if (page_map->remapped == NULL) {
-		clear_bit(PG_reserved,
-			  &virt_to_page(page_map->real)->flags);
+		ClearPageReserved(virt_to_page(page_map->real));
 		free_page((unsigned long) page_map->real);
 		page_map->real = NULL;
 		return -ENOMEM;
@@ -2301,8 +2299,7 @@
 static void amd_free_page_map(amd_page_map *page_map)
 {
 	iounmap(page_map->remapped);
-	clear_bit(PG_reserved,
-		  &virt_to_page(page_map->real)->flags);
+	ClearPageReserved(virt_to_page(page_map->real));
 	free_page((unsigned long) page_map->real);
 }

@@ -2790,8 +2787,8 @@
 	if (page == NULL)
 		return 0;

-	atomic_inc(&page->count);
-	set_bit(PG_locked, &page->flags);
+	get_page(page);
+	LockPage(page);
 	atomic_inc(&agp_bridge.current_memory_agp);

 	global_cache_flush();
@@ -2826,9 +2823,8 @@
 	}

 	page = virt_to_page(pt);
-	atomic_dec(&page->count);
-	clear_bit(PG_locked, &page->flags);
-	wake_up_page(page);
+	put_page(page);
+	UnlockPage(page);
 	free_page((unsigned long) pt);
 	atomic_dec(&agp_bridge.current_memory_agp);
 }
@@ -2910,13 +2906,12 @@
 	if (page_map->real == NULL) {
 		return -ENOMEM;
 	}
-	set_bit(PG_reserved, &virt_to_page(page_map->real)->flags);
+	SetPageReserved(virt_to_page(page_map->real));
 	CACHE_FLUSH();
 	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real),
 					    PAGE_SIZE);
 	if (page_map->remapped == NULL) {
-		clear_bit(PG_reserved,
-			  &virt_to_page(page_map->real)->flags);
+		ClearPageReserved(virt_to_page(page_map->real));
 		free_page((unsigned long) page_map->real);
 		page_map->real = NULL;
 		return -ENOMEM;
@@ -2933,8 +2928,7 @@
 static void serverworks_free_page_map(serverworks_page_map *page_map)
 {
 	iounmap(page_map->remapped);
-	clear_bit(PG_reserved,
-		  &virt_to_page(page_map->real)->flags);
+	ClearPageReserved(virt_to_page(page_map->real));
 	free_page((unsigned long) page_map->real);
 }

diff -Nru a/drivers/char/drm/i810_dma.c b/drivers/char/drm/i810_dma.c
--- a/drivers/char/drm/i810_dma.c	Thu Feb 28 23:15:40 2002
+++ b/drivers/char/drm/i810_dma.c	Thu Feb 28 23:15:40 2002
@@ -286,8 +286,8 @@
 	if(address == 0UL)
 		return 0;

-	atomic_inc(&virt_to_page(address)->count);
-	set_bit(PG_locked, &virt_to_page(address)->flags);
+	get_page(virt_to_page(address));
+	LockPage(virt_to_page(address));

 	return address;
 }
@@ -296,9 +296,8 @@
 {
 	if (page) {
 		struct page *p = virt_to_page(page);
-		atomic_dec(p);
-		clear_bit(PG_locked, &p->flags);
-		wake_up_page(p);
+		put_page(p);
+		UnlockPage(p);
 		free_page(page);
 	}
 }
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Thu Feb 28 23:15:40 2002
+++ b/include/linux/mm.h	Thu Feb 28 23:15:40 2002
@@ -193,11 +193,6 @@
 #define page_count(p)		atomic_read(&(p)->count)
 #define set_page_count(p,v) 	atomic_set(&(p)->count, v)

-static inline void init_page_count(struct page *page)
-{
-	page->count.counter = 0;
-}
-
 /*
  * Various page->flags bits:
  *
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Thu Feb 28 23:15:40 2002
+++ b/mm/page_alloc.c	Thu Feb 28 23:15:40 2002
@@ -811,7 +811,7 @@
 		for (i = 0; i < size; i++) {
 			struct page *page = mem_map + offset + i;
 			set_page_zone(page, nid * MAX_NR_ZONES + j);
-			init_page_count(page);
+			set_page_count(page, 0);
 			__SetPageReserved(page);
 			memlist_init(&page->list);
 			if (j != ZONE_HIGHMEM)

