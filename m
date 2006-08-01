Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWHAR5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWHAR5a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWHAR5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:57:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63894 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750810AbWHAR53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:57:29 -0400
Date: Tue, 1 Aug 2006 13:57:16 -0400
From: Dave Jones <davej@redhat.com>
To: akpm@osdl.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: clear vm_reclaimable when we free pages.
Message-ID: <20060801175716.GB22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, akpm@osdl.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are two places where we reclaim free pages, but we never
update the all_unreclaimable flag for the relevant zone.
This patch helped reduce the frequency of oom-kills under high load
for us a while back, and we've been carrying it since.
I posted this a few months back and from what I recall it didn't
get a great deal of interest.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/mm/filemap.c~	2005-12-10 01:47:15.000000000 -0500
+++ linux-2.6/mm/filemap.c	2005-12-10 01:47:46.000000000 -0500
@@ -471,11 +471,18 @@ EXPORT_SYMBOL(unlock_page);
  */
 void end_page_writeback(struct page *page)
 {
+	struct zone *zone = page_zone(page);
 	if (!TestClearPageReclaim(page) || rotate_reclaimable_page(page)) {
 		if (!test_clear_page_writeback(page))
 			BUG();
 	}
 	smp_mb__after_clear_bit();
+	if (zone->all_unreclaimable) {
+		spin_lock(&zone->lock);
+		zone->all_unreclaimable = 0;
+		zone->pages_scanned = 0;
+		spin_unlock(&zone->lock);
+	}
 	wake_up_page(page, PG_writeback);
 }
 EXPORT_SYMBOL(end_page_writeback);
--- linux-2.6/mm/page_alloc.c~	2006-01-09 13:40:03.000000000 -0500
+++ linux-2.6/mm/page_alloc.c	2006-01-09 13:40:50.000000000 -0500
@@ -722,6 +722,11 @@ static void fastcall free_hot_cold_page(
 	if (pcp->count >= pcp->high) {
 		free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
 		pcp->count -= pcp->batch;
+	} else if (zone->all_unreclaimable) {
+		spin_lock(&zone->lock);
+		zone->all_unreclaimable = 0;
+		zone->pages_scanned = 0;
+		spin_unlock(&zone->lock);
 	}
 	local_irq_restore(flags);
 	put_cpu();

-- 
http://www.codemonkey.org.uk
