Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSHTXkf>; Tue, 20 Aug 2002 19:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSHTXkf>; Tue, 20 Aug 2002 19:40:35 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:25816 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317517AbSHTXkX>; Tue, 20 Aug 2002 19:40:23 -0400
Subject: [BK-2.5 PATCH] NTFS 2.1.0 2/7: Add mmap(2) based overwrite code
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 21 Aug 2002 00:44:28 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17hIfk-0001Jq-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.5

Thanks! This is the 2nd changeset, adding mmap(2) based overwrite code.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/ntfs/aops.c |  566 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 566 insertions(+)

through these ChangeSets:

<aia21@cantab.net> (02/08/13 1.456.26.3)
   NTFS: Initial implementation of mmap(2) based overwriting
   of existing files on ntfs. (Note: Resident files are not
   supported yet, so avoid writing to files smaller than 1kiB.)


diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Tue Aug 20 23:57:16 2002
+++ b/fs/ntfs/aops.c	Tue Aug 20 23:57:16 2002
@@ -435,6 +435,569 @@
 	return err;
 }
 
+#ifdef NTFS_RW
+
+/**
+ * ntfs_write_block - write a @page to the backing store
+ * @page:	page cache page to write out
+ *
+ * This function is for writing pages belonging to non-resident, non-mst
+ * protected attributes to their backing store.
+ *
+ * For a page with buffers, map and write the dirty buffers asynchronously
+ * under page writeback. For a page without buffers, create buffers for the
+ * page, then proceed as above.
+ *
+ * If a page doesn't have buffers the page dirty state is definitive. If a page
+ * does have buffers, the page dirty state is just a hint, and the buffer dirty
+ * state is definitive. (A hint which has rules: dirty buffers against a clean
+ * page is illegal. Other combinations are legal and need to be handled. In
+ * particular a dirty page containing clean buffers for example.)
+ *
+ * Return 0 on success and -errno on error.
+ *
+ * Based on ntfs_read_block() and __block_write_full_page().
+ */
+static int ntfs_write_block(struct page *page)
+{
+	VCN vcn;
+	LCN lcn;
+	struct inode *vi;
+	ntfs_inode *ni;
+	ntfs_volume *vol;
+	run_list_element *rl;
+	struct buffer_head *bh, *head;
+	sector_t block, dblock, iblock;
+	unsigned int blocksize, vcn_ofs;
+	int err;
+	BOOL need_end_writeback;
+	unsigned char blocksize_bits;
+
+	vi = page->mapping->host;
+	ni = NTFS_I(vi);
+	vol = ni->vol;
+
+	ntfs_debug("Entering for inode %li, attribute type 0x%x, page index "
+			"0x%lx.\n", vi->i_ino, ni->type, page->index);
+
+	BUG_ON(!NInoNonResident(ni));
+	BUG_ON(NInoMstProtected(ni));
+
+	blocksize_bits = vi->i_blkbits;
+	blocksize = 1 << blocksize_bits;
+
+	if (!page_has_buffers(page)) {
+		BUG_ON(!PageUptodate(page));
+		create_empty_buffers(page, blocksize,
+				(1 << BH_Uptodate) | (1 << BH_Dirty));
+	}
+	bh = head = page_buffers(page);
+	if (unlikely(!bh)) {
+		ntfs_warning(vol->sb, "Error allocating page buffers. "
+				"Redirtying page so we try again later.");
+		/*
+		 * Put the page back on mapping->dirty_pages, but leave its
+		 * buffer's dirty state as-is.
+		 */
+		// FIXME: Once Andrew's -EAGAIN patch goes in, remove the
+		// __set_page_dirty_nobuffers(page) and return -EAGAIN instead
+		// of zero.
+		__set_page_dirty_nobuffers(page);
+		unlock_page(page);
+		return 0;
+	}
+
+	/* NOTE: Different naming scheme to ntfs_read_block()! */
+
+	/* The first block in the page. */
+	block = page->index << (PAGE_CACHE_SHIFT - blocksize_bits);
+
+	/* The first out of bounds block for the data size. */
+	dblock = (vi->i_size + blocksize - 1) >> blocksize_bits;
+
+	/* The last (fully or partially) initialized block. */
+	iblock = ni->initialized_size >> blocksize_bits;
+
+	/*
+	 * Be very careful.  We have no exclusion from __set_page_dirty_buffers
+	 * here, and the (potentially unmapped) buffers may become dirty at
+	 * any time.  If a buffer becomes dirty here after we've inspected it
+	 * then we just miss that fact, and the page stays dirty.
+	 *
+	 * Buffers outside i_size may be dirtied by __set_page_dirty_buffers;
+	 * handle that here by just cleaning them.
+	 */
+
+	/*
+	 * Loop through all the buffers in the page, mapping all the dirty
+	 * buffers to disk addresses and handling any aliases from the
+	 * underlying block device's mapping.
+	 */
+	rl = NULL;
+	err = 0;
+	do {
+		BOOL is_retry = FALSE;
+
+		if (unlikely(block >= dblock)) {
+			/*
+			 * Mapped buffers outside i_size will occur, because
+			 * this page can be outside i_size when there is a
+			 * truncate in progress. The contents of such buffers
+			 * were zeroed by ntfs_writepage().
+			 *
+			 * FIXME: What about the small race window where
+			 * ntfs_writepage() has not done any clearing because
+			 * the page was within i_size but before we get here,
+			 * vmtruncate() modifies i_size?
+			 */
+			clear_buffer_dirty(bh);
+			set_buffer_uptodate(bh);
+			continue;
+		}
+
+		/* Clean buffers are not written out, so no need to map them. */
+		if (!buffer_dirty(bh))
+			continue;
+
+		/* Make sure we have enough initialized size. */
+		if (unlikely((block >= iblock) && (iblock < dblock))) {
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
+			 * all non-uptodate buffers and set them uptodate.
+			 * Note, there aren't any non-uptodate buffers if the
+			 * page is uptodate.
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
+			break;
+		}
+
+		/* No need to map buffers that are already mapped. */
+		if (buffer_mapped(bh))
+			continue;
+
+		/* Unmapped, dirty buffer. Need to map it. */
+		bh->b_bdev = vol->sb->s_bdev;
+
+		/* Convert block into corresponding vcn and offset. */
+		vcn = (VCN)block << blocksize_bits >> vol->cluster_size_bits;
+		vcn_ofs = ((VCN)block << blocksize_bits) &
+				vol->cluster_size_mask;
+		if (!rl) {
+lock_retry_remap:
+			down_read(&ni->run_list.lock);
+			rl = ni->run_list.rl;
+		}
+		if (likely(rl != NULL)) {
+			/* Seek to element containing target vcn. */
+			while (rl->length && rl[1].vcn <= vcn)
+				rl++;
+			lcn = vcn_to_lcn(rl, vcn);
+		} else
+			lcn = (LCN)LCN_RL_NOT_MAPPED;
+		/* Successful remap. */
+		if (lcn >= 0) {
+			/* Setup buffer head to point to correct block. */
+			bh->b_blocknr = ((lcn << vol->cluster_size_bits) +
+					vcn_ofs) >> blocksize_bits;
+			set_buffer_mapped(bh);
+			continue;
+		}
+		/* It is a hole, need to instantiate it. */
+		if (lcn == LCN_HOLE) {
+			// TODO: Instantiate the hole.
+			// clear_buffer_new(bh);
+			// unmap_underlying_metadata(bh->b_bdev, bh->b_blocknr);
+			ntfs_error(vol->sb, "Writing into sparse regions is "
+					"not supported yet. Sorry.");
+			err = -EOPNOTSUPP;
+			break;
+		}
+		/* If first try and run list unmapped, map and retry. */
+		if (!is_retry && lcn == LCN_RL_NOT_MAPPED) {
+			is_retry = TRUE;
+			/*
+			 * Attempt to map run list, dropping lock for
+			 * the duration.
+			 */
+			up_read(&ni->run_list.lock);
+			err = map_run_list(ni, vcn);
+			if (likely(!err))
+				goto lock_retry_remap;
+			rl = NULL;
+		}
+		/* Failed to map the buffer, even after retrying. */
+		bh->b_blocknr = -1UL;
+		ntfs_error(vol->sb, "vcn_to_lcn(vcn = 0x%Lx) failed "
+				"with error code 0x%Lx%s.",
+				(long long)vcn, (long long)-lcn,
+				is_retry ? " even after retrying" : "");
+		// FIXME: Depending on vol->on_errors, do something.
+		if (!err)
+			err = -EIO;
+		break;
+	} while (block++, (bh = bh->b_this_page) != head);
+
+	/* Release the lock if we took it. */
+	if (rl)
+		up_read(&ni->run_list.lock);
+
+	/* For the error case, need to reset bh to the beginning. */
+	bh = head;
+
+	/* Just an optimization, so ->readpage() isn't called later. */
+	if (unlikely(!PageUptodate(page))) {
+		int uptodate = 1;
+		do {
+			if (!buffer_uptodate(bh)) {
+				uptodate = 0;
+				bh = head;
+				break;
+			}
+		} while ((bh = bh->b_this_page) != head);
+		if (uptodate)
+			SetPageUptodate(page);
+	}
+
+	/* Setup all mapped, dirty buffers for async write i/o. */
+	do {
+		get_bh(bh);
+		if (buffer_mapped(bh) && buffer_dirty(bh)) {
+			lock_buffer(bh);
+			if (test_clear_buffer_dirty(bh)) {
+				BUG_ON(!buffer_uptodate(bh));
+				mark_buffer_async_write(bh);
+			} else
+				unlock_buffer(bh);
+		} else if (unlikely(err)) {
+			/*
+			 * For the error case. The buffer may have been set
+			 * dirty during attachment to a dirty page.
+			 */
+			if (err != -ENOMEM)
+				clear_buffer_dirty(bh);
+		}
+	} while ((bh = bh->b_this_page) != head);
+
+	if (unlikely(err)) {
+		// TODO: Remove the -EOPNOTSUPP check later on...
+		if (unlikely(err == -EOPNOTSUPP))
+			err = 0;
+		else if (err == -ENOMEM) {
+			ntfs_warning(vol->sb, "Error allocating memory. "
+					"Redirtying page so we try again "
+					"later.");
+			/*
+			 * Put the page back on mapping->dirty_pages, but
+			 * leave its buffer's dirty state as-is.
+			 */
+			// FIXME: Once Andrew's -EAGAIN patch goes in, remove
+			// the __set_page_dirty_nobuffers(page) and set err to
+			// -EAGAIN instead of zero.
+			__set_page_dirty_nobuffers(page);
+			err = 0;
+		} else
+			SetPageError(page);
+	}
+
+	BUG_ON(PageWriteback(page));
+	SetPageWriteback(page);		/* Keeps try_to_free_buffers() away. */
+	unlock_page(page);
+
+	/*
+	 * Submit the prepared buffers for i/o. Note the page is unlocked,
+	 * and the async write i/o completion handler can end_page_writeback()
+	 * at any time after the *first* submit_bh(). So the buffers can then
+	 * disappear...
+	 */
+	need_end_writeback = TRUE;
+	do {
+		struct buffer_head *next = bh->b_this_page;
+		if (buffer_async_write(bh)) {
+			submit_bh(WRITE, bh);
+			need_end_writeback = FALSE;
+		}
+		put_bh(bh);
+		bh = next;
+	} while (bh != head);
+
+	/* If no i/o was started, need to end_page_writeback(). */
+	if (unlikely(need_end_writeback))
+		end_page_writeback(page);
+
+	ntfs_debug("Done.");
+	return err;
+}
+
+/**
+ * ntfs_writepage - write a @page to the backing store
+ * @page:	page cache page to write out
+ *
+ * For non-resident attributes, ntfs_writepage() writes the @page by calling
+ * the ntfs version of the generic block_write_full_page() function,
+ * ntfs_write_block(), which in turn if necessary creates and writes the
+ * buffers associated with the page asynchronously.
+ *
+ * For resident attributes, OTOH, ntfs_writepage() writes the @page by copying
+ * the data to the mft record (which at this stage is most likely in memory).
+ * Thus, in this case, I/O is synchronous, as even if the mft record is not
+ * cached at this point in time, we need to wait for it to be read in before we
+ * can do the copy.
+ *
+ * Note the caller clears the page dirty flag before calling ntfs_writepage().
+ *
+ * Based on ntfs_readpage() and fs/buffer.c::block_write_full_page().
+ *
+ * Return 0 on success and -errno on error.
+ */
+int ntfs_writepage(struct page *page)
+{
+	s64 attr_pos;
+	struct inode *vi;
+	ntfs_inode *ni, *base_ni;
+	ntfs_volume *vol;
+	char *kaddr;
+	attr_search_context *ctx;
+	MFT_RECORD *m;
+	u32 attr_len, bytes;
+	int err;
+
+	BUG_ON(!PageLocked(page));
+
+	vi = page->mapping->host;
+
+	/* Is the page fully outside i_size? (truncate in progress) */
+	if (unlikely(page->index >= (vi->i_size + PAGE_CACHE_SIZE - 1) >>
+			PAGE_CACHE_SHIFT)) {
+		unlock_page(page);
+		ntfs_debug("Write outside i_size. Returning i/o error.");
+		return -EIO;
+	}
+
+	ni = NTFS_I(vi);
+	vol = ni->vol;
+
+	if (NInoNonResident(ni)) {
+		/*
+		 * Only unnamed $DATA attributes can be compressed, encrypted,
+		 * and/or sparse.
+		 */
+		if (ni->type == AT_DATA && !ni->name_len) {
+			/* If file is encrypted, deny access, just like NT4. */
+			if (NInoEncrypted(ni)) {
+				unlock_page(page);
+				ntfs_debug("Denying write access to encrypted "
+						"file.");
+				return -EACCES;
+			}
+			/* Compressed data streams are handled in compress.c. */
+			if (NInoCompressed(ni)) {
+				// TODO: Implement and replace this check with
+				// return ntfs_write_compressed_block(page);
+				unlock_page(page);
+				ntfs_error(vol->sb, "Writing to compressed "
+						"files is not supported yet. "
+						"Sorry.");
+				return -EOPNOTSUPP;
+			}
+			// TODO: Implement and remove this check.
+			if (NInoSparse(ni)) {
+				unlock_page(page);
+				ntfs_error(vol->sb, "Writing to sparse files "
+						"is not supported yet. Sorry.");
+				return -EOPNOTSUPP;
+			}
+		}
+
+		/* We have to zero every time due to mmap-at-end-of-file. */
+		if (page->index >= (vi->i_size >> PAGE_CACHE_SHIFT)) {
+			/* The page straddles i_size. */
+			unsigned int ofs = vi->i_size & ~PAGE_CACHE_MASK;
+			kaddr = kmap_atomic(page, KM_USER0);
+			memset(kaddr + ofs, 0, PAGE_CACHE_SIZE - ofs);
+			flush_dcache_page(page);
+			kunmap_atomic(kaddr, KM_USER0);
+		}
+
+		// TODO: Implement and remove this check.
+		if (NInoMstProtected(ni)) {
+			unlock_page(page);
+			ntfs_error(vol->sb, "Writing to MST protected "
+					"attributes is not supported yet. "
+					"Sorry.");
+			return -EOPNOTSUPP;
+		}
+
+		/* Normal data stream. */
+		return ntfs_write_block(page);
+	}
+
+	/*
+	 * Attribute is resident, implying it is not compressed, encrypted, or
+	 * mst protected.
+	 */
+	BUG_ON(page_has_buffers(page));
+	BUG_ON(!PageUptodate(page));
+
+	// TODO: Consider using PageWriteback() + unlock_page() in 2.5 once the
+	// "VM fiddling has ended". Note, don't forget to replace all the
+	// unlock_page() calls further below with end_page_writeback() ones.
+	// FIXME: Make sure it is ok to SetPageError() on unlocked page under
+	// writeback before doing the change!
+#if 0
+	SetPageWriteback(page);
+	unlock_page(page);
+#endif
+
+	if (!NInoAttr(ni))
+		base_ni = ni;
+	else
+		base_ni = ni->_INE(base_ntfs_ino);
+
+	/* Map, pin and lock the mft record. */
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
+		ntfs_error(vol->sb, "BUG()! i_size (0x%Lx) doesn't match "
+				"attr_len (0x%x). Aborting write.", vi->i_size,
+				attr_len);
+		err = -EIO;
+		goto err_out;
+	}
+	if (unlikely(attr_pos >= attr_len)) {
+		ntfs_error(vol->sb, "BUG()! attr_pos (0x%Lx) > attr_len (0x%x)"
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
+	 * Here, we don't need to zero the out of bounds area everytime because
+	 * the below memcpy() already takes care of the mmap-at-end-of-file
+	 * requirements. If the file is converted to a non-resident one, then
+	 * the code path use is switched to the non-resident one where the
+	 * zeroing happens on each ntfs_writepage() invokation.
+	 *
+	 * The above also applies nicely when i_size is decreased.
+	 *
+	 * When i_size is increased, the memory between the old and new i_size
+	 * _must_ be zeroed (or overwritten with new data). Otherwise we will
+	 * expose data to userspace/disk which should never have been exposed.
+	 *
+	 * FIXME: Ensure that i_size increases do the zeroing/overwriting and
+	 * if we cannot guarantee that, then enable the zeroing below.
+	 */
+
+	kaddr = kmap_atomic(page, KM_USER0);
+	/* Copy the data from the page to the mft record. */
+	memcpy((u8*)ctx->attr + le16_to_cpu(ctx->attr->_ARA(value_offset)) +
+			attr_pos, kaddr, bytes);
+#if 0
+	/* Zero out of bounds area. */
+	if (likely(bytes < PAGE_CACHE_SIZE)) {
+		memset(kaddr + bytes, 0, PAGE_CACHE_SIZE - bytes);
+		flush_dcache_page(page);
+	}
+#endif
+	kunmap_atomic(kaddr, KM_USER0);
+
+	unlock_page(page);
+
+	// TODO: Mark mft record dirty so it gets written back.
+	ntfs_error(vol->sb, "Writing to resident files is not supported yet. "
+			"Wrote to memory only...");
+
+	put_attr_search_ctx(ctx);
+	unmap_mft_record(base_ni);
+	return 0;
+err_out:
+	if (err == -ENOMEM) {
+		ntfs_warning(vol->sb, "Error allocating memory. Redirtying "
+				"page so we try again later.");
+		/*
+		 * Put the page back on mapping->dirty_pages, but leave its
+		 * buffer's dirty state as-is.
+		 */
+		// FIXME: Once Andrew's -EAGAIN patch goes in, remove the
+		// __set_page_dirty_nobuffers(page) and set err to -EAGAIN
+		// instead of zero.
+		__set_page_dirty_nobuffers(page);
+		err = 0;
+	} else {
+		ntfs_error(vol->sb, "Resident attribute write failed with "
+				"error %i. Setting page error flag.", -err);
+		SetPageError(page);
+	}
+	unlock_page(page);
+	if (ctx)
+		put_attr_search_ctx(ctx);
+	if (m)
+		unmap_mft_record(base_ni);
+	return err;
+}
+
+#endif	/* NTFS_RW */
+
 /**
  * ntfs_aops - general address space operations for inodes and attributes
  */
@@ -442,5 +1005,8 @@
 	.readpage	= ntfs_readpage,	/* Fill page with data. */
 	.sync_page	= block_sync_page,	/* Currently, just unplugs the
 						   disk request queue. */
+#ifdef NTFS_RW
+	.writepage	= ntfs_writepage,	/* Write dirty page to disk. */
+#endif
 };
 

