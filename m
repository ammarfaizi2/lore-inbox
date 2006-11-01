Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946102AbWKAF1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946102AbWKAF1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946100AbWKAF1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:27:00 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:30873 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946102AbWKAF07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:26:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=a3bPSA0xK5WdK4FwfFNQMsvtq/X1YeEOM25s4OVXy57psT+LGWOycZc0QjRSGZ7XStyangaeTfiBCrNTI0zpaxX2ISjxd8yTzt6cAKXflRMFJ3FngDbYTbC9AdM/rUW/PJEq8fyvmNOVmdATt1J4FmXWAP8UqBjlWWo0/XgKSr0=  ;
X-YMail-OSG: p0S94dMVM1l_r3mF4ILlht1Uos2.82YSAaVg4yytzsjcbZWEbj2zc7cQqe_RZ32ZWGVyKltlQOgtKGORN7ooLN7VTgP_R6LZe50r83X6KFO39mvJHWYTuw--
Message-ID: <45483020.9010607@yahoo.com.au>
Date: Wed, 01 Nov 2006 16:26:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Purdie <richard@openedhand.com>
CC: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
References: <1161935995.5019.46.camel@localhost.localdomain>	 <4541C1B2.7070003@yahoo.com.au>	 <1161938694.5019.83.camel@localhost.localdomain>	 <4542E2A4.2080400@yahoo.com.au>	 <1162032227.5555.65.camel@localhost.localdomain>	 <454348B4.60007@yahoo.com.au> <1162209347.6962.2.camel@localhost.localdomain>
In-Reply-To: <1162209347.6962.2.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------000202010602040906060607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000202010602040906060607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Richard Purdie wrote:
> On Sat, 2006-10-28 at 22:10 +1000, Nick Piggin wrote: 
> 
>>Richard Purdie wrote:
>>
>>>I'm open to suggestions as to how to do it. The main problem was that in
>>>in order to mark the page bad you needed to hold an extra reference on
>>>the page so that the "mark bad" code would be the last code to touch the
>>>page. The swapoff code doesn't need this and I don't like the idea of
>>>passing some count value to a common function as that would be
>>>confusing. I guess swapoff could start taking an extra reference but I
>>>can see people objecting to that too as it doesn't need it. 
>>
>>If you have the page locked (which you can't from where you're trying,
>>but we'll tackle that next), and the page is swapcache, then doesn't
>>that pin you a reference to the swap entry as well? So I still don't
>>see why you need that extra reference.... I know there is a
>>try_to_unuse_page/entry hiding in try_to_unuse somewhere ;)
> 
> 
> The final call to swap_free() releases the swap mapping and beyond that
> point you can't tell which swap page you were dealing with.

Right, and the final call to swap_free comes from delete_from_swap_cache
(or in your case, manually, after __delete_from_swap_cache).

You can mark it bad right there, and you don't have to worry about it
any more.

>>That isn't your only problem though, and we simply don't want to do
>>this (potentially expensive) unusing from interrupt context. Noting
>>the error and dealing with it in process context I think is the best
>>way to do it.
> 
> 
> The reasoning was that this circumstance should be extremely rare. If it
> happens, we have a hardware problem. Recovering from that hardware
> problem gracefully is more important than a slightly longer interrupt.
> But yes, process context would be nicer, *if* we can find a way to do
> it. 

s/nicer/required

The fact remains that you simply cannot do this. You are taking locks
which are not interrupt safe, and you are taking sleeping locks too.

>>BTW. what's the driver you're using? It might be useful to have an
>>option to schedule a timer for the completions (at least the ones
>>which generate errors).
> 
> 
> Its a custom driver. I'm sure I can force it into using interrupt
> context for the completions to try and test things although I'm also
> fairly sure the existing patch will break when I do that for the reasons
> you mention :-(. 

That's the general idea ;)

>>I can't for the life of me see how or why this is happening. I don't
>>doubt it is a problem, but it smells like another bug.
> 
> 
> I can't work out the code path it happens in and until I do, I'm not
> sure how I can track it down... 

Is your driver scribbling on the page memory when it encounters a write
error, or is the SIGBUS coming from a subsequent pagefault attempt on
that address? Stick a WARN_ON(1) in the VM_FAULT_SIGBUS case in
arch/arm/mm/fault.c to check.

>>Still, something must be triggering it somewhere.
> 
> 
> Something must be but I wish I knew what/where...

Let's try to find out :)

>>swap_writepage sounds better than . You've even got the page
>>already locked for you, so the job's half done ;)
>>
>>What performance implications did you imagine? The fastpath will
>>just be a single PageError test, and error case slowpath doesn't
>>matter too much beyond having something that actually works.
> 
> 
> If swap_writepage() is to check for an error, it will have to wait until
> the IO is complete with something like wait_on_page_writeback() before
> it can check. The performance implication is the extra
> wait_on_page_writeback() on every call to swap_writepage(). In the
> meantime, it will have to give up the page lock and then reacquire it.
> Unless you're thinking of something different?

Yes, I mean the other side of the writepage, ie. when page reclaim is
about to attempt to swap it out.

The attached (very untested, in need of splitting up) patch attempts to
solve these problems. Note that it is probably not going to prevent your
SIGBUS, so that will have to be found and fixed individually.

In the meantime, I'll run this through some testing when I get half a
chance.

-- 
SUSE Labs, Novell Inc.

--------------000202010602040906060607
Content-Type: text/plain;
 name="mm-swap-fail.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-swap-fail.patch"

Notice swap write errors during page reclaim, and deallocate the swap entry
which is backing the swapcache. This allows the page error to be cleared and
the page be allocated to a new entry, rather than the page to becoming pinned
forever.

Based on code from Richard Purdie <richard@openedhand.com>

Index: linux-2.6/mm/shmem.c
===================================================================
--- linux-2.6.orig/mm/shmem.c	2006-11-01 14:58:28.000000000 +1100
+++ linux-2.6/mm/shmem.c	2006-11-01 16:10:21.000000000 +1100
@@ -729,6 +729,8 @@ static int shmem_unuse_inode(struct shme
 	struct page *subdir;
 	swp_entry_t *ptr;
 	int offset;
+	int moved;
+	int error;
 
 	idx = 0;
 	ptr = info->i_direct;
@@ -786,17 +788,20 @@ lost2:
 found:
 	idx += offset;
 	inode = &info->vfs_inode;
-	if (move_from_swap_cache(page, idx, inode->i_mapping) == 0) {
+	error = PageError(page);
+	moved = (move_from_swap_cache(page, idx, inode->i_mapping) == 0);
+	if (moved) {
 		info->flags |= SHMEM_PAGEIN;
 		shmem_swp_set(info, ptr + offset, 0);
 	}
 	shmem_swp_unmap(ptr);
 	spin_unlock(&info->lock);
-	/*
-	 * Decrement swap count even when the entry is left behind:
-	 * try_to_unuse will skip over mms, then reincrement count.
-	 */
-	swap_free(entry);
+	if (moved) {
+		if (!error)
+			swap_free(entry);
+		else
+			swap_free_markbad(entry);
+	}
 	return 1;
 }
 
Index: linux-2.6/mm/swapfile.c
===================================================================
--- linux-2.6.orig/mm/swapfile.c	2006-11-01 14:58:28.000000000 +1100
+++ linux-2.6/mm/swapfile.c	2006-11-01 16:14:26.000000000 +1100
@@ -304,6 +304,23 @@ void swap_free(swp_entry_t entry)
 	}
 }
 
+void swap_free_markbad(swp_entry_t entry)
+{
+	struct swap_info_struct * p;
+
+	p = swap_info_get(entry);
+	if (p) {
+		unsigned long offset = swp_offset(entry);
+		if (swap_entry_free(p, offset) == 0) {
+			p->swap_map[offset] = SWAP_MAP_BAD;
+			p->pages--;
+			nr_swap_pages--;
+			total_swap_pages--;
+		}
+		spin_unlock(&swap_lock);
+	}
+}
+
 /*
  * How many references to page are currently swapped out?
  */
@@ -618,6 +635,207 @@ static int unuse_mm(struct mm_struct *mm
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
+retry:
+	wait_on_page_locked(page);
+	wait_on_page_writeback(page);
+	lock_page(page);
+	wait_on_page_writeback(page);
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
+	if (retval) {
+		unlock_page(page);
+		page_cache_release(page);
+		goto out;
+	}
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
+			goto retry;
+		}
+		if (!shmem) {
+			int error = PageError(page);
+
+			write_lock_irq(&swapper_space.tree_lock);
+			__delete_from_swap_cache(page);
+			write_unlock_irq(&swapper_space.tree_lock);
+			page_cache_release(page); /* the swapcache ref */
+
+			if (!error)
+				swap_free(entry);
+			else
+				swap_free_markbad(entry);
+		}
+	}
+
+	/*
+	 * So we could skip searching mms once swap count went to 1, we did not
+	 * mark any present ptes as dirty: must mark page dirty so shrink_list
+	 * will preserve it.
+	 */
+	SetPageDirty(page);
+	unlock_page(page);
+	page_cache_release(page);
+
+	if (start_mm_p)
+		*start_mm_p = start_mm;
+	else
+		mmput(start_mm);
+
+out:
+	return retval;
+}
+
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
+	try_to_unuse_entry(entry, swap_map, page, NULL);
+}
+
 /*
  * Scan swap_map from current position to next entry still in use.
  * Recycle to start on reaching the end, returning 0 when empty.
@@ -666,13 +884,10 @@ static int try_to_unuse(unsigned int typ
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
@@ -724,152 +939,10 @@ static int try_to_unuse(unsigned int typ
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
-
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
+		retval = try_to_unuse_entry(entry, swap_map, page,
+							&start_mm);
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
@@ -879,10 +952,6 @@ static int try_to_unuse(unsigned int typ
 	}
 
 	mmput(start_mm);
-	if (reset_overflow) {
-		printk(KERN_WARNING "swapoff: cleared swap entry overflow\n");
-		swap_overflow = 0;
-	}
 	return retval;
 }
 
Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c	2006-11-01 15:11:54.000000000 +1100
+++ linux-2.6/mm/swap_state.c	2006-11-01 15:51:20.000000000 +1100
@@ -131,6 +131,8 @@ void __delete_from_swap_cache(struct pag
 	radix_tree_delete(&swapper_space.page_tree, page_private(page));
 	set_page_private(page, 0);
 	ClearPageSwapCache(page);
+	if (unlikely(PageError(page)))
+		ClearPageError(page);
 	total_swapcache_pages--;
 	__dec_zone_page_state(page, NR_FILE_PAGES);
 	INC_CACHE_INFO(del_total);
Index: linux-2.6/include/linux/swap.h
===================================================================
--- linux-2.6.orig/include/linux/swap.h	2006-11-01 15:54:10.000000000 +1100
+++ linux-2.6/include/linux/swap.h	2006-11-01 16:10:44.000000000 +1100
@@ -246,6 +246,7 @@ extern swp_entry_t get_swap_page_of_type
 extern int swap_duplicate(swp_entry_t);
 extern int valid_swaphandles(swp_entry_t, unsigned long *);
 extern void swap_free(swp_entry_t);
+extern void swap_free_markbad(swp_entry_t);
 extern void free_swap_and_cache(swp_entry_t);
 extern int swap_type_of(dev_t);
 extern unsigned int count_swap_pages(int, int);
@@ -253,6 +254,7 @@ extern sector_t map_swap_page(struct swa
 extern struct swap_info_struct *get_swap_info_struct(unsigned);
 extern int can_share_swap_page(struct page *);
 extern int remove_exclusive_swap_page(struct page *);
+extern void try_to_unuse_page_entry(struct page *page);
 struct backing_dev_info;
 
 extern spinlock_t swap_lock;
Index: linux-2.6/mm/page_io.c
===================================================================
--- linux-2.6.orig/mm/page_io.c	2006-11-01 15:52:40.000000000 +1100
+++ linux-2.6/mm/page_io.c	2006-11-01 15:52:46.000000000 +1100
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
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c	2006-11-01 15:53:29.000000000 +1100
+++ linux-2.6/mm/vmscan.c	2006-11-01 16:07:41.000000000 +1100
@@ -486,9 +486,21 @@ static unsigned long shrink_page_list(st
 		 * Anonymous process memory has backing store?
 		 * Try to allocate it some swap space here.
 		 */
-		if (PageAnon(page) && !PageSwapCache(page))
-			if (!add_to_swap(page, GFP_ATOMIC))
-				goto activate_locked;
+		if (PageAnon(page)) {
+			/*
+			 * Encountered an error last time? Try to remove the
+			 * page from its current position, which will notice
+			 * the error and mark that swap entry bad. Then we can
+			 * try allocating another swap entry.
+			 */
+			if (PageSwapCache(page) && unlikely(PageError(page)))
+				try_to_unuse_page_entry(page);
+
+			if (!PageSwapCache(page)) {
+				if (!add_to_swap(page, GFP_ATOMIC))
+					goto activate_locked;
+			}
+		}
 #endif /* CONFIG_SWAP */
 
 		mapping = page_mapping(page);

--------------000202010602040906060607--
Send instant messages to your online friends http://au.messenger.yahoo.com 
