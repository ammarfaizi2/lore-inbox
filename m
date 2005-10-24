Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVJXRQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVJXRQy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVJXRQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:16:54 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:50692 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751179AbVJXRQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:16:53 -0400
To: akpm@osdl.org
CC: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/8] FUSE: per inode statfs
Message-Id: <E1EU5vx-0005yb-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Oct 2005 19:16:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes FUSE based filesystems able to return filesystem
statistics based on path.  While breaks with the tradition of
homogeneous statistics per _local_ filesystem, however adds useful
ability to user to differentiate statistics from different _remote_
filesystem served by the same userspace server.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2005-10-24 15:43:02.000000000 +0200
+++ linux/fs/fuse/inode.c	2005-10-24 15:43:16.000000000 +0200
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/parser.h>
-#include <linux/statfs.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Filesystem in Userspace");
@@ -25,8 +24,6 @@ MODULE_LICENSE("GPL");
 spinlock_t fuse_lock;
 static kmem_cache_t *fuse_inode_cachep;
 
-#define FUSE_SUPER_MAGIC 0x65735546
-
 struct fuse_mount_data {
 	int fd;
 	unsigned rootmode;
@@ -214,43 +211,6 @@ static void fuse_put_super(struct super_
 	spin_unlock(&fuse_lock);
 }
 
-static void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr)
-{
-	stbuf->f_type    = FUSE_SUPER_MAGIC;
-	stbuf->f_bsize   = attr->bsize;
-	stbuf->f_blocks  = attr->blocks;
-	stbuf->f_bfree   = attr->bfree;
-	stbuf->f_bavail  = attr->bavail;
-	stbuf->f_files   = attr->files;
-	stbuf->f_ffree   = attr->ffree;
-	stbuf->f_namelen = attr->namelen;
-	/* fsid is left zero */
-}
-
-static int fuse_statfs(struct super_block *sb, struct kstatfs *buf)
-{
-	struct fuse_conn *fc = get_fuse_conn_super(sb);
-	struct fuse_req *req;
-	struct fuse_statfs_out outarg;
-	int err;
-
-        req = fuse_get_request(fc);
-	if (!req)
-		return -EINTR;
-
-	req->in.numargs = 0;
-	req->in.h.opcode = FUSE_STATFS;
-	req->out.numargs = 1;
-	req->out.args[0].size = sizeof(outarg);
-	req->out.args[0].value = &outarg;
-	request_send(fc, req);
-	err = req->out.h.error;
-	if (!err)
-		convert_fuse_statfs(buf, &outarg.st);
-	fuse_put_request(fc, req);
-	return err;
-}
-
 enum {
 	OPT_FD,
 	OPT_ROOTMODE,
@@ -446,7 +406,6 @@ static struct super_operations fuse_supe
 	.read_inode	= fuse_read_inode,
 	.clear_inode	= fuse_clear_inode,
 	.put_super	= fuse_put_super,
-	.statfs		= fuse_statfs,
 	.show_options	= fuse_show_options,
 };
 
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2005-10-24 15:43:14.000000000 +0200
+++ linux/fs/fuse/dir.c	2005-10-24 15:43:16.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
+#include <linux/statfs.h>
 
 static inline unsigned long time_to_jiffies(unsigned long sec,
 					    unsigned long nsec)
@@ -1061,6 +1062,46 @@ static int fuse_removexattr(struct dentr
 	return err;
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
+static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	struct inode *inode = dentry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req;
+	struct fuse_statfs_out outarg;
+	int err;
+
+        req = fuse_get_request(fc);
+	if (!req)
+		return -EINTR;
+
+	req->in.h.opcode = FUSE_STATFS;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->in.numargs = 0;
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
 static struct inode_operations fuse_dir_inode_operations = {
 	.lookup		= fuse_lookup,
 	.mkdir		= fuse_mkdir,
@@ -1078,6 +1119,7 @@ static struct inode_operations fuse_dir_
 	.getxattr	= fuse_getxattr,
 	.listxattr	= fuse_listxattr,
 	.removexattr	= fuse_removexattr,
+	.statfs		= fuse_statfs,
 };
 
 static struct file_operations fuse_dir_operations = {
@@ -1097,6 +1139,7 @@ static struct inode_operations fuse_comm
 	.getxattr	= fuse_getxattr,
 	.listxattr	= fuse_listxattr,
 	.removexattr	= fuse_removexattr,
+	.statfs		= fuse_statfs,
 };
 
 static struct inode_operations fuse_symlink_inode_operations = {
@@ -1109,6 +1152,7 @@ static struct inode_operations fuse_syml
 	.getxattr	= fuse_getxattr,
 	.listxattr	= fuse_listxattr,
 	.removexattr	= fuse_removexattr,
+	.statfs		= fuse_statfs,
 };
 
 void fuse_init_common(struct inode *inode)
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2005-10-24 15:43:09.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2005-10-24 15:43:16.000000000 +0200
@@ -15,6 +15,8 @@
 #include <linux/backing-dev.h>
 #include <asm/semaphore.h>
 
+#define FUSE_SUPER_MAGIC 0x65735546
+
 /** Max number of pages that can be used in a single read request */
 #define FUSE_MAX_PAGES_PER_REQ 32
 

