Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751691AbWBWQY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWBWQY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWBWQYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:24:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23703 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751630AbWBWQYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:24:24 -0500
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH 16/23] proc: Don't lock task_structs indefinitely.
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:23:15 -0700
In-Reply-To: <m1r75uf3mc.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:20:59 -0700")
Message-ID: <m1mzgif3ik.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Every inode in /proc holds a reference to a struct task_struct.
If a directory or file is opened and remains open after the
the task exits this pinning continues.  With 8K stacks on a
32bit machine the amount pinned per file descriptor is about 10K.

Normally I would figure a reasonable per user process limit is about
100 processes.  With 80 processes, with a 1000 file descriptors each
I can trigger the 00M killer on a 32bit kernel, because I have
pinned about 800MB of useless data.

This patch replaces the struct task_struct pointer with a pointer
to a struct task_ref which has a struct task_struct pointer.  The
difference is that the task_ref is updated when a task is removed,
so the pinning of dead tasks does not happen.

The code now has to contend with the fact that the task may now
exit at any time.  Which is a little but not much more complicated.

With this change it takes about 600 processes each opening up
1000 file descriptors before I can trigger the OOM killer.  Much
better.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c          |  268 ++++++++++++++++++++++++++++++++---------------
 fs/proc/inode.c         |    9 +-
 fs/proc/internal.h      |   15 ++-
 fs/proc/task_mmu.c      |   63 +++++++----
 include/linux/proc_fs.h |    8 +
 mm/mempolicy.c          |    6 +
 6 files changed, 252 insertions(+), 117 deletions(-)

eefe36bb6eeb5d815f702a3e1ecd3b026cd2d9d7
diff --git a/fs/proc/base.c b/fs/proc/base.c
index f507887..86aa5c5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -300,11 +300,15 @@ static struct pid_entry tid_attr_stuff[]
 
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
-	struct task_struct *task = proc_task(inode);
-	struct files_struct *files;
+	struct task_struct *task = get_proc_task(inode);
+	struct files_struct *files = NULL;
 	struct file *file;
 	int fd = proc_fd(inode);
 
+	if (task) {
+		files = get_files_struct(task);
+		put_task_struct(task);
+	}
 	files = get_files_struct(task);
 	if (files) {
 		rcu_read_lock();
@@ -335,8 +339,14 @@ static struct fs_struct *get_fs_struct(s
 
 static int proc_cwd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
-	struct fs_struct *fs = get_fs_struct(proc_task(inode));
+	struct task_struct *task = get_proc_task(inode);
+	struct fs_struct *fs = NULL;
 	int result = -ENOENT;
+
+	if (task) {
+		fs = get_fs_struct(task);
+		put_task_struct(task);
+	}
 	if (fs) {
 		read_lock(&fs->lock);
 		*mnt = mntget(fs->pwdmnt);
@@ -350,8 +360,14 @@ static int proc_cwd_link(struct inode *i
 
 static int proc_root_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
-	struct fs_struct *fs = get_fs_struct(proc_task(inode));
+	struct task_struct *task = get_proc_task(inode);
+	struct fs_struct *fs = NULL;
 	int result = -ENOENT;
+
+	if (task) {
+		fs = get_fs_struct(task);
+		put_task_struct(task);
+	}
 	if (fs) {
 		read_lock(&fs->lock);
 		*mnt = mntget(fs->rootmnt);
@@ -500,16 +516,19 @@ struct proc_mounts {
 
 static int mounts_open(struct inode *inode, struct file *file)
 {
-	struct task_struct *task = proc_task(inode);
-	struct namespace *namespace;
+	struct task_struct *task = get_proc_task(inode);
+	struct namespace *namespace = NULL;
 	struct proc_mounts *p;
 	int ret = -EINVAL;
 
-	task_lock(task);
-	namespace = task->namespace;
-	if (namespace)
-		get_namespace(namespace);
-	task_unlock(task);
+	if (task) {
+		task_lock(task);
+		namespace = task->namespace;
+		if (namespace)
+			get_namespace(namespace);
+		task_unlock(task);
+		put_task_struct(task);
+	}
 
 	if (namespace) {
 		ret = -ENOMEM;
@@ -571,18 +590,27 @@ static ssize_t proc_info_read(struct fil
 	struct inode * inode = file->f_dentry->d_inode;
 	unsigned long page;
 	ssize_t length;
-	struct task_struct *task = proc_task(inode);
+	struct task_struct *task = get_proc_task(inode);
+
+	length = -ESRCH;
+	if (!task)
+		goto out_no_task;
 
 	if (count > PROC_BLOCK_SIZE)
 		count = PROC_BLOCK_SIZE;
-	if (!(page = __get_free_page(GFP_KERNEL)))
-		return -ENOMEM;
 
+	length = -ENOMEM;
+	if (!(page = __get_free_page(GFP_KERNEL)))
+		goto out;
+	
 	length = PROC_I(inode)->op.proc_read(task, (char*)page);
-
+	
 	if (length >= 0)
 		length = simple_read_from_buffer(buf, count, ppos, (char *)page, length);
 	free_page(page);
+out:
+	put_task_struct(task);
+out_no_task:
 	return length;
 }
 
@@ -599,7 +627,7 @@ static int mem_open(struct inode* inode,
 static ssize_t mem_read(struct file * file, char __user * buf,
 			size_t count, loff_t *ppos)
 {
-	struct task_struct *task = proc_task(file->f_dentry->d_inode);
+	struct task_struct *task = get_proc_task(file->f_dentry->d_inode);
 	char *page;
 	unsigned long src = *ppos;
 	int ret = -ESRCH;
@@ -666,15 +694,20 @@ static ssize_t mem_write(struct file * f
 {
 	int copied = 0;
 	char *page;
-	struct task_struct *task = proc_task(file->f_dentry->d_inode);
+	struct task_struct *task = get_proc_task(file->f_dentry->d_inode);
 	unsigned long dst = *ppos;
 
+	copied = -ESRCH;
+	if (!task)
+		goto out_no_task;
+
 	if (!MAY_PTRACE(task) || !ptrace_may_attach(task))
-		return -ESRCH;
+		goto out;
 
+	copied = -ENOMEM;
 	page = (char *)__get_free_page(GFP_USER);
 	if (!page)
-		return -ENOMEM;
+		goto out;
 
 	while (count > 0) {
 		int this_len, retval;
@@ -697,6 +730,9 @@ static ssize_t mem_write(struct file * f
 	}
 	*ppos = dst;
 	free_page((unsigned long) page);
+out:
+	put_task_struct(task);
+out_no_task:
 	return copied;
 }
 #endif
@@ -727,12 +763,17 @@ static struct file_operations proc_mem_o
 static ssize_t oom_adjust_read(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	struct task_struct *task = proc_task(file->f_dentry->d_inode);
+	struct task_struct *task = get_proc_task(file->f_dentry->d_inode);
 	char buffer[PROC_NUMBUF];
 	size_t len;
-	int oom_adjust = task->oomkilladj;
+	int oom_adjust;
 	loff_t __ppos = *ppos;
 
+	if (!task)
+		return -ESRCH;
+	oom_adjust = task->oomkilladj;
+	put_task_struct(task);
+
 	len = snprintf(buffer, sizeof(buffer), "%i\n", oom_adjust);
 	if (__ppos >= len)
 		return 0;
@@ -747,7 +788,7 @@ static ssize_t oom_adjust_read(struct fi
 static ssize_t oom_adjust_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	struct task_struct *task = proc_task(file->f_dentry->d_inode);
+	struct task_struct *task;
 	char buffer[PROC_NUMBUF], *end;
 	int oom_adjust;
 
@@ -763,7 +804,11 @@ static ssize_t oom_adjust_write(struct f
 		return -EINVAL;
 	if (*end == '\n')
 		end++;
+	task = get_proc_task(file->f_dentry->d_inode);
+	if (!task)
+		return -ESRCH;
 	task->oomkilladj = oom_adjust;
+	put_task_struct(task);
 	if (end - buffer == 0)
 		return -EIO;
 	return end - buffer;
@@ -780,12 +825,15 @@ static ssize_t proc_loginuid_read(struct
 				  size_t count, loff_t *ppos)
 {
 	struct inode * inode = file->f_dentry->d_inode;
-	struct task_struct *task = proc_task(inode);
+	struct task_struct *task = get_proc_task(inode);
 	ssize_t length;
 	char tmpbuf[TMPBUFLEN];
 
+	if (!task)
+		return -ESRCH;
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
 				audit_get_loginuid(task->audit_context));
+	put_task_struct(task);
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
@@ -795,13 +843,12 @@ static ssize_t proc_loginuid_write(struc
 	struct inode * inode = file->f_dentry->d_inode;
 	char *page, *tmp;
 	ssize_t length;
-	struct task_struct *task = proc_task(inode);
 	uid_t loginuid;
 
 	if (!capable(CAP_AUDIT_CONTROL))
 		return -EPERM;
 
-	if (current != task)
+	if (current != proc_tref(inode)->task)
 		return -EPERM;
 
 	if (count > PAGE_SIZE)
@@ -824,7 +871,7 @@ static ssize_t proc_loginuid_write(struc
 		goto out_free_page;
 
 	}
-	length = audit_set_loginuid(task, loginuid);
+	length = audit_set_loginuid(current, loginuid);
 	if (likely(length == 0))
 		length = count;
 
@@ -843,13 +890,16 @@ static struct file_operations proc_login
 static ssize_t seccomp_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *ppos)
 {
-	struct task_struct *tsk = proc_task(file->f_dentry->d_inode);
+	struct task_struct *tsk = get_proc_task(file->f_dentry->d_inode);
 	char __buf[20];
 	loff_t __ppos = *ppos;
 	size_t len;
 
+	if (!tsk)
+		return -ESRCH;
 	/* no need to print the trailing zero, so use only len */
 	len = sprintf(__buf, "%u\n", tsk->seccomp.mode);
+	put_task_struct(tsk);
 	if (__ppos >= len)
 		return 0;
 	if (count > len - __ppos)
@@ -863,13 +913,19 @@ static ssize_t seccomp_read(struct file 
 static ssize_t seccomp_write(struct file *file, const char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	struct task_struct *tsk = proc_task(file->f_dentry->d_inode);
+	struct task_struct *tsk = get_proc_task(file->f_dentry->d_inode);
 	char __buf[20], *end;
 	unsigned int seccomp_mode;
+	ssize_t result;
+
+	result = -ESRCH;
+	if (!tsk)
+		goto out_no_task;
 
 	/* can set it only once to be even more secure */
+	result = -EPERM;
 	if (unlikely(tsk->seccomp.mode))
-		return -EPERM;
+		goto out;
 
 	memset(__buf, 0, sizeof(__buf));
 	count = min(count, sizeof(__buf) - 1);
@@ -878,14 +934,20 @@ static ssize_t seccomp_write(struct file
 	seccomp_mode = simple_strtoul(__buf, &end, 0);
 	if (*end == '\n')
 		end++;
+	result = -EINVAL;
 	if (seccomp_mode && seccomp_mode <= NR_SECCOMP_MODES) {
 		tsk->seccomp.mode = seccomp_mode;
 		set_tsk_thread_flag(tsk, TIF_SECCOMP);
 	} else
-		return -EINVAL;
+		goto out;
+	result = -EIO;
 	if (unlikely(!(end - __buf)))
-		return -EIO;
-	return end - __buf;
+		goto out;
+	result = end - __buf;
+out:
+	put_task_struct(tsk);
+out_no_task:
+	return result;
 }
 
 static struct file_operations proc_seccomp_operations = {
@@ -914,7 +976,7 @@ static int proc_check_dentry_visible(str
 	/* See if the the two tasks share a commone set of 
 	 * file descriptors.  If so everything is visible.
 	 */
-	task = proc_task(inode);
+	task = get_proc_task(inode);
 	if (!task)
 		goto out;
 	files = get_files_struct(current);
@@ -925,6 +987,7 @@ static int proc_check_dentry_visible(str
 		put_files_struct(task_files);
 	if (files)
 		put_files_struct(files);
+	put_task_struct(task);
 	if (!error)
 		goto out;
 
@@ -1044,7 +1107,7 @@ static int proc_readfd(struct file * fil
 {
 	struct dentry *dentry = filp->f_dentry;
 	struct inode *inode = dentry->d_inode;
-	struct task_struct *p = proc_task(inode);
+	struct task_struct *p = get_proc_task(inode);
 	unsigned int fd, tid, ino;
 	int retval;
 	char buf[PROC_NUMBUF];
@@ -1052,8 +1115,8 @@ static int proc_readfd(struct file * fil
 	struct fdtable *fdt;
 
 	retval = -ENOENT;
-	if (!pid_alive(p))
-		goto out;
+	if (!p)
+		goto out_no_task;
 	retval = 0;
 	tid = p->pid;
 
@@ -1102,6 +1165,8 @@ static int proc_readfd(struct file * fil
 			put_files_struct(files);
 	}
 out:
+	put_task_struct(p);
+out_no_task:
 	return retval;
 }
 
@@ -1113,16 +1178,18 @@ static int proc_pident_readdir(struct fi
 	int pid;
 	struct dentry *dentry = filp->f_dentry;
 	struct inode *inode = dentry->d_inode;
+	struct task_struct *task = get_proc_task(inode);
 	struct pid_entry *p;
 	ino_t ino;
 	int ret;
 
 	ret = -ENOENT;
-	if (!pid_alive(proc_task(inode)))
+	if (!task)
 		goto out;
 
 	ret = 0;
-	pid = proc_task(inode)->pid;
+	pid = task->pid;
+	put_task_struct(task);
 	i = filp->f_pos;
 	switch (i) {
 	case 0:
@@ -1208,14 +1275,13 @@ static struct inode *proc_pid_make_inode
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_ino = fake_ino(task->pid, ino);
 
-	if (!pid_alive(task))
-		goto out_unlock;
-
 	/*
 	 * grab the reference to task.
 	 */
-	get_task_struct(task);
-	ei->task = task;
+	tref_set(&ei->tref, tref_get_by_task(task, PIDTYPE_PID));
+	if (!ei->tref->task)
+		goto out_unlock;
+
 	inode->i_uid = 0;
 	inode->i_gid = 0;
 	if (task_dumpable(task)) {
@@ -1245,8 +1311,8 @@ out_unlock:
 static int pid_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
-	struct task_struct *task = proc_task(inode);
-	if (pid_alive(task)) {
+	struct task_struct *task = get_proc_task(inode);
+	if (task) {
 		if (task_dumpable(task)) {
 			inode->i_uid = task->euid;
 			inode->i_gid = task->egid;
@@ -1255,6 +1321,7 @@ static int pid_revalidate(struct dentry 
 			inode->i_gid = 0;
 		}
 		security_task_to_inode(task, inode);
+		put_task_struct(task);
 		return 1;
 	}
 	d_drop(dentry);
@@ -1264,28 +1331,31 @@ static int pid_revalidate(struct dentry 
 static int tid_fd_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
-	struct task_struct *task = proc_task(inode);
+	struct task_struct *task = get_proc_task(inode);
 	int fd = proc_fd(inode);
 	struct files_struct *files;
 
-	files = get_files_struct(task);
-	if (files) {
-		rcu_read_lock();
-		if (fcheck_files(files, fd)) {
+	if (task) {
+		files = get_files_struct(task);
+		if (files) {
+			rcu_read_lock();
+			if (fcheck_files(files, fd)) {
+				rcu_read_unlock();
+				put_files_struct(files);
+				if (task_dumpable(task)) {
+					inode->i_uid = task->euid;
+					inode->i_gid = task->egid;
+				} else {
+					inode->i_uid = 0;
+					inode->i_gid = 0;
+				}
+				security_task_to_inode(task, inode);
+				return 1;
+			}
 			rcu_read_unlock();
 			put_files_struct(files);
-			if (task_dumpable(task)) {
-				inode->i_uid = task->euid;
-				inode->i_gid = task->egid;
-			} else {
-				inode->i_uid = 0;
-				inode->i_gid = 0;
-			}
-			security_task_to_inode(task, inode);
-			return 1;
 		}
-		rcu_read_unlock();
-		put_files_struct(files);
+		put_task_struct(task);
 	}
 	d_drop(dentry);
 	return 0;
@@ -1297,7 +1367,7 @@ static int pid_delete_dentry(struct dent
 	 * If so, then don't put the dentry on the lru list,
 	 * kill it immediately.
 	 */
-	return !pid_alive(proc_task(dentry->d_inode));
+	return !proc_tref(dentry->d_inode)->task;
 }
 
 static struct dentry_operations tid_fd_dentry_operations =
@@ -1339,7 +1409,7 @@ out:
 /* SMP-safe */
 static struct dentry *proc_lookupfd(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
 {
-	struct task_struct *task = proc_task(dir);
+	struct task_struct *task = get_proc_task(dir);
 	unsigned fd = name_to_int(dentry);
 	struct dentry *result = ERR_PTR(-ENOENT);
 	struct file * file;
@@ -1347,10 +1417,10 @@ static struct dentry *proc_lookupfd(stru
 	struct inode *inode;
 	struct proc_inode *ei;
 
+	if (!task)
+		goto out_no_task;
 	if (fd == ~0U)
 		goto out;
-	if (!pid_alive(task))
-		goto out;
 
 	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TID_FD_DIR+fd);
 	if (!inode)
@@ -1380,6 +1450,8 @@ static struct dentry *proc_lookupfd(stru
 	if (tid_fd_revalidate(dentry, NULL))
 		result = NULL;
 out:
+	put_task_struct(task);
+out_no_task:
 	return result;
 
 out_unlock2:
@@ -1423,12 +1495,17 @@ static ssize_t proc_pid_attr_read(struct
 	struct inode * inode = file->f_dentry->d_inode;
 	unsigned long page;
 	ssize_t length;
-	struct task_struct *task = proc_task(inode);
+	struct task_struct *task = get_proc_task(inode);
+
+	length = -ESRCH;
+	if (!task)
+		goto out_no_task;
 
 	if (count > PAGE_SIZE)
 		count = PAGE_SIZE;
+	length = -ENOMEM;
 	if (!(page = __get_free_page(GFP_KERNEL)))
-		return -ENOMEM;
+		goto out;
 
 	length = security_getprocattr(task, 
 				      (char*)file->f_dentry->d_name.name, 
@@ -1436,6 +1513,9 @@ static ssize_t proc_pid_attr_read(struct
 	if (length >= 0)
 		length = simple_read_from_buffer(buf, count, ppos, (char *)page, length);
 	free_page(page);
+out:
+	put_task_struct(task);
+out_no_task:
 	return length;
 }
 
@@ -1445,26 +1525,36 @@ static ssize_t proc_pid_attr_write(struc
 	struct inode * inode = file->f_dentry->d_inode;
 	char *page; 
 	ssize_t length; 
-	struct task_struct *task = proc_task(inode); 
+	struct task_struct *task = get_proc_task(inode); 
 
+	length = -ESRCH;
+	if (!task)
+		goto out_no_task;
 	if (count > PAGE_SIZE) 
 		count = PAGE_SIZE; 
-	if (*ppos != 0) {
-		/* No partial writes. */
-		return -EINVAL;
-	}
+
+	/* No partial writes. */
+	length = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	length = -ENOMEM;
 	page = (char*)__get_free_page(GFP_USER); 
 	if (!page) 
-		return -ENOMEM;
+		goto out;
+
 	length = -EFAULT; 
 	if (copy_from_user(page, buf, count)) 
-		goto out;
+		goto out_free;
 
 	length = security_setprocattr(task, 
 				      (char*)file->f_dentry->d_name.name, 
 				      (void*)page, count);
-out:
+out_free:
 	free_page((unsigned long) page);
+out:
+	put_task_struct(task);
+out_no_task:
 	return length;
 } 
 
@@ -1486,15 +1576,15 @@ static struct dentry *proc_pident_lookup
 {
 	struct inode *inode;
 	struct dentry *error;
-	struct task_struct *task = proc_task(dir);
+	struct task_struct *task = get_proc_task(dir);
 	struct pid_entry *p;
 	struct proc_inode *ei;
 
 	error = ERR_PTR(-ENOENT);
 	inode = NULL;
 
-	if (!pid_alive(task))
-		goto out;
+	if (!task)
+		goto out_no_task;
 
 	for (p = ents; p->name; p++) {
 		if (p->len != dentry->d_name.len)
@@ -1675,6 +1765,8 @@ static struct dentry *proc_pident_lookup
 	if (pid_revalidate(dentry, NULL))
 		error = NULL;
 out:
+	put_task_struct(task);
+out_no_task:
 	return error;
 }
 
@@ -1916,10 +2008,13 @@ static struct dentry *proc_task_lookup(s
 {
 	struct dentry *result = ERR_PTR(-ENOENT);
 	struct task_struct *task;
-	struct task_struct *leader = proc_task(dir);
+	struct task_struct *leader = get_proc_task(dir);
 	struct inode *inode;
 	unsigned tid;
 
+	if (!leader)
+		goto out_no_task;
+
 	tid = name_to_int(dentry);
 	if (tid == ~0U)
 		goto out;
@@ -1959,6 +2054,8 @@ static struct dentry *proc_task_lookup(s
 out_drop_task:
 	put_task_struct(task);
 out:
+	put_task_struct(leader);
+out_no_task:
 	return result;
 }
 
@@ -2161,15 +2258,15 @@ static int proc_task_readdir(struct file
 	char buf[PROC_NUMBUF];
 	struct dentry *dentry = filp->f_dentry;
 	struct inode *inode = dentry->d_inode;
-	struct task_struct *leader = proc_task(inode);
+	struct task_struct *leader = get_proc_task(inode);
 	struct task_struct *task;
 	int retval = -ENOENT;
 	ino_t ino;
 	int tid;
 	unsigned long pos = filp->f_pos;  /* avoiding "long long" filp->f_pos */
 
-	if (!pid_alive(leader))
-		goto out;
+	if (!leader)
+		goto out_no_task;
 	retval = 0;
 
 	switch (pos) {
@@ -2209,20 +2306,23 @@ static int proc_task_readdir(struct file
 	}
 out:
 	filp->f_pos = pos;
+	put_task_struct(leader);
+out_no_task:
 	return retval;
 }
 
 static int proc_task_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
 {
 	struct inode *inode = dentry->d_inode;
-	struct task_struct *p = proc_task(inode);
+	struct task_struct *p = get_proc_task(inode);
 	generic_fillattr(inode, stat);
 
-	if (pid_alive(p)) {
+	if (p) {
 		task_lock(p);
 		if (p->signal)
 			stat->nlink += atomic_read(&p->signal->count);
 		task_unlock(p);
+		put_task_struct(p);
 	}
 		
 	return 0;
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 8f532d7..95c3cc5 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -58,14 +58,11 @@ static void de_put(struct proc_dir_entry
 static void proc_delete_inode(struct inode *inode)
 {
 	struct proc_dir_entry *de;
-	struct task_struct *tsk;
 
 	truncate_inode_pages(&inode->i_data, 0);
 
-	/* Let go of any associated process */
-	tsk = PROC_I(inode)->task;
-	if (tsk)
-		put_task_struct(tsk);
+	/* Stop tracking associated processes */
+	tref_fini(&PROC_I(inode)->tref);
 
 	/* Let go of any associated proc directory entry */
 	de = PROC_I(inode)->pde;
@@ -94,7 +91,7 @@ static struct inode *proc_alloc_inode(st
 	ei = (struct proc_inode *)kmem_cache_alloc(proc_inode_cachep, SLAB_KERNEL);
 	if (!ei)
 		return NULL;
-	ei->task = NULL;
+	tref_init(&ei->tref);
 	ei->fd = 0;
 	ei->op.proc_get_link = NULL;
 	ei->pde = NULL;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index ac95bfc..73b6384 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -10,6 +10,7 @@
  */
 
 #include <linux/proc_fs.h>
+#include <linux/task_ref.h>
 
 struct vmalloc_info {
 	unsigned long	used;
@@ -41,13 +42,23 @@ extern struct file_operations proc_maps_
 extern struct file_operations proc_numa_maps_operations;
 extern struct file_operations proc_smaps_operations;
 
+extern struct file_operations proc_maps_operations;
+extern struct file_operations proc_numa_maps_operations;
+extern struct file_operations proc_smaps_operations;
+
+
 void free_proc_entry(struct proc_dir_entry *de);
 
 int proc_init_inodecache(void);
 
-static inline struct task_struct *proc_task(struct inode *inode)
+static inline struct task_ref *proc_tref(struct inode *inode)
+{
+	return PROC_I(inode)->tref;
+}
+
+static inline struct task_struct *get_proc_task(struct inode *inode)
 {
-	return PROC_I(inode)->task;
+	return get_tref_task(proc_tref(inode));
 }
 
 static inline int proc_fd(struct inode *inode)
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 56cd932..4772543 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -75,9 +75,13 @@ int proc_exe_link(struct inode *inode, s
 {
 	struct vm_area_struct * vma;
 	int result = -ENOENT;
-	struct task_struct *task = proc_task(inode);
-	struct mm_struct * mm = get_task_mm(task);
+	struct task_struct *task = get_proc_task(inode);
+	struct mm_struct * mm = NULL;
 
+	if (task) {
+		mm = get_task_mm(task);
+		put_task_struct(task);
+	}
 	if (!mm)
 		goto out;
 	down_read(&mm->mmap_sem);
@@ -296,12 +300,16 @@ static int show_smap(struct seq_file *m,
 
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
-	struct task_struct *task = m->private;
+	struct proc_maps_private *priv = m->private; 
 	unsigned long last_addr = m->version;
 	struct mm_struct *mm;
-	struct vm_area_struct *vma, *tail_vma;
+	struct vm_area_struct *vma;
 	loff_t l = *pos;
 
+	/* Clear the per syscall fields in priv */
+	priv->task = NULL;
+	priv->tail_vma = NULL;
+
 	/*
 	 * We remember last_addr rather than next_addr to hit with
 	 * mmap_cache most of the time. We have zero last_addr at
@@ -312,11 +320,15 @@ static void *m_start(struct seq_file *m,
 	if (last_addr == -1UL)
 		return NULL;
 
-	mm = get_task_mm(task);
+	priv->task = get_tref_task(priv->tref);
+	if (!priv->task)
+		return NULL;
+
+	mm = get_task_mm(priv->task);
 	if (!mm)
 		return NULL;
 
-	tail_vma = get_gate_vma(task);
+	priv->tail_vma = get_gate_vma(priv->task);
 	down_read(&mm->mmap_sem);
 
 	/* Start with last addr hint */
@@ -338,35 +350,37 @@ static void *m_start(struct seq_file *m,
 	}
 
 	if (l != mm->map_count)
-		tail_vma = NULL; /* After gate vma */
+		priv->tail_vma = NULL; /* After gate vma */
 
 out:
 	if (vma)
 		return vma;
 
 	/* End of vmas has been reached */
-	m->version = (tail_vma != NULL)? 0: -1UL;
+	m->version = (priv->tail_vma != NULL)? 0: -1UL;
 	up_read(&mm->mmap_sem);
 	mmput(mm);
-	return tail_vma;
+	return priv->tail_vma;
 }
 
 static void m_stop(struct seq_file *m, void *v)
 {
-	struct task_struct *task = m->private;
+	struct proc_maps_private *priv = m->private;
 	struct vm_area_struct *vma = v;
-	if (vma && vma != get_gate_vma(task)) {
+	if (vma && vma != priv->tail_vma) {
 		struct mm_struct *mm = vma->vm_mm;
 		up_read(&mm->mmap_sem);
 		mmput(mm);
 	}
+	if (priv->task)
+		put_task_struct(priv->task);
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct task_struct *task = m->private;
+	struct proc_maps_private *priv = m->private;
 	struct vm_area_struct *vma = v;
-	struct vm_area_struct *tail_vma = get_gate_vma(task);
+	struct vm_area_struct *tail_vma = priv->tail_vma;
 
 	(*pos)++;
 	if (vma && (vma != tail_vma) && vma->vm_next)
@@ -392,11 +406,18 @@ static struct seq_operations proc_pid_sm
 static int do_maps_open(struct inode *inode, struct file *file, 
 			struct seq_operations *ops)
 {
-	struct task_struct *task = proc_task(inode);
-	int ret = seq_open(file, ops);
-	if (!ret) {
-		struct seq_file *m = file->private_data;
-		m->private = task;
+	struct proc_maps_private *priv;
+	int ret = -ENOMEM;
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (priv) {
+		priv->tref = proc_tref(inode);
+		ret = seq_open(file, ops);
+		if (!ret) {
+			struct seq_file *m = file->private_data;
+			m->private = priv;
+		} else {
+			kfree(priv);
+		}
 	}
 	return ret;
 }
@@ -410,7 +431,7 @@ struct file_operations proc_maps_operati
 	.open		= maps_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release,
+	.release	= seq_release_private,
 };
 
 #ifdef CONFIG_NUMA
@@ -432,7 +453,7 @@ struct file_operations proc_numa_maps_op
 	.open		= numa_maps_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release,
+	.release	= seq_release_private,
 };
 #endif
 
@@ -445,5 +466,5 @@ struct file_operations proc_smaps_operat
 	.open		= smaps_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release,
+	.release	= seq_release_private,
 };
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 302c24e..f6b491f 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -244,7 +244,7 @@ extern void kclist_add(struct kcore_list
 #endif
 
 struct proc_inode {
-	struct task_struct *task;
+	struct task_ref *tref;
 	int fd;
 	union {
 		int (*proc_get_link)(struct inode *, struct dentry **, struct vfsmount **);
@@ -264,4 +264,10 @@ static inline struct proc_dir_entry *PDE
 	return PROC_I(inode)->pde;
 }
 
+struct proc_maps_private {
+	struct task_ref *tref;
+	struct task_struct *task;
+	struct vm_area_struct *tail_vma;
+};
+
 #endif /* _LINUX_PROC_FS_H */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 880831b..3eed61c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1765,7 +1765,7 @@ static void gather_stats(struct page *pa
 
 int show_numa_map(struct seq_file *m, void *v)
 {
-	struct task_struct *task = m->private;
+	struct proc_maps_private *priv = m->private;
 	struct vm_area_struct *vma = v;
 	struct numa_maps *md;
 	int n;
@@ -1783,7 +1783,7 @@ int show_numa_map(struct seq_file *m, vo
 
 	if (md->pages) {
 		mpol_to_str(buffer, sizeof(buffer),
-			    get_vma_policy(task, vma, vma->vm_start));
+			    get_vma_policy(priv->task, vma, vma->vm_start));
 
 		seq_printf(m, "%08lx %s pages=%lu mapped=%lu maxref=%lu",
 			   vma->vm_start, buffer, md->pages,
@@ -1801,7 +1801,7 @@ int show_numa_map(struct seq_file *m, vo
 	kfree(md);
 
 	if (m->count < m->size)
-		m->version = (vma != get_gate_vma(task)) ? vma->vm_start : 0;
+		m->version = (vma != priv->tail_vma) ? vma->vm_start : 0;
 	return 0;
 }
 
-- 
1.2.2.g709a

