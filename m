Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314703AbSDTR7Q>; Sat, 20 Apr 2002 13:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314704AbSDTR7P>; Sat, 20 Apr 2002 13:59:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:21959 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314703AbSDTR6m>;
	Sat, 20 Apr 2002 13:58:42 -0400
Date: Sat, 20 Apr 2002 13:58:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [CFT][PATCH] (5/5) sane procfs/dcache interaction
In-Reply-To: <Pine.GSO.4.21.0204201357470.25383-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0204201358140.25383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -urN C8-file/fs/proc/base.c C8-procfs/fs/proc/base.c
--- C8-file/fs/proc/base.c	Fri Apr 19 02:11:56 2002
+++ C8-procfs/fs/proc/base.c	Fri Apr 19 01:20:20 2002
@@ -88,6 +88,11 @@
 	return PROC_I(inode)->task;
 }
 
+static inline int proc_type(struct inode *inode)
+{
+	return PROC_I(inode)->type;
+}
+
 ssize_t proc_pid_read_maps(struct task_struct*,struct file*,char*,size_t,loff_t*);
 int proc_pid_stat(struct task_struct*,char*);
 int proc_pid_status(struct task_struct*,char*);
@@ -99,7 +104,7 @@
 	struct task_struct *task = proc_task(inode);
 	struct files_struct *files;
 	struct file *file;
-	int fd = (inode->i_ino & 0xffff) - PROC_PID_FD_DIR;
+	int fd = proc_type(inode) - PROC_PID_FD_DIR;
 
 	task_lock(task);
 	files = task->files;
@@ -735,6 +740,7 @@
 	 */
 	get_task_struct(task);
 	ei->task = task;
+	ei->type = ino;
 	inode->i_uid = 0;
 	inode->i_gid = 0;
 	if (ino == PROC_PID_INO || task_dumpable(task)) {
@@ -753,11 +759,6 @@
 
 /* dentry stuff */
 
-static int pid_fd_revalidate(struct dentry * dentry, int flags)
-{
-	return 0;
-}
-
 /*
  *	Exceptional case: normally we are not allowed to unhash a busy
  * directory. In this case, however, we can do it - no aliasing problems
@@ -771,6 +772,31 @@
 	return 0;
 }
 
+static int pid_fd_revalidate(struct dentry * dentry, int flags)
+{
+	struct task_struct *task = proc_task(dentry->d_inode);
+	int fd = proc_type(dentry->d_inode) - PROC_PID_FD_DIR;
+	struct files_struct *files;
+
+	task_lock(task);
+	files = task->files;
+	if (files)
+		atomic_inc(&files->count);
+	task_unlock(task);
+	if (files) {
+		read_lock(&files->file_lock);
+		if (fcheck_files(files, fd)) {
+			read_unlock(&files->file_lock);
+			put_files_struct(files);
+			return 1;
+		}
+		read_unlock(&files->file_lock);
+		put_files_struct(files);
+	}
+	d_drop(dentry);
+	return 0;
+}
+
 static void pid_base_iput(struct dentry *dentry, struct inode *inode)
 {
 	struct task_struct *task = proc_task(inode);
@@ -781,11 +807,6 @@
 	iput(inode);
 }
 
-static int pid_fd_delete_dentry(struct dentry * dentry)
-{
-	return 1;
-}
-
 static int pid_delete_dentry(struct dentry * dentry)
 {
 	return proc_task(dentry->d_inode)->pid == 0;
@@ -794,7 +815,7 @@
 static struct dentry_operations pid_fd_dentry_operations =
 {
 	d_revalidate:	pid_fd_revalidate,
-	d_delete:	pid_fd_delete_dentry,
+	d_delete:	pid_delete_dentry,
 };
 
 static struct dentry_operations pid_dentry_operations =
@@ -879,8 +900,8 @@
 	return NULL;
 
 out_unlock2:
-	put_files_struct(files);
 	read_unlock(&files->file_lock);
+	put_files_struct(files);
 out_unlock:
 	iput(inode);
 out:


