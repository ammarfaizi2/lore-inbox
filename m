Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265090AbUFHLrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265090AbUFHLrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbUFHLqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:46:05 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:42943 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265051AbUFHLpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:45:11 -0400
Date: Tue, 8 Jun 2004 12:45:11 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       Pawel Kot <pkot@bezsensu.pl>
Subject: Re: [2.6.7-BK] NTFS 2.1.13 patch 3/8
In-Reply-To: <Pine.SOL.4.58.0406081244330.21854@orange.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0406081244580.21854@orange.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0406081236450.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081243060.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081244330.21854@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 3 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/05/28 1.1738)
   NTFS: Implement ->write_inode (fs/ntfs/inode.c::ntfs_write_inode()) for the
         ntfs super operations.  This gives us inode writing via the VFS inode
         dirty code paths.  Note:  Access time updates are not implemented yet.

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
--- a/fs/ntfs/ChangeLog	2004-06-08 12:22:10 +01:00
+++ b/fs/ntfs/ChangeLog	2004-06-08 12:22:10 +01:00
@@ -11,7 +11,10 @@
 	  pages as nothing can dirty a page other than ourselves. Should this
 	  change, we will really need to roll our own ->set_page_dirty().
 	- Implement sops->dirty_inode() to implement {a,m,c}time updates and
-	  such things.
+	  such things.  This should probably just flag the ntfs inode such that
+	  sops->write_inode(), i.e. ntfs_write_inode(), will copy the times
+	  when it is invoked rather than having to update the mft record
+	  every time.
 	- Implement sops->write_inode().
 	- In between ntfs_prepare/commit_write, need exclusion between
 	  simultaneous file extensions. Need perhaps an NInoResizeUnderway()
@@ -41,6 +44,9 @@
 	  I will wait for people to hit each one and only then implement it.
 	- Commit open system inodes at umount time.  This should make it
 	  virtually impossible for sync_mft_mirror_umount() to ever be needed.
+	- Implement ->write_inode (fs/ntfs/inode.c::ntfs_write_inode()) for the
+	  ntfs super operations.  This gives us inode writing via the VFS inode
+	  dirty code paths.  Note:  Access time updates are not implemented yet.

 2.1.12 - Fix the second fix to the decompression engine and some cleanups.

diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-06-08 12:22:10 +01:00
+++ b/fs/ntfs/inode.c	2004-06-08 12:22:10 +01:00
@@ -1960,49 +1960,134 @@
 	return err;
 }

+/**
+ * ntfs_write_inode - write out a dirty inode
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
+ */
 void ntfs_write_inode(struct inode *vi, int sync)
 {
 	ntfs_inode *ni = NTFS_I(vi);
+#if 0
+	attr_search_context *ctx;
+#endif
+	MFT_RECORD *m;
+	int err = 0;

 	ntfs_debug("Entering for %sinode 0x%lx.", NInoAttr(ni) ? "attr " : "",
 			vi->i_ino);
-
 	/*
 	 * Dirty attribute inodes are written via their real inodes so just
-	 * clean them here.
+	 * clean them here.  TODO:  Take care of access time updates.
 	 */
 	if (NInoAttr(ni)) {
 		NInoClearDirty(ni);
 		return;
 	}
-
-	/* Write this base mft record. */
-	if (NInoDirty(ni)) {
-		ntfs_warning(vi->i_sb, "Cleaning dirty inode 0x%lx without "
-				"writing to disk as this is not yet "
-				"implemented.", vi->i_ino);
-		NInoClearDirty(ni);
+	/* Map, pin, and lock the mft record belonging to the inode. */
+	m = map_mft_record(ni);
+	if (unlikely(IS_ERR(m))) {
+		err = PTR_ERR(m);
+		goto err_out;
 	}
-
+#if 0
+	/* Obtain the standard information attribute. */
+	ctx = get_attr_search_ctx(ni, m);
+	if (unlikely(!ctx)) {
+		err = -ENOMEM;
+		goto unm_err_out;
+	}
+	if (unlikely(!lookup_attr(AT_STANDARD_INFORMATION, NULL, 0,
+			IGNORE_CASE, 0, NULL, 0, ctx))) {
+		put_attr_search_ctx(ctx);
+		err = -ENOENT;
+		goto unm_err_out;
+	}
+	// TODO:  Update the access times in the standard information attribute
+	// which is now in ctx->attr.
+	// - Probably want to have use sops->dirty_inode() to set a flag that
+	//   we need to update the times here rather than having to blindly do
+	//   it every time.  Or even don't do it here at all and do it in
+	//   sops->dirty_inode() instead.  Problem with this would be that
+	//   sops->dirty_inode() must be atomic under certain circumstances
+	//   and mapping mft records and such like is not atomic.
+	// - For atime updates also need to check whether they are enabled in
+	//   the superblock flags.
+	ntfs_warning(vi->i_sb, "Access time updates not implement yet.");
+	/*
+	 * We just modified the mft record containing the standard information
+	 * attribute.  So need to mark the mft record dirty, too, but we do it
+	 * manually so that mark_inode_dirty() is not called again.
+	 * TODO:  Only do this if there was a change in any of the times!
+	 */
+	if (!NInoTestSetDirty(ctx->ntfs_ino))
+		__set_page_dirty_nobuffers(ctx->ntfs_ino->page);
+	put_attr_search_ctx(ctx);
+#endif
+	/* Write this base mft record. */
+	if (NInoDirty(ni))
+		err = write_mft_record(ni, m, sync);
 	/* Write all attached extent mft records. */
 	down(&ni->extent_lock);
 	if (ni->nr_extents > 0) {
-		int i;
 		ntfs_inode **extent_nis = ni->ext.extent_ntfs_inos;
+		int i;

+		ntfs_debug("Writing %i extent inodes.", ni->nr_extents);
 		for (i = 0; i < ni->nr_extents; i++) {
 			ntfs_inode *tni = extent_nis[i];

 			if (NInoDirty(tni)) {
-				ntfs_warning(vi->i_sb, "Cleaning dirty extent "
-						"inode 0x%lx without writing "
-						"to disk as this is not yet "
-						"implemented.", tni->mft_no);
-				NInoClearDirty(tni);
+				MFT_RECORD *tm = map_mft_record(tni);
+				int ret;
+
+				if (unlikely(IS_ERR(tm))) {
+					if (!err || err == -ENOMEM)
+						err = PTR_ERR(tm);
+					continue;
+				}
+				ret = write_mft_record(tni, tm, sync);
+				unmap_mft_record(tni);
+				if (unlikely(ret)) {
+					if (!err || err == -ENOMEM)
+						err = ret;
+				}
 			}
 		}
 	}
 	up(&ni->extent_lock);
+	unmap_mft_record(ni);
+	if (unlikely(err))
+		goto err_out;
+	ntfs_debug("Done.");
+	return;
+#if 0
+unm_err_out:
+	unmap_mft_record(ni);
+#endif
+err_out:
+	if (err == -ENOMEM) {
+		ntfs_warning(vi->i_sb, "Not enough memory to write inode.  "
+				"Marking the inode dirty again, so the VFS "
+				"retries later.");
+		mark_inode_dirty(vi);
+	} else {
+		ntfs_error(vi->i_sb, "Failed (error code %i):  Marking inode "
+				"as bad.  You should run chkdsk.", -err);
+		make_bad_inode(vi);
+	}
+	return;
 }

 #endif /* NTFS_RW */
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-06-08 12:22:10 +01:00
+++ b/fs/ntfs/super.c	2004-06-08 12:22:10 +01:00
@@ -1664,8 +1664,8 @@
 #ifdef NTFS_RW
 	//.dirty_inode	= NULL,			/* VFS: Called from
 	//					   __mark_inode_dirty(). */
-	//.write_inode	= NULL,			/* VFS: Write dirty inode to
-	//					   disk. */
+	.write_inode	= ntfs_write_inode,	/* VFS: Write dirty inode to
+						   disk. */
 	//.drop_inode	= NULL,			/* VFS: Called just after the
 	//					   inode reference count has
 	//					   been decreased to zero.
