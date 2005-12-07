Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVLGKgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVLGKgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVLGKgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:36:07 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:57289 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750823AbVLGKgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:36:06 -0500
Date: Wed, 7 Dec 2005 19:02:22 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 13/16] mm: fix minor scan count bugs
Message-ID: <20051207110222.GA7570@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20051207104755.177435000@localhost.localdomain> <20051207105209.818705000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207105209.818705000@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here is the standalone version for -mm inclusion.


Subject: mm: fix minor scan count bugs

- in isolate_lru_pages(): reports one more scan. Fix it.
- in shrink_cache(): 0 pages taken does not mean 0 pages scanned. Fix it.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -837,7 +837,8 @@ static int isolate_lru_pages(int nr_to_s
 	struct page *page;
 	int scan = 0;
 
-	while (scan++ < nr_to_scan && !list_empty(src)) {
+	while (scan < nr_to_scan && !list_empty(src)) {
+		scan++;
 		page = lru_to_page(src);
 		prefetchw_prev_lru_page(page, src, flags);
 
@@ -886,14 +887,15 @@ static void shrink_cache(struct zone *zo
 		zone->pages_scanned += nr_scan;
 		spin_unlock_irq(&zone->lru_lock);
 
-		if (nr_taken == 0)
-			goto done;
-
 		max_scan -= nr_scan;
 		if (current_is_kswapd())
 			mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
 		else
 			mod_page_state_zone(zone, pgscan_direct, nr_scan);
+
+		if (nr_taken == 0)
+			goto done;
+
 		nr_freed = shrink_list(&page_list, sc);
 		if (current_is_kswapd())
 			mod_page_state(kswapd_steal, nr_freed);
