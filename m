Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUAAWHb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265423AbUAAV7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:59:55 -0500
Received: from thunk.org ([140.239.227.29]:62114 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265422AbUAAVvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 16:51:16 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [PATCH] [2.4.24-pre3] 2/5  EXT2/3 Updates
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1AcAiP-0000LS-Gn@thunk.org>
Date: Thu, 01 Jan 2004 16:50:49 -0500
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1357  -> 1.1358 
#	     fs/ext2/inode.c	1.19    -> 1.20   
#	     fs/ext3/inode.c	1.16    -> 1.17   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/01	tytso@think.thunk.org	1.1358
# Applied 4208-ext23-symlink-ea-compat.patch from sct@redhat.com
# 
# I found why people running SELinux on 2.6 were having trouble booting
# again on 2.4 kernels, and it's nothing to do with SELinux per-se.  It's
# a compatibility problem with extended attributes.
#                                                                                                                                
# The trouble is that setting an EA on a fast symlink upsets the kernel's
# symlink detection code.  Older kernels will see a symlink with non-zero
# i_blocks, and will assume that the symlink is a slow one --- ie. that
# the first direct block of the inode points to the symlink contents ---
# and will end up doing a block lookup from what is in fact the first four
# ascii chars from the symlink path.
#                                                                                                                                
# 2.6 kernels deal with this by detecting a non-zero i_file_acl field and
# subtracting the EA's blocks from i_blocks before checking if the block
# count is zero.  The patch below adds the same compatibility code to
# 2.4.  Booting a SELinux partition results in immediate death via access
# beyond end-of-device as soon as the kernel tries to dereference /bin/sh
# (a symlink to /bin/bash on this box); with the fix, it's fine.
# 
# --------------------------------------------
#
diff -Nru a/fs/ext2/inode.c b/fs/ext2/inode.c
--- a/fs/ext2/inode.c	Thu Jan  1 16:29:13 2004
+++ b/fs/ext2/inode.c	Thu Jan  1 16:29:13 2004
@@ -35,6 +35,17 @@
 MODULE_DESCRIPTION("Second Extended Filesystem");
 MODULE_LICENSE("GPL");
 
+/*
+ * Test whether an inode is a fast symlink.
+ */
+static inline int ext2_inode_is_fast_symlink(struct inode *inode)
+{
+	int ea_blocks = inode->u.ext2_i.i_file_acl ?
+		(inode->i_sb->s_blocksize >> 9) : 0;
+
+	return (S_ISLNK(inode->i_mode) &&
+		inode->i_blocks - ea_blocks == 0);
+}
 
 static int ext2_update_inode(struct inode * inode, int do_sync);
 
@@ -801,6 +812,8 @@
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	    S_ISLNK(inode->i_mode)))
 		return;
+	if (ext2_inode_is_fast_symlink(inode))
+		return;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
 
@@ -1001,7 +1014,7 @@
 		inode->i_fop = &ext2_dir_operations;
 		inode->i_mapping->a_ops = &ext2_aops;
 	} else if (S_ISLNK(inode->i_mode)) {
-		if (!inode->i_blocks)
+		if (ext2_inode_is_fast_symlink(inode))
 			inode->i_op = &ext2_fast_symlink_inode_operations;
 		else {
 			inode->i_op = &page_symlink_inode_operations;
diff -Nru a/fs/ext3/inode.c b/fs/ext3/inode.c
--- a/fs/ext3/inode.c	Thu Jan  1 16:29:13 2004
+++ b/fs/ext3/inode.c	Thu Jan  1 16:29:13 2004
@@ -39,6 +39,18 @@
  */
 #undef SEARCH_FROM_ZERO
 
+/*
+ * Test whether an inode is a fast symlink.
+ */
+static inline int ext3_inode_is_fast_symlink(struct inode *inode)
+{
+	int ea_blocks = EXT3_I(inode)->i_file_acl ?
+		(inode->i_sb->s_blocksize >> 9) : 0;
+
+	return (S_ISLNK(inode->i_mode) &&
+		inode->i_blocks - ea_blocks == 0);
+}
+
 /* The ext3 forget function must perform a revoke if we are freeing data
  * which has been journaled.  Metadata (eg. indirect blocks) must be
  * revoked in all cases. 
@@ -1870,6 +1882,8 @@
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	    S_ISLNK(inode->i_mode)))
 		return;
+	if (ext3_inode_is_fast_symlink(inode))
+		return;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
 
@@ -2170,7 +2184,7 @@
 		inode->i_op = &ext3_dir_inode_operations;
 		inode->i_fop = &ext3_dir_operations;
 	} else if (S_ISLNK(inode->i_mode)) {
-		if (!inode->i_blocks)
+		if (ext3_inode_is_fast_symlink(inode))
 			inode->i_op = &ext3_fast_symlink_inode_operations;
 		else {
 			inode->i_op = &page_symlink_inode_operations;
