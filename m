Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbUKTXgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUKTXgq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbUKTXfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:35:44 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:25996 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263193AbUKTXO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:14:26 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] Filesystem in Userspace
Message-Id: <E1CVeQr-0007Sx-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:14:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for shared writable mappings to FUSE.

Note: currently this can deadlock the system if the userspace
filesystem needs to allocate space in order to perform writeback of
dirty data.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
--- linux-2.6.10-rc2/fs/fuse/dev.c	2004-11-20 22:56:20.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/dev.c	2004-11-20 22:43:08.000000000 +0100
@@ -164,9 +164,10 @@ void request_send_noreply(struct fuse_co
 }
 
 void request_send_async(struct fuse_conn *fc, struct fuse_req *req, 
-			   fuse_reqend_t end)
+			   fuse_reqend_t end, void *data)
 {
 	req->end = end;
+	req->data = data;
 	req->isreply = 1;
 	
 	spin_lock(&fuse_lock);
@@ -391,6 +392,7 @@ static int fuse_invalidate(struct fuse_c
 		inode = fuse_ilookup(fc->sb, uh->nodeid);
 		err = -ENOENT;
 		if (inode) {
+			fuse_sync_inode(inode);
 			invalidate_inode_pages(inode->i_mapping);
 			iput(inode);
 			err = 0;
--- linux-2.6.10-rc2/fs/fuse/dir.c	2004-11-20 22:56:20.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/dir.c	2004-11-20 22:41:40.000000000 +0100
@@ -798,6 +798,9 @@ static int fuse_setattr(struct dentry *e
 	if (!req)
 		return -ERESTARTSYS;
 
+	if (is_truncate)
+		down_write(&fi->write_sem);
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.valid = iattr_to_fattr(attr, &inarg.attr);
 	req->in.h.opcode = FUSE_SETATTR;
@@ -816,13 +819,15 @@ static int fuse_setattr(struct dentry *e
 		if (is_truncate) {
 			loff_t origsize = i_size_read(inode);
 			i_size_write(inode, outarg.attr.size);
+			up_write(&fi->write_sem);
 			if (origsize > outarg.attr.size)
 				vmtruncate(inode, outarg.attr.size);
 		}
 		change_attributes(inode, &outarg.attr);
 		fi->i_time = time_to_jiffies(outarg.attr_valid,
 					     outarg.attr_valid_nsec);
-	}
+	} else if (is_truncate)
+		up_write(&fi->write_sem);
 		
 	return err;
 }
--- linux-2.6.10-rc2/fs/fuse/fuse_i.h	2004-11-20 22:56:21.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/fuse_i.h	2004-11-20 22:43:08.000000000 +0100
@@ -45,13 +45,18 @@ permission checking is done in the kerne
 struct fuse_inode {
 	unsigned long nodeid;
 	struct fuse_req *forget_req;
+	struct rw_semaphore write_sem;
 	unsigned long i_time;
+	/* Files which can provide file handles in writepage.
+	   Protected by write_sem  */
+	struct list_head write_files;
 };
 
 /** FUSE specific file data */
 struct fuse_file {
 	struct fuse_req *release_req;
 	unsigned long fh;
+	struct list_head ff_list;
 };
 
 /** One input argument of a request */
@@ -118,8 +123,16 @@ struct fuse_req {
 	/** Request copy out function */
 	fuse_copyout_t copy_out;
 
+	/** User data */
+	void *data;
+
 	/** Data for asynchronous requests */
 	union {
+		struct {
+			struct fuse_write_in in;
+			struct fuse_write_out out;
+			
+		} write;
 		struct fuse_read_in read_in;
 		struct fuse_forget_in forget_in;
 	} misc;
@@ -291,6 +304,11 @@ struct fuse_req *fuse_get_request(struct
 struct fuse_req *fuse_get_request_nonint(struct fuse_conn *fc);
 
 /**
+ * Reserve a preallocated request, non-blocking
+ */
+struct fuse_req *fuse_get_request_nonblock(struct fuse_conn *fc);
+
+/**
  * Free a request
  */
 void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req);
@@ -309,9 +327,14 @@ void request_send_noreply(struct fuse_co
  * Send asynchronous request
  */
 void request_send_async(struct fuse_conn *fc, struct fuse_req *req, 
-			fuse_reqend_t end);
+			fuse_reqend_t end, void *data);
 
 /**
  * Get the attributes of a file
  */
 int fuse_do_getattr(struct inode *inode);
+
+/**
+ * Write dirty pages
+ */
+void fuse_sync_inode(struct inode *inode);
--- linux-2.6.10-rc2/fs/fuse/inode.c	2004-11-20 22:56:21.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/inode.c	2004-11-20 22:41:40.000000000 +0100
@@ -51,12 +51,16 @@ static struct inode *fuse_alloc_inode(st
 		kmem_cache_free(fuse_inode_cachep, inode);
 		return NULL;
 	}
+	init_rwsem(&fi->write_sem);
+	INIT_LIST_HEAD(&fi->write_files);
+
 	return inode;
 }
 
 static void fuse_destroy_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = INO_FI(inode);
+	BUG_ON(!list_empty(&fi->write_files));
 	if (fi->forget_req)
 		fuse_request_free(fi->forget_req);
 	kmem_cache_free(fuse_inode_cachep, inode);
--- linux-2.6.10-rc2/fs/fuse/file.c	2004-11-20 22:56:21.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/file.c	2004-11-20 22:41:40.000000000 +0100
@@ -10,8 +10,15 @@
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/writeback.h>
+#include <linux/moduleparam.h>
 #include <asm/uaccess.h>
 
+static int user_mmap;
+module_param(user_mmap, int, 0644);
+MODULE_PARM_DESC(user_mmap, "Allow non root user to create a shared writable mapping");
+
 static int fuse_open(struct inode *inode, struct file *file)
 {
 	struct fuse_conn *fc = INO_FC(inode);
@@ -73,6 +80,7 @@ static int fuse_open(struct inode *inode
 	else {
 		ff->fh = outarg.fh;
 		file->private_data = ff;
+		INIT_LIST_HEAD(&ff->ff_list);
 	}
 
  out_put_request:
@@ -82,6 +90,12 @@ static int fuse_open(struct inode *inode
 	return err;
 }
 
+void fuse_sync_inode(struct inode *inode)
+{
+	filemap_fdatawrite(inode->i_mapping);
+	filemap_fdatawait(inode->i_mapping);
+}
+
 static int fuse_release(struct inode *inode, struct file *file)
 {
 	struct fuse_conn *fc = INO_FC(inode);
@@ -91,6 +105,15 @@ static int fuse_release(struct inode *in
 	struct fuse_release_in inarg;
 	
 	down(&inode->i_sem);
+	if (file->f_mode & FMODE_WRITE)
+		fuse_sync_inode(inode);
+
+	if (!list_empty(&ff->ff_list)) {
+		down_write(&fi->write_sem);
+		list_del(&ff->ff_list);
+		up_write(&fi->write_sem);
+	}
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.fh = ff->fh;
 	inarg.flags = file->f_flags & ~O_EXCL;
@@ -157,6 +180,11 @@ static int fuse_fsync(struct file *file,
 	if (!req)
 		return -ERESTARTSYS;
 
+	/* Make sure all writes to this inode are completed before
+	   issuing the FSYNC request */
+	down_write(&fi->write_sem);
+	up_write(&fi->write_sem);
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.fh = ff->fh;
 	inarg.datasync = datasync;
@@ -303,7 +331,7 @@ static void fuse_send_readpages(struct f
 	req->in.args[0].size = sizeof(struct fuse_read_in);
 	req->in.args[0].value = inarg;
 	req->copy_out = read_pages_copyout;
-	request_send_async(fc, req, read_pages_end);
+	request_send_async(fc, req, read_pages_end, NULL);
 }
 
 struct fuse_readpages_data {
@@ -546,6 +574,123 @@ static int write_buffer(struct inode *in
 	return res;
 }
 
+static int get_write_count(struct inode *inode, struct page *page)
+{
+	unsigned long end_index;
+	loff_t size = i_size_read(inode);
+	int count;
+	
+	end_index = size >> PAGE_CACHE_SHIFT;
+	if (page->index < end_index)
+		count = PAGE_CACHE_SIZE;
+	else {
+		count = size & (PAGE_CACHE_SIZE - 1);
+		if (page->index > end_index || count == 0)
+			return 0;
+	}
+	return count;
+}
+
+static void write_page_end(struct fuse_conn *fc, struct fuse_req *req)
+{
+	struct page *page = req->data;
+	struct inode *inode = page->mapping->host;
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_write_out *outarg = req->out.args[0].value;
+	if (!req->out.h.error && outarg->size != req->in.args[1].size) {
+		printk("fuse: short write\n");
+		req->out.h.error = -EPROTO;
+	}
+
+	if (req->out.h.error) {
+		SetPageError(page);
+		if (req->out.h.error == -ENOSPC)
+			set_bit(AS_ENOSPC, &page->mapping->flags);
+		else
+			set_bit(AS_EIO, &page->mapping->flags);
+	}
+	up_read(&fi->write_sem);
+
+	end_page_writeback(page);
+	kunmap(page);
+	fuse_put_request(fc, req);
+}
+
+static void fuse_send_writepage(struct fuse_req *req, struct inode *inode,
+				struct page *page, unsigned count)
+{
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_write_in *inarg;
+	struct fuse_file *ff;
+	char *buffer;
+
+	BUG_ON(list_empty(&fi->write_files));
+	ff = list_entry(fi->write_files.next, struct fuse_file, ff_list);
+	
+	inarg = &req->misc.write.in;
+	buffer = kmap(page);
+	inarg->writepage = 1;
+	inarg->fh = ff->fh;
+	inarg->offset = ((loff_t) page->index << PAGE_CACHE_SHIFT);
+	inarg->size = count;
+	req->in.h.opcode = FUSE_WRITE;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.h.uid = 0;
+	req->in.h.gid = 0;
+	req->in.h.pid = 0;
+	req->in.numargs = 2;
+	req->in.args[0].size = sizeof(struct fuse_write_in);
+	req->in.args[0].value = inarg;
+	req->in.args[1].size = count;
+	req->in.args[1].value = buffer;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(struct fuse_write_out);
+	req->out.args[0].value = &req->misc.write.out;
+	request_send_async(fc, req, write_page_end, page);
+}
+
+static int fuse_writepage(struct page *page, struct writeback_control *wbc)
+{
+	struct inode *inode = page->mapping->host;
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_req *req;
+	int err;
+
+	err = -EWOULDBLOCK;
+	if (wbc->nonblocking)
+		req = fuse_get_request_nonblock(fc);
+	else
+		req = fuse_get_request_nonint(fc);
+	if (req) {
+		int locked = 1;
+		if (wbc->nonblocking)
+			locked = down_read_trylock(&fi->write_sem);
+		else
+			down_read(&fi->write_sem);
+		if (locked) {
+			unsigned count;
+			err = 0;
+			count = get_write_count(inode, page);
+			if (count) {
+				SetPageWriteback(page);		
+				fuse_send_writepage(req, inode, page, count);
+				goto out;
+			}
+			up_read(&fi->write_sem);
+		}
+		fuse_put_request(fc, req);
+	}
+	if (err == -EWOULDBLOCK) {
+		redirty_page_for_writepage(wbc, page);
+		err = 0;
+	}
+ out:
+	unlock_page(page);
+	return err;
+}
+
 static int fuse_prepare_write(struct file *file, struct page *page,
 			      unsigned offset, unsigned to)
 {
@@ -654,8 +799,22 @@ static int fuse_file_mmap(struct file *f
 
 	if (fc->flags & FUSE_DIRECT_IO)
 		return -ENODEV;
-	else
-		return generic_file_readonly_mmap(file, vma);
+	else {
+		if ((vma->vm_flags & (VM_WRITE | VM_SHARED)) == 
+		    (VM_WRITE | VM_SHARED)) {
+			struct fuse_inode *fi = INO_FI(inode);
+			struct fuse_file *ff = file->private_data;
+
+			if (!user_mmap && current->uid != 0)
+				return -EPERM;
+
+			down_write(&fi->write_sem);
+			if (list_empty(&ff->ff_list))
+				list_add(&ff->ff_list, &fi->write_files);
+			up_write(&fi->write_sem);
+		}
+		return generic_file_mmap(file, vma);
+	}
 }
 
 static struct file_operations fuse_file_operations = {
@@ -671,6 +830,7 @@ static struct file_operations fuse_file_
 
 static struct address_space_operations fuse_file_aops  = {
 	.readpage	= fuse_readpage,
+	.writepage	= fuse_writepage,
 	.prepare_write	= fuse_prepare_write,
 	.commit_write	= fuse_commit_write,
 	.readpages	= fuse_readpages,
