Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUKJOuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUKJOuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUKJOqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:46:45 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:38274 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261886AbUKJNpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:47 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 23/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsn6-0006Si-FP@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:40 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 23/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/09 1.2026.1.63)
   NTFS: - Add mapping of unmapped buffers to all remaining code paths, i.e.
           fs/ntfs/aops.c::ntfs_write_mst_block(), mft.c::ntfs_sync_mft_mirror(),
           and write_mft_record_nolock().  From now on we require that the
           complete runlist for the mft mirror is always mapped into memory.
         - Add creation of buffers to fs/ntfs/mft.c::ntfs_sync_mft_mirror().
         - Do not check for the page being uptodate in mark_ntfs_record_dirty()
           as we now call this after marking the page not uptodate during mft
           mirror synchronisation (fs/ntfs/mft.c::ntfs_sync_mft_mirror()).
         - Improve error handling in fs/ntfs/aops.c::ntfs_{read,write}_block().
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:45:44 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:45:44 +00:00
@@ -84,6 +84,15 @@
 	- Fix error handling in fs/ntfs/quota.c::ntfs_mark_quotas_out_of_date()
 	  where we failed to release i_sem on the $Quota/$Q attribute inode.
 	- Fix bug in handling of bad inodes in fs/ntfs/namei.c::ntfs_lookup().
+	- Add mapping of unmapped buffers to all remaining code paths, i.e.
+	  fs/ntfs/aops.c::ntfs_write_mst_block(), mft.c::ntfs_sync_mft_mirror(),
+	  and write_mft_record_nolock().  From now on we require that the
+	  complete runlist for the mft mirror is always mapped into memory.
+	- Add creation of buffers to fs/ntfs/mft.c::ntfs_sync_mft_mirror().
+	- Do not check for the page being uptodate in mark_ntfs_record_dirty()
+	  as we now call this after marking the page not uptodate during mft
+	  mirror synchronisation (fs/ntfs/mft.c::ntfs_sync_mft_mirror()).
+	- Improve error handling in fs/ntfs/aops.c::ntfs_{read,write}_block().
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-11-10 13:45:44 +00:00
+++ b/fs/ntfs/aops.c	2004-11-10 13:45:44 +00:00
@@ -175,6 +175,9 @@
 	ni = NTFS_I(page->mapping->host);
 	vol = ni->vol;
 
+	/* $MFT/$DATA must have its complete runlist in memory at all times. */
+	BUG_ON(!ni->runlist.rl && !ni->mft_no && !NInoAttr(ni));
+
 	blocksize_bits = VFS_I(ni)->i_blkbits;
 	blocksize = 1 << blocksize_bits;
 
@@ -190,12 +193,6 @@
 	lblock = (ni->allocated_size + blocksize - 1) >> blocksize_bits;
 	zblock = (ni->initialized_size + blocksize - 1) >> blocksize_bits;
 
-#ifdef DEBUG
-	if (unlikely(!ni->runlist.rl && !ni->mft_no && !NInoAttr(ni)))
-		panic("NTFS: $MFT/$DATA runlist has been unmapped! This is a "
-				"very serious bug! Cannot continue...");
-#endif
-
 	/* Loop through all the buffers in the page. */
 	rl = NULL;
 	nr = i = 0;
@@ -249,24 +246,30 @@
 				goto handle_hole;
 			/* If first try and runlist unmapped, map and retry. */
 			if (!is_retry && lcn == LCN_RL_NOT_MAPPED) {
+				int err;
 				is_retry = TRUE;
 				/*
 				 * Attempt to map runlist, dropping lock for
 				 * the duration.
 				 */
 				up_read(&ni->runlist.lock);
-				if (!ntfs_map_runlist(ni, vcn))
+				err = ntfs_map_runlist(ni, vcn);
+				if (likely(!err))
 					goto lock_retry_remap;
 				rl = NULL;
+				lcn = err;
 			}
 			/* Hard error, zero out region. */
+			bh->b_blocknr = -1;
 			SetPageError(page);
-			ntfs_error(vol->sb, "ntfs_rl_vcn_to_lcn(vcn = 0x%llx) "
-					"failed with error code 0x%llx%s.",
-					(unsigned long long)vcn,
-					(unsigned long long)-lcn,
-					is_retry ? " even after retrying" : "");
-			// FIXME: Depending on vol->on_errors, do something.
+			ntfs_error(vol->sb, "Failed to read from inode 0x%lx, "
+					"attribute type 0x%x, vcn 0x%llx, "
+					"offset 0x%x because its location on "
+					"disk could not be determined%s "
+					"(error code %lli).", ni->mft_no,
+					ni->type, (unsigned long long)vcn,
+					vcn_ofs, is_retry ? " even after "
+					"retrying" : "", (long long)lcn);
 		}
 		/*
 		 * Either iblock was outside lblock limits or
@@ -437,8 +440,8 @@
 
 /**
  * ntfs_write_block - write a @page to the backing store
- * @wbc:	writeback control structure
  * @page:	page cache page to write out
+ * @wbc:	writeback control structure
  *
  * This function is for writing pages belonging to non-resident, non-mst
  * protected attributes to their backing store.
@@ -457,7 +460,7 @@
  *
  * Based on ntfs_read_block() and __block_write_full_page().
  */
-static int ntfs_write_block(struct writeback_control *wbc, struct page *page)
+static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 {
 	VCN vcn;
 	LCN lcn;
@@ -477,7 +480,7 @@
 	vol = ni->vol;
 
 	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
-			"0x%lx.", vi->i_ino, ni->type, page->index);
+			"0x%lx.", ni->mft_no, ni->type, page->index);
 
 	BUG_ON(!NInoNonResident(ni));
 	BUG_ON(NInoMstProtected(ni));
@@ -618,9 +621,9 @@
 		bh->b_bdev = vol->sb->s_bdev;
 
 		/* Convert block into corresponding vcn and offset. */
-		vcn = (VCN)block << blocksize_bits >> vol->cluster_size_bits;
-		vcn_ofs = ((VCN)block << blocksize_bits) &
-				vol->cluster_size_mask;
+		vcn = (VCN)block << blocksize_bits;
+		vcn_ofs = vcn & vol->cluster_size_mask;
+		vcn >>= vol->cluster_size_bits;
 		if (!rl) {
 lock_retry_remap:
 			down_read(&ni->runlist.lock);
@@ -663,15 +666,17 @@
 			if (likely(!err))
 				goto lock_retry_remap;
 			rl = NULL;
+			lcn = err;
 		}
 		/* Failed to map the buffer, even after retrying. */
-		bh->b_blocknr = -1UL;
-		ntfs_error(vol->sb, "ntfs_rl_vcn_to_lcn(vcn = 0x%llx) failed "
-				"with error code 0x%llx%s.",
-				(unsigned long long)vcn,
-				(unsigned long long)-lcn,
-				is_retry ? " even after retrying" : "");
-		// FIXME: Depending on vol->on_errors, do something.
+		bh->b_blocknr = -1;
+		ntfs_error(vol->sb, "Failed to write to inode 0x%lx, "
+				"attribute type 0x%x, vcn 0x%llx, offset 0x%x "
+				"because its location on disk could not be "
+				"determined%s (error code %lli).", ni->mft_no,
+				ni->type, (unsigned long long)vcn,
+				vcn_ofs, is_retry ? " even after "
+				"retrying" : "", (long long)lcn);
 		if (!err)
 			err = -EIO;
 		break;
@@ -767,8 +772,8 @@
 
 /**
  * ntfs_write_mst_block - write a @page to the backing store
- * @wbc:	writeback control structure
  * @page:	page cache page to write out
+ * @wbc:	writeback control structure
  *
  * This function is for writing pages belonging to non-resident, mst protected
  * attributes to their backing store.  The only supported attributes are index
@@ -789,22 +794,24 @@
  * Based on ntfs_write_block(), ntfs_mft_writepage(), and
  * write_mft_record_nolock().
  */
-static int ntfs_write_mst_block(struct writeback_control *wbc,
-		struct page *page)
+static int ntfs_write_mst_block(struct page *page,
+		struct writeback_control *wbc)
 {
 	sector_t block, dblock, rec_block;
 	struct inode *vi = page->mapping->host;
 	ntfs_inode *ni = NTFS_I(vi);
 	ntfs_volume *vol = ni->vol;
 	u8 *kaddr;
-	unsigned int bh_size = 1 << vi->i_blkbits;
+	unsigned char bh_size_bits = vi->i_blkbits;
+	unsigned int bh_size = 1 << bh_size_bits;
 	unsigned int rec_size = ni->itype.index.block_size;
 	ntfs_inode *locked_nis[PAGE_CACHE_SIZE / rec_size];
-	struct buffer_head *bh, *head, *tbh;
+	struct buffer_head *bh, *head, *tbh, *rec_start_bh;
 	int max_bhs = PAGE_CACHE_SIZE / bh_size;
 	struct buffer_head *bhs[max_bhs];
-	int i, nr_locked_nis, nr_recs, nr_bhs, bhs_per_rec, err;
-	unsigned char bh_size_bits, rec_size_bits;
+	runlist_element *rl;
+	int i, nr_locked_nis, nr_recs, nr_bhs, bhs_per_rec, err, err2;
+	unsigned rec_size_bits;
 	BOOL sync, is_mft, page_is_dirty, rec_is_dirty;
 
 	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
@@ -824,7 +831,6 @@
 	bh = head = page_buffers(page);
 	BUG_ON(!bh);
 
-	bh_size_bits = vi->i_blkbits;
 	rec_size_bits = ni->itype.index.block_size_bits;
 	BUG_ON(!(PAGE_CACHE_SIZE >> rec_size_bits));
 	bhs_per_rec = rec_size >> bh_size_bits;
@@ -837,25 +843,18 @@
 	/* The first out of bounds block for the data size. */
 	dblock = (vi->i_size + bh_size - 1) >> bh_size_bits;
 
-	err = nr_bhs = nr_recs = nr_locked_nis = 0;
+	rl = NULL;
+	err = err2 = nr_bhs = nr_recs = nr_locked_nis = 0;
 	page_is_dirty = rec_is_dirty = FALSE;
+	rec_start_bh = NULL;
 	do {
-		if (unlikely(block >= dblock)) {
-			/*
-			 * Mapped buffers outside i_size will occur, because
-			 * this page can be outside i_size when there is a
-			 * truncate in progress.  The contents of such buffers
-			 * were zeroed by ntfs_writepage().
-			 *
-			 * FIXME: What about the small race window where
-			 * ntfs_writepage() has not done any clearing because
-			 * the page was within i_size but before we get here,
-			 * vmtruncate() modifies i_size?
-			 */
-			clear_buffer_dirty(bh);
-			continue;
-		}
+		BOOL is_retry = FALSE;
+
 		if (likely(block < rec_block)) {
+			if (unlikely(block >= dblock)) {
+				clear_buffer_dirty(bh);
+				continue;
+			}
 			/*
 			 * This block is not the first one in the record.  We
 			 * ignore the buffer's dirty state because we could
@@ -863,22 +862,121 @@
 			 */
 			if (!rec_is_dirty)
 				continue;
+			if (unlikely(err2)) {
+				if (err2 != -ENOMEM)
+					clear_buffer_dirty(bh);
+				continue;
+			}
 		} else /* if (block == rec_block) */ {
 			BUG_ON(block > rec_block);
 			/* This block is the first one in the record. */
 			rec_block += bhs_per_rec;
+			err2 = 0;
+			if (unlikely(block >= dblock)) {
+				clear_buffer_dirty(bh);
+				continue;
+			}
 			if (!buffer_dirty(bh)) {
 				/* Clean records are not written out. */
 				rec_is_dirty = FALSE;
 				continue;
 			}
 			rec_is_dirty = TRUE;
+			rec_start_bh = bh;
+		}
+		/* Need to map the buffer if it is not mapped already. */
+		if (unlikely(!buffer_mapped(bh))) {
+			VCN vcn;
+			LCN lcn;
+			unsigned int vcn_ofs;
+
+			/* Obtain the vcn and offset of the current block. */
+			vcn = (VCN)block << bh_size_bits;
+			vcn_ofs = vcn & vol->cluster_size_mask;
+			vcn >>= vol->cluster_size_bits;
+			if (!rl) {
+lock_retry_remap:
+				down_read(&ni->runlist.lock);
+				rl = ni->runlist.rl;
+			}
+			if (likely(rl != NULL)) {
+				/* Seek to element containing target vcn. */
+				while (rl->length && rl[1].vcn <= vcn)
+					rl++;
+				lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
+			} else
+				lcn = LCN_RL_NOT_MAPPED;
+			/* Successful remap. */
+			if (likely(lcn >= 0)) {
+				/* Setup buffer head to correct block. */
+				bh->b_blocknr = ((lcn <<
+						vol->cluster_size_bits) +
+						vcn_ofs) >> bh_size_bits;
+				set_buffer_mapped(bh);
+			} else {
+				/*
+				 * Remap failed.  Retry to map the runlist once
+				 * unless we are working on $MFT which always
+				 * has the whole of its runlist in memory.
+				 */
+				if (!is_mft && !is_retry &&
+						lcn == LCN_RL_NOT_MAPPED) {
+					is_retry = TRUE;
+					/*
+					 * Attempt to map runlist, dropping
+					 * lock for the duration.
+					 */
+					up_read(&ni->runlist.lock);
+					err2 = ntfs_map_runlist(ni, vcn);
+					if (likely(!err2))
+						goto lock_retry_remap;
+					if (err2 == -ENOMEM)
+						page_is_dirty = TRUE;
+					lcn = err2;
+				} else
+					err2 = -EIO;
+				/* Hard error.  Abort writing this record. */
+				if (!err || err == -ENOMEM)
+					err = err2;
+				bh->b_blocknr = -1;
+				ntfs_error(vol->sb, "Cannot write ntfs record "
+						"0x%llx (inode 0x%lx, "
+						"attribute type 0x%x) because "
+						"its location on disk could "
+						"not be determined (error "
+						"code %lli).", (s64)block <<
+						bh_size_bits >>
+						vol->mft_record_size_bits,
+						ni->mft_no, ni->type,
+						(long long)lcn);
+				/*
+				 * If this is not the first buffer, remove the
+				 * buffers in this record from the list of
+				 * buffers to write and clear their dirty bit
+				 * if not error -ENOMEM.
+				 */
+				if (rec_start_bh != bh) {
+					while (bhs[--nr_bhs] != rec_start_bh)
+						;
+					if (err2 != -ENOMEM) {
+						do {
+							clear_buffer_dirty(
+								rec_start_bh);
+						} while ((rec_start_bh =
+								rec_start_bh->
+								b_this_page) !=
+								bh);
+					}
+				}
+				continue;
+			}
 		}
-		BUG_ON(!buffer_mapped(bh));
 		BUG_ON(!buffer_uptodate(bh));
+		BUG_ON(nr_bhs >= max_bhs);
 		bhs[nr_bhs++] = bh;
-		BUG_ON(nr_bhs > max_bhs);
 	} while (block++, (bh = bh->b_this_page) != head);
+	if (unlikely(rl))
+		up_read(&ni->runlist.lock);
 	/* If there were no dirty buffers, we are done. */
 	if (!nr_bhs)
 		goto done;
@@ -930,9 +1028,11 @@
 				locked_nis[nr_locked_nis++] = tni;
 		}
 		/* Apply the mst protection fixups. */
-		err = pre_write_mst_fixup((NTFS_RECORD*)(kaddr + ofs),
+		err2 = pre_write_mst_fixup((NTFS_RECORD*)(kaddr + ofs),
 				rec_size);
-		if (unlikely(err)) {
+		if (unlikely(err2)) {
+			if (!err || err == -ENOMEM)
+				err = -EIO;
 			ntfs_error(vol->sb, "Failed to apply mst fixups "
 					"(inode 0x%lx, attribute type 0x%x, "
 					"page index 0x%lx, page offset 0x%x)!"
@@ -986,7 +1086,8 @@
 					"0x%lx, page offset 0x%lx)!  Unmount "
 					"and run chkdsk.", vi->i_ino, ni->type,
 					page->index, bh_offset(tbh));
-			err = -EIO;
+			if (!err || err == -ENOMEM)
+				err = -EIO;
 			/*
 			 * Set the buffer uptodate so the page and buffer
 			 * states do not become out of sync.
@@ -1056,13 +1157,18 @@
 		atomic_dec(&tni->count);
 		iput(VFS_I(base_tni));
 	}
-	if (unlikely(err)) {
-		SetPageError(page);
-		NVolSetErrors(vol);
-	}
 	SetPageUptodate(page);
 	kunmap(page);
 done:
+	if (unlikely(err && err != -ENOMEM)) {
+		/*
+		 * Set page error if there is only one ntfs record in the page.
+		 * Otherwise we would loose per-record granularity.
+		 */
+		if (ni->itype.index.block_size == PAGE_CACHE_SIZE)
+			SetPageError(page);
+		NVolSetErrors(vol);
+	}
 	if (page_is_dirty) {
 		ntfs_debug("Page still contains one or more dirty ntfs "
 				"records.  Redirtying the page starting at "
@@ -1182,9 +1288,9 @@
 		}
 		/* Handle mst protected attributes. */
 		if (NInoMstProtected(ni))
-			return ntfs_write_mst_block(wbc, page);
+			return ntfs_write_mst_block(page, wbc);
 		/* Normal data stream. */
-		return ntfs_write_block(wbc, page);
+		return ntfs_write_block(page, wbc);
 	}
 	/*
 	 * Attribute is resident, implying it is not compressed, encrypted,
@@ -1343,7 +1449,7 @@
 	vol = ni->vol;
 
 	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
-			"0x%lx, from = %u, to = %u.", vi->i_ino, ni->type,
+			"0x%lx, from = %u, to = %u.", ni->mft_no, ni->type,
 			page->index, from, to);
 
 	BUG_ON(!NInoNonResident(ni));
@@ -1537,21 +1643,24 @@
 					if (likely(!err))
 						goto lock_retry_remap;
 					rl = NULL;
+					lcn = err;
 				}
 				/*
 				 * Failed to map the buffer, even after
 				 * retrying.
 				 */
-				bh->b_blocknr = -1UL;
-				ntfs_error(vol->sb, "ntfs_rl_vcn_to_lcn(vcn = "
-						"0x%llx) failed with error "
-						"code 0x%llx%s.",
+				bh->b_blocknr = -1;
+				ntfs_error(vol->sb, "Failed to write to inode "
+						"0x%lx, attribute type 0x%x, "
+						"vcn 0x%llx, offset 0x%x "
+						"because its location on disk "
+						"could not be determined%s "
+						"(error code %lli).",
+						ni->mft_no, ni->type,
 						(unsigned long long)vcn,
-						(unsigned long long)-lcn,
-						is_retry ? " even after "
-						"retrying" : "");
-				// FIXME: Depending on vol->on_errors, do
-				// something.
+						vcn_ofs, is_retry ? " even "
+						"after retrying" : "",
+						(long long)lcn);
 				if (!err)
 					err = -EIO;
 				goto err_out;
@@ -2173,7 +2282,6 @@
 	struct buffer_head *bh, *head, *buffers_to_free = NULL;
 	unsigned int end, bh_size, bh_ofs;
 
-	BUG_ON(!PageUptodate(page));
 	end = ofs + ni->itype.index.block_size;
 	bh_size = 1 << VFS_I(ni)->i_blkbits;
 	spin_lock(&mapping->private_lock);
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-11-10 13:45:44 +00:00
+++ b/fs/ntfs/inode.c	2004-11-10 13:45:44 +00:00
@@ -2358,8 +2358,8 @@
 done:
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(ni);
-	ntfs_debug("Done.");
 	NInoClearTruncateFailed(ni);
+	ntfs_debug("Done.");
 	return 0;
 err_out:
 	if (err != -ENOMEM) {
@@ -2608,6 +2608,7 @@
 		ntfs_error(vi->i_sb, "Failed (error code %i):  Marking inode "
 				"as bad.  You should run chkdsk.", -err);
 		make_bad_inode(vi);
+		NVolSetErrors(ni->vol);
 	}
 	return err;
 }
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-11-10 13:45:44 +00:00
+++ b/fs/ntfs/mft.c	2004-11-10 13:45:44 +00:00
@@ -466,8 +466,10 @@
 	struct buffer_head *bhs[max_bhs];
 	struct buffer_head *bh, *head;
 	u8 *kmirr;
-	unsigned int block_start, block_end, m_start, m_end;
+	runlist_element *rl;
+	unsigned int block_start, block_end, m_start, m_end, page_ofs;
 	int i_bhs, nr_bhs, err = 0;
+	unsigned char blocksize_bits = vol->mftmirr_ino->i_blkbits;
 
 	ntfs_debug("Entering for inode 0x%lx.", mft_no);
 	BUG_ON(!max_bhs);
@@ -486,24 +488,24 @@
 		err = PTR_ERR(page);
 		goto err_out;
 	}
-	/*
-	 * Exclusion against other writers.   This should never be a problem
-	 * since the page in which the mft record @m resides is also locked and
-	 * hence any other writers would be held up there but it is better to
-	 * make sure no one is writing from elsewhere.
-	 */
 	lock_page(page);
 	BUG_ON(!PageUptodate(page));
 	ClearPageUptodate(page);
+	/* Offset of the mft mirror record inside the page. */
+	page_ofs = (mft_no << vol->mft_record_size_bits) & ~PAGE_CACHE_MASK;
 	/* The address in the page of the mirror copy of the mft record @m. */
-	kmirr = page_address(page) + ((mft_no << vol->mft_record_size_bits) &
-			~PAGE_CACHE_MASK);
+	kmirr = page_address(page) + page_ofs;
 	/* Copy the mst protected mft record to the mirror. */
 	memcpy(kmirr, m, vol->mft_record_size);
-	/* Make sure we have mapped buffers. */
+	/*
+	 * Create buffers if not present and mark the ones belonging to the mft
+	 * mirror record dirty.
+	 */
+	mark_ntfs_record_dirty(page, page_ofs);
 	BUG_ON(!page_has_buffers(page));
 	bh = head = page_buffers(page);
 	BUG_ON(!bh);
+	rl = NULL;
 	nr_bhs = 0;
 	block_start = 0;
 	m_start = kmirr - (u8*)page_address(page);
@@ -511,15 +513,61 @@
 	do {
 		block_end = block_start + blocksize;
 		/* If the buffer is outside the mft record, skip it. */
-		if ((block_end <= m_start) || (block_start >= m_end))
+		if (block_end <= m_start)
 			continue;
-		BUG_ON(!buffer_mapped(bh));
+		if (unlikely(block_start >= m_end))
+			break;
+		/* Need to map the buffer if it is not mapped already. */
+		if (unlikely(!buffer_mapped(bh))) {
+			VCN vcn;
+			LCN lcn;
+			unsigned int vcn_ofs;
+
+			/* Obtain the vcn and offset of the current block. */
+			vcn = ((VCN)mft_no << vol->mft_record_size_bits) +
+					(block_start - m_start);
+			vcn_ofs = vcn & vol->cluster_size_mask;
+			vcn >>= vol->cluster_size_bits;
+			if (!rl) {
+				down_read(&NTFS_I(vol->mftmirr_ino)->
+						runlist.lock);
+				rl = NTFS_I(vol->mftmirr_ino)->runlist.rl;
+				/*
+				 * $MFTMirr always has the whole of its runlist
+				 * in memory.
+				 */
+				BUG_ON(!rl);
+			}
+			/* Seek to element containing target vcn. */
+			while (rl->length && rl[1].vcn <= vcn)
+				rl++;
+			lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
+			/* For $MFTMirr, only lcn >= 0 is a successful remap. */
+			if (likely(lcn >= 0)) {
+				/* Setup buffer head to correct block. */
+				bh->b_blocknr = ((lcn <<
+						vol->cluster_size_bits) +
+						vcn_ofs) >> blocksize_bits;
+				set_buffer_mapped(bh);
+			} else {
+				bh->b_blocknr = -1;
+				ntfs_error(vol->sb, "Cannot write mft mirror "
+						"record 0x%lx because its "
+						"location on disk could not "
+						"be determined (error code "
+						"%lli).", mft_no,
+						(long long)lcn);
+				err = -EIO;
+			}
+		}
 		BUG_ON(!buffer_uptodate(bh));
 		BUG_ON(!nr_bhs && (m_start != block_start));
 		BUG_ON(nr_bhs >= max_bhs);
 		bhs[nr_bhs++] = bh;
 		BUG_ON((nr_bhs >= max_bhs) && (m_end != block_end));
 	} while (block_start = block_end, (bh = bh->b_this_page) != head);
+	if (unlikely(rl))
+		up_read(&NTFS_I(vol->mftmirr_ino)->runlist.lock);
 	if (likely(!err)) {
 		/* Lock buffers and start synchronous write i/o on them. */
 		for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++) {
@@ -528,8 +576,7 @@
 			if (unlikely(test_set_buffer_locked(tbh)))
 				BUG();
 			BUG_ON(!buffer_uptodate(tbh));
-			if (buffer_dirty(tbh))
-				clear_buffer_dirty(tbh);
+			clear_buffer_dirty(tbh);
 			get_bh(tbh);
 			tbh->b_end_io = end_buffer_write_sync;
 			submit_bh(WRITE, tbh);
@@ -613,13 +660,14 @@
 {
 	ntfs_volume *vol = ni->vol;
 	struct page *page = ni->page;
-	unsigned int blocksize = vol->sb->s_blocksize;
+	unsigned char blocksize_bits = vol->mft_ino->i_blkbits;
+	unsigned int blocksize = 1 << blocksize_bits;
 	int max_bhs = vol->mft_record_size / blocksize;
 	struct buffer_head *bhs[max_bhs];
 	struct buffer_head *bh, *head;
+	runlist_element *rl;
 	unsigned int block_start, block_end, m_start, m_end;
 	int i_bhs, nr_bhs, err = 0;
-	BOOL rec_is_dirty = TRUE;
 
 	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
 	BUG_ON(NInoAttr(ni));
@@ -636,6 +684,7 @@
 	BUG_ON(!page_has_buffers(page));
 	bh = head = page_buffers(page);
 	BUG_ON(!bh);
+	rl = NULL;
 	nr_bhs = 0;
 	block_start = 0;
 	m_start = ni->page_ofs;
@@ -647,31 +696,65 @@
 			continue;
 		if (unlikely(block_start >= m_end))
 			break;
+		/*
+		 * If this block is not the first one in the record, we ignore
+		 * the buffer's dirty state because we could have raced with a
+		 * parallel mark_ntfs_record_dirty().
+		 */
 		if (block_start == m_start) {
 			/* This block is the first one in the record. */
 			if (!buffer_dirty(bh)) {
+				BUG_ON(nr_bhs);
 				/* Clean records are not written out. */
-				rec_is_dirty = FALSE;
-				continue;
+				break;
+			}
+		}
+		/* Need to map the buffer if it is not mapped already. */
+		if (unlikely(!buffer_mapped(bh))) {
+			VCN vcn;
+			LCN lcn;
+			unsigned int vcn_ofs;
+
+			/* Obtain the vcn and offset of the current block. */
+			vcn = ((VCN)ni->mft_no << vol->mft_record_size_bits) +
+					(block_start - m_start);
+			vcn_ofs = vcn & vol->cluster_size_mask;
+			vcn >>= vol->cluster_size_bits;
+			if (!rl) {
+				down_read(&NTFS_I(vol->mft_ino)->runlist.lock);
+				rl = NTFS_I(vol->mft_ino)->runlist.rl;
+				BUG_ON(!rl);
+			}
+			/* Seek to element containing target vcn. */
+			while (rl->length && rl[1].vcn <= vcn)
+				rl++;
+			lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
+			/* For $MFT, only lcn >= 0 is a successful remap. */
+			if (likely(lcn >= 0)) {
+				/* Setup buffer head to correct block. */
+				bh->b_blocknr = ((lcn <<
+						vol->cluster_size_bits) +
+						vcn_ofs) >> blocksize_bits;
+				set_buffer_mapped(bh);
+			} else {
+				bh->b_blocknr = -1;
+				ntfs_error(vol->sb, "Cannot write mft record "
+						"0x%lx because its location "
+						"on disk could not be "
+						"determined (error code %lli).",
+						ni->mft_no, (long long)lcn);
+				err = -EIO;
 			}
-			rec_is_dirty = TRUE;
-		} else {
-			/*
-			 * This block is not the first one in the record.  We
-			 * ignore the buffer's dirty state because we could
-			 * have raced with a parallel mark_ntfs_record_dirty().
-			 */
-			if (!rec_is_dirty)
-				continue;
 		}
-		BUG_ON(!buffer_mapped(bh));
 		BUG_ON(!buffer_uptodate(bh));
 		BUG_ON(!nr_bhs && (m_start != block_start));
 		BUG_ON(nr_bhs >= max_bhs);
 		bhs[nr_bhs++] = bh;
 		BUG_ON((nr_bhs >= max_bhs) && (m_end != block_end));
 	} while (block_start = block_end, (bh = bh->b_this_page) != head);
-	if (!rec_is_dirty)
+	if (unlikely(rl))
+		up_read(&NTFS_I(vol->mft_ino)->runlist.lock);
+	if (!nr_bhs)
 		goto done;
 	if (unlikely(err))
 		goto cleanup_out;
@@ -745,7 +828,8 @@
 				"Redirtying so the write is retried later.");
 		mark_mft_record_dirty(ni);
 		err = 0;
-	}
+	} else
+		NVolSetErrors(vol);
 	return err;
 }
 
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-11-10 13:45:44 +00:00
+++ b/fs/ntfs/super.c	2004-11-10 13:45:44 +00:00
@@ -983,6 +983,10 @@
  * @vol:	ntfs super block describing device whose mft mirror to check
  *
  * Return TRUE on success or FALSE on error.
+ *
+ * Note, this function also results in the mft mirror runlist being completely
+ * mapped into memory.  The mft mirror write code requires this and will BUG()
+ * should it find an unmapped runlist element.
  */
 static BOOL check_mft_mirror(ntfs_volume *vol)
 {
