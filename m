Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161330AbWASTXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161330AbWASTXc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161341AbWASTXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:23:32 -0500
Received: from mail.suse.de ([195.135.220.2]:48054 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161330AbWASTXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:23:24 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <20060119192210.11913.49481.sendpatchset@linux.site>
In-Reply-To: <20060119192131.11913.27564.sendpatchset@linux.site>
References: <20060119192131.11913.27564.sendpatchset@linux.site>
Subject: [patch 4/6] mm: less atomic ops
Date: Thu, 19 Jan 2006 20:23:20 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the page release paths, we can be sure that nobody will mess with our
page->flags because the refcount has dropped to 0. So no need for atomic
operations here.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -247,10 +247,12 @@ extern void __mod_page_state_offset(unsi
 #define PageLRU(page)		test_bit(PG_lru, &(page)->flags)
 #define SetPageLRU(page)	set_bit(PG_lru, &(page)->flags)
 #define ClearPageLRU(page)	clear_bit(PG_lru, &(page)->flags)
+#define __ClearPageLRU(page)	__clear_bit(PG_lru, &(page)->flags)
 
 #define PageActive(page)	test_bit(PG_active, &(page)->flags)
 #define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
 #define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
+#define __ClearPageActive(page)	__clear_bit(PG_active, &(page)->flags)
 
 #define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
 #define SetPageSlab(page)	set_bit(PG_slab, &(page)->flags)
Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c
+++ linux-2.6/mm/swap.c
@@ -212,7 +212,7 @@ void fastcall __page_cache_release(struc
 		struct zone *zone = page_zone(page);
 		spin_lock_irqsave(&zone->lru_lock, flags);
 		BUG_ON(!PageLRU(page));
-		ClearPageLRU(page);
+		__ClearPageLRU(page);
 		del_page_from_lru(zone, page);
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
@@ -256,7 +256,7 @@ void release_pages(struct page **pages, 
 				spin_lock_irq(&zone->lru_lock);
 			}
 			BUG_ON(!PageLRU(page));
-			ClearPageLRU(page);
+			__ClearPageLRU(page);
 			del_page_from_lru(zone, page);
 		}
 
Index: linux-2.6/include/linux/mm_inline.h
===================================================================
--- linux-2.6.orig/include/linux/mm_inline.h
+++ linux-2.6/include/linux/mm_inline.h
@@ -32,7 +32,7 @@ del_page_from_lru(struct zone *zone, str
 {
 	list_del(&page->lru);
 	if (PageActive(page)) {
-		ClearPageActive(page);
+		__ClearPageActive(page);
 		zone->nr_active--;
 	} else {
 		zone->nr_inactive--;
