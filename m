Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262888AbTDAWSv>; Tue, 1 Apr 2003 17:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262889AbTDAWSv>; Tue, 1 Apr 2003 17:18:51 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:12611 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262888AbTDAWSs>; Tue, 1 Apr 2003 17:18:48 -0500
Date: Tue, 1 Apr 2003 23:32:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 2/6 remove shmem_readpage
In-Reply-To: <Pine.LNX.4.44.0304012328390.1730-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0304012331180.1730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shmem_readpage was created to give tmpfs sendfile and loop ability; but
they're both using shmem_file_sendfile now, so remove shmem_readpage.

--- tmpfs1/mm/shmem.c	Tue Apr  1 21:34:48 2003
+++ tmpfs2/mm/shmem.c	Tue Apr  1 21:34:59 2003
@@ -750,9 +750,9 @@
 	 * Normally, filepage is NULL on entry, and either found
 	 * uptodate immediately, or allocated and zeroed, or read
 	 * in under swappage, which is then assigned to filepage.
-	 * But shmem_readpage and shmem_prepare_write pass in a locked
-	 * filepage, which may be found not uptodate by other callers
-	 * too, and may need to be copied from the swappage read in.
+	 * But shmem_prepare_write passes in a locked filepage,
+	 * which may be found not uptodate by other callers too,
+	 * and may need to be copied from the swappage read in.
 	 */
 repeat:
 	if (!filepage)
@@ -1102,20 +1102,10 @@
 static struct inode_operations shmem_symlink_inline_operations;
 
 /*
- * tmpfs itself makes no use of generic_file_read, generic_file_mmap
- * or generic_file_write; but shmem_readpage, shmem_prepare_write and
- * simple_commit_write let a tmpfs file be used below the loop driver.
+ * Normally tmpfs makes no use of shmem_prepare_write, but it
+ * lets a tmpfs file be used read-write below the loop driver.
  */
 static int
-shmem_readpage(struct file *file, struct page *page)
-{
-	struct inode *inode = page->mapping->host;
-	int error = shmem_getpage(inode, page->index, &page, SGP_CACHE);
-	unlock_page(page);
-	return error;
-}
-
-static int
 shmem_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
 {
 	struct inode *inode = page->mapping->host;
@@ -1751,7 +1741,6 @@
 	.writepage	= shmem_writepage,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 #ifdef CONFIG_TMPFS
-	.readpage	= shmem_readpage,
 	.prepare_write	= shmem_prepare_write,
 	.commit_write	= simple_commit_write,
 #endif

