Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUBSOfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266681AbUBSOd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:33:29 -0500
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:59314 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S267285AbUBSOam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:30:42 -0500
Date: Thu, 19 Feb 2004 15:30:37 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@Juliusz
To: linux-kernel@vger.kernel.org
cc: Manfred Spraul <manfred@colorfullife.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: [RFC][PATCH] 5/6 POSIX message queues
Message-ID: <Pine.GSO.4.58.0402191530090.18841@Juliusz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 2
//  EXTRAVERSION =
--- 2.6/ipc/mqueue.c	2004-02-16 23:01:45.000000000 +0100
+++ build-2.6/ipc/mqueue.c	2004-02-18 19:59:51.000000000 +0100
@@ -123,9 +123,18 @@
 			info->notify_owner = 0;
 			info->qsize = 0;
 			info->attr.mq_curmsgs = 0;
-			info->messages = NULL;
+			info->attr.mq_maxmsg = DFLT_MSGMAX;
+			info->attr.mq_msgsize = DFLT_MSGSIZEMAX;
+			info->messages = kmalloc(DFLT_MSGMAX * sizeof(struct msg_msg *), GFP_KERNEL);
+			if (!info->messages) {
+				make_bad_inode(inode);
+				iput(inode);
+				inode = NULL;
+			}
 		} else if (S_ISDIR(mode)) {
 			inode->i_nlink++;
+			/* Some things misbehave if size == 0 on a directory */
+			inode->i_size = 2 * DIRENT_SIZE;
 			inode->i_op = &mqueue_dir_inode_operations;
 			inode->i_fop = &simple_dir_operations;
 		}
@@ -137,7 +146,6 @@
 {
 	struct inode *inode;

-	sb->s_flags = MS_NOUSER;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = MQUEUE_MAGIC;
@@ -231,6 +239,9 @@
 		goto out_lock;
 	}

+	dir->i_size += DIRENT_SIZE;
+	dir->i_ctime = dir->i_mtime = dir->i_atime = CURRENT_TIME;
+
 	d_instantiate(dentry, inode);
 	dget(dentry);
 	return 0;
@@ -239,6 +250,62 @@
 	return error;
 }

+static int mqueue_unlink(struct inode *dir, struct dentry *dentry)
+{
+  	struct inode *inode = dentry->d_inode;
+
+	dir->i_ctime = dir->i_mtime = dir->i_atime = CURRENT_TIME;
+	dir->i_size -= DIRENT_SIZE;
+  	inode->i_nlink--;
+  	dput(dentry);
+  	return 0;
+}
+
+/*
+*	This is routine for system read from queue file.
+*	To avoid mess with doing here some sort of mq_receive we allow
+*	to read only queue size & notification info (the only values
+*	that are interesting from user point of view and aren't accessible
+*	through std routines)
+*/
+static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
+				size_t count, loff_t * off)
+{
+	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
+	char buffer[FILENT_SIZE];
+	size_t slen;
+	loff_t o;
+
+	if (!count)
+		return 0;
+
+	spin_lock(&info->lock);
+	snprintf(buffer, sizeof(buffer),
+			"QSIZE:%-10lu NOTIFY:%-5d SIGNO:%-5d NOTIFY_PID:%-6d\n",
+			info->qsize,
+			info->notify_owner ? info->notify.sigev_notify : SIGEV_NONE,
+			(info->notify_owner && info->notify.sigev_notify == SIGEV_SIGNAL ) ?
+				info->notify.sigev_signo : 0,
+			info->notify_owner);
+	spin_unlock(&info->lock);
+	buffer[sizeof(buffer)-1] = '\0';
+	slen = strlen(buffer)+1;
+
+	o = *off;
+	if (o > slen)
+		return 0;
+
+	if (o + count > slen)
+		count = slen - o;
+
+	if (copy_to_user(u_data, buffer + o, count))
+       		return -EFAULT;
+
+	*off = o + count;
+	filp->f_dentry->d_inode->i_atime = filp->f_dentry->d_inode->i_ctime = CURRENT_TIME;
+	return count;
+}
+
 static int mqueue_flush_file(struct file *filp)
 {
 	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
@@ -509,14 +576,13 @@
 			if (attr.mq_maxmsg > msg_max || attr.mq_msgsize > msgsize_max)
 				return ERR_PTR(-EINVAL);
 		}
+		msgs = (struct msg_msg **)kmalloc(attr.mq_maxmsg * sizeof(struct msg_msg *), GFP_KERNEL);
+		if (!msgs)
+			return ERR_PTR(-ENOMEM);
 	} else {
-		attr.mq_maxmsg = DFLT_MSGMAX;
-		attr.mq_msgsize = DFLT_MSGSIZEMAX;
+		msgs = NULL;
 	}
-	msgs = (struct msg_msg **)kmalloc(attr.mq_maxmsg * sizeof(struct msg_msg *), GFP_KERNEL);
-	if (!msgs)
-		return ERR_PTR(-ENOMEM);
-
+
 	ret = vfs_create(dir->d_inode, dentry, mode, NULL);
 	if (ret) {
 		if (msgs)
@@ -527,9 +593,12 @@
 	inode = dentry->d_inode;
 	info = MQUEUE_I(inode);

-	info->attr.mq_maxmsg = attr.mq_maxmsg;
-	info->attr.mq_msgsize = attr.mq_msgsize;
-	info->messages = msgs;
+	if (msgs) {
+		info->attr.mq_maxmsg = attr.mq_maxmsg;
+		info->attr.mq_msgsize = attr.mq_msgsize;
+		kfree(info->messages);
+		info->messages = msgs;
+	}

 	filp = dentry_open(dentry, mqueue_mnt, oflag);
 	if (!IS_ERR(filp))
@@ -990,12 +1059,13 @@
 static struct inode_operations mqueue_dir_inode_operations = {
 	.lookup = simple_lookup,
 	.create = mqueue_create,
-	.unlink = simple_unlink,
+	.unlink = mqueue_unlink,
 };

 static struct file_operations mqueue_file_operations = {
 	.flush = mqueue_flush_file,
 	.poll = mqueue_poll_file,
+	.read = mqueue_read_file,
 };

 static struct file_operations mqueue_notify_fops = {
@@ -1007,6 +1077,7 @@
 static struct super_operations mqueue_super_ops = {
 	.alloc_inode = mqueue_alloc_inode,
 	.destroy_inode = mqueue_destroy_inode,
+	.statfs = simple_statfs,
 	.delete_inode = mqueue_delete_inode,
 	.drop_inode = generic_delete_inode,
 };
@@ -1014,7 +1085,7 @@
 static struct file_system_type mqueue_fs_type = {
 	.name = "mqueue",
 	.get_sb = mqueue_get_sb,
-	.kill_sb = kill_anon_super,
+	.kill_sb = kill_litter_super,
 };

 static int msg_max_limit_min = DFLT_MSGMAX;
