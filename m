Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVI2WCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVI2WCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVI2WCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:02:14 -0400
Received: from fmr21.intel.com ([143.183.121.13]:17795 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751316AbVI2WCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:02:13 -0400
Date: Thu, 29 Sep 2005 15:01:55 -0700
From: "Seth, Rohit" <rohit.seth@intel.com>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] earlier allocation of order 0 pages from pcp in __alloc_pages
Message-ID: <20050929150155.A15646@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	[PATCH]: Try to service a order 0 page request in __alloc_pages from the pcp list before checking the aone_watermarks.

        Try to service a order 0 page request from pcp list.  This will allow us to not check and possibly start the reclaim activity when there are free pages present on the pcp.  This early allocation does not try to replenish an empty pcp.

        Signed-off-by: Rohit Seth <rohit.seth@intel.com>

--- linux-2.6.14-rc2-mm1.org/mm/page_alloc.c	2005-09-27 10:03:51.000000000 -0700
+++ linux-2.6.14-rc2-mm1/mm/page_alloc.c	2005-09-28 17:38:15.000000000 -0700
@@ -716,6 +716,39 @@
 		clear_highpage(page + i);
 }
 
+/* This routine allocates a order 0 page from cpu's pcp list when one is present.
+ * It does not try to remove the pages from zone_free_list as the zone low
+ * water mark has not yet been checked.
+ */
+
+static struct page *
+remove_from_pcp(struct zone *zone, unsigned int __nocast gfp_flags)
+{
+	unsigned long flags;
+	struct per_cpu_pages *pcp;
+	struct page *page = NULL;
+	int cold = !!(gfp_flags & __GFP_COLD);
+
+	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
+	local_irq_save(flags);
+	if (pcp->count > pcp->low) {
+		page = list_entry(pcp->list.next, struct page, lru);
+		list_del(&page->lru);
+		pcp->count--;
+	}
+	local_irq_restore(flags);
+	put_cpu();
+
+	if (page != NULL) {
+		mod_page_state_zone(zone, pgalloc, 1 );
+		prep_new_page(page, 0);
+
+		if (gfp_flags & __GFP_ZERO)
+			prep_zero_page(page, 0, gfp_flags);
+	}
+	return page;
+}
+
 /*
  * Really, prep_compound_page() should be called from __rmqueue_bulk().  But
  * we cheat by calling it from here, in the order > 0 path.  Saves a branch
@@ -905,6 +938,12 @@
 		if (!cpuset_zone_allowed(z, __GFP_HARDWALL))
 			continue;
 
+		if (order == 0) {
+			page = remove_from_pcp(z, gfp_mask);
+			if (page)
+				goto got_pg;
+		}
+
 		/*
 		 * If the zone is to attempt early page reclaim then this loop
 		 * will try to reclaim pages and check the watermark a second
