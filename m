Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757419AbWKWQuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419AbWKWQuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757432AbWKWQuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:50:14 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:37769
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1757429AbWKWQuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:50:12 -0500
Date: Thu, 23 Nov 2006 16:49:40 +0000
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] lumpy cleanup a missplaced comment and simplify some code
Message-ID: <b416b30c3ea48e4e97aa0ed1d89124cb@pinky>
References: <exportbomb.1164300519@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1164300519@pinky>
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
---
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4645a3f..3b6ef79 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -609,21 +609,14 @@ keep:
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
@@ -645,6 +638,23 @@ int __isolate_lru_page(struct page *page
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
@@ -662,26 +672,31 @@ static unsigned long isolate_lru_pages(u
 
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
@@ -691,17 +706,16 @@ static unsigned long isolate_lru_pages(u
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
