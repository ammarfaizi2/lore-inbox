Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUCIFhh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 00:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUCIFhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 00:37:37 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:56807 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261231AbUCIFha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 00:37:30 -0500
Message-ID: <404D570D.90608@cyberone.com.au>
Date: Tue, 09 Mar 2004 16:33:01 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 1/4] vm-lrutopage-cleanup
References: <404D56D8.2000008@cyberone.com.au>
In-Reply-To: <404D56D8.2000008@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------060407080006040908030208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060407080006040908030208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------060407080006040908030208
Content-Type: text/x-patch;
 name="vm-lrutopage-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-lrutopage-cleanup.patch"


Cleanup from Nikita's dont-rotate-active-list patch.


 linux-2.6-npiggin/mm/vmscan.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff -puN mm/vmscan.c~vm-lrutopage-cleanup mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-lrutopage-cleanup	2004-03-09 13:51:29.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2004-03-09 16:31:28.000000000 +1100
@@ -45,14 +45,15 @@
 int vm_swappiness = 60;
 static long total_memory;
 
+#define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
+
 #ifdef ARCH_HAS_PREFETCH
 #define prefetch_prev_lru_page(_page, _base, _field)			\
 	do {								\
 		if ((_page)->lru.prev != _base) {			\
 			struct page *prev;				\
 									\
-			prev = list_entry(_page->lru.prev,		\
-					struct page, lru);		\
+			prev = lru_to_page(&(_page->lru));		\
 			prefetch(&prev->_field);			\
 		}							\
 	} while (0)
@@ -66,8 +67,7 @@ static long total_memory;
 		if ((_page)->lru.prev != _base) {			\
 			struct page *prev;				\
 									\
-			prev = list_entry(_page->lru.prev,		\
-					struct page, lru);		\
+			prev = lru_to_page(&(_page->lru));			\
 			prefetchw(&prev->_field);			\
 		}							\
 	} while (0)
@@ -262,7 +262,7 @@ shrink_list(struct list_head *page_list,
 		int may_enter_fs;
 		int referenced;
 
-		page = list_entry(page_list->prev, struct page, lru);
+		page = lru_to_page(page_list);
 		list_del(&page->lru);
 
 		if (TestSetPageLocked(page))
@@ -496,8 +496,7 @@ shrink_cache(struct zone *zone, unsigned
 
 		while (nr_scan++ < SWAP_CLUSTER_MAX &&
 				!list_empty(&zone->inactive_list)) {
-			page = list_entry(zone->inactive_list.prev,
-						struct page, lru);
+			page = lru_to_page(&zone->inactive_list);
 
 			prefetchw_prev_lru_page(page,
 						&zone->inactive_list, flags);
@@ -542,7 +541,7 @@ shrink_cache(struct zone *zone, unsigned
 		 * Put back any unfreeable pages.
 		 */
 		while (!list_empty(&page_list)) {
-			page = list_entry(page_list.prev, struct page, lru);
+			page = lru_to_page(&page_list);
 			if (TestSetPageLRU(page))
 				BUG();
 			list_del(&page->lru);
@@ -601,7 +600,7 @@ refill_inactive_zone(struct zone *zone, 
 	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
 	while (nr_pages && !list_empty(&zone->active_list)) {
-		page = list_entry(zone->active_list.prev, struct page, lru);
+		page = lru_to_page(&zone->active_list);
 		prefetchw_prev_lru_page(page, &zone->active_list, flags);
 		if (!TestClearPageLRU(page))
 			BUG();
@@ -652,7 +651,7 @@ refill_inactive_zone(struct zone *zone, 
 		reclaim_mapped = 1;
 
 	while (!list_empty(&l_hold)) {
-		page = list_entry(l_hold.prev, struct page, lru);
+		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
 		if (page_mapped(page)) {
 			if (!reclaim_mapped) {
@@ -683,7 +682,7 @@ refill_inactive_zone(struct zone *zone, 
 	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
 	while (!list_empty(&l_inactive)) {
-		page = list_entry(l_inactive.prev, struct page, lru);
+		page = lru_to_page(&l_inactive);
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
 		if (TestSetPageLRU(page))
 			BUG();
@@ -712,7 +711,7 @@ refill_inactive_zone(struct zone *zone, 
 
 	pgmoved = 0;
 	while (!list_empty(&l_active)) {
-		page = list_entry(l_active.prev, struct page, lru);
+		page = lru_to_page(&l_active);
 		prefetchw_prev_lru_page(page, &l_active, flags);
 		if (TestSetPageLRU(page))
 			BUG();

_

--------------060407080006040908030208--
