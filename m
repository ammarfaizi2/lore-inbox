Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVFBTia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVFBTia (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 15:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVFBTi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 15:38:29 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:40376 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261261AbVFBTgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 15:36:17 -0400
Message-Id: <200506021935.j52JZtH9001240@ms-smtp-01-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Thu,  2 Jun 2005 14:35:52 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2/7] v9fs: VFS file, dentry, and directory operations (2.0-rc7)
Cc: v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [2/7] of the v9fs-2.0-rc7 patch against Linux 2.6.

This part of the patch contains the VFS file, dentry, & directory interfaces.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>


 ----------

 vfs_dentry.c |  140 +++++++++++++++++++
 vfs_dir.c    |  242 ++++++++++++++++++++++++++++++++++
 vfs_file.c   |  419 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 801 insertions(+)

 ----------

Index: fs/9p/vfs_dir.c
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ 7d6ca5270f0ecf9306a944a3d39897a97dc9f67f/fs/9p/vfs_dir.c  (mode:100644)
@@ -0,0 +1,242 @@
+/*
+ * linux/fs/9p/vfs_dir.c
+ *
+ * This file contains vfs directory ops for the 9P2000 protocol.
+ *
+ *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/inet.h>
+
+#include "debug.h"
+#include "idpool.h"
+#include "v9fs.h"
+#include "9p.h"
+#include "v9fs_vfs.h"
+#include "conv.h"
+#include "fid.h"
+
+/**
+ * dt_type - return file type
+ * @mistat: mistat structure
+ *
+ */
+
+static inline int dt_type(struct v9fs_stat *mistat)
+{
+	unsigned long perm = mistat->mode;
+	int rettype = DT_REG;
+
+	if (perm & V9FS_DMDIR)
+		rettype = DT_DIR;
+	if (perm & V9FS_DMSYMLINK)
+		rettype = DT_LNK;
+
+	return rettype;
+}
+
+/**
+ * v9fs_dir_readdir - read a directory
+ * @filep: opened file structure
+ * @dirent: directory structure ???
+ * @filldir: function to populate directory structure ???
+ *
+ */
+
+static int v9fs_dir_readdir(struct file *filp, void *dirent, filldir_t filldir)
+{
+	struct v9fs_fcall *fcall = NULL;
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+	struct v9fs_fid *file = filp->private_data;
+	unsigned int i, n;
+	int fid = -1;
+	int ret = 0;
+	struct v9fs_stat *mi = NULL;
+	int over = 0;
+
+	dprintk(DEBUG_VFS, "name %s\n", filp->f_dentry->d_name.name);
+
+	if (!file)
+		return -EBADF;
+
+	fid = file->fid;
+	if (fid < 0)
+		return -EBADF;
+
+	mi = kmalloc(v9ses->maxdata, GFP_KERNEL);
+	if (!mi)
+		return -ENOMEM;
+
+	if (file->rdir_fcall && (filp->f_pos != file->rdir_pos)) {
+		kfree( file->rdir_fcall);
+		file->rdir_fcall = NULL;
+	}
+
+	if (file->rdir_fcall) {
+		n = file->rdir_fcall->params.rread.count;
+		i = file->rdir_fpos;
+		while (i < n) {
+			int s = v9fs_deserialize_stat(v9ses,
+				 file->rdir_fcall->params.rread.data + i,
+				 n - i, mi, v9ses->maxdata);
+
+			if (s == 0) {
+				dprintk(DEBUG_ERROR,
+					"error while deserializing mistat\n");
+				ret = -EIO;
+				goto FreeStructs;
+			}
+
+			over =
+			    filldir(dirent, mi->name, strlen(mi->name),
+				    filp->f_pos, v9fs_qid2ino(&mi->qid),
+				    dt_type(mi));
+
+			if (over) {
+				file->rdir_fpos = i;
+				file->rdir_pos = filp->f_pos;
+				break;
+			}
+
+			i += s;
+			filp->f_pos += s;
+		}
+
+		if (!over) {
+			kfree( file->rdir_fcall);
+			file->rdir_fcall = NULL;
+		}
+	}
+
+	while (!over) {
+		ret = v9fs_t_read(v9ses, fid, filp->f_pos, 1024, &fcall);
+		if (ret < 0) {
+			dprintk(DEBUG_ERROR, "error while reading: %d: %p\n",
+				ret, fcall);
+			goto FreeStructs;
+		} else if (ret == 0)
+			break;
+
+		n = ret;
+		i = 0;
+		while (i < n) {
+			int s = v9fs_deserialize_stat(v9ses,
+						   fcall->params.rread.data +
+						   i, n - i, mi, v9ses->maxdata);
+						      
+
+			if (s == 0) {
+				dprintk(DEBUG_ERROR,
+					"error while deserializing mistat\n");
+				return -EIO;
+			}
+
+			over =
+			    filldir(dirent, mi->name, strlen(mi->name),
+				    filp->f_pos, v9fs_qid2ino(&mi->qid),
+				    dt_type(mi));
+
+			if (over) {
+				file->rdir_fcall = fcall;
+				file->rdir_fpos = i;
+				file->rdir_pos = filp->f_pos;
+				fcall = NULL;
+				break;
+			}
+
+			i += s;
+			filp->f_pos += s;
+		}
+
+		kfree( fcall);
+	}
+
+      FreeStructs:
+	kfree( fcall);
+	kfree( mi);
+	return ret;
+}
+
+/**
+ * v9fs_dir_release - close a directory
+ * @inode: inode of the directory
+ * @filp: file pointer to a directory
+ *
+ */
+
+int v9fs_dir_release(struct inode *inode, struct file *filp)
+{
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+	struct v9fs_fid *fid = filp->private_data;
+	int fidnum = -1;
+
+	if (!fid) {
+		dprintk(DEBUG_ERROR,
+			"can't happen: no private data (ino %lu) (filp %p)\n",
+			inode->i_ino, filp);
+		return -EBADF;
+	}
+
+	dprintk(DEBUG_VFS, "inode: %p filp: %p fid: %d\n", inode, filp,
+		fid->fid);
+	fidnum = fid->fid;
+
+	filemap_fdatawrite(inode->i_mapping);
+	filemap_fdatawait(inode->i_mapping);
+
+	if (fidnum >= 0) {
+		fid->fidopen--;
+		dprintk(DEBUG_VFS, "fidopen: %d v9f->fid: %d\n", fid->fidopen,
+			fid->fid);
+
+		if (fid->fidopen == 0) {
+			if (v9fs_t_clunk(v9ses, fidnum, NULL))
+				dprintk(DEBUG_ERROR, "clunk failed\n");
+
+			v9fs_put_idpool(fid->fid, &v9ses->fidpool);
+		}
+
+		if (fid->rdir_fcall) {
+			kfree( fid->rdir_fcall);
+			fid->rdir_fcall = NULL;
+		}
+
+		filp->private_data = NULL;
+		v9fs_fid_destroy(fid);
+	}
+
+	d_drop(filp->f_dentry);
+	return 0;
+}
+
+struct file_operations v9fs_dir_operations = {
+	.read = generic_read_dir,
+	.readdir = v9fs_dir_readdir,
+	.open = v9fs_file_open,
+	.release = v9fs_dir_release,
+};
Index: fs/9p/vfs_file.c
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ 7d6ca5270f0ecf9306a944a3d39897a97dc9f67f/fs/9p/vfs_file.c  (mode:100644)
@@ -0,0 +1,419 @@
+/*
+ *  linux/fs/9p/vfs_file.c
+ *
+ * This file contians vfs file ops for 9P2000. 
+ *
+ *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/inet.h>
+#include <linux/version.h>
+#include <linux/list.h>
+#include <asm/uaccess.h>
+
+#include "debug.h"
+#include "idpool.h"
+#include "v9fs.h"
+#include "9p.h"
+#include "v9fs_vfs.h"
+#include "fid.h"
+
+/**
+ * v9fs_file_open - open a file (or directory)
+ * @inode: inode to be opened
+ * @file: file being opened
+ *
+ */
+
+int v9fs_file_open(struct inode *inode, struct file *file)
+{
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+	struct v9fs_fid *v9fid = v9fs_fid_lookup(file->f_dentry, FID_WALK);
+	struct v9fs_fid *v9newfid = NULL;
+	struct v9fs_fcall *fcall = NULL;
+	int open_mode = 0;
+	unsigned int iounit = 0;
+	int newfid = -1;
+	long result = -1;
+
+	dprintk(DEBUG_VFS, "inode: %p file: %p v9fid= %p\n", inode, file,
+		v9fid);
+
+	if (!v9fid) {
+		struct dentry *dentry = file->f_dentry;
+		dprintk(DEBUG_ERROR, "Couldn't resolve fid from dentry\n");
+
+		/* XXX - some duplication from lookup, generalize later */
+		/* basically vfs_lookup is too heavy weight */
+		v9fid = v9fs_fid_lookup(file->f_dentry, FID_OP);
+		if (!v9fid)
+			return -EBADF;
+
+		v9fid = v9fs_fid_lookup(dentry->d_parent, FID_WALK);
+		if (!v9fid)
+			return -EBADF;
+
+		newfid = v9fs_get_idpool(&v9ses->fidpool);
+		if (newfid < 0) {
+			eprintk(KERN_WARNING, "newfid fails!\n");
+			return -ENOSPC;
+		}
+
+		result =
+		    v9fs_t_walk(v9ses, v9fid->fid, newfid,
+				(char *)file->f_dentry->d_name.name, NULL);
+		if (result < 0) {
+			v9fs_put_idpool(newfid, &v9ses->fidpool);
+			dprintk(DEBUG_ERROR, "rewalk didn't work\n");
+			return -EBADF;
+		}
+
+		v9fid = v9fs_fid_create(dentry);
+		if (v9fid == NULL) {
+			dprintk(DEBUG_ERROR, "couldn't insert\n");
+			return -ENOMEM;
+		}
+		v9fid->fid = newfid;
+	}
+
+	if (v9fid->fidcreate) {
+		/* create case */
+		newfid = v9fid->fid;
+		iounit = v9fid->iounit;
+		v9fid->fidcreate = 0;
+	} else {
+		if (!S_ISDIR(inode->i_mode))
+			newfid = v9fid->fid;
+		else {
+			newfid = v9fs_get_idpool(&v9ses->fidpool);
+			if (newfid < 0) {
+				eprintk(KERN_WARNING, "allocation failed\n");
+				return -ENOSPC;
+			}
+			/* This would be a somewhat critical clone */
+			result =
+			    v9fs_t_walk(v9ses, v9fid->fid, newfid, NULL,
+					&fcall);
+			if (result < 0) {
+				dprintk(DEBUG_ERROR, "clone error: %s\n",
+					FCALL_ERROR(fcall));
+				kfree( fcall);
+				return result;
+			}
+
+			v9newfid = v9fs_fid_create(file->f_dentry);
+			v9newfid->fid = newfid;
+			v9newfid->qid = v9fid->qid;
+			v9newfid->iounit = v9fid->iounit;
+			v9newfid->fidopen = 0;
+			v9newfid->fidclunked = 0;
+			v9newfid->v9ses = v9ses;
+			v9fid = v9newfid;
+			kfree( fcall);
+		}
+
+		/* TODO: do special things for O_EXCL, O_NOFOLLOW, O_SYNC */
+		/* translate open mode appropriately */
+		open_mode = file->f_flags & 0x3;
+
+		if (file->f_flags & O_EXCL)
+			open_mode |= V9FS_OEXCL;
+
+		if (v9ses->extended) {
+			if (file->f_flags & O_TRUNC)
+				open_mode |= V9FS_OTRUNC;
+
+			if (file->f_flags & O_APPEND)
+				open_mode |= V9FS_OAPPEND;
+		}
+
+		result = v9fs_t_open(v9ses, newfid, open_mode, &fcall);
+		if (result < 0) {
+			dprintk(DEBUG_ERROR,
+				"open failed, open_mode 0x%x: %s\n", open_mode,
+				FCALL_ERROR(fcall));
+			kfree( fcall);
+			return result;
+		}
+
+		iounit = fcall->params.ropen.iounit;
+		kfree( fcall);
+	}
+
+	if (file) {
+		file->private_data = v9fid;
+
+		v9fid->rdir_pos = 0;
+		v9fid->rdir_fcall = NULL;
+	}
+
+	v9fid->fidopen = 1;
+	v9fid->filp = file;
+	v9fid->iounit = iounit;
+
+	return 0;
+}
+
+/**
+ * v9fs_file_lock - lock a file (or directory)
+ * @inode: inode to be opened
+ * @file: file being opened
+ *
+ * XXX - this looks like a local only lock, we should extend into 9P
+ *       by using open exclusive
+ */
+
+static int v9fs_file_lock(struct file *filp, int cmd, struct file_lock *fl)
+{
+	int res = 0;
+	struct inode *inode = filp->f_dentry->d_inode;
+
+	dprintk(DEBUG_VFS, "filp: %p lock: %p\n", filp, fl);
+	if (!inode)
+		return -EINVAL;
+
+	/* No mandatory locks */
+	if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
+		return -ENOLCK;
+
+	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
+		filemap_fdatawrite(inode->i_mapping);
+		filemap_fdatawait(inode->i_mapping);
+		invalidate_inode_pages(&inode->i_data);
+	}
+
+	return res;
+}
+
+/**
+ * v9fs_read - read from a file (internal)
+ * @filep: file pointer to read
+ * @data: data buffer to read data into
+ * @count: size of buffer
+ * @offset: offset at which to read data
+ *
+ */
+
+static ssize_t
+v9fs_read(struct file *filp, char *buffer, size_t count, loff_t * offset)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+	struct v9fs_fid *v9f = filp->private_data;
+	struct v9fs_fcall *fcall = NULL;
+	int fid = v9f->fid;
+	int rsize = 0;
+	int result = 0;
+	int total = 0;
+
+	dprintk(DEBUG_VFS, "\n");
+
+	rsize = v9ses->maxdata - V9FS_IOHDRSZ;
+	if (v9f->iounit != 0 && rsize > v9f->iounit)
+		rsize = v9f->iounit;
+
+	do {
+		if (count < rsize)
+			rsize = count;
+
+		result = v9fs_t_read(v9ses, fid, *offset, rsize, &fcall);
+
+		if (result < 0) {
+			printk(KERN_ERR "9P2000: v9fs_t_read returned %d\n",
+			       result);
+
+			kfree( fcall);
+			return total;
+		} else
+			*offset += result;
+
+		/* XXX - extra copy */
+		memcpy(buffer, fcall->params.rread.data, result);
+		count -= result;
+		buffer += result;
+		total += result;
+
+		kfree( fcall);
+
+		if (result < rsize)
+			break;
+	} while (count);
+
+	return total;
+}
+
+/**
+ * v9fs_file_read - read from a file
+ * @filep: file pointer to read
+ * @data: data buffer to read data into
+ * @count: size of buffer
+ * @offset: offset at which to read data
+ *
+ */
+
+static ssize_t
+v9fs_file_read(struct file *filp, char __user * data, size_t count,
+	       loff_t * offset)
+{
+	int retval = -1;
+	int ret = 0;
+	char *buffer = NULL;
+
+	buffer = kmalloc(count, GFP_KERNEL);
+	if (buffer < 0) 
+		return -ENOMEM;
+
+	retval = v9fs_read(filp, buffer, count, offset);
+	if (retval > 0) {
+		if ((ret = copy_to_user(data, buffer, retval)) != 0) {
+			dprintk(DEBUG_ERROR, "Problem copying to user %d\n", ret);
+			retval = ret;
+		}
+	}
+
+	kfree(buffer);
+
+	return retval;
+}
+
+/**
+ * v9fs_write - write to a file
+ * @filep: file pointer to write
+ * @data: data buffer to write data from
+ * @count: size of buffer
+ * @offset: offset at which to write data
+ *
+ */
+
+static ssize_t
+v9fs_write(struct file *filp, char *buffer, size_t count, loff_t * offset)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+	struct v9fs_fid *v9fid = filp->private_data;
+	struct v9fs_fcall *fcall;
+	int fid = v9fid->fid;
+	int result = -EIO;
+	int rsize = 0;
+	int total = 0;
+
+	dprintk(DEBUG_VFS, "data %p count %d offset %x\n", buffer, (int)count,
+		(int)*offset);
+	rsize = v9ses->maxdata - V9FS_IOHDRSZ;
+	if (v9fid->iounit != 0 && rsize > v9fid->iounit)
+		rsize = v9fid->iounit;
+
+	dump_data(buffer, count);
+
+	do {
+		if (count < rsize)
+			rsize = count;
+
+		result =
+		    v9fs_t_write(v9ses, fid, *offset, rsize, buffer, &fcall);
+		if (result < 0) {
+			eprintk(KERN_ERR, "error while writing: %s(%d)\n",
+				FCALL_ERROR(fcall), result);
+			kfree( fcall);
+			return result;
+		} else
+			*offset += result;
+
+		kfree( fcall);
+
+		if (result != rsize) {
+			eprintk(KERN_ERR,
+				"short write: v9fs_t_write returned %d\n",
+				result);
+			break;
+		}
+
+		count -= result;
+		buffer += result;
+		total += result;
+	} while (count);
+
+	return total;
+}
+
+/**
+ * v9fs_file_write - write to a file
+ * @filep: file pointer to write
+ * @data: data buffer to write data from
+ * @count: size of buffer
+ * @offset: offset at which to write data
+ *
+ */
+
+static ssize_t
+v9fs_file_write(struct file *filp, const char __user * data,
+		size_t count, loff_t * offset)
+{
+	int ret = -1;
+	char *buffer;
+
+	buffer = kmalloc(count, GFP_KERNEL);
+	if (buffer == NULL) 
+		return -ENOMEM;
+
+	ret = copy_from_user(buffer, data, count);
+	if (ret)
+		dprintk(DEBUG_ERROR, "Problem copying from user\n");
+	else
+		ret = v9fs_write(filp, buffer, count, offset);
+
+	kfree(buffer);
+
+	return ret;
+}
+
+/**
+ * v9fs_file_mmap - initiate an mmap on a file
+ *
+ * @filep - file pointer to write
+ * @vmarea - vm area struct
+ *
+ * v9fs doesn't support this right now in mainline branch
+ *
+ */
+
+static int v9fs_file_mmap(struct file *filp, struct vm_area_struct *vm)
+{
+	dprintk(DEBUG_VFS, " filp: %p - NOT IMPLEMENTED\n", filp);
+
+	return -ENOSYS;
+}
+
+struct file_operations v9fs_file_operations = {
+	.llseek = generic_file_llseek,
+	.read = v9fs_file_read,
+	.write = v9fs_file_write,
+	.mmap = v9fs_file_mmap,
+	.open = v9fs_file_open,
+	.release = v9fs_dir_release,
+	.lock = v9fs_file_lock,
+};
Index: fs/9p/vfs_dentry.c
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ 7d6ca5270f0ecf9306a944a3d39897a97dc9f67f/fs/9p/vfs_dentry.c  (mode:100644)
@@ -0,0 +1,140 @@
+/*
+ *  linux/fs/9p/vfs_dentry.c
+ *
+ * This file contians vfs dentry ops for the 9P2000 protocol.
+ *
+ *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/pagemap.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/inet.h>
+#include <linux/namei.h>
+
+#include "debug.h"
+#include "idpool.h"
+#include "v9fs.h"
+#include "9p.h"
+#include "v9fs_vfs.h"
+#include "conv.h"
+#include "fid.h"
+
+
+/**
+ * v9fs_dentry_validate - VFS dcache hook to validate cache
+ * @dentry:  dentry that is being validated
+ * @nd: path data
+ *
+ * dcache really shouldn't be used for 9P2000 as at all due to
+ * potential attached semantics to directory traversal (walk).
+ *
+ * FUTURE: look into how to use dcache to allow multi-stage
+ * walks in Plan 9 & potential for better dcache operation which
+ * would remain valid for Plan 9 semantics.  Older versions 
+ * had validation via stat for those interested.  However, since
+ * stat has the same approximate overhead as walk there really
+ * is no difference.  The only improvement would be from a 
+ * time-decay cache like NFS has and that undermines the
+ * synchronous nature of 9P2000.
+ *
+ */
+
+static int v9fs_dentry_validate(struct dentry *dentry, struct nameidata *nd)
+{
+	struct dentry *dc = current->fs->pwd;
+
+	dprintk(DEBUG_VFS, "dentry: %s (%p)\n", dentry->d_iname, dentry);
+	if (v9fs_fid_lookup(dentry, FID_OP)) {
+		dprintk(DEBUG_VFS, "VALID\n");
+		return 1;
+	}
+
+	while (dc != NULL) {
+		if (dc == dentry) {
+			dprintk(DEBUG_VFS, "VALID\n");
+			return 1;
+		}
+		if (dc == dc->d_parent)
+			break;
+
+		dc = dc->d_parent;
+	}
+
+	dprintk(DEBUG_VFS, "INVALID\n");
+	return 0;
+}
+
+/**
+ * v9fs_dentry_delete - called when dentry refcount reaches 0
+* @dentry:  dentry that is being deleted
+ *
+ */
+
+static int v9fs_dentry_delete(struct dentry *dentry)
+{
+	dprintk(DEBUG_VFS, " dentry: %s (%p)\n", dentry->d_iname, dentry);
+	return 1;
+}
+
+/*
+ * v9fs_dentry_release - called when dentry is going to be freed
+* @dentry:  dentry that is being release
+ *
+ */
+
+void v9fs_dentry_release(struct dentry *dentry)
+{
+	dprintk(DEBUG_VFS, " dentry: %s (%p)\n", dentry->d_iname, dentry);
+
+	if (dentry->d_fsdata != NULL) {
+		struct list_head *fid_list = dentry->d_fsdata;
+		struct list_head *temp;
+		struct v9fs_fid *current_fid = NULL;
+		struct list_head *p;
+		struct v9fs_fcall *fcall = NULL;
+
+		list_for_each_safe(p, temp, fid_list) {
+			current_fid = list_entry(p, struct v9fs_fid, list);
+			if (v9fs_t_clunk
+			    (current_fid->v9ses, current_fid->fid, &fcall))
+				dprintk(DEBUG_ERROR, "clunk failed: %s\n",
+					FCALL_ERROR(fcall));
+
+			v9fs_put_idpool(current_fid->fid,
+					&current_fid->v9ses->fidpool);
+
+			kfree(fcall);
+			v9fs_fid_destroy(current_fid);
+		}
+
+		kfree(dentry->d_fsdata);	/* free the list_head */
+	}
+}
+
+struct dentry_operations v9fs_dentry_operations = {
+	.d_revalidate = v9fs_dentry_validate,
+	.d_delete = v9fs_dentry_delete,
+	.d_release = v9fs_dentry_release,
+};
