Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWCGBmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWCGBmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWCGBmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:42:11 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:59349 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932600AbWCGBmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:42:09 -0500
Date: Tue, 7 Mar 2006 09:47:11 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mm: shrink_inactive_lis() nr_scan accounting fix
Message-ID: <20060307014711.GB5560@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In shrink_inactive_lis(), nr_scan is not accounted when nr_taken is 0.
But 0 pages taken does not mean 0 pages scanned.

Move the goto statement below the accounting code to fix it.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

--- linux-2.6.16-rc5-mm2.orig/mm/vmscan.c
+++ linux-2.6.16-rc5-mm2/mm/vmscan.c
@@ -1132,9 +1132,6 @@ static unsigned long shrink_inactive_lis
 		zone->pages_scanned += nr_scan;
 		spin_unlock_irq(&zone->lru_lock);
 
-		if (nr_taken == 0)
-			goto done;
-
 		nr_scanned += nr_scan;
 		nr_freed = shrink_page_list(&page_list, sc);
 		nr_reclaimed += nr_freed;
@@ -1146,6 +1143,11 @@ static unsigned long shrink_inactive_lis
 			__mod_page_state_zone(zone, pgscan_direct, nr_scan);
 		__mod_page_state_zone(zone, pgsteal, nr_freed);
 
+		if (nr_taken == 0) {
+			local_irq_enable();
+			goto done;
+		}
+
 		spin_lock(&zone->lru_lock);
 		/*
 		 * Put back any unfreeable pages.
