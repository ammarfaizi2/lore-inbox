Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbUCJQUk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbUCJQUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:20:40 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:38788 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S262677AbUCJQUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:20:06 -0500
Date: Wed, 10 Mar 2004 17:20:05 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: linux-kernel@vger.kernel.org
Subject: /dev/root: which approach ? [PATCH]
Message-ID: <20040310162003.GA25688@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-NCC-RegID: nl.cistron
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if you boot from a blockdevice with a dynamically
allocated major number (such as LVM or partitionable raid),
there is no way to check the root filesystem. The root
fs is still read-only, so you cannot create a device node
anywhere to point fsck at.

This was discussed on the linux-raid mailinglist, and I proposed
(as proof of concept) a simple check in bdget() to see if the
device is being opened is the /dev/root node and if so redirect
it to the current root device. This is a 8-line patch, the only
disadvantage I can think of is that for an open file, inode->i_rdev
is then different from blockdevice->bd_dev. Shouldn't be a problem.

Neil Brown also proposed 2 potential solutions; one is making
rootfs remountable so that you can  mount -t rootfs rootfs /mnt/root
and then fsck /mnt/root/dev/root (below as remount_rootfs.patch).

His second one is a patch that adds a /proc/pid/rootdev blockdevice,
below as proc_pid_rootdev.patch (partially rewritten by me).
This should probably be optimized to move the i_rdev resolving
out of init_proc_pid_rootdev_inode() and into open() / getattr().

My question to the FS hackers: which one is the preferred approach?


dev_root_alias.patch

--- linux-2.6.4-rc2-mm1.orig/fs/block_dev.c	2004-03-09 17:14:32.000000000 +0100
+++ linux-2.6.4-rc2-mm1/fs/block_dev.c	2004-03-10 16:39:30.000000000 +0100
@@ -338,6 +338,16 @@ struct block_device *bdget(dev_t dev)
 {
 	struct block_device *bdev;
 	struct inode *inode;
+	struct vfsmount *mnt;
+
+	/* See if device is the /dev/root alias. */
+	if (dev == MKDEV(4, 1)) {
+		read_lock(&current->fs->lock);
+		mnt = mntget(current->fs->rootmnt);
+		dev = mnt->mnt_sb->s_dev;
+		mntput(mnt);
+		read_unlock(&current->fs->lock);
+	}
 
 	inode = iget5_locked(bd_mnt->mnt_sb, hash(dev),
 			bdev_test, bdev_set, &dev);


remount_rootfs.patch

--- linux/fs/ramfs/inode.c~current~	2004-03-01 11:20:58.000000000 +1100
+++ linux/fs/ramfs/inode.c	2004-03-01 11:21:15.000000000 +1100
@@ -207,7 +207,7 @@ static struct super_block *ramfs_get_sb(
 static struct super_block *rootfs_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
-	return get_sb_nodev(fs_type, flags|MS_NOUSER, data, ramfs_fill_super);
+	return get_sb_single(fs_type, flags, data, ramfs_fill_super);
 }
 
 static struct file_system_type ramfs_fs_type = {


proc_rootdev.patch

--- linux-2.6.3/fs/proc/base.c	2004-02-18 04:58:32.000000000 +0100
+++ linux-2.6.3-bk8-mdp/fs/proc/base.c	2004-03-01 15:20:22.000000000 +0100
@@ -50,6 +50,7 @@
 	PROC_TGID_MEM,
 	PROC_TGID_CWD,
 	PROC_TGID_ROOT,
+	PROC_TGID_ROOTDEV,
 	PROC_TGID_EXE,
 	PROC_TGID_FD,
 	PROC_TGID_ENVIRON,
@@ -73,6 +74,7 @@
 	PROC_TID_MEM,
 	PROC_TID_CWD,
 	PROC_TID_ROOT,
+	PROC_TID_ROOTDEV,
 	PROC_TID_EXE,
 	PROC_TID_FD,
 	PROC_TID_ENVIRON,
@@ -115,6 +117,7 @@
 	E(PROC_TGID_MEM,       "mem",     S_IFREG|S_IRUSR|S_IWUSR),
 	E(PROC_TGID_CWD,       "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
+	E(PROC_TGID_ROOTDEV,   "rootdev", S_IFBLK|S_IRUSR|S_IWUSR),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
@@ -137,6 +140,7 @@
 	E(PROC_TID_MEM,        "mem",     S_IFREG|S_IRUSR|S_IWUSR),
 	E(PROC_TID_CWD,        "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
+	E(PROC_TID_ROOTDEV,    "rootdev", S_IFBLK|S_IRUSR|S_IWUSR),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
@@ -771,6 +775,32 @@
 	.follow_link	= proc_pid_follow_link
 };
 
+static int init_proc_pid_rootdev_inode(struct inode *inode)
+{
+	struct fs_struct *fs;
+	struct vfsmount *vmnt;
+	int result = -ENOENT;
+	dev_t rootdev = 0;
+
+	task_lock(proc_task(inode));
+	fs = proc_task(inode)->fs;
+	if(fs)
+		atomic_inc(&fs->count);
+	task_unlock(proc_task(inode));
+	if (fs) {
+		read_lock(&fs->lock);
+		vmnt = mntget(fs->rootmnt);
+		rootdev = vmnt->mnt_sb->s_dev;
+		mntput(vmnt);
+		read_unlock(&fs->lock);
+		result = 0;
+		put_fs_struct(fs);
+	}
+	init_special_inode(inode, inode->i_mode, rootdev);
+
+	return result;
+}
+
 static int pid_alive(struct task_struct *p)
 {
 	BUG_ON(p->pids[PIDTYPE_PID].pidptr != &p->pids[PIDTYPE_PID].pid);
@@ -958,7 +988,9 @@
 	ei->type = ino;
 	inode->i_uid = 0;
 	inode->i_gid = 0;
-	if (ino == PROC_TGID_INO || ino == PROC_TID_INO || task_dumpable(task)) {
+	if (ino != PROC_TGID_ROOTDEV && ino != PROC_TID_ROOTDEV &&
+	    (ino == PROC_TGID_INO || ino == PROC_TID_INO ||
+	     task_dumpable(task))) {
 		inode->i_uid = task->euid;
 		inode->i_gid = task->egid;
 	}
@@ -988,7 +1020,10 @@
 	struct inode *inode = dentry->d_inode;
 	struct task_struct *task = proc_task(inode);
 	if (pid_alive(task)) {
-		if (proc_type(inode) == PROC_TGID_INO || proc_type(inode) == PROC_TID_INO || task_dumpable(task)) {
+		int ino = proc_type(inode);
+		if (ino != PROC_TGID_ROOTDEV && ino != PROC_TID_ROOTDEV &&
+		    (ino == PROC_TGID_INO || ino == PROC_TID_INO ||
+		     task_dumpable(task))) {
 			inode->i_uid = task->euid;
 			inode->i_gid = task->egid;
 		} else {
@@ -1319,6 +1354,10 @@
 			inode->i_op = &proc_pid_link_inode_operations;
 			ei->op.proc_get_link = proc_root_link;
 			break;
+		case PROC_TID_ROOTDEV:
+		case PROC_TGID_ROOTDEV:
+			init_proc_pid_rootdev_inode(inode);
+			break;
 		case PROC_TID_ENVIRON:
 		case PROC_TGID_ENVIRON:
 			inode->i_fop = &proc_info_file_operations;

