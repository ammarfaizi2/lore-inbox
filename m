Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSJ1EFg>; Sun, 27 Oct 2002 23:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262827AbSJ1EFg>; Sun, 27 Oct 2002 23:05:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:39912 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262826AbSJ1EFf>;
	Sun, 27 Oct 2002 23:05:35 -0500
Message-ID: <3DBCB904.FA9CC188@digeo.com>
Date: Sun, 27 Oct 2002 20:11:48 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Jens Axboe <axboe@suse.de>
Subject: [patch] Fix file-corrupting bug, kernels 2.5.41 to 2.5.44
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2002 04:11:48.0745 (UTC) FILETIME=[22D50790:01C27E38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch fixes a filesystem corrupting bug, present in 2.5.41 through
2.5.44.  It can cause ext2 indirect blocks to not be written out.  A
fsck will fix it up.

Under heavy memory pressure a PF_MEMALLOC task attemtps to write out a
blockdev page whose buffers are already under writeback and which were
dirtied while under writeback.

The writepage call returns -EAGAIN but because the caller is
PF_MEMALLOC, the page was not being marked dirty again.

The page sits on mapping->clean_pages for ever and it not written out.

The fix is to mark that page dirty again for all callers, regardless of
PF_MEMALLOC state.



 fs/mpage.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- 25/fs/mpage.c~set_page_dirty-pf_memalloc	Sun Oct 27 19:22:44 2002
+++ 25-akpm/fs/mpage.c	Sun Oct 27 19:24:18 2002
@@ -591,6 +591,10 @@ mpage_writepages(struct address_space *m
 					test_clear_page_dirty(page)) {
 			if (writepage) {
 				ret = (*writepage)(page);
+				if (ret == -EAGAIN) {
+					__set_page_dirty_nobuffers(page);
+					ret = 0;
+				}
 			} else {
 				bio = mpage_writepage(bio, page, get_block,
 						&last_block_in_bio, &ret);
@@ -601,10 +605,6 @@ mpage_writepages(struct address_space *m
 					pagevec_deactivate_inactive(&pvec);
 				page = NULL;
 			}
-			if (ret == -EAGAIN && page) {
-				__set_page_dirty_nobuffers(page);
-				ret = 0;
-			}
 			if (ret || (--(wbc->nr_to_write) <= 0))
 				done = 1;
 			if (wbc->nonblocking && bdi_write_congested(bdi)) {

.
