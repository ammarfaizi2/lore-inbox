Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUKRUVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUKRUVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbUKRUVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:21:04 -0500
Received: from colino.net ([213.41.131.56]:33017 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261163AbUKRUSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:18:43 -0500
Date: Thu, 18 Nov 2004 21:17:52 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: hirofumi@mail.parknet.co.jp
Subject: [PATCH]
Message-ID: <20041118211752.6a9aaa53.colin@colino.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs142.2 (GTK+ 2.4.9; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resend - previous mail seem to have lost itself
Hi,

this patch is an RFC patch not to be applied.
It adds MS_SYNCHRONOUS support to FAT filesystem, so that less
filesystem breakage happen when disconnecting an USB key, for 
example. I'd like to have comments about it, because as it 
seems to work fine here, I'm not used to fs drivers and could
have made mistakes.
Thanks,

Signed-off-by: Colin Leroy <colin@colino.net>
--- a/fs/fat/dir.c	2004-11-18 19:42:41.704777744 +0100
+++ b/fs/fat/dir.c	2004-11-18 14:36:44.000000000 +0100
@@ -736,6 +736,7 @@
 {
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
+	struct super_block *sb;
 	__le16 date, time;
 
 	bh = fat_extend_dir(dir);
@@ -764,6 +765,11 @@
 	dir->i_atime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(dir);
 
+	sb = dir->i_sb;
+
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bh);
+
 	return 0;
 }
 
--- a/fs/fat/file.c	2004-10-18 23:53:44.000000000 +0200
+++ b/fs/fat/file.c	2004-11-18 14:57:03.000000000 +0100
@@ -74,21 +74,34 @@
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	int retval;
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *bh = NULL;
 
 	retval = generic_file_write(filp, buf, count, ppos);
 	if (retval > 0) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 		mark_inode_dirty(inode);
+		if (sb->s_flags & MS_SYNCHRONOUS) {
+			bh = sb_bread(sb, MSDOS_SB(sb)->fsinfo_sector);
+			if (bh != NULL) {
+				sync_dirty_buffer(bh);
+				brelse(bh);
+			} else {
+				BUG_ON(1);
+			}
+		}
 	}
 	return retval;
 }
 
 void fat_truncate(struct inode *inode)
 {
+	struct super_block *sb = inode->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	const unsigned int cluster_size = sbi->cluster_size;
 	int nr_clusters;
+	struct buffer_head *bh = NULL;
 
 	/* 
 	 * This protects against truncating a file bigger than it was then
@@ -105,4 +118,8 @@
 	unlock_kernel();
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
+	if (sb->s_flags & MS_SYNCHRONOUS) {
+		bh = sb_bread(sb, sbi->fsinfo_sector);
+		sync_dirty_buffer(bh);
+	}
 }
--- a/fs/fat/inode.c	2004-11-18 19:42:41.710776832 +0100
+++ b/fs/fat/inode.c	2004-11-18 15:00:55.000000000 +0100
@@ -1273,8 +1273,12 @@
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
