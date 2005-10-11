Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbVJKPO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbVJKPO0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 11:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVJKPNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 11:13:06 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:3534 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751409AbVJKPMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 11:12:53 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: jschopp@austin.ibm.com, Mel Gorman <mel@csn.ul.ie>, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20051011151251.16178.24064.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 6/8] Fragmentation Avoidance V17: 006_largealloc_tryharder
Date: Tue, 11 Oct 2005 16:12:52 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fragmentation avoidance patches increase our chances of satisfying high
order allocations.  So this patch takes more than one iteration at trying
to fulfill those allocations because, unlike before, the extra iterations
are often useful.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-005_fallback/mm/page_alloc.c linux-2.6.14-rc3-006_largealloc_tryharder/mm/page_alloc.c
--- linux-2.6.14-rc3-005_fallback/mm/page_alloc.c	2005-10-11 12:09:27.000000000 +0100
+++ linux-2.6.14-rc3-006_largealloc_tryharder/mm/page_alloc.c	2005-10-11 12:11:31.000000000 +0100
@@ -1055,6 +1055,7 @@ __alloc_pages(unsigned int __nocast gfp_
 	int do_retry;
 	int can_try_harder;
 	int did_some_progress;
+	int highorder_retry = 3;
 
 	might_sleep_if(wait);
 
@@ -1203,8 +1204,19 @@ rebalance:
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
+
 	}
 
 	/*
@@ -1220,6 +1232,8 @@ rebalance:
 			do_retry = 1;
 		if (gfp_mask & __GFP_NOFAIL)
 			do_retry = 1;
+		if (order >= MAX_ORDER/2 && --highorder_retry > 0)
+			do_retry = 1;
 	}
 	if (do_retry) {
 		blk_congestion_wait(WRITE, HZ/50);
