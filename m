Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267646AbUHWK3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267646AbUHWK3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267638AbUHWK3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:29:36 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:51873 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267646AbUHWK3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:29:17 -0400
Date: Mon, 23 Aug 2004 11:29:15 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 2/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/07/08 1.1784.14.2)
   NTFS: Change ntfs_write_inode to return 0 on success and -errno on error
         and create a wrapper ntfs_write_inode_vfs that does not have a
         return value and use the wrapper for the VFS super_operations
         write_inode function.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-08-18 20:49:49 +01:00
+++ b/fs/ntfs/inode.c	2004-08-18 20:49:49 +01:00
@@ -2314,8 +2314,10 @@
  * marking the page (and in this case mft record) dirty but we do not implement
  * this yet as write_mft_record() largely ignores the @sync parameter and
  * always performs synchronous writes.
+ *
+ * Return 0 on success and -errno on error.
  */
-void ntfs_write_inode(struct inode *vi, int sync)
+int ntfs_write_inode(struct inode *vi, int sync)
 {
 	ntfs_inode *ni = NTFS_I(vi);
 #if 0
@@ -2332,7 +2334,7 @@
 	 */
 	if (NInoAttr(ni)) {
 		NInoClearDirty(ni);
-		return;
+		return 0;
 	}
 	/* Map, pin, and lock the mft record belonging to the inode. */
 	m = map_mft_record(ni);
@@ -2410,7 +2412,7 @@
 	if (unlikely(err))
 		goto err_out;
 	ntfs_debug("Done.");
-	return;
+	return 0;
 #if 0
 unm_err_out:
 	unmap_mft_record(ni);
@@ -2426,7 +2428,31 @@
 				"as bad.  You should run chkdsk.", -err);
 		make_bad_inode(vi);
 	}
-	return;
+	return err;
+}
+
+/**
+ * ntfs_write_inode_vfs - write out a dirty inode
+ * @vi:		inode to write out
+ * @sync:	if true, write out synchronously
+ *
+ * Write out a dirty inode to disk including any extent inodes if present.
+ *
+ * If @sync is true, commit the inode to disk and wait for io completion.  This
+ * is done using write_mft_record().
+ *
+ * If @sync is false, just schedule the write to happen but do not wait for i/o
+ * completion.  In 2.6 kernels, scheduling usually happens just by virtue of
+ * marking the page (and in this case mft record) dirty but we do not implement
+ * this yet as write_mft_record() largely ignores the @sync parameter and
+ * always performs synchronous writes.
+ *
+ * This functions does not have a return value which is the required behaviour
+ * for the VFS super_operations ->dirty_inode function.
+ */
+void ntfs_write_inode_vfs(struct inode *vi, int sync)
+{
+	ntfs_write_inode(vi, sync);
 }
 
 #endif /* NTFS_RW */
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	2004-08-18 20:49:49 +01:00
+++ b/fs/ntfs/inode.h	2004-08-18 20:49:49 +01:00
@@ -285,7 +285,8 @@
 
 extern int ntfs_setattr(struct dentry *dentry, struct iattr *attr);
 
-extern void ntfs_write_inode(struct inode *vi, int sync);
+extern int ntfs_write_inode(struct inode *vi, int sync);
+extern void ntfs_write_inode_vfs(struct inode *vi, int sync);
 
 static inline void ntfs_commit_inode(struct inode *vi)
 {
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-08-18 20:49:49 +01:00
+++ b/fs/ntfs/super.c	2004-08-18 20:49:49 +01:00
@@ -2050,7 +2050,7 @@
 #ifdef NTFS_RW
 	//.dirty_inode	= NULL,			/* VFS: Called from
 	//					   __mark_inode_dirty(). */
-	.write_inode	= ntfs_write_inode,	/* VFS: Write dirty inode to
+	.write_inode	= ntfs_write_inode_vfs,	/* VFS: Write dirty inode to
 						   disk. */
 	//.drop_inode	= NULL,			/* VFS: Called just after the
 	//					   inode reference count has
