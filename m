Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945918AbWANAng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945918AbWANAng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945916AbWANAm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:42:29 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:21422 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1945906AbWANAmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:42:25 -0500
Message-Id: <20060114004143.743157000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:40:04 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] fuse: use asynchronous READ requests for readpages
Content-Disposition: inline; filename=fuse_async_read.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes fuse_readpages() to send READ requests
asynchronously.  This makes it possible for userspace filesystems to
utilize the kernel readahead logic instead of having to implement
their own (resulting in double caching).

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-01-14 00:48:17.000000000 +0100
+++ linux/fs/fuse/file.c	2006-01-14 00:53:07.000000000 +0100
@@ -265,7 +265,7 @@ void fuse_read_fill(struct fuse_req *req
 	req->file = file;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(struct fuse_read_in);
-	req->in.args[0].value = &inarg;
+	req->in.args[0].value = inarg;
 	req->out.argpages = 1;
 	req->out.argvar = 1;
 	req->out.numargs = 1;
@@ -311,21 +311,33 @@ static int fuse_readpage(struct file *fi
 	return err;
 }
 
-static int fuse_send_readpages(struct fuse_req *req, struct file *file,
-			       struct inode *inode)
+static void fuse_readpages_end(struct fuse_conn *fc, struct fuse_req *req)
 {
-	loff_t pos = page_offset(req->pages[0]);
-	size_t count = req->num_pages << PAGE_CACHE_SHIFT;
-	unsigned i;
-	req->out.page_zeroing = 1;
-	fuse_send_read(req, file, inode, pos, count);
+	int i;
+
+	fuse_invalidate_attr(req->pages[0]->mapping->host); /* atime changed */
+
 	for (i = 0; i < req->num_pages; i++) {
 		struct page *page = req->pages[i];
 		if (!req->out.h.error)
 			SetPageUptodate(page);
+		else
+			SetPageError(page);
 		unlock_page(page);
 	}
-	return req->out.h.error;
+	fuse_put_request(fc, req);
+}
+
+static void fuse_send_readpages(struct fuse_req *req, struct file *file,
+				struct inode *inode)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	loff_t pos = page_offset(req->pages[0]);
+	size_t count = req->num_pages << PAGE_CACHE_SHIFT;
+	req->out.page_zeroing = 1;
+	req->end = fuse_readpages_end;
+	fuse_read_fill(req, file, inode, pos, count, FUSE_READ);
+	request_send_background(fc, req);
 }
 
 struct fuse_readpages_data {
@@ -345,12 +357,12 @@ static int fuse_readpages_fill(void *_da
 	    (req->num_pages == FUSE_MAX_PAGES_PER_REQ ||
 	     (req->num_pages + 1) * PAGE_CACHE_SIZE > fc->max_read ||
 	     req->pages[req->num_pages - 1]->index + 1 != page->index)) {
-		int err = fuse_send_readpages(req, data->file, inode);
-		if (err) {
+		fuse_send_readpages(req, data->file, inode);
+		data->req = req = fuse_get_request(fc);
+		if (!req) {
 			unlock_page(page);
-			return err;
+			return -EINTR;
 		}
-		fuse_reset_request(req);
 	}
 	req->pages[req->num_pages] = page;
 	req->num_pages ++;
@@ -375,10 +387,8 @@ static int fuse_readpages(struct file *f
 		return -EINTR;
 
 	err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
-	if (!err && data.req->num_pages)
-		err = fuse_send_readpages(data.req, file, inode);
-	fuse_put_request(fc, data.req);
-	fuse_invalidate_attr(inode); /* atime changed */
+	if (!err)
+		fuse_send_readpages(data.req, file, inode);
 	return err;
 }
 

--
