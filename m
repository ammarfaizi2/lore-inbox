Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWHOSG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWHOSG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWHOSG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:06:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33451 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030413AbWHOSGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:06:55 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 5/7] proc: Factor out an instantiate method from every lookup method.
Date: Tue, 15 Aug 2006 12:05:28 -0600
Message-Id: <1155665132678-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To remove the hard coded proc inode numbers it is necessary to be able
to create the proc inodes during readdir.  The instantiate methods are
the subset of lookup that is needed to accomplish that.

This first step just splits the lookup methods into 2 functions.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c |  214 +++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 125 insertions(+), 89 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 96e22d7..bb6a631 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1253,21 +1253,15 @@ static struct dentry_operations tid_fd_d
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
@@ -1276,7 +1270,7 @@ static struct dentry *proc_lookupfd(stru
 	ei->fd = fd;
 	files = get_files_struct(task);
 	if (!files)
-		goto out_unlock;
+		goto out_iput;
 	inode->i_mode = S_IFLNK;
 
 	/*
@@ -1286,13 +1280,14 @@ static struct dentry *proc_lookupfd(stru
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
@@ -1300,20 +1295,37 @@ static struct dentry *proc_lookupfd(stru
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
@@ -1394,6 +1406,36 @@ static struct inode_operations proc_fd_i
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
@@ -1403,7 +1445,6 @@ static struct dentry *proc_pident_lookup
 	struct dentry *error;
 	struct task_struct *task = get_proc_task(dir);
 	struct pid_entry *p;
-	struct proc_inode *ei;
 
 	error = ERR_PTR(-ENOENT);
 	inode = NULL;
@@ -1424,25 +1465,7 @@ static struct dentry *proc_pident_lookup
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
@@ -1819,12 +1842,40 @@ out:
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
 
 	result = proc_pident_lookup(dir, dentry, proc_base_stuff);
@@ -1843,28 +1894,7 @@ struct dentry *proc_pid_lookup(struct in
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
@@ -2046,13 +2076,40 @@ static struct inode_operations proc_tid_
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
@@ -2072,28 +2129,7 @@ static struct dentry *proc_task_lookup(s
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

