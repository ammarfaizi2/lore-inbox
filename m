Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVK1UoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVK1UoB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVK1UoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:44:01 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48559 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932248AbVK1Uno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:43:44 -0500
Date: Mon, 28 Nov 2005 12:42:54 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>, Cliff Wickman <cpw@sgi.com>
Message-Id: <20051128204254.10037.17837.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051128204244.10037.43868.sendpatchset@schroedinger.engr.sgi.com>
References: <20051128204244.10037.43868.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/7] Swap Migration: Consolidate successful migration handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SwapMig: consolidate successful migration handling

Handle the moving of migrated pages to the "moved" list in a common branch
for rc == 0.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc2-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc2-mm1.orig/mm/vmscan.c	2005-11-28 11:23:45.000000000 -0800
+++ linux-2.6.15-rc2-mm1/mm/vmscan.c	2005-11-28 11:25:14.000000000 -0800
@@ -702,11 +702,11 @@ redo:
 	list_for_each_entry_safe(page, page2, from, lru) {
 		cond_resched();
 
-		if (page_count(page) == 1) {
+		rc = 0;
+		if (page_count(page) == 1)
 			/* page was freed from under us. So we are done. */
-			list_move(&page->lru, moved);
-			continue;
-		}
+			goto next;
+
 		/*
 		 * Skip locked pages during the first two passes to give the
 		 * functions holding the lock time to release the page. Later we
@@ -747,10 +747,7 @@ redo:
 		 * Page is properly locked and writeback is complete.
 		 * Try to migrate the page.
 		 */
-		if (!swap_page(page)) {
-			list_move(&page->lru, moved);
-			continue;
-		}
+		rc = swap_page(page);
 		goto next;
 
 unlock_page:
@@ -761,9 +758,12 @@ next:
 			retry++;
 
 		else if (rc) {
-			/* Permanent failure to migrate the page */
+			/* Permanent failure */
 			list_move(&page->lru, failed);
 			nr_failed++;
+		} else {
+			/* Success */
+			list_move(&page->lru, moved);
 		}
 	}
 	if (retry && pass++ < 10)
