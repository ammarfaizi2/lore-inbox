Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263236AbUKUAa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263236AbUKUAa5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 19:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbUKTXlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:41:47 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:5004 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263214AbUKTXM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:12:56 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/13] Filesystem in Userspace
Message-Id: <E1CVePO-0007Rc-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:12:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds clustered read support to FUSE.

With the help of the readpages() operation multiple reads are bundled
together and sent as a single request to userspace.  This greatly
improves reading performace.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
--- linux-2.6.10-rc2/fs/fuse/dev.c	2004-11-20 22:56:23.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/dev.c	2004-11-20 22:56:22.000000000 +0100
@@ -92,6 +92,12 @@ struct fuse_req *fuse_get_request(struct
 	return  do_get_request(fc);
 }
 
+struct fuse_req *fuse_get_request_nonint(struct fuse_conn *fc)
+{
+	down(&fc->unused_sem);
+	return do_get_request(fc);
+}
+
 struct fuse_req *fuse_get_request_nonblock(struct fuse_conn *fc)
 {
 	if (down_trylock(&fc->unused_sem))
@@ -114,13 +120,21 @@ void fuse_put_request(struct fuse_conn *
 /* Must be called with fuse_lock held, and unlocks it */
 static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 {
-	wake_up(&req->waitq);
-	spin_unlock(&fuse_lock);
+	fuse_reqend_t endfunc = req->end;
+
+	if (!endfunc) {
+		wake_up(&req->waitq);
+		spin_unlock(&fuse_lock);
+	} else {
+		spin_unlock(&fuse_lock);
+		endfunc(fc, req);
+	}
 }
 
 void request_send(struct fuse_conn *fc, struct fuse_req *req)
 {
 	req->isreply = 1;
+	req->end = NULL;
 		
 	spin_lock(&fuse_lock);
 	req->out.h.error = -ENOTCONN;
@@ -149,6 +163,24 @@ void request_send_noreply(struct fuse_co
 	}
 }
 
+void request_send_async(struct fuse_conn *fc, struct fuse_req *req, 
+			   fuse_reqend_t end)
+{
+	req->end = end;
+	req->isreply = 1;
+	
+	spin_lock(&fuse_lock);
+	if (fc->file) {
+		req->in.h.unique = get_unique(fc);
+		list_add_tail(&req->list, &fc->pending);
+		wake_up(&fc->waitq);
+		spin_unlock(&fuse_lock);
+	} else {
+		req->out.h.error = -ENOTCONN;
+		request_end(fc, req);
+	}
+}
+
 static void request_wait(struct fuse_conn *fc)
 {
 	DECLARE_WAITQUEUE(wait, current);
@@ -308,18 +340,22 @@ static inline int copy_out_args(struct f
 	nbytes -= sizeof(struct fuse_out_header);
 		
 	if (!out->h.error) {
-		for (i = 0; i < out->numargs; i++) {
-			struct fuse_out_arg *arg = &out->args[i];
-			int allowvar;
-			
-			if (out->argvar && i == out->numargs - 1)
-				allowvar = 1;
-			else
-				allowvar = 0;
-			
-			err = copy_out_one(arg, &buf, &nbytes, allowvar);
-			if (err)
-				return err;
+		if (req->copy_out)
+			return req->copy_out(req, buf, nbytes);
+		else {
+			for (i = 0; i < out->numargs; i++) {
+				struct fuse_out_arg *arg = &out->args[i];
+				int allowvar;
+				
+				if (out->argvar && i == out->numargs - 1)
+					allowvar = 1;
+				else
+					allowvar = 0;
+				
+				err = copy_out_one(arg, &buf, &nbytes, allowvar);
+				if (err)
+					return err;
+			}
 		}
 	}
 
--- linux-2.6.10-rc2/fs/fuse/fuse_i.h	2004-11-20 22:56:23.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/fuse_i.h	2004-11-20 22:56:22.000000000 +0100
@@ -14,6 +14,9 @@
 #include <linux/spinlock.h>
 #include <asm/semaphore.h>
 
+/* Max number of pages that can be used in a single read request */
+#define FUSE_MAX_PAGES_PER_REQ 32
+
 /* If more requests are outstanding, then the operation will block */
 #define FUSE_MAX_OUTSTANDING 10
 
@@ -78,6 +81,9 @@ struct fuse_out {
 struct fuse_req;
 struct fuse_conn;
 
+typedef void (*fuse_reqend_t)(struct fuse_conn *, struct fuse_req *);
+typedef int (*fuse_copyout_t)(struct fuse_req *, const char __user *, size_t);
+
 /**
  * A request to the client
  */
@@ -103,10 +109,20 @@ struct fuse_req {
 	/** Used to wake up the task waiting for completion of request*/
 	wait_queue_head_t waitq;
 
+	/** Request completion callback */
+	fuse_reqend_t end;
+
+	/** Request copy out function */
+	fuse_copyout_t copy_out;
+
 	/** Data for asynchronous requests */
 	union {
+		struct fuse_read_in read_in;
 		struct fuse_forget_in forget_in;
 	} misc;
+
+	struct page *pages[FUSE_MAX_PAGES_PER_REQ];
+	unsigned num_pages;
 };
 
 /**
@@ -129,6 +145,9 @@ struct fuse_conn {
 	/** The fuse mount flags for this mount */
 	unsigned int flags;
 
+	/** Maximum read size */
+	unsigned int max_read;
+
 	/** Readers of the connection are waiting on this */
 	wait_queue_head_t waitq;
 
@@ -258,6 +277,11 @@ void fuse_reset_request(struct fuse_req 
 struct fuse_req *fuse_get_request(struct fuse_conn *fc);
 
 /**
+ * Reserve a preallocated request, non-interruptible
+ */
+struct fuse_req *fuse_get_request_nonint(struct fuse_conn *fc);
+
+/**
  * Free a request
  */
 void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req);
@@ -273,6 +297,12 @@ void request_send(struct fuse_conn *fc, 
 void request_send_noreply(struct fuse_conn *fc, struct fuse_req *req);
 
 /**
+ * Send asynchronous request
+ */
+void request_send_async(struct fuse_conn *fc, struct fuse_req *req, 
+			fuse_reqend_t end);
+
+/**
  * Get the attributes of a file
  */
 int fuse_do_getattr(struct inode *inode);
--- linux-2.6.10-rc2/fs/fuse/inode.c	2004-11-20 22:56:23.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/inode.c	2004-11-20 22:56:22.000000000 +0100
@@ -31,6 +31,7 @@ struct fuse_mount_data {
 	unsigned int rootmode;
 	unsigned int uid;
 	unsigned int flags;
+	unsigned int max_read;
 };
 
 static struct inode *fuse_alloc_inode(struct super_block *sb)
@@ -150,6 +151,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_ALLOW_ROOT,
 	OPT_KERNEL_CACHE,
+	OPT_MAX_READ,
 	OPT_ERR 
 };
 
@@ -161,6 +163,7 @@ static match_table_t tokens = {
 	{OPT_ALLOW_OTHER,		"allow_other"},
 	{OPT_ALLOW_ROOT,		"allow_root"},
 	{OPT_KERNEL_CACHE,		"kernel_cache"},
+	{OPT_MAX_READ,			"max_read=%u"},
 	{OPT_ERR,			NULL}
 };
 
@@ -169,6 +172,7 @@ static int parse_fuse_opt(char *opt, str
 	char *p;
 	memset(d, 0, sizeof(struct fuse_mount_data));
 	d->fd = -1;
+	d->max_read = ~0;
 
 	while ((p = strsep(&opt, ",")) != NULL) {
 		int token;
@@ -213,6 +217,12 @@ static int parse_fuse_opt(char *opt, str
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
@@ -236,6 +246,8 @@ static int fuse_show_options(struct seq_
 		seq_puts(m, ",allow_root");
 	if (fc->flags & FUSE_KERNEL_CACHE)
 		seq_puts(m, ",kernel_cache");
+	if (fc->max_read != ~0)
+		seq_printf(m, ",max_read=%u", fc->max_read);
 	return 0;
 }
 
@@ -367,6 +379,7 @@ static int fuse_read_super(struct super_
 
 	fc->flags = d.flags;
 	fc->uid = d.uid;
+	fc->max_read = d.max_read;
 	
 	SB_FC(sb) = fc;
 
--- linux-2.6.10-rc2/fs/fuse/file.c	2004-11-20 22:56:23.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/file.c	2004-11-20 22:56:21.000000000 +0100
@@ -232,6 +232,126 @@ static int fuse_readpage(struct file *fi
 	return res;
 }
 
+static int read_pages_copyout(struct fuse_req *req, const char __user *buf,
+			      size_t nbytes)
+{
+	unsigned i;
+	unsigned long base_index = req->pages[0]->index;
+	for (i = 0; i < req->num_pages; i++) {
+		struct page *page = req->pages[i];
+		unsigned long offset;
+		unsigned count;
+		char *tmpbuf;
+		int err;
+
+		offset = (page->index - base_index) * PAGE_CACHE_SIZE;
+		if (offset >= nbytes)
+			count = 0;
+		else if (offset + PAGE_CACHE_SIZE <= nbytes)
+			count = PAGE_CACHE_SIZE;
+		else
+			count = nbytes - offset;
+
+		tmpbuf = kmap(page);
+		err = 0;
+		if (count)
+			err = copy_from_user(tmpbuf, buf + offset, count);
+		if (count < PAGE_CACHE_SIZE)
+			memset(tmpbuf + count, 0, PAGE_CACHE_SIZE - count);
+		kunmap(page);
+		if (err)
+			return -EFAULT;
+
+		flush_dcache_page(page);
+		SetPageUptodate(page);
+	}
+	return 0;
+}
+
+static void read_pages_end(struct fuse_conn *fc, struct fuse_req *req)
+{
+	unsigned i;
+
+	for (i = 0; i < req->num_pages; i++)
+		unlock_page(req->pages[i]);
+	
+	fuse_put_request(fc, req);
+}
+
+static void fuse_send_readpages(struct fuse_req *req, struct file *file,
+				struct inode *inode)
+{
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_read_in *inarg;
+	loff_t pos;
+	unsigned numpages;
+	
+	pos = (loff_t) req->pages[0]->index << PAGE_CACHE_SHIFT;
+	/* Allow for holes between the pages */
+	numpages = req->pages[req->num_pages - 1]->index + 1 
+		- req->pages[0]->index;
+	
+	inarg = &req->misc.read_in;
+	inarg->fh = ff->fh;
+	inarg->offset = pos;
+	inarg->size = numpages * PAGE_CACHE_SIZE;
+	req->in.h.opcode = FUSE_READ;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(struct fuse_read_in);
+	req->in.args[0].value = inarg;
+	req->copy_out = read_pages_copyout;
+	request_send_async(fc, req, read_pages_end);
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
+	struct fuse_conn *fc = INO_FC(inode);
+	
+	if (req->num_pages && 
+	    (req->num_pages == FUSE_MAX_PAGES_PER_REQ ||
+	     (req->num_pages + 1) * PAGE_CACHE_SIZE > fc->max_read ||
+	     req->pages[req->num_pages - 1]->index + 1 != page->index)) {
+		struct fuse_conn *fc = INO_FC(page->mapping->host);
+		fuse_send_readpages(req, data->file, inode);
+		data->req = req = fuse_get_request_nonint(fc);
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
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_readpages_data data;
+
+	data.req = fuse_get_request_nonint(fc);
+	data.file = file;
+	data.inode = inode;
+	
+	read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
+	if (data.req->num_pages)
+		fuse_send_readpages(data.req, file, inode);
+	else
+		fuse_put_request(fc, data.req);
+
+	return 0;
+}
+
 static ssize_t fuse_send_write(struct fuse_req *req, struct fuse_file *ff,
 			       struct inode *inode, const char *buf,
 			       loff_t pos, size_t count)
@@ -343,6 +463,7 @@ static struct address_space_operations f
 	.readpage	= fuse_readpage,
 	.prepare_write	= fuse_prepare_write,
 	.commit_write	= fuse_commit_write,
+	.readpages	= fuse_readpages,
 	.set_page_dirty = __set_page_dirty_nobuffers,
 };
 
