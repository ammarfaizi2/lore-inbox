Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbULQXjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbULQXjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbULQXjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:39:10 -0500
Received: from siaag2ad.compuserve.com ([149.174.40.134]:8844 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S262231AbULQXhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:37:54 -0500
Date: Fri, 17 Dec 2004 18:35:40 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Linux 2.6.9-ac16
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Ross <chris@tebibyte.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200412171837_MC3-1-9129-C5E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> Chris Ross wrote:
>
> > This kernel still suffers from the faulty OOM killing troubles of 
> > vanilla 2.6.9. Could you please pick up at least one of the recent fixes 
> > for this problem, such as as Rik van Riel's?
>
> Can someone point me to his patch?  I've been working on and off to try and get 
> reasonable OOM behaviour.

 I have these two patches (plus 208 more) applied to 2.6.9 and haven't seen
any OOM kills even under heavy swap pressure.  Building an allyesconfig kernel
on a 384M SMP machine running X goes 250M into swap and survives, but it does freeze
solid for long periods while swapping.  The dots on the KDE clock even stop blinking!

 Nobody has found an answer for the freezes, which persist even in the latest
2.6.10-rc but there's a vm_writeout throttling patch in -ac that I haven't tried.

======================================================================================
# mm_spurious_oomkill.patch
#       include/linux/rmap.h -2 +2
#       mm/rmap.c -10 +13
#       mm/vmscan.c -2 +2
#
#       2004/11/19 14:54:22-08:00 akpm@osdl.org 
#       [PATCH] vmscan: ignore swap token when in trouble
#       
#       The token-based thrashing control patches introduced a problem: when a task
#       which doesn't hold the token tries to run direct-reclaim, that task is told
#       that pages which belong to the token-holding mm are referenced, even though
#       they are not.  This means that it is possible for a huge number of a
#       non-token-holding mm's pages to be scanned to no effect.  Eventually, we give
#       up and go and oom-kill something.
#       
#       So the patch arranges for the thrashing control logic to be defeated if the
#       caller has reached the highest level of scanning priority.
#       
#       Signed-off-by: Andrew Morton <akpm@osdl.org>
#       Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
--- 2.6.9/include/linux/rmap.h
+++ 2.6.9.1/include/linux/rmap.h
@@ -88,7 +88,7 @@
 /*
  * Called from mm/vmscan.c to handle paging out
  */
-int page_referenced(struct page *, int is_locked);
+int page_referenced(struct page *, int is_locked, int ignore_token);
 int try_to_unmap(struct page *);
 
 /*
@@ -102,7 +102,7 @@
 #define anon_vma_prepare(vma)  (0)
 #define anon_vma_link(vma)     do {} while (0)
 
-#define page_referenced(page,l)        TestClearPageReferenced(page)
+#define page_referenced(page,l,i) TestClearPageReferenced(page)
 #define try_to_unmap(page)     SWAP_FAIL
 
 #endif /* CONFIG_MMU */
--- 2.6.9/mm/rmap.c
+++ 2.6.9.1/mm/rmap.c
@@ -253,7 +253,7 @@
  * repeatedly from either page_referenced_anon or page_referenced_file.
  */
 static int page_referenced_one(struct page *page,
-       struct vm_area_struct *vma, unsigned int *mapcount)
+       struct vm_area_struct *vma, unsigned int *mapcount, int ignore_token)
 {
        struct mm_struct *mm = vma->vm_mm;
        unsigned long address;
@@ -288,7 +288,7 @@
        if (ptep_clear_flush_young(vma, address, pte))
                referenced++;
 
-       if (mm != current->mm && has_swap_token(mm))
+       if (mm != current->mm && !ignore_token && has_swap_token(mm))
                referenced++;
 
        (*mapcount)--;
@@ -301,7 +301,7 @@
        return referenced;
 }
 
-static int page_referenced_anon(struct page *page)
+static int page_referenced_anon(struct page *page, int ignore_token)
 {
        unsigned int mapcount;
        struct anon_vma *anon_vma;
@@ -314,7 +314,8 @@
 
        mapcount = page_mapcount(page);
        list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
-               referenced += page_referenced_one(page, vma, &mapcount);
+               referenced += page_referenced_one(page, vma, &mapcount,
+                                                       ignore_token);
                if (!mapcount)
                        break;
        }
@@ -333,7 +334,7 @@
  *
  * This function is only called from page_referenced for object-based pages.
  */
-static int page_referenced_file(struct page *page)
+static int page_referenced_file(struct page *page, int ignore_token)
 {
        unsigned int mapcount;
        struct address_space *mapping = page->mapping;
@@ -371,7 +372,8 @@
                        referenced++;
                        break;
                }
-               referenced += page_referenced_one(page, vma, &mapcount);
+               referenced += page_referenced_one(page, vma, &mapcount,
+                                                       ignore_token);
                if (!mapcount)
                        break;
        }
@@ -388,7 +390,7 @@
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of ptes which referenced the page.
  */
-int page_referenced(struct page *page, int is_locked)
+int page_referenced(struct page *page, int is_locked, int ignore_token)
 {
        int referenced = 0;
 
@@ -400,14 +402,15 @@
 
        if (page_mapped(page) && page->mapping) {
                if (PageAnon(page))
-                       referenced += page_referenced_anon(page);
+                       referenced += page_referenced_anon(page, ignore_token);
                else if (is_locked)
-                       referenced += page_referenced_file(page);
+                       referenced += page_referenced_file(page, ignore_token);
                else if (TestSetPageLocked(page))
                        referenced++;
                else {
                        if (page->mapping)
-                               referenced += page_referenced_file(page);
+                               referenced += page_referenced_file(page,
+                                                               ignore_token);
                        unlock_page(page);
                }
        }
--- 2.6.9/mm/vmscan.c
+++ 2.6.9.1/mm/vmscan.c
@@ -377,7 +377,7 @@
                if (page_mapped(page) || PageSwapCache(page))
                        sc->nr_scanned++;
 
-               referenced = page_referenced(page, 1);
+               referenced = page_referenced(page, 1, sc->priority <= 0);
                /* In active use or really unfreeable?  Activate it. */
                if (referenced && page_mapping_inuse(page))
                        goto activate_locked;
@@ -715,7 +715,7 @@
                if (page_mapped(page)) {
                        if (!reclaim_mapped ||
                            (total_swap_pages == 0 && PageAnon(page)) ||
-                           page_referenced(page, 0)) {
+                           page_referenced(page, 0, sc->priority <= 0)) {
                                list_add(&page->lru, &l_active);
                                continue;
                        }
======================================================================================
# vm_pages_scanned_active_list.patch
#       mm/vmscan.c -1 +1
#
#       Stop kswapd from looping.
#
#       Patch by Nick Piggin 24 Oct 2004
#       Signed-off-by: Andrew Morton <akpm@osdl.org>
#       Signed-off-by: Linus Torvalds <torvalds@osdl.org>
#       Status: in 2.6.10
#
--- 2.6.9/mm/vmscan.c
+++ 2.6.9.1/mm/vmscan.c
@@ -574,7 +574,6 @@ static void shrink_cache(struct zone *zo
                        nr_taken++;
                }
                zone->nr_inactive -= nr_taken;
-               zone->pages_scanned += nr_taken;
                spin_unlock_irq(&zone->lru_lock);
 
                if (nr_taken == 0)
@@ -675,6 +674,7 @@ refill_inactive_zone(struct zone *zone, 
                }
                pgscanned++;
        }
+       zone->pages_scanned += pgscanned;
        zone->nr_active -= pgmoved;
        spin_unlock_irq(&zone->lru_lock);
 
======================================================================================
--
Please take it as a sign of my infinite respect for you,
that I insist on you doing all the work.
                                        -- Rusty Russell
