Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757430AbWKWQut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbWKWQut (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757429AbWKWQut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:50:49 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:39817
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1757428AbWKWQur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:50:47 -0500
Date: Thu, 23 Nov 2006 16:50:10 +0000
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] lumpy ensure we respect zone boundaries
Message-ID: <bf938e31d7fe72a5128a5bd22bb70480@pinky>
References: <exportbomb.1164300519@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1164300519@pinky>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lumpy: ensure we respect zone boundaries

When scanning an aligned order N area ensure we only pull out pages
in the same zone as our tag page, else we will manipulate those
pages' LRU under the wrong zone lru_lock.  Bad.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3b6ef79..e3be888 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -663,6 +663,7 @@ static unsigned long isolate_lru_pages(u
 	struct page *page, *tmp;
 	unsigned long scan, pfn, end_pfn, page_pfn;
 	int active;
+	int zone_id;
 
 	for (scan = 0; scan < nr_to_scan && !list_empty(src); scan++) {
 		page = lru_to_page(src);
@@ -694,6 +695,7 @@ static unsigned long isolate_lru_pages(u
 		 * surrounding the tag page.  Only take those pages of
 		 * the same active state as that tag page.
 		 */
+		zone_id = page_zone_id(page);
 		page_pfn = __page_to_pfn(page);
 		pfn = page_pfn & ~((1 << order) - 1);
 		end_pfn = pfn + (1 << order);
@@ -703,8 +705,10 @@ static unsigned long isolate_lru_pages(u
 			if (unlikely(!pfn_valid(pfn)))
 				break;
 
-			scan++;
 			tmp = __pfn_to_page(pfn);
+			if (unlikely(page_zone_id(tmp) != zone_id))
+				continue;
+			scan++;
 			switch (__isolate_lru_page(tmp, active)) {
 			case 0:
 				list_move(&tmp->lru, dst);
