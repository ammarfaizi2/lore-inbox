Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWA3Q4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWA3Q4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWA3Q4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:56:37 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:7582 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964779AbWA3Q4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:56:36 -0500
Subject: [PATCH] generic_file_write_nolock cleanup
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>, hch@lst.de
Content-Type: multipart/mixed; boundary="=-UtOyNMJSzm3DOT8lHJMt"
Date: Mon, 30 Jan 2006 08:56:05 -0800
Message-Id: <1138640165.28382.3.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UtOyNMJSzm3DOT8lHJMt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

generic_file_write_nolock() and __generic_file_write_nolock() seems
to be doing exactly same thing. Why do we have 2 of these ? 
Can we kill __generic_file_write_nolock() ?

Here is the patch.

Thanks,
Badari



--=-UtOyNMJSzm3DOT8lHJMt
Content-Disposition: attachment; filename=generic_file_write_nolock-cleanup.patch
Content-Type: text/x-patch; name=generic_file_write_nolock-cleanup.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
--- linux.org/mm/filemap.c	2006-01-16 23:44:47.000000000 -0800
+++ linux/mm/filemap.c	2006-01-30 08:51:04.000000000 -0800
@@ -2155,20 +2155,6 @@ generic_file_aio_write_nolock(struct kio
 	return ret;
 }
 
-static ssize_t
-__generic_file_write_nolock(struct file *file, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos)
-{
-	struct kiocb kiocb;
-	ssize_t ret;
-
-	init_sync_kiocb(&kiocb, file);
-	ret = __generic_file_aio_write_nolock(&kiocb, iov, nr_segs, ppos);
-	if (ret == -EIOCBQUEUED)
-		ret = wait_on_sync_kiocb(&kiocb);
-	return ret;
-}
-
 ssize_t
 generic_file_write_nolock(struct file *file, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
@@ -2222,7 +2208,7 @@ ssize_t generic_file_write(struct file *
 					.iov_len = count };
 
 	mutex_lock(&inode->i_mutex);
-	ret = __generic_file_write_nolock(file, &local_iov, 1, ppos);
+	ret = generic_file_write_nolock(file, &local_iov, 1, ppos);
 	mutex_unlock(&inode->i_mutex);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
@@ -2258,7 +2244,7 @@ ssize_t generic_file_writev(struct file 
 	ssize_t ret;
 
 	mutex_lock(&inode->i_mutex);
-	ret = __generic_file_write_nolock(file, iov, nr_segs, ppos);
+	ret = generic_file_write_nolock(file, iov, nr_segs, ppos);
 	mutex_unlock(&inode->i_mutex);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {

--=-UtOyNMJSzm3DOT8lHJMt--

