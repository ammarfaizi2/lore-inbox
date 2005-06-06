Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVFFRD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVFFRD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 13:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVFFRDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 13:03:25 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:40711 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261254AbVFFRCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 13:02:03 -0400
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] file position info in /proc
Message-Id: <E1DfKz1-00013b-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 06 Jun 2005 19:01:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for finding out the current file position of
an open file through the proc filesystem.  These new entries are
added:

  /proc/PID/fdinfo/FD/pos
  /proc/PID/task/TID/fdinfo/FD/pos

Various other (simpler) approaches would be possible:

  a) return file position in st_size if lstat() is called on
     /proc/PID/fd/FD (suggested by lsof FAQ)

  b) list the open files and current positions in a single proc file
     (e.g. /proc/PID/fdpos)

I don't really like a) because it uses the file size information for
something else.  b) has the problem of not scaling well to large
number of file descriptors, if the user only wants information for a
single descriptor.

The 'fdinfo' approach also has the advantage of being easily
extensible.  For example if the "autonomous mount trees" patches make
it to the kernel, there would be a need to get mount tree information
for each open file.

The inode number assignment looks like this:

  procfile                          ino
  --------                          ---
  /proc/PID/fd/FD                   (PID << 16) + 0x8000 + FD
  /proc/PID/fdinfo/FD               (PID << 16) + 0xc000 + FD * 8
  /proc/PID/fdinfo/FD/pos           (PID << 16) + 0xc000 + FD * 8 + 1

It is obvious that if a process has large number of file descriptors
(or just a large maximal fd) then inode numbers will clash.  This is
nothing new, the previous limit of 32768 can easily be exceeded with
appropriate limits.  Now this goes down to 2048, before possible
clashing.

If there is an inode number clash, nothing bad happens, just the inums
won't be unique anymore.  I really can't think of solving this in a
fundamentally better way.  Suggestions welcome.

Patch is against 2.6.12-rc5, but applies to any recent kernel.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---
 base.c |  284 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 241 insertions(+), 43 deletions(-)

Index: linux/fs/proc/base.c
===================================================================
--- linux.orig/fs/proc/base.c	2005-06-06 13:51:40.000000000 +0200
+++ linux/fs/proc/base.c	2005-06-06 13:59:00.000000000 +0200
@@ -83,9 +83,9 @@ enum pid_directory_inos {
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TGID_LOGINUID,
 #endif
-	PROC_TGID_FD_DIR,
 	PROC_TGID_OOM_SCORE,
 	PROC_TGID_OOM_ADJUST,
+	PROC_TGID_FDINFO,
 	PROC_TID_INO,
 	PROC_TID_STATUS,
 	PROC_TID_MEM,
@@ -120,11 +120,19 @@ enum pid_directory_inos {
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TID_LOGINUID,
 #endif
-	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,
+	PROC_TID_FDINFO,
+
+	/* Add new entries before this */
+	PROC_TID_FD_DIR = 0x8000,		/* /proc/PID/fd/FD     */
+	PROC_TID_FDINFO_DIR = 0xc000,		/* /proc/PID/fdinfo/FD */
+
+	PROC_FDINFO_POS = 1,			/* /proc/PID/fdinfo/FD/pos */
 };
 
+#define PROC_TID_FDINFO_MUL 8
+
 struct pid_entry {
 	int type;
 	int len;
@@ -137,6 +145,7 @@ struct pid_entry {
 static struct pid_entry tgid_base_stuff[] = {
 	E(PROC_TGID_TASK,      "task",    S_IFDIR|S_IRUGO|S_IXUGO),
 	E(PROC_TGID_FD,        "fd",      S_IFDIR|S_IRUSR|S_IXUSR),
+	E(PROC_TGID_FDINFO,    "fdinfo",  S_IFDIR|S_IRUSR|S_IXUSR),
 	E(PROC_TGID_ENVIRON,   "environ", S_IFREG|S_IRUSR),
 	E(PROC_TGID_AUXV,      "auxv",	  S_IFREG|S_IRUSR),
 	E(PROC_TGID_STATUS,    "status",  S_IFREG|S_IRUGO),
@@ -173,6 +182,7 @@ static struct pid_entry tgid_base_stuff[
 };
 static struct pid_entry tid_base_stuff[] = {
 	E(PROC_TID_FD,         "fd",      S_IFDIR|S_IRUSR|S_IXUSR),
+	E(PROC_TID_FDINFO,     "fdinfo",  S_IFDIR|S_IRUSR|S_IXUSR),
 	E(PROC_TID_ENVIRON,    "environ", S_IFREG|S_IRUSR),
 	E(PROC_TID_AUXV,       "auxv",	  S_IFREG|S_IRUSR),
 	E(PROC_TID_STATUS,     "status",  S_IFREG|S_IRUGO),
@@ -225,22 +235,52 @@ static struct pid_entry tid_attr_stuff[]
 };
 #endif
 
+static struct pid_entry fdinfo_base_stuff[] = {
+	E(PROC_FDINFO_POS,     "pos",     S_IFREG|S_IRUGO),
+	{0,0,NULL,0}
+};
+
 #undef E
 
-static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
+static struct pid_entry *proc_pident_find(struct pid_entry *ents,
+					  struct task_struct *task,
+					  struct dentry *dentry)
+{
+	struct pid_entry *p;
+
+	if (!pid_alive(task))
+		return NULL;
+
+	for (p = ents; p->name; p++) {
+		if (p->len != dentry->d_name.len)
+			continue;
+		if (!memcmp(dentry->d_name.name, p->name, p->len))
+			break;
+	}
+	if (!p->name)
+		return NULL;
+
+	return p;
+}
+
+static int proc_fd_info(struct inode *inode, int fd, struct dentry **dentry,
+			struct vfsmount **mnt, loff_t *pos)
 {
 	struct task_struct *task = proc_task(inode);
 	struct files_struct *files;
 	struct file *file;
-	int fd = proc_type(inode) - PROC_TID_FD_DIR;
 
 	files = get_files_struct(task);
 	if (files) {
 		spin_lock(&files->file_lock);
 		file = fcheck_files(files, fd);
 		if (file) {
-			*mnt = mntget(file->f_vfsmnt);
-			*dentry = dget(file->f_dentry);
+			if (mnt)
+				*mnt = mntget(file->f_vfsmnt);
+			if (dentry)
+				*dentry = dget(file->f_dentry);
+			if (pos)
+				*pos = file->f_pos;
 			spin_unlock(&files->file_lock);
 			put_files_struct(files);
 			return 0;
@@ -251,6 +291,13 @@ static int proc_fd_link(struct inode *in
 	return -ENOENT;
 }
 
+static int proc_fd_link(struct inode *inode, struct dentry **dentry,
+			struct vfsmount **mnt)
+{
+	int fd = proc_type(inode) - PROC_TID_FD_DIR;
+	return proc_fd_info(inode, fd, dentry, mnt, NULL);
+}
+
 static int proc_cwd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
 	struct fs_struct *fs;
@@ -970,7 +1017,24 @@ static struct inode_operations proc_pid_
 
 #define NUMBUF 10
 
-static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
+static int get_fd_ino(unsigned int fd, int isfdinfo)
+{
+	if (isfdinfo)
+		return PROC_TID_FDINFO_DIR + fd * PROC_TID_FDINFO_MUL;
+	else
+		return PROC_TID_FD_DIR + fd;
+}
+
+static int get_ino_fd(int ino, int isfdinfo)
+{
+	if (isfdinfo)
+		return (ino - PROC_TID_FDINFO_DIR) / PROC_TID_FDINFO_MUL;
+	else
+		return ino - PROC_TID_FD_DIR;
+}
+
+static int proc_readfd_common(struct file * filp, void * dirent,
+			      filldir_t filldir, int isfdinfo)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct task_struct *p = proc_task(inode);
@@ -1018,8 +1082,8 @@ static int proc_readfd(struct file * fil
 					i /= 10;
 				} while (i);
 
-				ino = fake_ino(tid, PROC_TID_FD_DIR + fd);
-				if (filldir(dirent, buf+j, NUMBUF-j, fd+2, ino, DT_LNK) < 0) {
+				ino = fake_ino(tid, get_fd_ino(fd, isfdinfo));
+				if (filldir(dirent, buf+j, NUMBUF-j, fd+2, ino, isfdinfo ? DT_DIR : DT_LNK) < 0) {
 					spin_lock(&files->file_lock);
 					break;
 				}
@@ -1032,9 +1096,35 @@ out:
 	return retval;
 }
 
+static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
+{
+	return proc_readfd_common(filp, dirent, filldir, 0);
+}
+
+static int proc_readfdinfo(struct file * filp, void * dirent, filldir_t filldir)
+{
+	return proc_readfd_common(filp, dirent, filldir, 1);
+}
+
+static int get_num_fd(struct task_struct *task)
+{
+	int num_fd = 0;
+	struct files_struct *files = get_files_struct(task);
+	if (files) {
+		int fd;
+		spin_lock(&files->file_lock);
+		for (fd = 0; fd < files->max_fds; fd++)
+			if (fcheck_files(files, fd))
+				num_fd++;
+		spin_unlock(&files->file_lock);
+		put_files_struct(files);
+	}
+	return num_fd;
+}
+
 static int proc_pident_readdir(struct file *filp,
 		void *dirent, filldir_t filldir,
-		struct pid_entry *ents, unsigned int nents)
+		struct pid_entry *ents, unsigned int nents, int offset)
 {
 	int i;
 	int pid;
@@ -1075,7 +1165,8 @@ static int proc_pident_readdir(struct fi
 		p = ents + i;
 		while (p->name) {
 			if (filldir(dirent, p->name, p->len, filp->f_pos,
-				    fake_ino(pid, p->type), p->mode >> 12) < 0)
+				    fake_ino(pid, p->type + offset),
+				    p->mode >> 12) < 0)
 				goto out;
 			filp->f_pos++;
 			p++;
@@ -1090,15 +1181,15 @@ out:
 static int proc_tgid_base_readdir(struct file * filp,
 			     void * dirent, filldir_t filldir)
 {
-	return proc_pident_readdir(filp,dirent,filldir,
-				   tgid_base_stuff,ARRAY_SIZE(tgid_base_stuff));
+	return proc_pident_readdir(filp, dirent, filldir, tgid_base_stuff,
+				   ARRAY_SIZE(tgid_base_stuff), 0);
 }
 
 static int proc_tid_base_readdir(struct file * filp,
 			     void * dirent, filldir_t filldir)
 {
-	return proc_pident_readdir(filp,dirent,filldir,
-				   tid_base_stuff,ARRAY_SIZE(tid_base_stuff));
+	return proc_pident_readdir(filp, dirent, filldir, tid_base_stuff,
+				   ARRAY_SIZE(tid_base_stuff), 0);
 }
 
 /* building an inode */
@@ -1193,7 +1284,8 @@ static int tid_fd_revalidate(struct dent
 {
 	struct inode *inode = dentry->d_inode;
 	struct task_struct *task = proc_task(inode);
-	int fd = proc_type(inode) - PROC_TID_FD_DIR;
+	struct proc_inode *ei = PROC_I(inode);
+	int fd = get_ino_fd(proc_type(inode), ei->op.proc_get_link == NULL);
 	struct files_struct *files;
 
 	files = get_files_struct(task);
@@ -1281,8 +1373,84 @@ out:
 	return ~0U;
 }
 
+static ssize_t proc_fdinfo_pos_read(struct file * file, char __user * buf,
+				    size_t count, loff_t *ppos)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+	int fd = get_ino_fd(proc_type(inode), 1);
+	loff_t pos;
+	int res = proc_fd_info(inode, fd, NULL, NULL, &pos);
+	if (!res) {
+		char tmpbuf[32];
+		unsigned int len = sprintf(tmpbuf, "%lli\n", pos);
+		res = simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
+	}
+	return res;
+}
+
+static struct file_operations proc_fdinfo_pos_file_operations = {
+	.read		= proc_fdinfo_pos_read,
+};
+
+static struct dentry *proc_fdinfo_base_lookup(struct inode *dir,
+					      struct dentry *dentry,
+					      struct nameidata *nd)
+{
+	struct inode *inode;
+	int error;
+	struct task_struct *task = proc_task(dir);
+	struct pid_entry *p;
+	struct proc_inode *ei;
+	int dirino;
+
+	error = -ENOENT;
+	p = proc_pident_find(fdinfo_base_stuff, task, dentry);
+	if (!p)
+		goto out;
+
+	error = -EINVAL;
+	dirino = proc_type(dir);
+	inode = proc_pid_make_inode(dir->i_sb, task, dirino + p->type);
+	if (!inode)
+		goto out;
+
+	ei = PROC_I(inode);
+	inode->i_mode = p->mode;
+	
+	switch (p->type) {
+	case PROC_FDINFO_POS:
+		inode->i_fop = &proc_fdinfo_pos_file_operations;
+		break;
+	default:
+		BUG();
+	}
+	dentry->d_op = &tid_fd_dentry_operations;
+	d_add(dentry, inode);
+	return NULL;
+
+out:
+	return ERR_PTR(error);
+}
+
+static struct inode_operations proc_fdinfo_base_inode_operations = {
+	.lookup		= proc_fdinfo_base_lookup,
+};
+
+static int proc_fdinfo_base_readdir(struct file * filp,
+				    void * dirent, filldir_t filldir)
+{
+	int base_ino = filp->f_dentry->d_inode->i_ino;
+	return proc_pident_readdir(filp, dirent, filldir, fdinfo_base_stuff,
+				   ARRAY_SIZE(fdinfo_base_stuff), base_ino);
+}
+
+static struct file_operations proc_fdinfo_base_operations = {
+	.read		= generic_read_dir,
+	.readdir	= proc_fdinfo_base_readdir,
+};
+
 /* SMP-safe */
-static struct dentry *proc_lookupfd(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
+static struct dentry *proc_lookupfd_common(struct inode * dir, struct dentry * dentry, int isfdinfo)
 {
 	struct task_struct *task = proc_task(dir);
 	unsigned fd = name_to_int(dentry);
@@ -1296,27 +1464,38 @@ static struct dentry *proc_lookupfd(stru
 	if (!pid_alive(task))
 		goto out;
 
-	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TID_FD_DIR+fd);
+	inode = proc_pid_make_inode(dir->i_sb, task, get_fd_ino(fd, isfdinfo));
 	if (!inode)
 		goto out;
 	ei = PROC_I(inode);
 	files = get_files_struct(task);
 	if (!files)
 		goto out_unlock;
-	inode->i_mode = S_IFLNK;
 	spin_lock(&files->file_lock);
 	file = fcheck_files(files, fd);
 	if (!file)
 		goto out_unlock2;
-	if (file->f_mode & 1)
-		inode->i_mode |= S_IRUSR | S_IXUSR;
-	if (file->f_mode & 2)
-		inode->i_mode |= S_IWUSR | S_IXUSR;
+	if (isfdinfo)
+		inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	else {
+		inode->i_mode = S_IFLNK;
+		if (file->f_mode & 1)
+			inode->i_mode |= S_IRUSR | S_IXUSR;
+		if (file->f_mode & 2)
+			inode->i_mode |= S_IWUSR | S_IXUSR;
+	}
 	spin_unlock(&files->file_lock);
 	put_files_struct(files);
-	inode->i_op = &proc_pid_link_inode_operations;
-	inode->i_size = 64;
-	ei->op.proc_get_link = proc_fd_link;
+	if (isfdinfo) {
+		inode->i_op = &proc_fdinfo_base_inode_operations;
+		inode->i_fop = &proc_fdinfo_base_operations;
+		inode->i_nlink = 2;
+		inode->i_flags |= S_IMMUTABLE;
+	} else {
+		inode->i_op = &proc_pid_link_inode_operations;
+		inode->i_size = 64;
+		ei->op.proc_get_link = proc_fd_link;
+	}
 	dentry->d_op = &tid_fd_dentry_operations;
 	d_add(dentry, inode);
 	return NULL;
@@ -1330,6 +1509,19 @@ out:
 	return ERR_PTR(-ENOENT);
 }
 
+static struct dentry *proc_lookupfd(struct inode * dir, struct dentry * dentry,
+				    struct nameidata *nd)
+{
+	return proc_lookupfd_common(dir, dentry, 0);
+}
+
+static struct dentry *proc_lookupfdinfo(struct inode * dir,
+					struct dentry * dentry,
+					struct nameidata *nd)
+{
+	return proc_lookupfd_common(dir, dentry, 1);
+}
+
 static int proc_task_readdir(struct file * filp, void * dirent, filldir_t filldir);
 static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd);
 
@@ -1338,6 +1530,11 @@ static struct file_operations proc_fd_op
 	.readdir	= proc_readfd,
 };
 
+static struct file_operations proc_fdinfo_operations = {
+	.read		= generic_read_dir,
+	.readdir	= proc_readfdinfo,
+};
+
 static struct file_operations proc_task_operations = {
 	.read		= generic_read_dir,
 	.readdir	= proc_task_readdir,
@@ -1351,6 +1548,11 @@ static struct inode_operations proc_fd_i
 	.permission	= proc_permission,
 };
 
+static struct inode_operations proc_fdinfo_inode_operations = {
+	.lookup		= proc_lookupfdinfo,
+	.permission	= proc_permission,
+};
+
 static struct inode_operations proc_task_inode_operations = {
 	.lookup		= proc_task_lookup,
 	.permission	= proc_permission,
@@ -1422,7 +1624,7 @@ static struct inode_operations proc_tgid
 static int get_tid_list(int index, unsigned int *tids, struct inode *dir);
 
 /* SMP-safe */
-static struct dentry *proc_pident_lookup(struct inode *dir, 
+static struct dentry *proc_pident_lookup(struct inode *dir,
 					 struct dentry *dentry,
 					 struct pid_entry *ents)
 {
@@ -1433,18 +1635,8 @@ static struct dentry *proc_pident_lookup
 	struct proc_inode *ei;
 
 	error = -ENOENT;
-	inode = NULL;
-
-	if (!pid_alive(task))
-		goto out;
-
-	for (p = ents; p->name; p++) {
-		if (p->len != dentry->d_name.len)
-			continue;
-		if (!memcmp(dentry->d_name.name, p->name, p->len))
-			break;
-	}
-	if (!p->name)
+	p = proc_pident_find(ents, task, dentry);
+	if (!p)
 		goto out;
 
 	error = -EINVAL;
@@ -1470,6 +1662,12 @@ static struct dentry *proc_pident_lookup
 			inode->i_op = &proc_fd_inode_operations;
 			inode->i_fop = &proc_fd_operations;
 			break;
+		case PROC_TID_FDINFO:
+		case PROC_TGID_FDINFO:
+			inode->i_nlink = 2 + get_num_fd(task);
+			inode->i_op = &proc_fdinfo_inode_operations;
+			inode->i_fop = &proc_fdinfo_operations;
+			break;
 		case PROC_TID_EXE:
 		case PROC_TGID_EXE:
 			inode->i_op = &proc_pid_link_inode_operations;
@@ -1637,15 +1835,15 @@ static struct inode_operations proc_tid_
 static int proc_tgid_attr_readdir(struct file * filp,
 			     void * dirent, filldir_t filldir)
 {
-	return proc_pident_readdir(filp,dirent,filldir,
-				   tgid_attr_stuff,ARRAY_SIZE(tgid_attr_stuff));
+	return proc_pident_readdir(filp, dirent, filldir, tgid_attr_stuff,
+				   ARRAY_SIZE(tgid_attr_stuff), 0);
 }
 
 static int proc_tid_attr_readdir(struct file * filp,
 			     void * dirent, filldir_t filldir)
 {
-	return proc_pident_readdir(filp,dirent,filldir,
-				   tid_attr_stuff,ARRAY_SIZE(tid_attr_stuff));
+	return proc_pident_readdir(filp, dirent, filldir, tid_attr_stuff,
+				   ARRAY_SIZE(tid_attr_stuff), 0);
 }
 
 static struct file_operations proc_tgid_attr_operations = {
