Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVJXRIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVJXRIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVJXRIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:08:36 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:24336 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751166AbVJXRIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:08:35 -0400
To: akpm@osdl.org
CC: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/8] FUSE: atomic create+open
Message-Id: <E1EU5nz-0005xM-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Oct 2005 19:08:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an atomic create+open operation.  This does not yet
work if the file type changes between lookup and create+open, but
solves the permission checking problems for the separte create and
open methods.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2005-10-24 15:43:06.000000000 +0200
+++ linux/fs/fuse/dev.c	2005-10-24 15:43:09.000000000 +0200
@@ -184,6 +184,13 @@ static void request_end(struct fuse_conn
 		   fuse_putback_request() */
 		for (i = 1; i < FUSE_MAX_OUTSTANDING; i++)
 			up(&fc->outstanding_sem);
+	} else if (req->in.h.opcode == FUSE_RELEASE && req->inode == NULL) {
+		/* Special case for failed iget in CREATE */
+		u64 nodeid = req->in.h.nodeid;
+		__fuse_get_request(req);
+		fuse_reset_request(req);
+		fuse_send_forget(fc, req, nodeid, 1);
+		putback = 0;
 	}
 	if (putback)
 		fuse_putback_request(fc, req);
Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2005-10-24 15:43:06.000000000 +0200
+++ linux/include/linux/fuse.h	2005-10-24 15:43:09.000000000 +0200
@@ -100,7 +100,8 @@ enum fuse_opcode {
 	FUSE_READDIR       = 28,
 	FUSE_RELEASEDIR    = 29,
 	FUSE_FSYNCDIR      = 30,
-	FUSE_ACCESS        = 34
+	FUSE_ACCESS        = 34,
+	FUSE_CREATE        = 35
 };
 
 /* Conservative buffer size for the client */
@@ -158,7 +159,7 @@ struct fuse_setattr_in {
 
 struct fuse_open_in {
 	__u32	flags;
-	__u32	padding;
+	__u32	mode;
 };
 
 struct fuse_open_out {
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2005-10-24 15:43:06.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2005-10-24 15:43:09.000000000 +0200
@@ -269,6 +269,9 @@ struct fuse_conn {
 	/** Is access not implemented by fs? */
 	unsigned no_access : 1;
 
+	/** Is create not implemented by fs? */
+	unsigned no_create : 1;
+
 	/** Backing dev info */
 	struct backing_dev_info bdi;
 };
@@ -340,6 +343,17 @@ size_t fuse_send_read_common(struct fuse
  */
 int fuse_open_common(struct inode *inode, struct file *file, int isdir);
 
+struct fuse_file *fuse_file_alloc(void);
+void fuse_file_free(struct fuse_file *ff);
+void fuse_finish_open(struct inode *inode, struct file *file,
+		      struct fuse_file *ff, struct fuse_open_out *outarg);
+
+/**
+ * Send a RELEASE request
+ */
+void fuse_send_release(struct fuse_conn *fc, struct fuse_file *ff,
+		       u64 nodeid, struct inode *inode, int flags, int isdir);
+
 /**
  * Send RELEASE or RELEASEDIR request
  */
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2005-10-24 15:43:06.000000000 +0200
+++ linux/fs/fuse/dir.c	2005-10-24 15:43:09.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/gfp.h>
 #include <linux/sched.h>
 #include <linux/namei.h>
+#include <linux/mount.h>
 
 static inline unsigned long time_to_jiffies(unsigned long sec,
 					    unsigned long nsec)
@@ -134,6 +135,101 @@ static void fuse_invalidate_entry(struct
 	entry->d_time = jiffies - 1;
 }
 
+static int fuse_create_open(struct inode *dir, struct dentry *entry, int mode,
+			    struct nameidata *nd)
+{
+	int err;
+	struct inode *inode;
+	struct fuse_conn *fc = get_fuse_conn(dir);
+	struct fuse_req *req;
+	struct fuse_open_in inarg;
+	struct fuse_open_out outopen;
+	struct fuse_entry_out outentry;
+	struct fuse_inode *fi;
+	struct fuse_file *ff;
+	struct file *file;
+	int flags = nd->intent.open.flags - 1;
+
+	err = -ENOSYS;
+	if (fc->no_create)
+		goto out;
+
+	err = -ENAMETOOLONG;
+	if (entry->d_name.len > FUSE_NAME_MAX)
+		goto out;
+
+	err = -EINTR;
+	req = fuse_get_request(fc);
+	if (!req)
+		goto out;
+
+	ff = fuse_file_alloc();
+	if (!ff)
+		goto out_put_request;
+
+	flags &= ~O_NOCTTY;
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.flags = flags;
+	inarg.mode = mode;
+	req->in.h.opcode = FUSE_CREATE;
+	req->in.h.nodeid = get_node_id(dir);
+	req->inode = dir;
+	req->in.numargs = 2;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->in.args[1].size = entry->d_name.len + 1;
+	req->in.args[1].value = entry->d_name.name;
+	req->out.numargs = 2;
+	req->out.args[0].size = sizeof(outentry);
+	req->out.args[0].value = &outentry;
+	req->out.args[1].size = sizeof(outopen);
+	req->out.args[1].value = &outopen;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (err) {
+		if (err == -ENOSYS)
+			fc->no_create = 1;
+		goto out_free_ff;
+	}
+
+	err = -EIO;
+	if (!S_ISREG(outentry.attr.mode))
+		goto out_free_ff;
+
+	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
+			  &outentry.attr);
+	err = -ENOMEM;
+	if (!inode) {
+		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
+		ff->fh = outopen.fh;
+		fuse_send_release(fc, ff, outentry.nodeid, NULL, flags, 0);
+		goto out_put_request;
+	}
+	fuse_put_request(fc, req);
+	entry->d_time =	time_to_jiffies(outentry.entry_valid,
+					outentry.entry_valid_nsec);
+	fi = get_fuse_inode(inode);
+	fi->i_time = time_to_jiffies(outentry.attr_valid,
+				     outentry.attr_valid_nsec);
+
+	d_instantiate(entry, inode);
+	file = lookup_instantiate_filp(nd, entry, generic_file_open);
+	if (IS_ERR(file)) {
+		ff->fh = outopen.fh;
+		fuse_send_release(fc, ff, outentry.nodeid, inode, flags, 0);
+		return PTR_ERR(file);
+	}
+	fuse_finish_open(inode, file, ff, &outopen);
+	return 0;
+
+ out_free_ff:
+	fuse_file_free(ff);
+ out_put_request:
+	fuse_put_request(fc, req);
+ out:
+	return err;
+}
+
 static int create_new_entry(struct fuse_conn *fc, struct fuse_req *req,
 			    struct inode *dir, struct dentry *entry,
 			    int mode)
@@ -208,6 +304,12 @@ static int fuse_mknod(struct inode *dir,
 static int fuse_create(struct inode *dir, struct dentry *entry, int mode,
 		       struct nameidata *nd)
 {
+	if (nd && (nd->flags & LOOKUP_CREATE)) {
+		int err = fuse_create_open(dir, entry, mode, nd);
+		if (err != -ENOSYS)
+			return err;
+		/* Fall back on mknod */
+	}
 	return fuse_mknod(dir, entry, mode, 0);
 }
 
@@ -770,7 +872,9 @@ static struct dentry *fuse_lookup(struct
 				  struct nameidata *nd)
 {
 	struct inode *inode;
-	int err = fuse_lookup_iget(dir, entry, &inode);
+	int err;
+
+	err = fuse_lookup_iget(dir, entry, &inode);
 	if (err)
 		return ERR_PTR(err);
 	if (inode && S_ISDIR(inode->i_mode)) {
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2005-10-24 15:43:06.000000000 +0200
+++ linux/fs/fuse/file.c	2005-10-24 15:43:09.000000000 +0200
@@ -14,11 +14,69 @@
 
 static struct file_operations fuse_direct_io_file_operations;
 
-int fuse_open_common(struct inode *inode, struct file *file, int isdir)
+static int fuse_send_open(struct inode *inode, struct file *file, int isdir,
+			  struct fuse_open_out *outargp)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_req *req;
 	struct fuse_open_in inarg;
+	struct fuse_req *req;
+	int err;
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -EINTR;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
+	req->in.h.opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(*outargp);
+	req->out.args[0].value = outargp;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+
+	return err;
+}
+
+struct fuse_file *fuse_file_alloc(void)
+{
+	struct fuse_file *ff;
+	ff = kmalloc(sizeof(struct fuse_file), GFP_KERNEL);
+	if (ff) {
+		ff->release_req = fuse_request_alloc();
+		if (!ff->release_req) {
+			kfree(ff);
+			ff = NULL;
+		}
+	}
+	return ff;
+}
+
+void fuse_file_free(struct fuse_file *ff)
+{
+	fuse_request_free(ff->release_req);
+	kfree(ff);
+}
+
+void fuse_finish_open(struct inode *inode, struct file *file,
+		      struct fuse_file *ff, struct fuse_open_out *outarg)
+{
+	if (outarg->open_flags & FOPEN_DIRECT_IO)
+		file->f_op = &fuse_direct_io_file_operations;
+	if (!(outarg->open_flags & FOPEN_KEEP_CACHE))
+		invalidate_inode_pages(inode->i_mapping);
+	ff->fh = outarg->fh;
+	file->private_data = ff;
+}
+
+int fuse_open_common(struct inode *inode, struct file *file, int isdir)
+{
 	struct fuse_open_out outarg;
 	struct fuse_file *ff;
 	int err;
@@ -34,73 +92,53 @@ int fuse_open_common(struct inode *inode
 	/* If opening the root node, no lookup has been performed on
 	   it, so the attributes must be refreshed */
 	if (get_node_id(inode) == FUSE_ROOT_ID) {
-		int err = fuse_do_getattr(inode);
+		err = fuse_do_getattr(inode);
 		if (err)
 		 	return err;
 	}
 
-	req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
-
-	err = -ENOMEM;
-	ff = kmalloc(sizeof(struct fuse_file), GFP_KERNEL);
+	ff = fuse_file_alloc();
 	if (!ff)
-		goto out_put_request;
+		return -ENOMEM;
 
-	ff->release_req = fuse_request_alloc();
-	if (!ff->release_req) {
-		kfree(ff);
-		goto out_put_request;
-	}
-
-	memset(&inarg, 0, sizeof(inarg));
-	inarg.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
-	req->in.h.opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
-	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
-	req->in.numargs = 1;
-	req->in.args[0].size = sizeof(inarg);
-	req->in.args[0].value = &inarg;
-	req->out.numargs = 1;
-	req->out.args[0].size = sizeof(outarg);
-	req->out.args[0].value = &outarg;
-	request_send(fc, req);
-	err = req->out.h.error;
-	if (err) {
-		fuse_request_free(ff->release_req);
-		kfree(ff);
-	} else {
-		if (!isdir && (outarg.open_flags & FOPEN_DIRECT_IO))
-			file->f_op = &fuse_direct_io_file_operations;
-		if (!(outarg.open_flags & FOPEN_KEEP_CACHE))
-			invalidate_inode_pages(inode->i_mapping);
-		ff->fh = outarg.fh;
-		file->private_data = ff;
+	err = fuse_send_open(inode, file, isdir, &outarg);
+	if (err)
+		fuse_file_free(ff);
+	else {
+		if (isdir)
+			outarg.open_flags &= ~FOPEN_DIRECT_IO;
+		fuse_finish_open(inode, file, ff, &outarg);
 	}
 
- out_put_request:
-	fuse_put_request(fc, req);
 	return err;
 }
 
-int fuse_release_common(struct inode *inode, struct file *file, int isdir)
+void fuse_send_release(struct fuse_conn *fc, struct fuse_file *ff,
+		       u64 nodeid, struct inode *inode, int flags, int isdir)
 {
-	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_file *ff = file->private_data;
-	struct fuse_req *req = ff->release_req;
+	struct fuse_req * req = ff->release_req;
 	struct fuse_release_in *inarg = &req->misc.release_in;
 
 	inarg->fh = ff->fh;
-	inarg->flags = file->f_flags & ~O_EXCL;
+	inarg->flags = flags;
 	req->in.h.opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
-	req->in.h.nodeid = get_node_id(inode);
+	req->in.h.nodeid = nodeid;
 	req->inode = inode;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(struct fuse_release_in);
 	req->in.args[0].value = inarg;
 	request_send_background(fc, req);
 	kfree(ff);
+}
+
+int fuse_release_common(struct inode *inode, struct file *file, int isdir)
+{
+	struct fuse_file *ff = file->private_data;
+	if (ff) {
+		struct fuse_conn *fc = get_fuse_conn(inode);
+		u64 nodeid = get_node_id(inode);
+		fuse_send_release(fc, ff, nodeid, inode, file->f_flags, isdir);
+	}
 
 	/* Return value is ignored by VFS */
 	return 0;

