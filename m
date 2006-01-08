Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWAHFZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWAHFZc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 00:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbWAHFZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 00:25:31 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:16040 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751157AbWAHFZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 00:25:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=QjqSrEdJqG650wuJVGDb2Ykk9jDjBkYLSpSI5XAWhF/DKtseFKYOeggt1JHS0Ye6HMlU9cXki4OZFrGMjNlHVg5XnknMgDL3Ha/ZEr1iUI/I3rCqmuWlWdIbaf0+xK9NuukT2ZBpTQoRbdv6zd86fpy0gMZN8yKEo3fqT36Q2jQ=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20060108052531.2996.20958.sendpatchset@didi.local0.net>
In-Reply-To: <20060108052307.2996.39444.sendpatchset@didi.local0.net>
References: <20060108052307.2996.39444.sendpatchset@didi.local0.net>
Subject: [patch 4/4] mm: less atomic ops
Date: Sun, 8 Jan 2006 00:25:29 -0500
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
@@ -186,7 +186,7 @@ void fastcall __page_cache_release(struc
 		struct zone *zone = page_zone(page);
 		spin_lock_irqsave(&zone->lru_lock, flags);
 		BUG_ON(!PageLRU(page));
-		ClearPageLRU(page);
+		__ClearPageLRU(page);
 		del_page_from_lru(zone, page);
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
@@ -231,7 +231,7 @@ void release_pages(struct page **pages, 
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
