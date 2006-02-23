Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751714AbWBWQ21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbWBWQ21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbWBWQ20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:28:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28823 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751630AbWBWQ2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:28:25 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 19/23] proc: Modify proc_pident_lookup to be completely
 table driven.
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:27:14 -0700
In-Reply-To: <m1ek1uf3eq.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:25:33 -0700")
Message-ID: <m1accif3bx.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently proc_pident_lookup gets the names and types from a table
and then has a huge switch statement to get the inode and file
operations it needs.  That is silly and is becoming increasingly hard
to maintain so I just put all of the information in the table.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c          |  332 +++++++++++++++--------------------------------
 include/linux/proc_fs.h |   10 +
 2 files changed, 109 insertions(+), 233 deletions(-)

aa1e6b9f7d2bf0d4a39fcb1ebd3c539e1287ea45
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 71edbad..b27175a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -189,9 +189,37 @@ struct pid_entry {
 	int len;
 	char *name;
 	mode_t mode;
-};
+	struct inode_operations *iop;
+	struct file_operations *fop;
+	union proc_op op;
+};
+
+#define NOD(TYPE, NAME, MODE, IOP, FOP, OP) {		\
+	.type = (TYPE),					\
+	.len  = sizeof(NAME) - 1,			\
+	.name = (NAME),					\
+	.mode = MODE,					\
+	.iop  = IOP,					\
+	.fop  = FOP,					\
+	.op   = OP,					\
+}
+
+#define DIR(TYPE, NAME, MODE, OTYPE)						\
+	NOD(TYPE, NAME, (S_IFDIR|(MODE)),					\
+		&proc_##OTYPE##_inode_operations, &proc_##OTYPE##_operations,	\
+		{} )
+#define LNK(TYPE, NAME, OTYPE)					\
+	NOD(TYPE, NAME, (S_IFLNK|S_IRWXUGO),			\
+		&proc_pid_link_inode_operations, NULL,		\
+		{ .proc_get_link = &proc_##OTYPE##_link } )
+#define REG(TYPE, NAME, MODE, OTYPE)			\
+	NOD(TYPE, NAME, (S_IFREG|(MODE)), NULL,		\
+		&proc_##OTYPE##_operations, {})
+#define INF(TYPE, NAME, MODE, OTYPE)			\
+	NOD(TYPE, NAME, (S_IFREG|(MODE)), 		\
+		NULL, &proc_info_file_operations,	\
+		{ .proc_read = &proc_##OTYPE } )
 
-#define E(type,name,mode) {(type),sizeof(name)-1,(name),(mode)}
 
 static struct fs_struct *get_fs_struct(struct task_struct *task)
 {
@@ -1298,17 +1326,6 @@ static struct inode_operations proc_fd_i
 	.lookup		= proc_lookupfd,
 };
 
-static struct file_operations proc_task_operations;
-static struct inode_operations proc_task_inode_operations;
-
-#ifdef CONFIG_SECURITY
-static struct file_operations proc_pid_attr_operations;
-static struct file_operations proc_tid_attr_operations;
-static struct inode_operations proc_tid_attr_inode_operations;
-static struct file_operations proc_tgid_attr_operations;
-static struct inode_operations proc_tgid_attr_inode_operations;
-#endif
-
 /* SMP-safe */
 static struct dentry *proc_pident_lookup(struct inode *dir, 
 					 struct dentry *dentry,
@@ -1326,6 +1343,10 @@ static struct dentry *proc_pident_lookup
 	if (!task)
 		goto out_no_task;
 
+	/*
+	 * Yes, it does not scale. And it should not. Don't add
+	 * new entries into /proc/<tgid>/ without very good reasons.
+	 */
 	for (p = ents; p->name; p++) {
 		if (p->len != dentry->d_name.len)
 			continue;
@@ -1342,163 +1363,13 @@ static struct dentry *proc_pident_lookup
 
 	ei = PROC_I(inode);
 	inode->i_mode = p->mode;
-	/*
-	 * Yes, it does not scale. And it should not. Don't add
-	 * new entries into /proc/<tgid>/ without very good reasons.
-	 */
-	switch(p->type) {
-		case PROC_TGID_TASK:
-			inode->i_nlink = 2;
-			inode->i_op = &proc_task_inode_operations;
-			inode->i_fop = &proc_task_operations;
-			break;
-		case PROC_TID_FD:
-		case PROC_TGID_FD:
-			inode->i_nlink = 2;
-			inode->i_op = &proc_fd_inode_operations;
-			inode->i_fop = &proc_fd_operations;
-			break;
-		case PROC_TID_EXE:
-		case PROC_TGID_EXE:
-			inode->i_op = &proc_pid_link_inode_operations;
-			ei->op.proc_get_link = proc_exe_link;
-			break;
-		case PROC_TID_CWD:
-		case PROC_TGID_CWD:
-			inode->i_op = &proc_pid_link_inode_operations;
-			ei->op.proc_get_link = proc_cwd_link;
-			break;
-		case PROC_TID_ROOT:
-		case PROC_TGID_ROOT:
-			inode->i_op = &proc_pid_link_inode_operations;
-			ei->op.proc_get_link = proc_root_link;
-			break;
-		case PROC_TID_ENVIRON:
-		case PROC_TGID_ENVIRON:
-			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_pid_environ;
-			break;
-		case PROC_TID_AUXV:
-		case PROC_TGID_AUXV:
-			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_pid_auxv;
-			break;
-		case PROC_TID_STATUS:
-		case PROC_TGID_STATUS:
-			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_pid_status;
-			break;
-		case PROC_TID_STAT:
-			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_tid_stat;
-			break;
-		case PROC_TGID_STAT:
-			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_tgid_stat;
-			break;
-		case PROC_TID_CMDLINE:
-		case PROC_TGID_CMDLINE:
-			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_pid_cmdline;
-			break;
-		case PROC_TID_STATM:
-		case PROC_TGID_STATM:
-			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_pid_statm;
-			break;
-		case PROC_TID_MAPS:
-		case PROC_TGID_MAPS:
-			inode->i_fop = &proc_maps_operations;
-			break;
-#ifdef CONFIG_NUMA
-		case PROC_TID_NUMA_MAPS:
-		case PROC_TGID_NUMA_MAPS:
-			inode->i_fop = &proc_numa_maps_operations;
-			break;
-#endif
-		case PROC_TID_MEM:
-		case PROC_TGID_MEM:
-			inode->i_fop = &proc_mem_operations;
-			break;
-#ifdef CONFIG_SECCOMP
-		case PROC_TID_SECCOMP:
-		case PROC_TGID_SECCOMP:
-			inode->i_fop = &proc_seccomp_operations;
-			break;
-#endif /* CONFIG_SECCOMP */
-		case PROC_TID_MOUNTS:
-		case PROC_TGID_MOUNTS:
-			inode->i_fop = &proc_mounts_operations;
-			break;
-#ifdef CONFIG_MMU
-		case PROC_TID_SMAPS:
-		case PROC_TGID_SMAPS:
-			inode->i_fop = &proc_smaps_operations;
-			break;
-#endif
-#ifdef CONFIG_SECURITY
-		case PROC_TID_ATTR:
-			inode->i_nlink = 2;
-			inode->i_op = &proc_tid_attr_inode_operations;
-			inode->i_fop = &proc_tid_attr_operations;
-			break;
-		case PROC_TGID_ATTR:
-			inode->i_nlink = 2;
-			inode->i_op = &proc_tgid_attr_inode_operations;
-			inode->i_fop = &proc_tgid_attr_operations;
-			break;
-		case PROC_TID_ATTR_CURRENT:
-		case PROC_TGID_ATTR_CURRENT:
-		case PROC_TID_ATTR_PREV:
-		case PROC_TGID_ATTR_PREV:
-		case PROC_TID_ATTR_EXEC:
-		case PROC_TGID_ATTR_EXEC:
-		case PROC_TID_ATTR_FSCREATE:
-		case PROC_TGID_ATTR_FSCREATE:
-			inode->i_fop = &proc_pid_attr_operations;
-			break;
-#endif
-#ifdef CONFIG_KALLSYMS
-		case PROC_TID_WCHAN:
-		case PROC_TGID_WCHAN:
-			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_pid_wchan;
-			break;
-#endif
-#ifdef CONFIG_SCHEDSTATS
-		case PROC_TID_SCHEDSTAT:
-		case PROC_TGID_SCHEDSTAT:
-			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_pid_schedstat;
-			break;
-#endif
-#ifdef CONFIG_CPUSETS
-		case PROC_TID_CPUSET:
-		case PROC_TGID_CPUSET:
-			inode->i_fop = &proc_cpuset_operations;
-			break;
-#endif
-		case PROC_TID_OOM_SCORE:
-		case PROC_TGID_OOM_SCORE:
-			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_oom_score;
-			break;
-		case PROC_TID_OOM_ADJUST:
-		case PROC_TGID_OOM_ADJUST:
-			inode->i_fop = &proc_oom_adjust_operations;
-			break;
-#ifdef CONFIG_AUDITSYSCALL
-		case PROC_TID_LOGINUID:
-		case PROC_TGID_LOGINUID:
-			inode->i_fop = &proc_loginuid_operations;
-			break;
-#endif
-		default:
-			printk("procfs: impossible type (%d)",p->type);
-			iput(inode);
-			error = ERR_PTR(-EINVAL);
-			goto out;
-	}
+	if (S_ISDIR(inode->i_mode))
+		inode->i_nlink = 2;	/* Use getattr to fix if necessary */
+	if (p->iop)
+		inode->i_op = p->iop;
+	if (p->fop)
+		inode->i_fop = p->fop;
+	ei->op = p->op;
 	dentry->d_op = &pid_dentry_operations;
 	d_add(dentry, inode);
 	/* Close the race of the process dying before we return the dentry */
@@ -1643,18 +1514,18 @@ static struct file_operations proc_pid_a
 };
 
 static struct pid_entry tgid_attr_stuff[] = {
-	E(PROC_TGID_ATTR_CURRENT,  "current",  S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TGID_ATTR_PREV,     "prev",     S_IFREG|S_IRUGO),
-	E(PROC_TGID_ATTR_EXEC,     "exec",     S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TGID_ATTR_FSCREATE, "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
-	{0,0,NULL,0}
+	REG(PROC_TGID_ATTR_CURRENT,  "current",  S_IRUGO|S_IWUGO, pid_attr),
+	REG(PROC_TGID_ATTR_PREV,     "prev",     S_IRUGO,         pid_attr),
+	REG(PROC_TGID_ATTR_EXEC,     "exec",     S_IRUGO|S_IWUGO, pid_attr),
+	REG(PROC_TGID_ATTR_FSCREATE, "fscreate", S_IRUGO|S_IWUGO, pid_attr),
+	{}
 };
 static struct pid_entry tid_attr_stuff[] = {
-	E(PROC_TID_ATTR_CURRENT,   "current",  S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TID_ATTR_PREV,      "prev",     S_IFREG|S_IRUGO),
-	E(PROC_TID_ATTR_EXEC,      "exec",     S_IFREG|S_IRUGO|S_IWUGO),
-	E(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
-	{0,0,NULL,0}
+	REG(PROC_TID_ATTR_CURRENT,   "current",  S_IRUGO|S_IWUGO, pid_attr),
+	REG(PROC_TID_ATTR_PREV,      "prev",     S_IRUGO,         pid_attr),
+	REG(PROC_TID_ATTR_EXEC,      "exec",     S_IRUGO|S_IWUGO, pid_attr),
+	REG(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IRUGO|S_IWUGO, pid_attr),
+	{}
 };
 
 static int proc_tgid_attr_readdir(struct file * filp,
@@ -1728,48 +1599,51 @@ static struct inode_operations proc_self
 /*
  * Thread groups
  */
+static struct file_operations proc_task_operations;
+static struct inode_operations proc_task_inode_operations;
+
 static struct pid_entry tgid_base_stuff[] = {
-	E(PROC_TGID_TASK,      "task",    S_IFDIR|S_IRUGO|S_IXUGO),
-	E(PROC_TGID_FD,        "fd",      S_IFDIR|S_IRUSR|S_IXUSR),
-	E(PROC_TGID_ENVIRON,   "environ", S_IFREG|S_IRUSR),
-	E(PROC_TGID_AUXV,      "auxv",	  S_IFREG|S_IRUSR),
-	E(PROC_TGID_STATUS,    "status",  S_IFREG|S_IRUGO),
-	E(PROC_TGID_CMDLINE,   "cmdline", S_IFREG|S_IRUGO),
-	E(PROC_TGID_STAT,      "stat",    S_IFREG|S_IRUGO),
-	E(PROC_TGID_STATM,     "statm",   S_IFREG|S_IRUGO),
-	E(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUGO),
+	DIR(PROC_TGID_TASK,    "task",    S_IRUGO|S_IXUGO, task),
+	DIR(PROC_TGID_FD,      "fd",      S_IRUSR|S_IXUSR, fd),
+	INF(PROC_TGID_ENVIRON, "environ", S_IRUSR, pid_environ),
+	INF(PROC_TGID_AUXV,    "auxv",	  S_IRUSR, pid_auxv),
+	INF(PROC_TGID_STATUS,  "status",  S_IRUGO, pid_status),
+	INF(PROC_TGID_CMDLINE, "cmdline", S_IRUGO, pid_cmdline),
+	INF(PROC_TGID_STAT,    "stat",    S_IRUGO, tgid_stat),
+	INF(PROC_TGID_STATM,   "statm",   S_IRUGO, pid_statm),
+	REG(PROC_TGID_MAPS,    "maps",    S_IRUGO, maps),
 #ifdef CONFIG_NUMA
-	E(PROC_TGID_NUMA_MAPS, "numa_maps", S_IFREG|S_IRUGO),
+	REG(PROC_TGID_NUMA_MAPS, "numa_maps", S_IRUGO, numa_maps),
 #endif
-	E(PROC_TGID_MEM,       "mem",     S_IFREG|S_IRUSR|S_IWUSR),
+	REG(PROC_TGID_MEM,     "mem",     S_IRUSR|S_IWUSR, mem),
 #ifdef CONFIG_SECCOMP
-	E(PROC_TGID_SECCOMP,   "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
+	REG(PROC_TGID_SECCOMP, "seccomp", S_IRUSR|S_IWUSR, seccomp),
 #endif
-	E(PROC_TGID_CWD,       "cwd",     S_IFLNK|S_IRWXUGO),
-	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
-	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
-	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
+	LNK(PROC_TGID_CWD,     "cwd",     cwd),
+	LNK(PROC_TGID_ROOT,    "root",    root),
+	LNK(PROC_TGID_EXE,     "exe",     exe),
+	REG(PROC_TGID_MOUNTS,  "mounts",  S_IRUGO, mounts),
 #ifdef CONFIG_MMU
-	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),
+	REG(PROC_TGID_SMAPS,   "smaps",   S_IRUGO, smaps),
 #endif
 #ifdef CONFIG_SECURITY
-	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
+	DIR(PROC_TGID_ATTR,    "attr",    S_IRUGO|S_IXUGO, tgid_attr),
 #endif
 #ifdef CONFIG_KALLSYMS
-	E(PROC_TGID_WCHAN,     "wchan",   S_IFREG|S_IRUGO),
+	INF(PROC_TGID_WCHAN,   "wchan",   S_IRUGO, pid_wchan),
 #endif
 #ifdef CONFIG_SCHEDSTATS
-	E(PROC_TGID_SCHEDSTAT, "schedstat", S_IFREG|S_IRUGO),
+	INF(PROC_TGID_SCHEDSTAT, "schedstat", S_IRUGO, pid_schedstat),
 #endif
 #ifdef CONFIG_CPUSETS
-	E(PROC_TGID_CPUSET,    "cpuset",  S_IFREG|S_IRUGO),
+	REG(PROC_TGID_CPUSET,  "cpuset",  S_IRUGO, cpuset),
 #endif
-	E(PROC_TGID_OOM_SCORE, "oom_score",S_IFREG|S_IRUGO),
-	E(PROC_TGID_OOM_ADJUST,"oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
+	INF(PROC_TGID_OOM_SCORE, "oom_score", S_IRUGO, oom_score),
+	REG(PROC_TGID_OOM_ADJUST,"oom_adj", S_IRUGO|S_IWUSR, oom_adjust),
 #ifdef CONFIG_AUDITSYSCALL
-	E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
+	REG(PROC_TGID_LOGINUID, "loginuid", S_IWUSR|S_IRUGO, loginuid),
 #endif
-	{0,0,NULL,0}
+	{}
 };
 
 static int proc_tgid_base_readdir(struct file * filp,
@@ -2050,46 +1924,46 @@ int proc_pid_readdir(struct file * filp,
  * Tasks
  */
 static struct pid_entry tid_base_stuff[] = {
-	E(PROC_TID_FD,         "fd",      S_IFDIR|S_IRUSR|S_IXUSR),
-	E(PROC_TID_ENVIRON,    "environ", S_IFREG|S_IRUSR),
-	E(PROC_TID_AUXV,       "auxv",	  S_IFREG|S_IRUSR),
-	E(PROC_TID_STATUS,     "status",  S_IFREG|S_IRUGO),
-	E(PROC_TID_CMDLINE,    "cmdline", S_IFREG|S_IRUGO),
-	E(PROC_TID_STAT,       "stat",    S_IFREG|S_IRUGO),
-	E(PROC_TID_STATM,      "statm",   S_IFREG|S_IRUGO),
-	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUGO),
+	DIR(PROC_TID_FD,       "fd",      S_IRUSR|S_IXUSR, fd),
+	INF(PROC_TID_ENVIRON,  "environ", S_IRUSR, pid_environ),
+	INF(PROC_TID_AUXV,     "auxv",	  S_IRUSR, pid_auxv),
+	INF(PROC_TID_STATUS,   "status",  S_IRUGO, pid_status),
+	INF(PROC_TID_CMDLINE,  "cmdline", S_IRUGO, pid_cmdline),
+	INF(PROC_TID_STAT,     "stat",    S_IRUGO, tid_stat),
+	INF(PROC_TID_STATM,    "statm",   S_IRUGO, pid_statm),
+	REG(PROC_TID_MAPS,     "maps",    S_IRUGO, maps),
 #ifdef CONFIG_NUMA
-	E(PROC_TID_NUMA_MAPS,  "numa_maps",    S_IFREG|S_IRUGO),
+	REG(PROC_TID_NUMA_MAPS, "numa_maps", S_IRUGO, numa_maps),
 #endif
-	E(PROC_TID_MEM,        "mem",     S_IFREG|S_IRUSR|S_IWUSR),
+	REG(PROC_TID_MEM,      "mem",     S_IRUSR|S_IWUSR, mem),
 #ifdef CONFIG_SECCOMP
-	E(PROC_TID_SECCOMP,    "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
+	REG(PROC_TID_SECCOMP,  "seccomp", S_IRUSR|S_IWUSR, seccomp),
 #endif
-	E(PROC_TID_CWD,        "cwd",     S_IFLNK|S_IRWXUGO),
-	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
-	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
-	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
+	LNK(PROC_TID_CWD,      "cwd",     cwd),
+	LNK(PROC_TID_ROOT,     "root",    root),
+	LNK(PROC_TID_EXE,      "exe",     exe),
+	REG(PROC_TID_MOUNTS,   "mounts",  S_IRUGO, mounts),
 #ifdef CONFIG_MMU
-	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
+	REG(PROC_TID_SMAPS,    "smaps",   S_IRUGO, smaps),
 #endif
 #ifdef CONFIG_SECURITY
-	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
+	DIR(PROC_TID_ATTR,     "attr",    S_IRUGO|S_IXUGO, tid_attr),
 #endif
 #ifdef CONFIG_KALLSYMS
-	E(PROC_TID_WCHAN,      "wchan",   S_IFREG|S_IRUGO),
+	INF(PROC_TID_WCHAN,    "wchan",   S_IRUGO, pid_wchan),
 #endif
 #ifdef CONFIG_SCHEDSTATS
-	E(PROC_TID_SCHEDSTAT, "schedstat",S_IFREG|S_IRUGO),
+	INF(PROC_TID_SCHEDSTAT, "schedstat", S_IRUGO, pid_schedstat),
 #endif
 #ifdef CONFIG_CPUSETS
-	E(PROC_TID_CPUSET,     "cpuset",  S_IFREG|S_IRUGO),
+	REG(PROC_TID_CPUSET,   "cpuset",  S_IRUGO, cpuset),
 #endif
-	E(PROC_TID_OOM_SCORE,  "oom_score",S_IFREG|S_IRUGO),
-	E(PROC_TID_OOM_ADJUST, "oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
+	INF(PROC_TID_OOM_SCORE, "oom_score", S_IRUGO, oom_score),
+	REG(PROC_TID_OOM_ADJUST, "oom_adj", S_IRUGO|S_IWUSR, oom_adjust),
 #ifdef CONFIG_AUDITSYSCALL
-	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
+	REG(PROC_TID_LOGINUID, "loginuid", S_IWUSR|S_IRUGO, loginuid),
 #endif
-	{0,0,NULL,0}
+	{}
 };
 
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index f6b491f..561db5f 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -243,13 +243,15 @@ static inline void kclist_add(struct kco
 extern void kclist_add(struct kcore_list *, void *, size_t);
 #endif
 
+union proc_op {
+	int (*proc_get_link)(struct inode *, struct dentry **, struct vfsmount **);
+	int (*proc_read)(struct task_struct *task, char *page);
+};
+
 struct proc_inode {
 	struct task_ref *tref;
 	int fd;
-	union {
-		int (*proc_get_link)(struct inode *, struct dentry **, struct vfsmount **);
-		int (*proc_read)(struct task_struct *task, char *page);
-	} op;
+	union proc_op op;
 	struct proc_dir_entry *pde;
 	struct inode vfs_inode;
 };
-- 
1.2.2.g709a

