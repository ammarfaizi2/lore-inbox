Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318061AbSHKH2i>; Sun, 11 Aug 2002 03:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318060AbSHKH2Z>; Sun, 11 Aug 2002 03:28:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38150 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318061AbSHKHZw>;
	Sun, 11 Aug 2002 03:25:52 -0400
Message-ID: <3D5614B2.EFD25A8D@zip.com.au>
Date: Sun, 11 Aug 2002 00:39:30 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 13/21] deferred and batched addition of faulted-in pages to the 
 LRU
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The remaining source of page-at-a-time activity against
pagemap_lru_lock is the anonymous pagefault path, which cannot be
changed to operate against multiple pages at a time.

But what we can do is to batch up just its adding of pages to the LRU,
via buffering and deferral.

The patch changes lru_cache_add to put the pages into a per-CPU
pagevec.  They are added to the LRU 16-at-a-time.

And in the page reclaim code, purge the local CPU's buffer before
starting.  This is mainly to decrease the chances of pages staying off
the LRU for very long periods: if the machine is under memory pressure,
CPUs will spill their pages onto the LRU promptly.

A consequence of this change is that we can have up to 15*num_cpus
pages which are not on the LRU.  Which could have a slight effect on VM
accuracy, but I find that doubtful.  If the system is under memory
pressure the pages will be added to the LRU promptly, and these pages
are the most-recently-touched ones - the VM isn't very interested in
them anyway.

This optimisation could be made SMP-specific, but I felt it best to
turn it on for UP as well for consistency and better testing coverage. 



 include/linux/pagevec.h |    1 +
 mm/swap.c               |   25 ++++++++++++++++++-------
 mm/vmscan.c             |    2 ++
 3 files changed, 21 insertions(+), 7 deletions(-)

--- 2.5.31/mm/swap.c~anon-add-pagevec	Sun Aug 11 00:20:34 2002
+++ 2.5.31-akpm/mm/swap.c	Sun Aug 11 00:21:00 2002
@@ -50,14 +50,25 @@ void activate_page(struct page * page)
  * lru_cache_add: add a page to the page lists
  * @page: the page to add
  */
-void lru_cache_add(struct page * page)
+static struct pagevec lru_add_pvecs[NR_CPUS];
+
+void lru_cache_add(struct page *page)
+{
+	struct pagevec *pvec = &lru_add_pvecs[get_cpu()];
+
+	page_cache_get(page);
+	if (!pagevec_add(pvec, page))
+		__pagevec_lru_add(pvec);
+	put_cpu();
+}
+
+void lru_add_drain(void)
 {
-	if (!PageLRU(page)) {
-		spin_lock_irq(&_pagemap_lru_lock);
-		if (!TestSetPageLRU(page))
-			add_page_to_inactive_list(page);
-		spin_unlock_irq(&_pagemap_lru_lock);
-	}
+	struct pagevec *pvec = &lru_add_pvecs[get_cpu()];
+
+	if (pagevec_count(pvec))
+		__pagevec_lru_add(pvec);
+	put_cpu();
 }
 
 /*
--- 2.5.31/include/linux/pagevec.h~anon-add-pagevec	Sun Aug 11 00:20:34 2002
+++ 2.5.31-akpm/include/linux/pagevec.h	Sun Aug 11 00:20:34 2002
@@ -21,6 +21,7 @@ void __pagevec_release_nonlru(struct pag
 void __pagevec_free(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
 void __pagevec_lru_del(struct pagevec *pvec);
+void lru_add_drain(void);
 void pagevec_deactivate_inactive(struct pagevec *pvec);
 
 static inline void pagevec_init(struct pagevec *pvec)
--- 2.5.31/mm/vmscan.c~anon-add-pagevec	Sun Aug 11 00:20:34 2002
+++ 2.5.31-akpm/mm/vmscan.c	Sun Aug 11 00:21:01 2002
@@ -290,6 +290,7 @@ shrink_cache(int nr_pages, zone_t *class
 
 	pagevec_init(&pvec);
 
+	lru_add_drain();
 	spin_lock_irq(&_pagemap_lru_lock);
 	while (max_scan > 0 && nr_pages > 0) {
 		struct page *page;
@@ -380,6 +381,7 @@ static /* inline */ void refill_inactive
 	struct page *page;
 	struct pagevec pvec;
 
+	lru_add_drain();
 	spin_lock_irq(&_pagemap_lru_lock);
 	while (nr_pages && !list_empty(&active_list)) {
 		page = list_entry(active_list.prev, struct page, lru);

.
