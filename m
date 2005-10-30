Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVJ3SfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVJ3SfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVJ3Sen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:34:43 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:46763 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932209AbVJ3SeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:34:21 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>
Message-Id: <20051030183419.22266.99114.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 5/7] Fragmentation Avoidance V19: 005_largealloc_tryharder
Date: Sun, 30 Oct 2005 18:34:20 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fragmentation avoidance patches increase our chances of satisfying high
order allocations.  So this patch takes more than one iteration at trying
to fulfill those allocations because, unlike before, the extra iterations
are often useful.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-004_fallback/mm/page_alloc.c linux-2.6.14-rc5-mm1-005_largealloc_tryharder/mm/page_alloc.c
--- linux-2.6.14-rc5-mm1-004_fallback/mm/page_alloc.c	2005-10-30 13:36:56.000000000 +0000
+++ linux-2.6.14-rc5-mm1-005_largealloc_tryharder/mm/page_alloc.c	2005-10-30 13:37:34.000000000 +0000
@@ -1127,6 +1127,7 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 	int do_retry;
 	int can_try_harder;
 	int did_some_progress;
+	int highorder_retry = 3;
 
 	might_sleep_if(wait);
 
@@ -1275,7 +1276,17 @@ rebalance:
 				goto got_pg;
 		}
 
-		out_of_memory(gfp_mask, order);
+		if (order < MAX_ORDER / 2)
+			out_of_memory(gfp_mask, order);
+
+		/*
+		 * Due to low fragmentation efforts, we try a little
+		 * harder to satisfy high order allocations and only
+		 * go OOM for low-order allocations
+		 */
+		if (order >= MAX_ORDER/2 && --highorder_retry > 0)
+				goto rebalance;
+
 		goto restart;
 	}
 
@@ -1292,6 +1303,8 @@ rebalance:
 			do_retry = 1;
 		if (gfp_mask & __GFP_NOFAIL)
 			do_retry = 1;
+		if (order >= MAX_ORDER/2 && --highorder_retry > 0)
+			do_retry = 1;
 	}
 	if (do_retry) {
 		blk_congestion_wait(WRITE, HZ/50);
