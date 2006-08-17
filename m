Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWHQTqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWHQTqR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWHQTqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:46:17 -0400
Received: from mail.tigress.co.uk ([195.172.168.163]:38589 "EHLO
	intgat.tigress.co.uk") by vger.kernel.org with ESMTP
	id S1030194AbWHQTqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:46:16 -0400
From: Ron Yorston <rmy@tigress.co.uk>
Message-Id: <200608171945.k7HJjaLk029781@tiffany.internal.tigress.co.uk>
Date: Thu, 17 Aug 2006 20:45:36 +0100
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext2: avoid needless discard of preallocated blocks
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently preallocated blocks in ext2 are discarded on every call
to iput() (by ext2_put_inode() calling ext2_discard_prealloc()).

An earlier attempt to fix this ("discard ext2 preallocation in last
iput") moved the ext2_discard_prealloc() call to ext2_clear_inode(),
but was found to cause filesystem corruption in a test using fsx.
The problem was that ext2_clear_inode() was writing the inode data
to disk before calling ext2_discard_prealloc(), so the value of
i_blocks on disk included the preallocated blocks.

This patch moves the call to ext2_discard_prealloc() to the new
function ext2_drop_inode().  This should be both efficient (discard
happens on only the last call to iput()) and correct (fixes i_blocks
before writing to disk).  Also, as there is now possibly a longer
window during which an open file may have an incorrrect block count
in its on-disk inode, ext2_update_inode adjusts the block count to
account for preallocated blocks.

No corruption has been detected using the fsx test.

Signed-off-by: Ron Yorston <rmy@tigress.co.uk>
---

--- linux-2.6.17/fs/ext2/super.c.prealloc	2006-06-18 02:49:35.000000000 +0100
+++ linux-2.6.17/fs/ext2/super.c	2006-08-17 20:16:34.000000000 +0100
@@ -238,7 +238,7 @@ static struct super_operations ext2_sops
 	.destroy_inode	= ext2_destroy_inode,
 	.read_inode	= ext2_read_inode,
 	.write_inode	= ext2_write_inode,
-	.put_inode	= ext2_put_inode,
+	.drop_inode	= ext2_drop_inode,
 	.delete_inode	= ext2_delete_inode,
 	.put_super	= ext2_put_super,
 	.write_super	= ext2_write_super,
--- linux-2.6.17/fs/ext2/inode.c.prealloc	2006-06-18 02:49:35.000000000 +0100
+++ linux-2.6.17/fs/ext2/inode.c	2006-08-17 20:16:34.000000000 +0100
@@ -54,16 +54,18 @@ static inline int ext2_inode_is_fast_sym
 }
 
 /*
- * Called at each iput().
+ * Called from iput_final().
  *
  * The inode may be "bad" if ext2_read_inode() saw an error from
  * ext2_get_inode(), so we need to check that to avoid freeing random disk
  * blocks.
  */
-void ext2_put_inode(struct inode *inode)
+void ext2_drop_inode(struct inode *inode)
 {
 	if (!is_bad_inode(inode))
 		ext2_discard_prealloc(inode);
+
+	generic_drop_inode(inode);
 }
 
 /*
@@ -1176,6 +1178,7 @@ static int ext2_update_inode(struct inod
 	ino_t ino = inode->i_ino;
 	uid_t uid = inode->i_uid;
 	gid_t gid = inode->i_gid;
+	blkcnt_t blocks = inode->i_blocks;
 	struct buffer_head * bh;
 	struct ext2_inode * raw_inode = ext2_get_inode(sb, ino, &bh);
 	int n;
@@ -1216,7 +1219,8 @@ static int ext2_update_inode(struct inod
 	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
 	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
 
-	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
+	blocks -= ei->i_prealloc_count * (inode->i_sb->s_blocksize >> 9);
+	raw_inode->i_blocks = cpu_to_le32(blocks);
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
 	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
 	raw_inode->i_faddr = cpu_to_le32(ei->i_faddr);
--- linux-2.6.17/fs/ext2/ext2.h.prealloc	2006-06-18 02:49:35.000000000 +0100
+++ linux-2.6.17/fs/ext2/ext2.h	2006-08-17 20:16:34.000000000 +0100
@@ -125,7 +125,7 @@ extern unsigned long ext2_count_free (st
 /* inode.c */
 extern void ext2_read_inode (struct inode *);
 extern int ext2_write_inode (struct inode *, int);
-extern void ext2_put_inode (struct inode *);
+extern void ext2_drop_inode (struct inode *);
 extern void ext2_delete_inode (struct inode *);
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
