Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130882AbQL1VJ7>; Thu, 28 Dec 2000 16:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131627AbQL1VJt>; Thu, 28 Dec 2000 16:09:49 -0500
Received: from hermes.mixx.net ([212.84.196.2]:7691 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130882AbQL1VJj>;
	Thu, 28 Dec 2000 16:09:39 -0500
Message-ID: <3A4BA45E.4ADEB2DF@innominate.de>
Date: Thu, 28 Dec 2000 21:36:46 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <3A4B8895.CEDA8311@innominate.de> <Pine.LNX.4.10.10012281051480.12260-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> We don't want to lose dirty bits by mistake. The only cases where it's ok
> to clear the dirty bit is when we truncate a page completely (so it won't
> be needed and obviously really shouldn't be written out) and when we've
> lost the last user of a swap cache entry.
> 
> Any other cases might be bugs, where we remove a page from a mapping
> without noticing that it is dirty (we had this bug in reclaim_pages(), for
> example).

I tried to go the lazy way the first time.  This time I put the BUG in
there and then went chasing all the places that do
(__)remove_inode_page.  There are tentacles all over the place but I
*think* I found them all.  That turned up one more place needing
changing, and this is one you already spotted a couple of days ago, in
reclaim_page.  I subjected this patch to some dbenching without
triggering the BUG.

The try_to_unuse function calls delete_from_swap_cache and this is
pretty unfamiliar stuff for me, but it looks like the page is just
freshly read and couldn't be dirty.  There's one more case in
arch/68K/atari/stram.c (unswap_by_read), similar to try_to_unuse.

OK, I see you just posted -pre5 while I was making the patch, but here
it is anyway, as a cross-check.

--- 2.4.0-test13-pre4.clean/mm/filemap.c	Fri Dec 29 03:14:58 2000
+++ 2.4.0-test13-pre4/mm/filemap.c	Fri Dec 29 04:29:09 2000
@@ -96,6 +96,7 @@
 	remove_page_from_inode_queue(page);
 	remove_page_from_hash_queue(page);
 	page->mapping = NULL;
+	if (PageDirty(page)) BUG();
 }
 
 void remove_inode_page(struct page *page)
@@ -132,7 +133,7 @@
 		curr = curr->next;
 
 		/* We cannot invalidate a locked page */
-		if (TryLockPage(page))
+		if (PageDirty(page) || TryLockPage(page))
 			continue;
 
 		/* Neither can we invalidate something in use.. */
--- 2.4.0-test13-pre4.clean/mm/vmscan.c	Fri Dec 29 03:14:58 2000
+++ 2.4.0-test13-pre4/mm/vmscan.c	Fri Dec 29 04:30:48 2000
@@ -484,7 +484,7 @@
 		}
 
 		/* The page is dirty, or locked, move to inactive_dirty list. */
-		if (page->buffers || TryLockPage(page)) {
+		if (page->buffers || PageDirty(page) || TryLockPage(page)) {
 			del_page_from_inactive_clean_list(page);
 			add_page_to_inactive_dirty_list(page);
 			continue;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
