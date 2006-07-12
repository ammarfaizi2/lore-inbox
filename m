Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWGLSWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWGLSWW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWGLSVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:21:43 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:17564 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932349AbWGLSRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:23 -0400
Subject: [RFC][PATCH 07/27] kill open files traverse on remount ro
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:15 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181715.08110A55@localhost.localdomain>
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
--- lxc/fs/file_table.c~C-kill-open-file-traverse-on-remount-ro	2006-07-12 11:09:15.000000000 -0700
+++ lxc-dave/fs/file_table.c	2006-07-12 11:09:24.000000000 -0700
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
--- lxc/fs/super.c~C-kill-open-file-traverse-on-remount-ro	2006-07-12 11:09:22.000000000 -0700
+++ lxc-dave/fs/super.c	2006-07-12 11:09:24.000000000 -0700
@@ -555,7 +555,6 @@ static void sb_mounts_clear_flag(struct 
 
 static int sb_remount_ro(struct super_block *sb)
 {
-	return fs_may_remount_ro(sb);
 	spin_lock(&sb->s_mnt_writers_lock);
 	if (atomic_read(&sb->s_mnt_writers) > 0) {
 		spin_unlock(&sb->s_mnt_writers_lock);
diff -puN include/linux/fs.h~C-kill-open-file-traverse-on-remount-ro include/linux/fs.h
--- lxc/include/linux/fs.h~C-kill-open-file-traverse-on-remount-ro	2006-07-12 11:09:23.000000000 -0700
+++ lxc-dave/include/linux/fs.h	2006-07-12 11:09:24.000000000 -0700
@@ -1584,8 +1584,6 @@ extern const struct file_operations read
 extern const struct file_operations write_fifo_fops;
 extern const struct file_operations rdwr_fifo_fops;
 
-extern int fs_may_remount_ro(struct super_block *);
-
 /*
  * return READ, READA, or WRITE
  */
_
