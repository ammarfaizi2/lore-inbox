Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWHBADJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWHBADJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 20:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWHBACk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 20:02:40 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:28069 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750763AbWHAXwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:52:50 -0400
Subject: [PATCH 08/28] record when sb_writer_count elevated for inode
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:46 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235246.A4B858F0@localhost.localdomain>
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
 lxc-dave/fs/libfs.c         |    2 ++
 lxc-dave/include/linux/fs.h |    1 +
 mm/page_alloc.c             |    0 
 4 files changed, 9 insertions(+), 1 deletion(-)

diff -puN fs/inode.c~C-record-when-sb_writer_count-elevated-for-inode-in-inode fs/inode.c
--- lxc/fs/inode.c~C-record-when-sb_writer_count-elevated-for-inode-in-inode	2006-08-01 16:35:11.000000000 -0700
+++ lxc-dave/fs/inode.c	2006-08-01 16:35:20.000000000 -0700
@@ -1114,12 +1114,17 @@ EXPORT_SYMBOL_GPL(generic_drop_inode);
  */
 static inline void iput_final(struct inode *inode)
 {
-	struct super_operations *op = inode->i_sb->s_op;
+	struct super_block *sb = inode->i_sb;
+	struct super_operations *op = sb->s_op;
 	void (*drop)(struct inode *) = generic_drop_inode;
+	int must_drop_sb_write = (inode->i_state & I_AWAITING_FINAL_IPUT);
 
+	inode->i_state &= ~I_AWAITING_FINAL_IPUT;
 	if (op && op->drop_inode)
 		drop = op->drop_inode;
 	drop(inode);
+	if (must_drop_sb_write)
+		atomic_dec(&sb->s_mnt_writers);
 }
 
 /**
diff -puN fs/libfs.c~C-record-when-sb_writer_count-elevated-for-inode-in-inode fs/libfs.c
--- lxc/fs/libfs.c~C-record-when-sb_writer_count-elevated-for-inode-in-inode	2006-08-01 16:35:17.000000000 -0700
+++ lxc-dave/fs/libfs.c	2006-08-01 16:35:20.000000000 -0700
@@ -272,6 +272,7 @@ out:
 
 void __inode_set_awaiting_final_iput(struct inode *inode)
 {
+	inode->i_state |= I_AWAITING_FINAL_IPUT;
 }
 
 int simple_unlink(struct inode *dir, struct dentry *dentry)
@@ -377,6 +378,7 @@ int simple_fill_super(struct super_block
 	inode = new_inode(s);
 	if (!inode)
 		return -ENOMEM;
+	inode->i_state |= I_AWAITING_FINAL_IPUT;
 	inode->i_mode = S_IFDIR | 0755;
 	inode->i_uid = inode->i_gid = 0;
 	inode->i_blocks = 0;
diff -puN include/linux/fs.h~C-record-when-sb_writer_count-elevated-for-inode-in-inode include/linux/fs.h
--- lxc/include/linux/fs.h~C-record-when-sb_writer_count-elevated-for-inode-in-inode	2006-08-01 16:35:19.000000000 -0700
+++ lxc-dave/include/linux/fs.h	2006-08-01 16:35:20.000000000 -0700
@@ -1239,6 +1239,7 @@ struct super_operations {
 #define I_CLEAR			32
 #define I_NEW			64
 #define I_WILL_FREE		128
+#define I_AWAITING_FINAL_IPUT		256
 
 #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
 
diff -puN mm/page_alloc.c~C-record-when-sb_writer_count-elevated-for-inode-in-inode mm/page_alloc.c
_
