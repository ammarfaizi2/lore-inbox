Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWEKShG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWEKShG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWEKShF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:37:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750890AbWEKShB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:37:01 -0400
Date: Thu, 11 May 2006 11:39:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, bcrl@kvack.org,
       cel@citi.umich.edu, Mark Fasheh <mark.fasheh@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH 1/4] Vectorize aio_read/aio_write methods
Message-Id: <20060511113932.535056c6.akpm@osdl.org>
In-Reply-To: <1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	<1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	<1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> This patch vectorizes aio_read() and aio_write() methods to prepare
> for collapsing all aio & vectored operations into one interface -
> which is aio_read()/aio_write().

There've been significant ocfs2 changes.  I redid things as below, but
didn't try super-hard.  Please check that it all looks sane.

diff -puN fs/ocfs2/file.c~vectorize-aio_read-aio_write-methods fs/ocfs2/file.c
--- 25/fs/ocfs2/file.c~vectorize-aio_read-aio_write-methods	Thu May 11 11:33:39 2006
+++ 25-akpm/fs/ocfs2/file.c	Thu May 11 11:36:12 2006
@@ -960,25 +960,23 @@ static inline int ocfs2_write_should_rem
 }
 
 static ssize_t ocfs2_file_aio_write(struct kiocb *iocb,
-				    const char __user *buf,
-				    size_t count,
+				    const struct iovec *iov,
+				    unsigned long nr_segs,
 				    loff_t pos)
 {
-	struct iovec local_iov = { .iov_base = (void __user *)buf,
-				   .iov_len = count };
 	int ret, rw_level = -1, meta_level = -1, have_alloc_sem = 0;
 	u32 clusters;
 	struct file *filp = iocb->ki_filp;
 	struct inode *inode = filp->f_dentry->d_inode;
 	loff_t newsize, saved_pos;
 
-	mlog_entry("(0x%p, 0x%p, %u, '%.*s')\n", filp, buf,
-		   (unsigned int)count,
+	mlog_entry("(0x%p, %u, '%.*s')\n", filp,
+		   (unsigned int)nr_segs,
 		   filp->f_dentry->d_name.len,
 		   filp->f_dentry->d_name.name);
 
 	/* happy write of zero bytes */
-	if (count == 0)
+	if (iocb->ki_left == 0)
 		return 0;
 
 	if (!inode) {
@@ -1047,7 +1045,7 @@ static ssize_t ocfs2_file_aio_write(stru
 		} else {
 			saved_pos = iocb->ki_pos;
 		}
-		newsize = count + saved_pos;
+		newsize = iocb->ki_left + saved_pos;
 
 		mlog(0, "pos=%lld newsize=%lld cursize=%lld\n",
 		     (long long) saved_pos, (long long) newsize,
@@ -1080,7 +1078,7 @@ static ssize_t ocfs2_file_aio_write(stru
 		if (!clusters)
 			break;
 
-		ret = ocfs2_extend_file(inode, NULL, newsize, count);
+		ret = ocfs2_extend_file(inode, NULL, newsize, iocb->ki_left);
 		if (ret < 0) {
 			if (ret != -ENOSPC)
 				mlog_errno(ret);
@@ -1097,7 +1095,7 @@ static ssize_t ocfs2_file_aio_write(stru
 	/* communicate with ocfs2_dio_end_io */
 	ocfs2_iocb_set_rw_locked(iocb);
 
-	ret = generic_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
+	ret = generic_file_aio_write_nolock(iocb, iov, nr_segs, iocb->ki_pos);
 
 	/* buffered aio wouldn't have proper lock coverage today */
 	BUG_ON(ret == -EIOCBQUEUED && !(filp->f_flags & O_DIRECT));
@@ -1131,16 +1129,16 @@ out:
 }
 
 static ssize_t ocfs2_file_aio_read(struct kiocb *iocb,
-				   char __user *buf,
-				   size_t count,
+				   const struct iovec *iov,
+				   unsigned long nr_segs,
 				   loff_t pos)
 {
 	int ret = 0, rw_level = -1, have_alloc_sem = 0;
 	struct file *filp = iocb->ki_filp;
 	struct inode *inode = filp->f_dentry->d_inode;
 
-	mlog_entry("(0x%p, 0x%p, %u, '%.*s')\n", filp, buf,
-		   (unsigned int)count,
+	mlog_entry("(0x%p, %u, '%.*s')\n", filp,
+		   (unsigned int)nr_segs,
 		   filp->f_dentry->d_name.len,
 		   filp->f_dentry->d_name.name);
 
@@ -1184,7 +1182,7 @@ static ssize_t ocfs2_file_aio_read(struc
 	}
 	ocfs2_meta_unlock(inode, 0);
 
-	ret = generic_file_aio_read(iocb, buf, count, iocb->ki_pos);
+	ret = generic_file_aio_read(iocb, iov, nr_segs, iocb->ki_pos);
 	if (ret == -EINVAL)
 		mlog(ML_ERROR, "generic_file_aio_read returned -EINVAL\n");
 

