Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314667AbSDTSAG>; Sat, 20 Apr 2002 14:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314706AbSDTR7Z>; Sat, 20 Apr 2002 13:59:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10438 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314701AbSDTR6K>;
	Sat, 20 Apr 2002 13:58:10 -0400
Date: Sat, 20 Apr 2002 13:58:09 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [CFT][PATCH] (4/5) sane procfs/dcache interaction
In-Reply-To: <Pine.GSO.4.21.0204201357220.25383-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0204201357470.25383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -urN C8-retain_dentry/fs/proc/base.c C8-current/fs/proc/base.c
--- C8-retain_dentry/fs/proc/base.c	Fri Apr 19 01:17:36 2002
+++ C8-current/fs/proc/base.c	Fri Apr 19 01:39:23 2002
@@ -37,6 +37,52 @@
 
 #define fake_ino(pid,ino) (((pid)<<16)|(ino))
 
+enum pid_directory_inos {
+	PROC_PID_INO = 2,
+	PROC_PID_STATUS,
+	PROC_PID_MEM,
+	PROC_PID_CWD,
+	PROC_PID_ROOT,
+	PROC_PID_EXE,
+	PROC_PID_FD,
+	PROC_PID_ENVIRON,
+	PROC_PID_CMDLINE,
+	PROC_PID_STAT,
+	PROC_PID_STATM,
+	PROC_PID_MAPS,
+	PROC_PID_CPU,
+	PROC_PID_MOUNTS,
+	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
+};
+
+struct pid_entry {
+	int type;
+	int len;
+	char *name;
+	mode_t mode;
+};
+
+#define E(type,name,mode) {(type),sizeof(name)-1,(name),(mode)}
+static struct pid_entry base_stuff[] = {
+  E(PROC_PID_FD,	"fd",		S_IFDIR|S_IRUSR|S_IXUSR),
+  E(PROC_PID_ENVIRON,	"environ",	S_IFREG|S_IRUSR),
+  E(PROC_PID_STATUS,	"status",	S_IFREG|S_IRUGO),
+  E(PROC_PID_CMDLINE,	"cmdline",	S_IFREG|S_IRUGO),
+  E(PROC_PID_STAT,	"stat",		S_IFREG|S_IRUGO),
+  E(PROC_PID_STATM,	"statm",	S_IFREG|S_IRUGO),
+#ifdef CONFIG_SMP
+  E(PROC_PID_CPU,	"cpu",		S_IFREG|S_IRUGO),
+#endif
+  E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUGO),
+  E(PROC_PID_MEM,	"mem",		S_IFREG|S_IRUSR|S_IWUSR),
+  E(PROC_PID_CWD,	"cwd",		S_IFLNK|S_IRWXUGO),
+  E(PROC_PID_ROOT,	"root",		S_IFLNK|S_IRWXUGO),
+  E(PROC_PID_EXE,	"exe",		S_IFLNK|S_IRWXUGO),
+  E(PROC_PID_MOUNTS,	"mounts",	S_IFREG|S_IRUGO),
+  {0,0,NULL,0}
+};
+#undef E
+
 static inline struct task_struct *proc_task(struct inode *inode)
 {
 	return PROC_I(inode)->task;
@@ -50,11 +96,28 @@
 
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
-	struct file *file = PROC_I(inode)->file;
-	if (file) {
-		*mnt = mntget(file->f_vfsmnt);
-		*dentry = dget(file->f_dentry);
-		return 0;
+	struct task_struct *task = proc_task(inode);
+	struct files_struct *files;
+	struct file *file;
+	int fd = (inode->i_ino & 0xffff) - PROC_PID_FD_DIR;
+
+	task_lock(task);
+	files = task->files;
+	if (files)
+		atomic_inc(&files->count);
+	task_unlock(task);
+	if (files) {
+		read_lock(&files->file_lock);
+		file = fcheck_files(files, fd);
+		if (file) {
+			*mnt = mntget(file->f_vfsmnt);
+			*dentry = dget(file->f_dentry);
+			read_unlock(&files->file_lock);
+			put_files_struct(files);
+			return 0;
+		}
+		read_unlock(&files->file_lock);
+		put_files_struct(files);
 	}
 	return -ENOENT;
 }
@@ -525,52 +588,6 @@
 	follow_link:	proc_pid_follow_link
 };
 
-struct pid_entry {
-	int type;
-	int len;
-	char *name;
-	mode_t mode;
-};
-
-enum pid_directory_inos {
-	PROC_PID_INO = 2,
-	PROC_PID_STATUS,
-	PROC_PID_MEM,
-	PROC_PID_CWD,
-	PROC_PID_ROOT,
-	PROC_PID_EXE,
-	PROC_PID_FD,
-	PROC_PID_ENVIRON,
-	PROC_PID_CMDLINE,
-	PROC_PID_STAT,
-	PROC_PID_STATM,
-	PROC_PID_MAPS,
-	PROC_PID_CPU,
-	PROC_PID_MOUNTS,
-	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
-};
-
-#define E(type,name,mode) {(type),sizeof(name)-1,(name),(mode)}
-static struct pid_entry base_stuff[] = {
-  E(PROC_PID_FD,	"fd",		S_IFDIR|S_IRUSR|S_IXUSR),
-  E(PROC_PID_ENVIRON,	"environ",	S_IFREG|S_IRUSR),
-  E(PROC_PID_STATUS,	"status",	S_IFREG|S_IRUGO),
-  E(PROC_PID_CMDLINE,	"cmdline",	S_IFREG|S_IRUGO),
-  E(PROC_PID_STAT,	"stat",		S_IFREG|S_IRUGO),
-  E(PROC_PID_STATM,	"statm",	S_IFREG|S_IRUGO),
-#ifdef CONFIG_SMP
-  E(PROC_PID_CPU,	"cpu",		S_IFREG|S_IRUGO),
-#endif
-  E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUGO),
-  E(PROC_PID_MEM,	"mem",		S_IFREG|S_IRUSR|S_IWUSR),
-  E(PROC_PID_CWD,	"cwd",		S_IFLNK|S_IRWXUGO),
-  E(PROC_PID_ROOT,	"root",		S_IFLNK|S_IRWXUGO),
-  E(PROC_PID_EXE,	"exe",		S_IFLNK|S_IRWXUGO),
-  E(PROC_PID_MOUNTS,	"mounts",	S_IFREG|S_IRUGO),
-  {0,0,NULL,0}
-};
-#undef E
-
 #define NUMBUF 10
 
 static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
@@ -707,7 +724,6 @@
 	/* Common stuff */
 	ei = PROC_I(inode);
 	ei->task = NULL;
-	ei->file = NULL;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_ino = fake_ino(task->pid, ino);
 
@@ -842,21 +858,20 @@
 	task_unlock(task);
 	if (!files)
 		goto out_unlock;
+	inode->i_mode = S_IFLNK;
 	read_lock(&files->file_lock);
-	file = ei->file = fcheck_files(files, fd);
+	file = fcheck_files(files, fd);
 	if (!file)
 		goto out_unlock2;
-	get_file(file);
+	if (file->f_mode & 1)
+		inode->i_mode |= S_IRUSR | S_IXUSR;
+	if (file->f_mode & 2)
+		inode->i_mode |= S_IWUSR | S_IXUSR;
 	read_unlock(&files->file_lock);
 	put_files_struct(files);
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
-	inode->i_mode = S_IFLNK;
 	ei->op.proc_get_link = proc_fd_link;
-	if (file->f_mode & 1)
-		inode->i_mode |= S_IRUSR | S_IXUSR;
-	if (file->f_mode & 2)
-		inode->i_mode |= S_IWUSR | S_IXUSR;
 	dentry->d_op = &pid_fd_dentry_operations;
 	d_add(dentry, inode);
 	if (!proc_task(dentry->d_inode)->pid)
@@ -1078,8 +1093,6 @@
 
 void proc_pid_delete_inode(struct inode *inode)
 {
-	if (PROC_I(inode)->file)
-		fput(PROC_I(inode)->file);
 	if (proc_task(inode))
 		put_task_struct(proc_task(inode));
 }
diff -urN C8-retain_dentry/include/linux/proc_fs.h C8-current/include/linux/proc_fs.h
--- C8-retain_dentry/include/linux/proc_fs.h	Sun Apr 14 17:53:12 2002
+++ C8-current/include/linux/proc_fs.h	Fri Apr 19 01:33:23 2002
@@ -212,7 +212,6 @@
 		int (*proc_get_link)(struct inode *, struct dentry **, struct vfsmount **);
 		int (*proc_read)(struct task_struct *task, char *page);
 	} op;
-	struct file *file;
 	struct proc_dir_entry *pde;
 	struct inode vfs_inode;
 };


