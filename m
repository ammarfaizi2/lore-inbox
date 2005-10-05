Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbVJEOrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbVJEOrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbVJEOqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:46:35 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:61582 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932635AbVJEOqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:46:09 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: akpm@osdl.org, Mel Gorman <mel@csn.ul.ie>, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, jschopp@austin.ibm.com,
       lhms-devel@lists.sourceforge.net
Message-Id: <20051005144607.11796.26661.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 4/7] Fragmentation Avoidance V16: 004_largealloc_tryharder
Date: Wed,  5 Oct 2005 15:46:07 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fragmentation avoidance patches increase our chances of satisfying high
order allocations.  So this patch takes more than one iteration at trying
to fulfill those allocations because, unlike before, the extra iterations
are often useful.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-003_fragcore/mm/page_alloc.c linux-2.6.14-rc3-004_largealloc_tryharder/mm/page_alloc.c
--- linux-2.6.14-rc3-003_fragcore/mm/page_alloc.c	2005-10-05 12:14:44.000000000 +0100
+++ linux-2.6.14-rc3-004_largealloc_tryharder/mm/page_alloc.c	2005-10-05 12:15:23.000000000 +0100
@@ -939,6 +939,7 @@ __alloc_pages(unsigned int __nocast gfp_
 	int do_retry;
 	int can_try_harder;
 	int did_some_progress;
+	int highorder_retry = 3;
 
 	might_sleep_if(wait);
 
@@ -1087,7 +1088,16 @@ rebalance:
 				goto got_pg;
 		}
 
-		out_of_memory(gfp_mask, order);
+		if (order < MAX_ORDER/2)
+			out_of_memory(gfp_mask, order);
+
+		/*
+		 * Due to low fragmentation efforts, we should try a little
+		 * harder to satisfy high order allocations
+		 */
+		if (order >= MAX_ORDER/2 && --highorder_retry > 0)
+			goto rebalance;
+
 		goto restart;
 	}
 
@@ -1104,6 +1114,8 @@ rebalance:
 			do_retry = 1;
 		if (gfp_mask & __GFP_NOFAIL)
 			do_retry = 1;
+		if (order >= MAX_ORDER/2 && --highorder_retry > 0)
+			do_retry = 1;
 	}
 	if (do_retry) {
 		blk_congestion_wait(WRITE, HZ/50);
