Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWHYOt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWHYOt6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWHYOt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:49:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11393 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030206AbWHYOtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:49:39 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 07/18] [PATCH] BLOCK: Remove dependence on existence of blockdev_superblock [try #3]
Date: Fri, 25 Aug 2006 15:49:31 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060825144931.30722.43302.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060825144916.30722.90944.stgit@warthog.cambridge.redhat.com>
References: <20060825144916.30722.90944.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Move blockdev_superblock extern declaration from fs/fs-writeback.c to a
headerfile and remove the dependence on it by wrapping it in a macro.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/fs-writeback.c      |    8 +++-----
 include/linux/blkdev.h |    4 ++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 892643d..d9de186 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -23,8 +23,6 @@ #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
 
-extern struct super_block *blockdev_superblock;
-
 /**
  *	__mark_inode_dirty -	internal function
  *	@inode: inode to mark
@@ -320,7 +318,7 @@ sync_sb_inodes(struct super_block *sb, s
 
 		if (!bdi_cap_writeback_dirty(bdi)) {
 			list_move(&inode->i_list, &sb->s_dirty);
-			if (sb == blockdev_superblock) {
+			if (sb_is_blkdev_sb(sb)) {
 				/*
 				 * Dirty memory-backed blockdev: the ramdisk
 				 * driver does this.  Skip just this inode
@@ -337,14 +335,14 @@ sync_sb_inodes(struct super_block *sb, s
 
 		if (wbc->nonblocking && bdi_write_congested(bdi)) {
 			wbc->encountered_congestion = 1;
-			if (sb != blockdev_superblock)
+			if (!sb_is_blkdev_sb(sb))
 				break;		/* Skip a congested fs */
 			list_move(&inode->i_list, &sb->s_dirty);
 			continue;		/* Skip a congested blockdev */
 		}
 
 		if (wbc->bdi && bdi != wbc->bdi) {
-			if (sb != blockdev_superblock)
+			if (!sb_is_blkdev_sb(sb))
 				break;		/* fs has the wrong queue */
 			list_move(&inode->i_list, &sb->s_dirty);
 			continue;		/* blockdev has wrong queue */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 04a11f7..311538e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -16,6 +16,10 @@ #include <linux/stringify.h>
 
 #include <asm/scatterlist.h>
 
+extern struct super_block *blockdev_superblock;
+
+#define sb_is_blkdev_sb(sb) ((sb) == blockdev_superblock)
+
 struct scsi_ioctl_command;
 
 struct request_queue;
