Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030694AbWF0EnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030694AbWF0EnQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030701AbWF0EnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:43:15 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:56795 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030694AbWF0Emv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/13] [Suspend2] Page_alloc paranoia.
Date: Tue, 27 Jun 2006 14:42:50 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044248.15066.52507.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add paranoia to the page_alloc code to ensure we don't start page reclaim
during suspending.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 mm/page_alloc.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 253a450..838ae19 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/pagevec.h>
 #include <linux/blkdev.h>
 #include <linux/slab.h>
@@ -37,6 +38,7 @@
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
 #include <linux/mempolicy.h>
+#include "../kernel/power/pageflags.h"
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -905,7 +907,8 @@ get_page_from_freelist(gfp_t gfp_mask, u
 			else
 				mark = (*z)->pages_high;
 			if (!zone_watermark_ok(*z, order, mark,
-				    classzone_idx, alloc_flags))
+				    classzone_idx, alloc_flags) &&
+			    likely(!test_freezer_state(FREEZER_ON)))
 				if (!zone_reclaim_mode ||
 				    !zone_reclaim(*z, gfp_mask, order))
 					continue;
@@ -950,10 +953,12 @@ restart:
 	if (page)
 		goto got_pg;
 
-	do {
-		if (cpuset_zone_allowed(*z, gfp_mask|__GFP_HARDWALL))
-			wakeup_kswapd(*z, order);
-	} while (*(++z));
+	if (likely(!test_freezer_state(FREEZER_ON))) {
+		do {
+			if (cpuset_zone_allowed(*z, gfp_mask|__GFP_HARDWALL))
+				wakeup_kswapd(*z, order);
+		} while (*(++z));
+	}
 
 	/*
 	 * OK, we're below the kswapd watermark and have kicked background
@@ -997,6 +1002,7 @@ nofail_alloc:
 			if (page)
 				goto got_pg;
 			if (gfp_mask & __GFP_NOFAIL) {
+				BUG_ON(unlikely(test_freezer_state(FREEZING_COMPLETE)));
 				blk_congestion_wait(WRITE, HZ/50);
 				goto nofail_alloc;
 			}
@@ -1009,6 +1015,8 @@ nofail_alloc:
 		goto nopage;
 
 rebalance:
+	BUG_ON(unlikely(test_freezer_state(FREEZER_ON)));
+
 	cond_resched();
 
 	/* We now go into synchronous reclaim */

--
Nigel Cunningham		nigel at suspend2 dot net
