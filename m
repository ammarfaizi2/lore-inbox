Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbSJ2RS6>; Tue, 29 Oct 2002 12:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262107AbSJ2RS6>; Tue, 29 Oct 2002 12:18:58 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:58608 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262080AbSJ2RSx>; Tue, 29 Oct 2002 12:18:53 -0500
From: Badari Pulavarty <badari@us.ibm.com>
Message-Id: <200210291725.g9THP6j15170@eng2.beaverton.ibm.com>
Subject: [PATCH] 2.5.44 generic_file_*_write() support for AIO
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org (lkml)
Date: Tue, 29 Oct 2002 09:25:06 -0800 (PST)
Cc: akpm@digeo.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben & Andrew,

Here is 2.5.44 patch to add support for generic_file_*_write()
support for AIO. I was wondering why this is not done, while 
adding generic_file_*_read() support for AIO. 

I need these changes to support AIO on DIO. Do they look
reasonable to you ?

Thanks,
Badari


--- linux/mm/filemap.c	Fri Oct 25 13:58:46 2002
+++ linux.new/mm/filemap.c	Tue Oct 29 08:27:50 2002
@@ -1571,10 +1571,11 @@
  * it for writing by marking it dirty.
  *							okir@monad.swb.de
  */
-ssize_t
-generic_file_write_nolock(struct file *file, const struct iovec *iov,
+static ssize_t
+__generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
 {
+	struct file *file = iocb->ki_filp;
 	struct address_space * mapping = file->f_dentry->d_inode->i_mapping;
 	struct address_space_operations *a_ops = mapping->a_ops;
 	size_t ocount;		/* original count */
@@ -1833,10 +1834,36 @@
 	return err;
 }
 
+ssize_t
+generic_file_write_nolock(struct file *file, const struct iovec *iov,
+				unsigned long nr_segs, loff_t *ppos)
+{
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, file);
+	ret = __generic_file_aio_write_nolock(&kiocb, iov, nr_segs, ppos);
+	if (-EIOCBQUEUED == ret)
+		ret = wait_on_sync_kiocb(&kiocb);
+	return ret;
+}
+
 ssize_t generic_file_aio_write(struct kiocb *iocb, const char *buf,
 			       size_t count, loff_t pos)
 {
-	return generic_file_write(iocb->ki_filp, buf, count, &iocb->ki_pos);
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
+	int err;
+	struct iovec local_iov = { .iov_base = (void *)buf, .iov_len = count };
+
+	BUG_ON(iocb->ki_pos != pos);
+
+	down(&inode->i_sem);
+	err = __generic_file_aio_write_nolock(iocb, &local_iov, 1, 
+						&iocb->ki_pos);
+	up(&inode->i_sem);
+
+	return err;
 }
 EXPORT_SYMBOL(generic_file_aio_write);
 

