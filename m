Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUCIFdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 00:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUCIFdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 00:33:51 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:39314 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261210AbUCIFds
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 00:33:48 -0500
Message-ID: <404D5735.1040500@cyberone.com.au>
Date: Tue, 09 Mar 2004 16:33:41 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 2/4] vm-nofixed-active-list
References: <404D56D8.2000008@cyberone.com.au> <404D570D.90608@cyberone.com.au>
In-Reply-To: <404D570D.90608@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------030503070709090809080809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030503070709090809080809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------030503070709090809080809
Content-Type: text/x-patch;
 name="vm-nofixed-active-list.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-nofixed-active-list.patch"


Generalise active list scanning to scan different lists.



 linux-2.6-npiggin/mm/vmscan.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff -puN mm/vmscan.c~vm-nofixed-active-list mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-nofixed-active-list	2004-03-09 13:57:23.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2004-03-09 16:31:27.000000000 +1100
@@ -579,13 +579,12 @@ done:
  * The downside is that we have to touch page->count against each page.
  * But we had to alter page->flags anyway.
  */
-static void
-refill_inactive_zone(struct zone *zone, const int nr_pages_in,
-			struct page_state *ps)
+static void shrink_active_list(struct zone *zone, struct list_head *list,
+				const int nr_scan, struct page_state *ps)
 {
 	int pgmoved;
 	int pgdeactivate = 0;
-	int nr_pages = nr_pages_in;
+	int nr_pages = nr_scan;
 	LIST_HEAD(l_hold);	/* The pages which were snipped off */
 	LIST_HEAD(l_inactive);	/* Pages to go onto the inactive_list */
 	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
@@ -599,16 +598,16 @@ refill_inactive_zone(struct zone *zone, 
 	lru_add_drain();
 	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
-	while (nr_pages && !list_empty(&zone->active_list)) {
-		page = lru_to_page(&zone->active_list);
-		prefetchw_prev_lru_page(page, &zone->active_list, flags);
+	while (nr_pages && !list_empty(list)) {
+		page = lru_to_page(list);
+		prefetchw_prev_lru_page(page, list, flags);
 		if (!TestClearPageLRU(page))
 			BUG();
 		list_del(&page->lru);
 		if (page_count(page) == 0) {
 			/* It is currently in pagevec_release() */
 			SetPageLRU(page);
-			list_add(&page->lru, &zone->active_list);
+			list_add(&page->lru, list);
 		} else {
 			page_cache_get(page);
 			list_add(&page->lru, &l_hold);
@@ -716,7 +715,7 @@ refill_inactive_zone(struct zone *zone, 
 		if (TestSetPageLRU(page))
 			BUG();
 		BUG_ON(!PageActive(page));
-		list_move(&page->lru, &zone->active_list);
+		list_move(&page->lru, list);
 		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
 			zone->nr_active += pgmoved;
@@ -730,7 +729,7 @@ refill_inactive_zone(struct zone *zone, 
 	spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(&pvec);
 
-	mod_page_state_zone(zone, pgrefill, nr_pages_in - nr_pages);
+	mod_page_state_zone(zone, pgrefill, nr_scan - nr_pages);
 	mod_page_state(pgdeactivate, pgdeactivate);
 }
 
@@ -762,7 +761,7 @@ shrink_zone(struct zone *zone, int max_s
 	count = atomic_read(&zone->nr_scan_active);
 	if (count >= SWAP_CLUSTER_MAX) {
 		atomic_set(&zone->nr_scan_active, 0);
-		refill_inactive_zone(zone, count, ps);
+		shrink_active_list(zone, &zone->active_list, count, ps);
 	}
 
 	atomic_add(max_scan, &zone->nr_scan_inactive);

_

--------------030503070709090809080809--
