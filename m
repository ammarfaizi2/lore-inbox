Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSGDXqo>; Thu, 4 Jul 2002 19:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSGDXql>; Thu, 4 Jul 2002 19:46:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36109 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315168AbSGDXp4>;
	Thu, 4 Jul 2002 19:45:56 -0400
Message-ID: <3D24E02B.A3AD8C95@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Hugh Dickins <hugh@veritas.com>
Subject: [patch 10/27] shmem fixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A shmem cleanup/bugfix patch from Hugh Dickins.

- Minor: in try_to_unuse(), only wait on writeout if we actually
  started new writeout.  Otherwise, there is no need because a
  wait_on_page_writeback() has already been executed against this page.
  And it's locked, so no new writeback can start.

- Minor: in shmem_unuse_inode(): remove all the
  wait_on_page_writeback() logic.  We already did that in
  try_to_unuse(), adn the page is locked so no new writeback can start.

- Less minor: add a missing a page_cache_release() to
  shmem_get_page_locked() in the uncommon case where the page was found
  to be under writeout.



 shmem.c    |   12 +++---------
 swapfile.c |    5 ++---
 2 files changed, 5 insertions(+), 12 deletions(-)

--- 2.5.24/mm/shmem.c~shmem-fixes	Thu Jul  4 16:17:16 2002
+++ 2.5.24-akpm/mm/shmem.c	Thu Jul  4 16:17:16 2002
@@ -426,22 +426,15 @@ found:
 	swap_free(entry);
 	ptr[offset] = (swp_entry_t) {0};
 
-	while (inode && (PageWriteback(page) ||
-			move_from_swap_cache(page, idx, inode->i_mapping))) {
+	while (inode && move_from_swap_cache(page, idx, inode->i_mapping)) {
 		/*
 		 * Yield for kswapd, and try again - but we're still
 		 * holding the page lock - ugh! fix this up later on.
 		 * Beware of inode being unlinked or truncated: just
 		 * leave try_to_unuse to delete_from_swap_cache if so.
-		 *
-		 * AKPM: We now wait on writeback too.  Note that it's
-		 * the page lock which prevents new writeback from starting.
 		 */
 		spin_unlock(&info->lock);
-		if (PageWriteback(page))
-			wait_on_page_writeback(page);
-		else
-			yield();
+		yield();
 		spin_lock(&info->lock);
 		ptr = shmem_swp_entry(info, idx, 0);
 		if (IS_ERR(ptr))
@@ -607,6 +600,7 @@ repeat:
 			spin_unlock(&info->lock);
 			wait_on_page_writeback(page);
 			unlock_page(page);
+			page_cache_release(page);
 			goto repeat;
 		}
 		error = move_from_swap_cache(page, idx, mapping);
--- 2.5.24/mm/swapfile.c~shmem-fixes	Thu Jul  4 16:17:16 2002
+++ 2.5.24-akpm/mm/swapfile.c	Thu Jul  4 16:17:16 2002
@@ -687,11 +687,10 @@ static int try_to_unuse(unsigned int typ
 		if ((*swap_map > 1) && PageDirty(page) && PageSwapCache(page)) {
 			swap_writepage(page);
 			lock_page(page);
-		}
-		if (PageSwapCache(page)) {
 			wait_on_page_writeback(page);
-			delete_from_swap_cache(page);
 		}
+		if (PageSwapCache(page))
+			delete_from_swap_cache(page);
 
 		/*
 		 * So we could skip searching mms once swap count went

-
