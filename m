Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVAJT2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVAJT2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVAJT0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:26:14 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:53426 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262405AbVAJTCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:02:49 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/11] FUSE - read-only operations
Message-Id: <E1Co4o8-00046I-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Jan 2005 20:02:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the read-only filesystem operations of FUSE.

This contains the following files:

 o dir.c
    - directory, symlink and file-inode operations

The following operations are added:

 o lookup
 o getattr
 o readlink
 o follow_link
 o directory open
 o readdir
 o directory release
 o permission
 o dentry revalidate
 o statfs

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
diff -Nurp a/fs/fuse/Makefile b/fs/fuse/Makefile
--- a/fs/fuse/Makefile	2005-01-10 19:28:38.000000000 +0100
+++ b/fs/fuse/Makefile	2005-01-10 19:28:38.000000000 +0100
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FUSE) += fuse.o
 
-fuse-objs := dev.o inode.o
+fuse-objs := dev.o dir.o inode.o
diff -Nurp a/fs/fuse/dev.c b/fs/fuse/dev.c
--- a/fs/fuse/dev.c	2005-01-10 19:28:38.000000000 +0100
+++ b/fs/fuse/dev.c	2005-01-10 19:28:38.000000000 +0100
@@ -642,6 +642,13 @@ static struct fuse_req *request_find(str
 	return NULL;
 }
 
+/* fget() needs to be done in this context */
+static void process_getdir(struct fuse_req *req)
+{
+	struct fuse_getdir_out_i *arg = req->out.args[0].value;
+	arg->file = fget(arg->fd);
+}
+
 static int copy_out_args(struct fuse_copy_state *cs, struct fuse_out *out,
 			 unsigned nbytes)
 {
@@ -714,6 +721,8 @@ static ssize_t fuse_dev_writev(struct fi
 	if (!err) {
 		if (req->interrupted)
 			err = -ENOENT;
+		else if (req->in.h.opcode == FUSE_GETDIR && !oh.error)
+			process_getdir(req);
 	} else if (!req->interrupted)
 		req->out.h.error = -EIO;
 	request_end(fc, req);
diff -Nurp a/fs/fuse/dir.c b/fs/fuse/dir.c
--- a/fs/fuse/dir.c	1970-01-01 01:00:00.000000000 +0100
+++ b/fs/fuse/dir.c	2005-01-10 19:28:38.000000000 +0100
@@ -0,0 +1,417 @@
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
+#include <linux/file.h>
+#include <linux/gfp.h>
+#include <linux/sched.h>
+
+static inline unsigned long time_to_jiffies(unsigned long sec,
+					    unsigned long nsec)
+{
+	/* prevent wrapping of jiffies */
+	if (sec + 1 >= LONG_MAX / HZ)
+		return 0;
+
+	return jiffies + sec * HZ + nsec / (1000000000 / HZ);
+}
+
+static void fuse_lookup_init(struct fuse_req *req, struct inode *dir,
+			     struct dentry *entry,
+			     struct fuse_entry_out *outarg)
+{
+	req->in.h.opcode = FUSE_LOOKUP;
+	req->in.h.nodeid = get_node_id(dir);
+	req->inode = dir;
+	req->in.numargs = 1;
+	req->in.args[0].size = entry->d_name.len + 1;
+	req->in.args[0].value = entry->d_name.name;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(struct fuse_entry_out);
+	req->out.args[0].value = outarg;
+}
+
+static int fuse_dentry_revalidate(struct dentry *entry, struct nameidata *nd)
+{
+	if (!entry->d_inode || is_bad_inode(entry->d_inode))
+		return 0;
+	else if (entry->d_time && time_after(jiffies, entry->d_time)) {
+		int err;
+		int version;
+		struct fuse_entry_out outarg;
+		struct inode *inode = entry->d_inode;
+		struct fuse_inode *fi = get_fuse_inode(inode);
+		struct fuse_conn *fc = get_fuse_conn(inode);
+		struct fuse_req *req = fuse_get_request_nonint(fc);
+		if (!req)
+			return 0;
+
+		fuse_lookup_init(req, entry->d_parent->d_inode, entry, &outarg);
+		request_send_nonint(fc, req);
+		version = req->out.h.unique;
+		err = req->out.h.error;
+		fuse_put_request(fc, req);
+		if (err || outarg.nodeid != get_node_id(inode) ||
+		    (outarg.attr.mode ^ inode->i_mode) & S_IFMT)
+			return 0;
+
+		fuse_change_attributes(inode, &outarg.attr);
+		inode->i_version = version;
+		entry->d_time = time_to_jiffies(outarg.entry_valid,
+						outarg.entry_valid_nsec);
+		fi->i_time = time_to_jiffies(outarg.attr_valid,
+					     outarg.attr_valid_nsec);
+	}
+	return 1;
+}
+
+static struct dentry_operations fuse_dentry_operations = {
+	.d_revalidate	= fuse_dentry_revalidate,
+};
+
+static int fuse_lookup_iget(struct inode *dir, struct dentry *entry,
+			    struct inode **inodep)
+{
+	int err;
+	int version;
+	struct fuse_entry_out outarg;
+	struct inode *inode = NULL;
+	struct fuse_conn *fc = get_fuse_conn(dir);
+	struct fuse_req *req;
+
+	if (entry->d_name.len > FUSE_NAME_MAX)
+		return -ENAMETOOLONG;
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	fuse_lookup_init(req, dir, entry, &outarg);
+	request_send(fc, req);
+	version = req->out.h.unique;
+	err = req->out.h.error;
+	if (!err) {
+		inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
+				  &outarg.attr, version);
+		if (!inode) {
+			fuse_send_forget(fc, req, outarg.nodeid, version);
+			return -ENOMEM;
+		}
+	}
+	fuse_put_request(fc, req);
+	if (err && err != -ENOENT)
+		return err;
+
+	if (inode) {
+		struct fuse_inode *fi = get_fuse_inode(inode);
+		entry->d_time =	time_to_jiffies(outarg.entry_valid,
+						outarg.entry_valid_nsec);
+		fi->i_time = time_to_jiffies(outarg.attr_valid,
+					     outarg.attr_valid_nsec);
+	}
+
+	entry->d_op = &fuse_dentry_operations;
+	*inodep = inode;
+	return 0;
+}
+
+int fuse_do_getattr(struct inode *inode)
+{
+	int err;
+	struct fuse_attr_out arg;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	req->in.h.opcode = FUSE_GETATTR;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(arg);
+	req->out.args[0].value = &arg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (!err) {
+		if ((inode->i_mode ^ arg.attr.mode) & S_IFMT) {
+			make_bad_inode(inode);
+			err = -EIO;
+		} else {
+			struct fuse_inode *fi = get_fuse_inode(inode);
+			fuse_change_attributes(inode, &arg.attr);
+			fi->i_time = time_to_jiffies(arg.attr_valid,
+						     arg.attr_valid_nsec);
+		}
+	}
+	return err;
+}
+
+static int fuse_revalidate(struct dentry *entry)
+{
+	struct inode *inode = entry->d_inode;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (get_node_id(inode) == FUSE_ROOT_ID) {
+		if (current->fsuid != fc->user_id)
+			return -EACCES;
+	} else if (!fi->i_time || time_before_eq(jiffies, fi->i_time))
+		return 0;
+
+	return fuse_do_getattr(inode);
+}
+
+static int fuse_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (current->fsuid != fc->user_id)
+		return -EACCES;
+	else {
+		int mode = inode->i_mode;
+		if ((mask & MAY_WRITE) && IS_RDONLY(inode) &&
+                    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
+                        return -EROFS;
+		if ((mask & MAY_EXEC) && !S_ISDIR(mode) && !(mode & S_IXUGO))
+			return -EACCES;
+		return 0;
+	}
+}
+
+static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
+			 void *dstbuf, filldir_t filldir)
+{
+	while (nbytes >= FUSE_NAME_OFFSET) {
+		struct fuse_dirent *dirent = (struct fuse_dirent *) buf;
+		size_t reclen = FUSE_DIRENT_SIZE(dirent);
+		int over;
+		if (dirent->namelen > FUSE_NAME_MAX)
+			return -EIO;
+		if (reclen > nbytes)
+			break;
+
+		over = filldir(dstbuf, dirent->name, dirent->namelen,
+			       file->f_pos, dirent->ino, dirent->type);
+		if (over)
+			break;
+
+		buf += reclen;
+		file->f_pos += reclen;
+		nbytes -= reclen;
+	}
+
+	return 0;
+}
+
+static int fuse_checkdir(struct file *cfile, struct file *file)
+{
+	struct inode *inode;
+	if (!cfile)
+		return -EIO;
+	inode = cfile->f_dentry->d_inode;
+	if (!S_ISREG(inode->i_mode)) {
+		fput(cfile);
+		return -EIO;
+	}
+
+	file->private_data = cfile;
+	return 0;
+}
+
+static int fuse_getdir(struct file *file)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req = fuse_get_request(fc);
+	struct fuse_getdir_out_i outarg;
+	int err;
+
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	req->in.h.opcode = FUSE_GETDIR;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(struct fuse_getdir_out);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (!err)
+		err = fuse_checkdir(outarg.file, file);
+	return err;
+}
+
+static int fuse_readdir(struct file *file, void *dstbuf, filldir_t filldir)
+{
+	struct file *cfile = file->private_data;
+	char *buf;
+	int ret;
+
+	if (!cfile) {
+		ret = fuse_getdir(file);
+		if (ret)
+			return ret;
+
+		cfile = file->private_data;
+	}
+
+	buf = (char *) __get_free_page(GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = kernel_read(cfile, file->f_pos, buf, PAGE_SIZE);
+	if (ret > 0)
+		ret = parse_dirfile(buf, ret, file, dstbuf, filldir);
+
+	free_page((unsigned long) buf);
+	return ret;
+}
+
+static char *read_link(struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req = fuse_get_request(fc);
+	char *link;
+
+	if (!req)
+		return ERR_PTR(-ERESTARTNOINTR);
+
+	link = (char *) __get_free_page(GFP_KERNEL);
+	if (!link) {
+		link = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+	req->in.h.opcode = FUSE_READLINK;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->out.argvar = 1;
+	req->out.numargs = 1;
+	req->out.args[0].size = PAGE_SIZE - 1;
+	req->out.args[0].value = link;
+	request_send(fc, req);
+	if (req->out.h.error) {
+		free_page((unsigned long) link);
+		link = ERR_PTR(req->out.h.error);
+	} else
+		link[req->out.args[0].size] = '\0';
+ out:
+	fuse_put_request(fc, req);
+	return link;
+}
+
+static void free_link(char *link)
+{
+	if (!IS_ERR(link))
+		free_page((unsigned long) link);
+}
+
+static int fuse_readlink(struct dentry *dentry, char __user *buffer,
+			 int buflen)
+{
+	int ret;
+	char *link;
+
+	link = read_link(dentry);
+	ret = vfs_readlink(dentry, buffer, buflen, link);
+	free_link(link);
+	return ret;
+}
+
+static int fuse_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	int ret;
+	char *link;
+
+	link = read_link(dentry);
+	ret = vfs_follow_link(nd, link);
+	free_link(link);
+	return ret;
+}
+
+static int fuse_dir_open(struct inode *inode, struct file *file)
+{
+	file->private_data = NULL;
+	return 0;
+}
+
+static int fuse_dir_release(struct inode *inode, struct file *file)
+{
+	struct file *cfile = file->private_data;
+
+	if (cfile)
+		fput(cfile);
+
+	return 0;
+}
+
+static int fuse_getattr(struct vfsmount *mnt, struct dentry *entry,
+			struct kstat *stat)
+{
+	struct inode *inode = entry->d_inode;
+	int err = fuse_revalidate(entry);
+	if (!err)
+		generic_fillattr(inode, stat);
+
+	return err;
+}
+
+static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
+				  struct nameidata *nd)
+{
+	struct inode *inode;
+	int err = fuse_lookup_iget(dir, entry, &inode);
+	if (err)
+		return ERR_PTR(err);
+	return d_splice_alias(inode, entry);
+}
+
+static struct inode_operations fuse_dir_inode_operations = {
+	.lookup		= fuse_lookup,
+	.permission	= fuse_permission,
+	.getattr	= fuse_getattr,
+};
+
+static struct file_operations fuse_dir_operations = {
+	.read		= generic_read_dir,
+	.readdir	= fuse_readdir,
+	.open		= fuse_dir_open,
+	.release	= fuse_dir_release,
+};
+
+static struct inode_operations fuse_common_inode_operations = {
+	.permission	= fuse_permission,
+	.getattr	= fuse_getattr,
+};
+
+static struct inode_operations fuse_symlink_inode_operations = {
+	.readlink	= fuse_readlink,
+	.follow_link	= fuse_follow_link,
+	.getattr	= fuse_getattr,
+};
+
+void fuse_init_common(struct inode *inode)
+{
+	inode->i_op = &fuse_common_inode_operations;
+}
+
+void fuse_init_dir(struct inode *inode)
+{
+	inode->i_op = &fuse_dir_inode_operations;
+	inode->i_fop = &fuse_dir_operations;
+}
+
+void fuse_init_symlink(struct inode *inode)
+{
+	inode->i_op = &fuse_symlink_inode_operations;
+}
diff -Nurp a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
--- a/fs/fuse/fuse_i.h	2005-01-10 19:28:38.000000000 +0100
+++ b/fs/fuse/fuse_i.h	2005-01-10 19:28:38.000000000 +0100
@@ -27,6 +27,9 @@ struct fuse_inode {
 	 * and kernel */
 	u64 nodeid;
 
+	/** The request used for sending the FORGET message */
+	struct fuse_req *forget_req;
+
 	/** Time in jiffies until the file attributes are valid */
 	unsigned long i_time;
 };
@@ -126,6 +129,7 @@ struct fuse_req {
 
 	/** Data for asynchronous requests */
 	union {
+		struct fuse_forget_in forget_in;
 		struct fuse_init_in_out init_in_out;
 	} misc;
 
@@ -191,6 +195,11 @@ struct fuse_conn {
 	struct backing_dev_info bdi;
 };
 
+struct fuse_getdir_out_i {
+	int fd;
+	void *file; /* Used by kernel only */
+};
+
 static inline struct fuse_conn **get_fuse_conn_super_p(struct super_block *sb)
 {
 	return (struct fuse_conn **) &sb->s_fs_info;
@@ -234,6 +243,38 @@ extern struct file_operations fuse_dev_o
 extern spinlock_t fuse_lock;
 
 /**
+ * Get a filled in inode
+ */
+struct inode *fuse_iget(struct super_block *sb, unsigned long nodeid,
+			int generation, struct fuse_attr *attr, int version);
+
+/**
+ * Send FORGET command
+ */
+void fuse_send_forget(struct fuse_conn *fc, struct fuse_req *req,
+		      unsigned long nodeid, int version);
+
+/**
+ * Initialise inode operations on regular files and special files
+ */
+void fuse_init_common(struct inode *inode);
+
+/**
+ * Initialise inode and file operations on a directory
+ */
+void fuse_init_dir(struct inode *inode);
+
+/**
+ * Initialise inode operations on a symlink
+ */
+void fuse_init_symlink(struct inode *inode);
+
+/**
+ * Change attributes of an inode
+ */
+void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr);
+
+/**
  * Check if the connection can be released, and if yes, then free the
  * connection structure
  */
@@ -301,6 +342,16 @@ void request_send_noreply(struct fuse_co
 void request_send_background(struct fuse_conn *fc, struct fuse_req *req);
 
 /**
+ * Get the attributes of a file
+ */
+int fuse_do_getattr(struct inode *inode);
+
+/**
+ * Invalidate inode attributes
+ */
+void fuse_invalidate_attr(struct inode *inode);
+
+/**
  * Send the INIT message
  */
 void fuse_send_init(struct fuse_conn *fc);
diff -Nurp a/fs/fuse/inode.c b/fs/fuse/inode.c
--- a/fs/fuse/inode.c	2005-01-10 19:28:38.000000000 +0100
+++ b/fs/fuse/inode.c	2005-01-10 19:28:38.000000000 +0100
@@ -50,12 +50,20 @@ static struct inode *fuse_alloc_inode(st
 
 	fi = get_fuse_inode(inode);
 	memset(fi, 0, sizeof(*fi));
+	fi->forget_req = fuse_request_alloc();
+	if (!fi->forget_req) {
+		kmem_cache_free(fuse_inode_cachep, inode);
+		return NULL;
+	}
 
 	return inode;
 }
 
 static void fuse_destroy_inode(struct inode *inode)
 {
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	if (fi->forget_req)
+		fuse_request_free(fi->forget_req);
 	kmem_cache_free(fuse_inode_cachep, inode);
 }
 
@@ -64,8 +72,27 @@ static void fuse_read_inode(struct inode
 	/* No op */
 }
 
+void fuse_send_forget(struct fuse_conn *fc, struct fuse_req *req,
+		      unsigned long nodeid, int version)
+{
+	struct fuse_forget_in *inarg = &req->misc.forget_in;
+	inarg->version = version;
+	req->in.h.opcode = FUSE_FORGET;
+	req->in.h.nodeid = nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(struct fuse_forget_in);
+	req->in.args[0].value = inarg;
+	request_send_noreply(fc, req);
+}
+
 static void fuse_clear_inode(struct inode *inode)
 {
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	if (fc) {
+		struct fuse_inode *fi = get_fuse_inode(inode);
+		fuse_send_forget(fc, fi->forget_req, fi->nodeid, inode->i_version);
+		fi->forget_req = NULL;
+	}
 }
 
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr)
@@ -93,6 +120,22 @@ static void fuse_init_inode(struct inode
 {
 	inode->i_mode = attr->mode & S_IFMT;
 	i_size_write(inode, attr->size);
+	if (S_ISREG(inode->i_mode)) {
+		fuse_init_common(inode);
+	} else if (S_ISDIR(inode->i_mode))
+		fuse_init_dir(inode);
+	else if (S_ISLNK(inode->i_mode))
+		fuse_init_symlink(inode);
+	else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+		 S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+		fuse_init_common(inode);
+		init_special_inode(inode, inode->i_mode,
+				   new_decode_dev(attr->rdev));
+	} else {
+		/* Don't let user create weird files */
+		inode->i_mode = S_IFREG;
+		fuse_init_common(inode);
+	}
 }
 
 static int fuse_inode_eq(struct inode *inode, void *_nodeidp)
@@ -157,6 +200,43 @@ static void fuse_put_super(struct super_
 	spin_unlock(&fuse_lock);
 }
 
+static void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr)
+{
+	stbuf->f_type    = FUSE_SUPER_MAGIC;
+	stbuf->f_bsize   = attr->bsize;
+	stbuf->f_blocks  = attr->blocks;
+	stbuf->f_bfree   = attr->bfree;
+	stbuf->f_bavail  = attr->bavail;
+	stbuf->f_files   = attr->files;
+	stbuf->f_ffree   = attr->ffree;
+	stbuf->f_namelen = attr->namelen;
+	/* fsid is left zero */
+}
+
+static int fuse_statfs(struct super_block *sb, struct kstatfs *buf)
+{
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct fuse_req *req;
+	struct fuse_statfs_out outarg;
+	int err;
+
+        req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
+
+	req->in.numargs = 0;
+	req->in.h.opcode = FUSE_STATFS;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (!err)
+		convert_fuse_statfs(buf, &outarg.st);
+	fuse_put_request(fc, req);
+	return err;
+}
+
 enum {
 	OPT_FD,
 	OPT_ROOTMODE,
@@ -317,6 +397,7 @@ static struct super_operations fuse_supe
 	.read_inode	= fuse_read_inode,
 	.clear_inode	= fuse_clear_inode,
 	.put_super	= fuse_put_super,
+	.statfs		= fuse_statfs,
 	.show_options	= fuse_show_options,
 };
 
diff -Nurp a/include/linux/fuse.h b/include/linux/fuse.h
--- a/include/linux/fuse.h	2005-01-10 19:28:38.000000000 +0100
+++ b/include/linux/fuse.h	2005-01-10 19:28:38.000000000 +0100
@@ -42,13 +42,61 @@ struct fuse_attr {
 	__u32	rdev;
 };
 
+struct fuse_kstatfs {
+	__u64	blocks;
+	__u64	bfree;
+	__u64	bavail;
+	__u64	files;
+	__u64	ffree;
+	__u32	bsize;
+	__u32	namelen;
+};
+
 enum fuse_opcode {
+	FUSE_LOOKUP	   = 1,
+	FUSE_FORGET	   = 2,  /* no reply */
+	FUSE_GETATTR	   = 3,
+	FUSE_READLINK	   = 5,
+	FUSE_GETDIR	   = 7,
+	FUSE_STATFS	   = 17,
 	FUSE_INIT          = 26
 };
 
 /* Conservative buffer size for the client */
 #define FUSE_MAX_IN 8192
 
+#define FUSE_NAME_MAX 1024
+
+struct fuse_entry_out {
+	__u64	nodeid;		/* Inode ID */
+	__u64	generation;	/* Inode generation: nodeid:gen must
+				   be unique for the fs's lifetime */
+	__u64	entry_valid;	/* Cache timeout for the name */
+	__u64	attr_valid;	/* Cache timeout for the attributes */
+	__u32	entry_valid_nsec;
+	__u32	attr_valid_nsec;
+	struct fuse_attr attr;
+};
+
+struct fuse_forget_in {
+	__u64	version;
+};
+
+struct fuse_attr_out {
+	__u64	attr_valid;	/* Cache timeout for the attributes */
+	__u32	attr_valid_nsec;
+	__u32	dummy;
+	struct fuse_attr attr;
+};
+
+struct fuse_getdir_out {
+	__u32	fd;
+};
+
+struct fuse_statfs_out {
+	struct fuse_kstatfs st;
+};
+
 struct fuse_init_in_out {
 	__u32	major;
 	__u32	minor;
@@ -70,3 +118,14 @@ struct fuse_out_header {
 	__u64	unique;
 };
 
+struct fuse_dirent {
+	__u64	ino;
+	__u32	namelen;
+	__u32	type;
+	char name[0];
+};
+
+#define FUSE_NAME_OFFSET ((unsigned) ((struct fuse_dirent *) 0)->name)
+#define FUSE_DIRENT_ALIGN(x) (((x) + sizeof(__u64) - 1) & ~(sizeof(__u64) - 1))
+#define FUSE_DIRENT_SIZE(d) \
+	FUSE_DIRENT_ALIGN(FUSE_NAME_OFFSET + (d)->namelen)
