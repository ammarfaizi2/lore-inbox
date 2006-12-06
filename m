Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936691AbWLFRAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936691AbWLFRAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936889AbWLFRAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:00:43 -0500
Received: from 40.150.104.212.access.eclipse.net.uk ([212.104.150.40]:53756
	"EHLO localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S936691AbWLFRAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:00:41 -0500
Date: Wed, 6 Dec 2006 17:00:05 +0000
To: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Mel Gorman <mel@csn.ul.ie>,
       Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] lumpy cleanup a missplaced comment and simplify some code
Message-ID: <4f3dd33d974901c0c6dbf313d72ef7f9@pinky>
References: <exportbomb.1165424343@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1165424343@pinky>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lumpy: cleanup a missplaced comment and simplify some code

Move the comment for isolate_lru_pages() back to its function
and comment the new function.  Add some running commentry on the
area scan.  Cleanup the indentation on switch to match the majority
view in mm/*.  Finally, clarify the boundary pfn calculations.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0f2d961..0effa3e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -606,21 +606,14 @@ keep:
 }
 
 /*
- * zone->lru_lock is heavily contended.  Some of the functions that
- * shrink the lists perform better by taking out a batch of pages
- * and working on them outside the LRU lock.
+ * Attempt to remove the specified page from its LRU.  Only take this
+ * page if it is of the appropriate PageActive status.  Pages which
+ * are being freed elsewhere are also ignored.
  *
- * For pagecache intensive workloads, this function is the hottest
- * spot in the kernel (apart from copy_*_user functions).
- *
- * Appropriate locks must be held before calling this function.
+ * @page:	page to consider
+ * @active:	active/inactive flag only take pages of this type
  *
- * @nr_to_scan:	The number of pages to look through on the list.
- * @src:	The LRU list to pull pages off.
- * @dst:	The temp list to put pages on to.
- * @scanned:	The number of pages that were scanned.
- *
- * returns how many pages were moved onto *@dst.
+ * returns 0 on success, -ve errno on failure.
  */
 int __isolate_lru_page(struct page *page, int active)
 {
@@ -642,6 +635,23 @@ int __isolate_lru_page(struct page *page, int active)
 	return ret;
 }
 
+/*
+ * zone->lru_lock is heavily contended.  Some of the functions that
+ * shrink the lists perform better by taking out a batch of pages
+ * and working on them outside the LRU lock.
+ *
+ * For pagecache intensive workloads, this function is the hottest
+ * spot in the kernel (apart from copy_*_user functions).
+ *
+ * Appropriate locks must be held before calling this function.
+ *
+ * @nr_to_scan:	The number of pages to look through on the list.
+ * @src:	The LRU list to pull pages off.
+ * @dst:	The temp list to put pages on to.
+ * @scanned:	The number of pages that were scanned.
+ *
+ * returns how many pages were moved onto *@dst.
+ */
 static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		struct list_head *src, struct list_head *dst,
 		unsigned long *scanned, int order)
@@ -659,26 +669,31 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 
 		active = PageActive(page);
 		switch (__isolate_lru_page(page, active)) {
-			case 0:
-				list_move(&page->lru, dst);
-				nr_taken++;
-				break;
+		case 0:
+			list_move(&page->lru, dst);
+			nr_taken++;
+			break;
 
-			case -EBUSY:
-				/* else it is being freed elsewhere */
-				list_move(&page->lru, src);
-				continue;
+		case -EBUSY:
+			/* else it is being freed elsewhere */
+			list_move(&page->lru, src);
+			continue;
 
-			default:
-				BUG();
+		default:
+			BUG();
 		}
 
 		if (!order)
 			continue;
 
-		page_pfn = pfn = __page_to_pfn(page);
-		end_pfn = pfn &= ~((1 << order) - 1);
-		end_pfn += 1 << order;
+		/*
+		 * Attempt to take all pages in the order aligned region
+		 * surrounding the tag page.  Only take those pages of
+		 * the same active state as that tag page.
+		 */
+		page_pfn = __page_to_pfn(page);
+		pfn = page_pfn & ~((1 << order) - 1);
+		end_pfn = pfn + (1 << order);
 		for (; pfn < end_pfn; pfn++) {
 			if (unlikely(pfn == page_pfn))
 				continue;
@@ -688,17 +703,16 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 			scan++;
 			tmp = __pfn_to_page(pfn);
 			switch (__isolate_lru_page(tmp, active)) {
-				case 0:
-					list_move(&tmp->lru, dst);
-					nr_taken++;
-					continue;
-
-				case -EBUSY:
-					/* else it is being freed elsewhere */
-					list_move(&tmp->lru, src);
-				default:
-					break;
+			case 0:
+				list_move(&tmp->lru, dst);
+				nr_taken++;
+				continue;
 
+			case -EBUSY:
+				/* else it is being freed elsewhere */
+				list_move(&tmp->lru, src);
+			default:
+				break;
 			}
 			break;
 		}
