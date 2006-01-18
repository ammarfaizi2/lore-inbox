Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWARKle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWARKle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWARKld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:41:33 -0500
Received: from ns2.suse.de ([195.135.220.15]:20961 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932463AbWARKlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:41:14 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>
Message-Id: <20060118024149.10241.6312.sendpatchset@linux.site>
In-Reply-To: <20060118024106.10241.69438.sendpatchset@linux.site>
References: <20060118024106.10241.69438.sendpatchset@linux.site>
Subject: [patch 4/4] mm: less atomic ops
Date: Wed, 18 Jan 2006 11:41:09 +0100 (CET)
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
@@ -204,7 +204,7 @@ void fastcall __page_cache_release(struc
 		struct zone *zone = page_zone(page);
 		spin_lock_irqsave(&zone->lru_lock, flags);
 		BUG_ON(!PageLRU(page));
-		ClearPageLRU(page);
+		__ClearPageLRU(page);
 		del_page_from_lru(zone, page);
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
@@ -248,7 +248,7 @@ void release_pages(struct page **pages, 
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
