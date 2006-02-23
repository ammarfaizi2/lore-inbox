Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWBWQcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWBWQcA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWBWQcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:32:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33687 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751746AbWBWQb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:31:58 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 21/23] proc: Factor out an instantiate method from every
 lookup method.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j7mhxs0.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biahxpd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0aqgiyv.fsf_-_@ebiederm.dsl.xmission.com>
	<m1pslegiwg.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkw2giue.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd6qgirv.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5heginy.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xs2gikb.fsf_-_@ebiederm.dsl.xmission.com>
	<m14q2qgigc.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zmkif3t8.fsf_-_@ebiederm.dsl.xmission.com>
	<m1vev6f3q3.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r75uf3mc.fsf_-_@ebiederm.dsl.xmission.com>
	<m1mzgif3ik.fsf_-_@ebiederm.dsl.xmission.com>
	<m1irr6f3h3.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ek1uf3eq.fsf_-_@ebiederm.dsl.xmission.com>
	<m1accif3bx.fsf_-_@ebiederm.dsl.xmission.com>
	<m164n6f39h.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:30:48 -0700
In-Reply-To: <m164n6f39h.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:28:42 -0700")
Message-ID: <m11wxuf35z.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To remove the hard coded proc inode numbers it is necessary to be able
to create the proc inodes during readdir, so that inode numbers reported
but readdir and stat stay in sync.  The instantiate methods are the
subset of lookup that is needed to accomplish that.

This first step just splits the lookup methods into 2 functions.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |  212 +++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 125 insertions(+), 87 deletions(-)

572832049c16973d7a8201eaaf2eb514210d943d
diff --git a/fs/proc/base.c b/fs/proc/base.c
index a6bff2f..5dfc754 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1191,21 +1191,15 @@ static struct dentry_operations tid_fd_d
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
+	int fd = *(int *)ptr;
+	struct file *file;
+	struct files_struct *files;
 	struct inode *inode;
 	struct proc_inode *ei;
-
-	if (!task)
-		goto out_no_task;
-	if (fd == ~0U)
-		goto out;
+	struct dentry *error = ERR_PTR(-ENOENT);
 
 	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TID_FD_DIR+fd);
 	if (!inode)
@@ -1214,18 +1208,19 @@ static struct dentry *proc_lookupfd(stru
 	ei->fd = fd;
 	files = get_files_struct(task);
 	if (!files)
-		goto out_unlock;
+		goto out_iput;
 	inode->i_mode = S_IFLNK;
 	rcu_read_lock();
 	file = fcheck_files(files, fd);
 	if (!file)
-		goto out_unlock2;
+		goto out_unlock;
 	if (file->f_mode & 1)
 		inode->i_mode |= S_IRUSR | S_IXUSR;
 	if (file->f_mode & 2)
 		inode->i_mode |= S_IWUSR | S_IXUSR;
 	rcu_read_unlock();
 	put_files_struct(files);
+
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
 	ei->op.proc_get_link = proc_fd_link;
@@ -1233,18 +1228,36 @@ static struct dentry *proc_lookupfd(stru
 	d_add(dentry, inode);
 	/* Close the race of the process dying before we return the dentry */
 	if (tid_fd_revalidate(dentry, NULL))
-		result = NULL;
+		error = NULL;
 out:
-	put_task_struct(task);
-out_no_task:
-	return result;
-
-out_unlock2:
+	return error;
+out_unlock:
 	rcu_read_unlock();
 	put_files_struct(files);
-out_unlock:
+out_iput:
 	iput(inode);
 	goto out;
+	
+
+	
+}
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
 }
 
 static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
@@ -1326,6 +1339,36 @@ static struct inode_operations proc_fd_i
 	.lookup		= proc_lookupfd,
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
@@ -1335,7 +1378,6 @@ static struct dentry *proc_pident_lookup
 	struct dentry *error;
 	struct task_struct *task = get_proc_task(dir);
 	struct pid_entry *p;
-	struct proc_inode *ei;
 
 	error = ERR_PTR(-ENOENT);
 	inode = NULL;
@@ -1356,25 +1398,7 @@ static struct dentry *proc_pident_lookup
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
@@ -1747,12 +1771,40 @@ out:
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
@@ -1771,28 +1823,7 @@ struct dentry *proc_pid_lookup(struct in
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
@@ -1981,13 +2012,41 @@ static struct inode_operations proc_tid_
 	.lookup		= proc_tid_base_lookup,
 };
 
+
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
@@ -2007,28 +2066,7 @@ static struct dentry *proc_task_lookup(s
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
1.2.2.g709a

