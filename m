Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUHWKde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUHWKde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUHWKde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:33:34 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:62152 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267638AbUHWK3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:29:37 -0400
Date: Mon, 23 Aug 2004 11:29:34 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231129180.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 3/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/07/08 1.1784.14.3)
   NTFS: Implement fsync, fdatasync, and msync both for files (fs/ntfs/file.c)
         and directories (fs/ntfs/dir.c).
   
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
--- a/fs/ntfs/ChangeLog	2004-08-18 20:49:53 +01:00
+++ b/fs/ntfs/ChangeLog	2004-08-18 20:49:53 +01:00
@@ -31,6 +31,8 @@
 	- Add support for readv/writev and aio_read/aio_write (fs/ntfs/file.c).
 	  This is done by setting the appropriate file operations pointers to
 	  the generic helper functions provided by mm/filemap.c.
+	- Implement fsync, fdatasync, and msync both for files (fs/ntfs/file.c)
+	  and directories (fs/ntfs/dir.c).
 
 2.1.15 - Invalidate quotas when (re)mounting read-write.
 
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	2004-08-18 20:49:53 +01:00
+++ b/fs/ntfs/dir.c	2004-08-18 20:49:53 +01:00
@@ -1495,10 +1495,69 @@
 	return 0;
 }
 
+#ifdef NTFS_RW
+
+/**
+ * ntfs_dir_fsync - sync a directory to disk
+ * @filp:	directory to be synced
+ * @dentry:	dentry describing the directory to sync
+ * @datasync:	if non-zero only flush user data and not metadata
+ *
+ * Data integrity sync of a directory to disk.  Used for fsync, fdatasync, and
+ * msync system calls.  This function is based on file.c::ntfs_file_fsync().
+ *
+ * Write the mft record and all associated extent mft records as well as the
+ * $INDEX_ALLOCATION and $BITMAP attributes and then sync the block device.
+ *
+ * If @datasync is true, we do not wait on the inode(s) to be written out
+ * but we always wait on the page cache pages to be written out.
+ *
+ * Note: In the past @filp could be NULL so we ignore it as we don't need it
+ * anyway.
+ *
+ * Locking: Caller must hold i_sem on the inode.
+ *
+ * TODO: We should probably also write all attribute/index inodes associated
+ * with this inode but since we have no simple way of getting to them we ignore
+ * this problem for now.  We do write the $BITMAP attribute if it is present
+ * which is the important one for a directory so things are not too bad.
+ */
+static int ntfs_dir_fsync(struct file *filp, struct dentry *dentry,
+		int datasync)
+{
+	struct inode *vi = dentry->d_inode;
+	ntfs_inode *ni = NTFS_I(vi);
+	int err, ret;
+
+	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
+	BUG_ON(!S_ISDIR(vi->i_mode));
+	if (NInoIndexAllocPresent(ni) && ni->itype.index.bmp_ino)
+		write_inode_now(ni->itype.index.bmp_ino, !datasync);
+	ret = ntfs_write_inode(vi, 1);
+	write_inode_now(vi, !datasync);
+	err = sync_blockdev(vi->i_sb->s_bdev);
+	if (unlikely(err && !ret))
+		ret = err;
+	if (likely(!ret))
+		ntfs_debug("Done.");
+	else
+		ntfs_warning(vi->i_sb, "Failed to f%ssync inode 0x%lx.  Error "
+				"%u.", datasync ? "data" : "", vi->i_ino, -ret);
+	return ret;
+}
+
+#endif /* NTFS_RW */
+
 struct file_operations ntfs_dir_ops = {
 	.llseek		= generic_file_llseek,	/* Seek inside directory. */
 	.read		= generic_read_dir,	/* Return -EISDIR. */
 	.readdir	= ntfs_readdir,		/* Read directory contents. */
+#ifdef NTFS_RW
+	.fsync		= ntfs_dir_fsync,	/* Sync a directory to disk. */
+	/*.aio_fsync	= ,*/			/* Sync all outstanding async
+						   i/o operations on a kiocb. */
+#endif /* NTFS_RW */
+	/*.ioctl	= ,*/			/* Perform function on the
+						   mounted filesystem. */
 	.open		= ntfs_dir_open,	/* Open directory. */
 };
-
diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	2004-08-18 20:49:53 +01:00
+++ b/fs/ntfs/file.c	2004-08-18 20:49:53 +01:00
@@ -48,6 +48,60 @@
 	return generic_file_open(vi, filp);
 }
 
+#ifdef NTFS_RW
+
+/**
+ * ntfs_file_fsync - sync a file to disk
+ * @filp:	file to be synced
+ * @dentry:	dentry describing the file to sync
+ * @datasync:	if non-zero only flush user data and not metadata
+ *
+ * Data integrity sync of a file to disk.  Used for fsync, fdatasync, and msync
+ * system calls.  This function is inspired by fs/buffer.c::file_fsync().
+ *
+ * If @datasync is false, write the mft record and all associated extent mft
+ * records as well as the $DATA attribute and then sync the block device.
+ *
+ * If @datasync is true and the attribute is non-resident, we skip the writing
+ * of the mft record and all associated extent mft records (this might still
+ * happen due to the write_inode_now() call).
+ *
+ * Also, if @datasync is true, we do not wait on the inode to be written out
+ * but we always wait on the page cache pages to be written out.
+ *
+ * Note: In the past @filp could be NULL so we ignore it as we don't need it
+ * anyway.
+ *
+ * Locking: Caller must hold i_sem on the inode.
+ *
+ * TODO: We should probably also write all attribute/index inodes associated
+ * with this inode but since we have no simple way of getting to them we ignore
+ * this problem for now.
+ */
+static int ntfs_file_fsync(struct file *filp, struct dentry *dentry,
+		int datasync)
+{
+	struct inode *vi = dentry->d_inode;
+	int err, ret = 0;
+
+	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
+	BUG_ON(S_ISDIR(vi->i_mode));
+	if (!datasync || !NInoNonResident(NTFS_I(vi)))
+		ret = ntfs_write_inode(vi, 1);
+	write_inode_now(vi, !datasync);
+	err = sync_blockdev(vi->i_sb->s_bdev);
+	if (unlikely(err && !ret))
+		ret = err;
+	if (likely(!ret))
+		ntfs_debug("Done.");
+	else
+		ntfs_warning(vi->i_sb, "Failed to f%ssync inode 0x%lx.  Error "
+				"%u.", datasync ? "data" : "", vi->i_ino, -ret);
+	return ret;
+}
+
+#endif /* NTFS_RW */
+
 struct file_operations ntfs_file_ops = {
 	.llseek		= generic_file_llseek,	  /* Seek inside file. */
 	.read		= generic_file_read,	  /* Read from file. */
@@ -63,9 +117,7 @@
 						     how to use this to discard
 						     preallocated space for
 						     write opened files. */
-	/*.fsync	= ,*/			  /* Sync a file to disk.  See
-						     fs/buffer.c::sys_fsync()
-						     and file_fsync(). */
+	.fsync		= ntfs_file_fsync,	  /* Sync a file to disk. */
 	/*.aio_fsync	= ,*/			  /* Sync all outstanding async
 						     i/o operations on a
 						     kiocb. */
