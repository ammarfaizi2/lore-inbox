Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbVAKQsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVAKQsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVAKQsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:48:23 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:30592 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262833AbVAKQ3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:29:19 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/11] FUSE - file operations
Message-Id: <E1CoOt9-0003LE-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Jan 2005 17:28:59 +0100
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
diff -Nurp a/fs/fuse/Makefile b/fs/fuse/Makefile
--- a/fs/fuse/Makefile	2005-01-11 16:28:29.000000000 +0100
+++ b/fs/fuse/Makefile	2005-01-11 16:28:28.000000000 +0100
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FUSE_FS) += fuse.o
 
-fuse-objs := dev.o dir.o inode.o
+fuse-objs := dev.o dir.o file.o inode.o
diff -Nurp a/fs/fuse/file.c b/fs/fuse/file.c
--- a/fs/fuse/file.c	1970-01-01 01:00:00.000000000 +0100
+++ b/fs/fuse/file.c	2005-01-11 16:28:28.000000000 +0100
@@ -0,0 +1,331 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2001-2005  Miklos Szeredi <miklos@szeredi.hu>
+
+  This program can be distributed under the terms of the GNU GPL.
+  See the file COPYING.
+*/
+
+#include "fuse_i.h"
+
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+
+static int fuse_open(struct inode *inode, struct file *file)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
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
+	if (get_node_id(inode) == FUSE_ROOT_ID) {
+		int err = fuse_do_getattr(inode);
+		if (err)
+		 	return err;
+	}
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
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
+	inarg.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
+	req->in.h.opcode = FUSE_OPEN;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (!err)
+		invalidate_inode_pages(inode->i_mapping);
+	if (err) {
+		fuse_request_free(ff->release_req);
+		kfree(ff);
+	} else {
+		ff->fh = outarg.fh;
+		file->private_data = ff;
+	}
+
+ out_put_request:
+	fuse_put_request(fc, req);
+	return err;
+}
+
+static int fuse_release(struct inode *inode, struct file *file)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_req *req = ff->release_req;
+	struct fuse_release_in *inarg = &req->misc.release_in;
+
+	inarg->fh = ff->fh;
+	inarg->flags = file->f_flags & ~O_EXCL;
+	req->in.h.opcode = FUSE_RELEASE;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(struct fuse_release_in);
+	req->in.args[0].value = inarg;
+	request_send_background(fc, req);
+	kfree(ff);
+
+	/* Return value is ignored by VFS */
+	return 0;
+}
+
+static int fuse_flush(struct file *file)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_req *req;
+	struct fuse_flush_in inarg;
+	int err;
+
+	if (fc->no_flush)
+		return 0;
+
+	req = fuse_get_request_nonint(fc);
+	if (!req)
+		return -EINTR;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.fh = ff->fh;
+	req->in.h.opcode = FUSE_FLUSH;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->file = file;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	request_send_nonint(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
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
+	struct fuse_conn *fc = get_fuse_conn(inode);
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
+	inarg.fsync_flags = datasync ? 1 : 0;
+	req->in.h.opcode = FUSE_FSYNC;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->file = file;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (err == -ENOSYS) {
+		fc->no_fsync = 1;
+		err = 0;
+	}
+	return err;
+}
+
+static ssize_t fuse_send_read(struct fuse_req *req, struct file *file,
+			      struct inode *inode, loff_t pos,  size_t count)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_read_in inarg;
+
+	memset(&inarg, 0, sizeof(struct fuse_read_in));
+	inarg.fh = ff->fh;
+	inarg.offset = pos;
+	inarg.size = count;
+	req->in.h.opcode = FUSE_READ;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->file = file;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(struct fuse_read_in);
+	req->in.args[0].value = &inarg;
+	req->out.argpages = 1;
+	req->out.argvar = 1;
+	req->out.numargs = 1;
+	req->out.args[0].size = count;
+	request_send_nonint(fc, req);
+	return req->out.args[0].size;
+}
+
+static int fuse_readpage(struct file *file, struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	loff_t pos = (loff_t) page->index << PAGE_CACHE_SHIFT;
+	struct fuse_req *req = fuse_get_request_nonint(fc);
+	int err = -EINTR;
+	if (!req)
+		goto out;
+
+	req->out.page_zeroing = 1;
+	req->num_pages = 1;
+	req->pages[0] = page;
+	fuse_send_read(req, file, inode, pos, PAGE_CACHE_SIZE);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (!err)
+		SetPageUptodate(page);
+ out:
+	unlock_page(page);
+	return err;
+}
+
+static ssize_t fuse_send_write(struct fuse_req *req, struct file *file,
+			       struct inode *inode, loff_t pos, size_t count)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_write_in inarg;
+	struct fuse_write_out outarg;
+
+	memset(&inarg, 0, sizeof(struct fuse_write_in));
+	inarg.fh = ff->fh;
+	inarg.offset = pos;
+	inarg.size = count;
+	req->in.h.opcode = FUSE_WRITE;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->file = file;
+	req->in.argpages = 1;
+	req->in.numargs = 2;
+	req->in.args[0].size = sizeof(struct fuse_write_in);
+	req->in.args[0].value = &inarg;
+	req->in.args[1].size = count;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(struct fuse_write_out);
+	req->out.args[0].value = &outarg;
+	request_send_nonint(fc, req);
+	return outarg.size;
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
+	ssize_t nres;
+	unsigned count = to - offset;
+	struct inode *inode = page->mapping->host;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	loff_t pos = ((loff_t) page->index << PAGE_CACHE_SHIFT) + offset;
+	struct fuse_req *req = fuse_get_request_nonint(fc);
+	if (!req)
+		return -EINTR;
+
+	req->num_pages = 1;
+	req->pages[0] = page;
+	req->page_offset = offset;
+	nres = fuse_send_write(req, file, inode, pos, count);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (!err && nres != count)
+		err = -EIO;
+	if (!err) {
+		pos += count;
+		if (pos > i_size_read(inode))
+			i_size_write(inode, pos);
+
+		if (offset == 0 && to == PAGE_CACHE_SIZE) {
+			clear_page_dirty(page);
+			SetPageUptodate(page);
+		}
+	} else if (err == -EINTR || err == -EIO)
+		fuse_invalidate_attr(inode);
+	return err;
+}
+
+static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	if ((vma->vm_flags & VM_SHARED)) {
+		if ((vma->vm_flags & VM_WRITE))
+			return -ENODEV;
+		else
+			vma->vm_flags &= ~VM_MAYWRITE;
+	}
+	return generic_file_mmap(file, vma);
+}
+
+static int fuse_set_page_dirty(struct page *page)
+{
+	printk("fuse_set_page_dirty: should not happen\n");
+	dump_stack();
+	return 0;
+}
+
+static struct file_operations fuse_file_operations = {
+	.read		= generic_file_read,
+	.write		= generic_file_write,
+	.mmap		= fuse_file_mmap,
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
+	.set_page_dirty	= fuse_set_page_dirty,
+};
+
+void fuse_init_file_inode(struct inode *inode)
+{
+	inode->i_fop = &fuse_file_operations;
+	inode->i_data.a_ops = &fuse_file_aops;
+}
diff -Nurp a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
--- a/fs/fuse/fuse_i.h	2005-01-11 16:28:28.000000000 +0100
+++ b/fs/fuse/fuse_i.h	2005-01-11 16:28:28.000000000 +0100
@@ -37,6 +37,15 @@ struct fuse_inode {
 	unsigned long i_time;
 };
 
+/** FUSE specific file data */
+struct fuse_file {
+	/** Request reserved for flush and release */
+	struct fuse_req *release_req;
+
+	/** File handle used by userspace */
+	u64 fh;
+};
+
 /** One input argument of a request */
 struct fuse_in_arg {
 	unsigned size;
@@ -133,6 +142,7 @@ struct fuse_req {
 	/** Data for asynchronous requests */
 	union {
 		struct fuse_forget_in forget_in;
+		struct fuse_release_in release_in;
 		struct fuse_init_in_out init_in_out;
 	} misc;
 
@@ -194,6 +204,12 @@ struct fuse_conn {
 	/** The next unique request id */
 	int reqctr;
 
+	/** Is fsync not implemented by fs? */
+	unsigned no_fsync : 1;
+
+	/** Is flush not implemented by fs? */
+	unsigned no_flush : 1;
+
 	/** Backing dev info */
 	struct backing_dev_info bdi;
 };
@@ -258,6 +274,11 @@ void fuse_send_forget(struct fuse_conn *
 		      unsigned long nodeid, int version);
 
 /**
+ * Initialise file operations on a regular file
+ */
+void fuse_init_file_inode(struct inode *inode);
+
+/**
  * Initialise inode operations on regular files and special files
  */
 void fuse_init_common(struct inode *inode);
diff -Nurp a/fs/fuse/inode.c b/fs/fuse/inode.c
--- a/fs/fuse/inode.c	2005-01-11 16:28:28.000000000 +0100
+++ b/fs/fuse/inode.c	2005-01-11 16:28:28.000000000 +0100
@@ -123,6 +123,7 @@ static void fuse_init_inode(struct inode
 	i_size_write(inode, attr->size);
 	if (S_ISREG(inode->i_mode)) {
 		fuse_init_common(inode);
+		fuse_init_file_inode(inode);
 	} else if (S_ISDIR(inode->i_mode))
 		fuse_init_dir(inode);
 	else if (S_ISLNK(inode->i_mode))
@@ -136,6 +137,7 @@ static void fuse_init_inode(struct inode
 		/* Don't let user create weird files */
 		inode->i_mode = S_IFREG;
 		fuse_init_common(inode);
+		fuse_init_file_inode(inode);
 	}
 }
 
diff -Nurp a/include/linux/fuse.h b/include/linux/fuse.h
--- a/include/linux/fuse.h	2005-01-11 16:28:28.000000000 +0100
+++ b/include/linux/fuse.h	2005-01-11 16:28:28.000000000 +0100
@@ -74,7 +74,13 @@ enum fuse_opcode {
 	FUSE_RMDIR	   = 11,
 	FUSE_RENAME	   = 12,
 	FUSE_LINK	   = 13,
+	FUSE_OPEN	   = 14,
+	FUSE_READ	   = 15,
+	FUSE_WRITE	   = 16,
 	FUSE_STATFS	   = 17,
+	FUSE_RELEASE       = 18,
+	FUSE_FSYNC         = 20,
+	FUSE_FLUSH         = 25,
 	FUSE_INIT          = 26
 };
 
@@ -132,10 +138,51 @@ struct fuse_setattr_in {
 	struct fuse_attr attr;
 };
 
+struct fuse_open_in {
+	__u32	flags;
+};
+
+struct fuse_open_out {
+	__u64	fh;
+	__u32	open_flags;
+};
+
+struct fuse_release_in {
+	__u64	fh;
+	__u32	flags;
+};
+
+struct fuse_flush_in {
+	__u64	fh;
+	__u32	flush_flags;
+};
+
+struct fuse_read_in {
+	__u64	fh;
+	__u64	offset;
+	__u32	size;
+};
+
+struct fuse_write_in {
+	__u64	fh;
+	__u64	offset;
+	__u32	size;
+	__u32	write_flags;
+};
+
+struct fuse_write_out {
+	__u32	size;
+};
+
 struct fuse_statfs_out {
 	struct fuse_kstatfs st;
 };
 
+struct fuse_fsync_in {
+	__u64	fh;
+	__u32	fsync_flags;
+};
+
 struct fuse_init_in_out {
 	__u32	major;
 	__u32	minor;
