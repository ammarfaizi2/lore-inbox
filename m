Return-Path: <linux-kernel-owner+w=401wt.eu-S1161296AbXAHNtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161296AbXAHNtN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161297AbXAHNtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:49:12 -0500
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:53453 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161296AbXAHNtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:49:11 -0500
Subject: [PATCH 1/4] swap: Split up try_to_unuse()
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 13:48:53 +0000
Message-Id: <1168264133.5605.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Split the core of try_to_unuse() into a new function,
try_to_unuse_entry().

These patches are a based on a patch by Nick Piggin and some of my own
patches/bugfixes as discussed on LKML.

Signed-off-by: Richard Purdie <rpurdie@openedhand.com>

---
 mm/swapfile.c |  321 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 170 insertions(+), 151 deletions(-)

Index: git/mm/swapfile.c
===================================================================
--- git.orig/mm/swapfile.c	2007-01-07 21:39:29.000000000 +0000
+++ git/mm/swapfile.c	2007-01-08 11:39:27.000000000 +0000
@@ -638,6 +638,174 @@ static int unuse_mm(struct mm_struct *mm
 	return 0;
 }
 
+static int try_to_unuse_entry(swp_entry_t entry, unsigned short *swap_map,
+			struct page *page, struct mm_struct **start_mm_p)
+{
+	struct mm_struct *start_mm;
+	unsigned short swcount;
+	int retval = 0;
+	int shmem;
+
+	if (start_mm_p)
+		start_mm = *start_mm_p;
+	else {
+		start_mm = &init_mm;
+		atomic_inc(&init_mm.mm_users);
+	}
+
+	/*
+	 * Don't hold on to start_mm if it looks like exiting.
+	 */
+	if (atomic_read(&start_mm->mm_users) == 1) {
+		mmput(start_mm);
+		start_mm = &init_mm;
+		atomic_inc(&init_mm.mm_users);
+	}
+
+	/*
+	 * Wait for and lock page.  When do_swap_page races with try_to_unuse,
+	 * do_swap_page can handle the fault much faster than try_to_unuse can
+	 * locate the entry.  This apparently redundant "wait_on_page_locked"
+	 * lets try_to_unuse defer to do_swap_page in such a case - in some
+	 * tests, do_swap_page and try_to_unuse repeatedly compete.
+	 */
+
+	wait_on_page_locked(page);
+	wait_on_page_writeback(page);
+	lock_page(page);
+	wait_on_page_writeback(page);
+retry:
+
+	/*
+	 * Remove all references to entry.
+	 * Whenever we reach init_mm, there's no address space to search, but
+	 * use it as a reminder to search shmem.
+	 */
+	shmem = 0;
+	swcount = *swap_map;
+	if (swcount > 1) {
+		if (start_mm == &init_mm)
+			shmem = shmem_unuse(entry, page);
+		else
+			retval = unuse_mm(start_mm, entry, page);
+	}
+	if (*swap_map > 1) {
+		int set_start_mm = (*swap_map >= swcount);
+		struct list_head *p = &start_mm->mmlist;
+		struct mm_struct *new_start_mm = start_mm;
+		struct mm_struct *prev_mm = start_mm;
+		struct mm_struct *mm;
+
+		atomic_inc(&new_start_mm->mm_users);
+		atomic_inc(&prev_mm->mm_users);
+		spin_lock(&mmlist_lock);
+		while (*swap_map > 1 && !retval &&
+				(p = p->next) != &start_mm->mmlist) {
+			mm = list_entry(p, struct mm_struct, mmlist);
+			if (!atomic_inc_not_zero(&mm->mm_users))
+				continue;
+			spin_unlock(&mmlist_lock);
+			mmput(prev_mm);
+			prev_mm = mm;
+
+			cond_resched();
+
+			swcount = *swap_map;
+			if (swcount <= 1)
+				;
+			else if (mm == &init_mm) {
+				set_start_mm = 1;
+				shmem = shmem_unuse(entry, page);
+			} else
+				retval = unuse_mm(mm, entry, page);
+			if (set_start_mm && *swap_map < swcount) {
+				mmput(new_start_mm);
+				atomic_inc(&mm->mm_users);
+				new_start_mm = mm;
+				set_start_mm = 0;
+			}
+			spin_lock(&mmlist_lock);
+		}
+		spin_unlock(&mmlist_lock);
+		mmput(prev_mm);
+		mmput(start_mm);
+		start_mm = new_start_mm;
+	}
+	if (retval)
+		goto unuse_err;
+
+	/*
+	 * How could swap count reach 0x7fff when the maximum pid is 0x7fff,
+	 * and there's no way to repeat a swap page within an mm (except in
+	 * shmem, where it's the shared object which takes the reference
+	 * count)?  We believe SWAP_MAP_MAX cannot occur in Linux 2.4.
+	 *
+	 * If that's wrong, then we should worry more about exit_mmap() and
+	 * do_munmap() cases described above: we might be resetting
+	 * SWAP_MAP_MAX too early here.  We know "Undead"s can happen, they're
+	 * okay, so don't report them; but do report if we reset SWAP_MAP_MAX.
+	 */
+	if (*swap_map == SWAP_MAP_MAX) {
+		spin_lock(&swap_lock);
+		*swap_map = 1;
+		spin_unlock(&swap_lock);
+		if (printk_ratelimit())
+			printk(KERN_WARNING
+				"try_to_unuse_entry: cleared swap entry overflow\n");
+	}
+
+	/*
+	 * If a reference remains (rare), we would like to leave the page in
+	 * the swap cache; but try_to_unmap could then re-duplicate the entry
+	 * once we drop page lock, so we might loop indefinitely; also, that
+	 * page could not be swapped out to other storage meanwhile.  So:
+	 * delete from cache even if there's another reference, after ensuring
+	 * that the data has been saved to disk - since if the reference
+	 * remains (rarer), it will be read from disk into another page.
+	 * Splitting into two pages would be incorrect if swap supported
+	 * "shared private" pages, but they are handled by tmpfs files.
+	 *
+	 * Note shmem_unuse already deleted a swappage from the swap cache,
+	 * unless the move to filepage failed: in which case it left swappage
+	 * in cache, lowered its swap count to pass quickly through the loops
+	 * above, and now we must reincrement count to try again later.
+	 */
+	if (PageSwapCache(page)) {
+		if ((*swap_map > 1) && PageDirty(page)) {
+			struct writeback_control wbc = {
+				.sync_mode = WB_SYNC_NONE,
+			};
+
+			swap_writepage(page, &wbc);
+			lock_page(page);
+			wait_on_page_writeback(page);
+			goto retry;
+		}
+
+		if (shmem)
+			swap_duplicate(entry);
+		else
+			delete_from_swap_cache(page);
+	}
+
+	/*
+	 * So we could skip searching mms once swap count went to 1, we did not
+	 * mark any present ptes as dirty: must mark page dirty so shrink_list
+	 * will preserve it.
+	 */
+	SetPageDirty(page);
+unuse_err:
+	unlock_page(page);
+	page_cache_release(page);
+
+	if (start_mm_p)
+		*start_mm_p = start_mm;
+	else
+		mmput(start_mm);
+
+	return retval;
+}
+
 /*
  * Scan swap_map from current position to next entry still in use.
  * Recycle to start on reaching the end, returning 0 when empty.
@@ -686,13 +854,10 @@ static int try_to_unuse(unsigned int typ
 	struct swap_info_struct * si = &swap_info[type];
 	struct mm_struct *start_mm;
 	unsigned short *swap_map;
-	unsigned short swcount;
 	struct page *page;
 	swp_entry_t entry;
 	unsigned int i = 0;
 	int retval = 0;
-	int reset_overflow = 0;
-	int shmem;
 
 	/*
 	 * When searching mms for an entry, a good strategy is to
@@ -744,152 +909,10 @@ static int try_to_unuse(unsigned int typ
 			break;
 		}
 
-		/*
-		 * Don't hold on to start_mm if it looks like exiting.
-		 */
-		if (atomic_read(&start_mm->mm_users) == 1) {
-			mmput(start_mm);
-			start_mm = &init_mm;
-			atomic_inc(&init_mm.mm_users);
-		}
-
-		/*
-		 * Wait for and lock page.  When do_swap_page races with
-		 * try_to_unuse, do_swap_page can handle the fault much
-		 * faster than try_to_unuse can locate the entry.  This
-		 * apparently redundant "wait_on_page_locked" lets try_to_unuse
-		 * defer to do_swap_page in such a case - in some tests,
-		 * do_swap_page and try_to_unuse repeatedly compete.
-		 */
-		wait_on_page_locked(page);
-		wait_on_page_writeback(page);
-		lock_page(page);
-		wait_on_page_writeback(page);
-
-		/*
-		 * Remove all references to entry.
-		 * Whenever we reach init_mm, there's no address space
-		 * to search, but use it as a reminder to search shmem.
-		 */
-		shmem = 0;
-		swcount = *swap_map;
-		if (swcount > 1) {
-			if (start_mm == &init_mm)
-				shmem = shmem_unuse(entry, page);
-			else
-				retval = unuse_mm(start_mm, entry, page);
-		}
-		if (*swap_map > 1) {
-			int set_start_mm = (*swap_map >= swcount);
-			struct list_head *p = &start_mm->mmlist;
-			struct mm_struct *new_start_mm = start_mm;
-			struct mm_struct *prev_mm = start_mm;
-			struct mm_struct *mm;
-
-			atomic_inc(&new_start_mm->mm_users);
-			atomic_inc(&prev_mm->mm_users);
-			spin_lock(&mmlist_lock);
-			while (*swap_map > 1 && !retval &&
-					(p = p->next) != &start_mm->mmlist) {
-				mm = list_entry(p, struct mm_struct, mmlist);
-				if (!atomic_inc_not_zero(&mm->mm_users))
-					continue;
-				spin_unlock(&mmlist_lock);
-				mmput(prev_mm);
-				prev_mm = mm;
-
-				cond_resched();
+		retval = try_to_unuse_entry(entry, swap_map, page, &start_mm);
 
-				swcount = *swap_map;
-				if (swcount <= 1)
-					;
-				else if (mm == &init_mm) {
-					set_start_mm = 1;
-					shmem = shmem_unuse(entry, page);
-				} else
-					retval = unuse_mm(mm, entry, page);
-				if (set_start_mm && *swap_map < swcount) {
-					mmput(new_start_mm);
-					atomic_inc(&mm->mm_users);
-					new_start_mm = mm;
-					set_start_mm = 0;
-				}
-				spin_lock(&mmlist_lock);
-			}
-			spin_unlock(&mmlist_lock);
-			mmput(prev_mm);
-			mmput(start_mm);
-			start_mm = new_start_mm;
-		}
-		if (retval) {
-			unlock_page(page);
-			page_cache_release(page);
+		if (retval)
 			break;
-		}
-
-		/*
-		 * How could swap count reach 0x7fff when the maximum
-		 * pid is 0x7fff, and there's no way to repeat a swap
-		 * page within an mm (except in shmem, where it's the
-		 * shared object which takes the reference count)?
-		 * We believe SWAP_MAP_MAX cannot occur in Linux 2.4.
-		 *
-		 * If that's wrong, then we should worry more about
-		 * exit_mmap() and do_munmap() cases described above:
-		 * we might be resetting SWAP_MAP_MAX too early here.
-		 * We know "Undead"s can happen, they're okay, so don't
-		 * report them; but do report if we reset SWAP_MAP_MAX.
-		 */
-		if (*swap_map == SWAP_MAP_MAX) {
-			spin_lock(&swap_lock);
-			*swap_map = 1;
-			spin_unlock(&swap_lock);
-			reset_overflow = 1;
-		}
-
-		/*
-		 * If a reference remains (rare), we would like to leave
-		 * the page in the swap cache; but try_to_unmap could
-		 * then re-duplicate the entry once we drop page lock,
-		 * so we might loop indefinitely; also, that page could
-		 * not be swapped out to other storage meanwhile.  So:
-		 * delete from cache even if there's another reference,
-		 * after ensuring that the data has been saved to disk -
-		 * since if the reference remains (rarer), it will be
-		 * read from disk into another page.  Splitting into two
-		 * pages would be incorrect if swap supported "shared
-		 * private" pages, but they are handled by tmpfs files.
-		 *
-		 * Note shmem_unuse already deleted a swappage from
-		 * the swap cache, unless the move to filepage failed:
-		 * in which case it left swappage in cache, lowered its
-		 * swap count to pass quickly through the loops above,
-		 * and now we must reincrement count to try again later.
-		 */
-		if ((*swap_map > 1) && PageDirty(page) && PageSwapCache(page)) {
-			struct writeback_control wbc = {
-				.sync_mode = WB_SYNC_NONE,
-			};
-
-			swap_writepage(page, &wbc);
-			lock_page(page);
-			wait_on_page_writeback(page);
-		}
-		if (PageSwapCache(page)) {
-			if (shmem)
-				swap_duplicate(entry);
-			else
-				delete_from_swap_cache(page);
-		}
-
-		/*
-		 * So we could skip searching mms once swap count went
-		 * to 1, we did not mark any present ptes as dirty: must
-		 * mark page dirty so shrink_list will preserve it.
-		 */
-		SetPageDirty(page);
-		unlock_page(page);
-		page_cache_release(page);
 
 		/*
 		 * Make sure that we aren't completely killing
@@ -899,10 +922,6 @@ static int try_to_unuse(unsigned int typ
 	}
 
 	mmput(start_mm);
-	if (reset_overflow) {
-		printk(KERN_WARNING "swapoff: cleared swap entry overflow\n");
-		swap_overflow = 0;
-	}
 	return retval;
 }
 


