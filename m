Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWADNTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWADNTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 08:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWADNTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 08:19:11 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:14474 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751781AbWADNTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 08:19:10 -0500
Message-Id: <20060104131838.566183000@dorka.pomaz.szeredi.hu>
References: <20060104131530.511388000@dorka.pomaz.szeredi.hu>
Date: Wed, 04 Jan 2006 14:15:32 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] fuse: fail file operations on bad inode
Content-Disposition: inline; filename=fuse_file_operations_on_bad_inode.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make file operations on a bad inode fail.  This just makes things a
bit more consistent.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-01-04 12:37:42.000000000 +0100
+++ linux/fs/fuse/dir.c	2006-01-04 12:37:52.000000000 +0100
@@ -773,7 +773,12 @@ static int fuse_readdir(struct file *fil
 	struct page *page;
 	struct inode *inode = file->f_dentry->d_inode;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_req *req = fuse_get_request(fc);
+	struct fuse_req *req;
+
+	if (is_bad_inode(inode))
+		return -EIO;
+
+	req = fuse_get_request(fc);
 	if (!req)
 		return -EINTR;
 
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-01-04 12:14:06.000000000 +0100
+++ linux/fs/fuse/file.c	2006-01-04 12:37:52.000000000 +0100
@@ -163,6 +163,9 @@ static int fuse_flush(struct file *file)
 	struct fuse_flush_in inarg;
 	int err;
 
+	if (is_bad_inode(inode))
+		return -EIO;
+
 	if (fc->no_flush)
 		return 0;
 
@@ -199,6 +202,9 @@ int fuse_fsync_common(struct file *file,
 	struct fuse_fsync_in inarg;
 	int err;
 
+	if (is_bad_inode(inode))
+		return -EIO;
+
 	if ((!isdir && fc->no_fsync) || (isdir && fc->no_fsyncdir))
 		return 0;
 
@@ -272,8 +278,15 @@ static int fuse_readpage(struct file *fi
 {
 	struct inode *inode = page->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_req *req = fuse_get_request(fc);
-	int err = -EINTR;
+	struct fuse_req *req;
+	int err;
+
+	err = -EIO;
+	if (is_bad_inode(inode))
+		goto out;
+
+	err = -EINTR;
+	req = fuse_get_request(fc);
 	if (!req)
 		goto out;
 
@@ -344,6 +357,10 @@ static int fuse_readpages(struct file *f
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_readpages_data data;
 	int err;
+
+	if (is_bad_inode(inode))
+		return -EIO;
+
 	data.file = file;
 	data.inode = inode;
 	data.req = fuse_get_request(fc);
@@ -402,7 +419,12 @@ static int fuse_commit_write(struct file
 	struct inode *inode = page->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	loff_t pos = page_offset(page) + offset;
-	struct fuse_req *req = fuse_get_request(fc);
+	struct fuse_req *req;
+
+	if (is_bad_inode(inode))
+		return -EIO;
+
+	req = fuse_get_request(fc);
 	if (!req)
 		return -EINTR;
 
@@ -474,7 +496,12 @@ static ssize_t fuse_direct_io(struct fil
 	size_t nmax = write ? fc->max_write : fc->max_read;
 	loff_t pos = *ppos;
 	ssize_t res = 0;
-	struct fuse_req *req = fuse_get_request(fc);
+	struct fuse_req *req;
+
+	if (is_bad_inode(inode))
+		return -EIO;
+
+	req = fuse_get_request(fc);
 	if (!req)
 		return -EINTR;
 

--
