Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVAUGC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVAUGC4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVAUGCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:02:48 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62034
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262278AbVAUGBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:01:36 -0500
Date: Fri, 21 Jan 2005 07:01:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <npiggin@novell.com>,
       Rik van Riel <riel@conectiva.com.br>
Subject: writeback-highmem
Message-ID: <20050121060135.GF12647@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random> <20050121054916.GB12647@dualathlon.random> <20050121054945.GC12647@dualathlon.random> <20050121055004.GD12647@dualathlon.random> <20050121055043.GE12647@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121055043.GE12647@dualathlon.random>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 38 12 CD 76 E4 82 94 AF 02 0C 0F FA E1 FF 55 9D 9B 4F A5 9B
X-Cpushare-SSL-MD5-Cert: ED A5 F2 DA 1D 32 75 60 5E 07 6C 91 BF FC B8 85
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This needed highmem fix from Rik is still missing too, so please apply
along the other 5 (it's orthogonal so you can apply this one in any
order you want).

From: Rik van Riel <riel@redhat.com>
Subject: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings

Simply running "dd if=/dev/zero of=/dev/hd<one you can miss>" will
result in OOM kills, with the dirty pagecache completely filling up
lowmem.  This patch is part 1 to fixing that problem.

This patch effectively lowers the dirty limit for mappings which cannot
be cached in highmem, counting the dirty limit as a percentage of lowmem
instead.  This should prevent heavy block device writers from pushing
the VM over the edge and triggering OOM kills.

Signed-off-by: Rik van Riel <riel@redhat.com>
Acked-by: Andrea Arcangeli <andrea@suse.de>

--- x/mm/page-writeback.c.orig	2005-01-04 01:13:30.000000000 +0100
+++ x/mm/page-writeback.c	2005-01-04 02:41:29.573177184 +0100
@@ -133,7 +133,8 @@ static void get_writeback_state(struct w
  * clamping level.
  */
 static void
-get_dirty_limits(struct writeback_state *wbs, long *pbackground, long *pdirty)
+get_dirty_limits(struct writeback_state *wbs, long *pbackground, long *pdirty,
+		 struct address_space *mapping)
 {
 	int background_ratio;		/* Percentages */
 	int dirty_ratio;
@@ -141,10 +142,20 @@ get_dirty_limits(struct writeback_state 
 	long background;
 	long dirty;
 	struct task_struct *tsk;
+	unsigned long available_memory = total_pages;
 
 	get_writeback_state(wbs);
 
-	unmapped_ratio = 100 - (wbs->nr_mapped * 100) / total_pages;
+#ifdef CONFIG_HIGHMEM
+	/*
+	 * In some cases we can only allocate from low memory,
+	 * so we exclude high memory from our count.
+	 */
+	if (mapping && !(mapping_gfp_mask(mapping) & __GFP_HIGHMEM))
+		available_memory -= totalhigh_pages;
+#endif
+
+	unmapped_ratio = 100 - (wbs->nr_mapped * 100) / available_memory;
 
 	dirty_ratio = vm_dirty_ratio;
 	if (dirty_ratio > unmapped_ratio / 2)
@@ -194,7 +205,7 @@ static void balance_dirty_pages(struct a
 			.nr_to_write	= write_chunk,
 		};
 
-		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh);
+		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh, mapping);
 		nr_reclaimable = wbs.nr_dirty + wbs.nr_unstable;
 		if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
 			break;
@@ -210,7 +221,7 @@ static void balance_dirty_pages(struct a
 		if (nr_reclaimable) {
 			writeback_inodes(&wbc);
 			get_dirty_limits(&wbs, &background_thresh,
-					&dirty_thresh);
+					&dirty_thresh, mapping);
 			nr_reclaimable = wbs.nr_dirty + wbs.nr_unstable;
 			if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
 				break;
@@ -296,7 +307,7 @@ static void background_writeout(unsigned
 		long background_thresh;
 		long dirty_thresh;
 
-		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh);
+		get_dirty_limits(&wbs, &background_thresh, &dirty_thresh, NULL);
 		if (wbs.nr_dirty + wbs.nr_unstable < background_thresh
 				&& min_pages <= 0)
 			break;
