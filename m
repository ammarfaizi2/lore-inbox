Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285287AbRLNBMn>; Thu, 13 Dec 2001 20:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285288AbRLNBMd>; Thu, 13 Dec 2001 20:12:33 -0500
Received: from suntan.tandem.com ([192.216.221.8]:12685 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S285287AbRLNBMS>; Thu, 13 Dec 2001 20:12:18 -0500
From: dzafman@kahuna.cag.cpqcorp.net
Message-Id: <200112140057.fBE0vDm05648@kahuna.cag.cpqcorp.net>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Date: Thu, 13 Dec 2001 16:51 PST
Subject: NFS client llseek
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I noticed that generic_file_llseek looks at i_size without performing a
revalidate, so I propose the following patch for NFS client.  It applies to
both 2.4.16 and 2.5.0 kernels.


diff -Naur linux-2.4.16.orig/fs/nfs/file.c linux-2.4.16/fs/nfs/file.c
--- linux-2.4.16.orig/fs/nfs/file.c	Sun Sep 23 09:48:01 2001
+++ linux-2.4.16/fs/nfs/file.c	Thu Dec 13 15:35:05 2001
@@ -39,9 +39,10 @@
 static ssize_t nfs_file_write(struct file *, const char *, size_t, loff_t *);
 static int  nfs_file_flush(struct file *);
 static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
+static loff_t nfs_file_llseek(struct file *, loff_t, int origin);
 
 struct file_operations nfs_file_operations = {
-	llseek:		generic_file_llseek,
+	llseek:		nfs_file_llseek,
 	read:		nfs_file_read,
 	write:		nfs_file_write,
 	mmap:		nfs_file_mmap,
@@ -142,6 +143,24 @@
 	}
 	unlock_kernel();
 	return status;
+}
+
+static loff_t
+nfs_file_llseek(struct file *file, loff_t offset, int origin)
+{
+	struct dentry * dentry = file->f_dentry;
+	struct inode * inode = dentry->d_inode;
+	loff_t result;
+
+	/*
+	 * Make sure inode fields are up-to-date, since generic_file_llseek()
+	 * might look at anything in the inode.  Currently, i_size may be
+	 * used.
+	 */
+	result = nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	if (!result)
+		result = generic_file_llseek(file, offset, origin);
+	return result;
 }
 
 /*
