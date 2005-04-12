Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVDLStF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVDLStF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVDLSsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:48:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:9674 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262234AbVDLKcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:54 -0400
Message-Id: <200504121032.j3CAWhE5005660@shell0.pdx.osdl.net>
Subject: [patch 130/198] ext2 corruption - regression between 2.6.9 and 2.6.10
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, bernard@blackham.com.au,
       cmm@us.ibm.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bernard Blackham <bernard@blackham.com.au>

Whilst trying to stress test a Promise SX8 card, we stumbled across
some nasty filesystem corruption in ext2. Our tests involved
creating an ext2 partition, mounting, running several concurrent
fsx's over it, umounting, and fsck'ing, all scripted[1]. The fsck
would always return with errors.

This regression was traced back to a change between 2.6.9 and
2.6.10, which moves the functionality of ext2_put_inode into
ext2_clear_inode.  The attached patch reverses this change, and
eliminated the source of corruption.

Mingming Cao <cmm@us.ibm.com> said:

I think his patch for ext2 is correct.  The corruption on ext3 is not the same
issue he saw on ext2.  I believe that's the race between discard reservation
and reservation in-use that we already fixed it in 2.6.12- rc1.

For the problem related to ext2, at the time when we design reservation for
ext3, we decide we only need to discard the reservation at the last file
close, so we have ext3_discard_reservation on iput_final- >ext3_clear_inode.

The ext2 handle discard preallocation differently at that time, it discard the
preallocation at each iput(), not in input_final(), so we think it's
unnecessary to thrash it so frequently, and the right thing to do, as we did
for ext3 reservation, discard preallocation on last iput().  So we moved the
ext2_discard_preallocation from ext2_put_inode(0 to ext2_clear_inode.

Since ext2 preallocation is doing pre-allocation on disk, so it is possible
that at the unmount time, someone is still hold the reference of the inode, so
the preallocation for a file is not discard yet, so we still mark those blocks
allocated on disk, while they are not actually in the inode's block map, so
fsck will catch/fix that error later.

This is not a issue for ext3, as ext3 reservation(pre-allocation) is done in
memory.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/ext2/ext2.h  |    1 +
 25-akpm/fs/ext2/inode.c |   13 +++++++++++++
 25-akpm/fs/ext2/super.c |    4 +---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff -puN fs/ext2/ext2.h~ext2-corruption-regression-between-269-and-2610 fs/ext2/ext2.h
--- 25/fs/ext2/ext2.h~ext2-corruption-regression-between-269-and-2610	2005-04-12 03:21:35.004815360 -0700
+++ 25-akpm/fs/ext2/ext2.h	2005-04-12 03:21:35.010814448 -0700
@@ -116,6 +116,7 @@ extern unsigned long ext2_count_free (st
 /* inode.c */
 extern void ext2_read_inode (struct inode *);
 extern int ext2_write_inode (struct inode *, int);
+extern void ext2_put_inode (struct inode *);
 extern void ext2_delete_inode (struct inode *);
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
diff -puN fs/ext2/inode.c~ext2-corruption-regression-between-269-and-2610 fs/ext2/inode.c
--- 25/fs/ext2/inode.c~ext2-corruption-regression-between-269-and-2610	2005-04-12 03:21:35.006815056 -0700
+++ 25-akpm/fs/ext2/inode.c	2005-04-12 03:21:35.011814296 -0700
@@ -53,6 +53,19 @@ static inline int ext2_inode_is_fast_sym
 }
 
 /*
+ * Called at each iput().
+ *
+ * The inode may be "bad" if ext2_read_inode() saw an error from
+ * ext2_get_inode(), so we need to check that to avoid freeing random disk
+ * blocks.
+ */
+void ext2_put_inode(struct inode *inode)
+{
+	if (!is_bad_inode(inode))
+		ext2_discard_prealloc(inode);
+}
+
+/*
  * Called at the last iput() if i_nlink is zero.
  */
 void ext2_delete_inode (struct inode * inode)
diff -puN fs/ext2/super.c~ext2-corruption-regression-between-269-and-2610 fs/ext2/super.c
--- 25/fs/ext2/super.c~ext2-corruption-regression-between-269-and-2610	2005-04-12 03:21:35.007814904 -0700
+++ 25-akpm/fs/ext2/super.c	2005-04-12 03:21:35.012814144 -0700
@@ -198,11 +198,8 @@ static void ext2_clear_inode(struct inod
 		ei->i_default_acl = EXT2_ACL_NOT_CACHED;
 	}
 #endif
-	if (!is_bad_inode(inode))
-		ext2_discard_prealloc(inode);
 }
 
-
 #ifdef CONFIG_QUOTA
 static ssize_t ext2_quota_read(struct super_block *sb, int type, char *data, size_t len, loff_t off);
 static ssize_t ext2_quota_write(struct super_block *sb, int type, const char *data, size_t len, loff_t off);
@@ -213,6 +210,7 @@ static struct super_operations ext2_sops
 	.destroy_inode	= ext2_destroy_inode,
 	.read_inode	= ext2_read_inode,
 	.write_inode	= ext2_write_inode,
+	.put_inode	= ext2_put_inode,
 	.delete_inode	= ext2_delete_inode,
 	.put_super	= ext2_put_super,
 	.write_super	= ext2_write_super,
_
