Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWCIQVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWCIQVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWCIQVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:21:36 -0500
Received: from mail.parknet.jp ([210.171.160.80]:24846 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932371AbWCIQVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:21:35 -0500
X-AuthUser: hirofumi@parknet.jp
To: linux-kernel@vger.kernel.org
Subject: [PATCH] freeze_bdev() cleanup
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 10 Mar 2006 01:21:08 +0900
Message-ID: <87k6b3zj0r.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

freeze_bdev() uses a fsync_super() without sync_blockdev(). This patch
makes __fsync_super() for shareing it.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/buffer.c |   30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff -puN fs/buffer.c~freeze_bdev-cleanup fs/buffer.c
--- linux-2.6/fs/buffer.c~freeze_bdev-cleanup	2006-03-03 00:24:40.000000000 +0900
+++ linux-2.6-hirofumi/fs/buffer.c	2006-03-03 00:24:40.000000000 +0900
@@ -160,12 +160,7 @@ int sync_blockdev(struct block_device *b
 }
 EXPORT_SYMBOL(sync_blockdev);
 
-/*
- * Write out and wait upon all dirty data associated with this
- * superblock.  Filesystem data as well as the underlying block
- * device.  Takes the superblock lock.
- */
-int fsync_super(struct super_block *sb)
+static void __fsync_super(struct super_block *sb)
 {
 	sync_inodes_sb(sb, 0);
 	DQUOT_SYNC(sb);
@@ -177,7 +172,16 @@ int fsync_super(struct super_block *sb)
 		sb->s_op->sync_fs(sb, 1);
 	sync_blockdev(sb->s_bdev);
 	sync_inodes_sb(sb, 1);
+}
 
+/*
+ * Write out and wait upon all dirty data associated with this
+ * superblock.  Filesystem data as well as the underlying block
+ * device.  Takes the superblock lock.
+ */
+int fsync_super(struct super_block *sb)
+{
+	__fsync_super(sb);
 	return sync_blockdev(sb->s_bdev);
 }
 
@@ -216,19 +220,7 @@ struct super_block *freeze_bdev(struct b
 		sb->s_frozen = SB_FREEZE_WRITE;
 		smp_wmb();
 
-		sync_inodes_sb(sb, 0);
-		DQUOT_SYNC(sb);
-
-		lock_super(sb);
-		if (sb->s_dirt && sb->s_op->write_super)
-			sb->s_op->write_super(sb);
-		unlock_super(sb);
-
-		if (sb->s_op->sync_fs)
-			sb->s_op->sync_fs(sb, 1);
-
-		sync_blockdev(sb->s_bdev);
-		sync_inodes_sb(sb, 1);
+		__fsync_super(sb);
 
 		sb->s_frozen = SB_FREEZE_TRANS;
 		smp_wmb();
_
