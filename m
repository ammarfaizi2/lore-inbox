Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbUKJNsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUKJNsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 08:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUKJNrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:47:40 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:44160 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261890AbUKJNor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:44:47 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 4/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRslt-0006N4-55@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:44:25 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 4/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/25 1.2026.1.20)
   NTFS: - Change fs/ntfs/inode.c::ntfs_truncate() to return an error code
           instead of void and provide a helper ntfs_truncate_vfs() for the
           vfs ->truncate method.
         - Add a new ntfs inode flag NInoTruncateFailed() and modify
           fs/ntfs/inode.c::ntfs_truncate() to set and clear it appropriately.
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:44:28 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:44:28 +00:00
@@ -24,6 +24,11 @@
 2.1.22-WIP
 
 	- Improve error handling in fs/ntfs/inode.c::ntfs_truncate().
+	- Change fs/ntfs/inode.c::ntfs_truncate() to return an error code
+	  instead of void and provide a helper ntfs_truncate_vfs() for the
+	  vfs ->truncate method.
+	- Add a new ntfs inode flag NInoTruncateFailed() and modify
+	  fs/ntfs/inode.c::ntfs_truncate() to set and clear it appropriately.
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	2004-11-10 13:44:28 +00:00
+++ b/fs/ntfs/file.c	2004-11-10 13:44:28 +00:00
@@ -145,7 +145,7 @@
 
 struct inode_operations ntfs_file_inode_ops = {
 #ifdef NTFS_RW
-	.truncate	= ntfs_truncate,
+	.truncate	= ntfs_truncate_vfs,
 	.setattr	= ntfs_setattr,
 #endif /* NTFS_RW */
 };
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-11-10 13:44:28 +00:00
+++ b/fs/ntfs/inode.c	2004-11-10 13:44:28 +00:00
@@ -2263,13 +2263,15 @@
  * This implies for us that @vi is a file inode rather than a directory, index,
  * or attribute inode as well as that @vi is a base inode.
  *
+ * Returns 0 on success or -errno on error.
+ *
  * Called with ->i_sem held.  In all but one case ->i_alloc_sem is held for
  * writing.  The only case where ->i_alloc_sem is not held is
  * mm/filemap.c::generic_file_buffered_write() where vmtruncate() is called
  * with the current i_size as the offset which means that it is a noop as far
  * as ntfs_truncate() is concerned.
  */
-void ntfs_truncate(struct inode *vi)
+int ntfs_truncate(struct inode *vi)
 {
 	ntfs_inode *ni = NTFS_I(vi);
 	ntfs_volume *vol = ni->vol;
@@ -2323,7 +2325,8 @@
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(ni);
 	ntfs_debug("Done.");
-	return;
+	NInoClearTruncateFailed(ni);
+	return 0;
 err_out:
 	if (err != -ENOMEM) {
 		NVolSetErrors(vol);
@@ -2333,7 +2336,20 @@
 		ntfs_attr_put_search_ctx(ctx);
 	if (m)
 		unmap_mft_record(ni);
-	return;
+	NInoSetTruncateFailed(ni);
+	return err;
+}
+
+/**
+ * ntfs_truncate_vfs - wrapper for ntfs_truncate() that has no return value
+ * @vi:		inode for which the i_size was changed
+ *
+ * Wrapper for ntfs_truncate() that has no return value.
+ *
+ * See ntfs_truncate() description above for details.
+ */
+void ntfs_truncate_vfs(struct inode *vi) {
+	ntfs_truncate(vi);
 }
 
 /**
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	2004-11-10 13:44:28 +00:00
+++ b/fs/ntfs/inode.h	2004-11-10 13:44:28 +00:00
@@ -165,6 +165,7 @@
 	NI_Sparse,		/* 1: Unnamed data attr is sparse (f).
 				   1: Create sparse files by default (d).
 				   1: Attribute is sparse (a). */
+	NI_TruncateFailed,	/* 1: Last ntfs_truncate() call failed. */
 } ntfs_inode_state_bits;
 
 /*
@@ -216,6 +217,7 @@
 NINO_FNS(Compressed)
 NINO_FNS(Encrypted)
 NINO_FNS(Sparse)
+NINO_FNS(TruncateFailed)
 
 /*
  * The full structure containing a ntfs_inode and a vfs struct inode. Used for
@@ -300,7 +302,8 @@
 
 #ifdef NTFS_RW
 
-extern void ntfs_truncate(struct inode *vi);
+extern int ntfs_truncate(struct inode *vi);
+extern void ntfs_truncate_vfs(struct inode *vi);
 
 extern int ntfs_setattr(struct dentry *dentry, struct iattr *attr);
 
