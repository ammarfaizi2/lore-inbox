Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283672AbRLNVY2>; Fri, 14 Dec 2001 16:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283724AbRLNVYR>; Fri, 14 Dec 2001 16:24:17 -0500
Received: from suntan.tandem.com ([192.216.221.8]:25832 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S283672AbRLNVYJ>; Fri, 14 Dec 2001 16:24:09 -0500
From: dzafman@kahuna.cag.cpqcorp.net
Message-Id: <200112142109.fBEL90123231@kahuna.cag.cpqcorp.net>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Date: Fri, 14 Dec 2001 12:45 PST
Subject: re: NFS client llseek
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trond Myklebust wrote:

>    Just one comment: Isn't it easier to do this in generic_file_llseek()
>    itself using inode->i_op->revalidate()? That would make it work for
>    coda and smbfs too...
>
>    Cheers,
>       Trond

Yes, you are right.  I've attached a patch which does the revalidate in
both default_llseek() and generic_file_llseek().  Also, it only happens
if i_size is going to be used.  This makes NFS client, smbfs, opengfs, and coda
work right, among others.  I copied do_revalidate() from fs/stat.c.  It would be
nice if it was in a header file instead.

By the way, we are looking at the challenges of integrating a fully coherent
distributed/cluster filesystem into the Linux filesystem architecture.

--- linux-2.4.16.orig/fs/read_write.c	Fri Dec 14 12:06:44 2001
+++ linux-2.4.16/fs/read_write.c	Fri Dec 14 12:54:02 2001
@@ -20,6 +20,19 @@
 	mmap:		generic_file_mmap,
 };
 
+/*
+ * Revalidate the inode. This is required for proper NFS attribute caching.
+ * ARG! Copied from fs/stat.c   (move to a header file)
+ */
+static __inline__ int
+do_revalidate(struct dentry *dentry)
+{
+	struct inode * inode = dentry->d_inode;
+	if (inode->i_op && inode->i_op->revalidate)
+		return inode->i_op->revalidate(dentry);
+	return 0;
+}
+
 ssize_t generic_read_dir(struct file *filp, char *buf, size_t siz, loff_t *ppos)
 {
 	return -EISDIR;
@@ -31,6 +44,8 @@
 
 	switch (origin) {
 		case 2:
+			if ((retval = do_revalidate(file->f_dentry)) < 0)
+				return retval;
 			offset += file->f_dentry->d_inode->i_size;
 			break;
 		case 1:
@@ -59,6 +74,8 @@
 
 	switch (origin) {
 		case 2:
+			if ((retval = do_revalidate(file->f_dentry)) < 0)
+				return retval;
 			offset += file->f_dentry->d_inode->i_size;
 			break;
 		case 1:
