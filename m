Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbTCOUNn>; Sat, 15 Mar 2003 15:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbTCOUNn>; Sat, 15 Mar 2003 15:13:43 -0500
Received: from packet.digeo.com ([12.110.80.53]:49806 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261505AbTCOUNl>;
	Sat, 15 Mar 2003 15:13:41 -0500
Date: Sat, 15 Mar 2003 12:24:32 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] remove BKL from ext2's readdir
Message-Id: <20030315122432.1e3f8bd5.akpm@digeo.com>
In-Reply-To: <m3smto4cjd.fsf@lexa.home.net>
References: <m3vfyluedb.fsf@lexa.home.net>
	<20030315023614.3e28e67b.akpm@digeo.com>
	<20030315030322.792fa598.akpm@digeo.com>
	<m3wuj0fvls.fsf@lexa.home.net>
	<20030315121125.48294975.akpm@digeo.com>
	<m3smto4cjd.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 20:24:18.0648 (UTC) FILETIME=[DB172580:01C2EB30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> fs/ext2/dir.c:
> 
> struct file_operations ext2_dir_operations = {
>         .read           = generic_read_dir,
>         .readdir        = ext2_readdir,
>         .ioctl          = ext2_ioctl,
>         .fsync          = ext2_sync_file,
> };

ah, OK.  How about this?

diff -puN fs/ext2/dir.c~lseek-ext2_readdir fs/ext2/dir.c
--- 25/fs/ext2/dir.c~lseek-ext2_readdir	2003-03-15 03:20:22.000000000 -0800
+++ 25-akpm/fs/ext2/dir.c	2003-03-15 12:21:56.000000000 -0800
@@ -259,8 +259,6 @@ ext2_readdir (struct file * filp, void *
 	int need_revalidate = (filp->f_version != inode->i_version);
 	int ret = 0;
 
-	lock_kernel();
-
 	if (pos > inode->i_size - EXT2_DIR_REC_LEN(1))
 		goto done;
 
@@ -313,7 +311,6 @@ done:
 	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
 	filp->f_version = inode->i_version;
 	UPDATE_ATIME(inode);
-	unlock_kernel();
 	return 0;
 }
 
@@ -660,6 +657,7 @@ not_empty:
 }
 
 struct file_operations ext2_dir_operations = {
+	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.readdir	= ext2_readdir,
 	.ioctl		= ext2_ioctl,
diff -puN fs/ext3/dir.c~lseek-ext2_readdir fs/ext3/dir.c
--- 25/fs/ext3/dir.c~lseek-ext2_readdir	2003-03-15 03:20:22.000000000 -0800
+++ 25-akpm/fs/ext3/dir.c	2003-03-15 12:22:14.000000000 -0800
@@ -37,10 +37,11 @@ static int ext3_release_dir (struct inod
 				struct file * filp);
 
 struct file_operations ext3_dir_operations = {
+	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.readdir	= ext3_readdir,		/* we take BKL. needed?*/
 	.ioctl		= ext3_ioctl,		/* BKL held */
-	.fsync		= ext3_sync_file,		/* BKL held */
+	.fsync		= ext3_sync_file,	/* BKL held */
 #ifdef CONFIG_EXT3_INDEX
 	.release	= ext3_release_dir,
 #endif
@@ -98,8 +99,7 @@ static int ext3_readdir(struct file * fi
 	struct super_block * sb;
 	int err;
 	struct inode *inode = filp->f_dentry->d_inode;
-
-	lock_kernel();
+	int ret = 0;
 
 	sb = inode->i_sb;
 
@@ -110,8 +110,8 @@ static int ext3_readdir(struct file * fi
 	     ((inode->i_size >> sb->s_blocksize_bits) == 1))) {
 		err = ext3_dx_readdir(filp, dirent, filldir);
 		if (err != ERR_BAD_DX_DIR) {
-			unlock_kernel();
-			return err;
+			ret = err;
+			goto out;
 		}
 		/*
 		 * We don't set the inode dirty flag since it's not
@@ -191,8 +191,8 @@ revalidate:
 				filp->f_pos = (filp->f_pos |
 						(sb->s_blocksize - 1)) + 1;
 				brelse (bh);
-				unlock_kernel();
-				return stored;
+				ret = stored;
+				goto out;
 			}
 			offset += le16_to_cpu(de->rec_len);
 			if (le32_to_cpu(de->inode)) {
@@ -222,8 +222,8 @@ revalidate:
 		brelse (bh);
 	}
 	UPDATE_ATIME(inode);
-	unlock_kernel();
-	return 0;
+out:
+	return ret;
 }
 
 #ifdef CONFIG_EXT3_INDEX
diff -puN fs/ext2/file.c~lseek-ext2_readdir fs/ext2/file.c

_


