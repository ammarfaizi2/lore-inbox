Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267635AbUHWK3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267635AbUHWK3R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUHWK3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:29:17 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:36815 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267635AbUHWK3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:29:05 -0400
Date: Mon, 23 Aug 2004 11:28:49 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 1/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/07/07 1.1784.14.1)
   NTFS: Add support for readv/writev and aio_read/aio_write.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-08-18 20:49:46 +01:00
+++ b/fs/ntfs/ChangeLog	2004-08-18 20:49:46 +01:00
@@ -26,6 +26,12 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
+2.1.16 - WIP.
+
+	- Add support for readv/writev and aio_read/aio_write (fs/ntfs/file.c).
+	  This is done by setting the appropriate file operations pointers to
+	  the generic helper functions provided by mm/filemap.c.
+
 2.1.15 - Invalidate quotas when (re)mounting read-write.
 
 	- Add new element itype.index.collation_rule to the ntfs inode
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-08-18 20:49:46 +01:00
+++ b/fs/ntfs/Makefile	2004-08-18 20:49:46 +01:00
@@ -6,7 +6,7 @@
 	     index.o inode.o mft.o mst.o namei.o super.o sysctl.o unistr.o \
 	     upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.15\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.16-WIP\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	2004-08-18 20:49:46 +01:00
+++ b/fs/ntfs/file.c	2004-08-18 20:49:46 +01:00
@@ -49,25 +49,48 @@
 }
 
 struct file_operations ntfs_file_ops = {
-	.llseek		= generic_file_llseek,	/* Seek inside file. */
-	.read		= generic_file_read,	/* Read from file. */
+	.llseek		= generic_file_llseek,	  /* Seek inside file. */
+	.read		= generic_file_read,	  /* Read from file. */
+	.aio_read	= generic_file_aio_read,  /* Async read from file. */
+	.readv		= generic_file_readv,	  /* Read from file. */
 #ifdef NTFS_RW
-	.write		= generic_file_write,	/* Write to a file. */
-#endif
-	.mmap		= generic_file_mmap,	/* Mmap file. */
-	.sendfile	= generic_file_sendfile,/* Zero-copy data send with the
-						   data source being on the
-						   ntfs partition. We don't
-						   need to care about the data
-						   destination. */
-	.open		= ntfs_file_open,	/* Open file. */
+	.write		= generic_file_write,	  /* Write to file. */
+	.aio_write	= generic_file_aio_write, /* Async write to file. */
+	.writev		= generic_file_writev,	  /* Write to file. */
+	/*.release	= ,*/			  /* Last file is closed.  See
+						     fs/ext2/file.c::
+						     ext2_release_file() for
+						     how to use this to discard
+						     preallocated space for
+						     write opened files. */
+	/*.fsync	= ,*/			  /* Sync a file to disk.  See
+						     fs/buffer.c::sys_fsync()
+						     and file_fsync(). */
+	/*.aio_fsync	= ,*/			  /* Sync all outstanding async
+						     i/o operations on a
+						     kiocb. */
+#endif /* NTFS_RW */
+	/*.ioctl	= ,*/			  /* Perform function on the
+						     mounted filesystem. */
+	.mmap		= generic_file_mmap,	  /* Mmap file. */
+	.open		= ntfs_file_open,	  /* Open file. */
+	.sendfile	= generic_file_sendfile,  /* Zero-copy data send with
+						     the data source being on
+						     the ntfs partition.  We
+						     do not need to care about
+						     the data destination. */
+	/*.sendpage	= ,*/			  /* Zero-copy data send with
+						     the data destination being
+						     on the ntfs partition.  We
+						     do not need to care about
+						     the data source. */
 };
 
 struct inode_operations ntfs_file_inode_ops = {
 #ifdef NTFS_RW
 	.truncate	= ntfs_truncate,
 	.setattr	= ntfs_setattr,
-#endif
+#endif /* NTFS_RW */
 };
 
 struct file_operations ntfs_empty_file_ops = {};
