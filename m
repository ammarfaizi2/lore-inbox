Return-Path: <linux-kernel-owner+w=401wt.eu-S965122AbWL2TL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWL2TL4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 14:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbWL2TLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 14:11:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55470 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965113AbWL2TLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 14:11:25 -0500
Date: Fri, 29 Dec 2006 14:11:14 -0500
Message-Id: <200612291911.kBTJBEOS019103@dantu.rdu.redhat.com>
From: Jeff Layton <jlayton@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] change libfs sb creation routines to avoid collisions with their root inodes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the superblock creation routines that call new_inode to take steps
to avoid later collisions with other inodes that get created. I took the
approach here of not hashing things unless is was strictly necessary, though
that does mean that filesystem authors need to be careful to avoid collisions
by calling iunique properly.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/fs/libfs.c b/fs/libfs.c
index 503898d..5bdaf00 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -217,6 +217,12 @@ int get_sb_pseudo(struct file_system_type *fs_type, char *name,
 	root = new_inode(s);
 	if (!root)
 		goto Enomem;
+	/*
+	 * since this is the first inode, make it number 1. New inodes created
+         * after this must take care not to collide with it (by passing
+	 * max_reserved of 1 to iunique).
+	 */
+	root->i_ino = 1;
 	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
 	root->i_uid = root->i_gid = 0;
 	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
@@ -373,6 +379,9 @@ int simple_fill_super(struct super_block *s, int magic, struct tree_descr *files
 	inode = new_inode(s);
 	if (!inode)
 		return -ENOMEM;
+	/* set to high value to try and avoid collisions with loop below */
+	inode->i_ino = 0xffffffff;
+	insert_inode_hash(inode);
 	inode->i_mode = S_IFDIR | 0755;
 	inode->i_uid = inode->i_gid = 0;
 	inode->i_blocks = 0;
@@ -399,6 +408,11 @@ int simple_fill_super(struct super_block *s, int magic, struct tree_descr *files
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		inode->i_fop = files->ops;
+		/*
+		 * no need to hash these, but you need to make sure that any
+		 * calls to iunique on this mount call it with a max_reserved
+		 * value high enough to avoid collisions with these inodes.
+		 */
 		inode->i_ino = i;
 		d_add(dentry, inode);
 	}
