Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265117AbUFHLwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUFHLwS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbUFHLvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:51:07 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:54207 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265051AbUFHLqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:46:05 -0400
Date: Tue, 8 Jun 2004 12:46:04 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       Pawel Kot <pkot@bezsensu.pl>
Subject: Re: [2.6.7-BK] NTFS 2.1.13 patch 6/8
In-Reply-To: <Pine.SOL.4.58.0406081245290.21854@orange.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0406081245500.21854@orange.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0406081236450.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081243060.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081244330.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081244580.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081245130.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081245290.21854@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 6 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/06/04 1.1744)
   NTFS: Implement ntfs_mft_writepage() so it now checks if any of the mft
         records in the page are dirty and if so redirties the page and
         returns.  Otherwise it just returns (after doing set_page_writeback(),
         unlock_page(), end_page_writeback() or the radix-tree tag
         PAGECACHE_TAG_DIRTY  remains set even though the page is clean), thus
         alowing the VM to do with the page as it pleases.  Also, at umount
         time, now only throw away dirty mft (meta)data pages if dirty inodes
         are present and ask the user to email us if they see this happening.

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
--- a/fs/ntfs/ChangeLog	2004-06-08 12:22:18 +01:00
+++ b/fs/ntfs/ChangeLog	2004-06-08 12:22:18 +01:00
@@ -60,6 +60,14 @@
 	  attribute code path of fs/ntfs/aops.c::ntfs_writepage() otherwise
 	  the radix-tree tag PAGECACHE_TAG_DIRTY remains set even though the
 	  page is clean.
+	- Implement ntfs_mft_writepage() so it now checks if any of the mft
+	  records in the page are dirty and if so redirties the page and
+	  returns.  Otherwise it just returns (after doing set_page_writeback(),
+	  unlock_page(), end_page_writeback() or the radix-tree tag
+	  PAGECACHE_TAG_DIRTY remains set even though the page is clean), thus
+	  alowing the VM to do with the page as it pleases.  Also, at umount
+	  time, now only throw away dirty mft (meta)data pages if dirty inodes
+	  are present and ask the user to email us if they see this happening.

 2.1.12 - Fix the second fix to the decompression engine and some cleanups.

diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-06-08 12:22:18 +01:00
+++ b/fs/ntfs/mft.c	2004-06-08 12:22:18 +01:00
@@ -476,7 +476,10 @@
 	BUG_ON(!page);
 	BUG_ON(NInoAttr(ni));

-	/* Set the page containing the mft record dirty. */
+	/*
+	 * Set the page containing the mft record dirty.  This also marks the
+	 * $MFT inode dirty (I_DIRTY_PAGES).
+	 */
 	__set_page_dirty_nobuffers(page);

 	/* Determine the base vfs inode and mark it dirty, too. */
@@ -878,17 +881,176 @@
 	return err;
 }

+/**
+ * ntfs_mft_writepage - check if a metadata page contains dirty mft records
+ * @page:	metadata page possibly containing dirty mft records
+ * @wbc:	writeback control structure
+ *
+ * This is called from the VM when it wants to have a dirty $MFT/$DATA metadata
+ * page cache page cleaned.  The VM has already locked the page and marked it
+ * clean.  Instead of writing the page as a conventional ->writepage function
+ * would do, we check if the page still contains any dirty mft records (it must
+ * have done at some point in the past since the page was marked dirty) and if
+ * none are found, i.e. all mft records are clean, we unlock the page and
+ * return.  The VM is then free to do with the page as it pleases.  If on the
+ * other hand we do find any dirty mft records in the page, we redirty the page
+ * before unlocking it and returning so the VM knows that the page is still
+ * busy and cannot be thrown out.
+ *
+ * Note, we do not actually write any dirty mft records here because they are
+ * dirty inodes and hence will be written by the VFS inode dirty code paths.
+ * There is no need to write them from the VM page dirty code paths, too and in
+ * fact once we implement journalling it would be a complete nightmare having
+ * two code paths leading to mft record writeout.
+ */
 static int ntfs_mft_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct inode *mft_vi = page->mapping->host;
 	struct super_block *sb = mft_vi->i_sb;
 	ntfs_volume *vol = NTFS_SB(sb);
+	u8 *maddr;
+	MFT_RECORD *m;
+	ntfs_inode **extent_nis;
+	unsigned long mft_no;
+	int nr, i, j;
+	BOOL is_dirty = FALSE;

 	BUG_ON(mft_vi != vol->mft_ino);
-	ntfs_warning(sb, "VM writeback of $MFT is not implemented yet:  "
-			"Redirtying the page.");
-	redirty_page_for_writepage(wbc, page);
-	unlock_page(page);
+	/* The first mft record number in the page. */
+	mft_no = page->index << (PAGE_CACHE_SHIFT - vol->mft_record_size_bits);
+	/* Number of mft records in the page. */
+	nr = PAGE_CACHE_SIZE >> vol->mft_record_size_bits;
+	BUG_ON(!nr);
+	ntfs_debug("Entering for %i inodes starting at 0x%lx.", nr, mft_no);
+	/* Iterate over the mft records in the page looking for a dirty one. */
+	maddr = (u8*)kmap(page);
+	for (i = 0; i < nr; ++i, ++mft_no, maddr += vol->mft_record_size) {
+		struct inode *vi;
+		ntfs_inode *ni, *eni;
+		ntfs_attr na;
+
+		na.mft_no = mft_no;
+		na.name = NULL;
+		na.name_len = 0;
+		na.type = AT_UNUSED;
+
+		/*
+		 * Check if the inode corresponding to this mft record is in
+		 * the VFS inode cache and obtain a reference to it if it is.
+		 */
+		vi = ilookup5(sb, mft_no, (test_t)ntfs_test_inode, &na);
+		if (vi) {
+			/* The inode is in icache.  Check if it is dirty. */
+			ni = NTFS_I(vi);
+			if (!NInoDirty(ni)) {
+				/* The inode is not dirty, skip this record. */
+				iput(vi);
+				continue;
+			}
+			/* The inode is dirty, no need to search further. */
+			iput(vi);
+			is_dirty = TRUE;
+			break;
+		}
+		/* The inode is not in icache. */
+		/* Skip the record if it is not a mft record (type "FILE"). */
+		if (!ntfs_is_mft_recordp(maddr))
+			continue;
+		m = (MFT_RECORD*)maddr;
+		/*
+		 * Skip the mft record if it is not in use.  FIXME:  What about
+		 * deleted/deallocated (extent) inodes?  (AIA)
+		 */
+		if (!(m->flags & MFT_RECORD_IN_USE))
+			continue;
+		/* Skip the mft record if it is a base inode. */
+		if (!m->base_mft_record)
+			continue;
+		/*
+		 * This is an extent mft record.  Check if the inode
+		 * corresponding to its base mft record is in icache.
+		 */
+		na.mft_no = MREF_LE(m->base_mft_record);
+		vi = ilookup5(sb, na.mft_no, (test_t)ntfs_test_inode,
+				&na);
+		if (!vi) {
+			/*
+			 * The base inode is not in icache.  Skip this extent
+			 * mft record.
+			 */
+			continue;
+		}
+		/*
+		 * The base inode is in icache.  Check if it has the extent
+		 * inode corresponding to this extent mft record attached.
+		 */
+		ni = NTFS_I(vi);
+		down(&ni->extent_lock);
+		if (ni->nr_extents <= 0) {
+			/*
+			 * The base inode has no attached extent inodes.  Skip
+			 * this extent mft record.
+			 */
+			up(&ni->extent_lock);
+			iput(vi);
+			continue;
+		}
+		/* Iterate over the attached extent inodes. */
+		extent_nis = ni->ext.extent_ntfs_inos;
+		for (eni = NULL, j = 0; j < ni->nr_extents; ++j) {
+			if (mft_no == extent_nis[j]->mft_no) {
+				/*
+				 * Found the extent inode corresponding to this
+				 * extent mft record.
+				 */
+				eni = extent_nis[j];
+				break;
+			}
+		}
+		/*
+		 * If the extent inode was not attached to the base inode, skip
+		 * this extent mft record.
+		 */
+		if (!eni) {
+			up(&ni->extent_lock);
+			iput(vi);
+			continue;
+		}
+		/*
+		 * Found the extent inode corrsponding to this extent mft
+		 * record.  If it is dirty, no need to search further.
+		 */
+		if (NInoDirty(eni)) {
+			up(&ni->extent_lock);
+			iput(vi);
+			is_dirty = TRUE;
+			break;
+		}
+		/* The extent inode is not dirty, so do the next record. */
+		up(&ni->extent_lock);
+		iput(vi);
+	}
+	kunmap(page);
+	/* If a dirty mft record was found, redirty the page. */
+	if (is_dirty) {
+		ntfs_debug("Inode 0x%lx is dirty.  Redirtying the page "
+				"starting at inode 0x%lx.", mft_no,
+				page->index << (PAGE_CACHE_SHIFT -
+				vol->mft_record_size_bits));
+		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
+	} else {
+		/*
+		 * Keep the VM happy.  This must be done otherwise the
+		 * radix-tree tag PAGECACHE_TAG_DIRTY remains set even though
+		 * the page is clean.
+		 */
+		BUG_ON(PageWriteback(page));
+		set_page_writeback(page);
+		unlock_page(page);
+		end_page_writeback(page);
+	}
+	ntfs_debug("Done.");
 	return 0;
 }

diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-06-08 12:22:18 +01:00
+++ b/fs/ntfs/super.c	2004-06-08 12:22:18 +01:00
@@ -1378,20 +1378,38 @@
 		vol->mftmirr_ino = NULL;
 	}
 	/*
-	 * Throw away all mft data page cache pages to allow a clean umount.
-	 * All inodes should by now be written out and clean so this should not
-	 * loose any data while removing all the pages which have the dirty bit
-	 * set.
+	 * If any dirty inodes are left, throw away all mft data page cache
+	 * pages to allow a clean umount.  This should never happen any more
+	 * due to mft.c::ntfs_mft_writepage() cleaning all the dirty pages as
+	 * the underlying mft records are written out and cleaned.  If it does,
+	 * happen anyway, we want to know...
 	 */
 	ntfs_commit_inode(vol->mft_ino);
-	down(&vol->mft_ino->i_sem);
-	truncate_inode_pages(vol->mft_ino->i_mapping, 0);
-	up(&vol->mft_ino->i_sem);
 	write_inode_now(vol->mft_ino, 1);
-	if (!list_empty(&vfs_sb->s_dirty) || !list_empty(&vfs_sb->s_io))
-		ntfs_error(vfs_sb, "Dirty inodes found at umount time.  "
-				"They have been thrown away and their changes "
-				"have been lost.  You should run chkdsk.");
+	if (!list_empty(&vfs_sb->s_dirty)) {
+		char *s1, *s2;
+
+		down(&vol->mft_ino->i_sem);
+		truncate_inode_pages(vol->mft_ino->i_mapping, 0);
+		up(&vol->mft_ino->i_sem);
+		write_inode_now(vol->mft_ino, 1);
+		if (!list_empty(&vfs_sb->s_dirty)) {
+			static char *_s1 = "inodes";
+			static char *_s2 = "";
+			s1 = _s1;
+			s2 = _s2;
+		} else {
+			static char *_s1 = "mft pages";
+			static char *_s2 = "They have been thrown away.  ";
+			s1 = _s1;
+			s2 = _s2;
+		}
+		ntfs_error(vfs_sb, "Dirty %s found at umount time.  %s"
+				"You should run chkdsk.  Please email "
+				"linux-ntfs-dev@lists.sourceforge.net and say "
+				"that you saw this message.  Thank you.", s1,
+				s2);
+	}
 #endif /* NTFS_RW */

 	iput(vol->mft_ino);
