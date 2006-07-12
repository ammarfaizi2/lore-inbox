Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWGLSYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWGLSYR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWGLSYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:24:14 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:6322 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932317AbWGLSRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:19 -0400
Subject: [RFC][PATCH 06/27] record when sb_writer_count elevated for inode
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:14 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181714.6C3216FF@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are a number of filesystems that do iput()s without first
having messed with i_nlink.  In order to keep from accidentally
decrementing the superblock writer count for these, we record
when the count is bumped up, so that we can properly balance
it.

I know the flag name sucks.  Anybody have better ideas?

I first tried to do this by catching all of the users an intentions
whenever i_nlink is modified, but all of the filesystems do enough
creative things with it that even if it was all properly fixed now,
new issues with vfsmnt writer count imaglance will  probably pop
up in the future.  This patch trades that possibility for the chance
that we will miss a i_nlink--, and not bump the sb writer count.

I like the idea screwing up writing out a single inode better than
screwing up a global superblock count imbalance that will affect
all inodes.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/inode.c         |    7 ++++++-
 lxc-dave/fs/libfs.c         |    4 ++++
 lxc-dave/include/linux/fs.h |    1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff -puN fs/inode.c~C-record-when-sb_writer_count-elevated-for-inode-in-inode fs/inode.c
--- lxc/fs/inode.c~C-record-when-sb_writer_count-elevated-for-inode-in-inode	2006-07-12 11:09:16.000000000 -0700
+++ lxc-dave/fs/inode.c	2006-07-12 11:09:23.000000000 -0700
@@ -1114,12 +1114,17 @@ EXPORT_SYMBOL_GPL(generic_drop_inode);
  */
 static inline void iput_final(struct inode *inode)
 {
-	struct super_operations *op = inode->i_sb->s_op;
+	struct super_block *sb = inode->i_sb;
+	struct super_operations *op = sb->s_op;
 	void (*drop)(struct inode *) = generic_drop_inode;
+	int must_drop_sb_write = (inode->i_state & I_WRITING_ON_SB);
 
+	inode->i_state &= ~I_WRITING_ON_SB;
 	if (op && op->drop_inode)
 		drop = op->drop_inode;
 	drop(inode);
+	if (must_drop_sb_write)
+		atomic_dec(&sb->s_mnt_writers);
 }
 
 /**
diff -puN fs/libfs.c~C-record-when-sb_writer_count-elevated-for-inode-in-inode fs/libfs.c
--- lxc/fs/libfs.c~C-record-when-sb_writer_count-elevated-for-inode-in-inode	2006-07-12 11:09:19.000000000 -0700
+++ lxc-dave/fs/libfs.c	2006-07-12 11:09:23.000000000 -0700
@@ -273,6 +273,9 @@ out:
 void inode_drop_nlink(struct inode *inode)
 {
 	inode->i_nlink--;
+	if (inode->i_nlink)
+		return;
+	inode->i_state |= I_WRITING_ON_SB;
 }
 
 int simple_unlink(struct inode *dir, struct dentry *dentry)
@@ -386,6 +389,7 @@ int simple_fill_super(struct super_block
 	inode = new_inode(s);
 	if (!inode)
 		return -ENOMEM;
+	inode->i_state |= I_WRITING_ON_SB;
 	inode->i_mode = S_IFDIR | 0755;
 	inode->i_uid = inode->i_gid = 0;
 	inode->i_blocks = 0;
diff -puN include/linux/fs.h~C-record-when-sb_writer_count-elevated-for-inode-in-inode include/linux/fs.h
--- lxc/include/linux/fs.h~C-record-when-sb_writer_count-elevated-for-inode-in-inode	2006-07-12 11:09:22.000000000 -0700
+++ lxc-dave/include/linux/fs.h	2006-07-12 11:09:23.000000000 -0700
@@ -1237,6 +1237,7 @@ struct super_operations {
 #define I_CLEAR			32
 #define I_NEW			64
 #define I_WILL_FREE		128
+#define I_WRITING_ON_SB		256
 
 #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
 
_
