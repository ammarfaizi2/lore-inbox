Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265054AbUFHLtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbUFHLtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbUFHLtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:49:42 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:47039 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265054AbUFHLp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:45:28 -0400
Date: Tue, 8 Jun 2004 12:45:27 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       Pawel Kot <pkot@bezsensu.pl>
Subject: Re: [2.6.7-BK] NTFS 2.1.13 patch 4/8
In-Reply-To: <Pine.SOL.4.58.0406081244580.21854@orange.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0406081245130.21854@orange.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0406081236450.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081243060.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081244330.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081244580.21854@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 4 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/06/01 1.1739)
   NTFS: - Implement fs/ntfs/mft.[hc]::{,__}mark_mft_record_dirty() and make
           fs/ntfs/aops.c::ntfs_writepage() and ntfs_commit_write() use it, thus
           finally enabling resident file overwrite!  (-8  This also includes a
           placeholder for ->writepage (ntfs_mft_writepage()), which for now
           just redirties the page and returns.  Also, at umount time, we for
           now throw away all mft data page cache pages after the last call to
           ntfs_commit_inode() in the hope that all inodes will have been
           written out by then and hence no dirty (meta)data will be lost.  We
           also check for this case and emit an error message telling the user
           to run chkdsk.
         - If the user is trying to enable (dir)atime updates, warn about the
           fact that we are disabling them.

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
--- a/fs/ntfs/ChangeLog	2004-06-08 12:22:13 +01:00
+++ b/fs/ntfs/ChangeLog	2004-06-08 12:22:13 +01:00
@@ -15,7 +15,6 @@
 	  sops->write_inode(), i.e. ntfs_write_inode(), will copy the times
 	  when it is invoked rather than having to update the mft record
 	  every time.
-	- Implement sops->write_inode().
 	- In between ntfs_prepare/commit_write, need exclusion between
 	  simultaneous file extensions. Need perhaps an NInoResizeUnderway()
 	  flag which we can set in ntfs_prepare_write() and clear again in
@@ -47,6 +46,16 @@
 	- Implement ->write_inode (fs/ntfs/inode.c::ntfs_write_inode()) for the
 	  ntfs super operations.  This gives us inode writing via the VFS inode
 	  dirty code paths.  Note:  Access time updates are not implemented yet.
+	- Implement fs/ntfs/mft.[hc]::{,__}mark_mft_record_dirty() and make
+	  fs/ntfs/aops.c::ntfs_writepage() and ntfs_commit_write() use it, thus
+	  finally enabling resident file overwrite!  (-8  This also includes a
+	  placeholder for ->writepage (ntfs_mft_writepage()), which for now
+	  just redirties the page and returns.  Also, at umount time, we for
+	  now throw away all mft data page cache pages after the last call to
+	  ntfs_commit_inode() in the hope that all inodes will have been
+	  written out by then and hence no dirty (meta)data will be lost.  We
+	  also check for this case and emit an error message telling the user
+	  to run chkdsk.

 2.1.12 - Fix the second fix to the decompression engine and some cleanups.

diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-06-08 12:22:13 +01:00
+++ b/fs/ntfs/aops.c	2004-06-08 12:22:13 +01:00
@@ -778,9 +778,8 @@
  *
  * For resident attributes, OTOH, ntfs_writepage() writes the @page by copying
  * the data to the mft record (which at this stage is most likely in memory).
- * Thus, in this case, I/O is synchronous, as even if the mft record is not
- * cached at this point in time, we need to wait for it to be read in before we
- * can do the copy.
+ * The mft record is then marked dirty and written out asynchronously via the
+ * vfs inode dirty code path.
  *
  * Note the caller clears the page dirty flag before calling ntfs_writepage().
  *
@@ -875,16 +874,6 @@
 	BUG_ON(page_has_buffers(page));
 	BUG_ON(!PageUptodate(page));

-	// TODO: Consider using PageWriteback() + unlock_page() in 2.5 once the
-	// "VM fiddling has ended". Note, don't forget to replace all the
-	// unlock_page() calls further below with end_page_writeback() ones.
-	// FIXME: Make sure it is ok to SetPageError() on unlocked page under
-	// writeback before doing the change!
-#if 0
-	set_page_writeback(page);
-	unlock_page(page);
-#endif
-
 	if (!NInoAttr(ni))
 		base_ni = ni;
 	else
@@ -934,6 +923,14 @@
 	if (unlikely(bytes > PAGE_CACHE_SIZE))
 		bytes = PAGE_CACHE_SIZE;

+	// TODO: Consider using PageWriteback() + unlock_page() in 2.6 once the
+	// "VM fiddling has ended". Note, don't forget to replace all the
+	// unlock_page() calls further below with end_page_writeback() ones.
+#if 0
+	set_page_writeback(page);
+	unlock_page(page);
+#endif
+
 	/*
 	 * Here, we don't need to zero the out of bounds area everytime because
 	 * the below memcpy() already takes care of the mmap-at-end-of-file
@@ -968,9 +965,8 @@

 	unlock_page(page);

-	// TODO: Mark mft record dirty so it gets written back.
-	ntfs_error(vi->i_sb, "Writing to resident files is not supported yet. "
-			"Wrote to memory only...");
+	/* Mark the mft record dirty, so it gets written back. */
+	mark_mft_record_dirty(ctx->ntfs_ino);

 	put_attr_search_ctx(ctx);
 	unmap_mft_record(base_ni);
@@ -1734,9 +1730,8 @@
 	}
 	kunmap_atomic(kaddr, KM_USER0);

-	// TODO: Mark mft record dirty so it gets written back.
-	ntfs_error(vi->i_sb, "Writing to resident files is not supported yet. "
-			"Wrote to memory only...");
+	/* Mark the mft record dirty, so it gets written back. */
+	mark_mft_record_dirty(ctx->ntfs_ino);

 	put_attr_search_ctx(ctx);
 	unmap_mft_record(base_ni);
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-06-08 12:22:13 +01:00
+++ b/fs/ntfs/mft.c	2004-06-08 12:22:13 +01:00
@@ -102,6 +102,13 @@
  */
 extern int ntfs_readpage(struct file *, struct page *);

+#ifdef NTFS_RW
+/**
+ * ntfs_mft_writepage - forward declaration, function is further below
+ */
+static int ntfs_mft_writepage(struct page *page, struct writeback_control *wbc);
+#endif /* NTFS_RW */
+
 /**
  * ntfs_mft_aops - address space operations for access to $MFT
  *
@@ -112,6 +119,10 @@
 	.readpage	= ntfs_readpage,	/* Fill page with data. */
 	.sync_page	= block_sync_page,	/* Currently, just unplugs the
 						   disk request queue. */
+#ifdef NTFS_RW
+	.writepage	= ntfs_mft_writepage,	/* Write out the dirty mft
+						   records in a page. */
+#endif /* NTFS_RW */
 };

 /**
@@ -432,6 +443,52 @@

 #ifdef NTFS_RW

+/**
+ * __mark_mft_record_dirty - set the mft record and the page containing it dirty
+ * @ni:		ntfs inode describing the mapped mft record
+ *
+ * Internal function.  Users should call mark_mft_record_dirty() instead.
+ *
+ * Set the mapped (extent) mft record of the (base or extent) ntfs inode @ni,
+ * as well as the page containing the mft record, dirty.  Also, mark the base
+ * vfs inode dirty.  This ensures that any changes to the mft record are
+ * written out to disk.
+ *
+ * NOTE:  We only set I_DIRTY_SYNC and I_DIRTY_DATASYNC (and not I_DIRTY_PAGES)
+ * on the base vfs inode, because even though file data may have been modified,
+ * it is dirty in the inode meta data rather than the data page cache of the
+ * inode, and thus there are no data pages that need writing out.  Therefore, a
+ * full mark_inode_dirty() is overkill.  A mark_inode_dirty_sync(), on the
+ * other hand, is not sufficient, because I_DIRTY_DATASYNC needs to be set to
+ * ensure ->write_inode is called from generic_osync_inode() and this needs to
+ * happen or the file data would not necessarily hit the device synchronously,
+ * even though the vfs inode has the O_SYNC flag set.  Also, I_DIRTY_DATASYNC
+ * simply "feels" better than just I_DIRTY_SYNC, since the file data has not
+ * actually hit the block device yet, which is not what I_DIRTY_SYNC on its own
+ * would suggest.
+ */
+void __mark_mft_record_dirty(ntfs_inode *ni)
+{
+	struct page *page = ni->page;
+	ntfs_inode *base_ni;
+
+	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
+	BUG_ON(!page);
+	BUG_ON(NInoAttr(ni));
+
+	/* Set the page containing the mft record dirty. */
+	__set_page_dirty_nobuffers(page);
+
+	/* Determine the base vfs inode and mark it dirty, too. */
+	down(&ni->extent_lock);
+	if (likely(ni->nr_extents >= 0))
+		base_ni = ni;
+	else
+		base_ni = ni->ext.base_ntfs_ino;
+	up(&ni->extent_lock);
+	__mark_inode_dirty(VFS_I(base_ni), I_DIRTY_SYNC | I_DIRTY_DATASYNC);
+}
+
 static const char *ntfs_please_email = "Please email "
 		"linux-ntfs-dev@lists.sourceforge.net and say that you saw "
 		"this message.  Thank you.";
@@ -812,7 +869,27 @@
 	 * happens.  ->clear_inode() will still be invoked so all extent inodes
 	 * and other allocated memory will be freed.
 	 */
+	if (err == -ENOMEM) {
+		ntfs_error(vol->sb, "Not enough memory to write mft record.  "
+				"Redirtying so the write is retried later.");
+		mark_mft_record_dirty(ni);
+		err = 0;
+	}
 	return err;
+}
+
+static int ntfs_mft_writepage(struct page *page, struct writeback_control *wbc)
+{
+	struct inode *mft_vi = page->mapping->host;
+	struct super_block *sb = mft_vi->i_sb;
+	ntfs_volume *vol = NTFS_SB(sb);
+
+	BUG_ON(mft_vi != vol->mft_ino);
+	ntfs_warning(sb, "VM writeback of $MFT is not implemented yet:  "
+			"Redirtying the page.");
+	redirty_page_for_writepage(wbc, page);
+	unlock_page(page);
+	return 0;
 }

 #endif /* NTFS_RW */
diff -Nru a/fs/ntfs/mft.h b/fs/ntfs/mft.h
--- a/fs/ntfs/mft.h	2004-06-08 12:22:13 +01:00
+++ b/fs/ntfs/mft.h	2004-06-08 12:22:13 +01:00
@@ -57,6 +57,25 @@
 	flush_dcache_page(ni->page);
 }

+extern void __mark_mft_record_dirty(ntfs_inode *ni);
+
+/**
+ * mark_mft_record_dirty - set the mft record and the page containing it dirty
+ * @ni:		ntfs inode describing the mapped mft record
+ *
+ * Set the mapped (extent) mft record of the (base or extent) ntfs inode @ni,
+ * as well as the page containing the mft record, dirty.  Also, mark the base
+ * vfs inode dirty.  This ensures that any changes to the mft record are
+ * written out to disk.
+ *
+ * NOTE:  Do not do anything if the mft record is already marked dirty.
+ */
+static inline void mark_mft_record_dirty(ntfs_inode *ni)
+{
+	if (!NInoTestSetDirty(ni))
+		__mark_mft_record_dirty(ni);
+}
+
 extern int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync);

 /**
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-06-08 12:22:13 +01:00
+++ b/fs/ntfs/super.c	2004-06-08 12:22:13 +01:00
@@ -340,6 +340,12 @@
 	}
 	// TODO:  For now we enforce no atime and dir atime updates as they are
 	// not implemented.
+	if ((sb->s_flags & MS_NOATIME) && !(*flags & MS_NOATIME))
+		ntfs_warning(sb, "Atime updates are not implemented yet.  "
+				"Leaving them disabled.");
+	else if ((sb->s_flags & MS_NODIRATIME) && !(*flags & MS_NODIRATIME))
+		ntfs_warning(sb, "Directory atime updates are not implemented "
+				"yet.  Leaving them disabled.");
 	*flags |= MS_NOATIME | MS_NODIRATIME;
 #endif /* ! NTFS_RW */

@@ -1371,6 +1377,21 @@
 		iput(vol->mftmirr_ino);
 		vol->mftmirr_ino = NULL;
 	}
+	/*
+	 * Throw away all mft data page cache pages to allow a clean umount.
+	 * All inodes should by now be written out and clean so this should not
+	 * loose any data while removing all the pages which have the dirty bit
+	 * set.
+	 */
+	ntfs_commit_inode(vol->mft_ino);
+	down(&vol->mft_ino->i_sem);
+	truncate_inode_pages(vol->mft_ino->i_mapping, 0);
+	up(&vol->mft_ino->i_sem);
+	write_inode_now(vol->mft_ino, 1);
+	if (!list_empty(&vfs_sb->s_dirty) || !list_empty(&vfs_sb->s_io))
+		ntfs_error(vfs_sb, "Dirty inodes found at umount time.  "
+				"They have been thrown away and their changes "
+				"have been lost.  You should run chkdsk.");
 #endif /* NTFS_RW */

 	iput(vol->mft_ino);
@@ -1754,8 +1775,12 @@
 #ifndef NTFS_RW
 	sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
 #else
-	// TODO:  For now we enforce no atime and dir atime updates as they are
-	// not implemented.
+	if (!(sb->s_flags & MS_NOATIME))
+		ntfs_warning(sb, "Atime updates are not implemented yet.  "
+				"Disabling them.");
+	else if (!(sb->s_flags & MS_NODIRATIME))
+		ntfs_warning(sb, "Directory atime updates are not implemented "
+				"yet.  Disabling them.");
 	sb->s_flags |= MS_NOATIME | MS_NODIRATIME;
 #endif
 	/* Allocate a new ntfs_volume and place it in sb->s_fs_info. */
