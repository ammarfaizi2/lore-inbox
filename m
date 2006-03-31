Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWCaSE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWCaSE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWCaSE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:04:59 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:22176 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932181AbWCaSE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:04:58 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:45:19 +0200)
Subject: [PATCH 10/10] fuse: add POSIX file locking support
References: <E1FPNgV-0005YY-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNz8-0005ff-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 20:04:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds POSIX file locking support to the FUSE interface.

This implementation doesn't keep any locking state in kernel, except a
dummy lock which is inserted whenever a locking operation is performed
on an inode and removed on inode cleanup.  This is needed because
locks_remove_posix() assumes that if inode->i_flock list is empty
there are no locks applied and bypasses calling the ->lock() method.

This is quite optimal, since file locking is rarely used, hence
->lock() will only be called on process exit, if there's a chance that
there might be locks owned by that process.

Mandatory locking is not supported.  The filesystem may enfoce
mandatory locking in userspace if needed.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-03-31 18:55:43.000000000 +0200
+++ linux/fs/fuse/file.c	2006-03-31 19:03:04.000000000 +0200
@@ -1,6 +1,6 @@
 /*
   FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2005  Miklos Szeredi <miklos@szeredi.hu>
+  Copyright (C) 2001-2006  Miklos Szeredi <miklos@szeredi.hu>
 
   This program can be distributed under the terms of the GNU GPL.
   See the file COPYING.
@@ -615,6 +615,158 @@ static int fuse_set_page_dirty(struct pa
 	return 0;
 }
 
+/*
+ * Need to add a dummy posix lock, so VFS doesn't optimize away the
+ * unlock from locks_remove_posix()
+ */
+static int fuse_add_dummy_lock(struct inode *inode)
+{
+	struct file_lock lock;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	locks_init_lock(&lock);
+	lock.fl_type = F_WRLCK;
+	lock.fl_flags = FL_POSIX;
+	lock.fl_start = 0;
+	lock.fl_end = OFFSET_MAX;
+	lock.fl_owner = (fl_owner_t) fc;
+	return __posix_lock_file(inode, &lock, NULL);
+}
+
+void fuse_remove_dummy_lock(struct inode *inode)
+{
+	struct file_lock lock;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	locks_init_lock(&lock);
+	lock.fl_type = F_UNLCK;
+	lock.fl_flags = FL_POSIX;
+	lock.fl_start = 0;
+	lock.fl_end = OFFSET_MAX;
+	lock.fl_owner = (fl_owner_t) fc;
+	__posix_lock_file(inode, &lock, NULL);
+}
+
+static int convert_fuse_file_lock(const struct fuse_file_lock *ffl,
+				  struct file_lock *fl)
+{
+	switch (ffl->type) {
+	case F_UNLCK:
+		break;
+
+	case F_RDLCK:
+	case F_WRLCK:
+		if (ffl->start < 0 || ffl->end < 0 || ffl->end < ffl->start)
+			return -EIO;
+
+		fl->fl_start = ffl->start;
+		fl->fl_end = ffl->end;
+		fl->fl_pid = ffl->pid;
+		break;
+
+	default:
+		return -EIO;
+	}
+	fl->fl_type = ffl->type;
+	return 0;
+}
+
+static void fuse_lk_fill(struct fuse_req *req, struct file *file,
+			 const struct file_lock *fl, int opcode, pid_t pid)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_file *ff = file->private_data;
+	struct fuse_lk_in *arg = &req->misc.lk_in;
+
+	arg->fh = ff->fh;
+	arg->owner = (unsigned long) fl->fl_owner;
+	arg->lk.start = fl->fl_start;
+	arg->lk.end = fl->fl_end;
+	arg->lk.type = fl->fl_type;
+	arg->lk.pid = pid;
+	req->in.h.opcode = opcode;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->file = file;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(*arg);
+	req->in.args[0].value = arg;
+}
+
+static int fuse_getlk(struct file *file, struct file_lock *fl)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req;
+	struct fuse_lk_out outarg;
+	int err;
+
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	fuse_lk_fill(req, file, fl, FUSE_GETLK, 0);
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (!err)
+		err = convert_fuse_file_lock(&outarg.lk, fl);
+
+	return err;
+}
+
+static int fuse_setlk(struct file *file, struct file_lock *fl)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req;
+	int opcode = (fl->fl_flags & FL_SLEEP) ? FUSE_SETLKW : FUSE_SETLK;
+	int err;
+	pid_t pid = 0;
+
+	if (fl->fl_type != F_UNLCK) {
+		pid = current->tgid;
+		err = fuse_add_dummy_lock(inode);
+		if (err)
+			return err;
+	}
+
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	fuse_lk_fill(req, file,fl, opcode, pid);
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	return err;
+}
+
+static int fuse_file_lock(struct file *file, int cmd, struct file_lock *fl)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	int err;
+
+	if (cmd == F_GETLK) {
+		if (fc->no_lk) {
+			if (!posix_test_lock(file, fl, fl))
+				fl->fl_type = F_UNLCK;
+			err = 0;
+		} else
+			err = fuse_getlk(file, fl);
+	} else {
+		if (fc->no_lk)
+			err = posix_lock_file_wait(file, fl);
+		else
+			err = fuse_setlk(file, fl);
+	}
+	return err;
+}
+
 static const struct file_operations fuse_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_file_read,
@@ -624,6 +776,7 @@ static const struct file_operations fuse
 	.flush		= fuse_flush,
 	.release	= fuse_release,
 	.fsync		= fuse_fsync,
+	.lock		= fuse_file_lock,
 	.sendfile	= generic_file_sendfile,
 };
 
@@ -635,6 +788,7 @@ static const struct file_operations fuse
 	.flush		= fuse_flush,
 	.release	= fuse_release,
 	.fsync		= fuse_fsync,
+	.lock		= fuse_file_lock,
 	/* no mmap and sendfile */
 };
 
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-03-31 18:55:43.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-03-31 18:55:43.000000000 +0200
@@ -178,6 +178,7 @@ struct fuse_req {
 		struct fuse_init_in init_in;
 		struct fuse_init_out init_out;
 		struct fuse_read_in read_in;
+		struct fuse_lk_in lk_in;
 	} misc;
 
 	/** page vector */
@@ -302,6 +303,9 @@ struct fuse_conn {
 	/** Is removexattr not implemented by fs? */
 	unsigned no_removexattr : 1;
 
+	/** Are file locking primitives not implemented by fs? */
+	unsigned no_lk : 1;
+
 	/** Is access not implemented by fs? */
 	unsigned no_access : 1;
 
@@ -490,3 +494,8 @@ int fuse_do_getattr(struct inode *inode)
  * Invalidate inode attributes
  */
 void fuse_invalidate_attr(struct inode *inode);
+
+/**
+ * Remove dummy lock from inode
+ */
+void fuse_remove_dummy_lock(struct inode *inode);
Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2006-03-31 18:55:39.000000000 +0200
+++ linux/include/linux/fuse.h	2006-03-31 18:55:43.000000000 +0200
@@ -1,6 +1,6 @@
 /*
     FUSE: Filesystem in Userspace
-    Copyright (C) 2001-2005  Miklos Szeredi <miklos@szeredi.hu>
+    Copyright (C) 2001-2006  Miklos Szeredi <miklos@szeredi.hu>
 
     This program can be distributed under the terms of the GNU GPL.
     See the file COPYING.
@@ -14,7 +14,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 6
+#define FUSE_KERNEL_MINOR_VERSION 7
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -58,6 +58,13 @@ struct fuse_kstatfs {
 	__u32	spare[6];
 };
 
+struct fuse_file_lock {
+	__u64	start;
+	__u64	end;
+	__u32	type;
+	__u32	pid; /* tgid */
+};
+
 /**
  * Bitmasks for fuse_setattr_in.valid
  */
@@ -82,6 +89,7 @@ struct fuse_kstatfs {
  * INIT request/reply flags
  */
 #define FUSE_ASYNC_READ		(1 << 0)
+#define FUSE_POSIX_LOCKS        (1 << 1)
 
 enum fuse_opcode {
 	FUSE_LOOKUP	   = 1,
@@ -112,8 +120,14 @@ enum fuse_opcode {
 	FUSE_READDIR       = 28,
 	FUSE_RELEASEDIR    = 29,
 	FUSE_FSYNCDIR      = 30,
+	FUSE_GETLK         = 31,
+	FUSE_SETLK         = 32,
+	FUSE_SETLKW        = 33,
 	FUSE_ACCESS        = 34,
-	FUSE_CREATE        = 35
+	FUSE_CREATE        = 35,
+
+	/* Keep at the end: */
+	FUSE_MAXOP
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -247,6 +261,16 @@ struct fuse_getxattr_out {
 	__u32	padding;
 };
 
+struct fuse_lk_in {
+	__u64	fh;
+	__u64	owner;
+	struct fuse_file_lock lk;
+};
+
+struct fuse_lk_out {
+	struct fuse_file_lock lk;
+};
+
 struct fuse_access_in {
 	__u32	mask;
 	__u32	padding;
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-03-31 18:55:43.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-03-31 18:55:43.000000000 +0200
@@ -71,6 +71,7 @@ static struct inode *fuse_alloc_inode(st
 static void fuse_destroy_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	BUG_ON(inode->i_flock);
 	if (fi->forget_req)
 		fuse_request_free(fi->forget_req);
 	kmem_cache_free(fuse_inode_cachep, inode);
@@ -96,6 +97,8 @@ void fuse_send_forget(struct fuse_conn *
 
 static void fuse_clear_inode(struct inode *inode)
 {
+	if (inode->i_flock)
+		fuse_remove_dummy_lock(inode);
 	if (inode->i_sb->s_flags & MS_ACTIVE) {
 		struct fuse_conn *fc = get_fuse_conn(inode);
 		struct fuse_inode *fi = get_fuse_inode(inode);
@@ -104,6 +107,14 @@ static void fuse_clear_inode(struct inod
 	}
 }
 
+static int fuse_remount_fs(struct super_block *sb, int *flags, char *data)
+{
+	if (*flags & MS_MANDLOCK)
+		return -EINVAL;
+
+	return 0;
+}
+
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr)
 {
 	if (S_ISREG(inode->i_mode) && i_size_read(inode) != attr->size)
@@ -413,6 +424,7 @@ static struct super_operations fuse_supe
 	.destroy_inode  = fuse_destroy_inode,
 	.read_inode	= fuse_read_inode,
 	.clear_inode	= fuse_clear_inode,
+	.remount_fs	= fuse_remount_fs,
 	.put_super	= fuse_put_super,
 	.umount_begin	= fuse_umount_begin,
 	.statfs		= fuse_statfs,
@@ -432,6 +444,8 @@ static void process_init_reply(struct fu
 			ra_pages = arg->max_readahead / PAGE_CACHE_SIZE;
 			if (arg->flags & FUSE_ASYNC_READ)
 				fc->async_read = 1;
+			if (!(arg->flags & FUSE_POSIX_LOCKS))
+				fc->no_lk = 1;
 		} else
 			ra_pages = fc->max_read / PAGE_CACHE_SIZE;
 
@@ -451,7 +465,7 @@ static void fuse_send_init(struct fuse_c
 	arg->major = FUSE_KERNEL_VERSION;
 	arg->minor = FUSE_KERNEL_MINOR_VERSION;
 	arg->max_readahead = fc->bdi.ra_pages * PAGE_CACHE_SIZE;
-	arg->flags |= FUSE_ASYNC_READ;
+	arg->flags |= FUSE_ASYNC_READ | FUSE_POSIX_LOCKS;
 	req->in.h.opcode = FUSE_INIT;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(*arg);
@@ -484,6 +498,9 @@ static int fuse_fill_super(struct super_
 	struct fuse_req *init_req;
 	int err;
 
+	if (sb->s_flags & MS_MANDLOCK)
+		return -EINVAL;
+
 	if (!parse_fuse_opt((char *) data, &d))
 		return -EINVAL;
 
