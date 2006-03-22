Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932874AbWCVWdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932874AbWCVWdI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbWCVWdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:33:07 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:42969 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S932866AbWCVWdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:33:02 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223228.12658.57533.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 08/34] mm: page-replace-move-scan_control.patch
Date: Wed, 22 Mar 2006 23:33:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Move struct scan_control to the general page_replace header so that all
policies can make use of it.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h |   30 ++++++++++++++++++++++++++++++
 mm/vmscan.c                     |   30 ------------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -8,6 +8,36 @@
 #include <linux/pagevec.h>
 #include <linux/mm_inline.h>
 
+struct scan_control {
+	/* Ask refill_inactive_zone, or shrink_cache to scan this many pages */
+	unsigned long nr_to_scan;
+
+	/* Incremented by the number of inactive pages that were scanned */
+	unsigned long nr_scanned;
+
+	/* Incremented by the number of pages reclaimed */
+	unsigned long nr_reclaimed;
+
+	unsigned long nr_mapped;	/* From page_state */
+
+	/* Ask shrink_caches, or shrink_zone to scan at this priority */
+	unsigned int priority;
+
+	/* This context's GFP mask */
+	gfp_t gfp_mask;
+
+	int may_writepage;
+
+	/* Can pages be swapped as part of reclaim? */
+	int may_swap;
+
+	/* This context's SWAP_CLUSTER_MAX. If freeing memory for
+	 * suspend, we effectively ignore SWAP_CLUSTER_MAX.
+	 * In this context, it doesn't matter that we scan the
+	 * whole list at once. */
+	int swap_cluster_max;
+};
+
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
 
 #ifdef ARCH_HAS_PREFETCH
Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -52,36 +52,6 @@ typedef enum {
 	PAGE_CLEAN,
 } pageout_t;
 
-struct scan_control {
-	/* Ask refill_inactive_zone, or shrink_cache to scan this many pages */
-	unsigned long nr_to_scan;
-
-	/* Incremented by the number of inactive pages that were scanned */
-	unsigned long nr_scanned;
-
-	/* Incremented by the number of pages reclaimed */
-	unsigned long nr_reclaimed;
-
-	unsigned long nr_mapped;	/* From page_state */
-
-	/* Ask shrink_caches, or shrink_zone to scan at this priority */
-	unsigned int priority;
-
-	/* This context's GFP mask */
-	gfp_t gfp_mask;
-
-	int may_writepage;
-
-	/* Can pages be swapped as part of reclaim? */
-	int may_swap;
-
-	/* This context's SWAP_CLUSTER_MAX. If freeing memory for
-	 * suspend, we effectively ignore SWAP_CLUSTER_MAX.
-	 * In this context, it doesn't matter that we scan the
-	 * whole list at once. */
-	int swap_cluster_max;
-};
-
 /*
  * The list of shrinker callbacks used by to apply pressure to
  * ageable caches.
