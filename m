Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751708AbWBWQ0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbWBWQ0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbWBWQ0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:26:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26775 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751708AbWBWQ0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:26:47 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 18/23] proc: Reorder the functions in base.c
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:25:33 -0700
In-Reply-To: <m1irr6f3h3.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:24:08 -0700")
Message-ID: <m1ek1uf3eq.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Group the functions by what they implement instead of
by type of operation.  As it existed base.c was quickly approaching
the point where it could not be followed.

No functionality or code changes asside from adding/removing
forward declartions are implemented in this patch.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c | 1062 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 533 insertions(+), 529 deletions(-)

1f2a8bf86e95c6c85808dfc18d75b1412290bef1
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 86aa5c5..71edbad 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -193,139 +193,6 @@ struct pid_entry {
 
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
-	{0,0,NULL,0}
-};
-static struct pid_entry tid_attr_stuff[] = {
-	E(PROC_TID_ATTR_CURRENT,   "current",  S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TID_ATTR_PREV,      "prev",     S_IFREG|S_IRUGO),
-	E(PROC_TID_ATTR_EXEC,      "exec",     S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
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
-	files = get_files_struct(task);
-	if (files) {
-		rcu_read_lock();
-		file = fcheck_files(files, fd);
-		if (file) {
-			*mnt = mntget(file->f_vfsmnt);
-			*dentry = dget(file->f_dentry);
-			rcu_read_unlock();
-			put_files_struct(files);
-			return 0;
-		}
-		rcu_read_unlock();
-		put_files_struct(files);
-	}
-	return -ENOENT;
-}
-
 static struct fs_struct *get_fs_struct(struct task_struct *task)
 {
 	struct fs_struct *fs;
@@ -1103,229 +970,158 @@ static struct inode_operations proc_pid_
 	.follow_link	= proc_pid_follow_link
 };
 
-static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
+/* building an inode */
+
+static int task_dumpable(struct task_struct *task)
 {
-	struct dentry *dentry = filp->f_dentry;
-	struct inode *inode = dentry->d_inode;
-	struct task_struct *p = get_proc_task(inode);
-	unsigned int fd, tid, ino;
-	int retval;
-	char buf[PROC_NUMBUF];
-	struct files_struct * files;
-	struct fdtable *fdt;
+	int dumpable = 0;
+	struct mm_struct *mm;
 
-	retval = -ENOENT;
-	if (!p)
-		goto out_no_task;
-	retval = 0;
-	tid = p->pid;
+	task_lock(task);
+	mm = task->mm;
+	if (mm)
+		dumpable = mm->dumpable;
+	task_unlock(task);
+	if(dumpable == 1)
+		return 1;
+	return 0;
+}
 
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
 
-				if (!fcheck_files(files, fd))
-					continue;
-				rcu_read_unlock();
+static struct inode *proc_pid_make_inode(struct super_block * sb, struct task_struct *task, int ino)
+{
+	struct inode * inode;
+	struct proc_inode *ei;
 
-				j = PROC_NUMBUF;
-				i = fd;
-				do {
-					j--;
-					buf[j] = '0' + (i % 10);
-					i /= 10;
-				} while (i);
+	/* We need a new inode */
+	
+	inode = new_inode(sb);
+	if (!inode)
+		goto out;
 
-				ino = fake_ino(tid, PROC_TID_FD_DIR + fd);
-				if (filldir(dirent, buf+j, PROC_NUMBUF-j, fd+2, ino, DT_LNK) < 0) {
-					rcu_read_lock();
-					break;
-				}
-				rcu_read_lock();
-			}
-			rcu_read_unlock();
-			put_files_struct(files);
+	/* Common stuff */
+	ei = PROC_I(inode);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_ino = fake_ino(task->pid, ino);
+
+	/*
+	 * grab the reference to task.
+	 */
+	tref_set(&ei->tref, tref_get_by_task(task, PIDTYPE_PID));
+	if (!ei->tref->task)
+		goto out_unlock;
+
+	inode->i_uid = 0;
+	inode->i_gid = 0;
+	if (task_dumpable(task)) {
+		inode->i_uid = task->euid;
+		inode->i_gid = task->egid;
 	}
+	security_task_to_inode(task, inode);
+
 out:
-	put_task_struct(p);
-out_no_task:
-	return retval;
+	return inode;
+
+out_unlock:
+	iput(inode);
+	return NULL;
 }
 
-static int proc_pident_readdir(struct file *filp,
-		void *dirent, filldir_t filldir,
-		struct pid_entry *ents, unsigned int nents)
+/* dentry stuff */
+
+/*
+ *	Exceptional case: normally we are not allowed to unhash a busy
+ * directory. In this case, however, we can do it - no aliasing problems
+ * due to the way we treat inodes.
+ *
+ * Rewrite the inode's ownerships here because the owning task may have
+ * performed a setuid(), etc.
+ */
+static int pid_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
-	int i;
-	int pid;
-	struct dentry *dentry = filp->f_dentry;
 	struct inode *inode = dentry->d_inode;
 	struct task_struct *task = get_proc_task(inode);
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
+	if (task) {
+		if (task_dumpable(task)) {
+			inode->i_uid = task->euid;
+			inode->i_gid = task->egid;
+		} else {
+			inode->i_uid = 0;
+			inode->i_gid = 0;
 		}
+		security_task_to_inode(task, inode);
+		put_task_struct(task);
+		return 1;
 	}
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
+	d_drop(dentry);
+	return 0;
 }
 
-static int proc_tid_base_readdir(struct file * filp,
-			     void * dirent, filldir_t filldir)
+static int pid_delete_dentry(struct dentry * dentry)
 {
-	return proc_pident_readdir(filp,dirent,filldir,
-				   tid_base_stuff,ARRAY_SIZE(tid_base_stuff));
+	/* Is the task we represent dead?
+	 * If so, then don't put the dentry on the lru list,
+	 * kill it immediately.
+	 */
+	return !proc_tref(dentry->d_inode)->task;
 }
 
-/* building an inode */
-
-static int task_dumpable(struct task_struct *task)
+static struct dentry_operations pid_dentry_operations =
 {
-	int dumpable = 0;
-	struct mm_struct *mm;
-
-	task_lock(task);
-	mm = task->mm;
-	if (mm)
-		dumpable = mm->dumpable;
-	task_unlock(task);
-	if(dumpable == 1)
-		return 1;
-	return 0;
-}
+	.d_revalidate	= pid_revalidate,
+	.d_delete	= pid_delete_dentry,
+};
 
+/* Lookups */
 
-static struct inode *proc_pid_make_inode(struct super_block * sb, struct task_struct *task, int ino)
+static unsigned name_to_int(struct dentry *dentry)
 {
-	struct inode * inode;
-	struct proc_inode *ei;
+	const char *name = dentry->d_name.name;
+	int len = dentry->d_name.len;
+	unsigned n = 0;
 
-	/* We need a new inode */
-	
-	inode = new_inode(sb);
-	if (!inode)
+	if (len > 1 && *name == '0')
 		goto out;
-
-	/* Common stuff */
-	ei = PROC_I(inode);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	inode->i_ino = fake_ino(task->pid, ino);
-
-	/*
-	 * grab the reference to task.
-	 */
-	tref_set(&ei->tref, tref_get_by_task(task, PIDTYPE_PID));
-	if (!ei->tref->task)
-		goto out_unlock;
-
-	inode->i_uid = 0;
-	inode->i_gid = 0;
-	if (task_dumpable(task)) {
-		inode->i_uid = task->euid;
-		inode->i_gid = task->egid;
+	while (len-- > 0) {
+		unsigned c = *name++ - '0';
+		if (c > 9)
+			goto out;
+		if (n >= (~0U-9)/10)
+			goto out;
+		n *= 10;
+		n += c;
 	}
-	security_task_to_inode(task, inode);
-
+	return n;
 out:
-	return inode;
-
-out_unlock:
-	iput(inode);
-	return NULL;
+	return ~0U;
 }
 
-/* dentry stuff */
-
-/*
- *	Exceptional case: normally we are not allowed to unhash a busy
- * directory. In this case, however, we can do it - no aliasing problems
- * due to the way we treat inodes.
- *
- * Rewrite the inode's ownerships here because the owning task may have
- * performed a setuid(), etc.
- */
-static int pid_revalidate(struct dentry *dentry, struct nameidata *nd)
+static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
-	struct inode *inode = dentry->d_inode;
 	struct task_struct *task = get_proc_task(inode);
+	struct files_struct *files = NULL;
+	struct file *file;
+	int fd = proc_fd(inode);
+
 	if (task) {
-		if (task_dumpable(task)) {
-			inode->i_uid = task->euid;
-			inode->i_gid = task->egid;
-		} else {
-			inode->i_uid = 0;
-			inode->i_gid = 0;
-		}
-		security_task_to_inode(task, inode);
+		files = get_files_struct(task);
 		put_task_struct(task);
-		return 1;
 	}
-	d_drop(dentry);
-	return 0;
+	files = get_files_struct(task);
+	if (files) {
+		rcu_read_lock();
+		file = fcheck_files(files, fd);
+		if (file) {
+			*mnt = mntget(file->f_vfsmnt);
+			*dentry = dget(file->f_dentry);
+			rcu_read_unlock();
+			put_files_struct(files);
+			return 0;
+		}
+		rcu_read_unlock();
+		put_files_struct(files);
+	}
+	return -ENOENT;
 }
 
 static int tid_fd_revalidate(struct dentry *dentry, struct nameidata *nd)
@@ -1361,51 +1157,12 @@ static int tid_fd_revalidate(struct dent
 	return 0;
 }
 
-static int pid_delete_dentry(struct dentry * dentry)
-{
-	/* Is the task we represent dead?
-	 * If so, then don't put the dentry on the lru list,
-	 * kill it immediately.
-	 */
-	return !proc_tref(dentry->d_inode)->task;
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
@@ -1450,32 +1207,90 @@ static struct dentry *proc_lookupfd(stru
 	if (tid_fd_revalidate(dentry, NULL))
 		result = NULL;
 out:
-	put_task_struct(task);
+	put_task_struct(task);
+out_no_task:
+	return result;
+
+out_unlock2:
+	rcu_read_unlock();
+	put_files_struct(files);
+out_unlock:
+	iput(inode);
+	goto out;
+}
+
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
 out_no_task:
-	return result;
-
-out_unlock2:
-	rcu_read_unlock();
-	put_files_struct(files);
-out_unlock:
-	iput(inode);
-	goto out;
+	return retval;
 }
 
-static int proc_task_readdir(struct file * filp, void * dirent, filldir_t filldir);
-static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd);
-static int proc_task_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat);
-
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
@@ -1483,86 +1298,11 @@ static struct inode_operations proc_fd_i
 	.lookup		= proc_lookupfd,
 };
 
-static struct inode_operations proc_task_inode_operations = {
-	.lookup		= proc_task_lookup,
-	.getattr	= proc_task_getattr,
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
@@ -1770,33 +1510,153 @@ out_no_task:
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
+static struct pid_entry tgid_attr_stuff[] = {
+	E(PROC_TGID_ATTR_CURRENT,  "current",  S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_PREV,     "prev",     S_IFREG|S_IRUGO),
+	E(PROC_TGID_ATTR_EXEC,     "exec",     S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_FSCREATE, "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
+	{0,0,NULL,0}
+};
+static struct pid_entry tid_attr_stuff[] = {
+	E(PROC_TID_ATTR_CURRENT,   "current",  S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_PREV,      "prev",     S_IFREG|S_IRUGO),
+	E(PROC_TID_ATTR_EXEC,      "exec",     S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
+	{0,0,NULL,0}
 };
 
-#ifdef CONFIG_SECURITY
 static int proc_tgid_attr_readdir(struct file * filp,
 			     void * dirent, filldir_t filldir)
 {
@@ -1865,6 +1725,73 @@ static struct inode_operations proc_self
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
+};
+
 /**
  * proc_flush_task -  Remove dcache entries for @task from the /proc dcache.
  *
@@ -2003,62 +1930,6 @@ out:
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
-	read_lock(&tasklist_lock);
-	task = find_task_by_pid(tid);
-	if (task)
-		get_task_struct(task);
-	read_unlock(&tasklist_lock);
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
@@ -2176,6 +2047,129 @@ int proc_pid_readdir(struct file * filp,
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
+
+static int proc_tid_base_readdir(struct file * filp,
+			     void * dirent, filldir_t filldir)
+{
+	return proc_pident_readdir(filp,dirent,filldir,
+				   tid_base_stuff,ARRAY_SIZE(tid_base_stuff));
+}
+
+static struct file_operations proc_tid_base_operations = {
+	.read		= generic_read_dir,
+	.readdir	= proc_tid_base_readdir,
+};
+
+static struct dentry *proc_tid_base_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd){
+	return proc_pident_lookup(dir, dentry, tid_base_stuff);
+}
+
+static struct inode_operations proc_tid_base_inode_operations = {
+	.lookup		= proc_tid_base_lookup,
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
+	read_lock(&tasklist_lock);
+	task = find_task_by_pid(tid);
+	if (task)
+		get_task_struct(task);
+	read_unlock(&tasklist_lock);
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
@@ -2327,3 +2321,13 @@ static int proc_task_getattr(struct vfsm
 		
 	return 0;
 }
+
+static struct inode_operations proc_task_inode_operations = {
+	.lookup		= proc_task_lookup,
+	.getattr	= proc_task_getattr,
+};
+
+static struct file_operations proc_task_operations = {
+	.read		= generic_read_dir,
+	.readdir	= proc_task_readdir,
+};
-- 
1.2.2.g709a

