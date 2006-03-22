Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932904AbWCVWgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904AbWCVWgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932905AbWCVWgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:36:19 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:49182 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S932886AbWCVWfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:35:55 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223521.12658.49919.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 25/34] mm: kswapd-writeout-wait.patch
Date: Wed, 22 Mar 2006 23:35:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

The new page reclaim implementations can require a lot more scanning
in order to find a suiteable page. This causes kswapd to constantly hit:

 	blk_congestion_wait(WRITE, HZ/10);

without there being any submitted IO.

Count the number of async pages submitted by pageout() and only wait
for congestion when the last priority level has submitted more than
half SWAP_CLUSTER_MAX pages for IO.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h |    2 ++
 mm/vmscan.c                     |    9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c	2006-03-13 20:45:16.000000000 +0100
+++ linux-2.6/mm/vmscan.c	2006-03-13 20:45:25.000000000 +0100
@@ -343,6 +343,7 @@ int shrink_list(struct list_head *page_l
 	struct pagevec freed_pvec;
 	int pgactivate = 0;
 	int reclaimed = 0;
+	int writeout = 0;
 
 	cond_resched();
 
@@ -438,8 +439,10 @@ int shrink_list(struct list_head *page_l
 			case PAGE_ACTIVATE:
 				goto activate_locked;
 			case PAGE_SUCCESS:
-				if (PageWriteback(page) || PageDirty(page))
+				if (PageWriteback(page) || PageDirty(page)) {
+					writeout++;
 					goto keep;
+				}
 				/*
 				 * A synchronous write - probably a ramdisk.  Go
 				 * ahead and try to reclaim the page.
@@ -507,6 +510,7 @@ keep:
 		__pagevec_release_nonlru(&freed_pvec);
 	mod_page_state(pgactivate, pgactivate);
 	sc->nr_reclaimed += reclaimed;
+	sc->nr_writeout += writeout;
 	return reclaimed;
 }
 
@@ -1232,6 +1236,7 @@ scan:
 		 * pages behind kswapd's direction of progress, which would
 		 * cause too much scanning of the lower zones.
 		 */
+		sc.nr_writeout = 0;
 		for (i = 0; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 			int nr_slab;
@@ -1283,7 +1288,7 @@ scan:
 		 * OK, kswapd is getting into trouble.  Take a nap, then take
 		 * another pass across the zones.
 		 */
-		if (total_scanned && priority < DEF_PRIORITY - 2)
+		if (sc.nr_writeout > SWAP_CLUSTER_MAX/2)
 			blk_congestion_wait(WRITE, HZ/10);
 
 		/*
Index: linux-2.6/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6.orig/include/linux/mm_page_replace.h	2006-03-13 20:45:16.000000000 +0100
+++ linux-2.6/include/linux/mm_page_replace.h	2006-03-13 20:45:25.000000000 +0100
@@ -18,6 +18,8 @@ struct scan_control {
 	/* Incremented by the number of pages reclaimed */
 	unsigned long nr_reclaimed;
 
+	unsigned long nr_writeout;	/* page against which writeout was started */
+
 	unsigned long nr_mapped;	/* From page_state */
 
 	/* Ask shrink_caches, or shrink_zone to scan at this priority */
