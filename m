Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUKJN4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUKJN4A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 08:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUKJNxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:53:43 -0500
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:2690 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261898AbUKJNo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:44:59 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 11/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsmK-0006P1-Jb@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:44:52 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 11/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/28 1.2026.1.36)
   NTFS: Implement extension of resident files in the regular file write code
         paths (fs/ntfs/aops.c::ntfs_{prepare,commit}_write()).  At present
         this only works until the data attribute becomes too big for the mft
         record after which we abort the write returning -EOPNOTSUPP from
         ntfs_prepare_write().
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:44:56 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:44:56 +00:00
@@ -45,6 +45,11 @@
 	- In fs/ntfs/aops.c::ntfs_writepage(), if t he page is fully outside
 	  i_size, i.e. race with truncate, invalidate the buffers on the page
 	  so that they become freeable and hence the page does not leak.
+	- Implement extension of resident files in the regular file write code
+	  paths (fs/ntfs/aops.c::ntfs_{prepare,commit}_write()).  At present
+	  this only works until the data attribute becomes too big for the mft
+	  record after which we abort the write returning -EOPNOTSUPP from
+	  ntfs_prepare_write().
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-11-10 13:44:56 +00:00
+++ b/fs/ntfs/aops.c	2004-11-10 13:44:56 +00:00
@@ -1201,10 +1201,9 @@
 		/* Normal data stream. */
 		return ntfs_write_block(wbc, page);
 	}
-
 	/*
-	 * Attribute is resident, implying it is not compressed, encrypted, or
-	 * mst protected.
+	 * Attribute is resident, implying it is not compressed, encrypted,
+	 * sparse, or mst protected.
 	 */
 	BUG_ON(page_has_buffers(page));
 	BUG_ON(!PageUptodate(page));
@@ -1283,6 +1282,9 @@
 	 * zeroing below is enabled, we MUST move the unlock_page() from above
 	 * to after the kunmap_atomic(), i.e. just before the
 	 * end_page_writeback().
+	 * UPDATE: ntfs_prepare/commit_write() do the zeroing on i_size
+	 * increases for resident attributes so those are ok.
+	 * TODO: ntfs_truncate(), others?
 	 */
 
 	kaddr = kmap_atomic(page, KM_USER0);
@@ -1360,7 +1362,6 @@
 			page->index, from, to);
 
 	BUG_ON(!NInoNonResident(ni));
-	BUG_ON(NInoMstProtected(ni));
 
 	blocksize_bits = vi->i_blkbits;
 	blocksize = 1 << blocksize_bits;
@@ -1688,8 +1689,8 @@
  * ntfs_prepare_write - prepare a page for receiving data
  *
  * This is called from generic_file_write() with i_sem held on the inode
- * (@page->mapping->host). The @page is locked and kmap()ped so page_address()
- * can simply be used. The source data has not yet been copied into the @page.
+ * (@page->mapping->host).  The @page is locked but not kmap()ped.  The source
+ * data has not yet been copied into the @page.
  *
  * Need to extend the attribute/fill in holes if necessary, create blocks and
  * make partially overwritten blocks uptodate,
@@ -1699,8 +1700,8 @@
  * Return 0 on success or -errno on error.
  *
  * Should be using block_prepare_write() [support for sparse files] or
- * cont_prepare_write() [no support for sparse files]. Can't do that due to
- * ntfs specifics but can look at them for implementation guidancea.
+ * cont_prepare_write() [no support for sparse files].  Cannot do that due to
+ * ntfs specifics but can look at them for implementation guidance.
  *
  * Note: In the range, @from is inclusive and @to is exclusive, i.e. @from is
  * the first byte in the page that will be written to and @to is the first byte
@@ -1709,18 +1710,40 @@
 static int ntfs_prepare_write(struct file *file, struct page *page,
 		unsigned from, unsigned to)
 {
+	s64 new_size;
 	struct inode *vi = page->mapping->host;
-	ntfs_inode   *ni = NTFS_I(vi);
+	ntfs_inode *base_ni = NULL, *ni = NTFS_I(vi);
+	ntfs_volume *vol = ni->vol;
+	ntfs_attr_search_ctx *ctx = NULL;
+	MFT_RECORD *m = NULL;
+	ATTR_RECORD *a;
+	u8 *kaddr;
+	u32 attr_len;
+	int err;
 
 	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
 			"0x%lx, from = %u, to = %u.", vi->i_ino, ni->type,
 			page->index, from, to);
-
 	BUG_ON(!PageLocked(page));
 	BUG_ON(from > PAGE_CACHE_SIZE);
 	BUG_ON(to > PAGE_CACHE_SIZE);
 	BUG_ON(from > to);
-
+	BUG_ON(NInoMstProtected(ni));
+	/*
+	 * If a previous ntfs_truncate() failed, repeat it and abort if it
+	 * fails again.
+	 */
+	if (unlikely(NInoTruncateFailed(ni))) {
+		down_write(&vi->i_alloc_sem);
+		err = ntfs_truncate(vi);
+		up_write(&vi->i_alloc_sem);
+		if (err || NInoTruncateFailed(ni)) {
+			if (!err)
+				err = -EIO;
+			goto err_out;
+		}
+	}
+	/* If the attribute is not resident, deal with it elsewhere. */
 	if (NInoNonResident(ni)) {
 		/*
 		 * Only unnamed $DATA attributes can be compressed, encrypted,
@@ -1749,33 +1772,106 @@
 				return -EOPNOTSUPP;
 			}
 		}
-
-		// TODO: Implement and remove this check.
-		if (NInoMstProtected(ni)) {
-			ntfs_error(vi->i_sb, "Writing to MST protected "
-					"attributes is not supported yet. "
-					"Sorry.");
-			return -EOPNOTSUPP;
-		}
-
 		/* Normal data stream. */
 		return ntfs_prepare_nonresident_write(page, from, to);
 	}
-
 	/*
 	 * Attribute is resident, implying it is not compressed, encrypted, or
-	 * mst protected.
+	 * sparse.
 	 */
 	BUG_ON(page_has_buffers(page));
-
-	/* Do we need to resize the attribute? */
-	if (((s64)page->index << PAGE_CACHE_SHIFT) + to > vi->i_size) {
-		// TODO: Implement resize...
-		ntfs_error(vi->i_sb, "Writing beyond the existing file size is "
-				"not supported yet. Sorry.");
-		return -EOPNOTSUPP;
+	new_size = ((s64)page->index << PAGE_CACHE_SHIFT) + to;
+	/* If we do not need to resize the attribute allocation we are done. */
+	if (new_size <= vi->i_size)
+		goto done;
+	/* Map, pin, and lock the (base) mft record. */
+	if (!NInoAttr(ni))
+		base_ni = ni;
+	else
+		base_ni = ni->ext.base_ntfs_ino;
+	m = map_mft_record(base_ni);
+	if (IS_ERR(m)) {
+		err = PTR_ERR(m);
+		m = NULL;
+		ctx = NULL;
+		goto err_out;
 	}
-
+	ctx = ntfs_attr_get_search_ctx(base_ni, m);
+	if (unlikely(!ctx)) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err)) {
+		if (err == -ENOENT)
+			err = -EIO;
+		goto err_out;
+	}
+	m = ctx->mrec;
+	a = ctx->attr;
+	/* The total length of the attribute value. */
+	attr_len = le32_to_cpu(a->data.resident.value_length);
+	BUG_ON(vi->i_size != attr_len);
+	/* Check if new size is allowed in $AttrDef. */
+	err = ntfs_attr_size_bounds_check(vol, ni->type, new_size);
+	if (unlikely(err)) {
+		if (err == -ERANGE) {
+			ntfs_error(vol->sb, "Write would cause the inode "
+					"0x%lx to exceed the maximum size for "
+					"its attribute type (0x%x).  Aborting "
+					"write.", vi->i_ino,
+					le32_to_cpu(ni->type));
+		} else {
+			ntfs_error(vol->sb, "Inode 0x%lx has unknown "
+					"attribute type 0x%x.  Aborting "
+					"write.", vi->i_ino,
+					le32_to_cpu(ni->type));
+			err = -EIO;
+		}
+		goto err_out2;
+	}
+	/*
+	 * Extend the attribute record to be able to store the new attribute
+	 * size.
+	 */
+	if (new_size >= vol->mft_record_size || ntfs_attr_record_resize(m, a,
+			le16_to_cpu(a->data.resident.value_offset) +
+			new_size)) {
+		/* Not enough space in the mft record. */
+		ntfs_error(vol->sb, "Not enough space in the mft record for "
+				"the resized attribute value.  This is not "
+				"supported yet.  Aborting write.");
+		err = -EOPNOTSUPP;
+		goto err_out2;
+	}
+	/*
+	 * We have enough space in the mft record to fit the write.  This
+	 * implies the attribute is smaller than the mft record and hence the
+	 * attribute must be in a single page and hence page->index must be 0.
+	 */
+	BUG_ON(page->index);
+	/*
+	 * If the beginning of the write is past the old size, enlarge the
+	 * attribute value up to the beginning of the write and fill it with
+	 * zeroes.
+	 */
+	if (from > attr_len) {
+		memset((u8*)a + le16_to_cpu(a->data.resident.value_offset) +
+				attr_len, 0, from - attr_len);
+		a->data.resident.value_length = cpu_to_le32(from);
+		/* Zero the corresponding area in the page as well. */
+		if (PageUptodate(page)) {
+			kaddr = kmap_atomic(page, KM_USER0);
+			memset(kaddr + attr_len, 0, from - attr_len);
+			kunmap_atomic(kaddr, KM_USER0);
+			flush_dcache_page(page);
+		}
+	}
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(base_ni);
 	/*
 	 * Because resident attributes are handled by memcpy() to/from the
 	 * corresponding MFT record, and because this form of i/o is byte
@@ -1785,26 +1881,30 @@
 	 * generic_file_write() does the copying from userspace.
 	 *
 	 * We thus defer the uptodate bringing of the page region outside the
-	 * region written to to ntfs_commit_write(). The reason for doing this
-	 * is that we save one round of:
-	 *	map_mft_record(), ntfs_attr_get_search_ctx(),
-	 *	ntfs_attr_lookup(), kmap_atomic(), kunmap_atomic(),
-	 *	ntfs_attr_put_search_ctx(), unmap_mft_record().
-	 * Which is obviously a very worthwhile save.
-	 *
-	 * Thus we just return success now...
+	 * region written to to ntfs_commit_write(), which makes the code
+	 * simpler and saves one atomic kmap which is good.
 	 */
+done:
 	ntfs_debug("Done.");
 	return 0;
+err_out:
+	if (err == -ENOMEM)
+		ntfs_warning(vi->i_sb, "Error allocating memory required to "
+				"prepare the write.");
+	else {
+		ntfs_error(vi->i_sb, "Resident attribute prepare write failed "
+				"with error %i.", err);
+		NVolSetErrors(vol);
+		make_bad_inode(vi);
+	}
+err_out2:
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	if (m)
+		unmap_mft_record(base_ni);
+	return err;
 }
 
-/*
- * NOTES: There is a disparity between the apparent need to extend the
- * attribute in prepare write but to update i_size only in commit write.
- * Need to make sure i_sem protection is sufficient. And if not will need to
- * handle this in some way or another.
- */
-
 /**
  * ntfs_commit_nonresident_write -
  *
@@ -1813,24 +1913,21 @@
 		unsigned from, unsigned to)
 {
 	s64 pos = ((s64)page->index << PAGE_CACHE_SHIFT) + to;
-	struct inode *vi;
+	struct inode *vi = page->mapping->host;
 	struct buffer_head *bh, *head;
 	unsigned int block_start, block_end, blocksize;
 	BOOL partial;
 
-	vi = page->mapping->host;
-
 	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
 			"0x%lx, from = %u, to = %u.", vi->i_ino,
 			NTFS_I(vi)->type, page->index, from, to);
-
 	blocksize = 1 << vi->i_blkbits;
 
-	// FIXME: We need a whole slew of special cases in here for MST
-	// protected attributes for example. For compressed files, too...
+	// FIXME: We need a whole slew of special cases in here for compressed
+	// files for example...
 	// For now, we know ntfs_prepare_write() would have failed so we can't
 	// get here in any of the cases which we have to special case, so we
-	// are just a ripped off unrolled generic_commit_write() at present.
+	// are just a ripped off, unrolled generic_commit_write().
 
 	bh = head = page_buffers(page);
 	block_start = 0;
@@ -1845,24 +1942,22 @@
 			mark_buffer_dirty(bh);
 		}
 	} while (block_start = block_end, (bh = bh->b_this_page) != head);
-
 	/*
 	 * If this is a partial write which happened to make all buffers
 	 * uptodate then we can optimize away a bogus ->readpage() for the next
-	 * read(). Here we 'discover' whether the page went uptodate as a
+	 * read().  Here we 'discover' whether the page went uptodate as a
 	 * result of this (potentially partial) write.
 	 */
 	if (!partial)
 		SetPageUptodate(page);
-
 	/*
-	 * Not convinced about this at all. See disparity comment above. For
+	 * Not convinced about this at all.  See disparity comment above.  For
 	 * now we know ntfs_prepare_write() would have failed in the write
 	 * exceeds i_size case, so this will never trigger which is fine.
 	 */
 	if (pos > vi->i_size) {
 		ntfs_error(vi->i_sb, "Writing beyond the existing file size is "
-				"not supported yet. Sorry.");
+				"not supported yet.  Sorry.");
 		return -EOPNOTSUPP;
 		// vi->i_size = pos;
 		// mark_inode_dirty(vi);
@@ -1875,118 +1970,73 @@
  * ntfs_commit_write - commit the received data
  *
  * This is called from generic_file_write() with i_sem held on the inode
- * (@page->mapping->host). The @page is locked and kmap()ped so page_address()
- * can simply be used. The source data has already been copied into the @page.
+ * (@page->mapping->host).  The @page is locked but not kmap()ped.  The source
+ * data has already been copied into the @page.  ntfs_prepare_write() has been
+ * called before the data copied and it returned success so we can take the
+ * results of various BUG checks and some error handling for granted.
  *
  * Need to mark modified blocks dirty so they get written out later when
  * ntfs_writepage() is invoked by the VM.
  *
  * Return 0 on success or -errno on error.
  *
- * Should be using generic_commit_write(). This marks buffers uptodate and
+ * Should be using generic_commit_write().  This marks buffers uptodate and
  * dirty, sets the page uptodate if all buffers in the page are uptodate, and
- * updates i_size if the end of io is beyond i_size. In that case, it also
- * marks the inode dirty. - We could still use this (obviously except for
- * NInoMstProtected() attributes, where we will need to duplicate the core code
- * because we need our own async_io completion handler) but we could just do
- * the i_size update in prepare write, when we resize the attribute. Then
- * we would avoid the i_size update and mark_inode_dirty() happening here.
+ * updates i_size if the end of io is beyond i_size.  In that case, it also
+ * marks the inode dirty.
  *
- * Can't use generic_commit_write() due to ntfs specialities but can look at
+ * Cannot use generic_commit_write() due to ntfs specialities but can look at
  * it for implementation guidance.
  *
  * If things have gone as outlined in ntfs_prepare_write(), then we do not
  * need to do any page content modifications here at all, except in the write
  * to resident attribute case, where we need to do the uptodate bringing here
- * which we combine with the copying into the mft record which means we only
- * need to map the mft record and find the attribute record in it only once.
+ * which we combine with the copying into the mft record which means we save
+ * one atomic kmap.
  */
 static int ntfs_commit_write(struct file *file, struct page *page,
 		unsigned from, unsigned to)
 {
-	s64 attr_pos;
-	struct inode *vi;
-	ntfs_inode *ni, *base_ni;
+	struct inode *vi = page->mapping->host;
+	ntfs_inode *base_ni, *ni = NTFS_I(vi);
 	char *kaddr, *kattr;
 	ntfs_attr_search_ctx *ctx;
 	MFT_RECORD *m;
-	u32 attr_len, bytes;
+	ATTR_RECORD *a;
+	u32 attr_len;
 	int err;
 
-	vi = page->mapping->host;
-	ni = NTFS_I(vi);
-
 	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
 			"0x%lx, from = %u, to = %u.", vi->i_ino, ni->type,
 			page->index, from, to);
-
+	/* If the attribute is not resident, deal with it elsewhere. */
 	if (NInoNonResident(ni)) {
-		/*
-		 * Only unnamed $DATA attributes can be compressed, encrypted,
-		 * and/or sparse.
-		 */
+		/* Only unnamed $DATA attributes can be compressed/encrypted. */
 		if (ni->type == AT_DATA && !ni->name_len) {
-			/* If file is encrypted, deny access, just like NT4. */
+			/* Encrypted files need separate handling. */
 			if (NInoEncrypted(ni)) {
-				// Should never get here!
-				ntfs_debug("Denying write access to encrypted "
-						"file.");
-				return -EACCES;
+				// We never get here at present!
+				BUG();
 			}
 			/* Compressed data streams are handled in compress.c. */
 			if (NInoCompressed(ni)) {
-				// TODO: Implement and replace this check with
+				// TODO: Implement this!
 				// return ntfs_write_compressed_block(page);
-				// Should never get here!
-				ntfs_error(vi->i_sb, "Writing to compressed "
-						"files is not supported yet. "
-						"Sorry.");
-				return -EOPNOTSUPP;
+				// We never get here at present!
+				BUG();
 			}
-			// TODO: Implement and remove this check.
-			if (NInoSparse(ni)) {
-				// Should never get here!
-				ntfs_error(vi->i_sb, "Writing to sparse files "
-						"is not supported yet. Sorry.");
-				return -EOPNOTSUPP;
-			}
-		}
-
-		// TODO: Implement and remove this check.
-		if (NInoMstProtected(ni)) {
-			// Should never get here!
-			ntfs_error(vi->i_sb, "Writing to MST protected "
-					"attributes is not supported yet. "
-					"Sorry.");
-			return -EOPNOTSUPP;
 		}
-
 		/* Normal data stream. */
 		return ntfs_commit_nonresident_write(page, from, to);
 	}
-
 	/*
 	 * Attribute is resident, implying it is not compressed, encrypted, or
-	 * mst protected.
+	 * sparse.
 	 */
-
-	/* Do we need to resize the attribute? */
-	if (((s64)page->index << PAGE_CACHE_SHIFT) + to > vi->i_size) {
-		// TODO: Implement resize...
-		// pos = ((s64)page->index << PAGE_CACHE_SHIFT) + to;
-		// vi->i_size = pos;
-		// mark_inode_dirty(vi);
-		// Should never get here!
-		ntfs_error(vi->i_sb, "Writing beyond the existing file size is "
-				"not supported yet. Sorry.");
-		return -EOPNOTSUPP;
-	}
-
 	if (!NInoAttr(ni))
 		base_ni = ni;
 	else
 		base_ni = ni->ext.base_ntfs_ino;
-
 	/* Map, pin, and lock the mft record. */
 	m = map_mft_record(base_ni);
 	if (IS_ERR(m)) {
@@ -2002,61 +2052,36 @@
 	}
 	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
 			CASE_SENSITIVE, 0, NULL, 0, ctx);
-	if (unlikely(err))
-		goto err_out;
-
-	/* Starting position of the page within the attribute value. */
-	attr_pos = page->index << PAGE_CACHE_SHIFT;
-
-	/* The total length of the attribute value. */
-	attr_len = le32_to_cpu(ctx->attr->data.resident.value_length);
-
-	if (unlikely(vi->i_size != attr_len)) {
-		ntfs_error(vi->i_sb, "BUG()! i_size (0x%llx) doesn't match "
-				"attr_len (0x%x). Aborting write.", vi->i_size,
-				attr_len);
-		err = -EIO;
+	if (unlikely(err)) {
+		if (err == -ENOENT)
+			err = -EIO;
 		goto err_out;
 	}
-	if (unlikely(attr_pos >= attr_len)) {
-		ntfs_error(vi->i_sb, "BUG()! attr_pos (0x%llx) > attr_len "
-				"(0x%x). Aborting write.",
-				(unsigned long long)attr_pos, attr_len);
-		err = -EIO;
-		goto err_out;
-	}
-
-	bytes = attr_len - attr_pos;
-	if (unlikely(bytes > PAGE_CACHE_SIZE))
-		bytes = PAGE_CACHE_SIZE;
-
-	/*
-	 * Calculate the address of the attribute value corresponding to the
-	 * beginning of the current data @page.
-	 */
-	kattr = (u8*)ctx->attr + le16_to_cpu(
-			ctx->attr->data.resident.value_offset) + attr_pos;
-
+	a = ctx->attr;
+	/* The total length of the attribute value. */
+	attr_len = le32_to_cpu(a->data.resident.value_length);
+	BUG_ON(from > attr_len);
+	kattr = (u8*)a + le16_to_cpu(a->data.resident.value_offset);
 	kaddr = kmap_atomic(page, KM_USER0);
-
 	/* Copy the received data from the page to the mft record. */
 	memcpy(kattr + from, kaddr + from, to - from);
-	flush_dcache_mft_record_page(ctx->ntfs_ino);
-
+	/* Update the attribute length if necessary. */
+	if (to > attr_len) {
+		attr_len = to;
+		a->data.resident.value_length = cpu_to_le32(attr_len);
+	}
+	/*
+	 * If the page is not uptodate, bring the out of bounds area(s)
+	 * uptodate by copying data from the mft record to the page.
+	 */
 	if (!PageUptodate(page)) {
-		/*
-		 * Bring the out of bounds area(s) uptodate by copying data
-		 * from the mft record to the page.
-		 */
 		if (from > 0)
 			memcpy(kaddr, kattr, from);
-		if (to < bytes)
-			memcpy(kaddr + to, kattr + to, bytes - to);
-
+		if (to < attr_len)
+			memcpy(kaddr + to, kattr + to, attr_len - to);
 		/* Zero the region outside the end of the attribute value. */
-		if (likely(bytes < PAGE_CACHE_SIZE))
-			memset(kaddr + bytes, 0, PAGE_CACHE_SIZE - bytes);
-
+		if (attr_len < PAGE_CACHE_SIZE)
+			memset(kaddr + attr_len, 0, PAGE_CACHE_SIZE - attr_len);
 		/*
 		 * The probability of not having done any of the above is
 		 * extremely small, so we just flush unconditionally.
@@ -2065,10 +2090,14 @@
 		SetPageUptodate(page);
 	}
 	kunmap_atomic(kaddr, KM_USER0);
-
+	/* Update i_size if necessary. */
+	if (vi->i_size < attr_len) {
+		ni->allocated_size = ni->initialized_size = attr_len;
+		i_size_write(vi, attr_len);
+	}
 	/* Mark the mft record dirty, so it gets written back. */
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
 	mark_mft_record_dirty(ctx->ntfs_ino);
-
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(base_ni);
 	ntfs_debug("Done.");
@@ -2083,17 +2112,18 @@
 					"later on by the VM.");
 			/*
 			 * Put the page on mapping->dirty_pages, but leave its
-			 * buffer's dirty state as-is.
+			 * buffers' dirty state as-is.
 			 */
 			__set_page_dirty_nobuffers(page);
 			err = 0;
 		} else
-			ntfs_error(vi->i_sb, "Page is not uptodate. Written "
-					"data has been lost. )-:");
+			ntfs_error(vi->i_sb, "Page is not uptodate.  Written "
+					"data has been lost.");
 	} else {
-		ntfs_error(vi->i_sb, "Resident attribute write failed with "
-				"error %i. Setting page error flag.", -err);
-		SetPageError(page);
+		ntfs_error(vi->i_sb, "Resident attribute commit write failed "
+				"with error %i.", err);
+		NVolSetErrors(ni->vol);
+		make_bad_inode(vi);
 	}
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
