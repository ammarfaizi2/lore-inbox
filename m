Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVCaVMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVCaVMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 16:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVCaVMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 16:12:13 -0500
Received: from rev.193.226.232.24.euroweb.hu ([193.226.232.24]:8115 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261760AbVCaVJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 16:09:17 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: add fsync operation for directories
Message-Id: <E1DH6uR-00019O-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 31 Mar 2005 23:08:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new FSYNCDIR request, which is sent when fsync is
called on directories.  This operation is available in libfuse
2.3-pre1 or greater.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc1-mm4/fs/fuse/dir.c linux-fuse/fs/fuse/dir.c
--- linux-2.6.12-rc1-mm4/fs/fuse/dir.c	2005-03-31 21:50:44.000000000 +0200
+++ linux-fuse/fs/fuse/dir.c	2005-03-31 21:51:20.000000000 +0200
@@ -591,6 +591,11 @@ static int fuse_dir_release(struct inode
 	return fuse_release_common(inode, file, 1);
 }
 
+static int fuse_dir_fsync(struct file *file, struct dentry *de, int datasync)
+{
+	return fuse_fsync_common(file, de, datasync, 1);
+}
+
 static unsigned iattr_to_fattr(struct iattr *iattr, struct fuse_attr *fattr)
 {
 	unsigned ivalid = iattr->ia_valid;
@@ -899,6 +904,7 @@ static struct file_operations fuse_dir_o
 	.readdir	= fuse_readdir,
 	.open		= fuse_dir_open,
 	.release	= fuse_dir_release,
+	.fsync		= fuse_dir_fsync,
 };
 
 static struct inode_operations fuse_common_inode_operations = {
diff -rup linux-2.6.12-rc1-mm4/fs/fuse/file.c linux-fuse/fs/fuse/file.c
--- linux-2.6.12-rc1-mm4/fs/fuse/file.c	2005-03-31 21:43:42.000000000 +0200
+++ linux-fuse/fs/fuse/file.c	2005-03-31 21:51:20.000000000 +0200
@@ -143,7 +143,8 @@ static int fuse_flush(struct file *file)
 	return err;
 }
 
-static int fuse_fsync(struct file *file, struct dentry *de, int datasync)
+int fuse_fsync_common(struct file *file, struct dentry *de, int datasync,
+		      int isdir)
 {
 	struct inode *inode = de->d_inode;
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -152,7 +153,7 @@ static int fuse_fsync(struct file *file,
 	struct fuse_fsync_in inarg;
 	int err;
 
-	if (fc->no_fsync)
+	if ((!isdir && fc->no_fsync) || (isdir && fc->no_fsyncdir))
 		return 0;
 
 	req = fuse_get_request(fc);
@@ -162,7 +163,7 @@ static int fuse_fsync(struct file *file,
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.fh = ff->fh;
 	inarg.fsync_flags = datasync ? 1 : 0;
-	req->in.h.opcode = FUSE_FSYNC;
+	req->in.h.opcode = isdir ? FUSE_FSYNCDIR : FUSE_FSYNC;
 	req->in.h.nodeid = get_node_id(inode);
 	req->inode = inode;
 	req->file = file;
@@ -173,12 +174,20 @@ static int fuse_fsync(struct file *file,
 	err = req->out.h.error;
 	fuse_put_request(fc, req);
 	if (err == -ENOSYS) {
-		fc->no_fsync = 1;
+		if (isdir)
+			fc->no_fsyncdir = 1;
+		else
+			fc->no_fsync = 1;
 		err = 0;
 	}
 	return err;
 }
 
+static int fuse_fsync(struct file *file, struct dentry *de, int datasync)
+{
+	return fuse_fsync_common(file, de, datasync, 0);
+}
+
 size_t fuse_send_read_common(struct fuse_req *req, struct file *file,
 			     struct inode *inode, loff_t pos, size_t count,
 			     int isdir)
diff -rup linux-2.6.12-rc1-mm4/fs/fuse/fuse_i.h linux-fuse/fs/fuse/fuse_i.h
--- linux-2.6.12-rc1-mm4/fs/fuse/fuse_i.h	2005-03-31 21:51:29.000000000 +0200
+++ linux-fuse/fs/fuse/fuse_i.h	2005-03-31 21:51:20.000000000 +0200
@@ -246,6 +246,9 @@ struct fuse_conn {
 	/** Is fsync not implemented by fs? */
 	unsigned no_fsync : 1;
 
+	/** Is fsyncdir not implemented by fs? */
+	unsigned no_fsyncdir : 1;
+
 	/** Is flush not implemented by fs? */
 	unsigned no_flush : 1;
 
@@ -341,6 +344,12 @@ int fuse_open_common(struct inode *inode
 int fuse_release_common(struct inode *inode, struct file *file, int isdir);
 
 /**
+ * Send FSYNC or FSYNCDIR request
+ */
+int fuse_fsync_common(struct file *file, struct dentry *de, int datasync,
+		      int isdir);
+
+/**
  * Initialise file operations on a regular file
  */
 void fuse_init_file_inode(struct inode *inode);
diff -rup linux-2.6.12-rc1-mm4/include/linux/fuse.h linux-fuse/include/linux/fuse.h
--- linux-2.6.12-rc1-mm4/include/linux/fuse.h	2005-03-31 21:51:29.000000000 +0200
+++ linux-fuse/include/linux/fuse.h	2005-03-31 21:51:20.000000000 +0200
@@ -90,7 +90,8 @@ enum fuse_opcode {
 	FUSE_INIT          = 26,
 	FUSE_OPENDIR       = 27,
 	FUSE_READDIR       = 28,
-	FUSE_RELEASEDIR    = 29
+	FUSE_RELEASEDIR    = 29,
+	FUSE_FSYNCDIR      = 30
 };
 
 /* Conservative buffer size for the client */

