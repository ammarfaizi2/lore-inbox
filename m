Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274123AbRISRzu>; Wed, 19 Sep 2001 13:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274125AbRISRzl>; Wed, 19 Sep 2001 13:55:41 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:10150 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S274123AbRISRz0>; Wed, 19 Sep 2001 13:55:26 -0400
Date: Wed, 19 Sep 2001 18:57:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: pre12 VM doubts and patch
Message-ID: <Pine.LNX.4.21.0109191850370.1133-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

I was unable to do much testing with -pre11 because of the spurious
allocation failures, but -pre12 fixes those for my particular testing:
thank you.  A few doubts: in the first case I've appended a patch; for
the rest you may prefer to make your own patch, or ask me for patch,
or reject my doubts.

1. Your changes don't quite fit with my -pre4 swapoff changes.  In
   free_pages_ok you want to treat PageDirty as a BUG, so you removed
   my SetPageDirty from try_to_unuse, and inserted a ClearPageDirty
   there.  Not good: that gives me hangs, or else data loss, after
   swapoff.  It is a cruel and unusual use of PageDirty (we could use a
   new flag for this purpose if it deserved it), but it fixes the race
   where try_to_swapout might clear a pte in between the page being
   removed from swap cache, and the pte being marked dirty (as it used
   to be) in unuse_pte; and allowed me to speed up swapoff, by not
   bothering to mark present ptes dirty at all.  See brief comment on
   PageDirty which remains in try_to_swap_out.  So patch below undoes
   your changes there (as before, clears PG_referenced too: I didn't
   look very hard, but wondered if that bit became undefined when a
   page was allocated in -pre11 and -pre12).  I also had more safety
   where vmscan.c goes from PageDirty to writepage, could a swapoff'ed
   page get there with NULL mapping?  I've not seen it, just a doubt.

2. swap_out_mm now takes mmlist_lock while holding a page_table_lock,
   whereas try_to_unuse takes page_table_lock while holding mmlist_lock.
   Yes, try_to_unuse holds mmlist_lock for a horrible length of time (I
   just changed it over from tasklist to mmlist), and now I believe the
   SWAP_MAP_MAX case to be imaginary, that could probably be changed.
   But it does look rather odd what swap_out_mm is doing, and I wonder
   if it wouldn't be better if you changed that?  You've clearly thought
   about the issues at that end, which I have not, so I'm not proposing
   a patch, but we do need to resolve the deadlock.  As I understand it,
   you don't like the way the old code darted away from a large and
   fruitful mm, now it scans the whole mm before going on to the next:
   sounds plausible, though I wonder, aren't other swapping out cpus
   liable to spin on its page_table_lock when they could be attacking
   other mms?  At a guess, your way works better when a few large mms
   (probably the common case?), worse if many.

3. If exclusive_swap_page, do_swap_page unconditionally makes the pte
   writable.  I think that's wrong, I think that's the same error Linus
   corrected in Rik's version there: if it's come in from swap, we know
   that the page has been dirtied in the past, but that does not imply
   that writing to it is now permitted.  I think you need something like
		if (write_access)
			pte = pte_mkwrite(pte);
		pte = pte_mkdirty(pte);
		delete_from_swap_cache_nolock(page);
   (and please remove that hesitant "#if 1" and "#if 0" from memory.c).

4. In 2.4.10-pre10, Linus removed the SetPageReferenced(page) from
   __find_page_nolock, and was adamant on lkml that it's inappropriate
   at that level.  Later in the day, Linus produced 2.4.10-pre11 from
   your patches, and that SetPageReferenced(page) reappeared: oversight
   or intentional?  Linus? more a question for you than Andrea.

5. With -pre12 I'm not getting the 0-order allocation failures which
   interfered with my -pre11 testing, but I did spend a while yesterday
   looking into that, and the patch I found successful was to move the
   "int nr_pages = SWAP_CLUSTER_MAX;" in try_to_free_pages from within
   the loop to the outer level: try_to_free_pages had freed 114 pages
   of the zone, but never as many as 32 in any one go round the loop.
   You'll have your own ideas of what's right and wrong here, and I'd
   rather stay clear of this area, but thought the observation worth
   passing on; and note that try_to_free_pages does look like work in
   progress - unused order argument, shrink_caches(,,, nr_pages)
   instead of explicit shrink_caches(,,, SWAP_CLUSTER_MAX).

Hugh

--- 2.4.10-pre12/mm/page_alloc.c	Wed Sep 19 14:08:14 2001
+++ linux/mm/page_alloc.c	Wed Sep 19 16:21:46 2001
@@ -86,8 +86,7 @@
 		BUG();
 	if (PageInactive(page))
 		BUG();
-	if (PageDirty(page))
-		BUG();
+	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
 
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;
--- 2.4.10-pre12/mm/swapfile.c	Wed Sep 19 14:08:14 2001
+++ linux/mm/swapfile.c	Wed Sep 19 16:08:08 2001
@@ -452,6 +452,7 @@
 		lock_page(page);
 		if (PageSwapCache(page))
 			delete_from_swap_cache_nolock(page);
+		SetPageDirty(page);
 		UnlockPage(page);
 		flush_page_to_ram(page);
 
@@ -492,7 +493,6 @@
 			mmput(start_mm);
 			start_mm = new_start_mm;
 		}
-		ClearPageDirty(page);
 		page_cache_release(page);
 
 		/*

