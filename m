Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVAUNqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVAUNqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 08:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVAUNqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 08:46:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30340 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262363AbVAUNqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 08:46:39 -0500
Date: Fri, 21 Jan 2005 08:46:30 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       npiggin@novell.com
Subject: Re: writeback-highmem
In-Reply-To: <20050120222630.6168a4cb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501210740590.11103@chimarrao.boston.redhat.com>
References: <20050121054840.GA12647@dualathlon.random>
 <20050121054916.GB12647@dualathlon.random> <20050121054945.GC12647@dualathlon.random>
 <20050121055004.GD12647@dualathlon.random> <20050121055043.GE12647@dualathlon.random>
 <20050121060135.GF12647@dualathlon.random> <20050120222630.6168a4cb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2005, Andrew Morton wrote:

> I've held off on this one because the recent throttling fix should have
> helped this problem.  Has anyone confirmed that this patch still actually
> fixes something?  If so, what was the scenario?

The throttling fix is not quite enough, a big mkfs can still
completely paralyse the system.  Note that the previously
posted patch wasn't quite complete, Larry Woodman spotted an
additional 2 lines that needed changing.

The full patch is:

This patch effectively lowers the dirty limit for mappings which cannot
be cached in highmem, counting the dirty limit as a percentage of lowmem
instead.  This should prevent heavy block device writers from pushing
the VM over the edge and triggering OOM kills.

Signed-off-by: Rik van Riel <riel@redhat.com>

===== mm/page-writeback.c 1.95 vs edited =====
--- 1.95/mm/page-writeback.c	Thu Oct 21 04:39:27 2004
+++ edited/mm/page-writeback.c	Fri Jan 21 08:45:24 2005
@@ -133,17 +133,27 @@
   * clamping level.
   */
  static void
-get_dirty_limits(struct writeback_state *wbs, long *pbackground, long *pdirty)
+get_dirty_limits(struct writeback_state *wbs, long *pbackground, long *pdirty, struct address_space *mapping)
  {
  	int background_ratio;		/* Percentages */
  	int dirty_ratio;
  	int unmapped_ratio;
  	long background;
  	long dirty;
+	unsigned long available_memory = total_pages;
  	struct task_struct *tsk;

  	get_writeback_state(wbs);

+#ifdef CONFIG_HIGHMEM
+	/*
+	 * If this mapping can only allocate from low memory,
+	 * we exclude high memory from our count.
+	 */
+	if (mapping && !(mapping_gfp_mask(mapping) & __GFP_HIGHMEM))
+		available_memory -= totalhigh_pages;
+#endif
+
  	unmapped_ratio = 100 - (wbs->nr_mapped * 100) / total_pages;

  	dirty_ratio = vm_dirty_ratio;
@@ -157,8 +167,8 @@
  	if (background_ratio >= dirty_ratio)
  		background_ratio = dirty_ratio / 2;

-	background = (background_ratio * total_pages) / 100;
-	dirty = (dirty_ratio * total_pages) / 100;
+	background = (background_ratio * available_memory) / 100;
+	dirty = (dirty_ratio * available_memory) / 100;
  	tsk = current;
  	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk)) {
  		background += background / 4;
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
@@ -296,7 +307,7 @@
  		long background_thresh;
  		long dirty_thresh;

-		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh);
+		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh, NULL);
  		if (wbs.nr_dirty + wbs.nr_unstable < background_thresh
  				&& min_pages <= 0)
  			break;
