Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUJSKVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUJSKVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269401AbUJSKPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:15:00 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:63148 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268182AbUJSJp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:45:27 -0400
Date: Tue, 19 Oct 2004 10:45:22 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 27/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191044560.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191045100.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041290.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041590.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042200.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042440.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043240.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043370.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043500.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044130.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044280.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044560.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 27/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/14 1.2046)
   NTFS: Big cleanup of mft record writing code.
   
   - Clear the page uptodate flag in fs/ntfs/aops.c::ntfs_write_mst_block()
     to ensure noone can see the page whilst the mst fixups are applied.
   - Add the helper fs/ntfs/mft.c::ntfs_may_write_mft_record() which
     checks if an mft record may be written out safely obtaining any
     necessary locks in the process.  This is used by
     fs/ntfs/aops.c::ntfs_write_mst_block().
   - Modify fs/ntfs/aops.c::ntfs_write_mst_block() to also work for
     writing mft records and improve its error handling in the process.
     Now if any of the records in the page fail to be written out, all
     other records will be written out instead of aborting completely.
   - Remove ntfs_mft_aops and update all users to use ntfs_mst_aops.
   - Modify fs/ntfs/inode.c::ntfs_read_locked_inode() to set the
     ntfs_mst_aops for all inodes which are NInoMstProtected() and
     ntfs_aops for all other inodes.
   - Rename fs/ntfs/mft.c::sync_mft_mirror{,_umount}() to
     ntfs_sync_mft_mirror{,_umount}() and change their parameters so they
     no longer require an ntfs inode to be present.  Update all callers.
   - Cleanup the error handling in fs/ntfs/mft.c::ntfs_sync_mft_mirror().
   - Clear the page uptodate flag in fs/ntfs/mft.c::ntfs_sync_mft_mirror()
     to ensure noone can see the page whilst the mst fixups are applied.
   - Remove the no longer needed fs/ntfs/mft.c::ntfs_mft_writepage() and
     fs/ntfs/mft.c::try_map_mft_record().
   - Fix callers of fs/ntfs/aops.c::mark_ntfs_record_dirty() to call it
     with the ntfs inode which contains the page rather than the ntfs
     inode the mft record of which is in the page.
   
   Ooops.  Yes, I know, I should have split this up into smaller changes...
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:44 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:44 +01:00
@@ -85,6 +85,31 @@
 	- Provide exclusion between opening an inode / mapping an mft record
 	  and accessing the mft record in fs/ntfs/mft.c::ntfs_mft_writepage()
 	  by setting the page not uptodate throughout ntfs_mft_writepage().
+	- Clear the page uptodate flag in fs/ntfs/aops.c::ntfs_write_mst_block()
+	  to ensure noone can see the page whilst the mst fixups are applied.
+	- Add the helper fs/ntfs/mft.c::ntfs_may_write_mft_record() which
+	  checks if an mft record may be written out safely obtaining any
+	  necessary locks in the process.  This is used by
+	  fs/ntfs/aops.c::ntfs_write_mst_block().
+	- Modify fs/ntfs/aops.c::ntfs_write_mst_block() to also work for
+	  writing mft records and improve its error handling in the process.
+	  Now if any of the records in the page fail to be written out, all
+	  other records will be written out instead of aborting completely.
+	- Remove ntfs_mft_aops and update all users to use ntfs_mst_aops.
+	- Modify fs/ntfs/inode.c::ntfs_read_locked_inode() to set the
+	  ntfs_mst_aops for all inodes which are NInoMstProtected() and
+	  ntfs_aops for all other inodes.
+	- Rename fs/ntfs/mft.c::sync_mft_mirror{,_umount}() to
+	  ntfs_sync_mft_mirror{,_umount}() and change their parameters so they
+	  no longer require an ntfs inode to be present.  Update all callers.
+	- Cleanup the error handling in fs/ntfs/mft.c::ntfs_sync_mft_mirror().
+	- Clear the page uptodate flag in fs/ntfs/mft.c::ntfs_sync_mft_mirror()
+	  to ensure noone can see the page whilst the mst fixups are applied.
+	- Remove the no longer needed fs/ntfs/mft.c::ntfs_mft_writepage() and
+	  fs/ntfs/mft.c::try_map_mft_record().
+	- Fix callers of fs/ntfs/aops.c::mark_ntfs_record_dirty() to call it
+	  with the ntfs inode which contains the page rather than the ntfs
+	  inode the mft record of which is in the page.
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-10-19 10:14:44 +01:00
+++ b/fs/ntfs/aops.c	2004-10-19 10:14:44 +01:00
@@ -26,6 +26,7 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/buffer_head.h>
+#include <linux/writeback.h>
 
 #include "aops.h"
 #include "debug.h"
@@ -777,25 +778,25 @@
 	return err;
 }
 
-static const char *ntfs_please_email = "Please email "
-		"linux-ntfs-dev@lists.sourceforge.net and say that you saw "
-		"this message.  Thank you.";
-
 /**
  * ntfs_write_mst_block - write a @page to the backing store
  * @wbc:	writeback control structure
  * @page:	page cache page to write out
  *
  * This function is for writing pages belonging to non-resident, mst protected
- * attributes to their backing store.  The only supported attribute is the
- * index allocation attribute.  Both directory inodes and index inodes are
- * supported.
+ * attributes to their backing store.  The only supported attributes are index
+ * allocation and $MFT/$DATA.  Both directory inodes and index inodes are
+ * supported for the index allocation case.
  *
  * The page must remain locked for the duration of the write because we apply
  * the mst fixups, write, and then undo the fixups, so if we were to unlock the
  * page before undoing the fixups, any other user of the page will see the
  * page contents as corrupt.
  *
+ * We clear the page uptodate flag for the duration of the function to ensure
+ * exclusion for the $MFT/$DATA case against someone mapping an mft record we
+ * are about to apply the mst fixups to.
+ *
  * Return 0 on success and -errno on error.
  *
  * Based on ntfs_write_block(), ntfs_mft_writepage(), and
@@ -810,60 +811,53 @@
 	ntfs_volume *vol = ni->vol;
 	u8 *kaddr;
 	unsigned int bh_size = 1 << vi->i_blkbits;
-	unsigned int rec_size;
-	struct buffer_head *bh, *head;
+	unsigned int rec_size = ni->itype.index.block_size;
+	ntfs_inode *locked_nis[PAGE_CACHE_SIZE / rec_size];
+	struct buffer_head *bh, *head, *tbh;
 	int max_bhs = PAGE_CACHE_SIZE / bh_size;
 	struct buffer_head *bhs[max_bhs];
-	int i, nr_recs, nr_bhs, bhs_per_rec, err;
-	unsigned char bh_size_bits;
-	BOOL rec_is_dirty;
+	int i, nr_locked_nis, nr_recs, nr_bhs, bhs_per_rec, err;
+	unsigned char bh_size_bits, rec_size_bits;
+	BOOL sync, is_mft, page_is_dirty, rec_is_dirty;
 
 	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
 			"0x%lx.", vi->i_ino, ni->type, page->index);
 	BUG_ON(!NInoNonResident(ni));
 	BUG_ON(!NInoMstProtected(ni));
-	BUG_ON(!(S_ISDIR(vi->i_mode) ||
+	is_mft = (S_ISREG(vi->i_mode) && !vi->i_ino);
+	BUG_ON(!(is_mft || S_ISDIR(vi->i_mode) ||
 			(NInoAttr(ni) && ni->type == AT_INDEX_ALLOCATION)));
-	BUG_ON(PageWriteback(page));
-	BUG_ON(!PageUptodate(page));
 	BUG_ON(!max_bhs);
 
+	/* Were we called for sync purposes? */
+	sync = (wbc->sync_mode == WB_SYNC_ALL);
+
 	/* Make sure we have mapped buffers. */
-	if (unlikely(!page_has_buffers(page))) {
-no_buffers_err_out:
-		ntfs_error(vol->sb, "Writing ntfs records without existing "
-				"buffers is not implemented yet.  %s",
-				ntfs_please_email);
-		err = -EOPNOTSUPP;
-		goto err_out;
-	}
+	BUG_ON(!page_has_buffers(page));
 	bh = head = page_buffers(page);
-	if (unlikely(!bh))
-		goto no_buffers_err_out;
+	BUG_ON(!bh);
 
 	bh_size_bits = vi->i_blkbits;
-	rec_size = ni->itype.index.block_size;
-	nr_recs = PAGE_CACHE_SIZE / rec_size;
-	BUG_ON(!nr_recs);
+	rec_size_bits = ni->itype.index.block_size_bits;
+	BUG_ON(!(PAGE_CACHE_SIZE >> rec_size_bits));
 	bhs_per_rec = rec_size >> bh_size_bits;
 	BUG_ON(!bhs_per_rec);
 
 	/* The first block in the page. */
-	rec_block = block = (s64)page->index <<
+	rec_block = block = (sector_t)page->index <<
 			(PAGE_CACHE_SHIFT - bh_size_bits);
 
 	/* The first out of bounds block for the data size. */
 	dblock = (vi->i_size + bh_size - 1) >> bh_size_bits;
 
-	err = nr_bhs = 0;
-	/* Need this to silence a stupid gcc warning. */
-	rec_is_dirty = FALSE;
+	err = nr_bhs = nr_recs = nr_locked_nis = 0;
+	page_is_dirty = rec_is_dirty = FALSE;
 	do {
 		if (unlikely(block >= dblock)) {
 			/*
 			 * Mapped buffers outside i_size will occur, because
 			 * this page can be outside i_size when there is a
-			 * truncate in progress. The contents of such buffers
+			 * truncate in progress.  The contents of such buffers
 			 * were zeroed by ntfs_writepage().
 			 *
 			 * FIXME: What about the small race window where
@@ -876,7 +870,7 @@
 		}
 		if (rec_block == block) {
 			/* This block is the first one in the record. */
-			rec_block += rec_size >> bh_size_bits;
+			rec_block += bhs_per_rec;
 			if (!buffer_dirty(bh)) {
 				/* Clean buffers are not written out. */
 				rec_is_dirty = FALSE;
@@ -892,54 +886,91 @@
 			}
 			BUG_ON(!rec_is_dirty);
 		}
-		if (!buffer_mapped(bh)) {
-			ntfs_error(vol->sb, "Writing ntfs records without "
-					"existing mapped buffers is not "
-					"implemented yet.  %s",
-					ntfs_please_email);
-			clear_buffer_dirty(bh);
-			err = -EOPNOTSUPP;
-			goto cleanup_out;
-		}
-		if (!buffer_uptodate(bh)) {
-			ntfs_error(vol->sb, "Writing ntfs records without "
-					"existing uptodate buffers is not "
-					"implemented yet.  %s",
-					ntfs_please_email);
-			clear_buffer_dirty(bh);
-			err = -EOPNOTSUPP;
-			goto cleanup_out;
-		}
+		BUG_ON(!buffer_mapped(bh));
+		BUG_ON(!buffer_uptodate(bh));
 		bhs[nr_bhs++] = bh;
 		BUG_ON(nr_bhs > max_bhs);
 	} while (block++, (bh = bh->b_this_page) != head);
 	/* If there were no dirty buffers, we are done. */
 	if (!nr_bhs)
 		goto done;
-	/* Apply the mst protection fixups. */
+	/* Map the page so we can access its contents. */
 	kaddr = kmap(page);
+	/* Clear the page uptodate flag whilst the mst fixups are applied. */
+	BUG_ON(!PageUptodate(page));
+	ClearPageUptodate(page);
 	for (i = 0; i < nr_bhs; i++) {
-		if (!(i % bhs_per_rec)) {
-			err = pre_write_mst_fixup((NTFS_RECORD*)(kaddr +
-					bh_offset(bhs[i])), rec_size);
-			if (err) {
-				ntfs_error(vol->sb, "Failed to apply mst "
-						"fixups (inode 0x%lx, "
-						"attribute type 0x%x, page "
-						"index 0x%lx)!  Umount and "
-						"run chkdsk.", vi->i_ino,
-						ni->type,
-				page->index);
-				nr_bhs = i;
-				goto mst_cleanup_out;
+		unsigned int ofs;
+
+		/* Skip buffers which are not at the beginning of records. */
+		if (i % bhs_per_rec)
+			continue;
+		tbh = bhs[i];
+		ofs = bh_offset(tbh);
+		if (is_mft) {
+			ntfs_inode *tni;
+			unsigned long mft_no;
+
+			/* Get the mft record number. */
+			mft_no = (((s64)page->index << PAGE_CACHE_SHIFT) + ofs)
+					>> rec_size_bits;
+			/* Check whether to write this mft record. */
+			tni = NULL;
+			if (!ntfs_may_write_mft_record(vol, mft_no,
+					(MFT_RECORD*)(kaddr + ofs), &tni)) {
+				/*
+				 * The record should not be written.  This
+				 * means we need to redirty the page before
+				 * returning.
+				 */
+				page_is_dirty = TRUE;
+				/*
+				 * Remove the buffers in this mft record from
+				 * the list of buffers to write.
+				 */
+				do {
+					bhs[i] = NULL;
+				} while (++i % bhs_per_rec);
+				continue;
 			}
+			/*
+			 * The record should be written.  If a locked ntfs
+			 * inode was returned, add it to the array of locked
+			 * ntfs inodes.
+			 */
+			if (tni)
+				locked_nis[nr_locked_nis++] = tni;
+		}
+		/* Apply the mst protection fixups. */
+		err = pre_write_mst_fixup((NTFS_RECORD*)(kaddr + ofs),
+				rec_size);
+		if (unlikely(err)) {
+			ntfs_error(vol->sb, "Failed to apply mst fixups "
+					"(inode 0x%lx, attribute type 0x%x, "
+					"page index 0x%lx, page offset 0x%x)!"
+					"  Unmount and run chkdsk.", vi->i_ino,
+					ni->type, page->index, ofs);
+			/*
+			 * Mark all the buffers in this record clean as we do
+			 * not want to write corrupt data to disk.
+			 */
+			do {
+				clear_buffer_dirty(bhs[i]);
+				bhs[i] = NULL;
+			} while (++i % bhs_per_rec);
+			continue;
 		}
+		nr_recs++;
 	}
+	/* If no records are to be written out, we are done. */
+	if (!nr_recs)
+		goto unm_done;
 	flush_dcache_page(page);
 	/* Lock buffers and start synchronous write i/o on them. */
 	for (i = 0; i < nr_bhs; i++) {
-		struct buffer_head *tbh = bhs[i];
-
+		tbh = bhs[i];
+		if (!tbh)
+			continue;
 		if (unlikely(test_set_buffer_locked(tbh)))
 			BUG();
 		if (unlikely(!test_clear_buffer_dirty(tbh))) {
@@ -952,59 +983,121 @@
 		tbh->b_end_io = end_buffer_write_sync;
 		submit_bh(WRITE, tbh);
 	}
+	/* Synchronize the mft mirror now if not @sync. */
+	if (is_mft && !sync)
+		goto do_mirror;
+do_wait:
 	/* Wait on i/o completion of buffers. */
 	for (i = 0; i < nr_bhs; i++) {
-		struct buffer_head *tbh = bhs[i];
-
+		tbh = bhs[i];
+		if (!tbh)
+			continue;
 		wait_on_buffer(tbh);
 		if (unlikely(!buffer_uptodate(tbh))) {
+			ntfs_error(vol->sb, "I/O error while writing ntfs "
+					"record buffer (inode 0x%lx, "
+					"attribute type 0x%x, page index "
+					"0x%lx, page offset 0x%lx)!  Unmount "
+					"and run chkdsk.", vi->i_ino, ni->type,
+					page->index, bh_offset(tbh));
 			err = -EIO;
 			/*
-			 * Set the buffer uptodate so the page & buffer states
-			 * don't become out of sync.
+			 * Set the buffer uptodate so the page and buffer
+			 * states do not become out of sync.
 			 */
-			if (PageUptodate(page))
-				set_buffer_uptodate(tbh);
+			set_buffer_uptodate(tbh);
 		}
 	}
+	/* If @sync, now synchronize the mft mirror. */
+	if (is_mft && sync) {
+do_mirror:
+		for (i = 0; i < nr_bhs; i++) {
+			unsigned long mft_no;
+			unsigned int ofs;
+
+			/*
+			 * Skip buffers which are not at the beginning of
+			 * records.
+			 */
+			if (i % bhs_per_rec)
+				continue;
+			tbh = bhs[i];
+			/* Skip removed buffers (and hence records). */
+			if (!tbh)
+				continue;
+			ofs = bh_offset(tbh);
+			/* Get the mft record number. */
+			mft_no = (((s64)page->index << PAGE_CACHE_SHIFT) + ofs)
+					>> rec_size_bits;
+			if (mft_no < vol->mftmirr_size)
+				ntfs_sync_mft_mirror(vol, mft_no,
+						(MFT_RECORD*)(kaddr + ofs),
+						sync);
+		}
+		if (!sync)
+			goto do_wait;
+	}
 	/* Remove the mst protection fixups again. */
 	for (i = 0; i < nr_bhs; i++) {
-		if (!(i % bhs_per_rec))
+		if (!(i % bhs_per_rec)) {
+			tbh = bhs[i];
+			if (!tbh)
+				continue;
 			post_write_mst_fixup((NTFS_RECORD*)(kaddr +
-					bh_offset(bhs[i])));
+					bh_offset(tbh)));
+		}
 	}
 	flush_dcache_page(page);
-	kunmap(page);
+unm_done:
+	/* Unlock any locked inodes. */
+	while (nr_locked_nis-- > 0) {
+		ntfs_inode *tni, *base_tni;
+		
+		tni = locked_nis[nr_locked_nis];
+		/* Get the base inode. */
+		down(&tni->extent_lock);
+		if (tni->nr_extents >= 0)
+			base_tni = tni;
+		else {
+			base_tni = tni->ext.base_ntfs_ino;
+			BUG_ON(!base_tni);
+		}
+		up(&tni->extent_lock);
+		ntfs_debug("Unlocking %s inode 0x%lx.",
+				tni == base_tni ? "base" : "extent",
+				tni->mft_no);
+		up(&tni->mrec_lock);
+		atomic_dec(&tni->count);
+		iput(VFS_I(base_tni));
+	}
 	if (unlikely(err)) {
-		/* I/O error during writing.  This is really bad! */
-		ntfs_error(vol->sb, "I/O error while writing ntfs record "
-				"(inode 0x%lx, attribute type 0x%x, page "
-				"index 0x%lx)!  Umount and run chkdsk.",
-				vi->i_ino, ni->type, page->index);
-		goto err_out;
+		SetPageError(page);
+		NVolSetErrors(vol);
 	}
+	SetPageUptodate(page);
+	kunmap(page);
 done:
-	set_page_writeback(page);
-	unlock_page(page);
-	end_page_writeback(page);
-	if (!err)
+	if (page_is_dirty) {
+		ntfs_debug("Page still contains one or more dirty ntfs "
+				"records.  Redirtying the page starting at "
+				"record 0x%lx.", page->index <<
+				(PAGE_CACHE_SHIFT - rec_size_bits));
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
+	if (likely(!err))
 		ntfs_debug("Done.");
 	return err;
-mst_cleanup_out:
-	/* Remove the mst protection fixups again. */
-	for (i = 0; i < nr_bhs; i++) {
-		if (!(i % bhs_per_rec))
-			post_write_mst_fixup((NTFS_RECORD*)(kaddr +
-					bh_offset(bhs[i])));
-	}
-	kunmap(page);
-cleanup_out:
-	/* Clean the buffers. */
-	for (i = 0; i < nr_bhs; i++)
-		clear_buffer_dirty(bhs[i]);
-err_out:
-	SetPageError(page);
-	goto done;
 }
 
 /**
@@ -1012,6 +1105,9 @@
  * @page:	page cache page to write out
  * @wbc:	writeback control structure
  *
+ * This is called from the VM when it wants to have a dirty ntfs page cache
+ * page cleaned.  The VM has already locked the page and marked it clean.
+ *
  * For non-resident attributes, ntfs_writepage() writes the @page by calling
  * the ntfs version of the generic block_write_full_page() function,
  * ntfs_write_block(), which in turn if necessary creates and writes the
@@ -1022,8 +1118,6 @@
  * The mft record is then marked dirty and written out asynchronously via the
  * vfs inode dirty code path.
  *
- * Note the caller clears the page dirty flag before calling ntfs_writepage().
- *
  * Based on ntfs_readpage() and fs/buffer.c::block_write_full_page().
  *
  * Return 0 on success and -errno on error.
@@ -2038,7 +2132,7 @@
 
 /**
  * mark_ntfs_record_dirty - mark an ntfs record dirty
- * @ni:		ntfs inode to which the ntfs record to be marked dirty belongs
+ * @ni:		ntfs inode containing the ntfs record to be marked dirty
  * @page:	page containing the ntfs record to mark dirty
  * @rec_start:	byte offset within @page at which the ntfs record begins
  *
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-10-19 10:14:44 +01:00
+++ b/fs/ntfs/inode.c	2004-10-19 10:14:44 +01:00
@@ -968,7 +968,6 @@
 		/* Setup the operations for this inode. */
 		vi->i_op = &ntfs_dir_inode_ops;
 		vi->i_fop = &ntfs_dir_ops;
-		vi->i_mapping->a_ops = &ntfs_mst_aops;
 	} else {
 		/* It is a file. */
 		ntfs_attr_reinit_search_ctx(ctx);
@@ -1112,8 +1111,11 @@
 		/* Setup the operations for this inode. */
 		vi->i_op = &ntfs_file_inode_ops;
 		vi->i_fop = &ntfs_file_ops;
-		vi->i_mapping->a_ops = &ntfs_aops;
 	}
+	if (NInoMstProtected(ni))
+		vi->i_mapping->a_ops = &ntfs_mst_aops;
+	else
+		vi->i_mapping->a_ops = &ntfs_aops;
 	/*
 	 * The number of 512-byte blocks used on disk (for stat). This is in so
 	 * far inaccurate as it doesn't account for any named streams or other
@@ -1766,7 +1768,7 @@
 	vi->i_generation = ni->seq_no = le16_to_cpu(m->sequence_number);
 
 	/* Provides readpage() and sync_page() for map_mft_record(). */
-	vi->i_mapping->a_ops = &ntfs_mft_aops;
+	vi->i_mapping->a_ops = &ntfs_mst_aops;
 
 	ctx = ntfs_attr_get_search_ctx(ni, m);
 	if (!ctx) {
@@ -2028,8 +2030,6 @@
 			/* No VFS initiated operations allowed for $MFT. */
 			vi->i_op = &ntfs_empty_inode_ops;
 			vi->i_fop = &ntfs_empty_file_ops;
-			/* Put back our special address space operations. */
-			vi->i_mapping->a_ops = &ntfs_mft_aops;
 		}
 
 		/* Get the lowest vcn for the next extent. */
@@ -2514,8 +2514,8 @@
 	 * this function returns.
 	 */
 	if (modified && !NInoTestSetDirty(ctx->ntfs_ino))
-		mark_ntfs_record_dirty(ctx->ntfs_ino, ctx->ntfs_ino->page,
-				ctx->ntfs_ino->page_ofs);
+		mark_ntfs_record_dirty(NTFS_I(ni->vol->mft_ino),
+				ctx->ntfs_ino->page, ctx->ntfs_ino->page_ofs);
 	ntfs_attr_put_search_ctx(ctx);
 	/* Now the access times are updated, write the base mft record. */
 	if (NInoDirty(ni))
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:14:44 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:14:44 +01:00
@@ -32,37 +32,6 @@
 #include "ntfs.h"
 
 /**
- * ntfs_readpage - external declaration, function is in fs/ntfs/aops.c
- */
-extern int ntfs_readpage(struct file *, struct page *);
-
-#ifdef NTFS_RW
-/**
- * ntfs_mft_writepage - forward declaration, function is further below
- */
-static int ntfs_mft_writepage(struct page *page, struct writeback_control *wbc);
-#endif /* NTFS_RW */
-
-/**
- * ntfs_mft_aops - address space operations for access to $MFT
- *
- * Address space operations for access to $MFT. This allows us to simply use
- * ntfs_map_page() in map_mft_record_page().
- */
-struct address_space_operations ntfs_mft_aops = {
-	.readpage	= ntfs_readpage,	/* Fill page with data. */
-	.sync_page	= block_sync_page,	/* Currently, just unplugs the
-						   disk request queue. */
-#ifdef NTFS_RW
-	.writepage	= ntfs_mft_writepage,	/* Write out the dirty mft
-						   records in a page. */
-	.set_page_dirty	= __set_page_dirty_nobuffers,	/* Set the page dirty
-						   without touching the buffers
-						   belonging to the page. */
-#endif /* NTFS_RW */
-};
-
-/**
  * map_mft_record_page - map the page in which a specific mft record resides
  * @ni:		ntfs inode whose mft record page to map
  *
@@ -115,57 +84,6 @@
 }
 
 /**
- * try_map_mft_record - attempt to map, pin and lock an mft record
- * @ni:		ntfs inode whose MFT record to map
- *
- * First, attempt to take the mrec_lock semaphore.  If the semaphore is already
- * taken by someone else, return the error code -EALREADY.  Otherwise continue
- * as described below.
- *
- * The page of the record is mapped using map_mft_record_page() before being
- * returned to the caller.
- *
- * This in turn uses ntfs_map_page() to get the page containing the wanted mft
- * record (it in turn calls read_cache_page() which reads it in from disk if
- * necessary, increments the use count on the page so that it cannot disappear
- * under us and returns a reference to the page cache page).
- *
- * The mft record is now ours and we return a pointer to it.  You need to check
- * the returned pointer with IS_ERR() and if that is true, PTR_ERR() will return
- * the error code.
- *
- * For further details see the description of map_mft_record() below.
- */
-MFT_RECORD *try_map_mft_record(ntfs_inode *ni)
-{
-	MFT_RECORD *m;
-
-	ntfs_debug("Entering for mft_no 0x%lx.", ni->mft_no);
-
-	/* Make sure the ntfs inode doesn't go away. */
-	atomic_inc(&ni->count);
-
-	/*
-	 * Serialize access to this mft record.  If someone else is already
-	 * holding the lock, abort instead of waiting for the lock.
-	 */
-	if (unlikely(down_trylock(&ni->mrec_lock))) {
-		ntfs_debug("Mft record is already locked, aborting.");
-		atomic_dec(&ni->count);
-		return ERR_PTR(-EALREADY);
-	}
-
-	m = map_mft_record_page(ni);
-	if (likely(!IS_ERR(m)))
-		return m;
-
-	up(&ni->mrec_lock);
-	atomic_dec(&ni->count);
-	ntfs_error(ni->vol->sb, "Failed with error code %lu.", -PTR_ERR(m));
-	return m;
-}
-
-/**
  * map_mft_record - map, pin and lock an mft record
  * @ni:		ntfs inode whose MFT record to map
  *
@@ -462,7 +380,8 @@
 
 	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
 	BUG_ON(NInoAttr(ni));
-	mark_ntfs_record_dirty(ni, ni->page, ni->page_ofs);
+	mark_ntfs_record_dirty(NTFS_I(ni->vol->mft_ino), ni->page,
+			ni->page_ofs);
 	/* Determine the base vfs inode and mark it dirty, too. */
 	down(&ni->extent_lock);
 	if (likely(ni->nr_extents >= 0))
@@ -478,13 +397,14 @@
 		"this message.  Thank you.";
 
 /**
- * sync_mft_mirror_umount - synchronise an mft record to the mft mirror
- * @ni:		ntfs inode whose mft record to synchronize
+ * ntfs_sync_mft_mirror_umount - synchronise an mft record to the mft mirror
+ * @vol:	ntfs volume on which the mft record to synchronize resides
+ * @mft_no:	mft record number of mft record to synchronize
  * @m:		mapped, mst protected (extent) mft record to synchronize
  *
- * Write the mapped, mst protected (extent) mft record @m described by the
- * (regular or extent) ntfs inode @ni to the mft mirror ($MFTMirr) bypassing
- * the page cache and the $MFTMirr inode itself.
+ * Write the mapped, mst protected (extent) mft record @m with mft record
+ * number @mft_no to the mft mirror ($MFTMirr) of the ntfs volume @vol,
+ * bypassing the page cache and the $MFTMirr inode itself.
  *
  * This function is only for use at umount time when the mft mirror inode has
  * already been disposed off.  We BUG() if we are called while the mft mirror
@@ -498,10 +418,9 @@
  * alternative would be either to BUG() or to get a NULL pointer dereference
  * and Oops.
  */
-static int sync_mft_mirror_umount(ntfs_inode *ni, MFT_RECORD *m)
+static int ntfs_sync_mft_mirror_umount(ntfs_volume *vol,
+		const unsigned long mft_no, MFT_RECORD *m)
 {
-	ntfs_volume *vol = ni->vol;
-
 	BUG_ON(vol->mftmirr_ino);
 	ntfs_error(vol->sb, "Umount time mft mirror syncing is not "
 			"implemented yet.  %s", ntfs_please_email);
@@ -509,25 +428,26 @@
 }
 
 /**
- * sync_mft_mirror - synchronize an mft record to the mft mirror
- * @ni:		ntfs inode whose mft record to synchronize
+ * ntfs_sync_mft_mirror - synchronize an mft record to the mft mirror
+ * @vol:	ntfs volume on which the mft record to synchronize resides
+ * @mft_no:	mft record number of mft record to synchronize
  * @m:		mapped, mst protected (extent) mft record to synchronize
  * @sync:	if true, wait for i/o completion
  *
- * Write the mapped, mst protected (extent) mft record @m described by the
- * (regular or extent) ntfs inode @ni to the mft mirror ($MFTMirr).
+ * Write the mapped, mst protected (extent) mft record @m with mft record
+ * number @mft_no to the mft mirror ($MFTMirr) of the ntfs volume @vol.
  *
  * On success return 0.  On error return -errno and set the volume errors flag
- * in the ntfs_volume to which @ni belongs.
+ * in the ntfs volume @vol.
  *
  * NOTE:  We always perform synchronous i/o and ignore the @sync parameter.
  *
  * TODO:  If @sync is false, want to do truly asynchronous i/o, i.e. just
  * schedule i/o via ->writepage or do it via kntfsd or whatever.
  */
-static int sync_mft_mirror(ntfs_inode *ni, MFT_RECORD *m, int sync)
+int ntfs_sync_mft_mirror(ntfs_volume *vol, const unsigned long mft_no,
+		MFT_RECORD *m, int sync)
 {
-	ntfs_volume *vol = ni->vol;
 	struct page *page;
 	unsigned int blocksize = vol->sb->s_blocksize;
 	int max_bhs = vol->mft_record_size / blocksize;
@@ -537,17 +457,17 @@
 	unsigned int block_start, block_end, m_start, m_end;
 	int i_bhs, nr_bhs, err = 0;
 
-	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
+	ntfs_debug("Entering for inode 0x%lx.", mft_no);
 	BUG_ON(!max_bhs);
 	if (unlikely(!vol->mftmirr_ino)) {
 		/* This could happen during umount... */
-		err = sync_mft_mirror_umount(ni, m);
+		err = ntfs_sync_mft_mirror_umount(vol, mft_no, m);
 		if (likely(!err))
 			return err;
 		goto err_out;
 	}
 	/* Get the page containing the mirror copy of the mft record @m. */
-	page = ntfs_map_page(vol->mftmirr_ino->i_mapping, ni->mft_no >>
+	page = ntfs_map_page(vol->mftmirr_ino->i_mapping, mft_no >>
 			(PAGE_CACHE_SHIFT - vol->mft_record_size_bits));
 	if (IS_ERR(page)) {
 		ntfs_error(vol->sb, "Failed to map mft mirror page.");
@@ -561,23 +481,17 @@
 	 * make sure no one is writing from elsewhere.
 	 */
 	lock_page(page);
+	BUG_ON(!PageUptodate(page));
+	ClearPageUptodate(page);
 	/* The address in the page of the mirror copy of the mft record @m. */
-	kmirr = page_address(page) + ((ni->mft_no << vol->mft_record_size_bits)
-			& ~PAGE_CACHE_MASK);
+	kmirr = page_address(page) + ((mft_no << vol->mft_record_size_bits) &
+			~PAGE_CACHE_MASK);
 	/* Copy the mst protected mft record to the mirror. */
 	memcpy(kmirr, m, vol->mft_record_size);
 	/* Make sure we have mapped buffers. */
-	if (!page_has_buffers(page)) {
-no_buffers_err_out:
-		ntfs_error(vol->sb, "Writing mft mirror records without "
-				"existing buffers is not implemented yet.  %s",
-				ntfs_please_email);
-		err = -EOPNOTSUPP;
-		goto unlock_err_out;
-	}
+	BUG_ON(!page_has_buffers(page));
 	bh = head = page_buffers(page);
-	if (!bh)
-		goto no_buffers_err_out;
+	BUG_ON(!bh);
 	nr_bhs = 0;
 	block_start = 0;
 	m_start = kmirr - (u8*)page_address(page);
@@ -587,22 +501,8 @@
 		/* If the buffer is outside the mft record, skip it. */
 		if ((block_end <= m_start) || (block_start >= m_end))
 			continue;
-		if (!buffer_mapped(bh)) {
-			ntfs_error(vol->sb, "Writing mft mirror records "
-					"without existing mapped buffers is "
-					"not implemented yet.  %s",
-					ntfs_please_email);
-			err = -EOPNOTSUPP;
-			continue;
-		}
-		if (!buffer_uptodate(bh)) {
-			ntfs_error(vol->sb, "Writing mft mirror records "
-					"without existing uptodate buffers is "
-					"not implemented yet.  %s",
-					ntfs_please_email);
-			err = -EOPNOTSUPP;
-			continue;
-		}
+		BUG_ON(!buffer_mapped(bh));
+		BUG_ON(!buffer_uptodate(bh));
 		BUG_ON(!nr_bhs && (m_start != block_start));
 		BUG_ON(nr_bhs >= max_bhs);
 		bhs[nr_bhs++] = bh;
@@ -630,11 +530,10 @@
 			if (unlikely(!buffer_uptodate(tbh))) {
 				err = -EIO;
 				/*
-				 * Set the buffer uptodate so the page & buffer
-				 * states don't become out of sync.
+				 * Set the buffer uptodate so the page and
+				 * buffer states do not become out of sync.
 				 */
-				if (PageUptodate(page))
-					set_buffer_uptodate(tbh);
+				set_buffer_uptodate(tbh);
 			}
 		}
 	} else /* if (unlikely(err)) */ {
@@ -642,29 +541,25 @@
 		for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++)
 			clear_buffer_dirty(bhs[i_bhs]);
 	}
-unlock_err_out:
 	/* Current state: all buffers are clean, unlocked, and uptodate. */
 	/* Remove the mst protection fixups again. */
 	post_write_mst_fixup((NTFS_RECORD*)kmirr);
 	flush_dcache_page(page);
+	SetPageUptodate(page);
 	unlock_page(page);
 	ntfs_unmap_page(page);
-	if (unlikely(err)) {
-		/* I/O error during writing.  This is really bad! */
+	if (likely(!err)) {
+		ntfs_debug("Done.");
+	} else {
 		ntfs_error(vol->sb, "I/O error while writing mft mirror "
-				"record 0x%lx!  You should unmount the volume "
-				"and run chkdsk or ntfsfix.", ni->mft_no);
-		goto err_out;
-	}
-	ntfs_debug("Done.");
-	return 0;
+				"record 0x%lx!", mft_no);
 err_out:
-	ntfs_error(vol->sb, "Failed to synchronize $MFTMirr (error code %i).  "
-			"Volume will be left marked dirty on umount.  Run "
-			"ntfsfix on the partition after umounting to correct "
-			"this.", -err);
-	/* We don't want to clear the dirty bit on umount. */
-	NVolSetErrors(vol);
+		ntfs_error(vol->sb, "Failed to synchronize $MFTMirr (error "
+				"code %i).  Volume will be left marked dirty "
+				"on umount.  Run ntfsfix on the partition "
+				"after umounting to correct this.", -err);
+		NVolSetErrors(vol);
+	}
 	return err;
 }
 
@@ -785,7 +680,7 @@
 	}
 	/* Synchronize the mft mirror now if not @sync. */
 	if (!sync && ni->mft_no < vol->mftmirr_size)
-		sync_mft_mirror(ni, m, sync);
+		ntfs_sync_mft_mirror(vol, ni->mft_no, m, sync);
 	/* Wait on i/o completion of buffers. */
 	for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++) {
 		struct buffer_head *tbh = bhs[i_bhs];
@@ -803,7 +698,7 @@
 	}
 	/* If @sync, now synchronize the mft mirror. */
 	if (sync && ni->mft_no < vol->mftmirr_size)
-		sync_mft_mirror(ni, m, sync);
+		ntfs_sync_mft_mirror(vol, ni->mft_no, m, sync);
 	/* Remove the mst protection fixups again. */
 	post_write_mst_fixup((NTFS_RECORD*)m);
 	flush_dcache_mft_record_page(ni);
@@ -839,221 +734,257 @@
 }
 
 /**
- * ntfs_mft_writepage - check if a metadata page contains dirty mft records
- * @page:	metadata page possibly containing dirty mft records
- * @wbc:	writeback control structure
- *
- * This is called from the VM when it wants to have a dirty $MFT/$DATA metadata
- * page cache page cleaned.  The VM has already locked the page and marked it
- * clean.  Instead of writing the page as a conventional ->writepage function
- * would do, we check if the page still contains any dirty mft records (it must
- * have done at some point in the past since the page was marked dirty) and if
- * none are found, i.e. all mft records are clean, we unlock the page and
- * return.  The VM is then free to do with the page as it pleases.  If on the
- * other hand we do find any dirty mft records in the page, we redirty the page
- * before unlocking it and returning so the VM knows that the page is still
- * busy and cannot be thrown out.
- *
- * Note, we do not actually write any dirty mft records here because they are
- * dirty inodes and hence will be written by the VFS inode dirty code paths.
- * There is no need to write them from the VM page dirty code paths, too and in
- * fact once we implement journalling it would be a complete nightmare having
- * two code paths leading to mft record writeout.
+ * ntfs_may_write_mft_record - check if an mft record may be written out
+ * @vol:	[IN]  ntfs volume on which the mft record to check resides
+ * @mft_no:	[IN]  mft record number of the mft record to check
+ * @m:		[IN]  mapped mft record to check
+ * @locked_ni:	[OUT] caller has to unlock this ntfs inode if one is returned
+ *
+ * Check if the mapped (base or extent) mft record @m with mft record number
+ * @mft_no belonging to the ntfs volume @vol may be written out.  If necessary
+ * and possible the ntfs inode of the mft record is locked and the base vfs
+ * inode is pinned.  The locked ntfs inode is then returned in @locked_ni.  The
+ * caller is responsible for unlocking the ntfs inode and unpinning the base
+ * vfs inode.
+ *
+ * Return TRUE if the mft record may be written out and FALSE if not.
+ *
+ * The caller has locked the page and cleared the uptodate flag on it which
+ * means that we can safely write out any dirty mft records that do not have
+ * their inodes in icache as determined by ilookup5() as anyone
+ * opening/creating such an inode would block when attempting to map the mft
+ * record in read_cache_page() until we are finished with the write out.
+ *
+ * Here is a description of the tests we perform:
+ *
+ * If the inode is found in icache we know the mft record must be a base mft
+ * record.  If it is dirty, we do not write it and return FALSE as the vfs
+ * inode write paths will result in the access times being updated which would
+ * cause the base mft record to be redirtied and written out again.  (We know
+ * the access time update will modify the base mft record because Windows
+ * chkdsk complains if the standard information attribute is not in the base
+ * mft record.)
+ *
+ * If the inode is in icache and not dirty, we attempt to lock the mft record
+ * and if we find the lock was already taken, it is not safe to write the mft
+ * record and we return FALSE.
+ *
+ * If we manage to obtain the lock we have exclusive access to the mft record,
+ * which also allows us safe writeout of the mft record.  We then set
+ * @locked_ni to the locked ntfs inode and return TRUE.
+ *
+ * Note we cannot just lock the mft record and sleep while waiting for the lock
+ * because this would deadlock due to lock reversal (normally the mft record is
+ * locked before the page is locked but we already have the page locked here
+ * when we try to lock the mft record).
+ *
+ * If the inode is not in icache we need to perform further checks.
+ *
+ * If the mft record is not a FILE record or it is a base mft record, we can
+ * safely write it and return TRUE.
+ *
+ * We now know the mft record is an extent mft record.  We check if the inode
+ * corresponding to its base mft record is in icache and obtain a reference to
+ * it if it is.  If it is not, we can safely write it and return TRUE.
+ *
+ * We now have the base inode for the extent mft record.  We check if it has an
+ * ntfs inode for the extent mft record attached and if not it is safe to write
+ * the extent mft record and we return TRUE.
+ *
+ * The ntfs inode for the extent mft record is attached to the base inode so we
+ * attempt to lock the extent mft record and if we find the lock was already
+ * taken, it is not safe to write the extent mft record and we return FALSE.
+ *
+ * If we manage to obtain the lock we have exclusive access to the extent mft
+ * record, which also allows us safe writeout of the extent mft record.  We
+ * set the ntfs inode of the extent mft record clean and then set @locked_ni to
+ * the now locked ntfs inode and return TRUE.
+ *
+ * Note, the reason for actually writing dirty mft records here and not just
+ * relying on the vfs inode dirty code paths is that we can have mft records
+ * modified without them ever having actual inodes in memory.  Also we can have
+ * dirty mft records with clean ntfs inodes in memory.  None of the described
+ * cases would result in the dirty mft records being written out if we only
+ * relied on the vfs inode dirty code paths.  And these cases can really occur
+ * during allocation of new mft records and in particular when the
+ * initialized_size of the $MFT/$DATA attribute is extended and the new space
+ * is initialized using ntfs_mft_record_format().  The clean inode can then
+ * appear if the mft record is reused for a new inode before it got written
+ * out.
  */
-static int ntfs_mft_writepage(struct page *page, struct writeback_control *wbc)
+BOOL ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
+		const MFT_RECORD *m, ntfs_inode **locked_ni)
 {
-	struct inode *mft_vi = page->mapping->host;
-	struct super_block *sb = mft_vi->i_sb;
-	ntfs_volume *vol = NTFS_SB(sb);
-	u8 *maddr;
-	MFT_RECORD *m;
-	ntfs_inode **extent_nis;
-	unsigned long mft_no;
-	int nr, i, j;
-	BOOL is_dirty = FALSE;
+	struct super_block *sb = vol->sb;
+	struct inode *mft_vi = vol->mft_ino;
+	struct inode *vi;
+	ntfs_inode *ni, *eni, **extent_nis;
+	int i;
+	ntfs_attr na;
 
-	BUG_ON(!PageLocked(page));
-	BUG_ON(PageWriteback(page));
-	BUG_ON(mft_vi != vol->mft_ino);
-	/* The first mft record number in the page. */
-	mft_no = page->index << (PAGE_CACHE_SHIFT - vol->mft_record_size_bits);
-	/* Number of mft records in the page. */
-	nr = PAGE_CACHE_SIZE >> vol->mft_record_size_bits;
-	BUG_ON(!nr);
-	ntfs_debug("Entering for %i inodes starting at 0x%lx.", nr, mft_no);
-	/* Iterate over the mft records in the page looking for a dirty one. */
-	maddr = (u8*)kmap(page);
+	ntfs_debug("Entering for inode 0x%lx.", mft_no);
 	/*
-	 * Clear the page uptodate flag.  This will cause anyone trying to get
-	 * hold of the page to block on the page lock in read_cache_page().
+	 * Normally we do not return a locked inode so set @locked_ni to NULL.
 	 */
-	BUG_ON(!PageUptodate(page));
-	ClearPageUptodate(page);
-	for (i = 0; i < nr; ++i, ++mft_no, maddr += vol->mft_record_size) {
-		struct inode *vi;
-		ntfs_inode *ni, *eni;
-		ntfs_attr na;
-
-		na.mft_no = mft_no;
-		na.name = NULL;
-		na.name_len = 0;
-		na.type = AT_UNUSED;
-		/*
-		 * Check if the inode corresponding to this mft record is in
-		 * the VFS inode cache and obtain a reference to it if it is.
-		 */
-		ntfs_debug("Looking for inode 0x%lx in icache.", mft_no);
-		/*
-		 * For inode 0, i.e. $MFT itself, we cannot use ilookup5() from
-		 * here or we deadlock because the inode is already locked by
-		 * the kernel (fs/fs-writeback.c::__sync_single_inode()) and
-		 * ilookup5() waits until the inode is unlocked before
-		 * returning it and it never gets unlocked because
-		 * ntfs_mft_writepage() never returns.  )-:  Fortunately, we
-		 * have inode 0 pinned in icache for the duration of the mount
-		 * so we can access it directly.
-		 */
-		if (!mft_no) {
-			/* Balance the below iput(). */
-			vi = igrab(mft_vi);
-			BUG_ON(vi != mft_vi);
-		} else
-			vi = ilookup5(sb, mft_no, (test_t)ntfs_test_inode, &na);
-		if (vi) {
-			ntfs_debug("Inode 0x%lx is in icache.", mft_no);
-			/* The inode is in icache.  Check if it is dirty. */
-			ni = NTFS_I(vi);
-			if (!NInoDirty(ni)) {
-				/* The inode is not dirty, skip this record. */
-				ntfs_debug("Inode 0x%lx is not dirty, "
-						"continuing search.", mft_no);
-				iput(vi);
-				continue;
-			}
-			ntfs_debug("Inode 0x%lx is dirty, aborting search.",
+	BUG_ON(!locked_ni);
+	*locked_ni = NULL;
+	/*
+	 * Check if the inode corresponding to this mft record is in the VFS
+	 * inode cache and obtain a reference to it if it is.
+	 */
+	ntfs_debug("Looking for inode 0x%lx in icache.", mft_no);
+	na.mft_no = mft_no;
+	na.name = NULL;
+	na.name_len = 0;
+	na.type = AT_UNUSED;
+	/*
+	 * For inode 0, i.e. $MFT itself, we cannot use ilookup5() from here or
+	 * we deadlock because the inode is already locked by the kernel
+	 * (fs/fs-writeback.c::__sync_single_inode()) and ilookup5() waits
+	 * until the inode is unlocked before returning it and it never gets
+	 * unlocked because ntfs_should_write_mft_record() never returns.  )-:
+	 * Fortunately, we have inode 0 pinned in icache for the duration of
+	 * the mount so we can access it directly.
+	 */
+	if (!mft_no) {
+		/* Balance the below iput(). */
+		vi = igrab(mft_vi);
+		BUG_ON(vi != mft_vi);
+	} else
+		vi = ilookup5(sb, mft_no, (test_t)ntfs_test_inode, &na);
+	if (vi) {
+		ntfs_debug("Base inode 0x%lx is in icache.", mft_no);
+		/* The inode is in icache. */
+		ni = NTFS_I(vi);
+		/* Take a reference to the ntfs inode. */
+		atomic_inc(&ni->count);
+		/* If the inode is dirty, do not write this record. */
+		if (NInoDirty(ni)) {
+			ntfs_debug("Inode 0x%lx is dirty, do not write it.",
 					mft_no);
-			/* The inode is dirty, no need to search further. */
+			atomic_dec(&ni->count);
 			iput(vi);
-			is_dirty = TRUE;
-			break;
+			return FALSE;
 		}
-		ntfs_debug("Inode 0x%lx is not in icache.", mft_no);
-		/* The inode is not in icache. */
-		/* Skip the record if it is not a mft record (type "FILE"). */
-		if (!ntfs_is_mft_recordp((le32*)maddr)) {
-			ntfs_debug("Mft record 0x%lx is not a FILE record, "
-					"continuing search.", mft_no);
-			continue;
+		ntfs_debug("Inode 0x%lx is not dirty.", mft_no);
+		/* The inode is not dirty, try to take the mft record lock. */
+		if (unlikely(down_trylock(&ni->mrec_lock))) {
+			ntfs_debug("Mft record 0x%lx is already locked, do "
+					"not write it.", mft_no);
+			atomic_dec(&ni->count);
+			iput(vi);
+			return FALSE;
 		}
-		m = (MFT_RECORD*)maddr;
+		ntfs_debug("Managed to lock mft record 0x%lx, write it.",
+				mft_no);
 		/*
-		 * Skip the mft record if it is not in use.  FIXME:  What about
-		 * deleted/deallocated (extent) inodes?  (AIA)
+		 * The write has to occur while we hold the mft record lock so
+		 * return the locked ntfs inode.
 		 */
-		if (!(m->flags & MFT_RECORD_IN_USE)) {
-			ntfs_debug("Mft record 0x%lx is not in use, "
-					"continuing search.", mft_no);
-			continue;
-		}
-		/* Skip the mft record if it is a base inode. */
-		if (!m->base_mft_record) {
-			ntfs_debug("Mft record 0x%lx is a base record, "
-					"continuing search.", mft_no);
-			continue;
-		}
+		*locked_ni = ni;
+		return TRUE;
+	}
+	ntfs_debug("Inode 0x%lx is not in icache.", mft_no);
+	/* The inode is not in icache. */
+	/* Write the record if it is not a mft record (type "FILE"). */
+	if (!ntfs_is_mft_record(m->magic)) {
+		ntfs_debug("Mft record 0x%lx is not a FILE record, write it.",
+				mft_no);
+		return TRUE;
+	}
+	/* Write the mft record if it is a base inode. */
+	if (!m->base_mft_record) {
+		ntfs_debug("Mft record 0x%lx is a base record, write it.",
+				mft_no);
+		return TRUE;
+	}
+	/*
+	 * This is an extent mft record.  Check if the inode corresponding to
+	 * its base mft record is in icache and obtain a reference to it if it
+	 * is.
+	 */
+	na.mft_no = MREF_LE(m->base_mft_record);
+	ntfs_debug("Mft record 0x%lx is an extent record.  Looking for base "
+			"inode 0x%lx in icache.", mft_no, na.mft_no);
+	vi = ilookup5(sb, na.mft_no, (test_t)ntfs_test_inode, &na);
+	if (!vi) {
 		/*
-		 * This is an extent mft record.  Check if the inode
-		 * corresponding to its base mft record is in icache.
+		 * The base inode is not in icache, write this extent mft
+		 * record.
 		 */
-		na.mft_no = MREF_LE(m->base_mft_record);
-		ntfs_debug("Mft record 0x%lx is an extent record.  Looking "
-				"for base inode 0x%lx in icache.", mft_no,
-				na.mft_no);
-		vi = ilookup5(sb, na.mft_no, (test_t)ntfs_test_inode,
-				&na);
-		if (!vi) {
-			/*
-			 * The base inode is not in icache.  Skip this extent
-			 * mft record.
-			 */
-			ntfs_debug("Base inode 0x%lx is not in icache, "
-					"continuing search.", na.mft_no);
-			continue;
-		}
-		ntfs_debug("Base inode 0x%lx is in icache.", na.mft_no);
+		ntfs_debug("Base inode 0x%lx is not in icache, write the "
+				"extent record.", na.mft_no);
+		return TRUE;
+	}
+	ntfs_debug("Base inode 0x%lx is in icache.", na.mft_no);
+	/*
+	 * The base inode is in icache.  Check if it has the extent inode
+	 * corresponding to this extent mft record attached.
+	 */
+	ni = NTFS_I(vi);
+	down(&ni->extent_lock);
+	if (ni->nr_extents <= 0) {
 		/*
-		 * The base inode is in icache.  Check if it has the extent
-		 * inode corresponding to this extent mft record attached.
+		 * The base inode has no attached extent inodes, write this
+		 * extent mft record.
 		 */
-		ni = NTFS_I(vi);
-		down(&ni->extent_lock);
-		if (ni->nr_extents <= 0) {
+		up(&ni->extent_lock);
+		iput(vi);
+		ntfs_debug("Base inode 0x%lx has no attached extent inodes, "
+				"write the extent record.", na.mft_no);
+		return TRUE;
+	}
+	/* Iterate over the attached extent inodes. */
+	extent_nis = ni->ext.extent_ntfs_inos;
+	for (eni = NULL, i = 0; i < ni->nr_extents; ++i) {
+		if (mft_no == extent_nis[i]->mft_no) {
 			/*
-			 * The base inode has no attached extent inodes.  Skip
-			 * this extent mft record.
+			 * Found the extent inode corresponding to this extent
+			 * mft record.
 			 */
-			up(&ni->extent_lock);
-			iput(vi);
-			continue;
-		}
-		/* Iterate over the attached extent inodes. */
-		extent_nis = ni->ext.extent_ntfs_inos;
-		for (eni = NULL, j = 0; j < ni->nr_extents; ++j) {
-			if (mft_no == extent_nis[j]->mft_no) {
-				/*
-				 * Found the extent inode corresponding to this
-				 * extent mft record.
-				 */
-				eni = extent_nis[j];
-				break;
-			}
-		}
-		/*
-		 * If the extent inode was not attached to the base inode, skip
-		 * this extent mft record.
-		 */
-		if (!eni) {
-			up(&ni->extent_lock);
-			iput(vi);
-			continue;
-		}
-		/*
-		 * Found the extent inode corrsponding to this extent mft
-		 * record.  If it is dirty, no need to search further.
-		 */
-		if (NInoDirty(eni)) {
-			up(&ni->extent_lock);
-			iput(vi);
-			is_dirty = TRUE;
+			eni = extent_nis[i];
 			break;
 		}
-		/* The extent inode is not dirty, so do the next record. */
+	}
+	/*
+	 * If the extent inode was not attached to the base inode, write this
+	 * extent mft record.
+	 */
+	if (!eni) {
 		up(&ni->extent_lock);
 		iput(vi);
-	}
-	SetPageUptodate(page);
-	kunmap(page);
-	/* If a dirty mft record was found, redirty the page. */
-	if (is_dirty) {
-		ntfs_debug("Inode 0x%lx is dirty.  Redirtying the page "
-				"starting at inode 0x%lx.", mft_no,
-				page->index << (PAGE_CACHE_SHIFT -
-				vol->mft_record_size_bits));
-		redirty_page_for_writepage(wbc, page);
-		unlock_page(page);
-	} else {
-		/*
-		 * Keep the VM happy.  This must be done otherwise the
-		 * radix-tree tag PAGECACHE_TAG_DIRTY remains set even though
-		 * the page is clean.
-		 */
-		BUG_ON(PageWriteback(page));
-		set_page_writeback(page);
-		unlock_page(page);
-		end_page_writeback(page);
-	}
-	ntfs_debug("Done.");
-	return 0;
+		ntfs_debug("Extent inode 0x%lx is not attached to its base "
+				"inode 0x%lx, write the extent record.",
+				mft_no, na.mft_no);
+		return TRUE;
+	}
+	ntfs_debug("Extent inode 0x%lx is attached to its base inode 0x%lx.",
+			mft_no, na.mft_no);
+	/* Take a reference to the extent ntfs inode. */
+	atomic_inc(&eni->count);
+	up(&ni->extent_lock);
+	/*
+	 * Found the extent inode coresponding to this extent mft record.
+	 * Try to take the mft record lock.
+	 */
+	if (unlikely(down_trylock(&eni->mrec_lock))) {
+		atomic_dec(&eni->count);
+		iput(vi);
+		ntfs_debug("Extent mft record 0x%lx is already locked, do "
+				"not write it.", mft_no);
+		return FALSE;
+	}
+	ntfs_debug("Managed to lock extent mft record 0x%lx, write it.",
+			mft_no);
+	if (NInoTestClearDirty(eni))
+		ntfs_debug("Extent inode 0x%lx is dirty, marking it clean.",
+				mft_no);
+	/*
+	 * The write has to occur while we hold the mft record lock so return
+	 * the locked extent ntfs inode.
+	 */
+	*locked_ni = eni;
+	return TRUE;
 }
 
 static const char *es = "  Leaving inconsistent metadata.  Unmount and run "
diff -Nru a/fs/ntfs/mft.h b/fs/ntfs/mft.h
--- a/fs/ntfs/mft.h	2004-10-19 10:14:44 +01:00
+++ b/fs/ntfs/mft.h	2004-10-19 10:14:44 +01:00
@@ -29,7 +29,6 @@
 
 #include "inode.h"
 
-extern MFT_RECORD *try_map_mft_record(ntfs_inode *ni);
 extern MFT_RECORD *map_mft_record(ntfs_inode *ni);
 extern void unmap_mft_record(ntfs_inode *ni);
 
@@ -77,6 +76,9 @@
 		__mark_mft_record_dirty(ni);
 }
 
+extern int ntfs_sync_mft_mirror(ntfs_volume *vol, const unsigned long mft_no,
+		MFT_RECORD *m, int sync);
+
 extern int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync);
 
 /**
@@ -111,6 +113,10 @@
 	unlock_page(page);
 	return err;
 }
+
+extern BOOL ntfs_may_write_mft_record(ntfs_volume *vol,
+		const unsigned long mft_no, const MFT_RECORD *m,
+		ntfs_inode **locked_ni);
 
 extern int ntfs_extent_mft_record_free(ntfs_inode *ni, MFT_RECORD *m);
 
diff -Nru a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
--- a/fs/ntfs/ntfs.h	2004-10-19 10:14:44 +01:00
+++ b/fs/ntfs/ntfs.h	2004-10-19 10:14:44 +01:00
@@ -56,7 +56,6 @@
 extern struct super_operations ntfs_sops;
 extern struct address_space_operations ntfs_aops;
 extern struct address_space_operations ntfs_mst_aops;
-extern struct address_space_operations ntfs_mft_aops;
 
 extern struct  file_operations ntfs_file_ops;
 extern struct inode_operations ntfs_file_inode_ops;
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-10-19 10:14:44 +01:00
+++ b/fs/ntfs/super.c	2004-10-19 10:14:44 +01:00
@@ -946,8 +946,8 @@
 	/* No VFS initiated operations allowed for $MFTMirr. */
 	tmp_ino->i_op = &ntfs_empty_inode_ops;
 	tmp_ino->i_fop = &ntfs_empty_file_ops;
-	/* Put back our special address space operations. */
-	tmp_ino->i_mapping->a_ops = &ntfs_mft_aops;
+	/* Put in our special address space operations. */
+	tmp_ino->i_mapping->a_ops = &ntfs_mst_aops;
 	tmp_ni = NTFS_I(tmp_ino);
 	/* The $MFTMirr, like the $MFT is multi sector transfer protected. */
 	NInoSetMstProtected(tmp_ni);
