Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263006AbVGIAK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbVGIAK7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbVGIAJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:09:04 -0400
Received: from gold.veritas.com ([143.127.12.110]:17086 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S263006AbVGIAHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:07:09 -0400
Date: Sat, 9 Jul 2005 01:08:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] scan_swap_map restyled
In-Reply-To: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090107420.13391@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:07:09.0398 (UTC) FILETIME=[26262F60:01C5841A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite scan_swap_map to allocate in just the same way as before
(taking the next free entry SWAPFILE_CLUSTER-1 times, then restarting at
the lowest wholly empty cluster, falling back to lowest entry if none),
but with a view towards dropping the lock in the next patch.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/swapfile.c |   91 +++++++++++++++++++++++++++++-----------------------------
 1 files changed, 47 insertions(+), 44 deletions(-)

--- swap8/mm/swapfile.c	2005-07-08 19:14:54.000000000 +0100
+++ swap9/mm/swapfile.c	2005-07-08 19:15:06.000000000 +0100
@@ -84,64 +84,67 @@ void swap_unplug_io_fn(struct backing_de
 
 static inline unsigned long scan_swap_map(struct swap_info_struct *si)
 {
-	unsigned long offset;
+	unsigned long offset, last_in_cluster;
+
 	/* 
-	 * We try to cluster swap pages by allocating them
-	 * sequentially in swap.  Once we've allocated
-	 * SWAPFILE_CLUSTER pages this way, however, we resort to
-	 * first-free allocation, starting a new cluster.  This
-	 * prevents us from scattering swap pages all over the entire
-	 * swap partition, so that we reduce overall disk seek times
-	 * between swap pages.  -- sct */
-	if (si->cluster_nr) {
-		while (si->cluster_next <= si->highest_bit) {
-			offset = si->cluster_next++;
+	 * We try to cluster swap pages by allocating them sequentially
+	 * in swap.  Once we've allocated SWAPFILE_CLUSTER pages this
+	 * way, however, we resort to first-free allocation, starting
+	 * a new cluster.  This prevents us from scattering swap pages
+	 * all over the entire swap partition, so that we reduce
+	 * overall disk seek times between swap pages.  -- sct
+	 * But we do now try to find an empty cluster.  -Andrea
+	 */
+
+	if (unlikely(!si->cluster_nr)) {
+		si->cluster_nr = SWAPFILE_CLUSTER - 1;
+		if (si->pages - si->inuse_pages < SWAPFILE_CLUSTER)
+			goto lowest;
+
+		offset = si->lowest_bit;
+		last_in_cluster = offset + SWAPFILE_CLUSTER - 1;
+
+		/* Locate the first empty (unaligned) cluster */
+		for (; last_in_cluster <= si->highest_bit; offset++) {
 			if (si->swap_map[offset])
-				continue;
-			si->cluster_nr--;
-			goto got_page;
+				last_in_cluster = offset + SWAPFILE_CLUSTER;
+			else if (offset == last_in_cluster) {
+				si->cluster_next = offset-SWAPFILE_CLUSTER-1;
+				goto cluster;
+			}
 		}
+		goto lowest;
 	}
-	si->cluster_nr = SWAPFILE_CLUSTER;
 
-	/* try to find an empty (even not aligned) cluster. */
-	offset = si->lowest_bit;
- check_next_cluster:
-	if (offset+SWAPFILE_CLUSTER-1 <= si->highest_bit)
-	{
-		unsigned long nr;
-		for (nr = offset; nr < offset+SWAPFILE_CLUSTER; nr++)
-			if (si->swap_map[nr])
-			{
-				offset = nr+1;
-				goto check_next_cluster;
-			}
-		/* We found a completly empty cluster, so start
-		 * using it.
-		 */
-		goto got_page;
-	}
-	/* No luck, so now go finegrined as usual. -Andrea */
-	for (offset = si->lowest_bit; offset <= si->highest_bit ; offset++) {
-		if (si->swap_map[offset])
-			continue;
-		si->lowest_bit = offset+1;
-	got_page:
-		if (offset == si->lowest_bit)
+	si->cluster_nr--;
+cluster:
+	offset = si->cluster_next;
+	if (offset > si->highest_bit)
+lowest:		offset = si->lowest_bit;
+	if (!si->highest_bit)
+		goto no_page;
+	if (!si->swap_map[offset]) {
+got_page:	if (offset == si->lowest_bit)
 			si->lowest_bit++;
 		if (offset == si->highest_bit)
 			si->highest_bit--;
-		if (si->lowest_bit > si->highest_bit) {
+		si->inuse_pages++;
+		if (si->inuse_pages == si->pages) {
 			si->lowest_bit = si->max;
 			si->highest_bit = 0;
 		}
 		si->swap_map[offset] = 1;
-		si->inuse_pages++;
-		si->cluster_next = offset+1;
+		si->cluster_next = offset + 1;
 		return offset;
 	}
-	si->lowest_bit = si->max;
-	si->highest_bit = 0;
+
+	while (++offset <= si->highest_bit) {
+		if (!si->swap_map[offset])
+			goto got_page;
+	}
+	goto lowest;
+
+no_page:
 	return 0;
 }
 
