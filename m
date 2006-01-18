Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWARKlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWARKlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWARKlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:41:09 -0500
Received: from cantor.suse.de ([195.135.220.2]:21654 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932453AbWARKlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:41:03 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>
Message-Id: <20060118024139.10241.73020.sendpatchset@linux.site>
In-Reply-To: <20060118024106.10241.69438.sendpatchset@linux.site>
References: <20060118024106.10241.69438.sendpatchset@linux.site>
Subject: [patch 3/3] mm: PageActive no testset
Date: Wed, 18 Jan 2006 11:40:58 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PG_active is protected by zone->lru_lock, it does not need TestSet/TestClear
operations.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -997,8 +997,9 @@ refill_inactive_zone(struct zone *zone, 
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
@@ -356,8 +356,8 @@ void __pagevec_lru_add_active(struct pag
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
@@ -251,8 +251,6 @@ extern void __mod_page_state_offset(unsi
 #define PageActive(page)	test_bit(PG_active, &(page)->flags)
 #define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
 #define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
-#define TestClearPageActive(page) test_and_clear_bit(PG_active, &(page)->flags)
-#define TestSetPageActive(page) test_and_set_bit(PG_active, &(page)->flags)
 
 #define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
 #define SetPageSlab(page)	set_bit(PG_slab, &(page)->flags)
