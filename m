Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbUKXPJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbUKXPJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbUKXPHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 10:07:49 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41099 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262749AbUKXPEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 10:04:52 -0500
Date: Wed, 24 Nov 2004 16:02:51 +0100
From: Colin Leroy <colin@colino.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Message-ID: <20041124160251.6dabbc92@pirandello>
In-Reply-To: <87pt23wdk1.fsf@devron.myhome.or.jp>
References: <20041118194959.3f1a3c8e.colin@colino.net>
	<87pt23wdk1.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed-Claws 0.9.12cvs166.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Nov 2004 at 23h11, OGAWA Hirofumi wrote:

Hi, 

> Aren't you forgetting to update the inode and various metadata (e.g. FAT)?

Don't really know what to do about this one; where should I look ?

this second patch seems a step in the right direction to me, based off your
previous comments:

Signed-off-by: Colin Leroy <colin@colino.net>
diff -ur /tmp/linux-2.6.9/fs/fat/dir.c fs/fat/dir.c
--- /tmp/linux-2.6.9/fs/fat/dir.c	2004-11-24 15:57:17.776119552 +0100
+++ fs/fat/dir.c	2004-11-24 15:58:41.664366600 +0100
@@ -760,10 +760,14 @@
 	de[1].start = cpu_to_le16(MSDOS_I(parent)->i_logstart);
 	de[1].starthi = cpu_to_le16(MSDOS_I(parent)->i_logstart>>16);
 	mark_buffer_dirty(bh);
-	brelse(bh);
 	dir->i_atime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(dir);
 
+	if (dir->i_sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bh);
+
+	brelse(bh);
+
 	return 0;
 }
 
diff -ur /tmp/linux-2.6.9/fs/fat/file.c fs/fat/file.c
--- /tmp/linux-2.6.9/fs/fat/file.c	2004-10-18 23:53:44.000000000 +0200
+++ fs/fat/file.c	2004-11-24 15:49:22.375391448 +0100
@@ -74,18 +74,30 @@
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	int retval;
+	struct super_block *sb = inode->i_sb;
 
 	retval = generic_file_write(filp, buf, count, ppos);
 	if (retval > 0) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 		mark_inode_dirty(inode);
+		if (sb->s_flags & MS_SYNCHRONOUS) {
+			struct buffer_head *bh;
+			loff_t i_pos = MSDOS_I(inode)->i_pos;
+			bh = sb_bread(sb, 
+				i_pos >> MSDOS_SB(sb)->dir_per_block_bits);
+			if (!bh)
+				return -EIO;
+			sync_dirty_buffer(bh);
+			brelse(bh);
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
@@ -105,4 +117,13 @@
 	unlock_kernel();
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
+	if (sb->s_flags & MS_SYNCHRONOUS) {
+		struct buffer_head *bh;
+		loff_t i_pos = MSDOS_I(inode)->i_pos;
+		bh = sb_bread(sb, i_pos >> MSDOS_SB(sb)->dir_per_block_bits);
+		if (!bh)
+			return;
+		sync_dirty_buffer(bh);
+		brelse(bh);
+	}
 }
diff -ur /tmp/linux-2.6.9/fs/fat/inode.c fs/fat/inode.c
--- /tmp/linux-2.6.9/fs/fat/inode.c	2004-11-24 15:57:17.783118488 +0100
+++ fs/fat/inode.c	2004-11-18 15:00:55.000000000 +0100
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
 
