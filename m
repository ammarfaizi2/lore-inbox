Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945917AbWANAm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945917AbWANAm5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945906AbWANAmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:42:31 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:20910 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1945918AbWANAmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:42:21 -0500
Message-Id: <20060114004139.115615000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:40:03 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] fuse: READ request initialization
Content-Disposition: inline; filename=fuse_read_fill.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a separate function for filling in the READ request.  This will
make it possible to send asynchronous READ requests as well as
synchronous ones.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-01-13 23:40:09.000000000 +0100
+++ linux/fs/fuse/dir.c	2006-01-14 00:48:17.000000000 +0100
@@ -762,12 +762,6 @@ static int parse_dirfile(char *buf, size
 	return 0;
 }
 
-static size_t fuse_send_readdir(struct fuse_req *req, struct file *file,
-				struct inode *inode, loff_t pos, size_t count)
-{
-	return fuse_send_read_common(req, file, inode, pos, count, 1);
-}
-
 static int fuse_readdir(struct file *file, void *dstbuf, filldir_t filldir)
 {
 	int err;
@@ -791,7 +785,9 @@ static int fuse_readdir(struct file *fil
 	}
 	req->num_pages = 1;
 	req->pages[0] = page;
-	nbytes = fuse_send_readdir(req, file, inode, file->f_pos, PAGE_SIZE);
+	fuse_read_fill(req, file, inode, file->f_pos, PAGE_SIZE, FUSE_READDIR);
+	request_send(fc, req);
+	nbytes = req->out.args[0].size;
 	err = req->out.h.error;
 	fuse_put_request(fc, req);
 	if (!err)
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-01-14 00:43:41.000000000 +0100
+++ linux/fs/fuse/file.c	2006-01-14 00:48:17.000000000 +0100
@@ -250,19 +250,16 @@ static int fuse_fsync(struct file *file,
 	return fuse_fsync_common(file, de, datasync, 0);
 }
 
-size_t fuse_send_read_common(struct fuse_req *req, struct file *file,
-			     struct inode *inode, loff_t pos, size_t count,
-			     int isdir)
+void fuse_read_fill(struct fuse_req *req, struct file *file,
+		    struct inode *inode, loff_t pos, size_t count, int opcode)
 {
-	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_file *ff = file->private_data;
-	struct fuse_read_in inarg;
+	struct fuse_read_in *inarg = &req->misc.read_in;
 
-	memset(&inarg, 0, sizeof(struct fuse_read_in));
-	inarg.fh = ff->fh;
-	inarg.offset = pos;
-	inarg.size = count;
-	req->in.h.opcode = isdir ? FUSE_READDIR : FUSE_READ;
+	inarg->fh = ff->fh;
+	inarg->offset = pos;
+	inarg->size = count;
+	req->in.h.opcode = opcode;
 	req->in.h.nodeid = get_node_id(inode);
 	req->inode = inode;
 	req->file = file;
@@ -273,14 +270,15 @@ size_t fuse_send_read_common(struct fuse
 	req->out.argvar = 1;
 	req->out.numargs = 1;
 	req->out.args[0].size = count;
-	request_send(fc, req);
-	return req->out.args[0].size;
 }
 
 static size_t fuse_send_read(struct fuse_req *req, struct file *file,
 			     struct inode *inode, loff_t pos, size_t count)
 {
-	return fuse_send_read_common(req, file, inode, pos, count, 0);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	fuse_read_fill(req, file, inode, pos, count, FUSE_READ);
+	request_send(fc, req);
+	return req->out.args[0].size;
 }
 
 static int fuse_readpage(struct file *file, struct page *page)
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-14 00:45:13.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-14 00:48:17.000000000 +0100
@@ -169,6 +169,7 @@ struct fuse_req {
 		struct fuse_release_in release_in;
 		struct fuse_init_in init_in;
 		struct fuse_init_out init_out;
+		struct fuse_read_in read_in;
 	} misc;
 
 	/** page vector */
@@ -354,11 +355,10 @@ void fuse_send_forget(struct fuse_conn *
 		      unsigned long nodeid, u64 nlookup);
 
 /**
- * Send READ or READDIR request
+ * Initialize READ or READDIR request
  */
-size_t fuse_send_read_common(struct fuse_req *req, struct file *file,
-			     struct inode *inode, loff_t pos, size_t count,
-			     int isdir);
+void fuse_read_fill(struct fuse_req *req, struct file *file,
+		    struct inode *inode, loff_t pos, size_t count, int opcode);
 
 /**
  * Send OPEN or OPENDIR request

--
