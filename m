Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291169AbSBLUS1>; Tue, 12 Feb 2002 15:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291168AbSBLUSQ>; Tue, 12 Feb 2002 15:18:16 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:38674 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S291164AbSBLUSK>; Tue, 12 Feb 2002 15:18:10 -0500
Date: Tue, 12 Feb 2002 20:19:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>,
        Benjamin LaHaise <bcrl@redhat.com>, Gerd Knorr <kraxel@bytesex.org>,
        Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] __free_pages_ok oops
In-Reply-To: <20020209093305.A13748@redhat.com>
Message-ID: <Pine.LNX.4.21.0202121929230.1468-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2002, Benjamin LaHaise wrote:
> On Fri, Feb 08, 2002 at 05:46:56PM +0000, Hugh Dickins wrote:
> > Ben, you probably have an AIO opinion here.  Is there a circumstance
> > in which AIO can unpin a user page at interrupt time, after the
> > calling task has (exited or) unmapped the page?
> 
> If the user unmaps the page, then aio is left holding the last reference 
> to the page and will unmap it from irq or bh context (potentially task 
> context too).  With networked aio, pages from userspace (anonymous or 
> page cache pages) will be released by the network stack from bh context.  
> Even now, I'm guess that should be possible with the zero copy flag...

Thanks for the feedback, Ben; and thanks for your feedback too, Gerd.
Yes, even in asking the question, the answer seemed unavoidable: with
AIO we shall have to permit an LRU page in __free_pages_ok at interrupt
time; as already happens, rightly or wrongly, with Gerd's bttv.

So my proposal to shove an "if (in_interrupt()) BUG();" there cannot
go forward: please back it out, Dave.  I've abandoned that patch, and
reworked my "fatally flawed" racy patch.  Andrea, Rik and Ben all seem
to prefer page_cache_release same as put_page same as __free_page, so
I've also abandoned reinstating distinct LRU-aware page_cache_release.

I don't like the idea of deciding what to do with a PageLRU page in
__free_pages_ok, based on whether in_interrupt() or not: feels wrong;
but would make a smaller patch, if you prefer for 2.4.18, Marcelo.

Instead, lru_cache_del when page_count 1 (and cannot be duplicated)
before page_cache_release, in three places where it's often needed -
free_page_and_swap_cache, free_swap_and_cache and (less obviously)
do_wp_page.  I know PageLRU pages can get leftover by try_to_unuse,
that's okay, good for testing; probably other places.

This way also has the advantage that __free_pages_ok *never* needs to
take pagemap_lru_lock: although an earlier audit suggested that was
not a real issue at present, it's going to be easier if we don't ever
have to worry about such a locking order issue.

New patch against 2.4.18-pre9 below: uses the PageLocked bit to avoid
the race in the earlier patch.  Please, would someone adept at memory
barriers check whether the page_count 0 PageLocked interaction between
__free_pages_ok and shrink_cache should have a barrier too?  Thanks!

Hugh

--- 2.4.18-pre9/mm/memory.c	Mon Jan  7 13:03:04 2002
+++ linux/mm/memory.c	Tue Feb 12 18:20:21 2002
@@ -961,6 +961,8 @@
 	}
 	spin_unlock(&mm->page_table_lock);
 	page_cache_release(new_page);
+	if (page_count(old_page) == 1)
+		lru_cache_del(old_page);
 	page_cache_release(old_page);
 	return 1;	/* Minor fault */
 
--- 2.4.18-pre9/mm/page_alloc.c	Mon Feb 11 18:08:45 2002
+++ linux/mm/page_alloc.c	Tue Feb 12 18:28:27 2002
@@ -70,12 +70,6 @@
 	struct page *base;
 	zone_t *zone;
 
-	/* Yes, think what happens when other parts of the kernel take 
-	 * a reference to a page in order to pin it for io. -ben
-	 */
-	if (PageLRU(page))
-		lru_cache_del(page);
-
 	if (page->buffers)
 		BUG();
 	if (page->mapping)
@@ -86,8 +80,19 @@
 		BUG();
 	if (PageLocked(page))
 		BUG();
-	if (PageLRU(page))
-		BUG();
+	/*
+	 * Exceptionally, a page may arrive here while still on LRU e.g.
+	 * asynchronous methods can take a reference to a page in order
+	 * to pin it for I/O, then free it after its vma was unmapped:
+	 * perhaps in IRQ or BH context when it would be unsafe to take
+	 * pagemap_lru_lock.  So leave such a page on the LRU, use page
+	 * lock to flag it, and let shrink_cache free it in due course.
+	 */
+	if (PageLRU(page)) {
+		if (TryLockPage(page))
+			BUG();
+		return;
+	}
 	if (PageActive(page))
 		BUG();
 	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
--- 2.4.18-pre9/mm/swap_state.c	Wed Oct 31 23:31:03 2001
+++ linux/mm/swap_state.c	Tue Feb 12 18:20:21 2002
@@ -148,6 +148,13 @@
 		remove_exclusive_swap_page(page);
 		UnlockPage(page);
 	}
+	/*
+	 * Take last reference to an anonymous page off its LRU list:
+	 * page_table_lock is held so count 1 cannot be duplicated at
+	 * this point; and a cached page would have count >= 2 here.
+	 */
+	if (page_count(page) == 1)
+		lru_cache_del(page);
 	page_cache_release(page);
 }
 
--- 2.4.18-pre9/mm/swapfile.c	Mon Feb 11 18:08:45 2002
+++ linux/mm/swapfile.c	Tue Feb 12 18:20:21 2002
@@ -346,6 +346,8 @@
 		/* Only cache user (+us), or swap space full? Free it! */
 		if (page_count(page) - !!page->buffers == 2 || vm_swap_full()) {
 			delete_from_swap_cache(page);
+			if (page_count(page) == 1)
+				lru_cache_del(page);
 			SetPageDirty(page);
 		}
 		UnlockPage(page);
--- 2.4.18-pre9/mm/vmscan.c	Mon Feb 11 18:08:45 2002
+++ linux/mm/vmscan.c	Tue Feb 12 18:43:13 2002
@@ -363,11 +363,26 @@
 		list_add(entry, &inactive_list);
 
 		/*
-		 * Zero page counts can happen because we unlink the pages
-		 * _after_ decrementing the usage count..
+		 * Exceptionally, a page may still be on an LRU when it
+		 * arrives at __free_pages_ok, maybe at interrupt time
+		 * when it could not safely be removed: so free it here.
+		 * The PageLocked bit is used to flag this case, to
+		 * avoid race where __free_pages on another CPU brings
+		 * page_count to 0, we see count 0 so __lru_cache_del
+		 * and __free_pages_ok, other CPU reaches PageLRU test
+		 * after we already cleared it, then page doubly freed.
 		 */
-		if (unlikely(!page_count(page)))
+		if (unlikely(!page_count(page))) {
+			if (PageLocked(page)) {
+				page_cache_get(page);
+				__lru_cache_del(page);
+				UnlockPage(page);
+				page_cache_release(page);
+				if (!--nr_pages)
+					break;
+			}
 			continue;
+		}
 
 		if (!memclass(page->zone, classzone))
 			continue;

