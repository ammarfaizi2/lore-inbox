Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbULTPV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbULTPV1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbULTPUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:20:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55212 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261533AbULTPPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:15:46 -0500
Date: Mon, 20 Dec 2004 10:15:34 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com
Subject: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simply running "dd if=/dev/zero of=/dev/hd<one you can miss>" will
result in OOM kills, with the dirty pagecache completely filling up
lowmem.  This patch is part 1 to fixing that problem.

This patch effectively lowers the dirty limit for mappings which cannot
be cached in highmem, counting the dirty limit as a percentage of lowmem
instead.  This should prevent heavy block device writers from pushing
the VM over the edge and triggering OOM kills.

Signed-off-by: Rik van Riel <riel@redhat.com>


--- linux-2.6.9/mm/page-writeback.c.highmem	2004-12-16 11:22:48.193641312 
-0500
+++ linux-2.6.9/mm/page-writeback.c	2004-12-16 11:30:00.565676290 -0500
@@ -133,18 +133,28 @@
   * clamping level.
   */
  static void
-get_dirty_limits(struct writeback_state *wbs, long *pbackground, long *pdirty)
+get_dirty_limits(struct writeback_state *wbs, long *pbackground, long *pdirty, 
struct address_space *mapping)
  {
  	int background_ratio;		/* Percentages */
  	int dirty_ratio;
  	int unmapped_ratio;
  	long background;
  	long dirty;
+	unsigned long available_memory = total_pages;
  	struct task_struct *tsk;

  	get_writeback_state(wbs);

-	unmapped_ratio = 100 - (wbs->nr_mapped * 100) / total_pages;
+#ifdef CONFIG_HIGHMEM
+	/*
+	 * If this mapping can only allocate from low memory,
+	 * we exclude high memory from our count.
+	 */
+	if (mapping && !(mapping_gfp_mask(mapping) & __GFP_HIGHMEM))
+		available_memory -= totalhigh_pages;
+#endif
+
+	unmapped_ratio = 100 - (wbs->nr_mapped * 100) / available_memory;

  	dirty_ratio = vm_dirty_ratio;
  	if (dirty_ratio > unmapped_ratio / 2)
@@ -194,7 +204,8 @@
  			.nr_to_write	= write_chunk,
  		};

-		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh);
+		get_dirty_limits(&wbs, &background_thresh,
+					&dirty_thresh, mapping);
  		nr_reclaimable = wbs.nr_dirty + wbs.nr_unstable;
  		if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
  			break;
@@ -210,7 +221,7 @@
  		if (nr_reclaimable) {
  			writeback_inodes(&wbc);
  			get_dirty_limits(&wbs, &background_thresh,
-					&dirty_thresh);
+					&dirty_thresh, mapping);
  			nr_reclaimable = wbs.nr_dirty + wbs.nr_unstable;
  			if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
  				break;
@@ -283,7 +294,7 @@
  	long dirty_thresh;

          for ( ; ; ) {
-		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh);
+		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh, 
NULL);

                  /*
                   * Boost the allowable dirty threshold a bit for page
@@ -318,7 +329,7 @@
  		long background_thresh;
  		long dirty_thresh;

-		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh);
+		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh, 
NULL);
  		if (wbs.nr_dirty + wbs.nr_unstable < background_thresh
  				&& min_pages <= 0)
  			break;
