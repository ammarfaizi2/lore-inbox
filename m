Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVASVtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVASVtO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVASVri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:47:38 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:31139 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261914AbVASVoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:44:05 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE - Transfer readdir data through device
Message-Id: <E1CrNc3-0001Lr-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 19 Jan 2005 22:43:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch removes a long lasting "hack" in FUSE, which used a
separate channel (a file descriptor refering to a disk-file) to
transfer directory contents from userspace to the kernel.

The patch adds three new operations (OPENDIR, READDIR, RELEASEDIR),
which have semantics and implementation exactly maching the respective
file operations (OPEN, READ, RELEASE).

This simplifies the directory reading code.  Also disk space is not
necessary, which can be important in embedded systems.

Please apply.

Thanks,
Miklos

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -ru linux-2.6.11-rc1-mm1/fs/fuse/dev.c linux-2.6.11-rc1-mm1-fuse/fs/fuse/dev.c
--- linux-2.6.11-rc1-mm1/fs/fuse/dev.c	2005-01-19 22:25:14.000000000 +0100
+++ linux-2.6.11-rc1-mm1-fuse/fs/fuse/dev.c	2005-01-19 22:28:04.000000000 +0100
@@ -642,13 +642,6 @@
 	return NULL;
 }
 
-/* fget() needs to be done in this context */
-static void process_getdir(struct fuse_req *req)
-{
-	struct fuse_getdir_out_i *arg = req->out.args[0].value;
-	arg->file = fget(arg->fd);
-}
-
 static int copy_out_args(struct fuse_copy_state *cs, struct fuse_out *out,
 			 unsigned nbytes)
 {
@@ -721,8 +714,6 @@
 	if (!err) {
 		if (req->interrupted)
 			err = -ENOENT;
-		else if (req->in.h.opcode == FUSE_GETDIR && !oh.error)
-			process_getdir(req);
 	} else if (!req->interrupted)
 		req->out.h.error = -EIO;
 	request_end(fc, req);
diff -ru linux-2.6.11-rc1-mm1/fs/fuse/dir.c linux-2.6.11-rc1-mm1-fuse/fs/fuse/dir.c
--- linux-2.6.11-rc1-mm1/fs/fuse/dir.c	2005-01-15 10:17:44.000000000 +0100
+++ linux-2.6.11-rc1-mm1-fuse/fs/fuse/dir.c	2005-01-19 22:28:04.000000000 +0100
@@ -495,70 +495,40 @@
 	return 0;
 }
 
-static int fuse_checkdir(struct file *cfile, struct file *file)
+static inline size_t fuse_send_readdir(struct fuse_req *req, struct file *file,
+				       struct inode *inode, loff_t pos,
+				       size_t count)
 {
-	struct inode *inode;
-	if (!cfile)
-		return -EIO;
-	inode = cfile->f_dentry->d_inode;
-	if (!S_ISREG(inode->i_mode)) {
-		fput(cfile);
-		return -EIO;
-	}
-
-	file->private_data = cfile;
-	return 0;
+	return fuse_send_read_common(req, file, inode, pos, count, 1);
 }
 
-static int fuse_getdir(struct file *file)
+static int fuse_readdir(struct file *file, void *dstbuf, filldir_t filldir)
 {
-	struct inode *inode = file->f_dentry->d_inode;
-	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_req *req = fuse_get_request(fc);
-	struct fuse_getdir_out_i outarg;
 	int err;
-
+	size_t nbytes;
+	struct page *page;
+	struct inode *inode = file->f_dentry->d_inode;	
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req = fuse_get_request_nonint(fc);
 	if (!req)
-		return -ERESTARTNOINTR;
+		return -EINTR;
 
-	req->in.h.opcode = FUSE_GETDIR;
-	req->in.h.nodeid = get_node_id(inode);
-	req->inode = inode;
-	req->out.numargs = 1;
-	req->out.args[0].size = sizeof(struct fuse_getdir_out);
-	req->out.args[0].value = &outarg;
-	request_send(fc, req);
+	page = alloc_page(GFP_KERNEL);
+	if (!page) {
+		fuse_put_request(fc, req);
+		return -ENOMEM;
+	}
+	req->num_pages = 1;
+	req->pages[0] = page;
+	nbytes = fuse_send_readdir(req, file, inode, file->f_pos, PAGE_SIZE);
 	err = req->out.h.error;
 	fuse_put_request(fc, req);
 	if (!err)
-		err = fuse_checkdir(outarg.file, file);
-	return err;
-}
-
-static int fuse_readdir(struct file *file, void *dstbuf, filldir_t filldir)
-{
-	struct file *cfile = file->private_data;
-	char *buf;
-	int ret;
+		err = parse_dirfile(page_address(page), nbytes, file, dstbuf,
+				    filldir);
 
-	if (!cfile) {
-		ret = fuse_getdir(file);
-		if (ret)
-			return ret;
-
-		cfile = file->private_data;
-	}
-
-	buf = (char *) __get_free_page(GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	ret = kernel_read(cfile, file->f_pos, buf, PAGE_SIZE);
-	if (ret > 0)
-		ret = parse_dirfile(buf, ret, file, dstbuf, filldir);
-
-	free_page((unsigned long) buf);
-	return ret;
+	__free_page(page);
+	return err;
 }
 
 static char *read_link(struct dentry *dentry)
@@ -613,18 +583,12 @@
 
 static int fuse_dir_open(struct inode *inode, struct file *file)
 {
-	file->private_data = NULL;
-	return 0;
+	return fuse_open_common(inode, file, 1);
 }
 
 static int fuse_dir_release(struct inode *inode, struct file *file)
 {
-	struct file *cfile = file->private_data;
-
-	if (cfile)
-		fput(cfile);
-
-	return 0;
+	return fuse_release_common(inode, file, 1);
 }
 
 static unsigned iattr_to_fattr(struct iattr *iattr, struct fuse_attr *fattr)
diff -ru linux-2.6.11-rc1-mm1/fs/fuse/file.c linux-2.6.11-rc1-mm1-fuse/fs/fuse/file.c
--- linux-2.6.11-rc1-mm1/fs/fuse/file.c	2005-01-14 12:30:07.000000000 +0100
+++ linux-2.6.11-rc1-mm1-fuse/fs/fuse/file.c	2005-01-19 22:28:04.000000000 +0100
@@ -12,7 +12,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 
-static int fuse_open(struct inode *inode, struct file *file)
+int fuse_open_common(struct inode *inode, struct file *file, int isdir)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_req *req;
@@ -50,7 +50,7 @@
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
-	req->in.h.opcode = FUSE_OPEN;
+	req->in.h.opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
 	req->in.h.nodeid = get_node_id(inode);
 	req->inode = inode;
 	req->in.numargs = 1;
@@ -76,7 +76,7 @@
 	return err;
 }
 
-static int fuse_release(struct inode *inode, struct file *file)
+int fuse_release_common(struct inode *inode, struct file *file, int isdir)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_file *ff = file->private_data;
@@ -85,7 +85,7 @@
 
 	inarg->fh = ff->fh;
 	inarg->flags = file->f_flags & ~O_EXCL;
-	req->in.h.opcode = FUSE_RELEASE;
+	req->in.h.opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
 	req->in.h.nodeid = get_node_id(inode);
 	req->inode = inode;
 	req->in.numargs = 1;
@@ -98,6 +98,16 @@
 	return 0;
 }
 
+static int fuse_open(struct inode *inode, struct file *file)
+{
+	return fuse_open_common(inode, file, 0);
+}
+
+static int fuse_release(struct inode *inode, struct file *file)
+{
+	return fuse_release_common(inode, file, 0);
+}
+
 static int fuse_flush(struct file *file)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -169,8 +179,9 @@
 	return err;
 }
 
-static ssize_t fuse_send_read(struct fuse_req *req, struct file *file,
-			      struct inode *inode, loff_t pos,  size_t count)
+size_t fuse_send_read_common(struct fuse_req *req, struct file *file,
+			     struct inode *inode, loff_t pos, size_t count, 
+			     int isdir)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_file *ff = file->private_data;
@@ -180,7 +191,7 @@
 	inarg.fh = ff->fh;
 	inarg.offset = pos;
 	inarg.size = count;
-	req->in.h.opcode = FUSE_READ;
+	req->in.h.opcode = isdir ? FUSE_READDIR : FUSE_READ;
 	req->in.h.nodeid = get_node_id(inode);
 	req->inode = inode;
 	req->file = file;
@@ -195,6 +206,13 @@
 	return req->out.args[0].size;
 }
 
+static inline size_t fuse_send_read(struct fuse_req *req, struct file *file,
+				    struct inode *inode, loff_t pos,
+				    size_t count)
+{
+	return fuse_send_read_common(req, file, inode, pos, count, 0);
+}
+
 static int fuse_readpage(struct file *file, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
@@ -284,8 +302,8 @@
 	return err;
 }
 
-static ssize_t fuse_send_write(struct fuse_req *req, struct file *file,
-			       struct inode *inode, loff_t pos, size_t count)
+static size_t fuse_send_write(struct fuse_req *req, struct file *file,
+			      struct inode *inode, loff_t pos, size_t count)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_file *ff = file->private_data;
@@ -323,7 +341,7 @@
 			     unsigned offset, unsigned to)
 {
 	int err;
-	ssize_t nres;
+	size_t nres;
 	unsigned count = to - offset;
 	struct inode *inode = page->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
diff -ru linux-2.6.11-rc1-mm1/fs/fuse/fuse_i.h linux-2.6.11-rc1-mm1-fuse/fs/fuse/fuse_i.h
--- linux-2.6.11-rc1-mm1/fs/fuse/fuse_i.h	2005-01-14 12:30:07.000000000 +0100
+++ linux-2.6.11-rc1-mm1-fuse/fs/fuse/fuse_i.h	2005-01-19 22:28:04.000000000 +0100
@@ -255,11 +255,6 @@
 	struct backing_dev_info bdi;
 };
 
-struct fuse_getdir_out_i {
-	int fd;
-	void *file; /* Used by kernel only */
-};
-
 static inline struct fuse_conn **get_fuse_conn_super_p(struct super_block *sb)
 {
 	return (struct fuse_conn **) &sb->s_fs_info;
@@ -315,6 +310,23 @@
 		      unsigned long nodeid, int version);
 
 /**
+ * Send READ or READDIR request
+ */
+size_t fuse_send_read_common(struct fuse_req *req, struct file *file,
+			     struct inode *inode, loff_t pos, size_t count,
+			     int isdir);
+
+/**
+ * Send OPEN or OPENDIR request
+ */
+int fuse_open_common(struct inode *inode, struct file *file, int isdir);
+
+/**
+ * Send RELEASE or RELEASEDIR request
+ */
+int fuse_release_common(struct inode *inode, struct file *file, int isdir);
+
+/**
  * Initialise file operations on a regular file
  */
 void fuse_init_file_inode(struct inode *inode);
diff -ru linux-2.6.11-rc1-mm1/include/linux/fuse.h linux-2.6.11-rc1-mm1-fuse/include/linux/fuse.h
--- linux-2.6.11-rc1-mm1/include/linux/fuse.h	2005-01-14 12:30:13.000000000 +0100
+++ linux-2.6.11-rc1-mm1-fuse/include/linux/fuse.h	2005-01-19 22:28:04.000000000 +0100
@@ -67,7 +67,6 @@
 	FUSE_SETATTR	   = 4,
 	FUSE_READLINK	   = 5,
 	FUSE_SYMLINK	   = 6,
-	FUSE_GETDIR	   = 7,
 	FUSE_MKNOD	   = 8,
 	FUSE_MKDIR	   = 9,
 	FUSE_UNLINK	   = 10,
@@ -85,7 +84,10 @@
 	FUSE_LISTXATTR     = 23,
 	FUSE_REMOVEXATTR   = 24,
 	FUSE_FLUSH         = 25,
-	FUSE_INIT          = 26
+	FUSE_INIT          = 26,
+	FUSE_OPENDIR       = 27,
+	FUSE_READDIR       = 28,
+	FUSE_RELEASEDIR    = 29
 };
 
 /* Conservative buffer size for the client */
@@ -117,10 +119,6 @@
 	struct fuse_attr attr;
 };
 
-struct fuse_getdir_out {
-	__u32	fd;
-};
-
 struct fuse_mknod_in {
 	__u32	mode;
 	__u32	rdev;

