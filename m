Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWANS6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWANS6h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 13:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWANS6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 13:58:37 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:3490 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750764AbWANS6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 13:58:36 -0500
Date: Sat, 14 Jan 2006 10:58:25 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Nick Piggin <npiggin@suse.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
In-Reply-To: <20060114181949.GA27382@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
References: <20060114155517.GA30543@wotan.suse.de>
 <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>
 <20060114181949.GA27382@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2006, Nick Piggin wrote:

> > We take that reference count on the page:
> Yes, after you have dropped all your claims to pin this page
> (ie. pte lock). You really can't take a refcount on a page that

Oh. Now I see. I screwed that up by a fix I added.... We cannot drop the 
ptl here. So back to the way it was before. Remove the draining from 
isolate_lru_page and do it before scanning for pages so that we do not
have to drop the ptl. 

Also remove the WARN_ON since its now even possible that other actions of 
the VM move the pages into the LRU lists while we scan for pages to
migrate.

This increases the chance that we find pages that cannot be migrated.

Needs to be applied to Linus tree.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15/mm/mempolicy.c
===================================================================
--- linux-2.6.15.orig/mm/mempolicy.c	2006-01-11 20:55:08.000000000 -0800
+++ linux-2.6.15/mm/mempolicy.c	2006-01-14 10:37:19.000000000 -0800
@@ -216,11 +216,8 @@ static int check_pte_range(struct vm_are
 
 		if (flags & MPOL_MF_STATS)
 			gather_stats(page, private);
-		else if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
-			spin_unlock(ptl);
+		else if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
 			migrate_page_add(vma, page, private, flags);
-			spin_lock(ptl);
-		}
 		else
 			break;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
@@ -297,6 +294,11 @@ static inline int vma_migratable(struct 
 	return 1;
 }
 
+static void lru_add_drain_per_cpu(void *dummy)
+{
+	lru_add_drain();
+}
+
 /*
  * Check if all pages in a range are on a set of nodes.
  * If pagelist != NULL then isolate pages from the LRU and
@@ -309,6 +311,12 @@ check_range(struct mm_struct *mm, unsign
 	int err;
 	struct vm_area_struct *first, *vma, *prev;
 
+	/*
+	 * Clear the LRU lists so that we can isolate the pages
+	 */
+	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+		schedule_on_each_cpu(lru_add_drain_per_cpu, NULL);
+
 	first = find_vma(mm, start);
 	if (!first)
 		return ERR_PTR(-EFAULT);
@@ -554,17 +562,9 @@ static void migrate_page_add(struct vm_a
 	 */
 	if ((flags & MPOL_MF_MOVE_ALL) || !page->mapping || PageAnon(page) ||
 	    mapping_writably_mapped(page->mapping) ||
-	    single_mm_mapping(vma->vm_mm, page->mapping)) {
-		int rc = isolate_lru_page(page);
-
-		if (rc == 1)
+	    single_mm_mapping(vma->vm_mm, page->mapping))
+		if (isolate_lru_page(page) == 1)
 			list_add(&page->lru, pagelist);
-		/*
-		 * If the isolate attempt was not successful then we just
-		 * encountered an unswappable page. Something must be wrong.
-	 	 */
-		WARN_ON(rc == 0);
-	}
 }
 
 static int swap_pages(struct list_head *pagelist)
Index: linux-2.6.15/mm/vmscan.c
===================================================================
--- linux-2.6.15.orig/mm/vmscan.c	2006-01-11 12:49:03.000000000 -0800
+++ linux-2.6.15/mm/vmscan.c	2006-01-14 10:39:15.000000000 -0800
@@ -760,11 +760,6 @@ next:
 	return nr_failed + retry;
 }
 
-static void lru_add_drain_per_cpu(void *dummy)
-{
-	lru_add_drain();
-}
-
 /*
  * Isolate one page from the LRU lists and put it on the
  * indicated list. Do necessary cache draining if the
@@ -780,7 +775,6 @@ int isolate_lru_page(struct page *page)
 	int rc = 0;
 	struct zone *zone = page_zone(page);
 
-redo:
 	spin_lock_irq(&zone->lru_lock);
 	rc = __isolate_lru_page(page);
 	if (rc == 1) {
@@ -790,15 +784,6 @@ redo:
 			del_page_from_inactive_list(zone, page);
 	}
 	spin_unlock_irq(&zone->lru_lock);
-	if (rc == 0) {
-		/*
-		 * Maybe this page is still waiting for a cpu to drain it
-		 * from one of the lru lists?
-		 */
-		rc = schedule_on_each_cpu(lru_add_drain_per_cpu, NULL);
-		if (rc == 0 && PageLRU(page))
-			goto redo;
-	}
 	return rc;
 }
 #endif
