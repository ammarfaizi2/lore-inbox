Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbUKVKdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbUKVKdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUKVKbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:31:50 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:53508 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262026AbUKVKai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:30:38 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] problem of cont_prepare_write()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 22 Nov 2004 19:30:18 +0900
Message-ID: <877joexjk5.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If I do the following operation on fatfs, and my box under heavy load,

	open("testfile", O_CREAT | O_TRUNC | O_RDWR, 0664);
	lseek(fd, 500*1024*1024 - 1, SEEK_SET);
	write(fd, "\0", 1);

In cont_prepare_write(), kernel fills the hole by zero cleared page.

fs/buffer.c:cont_prepare_write:2210,
	while(page->index > (pgpos = *bytes>>PAGE_CACHE_SHIFT)) {

		[...]	

		status = __block_prepare_write(inode, new_page, zerofrom,
						PAGE_CACHE_SIZE, get_block);
		if (status)
			goto out_unmap;
		kaddr = kmap_atomic(new_page, KM_USER0);
		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
		flush_dcache_page(new_page);
		kunmap_atomic(kaddr, KM_USER0);
		__block_commit_write(inode, new_page,
				zerofrom, PAGE_CACHE_SIZE);
		unlock_page(new_page);
		page_cache_release(new_page);
	}

But until ->commit_write(), kernel doesn't update the ->i_size. Then,
if kernel writes out that hole page before updates of ->i_size, dirty
flag of buffer_head is cleared in __block_write_full_page(). So hole
page was not writed to disk.

fs/buffer.c:__block_write_full_page:1773,
		if (block > last_block) {
			/*
			 * mapped buffers outside i_size will occur, because
			 * this page can be outside i_size when there is a
			 * truncate in progress.
			 */
			/*
			 * The buffer was zeroed by block_write_full_page()
			 */
			clear_buffer_dirty(bh);
			set_buffer_uptodate(bh);

This became cause of data corruption.

I thought that it is not good to update ->i_size before ->commit_write().
So, I wrote the following patch.  Anyone has good idea for solving this
problem?



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/buffer.c        |    4 ++--
 include/linux/fs.h |    4 ++++
 mm/memory.c        |    2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff -puN mm/memory.c~cont_prepare_write-fix mm/memory.c
--- linux-2.6.10-rc2/mm/memory.c~cont_prepare_write-fix	2004-11-22 18:59:19.000000000 +0900
+++ linux-2.6.10-rc2-hirofumi/mm/memory.c	2004-11-22 18:59:19.000000000 +0900
@@ -1246,9 +1246,11 @@ int vmtruncate(struct inode * inode, lof
 	 */
 	if (IS_SWAPFILE(inode))
 		goto out_busy;
+	inode->i_flags |= S_TRUNCATING;
 	i_size_write(inode, offset);
 	unmap_mapping_range(mapping, offset + PAGE_SIZE - 1, 0, 1);
 	truncate_inode_pages(mapping, offset);
+	inode->i_flags &= ~S_TRUNCATING;
 	goto out_truncate;
 
 do_expand:
diff -puN fs/buffer.c~cont_prepare_write-fix fs/buffer.c
--- linux-2.6.10-rc2/fs/buffer.c~cont_prepare_write-fix	2004-11-22 18:59:19.000000000 +0900
+++ linux-2.6.10-rc2-hirofumi/fs/buffer.c	2004-11-22 18:59:19.000000000 +0900
@@ -1763,7 +1763,7 @@ static int __block_write_full_page(struc
 	 * handle any aliases from the underlying blockdev's mapping.
 	 */
 	do {
-		if (block > last_block) {
+		if (IS_TRUNCATING(inode) && block > last_block) {
 			/*
 			 * mapped buffers outside i_size will occur, because
 			 * this page can be outside i_size when there is a
@@ -2628,7 +2628,7 @@ int block_write_full_page(struct page *p
 
 	/* Is the page fully outside i_size? (truncate in progress) */
 	offset = i_size & (PAGE_CACHE_SIZE-1);
-	if (page->index >= end_index+1 || !offset) {
+	if (IS_TRUNCATING(inode) && (page->index >= end_index+1 || !offset)) {
 		/*
 		 * The page may have dirty, unmapped buffers.  For example,
 		 * they may have been added in ext3_writepage().  Make them
diff -puN include/linux/fs.h~cont_prepare_write-fix include/linux/fs.h
--- linux-2.6.10-rc2/include/linux/fs.h~cont_prepare_write-fix	2004-11-22 18:59:19.000000000 +0900
+++ linux-2.6.10-rc2-hirofumi/include/linux/fs.h	2004-11-22 18:59:19.000000000 +0900
@@ -151,6 +151,8 @@ extern int dir_notify_enable;
 #define S_NOCMTIME	128	/* Do not update file c/mtime */
 #define S_SWAPFILE	256	/* Do not truncate: swapon got its bmaps */
 
+#define S_TRUNCATING	(1<<31)	/* Hack: inode is truncating the data now */
+
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
  * flags just means all the inodes inherit those flags by default. It might be
@@ -185,6 +187,8 @@ extern int dir_notify_enable;
 #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
 #define IS_SWAPFILE(inode)	((inode)->i_flags & S_SWAPFILE)
 
+#define IS_TRUNCATING(inode)	((inode)->i_flags & S_TRUNCATING)
+
 /* the read-only stuff doesn't really belong here, but any other place is
    probably as bad and I don't want to create yet another include file. */
 
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
