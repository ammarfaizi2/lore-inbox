Return-Path: <linux-kernel-owner+w=401wt.eu-S1161303AbXAHNtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161303AbXAHNtj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161304AbXAHNtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:49:39 -0500
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:53497 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161301AbXAHNth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:49:37 -0500
Subject: [PATCH 3/4] swap: Add try_to_unuse_page_entry()
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 13:49:04 +0000
Message-Id: <1168264144.5605.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add try_to_unuse_page_entry(). As this function takes a already locked page, 
the locking and refcounting within try_to_unuse_entry() needs to be rearranged.

These patches are a based on a patch by Nick Piggin and some of my own
patches/bugfixes as discussed on LKML.

Signed-off-by: Richard Purdie <rpurdie@openedhand.com>

---
 include/linux/swap.h |    1 
 mm/swapfile.c        |   52 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 13 deletions(-)

Index: git/include/linux/swap.h
===================================================================
--- git.orig/include/linux/swap.h	2007-01-08 11:39:36.000000000 +0000
+++ git/include/linux/swap.h	2007-01-08 11:39:42.000000000 +0000
@@ -253,6 +253,7 @@ extern sector_t swapdev_block(int, pgoff
 extern struct swap_info_struct *get_swap_info_struct(unsigned);
 extern int can_share_swap_page(struct page *);
 extern int remove_exclusive_swap_page(struct page *);
+extern void try_to_unuse_page_entry(struct page *page);
 struct backing_dev_info;
 
 extern spinlock_t swap_lock;
Index: git/mm/swapfile.c
===================================================================
--- git.orig/mm/swapfile.c	2007-01-08 11:39:36.000000000 +0000
+++ git/mm/swapfile.c	2007-01-08 12:19:08.000000000 +0000
@@ -656,12 +656,13 @@ static int unuse_mm(struct mm_struct *mm
 }
 
 static int try_to_unuse_entry(swp_entry_t entry, unsigned short *swap_map,
-			struct page *page, struct mm_struct **start_mm_p)
+			struct page *page, struct mm_struct **start_mm_p,
+			int initial_locked)
 {
 	struct mm_struct *start_mm;
 	unsigned short swcount;
 	int retval = 0;
-	int shmem;
+	int shmem, locked = initial_locked;
 
 	if (start_mm_p)
 		start_mm = *start_mm_p;
@@ -686,12 +687,13 @@ static int try_to_unuse_entry(swp_entry_
 	 * lets try_to_unuse defer to do_swap_page in such a case - in some
 	 * tests, do_swap_page and try_to_unuse repeatedly compete.
 	 */
-
-	wait_on_page_locked(page);
-	wait_on_page_writeback(page);
-	lock_page(page);
-	wait_on_page_writeback(page);
 retry:
+	if (!locked) {
+		wait_on_page_locked(page);
+		wait_on_page_writeback(page);
+		lock_page(page);
+	}
+	wait_on_page_writeback(page);
 
 	/*
 	 * Remove all references to entry.
@@ -789,8 +791,7 @@ retry:
 			};
 
 			swap_writepage(page, &wbc);
-			lock_page(page);
-			wait_on_page_writeback(page);
+			locked = 0;
 			goto retry;
 		}
 		if (!shmem) {
@@ -815,9 +816,8 @@ retry:
 	 */
 	SetPageDirty(page);
 unuse_err:
-	unlock_page(page);
-	page_cache_release(page);
-
+	if (!initial_locked)
+		unlock_page(page);
 	if (start_mm_p)
 		*start_mm_p = start_mm;
 	else
@@ -826,6 +826,31 @@ unuse_err:
 	return retval;
 }
 
+void try_to_unuse_page_entry(struct page *page)
+{
+	struct swap_info_struct *si;
+	unsigned short *swap_map;
+	swp_entry_t entry;
+
+	BUG_ON(!PageLocked(page));
+	BUG_ON(!PageSwapCache(page));
+	BUG_ON(PageWriteback(page));
+	BUG_ON(PagePrivate(page));
+
+	entry.val = page_private(page);
+	si = swap_info_get(entry);
+	if (!si) {
+		WARN_ON(1);
+		return;
+	}
+	swap_map = &si->swap_map[swp_offset(entry)];
+	spin_unlock(&swap_lock);
+
+	BUG_ON(*swap_map == SWAP_MAP_BAD);
+
+	try_to_unuse_entry(entry, swap_map, page, NULL, 1);
+}
+
 /*
  * Scan swap_map from current position to next entry still in use.
  * Recycle to start on reaching the end, returning 0 when empty.
@@ -929,7 +954,8 @@ static int try_to_unuse(unsigned int typ
 			break;
 		}
 
-		retval = try_to_unuse_entry(entry, swap_map, page, &start_mm);
+		retval = try_to_unuse_entry(entry, swap_map, page, &start_mm, 0);
+		page_cache_release(page);
 
 		if (retval)
 			break;


