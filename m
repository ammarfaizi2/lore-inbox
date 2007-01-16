Return-Path: <linux-kernel-owner+w=401wt.eu-S932351AbXAPCFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbXAPCFH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbXAPCDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:03:47 -0500
Received: from 64.221.212.177.ptr.us.xo.net ([64.221.212.177]:25129 "EHLO
	ext.agami.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932247AbXAPCDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:03:35 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 21:03:27 EST
From: Nate Diller <nate@agami.com>
To: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
Date: Mon, 15 Jan 2007 17:54:50 -0800
Message-Id: <20070116015450.9764.23733.patchbomb.py@nate-64.agami.com>
In-Reply-To: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com>
Subject: [PATCH -mm 6/10][RFC] aio: make nfs_directIO use file_endio_t
X-OriginalArrivalTime: 16 Jan 2007 01:55:21.0443 (UTC) FILETIME=[6162A330:01C73911]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the iternals of nfs's directIO support to use a generic endio
function, instead of directly calling aio_complete.  It's pretty easy
because it already has a pretty abstracted completion path.

---

diff -urpN -X dontdiff a/fs/nfs/direct.c b/fs/nfs/direct.c
--- a/fs/nfs/direct.c	2007-01-12 14:53:48.000000000 -0800
+++ b/fs/nfs/direct.c	2007-01-12 15:02:30.000000000 -0800
@@ -68,7 +68,6 @@ struct nfs_direct_req {
 
 	/* I/O parameters */
 	struct nfs_open_context	*ctx;		/* file open context info */
-	struct kiocb *		iocb;		/* controlling i/o request */
 	struct inode *		inode;		/* target file of i/o */
 
 	/* completion state */
@@ -77,6 +76,8 @@ struct nfs_direct_req {
 	ssize_t			count,		/* bytes actually processed */
 				error;		/* any reported error */
 	struct completion	completion;	/* wait for i/o completion */
+	file_endio_t		*endio;		/* async completion function */
+	void			*endio_data;	/* private completion data */
 
 	/* commit state */
 	struct list_head	rewrite_list;	/* saved nfs_write_data structs */
@@ -151,7 +152,7 @@ static inline struct nfs_direct_req *nfs
 	kref_get(&dreq->kref);
 	init_completion(&dreq->completion);
 	INIT_LIST_HEAD(&dreq->rewrite_list);
-	dreq->iocb = NULL;
+	dreq->endio = NULL;
 	dreq->ctx = NULL;
 	spin_lock_init(&dreq->lock);
 	atomic_set(&dreq->io_count, 0);
@@ -179,7 +180,7 @@ static ssize_t nfs_direct_wait(struct nf
 	ssize_t result = -EIOCBQUEUED;
 
 	/* Async requests don't wait here */
-	if (dreq->iocb)
+	if (!dreq->endio)
 		goto out;
 
 	result = wait_for_completion_interruptible(&dreq->completion);
@@ -194,14 +195,10 @@ out:
 	return (ssize_t) result;
 }
 
-/*
- * Synchronous I/O uses a stack-allocated iocb.  Thus we can't trust
- * the iocb is still valid here if this is a synchronous request.
- */
 static void nfs_direct_complete(struct nfs_direct_req *dreq)
 {
-	if (dreq->iocb)
-		aio_complete(dreq->iocb, dreq->count, dreq->error);
+	if (dreq->endio)
+		dreq->endio(dreq->endio_data, dreq->count, dreq->error);
 
 	complete_all(&dreq->completion);
 
@@ -332,11 +329,13 @@ static ssize_t nfs_direct_read_schedule(
 	return result < 0 ? (ssize_t) result : -EFAULT;
 }
 
-static ssize_t nfs_direct_read(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos)
+static ssize_t nfs_direct_read(struct file *file, unsigned long user_addr,
+			       size_t count, loff_t pos,
+			       file_endio_t *endio, void *endio_data)
 {
 	ssize_t result = 0;
 	sigset_t oldset;
-	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	struct inode *inode = file->f_mapping->host;
 	struct rpc_clnt *clnt = NFS_CLIENT(inode);
 	struct nfs_direct_req *dreq;
 
@@ -345,9 +344,9 @@ static ssize_t nfs_direct_read(struct ki
 		return -ENOMEM;
 
 	dreq->inode = inode;
-	dreq->ctx = get_nfs_open_context((struct nfs_open_context *)iocb->ki_filp->private_data);
-	if (!is_sync_kiocb(iocb))
-		dreq->iocb = iocb;
+	dreq->ctx = get_nfs_open_context((struct nfs_open_context *)file->private_data);
+	dreq->endio = endio;
+	dreq->endio_data = endio_data;
 
 	nfs_add_stats(inode, NFSIOS_DIRECTREADBYTES, count);
 	rpc_clnt_sigmask(clnt, &oldset);
@@ -663,11 +662,13 @@ static ssize_t nfs_direct_write_schedule
 	return result < 0 ? (ssize_t) result : -EFAULT;
 }
 
-static ssize_t nfs_direct_write(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos)
+static ssize_t nfs_direct_write(struct file *file, unsigned long user_addr,
+				size_t count, loff_t pos,
+				file_endio_t *endio, void *endio_data)
 {
 	ssize_t result = 0;
 	sigset_t oldset;
-	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	struct inode *inode = file->f_mapping->host;
 	struct rpc_clnt *clnt = NFS_CLIENT(inode);
 	struct nfs_direct_req *dreq;
 	size_t wsize = NFS_SERVER(inode)->wsize;
@@ -682,9 +683,9 @@ static ssize_t nfs_direct_write(struct k
 		sync = FLUSH_STABLE;
 
 	dreq->inode = inode;
-	dreq->ctx = get_nfs_open_context((struct nfs_open_context *)iocb->ki_filp->private_data);
-	if (!is_sync_kiocb(iocb))
-		dreq->iocb = iocb;
+	dreq->ctx = get_nfs_open_context((struct nfs_open_context *)file->private_data);
+	dreq->endio = endio;
+	dreq->endio_data = endio_data;
 
 	nfs_add_stats(inode, NFSIOS_DIRECTWRITTENBYTES, count);
 
@@ -701,10 +702,12 @@ static ssize_t nfs_direct_write(struct k
 
 /**
  * nfs_file_direct_read - file direct read operation for NFS files
- * @iocb: target I/O control block
+ * @file: target file
  * @iov: vector of user buffers into which to read data
  * @nr_segs: size of iov vector
  * @pos: byte offset in file where reading starts
+ * @endio: async I/O completion function
+ * @endio_data: private completion data
  *
  * We use this function for direct reads instead of calling
  * generic_file_aio_read() in order to avoid gfar's check to see if
@@ -720,11 +723,11 @@ static ssize_t nfs_direct_write(struct k
  * client must read the updated atime from the server back into its
  * cache.
  */
-ssize_t nfs_file_direct_read(struct kiocb *iocb, const struct iovec *iov,
-				unsigned long nr_segs, loff_t pos)
+ssize_t nfs_file_direct_read(struct file *file, const struct iovec *iov,
+				unsigned long nr_segs, loff_t *pos,
+				file_endio_t *endio, void *endio_data)
 {
 	ssize_t retval = -EINVAL;
-	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	/* XXX: temporary */
 	const char __user *buf = iov[0].iov_base;
@@ -733,7 +736,7 @@ ssize_t nfs_file_direct_read(struct kioc
 	dprintk("nfs: direct read(%s/%s, %lu@%Ld)\n",
 		file->f_path.dentry->d_parent->d_name.name,
 		file->f_path.dentry->d_name.name,
-		(unsigned long) count, (long long) pos);
+		(unsigned long) count, (long long) *pos);
 
 	if (nr_segs != 1)
 		return -EINVAL;
@@ -751,9 +754,10 @@ ssize_t nfs_file_direct_read(struct kioc
 	if (retval)
 		goto out;
 
-	retval = nfs_direct_read(iocb, (unsigned long) buf, count, pos);
+	retval = nfs_direct_read(file, (unsigned long) buf, count, *pos,
+				 endio, endio_data);
 	if (retval > 0)
-		iocb->ki_pos = pos + retval;
+		*pos += retval;
 
 out:
 	return retval;
@@ -761,10 +765,12 @@ out:
 
 /**
  * nfs_file_direct_write - file direct write operation for NFS files
- * @iocb: target I/O control block
+ * @file: target file
  * @iov: vector of user buffers from which to write data
  * @nr_segs: size of iov vector
  * @pos: byte offset in file where writing starts
+ * @endio: async I/O completion function
+ * @endio_data: private completion data
  *
  * We use this function for direct writes instead of calling
  * generic_file_aio_write() in order to avoid taking the inode
@@ -784,11 +790,11 @@ out:
  * Note that O_APPEND is not supported for NFS direct writes, as there
  * is no atomic O_APPEND write facility in the NFS protocol.
  */
-ssize_t nfs_file_direct_write(struct kiocb *iocb, const struct iovec *iov,
-				unsigned long nr_segs, loff_t pos)
+ssize_t nfs_file_direct_write(struct file *file, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t *pos,
+			      file_endio_t *endio, void *endio_data)
 {
 	ssize_t retval;
-	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	/* XXX: temporary */
 	const char __user *buf = iov[0].iov_base;
@@ -797,12 +803,12 @@ ssize_t nfs_file_direct_write(struct kio
 	dfprintk(VFS, "nfs: direct write(%s/%s, %lu@%Ld)\n",
 		file->f_path.dentry->d_parent->d_name.name,
 		file->f_path.dentry->d_name.name,
-		(unsigned long) count, (long long) pos);
+		(unsigned long) count, (long long) *pos);
 
 	if (nr_segs != 1)
 		return -EINVAL;
 
-	retval = generic_write_checks(file, &pos, &count, 0);
+	retval = generic_write_checks(file, pos, &count, 0);
 	if (retval)
 		goto out;
 
@@ -821,10 +827,11 @@ ssize_t nfs_file_direct_write(struct kio
 	if (retval)
 		goto out;
 
-	retval = nfs_direct_write(iocb, (unsigned long) buf, count, pos);
+	retval = nfs_direct_write(file, (unsigned long) buf, count, *pos,
+				  endio, endio_data);
 
 	if (retval > 0)
-		iocb->ki_pos = pos + retval;
+		*pos += retval;
 
 out:
 	return retval;
diff -urpN -X dontdiff a/fs/nfs/file.c b/fs/nfs/file.c
--- a/fs/nfs/file.c	2007-01-12 11:19:45.000000000 -0800
+++ b/fs/nfs/file.c	2007-01-12 15:01:17.000000000 -0800
@@ -208,7 +208,8 @@ nfs_file_read(struct kiocb *iocb, const 
 
 #ifdef CONFIG_NFS_DIRECTIO
 	if (iocb->ki_filp->f_flags & O_DIRECT)
-		return nfs_file_direct_read(iocb, iov, nr_segs, pos);
+		return nfs_file_direct_read(iocb->ki_filp, iov, nr_segs,
+					    &iocb->ki_pos, aio_complete, iocb);
 #endif
 
 	dfprintk(VFS, "nfs: read(%s/%s, %lu@%lu)\n",
@@ -350,7 +351,8 @@ static ssize_t nfs_file_write(struct kio
 
 #ifdef CONFIG_NFS_DIRECTIO
 	if (iocb->ki_filp->f_flags & O_DIRECT)
-		return nfs_file_direct_write(iocb, iov, nr_segs, pos);
+		return nfs_file_direct_write(iocb->ki_filp, iov, nr_segs,
+					     &iocb->ki_pos, aio_complete, iocb);
 #endif
 
 	dfprintk(VFS, "nfs: write(%s/%s(%ld), %lu@%Ld)\n",
diff -urpN -X dontdiff a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
--- a/include/linux/nfs_fs.h	2007-01-12 11:19:48.000000000 -0800
+++ b/include/linux/nfs_fs.h	2007-01-12 15:01:17.000000000 -0800
@@ -369,12 +369,12 @@ extern int nfs3_removexattr (struct dent
  */
 extern ssize_t nfs_direct_IO(int, struct kiocb *, const struct iovec *, loff_t,
 			unsigned long);
-extern ssize_t nfs_file_direct_read(struct kiocb *iocb,
+extern ssize_t nfs_file_direct_read(struct file *file,
 			const struct iovec *iov, unsigned long nr_segs,
-			loff_t pos);
-extern ssize_t nfs_file_direct_write(struct kiocb *iocb,
+			loff_t *pos, file_endio_t *endio, void *endio_data);
+extern ssize_t nfs_file_direct_write(struct file *file,
 			const struct iovec *iov, unsigned long nr_segs,
-			loff_t pos);
+			loff_t *pos, file_endio_t *endio, void *endio_data);
 
 /*
  * linux/fs/nfs/dir.c
