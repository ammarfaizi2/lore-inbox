Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWIFQZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWIFQZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWIFQZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:25:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43650 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751475AbWIFQZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:25:33 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] proc: Factor out an instantiate method from every lookup method.
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
Date: Wed, 06 Sep 2006 10:24:50 -0600
In-Reply-To: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Wed, 06 Sep 2006 10:23:00 -0600")
Message-ID: <m1k64hx8rx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To remove the hard coded proc inode numbers it is necessary to be able
to create the proc inodes during readdir.  The instantiate methods are
the subset of lookup that is needed to accomplish that.

This first step just splits the lookup methods into 2 functions.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c |  269 +++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 158 insertions(+), 111 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9055918..8c62fe1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1254,21 +1254,15 @@ static struct dentry_operations tid_fd_d
 	.d_delete	= pid_delete_dentry,
 };
 
-/* SMP-safe */
-static struct dentry *proc_lookupfd(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
+static struct dentry *proc_fd_instantiate(struct inode *dir,
+	struct dentry *dentry, struct task_struct *task, void *ptr)
 {
-	struct task_struct *task = get_proc_task(dir);
-	unsigned fd = name_to_int(dentry);
-	struct dentry *result = ERR_PTR(-ENOENT);
-	struct file * file;
-	struct files_struct * files;
-	struct inode *inode;
-	struct proc_inode *ei;
-
-	if (!task)
-		goto out_no_task;
-	if (fd == ~0U)
-		goto out;
+	unsigned fd = *(unsigned *)ptr;
+	struct file *file;
+	struct files_struct *files;
+ 	struct inode *inode;
+ 	struct proc_inode *ei;
+	struct dentry *error = ERR_PTR(-ENOENT);
 
 	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TID_FD_DIR+fd);
 	if (!inode)
@@ -1277,7 +1271,7 @@ static struct dentry *proc_lookupfd(stru
 	ei->fd = fd;
 	files = get_files_struct(task);
 	if (!files)
-		goto out_unlock;
+		goto out_iput;
 	inode->i_mode = S_IFLNK;
 
 	/*
@@ -1287,13 +1281,14 @@ static struct dentry *proc_lookupfd(stru
 	spin_lock(&files->file_lock);
 	file = fcheck_files(files, fd);
 	if (!file)
-		goto out_unlock2;
+		goto out_unlock;
 	if (file->f_mode & 1)
 		inode->i_mode |= S_IRUSR | S_IXUSR;
 	if (file->f_mode & 2)
 		inode->i_mode |= S_IWUSR | S_IXUSR;
 	spin_unlock(&files->file_lock);
 	put_files_struct(files);
+
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
 	ei->op.proc_get_link = proc_fd_link;
@@ -1301,20 +1296,37 @@ static struct dentry *proc_lookupfd(stru
 	d_add(dentry, inode);
 	/* Close the race of the process dying before we return the dentry */
 	if (tid_fd_revalidate(dentry, NULL))
-		result = NULL;
-out:
-	put_task_struct(task);
-out_no_task:
-	return result;
+		error = NULL;
 
-out_unlock2:
+ out:
+	return error;
+out_unlock:
 	spin_unlock(&files->file_lock);
 	put_files_struct(files);
-out_unlock:
+out_iput:
 	iput(inode);
 	goto out;
 }
 
+/* SMP-safe */
+static struct dentry *proc_lookupfd(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
+{
+	struct task_struct *task = get_proc_task(dir);
+	unsigned fd = name_to_int(dentry);
+	struct dentry *result = ERR_PTR(-ENOENT);
+
+	if (!task)
+		goto out_no_task;
+	if (fd == ~0U)
+		goto out;
+
+	result = proc_fd_instantiate(dir, dentry, task, &fd);
+out:
+	put_task_struct(task);
+out_no_task:
+	return result;
+}
+
 static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
 {
 	struct dentry *dentry = filp->f_dentry;
@@ -1395,6 +1407,36 @@ static struct inode_operations proc_fd_i
 	.setattr	= proc_setattr,
 };
 
+static struct dentry *proc_pident_instantiate(struct inode *dir,
+	struct dentry *dentry, struct task_struct *task, void *ptr)
+{
+	struct pid_entry *p = ptr;
+	struct inode *inode;
+	struct proc_inode *ei;
+	struct dentry *error = ERR_PTR(-EINVAL);
+
+	inode = proc_pid_make_inode(dir->i_sb, task, p->type);
+	if (!inode)
+		goto out;
+
+	ei = PROC_I(inode);
+	inode->i_mode = p->mode;
+	if (S_ISDIR(inode->i_mode))
+		inode->i_nlink = 2;	/* Use getattr to fix if necessary */
+	if (p->iop)
+		inode->i_op = p->iop;
+	if (p->fop)
+		inode->i_fop = p->fop;
+	ei->op = p->op;
+	dentry->d_op = &pid_dentry_operations;
+	d_add(dentry, inode);
+	/* Close the race of the process dying before we return the dentry */
+	if (pid_revalidate(dentry, NULL))
+		error = NULL;
+out:
+	return error;
+}
+
 /* SMP-safe */
 static struct dentry *proc_pident_lookup(struct inode *dir, 
 					 struct dentry *dentry,
@@ -1404,7 +1446,6 @@ static struct dentry *proc_pident_lookup
 	struct dentry *error;
 	struct task_struct *task = get_proc_task(dir);
 	struct pid_entry *p;
-	struct proc_inode *ei;
 
 	error = ERR_PTR(-ENOENT);
 	inode = NULL;
@@ -1425,25 +1466,7 @@ static struct dentry *proc_pident_lookup
 	if (!p->name)
 		goto out;
 
-	error = ERR_PTR(-EINVAL);
-	inode = proc_pid_make_inode(dir->i_sb, task, p->type);
-	if (!inode)
-		goto out;
-
-	ei = PROC_I(inode);
-	inode->i_mode = p->mode;
-	if (S_ISDIR(inode->i_mode))
-		inode->i_nlink = 2;	/* Use getattr to fix if necessary */
-	if (p->iop)
-		inode->i_op = p->iop;
-	if (p->fop)
-		inode->i_fop = p->fop;
-	ei->op = p->op;
-	dentry->d_op = &pid_dentry_operations;
-	d_add(dentry, inode);
-	/* Close the race of the process dying before we return the dentry */
-	if (pid_revalidate(dentry, NULL))
-		error = NULL;
+	error = proc_pident_instantiate(dir, dentry, task, p);
 out:
 	put_task_struct(task);
 out_no_task:
@@ -1709,29 +1732,13 @@ static struct dentry_operations proc_bas
 	.d_delete	= pid_delete_dentry,
 };
 
-static struct dentry *proc_base_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *proc_base_instantiate(struct inode *dir,
+	struct dentry *dentry, struct task_struct *task, void *ptr)
 {
+	struct pid_entry *p = ptr;
 	struct inode *inode;
-	struct dentry *error;
-	struct task_struct *task = get_proc_task(dir);
-	struct pid_entry *p;
 	struct proc_inode *ei;
-
-	error = ERR_PTR(-ENOENT);
-	inode = NULL;
-
-	if (!task)
-		goto out_no_task;
-
-	/* Lookup the directory entry */
-	for (p = proc_base_stuff; p->name; p++) {
-		if (p->len != dentry->d_name.len)
-			continue;
-		if (!memcmp(dentry->d_name.name, p->name, p->len))
-			break;
-	}
-	if (!p->name)
-		goto out;
+	struct dentry *error = ERR_PTR(-EINVAL);
 
 	/* Allocate the inode */
 	error = ERR_PTR(-ENOMEM);
@@ -1767,14 +1774,41 @@ static struct dentry *proc_base_lookup(s
 	d_add(dentry, inode);
 	error = NULL;
 out:
-	put_task_struct(task);
-out_no_task:
 	return error;
 out_iput:
 	iput(inode);
 	goto out;
 }
 
+static struct dentry *proc_base_lookup(struct inode *dir, struct dentry *dentry)
+{
+	struct dentry *error;
+	struct task_struct *task = get_proc_task(dir);
+	struct pid_entry *p;
+
+	error = ERR_PTR(-ENOENT);
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
+	error = proc_base_instantiate(dir, dentry, task, p);
+
+out:
+	put_task_struct(task);
+out_no_task:
+	return error;
+}
+
 /*
  * Thread groups
  */
@@ -1915,12 +1949,40 @@ out:
 	return;
 }
 
+struct dentry *proc_pid_instantiate(struct inode *dir,
+	struct dentry * dentry, struct task_struct *task, void *ptr)
+{
+	struct dentry *error = ERR_PTR(-ENOENT);
+	struct inode *inode;
+
+	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TGID_INO);
+	if (!inode)
+		goto out;
+
+	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_op = &proc_tgid_base_inode_operations;
+	inode->i_fop = &proc_tgid_base_operations;
+	inode->i_flags|=S_IMMUTABLE;
+	inode->i_nlink = 4;
+#ifdef CONFIG_SECURITY
+	inode->i_nlink += 1;
+#endif
+
+	dentry->d_op = &pid_dentry_operations;
+
+	d_add(dentry, inode);
+	/* Close the race of the process dying before we return the dentry */
+	if (pid_revalidate(dentry, NULL))
+		error = NULL;
+out:
+	return error;
+}
+
 /* SMP-safe */
 struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
 {
 	struct dentry *result = ERR_PTR(-ENOENT);
 	struct task_struct *task;
-	struct inode *inode;
 	unsigned tgid;
 
 	result = proc_base_lookup(dir, dentry);
@@ -1939,28 +2001,7 @@ struct dentry *proc_pid_lookup(struct in
 	if (!task)
 		goto out;
 
-	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TGID_INO);
-	if (!inode)
-		goto out_put_task;
-
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
-	inode->i_op = &proc_tgid_base_inode_operations;
-	inode->i_fop = &proc_tgid_base_operations;
-	inode->i_flags|=S_IMMUTABLE;
-#ifdef CONFIG_SECURITY
-	inode->i_nlink = 5;
-#else
-	inode->i_nlink = 4;
-#endif
-
-	dentry->d_op = &pid_dentry_operations;
-
-	d_add(dentry, inode);
-	/* Close the race of the process dying before we return the dentry */
-	if (pid_revalidate(dentry, NULL))
-		result = NULL;
-
-out_put_task:
+	result = proc_pid_instantiate(dir, dentry, task, NULL);
 	put_task_struct(task);
 out:
 	return result;
@@ -2107,13 +2148,40 @@ static struct inode_operations proc_tid_
 	.setattr	= proc_setattr,
 };
 
+static struct dentry *proc_task_instantiate(struct inode *dir,
+	struct dentry *dentry, struct task_struct *task, void *ptr)
+{
+	struct dentry *error = ERR_PTR(-ENOENT);
+	struct inode *inode;
+	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TID_INO);
+
+	if (!inode)
+		goto out;
+	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_op = &proc_tid_base_inode_operations;
+	inode->i_fop = &proc_tid_base_operations;
+	inode->i_flags|=S_IMMUTABLE;
+	inode->i_nlink = 3;
+#ifdef CONFIG_SECURITY
+	inode->i_nlink += 1;
+#endif
+
+	dentry->d_op = &pid_dentry_operations;
+
+	d_add(dentry, inode);
+	/* Close the race of the process dying before we return the dentry */
+	if (pid_revalidate(dentry, NULL))
+		error = NULL;
+out:
+	return error;
+}
+
 /* SMP-safe */
 static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
 {
 	struct dentry *result = ERR_PTR(-ENOENT);
 	struct task_struct *task;
 	struct task_struct *leader = get_proc_task(dir);
-	struct inode *inode;
 	unsigned tid;
 
 	if (!leader)
@@ -2133,28 +2201,7 @@ static struct dentry *proc_task_lookup(s
 	if (leader->tgid != task->tgid)
 		goto out_drop_task;
 
-	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TID_INO);
-
-
-	if (!inode)
-		goto out_drop_task;
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
-	inode->i_op = &proc_tid_base_inode_operations;
-	inode->i_fop = &proc_tid_base_operations;
-	inode->i_flags|=S_IMMUTABLE;
-#ifdef CONFIG_SECURITY
-	inode->i_nlink = 4;
-#else
-	inode->i_nlink = 3;
-#endif
-
-	dentry->d_op = &pid_dentry_operations;
-
-	d_add(dentry, inode);
-	/* Close the race of the process dying before we return the dentry */
-	if (pid_revalidate(dentry, NULL))
-		result = NULL;
-
+	result = proc_task_instantiate(dir, dentry, task, NULL);
 out_drop_task:
 	put_task_struct(task);
 out:
-- 
1.4.2.rc3.g7e18e-dirty

