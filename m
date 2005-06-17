Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVFQDX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVFQDX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 23:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVFQDX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 23:23:26 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:53381 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261372AbVFQDXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 23:23:18 -0400
Subject: [patch] vm early reclaim orphaned pages
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, mason@suse.de
Content-Type: multipart/mixed; boundary="=-mmRXfSJcAFRAX+/A2ZOb"
Date: Fri, 17 Jun 2005 13:23:10 +1000
Message-Id: <1118978590.5261.4.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mmRXfSJcAFRAX+/A2ZOb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This any good?

The workload in question is bonnie, with ext3 data=ordered.
Chris has some ReiserFS workloads where orphaned pages build
up that I think were improved.


-- 
SUSE Labs, Novell Inc.



--=-mmRXfSJcAFRAX+/A2ZOb
Content-Disposition: attachment; filename=vm-early-reclaim-orphaned.patch
Content-Type: text/x-patch; name=vm-early-reclaim-orphaned.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

We have workloads where orphaned pages build up and appear to slow
the system down when it starts reclaiming memory.

Stripping the referenced bit from orphaned pages and putting them
on the end of the inactive list should help improve reclaim.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/truncate.c
===================================================================
--- linux-2.6.orig/mm/truncate.c	2005-06-01 16:09:34.000000000 +1000
+++ linux-2.6/mm/truncate.c	2005-06-17 13:01:01.090334444 +1000
@@ -45,11 +45,30 @@
 static void
 truncate_complete_page(struct address_space *mapping, struct page *page)
 {
+	int orphaned = 0;
+	
 	if (page->mapping != mapping)
 		return;
 
 	if (PagePrivate(page))
-		do_invalidatepage(page, 0);
+		orphaned = !(do_invalidatepage(page, 0));
+
+	if (orphaned) {
+		/*
+		 * Put orphaned pagecache on the end of the inactive
+		 * list so it can get reclaimed quickly.
+		 */
+		unsigned long flags;
+		struct zone *zone = page_zone(page);
+		spin_lock_irqsave(&zone->lru_lock, flags);
+		ClearPageReferenced(page);
+		if (PageLRU(page)) {
+			list_move_tail(&page->lru, &zone->inactive_list);
+			if (PageActive(page))
+				ClearPageActive(page);
+		}
+		spin_unlock_irqrestore(&zone->lru_lock, flags);
+	}
 
 	clear_page_dirty(page);
 	ClearPageUptodate(page);

--=-mmRXfSJcAFRAX+/A2ZOb--

Send instant messages to your online friends http://au.messenger.yahoo.com 
