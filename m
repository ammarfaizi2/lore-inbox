Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263198AbUKTXbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263198AbUKTXbv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbUKTXau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:30:50 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:46731 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263212AbUKTXLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:11:15 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/13] Filesystem in Userspace
Message-Id: <E1CVeNh-0007Q9-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:11:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the file operations of FUSE.

The following operations are added:

 o open
 o flush
 o release
 o fsync
 o readpage
 o commit_write

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
--- linux-2.6.10-rc2/fs/fuse/dir.c	2004-11-20 22:56:24.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/dir.c	2004-11-20 22:56:24.000000000 +0100
@@ -47,6 +47,7 @@ static void fuse_init_inode(struct inode
 	i_size_write(inode, attr->size);
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &fuse_file_inode_operations;
+		fuse_init_file_inode(inode);
 	}
 	else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &fuse_dir_inode_operations;
@@ -65,6 +66,7 @@ static void fuse_init_inode(struct inode
 		printk("fuse_init_inode: bad file type: %o\n", inode->i_mode);
 		inode->i_mode = S_IFREG;
 		inode->i_op = &fuse_file_inode_operations;
+		fuse_init_file_inode(inode);
 	}
 }
 
--- linux-2.6.10-rc2/fs/fuse/fuse_i.h	2004-11-20 22:56:24.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/fuse_i.h	2004-11-20 22:56:24.000000000 +0100
@@ -24,6 +24,12 @@ struct fuse_inode {
 	unsigned long i_time;
 };
 
+/** FUSE specific file data */
+struct fuse_file {
+	struct fuse_req *release_req;
+	unsigned long fh;
+};
+
 /** One input argument of a request */
 struct fuse_in_arg {
 	unsigned int size;
@@ -119,6 +125,12 @@ struct fuse_conn {
 	
 	/** The next unique request id */
 	int reqctr;
+	
+	/** Is fsync not implemented by fs? */
+	unsigned int no_fsync : 1;
+
+	/** Is flush not implemented by fs? */
+	unsigned int no_flush : 1;
 };
 
 struct fuse_getdir_out_i {
@@ -162,6 +174,11 @@ void fuse_send_forget(struct fuse_conn *
 		      unsigned long nodeid, int version);
 
 /**
+ * Initialise operations on regular file
+ */
+void fuse_init_file_inode(struct inode *inode);
+
+/**
  * Check if the connection can be released, and if yes, then free the
  * connection structure
  */
--- linux-2.6.10-rc2/fs/fuse/Makefile	2004-11-20 22:56:24.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/Makefile	2004-11-20 22:41:28.000000000 +0100
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FUSE) += fuse.o
 
-fuse-objs := dev.o dir.o inode.o util.o
+fuse-objs := dev.o dir.o file.o inode.o util.o
--- linux-2.6.10-rc2/fs/fuse/file.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/file.c	2004-11-20 22:56:24.000000000 +0100
@@ -0,0 +1,353 @@
+/*
+    FUSE: Filesystem in Userspace
+    Copyright (C) 2001-2004  Miklos Szeredi <miklos@szeredi.hu>
+
+    This program can be distributed under the terms of the GNU GPL.
+    See the file COPYING.
+*/
+#include "fuse_i.h"
+
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <asm/uaccess.h>
+
+static int fuse_open(struct inode *inode, struct file *file)
+{
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_req *req;
+	struct fuse_open_in inarg;
+	struct fuse_open_out outarg;
+	struct fuse_file *ff;
+	int err;
+
+	err = generic_file_open(inode, file);
+	if (err)
+		return err;
+
+	/* If opening the root node, no lookup has been performed on
+	   it, so the attributes must be refreshed */
+	if (fi->nodeid == FUSE_ROOT_ID) {
+		int err = fuse_do_getattr(inode);
+		if (err)
+		 	return err;
+	}
+
+	down(&inode->i_sem);
+	err = -ERESTARTSYS;
+	req = fuse_get_request(fc);
+	if (!req)
+		goto out;
+
+	err = -ENOMEM;
+	ff = kmalloc(sizeof(struct fuse_file), GFP_KERNEL);
+	if (!ff)
+		goto out_put_request;
+
+	ff->release_req = fuse_request_alloc();
+	if (!ff->release_req) {
+		kfree(ff);
+		goto out_put_request;
+	}
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.flags = file->f_flags & ~O_EXCL;
+	req->in.h.opcode = FUSE_OPEN;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (!err) {
+		invalidate_inode_pages(inode->i_mapping);
+	}
+	if (err) {
+		fuse_request_free(ff->release_req);
+		kfree(ff);
+	}
+	else {
+		ff->fh = outarg.fh;
+		file->private_data = ff;
+	}
+
+ out_put_request:
+	fuse_put_request(fc, req);
+ out:
+	up(&inode->i_sem);
+	return err;
+}
+
+static int fuse_release(struct inode *inode, struct file *file)
+{
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_req *req = ff->release_req;
+	struct fuse_release_in inarg;
+	
+	down(&inode->i_sem);
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.fh = ff->fh;
+	inarg.flags = file->f_flags & ~O_EXCL;
+	req->in.h.opcode = FUSE_RELEASE;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	request_send(fc, req);
+	fuse_put_request(fc, req);
+	kfree(ff);
+	up(&inode->i_sem);
+
+	/* Return value is ignored by VFS */
+	return 0;
+}
+
+static int fuse_flush(struct file *file)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_req *req = ff->release_req;
+	struct fuse_flush_in inarg;
+	int err;
+	
+	if (fc->no_flush)
+		return 0;
+
+	down(&inode->i_sem);
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.fh = ff->fh;
+	req->in.h.opcode = FUSE_FLUSH;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_reset_request(req);
+	up(&inode->i_sem);
+	if (err == -ENOSYS) {
+		fc->no_flush = 1;
+		err = 0;
+	}
+	return err;
+}
+
+static int fuse_fsync(struct file *file, struct dentry *de, int datasync)
+{
+	struct inode *inode = de->d_inode;
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_req *req;
+	struct fuse_fsync_in inarg;
+	int err;
+	
+	if (fc->no_fsync)
+		return 0;
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.fh = ff->fh;
+	inarg.datasync = datasync;
+	req->in.h.opcode = FUSE_FSYNC;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (err == -ENOSYS) {
+		fc->no_fsync = 1;
+		err = 0;
+	}
+	fuse_put_request(fc, req);
+	return err;
+}
+
+static ssize_t fuse_send_read(struct file *file, struct inode *inode,
+			      char *buf, loff_t pos, size_t count)
+{
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_req *req;
+	struct fuse_read_in inarg;
+	ssize_t res;
+	
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
+	
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.fh = ff->fh;
+	inarg.offset = pos;
+	inarg.size = count;
+	req->in.h.opcode = FUSE_READ;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->out.argvar = 1;
+	req->out.numargs = 1;
+	req->out.args[0].size = count;
+	req->out.args[0].value = buf;
+	request_send(fc, req);
+	res = req->out.h.error;
+	if (!res)
+		res = req->out.args[0].size;
+	fuse_put_request(fc, req);
+	return res;
+}
+
+static int fuse_readpage(struct file *file, struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	char *buffer;
+	ssize_t res;
+	loff_t pos;
+
+	pos = (loff_t) page->index << PAGE_CACHE_SHIFT;
+	buffer = kmap(page);
+	res = fuse_send_read(file, inode, buffer, pos, PAGE_CACHE_SIZE);
+	if (res >= 0) {
+		if (res < PAGE_CACHE_SIZE) 
+			memset(buffer + res, 0, PAGE_CACHE_SIZE - res);
+		flush_dcache_page(page);
+		SetPageUptodate(page);
+		res = 0;
+	}
+	kunmap(page);
+	unlock_page(page);
+	return res;
+}
+
+static ssize_t fuse_send_write(struct fuse_req *req, struct fuse_file *ff,
+			       struct inode *inode, const char *buf,
+			       loff_t pos, size_t count)
+{
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_write_in inarg;
+	struct fuse_write_out outarg;
+	ssize_t res;
+	
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.writepage = 0;
+	inarg.fh = ff->fh;
+	inarg.offset = pos;
+	inarg.size = count;
+	req->in.h.opcode = FUSE_WRITE;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 2;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->in.args[1].size = count;
+	req->in.args[1].value = buf;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	res = req->out.h.error;
+	if (!res) {
+		if (outarg.size > count)
+			return -EPROTO;
+		else
+			return outarg.size;
+	}
+	else
+		return res;
+}
+
+static int write_buffer(struct inode *inode, struct file *file,
+			struct page *page, unsigned offset, size_t count)
+{
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_file *ff = file->private_data;
+	char *buffer;
+	ssize_t res;
+	loff_t pos;
+	struct fuse_req *req;
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
+	
+	pos = ((loff_t) page->index << PAGE_CACHE_SHIFT) + offset;
+	buffer = kmap(page);
+	res = fuse_send_write(req, ff, inode, buffer + offset, pos, count);
+	fuse_put_request(fc, req);
+	if (res >= 0) {
+		if (res < count) {
+			printk("fuse: short write\n");
+			res = -EPROTO;
+		} else
+			res = 0;
+	}
+	kunmap(page);
+	if (res)
+		SetPageError(page);
+	return res;
+}
+
+static int fuse_prepare_write(struct file *file, struct page *page,
+			      unsigned offset, unsigned to)
+{
+	/* No op */
+	return 0;
+}
+
+static int fuse_commit_write(struct file *file, struct page *page,
+			     unsigned offset, unsigned to)
+{
+	int err;
+	struct inode *inode = page->mapping->host;
+
+	err = write_buffer(inode, file, page, offset, to - offset);
+	if (!err) {
+		loff_t pos = (page->index << PAGE_CACHE_SHIFT) + to;
+		if (pos > i_size_read(inode))
+			i_size_write(inode, pos);
+		
+		if (offset == 0 && to == PAGE_CACHE_SIZE) {
+			clear_page_dirty(page);
+			SetPageUptodate(page);
+		}
+
+	}
+	return err;
+}
+
+static struct file_operations fuse_file_operations = {
+	.read		= generic_file_read,
+	.write		= generic_file_write,
+	.mmap		= generic_file_readonly_mmap,
+	.open		= fuse_open,
+	.flush		= fuse_flush,
+	.release	= fuse_release,
+	.fsync		= fuse_fsync,
+	.sendfile	= generic_file_sendfile,
+};
+
+static struct address_space_operations fuse_file_aops  = {
+	.readpage	= fuse_readpage,
+	.prepare_write	= fuse_prepare_write,
+	.commit_write	= fuse_commit_write,
+	.set_page_dirty = __set_page_dirty_nobuffers,
+};
+
+void fuse_init_file_inode(struct inode *inode)
+{
+	inode->i_fop = &fuse_file_operations;
+	inode->i_data.a_ops = &fuse_file_aops;
+}
--- linux-2.6.10-rc2/include/linux/fuse.h	2004-11-20 22:56:24.000000000 +0100
+++ linux-2.6.10-rc2-fuse/include/linux/fuse.h	2004-11-20 22:56:23.000000000 +0100
@@ -72,18 +72,18 @@ enum fuse_opcode {
 	FUSE_RMDIR	   = 11,
 	FUSE_RENAME	   = 12,
 	FUSE_LINK	   = 13,
-	/* FUSE_OPEN	   = 14, */
-	/* FUSE_READ	   = 15, */
-	/* FUSE_WRITE	   = 16, */
+	FUSE_OPEN	   = 14,
+	FUSE_READ	   = 15,
+	FUSE_WRITE	   = 16,
 	FUSE_STATFS	   = 17,
-	/* FUSE_RELEASE       = 18, */
+	FUSE_RELEASE       = 18,
 	/* FUSE_INVALIDATE    = 19, */
-	/* FUSE_FSYNC         = 20, */
+	FUSE_FSYNC         = 20,
 	/* FUSE_SETXATTR      = 21, */
 	/* FUSE_GETXATTR      = 22, */
 	/* FUSE_LISTXATTR     = 23, */
 	/* FUSE_REMOVEXATTR   = 24, */
-	/* FUSE_FLUSH         = 25, */
+	FUSE_FLUSH         = 25,
 };
 
 /* Conservative buffer size for the client */
@@ -139,10 +139,51 @@ struct fuse_setattr_in {
 	unsigned int valid;
 };
 
+struct fuse_open_in {
+	unsigned int flags;
+};
+
+struct fuse_open_out {
+	unsigned long fh;
+	unsigned int _open_flags;
+};
+
+struct fuse_release_in {
+	unsigned long fh;
+	unsigned int flags;
+};
+
+struct fuse_flush_in {
+	unsigned long fh;
+	unsigned int _nref;
+};
+
+struct fuse_read_in {
+	unsigned long fh;
+	unsigned long long offset;
+	unsigned int size;
+};
+
+struct fuse_write_in {
+	int writepage;
+	unsigned long fh;
+	unsigned long long offset;
+	unsigned int size;
+};
+
+struct fuse_write_out {
+	unsigned int size;
+};
+
 struct fuse_statfs_out {
 	struct fuse_kstatfs st;
 };
 
+struct fuse_fsync_in {
+	unsigned long fh;
+	int datasync;
+};
+
 struct fuse_in_header {
 	int unique;
 	enum fuse_opcode opcode;
