Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVCEUul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVCEUul (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVCETia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:38:30 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:25349 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261201AbVCETL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:26 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 25/29] FAT: Fix fat_truncate()
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
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
	<87psydor8t.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:57:53 +0900
In-Reply-To: <87psydor8t.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:57:22 +0900")
Message-ID: <87ll91or7y.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Instead of
	mark_inode_dirty(inode);
	if (IS_SYNC(inode))
		fat_sync_inode(inode);

use this
	if (IS_SYNC(inode))
		fat_sync_inode(inode);
	else
		mark_inode_dirty(inode);

And if occurs a error, restore the ->i_start and ->i_logstart.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/file.c |   40 +++++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 17 deletions(-)

diff -puN fs/fat/file.c~sync08-fat_tweak5 fs/fat/file.c
--- linux-2.6.11/fs/fat/file.c~sync08-fat_tweak5	2005-03-06 02:37:23.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/file.c	2005-03-06 02:37:24.000000000 +0900
@@ -212,7 +212,7 @@ EXPORT_SYMBOL(fat_notify_change);
 static int fat_free(struct inode *inode, int skip)
 {
 	struct super_block *sb = inode->i_sb;
-	int ret, wait;
+	int err, wait, free_start, i_start, i_logstart;
 
 	if (MSDOS_I(inode)->i_start == 0)
 		return 0;
@@ -223,7 +223,7 @@ static int fat_free(struct inode *inode,
 	wait = IS_DIRSYNC(inode);
 	if (skip) {
 		struct fat_entry fatent;
-		int fclus, dclus;
+		int ret, fclus, dclus;
 
 		ret = fat_get_cluster(inode, skip - 1, &fclus, &dclus);
 		if (ret < 0)
@@ -242,8 +242,7 @@ static int fat_free(struct inode *inode,
 				     __FUNCTION__, MSDOS_I(inode)->i_pos);
 			ret = -EIO;
 		} else if (ret > 0) {
-			int err = fat_ent_write(inode, &fatent, FAT_ENT_EOF,
-						wait);
+			err = fat_ent_write(inode, &fatent, FAT_ENT_EOF, wait);
 			if (err)
 				ret = err;
 		}
@@ -251,24 +250,36 @@ static int fat_free(struct inode *inode,
 		if (ret < 0)
 			return ret;
 
+		free_start = ret;
+		i_start = i_logstart = 0;
 		fat_cache_inval_inode(inode);
 	} else {
 		fat_cache_inval_inode(inode);
 
-		ret = MSDOS_I(inode)->i_start;
+		i_start = free_start = MSDOS_I(inode)->i_start;
+		i_logstart = MSDOS_I(inode)->i_logstart;
 		MSDOS_I(inode)->i_start = 0;
 		MSDOS_I(inode)->i_logstart = 0;
-		if (wait) {
-			int err = fat_sync_inode(inode);
-			if (err)
-				return err;
-		} else
-			mark_inode_dirty(inode);
 	}
+	MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
+	if (wait) {
+		err = fat_sync_inode(inode);
+		if (err)
+			goto error;
+	} else
+		mark_inode_dirty(inode);
 	inode->i_blocks = skip << (MSDOS_SB(sb)->cluster_bits - 9);
 
 	/* Freeing the remained cluster chain */
-	return fat_free_clusters(inode, ret);
+	return fat_free_clusters(inode, free_start);
+
+error:
+	if (i_start) {
+		MSDOS_I(inode)->i_start = i_start;
+		MSDOS_I(inode)->i_logstart = i_logstart;
+	}
+	return err;
 }
 
 void fat_truncate(struct inode *inode)
@@ -288,12 +299,7 @@ void fat_truncate(struct inode *inode)
 
 	lock_kernel();
 	fat_free(inode, nr_clusters);
-	MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 	unlock_kernel();
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
-	mark_inode_dirty(inode);
-	if (IS_SYNC(inode))
-		fat_sync_inode(inode);
 }
 
 struct inode_operations fat_file_inode_operations = {
_
