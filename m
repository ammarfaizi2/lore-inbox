Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbULTPV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbULTPV1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbULTPUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:20:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64173 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261534AbULTPRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:17:33 -0500
Date: Mon, 20 Dec 2004 10:17:28 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, robert_hentosh@dell.com
Subject: [PATCH][2/2] do not OOM kill if we skip writing many pages
Message-ID: <Pine.LNX.4.61.0412201013420.13935@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simply running "dd if=/dev/zero of=/dev/hd<one you can miss>" will
result in OOM kills, with the dirty pagecache completely filling up
lowmem.  This patch is part 2 to fixing that problem.

Note that this test case demonstrates that the false OOM kills can
also be reproduced with pages that are not "pinned" by the swap token
at all, so there are some serious VM problems left still...

If we cannot write out a number of pages because of congestion on
the filesystem or block device, do not cause an OOM kill.  These
pages will become freeable later, when the congestion clears.

Signed-off-by: Rik van Riel <riel@redhat.com>

--- linux-2.6.9/mm/vmscan.c.oomkill	2004-12-17 12:19:36.000000000 -0500
+++ linux-2.6.9/mm/vmscan.c	2004-12-17 13:38:31.368294772 -0500
@@ -43,6 +43,8 @@
  typedef enum {
  	/* failed to write page out, page is locked */
  	PAGE_KEEP,
+	/* failed to write page out because of busy disk, page is locked */
+	PAGE_CONGESTED,
  	/* move page to the active list, page is locked */
  	PAGE_ACTIVATE,
  	/* page has been sent to the disk successfully, page is unlocked */
@@ -61,6 +63,9 @@
  	/* Incremented by the number of pages reclaimed */
  	unsigned long nr_reclaimed;

+	/* Incremented by the number of pages skipped due to congestion */
+	unsigned long nr_congested;
+
  	unsigned long nr_mapped;	/* From page_state */

  	/* How many pages shrink_cache() should reclaim */
@@ -312,7 +317,7 @@
  	if (mapping->a_ops->writepage == NULL)
  		return PAGE_ACTIVATE;
  	if (!may_write_to_queue(mapping->backing_dev_info))
-		return PAGE_KEEP;
+		return PAGE_CONGESTED;

  	if (clear_page_dirty_for_io(page)) {
  		int res;
@@ -424,6 +429,9 @@

  			/* Page is dirty, try to write it out here */
  			switch(pageout(page, mapping)) {
+			case PAGE_CONGESTED:
+				sc->nr_congested++;
+				/* fall through */
  			case PAGE_KEEP:
  				goto keep_locked;
  			case PAGE_ACTIVATE:
@@ -910,6 +918,7 @@
  		sc.nr_mapped = read_page_state(nr_mapped);
  		sc.nr_scanned = 0;
  		sc.nr_reclaimed = 0;
+		sc.nr_congested = 0;
  		sc.priority = priority;
  		shrink_caches(zones, &sc);
  		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
@@ -940,7 +949,8 @@
  		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
  			blk_congestion_wait(WRITE, HZ/10);
  	}
-	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
+	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY) &&
+			sc.nr_congested < SWAP_CLUSTER_MAX)
  		out_of_memory(gfp_mask);
  out:
  	for (i = 0; zones[i] != 0; i++)
@@ -1062,6 +1072,7 @@
  				zone->prev_priority = priority;
  			sc.nr_scanned = 0;
  			sc.nr_reclaimed = 0;
+			sc.nr_congested = 0;
  			sc.priority = priority;
  			shrink_zone(zone, &sc);
  			reclaim_state->reclaimed_slab = 0;
