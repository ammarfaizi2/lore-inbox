Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSFAIms>; Sat, 1 Jun 2002 04:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316996AbSFAIlz>; Sat, 1 Jun 2002 04:41:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56074 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317003AbSFAIlL>;
	Sat, 1 Jun 2002 04:41:11 -0400
Message-ID: <3CF88972.D2E192C4@zip.com.au>
Date: Sat, 01 Jun 2002 01:44:34 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 16/16] dirsync support for minixfs, sysvfs and ufs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Makes minixfs, sysvfs and ufs understand `mount -o dirsync'.



=====================================

--- 2.5.19/fs/minix/dir.c~more-dirsync	Sat Jun  1 01:18:14 2002
+++ 2.5.19-akpm/fs/minix/dir.c	Sat Jun  1 01:18:14 2002
@@ -49,7 +49,7 @@ static int dir_commit_chunk(struct page 
 	struct inode *dir = (struct inode *)page->mapping->host;
 	int err = 0;
 	page->mapping->a_ops->commit_write(NULL, page, from, to);
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		err = write_one_page(page, 1);
 	else
 		unlock_page(page);
--- 2.5.19/fs/sysv/dir.c~more-dirsync	Sat Jun  1 01:18:14 2002
+++ 2.5.19-akpm/fs/sysv/dir.c	Sat Jun  1 01:18:14 2002
@@ -42,7 +42,7 @@ static int dir_commit_chunk(struct page 
 	int err = 0;
 
 	page->mapping->a_ops->commit_write(NULL, page, from, to);
-	if (IS_SYNC(dir))
+	if (IS_DIRSYNC(dir))
 		err = write_one_page(page, 1);
 	else
 		unlock_page(page);
--- 2.5.19/fs/ufs/dir.c~more-dirsync	Sat Jun  1 01:18:14 2002
+++ 2.5.19-akpm/fs/ufs/dir.c	Sat Jun  1 01:18:14 2002
@@ -356,7 +356,7 @@ void ufs_set_link(struct inode *dir, str
 	dir->i_version = ++event;
 	de->d_ino = cpu_to_fs32(dir->i_sb, inode->i_ino);
 	mark_buffer_dirty(bh);
-	if (IS_SYNC(dir)) {
+	if (IS_DIRSYNC(dir)) {
 		ll_rw_block (WRITE, 1, &bh);
 		wait_on_buffer(bh);
 	}
@@ -457,7 +457,7 @@ int ufs_add_link(struct dentry *dentry, 
 	de->d_ino = cpu_to_fs32(sb, inode->i_ino);
 	ufs_set_de_type(sb, de, inode->i_mode);
 	mark_buffer_dirty(bh);
-	if (IS_SYNC(dir)) {
+	if (IS_DIRSYNC(dir)) {
 		ll_rw_block (WRITE, 1, &bh);
 		wait_on_buffer (bh);
 	}
@@ -508,7 +508,7 @@ int ufs_delete_entry (struct inode * ino
 			inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 			mark_inode_dirty(inode);
 			mark_buffer_dirty(bh);
-			if (IS_SYNC(inode)) {
+			if (IS_DIRSYNC(inode)) {
 				ll_rw_block(WRITE, 1, &bh);
 				wait_on_buffer(bh);
 			}

-
