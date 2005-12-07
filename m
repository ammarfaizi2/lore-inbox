Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVLGKsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVLGKsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVLGKsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:48:42 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:989 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750820AbVLGKsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:48:42 -0500
Date: Wed, 7 Dec 2005 19:15:01 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: mm: fold sc.may_writepage and sc.may_swap into sc.flags
Message-ID: <20051207111501.GA8133@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20051207104755.177435000@localhost.localdomain> <20051207105154.142779000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207105154.142779000@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fold bool values into flags to make struct scan_control more compact.

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
@@ -488,7 +488,7 @@ static int shrink_list(struct list_head 
 		 * Try to allocate it some swap space here.
 		 */
 		if (PageAnon(page) && !PageSwapCache(page)) {
-			if (!sc->may_swap)
+			if (!(sc->flags & SC_MAY_SWAP))
 				goto keep_locked;
 			if (!add_to_swap(page, GFP_ATOMIC))
 				goto activate_locked;
@@ -519,7 +519,7 @@ static int shrink_list(struct list_head 
 				goto keep_locked;
 			if (!may_enter_fs)
 				goto keep_locked;
-			if (laptop_mode && !sc->may_writepage)
+			if (laptop_mode && !(sc->flags & SC_MAY_WRITEPAGE))
 				goto keep_locked;
 
 			/* Page is dirty, try to write it out here */
@@ -1238,8 +1238,7 @@ int try_to_free_pages(struct zone **zone
 	delay_prefetch();
 
 	sc.gfp_mask = gfp_mask;
-	sc.may_writepage = 0;
-	sc.may_swap = 1;
+	sc.flags = SC_MAY_SWAP;
 	sc.nr_scanned = 0;
 	sc.nr_reclaimed = 0;
 
@@ -1287,7 +1286,7 @@ int try_to_free_pages(struct zone **zone
 		 */
 		if (sc.nr_scanned > SWAP_CLUSTER_MAX * 3 / 2) {
 			wakeup_pdflush(laptop_mode ? 0 : sc.nr_scanned);
-			sc.may_writepage = 1;
+			sc.flags |= SC_MAY_WRITEPAGE;
 		}
 
 		/* Take a nap, wait for some writeback to complete */
@@ -1343,8 +1342,7 @@ static int balance_pgdat(pg_data_t *pgda
 
 loop_again:
 	sc.gfp_mask = GFP_KERNEL;
-	sc.may_writepage = 0;
-	sc.may_swap = 1;
+	sc.flags = SC_MAY_SWAP;
 	sc.nr_mapped = read_page_state(nr_mapped);
 	sc.nr_scanned = 0;
 	sc.nr_reclaimed = 0;
@@ -1439,7 +1437,7 @@ scan_swspd:
 		 */
 		if (sc.nr_scanned > SWAP_CLUSTER_MAX * 2 &&
 		    sc.nr_scanned > sc.nr_reclaimed + sc.nr_reclaimed / 2)
-			sc.may_writepage = 1;
+			sc.flags |= SC_MAY_WRITEPAGE;
 
 		if (nr_pages && to_free > sc.nr_reclaimed)
 			continue;	/* swsusp: need to do more work */
