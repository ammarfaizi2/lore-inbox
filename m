Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWHBADI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWHBADI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 20:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWHBACm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 20:02:42 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:26070 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750758AbWHAXwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:52:50 -0400
Subject: [PATCH 09/28] kill open files traverse on remount ro
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:46 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235246.5B49CFF3@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that we have the sb writer count, we don't need to
go looking at all of the individual open files.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/file_table.c    |   25 -------------------------
 lxc-dave/fs/super.c         |    1 -
 lxc-dave/include/linux/fs.h |    2 --
 3 files changed, 28 deletions(-)

diff -puN fs/file_table.c~C-kill-open-file-traverse-on-remount-ro fs/file_table.c
--- lxc/fs/file_table.c~C-kill-open-file-traverse-on-remount-ro	2006-08-01 16:35:10.000000000 -0700
+++ lxc-dave/fs/file_table.c	2006-08-01 16:35:21.000000000 -0700
@@ -269,31 +269,6 @@ void file_kill(struct file *file)
 	}
 }
 
-int fs_may_remount_ro(struct super_block *sb)
-{
-	struct list_head *p;
-
-	/* Check that no files are currently opened for writing. */
-	file_list_lock();
-	list_for_each(p, &sb->s_files) {
-		struct file *file = list_entry(p, struct file, f_u.fu_list);
-		struct inode *inode = file->f_dentry->d_inode;
-
-		/* File with pending delete? */
-		if (inode->i_nlink == 0)
-			goto too_bad;
-
-		/* Writeable file? */
-		if (S_ISREG(inode->i_mode) && (file->f_mode & FMODE_WRITE))
-			goto too_bad;
-	}
-	file_list_unlock();
-	return 1; /* Tis' cool bro. */
-too_bad:
-	file_list_unlock();
-	return 0;
-}
-
 void __init files_init(unsigned long mempages)
 { 
 	int n; 
diff -puN fs/super.c~C-kill-open-file-traverse-on-remount-ro fs/super.c
--- lxc/fs/super.c~C-kill-open-file-traverse-on-remount-ro	2006-08-01 16:35:19.000000000 -0700
+++ lxc-dave/fs/super.c	2006-08-01 16:35:21.000000000 -0700
@@ -556,7 +556,6 @@ static void sb_mounts_clear_flag(struct 
 
 static int sb_remount_ro(struct super_block *sb)
 {
-	return fs_may_remount_ro(sb);
 	spin_lock(&sb->s_mnt_writers_lock);
 	if (atomic_read(&sb->s_mnt_writers) > 0) {
 		spin_unlock(&sb->s_mnt_writers_lock);
diff -puN include/linux/fs.h~C-kill-open-file-traverse-on-remount-ro include/linux/fs.h
--- lxc/include/linux/fs.h~C-kill-open-file-traverse-on-remount-ro	2006-08-01 16:35:20.000000000 -0700
+++ lxc-dave/include/linux/fs.h	2006-08-01 16:35:21.000000000 -0700
@@ -1601,8 +1601,6 @@ extern const struct file_operations read
 extern const struct file_operations write_fifo_fops;
 extern const struct file_operations rdwr_fifo_fops;
 
-extern int fs_may_remount_ro(struct super_block *);
-
 /*
  * return READ, READA, or WRITE
  */
_
