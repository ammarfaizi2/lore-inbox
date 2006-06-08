Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWFHXEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWFHXEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWFHXEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:04:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:4540 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965070AbWFHXEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:04:05 -0400
Date: Thu, 8 Jun 2006 16:03:52 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230352.25121.41819.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 14/14] Remove useless writeback structure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove writeback state

We can remove some functions now that were needed to calculate the page
state for writeback control since these statistics are now directly
available.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/mm/page-writeback.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page-writeback.c	2006-06-07 18:57:51.435777984 -0700
+++ linux-2.6.17-rc6-mm1/mm/page-writeback.c	2006-06-07 19:21:47.052964181 -0700
@@ -99,22 +99,6 @@ EXPORT_SYMBOL(laptop_mode);
 
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
-	wbs->nr_mapped = global_page_state(NR_MAPPED);
-	wbs->nr_writeback = global_page_state(NR_WRITEBACK);
-}
-
 /*
  * Work out the current dirty-memory clamping and background writeout
  * thresholds.
@@ -133,8 +117,7 @@ static void get_writeback_state(struct w
  * clamping level.
  */
 static void
-get_dirty_limits(struct writeback_state *wbs, long *pbackground, long *pdirty,
-		struct address_space *mapping)
+get_dirty_limits(long *pbackground, long *pdirty, struct address_space *mapping)
 {
 	int background_ratio;		/* Percentages */
 	int dirty_ratio;
@@ -144,8 +127,6 @@ get_dirty_limits(struct writeback_state 
 	unsigned long available_memory = total_pages;
 	struct task_struct *tsk;
 
-	get_writeback_state(wbs);
-
 #ifdef CONFIG_HIGHMEM
 	/*
 	 * If this mapping can only allocate from low memory,
@@ -156,7 +137,7 @@ get_dirty_limits(struct writeback_state 
 #endif
 
 
-	unmapped_ratio = 100 - (wbs->nr_mapped * 100) / total_pages;
+	unmapped_ratio = 100 - (global_page_state(NR_MAPPED) * 100) / total_pages;
 
 	dirty_ratio = vm_dirty_ratio;
 	if (dirty_ratio > unmapped_ratio / 2)
@@ -189,7 +170,6 @@ get_dirty_limits(struct writeback_state 
  */
 static void balance_dirty_pages(struct address_space *mapping)
 {
-	struct writeback_state wbs;
 	long nr_reclaimable;
 	long background_thresh;
 	long dirty_thresh;
@@ -207,10 +187,9 @@ static void balance_dirty_pages(struct a
 			.range_cyclic	= 1,
 		};
 
-		get_dirty_limits(&wbs, &background_thresh,
-					&dirty_thresh, mapping);
-		nr_reclaimable = wbs.nr_dirty + wbs.nr_unstable;
-		if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
+		get_dirty_limits(&background_thresh, &dirty_thresh, mapping);
+		nr_reclaimable = global_page_state(NR_DIRTY) + global_page_state(NR_UNSTABLE);
+		if (nr_reclaimable + global_page_state(NR_WRITEBACK) <= dirty_thresh)
 			break;
 
 		if (!dirty_exceeded)
@@ -224,10 +203,9 @@ static void balance_dirty_pages(struct a
 		 */
 		if (nr_reclaimable) {
 			writeback_inodes(&wbc);
-			get_dirty_limits(&wbs, &background_thresh,
-					&dirty_thresh, mapping);
-			nr_reclaimable = wbs.nr_dirty + wbs.nr_unstable;
-			if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
+			get_dirty_limits(&background_thresh, &dirty_thresh, mapping);
+			nr_reclaimable = global_page_state(NR_DIRTY) + global_page_state(NR_UNSTABLE);
+			if (nr_reclaimable + global_page_state(NR_WRITEBACK) <= dirty_thresh)
 				break;
 			pages_written += write_chunk - wbc.nr_to_write;
 			if (pages_written >= write_chunk)
@@ -236,8 +214,9 @@ static void balance_dirty_pages(struct a
 		blk_congestion_wait(WRITE, HZ/10);
 	}
 
-	if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh && dirty_exceeded)
-		dirty_exceeded = 0;
+	if (nr_reclaimable + global_page_state(NR_WRITEBACK)
+		<= dirty_thresh && dirty_exceeded)
+			dirty_exceeded = 0;
 
 	if (writeback_in_progress(bdi))
 		return;		/* pdflush is already working this queue */
@@ -299,12 +278,11 @@ EXPORT_SYMBOL(balance_dirty_pages_rateli
 
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
@@ -312,7 +290,7 @@ void throttle_vm_writeout(void)
                  */
                 dirty_thresh += dirty_thresh / 10;      /* wheeee... */
 
-                if (wbs.nr_unstable + wbs.nr_writeback <= dirty_thresh)
+                if (global_page_state(NR_UNSTABLE) + global_page_state(NR_WRITEBACK) <= dirty_thresh)
                         break;
                 blk_congestion_wait(WRITE, HZ/10);
         }
@@ -336,12 +314,11 @@ static void background_writeout(unsigned
 	};
 
 	for ( ; ; ) {
-		struct writeback_state wbs;
 		long background_thresh;
 		long dirty_thresh;
 
-		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh, NULL);
-		if (wbs.nr_dirty + wbs.nr_unstable < background_thresh
+		get_dirty_limits(&background_thresh, &dirty_thresh, NULL);
+		if (global_page_state(NR_DIRTY) + global_page_state(NR_UNSTABLE) < background_thresh
 				&& min_pages <= 0)
 			break;
 		wbc.encountered_congestion = 0;
@@ -365,12 +342,8 @@ static void background_writeout(unsigned
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
+		nr_pages = global_page_state(NR_DIRTY) + global_page_state(NR_UNSTABLE);
 	return pdflush_operation(background_writeout, nr_pages);
 }
 
@@ -401,7 +374,6 @@ static void wb_kupdate(unsigned long arg
 	unsigned long start_jif;
 	unsigned long next_jif;
 	long nr_to_write;
-	struct writeback_state wbs;
 	struct writeback_control wbc = {
 		.bdi		= NULL,
 		.sync_mode	= WB_SYNC_NONE,
@@ -414,11 +386,11 @@ static void wb_kupdate(unsigned long arg
 
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
