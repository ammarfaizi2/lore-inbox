Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVLEMBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVLEMBB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 07:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVLEMBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 07:01:00 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:14271 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932390AbVLEMBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 07:01:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=aEvaKUGsxLKs8/sx+A2Dz3H9QoksMfgrTC8dxv6eNoIiXl9teY8bPNH20eO6Wg0yId9NjT5+TIYW4ksVvsV00zQlyO0F0EdJf3MYHyTPxvgXbDKPOyvABTfR/PuRMiXtCN1Ei4R8evKO0NeFcCZF/F4n/S2dVoxNuSekqGKIlG8=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051205120029.3480.23573.sendpatchset@didi.local0.net>
In-Reply-To: <20051205115901.3480.60596.sendpatchset@didi.local0.net>
References: <20051205115901.3480.60596.sendpatchset@didi.local0.net>
Subject: [patch 4/4] mm: less atomic ops
Date: Mon, 5 Dec 2005 07:01:00 -0500
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
@@ -236,10 +236,12 @@ extern void __mod_page_state_offset(unsi
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
@@ -180,7 +180,7 @@ void fastcall __page_cache_release(struc
 		struct zone *zone = page_zone(page);
 		spin_lock_irqsave(&zone->lru_lock, flags);
 		BUG_ON(!PageLRU(page));
-		ClearPageLRU(page);
+		__ClearPageLRU(page);
 		del_page_from_lru(zone, page);
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
@@ -225,7 +225,7 @@ void release_pages(struct page **pages, 
 				spin_lock_irq(&zone->lru_lock);
 			}
 			BUG_ON(!PageLRU(page));
-			ClearPageLRU(page);
+			__ClearPageLRU(page);
 			del_page_from_lru(zone, page);
 		}
 		BUG_ON(page_count(page));
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
Send instant messages to your online friends http://au.messenger.yahoo.com 
