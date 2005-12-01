Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVLAKOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVLAKOr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVLAKOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:14:41 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:2204 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932128AbVLAKOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:14:11 -0500
Message-Id: <20051201102137.587979000@localhost.localdomain>
References: <20051201101810.837245000@localhost.localdomain>
Date: Thu, 01 Dec 2005 18:18:20 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Nick Piggin <npiggin@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 10/12] mm: merge sc.may_writepage and sc.may_swap into sc.flags
Content-Disposition: inline; filename=mm-turn-bool-variables-into-flags-in-scan-control.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turn bool values into flags to make struct scan_control more compact.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/vmscan.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -72,12 +72,12 @@ struct scan_control {
 	/* This context's GFP mask */
 	gfp_t gfp_mask;
 
-	int may_writepage;
-
-	/* Can pages be swapped as part of reclaim? */
-	int may_swap;
+	unsigned long flags;
 };
 
+#define SC_MAY_WRITEPAGE	0x1
+#define SC_MAY_SWAP		0x2	/* Can pages be swapped as part of reclaim? */
+
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
 
 #ifdef ARCH_HAS_PREFETCH
@@ -487,7 +487,7 @@ static int shrink_list(struct list_head 
 		 * Try to allocate it some swap space here.
 		 */
 		if (PageAnon(page) && !PageSwapCache(page)) {
-			if (!sc->may_swap)
+			if (!(sc->flags & SC_MAY_SWAP))
 				goto keep_locked;
 			if (!add_to_swap(page, GFP_ATOMIC))
 				goto activate_locked;
@@ -518,7 +518,7 @@ static int shrink_list(struct list_head 
 				goto keep_locked;
 			if (!may_enter_fs)
 				goto keep_locked;
-			if (laptop_mode && !sc->may_writepage)
+			if (laptop_mode && !(sc->flags & SC_MAY_WRITEPAGE))
 				goto keep_locked;
 
 			/* Page is dirty, try to write it out here */
@@ -1236,8 +1236,7 @@ int try_to_free_pages(struct zone **zone
 	delay_prefetch();
 
 	sc.gfp_mask = gfp_mask;
-	sc.may_writepage = 0;
-	sc.may_swap = 1;
+	sc.flags = SC_MAY_SWAP;
 	sc.nr_scanned = 0;
 	sc.nr_reclaimed = 0;
 
@@ -1279,7 +1278,7 @@ int try_to_free_pages(struct zone **zone
 		 */
 		if (sc.nr_scanned > SWAP_CLUSTER_MAX * 3 / 2) {
 			wakeup_pdflush(laptop_mode ? 0 : sc.nr_scanned);
-			sc.may_writepage = 1;
+			sc.flags |= SC_MAY_WRITEPAGE;
 		}
 
 		/* Take a nap, wait for some writeback to complete */
@@ -1336,8 +1335,7 @@ static int balance_pgdat(pg_data_t *pgda
 
 loop_again:
 	sc.gfp_mask = GFP_KERNEL;
-	sc.may_writepage = 0;
-	sc.may_swap = 1;
+	sc.flags = SC_MAY_SWAP;
 	sc.nr_mapped = read_page_state(nr_mapped);
 	sc.nr_scanned = 0;
 	sc.nr_reclaimed = 0;
@@ -1423,7 +1421,7 @@ loop_again:
 		 */
 		if (sc.nr_scanned > SWAP_CLUSTER_MAX * 2 &&
 		    sc.nr_scanned > sc.nr_reclaimed + sc.nr_reclaimed / 2)
-			sc.may_writepage = 1;
+			sc.flags |= SC_MAY_WRITEPAGE;
 
 		if (nr_pages && to_free > sc.nr_reclaimed)
 			continue;	/* swsusp: need to do more work */

--
