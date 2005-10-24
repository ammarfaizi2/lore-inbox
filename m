Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVJXRNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVJXRNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVJXRNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:13:37 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:39687 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751158AbVJXRNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:13:37 -0400
To: akpm@osdl.org
CC: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/8] FUSE: pass file handle in setattr
Message-Id: <E1EU5st-0005xz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Oct 2005 19:13:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch passes the file handle supplied in iattr to userspace, in
case the ->setattr() was invoked from sys_ftruncate().  This solves
the permission checking (or lack thereof) in ftruncate() for the class
of filesystems served by an unprivileged userspace process.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2005-10-24 15:43:09.000000000 +0200
+++ linux/include/linux/fuse.h	2005-10-24 15:43:14.000000000 +0200
@@ -61,6 +61,7 @@ struct fuse_kstatfs {
 #define FATTR_SIZE	(1 << 3)
 #define FATTR_ATIME	(1 << 4)
 #define FATTR_MTIME	(1 << 5)
+#define FATTR_FH	(1 << 6)
 
 /**
  * Flags returned by the OPEN request
@@ -154,7 +155,20 @@ struct fuse_link_in {
 struct fuse_setattr_in {
 	__u32	valid;
 	__u32	padding;
-	struct fuse_attr attr;
+	__u64	fh;
+	__u64	size;
+	__u64	unused1;
+	__u64	atime;
+	__u64	mtime;
+	__u64	unused2;
+	__u32	atimensec;
+	__u32	mtimensec;
+	__u32	unused3;
+	__u32	mode;
+	__u32	unused4;
+	__u32	uid;
+	__u32	gid;
+	__u32	unused5;
 };
 
 struct fuse_open_in {
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2005-10-24 15:43:09.000000000 +0200
+++ linux/fs/fuse/dir.c	2005-10-24 15:43:14.000000000 +0200
@@ -766,29 +766,29 @@ static int fuse_dir_fsync(struct file *f
 	return file ? fuse_fsync_common(file, de, datasync, 1) : 0;
 }
 
-static unsigned iattr_to_fattr(struct iattr *iattr, struct fuse_attr *fattr)
+static void iattr_to_fattr(struct iattr *iattr, struct fuse_setattr_in *arg)
 {
 	unsigned ivalid = iattr->ia_valid;
-	unsigned fvalid = 0;
-
-	memset(fattr, 0, sizeof(*fattr));
 
 	if (ivalid & ATTR_MODE)
-		fvalid |= FATTR_MODE,   fattr->mode = iattr->ia_mode;
+		arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
 	if (ivalid & ATTR_UID)
-		fvalid |= FATTR_UID,    fattr->uid = iattr->ia_uid;
+		arg->valid |= FATTR_UID,    arg->uid = iattr->ia_uid;
 	if (ivalid & ATTR_GID)
-		fvalid |= FATTR_GID,    fattr->gid = iattr->ia_gid;
+		arg->valid |= FATTR_GID,    arg->gid = iattr->ia_gid;
 	if (ivalid & ATTR_SIZE)
-		fvalid |= FATTR_SIZE,   fattr->size = iattr->ia_size;
+		arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
 	/* You can only _set_ these together (they may change by themselves) */
 	if ((ivalid & (ATTR_ATIME | ATTR_MTIME)) == (ATTR_ATIME | ATTR_MTIME)) {
-		fvalid |= FATTR_ATIME | FATTR_MTIME;
-		fattr->atime = iattr->ia_atime.tv_sec;
-		fattr->mtime = iattr->ia_mtime.tv_sec;
+		arg->valid |= FATTR_ATIME | FATTR_MTIME;
+		arg->atime = iattr->ia_atime.tv_sec;
+		arg->mtime = iattr->ia_mtime.tv_sec;
+	}
+	if (ivalid & ATTR_FILE) {
+		struct fuse_file *ff = iattr->ia_file->private_data;
+		arg->valid |= FATTR_FH;
+		arg->fh = ff->fh;
 	}
-
-	return fvalid;
 }
 
 static int fuse_setattr(struct dentry *entry, struct iattr *attr)
@@ -823,7 +823,7 @@ static int fuse_setattr(struct dentry *e
 		return -EINTR;
 
 	memset(&inarg, 0, sizeof(inarg));
-	inarg.valid = iattr_to_fattr(attr, &inarg.attr);
+	iattr_to_fattr(attr, &inarg);
 	req->in.h.opcode = FUSE_SETATTR;
 	req->in.h.nodeid = get_node_id(inode);
 	req->inode = inode;
