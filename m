Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbWHOSHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWHOSHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWHOSHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:07:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33707 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030413AbWHOSHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:07:00 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 6/7] proc: Remove the hard coded inode numbers.
Date: Tue, 15 Aug 2006 12:05:29 -0600
Message-Id: <11556651323972-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hard coded inode numbers in proc currently limit it's
maintainability, it's flexibility, and what can be done with
the rest of system.  /proc limits pid-max to 32768 on 32 bit
systems it limits fd-max to 32768 on all systems, and placing
the pid in the inode number really gets in the way of implementing
multiple pid namespaces.

Ever since people started adding to the middle of the file type
enumeration we haven't been maintaing the historical inode numbers,
all we have really succeeded in doing is keeping the pid in the proc
inode number.  The pid is already available in the directory name
so no information is lost removing it from the inode number.

So if something in user space cares if we remove the inode number
from the /proc inode it is almost certainly broken.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c |  376 +++++++++++++++++++++++++-------------------------------
 1 files changed, 167 insertions(+), 209 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index bb6a631..f657210 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -84,114 +84,11 @@ #include "internal.h"
  *	in /proc for a task before it execs a suid executable.
  */
 
-/*
- * For hysterical raisins we keep the same inumbers as in the old procfs.
- * Feel free to change the macro below - just keep the range distinct from
- * inumbers of the rest of procfs (currently those are in 0x0000--0xffff).
- * As soon as we'll get a separate superblock we will be able to forget
- * about magical ranges too.
- */
-
-#define fake_ino(pid,ino) (((pid)<<16)|(ino))
-
-enum pid_directory_inos {
-	PROC_TGID_INO = 2,
-	PROC_TGID_TASK,
-	PROC_TGID_STATUS,
-	PROC_TGID_MEM,
-#ifdef CONFIG_SECCOMP
-	PROC_TGID_SECCOMP,
-#endif
-	PROC_TGID_CWD,
-	PROC_TGID_ROOT,
-	PROC_TGID_EXE,
-	PROC_TGID_FD,
-	PROC_TGID_ENVIRON,
-	PROC_TGID_AUXV,
-	PROC_TGID_CMDLINE,
-	PROC_TGID_STAT,
-	PROC_TGID_STATM,
-	PROC_TGID_MAPS,
-	PROC_TGID_NUMA_MAPS,
-	PROC_TGID_MOUNTS,
-	PROC_TGID_MOUNTSTATS,
-	PROC_TGID_WCHAN,
-#ifdef CONFIG_MMU
-	PROC_TGID_SMAPS,
-#endif
-#ifdef CONFIG_SCHEDSTATS
-	PROC_TGID_SCHEDSTAT,
-#endif
-#ifdef CONFIG_CPUSETS
-	PROC_TGID_CPUSET,
-#endif
-#ifdef CONFIG_SECURITY
-	PROC_TGID_ATTR,
-	PROC_TGID_ATTR_CURRENT,
-	PROC_TGID_ATTR_PREV,
-	PROC_TGID_ATTR_EXEC,
-	PROC_TGID_ATTR_FSCREATE,
-	PROC_TGID_ATTR_KEYCREATE,
-	PROC_TGID_ATTR_SOCKCREATE,
-#endif
-#ifdef CONFIG_AUDITSYSCALL
-	PROC_TGID_LOGINUID,
-#endif
-	PROC_TGID_OOM_SCORE,
-	PROC_TGID_OOM_ADJUST,
-	PROC_TID_INO,
-	PROC_TID_STATUS,
-	PROC_TID_MEM,
-#ifdef CONFIG_SECCOMP
-	PROC_TID_SECCOMP,
-#endif
-	PROC_TID_CWD,
-	PROC_TID_ROOT,
-	PROC_TID_EXE,
-	PROC_TID_FD,
-	PROC_TID_ENVIRON,
-	PROC_TID_AUXV,
-	PROC_TID_CMDLINE,
-	PROC_TID_STAT,
-	PROC_TID_STATM,
-	PROC_TID_MAPS,
-	PROC_TID_NUMA_MAPS,
-	PROC_TID_MOUNTS,
-	PROC_TID_MOUNTSTATS,
-	PROC_TID_WCHAN,
-#ifdef CONFIG_MMU
-	PROC_TID_SMAPS,
-#endif
-#ifdef CONFIG_SCHEDSTATS
-	PROC_TID_SCHEDSTAT,
-#endif
-#ifdef CONFIG_CPUSETS
-	PROC_TID_CPUSET,
-#endif
-#ifdef CONFIG_SECURITY
-	PROC_TID_ATTR,
-	PROC_TID_ATTR_CURRENT,
-	PROC_TID_ATTR_PREV,
-	PROC_TID_ATTR_EXEC,
-	PROC_TID_ATTR_FSCREATE,
-	PROC_TID_ATTR_KEYCREATE,
-	PROC_TID_ATTR_SOCKCREATE,
-#endif
-#ifdef CONFIG_AUDITSYSCALL
-	PROC_TID_LOGINUID,
-#endif
-	PROC_TID_OOM_SCORE,
-	PROC_TID_OOM_ADJUST,
-
-	/* Add new entries before this */
-	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
-};
 
 /* Worst case buffer size needed for holding an integer. */
 #define PROC_NUMBUF 10
 
 struct pid_entry {
-	int type;
 	int len;
 	char *name;
 	mode_t mode;
@@ -200,8 +97,7 @@ struct pid_entry {
 	union proc_op op;
 };
 
-#define NOD(TYPE, NAME, MODE, IOP, FOP, OP) {		\
-	.type = (TYPE),					\
+#define NOD(NAME, MODE, IOP, FOP, OP) {			\
 	.len  = sizeof(NAME) - 1,			\
 	.name = (NAME),					\
 	.mode = MODE,					\
@@ -210,19 +106,19 @@ #define NOD(TYPE, NAME, MODE, IOP, FOP, 
 	.op   = OP,					\
 }
 
-#define DIR(TYPE, NAME, MODE, OTYPE)						\
-	NOD(TYPE, NAME, (S_IFDIR|(MODE)),					\
+#define DIR(NAME, MODE, OTYPE)							\
+	NOD(NAME, (S_IFDIR|(MODE)),						\
 		&proc_##OTYPE##_inode_operations, &proc_##OTYPE##_operations,	\
 		{} )
-#define LNK(TYPE, NAME, OTYPE)					\
-	NOD(TYPE, NAME, (S_IFLNK|S_IRWXUGO),			\
+#define LNK(NAME, OTYPE)					\
+	NOD(NAME, (S_IFLNK|S_IRWXUGO),				\
 		&proc_pid_link_inode_operations, NULL,		\
 		{ .proc_get_link = &proc_##OTYPE##_link } )
-#define REG(TYPE, NAME, MODE, OTYPE)			\
-	NOD(TYPE, NAME, (S_IFREG|(MODE)), NULL,		\
+#define REG(NAME, MODE, OTYPE)				\
+	NOD(NAME, (S_IFREG|(MODE)), NULL,		\
 		&proc_##OTYPE##_operations, {})
-#define INF(TYPE, NAME, MODE, OTYPE)			\
-	NOD(TYPE, NAME, (S_IFREG|(MODE)), 		\
+#define INF(NAME, MODE, OTYPE)				\
+	NOD(NAME, (S_IFREG|(MODE)), 			\
 		NULL, &proc_info_file_operations,	\
 		{ .proc_read = &proc_##OTYPE } )
 
@@ -1042,7 +938,7 @@ static int task_dumpable(struct task_str
 }
 
 
-static struct inode *proc_pid_make_inode(struct super_block * sb, struct task_struct *task, int ino)
+static struct inode *proc_pid_make_inode(struct super_block * sb, struct task_struct *task)
 {
 	struct inode * inode;
 	struct proc_inode *ei;
@@ -1056,7 +952,6 @@ static struct inode *proc_pid_make_inode
 	/* Common stuff */
 	ei = PROC_I(inode);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	inode->i_ino = fake_ino(task->pid, ino);
 	inode->i_op = &proc_def_inode_operations;
 
 	/*
@@ -1159,6 +1054,50 @@ static struct dentry_operations pid_dent
 
 /* Lookups */
 
+typedef struct dentry *instantiate_t(struct inode *, struct dentry *, struct task_struct *, void *);
+
+static int proc_fill_cache(struct file *filp, void *dirent, filldir_t filldir,
+	char *name, int len,
+	instantiate_t instantiate, struct task_struct *task, void *ptr)
+{
+	struct dentry *child, *dir = filp->f_dentry;
+	struct inode *inode;
+	struct qstr qname;
+	ino_t ino = 0;
+	unsigned type = DT_UNKNOWN;
+
+	qname.name = name;
+	qname.len  = len;
+	qname.hash = full_name_hash(name, len);
+
+	child = d_lookup(dir, &qname);
+	if (!child) {
+		struct dentry *new;
+		new = d_alloc(dir, &qname);
+		if (new) {
+			child = instantiate(dir->d_inode, new, task, ptr);
+			if (child)
+				dput(new);
+			else
+				child = new;
+		}
+	}
+	if (!child || IS_ERR(child) || !child->d_inode)
+		goto end_instantiate;
+	inode = child->d_inode;
+	if (inode) {
+		ino = inode->i_ino;
+		type = inode->i_mode >> 12;
+	}
+	dput(child);
+end_instantiate:
+	if (!ino)
+		ino = find_inode_number(dir, &qname);
+	if (!ino)
+		ino = 1;
+	return filldir(dirent, name, len, filp->f_pos, ino, type);
+}
+
 static unsigned name_to_int(struct dentry *dentry)
 {
 	const char *name = dentry->d_name.name;
@@ -1263,7 +1202,7 @@ static struct dentry *proc_fd_instantiat
  	struct proc_inode *ei;
 	struct dentry *error = ERR_PTR(-ENOENT);
 
-	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TID_FD_DIR+fd);
+	inode = proc_pid_make_inode(dir->i_sb, task);
 	if (!inode)
 		goto out;
 	ei = PROC_I(inode);
@@ -1326,6 +1265,15 @@ out_no_task:
 	return result;
 }
 
+static int proc_fd_fill_cache(struct file *filp, void *dirent, filldir_t filldir,
+	struct task_struct *task, int fd)
+{
+	char name[PROC_NUMBUF];
+	int len = snprintf(name, sizeof(name), "%d", fd);
+	return proc_fill_cache(filp, dirent, filldir, name, len,
+				proc_fd_instantiate, task, &fd);
+}
+
 static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
 {
 	struct dentry *dentry = filp->f_dentry;
@@ -1333,7 +1281,6 @@ static int proc_readfd(struct file * fil
 	struct task_struct *p = get_proc_task(inode);
 	unsigned int fd, tid, ino;
 	int retval;
-	char buf[PROC_NUMBUF];
 	struct files_struct * files;
 	struct fdtable *fdt;
 
@@ -1363,22 +1310,12 @@ static int proc_readfd(struct file * fil
 			for (fd = filp->f_pos-2;
 			     fd < fdt->max_fds;
 			     fd++, filp->f_pos++) {
-				unsigned int i,j;
 
 				if (!fcheck_files(files, fd))
 					continue;
 				rcu_read_unlock();
 
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
+				if (proc_fd_fill_cache(filp, dirent, filldir, p, fd) < 0) {
 					rcu_read_lock();
 					break;
 				}
@@ -1414,7 +1351,7 @@ static struct dentry *proc_pident_instan
 	struct proc_inode *ei;
 	struct dentry *error = ERR_PTR(-EINVAL);
 
-	inode = proc_pid_make_inode(dir->i_sb, task, p->type);
+	inode = proc_pid_make_inode(dir->i_sb, task);
 	if (!inode)
 		goto out;
 
@@ -1472,6 +1409,13 @@ out_no_task:
 	return error;
 }
 
+static int proc_pident_fill_cache(struct file *filp, void *dirent, filldir_t filldir,
+	struct task_struct *task, struct pid_entry *p)
+{
+	return proc_fill_cache(filp, dirent, filldir, p->name, p->len,
+				proc_pident_instantiate, task, p);
+}
+
 static int proc_pident_readdir(struct file *filp,
 		void *dirent, filldir_t filldir,
 		struct pid_entry *ents, unsigned int nents)
@@ -1487,11 +1431,10 @@ static int proc_pident_readdir(struct fi
 
 	ret = -ENOENT;
 	if (!task)
-		goto out;
+		goto out_no_task;
 
 	ret = 0;
 	pid = task->pid;
-	put_task_struct(task);
 	i = filp->f_pos;
 	switch (i) {
 	case 0:
@@ -1516,8 +1459,7 @@ static int proc_pident_readdir(struct fi
 		}
 		p = ents + i;
 		while (p->name) {
-			if (filldir(dirent, p->name, p->len, filp->f_pos,
-				    fake_ino(pid, p->type), p->mode >> 12) < 0)
+			if (proc_pident_fill_cache(filp, dirent, filldir, task, p) < 0)
 				goto out;
 			filp->f_pos++;
 			p++;
@@ -1526,6 +1468,8 @@ static int proc_pident_readdir(struct fi
 
 	ret = 1;
 out:
+	put_task_struct(task);
+out_no_task:
 	return ret;
 }
 
@@ -1605,21 +1549,21 @@ static struct file_operations proc_pid_a
 };
 
 static struct pid_entry tgid_attr_stuff[] = {
-	REG(PROC_TGID_ATTR_CURRENT,    "current",    S_IRUGO|S_IWUGO, pid_attr),
-	REG(PROC_TGID_ATTR_PREV,       "prev",       S_IRUGO,	      pid_attr),
-	REG(PROC_TGID_ATTR_EXEC,       "exec",       S_IRUGO|S_IWUGO, pid_attr),
-	REG(PROC_TGID_ATTR_FSCREATE,   "fscreate",   S_IRUGO|S_IWUGO, pid_attr),
-	REG(PROC_TGID_ATTR_KEYCREATE,  "keycreate",  S_IRUGO|S_IWUGO, pid_attr),
-	REG(PROC_TGID_ATTR_SOCKCREATE, "sockcreate", S_IRUGO|S_IWUGO, pid_attr),
+	REG("current",    S_IRUGO|S_IWUGO, pid_attr),
+	REG("prev",       S_IRUGO,	   pid_attr),
+	REG("exec",       S_IRUGO|S_IWUGO, pid_attr),
+	REG("fscreate",   S_IRUGO|S_IWUGO, pid_attr),
+	REG("keycreate",  S_IRUGO|S_IWUGO, pid_attr),
+	REG("sockcreate", S_IRUGO|S_IWUGO, pid_attr),
 	{}
 };
 static struct pid_entry tid_attr_stuff[] = {
-	REG(PROC_TID_ATTR_CURRENT,    "current",    S_IRUGO|S_IWUGO, pid_attr),
-	REG(PROC_TID_ATTR_PREV,       "prev",       S_IRUGO,	     pid_attr),
-	REG(PROC_TID_ATTR_EXEC,       "exec",       S_IRUGO|S_IWUGO, pid_attr),
-	REG(PROC_TID_ATTR_FSCREATE,   "fscreate",   S_IRUGO|S_IWUGO, pid_attr),
-	REG(PROC_TID_ATTR_KEYCREATE,  "keycreate",  S_IRUGO|S_IWUGO, pid_attr),
-	REG(PROC_TID_ATTR_SOCKCREATE, "sockcreate", S_IRUGO|S_IWUGO, pid_attr),
+	REG("current",    S_IRUGO|S_IWUGO, pid_attr),
+	REG("prev",       S_IRUGO,	   pid_attr),
+	REG("exec",       S_IRUGO|S_IWUGO, pid_attr),
+	REG("fscreate",   S_IRUGO|S_IWUGO, pid_attr),
+	REG("keycreate",  S_IRUGO|S_IWUGO, pid_attr),
+	REG("sockcreate", S_IRUGO|S_IWUGO, pid_attr),
 	{}
 };
 
@@ -1702,46 +1646,46 @@ static struct file_operations proc_task_
 static struct inode_operations proc_task_inode_operations;
 
 static struct pid_entry tgid_base_stuff[] = {
-	DIR(PROC_TGID_TASK,       "task",       S_IRUGO|S_IXUGO, task),
-	DIR(PROC_TGID_FD,         "fd",         S_IRUSR|S_IXUSR, fd),
-	INF(PROC_TGID_ENVIRON,    "environ",    S_IRUSR, pid_environ),
-	INF(PROC_TGID_AUXV,       "auxv",       S_IRUSR, pid_auxv),
-	INF(PROC_TGID_STATUS,     "status",     S_IRUGO, pid_status),
-	INF(PROC_TGID_CMDLINE,    "cmdline",    S_IRUGO, pid_cmdline),
-	INF(PROC_TGID_STAT,       "stat",       S_IRUGO, tgid_stat),
-	INF(PROC_TGID_STATM,      "statm",      S_IRUGO, pid_statm),
-	REG(PROC_TGID_MAPS,       "maps",       S_IRUGO, maps),
+	DIR("task",       S_IRUGO|S_IXUGO, task),
+	DIR("fd",         S_IRUSR|S_IXUSR, fd),
+	INF("environ",    S_IRUSR, pid_environ),
+	INF("auxv",       S_IRUSR, pid_auxv),
+	INF("status",     S_IRUGO, pid_status),
+	INF("cmdline",    S_IRUGO, pid_cmdline),
+	INF("stat",       S_IRUGO, tgid_stat),
+	INF("statm",      S_IRUGO, pid_statm),
+	REG("maps",       S_IRUGO, maps),
 #ifdef CONFIG_NUMA
-	REG(PROC_TGID_NUMA_MAPS,  "numa_maps",  S_IRUGO, numa_maps),
+	REG("numa_maps",  S_IRUGO, numa_maps),
 #endif
-	REG(PROC_TGID_MEM,        "mem",        S_IRUSR|S_IWUSR, mem),
+	REG("mem",        S_IRUSR|S_IWUSR, mem),
 #ifdef CONFIG_SECCOMP
-	REG(PROC_TGID_SECCOMP,    "seccomp",    S_IRUSR|S_IWUSR, seccomp),
+	REG("seccomp",    S_IRUSR|S_IWUSR, seccomp),
 #endif
-	LNK(PROC_TGID_CWD,        "cwd",        cwd),
-	LNK(PROC_TGID_ROOT,       "root",       root),
-	LNK(PROC_TGID_EXE,        "exe",        exe),
-	REG(PROC_TGID_MOUNTS,     "mounts",     S_IRUGO, mounts),
-	REG(PROC_TGID_MOUNTSTATS, "mountstats", S_IRUSR, mountstats),
+	LNK("cwd",        cwd),
+	LNK("root",       root),
+	LNK("exe",        exe),
+	REG("mounts",     S_IRUGO, mounts),
+	REG("mountstats", S_IRUSR, mountstats),
 #ifdef CONFIG_MMU
-	REG(PROC_TGID_SMAPS,      "smaps",      S_IRUGO, smaps),
+	REG("smaps",      S_IRUGO, smaps),
 #endif
 #ifdef CONFIG_SECURITY
-	DIR(PROC_TGID_ATTR,       "attr",       S_IRUGO|S_IXUGO, tgid_attr),
+	DIR("attr",       S_IRUGO|S_IXUGO, tgid_attr),
 #endif
 #ifdef CONFIG_KALLSYMS
-	INF(PROC_TGID_WCHAN,      "wchan",      S_IRUGO, pid_wchan),
+	INF("wchan",      S_IRUGO, pid_wchan),
 #endif
 #ifdef CONFIG_SCHEDSTATS
-	INF(PROC_TGID_SCHEDSTAT,  "schedstat",  S_IRUGO, pid_schedstat),
+	INF("schedstat",  S_IRUGO, pid_schedstat),
 #endif
 #ifdef CONFIG_CPUSETS
-	REG(PROC_TGID_CPUSET,     "cpuset",     S_IRUGO, cpuset),
+	REG("cpuset",     S_IRUGO, cpuset),
 #endif
-	INF(PROC_TGID_OOM_SCORE,  "oom_score",  S_IRUGO, oom_score),
-	REG(PROC_TGID_OOM_ADJUST, "oom_adj",    S_IRUGO|S_IWUSR, oom_adjust),
+	INF("oom_score",  S_IRUGO, oom_score),
+	REG("oom_adj",    S_IRUGO|S_IWUSR, oom_adjust),
 #ifdef CONFIG_AUDITSYSCALL
-	REG(PROC_TGID_LOGINUID,   "loginuid",   S_IWUSR|S_IRUGO, loginuid),
+	REG("loginuid",   S_IWUSR|S_IRUGO, loginuid),
 #endif
 	{}
 };
@@ -1769,7 +1713,7 @@ static struct inode_operations proc_tgid
 };
 
 static struct pid_entry proc_base_stuff[] = {
-	NOD(PROC_TGID_INO,     "self",	S_IFLNK|S_IRWXUGO,
+	NOD("self",	S_IFLNK|S_IRWXUGO,
 		&proc_self_inode_operations, NULL, {}),
 	{}
 };
@@ -1848,7 +1792,7 @@ struct dentry *proc_pid_instantiate(stru
 	struct dentry *error = ERR_PTR(-ENOENT);
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TGID_INO);
+	inode = proc_pid_make_inode(dir->i_sb, task);
 	if (!inode)
 		goto out;
 
@@ -1967,18 +1911,29 @@ done:
 	return pos;
 }
 
+static int proc_pid_fill_cache(struct file *filp, void *dirent, filldir_t filldir,
+	struct task_struct *task, int tgid)
+{
+	char name[PROC_NUMBUF];
+	int len = snprintf(name, sizeof(name), "%d", tgid);
+	return proc_fill_cache(filp, dirent, filldir, name, len,
+				proc_pid_instantiate, task, NULL);
+}
+
 /* for the /proc/ directory itself, after non-process stuff has been done */
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
-	char buf[PROC_NUMBUF];
 	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
+	struct task_struct *reaper = get_proc_task(filp->f_dentry->d_inode);
 	struct task_struct *task;
 	int tgid;
 
+	if (!reaper)
+		goto out_no_task;
+
 	for (;nr < (ARRAY_SIZE(proc_base_stuff) - 1); filp->f_pos++, nr++) {
 		struct pid_entry *p = &proc_base_stuff[nr];
-		if (filldir(dirent, p->name, p->len, filp->f_pos,
-			    fake_ino(0, p->type), p->mode >> 12) < 0)
+		if (proc_pident_fill_cache(filp, dirent, filldir, reaper, p) < 0)
 			goto out;
 	}
 	nr -= ARRAY_SIZE(proc_base_stuff) - 1;
@@ -1991,12 +1946,8 @@ int proc_pid_readdir(struct file * filp,
 	for (task = first_tgid(tgid, nr);
 	     task;
 	     task = next_tgid(task), filp->f_pos++) {
-		int len;
-		ino_t ino;
 		tgid = task->pid;
-		len = snprintf(buf, sizeof(buf), "%d", tgid);
-		ino = fake_ino(tgid, PROC_TGID_INO);
-		if (filldir(dirent, buf, len, filp->f_pos, ino, DT_DIR) < 0) {
+		if (proc_pid_fill_cache(filp, dirent, filldir, task, tgid) < 0) {
 			/* returning this tgid failed, save it as the first
 			 * pid for the next readir call */
 			filp->f_version = tgid;
@@ -2005,6 +1956,8 @@ int proc_pid_readdir(struct file * filp,
 		}
 	}
 out:
+	put_task_struct(reaper);
+out_no_task:
 	return 0;
 }
 
@@ -2012,44 +1965,44 @@ out:
  * Tasks
  */
 static struct pid_entry tid_base_stuff[] = {
-	DIR(PROC_TID_FD,         "fd",        S_IRUSR|S_IXUSR, fd),
-	INF(PROC_TID_ENVIRON,    "environ",   S_IRUSR, pid_environ),
-	INF(PROC_TID_AUXV,       "auxv",      S_IRUSR, pid_auxv),
-	INF(PROC_TID_STATUS,     "status",    S_IRUGO, pid_status),
-	INF(PROC_TID_CMDLINE,    "cmdline",   S_IRUGO, pid_cmdline),
-	INF(PROC_TID_STAT,       "stat",      S_IRUGO, tid_stat),
-	INF(PROC_TID_STATM,      "statm",     S_IRUGO, pid_statm),
-	REG(PROC_TID_MAPS,       "maps",      S_IRUGO, maps),
+	DIR("fd",        S_IRUSR|S_IXUSR, fd),
+	INF("environ",   S_IRUSR, pid_environ),
+	INF("auxv",      S_IRUSR, pid_auxv),
+	INF("status",    S_IRUGO, pid_status),
+	INF("cmdline",   S_IRUGO, pid_cmdline),
+	INF("stat",      S_IRUGO, tid_stat),
+	INF("statm",     S_IRUGO, pid_statm),
+	REG("maps",      S_IRUGO, maps),
 #ifdef CONFIG_NUMA
-	REG(PROC_TID_NUMA_MAPS,  "numa_maps", S_IRUGO, numa_maps),
+	REG("numa_maps", S_IRUGO, numa_maps),
 #endif
-	REG(PROC_TID_MEM,        "mem",       S_IRUSR|S_IWUSR, mem),
+	REG("mem",       S_IRUSR|S_IWUSR, mem),
 #ifdef CONFIG_SECCOMP
-	REG(PROC_TID_SECCOMP,    "seccomp",   S_IRUSR|S_IWUSR, seccomp),
+	REG("seccomp",   S_IRUSR|S_IWUSR, seccomp),
 #endif
-	LNK(PROC_TID_CWD,        "cwd",       cwd),
-	LNK(PROC_TID_ROOT,       "root",      root),
-	LNK(PROC_TID_EXE,        "exe",       exe),
-	REG(PROC_TID_MOUNTS,     "mounts",    S_IRUGO, mounts),
+	LNK("cwd",       cwd),
+	LNK("root",      root),
+	LNK("exe",       exe),
+	REG("mounts",    S_IRUGO, mounts),
 #ifdef CONFIG_MMU
-	REG(PROC_TID_SMAPS,      "smaps",     S_IRUGO, smaps),
+	REG("smaps",     S_IRUGO, smaps),
 #endif
 #ifdef CONFIG_SECURITY
-	DIR(PROC_TID_ATTR,       "attr",      S_IRUGO|S_IXUGO, tid_attr),
+	DIR("attr",      S_IRUGO|S_IXUGO, tid_attr),
 #endif
 #ifdef CONFIG_KALLSYMS
-	INF(PROC_TID_WCHAN,      "wchan",     S_IRUGO, pid_wchan),
+	INF("wchan",     S_IRUGO, pid_wchan),
 #endif
 #ifdef CONFIG_SCHEDSTATS
-	INF(PROC_TID_SCHEDSTAT,  "schedstat", S_IRUGO, pid_schedstat),
+	INF("schedstat", S_IRUGO, pid_schedstat),
 #endif
 #ifdef CONFIG_CPUSETS
-	REG(PROC_TID_CPUSET,     "cpuset",    S_IRUGO, cpuset),
+	REG("cpuset",    S_IRUGO, cpuset),
 #endif
-	INF(PROC_TID_OOM_SCORE,  "oom_score", S_IRUGO, oom_score),
-	REG(PROC_TID_OOM_ADJUST, "oom_adj",   S_IRUGO|S_IWUSR, oom_adjust),
+	INF("oom_score", S_IRUGO, oom_score),
+	REG("oom_adj",   S_IRUGO|S_IWUSR, oom_adjust),
 #ifdef CONFIG_AUDITSYSCALL
-	REG(PROC_TID_LOGINUID,   "loginuid",  S_IWUSR|S_IRUGO, loginuid),
+	REG("loginuid",  S_IWUSR|S_IRUGO, loginuid),
 #endif
 	{}
 };
@@ -2081,7 +2034,7 @@ static struct dentry *proc_task_instanti
 {
 	struct dentry *error = ERR_PTR(-ENOENT);
 	struct inode *inode;
-	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TID_INO);
+	inode = proc_pid_make_inode(dir->i_sb, task);
 
 	if (!inode)
 		goto out;
@@ -2207,10 +2160,18 @@ static struct task_struct *next_tid(stru
 	return pos;
 }
 
+static int proc_task_fill_cache(struct file *filp, void *dirent, filldir_t filldir,
+	struct task_struct *task, int tid)
+{
+	char name[PROC_NUMBUF];
+	int len = snprintf(name, sizeof(name), "%d", tid);
+	return proc_fill_cache(filp, dirent, filldir, name, len,
+				proc_task_instantiate, task, NULL);
+}
+
 /* for the /proc/TGID/task/ directories */
 static int proc_task_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
-	char buf[PROC_NUMBUF];
 	struct dentry *dentry = filp->f_dentry;
 	struct inode *inode = dentry->d_inode;
 	struct task_struct *leader = get_proc_task(inode);
@@ -2247,11 +2208,8 @@ static int proc_task_readdir(struct file
 	for (task = first_tid(leader, tid, pos - 2);
 	     task;
 	     task = next_tid(task), pos++) {
-		int len;
 		tid = task->pid;
-		len = snprintf(buf, sizeof(buf), "%d", tid);
-		ino = fake_ino(tid, PROC_TID_INO);
-		if (filldir(dirent, buf, len, pos, ino, DT_DIR < 0)) {
+		if (proc_task_fill_cache(filp, dirent, filldir, task, tid) < 0) {
 			/* returning this tgid failed, save it as the first
 			 * pid for the next readir call */
 			filp->f_version = tid;
-- 
1.4.2.rc3.g7e18e-dirty

