Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSD2Oys>; Mon, 29 Apr 2002 10:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312449AbSD2Oyr>; Mon, 29 Apr 2002 10:54:47 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:38540 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312447AbSD2Oyq>;
	Mon, 29 Apr 2002 10:54:46 -0400
Date: Mon, 29 Apr 2002 20:24:46 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: marcelo@brutus.conectiva.com.br
Subject: [PATCH]Fix: Init page count for all pages during higher order allocs
Message-ID: <20020429202446.A2326@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The call to set_page_count(page, 1) in page_alloc.c appears to happen 
only for the first page, for order 1 and higher allocations.
This leaves the count for the rest of the pages in that block 
uninitialised.

We ran into this while working on some lkcd changes where we check
the page count to help exclude unreferenced pages, and found
that we were missing some referenced pages too (e.g the second page
of thread_info/stack pages which involve order 1 allocations)

Here is a patch from Bharata B. Rao that sets the page count 
for all the pages allocated. This is along the same lines
as the code in slab.c to issue SET_PAGE_CACHE/SET_PAGE_SLAB
on all the pages in an allocated block based on the slab order.
(That code seems to be preceded by a somewhat scary comment
 so hope there is nothing to be concerned about; are there 
 any caveats ? )

Comments ? 
Does this look like the right thing to do ?

Regards
Suparna

--- 2418-pure/mm/page_alloc.c	Tue Feb 26 01:08:14 2002
+++ linux-2.4.18+lkcd/mm/page_alloc.c	Mon Apr 29 14:16:37 2002
@@ -181,7 +181,7 @@
 static struct page * rmqueue(zone_t *zone, unsigned int order)
 {
 	free_area_t * area = zone->free_area + order;
-	unsigned int curr_order = order;
+	unsigned int i, curr_order = order;
 	struct list_head *head, *curr;
 	unsigned long flags;
 	struct page *page;
@@ -206,13 +206,18 @@
 			page = expand(zone, page, index, order, curr_order, area);
 			spin_unlock_irqrestore(&zone->lock, flags);
 
-			set_page_count(page, 1);
-			if (BAD_RANGE(zone,page))
-				BUG();
-			if (PageLRU(page))
-				BUG();
-			if (PageActive(page))
-				BUG();
+			i = 1UL << order;
+			page += i;
+			do {
+				page--;
+				set_page_count(page, 1);
+				if (BAD_RANGE(zone,page))
+					BUG();
+				if (PageLRU(page))
+					BUG();
+				if (PageActive(page))
+					BUG();
+			} while (--i);
 			return page;	
 		}
 		curr_order++;
@@ -236,6 +241,7 @@
 {
 	struct page * page = NULL;
 	int __freed = 0;
+	unsigned int i;
 
 	if (!(gfp_mask & __GFP_WAIT))
 		goto out;
@@ -264,25 +270,29 @@
 				if (tmp->index == order && memclass(tmp->zone, classzone)) {
 					list_del(entry);
 					current->nr_local_pages--;
-					set_page_count(tmp, 1);
-					page = tmp;
 
-					if (page->buffers)
-						BUG();
-					if (page->mapping)
-						BUG();
-					if (!VALID_PAGE(page))
-						BUG();
-					if (PageSwapCache(page))
-						BUG();
-					if (PageLocked(page))
-						BUG();
-					if (PageLRU(page))
-						BUG();
-					if (PageActive(page))
-						BUG();
-					if (PageDirty(page))
-						BUG();
+					i = 1UL << order;
+					page = tmp + i;
+					do {
+						page--;
+						set_page_count(page, 1);
+						if (page->buffers)
+							BUG();
+						if (page->mapping)
+							BUG();
+						if (!VALID_PAGE(page))
+							BUG();
+						if (PageSwapCache(page))
+							BUG();
+						if (PageLocked(page))
+							BUG();
+						if (PageLRU(page))
+							BUG();
+						if (PageActive(page))
+							BUG();
+						if (PageDirty(page))
+							BUG();
+					} while (--i);
 
 					break;
 				}
