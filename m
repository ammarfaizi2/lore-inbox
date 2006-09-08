Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWIHMZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWIHMZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 08:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWIHMZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 08:25:53 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:24980
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750942AbWIHMZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 08:25:52 -0400
Date: Fri, 8 Sep 2006 13:25:17 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 1/5] linear reclaim add order to reclaim path
Message-ID: <20060908122517.GA898@shadowen.org>
References: <exportbomb.1157718286@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1157718286@pinky>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linear reclaim add order to reclaim path

In order to select an appropriate reclaim algorithm we need to
know the order of the original failure.  Pass the order down
in the reclaim path.

Added in: V1

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/fs/buffer.c b/fs/buffer.c
index 1e0d740..bc2e7ef 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -371,7 +371,7 @@ static void free_more_memory(void)
 	for_each_online_pgdat(pgdat) {
 		zones = pgdat->node_zonelists[gfp_zone(GFP_NOFS)].zones;
 		if (*zones)
-			try_to_free_pages(zones, GFP_NOFS);
+			try_to_free_pages(zones, 0, GFP_NOFS);
 	}
 }
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 051d1c5..27b963f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -187,7 +187,7 @@ extern int rotate_reclaimable_page(struc
 extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
-extern unsigned long try_to_free_pages(struct zone **, gfp_t);
+extern unsigned long try_to_free_pages(struct zone **, int, gfp_t);
 extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_swappiness;
 extern int remove_mapping(struct address_space *mapping, struct page *page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ea38560..dc41137 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1132,7 +1132,7 @@ rebalance:
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
-	did_some_progress = try_to_free_pages(zonelist->zones, gfp_mask);
+	did_some_progress = try_to_free_pages(zonelist->zones, order, gfp_mask);
 
 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bad9c05..afa7c03 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -978,7 +978,7 @@ static unsigned long shrink_zones(int pr
  * holds filesystem locks which prevent writeout this might not work, and the
  * allocation attempt will fail.
  */
-unsigned long try_to_free_pages(struct zone **zones, gfp_t gfp_mask)
+unsigned long try_to_free_pages(struct zone **zones, int order, gfp_t gfp_mask)
 {
 	int priority;
 	int ret = 0;
