Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSJOU46>; Tue, 15 Oct 2002 16:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264821AbSJOU45>; Tue, 15 Oct 2002 16:56:57 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:8847 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S264818AbSJOU4i>; Tue, 15 Oct 2002 16:56:38 -0400
Date: Tue, 15 Oct 2002 22:03:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pagevec freeze
Message-ID: <Pine.LNX.4.44.0210152202070.1521-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

refill_inactive_zone stuck circling the one-page active_list with
lru_lock and interrupts disabled, if concurrent release_pages has
done its put_page_testzero and is now spinning for that lru_lock.

(I haven't done a patch for include/linux/pagevec.h, but when working
on this freeze, I noticed that pagevec_add becomes rather unfriendly
once you get into NMIs and BUGs - overshoots PAGEVEC_SIZE and corrupts
beyond.  Perhaps you'd say all bets are off then anyway, or perhaps
pagevec_space should be signed, and tested before rather than after?)

--- 2.5.42-mm3/mm/vmscan.c	Tue Oct 15 06:43:41 2002
+++ linux/mm/vmscan.c	Tue Oct 15 13:14:35 2002
@@ -542,10 +542,13 @@
 	long mapped_ratio;
 	long distress;
 	long swap_tendency;
+	int max_scan;
 
 	lru_add_drain();
 	spin_lock_irq(&zone->lru_lock);
-	while (nr_pages && !list_empty(&zone->active_list)) {
+	max_scan = zone->nr_active;
+	while (max_scan && nr_pages && !list_empty(&zone->active_list)) {
+		max_scan--;
 		page = list_entry(zone->active_list.prev, struct page, lru);
 		prefetchw_prev_lru_page(page, &zone->active_list, flags);
 		if (!TestClearPageLRU(page))

