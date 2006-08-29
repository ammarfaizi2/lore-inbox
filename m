Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWH2QvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWH2QvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWH2QtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:49:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31133 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965118AbWH2QqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:46:08 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 07/19] BLOCK: Remove dependence on existence of blockdev_superblock [try #5]
Date: Tue, 29 Aug 2006 17:46:04 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829164604.15723.21277.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
References: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
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

 fs/fs-writeback.c |    6 +++---
 fs/internal.h     |    2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 0639024..c403b66 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -319,7 +319,7 @@ sync_sb_inodes(struct super_block *sb, s
 
 		if (!bdi_cap_writeback_dirty(bdi)) {
 			list_move(&inode->i_list, &sb->s_dirty);
-			if (sb == blockdev_superblock) {
+			if (sb_is_blkdev_sb(sb)) {
 				/*
 				 * Dirty memory-backed blockdev: the ramdisk
 				 * driver does this.  Skip just this inode
@@ -336,14 +336,14 @@ sync_sb_inodes(struct super_block *sb, s
 
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
diff --git a/fs/internal.h b/fs/internal.h
index c21ecd3..f662b70 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -17,6 +17,8 @@ #include <linux/ioctl32.h>
 extern struct super_block *blockdev_superblock;
 extern void __init bdev_cache_init(void);
 
+#define sb_is_blkdev_sb(sb) ((sb) == blockdev_superblock)
+
 /*
  * char_dev.c
  */
