Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSEEVBL>; Sun, 5 May 2002 17:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313592AbSEEU76>; Sun, 5 May 2002 16:59:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49161 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313559AbSEEU7A>;
	Sun, 5 May 2002 16:59:00 -0400
Message-ID: <3CD59D9E.FCA0D078@zip.com.au>
Date: Sun, 05 May 2002 14:01:18 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 10/10] Documentation update
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 2.5.13/mm/filemap.c~lock-doc-cleanup	Sat May  4 13:45:40 2002
+++ 2.5.13-akpm/mm/filemap.c	Sat May  4 13:45:40 2002
@@ -43,8 +43,7 @@
  *  pagemap_lru_lock
  *  ->i_shared_lock		(vmtruncate)
  *    ->i_bufferlist_lock	(__free_pte->__set_page_dirty_buffers)
- *      ->unused_list_lock	(try_to_free_buffers)
- *        ->mapping->page_lock
+ *      ->mapping->page_lock
  *      ->inode_lock		(__mark_inode_dirty)
  *        ->sb_lock		(fs/fs-writeback.c)
  */
--- 2.5.13/Documentation/filesystems/Locking~lock-doc-cleanup	Sat May  4 13:46:18 2002
+++ 2.5.13-akpm/Documentation/filesystems/Locking	Sat May  4 14:06:02 2002
@@ -137,6 +137,9 @@ prototypes:
 	int (*writepage)(struct page *);
 	int (*readpage)(struct file *, struct page *);
 	int (*sync_page)(struct page *);
+	int (*writeback_mapping)(struct address_space *, int *nr_to_write);
+	int (*vm_writeback)(struct page *, int *nr_to_write);
+	int (*set_page_dirty)(struct page *page);
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*bmap)(struct address_space *, long);
@@ -145,32 +148,71 @@ prototypes:
 	int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
 
 locking rules:
-	All may block
-		BKL	PageLocked(page)
-writepage:	no	yes, unlocks
-readpage:	no	yes, unlocks
-sync_page:	no	maybe
-prepare_write:	no	yes
-commit_write:	no	yes
-bmap:		yes
-flushpage:	no	yes
-releasepage:	no	yes
+	All except set_page_dirty may block
+
+			BKL	PageLocked(page)
+writepage:		no	yes, unlocks
+readpage:		no	yes, unlocks
+sync_page:		no	maybe
+writeback_mapping:	no
+vm_writeback:		no	yes
+set_page_dirty		no	no
+prepare_write:		no	yes
+commit_write:		no	yes
+bmap:			yes
+flushpage:		no	yes
+releasepage:		no	yes
 
 	->prepare_write(), ->commit_write(), ->sync_page() and ->readpage()
 may be called from the request handler (/dev/loop).
-	->readpage() and ->writepage() unlock the page.
+
+	->readpage() unlocks the page, either synchronously or via I/O
+completion.
+
+	->writepage() unlocks the page synchronously, before returning to
+the caller.  If the page has write I/O underway against it, writepage()
+should run SetPageWriteback() against the page prior to unlocking it.
+The write I/O completion handler should run ClearPageWriteback against
+the page.
+
+	That is: after 2.5.12, pages which are under writeout are *not*
+locked.
+
 	->sync_page() locking rules are not well-defined - usually it is called
 with lock on page, but that is not guaranteed. Considering the currently
 existing instances of this method ->sync_page() itself doesn't look
 well-defined...
+
+	->writeback_mapping() is used for periodic writeback and for
+systemcall-initiated sync operations. The address_space should start
+I/O against at least *nr_to_write pages.  *nr_to_write must be decremented
+for each page which is written.  *nr_to_write must not go negative (this
+will be relaxed later).  If nr_to_write is NULL, all dirty pages must
+be written.
+
+	->vm_writeback() is called from the VM.  The address_space should
+start I/O against at least *nr_to_write pages, including the passed page. As
+each page is written its PG_launder flag must be set (inside the page lock).
+
+	The vm_writeback() function is provided so that filesytems can perform
+clustered writeback around the page which the VM is trying to clean.
+If a_ops.vm_writeback is NULL the VM will fall back to single-page writepage().
+
+	->set_page_dirty() is called from various places in the kernel
+when the target page is marked as needing writeback.  It may be called
+under spinlock (it cannot block) and is sometimes called with the page
+not locked.
+
 	->bmap() is currently used by legacy ioctl() (FIBMAP) provided by some
 filesystems and by the swapper. The latter will eventually go away. All
 instances do not actually need the BKL. Please, keep it that way and don't
 breed new callers.
+
 	->flushpage() is called when the filesystem must attempt to drop
 some or all of the buffers from the page when it is being truncated.  It
 returns zero on success.  If ->flushpage is zero, the kernel uses
 block_flushpage() instead.
+
 	->releasepage() is called when the kernel is about to try to drop the
 buffers from the page in preparation for freeing it.  It returns zero to
 indicate that the buffers are (or may be) freeable.  If ->releasepage is zero,


-
