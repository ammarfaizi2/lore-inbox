Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVCETgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVCETgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVCETfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:35:38 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:25861 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261203AbVCETL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:29 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 24/29] FAT: Remove unneed mark_inode_dirty()
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
	<87zmxiq6ef.fsf_-_@devron.myhome.or.jp>
	<87vf86q6d2.fsf_-_@devron.myhome.or.jp>
	<87r7iuq6af.fsf_-_@devron.myhome.or.jp>
	<87mztiq69f.fsf_-_@devron.myhome.or.jp>
	<87is46q68d.fsf_-_@devron.myhome.or.jp>
	<87ekeuq672.fsf_-_@devron.myhome.or.jp>
	<87acpiq665.fsf_-_@devron.myhome.or.jp>
	<876506q653.fsf_-_@devron.myhome.or.jp>
	<871xauq63z.fsf_-_@devron.myhome.or.jp>
	<87wtsmorii.fsf_-_@devron.myhome.or.jp>
	<87sm3aorho.fsf_-_@devron.myhome.or.jp>
	<87oedyorgu.fsf_-_@devron.myhome.or.jp>
	<87k6olq60a.fsf_-_@devron.myhome.or.jp>
	<87fyz9q5z7.fsf_-_@devron.myhome.or.jp>
	<87br9xq5y8.fsf_-_@devron.myhome.or.jp>
	<877jklq5x7.fsf_-_@devron.myhome.or.jp>
	<873bv9q5vx.fsf_-_@devron.myhome.or.jp>
	<87y8d1orah.fsf_-_@devron.myhome.or.jp>
	<87u0npor9o.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:57:22 +0900
In-Reply-To: <87u0npor9o.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:56:51 +0900")
Message-ID: <87psydor8t.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some mark_inode_dirty() is unneeded. Those are already detached (it's
not written) or change a ->i_nlink count only (fatfs don't have).

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/msdos/namei.c |   11 +++--------
 fs/vfat/namei.c  |   10 +++-------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff -puN fs/msdos/namei.c~sync08-fat_tweak4 fs/msdos/namei.c
--- linux-2.6.11/fs/msdos/namei.c~sync08-fat_tweak4	2005-03-06 02:37:21.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/msdos/namei.c	2005-03-06 02:37:21.000000000 +0900
@@ -354,7 +354,6 @@ static int msdos_rmdir(struct inode *dir
 	inode->i_nlink = 0;
 	inode->i_ctime = CURRENT_TIME_SEC;
 	fat_detach(inode);
-	mark_inode_dirty(inode);
 out:
 	unlock_kernel();
 
@@ -403,7 +402,7 @@ static int msdos_mkdir(struct inode *dir
 		/* the directory was completed, just return a error */
 		goto out;
 	}
-	inode->i_nlink = 2;	/* no need to mark them dirty */
+	inode->i_nlink = 2;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = ts;
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
@@ -437,7 +436,6 @@ static int msdos_unlink(struct inode *di
 	inode->i_nlink = 0;
 	inode->i_ctime = CURRENT_TIME_SEC;
 	fat_detach(inode);
-	mark_inode_dirty(inode);
 out:
 	unlock_kernel();
 
@@ -544,7 +542,6 @@ static int do_msdos_rename(struct inode 
 	if (new_inode) {
 		new_inode->i_nlink--;
 		new_inode->i_ctime = ts;
-		mark_inode_dirty(new_inode);
 	}
 	if (is_dir) {
 		int start = MSDOS_I(new_dir)->i_logstart;
@@ -552,12 +549,10 @@ static int do_msdos_rename(struct inode 
 		dotdot_de->starthi = cpu_to_le16(start >> 16);
 		mark_buffer_dirty(dotdot_bh);
 
-		if (new_inode) {
+		if (new_inode)
 			new_inode->i_nlink--;
-		} else {
+		else
 			new_dir->i_nlink++;
-			mark_inode_dirty(new_dir);
-		}
 	}
 out:
 	brelse(dotdot_bh);
diff -puN fs/vfat/namei.c~sync08-fat_tweak4 fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync08-fat_tweak4	2005-03-06 02:37:21.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:37:21.000000000 +0900
@@ -803,7 +803,6 @@ static int vfat_rmdir(struct inode *dir,
 	inode->i_nlink = 0;
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
-	mark_inode_dirty(inode);
 out:
 	unlock_kernel();
 
@@ -828,7 +827,6 @@ static int vfat_unlink(struct inode *dir
 	inode->i_nlink = 0;
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
-	mark_inode_dirty(inode);
 out:
 	unlock_kernel();
 
@@ -865,7 +863,7 @@ static int vfat_mkdir(struct inode *dir,
 		goto out;
 	}
 	inode->i_version++;
-	inode->i_nlink = 2;	/* no need to mark them dirty */
+	inode->i_nlink = 2;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = ts;
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
@@ -964,12 +962,10 @@ static int vfat_rename(struct inode *old
 		if (new_dir->i_sb->s_flags & MS_SYNCHRONOUS)
 			sync_dirty_buffer(dotdot_bh);
 
-		if (new_inode) {
+		if (new_inode)
 			new_inode->i_nlink--;
-		} else {
+		else
 			new_dir->i_nlink++;
-			mark_inode_dirty(new_dir);
-		}
 	}
 out:
 	brelse(dotdot_bh);
_
