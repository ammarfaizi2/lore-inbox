Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVCETDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVCETDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVCETDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:03:25 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:25604 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261288AbVCESli
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:41:38 -0500
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/29] fat: fix writev(), add aio support
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:41:31 +0900
In-Reply-To: <87ll92rl6a.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message
 of "Sun, 06 Mar 2005 03:40:13 +0900")
Message-ID: <87hdjqrl44.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes vectored write support on fat to do the nessecary
non-standard action done in write() aswell.

Also adds aio support and makes read/write wrappers around the aio
version.

 From: Christoph Hellwig <hch@lst.de>

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/file.c |   31 ++++++++++++++++++++++++-------
 1 files changed, 24 insertions(+), 7 deletions(-)

diff -puN fs/fat/file.c~fat_support-aio fs/fat/file.c
--- linux-2.6.11/fs/fat/file.c~fat_support-aio	2005-03-06 02:17:05.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/file.c	2005-03-06 02:35:38.000000000 +0900
@@ -12,13 +12,28 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 
-static ssize_t fat_file_write(struct file *filp, const char __user *buf,
-			      size_t count, loff_t *ppos)
+static ssize_t fat_file_aio_write(struct kiocb *iocb, const char __user *buf,
+				  size_t count, loff_t pos)
+{
+	struct inode *inode = iocb->ki_filp->f_dentry->d_inode;
+	int retval;
+
+	retval = generic_file_aio_write(iocb, buf, count, pos);
+	if (retval > 0) {
+		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
+		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
+		mark_inode_dirty(inode);
+	}
+	return retval;
+}
+
+static ssize_t fat_file_writev(struct file *filp, const struct iovec *iov,
+			       unsigned long nr_segs, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	int retval;
 
-	retval = generic_file_write(filp, buf, count, ppos);
+	retval = generic_file_writev(filp, iov, nr_segs, ppos);
 	if (retval > 0) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
@@ -29,12 +44,14 @@ static ssize_t fat_file_write(struct fil
 
 struct file_operations fat_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= fat_file_write,
+	.read		= do_sync_read,
+	.write		= do_sync_write,
+	.readv		= generic_file_readv,
+	.writev		= fat_file_writev,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= fat_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.fsync		= file_fsync,
-	.readv		= generic_file_readv,
-	.writev		= generic_file_writev,
 	.sendfile	= generic_file_sendfile,
 };
 
_
