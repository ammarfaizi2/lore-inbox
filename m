Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbWADNTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWADNTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 08:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWADNTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 08:19:18 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:15242 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751776AbWADNTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 08:19:15 -0500
Message-Id: <20060104131839.391846000@dorka.pomaz.szeredi.hu>
References: <20060104131530.511388000@dorka.pomaz.szeredi.hu>
Date: Wed, 04 Jan 2006 14:15:33 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] fuse: clean up request size limit checking
Content-Disposition: inline; filename=fuse_clean_up_limits.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the way a too large request is handled.  Until now in this case
the device read returned -EINVAL and the operation returned -EIO.

Make it more flexibible by not returning -EINVAL from the read, but
restarting it instead.

Also remove the fix limit on setxattr data and let the filesystem
provide as large a read buffer as it needs to handle the extended
attribute data.

The symbolic link length is already checked by VFS to be less than
PATH_MAX, so the extra check against FUSE_SYMLINK_MAX is not needed.

The check in fuse_create_open() against FUSE_NAME_MAX is not needed,
since the dentry has already been looked up, and hence the name
already checked.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-04 12:14:06.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-04 12:37:53.000000000 +0100
@@ -617,6 +617,7 @@ static ssize_t fuse_dev_readv(struct fil
 	struct fuse_copy_state cs;
 	unsigned reqsize;
 
+ restart:
 	spin_lock(&fuse_lock);
 	fc = file->private_data;
 	err = -EPERM;
@@ -632,20 +633,25 @@ static ssize_t fuse_dev_readv(struct fil
 
 	req = list_entry(fc->pending.next, struct fuse_req, list);
 	list_del_init(&req->list);
-	spin_unlock(&fuse_lock);
 
 	in = &req->in;
-	reqsize = req->in.h.len;
-	fuse_copy_init(&cs, 1, req, iov, nr_segs);
-	err = -EINVAL;
-	if (iov_length(iov, nr_segs) >= reqsize) {
-		err = fuse_copy_one(&cs, &in->h, sizeof(in->h));
-		if (!err)
-			err = fuse_copy_args(&cs, in->numargs, in->argpages,
-					     (struct fuse_arg *) in->args, 0);
+	reqsize = in->h.len;
+	/* If request is too large, reply with an error and restart the read */
+	if (iov_length(iov, nr_segs) < reqsize) {
+		req->out.h.error = -EIO;
+		/* SETXATTR is special, since it may contain too large data */
+		if (in->h.opcode == FUSE_SETXATTR)
+			req->out.h.error = -E2BIG;
+		request_end(fc, req);
+		goto restart;
 	}
+	spin_unlock(&fuse_lock);
+	fuse_copy_init(&cs, 1, req, iov, nr_segs);
+	err = fuse_copy_one(&cs, &in->h, sizeof(in->h));
+	if (!err)
+		err = fuse_copy_args(&cs, in->numargs, in->argpages,
+				     (struct fuse_arg *) in->args, 0);
 	fuse_copy_finish(&cs);
-
 	spin_lock(&fuse_lock);
 	req->locked = 0;
 	if (!err && req->interrupted)
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-01-04 12:37:52.000000000 +0100
+++ linux/fs/fuse/dir.c	2006-01-04 12:37:53.000000000 +0100
@@ -236,10 +236,6 @@ static int fuse_create_open(struct inode
 	if (fc->no_create)
 		goto out;
 
-	err = -ENAMETOOLONG;
-	if (entry->d_name.len > FUSE_NAME_MAX)
-		goto out;
-
 	err = -EINTR;
 	req = fuse_get_request(fc);
 	if (!req)
@@ -413,12 +409,7 @@ static int fuse_symlink(struct inode *di
 {
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	unsigned len = strlen(link) + 1;
-	struct fuse_req *req;
-
-	if (len > FUSE_SYMLINK_MAX)
-		return -ENAMETOOLONG;
-
-	req = fuse_get_request(fc);
+	struct fuse_req *req = fuse_get_request(fc);
 	if (!req)
 		return -EINTR;
 
@@ -988,9 +979,6 @@ static int fuse_setxattr(struct dentry *
 	struct fuse_setxattr_in inarg;
 	int err;
 
-	if (size > FUSE_XATTR_SIZE_MAX)
-		return -E2BIG;
-
 	if (fc->no_setxattr)
 		return -EOPNOTSUPP;
 
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-04 12:14:06.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-04 12:37:53.000000000 +0100
@@ -21,6 +21,12 @@
 /** If more requests are outstanding, then the operation will block */
 #define FUSE_MAX_OUTSTANDING 10
 
+/** Maximum size of data in a write request */
+#define FUSE_MAX_WRITE 4096
+
+/** It could be as large as PATH_MAX, but would that have any uses? */
+#define FUSE_NAME_MAX 1024
+
 /** If the FUSE_DEFAULT_PERMISSIONS flag is given, the filesystem
     module will check permissions based on the file mode.  Otherwise no
     permission checking is done in the kernel */
@@ -108,9 +114,6 @@ struct fuse_out {
 	struct fuse_arg args[3];
 };
 
-struct fuse_req;
-struct fuse_conn;
-
 /**
  * A request to the client
  */
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-01-04 12:14:06.000000000 +0100
+++ linux/fs/fuse/inode.c	2006-01-04 12:37:53.000000000 +0100
@@ -485,7 +485,7 @@ static int fuse_fill_super(struct super_
 	fc->max_read = d.max_read;
 	if (fc->max_read / PAGE_CACHE_SIZE < fc->bdi.ra_pages)
 		fc->bdi.ra_pages = fc->max_read / PAGE_CACHE_SIZE;
-	fc->max_write = FUSE_MAX_IN / 2;
+	fc->max_write = FUSE_MAX_WRITE;
 
 	err = -ENOMEM;
 	root = get_root_inode(sb, d.rootmode);
Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2006-01-04 12:14:06.000000000 +0100
+++ linux/include/linux/fuse.h	2006-01-04 12:37:53.000000000 +0100
@@ -108,12 +108,8 @@ enum fuse_opcode {
 	FUSE_CREATE        = 35
 };
 
-/* Conservative buffer size for the client */
-#define FUSE_MAX_IN 8192
-
-#define FUSE_NAME_MAX 1024
-#define FUSE_SYMLINK_MAX 4096
-#define FUSE_XATTR_SIZE_MAX 4096
+/* The read buffer is required to be at least 8k, but may be much larger */
+#define FUSE_MIN_READ_BUFFER 8192
 
 struct fuse_entry_out {
 	__u64	nodeid;		/* Inode ID */

--
