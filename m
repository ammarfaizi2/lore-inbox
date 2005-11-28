Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVK1Trv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVK1Trv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVK1Trv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:47:51 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:17157 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932211AbVK1Tru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:47:50 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1EgoxK-0006tk-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 28 Nov 2005 20:46:30 +0100)
Subject: [PATCH 4/7] fuse: clean up page offset calculation
References: <E1EgosN-0006s3-00@dorka.pomaz.szeredi.hu> <E1EgouE-0006sp-00@dorka.pomaz.szeredi.hu> <E1EgowL-0006tN-00@dorka.pomaz.szeredi.hu> <E1EgoxK-0006tk-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1EgoyM-0006uH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 28 Nov 2005 20:47:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use page_offset() instead of doing page offset calculation by hand.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2005-11-28 14:01:07.000000000 +0100
+++ linux/fs/fuse/file.c	2005-11-28 14:02:07.000000000 +0100
@@ -272,7 +272,6 @@ static int fuse_readpage(struct file *fi
 {
 	struct inode *inode = page->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	loff_t pos = (loff_t) page->index << PAGE_CACHE_SHIFT;
 	struct fuse_req *req = fuse_get_request(fc);
 	int err = -EINTR;
 	if (!req)
@@ -281,7 +280,7 @@ static int fuse_readpage(struct file *fi
 	req->out.page_zeroing = 1;
 	req->num_pages = 1;
 	req->pages[0] = page;
-	fuse_send_read(req, file, inode, pos, PAGE_CACHE_SIZE);
+	fuse_send_read(req, file, inode, page_offset(page), PAGE_CACHE_SIZE);
 	err = req->out.h.error;
 	fuse_put_request(fc, req);
 	if (!err)
@@ -295,7 +294,7 @@ static int fuse_readpage(struct file *fi
 static int fuse_send_readpages(struct fuse_req *req, struct file *file,
 			       struct inode *inode)
 {
-	loff_t pos = (loff_t) req->pages[0]->index << PAGE_CACHE_SHIFT;
+	loff_t pos = page_offset(req->pages[0]);
 	size_t count = req->num_pages << PAGE_CACHE_SHIFT;
 	unsigned i;
 	req->out.page_zeroing = 1;
@@ -402,7 +401,7 @@ static int fuse_commit_write(struct file
 	unsigned count = to - offset;
 	struct inode *inode = page->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	loff_t pos = ((loff_t) page->index << PAGE_CACHE_SHIFT) + offset;
+	loff_t pos = page_offset(page) + offset;
 	struct fuse_req *req = fuse_get_request(fc);
 	if (!req)
 		return -EINTR;
