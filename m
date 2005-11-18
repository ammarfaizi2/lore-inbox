Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161169AbVKRUFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbVKRUFS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbVKRUFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:05:18 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:20619 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1161155AbVKRUFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:05:16 -0500
Date: Fri, 18 Nov 2005 12:05:02 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: [PATCH] SwapMig: Switch error handling in migrate_pages to use -Exx
In-Reply-To: <Pine.LNX.4.62.0511181200020.27515@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0511181202440.27515@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511181200020.27515@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use -Exxx instead of numeric return codes and cleanup the code
in migrate_pages() using -Exx error codes.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc1-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc1-mm2.orig/mm/vmscan.c	2005-11-18 10:04:05.000000000 -0800
+++ linux-2.6.15-rc1-mm2/mm/vmscan.c	2005-11-18 10:12:01.000000000 -0800
@@ -608,10 +608,6 @@ int putback_lru_pages(struct list_head *
 /*
  * swapout a single page
  * page is locked upon entry, unlocked on exit
- *
- * return codes:
- *	0 = complete
- *	1 = retry
  */
 static int swap_page(struct page *page)
 {
@@ -652,7 +648,7 @@ unlock_retry:
 	unlock_page(page);
 
 retry:
-	return 1;
+	return -EAGAIN;
 }
 /*
  * migrate_pages
@@ -671,6 +667,8 @@ retry:
  * is only swapping out pages and never touches the second
  * list. The direct migration patchset
  * extends this function to avoid the use of swap.
+ *
+ * Return: Number of pages not migrated when "to" ran empty.
  */
 int migrate_pages(struct list_head *from, struct list_head *to,
 		  struct list_head *moved, struct list_head *failed)
@@ -681,6 +679,7 @@ int migrate_pages(struct list_head *from
 	struct page *page;
 	struct page *page2;
 	int swapwrite = current->flags & PF_SWAPWRITE;
+	int rc;
 
 	if (!swapwrite)
 		current->flags |= PF_SWAPWRITE;
@@ -702,11 +701,12 @@ redo:
 		 * use lock_page() to have a higher chance of acquiring the
 		 * lock.
 		 */
+		rc = -EAGAIN;
 		if (pass > 2)
 			lock_page(page);
 		else
 			if (TestSetPageLocked(page))
-				goto retry_later;
+				goto next;
 
 		/*
 		 * Only wait on writeback if we have already done a pass where
@@ -715,18 +715,19 @@ redo:
 		if (pass > 0) {
 			wait_on_page_writeback(page);
 		} else {
-			if (PageWriteback(page)) {
-				unlock_page(page);
-				goto retry_later;
-			}
+			if (PageWriteback(page))
+				goto unlock_page;
 		}
 
+		/*
+		 * Anonymous pages must have swap cache references otherwise
+		 * the information contained in the page maps cannot be
+		 * preserved.
+		 */
 		if (PageAnon(page) && !PageSwapCache(page)) {
 			if (!add_to_swap(page, GFP_KERNEL)) {
-				unlock_page(page);
-				list_move(&page->lru, failed);
-				nr_failed++;
-				continue;
+				rc = -ENOMEM;
+				goto unlock_page;
 			}
 		}
 
@@ -738,8 +739,19 @@ redo:
 			list_move(&page->lru, moved);
 			continue;
 		}
-retry_later:
-		retry++;
+
+unlock_page:
+		unlock_page(page);
+
+next:
+		if (rc == -EAGAIN)
+			retry++;
+
+		else if (rc) {
+			/* Permanent failure to migrate the page */
+			list_move(&page->lru, failed);
+			nr_failed++;
+		}
 	}
 	if (retry && pass++ < 10)
 		goto redo;
