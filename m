Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSHKH2k>; Sun, 11 Aug 2002 03:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318234AbSHKH2N>; Sun, 11 Aug 2002 03:28:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36870 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318047AbSHKHZl>;
	Sun, 11 Aug 2002 03:25:41 -0400
Message-ID: <3D5614A6.22F832F1@zip.com.au>
Date: Sun, 11 Aug 2002 00:39:18 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 11/21] disable interrupts while holding pagemap_lru_lock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It is expensive for a CPU to take an interrupt while holding the page
LRU lock, because other CPUs will pile up on the lock while the
interrupt runs.

Disabling interrupts while holding the lock reduces contention by an
additional 30% on 4-way.  This is when the only source of interrupts is
disk completion.  The improvement will be higher with more CPUs and it
will be higher if there is networking happening.

The maximum hold time of this lock is 17 microseconds on 500 MHx PIII,
which is well inside the kernel's maximum interrupt latency (which was
100 usecs when I last looked, a year ago).

This optimisation is not needed on uniprocessor, but the patch disables
IRQs while holding pagemap_lru_lock anyway, so it becomes an irq-safe
spinlock, and pages can be moved from the LRU in interrupt context.

pagemap_lru_lock has been renamed to _pagemap_lru_lock to pick up any
missed uses, and to reliably break any out-of-tree patches which may be
using the old semantics.



 include/linux/swap.h |    2 +-
 mm/filemap.c         |    2 +-
 mm/swap.c            |   28 ++++++++++++++--------------
 mm/vmscan.c          |   28 ++++++++++++++--------------
 4 files changed, 30 insertions(+), 30 deletions(-)

--- 2.5.31/mm/filemap.c~lru-lock-irq-off	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/filemap.c	Sun Aug 11 00:21:02 2002
@@ -62,7 +62,7 @@
  *      ->inode_lock		(__mark_inode_dirty)
  *        ->sb_lock		(fs/fs-writeback.c)
  */
-spinlock_t pagemap_lru_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+spinlock_t _pagemap_lru_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 /*
  * Remove a page from the page cache and free it. Caller has to make
--- 2.5.31/mm/swap.c~lru-lock-irq-off	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/swap.c	Sun Aug 11 00:21:02 2002
@@ -41,9 +41,9 @@ static inline void activate_page_nolock(
  */
 void activate_page(struct page * page)
 {
-	spin_lock(&pagemap_lru_lock);
+	spin_lock_irq(&_pagemap_lru_lock);
 	activate_page_nolock(page);
-	spin_unlock(&pagemap_lru_lock);
+	spin_unlock_irq(&_pagemap_lru_lock);
 }
 
 /**
@@ -53,10 +53,10 @@ void activate_page(struct page * page)
 void lru_cache_add(struct page * page)
 {
 	if (!PageLRU(page)) {
-		spin_lock(&pagemap_lru_lock);
+		spin_lock_irq(&_pagemap_lru_lock);
 		if (!TestSetPageLRU(page))
 			add_page_to_inactive_list(page);
-		spin_unlock(&pagemap_lru_lock);
+		spin_unlock_irq(&_pagemap_lru_lock);
 	}
 }
 
@@ -83,9 +83,9 @@ void __lru_cache_del(struct page * page)
  */
 void lru_cache_del(struct page * page)
 {
-	spin_lock(&pagemap_lru_lock);
+	spin_lock_irq(&_pagemap_lru_lock);
 	__lru_cache_del(page);
-	spin_unlock(&pagemap_lru_lock);
+	spin_unlock_irq(&_pagemap_lru_lock);
 }
 
 /*
@@ -116,7 +116,7 @@ void __pagevec_release(struct pagevec *p
 			continue;
 
 		if (!lock_held) {
-			spin_lock(&pagemap_lru_lock);
+			spin_lock_irq(&_pagemap_lru_lock);
 			lock_held = 1;
 		}
 
@@ -130,7 +130,7 @@ void __pagevec_release(struct pagevec *p
 			pagevec_add(&pages_to_free, page);
 	}
 	if (lock_held)
-		spin_unlock(&pagemap_lru_lock);
+		spin_unlock_irq(&_pagemap_lru_lock);
 
 	pagevec_free(&pages_to_free);
 	pagevec_init(pvec);
@@ -175,14 +175,14 @@ void pagevec_deactivate_inactive(struct 
 		if (!lock_held) {
 			if (PageActive(page) || !PageLRU(page))
 				continue;
-			spin_lock(&pagemap_lru_lock);
+			spin_lock_irq(&_pagemap_lru_lock);
 			lock_held = 1;
 		}
 		if (!PageActive(page) && PageLRU(page))
 			list_move(&page->lru, &inactive_list);
 	}
 	if (lock_held)
-		spin_unlock(&pagemap_lru_lock);
+		spin_unlock_irq(&_pagemap_lru_lock);
 	__pagevec_release(pvec);
 }
 
@@ -194,7 +194,7 @@ void __pagevec_lru_add(struct pagevec *p
 {
 	int i;
 
-	spin_lock(&pagemap_lru_lock);
+	spin_lock_irq(&_pagemap_lru_lock);
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
 
@@ -202,7 +202,7 @@ void __pagevec_lru_add(struct pagevec *p
 			BUG();
 		add_page_to_inactive_list(page);
 	}
-	spin_unlock(&pagemap_lru_lock);
+	spin_unlock_irq(&_pagemap_lru_lock);
 	pagevec_release(pvec);
 }
 
@@ -214,7 +214,7 @@ void __pagevec_lru_del(struct pagevec *p
 {
 	int i;
 
-	spin_lock(&pagemap_lru_lock);
+	spin_lock_irq(&_pagemap_lru_lock);
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
 
@@ -225,7 +225,7 @@ void __pagevec_lru_del(struct pagevec *p
 		else
 			del_page_from_inactive_list(page);
 	}
-	spin_unlock(&pagemap_lru_lock);
+	spin_unlock_irq(&_pagemap_lru_lock);
 	pagevec_release(pvec);
 }
 
--- 2.5.31/mm/vmscan.c~lru-lock-irq-off	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/vmscan.c	Sun Aug 11 00:21:02 2002
@@ -284,7 +284,7 @@ shrink_cache(int nr_pages, zone_t *class
 
 	pagevec_init(&pvec);
 
-	spin_lock(&pagemap_lru_lock);
+	spin_lock_irq(&_pagemap_lru_lock);
 	while (max_scan > 0 && nr_pages > 0) {
 		struct page *page;
 		int n = 0;
@@ -307,7 +307,7 @@ shrink_cache(int nr_pages, zone_t *class
 			page_cache_get(page);
 			n++;
 		}
-		spin_unlock(&pagemap_lru_lock);
+		spin_unlock_irq(&_pagemap_lru_lock);
 
 		if (list_empty(&page_list))
 			goto done;
@@ -321,7 +321,7 @@ shrink_cache(int nr_pages, zone_t *class
 		if (nr_pages <= 0 && list_empty(&page_list))
 			goto done;
 
-		spin_lock(&pagemap_lru_lock);
+		spin_lock_irq(&_pagemap_lru_lock);
 		/*
 		 * Put back any unfreeable pages.
 		 */
@@ -335,13 +335,13 @@ shrink_cache(int nr_pages, zone_t *class
 			else
 				add_page_to_inactive_list(page);
 			if (!pagevec_add(&pvec, page)) {
-				spin_unlock(&pagemap_lru_lock);
+				spin_unlock_irq(&_pagemap_lru_lock);
 				__pagevec_release(&pvec);
-				spin_lock(&pagemap_lru_lock);
+				spin_lock_irq(&_pagemap_lru_lock);
 			}
 		}
   	}
-	spin_unlock(&pagemap_lru_lock);
+	spin_unlock_irq(&_pagemap_lru_lock);
 done:
 	pagevec_release(&pvec);
 	return nr_pages;	
@@ -374,7 +374,7 @@ static /* inline */ void refill_inactive
 	struct page *page;
 	struct pagevec pvec;
 
-	spin_lock(&pagemap_lru_lock);
+	spin_lock_irq(&_pagemap_lru_lock);
 	while (nr_pages && !list_empty(&active_list)) {
 		page = list_entry(active_list.prev, struct page, lru);
 		prefetchw_prev_lru_page(page, &active_list, flags);
@@ -384,7 +384,7 @@ static /* inline */ void refill_inactive
 		list_move(&page->lru, &l_hold);
 		nr_pages--;
 	}
-	spin_unlock(&pagemap_lru_lock);
+	spin_unlock_irq(&_pagemap_lru_lock);
 
 	while (!list_empty(&l_hold)) {
 		page = list_entry(l_hold.prev, struct page, lru);
@@ -406,7 +406,7 @@ static /* inline */ void refill_inactive
 	}
 
 	pagevec_init(&pvec);
-	spin_lock(&pagemap_lru_lock);
+	spin_lock_irq(&_pagemap_lru_lock);
 	while (!list_empty(&l_inactive)) {
 		page = list_entry(l_inactive.prev, struct page, lru);
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
@@ -416,9 +416,9 @@ static /* inline */ void refill_inactive
 			BUG();
 		list_move(&page->lru, &inactive_list);
 		if (!pagevec_add(&pvec, page)) {
-			spin_unlock(&pagemap_lru_lock);
+			spin_unlock_irq(&_pagemap_lru_lock);
 			__pagevec_release(&pvec);
-			spin_lock(&pagemap_lru_lock);
+			spin_lock_irq(&_pagemap_lru_lock);
 		}
 	}
 	while (!list_empty(&l_active)) {
@@ -429,12 +429,12 @@ static /* inline */ void refill_inactive
 		BUG_ON(!PageActive(page));
 		list_move(&page->lru, &active_list);
 		if (!pagevec_add(&pvec, page)) {
-			spin_unlock(&pagemap_lru_lock);
+			spin_unlock_irq(&_pagemap_lru_lock);
 			__pagevec_release(&pvec);
-			spin_lock(&pagemap_lru_lock);
+			spin_lock_irq(&_pagemap_lru_lock);
 		}
 	}
-	spin_unlock(&pagemap_lru_lock);
+	spin_unlock_irq(&_pagemap_lru_lock);
 	pagevec_release(&pvec);
 
 	mod_page_state(nr_active, -pgdeactivate);
--- 2.5.31/include/linux/swap.h~lru-lock-irq-off	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/linux/swap.h	Sun Aug 11 00:21:02 2002
@@ -212,7 +212,7 @@ extern struct swap_list_t swap_list;
 asmlinkage long sys_swapoff(const char *);
 asmlinkage long sys_swapon(const char *, int);
 
-extern spinlock_t pagemap_lru_lock;
+extern spinlock_t _pagemap_lru_lock;
 
 extern void FASTCALL(mark_page_accessed(struct page *));
 

.
