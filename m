Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSHTXnx>; Tue, 20 Aug 2002 19:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317589AbSHTXnx>; Tue, 20 Aug 2002 19:43:53 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:65240 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317571AbSHTXnZ>; Tue, 20 Aug 2002 19:43:25 -0400
Subject: [BK-2.5 PATCH] NTFS 2.1.0 5/7: Add write(2) based overwrite code
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 21 Aug 2002 00:47:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17hIig-0001KP-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.5

Thanks! The 5th changeset, implementing write(2) based overwrites.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    5 
 fs/ntfs/ChangeLog                  |   37 +
 fs/ntfs/aops.c                     |  800 ++++++++++++++++++++++++++++++++++++-
 fs/ntfs/attrib.c                   |    5 
 fs/ntfs/file.c                     |    3 
 fs/ntfs/mft.c                      |    5 
 fs/ntfs/mft.h                      |   14 
 7 files changed, 847 insertions(+), 22 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/08/20 1.486.1.2)
   NTFS: Initial implementation of write(2) based overwriting of existing
   files on ntfs. (Note: Resident files are not supported yet, so avoid
   writing to files smaller than 1kiB.)


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Tue Aug 20 23:58:06 2002
+++ b/Documentation/filesystems/ntfs.txt	Tue Aug 20 23:58:06 2002
@@ -247,6 +247,11 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.1.0:
+	- Add configuration option for developmental write support.
+	- Initial implementation of file overwriting. (Writes to resident files
+	  are not written out to disk yet, so avoid writing to files smaller
+	  than about 1kiB.)
 2.0.25:
 	- Minor bugfixes in error code paths and small cleanups.
 2.0.24:
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Tue Aug 20 23:58:06 2002
+++ b/fs/ntfs/ChangeLog	Tue Aug 20 23:58:06 2002
@@ -1,6 +1,43 @@
 ToDo:
 	- Find and fix bugs.
 	- Enable NFS exporting of NTFS.
+	- Implement aops->set_page_dirty() in order to take control of buffer
+	  dirtying. Not having it means if page_has_buffers(), all buffers
+	  will be dirtied with the page. And if not they won't be. That is
+	  fine for the moment but will break once we enable metadata updates.
+	- Implement sops->dirty_inode() to implement {a,m,c} time updates and
+	  such things.
+	- Implement sops->write_inode().
+	- In between ntfs_prepare/commit_write, need exclusion between
+	  simultaneous file extensions. Need perhaps an NInoResizeUnderway()
+	  flag which we can set in ntfs_prepare_write() and clear again in
+	  ntfs_commit_write(). Just have to be careful in readpage/writepage,
+	  as well as in truncate, that we play nice... We might need to have
+	  a data_size field in the ntfs_inode to store the real attribute
+	  length. Also need to be careful with initialized_size extention in
+	  ntfs_prepare_write. Basically, just be _very_ careful in this code...
+	  OTOH, perhaps i_sem, which is held accross generic_file_write is
+	  sufficient for synchronisation here. We then just need to make sure
+	  ntfs_readpage/writepage/truncate interoperate properly with us.
+
+2.1.0 - First steps towards write support: implement file overwrite.
+
+	- Add configuration option for developmental write support with an
+	  appropriately scary configuration help text.
+	- Initial implementation of fs/ntfs/aops.c::ntfs_writepage() and its
+	  helper fs/ntfs/aops.c::ntfs_write_block(). This enables mmap(2) based
+	  overwriting of existing files on ntfs. Note: Resident files are
+	  only written into memory, and not written out to disk at present, so
+	  avoid writing to files smaller than about 1kiB.
+	- Initial implementation of fs/ntfs/aops.c::ntfs_prepare_write(), its
+	  helper fs/ntfs/aops.c::ntfs_prepare_nonresident_write() and their
+	  counterparts, fs/ntfs/aops.c::ntfs_commit_write(), and
+	  fs/ntfs/aops.c::ntfs_commit_nonresident_write(), respectively. Also,
+	  add generic_file_write() to the ntfs file operations (fs/ntfs/file.c).
+	  This enables write(2) based overwriting of existing files on ntfs.
+	  Note: As with mmap(2) based overwriting, resident files are only
+	  written into memory, and not written out to disk at present, so avoid
+	  writing to files smaller than about 1kiB.
 
 2.0.25 - Small bug fixes and cleanups.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Tue Aug 20 23:58:06 2002
+++ b/fs/ntfs/aops.c	Tue Aug 20 23:58:06 2002
@@ -462,12 +462,12 @@
 {
 	VCN vcn;
 	LCN lcn;
+	sector_t block, dblock, iblock;
 	struct inode *vi;
 	ntfs_inode *ni;
 	ntfs_volume *vol;
 	run_list_element *rl;
 	struct buffer_head *bh, *head;
-	sector_t block, dblock, iblock;
 	unsigned int blocksize, vcn_ofs;
 	int err;
 	BOOL need_end_writeback;
@@ -586,9 +586,12 @@
 			}
 			/*
 			 * The current page straddles initialized size. Zero
-			 * all non-uptodate buffers and set them uptodate.
-			 * Note, there aren't any non-uptodate buffers if the
-			 * page is uptodate.
+			 * all non-uptodate buffers and set them uptodate (and
+			 * dirty?). Note, there aren't any non-uptodate buffers
+			 * if the page is uptodate.
+			 * FIXME: For an uptodate page, the buffers may need to
+			 * be written out because they were not initialized on
+			 * disk before.
 			 */
 			if (!PageUptodate(page)) {
 				// TODO:
@@ -605,6 +608,10 @@
 					"is not supported yet. Sorry.");
 			err = -EOPNOTSUPP;
 			break;
+			// Do NOT set_buffer_new() BUT DO clear buffer range
+			// outside write request range.
+			// set_buffer_uptodate() on complete buffers as well as
+			// set_buffer_dirty().
 		}
 
 		/* No need to map buffers that are already mapped. */
@@ -785,12 +792,11 @@
  *
  * Return 0 on success and -errno on error.
  */
-int ntfs_writepage(struct page *page)
+static int ntfs_writepage(struct page *page)
 {
 	s64 attr_pos;
 	struct inode *vi;
 	ntfs_inode *ni, *base_ni;
-	ntfs_volume *vol;
 	char *kaddr;
 	attr_search_context *ctx;
 	MFT_RECORD *m;
@@ -810,7 +816,6 @@
 	}
 
 	ni = NTFS_I(vi);
-	vol = ni->vol;
 
 	if (NInoNonResident(ni)) {
 		/*
@@ -830,7 +835,7 @@
 				// TODO: Implement and replace this check with
 				// return ntfs_write_compressed_block(page);
 				unlock_page(page);
-				ntfs_error(vol->sb, "Writing to compressed "
+				ntfs_error(vi->i_sb, "Writing to compressed "
 						"files is not supported yet. "
 						"Sorry.");
 				return -EOPNOTSUPP;
@@ -838,7 +843,7 @@
 			// TODO: Implement and remove this check.
 			if (NInoSparse(ni)) {
 				unlock_page(page);
-				ntfs_error(vol->sb, "Writing to sparse files "
+				ntfs_error(vi->i_sb, "Writing to sparse files "
 						"is not supported yet. Sorry.");
 				return -EOPNOTSUPP;
 			}
@@ -857,7 +862,7 @@
 		// TODO: Implement and remove this check.
 		if (NInoMstProtected(ni)) {
 			unlock_page(page);
-			ntfs_error(vol->sb, "Writing to MST protected "
+			ntfs_error(vi->i_sb, "Writing to MST protected "
 					"attributes is not supported yet. "
 					"Sorry.");
 			return -EOPNOTSUPP;
@@ -889,7 +894,7 @@
 	else
 		base_ni = ni->_INE(base_ntfs_ino);
 
-	/* Map, pin and lock the mft record. */
+	/* Map, pin, and lock the mft record. */
 	m = map_mft_record(base_ni);
 	if (unlikely(IS_ERR(m))) {
 		err = PTR_ERR(m);
@@ -915,14 +920,14 @@
 	attr_len = le32_to_cpu(ctx->attr->_ARA(value_length));
 
 	if (unlikely(vi->i_size != attr_len)) {
-		ntfs_error(vol->sb, "BUG()! i_size (0x%Lx) doesn't match "
+		ntfs_error(vi->i_sb, "BUG()! i_size (0x%Lx) doesn't match "
 				"attr_len (0x%x). Aborting write.", vi->i_size,
 				attr_len);
 		err = -EIO;
 		goto err_out;
 	}
 	if (unlikely(attr_pos >= attr_len)) {
-		ntfs_error(vol->sb, "BUG()! attr_pos (0x%Lx) > attr_len (0x%x)"
+		ntfs_error(vi->i_sb, "BUG()! attr_pos (0x%Lx) > attr_len (0x%x)"
 				". Aborting write.", attr_pos, attr_len);
 		err = -EIO;
 		goto err_out;
@@ -953,6 +958,7 @@
 	/* Copy the data from the page to the mft record. */
 	memcpy((u8*)ctx->attr + le16_to_cpu(ctx->attr->_ARA(value_offset)) +
 			attr_pos, kaddr, bytes);
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
 #if 0
 	/* Zero out of bounds area. */
 	if (likely(bytes < PAGE_CACHE_SIZE)) {
@@ -965,7 +971,7 @@
 	unlock_page(page);
 
 	// TODO: Mark mft record dirty so it gets written back.
-	ntfs_error(vol->sb, "Writing to resident files is not supported yet. "
+	ntfs_error(vi->i_sb, "Writing to resident files is not supported yet. "
 			"Wrote to memory only...");
 
 	put_attr_search_ctx(ctx);
@@ -973,7 +979,7 @@
 	return 0;
 err_out:
 	if (err == -ENOMEM) {
-		ntfs_warning(vol->sb, "Error allocating memory. Redirtying "
+		ntfs_warning(vi->i_sb, "Error allocating memory. Redirtying "
 				"page so we try again later.");
 		/*
 		 * Put the page back on mapping->dirty_pages, but leave its
@@ -985,7 +991,7 @@
 		__set_page_dirty_nobuffers(page);
 		err = 0;
 	} else {
-		ntfs_error(vol->sb, "Resident attribute write failed with "
+		ntfs_error(vi->i_sb, "Resident attribute write failed with "
 				"error %i. Setting page error flag.", -err);
 		SetPageError(page);
 	}
@@ -997,6 +1003,765 @@
 	return err;
 }
 
+/**
+ * ntfs_prepare_nonresident_write -
+ *
+ */
+static int ntfs_prepare_nonresident_write(struct page *page,
+		unsigned from, unsigned to)
+{
+	VCN vcn;
+	LCN lcn;
+	sector_t block, ablock, iblock;
+	struct inode *vi;
+	ntfs_inode *ni;
+	ntfs_volume *vol;
+	run_list_element *rl;
+	struct buffer_head *bh, *head, *wait[2], **wait_bh = wait;
+	char *kaddr = page_address(page);
+	unsigned int vcn_ofs, block_start, block_end, blocksize;
+	int err;
+	BOOL is_retry;
+	unsigned char blocksize_bits;
+
+	vi = page->mapping->host;
+	ni = NTFS_I(vi);
+	vol = ni->vol;
+
+	ntfs_debug("Entering for inode %li, attribute type 0x%x, page index "
+			"0x%lx, from = %u, to = %u.", vi->i_ino, ni->type,
+			page->index, from, to);
+
+	BUG_ON(!NInoNonResident(ni));
+	BUG_ON(NInoMstProtected(ni));
+
+	blocksize_bits = vi->i_blkbits;
+	blocksize = 1 << blocksize_bits;
+
+	/*
+	 * create_empty_buffers() will create uptodate/dirty buffers if the
+	 * page is uptodate/dirty.
+	 */
+	if (!page_has_buffers(page))
+		create_empty_buffers(page, blocksize, 0);
+	bh = head = page_buffers(page);
+	if (unlikely(!bh))
+		return -ENOMEM;
+
+	/* The first block in the page. */
+	block = page->index << (PAGE_CACHE_SHIFT - blocksize_bits);
+
+	/*
+	 * The first out of bounds block for the allocated size. No need to
+	 * round up as allocated_size is in multiples of cluster size and the
+	 * minimum cluster size is 512 bytes, which is equal to the smallest
+	 * blocksize.
+	 */
+	ablock = ni->allocated_size >> blocksize_bits;
+
+	/* The last (fully or partially) initialized block. */
+	iblock = ni->initialized_size >> blocksize_bits;
+
+	/* Loop through all the buffers in the page. */
+	block_start = 0;
+	rl = NULL;
+	err = 0;
+	do {
+		block_end = block_start + blocksize;
+		/*
+		 * If buffer @bh is outside the write, just mark it uptodate
+		 * if the page is uptodate and continue with the next buffer.
+		 */
+		if (block_end <= from || block_start >= to) {
+			if (PageUptodate(page)) {
+				if (!buffer_uptodate(bh))
+					set_buffer_uptodate(bh);
+			}
+			continue;
+		}
+		/*
+		 * @bh is at least partially being written to.
+		 * Make sure it is not marked as new.
+		 */
+		//if (buffer_new(bh))
+		//	clear_buffer_new(bh);
+
+		if (block >= ablock) {
+			// TODO: block is above allocated_size, need to
+			// allocate it. Best done in one go to accomodate not
+			// only block but all above blocks up to and including:
+			// ((page->index << PAGE_CACHE_SHIFT) + to + blocksize
+			// - 1) >> blobksize_bits. Obviously will need to round
+			// up to next cluster boundary, too. This should be
+			// done with a helper function, so it can be reused.
+			ntfs_error(vol->sb, "Writing beyond allocated size "
+					"is not supported yet. Sorry.");
+			err = -EOPNOTSUPP;
+			goto err_out;
+			// Need to update ablock.
+			// Need to set_buffer_new() on all block bhs that are
+			// newly allocated.
+		}
+		/*
+		 * Now we have enough allocated size to fulfill the whole
+		 * request, i.e. block < ablock is true.
+		 */
+		if (unlikely((block >= iblock) &&
+				(ni->initialized_size < vi->i_size))) {
+			/*
+			 * If this page is fully outside initialized size, zero
+			 * out all pages between the current initialized size
+			 * and the current page. Just use ntfs_readpage() to do
+			 * the zeroing transparently.
+			 */
+			if (block > iblock) {
+				// TODO:
+				// For each page do:
+				// - read_cache_page()
+				// Again for each page do:
+				// - wait_on_page_locked()
+				// - Check (PageUptodate(page) &&
+				// 			!PageError(page))
+				// Update initialized size in the attribute and
+				// in the inode.
+				// Again, for each page do:
+				// 	__set_page_dirty_buffers();
+				// page_cache_release()
+				// We don't need to wait on the writes.
+				// Update iblock.
+			}
+			/*
+			 * The current page straddles initialized size. Zero
+			 * all non-uptodate buffers and set them uptodate (and
+			 * dirty?). Note, there aren't any non-uptodate buffers
+			 * if the page is uptodate.
+			 * FIXME: For an uptodate page, the buffers may need to
+			 * be written out because they were not initialized on
+			 * disk before.
+			 */
+			if (!PageUptodate(page)) {
+				// TODO:
+				// Zero any non-uptodate buffers up to i_size.
+				// Set them uptodate and dirty.
+			}
+			// TODO:
+			// Update initialized size in the attribute and in the
+			// inode (up to i_size).
+			// Update iblock.
+			// FIXME: This is inefficient. Try to batch the two
+			// size changes to happen in one go.
+			ntfs_error(vol->sb, "Writing beyond initialized size "
+					"is not supported yet. Sorry.");
+			err = -EOPNOTSUPP;
+			goto err_out;
+			// Do NOT set_buffer_new() BUT DO clear buffer range
+			// outside write request range.
+			// set_buffer_uptodate() on complete buffers as well as
+			// set_buffer_dirty().
+		}
+
+		/* Need to map unmapped buffers. */
+		if (!buffer_mapped(bh)) {
+			/* Unmapped buffer. Need to map it. */
+			bh->b_bdev = vol->sb->s_bdev;
+
+			/* Convert block into corresponding vcn and offset. */
+			vcn = (VCN)block << blocksize_bits >>
+					vol->cluster_size_bits;
+			vcn_ofs = ((VCN)block << blocksize_bits) &
+					vol->cluster_size_mask;
+
+			is_retry = FALSE;
+			if (!rl) {
+lock_retry_remap:
+				down_read(&ni->run_list.lock);
+				rl = ni->run_list.rl;
+			}
+			if (likely(rl != NULL)) {
+				/* Seek to element containing target vcn. */
+				while (rl->length && rl[1].vcn <= vcn)
+					rl++;
+				lcn = vcn_to_lcn(rl, vcn);
+			} else
+				lcn = (LCN)LCN_RL_NOT_MAPPED;
+			if (unlikely(lcn < 0)) {
+				/*
+				 * We extended the attribute allocation above.
+				 * If we hit an ENOENT here it means that the
+				 * allocation was insufficient which is a bug.
+				 */
+				BUG_ON(lcn == LCN_ENOENT);
+
+				/* It is a hole, need to instantiate it. */
+				if (lcn == LCN_HOLE) {
+					// TODO: Instantiate the hole.
+					// clear_buffer_new(bh);
+					// unmap_underlying_metadata(bh->b_bdev,
+					// 		bh->b_blocknr);
+					// For non-uptodate buffers, need to
+					// zero out the region outside the
+					// request in this bh or all bhs,
+					// depending on what we implemented
+					// above.
+					// Need to flush_dcache_page().
+					// Or could use set_buffer_new()
+					// instead?
+					ntfs_error(vol->sb, "Writing into "
+							"sparse regions is "
+							"not supported yet. "
+							"Sorry.");
+					err = -EOPNOTSUPP;
+					goto err_out;
+				} else if (!is_retry &&
+						lcn == LCN_RL_NOT_MAPPED) {
+					is_retry = TRUE;
+					/*
+					 * Attempt to map run list, dropping
+					 * lock for the duration.
+					 */
+					up_read(&ni->run_list.lock);
+					err = map_run_list(ni, vcn);
+					if (likely(!err))
+						goto lock_retry_remap;
+					rl = NULL;
+				}
+				/*
+				 * Failed to map the buffer, even after
+				 * retrying.
+				 */
+				bh->b_blocknr = -1UL;
+				ntfs_error(vol->sb, "vcn_to_lcn(vcn = 0x%Lx) "
+						"failed with error code "
+						"0x%Lx%s.", (long long)vcn,
+						(long long)-lcn, is_retry ?
+						" even after retrying" : "");
+				// FIXME: Depending on vol->on_errors, do
+				// something.
+				if (!err)
+					err = -EIO;
+				goto err_out;
+			}
+			/* We now have a successful remap, i.e. lcn >= 0. */
+
+			/* Setup buffer head to correct block. */
+			bh->b_blocknr = ((lcn << vol->cluster_size_bits)
+					+ vcn_ofs) >> blocksize_bits;
+			set_buffer_mapped(bh);
+
+			// FIXME: Something analogous to this is needed for
+			// each newly allocated block, i.e. BH_New.
+			// FIXME: Might need to take this out of the
+			// if (!buffer_mapped(bh)) {}, depending on how we
+			// implement things during the allocated_size and
+			// initialized_size extension code above.
+			if (buffer_new(bh)) {
+				clear_buffer_new(bh);
+				unmap_underlying_metadata(bh->b_bdev,
+						bh->b_blocknr);
+				if (PageUptodate(page)) {
+					set_buffer_uptodate(bh);
+					continue;
+				}
+				/*
+				 * Page is _not_ uptodate, zero surrounding
+				 * region. NOTE: This is how we decide if to
+				 * zero or not!
+				 */
+				if (block_end > to)
+					memset(kaddr + to, 0, block_end - to);
+				if (block_start < from)
+					memset(kaddr + block_start, 0,
+							from - block_start);
+				if (block_end > to || block_start < from)
+					flush_dcache_page(page);
+				continue;
+			}
+		}
+		/* @bh is mapped, set it uptodate if the page is uptodate. */
+		if (PageUptodate(page)) {
+			if (!buffer_uptodate(bh))
+				set_buffer_uptodate(bh);
+			continue; 
+		}
+		/*
+		 * The page is not uptodate. The buffer is mapped. If it is not
+		 * uptodate, and it is only partially being written to, we need
+		 * to read the buffer in before the write, i.e. right now.
+		 */
+		if (!buffer_uptodate(bh) &&
+				(block_start < from || block_end > to)) {
+			ll_rw_block(READ, 1, &bh);
+			*wait_bh++ = bh;
+		}
+	} while (block++, block_start = block_end,
+			(bh = bh->b_this_page) != head);
+
+	/* Release the lock if we took it. */
+	if (rl) {
+		up_read(&ni->run_list.lock);
+		rl = NULL;
+	}
+
+	/* If we issued read requests, let them complete. */
+	while (wait_bh > wait) {
+		wait_on_buffer(*--wait_bh);
+		if (!buffer_uptodate(*wait_bh))
+			return -EIO;
+	}
+
+	ntfs_debug("Done.");
+	return 0;
+err_out:
+	/*
+	 * Zero out any newly allocated blocks to avoid exposing stale data.
+	 * If BH_New is set, we know that the block was newly allocated in the
+	 * above loop.
+	 * FIXME: What about initialized_size increments? Have we done all the
+	 * required zeroing above? If not this error handling is broken, and
+	 * in particular the if (block_end <= from) check is completely bogus.
+	 */
+	bh = head;
+	block_start = 0;
+	is_retry = FALSE;
+	do {
+		block_end = block_start + blocksize;
+		if (block_end <= from)
+			continue;
+		if (block_start >= to)
+			break;
+		if (buffer_new(bh)) {
+			clear_buffer_new(bh);
+			if (buffer_uptodate(bh))
+				buffer_error();
+			memset(kaddr + block_start, 0, bh->b_size);
+			set_buffer_uptodate(bh);
+			mark_buffer_dirty(bh);
+			is_retry = TRUE;
+		}
+	} while (block_start = block_end, (bh = bh->b_this_page) != head);
+	if (is_retry)
+		flush_dcache_page(page);
+	if (rl)
+		up_read(&ni->run_list.lock);
+	return err;
+}
+
+/**
+ * ntfs_prepare_write - prepare a page for receiving data
+ *
+ * This is called from generic_file_write() with i_sem held on the inode
+ * (@page->mapping->host). The @page is locked and kmap()ped so page_address()
+ * can simply be used. The source data has not yet been copied into the @page.
+ *
+ * Need to extend the attribute/fill in holes if necessary, create blocks and
+ * make partially overwritten blocks uptodate,
+ *
+ * i_size is not to be modified yet.
+ *
+ * Return 0 on success or -errno on error.
+ *
+ * Should be using block_prepare_write() [support for sparse files] or
+ * cont_prepare_write() [no support for sparse files]. Can't do that due to
+ * ntfs specifics but can look at them for implementation guidancea.
+ *
+ * Note: In the range, @from is inclusive and @to is exclusive, i.e. @from is
+ * the first byte in the page that will be written to and @to is the first byte
+ * after the last byte that will be written to.
+ */
+static int ntfs_prepare_write(struct file *file, struct page *page,
+		unsigned from, unsigned to)
+{
+	struct inode *vi = page->mapping->host;
+	ntfs_inode   *ni = NTFS_I(vi);
+
+	ntfs_debug("Entering for inode %li, attribute type 0x%x, page index "
+			"0x%lx, from = %u, to = %u.", vi->i_ino, ni->type,
+			page->index, from, to);
+
+	BUG_ON(!PageLocked(page));
+	BUG_ON(from > PAGE_CACHE_SIZE);
+	BUG_ON(to > PAGE_CACHE_SIZE);
+	BUG_ON(from > to);
+
+	if (NInoNonResident(ni)) {
+		/*
+		 * Only unnamed $DATA attributes can be compressed, encrypted,
+		 * and/or sparse.
+		 */
+		if (ni->type == AT_DATA && !ni->name_len) {
+			/* If file is encrypted, deny access, just like NT4. */
+			if (NInoEncrypted(ni)) {
+				ntfs_debug("Denying write access to encrypted "
+						"file.");
+				return -EACCES;
+			}
+			/* Compressed data streams are handled in compress.c. */
+			if (NInoCompressed(ni)) {
+				// TODO: Implement and replace this check with
+				// return ntfs_write_compressed_block(page);
+				ntfs_error(vi->i_sb, "Writing to compressed "
+						"files is not supported yet. "
+						"Sorry.");
+				return -EOPNOTSUPP;
+			}
+			// TODO: Implement and remove this check.
+			if (NInoSparse(ni)) {
+				ntfs_error(vi->i_sb, "Writing to sparse files "
+						"is not supported yet. Sorry.");
+				return -EOPNOTSUPP;
+			}
+		}
+
+		// TODO: Implement and remove this check.
+		if (NInoMstProtected(ni)) {
+			ntfs_error(vi->i_sb, "Writing to MST protected "
+					"attributes is not supported yet. "
+					"Sorry.");
+			return -EOPNOTSUPP;
+		}
+
+		/* Normal data stream. */
+		return ntfs_prepare_nonresident_write(page, from, to);
+	}
+
+	/*
+	 * Attribute is resident, implying it is not compressed, encrypted, or
+	 * mst protected.
+	 */
+	BUG_ON(page_has_buffers(page));
+
+	/* Do we need to resize the attribute? */
+	if (((s64)page->index << PAGE_CACHE_SHIFT) + to > vi->i_size) {
+		// TODO: Implement resize...
+		ntfs_error(vi->i_sb, "Writing beyond the existing file size is "
+				"not supported yet. Sorry.");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * Because resident attributes are handled by memcpy() to/from the
+	 * corresponding MFT record, and because this form of i/o is byte
+	 * aligned rather than block aligned, there is no need to bring the
+	 * page uptodate here as in the non-resident case where we need to
+	 * bring the buffers straddled by the write uptodate before
+	 * generic_file_write() does the copying from userspace.
+	 *
+	 * We thus defer the uptodate bringing of the page region outside the
+	 * region written to to ntfs_commit_write(). The reason for doing this
+	 * is that we save one round of:
+	 *	map_mft_record(), get_attr_search_ctx(), lookup_attr(),
+	 *	kmap_atomic(), kunmap_atomic(), put_attr_search_ctx(),
+	 *	unmap_mft_record().
+	 * Which is obviously a very worthwhile save.
+	 *
+	 * Thus we just return success now...
+	 */
+	ntfs_debug("Done.");
+	return 0;
+}
+
+/*
+ * NOTES: There is a disparity between the apparent need to extend the
+ * attribute in prepare write but to update i_size only in commit write.
+ * Need to make sure i_sem protection is sufficient. And if not will need to
+ * handle this in some way or another.
+ */
+
+/**
+ * ntfs_commit_nonresident_write -
+ *
+ */
+static int ntfs_commit_nonresident_write(struct page *page,
+		unsigned from, unsigned to)
+{
+	s64 pos = ((s64)page->index << PAGE_CACHE_SHIFT) + to;
+	struct inode *vi;
+	struct buffer_head *bh, *head;
+	unsigned int block_start, block_end, blocksize;
+	BOOL partial;
+
+	vi = page->mapping->host;
+
+	ntfs_debug("Entering for inode %li, attribute type 0x%x, page index "
+			"0x%lx, from = %u, to = %u.", vi->i_ino,
+			NTFS_I(vi)->type, page->index, from, to);
+
+	blocksize = 1 << vi->i_blkbits;
+
+	// FIXME: We need a whole slew of special cases in here for MST
+	// protected attributes for example. For compressed files, too...
+	// For now, we know ntfs_prepare_write() would have failed so we can't
+	// get here in any of the cases which we have to special case, so we
+	// are just a ripped off unrolled generic_commit_write() at present.
+
+	bh = head = page_buffers(page);
+	block_start = 0;
+	partial = FALSE;
+	do {
+		block_end = block_start + blocksize;
+		if (block_end <= from || block_start >= to) {
+			if (!buffer_uptodate(bh))
+				partial = TRUE;
+		} else {
+			set_buffer_uptodate(bh);
+			mark_buffer_dirty(bh);
+		}
+	} while (block_start = block_end, (bh = bh->b_this_page) != head);
+
+	/*
+	 * If this is a partial write which happened to make all buffers
+	 * uptodate then we can optimize away a bogus ->readpage() for the next
+	 * read(). Here we 'discover' whether the page went uptodate as a
+	 * result of this (potentially partial) write.
+	 */
+	if (!partial)
+		SetPageUptodate(page);
+
+	/*
+	 * Not convinced about this at all. See disparity comment above. For
+	 * now we know ntfs_prepare_write() would have failed in the write
+	 * exceeds i_size case, so this will never trigger which is fine.
+	 */
+	if (pos > vi->i_size) {
+		vi->i_size = pos;
+		mark_inode_dirty(vi);
+	}
+	ntfs_debug("Done.");
+	return 0;
+}
+
+/**
+ * ntfs_commit_write - commit the received data
+ *
+ * This is called from generic_file_write() with i_sem held on the inode
+ * (@page->mapping->host). The @page is locked and kmap()ped so page_address()
+ * can simply be used. The source data has already been copied into the @page.
+ *
+ * Need to mark modified blocks dirty so they get written out later when
+ * ntfs_writepage() is invoked by the VM.
+ *
+ * Return 0 on success or -errno on error.
+ *
+ * Should be using generic_commit_write(). This marks buffers uptodate and
+ * dirty, sets the page uptodate if all buffers in the page are uptodate, and
+ * updates i_size if the end of io is beyond i_size. In that case, it also
+ * marks the inode dirty. - We could still use this (obviously except for
+ * NInoMstProtected() attributes, where we will need to duplicate the core code
+ * because we need our own async_io completion handler) but we could just do
+ * the i_size update in prepare write, when we resize the attribute. Then
+ * we would avoid the i_size update and mark_inode_dirty() happening here.
+ *
+ * Can't use generic_commit_write() due to ntfs specialities but can look at
+ * it for implementation guidance.
+ *
+ * If things have gone as outlined in ntfs_prepare_write(), then we do not
+ * need to do any page content modifications here at all, except in the write
+ * to resident attribute case, where we need to do the uptodate bringing here
+ * which we combine with the copying into the mft record which means we only
+ * need to map the mft record and find the attribute record in it only once.
+ */
+static int ntfs_commit_write(struct file *file, struct page *page,
+		unsigned from, unsigned to)
+{
+	s64 attr_pos;
+	struct inode *vi;
+	ntfs_inode *ni, *base_ni;
+	char *kaddr, *kattr;
+	attr_search_context *ctx;
+	MFT_RECORD *m;
+	u32 attr_len, bytes;
+	int err;
+
+	vi = page->mapping->host;
+	ni = NTFS_I(vi);
+
+	ntfs_debug("Entering for inode %li, attribute type 0x%x, page index "
+			"0x%lx, from = %u, to = %u.", vi->i_ino, ni->type,
+			page->index, from, to);
+
+	if (NInoNonResident(ni)) {
+		/*
+		 * Only unnamed $DATA attributes can be compressed, encrypted,
+		 * and/or sparse.
+		 */
+		if (ni->type == AT_DATA && !ni->name_len) {
+			/* If file is encrypted, deny access, just like NT4. */
+			if (NInoEncrypted(ni)) {
+				// Should never get here!
+				ntfs_debug("Denying write access to encrypted "
+						"file.");
+				return -EACCES;
+			}
+			/* Compressed data streams are handled in compress.c. */
+			if (NInoCompressed(ni)) {
+				// TODO: Implement and replace this check with
+				// return ntfs_write_compressed_block(page);
+				// Should never get here!
+				ntfs_error(vi->i_sb, "Writing to compressed "
+						"files is not supported yet. "
+						"Sorry.");
+				return -EOPNOTSUPP;
+			}
+			// TODO: Implement and remove this check.
+			if (NInoSparse(ni)) {
+				// Should never get here!
+				ntfs_error(vi->i_sb, "Writing to sparse files "
+						"is not supported yet. Sorry.");
+				return -EOPNOTSUPP;
+			}
+		}
+
+		// TODO: Implement and remove this check.
+		if (NInoMstProtected(ni)) {
+			// Should never get here!
+			ntfs_error(vi->i_sb, "Writing to MST protected "
+					"attributes is not supported yet. "
+					"Sorry.");
+			return -EOPNOTSUPP;
+		}
+
+		/* Normal data stream. */
+		return ntfs_commit_nonresident_write(page, from, to);
+	}
+
+	/*
+	 * Attribute is resident, implying it is not compressed, encrypted, or
+	 * mst protected.
+	 */
+
+	/* Do we need to resize the attribute? */
+	if (((s64)page->index << PAGE_CACHE_SHIFT) + to > vi->i_size) {
+		// TODO: Implement resize...
+		// pos = ((s64)page->index << PAGE_CACHE_SHIFT) + to;
+		// vi->i_size = pos;
+		// mark_inode_dirty(vi);
+		// Should never get here!
+		ntfs_error(vi->i_sb, "Writing beyond the existing file size is "
+				"not supported yet. Sorry.");
+		return -EOPNOTSUPP;
+	}
+
+	if (!NInoAttr(ni))
+		base_ni = ni;
+	else
+		base_ni = ni->_INE(base_ntfs_ino);
+
+	/* Map, pin, and lock the mft record. */
+	m = map_mft_record(base_ni);
+	if (unlikely(IS_ERR(m))) {
+		err = PTR_ERR(m);
+		m = NULL;
+		ctx = NULL;
+		goto err_out;
+	}
+	ctx = get_attr_search_ctx(base_ni, m);
+	if (unlikely(!ctx)) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	if (unlikely(!lookup_attr(ni->type, ni->name, ni->name_len,
+			IGNORE_CASE, 0, NULL, 0, ctx))) {
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	/* Starting position of the page within the attribute value. */
+	attr_pos = page->index << PAGE_CACHE_SHIFT;
+
+	/* The total length of the attribute value. */
+	attr_len = le32_to_cpu(ctx->attr->_ARA(value_length));
+
+	if (unlikely(vi->i_size != attr_len)) {
+		ntfs_error(vi->i_sb, "BUG()! i_size (0x%Lx) doesn't match "
+				"attr_len (0x%x). Aborting write.", vi->i_size,
+				attr_len);
+		err = -EIO;
+		goto err_out;
+	}
+	if (unlikely(attr_pos >= attr_len)) {
+		ntfs_error(vi->i_sb, "BUG()! attr_pos (0x%Lx) > attr_len (0x%x)"
+				". Aborting write.", attr_pos, attr_len);
+		err = -EIO;
+		goto err_out;
+	}
+
+	bytes = attr_len - attr_pos;
+	if (unlikely(bytes > PAGE_CACHE_SIZE))
+		bytes = PAGE_CACHE_SIZE;
+
+	/*
+	 * Calculate the address of the attribute value corresponding to the
+	 * beginning of the current data @page.
+	 */
+	kattr = (u8*)ctx->attr + le16_to_cpu(ctx->attr->_ARA(value_offset)) +
+			attr_pos;
+
+	kaddr = kmap_atomic(page, KM_USER0);
+
+	/* Copy the received data from the page to the mft record. */
+	memcpy(kattr + from, kaddr + from, to - from);
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
+
+	if (!PageUptodate(page)) {
+		/*
+		 * Bring the out of bounds area(s) uptodate by copying data
+		 * from the mft record to the page.
+	 	 */
+		if (from > 0)
+			memcpy(kaddr, kattr, from);
+		if (to < bytes)
+			memcpy(kaddr + to, kattr + to, bytes - to);
+
+		/* Zero the region outside the end of the attribute value. */
+		if (likely(bytes < PAGE_CACHE_SIZE))
+			memset(kaddr + bytes, 0, PAGE_CACHE_SIZE - bytes);
+
+		/*
+		 * The probability of not having done any of the above is
+		 * extremely small, so we just flush unconditionally.
+		 */
+		flush_dcache_page(page);
+		SetPageUptodate(page);
+	}
+	kunmap_atomic(kaddr, KM_USER0);
+
+	// TODO: Mark mft record dirty so it gets written back.
+	ntfs_error(vi->i_sb, "Writing to resident files is not supported yet. "
+			"Wrote to memory only...");
+
+	put_attr_search_ctx(ctx);
+	unmap_mft_record(base_ni);
+	ntfs_debug("Done.");
+	return 0;
+err_out:
+	if (err == -ENOMEM) {
+		ntfs_warning(vi->i_sb, "Error allocating memory required to "
+				"commit the write.");
+		if (PageUptodate(page)) {
+			ntfs_warning(vi->i_sb, "Page is uptodate, setting "
+					"dirty so the write will be retried "
+					"later on by the VM.");
+			/*
+			 * Put the page on mapping->dirty_pages, but leave its
+			 * buffer's dirty state as-is.
+			 */
+			__set_page_dirty_nobuffers(page);
+			err = 0;
+		} else
+			ntfs_error(vi->i_sb, "Page is not uptodate. Written "
+					"data has been lost. )-:");
+	} else {
+		ntfs_error(vi->i_sb, "Resident attribute write failed with "
+				"error %i. Setting page error flag.", -err);
+		SetPageError(page);
+	}
+	if (ctx)
+		put_attr_search_ctx(ctx);
+	if (m)
+		unmap_mft_record(base_ni);
+	return err;
+}
+
 #endif	/* NTFS_RW */
 
 /**
@@ -1008,6 +1773,9 @@
 						   disk request queue. */
 #ifdef NTFS_RW
 	.writepage	= ntfs_writepage,	/* Write dirty page to disk. */
+	.prepare_write	= ntfs_prepare_write,	/* Prepare page and buffers
+						   ready to receive data. */
+	.commit_write	= ntfs_commit_write,	/* Commit received data. */
 #endif
 };
 
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	Tue Aug 20 23:58:06 2002
+++ b/fs/ntfs/attrib.c	Tue Aug 20 23:58:06 2002
@@ -1182,8 +1182,9 @@
 		else {
 			register int rc;
 			
-			rc = memcmp(val, (u8*)a +le16_to_cpu(a->_ARA(value_offset)),
-				min(val_len, le32_to_cpu(a->_ARA(value_length))));
+			rc = memcmp(val, (u8*)a + le16_to_cpu(
+					a->_ARA(value_offset)), min(val_len,
+					le32_to_cpu(a->_ARA(value_length))));
 			/*
 			 * If @val collates before the current attribute's
 			 * value, there is no matching attribute.
diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	Tue Aug 20 23:58:06 2002
+++ b/fs/ntfs/file.c	Tue Aug 20 23:58:06 2002
@@ -51,6 +51,9 @@
 struct file_operations ntfs_file_ops = {
 	.llseek		= generic_file_llseek,	/* Seek inside file. */
 	.read		= generic_file_read,	/* Read from file. */
+#ifdef NTFS_RW
+	.write		= generic_file_write,	/* Write to a file. */
+#endif
 	.mmap		= generic_file_mmap,	/* Mmap file. */
 	.sendfile	= generic_file_sendfile,/* Zero-copy data send with the
 						   data source being on the
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	Tue Aug 20 23:58:06 2002
+++ b/fs/ntfs/mft.c	Tue Aug 20 23:58:06 2002
@@ -98,7 +98,7 @@
 }
 
 /**
- * From fs/ntfs/aops.c
+ * ntfs_readpage - external declaration, function is in fs/ntfs/aops.c
  */
 extern int ntfs_readpage(struct file *, struct page *);
 
@@ -109,12 +109,9 @@
  * ntfs_map_page() in map_mft_record_page().
  */
 struct address_space_operations ntfs_mft_aops = {
-	.writepage	= NULL,			/* Write dirty page to disk. */
 	.readpage	= ntfs_readpage,	/* Fill page with data. */
 	.sync_page	= block_sync_page,	/* Currently, just unplugs the
 						   disk request queue. */
-	.prepare_write	= NULL,			/* . */
-	.commit_write	= NULL,			/* . */
 };
 
 /**
diff -Nru a/fs/ntfs/mft.h b/fs/ntfs/mft.h
--- a/fs/ntfs/mft.h	Tue Aug 20 23:58:06 2002
+++ b/fs/ntfs/mft.h	Tue Aug 20 23:58:06 2002
@@ -43,5 +43,19 @@
 	return;
 }
 
+/*
+ * flush_dcache_mft_record_page - flush_dcache_page() for mft records
+ * @ni:		ntfs inode structure of mft record
+ *
+ * Call flush_dcache_page() for the page in which an mft record resides.
+ *
+ * This must be called every time an mft record is modified, just after the
+ * modification.
+ */
+static inline void flush_dcache_mft_record_page(ntfs_inode *ni)
+{
+	flush_dcache_page(ni->page);
+}
+
 #endif /* _LINUX_NTFS_MFT_H */
 

