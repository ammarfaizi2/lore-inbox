Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVLGK0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVLGK0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVLGK0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:26:04 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:49594 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750807AbVLGKZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:25:58 -0500
Message-Id: <20051207105209.818705000@localhost.localdomain>
References: <20051207104755.177435000@localhost.localdomain>
Date: Wed, 07 Dec 2005 18:48:08 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 13/16] mm: fix minor scan count bugs
Content-Disposition: inline; filename=mm-scan-accounting-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- in isolate_lru_pages(): reports one more scan. Fix it.
- in shrink_cache(): 0 pages taken does not mean 0 pages scanned. Fix it.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/vmscan.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -864,7 +864,8 @@ static int isolate_lru_pages(int nr_to_s
 	struct page *page;
 	int scan = 0;
 
-	while (scan++ < nr_to_scan && !list_empty(src)) {
+	while (scan < nr_to_scan && !list_empty(src)) {
+		scan++;
 		page = lru_to_page(src);
 		prefetchw_prev_lru_page(page, src, flags);
 
@@ -911,14 +912,15 @@ static void shrink_cache(struct zone *zo
 	update_zone_age(zone, nr_scan);
 	spin_unlock_irq(&zone->lru_lock);
 
-	if (nr_taken == 0)
-		return;
-
 	sc->nr_scanned += nr_scan;
 	if (current_is_kswapd())
 		mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
 	else
 		mod_page_state_zone(zone, pgscan_direct, nr_scan);
+
+	if (nr_taken == 0)
+		return;
+
 	nr_freed = shrink_list(&page_list, sc);
 	if (current_is_kswapd())
 		mod_page_state(kswapd_steal, nr_freed);

--
