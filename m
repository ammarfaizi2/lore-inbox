Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVAJTPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVAJTPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVAJTPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:15:31 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:63154 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262486AbVAJTK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:10:58 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/11] FUSE - extended attribute operations
Message-Id: <E1Co4w4-00049P-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Jan 2005 20:10:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the extended attribute operations to FUSE.

The following operations are added:

 o getxattr
 o setxattr
 o listxattr
 o removexattr

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
diff -Nurp a/fs/fuse/dir.c b/fs/fuse/dir.c
--- a/fs/fuse/dir.c	2005-01-10 19:28:36.000000000 +0100
+++ b/fs/fuse/dir.c	2005-01-10 19:28:35.000000000 +0100
@@ -753,6 +753,177 @@ static struct dentry *fuse_lookup(struct
 	return d_splice_alias(inode, entry);
 }
 
+static int fuse_setxattr(struct dentry *entry, const char *name,
+			 const void *value, size_t size, int flags)
+{
+	struct inode *inode = entry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req;
+	struct fuse_setxattr_in inarg;
+	int err;
+
+	if (size > FUSE_XATTR_SIZE_MAX)
+		return -E2BIG;
+
+	if (fc->no_setxattr)
+		return -EOPNOTSUPP;
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.size = size;
+	inarg.flags = flags;
+	req->in.h.opcode = FUSE_SETXATTR;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->in.numargs = 3;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->in.args[1].size = strlen(name) + 1;
+	req->in.args[1].value = name;
+	req->in.args[2].size = size;
+	req->in.args[2].value = value;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (err == -ENOSYS) {
+		fc->no_setxattr = 1;
+		err = -EOPNOTSUPP;
+	}
+	return err;
+}
+
+static ssize_t fuse_getxattr(struct dentry *entry, const char *name,
+			     void *value, size_t size)
+{
+	struct inode *inode = entry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req;
+	struct fuse_getxattr_in inarg;
+	struct fuse_getxattr_out outarg;
+	ssize_t ret;
+
+	if (fc->no_getxattr)
+		return -EOPNOTSUPP;
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.size = size;
+	req->in.h.opcode = FUSE_GETXATTR;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->in.numargs = 2;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->in.args[1].size = strlen(name) + 1;
+	req->in.args[1].value = name;
+	/* This is really two different operations rolled into one */
+	req->out.numargs = 1;
+	if (size) {
+		req->out.argvar = 1;
+		req->out.args[0].size = size;
+		req->out.args[0].value = value;
+	} else {
+		req->out.args[0].size = sizeof(outarg);
+		req->out.args[0].value = &outarg;
+	}
+	request_send(fc, req);
+	ret = req->out.h.error;
+	if (!ret)
+		ret = size ? req->out.args[0].size : outarg.size;
+	else {
+		if (ret == -ENOSYS) {
+			fc->no_getxattr = 1;
+			ret = -EOPNOTSUPP;
+		}
+	}
+	fuse_put_request(fc, req);
+	return ret;
+}
+
+static ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
+{
+	struct inode *inode = entry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req;
+	struct fuse_getxattr_in inarg;
+	struct fuse_getxattr_out outarg;
+	ssize_t ret;
+
+	if (fc->no_listxattr)
+		return -EOPNOTSUPP;
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.size = size;
+	req->in.h.opcode = FUSE_LISTXATTR;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	/* This is really two different operations rolled into one */
+	req->out.numargs = 1;
+	if (size) {
+		req->out.argvar = 1;
+		req->out.args[0].size = size;
+		req->out.args[0].value = list;
+	} else {
+		req->out.args[0].size = sizeof(outarg);
+		req->out.args[0].value = &outarg;
+	}
+	request_send(fc, req);
+	ret = req->out.h.error;
+	if (!ret)
+		ret = size ? req->out.args[0].size : outarg.size;
+	else {
+		if (ret == -ENOSYS) {
+			fc->no_listxattr = 1;
+			ret = -EOPNOTSUPP;
+		}
+	}
+	fuse_put_request(fc, req);
+	return ret;
+}
+
+static int fuse_removexattr(struct dentry *entry, const char *name)
+{
+	struct inode *inode = entry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req;
+	int err;
+
+	if (fc->no_removexattr)
+		return -EOPNOTSUPP;
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	req->in.h.opcode = FUSE_REMOVEXATTR;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->in.numargs = 1;
+	req->in.args[0].size = strlen(name) + 1;
+	req->in.args[0].value = name;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (err == -ENOSYS) {
+		fc->no_removexattr = 1;
+		err = -EOPNOTSUPP;
+	}
+	return err;
+}
+
 static struct inode_operations fuse_dir_inode_operations = {
 	.lookup		= fuse_lookup,
 	.mkdir		= fuse_mkdir,
@@ -766,6 +937,10 @@ static struct inode_operations fuse_dir_
 	.mknod		= fuse_mknod,
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
+	.setxattr	= fuse_setxattr,
+	.getxattr	= fuse_getxattr,
+	.listxattr	= fuse_listxattr,
+	.removexattr	= fuse_removexattr,
 };
 
 static struct file_operations fuse_dir_operations = {
@@ -779,6 +954,10 @@ static struct inode_operations fuse_comm
 	.setattr	= fuse_setattr,
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
+	.setxattr	= fuse_setxattr,
+	.getxattr	= fuse_getxattr,
+	.listxattr	= fuse_listxattr,
+	.removexattr	= fuse_removexattr,
 };
 
 static struct inode_operations fuse_symlink_inode_operations = {
@@ -786,6 +965,10 @@ static struct inode_operations fuse_syml
 	.readlink	= fuse_readlink,
 	.follow_link	= fuse_follow_link,
 	.getattr	= fuse_getattr,
+	.setxattr	= fuse_setxattr,
+	.getxattr	= fuse_getxattr,
+	.listxattr	= fuse_listxattr,
+	.removexattr	= fuse_removexattr,
 };
 
 void fuse_init_common(struct inode *inode)
diff -Nurp a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
--- a/fs/fuse/fuse_i.h	2005-01-10 19:28:36.000000000 +0100
+++ b/fs/fuse/fuse_i.h	2005-01-10 19:28:35.000000000 +0100
@@ -227,6 +227,18 @@ struct fuse_conn {
 	/** Is flush not implemented by fs? */
 	unsigned no_flush : 1;
 
+	/** Is setxattr not implemented by fs? */
+	unsigned no_setxattr : 1;
+
+	/** Is getxattr not implemented by fs? */
+	unsigned no_getxattr : 1;
+
+	/** Is listxattr not implemented by fs? */
+	unsigned no_listxattr : 1;
+
+	/** Is removexattr not implemented by fs? */
+	unsigned no_removexattr : 1;
+
 	/** Backing dev info */
 	struct backing_dev_info bdi;
 };
diff -Nurp a/include/linux/fuse.h b/include/linux/fuse.h
--- a/include/linux/fuse.h	2005-01-10 19:28:36.000000000 +0100
+++ b/include/linux/fuse.h	2005-01-10 19:28:36.000000000 +0100
@@ -80,6 +80,10 @@ enum fuse_opcode {
 	FUSE_STATFS	   = 17,
 	FUSE_RELEASE       = 18,
 	FUSE_FSYNC         = 20,
+	FUSE_SETXATTR      = 21,
+	FUSE_GETXATTR      = 22,
+	FUSE_LISTXATTR     = 23,
+	FUSE_REMOVEXATTR   = 24,
 	FUSE_FLUSH         = 25,
 	FUSE_INIT          = 26
 };
@@ -89,6 +93,7 @@ enum fuse_opcode {
 
 #define FUSE_NAME_MAX 1024
 #define FUSE_SYMLINK_MAX 4096
+#define FUSE_XATTR_SIZE_MAX 4096
 
 struct fuse_entry_out {
 	__u64	nodeid;		/* Inode ID */
@@ -183,6 +188,19 @@ struct fuse_fsync_in {
 	__u32	fsync_flags;
 };
 
+struct fuse_setxattr_in {
+	__u32	size;
+	__u32	flags;
+};
+
+struct fuse_getxattr_in {
+	__u32	size;
+};
+
+struct fuse_getxattr_out {
+	__u32	size;
+};
+
 struct fuse_init_in_out {
 	__u32	major;
 	__u32	minor;
