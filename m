Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSF0UMk>; Thu, 27 Jun 2002 16:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316051AbSF0UMj>; Thu, 27 Jun 2002 16:12:39 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:29724 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316043AbSF0UMi>; Thu, 27 Jun 2002 16:12:38 -0400
Date: Thu, 27 Jun 2002 16:14:13 -0400
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: vm fixes for 2.4.19rc1
Message-ID: <20020627201413.GD1457@inspiron.ols.wavesec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

some fix for 2.4.19rc1 (btw, the lru_cache_del() in the LRU path is
needed in 2.5 too and it's also more efficient than the
page_cache_release, see ptrace freeing the anon pages with put_page(),
it will not pass through page_cache_release and it will trigger the
PageLRU check that __free_pages_ok isn't capable to handle in 2.5, I
will make a full vm update for 2.5 [in small pieces based on post-Andrew
split of the monolithic patch] in the next days anyways):

diff -urNp 2.4.19rc1/mm/page_alloc.c 2.4.19rc1aa1/mm/page_alloc.c
--- 2.4.19rc1/mm/page_alloc.c	Tue Jun 25 23:56:23 2002
+++ 2.4.19rc1aa1/mm/page_alloc.c	Wed Jun 26 00:55:35 2002
@@ -82,8 +82,11 @@ static void __free_pages_ok (struct page
 	/* Yes, think what happens when other parts of the kernel take 
 	 * a reference to a page in order to pin it for io. -ben
 	 */
-	if (PageLRU(page))
+	if (PageLRU(page)) {
+		if (unlikely(in_interrupt()))
+			BUG();
 		lru_cache_del(page);
+	}

this adds a debugging check just in case.

@@ -91,6 +94,8 @@ static void __free_pages_ok (struct page
 		BUG();
 	if (!VALID_PAGE(page))
 		BUG();
+	if (PageSwapCache(page))
+		BUG();

This resurrects a valid debugging check dropped in rc1.

@@ -280,10 +285,12 @@ static struct page * balance_classzone(z
 						BUG();
 					if (!VALID_PAGE(page))
 						BUG();
+					if (PageSwapCache(page))
+						BUG();

same as above. a page with page->mapping set cannot be freed, if it
happens it's a bug that we want to trap.

 					if (PageLocked(page))
 						BUG();
 					if (PageLRU(page))
-						BUG();
+						lru_cache_del(page);


This fixes a bug I found two days ago, it could explain the nvidia
oopses in __free_pages_ok. Not too bad, no risk of mm corruption or fs
corruption, just a bug could trigger in some unlikely case (never seen
it happening myself). (btw, the in_interrupt() check isn't needed above
because it's executed by the caller anyways)

diff -urNp 2.4.19rc1/mm/swap_state.c 2.4.19rc1aa1/mm/swap_state.c
--- 2.4.19rc1/mm/swap_state.c	Tue Jan 22 12:55:27 2002
+++ 2.4.19rc1aa1/mm/swap_state.c	Wed Jun 26 00:48:13 2002
@@ -95,11 +95,8 @@ int add_to_swap_cache(struct page *page,
  */
 void __delete_from_swap_cache(struct page *page)
 {
-	if (!PageLocked(page))
-		BUG();
 	if (!PageSwapCache(page))
 		BUG();
-	ClearPageDirty(page);
 	__remove_inode_page(page);
 	INC_CACHE_INFO(del_total);
 }

Here I play risky for a rc1, but it made perfect sense to me, when we
drop a page from the swapcache it doesn't make any sense to clear the
dirty bit, conceptually the only case where an anon page can be clean is
when it's part of swapcache, if it's not part of swapcache it cannot be
clean, the clearpagedirty was only to avoid oopsing in
__remove_inode_dirty but rc1 fixes that because the dirty bit can be
added without the page lock (i.e. mark_dirty_kiobuf) so the right thing
is to accept in __remove_inode_pages if somebody is dropping from the
swapcache a dirty page without oopsing. So the above patch will be now
safe on top of rc1, thanks to the fix in rc1 that avoids a false
positive bug to trigger in __remove_inode_page.

To bias the correctness of the above, we always mark the page dirty
after deleting from the swapcache, of course we have to or we risk to
lose it if the pte isn't dirty too (for example if there was a read
fault and the swapcache was clean and mapped as clean in the pte too).

@@ -114,9 +111,6 @@ void delete_from_swap_cache(struct page 
 {
 	swp_entry_t entry;
 
-	if (!PageLocked(page))
-		BUG();
-
 	block_flushpage(page, 0);
 
 	entry.val = page->index;

dropped also two pagelocked checks because there execute unconditionally
paths that checks the pagelocked bit at the lower layer.

here the full patch below (only slightly tested on my laptop so far, so
please make sure not to release this without an intermediate rc2 first :)

thanks,

diff -urNp 2.4.19rc1/mm/page_alloc.c 2.4.19rc1aa1/mm/page_alloc.c
--- 2.4.19rc1/mm/page_alloc.c	Tue Jun 25 23:56:23 2002
+++ 2.4.19rc1aa1/mm/page_alloc.c	Wed Jun 26 00:55:35 2002
@@ -82,8 +82,11 @@ static void __free_pages_ok (struct page
 	/* Yes, think what happens when other parts of the kernel take 
 	 * a reference to a page in order to pin it for io. -ben
 	 */
-	if (PageLRU(page))
+	if (PageLRU(page)) {
+		if (unlikely(in_interrupt()))
+			BUG();
 		lru_cache_del(page);
+	}
 
 	if (page->buffers)
 		BUG();
@@ -91,6 +94,8 @@ static void __free_pages_ok (struct page
 		BUG();
 	if (!VALID_PAGE(page))
 		BUG();
+	if (PageSwapCache(page))
+		BUG();
 	if (PageLocked(page))
 		BUG();
 	if (PageActive(page))
@@ -280,10 +285,12 @@ static struct page * balance_classzone(z
 						BUG();
 					if (!VALID_PAGE(page))
 						BUG();
+					if (PageSwapCache(page))
+						BUG();
 					if (PageLocked(page))
 						BUG();
 					if (PageLRU(page))
-						BUG();
+						lru_cache_del(page);
 					if (PageActive(page))
 						BUG();
 					if (PageDirty(page))
diff -urNp 2.4.19rc1/mm/swap_state.c 2.4.19rc1aa1/mm/swap_state.c
--- 2.4.19rc1/mm/swap_state.c	Tue Jan 22 12:55:27 2002
+++ 2.4.19rc1aa1/mm/swap_state.c	Wed Jun 26 00:48:13 2002
@@ -95,11 +95,8 @@ int add_to_swap_cache(struct page *page,
  */
 void __delete_from_swap_cache(struct page *page)
 {
-	if (!PageLocked(page))
-		BUG();
 	if (!PageSwapCache(page))
 		BUG();
-	ClearPageDirty(page);
 	__remove_inode_page(page);
 	INC_CACHE_INFO(del_total);
 }
@@ -114,9 +111,6 @@ void delete_from_swap_cache(struct page 
 {
 	swp_entry_t entry;
 
-	if (!PageLocked(page))
-		BUG();
-
 	block_flushpage(page, 0);
 
 	entry.val = page->index;

Andrea
