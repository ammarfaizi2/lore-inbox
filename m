Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936795AbWLFRBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936795AbWLFRBS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936798AbWLFRBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:01:17 -0500
Received: from 40.150.104.212.access.eclipse.net.uk ([212.104.150.40]:53762
	"EHLO localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S936493AbWLFRAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:00:55 -0500
Date: Wed, 6 Dec 2006 17:00:35 +0000
To: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Mel Gorman <mel@csn.ul.ie>,
       Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] lumpy ensure we respect zone boundaries
Message-ID: <9f8124c15f20c487101e5b2fd30ac13f@pinky>
References: <exportbomb.1165424343@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1165424343@pinky>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lumpy: ensure we respect zone boundaries

When scanning an aligned order N area ensure we only pull out pages
in the same zone as our tag page, else we will manipulate those
pages' LRU under the wrong zone lru_lock.  Bad.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0effa3e..85f626b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -660,6 +660,7 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 	struct page *page, *tmp;
 	unsigned long scan, pfn, end_pfn, page_pfn;
 	int active;
+	int zone_id;
 
 	for (scan = 0; scan < nr_to_scan && !list_empty(src); scan++) {
 		page = lru_to_page(src);
@@ -691,6 +692,7 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		 * surrounding the tag page.  Only take those pages of
 		 * the same active state as that tag page.
 		 */
+		zone_id = page_zone_id(page);
 		page_pfn = __page_to_pfn(page);
 		pfn = page_pfn & ~((1 << order) - 1);
 		end_pfn = pfn + (1 << order);
@@ -700,8 +702,10 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
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
