Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVI2SQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVI2SQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVI2SQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:16:42 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.19]:51241 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S932340AbVI2SQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:16:39 -0400
Message-Id: <20050929181632.736493250@twins>
References: <20050929180845.910895444@twins>
Date: Thu, 29 Sep 2005 20:08:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org
Subject: [PATCH 4/7] CART - an advanced page replacement policy
Content-Disposition: inline; filename=cart-cart-r.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An improvement to CART.

This patch introduces yet another adaptive parameter: 'r'.
'r' measures the influx of fresh pages in ns/nl space; 
ie. those pages not in: T1 u T2 u B1 u B2.

When 'r' drops below nl we start reclaiming 'new' 'L' pages
(from T1).

This elevates the typical scan problem of eating your own tail.

One possible improvement on this scheme: when it is
found that we start reclaiming 'new' pages too soon ('p' > |T1|)
we can give referenced 'new' 'L' pages one extra cycle and promote
them to regular 'L' pages instead of reclaiming them when they
are again referenced.


Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 include/linux/mmzone.h |    1 +
 mm/cart.c              |   41 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

Index: linux-2.6-git/mm/cart.c
===================================================================
--- linux-2.6-git.orig/mm/cart.c
+++ linux-2.6-git/mm/cart.c
@@ -64,6 +64,7 @@
 
 #define cart_p ((zone)->nr_p)
 #define cart_q ((zone)->nr_q)
+#define cart_r ((zone)->nr_r)
 
 #define size_B1 ((zone)->nr_evicted_active)
 #define size_B2 ((zone)->nr_evicted_inactive)
@@ -81,6 +82,7 @@ void __init cart_init(void)
 		zone->nr_shortterm = 0;
 		zone->nr_p = 0;
 		zone->nr_q = 0;
+		zone->nr_r = 0;
 	}
 }
 
@@ -123,6 +125,12 @@ void __cart_insert(struct zone *zone, st
 	rflags = nonresident_find(page_mapping(page), page_index(page));
 
 	if (rflags & NR_found) {
+		ratio = (nr_Nl / (nr_Ns + 1)) ?: 1;
+		if (cart_r > ratio)
+			cart_r -= ratio;
+		else
+			cart_r = 0UL;
+
 		rflags &= NR_listid;
 		if (rflags == NR_b1) {
 			if (likely(size_B1)) --size_B1;
@@ -149,6 +157,11 @@ void __cart_insert(struct zone *zone, st
 		}
 		/* ++nr_Nl; */
 	} else {
+		ratio = (nr_Ns / (nr_Nl + 1)) ?: 1;
+		cart_r += ratio;
+		if (cart_r > cart_cT)
+			cart_r = cart_cT;
+
 		ClearPageLongTerm(page);
 		++nr_Ns;
 	}
@@ -355,12 +368,14 @@ static int cart_rebalance_T2(struct zone
 
 /*
  * Rebalance the T1 list:
+ *  take 'new' 'L' pages for reclaim when r < nl,
  *  move referenced pages to tail and possibly mark 'L',
  *  move unreffed 'L' pages to tail T2,
  *  take unreffed 'S' pages for reclaim.
  *
  * @zone: target zone.
  * @l_t1_head: temp list of reclaimable pages (1 ref).
+ * @l_new: temp list of 'new' pages.
  * @nr_dst: quantum of pages.
  * @nr_scanned: counter that keeps the number of pages touched.
  * @pvec: pagevec used to release pages.
@@ -369,6 +384,7 @@ static int cart_rebalance_T2(struct zone
  * returns if we encountered more PG_writeback pages than reclaimable pages.
  */
 static int cart_rebalance_T1(struct zone *zone, struct list_head *l_t1_head,
+			     struct list_head *l_new,
 			     unsigned long nr_dst, unsigned long *nr_scanned,
 			     struct pagevec *pvec, int ignore_token)
 {
@@ -394,8 +410,13 @@ static int cart_rebalance_T1(struct zone
 			referenced = page_referenced(page, 0, ignore_token);
 			new = TestClearPageNew(page);
 
-			if (referenced ||
-			    (PageWriteback(page) && ++nr_writeback)) {
+			if (cart_r < (nr_Nl + dsl) && PageLongTerm(page) && new) {
+				list_move_tail(&page->lru, l_new);
+				ClearPageActive(page);
+				++dq;
+				++nr_reclaim;
+			} else if (referenced ||
+				   (PageWriteback(page) && ++nr_writeback)) {
 				list_move_tail(&page->lru, &l_t1);
 
 				// XXX: we race a bit here; 
@@ -432,6 +453,7 @@ static int cart_rebalance_T1(struct zone
 
 /*
  * Try to reclaim a specified number of pages.
+ * Prefer 'new' pages when available, otherwise let p be the judge.
  *
  * Clears PG_lru of reclaimed pages, but does take 1 reference.
  *
@@ -448,6 +470,7 @@ unsigned long cart_replace(struct zone *
 			   int ignore_token)
 {
 	struct page *page;
+	LIST_HEAD(l_new);
 	LIST_HEAD(l_t1);
 	LIST_HEAD(l_t2);
 	struct pagevec pvec;
@@ -472,13 +495,26 @@ unsigned long cart_replace(struct zone *
 			wr2 = cart_rebalance_T2(zone, &l_t2, nr_dst/2, nr_scanned,
 						&pvec, ignore_token);
 		if (list_empty(&l_t1))
-			wr1 = cart_rebalance_T1(zone, &l_t1, nr_dst/2, nr_scanned,
+			wr1 = cart_rebalance_T1(zone, &l_t1, &l_new, nr_dst/2, nr_scanned,
 						&pvec, ignore_token);
 
 		if (list_empty(&l_t1) && list_empty(&l_t2))
 			break;
 
 		spin_lock_irq(&zone->lru_lock);
+		while (!list_empty(&l_new) && nr < nr_dst) {
+			page = head_to_page(&l_new);
+			prefetchw_next_lru_page(page, &l_new, flags);
+
+			if (!TestClearPageLRU(page))
+				BUG();
+			if (!PageLongTerm(page))
+				BUG();
+			/* --nr_Nl; */
+			--size_T2;
+			++nr;
+			list_move(&page->lru, dst);
+		}
 		while (!list_empty(&l_t1) &&
 		       (size_T1 > cart_p || !size_T2 || wr2) && nr < nr_dst) {
 			page = head_to_page(&l_t1);
@@ -515,6 +551,7 @@ unsigned long cart_replace(struct zone *
 	spin_lock_irq(&zone->lru_lock);
 	__cart_list_splice_release(zone, &l_t1, list_T1, &pvec);
 	__cart_list_splice_release(zone, &l_t2, list_T2, &pvec);
+	__cart_list_splice_release(zone, &l_new, list_T2, &pvec);
 	spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(&pvec);
 
@@ -562,7 +599,6 @@ void cart_reinsert(struct zone *zone, st
 			list_move_tail(&page->lru, list_T1);
 			++size_T1;
 
-			/* ( |T1| >= min(p + 1, |B1| ) and ( filter = 'S' ) */
 			/*
 			 * Don't modify page state; it wasn't actually referenced
 			 */
Index: linux-2.6-git/include/linux/mmzone.h
===================================================================
--- linux-2.6-git.orig/include/linux/mmzone.h
+++ linux-2.6-git/include/linux/mmzone.h
@@ -155,6 +155,7 @@ struct zone {
 	unsigned long 		nr_shortterm;	/* number of short term pages */
 	unsigned long		nr_p;		/* p from the CART paper */
 	unsigned long 		nr_q;		/* q from the cart paper */
+	unsigned long		nr_r;
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 

--
