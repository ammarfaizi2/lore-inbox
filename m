Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVLEMAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVLEMAf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 07:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVLEMAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 07:00:35 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:12648 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932390AbVLEMAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 07:00:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=6s9XfzZi1ZMxw7vcAd3wjz7uQlQRxV5g5jUoArDao8tW96M0+1W3m10N2u2AJIb/e5fZAUnAy1cUAphiFqPMKrTvcaN3ULQtlCuXF5hbcxfdwKNUJh3MNpHyDBr1t8DmIKWbXBIV/4+0jbY8QAL9YAmMbv7GIJ7h8U61Y5FRKaQ=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051205120002.3480.97458.sendpatchset@didi.local0.net>
In-Reply-To: <20051205115901.3480.60596.sendpatchset@didi.local0.net>
References: <20051205115901.3480.60596.sendpatchset@didi.local0.net>
Subject: [patch 3/4] mm: PageActive no testset
Date: Mon, 5 Dec 2005 07:00:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PG_active is protected by zone->lru_lock, it does not need TestSet/TestClear
operations.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -781,8 +781,9 @@ refill_inactive_zone(struct zone *zone, 
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
 		BUG_ON(PageLRU(page));
 		SetPageLRU(page);
-		if (!TestClearPageActive(page))
-			BUG();
+		BUG_ON(!PageActive(page));
+		ClearPageActive(page);
+
 		list_move(&page->lru, &zone->inactive_list);
 		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c
+++ linux-2.6/mm/swap.c
@@ -334,8 +334,8 @@ void __pagevec_lru_add_active(struct pag
 		}
 		BUG_ON(PageLRU(page));
 		SetPageLRU(page);
-		if (TestSetPageActive(page))
-			BUG();
+		BUG_ON(PageActive(page));
+		SetPageActive(page);
 		add_page_to_active_list(zone, page);
 	}
 	if (zone)
Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -240,8 +240,6 @@ extern void __mod_page_state_offset(unsi
 #define PageActive(page)	test_bit(PG_active, &(page)->flags)
 #define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
 #define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
-#define TestClearPageActive(page) test_and_clear_bit(PG_active, &(page)->flags)
-#define TestSetPageActive(page) test_and_set_bit(PG_active, &(page)->flags)
 
 #define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
 #define SetPageSlab(page)	set_bit(PG_slab, &(page)->flags)
Send instant messages to your online friends http://au.messenger.yahoo.com 
