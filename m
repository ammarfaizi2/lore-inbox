Return-Path: <linux-kernel-owner+w=401wt.eu-S1161301AbXAHNuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161301AbXAHNuO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161311AbXAHNuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:50:12 -0500
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:53500 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161301AbXAHNtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:49:41 -0500
Subject: [PATCH 4/4] swap: Catch pages with errors and mark as bad
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 13:49:10 +0000
Message-Id: <1168264150.5605.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check for pages with errors within shrink_page_list() and if found, try
to unuse them which will trigger the functions to mark the page bad. The
page will then be allocated a new swap page.

If a swap page write error occurs, don't disable page reclaim.

These patches are a based on a patch by Nick Piggin and some of my own
patches/bugfixes as discussed on LKML.

Signed-off-by: Richard Purdie <rpurdie@openedhand.com>

---
 mm/page_io.c |    3 ---
 mm/vmscan.c  |    9 +++++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

Index: git/mm/page_io.c
===================================================================
--- git.orig/mm/page_io.c	2007-01-07 21:39:29.000000000 +0000
+++ git/mm/page_io.c	2007-01-08 11:40:38.000000000 +0000
@@ -59,15 +59,12 @@ static int end_swap_bio_write(struct bio
 		 * Re-dirty the page in order to avoid it being reclaimed.
 		 * Also print a dire warning that things will go BAD (tm)
 		 * very quickly.
-		 *
-		 * Also clear PG_reclaim to avoid rotate_reclaimable_page()
 		 */
 		set_page_dirty(page);
 		printk(KERN_ALERT "Write-error on swap-device (%u:%u:%Lu)\n",
 				imajor(bio->bi_bdev->bd_inode),
 				iminor(bio->bi_bdev->bd_inode),
 				(unsigned long long)bio->bi_sector);
-		ClearPageReclaim(page);
 	}
 	end_page_writeback(page);
 	bio_put(bio);
Index: git/mm/vmscan.c
===================================================================
--- git.orig/mm/vmscan.c	2007-01-07 21:39:29.000000000 +0000
+++ git/mm/vmscan.c	2007-01-08 11:40:00.000000000 +0000
@@ -490,6 +490,15 @@ static unsigned long shrink_page_list(st
 
 #ifdef CONFIG_SWAP
 		/*
+		 * Encountered an error last time? Try to remove the
+		 * page from its current position, which will notice
+		 * the error and mark that swap entry bad. Then we can
+		 * try allocating another swap entry.
+		 */
+		if (PageSwapCache(page) && unlikely(PageError(page)))
+			try_to_unuse_page_entry(page);
+
+		/*
 		 * Anonymous process memory has backing store?
 		 * Try to allocate it some swap space here.
 		 */


