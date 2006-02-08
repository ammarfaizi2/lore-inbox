Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030609AbWBHUbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030609AbWBHUbd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030610AbWBHUbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:31:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37053 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030609AbWBHUbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:31:32 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] fix handling of st_nlink on procfs root
Message-Id: <E1F6vyO-00009r-3a@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 20:31:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1139427460 -0500

1) it should use nr_processes(), not nr_threads; otherwise we are getting
very confused find(1) and friends, among other things.
2) better do that at stat() time than at every damn lookup in procfs root.

Patch had been sitting in FC4 kernels for many months now...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/proc/inode.c |    4 ----
 fs/proc/root.c  |   17 +++++++++--------
 2 files changed, 9 insertions(+), 12 deletions(-)

ec5a7567ad58f55067f527e700723480cfbdbee5
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 6573f31..075d3e9 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -204,10 +204,6 @@ int proc_fill_super(struct super_block *
 	root_inode = proc_get_inode(s, PROC_ROOT_INO, &proc_root);
 	if (!root_inode)
 		goto out_no_root;
-	/*
-	 * Fixup the root inode's nlink value
-	 */
-	root_inode->i_nlink += nr_processes();
 	root_inode->i_uid = 0;
 	root_inode->i_gid = 0;
 	s->s_root = d_alloc_root(root_inode);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 6889628..c3fd361 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -80,16 +80,16 @@ void __init proc_root_init(void)
 	proc_bus = proc_mkdir("bus", NULL);
 }
 
-static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
+static int proc_root_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat
+)
 {
-	/*
-	 * nr_threads is actually protected by the tasklist_lock;
-	 * however, it's conventional to do reads, especially for
-	 * reporting, without any locking whatsoever.
-	 */
-	if (dir->i_ino == PROC_ROOT_INO) /* check for safety... */
-		dir->i_nlink = proc_root.nlink + nr_threads;
+	generic_fillattr(dentry->d_inode, stat);
+	stat->nlink = proc_root.nlink + nr_processes();
+	return 0;
+}
 
+static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
+{
 	if (!proc_lookup(dir, dentry, nd)) {
 		return NULL;
 	}
@@ -134,6 +134,7 @@ static struct file_operations proc_root_
  */
 static struct inode_operations proc_root_inode_operations = {
 	.lookup		= proc_root_lookup,
+	.getattr	= proc_root_getattr,
 };
 
 /*
-- 
0.99.9.GIT

