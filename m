Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSGDXuS>; Thu, 4 Jul 2002 19:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315287AbSGDXty>; Thu, 4 Jul 2002 19:49:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32781 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315119AbSGDXpl>;
	Thu, 4 Jul 2002 19:45:41 -0400
Message-ID: <3D24E01C.84EF4ABD@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: [patch 6/27] dbeug check for leaked blockdev buffers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Having just fiddled with the refcounts of blockdev buffers, I want some
way of assuring that the code is correct and is not leaking
buffer_heads.

There's no easy way to do this: if a blockdev page has pinned buffers
then truncate_complete_page just cuts it loose and we leak memory.

The patch adds a bit of debug code to catch these leaks.  This code,
PF_RADIX_TREE and buffer_error() need to be removed later on.



 fs/buffer.c           |    2 ++
 include/linux/sched.h |    2 +-
 mm/filemap.c          |    7 ++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

--- 2.5.24/mm/filemap.c~buffer-leak-check	Thu Jul  4 16:17:12 2002
+++ 2.5.24-akpm/mm/filemap.c	Thu Jul  4 16:22:11 2002
@@ -177,8 +177,13 @@ static inline void truncate_partial_page
 static void truncate_complete_page(struct page *page)
 {
 	/* Leave it on the LRU if it gets converted into anonymous buffers */
-	if (!PagePrivate(page) || do_invalidatepage(page, 0))
+	if (!PagePrivate(page) || do_invalidatepage(page, 0)) {
 		lru_cache_del(page);
+	} else {
+		if (current->flags & PF_INVALIDATE)
+			printk("%s: buffer heads were leaked\n",
+				current->comm);
+	}
 	ClearPageDirty(page);
 	ClearPageUptodate(page);
 	remove_inode_page(page);
--- 2.5.24/fs/buffer.c~buffer-leak-check	Thu Jul  4 16:17:12 2002
+++ 2.5.24-akpm/fs/buffer.c	Thu Jul  4 16:22:11 2002
@@ -467,7 +467,9 @@ void invalidate_bdev(struct block_device
 	 * We really want to use invalidate_inode_pages2() for
 	 * that, but not until that's cleaned up.
 	 */
+	current->flags |= PF_INVALIDATE;
 	invalidate_inode_pages(bdev->bd_inode);
+	current->flags &= ~PF_INVALIDATE;
 }
 
 void __invalidate_buffers(kdev_t dev, int destroy_dirty_buffers)
--- 2.5.24/include/linux/sched.h~buffer-leak-check	Thu Jul  4 16:17:12 2002
+++ 2.5.24-akpm/include/linux/sched.h	Thu Jul  4 16:22:11 2002
@@ -391,7 +391,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
 #define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
 #define PF_FROZEN	0x00040000	/* frozen for system suspend */
-
+#define PF_INVALIDATE	0x00080000	/* debug: unmounting an fs. killme. */
 /*
  * Ptrace flags
  */

-
