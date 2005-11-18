Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbVKRUCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbVKRUCv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbVKRUCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:02:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34233 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161161AbVKRUCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:02:50 -0500
Date: Fri, 18 Nov 2005 12:02:37 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: [PATCH] SwapMig: Do not free the page in swap_page() 
Message-ID: <Pine.LNX.4.62.0511181200020.27515@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not free the page in swap_page() to allow the page to be managed by
the caller of migrate_page().

If the page count dropped to 1 then rely on the next loop in migrate_pages()
to deal with the page of freeing it directly.

Some whitespace cleanup.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc1-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc1-mm2.orig/mm/vmscan.c	2005-11-18 09:47:15.000000000 -0800
+++ linux-2.6.15-rc1-mm2/mm/vmscan.c	2005-11-18 10:04:05.000000000 -0800
@@ -627,41 +627,32 @@ static int swap_page(struct page *page)
 		case PAGE_KEEP:
 		case PAGE_ACTIVATE:
 			goto unlock_retry;
+
 		case PAGE_SUCCESS:
 			goto retry;
+
 		case PAGE_CLEAN:
 			; /* try to free the page below */
 		}
 	}
 
 	if (PagePrivate(page)) {
-		if (!try_to_release_page(page, GFP_KERNEL))
+		if (!try_to_release_page(page, GFP_KERNEL) ||
+		    (!mapping && page_count(page) == 1))
 			goto unlock_retry;
-		if (!mapping && page_count(page) == 1)
-			goto free_it;
 	}
 
-	if (!remove_mapping(mapping, page))
-		goto unlock_retry;		/* truncate got there first */
-
-free_it:
-	/*
-	 * We may free pages that were taken off the active list
-	 * by isolate_lru_page. However, free_hot_cold_page will check
-	 * if the active bit is set. So clear it.
-	 */
-	ClearPageActive(page);
-
-	list_del(&page->lru);
-	unlock_page(page);
-	put_page(page);
- 	return 0;
+	if (remove_mapping(mapping, page)) {
+		/* Success */
+		unlock_page(page);
+		return 0;
+	}
 
 unlock_retry:
 	unlock_page(page);
 
 retry:
-       return 1;
+	return 1;
 }
 /*
  * migrate_pages
