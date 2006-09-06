Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWIFQXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWIFQXn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWIFQXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:23:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42882 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751465AbWIFQXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:23:42 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] proc: Make the generation of the self symlink table driven.
Date: Wed, 06 Sep 2006 10:23:00 -0600
Message-ID: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch generalizes the concept of files in /proc that are
related to processes but live in the root directory of /proc

Ideally this would reuse infrastructure from the rest of the
process specific parts of proc but unfortunately
security_task_to_inode must not be called on files that
are not strictly per process.  security_task_to_inode
really needs to be reexamined as the security label can
change in important places that we are not currently
catching, but I'm not certain that simplifies this problem.

By at least matching the structure of the rest of proc
we get more idiom reuse and it becomes easier to spot problems
in the way things are put together.

Later things like /proc/mounts are likely to be moved into
proc_base as well.  If union mounts are ever supported
we may be able to make /proc a union mount, and properly
split it into 2 filesystems.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c |  133 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 111 insertions(+), 22 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4096518..9055918 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1674,6 +1674,108 @@ static struct inode_operations proc_self
 };
 
 /*
+ * proc base
+ *
+ * These are the directory entries in the root directory of /proc
+ * that properly belong to the /proc filesystem, as they describe
+ * describe something that is process related.
+ */
+static struct pid_entry proc_base_stuff[] = {
+	NOD(PROC_TGID_INO, 	"self", S_IFLNK|S_IRWXUGO,
+		&proc_self_inode_operations, NULL, {}),
+	{}
+};
+
+/*
+ *	Exceptional case: normally we are not allowed to unhash a busy
+ * directory. In this case, however, we can do it - no aliasing problems
+ * due to the way we treat inodes.
+ */
+static int proc_base_revalidate(struct dentry *dentry, struct nameidata *nd)
+{
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *task = get_proc_task(inode);
+	if (task) {
+		put_task_struct(task);
+		return 1;
+	}
+	d_drop(dentry);
+	return 0;
+}
+
+static struct dentry_operations proc_base_dentry_operations =
+{
+	.d_revalidate	= proc_base_revalidate,
+	.d_delete	= pid_delete_dentry,
+};
+
+static struct dentry *proc_base_lookup(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode;
+	struct dentry *error;
+	struct task_struct *task = get_proc_task(dir);
+	struct pid_entry *p;
+	struct proc_inode *ei;
+
+	error = ERR_PTR(-ENOENT);
+	inode = NULL;
+
+	if (!task)
+		goto out_no_task;
+
+	/* Lookup the directory entry */
+	for (p = proc_base_stuff; p->name; p++) {
+		if (p->len != dentry->d_name.len)
+			continue;
+		if (!memcmp(dentry->d_name.name, p->name, p->len))
+			break;
+	}
+	if (!p->name)
+		goto out;
+
+	/* Allocate the inode */
+	error = ERR_PTR(-ENOMEM);
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		goto out;
+
+	/* Initialize the inode */
+	ei = PROC_I(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_ino = fake_ino(0, p->type);
+
+	/*
+	 * grab the reference to the task.
+	 */
+	ei->pid = get_pid(task_pid(task));
+	if (!ei->pid)
+		goto out_iput;
+
+	inode->i_uid = 0;
+	inode->i_gid = 0;
+	inode->i_mode = p->mode;
+	if (S_ISDIR(inode->i_mode))
+		inode->i_nlink = 2;
+	if (S_ISLNK(inode->i_mode))
+		inode->i_size = 64;
+	if (p->iop)
+		inode->i_op = p->iop;
+	if (p->fop)
+		inode->i_fop = p->fop;
+	ei->op = p->op;
+	dentry->d_op = &proc_base_dentry_operations;
+	d_add(dentry, inode);
+	error = NULL;
+out:
+	put_task_struct(task);
+out_no_task:
+	return error;
+out_iput:
+	iput(inode);
+	goto out;
+}
+
+/*
  * Thread groups
  */
 static struct file_operations proc_task_operations;
@@ -1819,24 +1921,12 @@ struct dentry *proc_pid_lookup(struct in
 	struct dentry *result = ERR_PTR(-ENOENT);
 	struct task_struct *task;
 	struct inode *inode;
-	struct proc_inode *ei;
 	unsigned tgid;
 
-	if (dentry->d_name.len == 4 && !memcmp(dentry->d_name.name,"self",4)) {
-		inode = new_inode(dir->i_sb);
-		if (!inode)
-			return ERR_PTR(-ENOMEM);
-		ei = PROC_I(inode);
-		inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-		inode->i_ino = fake_ino(0, PROC_TGID_INO);
-		ei->pde = NULL;
-		inode->i_mode = S_IFLNK|S_IRWXUGO;
-		inode->i_uid = inode->i_gid = 0;
-		inode->i_size = 64;
-		inode->i_op = &proc_self_inode_operations;
-		d_add(dentry, inode);
-		return NULL;
-	}
+	result = proc_base_lookup(dir, dentry);
+	if (!IS_ERR(result) || PTR_ERR(result) != -ENOENT)
+		goto out;
+
 	tgid = name_to_int(dentry);
 	if (tgid == ~0U)
 		goto out;
@@ -1922,12 +2012,11 @@ int proc_pid_readdir(struct file * filp,
 	struct task_struct *task;
 	int tgid;
 
-	if (!nr) {
-		ino_t ino = fake_ino(0,PROC_TGID_INO);
-		if (filldir(dirent, "self", 4, filp->f_pos, ino, DT_LNK) < 0)
-			return 0;
-		filp->f_pos++;
-		nr++;
+	for (; nr < (ARRAY_SIZE(proc_base_stuff) - 1); filp->f_pos++, nr++) {
+		struct pid_entry *p = &proc_base_stuff[nr];
+		if (filldir(dirent, p->name, p->len, filp->f_pos,
+			    fake_ino(0, p->type), p->mode >> 12) < 0)
+			goto out;
 	}
 
 	tgid = filp->f_pos - TGID_OFFSET;
-- 
1.4.2.rc3.g7e18e-dirty

