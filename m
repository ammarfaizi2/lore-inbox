Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422763AbWJPQ3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422763AbWJPQ3T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422771AbWJPQ3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:29:15 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:40634 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1422757AbWJPQ3E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:29:04 -0400
Message-Id: <20061016162813.789732000@szeredi.hu>
References: <20061016162709.369579000@szeredi.hu>
User-Agent: quilt/0.45-1
Date: Mon, 16 Oct 2006 18:27:20 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [patch 11/12] fuse: add bmap support
Content-Disposition: inline; filename=fuse_bmap.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the BMAP operation for block device based filesystems.
This is needed to support swap-files and lilo.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-10-16 16:17:30.000000000 +0200
+++ linux/fs/fuse/file.c	2006-10-16 16:21:39.000000000 +0200
@@ -757,6 +757,42 @@ static int fuse_file_lock(struct file *f
 	return err;
 }
 
+static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
+{
+	struct inode *inode = mapping->host;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req;
+	struct fuse_bmap_in inarg;
+	struct fuse_bmap_out outarg;
+	int err;
+
+	if (!inode->i_sb->s_bdev || fc->no_bmap)
+		return 0;
+
+	req = fuse_get_req(fc);
+	if (IS_ERR(req))
+		return 0;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.block = block;
+	inarg.blocksize = inode->i_sb->s_blocksize;
+	req->in.h.opcode = FUSE_BMAP;
+	req->in.h.nodeid = get_node_id(inode);
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (err == -ENOSYS)
+		fc->no_bmap = 1;
+
+	return err ? 0 : outarg.block;
+}
+
 static const struct file_operations fuse_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= do_sync_read,
@@ -790,6 +826,7 @@ static const struct address_space_operat
 	.commit_write	= fuse_commit_write,
 	.readpages	= fuse_readpages,
 	.set_page_dirty	= fuse_set_page_dirty,
+	.bmap		= fuse_bmap,
 };
 
 void fuse_init_file_inode(struct inode *inode)
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-10-16 16:17:36.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-10-16 16:21:39.000000000 +0200
@@ -339,6 +339,9 @@ struct fuse_conn {
 	/** Is interrupt not implemented by fs? */
 	unsigned no_interrupt : 1;
 
+	/** Is bmap not implemented by fs? */
+	unsigned no_bmap : 1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2006-10-16 16:21:26.000000000 +0200
+++ linux/include/linux/fuse.h	2006-10-16 16:21:39.000000000 +0200
@@ -132,6 +132,7 @@ enum fuse_opcode {
 	FUSE_ACCESS        = 34,
 	FUSE_CREATE        = 35,
 	FUSE_INTERRUPT     = 36,
+	FUSE_BMAP          = 37,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -302,6 +303,16 @@ struct fuse_interrupt_in {
 	__u64	unique;
 };
 
+struct fuse_bmap_in {
+	__u64	block;
+	__u32	blocksize;
+	__u32	padding;
+};
+
+struct fuse_bmap_out {
+	__u64	block;
+};
+
 struct fuse_in_header {
 	__u32	len;
 	__u32	opcode;
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-10-16 16:21:29.000000000 +0200
+++ linux/fs/fuse/dir.c	2006-10-16 16:21:39.000000000 +0200
@@ -1000,6 +1000,8 @@ static int fuse_setattr(struct dentry *e
 	if (attr->ia_valid & ATTR_SIZE) {
 		unsigned long limit;
 		is_truncate = 1;
+		if (IS_SWAPFILE(inode))
+			return -ETXTBSY;
 		limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
 		if (limit != RLIM_INFINITY && attr->ia_size > (loff_t) limit) {
 			send_sig(SIGXFSZ, current, 0);

--
