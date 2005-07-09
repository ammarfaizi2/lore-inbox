Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262994AbVGIAFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbVGIAFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262999AbVGIADZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:03:25 -0400
Received: from gold.veritas.com ([143.127.12.110]:55485 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262994AbVGIACZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:02:25 -0400
Date: Sat, 9 Jul 2005 01:03:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] swap extent list is ordered
In-Reply-To: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090102540.13391@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:02:25.0351 (UTC) FILETIME=[7CD80D70:01C58419]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are several comments that swap's extent_list.prev points to the
lowest extent: that's not so, it's extent_list.next which points to it,
as you'd expect.  And a couple of loops in add_swap_extent which go all
the way through the list, when they should just add to the other end.

Fix those up, and let map_swap_page search the list forwards: profiles
shows it to be twice as quick that way - because prefetch works better
on how the structs are typically kmalloc'ed?  or because usually more
is written to than read from swap, and swap is allocated ascendingly?

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/swap.h |    2 --
 mm/swapfile.c        |   27 +++++++++------------------
 2 files changed, 9 insertions(+), 20 deletions(-)

--- swap3/include/linux/swap.h	2005-07-07 12:33:21.000000000 +0100
+++ swap4/include/linux/swap.h	2005-07-08 19:14:00.000000000 +0100
@@ -115,8 +115,6 @@ enum {
 
 /*
  * The in-memory structure used to track swap areas.
- * extent_list.prev points at the lowest-index extent.  That list is
- * sorted.
  */
 struct swap_info_struct {
 	unsigned int flags;
--- swap3/mm/swapfile.c	2005-07-08 19:13:46.000000000 +0100
+++ swap4/mm/swapfile.c	2005-07-08 19:14:00.000000000 +0100
@@ -830,9 +830,9 @@ sector_t map_swap_page(struct swap_info_
 				offset < (se->start_page + se->nr_pages)) {
 			return se->start_block + (offset - se->start_page);
 		}
-		lh = se->list.prev;
+		lh = se->list.next;
 		if (lh == &sis->extent_list)
-			lh = lh->prev;
+			lh = lh->next;
 		se = list_entry(lh, struct swap_extent, list);
 		sis->curr_swap_extent = se;
 		BUG_ON(se == start_se);		/* It *must* be present */
@@ -857,10 +857,9 @@ static void destroy_swap_extents(struct 
 
 /*
  * Add a block range (and the corresponding page range) into this swapdev's
- * extent list.  The extent list is kept sorted in block order.
+ * extent list.  The extent list is kept sorted in page order.
  *
- * This function rather assumes that it is called in ascending sector_t order.
- * It doesn't look for extent coalescing opportunities.
+ * This function rather assumes that it is called in ascending page order.
  */
 static int
 add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
@@ -870,16 +869,15 @@ add_swap_extent(struct swap_info_struct 
 	struct swap_extent *new_se;
 	struct list_head *lh;
 
-	lh = sis->extent_list.next;	/* The highest-addressed block */
-	while (lh != &sis->extent_list) {
+	lh = sis->extent_list.prev;	/* The highest page extent */
+	if (lh != &sis->extent_list) {
 		se = list_entry(lh, struct swap_extent, list);
-		if (se->start_block + se->nr_pages == start_block &&
-		    se->start_page  + se->nr_pages == start_page) {
+		BUG_ON(se->start_page + se->nr_pages != start_page);
+		if (se->start_block + se->nr_pages == start_block) {
 			/* Merge it */
 			se->nr_pages += nr_pages;
 			return 0;
 		}
-		lh = lh->next;
 	}
 
 	/*
@@ -892,14 +890,7 @@ add_swap_extent(struct swap_info_struct 
 	new_se->nr_pages = nr_pages;
 	new_se->start_block = start_block;
 
-	lh = sis->extent_list.prev;	/* The lowest block */
-	while (lh != &sis->extent_list) {
-		se = list_entry(lh, struct swap_extent, list);
-		if (se->start_block > start_block)
-			break;
-		lh = lh->prev;
-	}
-	list_add_tail(&new_se->list, lh);
+	list_add_tail(&new_se->list, &sis->extent_list);
 	sis->nr_extents++;
 	return 0;
 }
