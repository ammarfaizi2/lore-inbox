Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVAKRDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVAKRDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 12:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVAKQzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:55:52 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:34176 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262831AbVAKQcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:32:21 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] FUSE - direct I/O
Message-Id: <E1CoOw6-0003NA-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Jan 2005 17:32:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the "direct_io" mount option of FUSE.

When this mount option is specified, the page cache is bypassed for
read and write operations.  This is useful for example, if the
filesystem doesn't know the size of files before reading them, or when
any kind of caching is harmful.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
diff -Nurp a/fs/fuse/file.c b/fs/fuse/file.c
--- a/fs/fuse/file.c	2005-01-11 16:28:28.000000000 +0100
+++ b/fs/fuse/file.c	2005-01-11 16:28:28.000000000 +0100
@@ -354,8 +354,134 @@ static int fuse_commit_write(struct file
 	return err;
 }
 
+static void fuse_release_user_pages(struct fuse_req *req, int write)
+{
+	unsigned i;
+
+	for (i = 0; i < req->num_pages; i++) {
+		struct page *page = req->pages[i];
+		if (write)
+			set_page_dirty_lock(page);
+		put_page(page);
+	}
+}
+
+static int fuse_get_user_pages(struct fuse_req *req, const char __user *buf,
+			       unsigned nbytes, int write)
+{
+	unsigned long user_addr = (unsigned long) buf;
+	unsigned offset = user_addr & ~PAGE_MASK;
+	int npages;
+
+	nbytes = min(nbytes, (unsigned) FUSE_MAX_PAGES_PER_REQ << PAGE_SHIFT);
+	npages = (nbytes + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	npages = min(npages, FUSE_MAX_PAGES_PER_REQ);
+	down_read(&current->mm->mmap_sem);
+	npages = get_user_pages(current, current->mm, user_addr, npages, write,
+				0, req->pages, NULL);
+	up_read(&current->mm->mmap_sem);
+	if (npages < 0)
+		return npages;
+
+	req->num_pages = npages;
+	req->page_offset = offset;
+	return 0;
+}
+
+static ssize_t fuse_direct_io(struct file *file, const char __user *buf,
+			      size_t count, loff_t *ppos, int write)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	unsigned nmax = write ? fc->max_write : fc->max_read;
+	loff_t pos = *ppos;
+	ssize_t res = 0;
+	struct fuse_req *req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
+
+	while (count) {
+		unsigned tmp;
+		unsigned nres;
+		size_t nbytes = min(count, nmax);
+		int err = fuse_get_user_pages(req, buf, nbytes, !write);
+		if (err) {
+			res = err;
+			break;
+		}
+		tmp = (req->num_pages << PAGE_SHIFT) - req->page_offset;
+		nbytes = min(nbytes, tmp);
+		if (write)
+			nres = fuse_send_write(req, file, inode, pos, nbytes);
+		else
+			nres = fuse_send_read(req, file, inode, pos, nbytes);
+		fuse_release_user_pages(req, !write);
+		if (req->out.h.error) {
+			if (!res)
+				res = req->out.h.error;
+			break;
+		} else if (nres > nbytes) {
+			res = -EIO;
+			break;
+		}
+		count -= nres;
+		res += nres;
+		pos += nres;
+		buf += nres;
+		if (nres != nbytes)
+			break;
+		if (count)
+			fuse_reset_request(req);
+	}
+	fuse_put_request(fc, req);
+	if (res > 0) {
+		if (write && pos > i_size_read(inode))
+			i_size_write(inode, pos);
+		*ppos = pos;
+	} else if (write && (res == -EINTR || res == -EIO))
+		fuse_invalidate_attr(inode);
+
+	return res;
+}
+
+static ssize_t fuse_file_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (fc->flags & FUSE_DIRECT_IO)
+		return fuse_direct_io(file, buf, count, ppos, 0);
+	else
+		return generic_file_read(file, buf, count, ppos);
+}
+
+static ssize_t fuse_file_write(struct file *file, const char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (fc->flags & FUSE_DIRECT_IO) {
+		ssize_t res;
+		/* Don't allow parallel writes to the same file */
+		down(&inode->i_sem);
+		res = fuse_direct_io(file, buf, count, ppos, 1);
+		up(&inode->i_sem);
+		return res;
+	}
+	else
+		return generic_file_write(file, buf, count, ppos);
+}
+
 static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (fc->flags & FUSE_DIRECT_IO)
+		return -ENODEV;
+
 	if ((vma->vm_flags & VM_SHARED)) {
 		if ((vma->vm_flags & VM_WRITE))
 			return -ENODEV;
@@ -373,8 +499,8 @@ static int fuse_set_page_dirty(struct pa
 }
 
 static struct file_operations fuse_file_operations = {
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= fuse_file_read,
+	.write		= fuse_file_write,
 	.mmap		= fuse_file_mmap,
 	.open		= fuse_open,
 	.flush		= fuse_flush,
diff -Nurp a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
--- a/fs/fuse/fuse_i.h	2005-01-11 16:28:28.000000000 +0100
+++ b/fs/fuse/fuse_i.h	2005-01-11 16:28:28.000000000 +0100
@@ -34,6 +34,9 @@
     be flushed on open */
 #define FUSE_KERNEL_CACHE        (1 << 2)
 
+/** Bypass the page cache for read and write operations  */
+#define FUSE_DIRECT_IO           (1 << 3)
+
 /** Allow root and setuid-root programs to access fuse-mounted
     filesystems */
 #define FUSE_ALLOW_ROOT		 (1 << 4)
@@ -205,6 +208,9 @@ struct fuse_conn {
 	/** Maximum read size */
 	unsigned max_read;
 
+	/** Maximum write size */
+	unsigned max_write;
+
 	/** Readers of the connection are waiting on this */
 	wait_queue_head_t waitq;
 
diff -Nurp a/fs/fuse/inode.c b/fs/fuse/inode.c
--- a/fs/fuse/inode.c	2005-01-11 16:28:28.000000000 +0100
+++ b/fs/fuse/inode.c	2005-01-11 16:28:28.000000000 +0100
@@ -255,6 +255,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_ALLOW_ROOT,
 	OPT_KERNEL_CACHE,
+	OPT_DIRECT_IO,
 	OPT_MAX_READ,
 	OPT_ERR
 };
@@ -267,6 +268,7 @@ static match_table_t tokens = {
 	{OPT_ALLOW_OTHER,		"allow_other"},
 	{OPT_ALLOW_ROOT,		"allow_root"},
 	{OPT_KERNEL_CACHE,		"kernel_cache"},
+	{OPT_DIRECT_IO,			"direct_io"},
 	{OPT_MAX_READ,			"max_read=%u"},
 	{OPT_ERR,			NULL}
 };
@@ -321,6 +323,10 @@ static int parse_fuse_opt(char *opt, str
 			d->flags |= FUSE_KERNEL_CACHE;
 			break;
 
+		case OPT_DIRECT_IO:
+			d->flags |= FUSE_DIRECT_IO;
+			break;
+
 		case OPT_MAX_READ:
 			if (match_int(&args[0], &value))
 				return 0;
@@ -350,6 +356,8 @@ static int fuse_show_options(struct seq_
 		seq_puts(m, ",allow_root");
 	if (fc->flags & FUSE_KERNEL_CACHE)
 		seq_puts(m, ",kernel_cache");
+	if (fc->flags & FUSE_DIRECT_IO)
+		seq_puts(m, ",direct_io");
 	if (fc->max_read != ~0)
 		seq_printf(m, ",max_read=%u", fc->max_read);
 	return 0;
@@ -552,6 +560,7 @@ static int fuse_fill_super(struct super_
 	fc->max_read = d.max_read;
 	if (fc->max_read / PAGE_CACHE_SIZE < fc->bdi.ra_pages)
 		fc->bdi.ra_pages = fc->max_read / PAGE_CACHE_SIZE;
+	fc->max_write = FUSE_MAX_IN / 2;
 
 	*get_fuse_conn_super_p(sb) = fc;
 
