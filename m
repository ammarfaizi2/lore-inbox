Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbVAKQxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbVAKQxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbVAKQxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:53:05 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:33152 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262829AbVAKQbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:31:35 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/11] FUSE - readpages operation
Message-Id: <E1CoOvN-0003MY-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Jan 2005 17:31:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds readpages support to FUSE.

With the help of the readpages() operation multiple reads are bundled
together and sent as a single request to userspace.  This can improve
reading performace.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
diff -Nurp a/fs/fuse/file.c b/fs/fuse/file.c
--- a/fs/fuse/file.c	2005-01-11 16:28:28.000000000 +0100
+++ b/fs/fuse/file.c	2005-01-11 16:28:28.000000000 +0100
@@ -218,6 +218,72 @@ static int fuse_readpage(struct file *fi
 	return err;
 }
 
+static int fuse_send_readpages(struct fuse_req *req, struct file *file,
+			       struct inode *inode)
+{
+	loff_t pos = (loff_t) req->pages[0]->index << PAGE_CACHE_SHIFT;
+	size_t count = req->num_pages << PAGE_CACHE_SHIFT;
+	unsigned i;
+	req->out.page_zeroing = 1;
+	fuse_send_read(req, file, inode, pos, count);
+	for (i = 0; i < req->num_pages; i++) {
+		struct page *page = req->pages[i];
+		if (!req->out.h.error)
+			SetPageUptodate(page);
+		unlock_page(page);
+	}
+	return req->out.h.error;
+}
+
+struct fuse_readpages_data {
+	struct fuse_req *req;
+	struct file *file;
+	struct inode *inode;
+};
+
+static int fuse_readpages_fill(void *_data, struct page *page)
+{
+	struct fuse_readpages_data *data = _data;
+	struct fuse_req *req = data->req;
+	struct inode *inode = data->inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (req->num_pages &&
+	    (req->num_pages == FUSE_MAX_PAGES_PER_REQ ||
+	     (req->num_pages + 1) * PAGE_CACHE_SIZE > fc->max_read ||
+	     req->pages[req->num_pages - 1]->index + 1 != page->index)) {
+		int err = fuse_send_readpages(req, data->file, inode);
+		if (err) {
+			unlock_page(page);
+			return err;
+		}
+		fuse_reset_request(req);
+	}
+	req->pages[req->num_pages] = page;
+	req->num_pages ++;
+	return 0;
+}
+
+static int fuse_readpages(struct file *file, struct address_space *mapping,
+			  struct list_head *pages, unsigned nr_pages)
+{
+	struct inode *inode = mapping->host;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_readpages_data data;
+	int err;
+	data.file = file;
+	data.inode = inode;
+	data.req = fuse_get_request_nonint(fc);
+	if (!data.req)
+		return -EINTR;
+
+	err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
+	if (!err && data.req->num_pages)
+		err = fuse_send_readpages(data.req, file, inode);
+	fuse_put_request(fc, data.req);
+	return err;
+}
+
 static ssize_t fuse_send_write(struct fuse_req *req, struct file *file,
 			       struct inode *inode, loff_t pos, size_t count)
 {
@@ -321,6 +387,7 @@ static struct address_space_operations f
 	.readpage	= fuse_readpage,
 	.prepare_write	= fuse_prepare_write,
 	.commit_write	= fuse_commit_write,
+	.readpages	= fuse_readpages,
 	.set_page_dirty	= fuse_set_page_dirty,
 };
 
diff -Nurp a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
--- a/fs/fuse/fuse_i.h	2005-01-11 16:28:28.000000000 +0100
+++ b/fs/fuse/fuse_i.h	2005-01-11 16:28:28.000000000 +0100
@@ -202,6 +202,9 @@ struct fuse_conn {
 	/** The fuse mount flags for this mount */
 	unsigned flags;
 
+	/** Maximum read size */
+	unsigned max_read;
+
 	/** Readers of the connection are waiting on this */
 	wait_queue_head_t waitq;
 
diff -Nurp a/fs/fuse/inode.c b/fs/fuse/inode.c
--- a/fs/fuse/inode.c	2005-01-11 16:28:28.000000000 +0100
+++ b/fs/fuse/inode.c	2005-01-11 16:28:28.000000000 +0100
@@ -42,6 +42,7 @@ struct fuse_mount_data {
 	unsigned rootmode;
 	unsigned user_id;
 	unsigned flags;
+	unsigned max_read;
 };
 
 static struct inode *fuse_alloc_inode(struct super_block *sb)
@@ -254,6 +255,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_ALLOW_ROOT,
 	OPT_KERNEL_CACHE,
+	OPT_MAX_READ,
 	OPT_ERR
 };
 
@@ -265,6 +267,7 @@ static match_table_t tokens = {
 	{OPT_ALLOW_OTHER,		"allow_other"},
 	{OPT_ALLOW_ROOT,		"allow_root"},
 	{OPT_KERNEL_CACHE,		"kernel_cache"},
+	{OPT_MAX_READ,			"max_read=%u"},
 	{OPT_ERR,			NULL}
 };
 
@@ -273,6 +276,7 @@ static int parse_fuse_opt(char *opt, str
 	char *p;
 	memset(d, 0, sizeof(struct fuse_mount_data));
 	d->fd = -1;
+	d->max_read = ~0;
 
 	while ((p = strsep(&opt, ",")) != NULL) {
 		int token;
@@ -317,6 +321,12 @@ static int parse_fuse_opt(char *opt, str
 			d->flags |= FUSE_KERNEL_CACHE;
 			break;
 
+		case OPT_MAX_READ:
+			if (match_int(&args[0], &value))
+				return 0;
+			d->max_read = value;
+			break;
+
 		default:
 			return 0;
 		}
@@ -340,6 +350,8 @@ static int fuse_show_options(struct seq_
 		seq_puts(m, ",allow_root");
 	if (fc->flags & FUSE_KERNEL_CACHE)
 		seq_puts(m, ",kernel_cache");
+	if (fc->max_read != ~0)
+		seq_printf(m, ",max_read=%u", fc->max_read);
 	return 0;
 }
 
@@ -479,6 +491,9 @@ static int fuse_fill_super(struct super_
 
 	fc->flags = d.flags;
 	fc->user_id = d.user_id;
+	fc->max_read = d.max_read;
+	if (fc->max_read / PAGE_CACHE_SIZE < fc->bdi.ra_pages)
+		fc->bdi.ra_pages = fc->max_read / PAGE_CACHE_SIZE;
 
 	*get_fuse_conn_super_p(sb) = fc;
 
