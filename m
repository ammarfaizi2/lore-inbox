Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265812AbUEZVUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUEZVUi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 17:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265813AbUEZVUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 17:20:38 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:30615 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265812AbUEZVT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 17:19:58 -0400
Date: Wed, 26 May 2004 22:19:57 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [2.6.7-rc1-bk] NTFS: 2.1.12 release - patch 2/3
In-Reply-To: <Pine.SOL.4.58.0405262216460.15648@orange.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0405262217590.15648@orange.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0405262214280.15648@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0405262216460.15648@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 2 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/05/25 1.1731)
   NTFS: Cleanup dirty ntfs inode handling (fs/ntfs/inode.[hc]) which also
         includes an adapted ntfs_commit_inode() and an implementation of
         ntfs_write_inode() which for now just cleans dirty inodes without
         writing them (it does emit a warning that this is happening).

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-05-26 22:10:14 +01:00
+++ b/fs/ntfs/ChangeLog	2004-05-26 22:10:14 +01:00
@@ -32,6 +32,10 @@
 	  make sense with mst protected data and were they to write anything to
 	  such an attribute they would cause data corruption so we provide
 	  ntfs_mst_aops which does not have any write related operations set.
+	- Cleanup dirty ntfs inode handling (fs/ntfs/inode.[hc]) which also
+	  includes an adapted ntfs_commit_inode() and an implementation of
+	  ntfs_write_inode() which for now just cleans dirty inodes without
+	  writing them (it does emit a warning that this is happening).

 2.1.11 - Driver internal cleanups.

diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	2004-05-26 22:10:14 +01:00
+++ b/fs/ntfs/dir.c	2004-05-26 22:10:14 +01:00
@@ -1196,7 +1196,7 @@
 	ia_mapping = vdir->i_mapping;
 	bmp_vi = ndir->itype.index.bmp_ino;
 	if (unlikely(!bmp_vi)) {
-		ntfs_debug("Inode %lu, regetting index bitmap.", vdir->i_ino);
+		ntfs_debug("Inode 0x%lx, regetting index bitmap.", vdir->i_ino);
 		bmp_vi = ntfs_attr_iget(vdir, AT_BITMAP, I30, 4);
 		if (unlikely(IS_ERR(bmp_vi))) {
 			ntfs_error(sb, "Failed to get bitmap attribute.");
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-05-26 22:10:14 +01:00
+++ b/fs/ntfs/inode.c	2004-05-26 22:10:14 +01:00
@@ -1342,7 +1342,7 @@
 	ni->name_len = 0;

 	/*
-	 * This sets up our little cheat allowing us to reuse the async io
+	 * This sets up our little cheat allowing us to reuse the async read io
 	 * completion handler for directories.
 	 */
 	ni->itype.index.block_size = vol->mft_record_size;
@@ -1706,18 +1706,6 @@
 }

 /**
- * ntfs_commit_inode - write out a dirty inode
- * @ni:		inode to write out
- *
- */
-int ntfs_commit_inode(ntfs_inode *ni)
-{
-	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
-	NInoClearDirty(ni);
-	return 0;
-}
-
-/**
  * ntfs_put_inode - handler for when the inode reference count is decremented
  * @vi:		vfs inode
  *
@@ -1745,34 +1733,6 @@

 void __ntfs_clear_inode(ntfs_inode *ni)
 {
-	int err;
-
-	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
-	if (NInoDirty(ni)) {
-		err = ntfs_commit_inode(ni);
-		if (err) {
-			ntfs_error(ni->vol->sb, "Failed to commit dirty "
-					"inode synchronously.");
-			// FIXME: Do something!!!
-		}
-	}
-	/* Synchronize with ntfs_commit_inode(). */
-	down(&ni->mrec_lock);
-	up(&ni->mrec_lock);
-	if (NInoDirty(ni)) {
-		ntfs_error(ni->vol->sb, "Failed to commit dirty inode "
-				"asynchronously.");
-		// FIXME: Do something!!!
-	}
-	/* No need to lock at this stage as no one else has a reference. */
-	if (ni->nr_extents > 0) {
-		int i;
-
-		// FIXME: Handle dirty case for each extent inode!
-		for (i = 0; i < ni->nr_extents; i++)
-			ntfs_clear_extent_inode(ni->ext.extent_ntfs_inos[i]);
-		kfree(ni->ext.extent_ntfs_inos);
-	}
 	/* Free all alocated memory. */
 	down_write(&ni->run_list.lock);
 	if (ni->run_list.rl) {
@@ -1802,6 +1762,20 @@

 void ntfs_clear_extent_inode(ntfs_inode *ni)
 {
+	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
+
+	BUG_ON(NInoAttr(ni));
+	BUG_ON(ni->nr_extents != -1);
+
+#ifdef NTFS_RW
+	if (NInoDirty(ni)) {
+		if (!is_bad_inode(VFS_I(ni->ext.base_ntfs_ino)))
+			ntfs_error(ni->vol->sb, "Clearing dirty extent inode!  "
+					"Losing data!  This is a BUG!!!");
+		// FIXME:  Do something!!!
+	}
+#endif /* NTFS_RW */
+
 	__ntfs_clear_inode(ni);

 	/* Bye, bye... */
@@ -1822,6 +1796,30 @@
 {
 	ntfs_inode *ni = NTFS_I(vi);

+#ifdef NTFS_RW
+	if (NInoDirty(ni)) {
+		BOOL was_bad = (is_bad_inode(vi));
+
+		/* Committing the inode also commits all extent inodes. */
+		ntfs_commit_inode(vi);
+
+		if (!was_bad && (is_bad_inode(vi) || NInoDirty(ni))) {
+			ntfs_error(vi->i_sb, "Failed to commit dirty inode "
+					"0x%lx.  Losing data!", vi->i_ino);
+			// FIXME:  Do something!!!
+		}
+	}
+#endif /* NTFS_RW */
+
+	/* No need to lock at this stage as no one else has a reference. */
+	if (ni->nr_extents > 0) {
+		int i;
+
+		for (i = 0; i < ni->nr_extents; i++)
+			ntfs_clear_extent_inode(ni->ext.extent_ntfs_inos[i]);
+		kfree(ni->ext.extent_ntfs_inos);
+	}
+
 	__ntfs_clear_inode(ni);

 	if (NInoAttr(ni)) {
@@ -1962,4 +1960,49 @@
 	return err;
 }

-#endif
+void ntfs_write_inode(struct inode *vi, int sync)
+{
+	ntfs_inode *ni = NTFS_I(vi);
+
+	ntfs_debug("Entering for %sinode 0x%lx.", NInoAttr(ni) ? "attr " : "",
+			vi->i_ino);
+
+	/*
+	 * Dirty attribute inodes are written via their real inodes so just
+	 * clean them here.
+	 */
+	if (NInoAttr(ni)) {
+		NInoClearDirty(ni);
+		return;
+	}
+
+	/* Write this base mft record. */
+	if (NInoDirty(ni)) {
+		ntfs_warning(vi->i_sb, "Cleaning dirty inode 0x%lx without "
+				"writing to disk as this is not yet "
+				"implemented.", vi->i_ino);
+		NInoClearDirty(ni);
+	}
+
+	/* Write all attached extent mft records. */
+	down(&ni->extent_lock);
+	if (ni->nr_extents > 0) {
+		int i;
+		ntfs_inode **extent_nis = ni->ext.extent_ntfs_inos;
+
+		for (i = 0; i < ni->nr_extents; i++) {
+			ntfs_inode *tni = extent_nis[i];
+
+			if (NInoDirty(tni)) {
+				ntfs_warning(vi->i_sb, "Cleaning dirty extent "
+						"inode 0x%lx without writing "
+						"to disk as this is not yet "
+						"implemented.", tni->mft_no);
+				NInoClearDirty(tni);
+			}
+		}
+	}
+	up(&ni->extent_lock);
+}
+
+#endif /* NTFS_RW */
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	2004-05-26 22:10:14 +01:00
+++ b/fs/ntfs/inode.h	2004-05-26 22:10:14 +01:00
@@ -281,6 +281,15 @@

 extern int ntfs_setattr(struct dentry *dentry, struct iattr *attr);

+extern void ntfs_write_inode(struct inode *vi, int sync);
+
+static inline void ntfs_commit_inode(struct inode *vi)
+{
+	if (!is_bad_inode(vi))
+		ntfs_write_inode(vi, 1);
+	return;
+}
+
 #endif /* NTFS_RW */

 #endif /* _LINUX_NTFS_INODE_H */
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-05-26 22:10:14 +01:00
+++ b/fs/ntfs/super.c	2004-05-26 22:10:14 +01:00
@@ -763,7 +763,7 @@
 	/* The $MFTMirr, like the $MFT is multi sector transfer protected. */
 	NInoSetMstProtected(tmp_ni);
 	/*
-	 * Set up our little cheat allowing us to reuse the async io
+	 * Set up our little cheat allowing us to reuse the async read io
 	 * completion handler for directories.
 	 */
 	tmp_ni->itype.index.block_size = vol->mft_record_size;
