Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWFLVOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWFLVOy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWFLVOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:14:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7600 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932306AbWFLVOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:14:42 -0400
Date: Mon, 12 Jun 2006 14:14:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211433.20862.22225.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 21/21] Remove useless struct wbs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned vm counters: remove useless writeback structure
From: Christoph Lameter <clameter@sgi.com>

Remove writeback state

We can remove some functions now that were needed to calculate the page state
for writeback control since these statistics are now directly available.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Index: linux-2.6.17-rc6-cl/mm/page-writeback.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page-writeback.c	2006-06-10 17:25:05.237248907 -0700
+++ linux-2.6.17-rc6-cl/mm/page-writeback.c	2006-06-10 19:27:44.138352158 -0700
@@ -99,23 +99,6 @@ EXPORT_SYMBOL(laptop_mode);
 
 static void background_writeout(unsigned long _min_pages);
 
-struct writeback_state
-{
-	unsigned long nr_dirty;
-	unsigned long nr_unstable;
-	unsigned long nr_mapped;
-	unsigned long nr_writeback;
-};
-
-static void get_writeback_state(struct writeback_state *wbs)
-{
-	wbs->nr_dirty = global_page_state(NR_DIRTY);
-	wbs->nr_unstable = global_page_state(NR_UNSTABLE);
-	wbs->nr_mapped = global_page_state(NR_MAPPED) +
-				global_page_state(NR_ANON);
-	wbs->nr_writeback = global_page_state(NR_WRITEBACK);
-}
-
 /*
  * Work out the current dirty-memory clamping and background writeout
  * thresholds.
@@ -134,8 +117,7 @@ static void get_writeback_state(struct w
  * clamping level.
  */
 static void
-get_dirty_limits(struct writeback_state *wbs, long *pbackground, long *pdirty,
-		struct address_space *mapping)
+get_dirty_limits(long *pbackground, long *pdirty, struct address_space *mapping)
 {
 	int background_ratio;		/* Percentages */
 	int dirty_ratio;
@@ -145,8 +127,6 @@ get_dirty_limits(struct writeback_state 
 	unsigned long available_memory = total_pages;
 	struct task_struct *tsk;
 
-	get_writeback_state(wbs);
-
 #ifdef CONFIG_HIGHMEM
 	/*
 	 * If this mapping can only allocate from low memory,
@@ -157,7 +137,9 @@ get_dirty_limits(struct writeback_state 
 #endif
 
 
-	unmapped_ratio = 100 - (wbs->nr_mapped * 100) / total_pages;
+	unmapped_ratio = 100 - ((global_page_state(NR_MAPPED) +
+				global_page_state(NR_ANON)) * 100) /
+					total_pages;
 
 	dirty_ratio = vm_dirty_ratio;
 	if (dirty_ratio > unmapped_ratio / 2)
@@ -190,7 +172,6 @@ get_dirty_limits(struct writeback_state 
  */
 static void balance_dirty_pages(struct address_space *mapping)
 {
-	struct writeback_state wbs;
 	long nr_reclaimable;
 	long background_thresh;
 	long dirty_thresh;
@@ -208,11 +189,12 @@ static void balance_dirty_pages(struct a
 			.range_cyclic	= 1,
 		};
 
-		get_dirty_limits(&wbs, &background_thresh,
-					&dirty_thresh, mapping);
-		nr_reclaimable = wbs.nr_dirty + wbs.nr_unstable;
-		if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
-			break;
+		get_dirty_limits(&background_thresh, &dirty_thresh, mapping);
+		nr_reclaimable = global_page_state(NR_DIRTY) +
+					global_page_state(NR_UNSTABLE);
+		if (nr_reclaimable + global_page_state(NR_WRITEBACK) <=
+			dirty_thresh)
+				break;
 
 		if (!dirty_exceeded)
 			dirty_exceeded = 1;
@@ -225,11 +207,14 @@ static void balance_dirty_pages(struct a
 		 */
 		if (nr_reclaimable) {
 			writeback_inodes(&wbc);
-			get_dirty_limits(&wbs, &background_thresh,
-					&dirty_thresh, mapping);
-			nr_reclaimable = wbs.nr_dirty + wbs.nr_unstable;
-			if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
-				break;
+			get_dirty_limits(&background_thresh,
+					 	&dirty_thresh, mapping);
+			nr_reclaimable = global_page_state(NR_DIRTY) +
+					global_page_state(NR_UNSTABLE);
+			if (nr_reclaimable +
+				global_page_state(NR_WRITEBACK)
+					<= dirty_thresh)
+						break;
 			pages_written += write_chunk - wbc.nr_to_write;
 			if (pages_written >= write_chunk)
 				break;		/* We've done our duty */
@@ -237,8 +222,9 @@ static void balance_dirty_pages(struct a
 		blk_congestion_wait(WRITE, HZ/10);
 	}
 
-	if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh && dirty_exceeded)
-		dirty_exceeded = 0;
+	if (nr_reclaimable + global_page_state(NR_WRITEBACK)
+		<= dirty_thresh && dirty_exceeded)
+			dirty_exceeded = 0;
 
 	if (writeback_in_progress(bdi))
 		return;		/* pdflush is already working this queue */
@@ -300,12 +286,11 @@ EXPORT_SYMBOL(balance_dirty_pages_rateli
 
 void throttle_vm_writeout(void)
 {
-	struct writeback_state wbs;
 	long background_thresh;
 	long dirty_thresh;
 
         for ( ; ; ) {
-		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh, NULL);
+		get_dirty_limits(&background_thresh, &dirty_thresh, NULL);
 
                 /*
                  * Boost the allowable dirty threshold a bit for page
@@ -313,8 +298,9 @@ void throttle_vm_writeout(void)
                  */
                 dirty_thresh += dirty_thresh / 10;      /* wheeee... */
 
-                if (wbs.nr_unstable + wbs.nr_writeback <= dirty_thresh)
-                        break;
+                if (global_page_state(NR_UNSTABLE) +
+			global_page_state(NR_WRITEBACK) <= dirty_thresh)
+                        	break;
                 blk_congestion_wait(WRITE, HZ/10);
         }
 }
@@ -337,12 +323,12 @@ static void background_writeout(unsigned
 	};
 
 	for ( ; ; ) {
-		struct writeback_state wbs;
 		long background_thresh;
 		long dirty_thresh;
 
-		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh, NULL);
-		if (wbs.nr_dirty + wbs.nr_unstable < background_thresh
+		get_dirty_limits(&background_thresh, &dirty_thresh, NULL);
+		if (global_page_state(NR_DIRTY) +
+			global_page_state(NR_UNSTABLE) < background_thresh
 				&& min_pages <= 0)
 			break;
 		wbc.encountered_congestion = 0;
@@ -366,12 +352,9 @@ static void background_writeout(unsigned
  */
 int wakeup_pdflush(long nr_pages)
 {
-	if (nr_pages == 0) {
-		struct writeback_state wbs;
-
-		get_writeback_state(&wbs);
-		nr_pages = wbs.nr_dirty + wbs.nr_unstable;
-	}
+	if (nr_pages == 0)
+		nr_pages = global_page_state(NR_DIRTY) +
+				global_page_state(NR_UNSTABLE);
 	return pdflush_operation(background_writeout, nr_pages);
 }
 
@@ -402,7 +385,6 @@ static void wb_kupdate(unsigned long arg
 	unsigned long start_jif;
 	unsigned long next_jif;
 	long nr_to_write;
-	struct writeback_state wbs;
 	struct writeback_control wbc = {
 		.bdi		= NULL,
 		.sync_mode	= WB_SYNC_NONE,
@@ -415,11 +397,11 @@ static void wb_kupdate(unsigned long arg
 
 	sync_supers();
 
-	get_writeback_state(&wbs);
 	oldest_jif = jiffies - dirty_expire_interval;
 	start_jif = jiffies;
 	next_jif = start_jif + dirty_writeback_interval;
-	nr_to_write = wbs.nr_dirty + wbs.nr_unstable +
+	nr_to_write = global_page_state(NR_DIRTY) +
+			global_page_state(NR_UNSTABLE) +
 			(inodes_stat.nr_inodes - inodes_stat.nr_unused);
 	while (nr_to_write > 0) {
 		wbc.encountered_congestion = 0;
