Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVJXRE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVJXRE2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVJXRE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:04:28 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:51720 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751172AbVJXRE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:04:27 -0400
To: akpm@osdl.org
CC: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/8] FUSE: add access call
Message-Id: <E1EU5k4-0005vo-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Oct 2005 19:04:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new access call, which will only be called if ->permission is
invoked from sys_access().  In all other cases permission checking is
delayed until the actual filesystem operation.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2005-10-24 15:46:28.000000000 +0200
+++ linux/include/linux/fuse.h	2005-10-24 17:26:36.000000000 +0200
@@ -99,7 +99,8 @@ enum fuse_opcode {
 	FUSE_OPENDIR       = 27,
 	FUSE_READDIR       = 28,
 	FUSE_RELEASEDIR    = 29,
-	FUSE_FSYNCDIR      = 30
+	FUSE_FSYNCDIR      = 30,
+	FUSE_ACCESS        = 34
 };
 
 /* Conservative buffer size for the client */
@@ -222,6 +223,11 @@ struct fuse_getxattr_out {
 	__u32	padding;
 };
 
+struct fuse_access_in {
+	__u32	mask;
+	__u32	padding;
+};
+
 struct fuse_init_in_out {
 	__u32	major;
 	__u32	minor;
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2005-10-24 15:46:23.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2005-10-24 17:26:36.000000000 +0200
@@ -266,6 +266,9 @@ struct fuse_conn {
 	/** Is removexattr not implemented by fs? */
 	unsigned no_removexattr : 1;
 
+	/** Is access not implemented by fs? */
+	unsigned no_access : 1;
+
 	/** Backing dev info */
 	struct backing_dev_info bdi;
 };
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2005-10-24 15:46:23.000000000 +0200
+++ linux/fs/fuse/dir.c	2005-10-24 17:26:53.000000000 +0200
@@ -461,6 +461,38 @@ static int fuse_revalidate(struct dentry
 	return fuse_do_getattr(inode);
 }
 
+static int fuse_access(struct inode *inode, int mask)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req;
+	struct fuse_access_in inarg;
+	int err;
+
+	if (fc->no_access)
+		return 0;
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -EINTR;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.mask = mask;
+	req->in.h.opcode = FUSE_ACCESS;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (err == -ENOSYS) {
+		fc->no_access = 1;
+		err = 0;
+	}
+	return err;
+}
+
 static int fuse_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -496,6 +528,9 @@ static int fuse_permission(struct inode 
                         return -EROFS;
 		if ((mask & MAY_EXEC) && !S_ISDIR(mode) && !(mode & S_IXUGO))
 			return -EACCES;
+
+		if (nd && (nd->flags & LOOKUP_ACCESS))
+			return fuse_access(inode, mask);
 		return 0;
 	}
 }
