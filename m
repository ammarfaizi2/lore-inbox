Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263193AbUKTXmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbUKTXmZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbUKTXie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:38:34 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:21900 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261582AbUKTXOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:14:04 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] Filesystem in Userspace
Message-Id: <E1CVeQT-0007Sc-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:13:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the "direct_io" mount option of FUSE.

When this mount option is specified, the page cache is bypassed for
read and write operations.  This is useful for example, if the
filesystem doesn't know the size of files before reading them, or when
any kind of caching is harmful.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
--- linux-2.6.10-rc2/fs/fuse/fuse_i.h	2004-11-20 22:56:21.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/fuse_i.h	2004-11-20 22:56:21.000000000 +0100
@@ -34,6 +34,9 @@ permission checking is done in the kerne
     until the INVALIDATE operation is invoked */
 #define FUSE_KERNEL_CACHE        (1 << 2)
 
+/** Bypass the page cache for read and write operations  */
+#define FUSE_DIRECT_IO           (1 << 3)
+
 /** Allow root and setuid-root programs to access fuse-mounted
     filesystems */
 #define FUSE_ALLOW_ROOT		 (1 << 4)
@@ -148,6 +151,9 @@ struct fuse_conn {
 	/** Maximum read size */
 	unsigned int max_read;
 
+	/** Maximum write size */
+	unsigned int max_write;
+
 	/** Readers of the connection are waiting on this */
 	wait_queue_head_t waitq;
 
--- linux-2.6.10-rc2/fs/fuse/inode.c	2004-11-20 22:56:21.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/inode.c	2004-11-20 22:56:21.000000000 +0100
@@ -153,6 +153,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_ALLOW_ROOT,
 	OPT_KERNEL_CACHE,
+	OPT_DIRECT_IO,
 	OPT_MAX_READ,
 	OPT_ERR 
 };
@@ -165,6 +166,7 @@ static match_table_t tokens = {
 	{OPT_ALLOW_OTHER,		"allow_other"},
 	{OPT_ALLOW_ROOT,		"allow_root"},
 	{OPT_KERNEL_CACHE,		"kernel_cache"},
+	{OPT_DIRECT_IO,			"direct_io"},
 	{OPT_MAX_READ,			"max_read=%u"},
 	{OPT_ERR,			NULL}
 };
@@ -219,6 +221,10 @@ static int parse_fuse_opt(char *opt, str
 			d->flags |= FUSE_KERNEL_CACHE;
 			break;
 
+		case OPT_DIRECT_IO:
+			d->flags |= FUSE_DIRECT_IO;
+			break;
+
 		case OPT_MAX_READ:
 			if (match_int(&args[0], &value))
 				return 0;
@@ -248,6 +254,8 @@ static int fuse_show_options(struct seq_
 		seq_puts(m, ",allow_root");
 	if (fc->flags & FUSE_KERNEL_CACHE)
 		seq_puts(m, ",kernel_cache");
+	if (fc->flags & FUSE_DIRECT_IO)
+		seq_puts(m, ",direct_io");
 	if (fc->max_read != ~0)
 		seq_printf(m, ",max_read=%u", fc->max_read);
 	return 0;
@@ -445,6 +453,7 @@ static int fuse_read_super(struct super_
 	fc->flags = d.flags;
 	fc->uid = d.uid;
 	fc->max_read = d.max_read;
+	fc->max_write = FUSE_MAX_IN / 2;
 	
 	SB_FC(sb) = fc;
 
--- linux-2.6.10-rc2/fs/fuse/file.c	2004-11-20 22:56:21.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/file.c	2004-11-20 22:56:21.000000000 +0100
@@ -352,6 +352,132 @@ static int fuse_readpages(struct file *f
 	return 0;
 }
 
+static int fuse_read_copyout(struct fuse_req *req, const char __user *buf,
+			     size_t nbytes)
+{
+	struct fuse_read_in *inarg =  &req->misc.read_in;
+	unsigned i;
+	if (nbytes > inarg->size) {
+		printk("fuse: long read\n");
+		return -EPROTO;
+	}
+	req->out.args[0].size = nbytes;
+	for (i = 0; i < req->num_pages && nbytes; i++) {
+		struct page *page = req->pages[i];
+		unsigned long offset = i * PAGE_CACHE_SIZE;
+		unsigned count = min((unsigned) PAGE_CACHE_SIZE, nbytes);
+		if (copy_from_user(page_address(page), buf + offset, count))
+			return -EFAULT;
+		nbytes -= count;
+	}
+	return 0;
+}
+
+static int fuse_send_read_multi(struct file *file, struct fuse_req *req,
+				    size_t size, off_t pos)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_read_in *inarg;
+	
+	inarg = &req->misc.read_in;
+	inarg->fh = ff->fh;
+	inarg->offset = pos;
+	inarg->size = size;
+	req->in.h.opcode = FUSE_READ;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(struct fuse_read_in);
+	req->in.args[0].value = inarg;
+	req->copy_out = fuse_read_copyout;
+	request_send(fc, req);
+	return req->out.h.error;
+}
+
+static ssize_t fuse_read(struct file *file, char __user *buf, size_t count,
+			 loff_t *ppos)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = INO_FC(inode);
+	ssize_t res;
+	loff_t pos = *ppos;
+	struct fuse_req *req;
+	unsigned npages;
+	int i;
+
+	npages = (min(fc->max_read, count) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	npages = min(npages, (unsigned) FUSE_MAX_PAGES_PER_REQ);
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
+
+	res = -ENOMEM;
+	for (req->num_pages = 0; req->num_pages < npages; req->num_pages++) {
+		req->pages[req->num_pages] = alloc_page(GFP_KERNEL);
+		if (!req->pages[req->num_pages])
+			goto out;
+	}
+
+	res = 0;
+	while (count) {
+		size_t nbytes;
+		size_t nbytes_req = min(req->num_pages * (unsigned) PAGE_SIZE,
+					count);
+		int err = fuse_send_read_multi(file, req, nbytes_req, pos);
+		if (err) {
+			if (!res)
+				res = err;
+			break;
+		}
+		nbytes = req->out.args[0].size;
+		for (i = 0; i < req->num_pages && nbytes; i++) {
+			struct page *page = req->pages[i];
+			unsigned n = min((unsigned) PAGE_SIZE, nbytes);
+			if (copy_to_user(buf, page_address(page), n)) {
+				res = -EFAULT;
+				break;
+			}
+			nbytes -= n;
+			buf += n;
+		}
+		nbytes = req->out.args[0].size;
+		count -= nbytes;
+		res += nbytes;
+		pos += nbytes;
+
+		if (res < 0 || nbytes != nbytes_req)
+			break;
+	}
+ out:
+	for (i = 0; i < req->num_pages; i++)
+		__free_page(req->pages[i]);
+	fuse_put_request(fc, req);
+	if (res > 0)
+		*ppos += res;
+
+	return res;
+}
+
+static ssize_t fuse_file_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = INO_FC(inode);
+	ssize_t res;
+
+	if (fc->flags & FUSE_DIRECT_IO) {
+		res = fuse_read(file, buf, count, ppos);
+	}
+	else {
+		res = generic_file_read(file, buf, count, ppos);
+	}
+
+	return res;
+}  
+
 static ssize_t fuse_send_write(struct fuse_req *req, struct fuse_file *ff,
 			       struct inode *inode, const char *buf,
 			       loff_t pos, size_t count)
@@ -448,10 +574,94 @@ static int fuse_commit_write(struct file
 	return err;
 }
 
+static ssize_t fuse_write(struct file *file, const char __user *buf,
+			  size_t count, loff_t *ppos)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_file *ff = file->private_data;
+	char *tmpbuf;
+	ssize_t res = 0;
+	loff_t pos = *ppos;
+	struct fuse_req *req;
+	size_t max_write = min(fc->max_write, (unsigned) PAGE_SIZE);
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
+
+	tmpbuf = (char *) __get_free_page(GFP_KERNEL);
+	if (!tmpbuf) {
+		fuse_put_request(fc, req);
+		return -ENOMEM;
+	}
+
+	while (count) {
+		size_t nbytes = min(max_write, count);
+		ssize_t res1;
+		if (copy_from_user(tmpbuf, buf, nbytes)) {
+			res = -EFAULT;
+			break;
+		}
+		res1 = fuse_send_write(req, ff, inode, tmpbuf, pos, nbytes);
+		if (res1 < 0) {
+			res = res1;
+			break;
+		}
+		res += res1;
+		count -= res1;
+		buf += res1;
+		pos += res1;
+		if (res1 < nbytes)
+			break;
+
+		if (count)
+			fuse_reset_request(req);
+	}
+	free_page((unsigned long) tmpbuf);
+	fuse_put_request(fc, req);
+
+	if (res > 0) {
+		if (pos > i_size_read(inode))
+			i_size_write(inode, pos);
+		*ppos = pos;
+	}
+
+	return res;
+}
+
+static ssize_t fuse_file_write(struct file *file, const char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = INO_FC(inode);
+	
+	if (fc->flags & FUSE_DIRECT_IO) {
+		ssize_t res;
+		down(&inode->i_sem);
+		res = fuse_write(file, buf, count, ppos);
+		up(&inode->i_sem);
+		return res;
+	}
+	else 
+		return generic_file_write(file, buf, count, ppos);
+}
+			       
+static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = INO_FC(inode);
+
+	if (fc->flags & FUSE_DIRECT_IO)
+		return -ENODEV;
+	else
+		return generic_file_readonly_mmap(file, vma);
+}
+
 static struct file_operations fuse_file_operations = {
-	.read		= generic_file_read,
-	.write		= generic_file_write,
-	.mmap		= generic_file_readonly_mmap,
+	.read		= fuse_file_read,
+	.write		= fuse_file_write,
+	.mmap		= fuse_file_mmap,
 	.open		= fuse_open,
 	.flush		= fuse_flush,
 	.release	= fuse_release,
