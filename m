Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVD1Oo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVD1Oo7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 10:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVD1Oo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 10:44:59 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:5801 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261986AbVD1Ool (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 10:44:41 -0400
To: akpm@osdl.org
CC: hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: tighten check for processes allowed access
Message-Id: <E1DRAFS-0005vu-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Apr 2005 16:44:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tightens the check for allowing processes to access
non-privileged mounts.  The rational is that the filesystem
implementation can control the behavior or get otherwise unavailable
information of the filesystem user.  If the filesystem user process
has the same uid, gid, and is not suid or sgid application, then
access is safe.  Otherwise access is not allowed unless the
"allow_other" mount option is given (for which policy is controlled by
the userspace mount utility).

Thanks to everyone linux-fsdevel, especially Martin Mares who helped
uncover problems with the previous approach.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc2-mm3/fs/fuse/dir.c linux-fuse/fs/fuse/dir.c
--- linux-2.6.12-rc2-mm3/fs/fuse/dir.c	2005-04-28 15:41:34.000000000 +0200
+++ linux-fuse/fs/fuse/dir.c	2005-04-28 15:44:34.000000000 +0200
@@ -412,17 +412,45 @@ int fuse_do_getattr(struct inode *inode)
 	return err;
 }
 
+/*
+ * Calling into a user-controlled filesystem gives the filesystem
+ * daemon ptrace-like capabilities over the requester process.  This
+ * means, that the filesystem daemon is able to record the exact
+ * filesystem operations performed, and can also control the behavior
+ * of the requester process in otherwise impossible ways.  For example
+ * it can delay the operation for arbitrary length of time allowing
+ * DoS against the requester.
+ *
+ * For this reason only those processes can call into the filesystem,
+ * for which the owner of the mount has ptrace privilege.  This
+ * excludes processes started by other users, suid or sgid processes.
+ */
+static int fuse_allow_task(struct fuse_conn *fc, struct task_struct *task)
+{
+	if (fc->flags & FUSE_ALLOW_OTHER)
+		return 1;
+
+	if (task->euid == fc->user_id &&
+	    task->suid == fc->user_id &&
+	    task->uid == fc->user_id &&
+	    task->egid == fc->group_id &&
+	    task->sgid == fc->group_id &&
+	    task->gid == fc->group_id)
+		return 1;
+
+	return 0;
+}
+
 static int fuse_revalidate(struct dentry *entry)
 {
 	struct inode *inode = entry->d_inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (get_node_id(inode) == FUSE_ROOT_ID) {
-		if (!(fc->flags & FUSE_ALLOW_OTHER) &&
-		    current->fsuid != fc->user_id)
-			return -EACCES;
-	} else if (time_before_eq(jiffies, fi->i_time))
+	if (!fuse_allow_task(fc, current))
+		return -EACCES;
+	if (get_node_id(inode) != FUSE_ROOT_ID &&
+	    time_before_eq(jiffies, fi->i_time))
 		return 0;
 
 	return fuse_do_getattr(inode);
@@ -432,7 +460,7 @@ static int fuse_permission(struct inode 
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (!(fc->flags & FUSE_ALLOW_OTHER) && current->fsuid != fc->user_id)
+	if (!fuse_allow_task(fc, current))
 		return -EACCES;
 	else if (fc->flags & FUSE_DEFAULT_PERMISSIONS) {
 		int err = generic_permission(inode, mask, NULL);
diff -rup linux-2.6.12-rc2-mm3/fs/fuse/fuse_i.h linux-fuse/fs/fuse/fuse_i.h
--- linux-2.6.12-rc2-mm3/fs/fuse/fuse_i.h	2005-04-22 15:53:43.000000000 +0200
+++ linux-fuse/fs/fuse/fuse_i.h	2005-04-28 15:44:34.000000000 +0200
@@ -198,6 +198,9 @@ struct fuse_conn {
 	/** The user id for this mount */
 	uid_t user_id;
 
+	/** The group id for this mount */
+	gid_t group_id;
+
 	/** The fuse mount flags for this mount */
 	unsigned flags;
 
diff -rup linux-2.6.12-rc2-mm3/fs/fuse/inode.c linux-fuse/fs/fuse/inode.c
--- linux-2.6.12-rc2-mm3/fs/fuse/inode.c	2005-04-22 15:53:43.000000000 +0200
+++ linux-fuse/fs/fuse/inode.c	2005-04-28 15:44:34.000000000 +0200
@@ -31,6 +31,7 @@ struct fuse_mount_data {
 	int fd;
 	unsigned rootmode;
 	unsigned user_id;
+	unsigned group_id;
 	unsigned flags;
 	unsigned max_read;
 };
@@ -196,6 +197,7 @@ static void fuse_put_super(struct super_
 	spin_lock(&fuse_lock);
 	fc->mounted = 0;
 	fc->user_id = 0;
+	fc->group_id = 0;
 	fc->flags = 0;
 	/* Flush all readers on this fs */
 	wake_up_all(&fc->waitq);
@@ -245,6 +247,7 @@ enum {
 	OPT_FD,
 	OPT_ROOTMODE,
 	OPT_USER_ID,
+	OPT_GROUP_ID,
 	OPT_DEFAULT_PERMISSIONS,
 	OPT_ALLOW_OTHER,
 	OPT_KERNEL_CACHE,
@@ -257,6 +260,7 @@ static match_table_t tokens = {
 	{OPT_FD,			"fd=%u"},
 	{OPT_ROOTMODE,			"rootmode=%o"},
 	{OPT_USER_ID,			"user_id=%u"},
+	{OPT_GROUP_ID,			"group_id=%u"},
 	{OPT_DEFAULT_PERMISSIONS,	"default_permissions"},
 	{OPT_ALLOW_OTHER,		"allow_other"},
 	{OPT_KERNEL_CACHE,		"kernel_cache"},
@@ -299,6 +303,12 @@ static int parse_fuse_opt(char *opt, str
 			d->user_id = value;
 			break;
 
+		case OPT_GROUP_ID:
+			if (match_int(&args[0], &value))
+				return 0;
+			d->group_id = value;
+			break;
+
 		case OPT_DEFAULT_PERMISSIONS:
 			d->flags |= FUSE_DEFAULT_PERMISSIONS;
 			break;
@@ -336,6 +346,7 @@ static int fuse_show_options(struct seq_
 	struct fuse_conn *fc = get_fuse_conn_super(mnt->mnt_sb);
 
 	seq_printf(m, ",user_id=%u", fc->user_id);
+	seq_printf(m, ",group_id=%u", fc->group_id);
 	if (fc->flags & FUSE_DEFAULT_PERMISSIONS)
 		seq_puts(m, ",default_permissions");
 	if (fc->flags & FUSE_ALLOW_OTHER)
@@ -532,6 +543,7 @@ static int fuse_fill_super(struct super_
 
 	fc->flags = d.flags;
 	fc->user_id = d.user_id;
+	fc->group_id = d.group_id;
 	fc->max_read = d.max_read;
 	if (fc->max_read / PAGE_CACHE_SIZE < fc->bdi.ra_pages)
 		fc->bdi.ra_pages = fc->max_read / PAGE_CACHE_SIZE;
