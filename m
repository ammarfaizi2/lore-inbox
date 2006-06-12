Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751918AbWFLM3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbWFLM3u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWFLM3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:29:49 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:11498 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1751918AbWFLM3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:29:48 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 12 Jun 2006 14:21:49 +0200)
Subject: [PATCH 4/7] fuse: add POSIX file locking support
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FplXk-00062M-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 Jun 2006 14:29:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds POSIX file locking support to the fuse interface.

This implementation doesn't keep any locking state in kernel.
Unlocking on close() is handled by the FLUSH message, which now
contains the lock owner id.

Mandatory locking is not supported.  The filesystem may enfoce
mandatory locking in userspace if needed.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-06-12 14:09:56.000000000 +0200
+++ linux/fs/fuse/file.c	2006-06-12 14:09:59.000000000 +0200
@@ -160,6 +160,18 @@ static int fuse_release(struct inode *in
 	return fuse_release_common(inode, file, 0);
 }
 
+/*
+ * It would be nice to scramble the ID space, so that the value of the
+ * files_struct pointer is not exposed to userspace.  Symmetric crypto
+ * functions are overkill, since the inverse function doesn't need to
+ * be implemented (though it does have to exist).  Is there something
+ * simpler?
+ */
+static inline u64 fuse_lock_owner_id(fl_owner_t id)
+{
+	return (unsigned long) id;
+}
+
 static int fuse_flush(struct file *file, fl_owner_t id)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -181,11 +193,13 @@ static int fuse_flush(struct file *file,
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.fh = ff->fh;
+	inarg.lock_owner = fuse_lock_owner_id(id);
 	req->in.h.opcode = FUSE_FLUSH;
 	req->in.h.nodeid = get_node_id(inode);
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
+	req->force = 1;
 	request_send(fc, req);
 	err = req->out.h.error;
 	fuse_put_request(fc, req);
@@ -604,6 +618,122 @@ static int fuse_set_page_dirty(struct pa
 	return 0;
 }
 
+static int convert_fuse_file_lock(const struct fuse_file_lock *ffl,
+				  struct file_lock *fl)
+{
+	switch (ffl->type) {
+	case F_UNLCK:
+		break;
+
+	case F_RDLCK:
+	case F_WRLCK:
+		if (ffl->start > OFFSET_MAX || ffl->end > OFFSET_MAX ||
+		    ffl->end < ffl->start)
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
+	arg->owner = fuse_lock_owner_id(fl->fl_owner);
+	arg->lk.start = fl->fl_start;
+	arg->lk.end = fl->fl_end;
+	arg->lk.type = fl->fl_type;
+	arg->lk.pid = pid;
+	req->in.h.opcode = opcode;
+	req->in.h.nodeid = get_node_id(inode);
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
+	pid_t pid = fl->fl_type != F_UNLCK ? current->tgid : 0;
+	int err;
+
+	/* Unlock on close is handled by the flush method */
+	if (fl->fl_flags & FL_CLOSE)
+		return 0;
+
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	fuse_lk_fill(req, file, fl, opcode, pid);
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
+		if (fc->no_lock) {
+			if (!posix_test_lock(file, fl, fl))
+				fl->fl_type = F_UNLCK;
+			err = 0;
+		} else
+			err = fuse_getlk(file, fl);
+	} else {
+		if (fc->no_lock)
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
@@ -613,6 +743,7 @@ static const struct file_operations fuse
 	.flush		= fuse_flush,
 	.release	= fuse_release,
 	.fsync		= fuse_fsync,
+	.lock		= fuse_file_lock,
 	.sendfile	= generic_file_sendfile,
 };
 
@@ -624,6 +755,7 @@ static const struct file_operations fuse
 	.flush		= fuse_flush,
 	.release	= fuse_release,
 	.fsync		= fuse_fsync,
+	.lock		= fuse_file_lock,
 	/* no mmap and sendfile */
 };
 
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-06-12 14:09:57.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-06-12 14:09:59.000000000 +0200
@@ -190,6 +190,7 @@ struct fuse_req {
 		struct fuse_init_in init_in;
 		struct fuse_init_out init_out;
 		struct fuse_read_in read_in;
+		struct fuse_lk_in lk_in;
 	} misc;
 
 	/** page vector */
@@ -307,6 +308,9 @@ struct fuse_conn {
 	/** Is removexattr not implemented by fs? */
 	unsigned no_removexattr : 1;
 
+	/** Are file locking primitives not implemented by fs? */
+	unsigned no_lock : 1;
+
 	/** Is access not implemented by fs? */
 	unsigned no_access : 1;
 
Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2006-06-12 14:09:54.000000000 +0200
+++ linux/include/linux/fuse.h	2006-06-12 14:09:59.000000000 +0200
@@ -1,6 +1,6 @@
 /*
     FUSE: Filesystem in Userspace
-    Copyright (C) 2001-2005  Miklos Szeredi <miklos@szeredi.hu>
+    Copyright (C) 2001-2006  Miklos Szeredi <miklos@szeredi.hu>
 
     This program can be distributed under the terms of the GNU GPL.
     See the file COPYING.
@@ -15,7 +15,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 6
+#define FUSE_KERNEL_MINOR_VERSION 7
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -59,6 +59,13 @@ struct fuse_kstatfs {
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
@@ -83,6 +90,7 @@ struct fuse_kstatfs {
  * INIT request/reply flags
  */
 #define FUSE_ASYNC_READ		(1 << 0)
+#define FUSE_POSIX_LOCKS	(1 << 1)
 
 enum fuse_opcode {
 	FUSE_LOOKUP	   = 1,
@@ -113,6 +121,9 @@ enum fuse_opcode {
 	FUSE_READDIR       = 28,
 	FUSE_RELEASEDIR    = 29,
 	FUSE_FSYNCDIR      = 30,
+	FUSE_GETLK         = 31,
+	FUSE_SETLK         = 32,
+	FUSE_SETLKW        = 33,
 	FUSE_ACCESS        = 34,
 	FUSE_CREATE        = 35
 };
@@ -200,6 +211,7 @@ struct fuse_flush_in {
 	__u64	fh;
 	__u32	flush_flags;
 	__u32	padding;
+	__u64	lock_owner;
 };
 
 struct fuse_read_in {
@@ -248,6 +260,16 @@ struct fuse_getxattr_out {
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
--- linux.orig/fs/fuse/inode.c	2006-06-12 14:09:57.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-06-12 14:09:59.000000000 +0200
@@ -98,6 +98,14 @@ static void fuse_clear_inode(struct inod
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
@@ -409,6 +417,7 @@ static struct super_operations fuse_supe
 	.destroy_inode  = fuse_destroy_inode,
 	.read_inode	= fuse_read_inode,
 	.clear_inode	= fuse_clear_inode,
+	.remount_fs	= fuse_remount_fs,
 	.put_super	= fuse_put_super,
 	.umount_begin	= fuse_umount_begin,
 	.statfs		= fuse_statfs,
@@ -428,8 +437,12 @@ static void process_init_reply(struct fu
 			ra_pages = arg->max_readahead / PAGE_CACHE_SIZE;
 			if (arg->flags & FUSE_ASYNC_READ)
 				fc->async_read = 1;
-		} else
+			if (!(arg->flags & FUSE_POSIX_LOCKS))
+				fc->no_lock = 1;
+		} else {
 			ra_pages = fc->max_read / PAGE_CACHE_SIZE;
+			fc->no_lock = 1;
+		}
 
 		fc->bdi.ra_pages = min(fc->bdi.ra_pages, ra_pages);
 		fc->minor = arg->minor;
@@ -447,7 +460,7 @@ static void fuse_send_init(struct fuse_c
 	arg->major = FUSE_KERNEL_VERSION;
 	arg->minor = FUSE_KERNEL_MINOR_VERSION;
 	arg->max_readahead = fc->bdi.ra_pages * PAGE_CACHE_SIZE;
-	arg->flags |= FUSE_ASYNC_READ;
+	arg->flags |= FUSE_ASYNC_READ | FUSE_POSIX_LOCKS;
 	req->in.h.opcode = FUSE_INIT;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(*arg);
@@ -479,6 +492,9 @@ static int fuse_fill_super(struct super_
 	struct fuse_req *init_req;
 	int err;
 
+	if (sb->s_flags & MS_MANDLOCK)
+		return -EINVAL;
+
 	if (!parse_fuse_opt((char *) data, &d))
 		return -EINVAL;
 
