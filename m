Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbUKYAfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbUKYAfR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUKXXZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:25:13 -0500
Received: from zeus.kernel.org ([204.152.189.113]:28608 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262888AbUKXXNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:13:22 -0500
Date: Wed, 24 Nov 2004 21:28:11 +0100
From: Colin Leroy <colin@colino.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Message-ID: <20041124212811.4d8b121e@jack.colino.net>
In-Reply-To: <87d5y3w21j.fsf@devron.myhome.or.jp>
References: <20041118194959.3f1a3c8e.colin@colino.net>
	<87pt23wdk1.fsf@devron.myhome.or.jp>
	<20041124160251.6dabbc92@pirandello>
	<87d5y3w21j.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed-Claws 0.9.12cvs172.1 (GTK+ 2.4.9; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Nov 2004 at 03h11, OGAWA Hirofumi wrote:

Hi, 

> int fat_sync_inode(struct inode *inode)
> {
> 	return fat_write_inode(inode, 1);
> }

Thanks for the hint. Here's a third patch.

Signed-off-by: Colin Leroy <colin@colino.net>
--- a/fs/fat/dir.c	2004-11-24 15:57:17.000000000 +0100
+++ fs/fat/dir.c	2004-11-24 21:21:51.783396408 +0100
@@ -760,10 +760,16 @@
 	de[1].start = cpu_to_le16(MSDOS_I(parent)->i_logstart);
 	de[1].starthi = cpu_to_le16(MSDOS_I(parent)->i_logstart>>16);
 	mark_buffer_dirty(bh);
-	brelse(bh);
 	dir->i_atime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(dir);
 
+	if (dir->i_sb->s_flags & MS_SYNCHRONOUS) {
+		sync_dirty_buffer(bh);
+		fat_sync_inode(dir);
+	}
+
+	brelse(bh);
+
 	return 0;
 }
 
--- a/fs/fat/fatfs_syms.c	2004-11-24 15:57:17.000000000 +0100
+++ fs/fat/fatfs_syms.c	2004-11-24 21:05:18.665605752 +0100
@@ -19,6 +19,7 @@
 EXPORT_SYMBOL(fat_detach);
 EXPORT_SYMBOL(fat_build_inode);
 EXPORT_SYMBOL(fat_fill_super);
+EXPORT_SYMBOL(fat_sync_inode);
 EXPORT_SYMBOL(fat_search_long);
 EXPORT_SYMBOL(fat_scan);
 EXPORT_SYMBOL(fat_add_entries);
--- a/fs/fat/file.c	2004-10-18 23:53:44.000000000 +0200
+++ fs/fat/file.c	2004-11-24 21:06:56.271767360 +0100
@@ -74,18 +74,22 @@
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	int retval;
+	struct super_block *sb = inode->i_sb;
 
 	retval = generic_file_write(filp, buf, count, ppos);
 	if (retval > 0) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 		mark_inode_dirty(inode);
+		if (sb->s_flags & MS_SYNCHRONOUS)
+			fat_sync_inode(inode);
 	}
 	return retval;
 }
 
 void fat_truncate(struct inode *inode)
 {
+	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	const unsigned int cluster_size = sbi->cluster_size;
 	int nr_clusters;
@@ -105,4 +109,6 @@
 	unlock_kernel();
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		fat_sync_inode(inode);
 }
--- a/fs/fat/inode.c	2004-11-24 15:57:17.000000000 +0100
+++ fs/fat/inode.c	2004-11-24 21:04:23.031063488 +0100
@@ -1224,6 +1224,11 @@
 	return 0;
 }
 
+int fat_sync_inode(struct inode *inode)
+{
+	return fat_write_inode(inode, 1);
+}
+
 static int fat_write_inode(struct inode *inode, int wait)
 {
 	struct super_block *sb = inode->i_sb;
@@ -1273,8 +1278,12 @@
 	}
 	spin_unlock(&sbi->inode_hash_lock);
 	mark_buffer_dirty(bh);
-	brelse(bh);
 	unlock_kernel();
+
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bh);
+	brelse(bh);
+
 	return 0;
 }
 
--- a/include/linux/msdos_fs.h	2004-11-24 15:57:20.000000000 +0100
+++ b/include/linux/msdos_fs.h	2004-11-24 21:06:17.858607048 +0100
@@ -266,6 +266,7 @@
 			struct msdos_dir_entry *de, loff_t i_pos, int
*res); int fat_fill_super(struct super_block *sb, void *data, int
silent, 		   struct inode_operations *fs_dir_inode_ops,
int isvfat);+int fat_sync_inode(struct inode *inode);
 extern int fat_notify_change(struct dentry * dentry, struct iattr *
attr); 
 /* fat/misc.c */


-- 
Colin
  "That's the difference between me and the rest of the world! 
   Happiness isn't good enough for me! I demand euphoria!"
		-- Calvin
