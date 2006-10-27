Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946233AbWJ0IAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946233AbWJ0IAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 04:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946234AbWJ0IAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 04:00:24 -0400
Received: from tim.rpsys.net ([194.106.48.114]:60857 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1946233AbWJ0IAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 04:00:23 -0400
Subject: [PATCH, RFC/T] Fix handling of write failures to swap devices
From: Richard Purdie <rpurdie@openedhand.com>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 08:59:55 +0100
Message-Id: <1161935995.5019.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix handling of write failures to swap devices.

Calling SetPageError(page) marks the data in memory as bad and processes using
the page in question will die unexpectedly. This isn't necessary as the data 
in the memory page is still valid, just the copy on disk isn't. This patch 
therefore removes this call.

Setting set_page_dirty(page) is good as the memory page will be retained and 
processes don't die. It will try to write out the page again soon but a second 
attempt at a write is probably no more likely to succeed than the first 
resulting in IO loops. We can do better.

This patch attempts to unuse the page in a similar manner to swapoff. If 
successful, mark the swap page as bad and remove it from use. If we fail to
remove all references, we fall back on set_page_dirty above which will retry 
the write.

If we can mark the swap page as bad, adjust the VM accounting to reflect this.

Signed-off-by: Richard Purdie <rpurdie@openedhand.com>

---

Comments and testing from people who know this area of code better than
me would be appreciated!

 include/linux/swap.h |    1 
 mm/page_io.c         |   13 ----
 mm/swap_state.c      |    1 
 mm/swapfile.c        |  156 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+), 11 deletions(-)

Index: linux-2.6.19-rc3/include/linux/swap.h
===================================================================
--- linux-2.6.19-rc3.orig/include/linux/swap.h	2006-10-26 13:49:41.000000000 +0100
+++ linux-2.6.19-rc3/include/linux/swap.h	2006-10-26 13:50:40.000000000 +0100
@@ -253,6 +253,7 @@ extern sector_t map_swap_page(struct swa
 extern struct swap_info_struct *get_swap_info_struct(unsigned);
 extern int can_share_swap_page(struct page *);
 extern int remove_exclusive_swap_page(struct page *);
+extern void try_to_mark_swapbad(struct page *);
 struct backing_dev_info;
 
 extern spinlock_t swap_lock;
Index: linux-2.6.19-rc3/mm/swapfile.c
===================================================================
--- linux-2.6.19-rc3.orig/mm/swapfile.c	2006-10-26 13:49:41.000000000 +0100
+++ linux-2.6.19-rc3/mm/swapfile.c	2006-10-26 13:50:40.000000000 +0100
@@ -304,6 +304,25 @@ void swap_free(swp_entry_t entry)
 	}
 }
 
+static void swap_markbad_free(swp_entry_t entry)
+{
+	struct swap_info_struct * p;
+	unsigned long offset = swp_offset(entry);
+
+	p = swap_info_get(entry);
+	if (p) {
+		printk(KERN_ERR "Marking swap offset %ld as bad\n", offset);
+
+		if (swap_entry_free(p, offset) != 0)
+			printk(KERN_ERR "Bad swap entry didn't have zero count?\n");
+		p->swap_map[offset] = SWAP_MAP_BAD;
+		p->pages--;
+		nr_swap_pages--;
+		total_swap_pages--;
+		spin_unlock(&swap_lock);
+	}
+}
+
 /*
  * How many references to page are currently swapped out?
  */
@@ -887,6 +906,143 @@ static int try_to_unuse(unsigned int typ
 }
 
 /*
+ * Try to unuse a page (after a write failure).
+ * The caller holds a reference on the entry so it can
+ * perform the final free and mark the swap page bad.
+ * The page writeback lock is already held.
+ */
+static int try_to_unuse_page(struct page *page)
+{
+	swp_entry_t entry;
+	struct swap_info_struct *si;
+	unsigned short *swap_map;
+	unsigned int i = 0;
+	int retval = 0;
+
+	entry.val = page_private(page);
+
+	si = swap_info_get(entry);
+	if (!si)
+		return -ENODEV;
+
+	swap_map = &si->swap_map[swp_offset(entry)];
+	spin_unlock(&swap_lock);
+
+	if (*swap_map == SWAP_MAP_BAD)
+		return -EINVAL;
+
+	if (*swap_map == 1)
+		return 0;
+
+	lock_page(page);
+
+	/*
+	 * Keep on scanning until all references have gone.  Usually,
+	 * one pass through is enough, but not necessarily.
+	 * Try a few times, then give up.
+	 */
+	for (i = 0; i < 5; i++) {
+
+		/* Note shmem_unuse will delete a swappage from
+		 * the swap cache, unless the move to filepage failed.
+		 * If so, it left swappage in cache yet lowered its
+		 * swap count. We reincrement the count to try again later.
+		 */
+		if ((*swap_map > 2) && shmem_unuse(entry, page) && PageSwapCache(page))
+			swap_duplicate(entry);
+
+		if (*swap_map == 1) {
+			/* shmem deleted the page for us */
+			unlock_page(page);
+			return 0;
+		}
+
+		/*
+		 * Remove all references to entry.
+		 */
+		if (*swap_map > 2) {
+			struct mm_struct *start_mm = &init_mm;
+			struct mm_struct *prev_mm = &init_mm;
+			struct mm_struct *mm;
+			struct list_head *p = &start_mm->mmlist;
+
+			atomic_inc(&start_mm->mm_users);
+			atomic_inc(&prev_mm->mm_users);
+			spin_lock(&mmlist_lock);
+			while (*swap_map > 2 && !retval &&
+					(p = p->next) != &start_mm->mmlist) {
+				mm = list_entry(p, struct mm_struct, mmlist);
+				if (atomic_inc_return(&mm->mm_users) == 1) {
+					atomic_dec(&mm->mm_users);
+					continue;
+				}
+				spin_unlock(&mmlist_lock);
+				mmput(prev_mm);
+				prev_mm = mm;
+
+				if (*swap_map > 2)
+					retval = unuse_mm(mm, entry, page);
+				spin_lock(&mmlist_lock);
+			}
+			spin_unlock(&mmlist_lock);
+			mmput(prev_mm);
+			mmput(start_mm);
+			if (retval) {
+				unlock_page(page);
+				return retval;
+			}
+		}
+
+		/*
+		 * How could swap count reach 0x7fff when the maximum
+		 * pid is 0x7fff, and there's no way to repeat a swap
+		 * page within an mm (except in shmem, where it's the
+		 * shared object which takes the reference count)?
+		 * We believe SWAP_MAP_MAX cannot occur in Linux 2.4.
+		 *
+		 * We know "Undead"s can happen, they're okay, so don't
+		 * report them; but do report if we reset SWAP_MAP_MAX.
+		 */
+		if (*swap_map == SWAP_MAP_MAX) {
+			spin_lock(&swap_lock);
+			*swap_map = 2;
+			spin_unlock(&swap_lock);
+			printk(KERN_WARNING "unuse_page: cleared swap entry overflow\n");
+		}
+
+		if (PageSwapCache(page) && (*swap_map == 2)) {
+			/* We removed all the references, just the swapcache
+			 * reference itself left */
+			write_lock_irq(&swapper_space.tree_lock);
+			__delete_from_swap_cache(page);
+			write_unlock_irq(&swapper_space.tree_lock);
+			swap_free(entry);
+			unlock_page(page);
+			return 0;
+		}
+	}
+
+	unlock_page(page);
+	return -EAGAIN;
+}
+
+/*
+ * Try to mark a swap page as bad after a write failure
+ */
+void try_to_mark_swapbad(struct page *page)
+{
+	swp_entry_t entry;
+	entry.val = page_private(page);
+
+	/* Pin entry so we call the final free */
+	swap_duplicate(entry);
+	if (try_to_unuse_page(page) < 0)
+		swap_free(entry);
+	else
+		swap_markbad_free(entry);
+}
+
+/*
  * After a successful try_to_unuse, if no swap is now in use, we know
  * we can empty the mmlist.  swap_lock must be held on entry and exit.
  * Note that mmlist_lock nests inside swap_lock, and an mm must be
Index: linux-2.6.19-rc3/mm/page_io.c
===================================================================
--- linux-2.6.19-rc3.orig/mm/page_io.c	2006-10-26 13:49:41.000000000 +0100
+++ linux-2.6.19-rc3/mm/page_io.c	2006-10-26 13:50:40.000000000 +0100
@@ -53,21 +53,14 @@ static int end_swap_bio_write(struct bio
 		return 1;
 
 	if (!uptodate) {
-		SetPageError(page);
-		/*
-		 * We failed to write the page out to swap-space.
-		 * Re-dirty the page in order to avoid it being reclaimed.
-		 * Also print a dire warning that things will go BAD (tm)
-		 * very quickly.
-		 *
-		 * Also clear PG_reclaim to avoid rotate_reclaimable_page()
-		 */
+		/* Mark page as dirty so it stays in memory regardless.
+                   Worst case, we retry the write but attempt to mark it bad */
 		set_page_dirty(page);
+		try_to_mark_swapbad(page);
 		printk(KERN_ALERT "Write-error on swap-device (%u:%u:%Lu)\n",
 				imajor(bio->bi_bdev->bd_inode),
 				iminor(bio->bi_bdev->bd_inode),
 				(unsigned long long)bio->bi_sector);
-		ClearPageReclaim(page);
 	}
 	end_page_writeback(page);
 	bio_put(bio);
Index: linux-2.6.19-rc3/mm/swap_state.c
===================================================================
--- linux-2.6.19-rc3.orig/mm/swap_state.c	2006-10-26 13:49:41.000000000 +0100
+++ linux-2.6.19-rc3/mm/swap_state.c	2006-10-26 13:50:40.000000000 +0100
@@ -125,7 +125,6 @@ void __delete_from_swap_cache(struct pag
 {
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!PageSwapCache(page));
-	BUG_ON(PageWriteback(page));
 	BUG_ON(PagePrivate(page));
 
 	radix_tree_delete(&swapper_space.page_tree, page_private(page));


