Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268117AbUJSK1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268117AbUJSK1A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269395AbUJSK0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:26:09 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:6802 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268117AbUJSJr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:47:29 -0400
Date: Tue, 19 Oct 2004 10:47:23 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 35/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191046580.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191047120.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043240.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043370.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043500.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044130.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044280.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045410.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046000.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046160.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046300.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046440.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046580.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 35/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/16 1.2055)
   NTFS: Add fs/ntfs/mft.[hc]::ntfs_mft_record_alloc() and various helper
         functions used by it.
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:15:13 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:15:13 +01:00
@@ -136,6 +136,8 @@
 	- Add helpers fs/ntfs/layout.h::MK_MREF() and MK_LE_MREF().
 	- Modify fs/ntfs/mft.c::map_extent_mft_record() to only verify the mft
 	  record sequence number if it is specified (i.e. not zero).
+	- Add fs/ntfs/mft.[hc]::ntfs_mft_record_alloc() and various helper
+	  functions used by it.
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:15:13 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:15:13 +01:00
@@ -996,6 +996,1579 @@
 		"chkdsk.";
 
 /**
+ * ntfs_mft_bitmap_find_and_alloc_free_rec_nolock - see name
+ * @vol:	volume on which to search for a free mft record
+ * @base_ni:	open base inode if allocating an extent mft record or NULL
+ *
+ * Search for a free mft record in the mft bitmap attribute on the ntfs volume
+ * @vol.
+ *
+ * If @base_ni is NULL start the search at the default allocator position.
+ *
+ * If @base_ni is not NULL start the search at the mft record after the base
+ * mft record @base_ni.
+ *
+ * Return the free mft record on success and -errno on error.  An error code of
+ * -ENOSPC means that there are no free mft records in the currently
+ * initialized mft bitmap.
+ *
+ * Locking: Caller must hold vol->mftbmp_lock for writing.
+ */
+static int ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(ntfs_volume *vol,
+		ntfs_inode *base_ni)
+{
+	s64 pass_end, ll, data_pos, pass_start, ofs, bit;
+	struct address_space *mftbmp_mapping;
+	u8 *buf, *byte;
+	struct page *page;
+	unsigned int page_ofs, size;
+	u8 pass, b;
+
+	ntfs_debug("Searching for free mft record in the currently "
+			"initialized mft bitmap.");
+	mftbmp_mapping = vol->mftbmp_ino->i_mapping;
+	/*
+	 * Set the end of the pass making sure we do not overflow the mft
+	 * bitmap.
+	 */
+	pass_end = NTFS_I(vol->mft_ino)->allocated_size >>
+			vol->mft_record_size_bits;
+	ll = NTFS_I(vol->mftbmp_ino)->initialized_size << 3;
+	if (pass_end > ll)
+		pass_end = ll;
+	pass = 1;
+	if (!base_ni)
+		data_pos = vol->mft_data_pos;
+	else
+		data_pos = base_ni->mft_no + 1;
+	if (data_pos < 24)
+		data_pos = 24;
+	if (data_pos >= pass_end) {
+		data_pos = 24;
+		pass = 2;
+		/* This happens on a freshly formatted volume. */
+		if (data_pos >= pass_end)
+			return -ENOSPC;
+	}
+	pass_start = data_pos;
+	ntfs_debug("Starting bitmap search: pass %u, pass_start 0x%llx, "
+			"pass_end 0x%llx, data_pos 0x%llx.", pass,
+			(long long)pass_start, (long long)pass_end,
+			(long long)data_pos);
+	/* Loop until a free mft record is found. */
+	for (; pass <= 2;) {
+		/* Cap size to pass_end. */
+		ofs = data_pos >> 3;
+		page_ofs = ofs & ~PAGE_CACHE_MASK;
+		size = PAGE_CACHE_SIZE - page_ofs;
+		ll = ((pass_end + 7) >> 3) - ofs;
+		if (size > ll)
+			size = ll;
+		size <<= 3;
+		/*
+		 * If we are still within the active pass, search the next page
+		 * for a zero bit.
+		 */
+		if (size) {
+			page = ntfs_map_page(mftbmp_mapping,
+					ofs >> PAGE_CACHE_SHIFT);
+			if (unlikely(IS_ERR(page))) {
+				ntfs_error(vol->sb, "Failed to read mft "
+						"bitmap, aborting.");
+				return PTR_ERR(page);
+			}
+			buf = (u8*)page_address(page) + page_ofs;
+			bit = data_pos & 7;
+			data_pos &= ~7ull;
+			ntfs_debug("Before inner for loop: size 0x%x, "
+					"data_pos 0x%llx, bit 0x%llx", size,
+					(long long)data_pos, (long long)bit);
+			for (; bit < size && data_pos + bit < pass_end;
+					bit &= ~7ull, bit += 8) {
+				byte = buf + (bit >> 3);
+				if (*byte == 0xff)
+					continue;
+				b = ffz((unsigned long)*byte);
+				if (b < 8 && b >= (bit & 7)) {
+					ll = data_pos + (bit & ~7ull) + b;
+					if (unlikely(ll > (1ll << 32))) {
+						ntfs_unmap_page(page);
+						return -ENOSPC;
+					}
+					*byte |= 1 << b;
+					flush_dcache_page(page);
+					set_page_dirty(page);
+					ntfs_unmap_page(page);
+					ntfs_debug("Done.  (Found and "
+							"allocated mft record "
+							"0x%llx.)",
+							(long long)ll);
+					return ll;
+				}
+			}
+			ntfs_debug("After inner for loop: size 0x%x, "
+					"data_pos 0x%llx, bit 0x%llx", size,
+					(long long)data_pos, (long long)bit);
+			data_pos += size;
+			ntfs_unmap_page(page);
+			/*
+			 * If the end of the pass has not been reached yet,
+			 * continue searching the mft bitmap for a zero bit.
+			 */
+			if (data_pos < pass_end)
+				continue;
+		}
+		/* Do the next pass. */
+		if (++pass == 2) {
+			/*
+			 * Starting the second pass, in which we scan the first
+			 * part of the zone which we omitted earlier.
+			 */
+			pass_end = pass_start;
+			data_pos = pass_start = 24;
+			ntfs_debug("pass %i, pass_start 0x%llx, pass_end "
+					"0x%llx.", pass, (long long)pass_start,
+					(long long)pass_end);
+			if (data_pos >= pass_end)
+				break;
+		}
+	}
+	/* No free mft records in currently initialized mft bitmap. */
+	ntfs_debug("Done.  (No free mft records left in currently initialized "
+			"mft bitmap.)");
+	return -ENOSPC;
+}
+
+/**
+ * ntfs_mft_bitmap_extend_allocation_nolock - extend mft bitmap by a cluster
+ * @vol:	volume on which to extend the mft bitmap attribute
+ *
+ * Extend the mft bitmap attribute on the ntfs volume @vol by one cluster.
+ *
+ * Note: Only changes allocated_size, i.e. does not touch initialized_size or
+ * data_size.
+ *
+ * Return 0 on success and -errno on error.
+ *
+ * Locking: - Caller must hold vol->mftbmp_lock for writing.
+ *	    - This function takes NTFS_I(vol->mftbmp_ino)->runlist.lock for
+ *	      writing and releases it before returning.
+ *	    - This function takes vol->lcnbmp_lock for writing and releases it
+ *	      before returning.
+ */
+static int ntfs_mft_bitmap_extend_allocation_nolock(ntfs_volume *vol)
+{
+	LCN lcn;
+	s64 ll;
+	struct page *page;
+	ntfs_inode *mft_ni, *mftbmp_ni;
+	runlist_element *rl, *rl2 = NULL;
+	ntfs_attr_search_ctx *ctx = NULL;
+	MFT_RECORD *mrec;
+	ATTR_RECORD *a = NULL;
+	int ret, mp_size;
+	u32 old_alen = 0;
+	u8 *b, tb;
+	struct {
+		u8 added_cluster:1;
+		u8 added_run:1;
+		u8 mp_rebuilt:1;
+	} status = { 0, 0, 0 };
+
+	ntfs_debug("Extending mft bitmap allocation.");
+	mft_ni = NTFS_I(vol->mft_ino);
+	mftbmp_ni = NTFS_I(vol->mftbmp_ino);
+	/*
+	 * Determine the last lcn of the mft bitmap.  The allocated size of the
+	 * mft bitmap cannot be zero so we are ok to do this.
+	 * ntfs_find_vcn() returns the runlist locked on success.
+	 */
+	rl = ntfs_find_vcn(mftbmp_ni, (mftbmp_ni->allocated_size - 1) >>
+			vol->cluster_size_bits, TRUE);
+	if (unlikely(IS_ERR(rl) || !rl->length || rl->lcn < 0)) {
+		ntfs_error(vol->sb, "Failed to determine last allocated "
+				"cluster of mft bitmap attribute.");
+		if (!IS_ERR(rl)) {
+			up_write(&mftbmp_ni->runlist.lock);
+			ret = -EIO;
+		} else
+			ret = PTR_ERR(rl);
+		return ret;
+	}
+	lcn = rl->lcn + rl->length;
+	ntfs_debug("Last lcn of mft bitmap attribute is 0x%llx.",
+			(long long)lcn);
+	/*
+	 * Attempt to get the cluster following the last allocated cluster by
+	 * hand as it may be in the MFT zone so the allocator would not give it
+	 * to us.
+	 */
+	ll = lcn >> 3;
+	page = ntfs_map_page(vol->lcnbmp_ino->i_mapping,
+			ll >> PAGE_CACHE_SHIFT);
+	if (IS_ERR(page)) {
+		up_write(&mftbmp_ni->runlist.lock);
+		ntfs_error(vol->sb, "Failed to read from lcn bitmap.");
+		return PTR_ERR(page);
+	}
+	b = (u8*)page_address(page) + (ll & ~PAGE_CACHE_MASK);
+	tb = 1 << (lcn & 7ull);
+	down_write(&vol->lcnbmp_lock);
+	if (*b != 0xff && !(*b & tb)) {
+		/* Next cluster is free, allocate it. */
+		*b |= tb;
+		flush_dcache_page(page);
+		set_page_dirty(page);
+		up_write(&vol->lcnbmp_lock);
+		ntfs_unmap_page(page);
+		/* Update the mft bitmap runlist. */
+		rl->length++;
+		rl[1].vcn++;
+		status.added_cluster = 1;
+		ntfs_debug("Appending one cluster to mft bitmap.");
+	} else {
+		up_write(&vol->lcnbmp_lock);
+		ntfs_unmap_page(page);
+		/* Allocate a cluster from the DATA_ZONE. */
+		rl2 = ntfs_cluster_alloc(vol, rl[1].vcn, 1, lcn, DATA_ZONE);
+		if (IS_ERR(rl2)) {
+			up_write(&mftbmp_ni->runlist.lock);
+			ntfs_error(vol->sb, "Failed to allocate a cluster for "
+					"the mft bitmap.");
+			return PTR_ERR(rl2);
+		}
+		rl = ntfs_runlists_merge(mftbmp_ni->runlist.rl, rl2);
+		if (IS_ERR(rl)) {
+			up_write(&mftbmp_ni->runlist.lock);
+			ntfs_error(vol->sb, "Failed to merge runlists for mft "
+					"bitmap.");
+			if (ntfs_cluster_free_from_rl(vol, rl2)) {
+				ntfs_error(vol->sb, "Failed to dealocate "
+						"allocated cluster.%s", es);
+				NVolSetErrors(vol);
+			}
+			ntfs_free(rl2);
+			return PTR_ERR(rl);
+		}
+		mftbmp_ni->runlist.rl = rl;
+		status.added_run = 1;
+		ntfs_debug("Adding one run to mft bitmap.");
+		/* Find the last run in the new runlist. */
+		for (; rl[1].length; rl++)
+			;
+	}
+	/*
+	 * Update the attribute record as well.  Note: @rl is the last
+	 * (non-terminator) runlist element of mft bitmap.
+	 */
+	mrec = map_mft_record(mft_ni);
+	if (IS_ERR(mrec)) {
+		ntfs_error(vol->sb, "Failed to map mft record.");
+		ret = PTR_ERR(mrec);
+		goto undo_alloc;
+	}
+	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
+	if (unlikely(!ctx)) {
+		ntfs_error(vol->sb, "Failed to get search context.");
+		ret = -ENOMEM;
+		goto undo_alloc;
+	}
+	ret = ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
+			mftbmp_ni->name_len, CASE_SENSITIVE, rl[1].vcn, NULL,
+			0, ctx);
+	if (unlikely(ret)) {
+		ntfs_error(vol->sb, "Failed to find last attribute extent of "
+				"mft bitmap attribute.");
+		if (ret == -ENOENT)
+			ret = -EIO;
+		goto undo_alloc;
+	}
+	a = ctx->attr;
+	ll = sle64_to_cpu(a->data.non_resident.lowest_vcn);
+	/* Search back for the previous last allocated cluster of mft bitmap. */
+	for (rl2 = rl; rl2 > mftbmp_ni->runlist.rl; rl2--) {
+		if (ll >= rl2->vcn)
+			break;
+	}
+	BUG_ON(ll < rl2->vcn);
+	BUG_ON(ll >= rl2->vcn + rl2->length);
+	/* Get the size for the new mapping pairs array for this extent. */
+	mp_size = ntfs_get_size_for_mapping_pairs(vol, rl2, ll);
+	if (unlikely(mp_size <= 0)) {
+		ntfs_error(vol->sb, "Get size for mapping pairs failed for "
+				"mft bitmap attribute extent.");
+		ret = mp_size;
+		if (!ret)
+			ret = -EIO;
+		goto undo_alloc;
+	}
+	/* Expand the attribute record if necessary. */
+	old_alen = le32_to_cpu(a->length);
+	ret = ntfs_attr_record_resize(ctx->mrec, a, mp_size +
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset));
+	if (unlikely(ret)) {
+		if (ret != -ENOSPC) {
+			ntfs_error(vol->sb, "Failed to resize attribute "
+					"record for mft bitmap attribute.");
+			goto undo_alloc;
+		}
+		// TODO: Deal with this by moving this extent to a new mft
+		// record or by starting a new extent in a new mft record or by
+		// moving other attributes out of this mft record.
+		ntfs_error(vol->sb, "Not enough space in this mft record to "
+				"accomodate extended mft bitmap attribute "
+				"extent.  Cannot handle this yet.");
+		ret = -EOPNOTSUPP;
+		goto undo_alloc;
+	}
+	status.mp_rebuilt = 1;
+	/* Generate the mapping pairs array directly into the attr record. */
+	ret = ntfs_mapping_pairs_build(vol, (u8*)a +
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset),
+			mp_size, rl2, ll, NULL);
+	if (unlikely(ret)) {
+		ntfs_error(vol->sb, "Failed to build mapping pairs array for "
+				"mft bitmap attribute.");
+		goto undo_alloc;
+	}
+	/* Update the highest_vcn. */
+	a->data.non_resident.highest_vcn = cpu_to_sle64(rl[1].vcn - 1);
+	/*
+	 * We now have extended the mft bitmap allocated_size by one cluster.
+	 * Reflect this in the ntfs_inode structure and the attribute record.
+	 */
+	if (a->data.non_resident.lowest_vcn) {
+		/*
+		 * We are not in the first attribute extent, switch to it, but
+		 * first ensure the changes will make it to disk later.
+		 */
+		flush_dcache_mft_record_page(ctx->ntfs_ino);
+		mark_mft_record_dirty(ctx->ntfs_ino);
+		ntfs_attr_reinit_search_ctx(ctx);
+		ret = ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
+				mftbmp_ni->name_len, CASE_SENSITIVE, 0, NULL,
+				0, ctx);
+		if (unlikely(ret)) {
+			ntfs_error(vol->sb, "Failed to find first attribute "
+					"extent of mft bitmap attribute.");
+			goto restore_undo_alloc;
+		}
+		a = ctx->attr;
+	}
+	mftbmp_ni->allocated_size += vol->cluster_size;
+	a->data.non_resident.allocated_size =
+			cpu_to_sle64(mftbmp_ni->allocated_size);
+	/* Ensure the changes make it to disk. */
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(mft_ni);
+	up_write(&mftbmp_ni->runlist.lock);
+	ntfs_debug("Done.");
+	return 0;
+restore_undo_alloc:
+	ntfs_attr_reinit_search_ctx(ctx);
+	if (ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
+			mftbmp_ni->name_len, CASE_SENSITIVE, rl[1].vcn, NULL,
+			0, ctx)) {
+		ntfs_error(vol->sb, "Failed to find last attribute extent of "
+				"mft bitmap attribute.%s", es);
+		mftbmp_ni->allocated_size += vol->cluster_size;
+		ntfs_attr_put_search_ctx(ctx);
+		unmap_mft_record(mft_ni);
+		up_write(&mftbmp_ni->runlist.lock);
+		/*
+		 * The only thing that is now wrong is ->allocated_size of the
+		 * base attribute extent which chkdsk should be able to fix.
+		 */
+		NVolSetErrors(vol);
+		return ret;
+	}
+	a = ctx->attr;
+	a->data.non_resident.highest_vcn = cpu_to_sle64(rl[1].vcn - 2);
+undo_alloc:
+	if (status.added_cluster) {
+		/* Truncate the last run in the runlist by one cluster. */
+		rl->length--;
+		rl[1].vcn--;
+	} else if (status.added_run) {
+		lcn = rl->lcn;
+		/* Remove the last run from the runlist. */
+		rl->lcn = rl[1].lcn;
+		rl->length = 0;
+	}
+	/* Deallocate the cluster. */
+	down_write(&vol->lcnbmp_lock);
+	if (ntfs_bitmap_clear_bit(vol->lcnbmp_ino, lcn)) {
+		ntfs_error(vol->sb, "Failed to free allocated cluster.%s", es);
+		NVolSetErrors(vol);
+	}
+	up_write(&vol->lcnbmp_lock);
+	if (status.mp_rebuilt) {
+		if (ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(
+				a->data.non_resident.mapping_pairs_offset),
+				old_alen - le16_to_cpu(
+				a->data.non_resident.mapping_pairs_offset),
+				rl2, ll, NULL)) {
+			ntfs_error(vol->sb, "Failed to restore mapping pairs "
+					"array.%s", es);
+			NVolSetErrors(vol);
+		}
+		if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
+			ntfs_error(vol->sb, "Failed to restore attribute "
+					"record.%s", es);
+			NVolSetErrors(vol);
+		}
+		flush_dcache_mft_record_page(ctx->ntfs_ino);
+		mark_mft_record_dirty(ctx->ntfs_ino);
+	}
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	if (!IS_ERR(mrec))
+		unmap_mft_record(mft_ni);
+	up_write(&mftbmp_ni->runlist.lock);
+	return ret;
+}
+
+/**
+ * ntfs_mft_bitmap_extend_initialized_nolock - extend mftbmp initialized data
+ * @vol:	volume on which to extend the mft bitmap attribute
+ *
+ * Extend the initialized portion of the mft bitmap attribute on the ntfs
+ * volume @vol by 8 bytes.
+ *
+ * Note:  Only changes initialized_size and data_size, i.e. requires that
+ * allocated_size is big enough to fit the new initialized_size.
+ *
+ * Return 0 on success and -error on error.
+ *
+ * Locking: Caller must hold vol->mftbmp_lock for writing.
+ */
+static int ntfs_mft_bitmap_extend_initialized_nolock(ntfs_volume *vol)
+{
+	s64 old_data_size, old_initialized_size;
+	struct inode *mftbmp_vi;
+	ntfs_inode *mft_ni, *mftbmp_ni;
+	ntfs_attr_search_ctx *ctx;
+	MFT_RECORD *mrec;
+	ATTR_RECORD *a;
+	int ret;
+
+	ntfs_debug("Extending mft bitmap initiailized (and data) size.");
+	mft_ni = NTFS_I(vol->mft_ino);
+	mftbmp_vi = vol->mftbmp_ino;
+	mftbmp_ni = NTFS_I(mftbmp_vi);
+	/* Get the attribute record. */
+	mrec = map_mft_record(mft_ni);
+	if (IS_ERR(mrec)) {
+		ntfs_error(vol->sb, "Failed to map mft record.");
+		return PTR_ERR(mrec);
+	}
+	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
+	if (unlikely(!ctx)) {
+		ntfs_error(vol->sb, "Failed to get search context.");
+		ret = -ENOMEM;
+		goto unm_err_out;
+	}
+	ret = ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
+			mftbmp_ni->name_len, CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(ret)) {
+		ntfs_error(vol->sb, "Failed to find first attribute extent of "
+				"mft bitmap attribute.");
+		if (ret == -ENOENT)
+			ret = -EIO;
+		goto put_err_out;
+	}
+	a = ctx->attr;
+	old_data_size = mftbmp_vi->i_size;
+	old_initialized_size = mftbmp_ni->initialized_size;
+	/*
+	 * We can simply update the initialized_size before filling the space
+	 * with zeroes because the caller is holding the mft bitmap lock for
+	 * writing which ensures that no one else is trying to access the data.
+	 */
+	mftbmp_ni->initialized_size += 8;
+	a->data.non_resident.initialized_size =
+			cpu_to_sle64(mftbmp_ni->initialized_size);
+	if (mftbmp_ni->initialized_size > mftbmp_vi->i_size) {
+		mftbmp_vi->i_size = mftbmp_ni->initialized_size;
+		a->data.non_resident.data_size =
+				cpu_to_sle64(mftbmp_vi->i_size);
+	}
+	/* Ensure the changes make it to disk. */
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(mft_ni);
+	/* Initialize the mft bitmap attribute value with zeroes. */
+	ret = ntfs_attr_set(mftbmp_ni, old_initialized_size, 8, 0);
+	if (likely(!ret)) {
+		ntfs_debug("Done.  (Wrote eight initialized bytes to mft "
+				"bitmap.");
+		return 0;
+	}
+	ntfs_error(vol->sb, "Failed to write to mft bitmap.");
+	/* Try to recover from the error. */
+	mrec = map_mft_record(mft_ni);
+	if (IS_ERR(mrec)) {
+		ntfs_error(vol->sb, "Failed to map mft record.%s", es);
+		NVolSetErrors(vol);
+		return ret;
+	}
+	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
+	if (unlikely(!ctx)) {
+		ntfs_error(vol->sb, "Failed to get search context.%s", es);
+		NVolSetErrors(vol);
+		goto unm_err_out;
+	}
+	if (ntfs_attr_lookup(mftbmp_ni->type, mftbmp_ni->name,
+			mftbmp_ni->name_len, CASE_SENSITIVE, 0, NULL, 0, ctx)) {
+		ntfs_error(vol->sb, "Failed to find first attribute extent of "
+				"mft bitmap attribute.%s", es);
+		NVolSetErrors(vol);
+put_err_out:
+		ntfs_attr_put_search_ctx(ctx);
+unm_err_out:
+		unmap_mft_record(mft_ni);
+		goto err_out;
+	}
+	a = ctx->attr;
+	mftbmp_ni->initialized_size = old_initialized_size;
+	a->data.non_resident.initialized_size =
+			cpu_to_sle64(old_initialized_size);
+	if (mftbmp_vi->i_size != old_data_size) {
+		mftbmp_vi->i_size = old_data_size;
+		a->data.non_resident.data_size = cpu_to_sle64(old_data_size);
+	}
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(mft_ni);
+	ntfs_debug("Restored status of mftbmp: allocated_size 0x%llx, "
+			"data_size 0x%llx, initialized_size 0x%llx.",
+			(long long)mftbmp_ni->allocated_size,
+			(long long)mftbmp_vi->i_size,
+			(long long)mftbmp_ni->initialized_size);
+err_out:
+	return ret;
+}
+
+/**
+ * ntfs_mft_data_extend_allocation_nolock - extend mft data attribute
+ * @vol:	volume on which to extend the mft data attribute
+ *
+ * Extend the mft data attribute on the ntfs volume @vol by 16 mft records
+ * worth of clusters or if not enough space for this by one mft record worth
+ * of clusters.
+ *
+ * Note:  Only changes allocated_size, i.e. does not touch initialized_size or
+ * data_size.
+ *
+ * Return 0 on success and -errno on error.
+ *
+ * Locking: - Caller must hold vol->mftbmp_lock for writing.
+ *	    - This function takes NTFS_I(vol->mft_ino)->runlist.lock for
+ *	      writing and releases it before returning.
+ *	    - This function calls functions which take vol->lcnbmp_lock for
+ *	      writing and release it before returning.
+ */
+static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
+{
+	LCN lcn;
+	VCN old_last_vcn;
+	s64 min_nr, nr, ll = 0;
+	ntfs_inode *mft_ni;
+	runlist_element *rl, *rl2;
+	ntfs_attr_search_ctx *ctx = NULL;
+	MFT_RECORD *mrec;
+	ATTR_RECORD *a = NULL;
+	int ret, mp_size;
+	u32 old_alen = 0;
+	BOOL mp_rebuilt = FALSE;
+
+	ntfs_debug("Extending mft data allocation.");
+	mft_ni = NTFS_I(vol->mft_ino);
+	/*
+	 * Determine the preferred allocation location, i.e. the last lcn of
+	 * the mft data attribute.  The allocated size of the mft data
+	 * attribute cannot be zero so we are ok to do this.
+	 * ntfs_find_vcn() returns the runlist locked on success.
+	 */
+	rl = ntfs_find_vcn(mft_ni, (mft_ni->allocated_size - 1) >>
+			vol->cluster_size_bits, TRUE);
+	if (unlikely(IS_ERR(rl) || !rl->length || rl->lcn < 0)) {
+		ntfs_error(vol->sb, "Failed to determine last allocated "
+				"cluster of mft data attribute.");
+		if (!IS_ERR(rl)) {
+			up_write(&mft_ni->runlist.lock);
+			ret = -EIO;
+		} else
+			ret = PTR_ERR(rl);
+		return ret;
+	}
+	lcn = rl->lcn + rl->length;
+	ntfs_debug("Last lcn of mft data attribute is 0x%llx.",
+			(long long)lcn);
+	/* Minimum allocation is one mft record worth of clusters. */
+	min_nr = vol->mft_record_size >> vol->cluster_size_bits;
+	if (!min_nr)
+		min_nr = 1;
+	/* Want to allocate 16 mft records worth of clusters. */
+	nr = vol->mft_record_size << 4 >> vol->cluster_size_bits;
+	if (!nr)
+		nr = min_nr;
+	/* Ensure we do not go above 2^32-1 mft records. */
+	if (unlikely((mft_ni->allocated_size +
+			(nr << vol->cluster_size_bits)) >>
+			vol->mft_record_size_bits >= (1ll << 32))) {
+		nr = min_nr;
+		if (unlikely((mft_ni->allocated_size +
+				(nr << vol->cluster_size_bits)) >>
+				vol->mft_record_size_bits >= (1ll << 32))) {
+			ntfs_warning(vol->sb, "Cannot allocate mft record "
+					"because the maximum number of inodes "
+					"(2^32) has already been reached.");
+			up_write(&mft_ni->runlist.lock);
+			return -ENOSPC;
+		}
+	}
+	ntfs_debug("Trying mft data allocation with %s cluster count %lli.",
+			nr > min_nr ? "default" : "minimal", (long long)nr);
+	old_last_vcn = rl[1].vcn;
+	do {
+		rl2 = ntfs_cluster_alloc(vol, old_last_vcn, nr, lcn, MFT_ZONE);
+		if (likely(!IS_ERR(rl2)))
+			break;
+		if (PTR_ERR(rl2) != -ENOSPC || nr == min_nr) {
+			ntfs_error(vol->sb, "Failed to allocate the minimal "
+					"number of clusters (%lli) for the "
+					"mft data attribute.", (long long)nr);
+			up_write(&mft_ni->runlist.lock);
+			return PTR_ERR(rl2);
+		}
+		/*
+		 * There is not enough space to do the allocation, but there
+		 * might be enough space to do a minimal allocation so try that
+		 * before failing.
+		 */
+		nr = min_nr;
+		ntfs_debug("Retrying mft data allocation with minimal cluster "
+				"count %lli.", (long long)nr);
+	} while (1);
+	rl = ntfs_runlists_merge(mft_ni->runlist.rl, rl2);
+	if (IS_ERR(rl)) {
+		up_write(&mft_ni->runlist.lock);
+		ntfs_error(vol->sb, "Failed to merge runlists for mft data "
+				"attribute.");
+		if (ntfs_cluster_free_from_rl(vol, rl2)) {
+			ntfs_error(vol->sb, "Failed to dealocate clusters "
+					"from the mft data attribute.%s", es);
+			NVolSetErrors(vol);
+		}
+		ntfs_free(rl2);
+		return PTR_ERR(rl);
+	}
+	mft_ni->runlist.rl = rl;
+	ntfs_debug("Allocated %lli clusters.", nr);
+	/* Find the last run in the new runlist. */
+	for (; rl[1].length; rl++)
+		;
+	/* Update the attribute record as well. */
+	mrec = map_mft_record(mft_ni);
+	if (IS_ERR(mrec)) {
+		ntfs_error(vol->sb, "Failed to map mft record.");
+		ret = PTR_ERR(mrec);
+		goto undo_alloc;
+	}
+	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
+	if (unlikely(!ctx)) {
+		ntfs_error(vol->sb, "Failed to get search context.");
+		ret = -ENOMEM;
+		goto undo_alloc;
+	}
+	ret = ntfs_attr_lookup(mft_ni->type, mft_ni->name, mft_ni->name_len,
+			CASE_SENSITIVE, rl[1].vcn, NULL, 0, ctx);
+	if (unlikely(ret)) {
+		ntfs_error(vol->sb, "Failed to find last attribute extent of "
+				"mft data attribute.");
+		if (ret == -ENOENT)
+			ret = -EIO;
+		goto undo_alloc;
+	}
+	a = ctx->attr;
+	ll = sle64_to_cpu(a->data.non_resident.lowest_vcn);
+	/* Search back for the previous last allocated cluster of mft bitmap. */
+	for (rl2 = rl; rl2 > mft_ni->runlist.rl; rl2--) {
+		if (ll >= rl2->vcn)
+			break;
+	}
+	BUG_ON(ll < rl2->vcn);
+	BUG_ON(ll >= rl2->vcn + rl2->length);
+	/* Get the size for the new mapping pairs array for this extent. */
+	mp_size = ntfs_get_size_for_mapping_pairs(vol, rl2, ll);
+	if (unlikely(mp_size <= 0)) {
+		ntfs_error(vol->sb, "Get size for mapping pairs failed for "
+				"mft data attribute extent.");
+		ret = mp_size;
+		if (!ret)
+			ret = -EIO;
+		goto undo_alloc;
+	}
+	/* Expand the attribute record if necessary. */
+	old_alen = le32_to_cpu(a->length);
+	ret = ntfs_attr_record_resize(ctx->mrec, a, mp_size +
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset));
+	if (unlikely(ret)) {
+		if (ret != -ENOSPC) {
+			ntfs_error(vol->sb, "Failed to resize attribute "
+					"record for mft data attribute.");
+			goto undo_alloc;
+		}
+		// TODO: Deal with this by moving this extent to a new mft
+		// record or by starting a new extent in a new mft record or by
+		// moving other attributes out of this mft record.
+		// Note: Use the special reserved mft records and ensure that
+		// this extent is not required to find the mft record in
+		// question.
+		ntfs_error(vol->sb, "Not enough space in this mft record to "
+				"accomodate extended mft data attribute "
+				"extent.  Cannot handle this yet.");
+		ret = -EOPNOTSUPP;
+		goto undo_alloc;
+	}
+	mp_rebuilt = TRUE;
+	/* Generate the mapping pairs array directly into the attr record. */
+	ret = ntfs_mapping_pairs_build(vol, (u8*)a +
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset),
+			mp_size, rl2, ll, NULL);
+	if (unlikely(ret)) {
+		ntfs_error(vol->sb, "Failed to build mapping pairs array of "
+				"mft data attribute.");
+		goto undo_alloc;
+	}
+	/* Update the highest_vcn. */
+	a->data.non_resident.highest_vcn = cpu_to_sle64(rl[1].vcn - 1);
+	/*
+	 * We now have extended the mft data allocated_size by nr clusters.
+	 * Reflect this in the ntfs_inode structure and the attribute record.
+	 * @rl is the last (non-terminator) runlist element of mft data
+	 * attribute.
+	 */
+	if (a->data.non_resident.lowest_vcn) {
+		/*
+		 * We are not in the first attribute extent, switch to it, but
+		 * first ensure the changes will make it to disk later.
+		 */
+		flush_dcache_mft_record_page(ctx->ntfs_ino);
+		mark_mft_record_dirty(ctx->ntfs_ino);
+		ntfs_attr_reinit_search_ctx(ctx);
+		ret = ntfs_attr_lookup(mft_ni->type, mft_ni->name,
+				mft_ni->name_len, CASE_SENSITIVE, 0, NULL, 0,
+				ctx);
+		if (unlikely(ret)) {
+			ntfs_error(vol->sb, "Failed to find first attribute "
+					"extent of mft data attribute.");
+			goto restore_undo_alloc;
+		}
+		a = ctx->attr;
+	}
+	mft_ni->allocated_size += nr << vol->cluster_size_bits;
+	a->data.non_resident.allocated_size =
+			cpu_to_sle64(mft_ni->allocated_size);
+	/* Ensure the changes make it to disk. */
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(mft_ni);
+	up_write(&mft_ni->runlist.lock);
+	ntfs_debug("Done.");
+	return 0;
+restore_undo_alloc:
+	ntfs_attr_reinit_search_ctx(ctx);
+	if (ntfs_attr_lookup(mft_ni->type, mft_ni->name, mft_ni->name_len,
+			CASE_SENSITIVE, rl[1].vcn, NULL, 0, ctx)) {
+		ntfs_error(vol->sb, "Failed to find last attribute extent of "
+				"mft data attribute.%s", es);
+		mft_ni->allocated_size += nr << vol->cluster_size_bits;
+		ntfs_attr_put_search_ctx(ctx);
+		unmap_mft_record(mft_ni);
+		up_write(&mft_ni->runlist.lock);
+		/*
+		 * The only thing that is now wrong is ->allocated_size of the
+		 * base attribute extent which chkdsk should be able to fix.
+		 */
+		NVolSetErrors(vol);
+		return ret;
+	}
+	a = ctx->attr;
+	a->data.non_resident.highest_vcn = cpu_to_sle64(old_last_vcn - 1);
+undo_alloc:
+	if (ntfs_cluster_free(vol->mft_ino, old_last_vcn, -1) < 0) {
+		ntfs_error(vol->sb, "Failed to free clusters from mft data "
+				"attribute.%s", es);
+		NVolSetErrors(vol);
+	}
+	if (ntfs_rl_truncate_nolock(vol, &mft_ni->runlist, old_last_vcn)) {
+		ntfs_error(vol->sb, "Failed to truncate mft data attribute "
+				"runlist.%s", es);
+		NVolSetErrors(vol);
+	}
+	if (mp_rebuilt) {
+		if (ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(
+				a->data.non_resident.mapping_pairs_offset),
+				old_alen - le16_to_cpu(
+				a->data.non_resident.mapping_pairs_offset),
+				rl2, ll, NULL)) {
+			ntfs_error(vol->sb, "Failed to restore mapping pairs "
+					"array.%s", es);
+			NVolSetErrors(vol);
+		}
+		if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
+			ntfs_error(vol->sb, "Failed to restore attribute "
+					"record.%s", es);
+			NVolSetErrors(vol);
+		}
+		flush_dcache_mft_record_page(ctx->ntfs_ino);
+		mark_mft_record_dirty(ctx->ntfs_ino);
+	}
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	if (!IS_ERR(mrec))
+		unmap_mft_record(mft_ni);
+	up_write(&mft_ni->runlist.lock);
+	return ret;
+}
+
+/**
+ * ntfs_mft_record_layout - layout an mft record into a memory buffer
+ * @vol:	volume to which the mft record will belong
+ * @mft_no:	mft reference specifying the mft record number
+ * @m:		destination buffer of size >= @vol->mft_record_size bytes
+ *
+ * Layout an empty, unused mft record with the mft record number @mft_no into
+ * the buffer @m.  The volume @vol is needed because the mft record structure
+ * was modified in NTFS 3.1 so we need to know which volume version this mft
+ * record will be used on.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static int ntfs_mft_record_layout(const ntfs_volume *vol, const s64 mft_no,
+		MFT_RECORD *m)
+{
+	ATTR_RECORD *a;
+
+	ntfs_debug("Entering for mft record 0x%llx.", (long long)mft_no);
+	if (mft_no >= (1ll << 32)) {
+		ntfs_error(vol->sb, "Mft record number 0x%llx exceeds "
+				"maximum of 2^32.", (long long)mft_no);
+		return -ERANGE;
+	}
+	/* Start by clearing the whole mft record to gives us a clean slate. */
+	memset(m, 0, vol->mft_record_size);
+	/* Aligned to 2-byte boundary. */
+	if (vol->major_ver < 3 || (vol->major_ver == 3 && !vol->minor_ver))
+		m->usa_ofs = cpu_to_le16((sizeof(MFT_RECORD_OLD) + 1) & ~1);
+	else {
+		m->usa_ofs = cpu_to_le16((sizeof(MFT_RECORD) + 1) & ~1);
+		/*
+		 * Set the NTFS 3.1+ specific fields while we know that the
+		 * volume version is 3.1+.
+		 */
+		m->reserved = 0;
+		m->mft_record_number = cpu_to_le32((u32)mft_no);
+	}
+	m->magic = magic_FILE;
+	if (vol->mft_record_size >= NTFS_BLOCK_SIZE)
+		m->usa_count = cpu_to_le16(vol->mft_record_size /
+				NTFS_BLOCK_SIZE + 1);
+	else {
+		m->usa_count = cpu_to_le16(1);
+		ntfs_warning(vol->sb, "Sector size is bigger than mft record "
+				"size.  Setting usa_count to 1.  If chkdsk "
+				"reports this as corruption, please email "
+				"linux-ntfs-dev@lists.sourceforge.net stating "
+				"that you saw this message and that the "
+				"modified file system created was corrupt.  "
+				"Thank you.");
+	}
+	/* Set the update sequence number to 1. */
+	*(le16*)((u8*)m + le16_to_cpu(m->usa_ofs)) = cpu_to_le16(1);
+	m->lsn = 0;
+	m->sequence_number = cpu_to_le16(1);
+	m->link_count = 0;
+	/*
+	 * Place the attributes straight after the update sequence array,
+	 * aligned to 8-byte boundary.
+	 */
+	m->attrs_offset = cpu_to_le16((le16_to_cpu(m->usa_ofs) +
+			(le16_to_cpu(m->usa_count) << 1) + 7) & ~7);
+	m->flags = 0;
+	/*
+	 * Using attrs_offset plus eight bytes (for the termination attribute).
+	 * attrs_offset is already aligned to 8-byte boundary, so no need to
+	 * align again.
+	 */
+	m->bytes_in_use = cpu_to_le32(le16_to_cpu(m->attrs_offset) + 8);
+	m->bytes_allocated = cpu_to_le32(vol->mft_record_size);
+	m->base_mft_record = 0;
+	m->next_attr_instance = 0;
+	/* Add the termination attribute. */
+	a = (ATTR_RECORD*)((u8*)m + le16_to_cpu(m->attrs_offset));
+	a->type = AT_END;
+	a->length = 0;
+	ntfs_debug("Done.");
+	return 0;
+}
+
+/**
+ * ntfs_mft_record_format - format an mft record on an ntfs volume
+ * @vol:	volume on which to format the mft record
+ * @mft_no:	mft record number to format
+ *
+ * Format the mft record @mft_no in $MFT/$DATA, i.e. lay out an empty, unused
+ * mft record into the appropriate place of the mft data attribute.  This is
+ * used when extending the mft data attribute.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static int ntfs_mft_record_format(const ntfs_volume *vol, const s64 mft_no)
+{
+	struct inode *mft_vi = vol->mft_ino;
+	struct page *page;
+	MFT_RECORD *m;
+	pgoff_t index, end_index;
+	unsigned int ofs;
+	int err;
+
+	ntfs_debug("Entering for mft record 0x%llx.", (long long)mft_no);
+	/*
+	 * The index into the page cache and the offset within the page cache
+	 * page of the wanted mft record.
+	 */
+	index = mft_no << vol->mft_record_size_bits >> PAGE_CACHE_SHIFT;
+	ofs = (mft_no << vol->mft_record_size_bits) & ~PAGE_CACHE_MASK;
+	/* The maximum valid index into the page cache for $MFT's data. */
+	end_index = mft_vi->i_size >> PAGE_CACHE_SHIFT;
+	if (unlikely(index >= end_index)) {
+		if (unlikely(index > end_index || ofs + vol->mft_record_size >=
+				(mft_vi->i_size & ~PAGE_CACHE_MASK))) {
+			ntfs_error(vol->sb, "Tried to format non-existing mft "
+					"record 0x%llx.", (long long)mft_no);
+			return -ENOENT;
+		}
+	}
+	/* Read, map, and pin the page containing the mft record. */
+	page = ntfs_map_page(mft_vi->i_mapping, index);
+	if (unlikely(IS_ERR(page))) {
+		ntfs_error(vol->sb, "Failed to map page containing mft record "
+				"to format 0x%llx.", (long long)mft_no);
+		return PTR_ERR(page);
+	}
+	lock_page(page);
+	BUG_ON(!PageUptodate(page));
+	ClearPageUptodate(page);
+	m = (MFT_RECORD*)((u8*)page_address(page) + ofs);
+	err = ntfs_mft_record_layout(vol, mft_no, m);
+	if (unlikely(err)) {
+		ntfs_error(vol->sb, "Failed to layout mft record 0x%llx.",
+				(long long)mft_no);
+		SetPageUptodate(page);
+		unlock_page(page);
+		ntfs_unmap_page(page);
+		return err;
+	}
+	flush_dcache_page(page);
+	SetPageUptodate(page);
+	unlock_page(page);
+	/*
+	 * Make sure the mft record is written out to disk.  We could use
+	 * ilookup5() to check if an inode is in icache and so on but this is
+	 * unnecessary as ntfs_writepage() will write the dirty record anyway.
+	 */
+	mark_ntfs_record_dirty(page, ofs);
+	ntfs_unmap_page(page);
+	ntfs_debug("Done.");
+	return 0;
+}
+
+/**
+ * ntfs_mft_record_alloc - allocate an mft record on an ntfs volume
+ * @vol:	[IN]  volume on which to allocate the mft record
+ * @mode:	[IN]  mode if want a file or directory, i.e. base inode or 0
+ * @base_ni:	[IN]  open base inode if allocating an extent mft record or NULL
+ * @mrec:	[OUT] on successful return this is the mapped mft record
+ *
+ * Allocate an mft record in $MFT/$DATA of an open ntfs volume @vol.
+ *
+ * If @base_ni is NULL make the mft record a base mft record, i.e. a file or
+ * direvctory inode, and allocate it at the default allocator position.  In
+ * this case @mode is the file mode as given to us by the caller.  We in
+ * particular use @mode to distinguish whether a file or a directory is being
+ * created (S_IFDIR(mode) and S_IFREG(mode), respectively).
+ *
+ * If @base_ni is not NULL make the allocated mft record an extent record,
+ * allocate it starting at the mft record after the base mft record and attach
+ * the allocated and opened ntfs inode to the base inode @base_ni.  In this
+ * case @mode must be 0 as it is meaningless for extent inodes.
+ *
+ * You need to check the return value with IS_ERR().  If false, the function
+ * was successful and the return value is the now opened ntfs inode of the
+ * allocated mft record.  *@mrec is then set to the allocated, mapped, pinned,
+ * and locked mft record.  If IS_ERR() is true, the function failed and the
+ * error code is obtained from PTR_ERR(return value).  *@mrec is undefined in
+ * this case.
+ *
+ * Allocation strategy:
+ *
+ * To find a free mft record, we scan the mft bitmap for a zero bit.  To
+ * optimize this we start scanning at the place specified by @base_ni or if
+ * @base_ni is NULL we start where we last stopped and we perform wrap around
+ * when we reach the end.  Note, we do not try to allocate mft records below
+ * number 24 because numbers 0 to 15 are the defined system files anyway and 16
+ * to 24 are special in that they are used for storing extension mft records
+ * for the $DATA attribute of $MFT.  This is required to avoid the possibility
+ * of creating a runlist with a circular dependency which once written to disk
+ * can never be read in again.  Windows will only use records 16 to 24 for
+ * normal files if the volume is completely out of space.  We never use them
+ * which means that when the volume is really out of space we cannot create any
+ * more files while Windows can still create up to 8 small files.  We can start
+ * doing this at some later time, it does not matter much for now.
+ *
+ * When scanning the mft bitmap, we only search up to the last allocated mft
+ * record.  If there are no free records left in the range 24 to number of
+ * allocated mft records, then we extend the $MFT/$DATA attribute in order to
+ * create free mft records.  We extend the allocated size of $MFT/$DATA by 16
+ * records at a time or one cluster, if cluster size is above 16kiB.  If there
+ * is not sufficient space to do this, we try to extend by a single mft record
+ * or one cluster, if cluster size is above the mft record size.
+ *
+ * No matter how many mft records we allocate, we initialize only the first
+ * allocated mft record, incrementing mft data size and initialized size
+ * accordingly, open an ntfs_inode for it and return it to the caller, unless
+ * there are less than 24 mft records, in which case we allocate and initialize
+ * mft records until we reach record 24 which we consider as the first free mft
+ * record for use by normal files.
+ *
+ * If during any stage we overflow the initialized data in the mft bitmap, we
+ * extend the initialized size (and data size) by 8 bytes, allocating another
+ * cluster if required.  The bitmap data size has to be at least equal to the
+ * number of mft records in the mft, but it can be bigger, in which case the
+ * superflous bits are padded with zeroes.
+ *
+ * Thus, when we return successfully (IS_ERR() is false), we will have:
+ *	- initialized / extended the mft bitmap if necessary,
+ *	- initialized / extended the mft data if necessary,
+ *	- set the bit corresponding to the mft record being allocated in the
+ *	  mft bitmap,
+ *	- opened an ntfs_inode for the allocated mft record, and we will have
+ *	- returned the ntfs_inode as well as the allocated mapped, pinned, and
+ *	  locked mft record.
+ *
+ * On error, the volume will be left in a consistent state and no record will
+ * be allocated.  If rolling back a partial operation fails, we may leave some
+ * inconsistent metadata in which case we set NVolErrors() so the volume is
+ * left dirty when unmounted.
+ *
+ * Note, this function cannot make use of most of the normal functions, like
+ * for example for attribute resizing, etc, because when the run list overflows
+ * the base mft record and an attribute list is used, it is very important that
+ * the extension mft records used to store the $DATA attribute of $MFT can be
+ * reached without having to read the information contained inside them, as
+ * this would make it impossible to find them in the first place after the
+ * volume is unmounted.  $MFT/$BITMAP probably does not need to follow this
+ * rule because the bitmap is not essential for finding the mft records, but on
+ * the other hand, handling the bitmap in this special way would make life
+ * easier because otherwise there might be circular invocations of functions
+ * when reading the bitmap.
+ */
+ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
+		ntfs_inode *base_ni, MFT_RECORD **mrec)
+{
+	s64 ll, bit, old_data_initialized, old_data_size;
+	struct inode *vi;
+	struct page *page;
+	ntfs_inode *mft_ni, *mftbmp_ni, *ni;
+	ntfs_attr_search_ctx *ctx;
+	MFT_RECORD *m;
+	ATTR_RECORD *a;
+	pgoff_t index;
+	unsigned int ofs;
+	int err;
+	le16 seq_no, usn;
+	BOOL record_formatted = FALSE;
+
+	if (base_ni) {
+		ntfs_debug("Entering (allocating an extent mft record for "
+				"base mft record 0x%llx).",
+				(long long)base_ni->mft_no);
+		/* @mode and @base_ni are mutually exclusive. */
+		BUG_ON(mode);
+	} else
+		ntfs_debug("Entering (allocating a base mft record).");
+	if (mode) {
+		/* @mode and @base_ni are mutually exclusive. */
+		BUG_ON(base_ni);
+		/* We only support creation of normal files and directories. */
+		if (!S_ISREG(mode) && !S_ISDIR(mode))
+			return ERR_PTR(-EOPNOTSUPP);
+	}
+	BUG_ON(!mrec);
+	mft_ni = NTFS_I(vol->mft_ino);
+	mftbmp_ni = NTFS_I(vol->mftbmp_ino);
+	down_write(&vol->mftbmp_lock);
+	bit = ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(vol, base_ni);
+	if (bit >= 0) {
+		ntfs_debug("Found and allocated free record (#1), bit 0x%llx.",
+				(long long)bit);
+		goto have_alloc_rec;
+	}
+	if (bit != -ENOSPC) {
+		up_write(&vol->mftbmp_lock);
+		return ERR_PTR(bit);
+	}
+	/*
+	 * No free mft records left.  If the mft bitmap already covers more
+	 * than the currently used mft records, the next records are all free,
+	 * so we can simply allocate the first unused mft record.
+	 * Note: We also have to make sure that the mft bitmap at least covers
+	 * the first 24 mft records as they are special and whilst they may not
+	 * be in use, we do not allocate from them.
+	 */
+	ll = mft_ni->initialized_size >> vol->mft_record_size_bits;
+	if (mftbmp_ni->initialized_size << 3 > ll &&
+			mftbmp_ni->initialized_size > 3) {
+		bit = ll;
+		if (bit < 24)
+			bit = 24;
+		if (unlikely(bit >= (1ll << 32)))
+			goto max_err_out;
+		ntfs_debug("Found free record (#2), bit 0x%llx.",
+				(long long)bit);
+		goto found_free_rec;
+	}
+	/*
+	 * The mft bitmap needs to be expanded until it covers the first unused
+	 * mft record that we can allocate.
+	 * Note: The smallest mft record we allocate is mft record 24.
+	 */
+	bit = mftbmp_ni->initialized_size << 3;
+	if (unlikely(bit >= (1ll << 32)))
+		goto max_err_out;
+	ntfs_debug("Status of mftbmp before extension: allocated_size 0x%llx, "
+			"data_size 0x%llx, initialized_size 0x%llx.",
+			(long long)mftbmp_ni->allocated_size,
+			(long long)vol->mftbmp_ino->i_size,
+			(long long)mftbmp_ni->initialized_size);
+	if (mftbmp_ni->initialized_size + 8 > mftbmp_ni->allocated_size) {
+		/* Need to extend bitmap by one more cluster. */
+		ntfs_debug("mftbmp: initialized_size + 8 > allocated_size.");
+		err = ntfs_mft_bitmap_extend_allocation_nolock(vol);
+		if (unlikely(err)) {
+			up_write(&vol->mftbmp_lock);
+			goto err_out;
+		}
+		ntfs_debug("Status of mftbmp after allocation extension: "
+				"allocated_size 0x%llx, data_size 0x%llx, "
+				"initialized_size 0x%llx.",
+				(long long)mftbmp_ni->allocated_size,
+				(long long)vol->mftbmp_ino->i_size,
+				(long long)mftbmp_ni->initialized_size);
+	}
+	/*
+	 * We now have sufficient allocated space, extend the initialized_size
+	 * as well as the data_size if necessary and fill the new space with
+	 * zeroes.
+	 */
+	err = ntfs_mft_bitmap_extend_initialized_nolock(vol);
+	if (unlikely(err)) {
+		up_write(&vol->mftbmp_lock);
+		goto err_out;
+	}
+	ntfs_debug("Status of mftbmp after initialized extention: "
+			"allocated_size 0x%llx, data_size 0x%llx, "
+			"initialized_size 0x%llx.",
+			(long long)mftbmp_ni->allocated_size,
+			(long long)vol->mftbmp_ino->i_size,
+			(long long)mftbmp_ni->initialized_size);
+	ntfs_debug("Found free record (#3), bit 0x%llx.", (long long)bit);
+found_free_rec:
+	/* @bit is the found free mft record, allocate it in the mft bitmap. */
+	ntfs_debug("At found_free_rec.");
+	err = ntfs_bitmap_set_bit(vol->mftbmp_ino, bit);
+	if (unlikely(err)) {
+		ntfs_error(vol->sb, "Failed to allocate bit in mft bitmap.");
+		up_write(&vol->mftbmp_lock);
+		goto err_out;
+	}
+	ntfs_debug("Set bit 0x%llx in mft bitmap.", (long long)bit);
+have_alloc_rec:
+	/*
+	 * The mft bitmap is now uptodate.  Deal with mft data attribute now.
+	 * Note, we keep hold of the mft bitmap lock for writing until all
+	 * modifications to the mft data attribute are complete, too, as they
+	 * will impact decisions for mft bitmap and mft record allocation done
+	 * by a parallel allocation and if the lock is not maintained a
+	 * parallel allocation could allocate the same mft record as this one.
+	 */
+	ll = (bit + 1) << vol->mft_record_size_bits;
+	if (ll <= mft_ni->initialized_size) {
+		ntfs_debug("Allocated mft record already initialized.");
+		goto mft_rec_already_initialized;
+	}
+	ntfs_debug("Initializing allocated mft record.");
+	/*
+	 * The mft record is outside the initialized data.  Extend the mft data
+	 * attribute until it covers the allocated record.  The loop is only
+	 * actually traversed more than once when a freshly formatted volume is
+	 * first written to so it optimizes away nicely in the common case.
+	 */
+	ntfs_debug("Status of mft data before extension: "
+			"allocated_size 0x%llx, data_size 0x%llx, "
+			"initialized_size 0x%llx.",
+			(long long)mft_ni->allocated_size,
+			(long long)vol->mft_ino->i_size,
+			(long long)mft_ni->initialized_size);
+	while (ll > mft_ni->allocated_size) {
+		err = ntfs_mft_data_extend_allocation_nolock(vol);
+		if (unlikely(err)) {
+			ntfs_error(vol->sb, "Failed to extend mft data "
+					"allocation.");
+			goto undo_mftbmp_alloc_nolock;
+		}
+		ntfs_debug("Status of mft data after allocation extension: "
+				"allocated_size 0x%llx, data_size 0x%llx, "
+				"initialized_size 0x%llx.",
+				(long long)mft_ni->allocated_size,
+				(long long)vol->mft_ino->i_size,
+				(long long)mft_ni->initialized_size);
+	}
+	/*
+	 * Extend mft data initialized size (and data size of course) to reach
+	 * the allocated mft record, formatting the mft records allong the way.
+	 * Note: We only modify the ntfs_inode structure as that is all that is
+	 * needed by ntfs_mft_record_format().  We will update the attribute
+	 * record itself in one fell swoop later on.
+	 */
+	old_data_initialized = mft_ni->initialized_size;
+	old_data_size = vol->mft_ino->i_size;
+	while (ll > mft_ni->initialized_size) {
+		s64 new_initialized_size, mft_no;
+		
+		new_initialized_size = mft_ni->initialized_size +
+				vol->mft_record_size;
+		mft_no = mft_ni->initialized_size >> vol->mft_record_size_bits;
+		if (new_initialized_size > vol->mft_ino->i_size)
+			vol->mft_ino->i_size = new_initialized_size;
+		ntfs_debug("Initializing mft record 0x%llx.",
+				(long long)mft_no);
+		err = ntfs_mft_record_format(vol, mft_no);
+		if (unlikely(err)) {
+			ntfs_error(vol->sb, "Failed to format mft record.");
+			goto undo_data_init;
+		}
+		mft_ni->initialized_size = new_initialized_size;
+	}
+	record_formatted = TRUE;
+	/* Update the mft data attribute record to reflect the new sizes. */
+	m = map_mft_record(mft_ni);
+	if (IS_ERR(m)) {
+		ntfs_error(vol->sb, "Failed to map mft record.");
+		err = PTR_ERR(m);
+		goto undo_data_init;
+	}
+	ctx = ntfs_attr_get_search_ctx(mft_ni, m);
+	if (unlikely(!ctx)) {
+		ntfs_error(vol->sb, "Failed to get search context.");
+		err = -ENOMEM;
+		unmap_mft_record(mft_ni);
+		goto undo_data_init;
+	}
+	err = ntfs_attr_lookup(mft_ni->type, mft_ni->name, mft_ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err)) {
+		ntfs_error(vol->sb, "Failed to find first attribute extent of "
+				"mft data attribute.");
+		ntfs_attr_put_search_ctx(ctx);
+		unmap_mft_record(mft_ni);
+		goto undo_data_init;
+	}
+	a = ctx->attr;
+	a->data.non_resident.initialized_size =
+			cpu_to_sle64(mft_ni->initialized_size);
+	a->data.non_resident.data_size = cpu_to_sle64(vol->mft_ino->i_size);
+	/* Ensure the changes make it to disk. */
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(mft_ni);
+	ntfs_debug("Status of mft data after mft record initialization: "
+			"allocated_size 0x%llx, data_size 0x%llx, "
+			"initialized_size 0x%llx.",
+			(long long)mft_ni->allocated_size,
+			(long long)vol->mft_ino->i_size,
+			(long long)mft_ni->initialized_size);
+	BUG_ON(vol->mft_ino->i_size > mft_ni->allocated_size);
+	BUG_ON(mft_ni->initialized_size > vol->mft_ino->i_size);
+mft_rec_already_initialized:
+	/*
+	 * We can finally drop the mft bitmap lock as the mft data attribute
+	 * has been fully updated.  The only disparity left is that the
+	 * allocated mft record still needs to be marked as in use to match the
+	 * set bit in the mft bitmap but this is actually not a problem since
+	 * this mft record is not referenced from anywhere yet and the fact
+	 * that it is allocated in the mft bitmap means that no-one will try to
+	 * allocate it either.
+	 */
+	up_write(&vol->mftbmp_lock);
+	/*
+	 * We now have allocated and initialized the mft record.  Calculate the
+	 * index of and the offset within the page cache page the record is in.
+	 */
+	index = bit << vol->mft_record_size_bits >> PAGE_CACHE_SHIFT;
+	ofs = (bit << vol->mft_record_size_bits) & ~PAGE_CACHE_MASK;
+	/* Read, map, and pin the page containing the mft record. */
+	page = ntfs_map_page(vol->mft_ino->i_mapping, index);
+	if (unlikely(IS_ERR(page))) {
+		ntfs_error(vol->sb, "Failed to map page containing allocated "
+				"mft record 0x%llx.", (long long)bit);
+		err = PTR_ERR(page);
+		goto undo_mftbmp_alloc;
+	}
+	lock_page(page);
+	BUG_ON(!PageUptodate(page));
+	ClearPageUptodate(page);
+	m = (MFT_RECORD*)((u8*)page_address(page) + ofs);
+	/* If we just formatted the mft record no need to do it again. */
+	if (!record_formatted) {
+		/* Sanity check that the mft record is really not in use. */
+		if (ntfs_is_file_record(m->magic) &&
+				(m->flags & MFT_RECORD_IN_USE)) {
+			ntfs_error(vol->sb, "Mft record 0x%llx was marked "
+					"free in mft bitmap but is marked "
+					"used itself.  Corrupt filesystem.  "
+					"Unmount and run chkdsk.",
+					(long long)bit);
+			err = -EIO;
+			SetPageUptodate(page);
+			unlock_page(page);
+			ntfs_unmap_page(page);
+			NVolSetErrors(vol);
+			goto undo_mftbmp_alloc;
+		}
+		/*
+		 * We need to (re-)format the mft record, preserving the
+		 * sequence number if it is not zero as well as the update
+		 * sequence number if it is not zero or -1 (0xffff).  This
+		 * means we do not need to care whether or not something went
+		 * wrong with the previous mft record.
+		 */
+		seq_no = m->sequence_number;
+		usn = *(le16*)((u8*)m + le16_to_cpu(m->usa_ofs));
+		err = ntfs_mft_record_layout(vol, bit, m);
+		if (unlikely(err)) {
+			ntfs_error(vol->sb, "Failed to layout allocated mft "
+					"record 0x%llx.", (long long)bit);
+			SetPageUptodate(page);
+			unlock_page(page);
+			ntfs_unmap_page(page);
+			goto undo_mftbmp_alloc;
+		}
+		if (seq_no)
+			m->sequence_number = seq_no;
+		if (usn && le16_to_cpu(usn) != 0xffff)
+			*(le16*)((u8*)m + le16_to_cpu(m->usa_ofs)) = usn;
+	}
+	/* Set the mft record itself in use. */
+	m->flags |= MFT_RECORD_IN_USE;
+	if (S_ISDIR(mode))
+		m->flags |= MFT_RECORD_IS_DIRECTORY;
+	flush_dcache_page(page);
+	SetPageUptodate(page);
+	if (base_ni) {
+		/*
+		 * Setup the base mft record in the extent mft record.  This
+		 * completes initialization of the allocated extent mft record
+		 * and we can simply use it with map_extent_mft_record().
+		 */
+		m->base_mft_record = MK_LE_MREF(base_ni->mft_no,
+				base_ni->seq_no);
+		/*
+		 * Allocate an extent inode structure for the new mft record,
+		 * attach it to the base inode @base_ni and map, pin, and lock
+		 * its, i.e. the allocated, mft record.
+		 */
+		m = map_extent_mft_record(base_ni, bit, &ni);
+		if (IS_ERR(m)) {
+			ntfs_error(vol->sb, "Failed to map allocated extent "
+					"mft record 0x%llx.", (long long)bit);
+			err = PTR_ERR(m);
+			/* Set the mft record itself not in use. */
+			m->flags &= cpu_to_le16(
+					~le16_to_cpu(MFT_RECORD_IN_USE));
+			flush_dcache_page(page);
+			/* Make sure the mft record is written out to disk. */
+			mark_ntfs_record_dirty(page, ofs);
+			unlock_page(page);
+			ntfs_unmap_page(page);
+			goto undo_mftbmp_alloc;
+		}
+		/*
+		 * Make sure the allocated mft record is written out to disk.
+		 * No need to set the inode dirty because the caller is going
+		 * to do that anyway after finishing with the new extent mft
+		 * record (e.g. at a minimum a new attribute will be added to
+		 * the mft record.
+		 */
+		mark_ntfs_record_dirty(page, ofs);
+		unlock_page(page);
+		/*
+		 * Need to unmap the page since map_extent_mft_record() mapped
+		 * it as well so we have it mapped twice at the moment.
+		 */
+		ntfs_unmap_page(page);
+	} else {
+		/*
+		 * Allocate a new VFS inode and set it up.  NOTE: @vi->i_nlink
+		 * is set to 1 but the mft record->link_count is 0.  The caller
+		 * needs to bear this in mind.
+		 */
+		vi = new_inode(vol->sb);
+		if (unlikely(!vi)) {
+			err = -ENOMEM;
+			/* Set the mft record itself not in use. */
+			m->flags &= cpu_to_le16(
+					~le16_to_cpu(MFT_RECORD_IN_USE));
+			flush_dcache_page(page);
+			/* Make sure the mft record is written out to disk. */
+			mark_ntfs_record_dirty(page, ofs);
+			unlock_page(page);
+			ntfs_unmap_page(page);
+			goto undo_mftbmp_alloc;
+		}
+		vi->i_ino = bit;
+		/*
+		 * This is the optimal IO size (for stat), not the fs block
+		 * size.
+		 */
+		vi->i_blksize = PAGE_CACHE_SIZE;
+		/*
+		 * This is for checking whether an inode has changed w.r.t. a
+		 * file so that the file can be updated if necessary (compare
+		 * with f_version).
+		 */
+		vi->i_version = 1;
+
+		/* The owner and group come from the ntfs volume. */
+		vi->i_uid = vol->uid;
+		vi->i_gid = vol->gid;
+
+		/* Initialize the ntfs specific part of @vi. */
+		ntfs_init_big_inode(vi);
+		ni = NTFS_I(vi);
+		/*
+		 * Set the appropriate mode, attribute type, and name.  For
+		 * directories, also setup the index values to the defaults.
+		 */
+		if (S_ISDIR(mode)) {
+			vi->i_mode = S_IFDIR | S_IRWXUGO;
+			vi->i_mode &= ~vol->dmask;
+
+			NInoSetMstProtected(ni);
+			ni->type = AT_INDEX_ALLOCATION;
+			ni->name = I30;
+			ni->name_len = 4;
+
+			ni->itype.index.block_size = 4096;
+			ni->itype.index.block_size_bits = generic_ffs(4096) - 1;
+			ni->itype.index.collation_rule = COLLATION_FILE_NAME;
+			if (vol->cluster_size <= ni->itype.index.block_size) {
+				ni->itype.index.vcn_size = vol->cluster_size;
+				ni->itype.index.vcn_size_bits =
+						vol->cluster_size_bits;
+			} else {
+				ni->itype.index.vcn_size = vol->sector_size;
+				ni->itype.index.vcn_size_bits =
+						vol->sector_size_bits;
+			}
+		} else {
+			vi->i_mode = S_IFREG | S_IRWXUGO;
+			vi->i_mode &= ~vol->fmask;
+
+			ni->type = AT_DATA;
+			ni->name = NULL;
+			ni->name_len = 0;
+		}
+		if (IS_RDONLY(vi))
+			vi->i_mode &= ~S_IWUGO;
+
+		/* Set the inode times to the current time. */
+		vi->i_atime = vi->i_mtime = vi->i_ctime = current_kernel_time();
+		/*
+		 * Set the file size to 0, the ntfs inode sizes are set to 0 by
+		 * the call to ntfs_init_big_inode() below.
+		 */
+		vi->i_size = 0;
+		vi->i_blocks = 0;
+
+		/* Set the sequence number. */
+		vi->i_generation = ni->seq_no = le16_to_cpu(m->sequence_number);
+		/*
+		 * Manually map, pin, and lock the mft record as we already
+		 * have its page mapped and it is very easy to do.
+		 */
+		atomic_inc(&ni->count);
+		down(&ni->mrec_lock);
+		ni->page = page;
+		ni->page_ofs = ofs;
+		/*
+		 * Make sure the allocated mft record is written out to disk.
+		 * NOTE: We do not set the ntfs inode dirty because this would
+		 * fail in ntfs_write_inode() because the inode does not have a
+		 * standard information attribute yet.  Also, there is no need
+		 * to set the inode dirty because the caller is going to do
+		 * that anyway after finishing with the new mft record (e.g. at
+		 * a minimum some new attributes will be added to the mft
+		 * record.
+		 */
+		mark_ntfs_record_dirty(page, ofs);
+		unlock_page(page);
+
+		/* Add the inode to the inode hash for the superblock. */
+		insert_inode_hash(vi);
+
+		/* Update the default mft allocation position. */
+		vol->mft_data_pos = bit + 1;
+	}
+	/*
+	 * Return the opened, allocated inode of the allocated mft record as
+	 * well as the mapped, pinned, and locked mft record.
+	 */
+	ntfs_debug("Returning opened, allocated %sinode 0x%llx.",
+			base_ni ? "extent " : "", (long long)bit);
+	*mrec = m;
+	return ni;
+undo_data_init:
+	mft_ni->initialized_size = old_data_initialized;
+	vol->mft_ino->i_size = old_data_size;
+	goto undo_mftbmp_alloc_nolock;
+undo_mftbmp_alloc:
+	down_write(&vol->mftbmp_lock);
+undo_mftbmp_alloc_nolock:
+	if (ntfs_bitmap_clear_bit(vol->mftbmp_ino, bit)) {
+		ntfs_error(vol->sb, "Failed to clear bit in mft bitmap.%s", es);
+		NVolSetErrors(vol);
+	}
+	up_write(&vol->mftbmp_lock);
+err_out:
+	return ERR_PTR(err);
+max_err_out:
+	ntfs_warning(vol->sb, "Cannot allocate mft record because the maximum "
+			"number of inodes (2^32) has already been reached.");
+	up_write(&vol->mftbmp_lock);
+	return ERR_PTR(-ENOSPC);
+}
+
+/**
  * ntfs_extent_mft_record_free - free an extent mft record on an ntfs volume
  * @ni:		ntfs inode of the mapped extent mft record to free
  * @m:		mapped extent mft record of the ntfs inode @ni
diff -Nru a/fs/ntfs/mft.h b/fs/ntfs/mft.h
--- a/fs/ntfs/mft.h	2004-10-19 10:15:13 +01:00
+++ b/fs/ntfs/mft.h	2004-10-19 10:15:13 +01:00
@@ -118,6 +118,8 @@
 		const unsigned long mft_no, const MFT_RECORD *m,
 		ntfs_inode **locked_ni);
 
+extern ntfs_inode *ntfs_mft_record_alloc(ntfs_volume *vol, const int mode,
+		ntfs_inode *base_ni, MFT_RECORD **mrec);
 extern int ntfs_extent_mft_record_free(ntfs_inode *ni, MFT_RECORD *m);
 
 #endif /* NTFS_RW */
