Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVCQQ1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVCQQ1Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 11:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVCQQ1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 11:27:23 -0500
Received: from citi.umich.edu ([141.211.133.111]:21893 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S261950AbVCQQ0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 11:26:14 -0500
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: [PATCH 1/2] VFS: New /proc file /proc/self/mountstats
Message-Id: <20050317162613.756101BB98@citi.umich.edu>
Date: Thu, 17 Mar 2005 11:26:13 -0500 (EST)
From: cel@citi.umich.edu (Chuck Lever)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Create a new file under /proc/self, called mountstats, where mounted file
 systems can export information (configuration options, performance counters,
 and so on).  Use a mechanism similar to /proc/mounts and s_ops->show_options.

 This mechanism does not violate namespace security, and is safe to use while
 other processes are unmounting file systems.

 Version: Mon, 14 Mar 2005 17:06:04 -0500
 
 Signed-off-by: Chuck Lever <cel@netapp.com>
---
 
 fs/namespace.c     |   66 +++++++++++++++++++++++++++++++++++++++++++++
 fs/proc/base.c     |   40 +++++++++++++++++++++++++++
 include/linux/fs.h |    1 
 3 files changed, 107 insertions(+)
 
 
diff -X /home/cel/src/linux/dont-diff -Naurp 00-stock/fs/namespace.c 01-mountstats/fs/namespace.c
--- 00-stock/fs/namespace.c	2005-03-02 02:38:13.000000000 -0500
+++ 01-mountstats/fs/namespace.c	2005-03-14 15:24:51.565085000 -0500
@@ -265,6 +265,72 @@ struct seq_operations mounts_op = {
 	.show	= show_vfsmnt
 };
 
+/* iterator */
+static void *ms_start(struct seq_file *m, loff_t *pos)
+{
+	struct namespace *n = m->private;
+	struct list_head *p;
+	loff_t l = *pos;
+
+	down_read(&n->sem);
+	list_for_each(p, &n->list)
+		if (!l--)
+			return list_entry(p, struct vfsmount, mnt_list);
+	return NULL;
+}
+
+static void *ms_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct namespace *n = m->private;
+	struct list_head *p = ((struct vfsmount *)v)->mnt_list.next;
+	(*pos)++;
+	return p==&n->list ? NULL : list_entry(p, struct vfsmount, mnt_list);
+}
+
+static void ms_stop(struct seq_file *m, void *v)
+{
+	struct namespace *n = m->private;
+	up_read(&n->sem);
+}
+
+static int show_vfsstat(struct seq_file *m, void *v)
+{
+	struct vfsmount *mnt = v;
+	int err = 0;
+
+	/* device */
+	if (mnt->mnt_devname) {
+		seq_puts(m, "device ");
+		mangle(m, mnt->mnt_devname);
+	} else
+		seq_puts(m, "no device");
+
+	/* mount point */
+	seq_puts(m, " mounted on ");
+	seq_path(m, mnt, mnt->mnt_root, " \t\n\\");
+	seq_putc(m, ' ');
+
+	/* file system type */
+	seq_puts(m, "with fstype ");
+	mangle(m, mnt->mnt_sb->s_type->name);
+
+	/* optional statistics */
+	if (mnt->mnt_sb->s_op->show_stats) {
+		seq_putc(m, ' ');
+		err = mnt->mnt_sb->s_op->show_stats(m, mnt);
+	}
+
+	seq_putc(m, '\n');
+	return err;
+}
+
+struct seq_operations mountstats_op = {
+	.start	= ms_start,
+	.next	= ms_next,
+	.stop	= ms_stop,
+	.show	= show_vfsstat,
+};
+
 /**
  * may_umount_tree - check if a mount tree is busy
  * @mnt: root of mount tree
diff -X /home/cel/src/linux/dont-diff -Naurp 00-stock/fs/proc/base.c 01-mountstats/fs/proc/base.c
--- 00-stock/fs/proc/base.c	2005-03-02 02:38:12.000000000 -0500
+++ 01-mountstats/fs/proc/base.c	2005-03-14 15:24:51.571085000 -0500
@@ -60,6 +60,7 @@ enum pid_directory_inos {
 	PROC_TGID_STATM,
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
+	PROC_TGID_MOUNTSTATS,
 	PROC_TGID_WCHAN,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TGID_SCHEDSTAT,
@@ -91,6 +92,7 @@ enum pid_directory_inos {
 	PROC_TID_STATM,
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
+	PROC_TID_MOUNTSTATS,
 	PROC_TID_WCHAN,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TID_SCHEDSTAT,
@@ -134,6 +136,7 @@ static struct pid_entry tgid_base_stuff[
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TGID_MOUNTSTATS, "mountstats", S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -164,6 +167,7 @@ static struct pid_entry tid_base_stuff[]
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
+	E(PROC_TID_MOUNTSTATS, "mountstats", S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -528,6 +532,38 @@ static struct file_operations proc_mount
 	.release	= mounts_release,
 };
 
+extern struct seq_operations mountstats_op;
+static int mountstats_open(struct inode *inode, struct file *file)
+{
+	struct task_struct *task = proc_task(inode);
+	int ret = seq_open(file, &mountstats_op);
+
+	if (!ret) {
+		struct seq_file *m = file->private_data;
+		struct namespace *namespace;
+		task_lock(task);
+		namespace = task->namespace;
+		if (namespace)
+			get_namespace(namespace);
+		task_unlock(task);
+
+		if (namespace)
+			m->private = namespace;
+		else {
+			seq_release(inode, file);
+			ret = -EINVAL;
+		}
+	}
+	return ret;
+}
+
+static struct file_operations proc_mountstats_operations = {
+	.open		= mountstats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= mounts_release,
+};
+
 #define PROC_BLOCK_SIZE	(3*1024)		/* 4K page size but our output routines use some slack for overruns */
 
 static ssize_t proc_info_read(struct file * file, char __user * buf,
@@ -1447,6 +1483,10 @@ static struct dentry *proc_pident_lookup
 		case PROC_TGID_MOUNTS:
 			inode->i_fop = &proc_mounts_operations;
 			break;
+		case PROC_TID_MOUNTSTATS:
+		case PROC_TGID_MOUNTSTATS:
+			inode->i_fop = &proc_mountstats_operations;
+			break;
 #ifdef CONFIG_SECURITY
 		case PROC_TID_ATTR:
 			inode->i_nlink = 2;
diff -X /home/cel/src/linux/dont-diff -Naurp 00-stock/include/linux/fs.h 01-mountstats/include/linux/fs.h
--- 00-stock/include/linux/fs.h	2005-03-02 02:37:50.000000000 -0500
+++ 01-mountstats/include/linux/fs.h	2005-03-14 15:24:51.598084000 -0500
@@ -1008,6 +1008,7 @@ struct super_operations {
 	void (*umount_begin) (struct super_block *);
 
 	int (*show_options)(struct seq_file *, struct vfsmount *);
+	int (*show_stats)(struct seq_file *, struct vfsmount *);
 
 	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
 	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
