Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbWHOSGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbWHOSGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWHOSGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:06:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32427 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030428AbWHOSGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:06:30 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@dpweb.vendaregroup.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/7] proc: Reorder the functions in base.c
Date: Tue, 15 Aug 2006 12:05:24 -0600
Message-Id: <11556651302258-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmisison.com>

Group the functions by what they implement instead of
by type of operation.  As it existed base.c was quickly approaching
the point where it could not be followed.

No functionality or code changes asside from adding/removing
forward declartions are implemented in this patch.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c |  994 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 499 insertions(+), 495 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index fbc03b5..605ae9c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -199,147 +199,6 @@ struct pid_entry {
 
 #define E(type,name,mode) {(type),sizeof(name)-1,(name),(mode)}
 
-static struct pid_entry tgid_base_stuff[] = {
-	E(PROC_TGID_TASK,      "task",    S_IFDIR|S_IRUGO|S_IXUGO),
-	E(PROC_TGID_FD,        "fd",      S_IFDIR|S_IRUSR|S_IXUSR),
-	E(PROC_TGID_ENVIRON,   "environ", S_IFREG|S_IRUSR),
-	E(PROC_TGID_AUXV,      "auxv",	  S_IFREG|S_IRUSR),
-	E(PROC_TGID_STATUS,    "status",  S_IFREG|S_IRUGO),
-	E(PROC_TGID_CMDLINE,   "cmdline", S_IFREG|S_IRUGO),
-	E(PROC_TGID_STAT,      "stat",    S_IFREG|S_IRUGO),
-	E(PROC_TGID_STATM,     "statm",   S_IFREG|S_IRUGO),
-	E(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUGO),
-#ifdef CONFIG_NUMA
-	E(PROC_TGID_NUMA_MAPS, "numa_maps", S_IFREG|S_IRUGO),
-#endif
-	E(PROC_TGID_MEM,       "mem",     S_IFREG|S_IRUSR|S_IWUSR),
-#ifdef CONFIG_SECCOMP
-	E(PROC_TGID_SECCOMP,   "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
-#endif
-	E(PROC_TGID_CWD,       "cwd",     S_IFLNK|S_IRWXUGO),
-	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
-	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
-	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
-	E(PROC_TGID_MOUNTSTATS, "mountstats", S_IFREG|S_IRUSR),
-#ifdef CONFIG_MMU
-	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),
-#endif
-#ifdef CONFIG_SECURITY
-	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
-#endif
-#ifdef CONFIG_KALLSYMS
-	E(PROC_TGID_WCHAN,     "wchan",   S_IFREG|S_IRUGO),
-#endif
-#ifdef CONFIG_SCHEDSTATS
-	E(PROC_TGID_SCHEDSTAT, "schedstat", S_IFREG|S_IRUGO),
-#endif
-#ifdef CONFIG_CPUSETS
-	E(PROC_TGID_CPUSET,    "cpuset",  S_IFREG|S_IRUGO),
-#endif
-	E(PROC_TGID_OOM_SCORE, "oom_score",S_IFREG|S_IRUGO),
-	E(PROC_TGID_OOM_ADJUST,"oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
-#ifdef CONFIG_AUDITSYSCALL
-	E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
-#endif
-	{0,0,NULL,0}
-};
-static struct pid_entry tid_base_stuff[] = {
-	E(PROC_TID_FD,         "fd",      S_IFDIR|S_IRUSR|S_IXUSR),
-	E(PROC_TID_ENVIRON,    "environ", S_IFREG|S_IRUSR),
-	E(PROC_TID_AUXV,       "auxv",	  S_IFREG|S_IRUSR),
-	E(PROC_TID_STATUS,     "status",  S_IFREG|S_IRUGO),
-	E(PROC_TID_CMDLINE,    "cmdline", S_IFREG|S_IRUGO),
-	E(PROC_TID_STAT,       "stat",    S_IFREG|S_IRUGO),
-	E(PROC_TID_STATM,      "statm",   S_IFREG|S_IRUGO),
-	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUGO),
-#ifdef CONFIG_NUMA
-	E(PROC_TID_NUMA_MAPS,  "numa_maps",    S_IFREG|S_IRUGO),
-#endif
-	E(PROC_TID_MEM,        "mem",     S_IFREG|S_IRUSR|S_IWUSR),
-#ifdef CONFIG_SECCOMP
-	E(PROC_TID_SECCOMP,    "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
-#endif
-	E(PROC_TID_CWD,        "cwd",     S_IFLNK|S_IRWXUGO),
-	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
-	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
-	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
-#ifdef CONFIG_MMU
-	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
-#endif
-#ifdef CONFIG_SECURITY
-	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
-#endif
-#ifdef CONFIG_KALLSYMS
-	E(PROC_TID_WCHAN,      "wchan",   S_IFREG|S_IRUGO),
-#endif
-#ifdef CONFIG_SCHEDSTATS
-	E(PROC_TID_SCHEDSTAT, "schedstat",S_IFREG|S_IRUGO),
-#endif
-#ifdef CONFIG_CPUSETS
-	E(PROC_TID_CPUSET,     "cpuset",  S_IFREG|S_IRUGO),
-#endif
-	E(PROC_TID_OOM_SCORE,  "oom_score",S_IFREG|S_IRUGO),
-	E(PROC_TID_OOM_ADJUST, "oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
-#ifdef CONFIG_AUDITSYSCALL
-	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
-#endif
-	{0,0,NULL,0}
-};
-
-#ifdef CONFIG_SECURITY
-static struct pid_entry tgid_attr_stuff[] = {
-	E(PROC_TGID_ATTR_CURRENT,  "current",  S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TGID_ATTR_PREV,     "prev",     S_IFREG|S_IRUGO),
-	E(PROC_TGID_ATTR_EXEC,     "exec",     S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TGID_ATTR_FSCREATE, "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TGID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TGID_ATTR_SOCKCREATE, "sockcreate", S_IFREG|S_IRUGO|S_IWUGO),
-	{0,0,NULL,0}
-};
-static struct pid_entry tid_attr_stuff[] = {
-	E(PROC_TID_ATTR_CURRENT,   "current",  S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TID_ATTR_PREV,      "prev",     S_IFREG|S_IRUGO),
-	E(PROC_TID_ATTR_EXEC,      "exec",     S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TID_ATTR_SOCKCREATE, "sockcreate", S_IFREG|S_IRUGO|S_IWUGO),
-	{0,0,NULL,0}
-};
-#endif
-
-#undef E
-
-static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
-{
-	struct task_struct *task = get_proc_task(inode);
-	struct files_struct *files = NULL;
-	struct file *file;
-	int fd = proc_fd(inode);
-
-	if (task) {
-		files = get_files_struct(task);
-		put_task_struct(task);
-	}
-	if (files) {
-		/*
-		 * We are not taking a ref to the file structure, so we must
-		 * hold ->file_lock.
-		 */
-		spin_lock(&files->file_lock);
-		file = fcheck_files(files, fd);
-		if (file) {
-			*mnt = mntget(file->f_vfsmnt);
-			*dentry = dget(file->f_dentry);
-			spin_unlock(&files->file_lock);
-			put_files_struct(files);
-			return 0;
-		}
-		spin_unlock(&files->file_lock);
-		put_files_struct(files);
-	}
-	return -ENOENT;
-}
-
 static struct fs_struct *get_fs_struct(struct task_struct *task)
 {
 	struct fs_struct *fs;
@@ -1137,143 +996,6 @@ static struct inode_operations proc_pid_
 	.setattr	= proc_setattr,
 };
 
-static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
-{
-	struct dentry *dentry = filp->f_dentry;
-	struct inode *inode = dentry->d_inode;
-	struct task_struct *p = get_proc_task(inode);
-	unsigned int fd, tid, ino;
-	int retval;
-	char buf[PROC_NUMBUF];
-	struct files_struct * files;
-	struct fdtable *fdt;
-
-	retval = -ENOENT;
-	if (!p)
-		goto out_no_task;
-	retval = 0;
-	tid = p->pid;
-
-	fd = filp->f_pos;
-	switch (fd) {
-		case 0:
-			if (filldir(dirent, ".", 1, 0, inode->i_ino, DT_DIR) < 0)
-				goto out;
-			filp->f_pos++;
-		case 1:
-			ino = parent_ino(dentry);
-			if (filldir(dirent, "..", 2, 1, ino, DT_DIR) < 0)
-				goto out;
-			filp->f_pos++;
-		default:
-			files = get_files_struct(p);
-			if (!files)
-				goto out;
-			rcu_read_lock();
-			fdt = files_fdtable(files);
-			for (fd = filp->f_pos-2;
-			     fd < fdt->max_fds;
-			     fd++, filp->f_pos++) {
-				unsigned int i,j;
-
-				if (!fcheck_files(files, fd))
-					continue;
-				rcu_read_unlock();
-
-				j = PROC_NUMBUF;
-				i = fd;
-				do {
-					j--;
-					buf[j] = '0' + (i % 10);
-					i /= 10;
-				} while (i);
-
-				ino = fake_ino(tid, PROC_TID_FD_DIR + fd);
-				if (filldir(dirent, buf+j, PROC_NUMBUF-j, fd+2, ino, DT_LNK) < 0) {
-					rcu_read_lock();
-					break;
-				}
-				rcu_read_lock();
-			}
-			rcu_read_unlock();
-			put_files_struct(files);
-	}
-out:
-	put_task_struct(p);
-out_no_task:
-	return retval;
-}
-
-static int proc_pident_readdir(struct file *filp,
-		void *dirent, filldir_t filldir,
-		struct pid_entry *ents, unsigned int nents)
-{
-	int i;
-	int pid;
-	struct dentry *dentry = filp->f_dentry;
-	struct inode *inode = dentry->d_inode;
-	struct task_struct *task = get_proc_task(inode);
-	struct pid_entry *p;
-	ino_t ino;
-	int ret;
-
-	ret = -ENOENT;
-	if (!task)
-		goto out;
-
-	ret = 0;
-	pid = task->pid;
-	put_task_struct(task);
-	i = filp->f_pos;
-	switch (i) {
-	case 0:
-		ino = inode->i_ino;
-		if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0)
-			goto out;
-		i++;
-		filp->f_pos++;
-		/* fall through */
-	case 1:
-		ino = parent_ino(dentry);
-		if (filldir(dirent, "..", 2, i, ino, DT_DIR) < 0)
-			goto out;
-		i++;
-		filp->f_pos++;
-		/* fall through */
-	default:
-		i -= 2;
-		if (i >= nents) {
-			ret = 1;
-			goto out;
-		}
-		p = ents + i;
-		while (p->name) {
-			if (filldir(dirent, p->name, p->len, filp->f_pos,
-				    fake_ino(pid, p->type), p->mode >> 12) < 0)
-				goto out;
-			filp->f_pos++;
-			p++;
-		}
-	}
-
-	ret = 1;
-out:
-	return ret;
-}
-
-static int proc_tgid_base_readdir(struct file * filp,
-			     void * dirent, filldir_t filldir)
-{
-	return proc_pident_readdir(filp,dirent,filldir,
-				   tgid_base_stuff,ARRAY_SIZE(tgid_base_stuff));
-}
-
-static int proc_tid_base_readdir(struct file * filp,
-			     void * dirent, filldir_t filldir)
-{
-	return proc_pident_readdir(filp,dirent,filldir,
-				   tid_base_stuff,ARRAY_SIZE(tid_base_stuff));
-}
 
 /* building an inode */
 
@@ -1333,6 +1055,27 @@ out_unlock:
 	return NULL;
 }
 
+static int pid_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
+{
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *task;
+	generic_fillattr(inode, stat);
+
+	rcu_read_lock();
+	stat->uid = 0;
+	stat->gid = 0;
+	task = pid_task(proc_pid(inode), PIDTYPE_PID);
+	if (task) {
+		if ((inode->i_mode == (S_IFDIR|S_IRUGO|S_IXUGO)) ||
+		    task_dumpable(task)) {
+			stat->uid = task->euid;
+			stat->gid = task->egid;
+		}
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
 /* dentry stuff */
 
 /*
@@ -1372,25 +1115,74 @@ static int pid_revalidate(struct dentry 
 	return 0;
 }
 
-static int pid_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
+static int pid_delete_dentry(struct dentry * dentry)
 {
-	struct inode *inode = dentry->d_inode;
-	struct task_struct *task;
-	generic_fillattr(inode, stat);
+	/* Is the task we represent dead?
+	 * If so, then don't put the dentry on the lru list,
+	 * kill it immediately.
+	 */
+	return !proc_pid(dentry->d_inode)->tasks[PIDTYPE_PID].first;
+}
+
+static struct dentry_operations pid_dentry_operations =
+{
+	.d_revalidate	= pid_revalidate,
+	.d_delete	= pid_delete_dentry,
+};
+
+/* Lookups */
+
+static unsigned name_to_int(struct dentry *dentry)
+{
+	const char *name = dentry->d_name.name;
+	int len = dentry->d_name.len;
+	unsigned n = 0;
+
+	if (len > 1 && *name == '0')
+		goto out;
+	while (len-- > 0) {
+		unsigned c = *name++ - '0';
+		if (c > 9)
+			goto out;
+		if (n >= (~0U-9)/10)
+			goto out;
+		n *= 10;
+		n += c;
+	}
+	return n;
+out:
+	return ~0U;
+}
+
+static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
+{
+	struct task_struct *task = get_proc_task(inode);
+	struct files_struct *files = NULL;
+	struct file *file;
+	int fd = proc_fd(inode);
 
-	rcu_read_lock();
-	stat->uid = 0;
-	stat->gid = 0;
-	task = pid_task(proc_pid(inode), PIDTYPE_PID);
 	if (task) {
-		if ((inode->i_mode == (S_IFDIR|S_IRUGO|S_IXUGO)) ||
-		    task_dumpable(task)) {
-			stat->uid = task->euid;
-			stat->gid = task->egid;
+		files = get_files_struct(task);
+		put_task_struct(task);
+	}
+	if (files) {
+		/*
+		 * We are not taking a ref to the file structure, so we must
+		 * hold ->file_lock.
+		 */
+		spin_lock(&files->file_lock);
+		file = fcheck_files(files, fd);
+		if (file) {
+			*mnt = mntget(file->f_vfsmnt);
+			*dentry = dget(file->f_dentry);
+			spin_unlock(&files->file_lock);
+			put_files_struct(files);
+			return 0;
 		}
+		spin_unlock(&files->file_lock);
+		put_files_struct(files);
 	}
-	rcu_read_unlock();
-	return 0;
+	return -ENOENT;
 }
 
 static int tid_fd_revalidate(struct dentry *dentry, struct nameidata *nd)
@@ -1428,51 +1220,12 @@ static int tid_fd_revalidate(struct dent
 	return 0;
 }
 
-static int pid_delete_dentry(struct dentry * dentry)
-{
-	/* Is the task we represent dead?
-	 * If so, then don't put the dentry on the lru list,
-	 * kill it immediately.
-	 */
-	return !proc_pid(dentry->d_inode)->tasks[PIDTYPE_PID].first;
-}
-
 static struct dentry_operations tid_fd_dentry_operations =
 {
 	.d_revalidate	= tid_fd_revalidate,
 	.d_delete	= pid_delete_dentry,
 };
 
-static struct dentry_operations pid_dentry_operations =
-{
-	.d_revalidate	= pid_revalidate,
-	.d_delete	= pid_delete_dentry,
-};
-
-/* Lookups */
-
-static unsigned name_to_int(struct dentry *dentry)
-{
-	const char *name = dentry->d_name.name;
-	int len = dentry->d_name.len;
-	unsigned n = 0;
-
-	if (len > 1 && *name == '0')
-		goto out;
-	while (len-- > 0) {
-		unsigned c = *name++ - '0';
-		if (c > 9)
-			goto out;
-		if (n >= (~0U-9)/10)
-			goto out;
-		n *= 10;
-		n += c;
-	}
-	return n;
-out:
-	return ~0U;
-}
-
 /* SMP-safe */
 static struct dentry *proc_lookupfd(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
 {
@@ -1534,20 +1287,78 @@ out_unlock:
 	goto out;
 }
 
-static int proc_task_readdir(struct file * filp, void * dirent, filldir_t filldir);
-static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd);
-static int proc_task_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat);
+static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
+{
+	struct dentry *dentry = filp->f_dentry;
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *p = get_proc_task(inode);
+	unsigned int fd, tid, ino;
+	int retval;
+	char buf[PROC_NUMBUF];
+	struct files_struct * files;
+	struct fdtable *fdt;
+
+	retval = -ENOENT;
+	if (!p)
+		goto out_no_task;
+	retval = 0;
+	tid = p->pid;
+
+	fd = filp->f_pos;
+	switch (fd) {
+		case 0:
+			if (filldir(dirent, ".", 1, 0, inode->i_ino, DT_DIR) < 0)
+				goto out;
+			filp->f_pos++;
+		case 1:
+			ino = parent_ino(dentry);
+			if (filldir(dirent, "..", 2, 1, ino, DT_DIR) < 0)
+				goto out;
+			filp->f_pos++;
+		default:
+			files = get_files_struct(p);
+			if (!files)
+				goto out;
+			rcu_read_lock();
+			fdt = files_fdtable(files);
+			for (fd = filp->f_pos-2;
+			     fd < fdt->max_fds;
+			     fd++, filp->f_pos++) {
+				unsigned int i,j;
+
+				if (!fcheck_files(files, fd))
+					continue;
+				rcu_read_unlock();
+
+				j = PROC_NUMBUF;
+				i = fd;
+				do {
+					j--;
+					buf[j] = '0' + (i % 10);
+					i /= 10;
+				} while (i);
+
+				ino = fake_ino(tid, PROC_TID_FD_DIR + fd);
+				if (filldir(dirent, buf+j, PROC_NUMBUF-j, fd+2, ino, DT_LNK) < 0) {
+					rcu_read_lock();
+					break;
+				}
+				rcu_read_lock();
+			}
+			rcu_read_unlock();
+			put_files_struct(files);
+	}
+out:
+	put_task_struct(p);
+out_no_task:
+	return retval;
+}
 
 static struct file_operations proc_fd_operations = {
 	.read		= generic_read_dir,
 	.readdir	= proc_readfd,
 };
 
-static struct file_operations proc_task_operations = {
-	.read		= generic_read_dir,
-	.readdir	= proc_task_readdir,
-};
-
 /*
  * proc directories can do almost nothing..
  */
@@ -1556,87 +1367,11 @@ static struct inode_operations proc_fd_i
 	.setattr	= proc_setattr,
 };
 
-static struct inode_operations proc_task_inode_operations = {
-	.lookup		= proc_task_lookup,
-	.getattr	= proc_task_getattr,
-	.setattr	= proc_setattr,
-};
+static struct file_operations proc_task_operations;
+static struct inode_operations proc_task_inode_operations;
 
 #ifdef CONFIG_SECURITY
-static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
-				  size_t count, loff_t *ppos)
-{
-	struct inode * inode = file->f_dentry->d_inode;
-	unsigned long page;
-	ssize_t length;
-	struct task_struct *task = get_proc_task(inode);
-
-	length = -ESRCH;
-	if (!task)
-		goto out_no_task;
-
-	if (count > PAGE_SIZE)
-		count = PAGE_SIZE;
-	length = -ENOMEM;
-	if (!(page = __get_free_page(GFP_KERNEL)))
-		goto out;
-
-	length = security_getprocattr(task, 
-				      (char*)file->f_dentry->d_name.name, 
-				      (void*)page, count);
-	if (length >= 0)
-		length = simple_read_from_buffer(buf, count, ppos, (char *)page, length);
-	free_page(page);
-out:
-	put_task_struct(task);
-out_no_task:
-	return length;
-}
-
-static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
-				   size_t count, loff_t *ppos)
-{ 
-	struct inode * inode = file->f_dentry->d_inode;
-	char *page; 
-	ssize_t length; 
-	struct task_struct *task = get_proc_task(inode);
-
-	length = -ESRCH;
-	if (!task)
-		goto out_no_task;
-	if (count > PAGE_SIZE) 
-		count = PAGE_SIZE; 
-
-	/* No partial writes. */
-	length = -EINVAL;
-	if (*ppos != 0)
-		goto out;
-
-	length = -ENOMEM;
-	page = (char*)__get_free_page(GFP_USER); 
-	if (!page) 
-		goto out;
-
-	length = -EFAULT; 
-	if (copy_from_user(page, buf, count)) 
-		goto out_free;
-
-	length = security_setprocattr(task, 
-				      (char*)file->f_dentry->d_name.name, 
-				      (void*)page, count);
-out_free:
-	free_page((unsigned long) page);
-out:
-	put_task_struct(task);
-out_no_task:
-	return length;
-} 
-
-static struct file_operations proc_pid_attr_operations = {
-	.read		= proc_pid_attr_read,
-	.write		= proc_pid_attr_write,
-};
-
+static struct file_operations proc_pid_attr_operations;
 static struct file_operations proc_tid_attr_operations;
 static struct inode_operations proc_tid_attr_inode_operations;
 static struct file_operations proc_tgid_attr_operations;
@@ -1852,37 +1587,157 @@ out_no_task:
 	return error;
 }
 
-static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd){
-	return proc_pident_lookup(dir, dentry, tgid_base_stuff);
+static int proc_pident_readdir(struct file *filp,
+		void *dirent, filldir_t filldir,
+		struct pid_entry *ents, unsigned int nents)
+{
+	int i;
+	int pid;
+	struct dentry *dentry = filp->f_dentry;
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *task = get_proc_task(inode);
+	struct pid_entry *p;
+	ino_t ino;
+	int ret;
+
+	ret = -ENOENT;
+	if (!task)
+		goto out;
+
+	ret = 0;
+	pid = task->pid;
+	put_task_struct(task);
+	i = filp->f_pos;
+	switch (i) {
+	case 0:
+		ino = inode->i_ino;
+		if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0)
+			goto out;
+		i++;
+		filp->f_pos++;
+		/* fall through */
+	case 1:
+		ino = parent_ino(dentry);
+		if (filldir(dirent, "..", 2, i, ino, DT_DIR) < 0)
+			goto out;
+		i++;
+		filp->f_pos++;
+		/* fall through */
+	default:
+		i -= 2;
+		if (i >= nents) {
+			ret = 1;
+			goto out;
+		}
+		p = ents + i;
+		while (p->name) {
+			if (filldir(dirent, p->name, p->len, filp->f_pos,
+				    fake_ino(pid, p->type), p->mode >> 12) < 0)
+				goto out;
+			filp->f_pos++;
+			p++;
+		}
+	}
+
+	ret = 1;
+out:
+	return ret;
 }
 
-static struct dentry *proc_tid_base_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd){
-	return proc_pident_lookup(dir, dentry, tid_base_stuff);
+#ifdef CONFIG_SECURITY
+static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
+				  size_t count, loff_t *ppos)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+	unsigned long page;
+	ssize_t length;
+	struct task_struct *task = get_proc_task(inode);
+
+	length = -ESRCH;
+	if (!task)
+		goto out_no_task;
+
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+	length = -ENOMEM;
+	if (!(page = __get_free_page(GFP_KERNEL)))
+		goto out;
+
+	length = security_getprocattr(task,
+				      (char*)file->f_dentry->d_name.name,
+				      (void*)page, count);
+	if (length >= 0)
+		length = simple_read_from_buffer(buf, count, ppos, (char *)page, length);
+	free_page(page);
+out:
+	put_task_struct(task);
+out_no_task:
+	return length;
 }
 
-static struct file_operations proc_tgid_base_operations = {
-	.read		= generic_read_dir,
-	.readdir	= proc_tgid_base_readdir,
-};
+static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
+				   size_t count, loff_t *ppos)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+	char *page;
+	ssize_t length;
+	struct task_struct *task = get_proc_task(inode);
 
-static struct file_operations proc_tid_base_operations = {
-	.read		= generic_read_dir,
-	.readdir	= proc_tid_base_readdir,
-};
+	length = -ESRCH;
+	if (!task)
+		goto out_no_task;
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
 
-static struct inode_operations proc_tgid_base_inode_operations = {
-	.lookup		= proc_tgid_base_lookup,
-	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+	/* No partial writes. */
+	length = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	length = -ENOMEM;
+	page = (char*)__get_free_page(GFP_USER);
+	if (!page)
+		goto out;
+
+	length = -EFAULT;
+	if (copy_from_user(page, buf, count))
+		goto out_free;
+
+	length = security_setprocattr(task,
+				      (char*)file->f_dentry->d_name.name,
+				      (void*)page, count);
+out_free:
+	free_page((unsigned long) page);
+out:
+	put_task_struct(task);
+out_no_task:
+	return length;
+}
+
+static struct file_operations proc_pid_attr_operations = {
+	.read		= proc_pid_attr_read,
+	.write		= proc_pid_attr_write,
 };
 
-static struct inode_operations proc_tid_base_inode_operations = {
-	.lookup		= proc_tid_base_lookup,
-	.getattr	= pid_getattr,
-	.setattr	= proc_setattr,
+static struct pid_entry tgid_attr_stuff[] = {
+	E(PROC_TGID_ATTR_CURRENT,  "current",  S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_PREV,     "prev",     S_IFREG|S_IRUGO),
+	E(PROC_TGID_ATTR_EXEC,     "exec",     S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_FSCREATE, "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_SOCKCREATE, "sockcreate", S_IFREG|S_IRUGO|S_IWUGO),
+	{0,0,NULL,0}
+};
+static struct pid_entry tid_attr_stuff[] = {
+	E(PROC_TID_ATTR_CURRENT,   "current",  S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_PREV,      "prev",     S_IFREG|S_IRUGO),
+	E(PROC_TID_ATTR_EXEC,      "exec",     S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_SOCKCREATE, "sockcreate", S_IFREG|S_IRUGO|S_IWUGO),
+	{0,0,NULL,0}
 };
 
-#ifdef CONFIG_SECURITY
 static int proc_tgid_attr_readdir(struct file * filp,
 			     void * dirent, filldir_t filldir)
 {
@@ -1955,6 +1810,76 @@ static struct inode_operations proc_self
 	.follow_link	= proc_self_follow_link,
 };
 
+/*
+ * Thread groups
+ */
+static struct pid_entry tgid_base_stuff[] = {
+	E(PROC_TGID_TASK,      "task",    S_IFDIR|S_IRUGO|S_IXUGO),
+	E(PROC_TGID_FD,        "fd",      S_IFDIR|S_IRUSR|S_IXUSR),
+	E(PROC_TGID_ENVIRON,   "environ", S_IFREG|S_IRUSR),
+	E(PROC_TGID_AUXV,      "auxv",	  S_IFREG|S_IRUSR),
+	E(PROC_TGID_STATUS,    "status",  S_IFREG|S_IRUGO),
+	E(PROC_TGID_CMDLINE,   "cmdline", S_IFREG|S_IRUGO),
+	E(PROC_TGID_STAT,      "stat",    S_IFREG|S_IRUGO),
+	E(PROC_TGID_STATM,     "statm",   S_IFREG|S_IRUGO),
+	E(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUGO),
+#ifdef CONFIG_NUMA
+	E(PROC_TGID_NUMA_MAPS, "numa_maps", S_IFREG|S_IRUGO),
+#endif
+	E(PROC_TGID_MEM,       "mem",     S_IFREG|S_IRUSR|S_IWUSR),
+#ifdef CONFIG_SECCOMP
+	E(PROC_TGID_SECCOMP,   "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
+#endif
+	E(PROC_TGID_CWD,       "cwd",     S_IFLNK|S_IRWXUGO),
+	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
+	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
+	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TGID_MOUNTSTATS, "mountstats", S_IFREG|S_IRUSR),
+#ifdef CONFIG_MMU
+	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),
+#endif
+#ifdef CONFIG_SECURITY
+	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
+#endif
+#ifdef CONFIG_KALLSYMS
+	E(PROC_TGID_WCHAN,     "wchan",   S_IFREG|S_IRUGO),
+#endif
+#ifdef CONFIG_SCHEDSTATS
+	E(PROC_TGID_SCHEDSTAT, "schedstat", S_IFREG|S_IRUGO),
+#endif
+#ifdef CONFIG_CPUSETS
+	E(PROC_TGID_CPUSET,    "cpuset",  S_IFREG|S_IRUGO),
+#endif
+	E(PROC_TGID_OOM_SCORE, "oom_score",S_IFREG|S_IRUGO),
+	E(PROC_TGID_OOM_ADJUST,"oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
+#ifdef CONFIG_AUDITSYSCALL
+	E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
+#endif
+	{0,0,NULL,0}
+};
+
+static int proc_tgid_base_readdir(struct file * filp,
+			     void * dirent, filldir_t filldir)
+{
+	return proc_pident_readdir(filp,dirent,filldir,
+				   tgid_base_stuff,ARRAY_SIZE(tgid_base_stuff));
+}
+
+static struct file_operations proc_tgid_base_operations = {
+	.read		= generic_read_dir,
+	.readdir	= proc_tgid_base_readdir,
+};
+
+static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd){
+	return proc_pident_lookup(dir, dentry, tgid_base_stuff);
+}
+
+static struct inode_operations proc_tgid_base_inode_operations = {
+	.lookup		= proc_tgid_base_lookup,
+	.getattr	= pid_getattr,
+	.setattr	= proc_setattr,
+};
+
 /**
  * proc_flush_task -  Remove dcache entries for @task from the /proc dcache.
  *
@@ -2085,62 +2010,6 @@ out:
 	return result;
 }
 
-/* SMP-safe */
-static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
-{
-	struct dentry *result = ERR_PTR(-ENOENT);
-	struct task_struct *task;
-	struct task_struct *leader = get_proc_task(dir);
-	struct inode *inode;
-	unsigned tid;
-
-	if (!leader)
-		goto out_no_task;
-
-	tid = name_to_int(dentry);
-	if (tid == ~0U)
-		goto out;
-
-	rcu_read_lock();
-	task = find_task_by_pid(tid);
-	if (task)
-		get_task_struct(task);
-	rcu_read_unlock();
-	if (!task)
-		goto out;
-	if (leader->tgid != task->tgid)
-		goto out_drop_task;
-
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
-out_drop_task:
-	put_task_struct(task);
-out:
-	put_task_struct(leader);
-out_no_task:
-	return result;
-}
-
 /*
  * Find the first tgid to return to user space.
  *
@@ -2250,6 +2119,130 @@ int proc_pid_readdir(struct file * filp,
 }
 
 /*
+ * Tasks
+ */
+static struct pid_entry tid_base_stuff[] = {
+	E(PROC_TID_FD,         "fd",      S_IFDIR|S_IRUSR|S_IXUSR),
+	E(PROC_TID_ENVIRON,    "environ", S_IFREG|S_IRUSR),
+	E(PROC_TID_AUXV,       "auxv",	  S_IFREG|S_IRUSR),
+	E(PROC_TID_STATUS,     "status",  S_IFREG|S_IRUGO),
+	E(PROC_TID_CMDLINE,    "cmdline", S_IFREG|S_IRUGO),
+	E(PROC_TID_STAT,       "stat",    S_IFREG|S_IRUGO),
+	E(PROC_TID_STATM,      "statm",   S_IFREG|S_IRUGO),
+	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUGO),
+#ifdef CONFIG_NUMA
+	E(PROC_TID_NUMA_MAPS,  "numa_maps",    S_IFREG|S_IRUGO),
+#endif
+	E(PROC_TID_MEM,        "mem",     S_IFREG|S_IRUSR|S_IWUSR),
+#ifdef CONFIG_SECCOMP
+	E(PROC_TID_SECCOMP,    "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
+#endif
+	E(PROC_TID_CWD,        "cwd",     S_IFLNK|S_IRWXUGO),
+	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
+	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
+	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
+#ifdef CONFIG_MMU
+	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
+#endif
+#ifdef CONFIG_SECURITY
+	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
+#endif
+#ifdef CONFIG_KALLSYMS
+	E(PROC_TID_WCHAN,      "wchan",   S_IFREG|S_IRUGO),
+#endif
+#ifdef CONFIG_SCHEDSTATS
+	E(PROC_TID_SCHEDSTAT, "schedstat",S_IFREG|S_IRUGO),
+#endif
+#ifdef CONFIG_CPUSETS
+	E(PROC_TID_CPUSET,     "cpuset",  S_IFREG|S_IRUGO),
+#endif
+	E(PROC_TID_OOM_SCORE,  "oom_score",S_IFREG|S_IRUGO),
+	E(PROC_TID_OOM_ADJUST, "oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
+#ifdef CONFIG_AUDITSYSCALL
+	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
+#endif
+	{0,0,NULL,0}
+};
+
+static int proc_tid_base_readdir(struct file * filp,
+			     void * dirent, filldir_t filldir)
+{
+	return proc_pident_readdir(filp,dirent,filldir,
+				   tid_base_stuff,ARRAY_SIZE(tid_base_stuff));
+}
+
+static struct dentry *proc_tid_base_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd){
+	return proc_pident_lookup(dir, dentry, tid_base_stuff);
+}
+
+static struct file_operations proc_tid_base_operations = {
+	.read		= generic_read_dir,
+	.readdir	= proc_tid_base_readdir,
+};
+
+static struct inode_operations proc_tid_base_inode_operations = {
+	.lookup		= proc_tid_base_lookup,
+	.getattr	= pid_getattr,
+	.setattr	= proc_setattr,
+};
+
+/* SMP-safe */
+static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
+{
+	struct dentry *result = ERR_PTR(-ENOENT);
+	struct task_struct *task;
+	struct task_struct *leader = get_proc_task(dir);
+	struct inode *inode;
+	unsigned tid;
+
+	if (!leader)
+		goto out_no_task;
+
+	tid = name_to_int(dentry);
+	if (tid == ~0U)
+		goto out;
+
+	rcu_read_lock();
+	task = find_task_by_pid(tid);
+	if (task)
+		get_task_struct(task);
+	rcu_read_unlock();
+	if (!task)
+		goto out;
+	if (leader->tgid != task->tgid)
+		goto out_drop_task;
+
+	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TID_INO);
+
+
+	if (!inode)
+		goto out_drop_task;
+	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_op = &proc_tid_base_inode_operations;
+	inode->i_fop = &proc_tid_base_operations;
+	inode->i_flags|=S_IMMUTABLE;
+#ifdef CONFIG_SECURITY
+	inode->i_nlink = 4;
+#else
+	inode->i_nlink = 3;
+#endif
+
+	dentry->d_op = &pid_dentry_operations;
+
+	d_add(dentry, inode);
+	/* Close the race of the process dying before we return the dentry */
+	if (pid_revalidate(dentry, NULL))
+		result = NULL;
+
+out_drop_task:
+	put_task_struct(task);
+out:
+	put_task_struct(leader);
+out_no_task:
+	return result;
+}
+
+/*
  * Find the first tid of a thread group to return to user space.
  *
  * Usually this is just the thread group leader, but if the users
@@ -2392,3 +2385,14 @@ static int proc_task_getattr(struct vfsm
 
 	return 0;
 }
+
+static struct inode_operations proc_task_inode_operations = {
+	.lookup		= proc_task_lookup,
+	.getattr	= proc_task_getattr,
+	.setattr	= proc_setattr,
+};
+
+static struct file_operations proc_task_operations = {
+	.read		= generic_read_dir,
+	.readdir	= proc_task_readdir,
+};
-- 
1.4.2.rc3.g7e18e-dirty

