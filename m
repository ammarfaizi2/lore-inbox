Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263192AbUKTXoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbUKTXoz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUKTXoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:44:16 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:57483 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263192AbUKTXL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:11:59 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/13] Filesystem in Userspace
Message-Id: <E1CVeOT-0007Qz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:11:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the extended attribute operations to FUSE.

The following operations are added:

 o getxattr
 o setxattr
 o listxattr
 o removexattr

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
--- linux-2.6.10-rc2/fs/fuse/dir.c	2004-11-20 22:56:23.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/dir.c	2004-11-20 22:56:21.000000000 +0100
@@ -877,6 +877,177 @@ static struct dentry *fuse_lookup(struct
 	return d_splice_alias(inode, entry);
 }
 
+static int fuse_setxattr(struct dentry *entry, const char *name,
+			 const void *value, size_t size, int flags)
+{
+	struct inode *inode = entry->d_inode;
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
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
+		return -ERESTARTSYS;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.size = size;
+	inarg.flags = flags;
+	req->in.h.opcode = FUSE_SETXATTR;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 3;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->in.args[1].size = strlen(name) + 1;
+	req->in.args[1].value = name;
+	req->in.args[2].size = size;
+	req->in.args[2].value = value;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (err == -ENOSYS) {
+		fc->no_setxattr = 1;
+		err = -EOPNOTSUPP;
+	}
+	fuse_put_request(fc, req);
+	return err;
+}
+
+static ssize_t fuse_getxattr(struct dentry *entry, const char *name,
+			     void *value, size_t size)
+{
+	struct inode *inode = entry->d_inode;
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
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
+		return -ERESTARTSYS;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.size = size;
+	req->in.h.opcode = FUSE_GETXATTR;
+	req->in.h.nodeid = fi->nodeid;
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
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
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
+		return -ERESTARTSYS;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.size = size;
+	req->in.h.opcode = FUSE_LISTXATTR;
+	req->in.h.nodeid = fi->nodeid;
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
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_req *req;
+	int err;
+	
+	if (fc->no_removexattr)
+		return -EOPNOTSUPP;
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
+
+	req->in.h.opcode = FUSE_REMOVEXATTR;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = strlen(name) + 1;
+	req->in.args[0].value = name;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (err == -ENOSYS) {
+		fc->no_removexattr = 1;
+		err = -EOPNOTSUPP;
+	}
+	fuse_put_request(fc, req);
+	return err;
+}
+
 static struct inode_operations fuse_dir_inode_operations = {
 	.lookup		= fuse_lookup,
 	.mkdir		= fuse_mkdir,
@@ -890,6 +1061,10 @@ static struct inode_operations fuse_dir_
 	.mknod		= fuse_mknod,
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
+	.setxattr	= fuse_setxattr,
+	.getxattr	= fuse_getxattr,
+	.listxattr	= fuse_listxattr,
+	.removexattr	= fuse_removexattr,
 };
 
 static struct file_operations fuse_dir_operations = {
@@ -903,6 +1078,10 @@ static struct inode_operations fuse_file
 	.setattr	= fuse_setattr,
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
+	.setxattr	= fuse_setxattr,
+	.getxattr	= fuse_getxattr,
+	.listxattr	= fuse_listxattr,
+	.removexattr	= fuse_removexattr,
 };
 
 static struct inode_operations fuse_symlink_inode_operations = {
@@ -910,6 +1089,10 @@ static struct inode_operations fuse_syml
 	.readlink	= fuse_readlink,
 	.follow_link	= fuse_follow_link,
 	.getattr	= fuse_getattr,
+	.setxattr	= fuse_setxattr,
+	.getxattr	= fuse_getxattr,
+	.listxattr	= fuse_listxattr,
+	.removexattr	= fuse_removexattr,
 };
 
 static struct dentry_operations fuse_dentry_operations = {
--- linux-2.6.10-rc2/fs/fuse/fuse_i.h	2004-11-20 22:56:23.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/fuse_i.h	2004-11-20 22:56:23.000000000 +0100
@@ -152,6 +152,18 @@ struct fuse_conn {
 
 	/** Is flush not implemented by fs? */
 	unsigned int no_flush : 1;
+
+	/** Is setxattr not implemented by fs? */
+	unsigned int no_setxattr : 1;
+
+	/** Is getxattr not implemented by fs? */
+	unsigned int no_getxattr : 1;
+
+	/** Is listxattr not implemented by fs? */
+	unsigned int no_listxattr : 1;
+
+	/** Is removexattr not implemented by fs? */
+	unsigned int no_removexattr : 1;
 };
 
 struct fuse_getdir_out_i {
--- linux-2.6.10-rc2/include/linux/fuse.h	2004-11-20 22:56:23.000000000 +0100
+++ linux-2.6.10-rc2-fuse/include/linux/fuse.h	2004-11-20 22:56:22.000000000 +0100
@@ -79,10 +79,10 @@ enum fuse_opcode {
 	FUSE_RELEASE       = 18,
 	/* FUSE_INVALIDATE    = 19, */
 	FUSE_FSYNC         = 20,
-	/* FUSE_SETXATTR      = 21, */
-	/* FUSE_GETXATTR      = 22, */
-	/* FUSE_LISTXATTR     = 23, */
-	/* FUSE_REMOVEXATTR   = 24, */
+	FUSE_SETXATTR      = 21,
+	FUSE_GETXATTR      = 22,
+	FUSE_LISTXATTR     = 23,
+	FUSE_REMOVEXATTR   = 24,
 	FUSE_FLUSH         = 25,
 };
 
@@ -91,6 +91,7 @@ enum fuse_opcode {
 
 #define FUSE_NAME_MAX 1024
 #define FUSE_SYMLINK_MAX 4096
+#define FUSE_XATTR_SIZE_MAX 4096
 
 struct fuse_entry_out {
 	unsigned long nodeid;      /* Inode ID */
@@ -184,6 +185,19 @@ struct fuse_fsync_in {
 	int datasync;
 };
 
+struct fuse_setxattr_in {
+	unsigned int size;
+	unsigned int flags;
+};
+
+struct fuse_getxattr_in {
+	unsigned int size;
+};
+
+struct fuse_getxattr_out {
+	unsigned int size;
+};
+
 struct fuse_in_header {
 	int unique;
 	enum fuse_opcode opcode;
