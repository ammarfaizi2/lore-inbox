Return-Path: <linux-kernel-owner+w=401wt.eu-S1751438AbXAKTnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbXAKTnM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbXAKTnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:43:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53702 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbXAKTnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:43:09 -0500
Date: Thu, 11 Jan 2007 14:43:07 -0500
Message-Id: <200701111943.l0BJh7OT011708@dantu.rdu.redhat.com>
From: Jeff Layton <jlayton@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] change libfs sb creation routines to avoid collisions with their root inodes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a respun patch, which makes the root inode created by simple_fill_super
be number 1. This also adds some comments about appropriate usage of iunique
with this function, and caution about not passing it a files array with an
entry at index 1.

A couple of filesystems were passing in files structs with an entry at
index 1. That would have created a conflict, so I changed them so that
there would be not be.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_fs.c b/drivers/infiniband/hw/ipath/ipath_fs.c
index 79a60f0..6ce7926 100644
--- a/drivers/infiniband/hw/ipath/ipath_fs.c
+++ b/drivers/infiniband/hw/ipath/ipath_fs.c
@@ -510,7 +510,7 @@ static int ipathfs_fill_super(struct super_block *sb, void *data,
 	int ret;
 
 	static struct tree_descr files[] = {
-		[1] = {"atomic_stats", &atomic_stats_ops, S_IRUGO},
+		[2] = {"atomic_stats", &atomic_stats_ops, S_IRUGO},
 		{""},
 	};
 
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index c2e0825..023d825 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -727,8 +727,8 @@ static struct super_operations s_ops = {
 static int bm_fill_super(struct super_block * sb, void * data, int silent)
 {
 	static struct tree_descr bm_files[] = {
-		[1] = {"status", &bm_status_operations, S_IWUSR|S_IRUGO},
-		[2] = {"register", &bm_register_operations, S_IWUSR},
+		[2] = {"status", &bm_status_operations, S_IWUSR|S_IRUGO},
+		[3] = {"register", &bm_register_operations, S_IWUSR},
 		/* last one */ {""}
 	};
 	int err = simple_fill_super(sb, 0x42494e4d, bm_files);
diff --git a/fs/inode.c b/fs/inode.c
diff --git a/fs/libfs.c b/fs/libfs.c
index 503898d..d9a299b 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -217,6 +217,12 @@ int get_sb_pseudo(struct file_system_type *fs_type, char *name,
 	root = new_inode(s);
 	if (!root)
 		goto Enomem;
+	/*
+	 * since this is the first inode, make it number 1. New inodes created
+	 * after this must take care not to collide with it (by passing
+	 * max_reserved of 1 to iunique).
+	 */
+	root->i_ino = 1;
 	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
 	root->i_uid = root->i_gid = 0;
 	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
@@ -356,6 +362,11 @@ int simple_commit_write(struct file *file, struct page *page,
 	return 0;
 }
 
+/*
+ * the inodes created here are not hashed. If you use iunique to generate
+ * unique inode values later for this filesystem, then you must take care
+ * to pass it an appropriate max_reserved value to avoid collisions.
+ */
 int simple_fill_super(struct super_block *s, int magic, struct tree_descr *files)
 {
 	static struct super_operations s_ops = {.statfs = simple_statfs};
@@ -373,6 +384,11 @@ int simple_fill_super(struct super_block *s, int magic, struct tree_descr *files
 	inode = new_inode(s);
 	if (!inode)
 		return -ENOMEM;
+	/*
+	 * because the root inode is 1, the files array must not contain an
+	 * entry at index 1
+	 */
+	inode->i_ino = 1;
 	inode->i_mode = S_IFDIR | 0755;
 	inode->i_uid = inode->i_gid = 0;
 	inode->i_blocks = 0;
