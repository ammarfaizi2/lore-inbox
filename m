Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVJaOaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVJaOaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVJaOaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:30:19 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:37010 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751315AbVJaOaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:30:16 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:30:11 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 7/17] NTFS: Add fs/ntfs/attrib.[hc]::ntfs_attr_extend_allocation()
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311429050.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Add fs/ntfs/attrib.[hc]::ntfs_attr_extend_allocation(), a function to
      extend the allocation of an attributes.  Optionally, the data size,
      but not the initialized size can be extended, too.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    3 
 fs/ntfs/attrib.c  |  634 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs/attrib.h  |    3 
 3 files changed, 640 insertions(+), 0 deletions(-)

applies-to: a123e9bb2c7d17aade84b1d1cc2decafdeace121
2d86829b846d1447a6ab5af4060fc9f301521317
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 045beda..6c5bdfb 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -47,6 +47,9 @@ ToDo/Notes:
 	  which is zero for a resident attribute but should no longer be zero
 	  once the attribute is non-resident as it then has real clusters
 	  allocated.
+	- Add fs/ntfs/attrib.[hc]::ntfs_attr_extend_allocation(), a function to
+	  extend the allocation of an attributes.  Optionally, the data size,
+	  but not the initialized size can be extended, too.
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 8821e2d..bc25e88 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1835,6 +1835,640 @@ page_err_out:
 }
 
 /**
+ * ntfs_attr_extend_allocation - extend the allocated space of an attribute
+ * @ni:			ntfs inode of the attribute whose allocation to extend
+ * @new_alloc_size:	new size in bytes to which to extend the allocation to
+ * @new_data_size:	new size in bytes to which to extend the data to
+ * @data_start:		beginning of region which is required to be non-sparse
+ *
+ * Extend the allocated space of an attribute described by the ntfs inode @ni
+ * to @new_alloc_size bytes.  If @data_start is -1, the whole extension may be
+ * implemented as a hole in the file (as long as both the volume and the ntfs
+ * inode @ni have sparse support enabled).  If @data_start is >= 0, then the
+ * region between the old allocated size and @data_start - 1 may be made sparse
+ * but the regions between @data_start and @new_alloc_size must be backed by
+ * actual clusters.
+ *
+ * If @new_data_size is -1, it is ignored.  If it is >= 0, then the data size
+ * of the attribute is extended to @new_data_size.  Note that the i_size of the
+ * vfs inode is not updated.  Only the data size in the base attribute record
+ * is updated.  The caller has to update i_size separately if this is required.
+ * WARNING: It is a BUG() for @new_data_size to be smaller than the old data
+ * size as well as for @new_data_size to be greater than @new_alloc_size.
+ *
+ * For resident attributes this involves resizing the attribute record and if
+ * necessary moving it and/or other attributes into extent mft records and/or
+ * converting the attribute to a non-resident attribute which in turn involves
+ * extending the allocation of a non-resident attribute as described below.
+ *
+ * For non-resident attributes this involves allocating clusters in the data
+ * zone on the volume (except for regions that are being made sparse) and
+ * extending the run list to describe the allocated clusters as well as
+ * updating the mapping pairs array of the attribute.  This in turn involves
+ * resizing the attribute record and if necessary moving it and/or other
+ * attributes into extent mft records and/or splitting the attribute record
+ * into multiple extent attribute records.
+ *
+ * Also, the attribute list attribute is updated if present and in some of the
+ * above cases (the ones where extent mft records/attributes come into play),
+ * an attribute list attribute is created if not already present.
+ *
+ * Return the new allocated size on success and -errno on error.  In the case
+ * that an error is encountered but a partial extension at least up to
+ * @data_start (if present) is possible, the allocation is partially extended
+ * and this is returned.  This means the caller must check the returned size to
+ * determine if the extension was partial.  If @data_start is -1 then partial
+ * allocations are not performed.
+ *
+ * WARNING: Do not call ntfs_attr_extend_allocation() for $MFT/$DATA.
+ *
+ * Locking: This function takes the runlist lock of @ni for writing as well as
+ * locking the mft record of the base ntfs inode.  These locks are maintained
+ * throughout execution of the function.  These locks are required so that the
+ * attribute can be resized safely and so that it can for example be converted
+ * from resident to non-resident safely.
+ *
+ * TODO: At present attribute list attribute handling is not implemented.
+ *
+ * TODO: At present it is not safe to call this function for anything other
+ * than the $DATA attribute(s) of an uncompressed and unencrypted file.
+ */
+s64 ntfs_attr_extend_allocation(ntfs_inode *ni, s64 new_alloc_size,
+		const s64 new_data_size, const s64 data_start)
+{
+	VCN vcn;
+	s64 ll, allocated_size, start = data_start;
+	struct inode *vi = VFS_I(ni);
+	ntfs_volume *vol = ni->vol;
+	ntfs_inode *base_ni;
+	MFT_RECORD *m;
+	ATTR_RECORD *a;
+	ntfs_attr_search_ctx *ctx;
+	runlist_element *rl, *rl2;
+	unsigned long flags;
+	int err, mp_size;
+	u32 attr_len = 0; /* Silence stupid gcc warning. */
+	BOOL mp_rebuilt;
+
+#ifdef NTFS_DEBUG
+	read_lock_irqsave(&ni->size_lock, flags);
+	allocated_size = ni->allocated_size;
+	read_unlock_irqrestore(&ni->size_lock, flags);
+	ntfs_debug("Entering for i_ino 0x%lx, attribute type 0x%x, "
+			"old_allocated_size 0x%llx, "
+			"new_allocated_size 0x%llx, new_data_size 0x%llx, "
+			"data_start 0x%llx.", vi->i_ino,
+			(unsigned)le32_to_cpu(ni->type),
+			(unsigned long long)allocated_size,
+			(unsigned long long)new_alloc_size,
+			(unsigned long long)new_data_size,
+			(unsigned long long)start);
+#endif
+retry_extend:
+	/*
+	 * For non-resident attributes, @start and @new_size need to be aligned
+	 * to cluster boundaries for allocation purposes.
+	 */
+	if (NInoNonResident(ni)) {
+		if (start > 0)
+			start &= ~(s64)vol->cluster_size_mask;
+		new_alloc_size = (new_alloc_size + vol->cluster_size - 1) &
+				~(s64)vol->cluster_size_mask;
+	}
+	BUG_ON(new_data_size >= 0 && new_data_size > new_alloc_size);
+	/* Check if new size is allowed in $AttrDef. */
+	err = ntfs_attr_size_bounds_check(vol, ni->type, new_alloc_size);
+	if (unlikely(err)) {
+		/* Only emit errors when the write will fail completely. */
+		read_lock_irqsave(&ni->size_lock, flags);
+		allocated_size = ni->allocated_size;
+		read_unlock_irqrestore(&ni->size_lock, flags);
+		if (start < 0 || start >= allocated_size) {
+			if (err == -ERANGE) {
+				ntfs_error(vol->sb, "Cannot extend allocation "
+						"of inode 0x%lx, attribute "
+						"type 0x%x, because the new "
+						"allocation would exceed the "
+						"maximum allowed size for "
+						"this attribute type.",
+						vi->i_ino, (unsigned)
+						le32_to_cpu(ni->type));
+			} else {
+				ntfs_error(vol->sb, "Cannot extend allocation "
+						"of inode 0x%lx, attribute "
+						"type 0x%x, because this "
+						"attribute type is not "
+						"defined on the NTFS volume.  "
+						"Possible corruption!  You "
+						"should run chkdsk!",
+						vi->i_ino, (unsigned)
+						le32_to_cpu(ni->type));
+			}
+		}
+		/* Translate error code to be POSIX conformant for write(2). */
+		if (err == -ERANGE)
+			err = -EFBIG;
+		else
+			err = -EIO;
+		return err;
+	}
+	if (!NInoAttr(ni))
+		base_ni = ni;
+	else
+		base_ni = ni->ext.base_ntfs_ino;
+	/*
+	 * We will be modifying both the runlist (if non-resident) and the mft
+	 * record so lock them both down.
+	 */
+	down_write(&ni->runlist.lock);
+	m = map_mft_record(base_ni);
+	if (IS_ERR(m)) {
+		err = PTR_ERR(m);
+		m = NULL;
+		ctx = NULL;
+		goto err_out;
+	}
+	ctx = ntfs_attr_get_search_ctx(base_ni, m);
+	if (unlikely(!ctx)) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	read_lock_irqsave(&ni->size_lock, flags);
+	allocated_size = ni->allocated_size;
+	read_unlock_irqrestore(&ni->size_lock, flags);
+	/*
+	 * If non-resident, seek to the last extent.  If resident, there is
+	 * only one extent, so seek to that.
+	 */
+	vcn = NInoNonResident(ni) ? allocated_size >> vol->cluster_size_bits :
+			0;
+	/*
+	 * Abort if someone did the work whilst we waited for the locks.  If we
+	 * just converted the attribute from resident to non-resident it is
+	 * likely that exactly this has happened already.  We cannot quite
+	 * abort if we need to update the data size.
+	 */
+	if (unlikely(new_alloc_size <= allocated_size)) {
+		ntfs_debug("Allocated size already exceeds requested size.");
+		new_alloc_size = allocated_size;
+		if (new_data_size < 0)
+			goto done;
+		/*
+		 * We want the first attribute extent so that we can update the
+		 * data size.
+		 */
+		vcn = 0;
+	}
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, vcn, NULL, 0, ctx);
+	if (unlikely(err)) {
+		if (err == -ENOENT)
+			err = -EIO;
+		goto err_out;
+	}
+	m = ctx->mrec;
+	a = ctx->attr;
+	/* Use goto to reduce indentation. */
+	if (a->non_resident)
+		goto do_non_resident_extend;
+	BUG_ON(NInoNonResident(ni));
+	/* The total length of the attribute value. */
+	attr_len = le32_to_cpu(a->data.resident.value_length);
+	/*
+	 * Extend the attribute record to be able to store the new attribute
+	 * size.  ntfs_attr_record_resize() will not do anything if the size is
+	 * not changing.
+	 */
+	if (new_alloc_size < vol->mft_record_size &&
+			!ntfs_attr_record_resize(m, a,
+			le16_to_cpu(a->data.resident.value_offset) +
+			new_alloc_size)) {
+		/* The resize succeeded! */
+		write_lock_irqsave(&ni->size_lock, flags);
+		ni->allocated_size = le32_to_cpu(a->length) -
+				le16_to_cpu(a->data.resident.value_offset);
+		write_unlock_irqrestore(&ni->size_lock, flags);
+		if (new_data_size >= 0) {
+			BUG_ON(new_data_size < attr_len);
+			a->data.resident.value_length =
+					cpu_to_le32((u32)new_data_size);
+		}
+		goto flush_done;
+	}
+	/*
+	 * We have to drop all the locks so we can call
+	 * ntfs_attr_make_non_resident().  This could be optimised by try-
+	 * locking the first page cache page and only if that fails dropping
+	 * the locks, locking the page, and redoing all the locking and
+	 * lookups.  While this would be a huge optimisation, it is not worth
+	 * it as this is definitely a slow code path.
+	 */
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(base_ni);
+	up_write(&ni->runlist.lock);
+	/*
+	 * Not enough space in the mft record, try to make the attribute
+	 * non-resident and if successful restart the extension process.
+	 */
+	err = ntfs_attr_make_non_resident(ni, attr_len);
+	if (likely(!err))
+		goto retry_extend;
+	/*
+	 * Could not make non-resident.  If this is due to this not being
+	 * permitted for this attribute type or there not being enough space,
+	 * try to make other attributes non-resident.  Otherwise fail.
+	 */
+	if (unlikely(err != -EPERM && err != -ENOSPC)) {
+		/* Only emit errors when the write will fail completely. */
+		read_lock_irqsave(&ni->size_lock, flags);
+		allocated_size = ni->allocated_size;
+		read_unlock_irqrestore(&ni->size_lock, flags);
+		if (start < 0 || start >= allocated_size)
+			ntfs_error(vol->sb, "Cannot extend allocation of "
+					"inode 0x%lx, attribute type 0x%x, "
+					"because the conversion from resident "
+					"to non-resident attribute failed "
+					"with error code %i.", vi->i_ino,
+					(unsigned)le32_to_cpu(ni->type), err);
+		if (err != -ENOMEM)
+			err = -EIO;
+		goto conv_err_out;
+	}
+	/* TODO: Not implemented from here, abort. */
+	read_lock_irqsave(&ni->size_lock, flags);
+	allocated_size = ni->allocated_size;
+	read_unlock_irqrestore(&ni->size_lock, flags);
+	if (start < 0 || start >= allocated_size) {
+		if (err == -ENOSPC)
+			ntfs_error(vol->sb, "Not enough space in the mft "
+					"record/on disk for the non-resident "
+					"attribute value.  This case is not "
+					"implemented yet.");
+		else /* if (err == -EPERM) */
+			ntfs_error(vol->sb, "This attribute type may not be "
+					"non-resident.  This case is not "
+					"implemented yet.");
+	}
+	err = -EOPNOTSUPP;
+	goto conv_err_out;
+#if 0
+	// TODO: Attempt to make other attributes non-resident.
+	if (!err)
+		goto do_resident_extend;
+	/*
+	 * Both the attribute list attribute and the standard information
+	 * attribute must remain in the base inode.  Thus, if this is one of
+	 * these attributes, we have to try to move other attributes out into
+	 * extent mft records instead.
+	 */
+	if (ni->type == AT_ATTRIBUTE_LIST ||
+			ni->type == AT_STANDARD_INFORMATION) {
+		// TODO: Attempt to move other attributes into extent mft
+		// records.
+		err = -EOPNOTSUPP;
+		if (!err)
+			goto do_resident_extend;
+		goto err_out;
+	}
+	// TODO: Attempt to move this attribute to an extent mft record, but
+	// only if it is not already the only attribute in an mft record in
+	// which case there would be nothing to gain.
+	err = -EOPNOTSUPP;
+	if (!err)
+		goto do_resident_extend;
+	/* There is nothing we can do to make enough space. )-: */
+	goto err_out;
+#endif
+do_non_resident_extend:
+	BUG_ON(!NInoNonResident(ni));
+	if (new_alloc_size == allocated_size) {
+		BUG_ON(vcn);
+		goto alloc_done;
+	}
+	/*
+	 * If the data starts after the end of the old allocation, this is a
+	 * $DATA attribute and sparse attributes are enabled on the volume and
+	 * for this inode, then create a sparse region between the old
+	 * allocated size and the start of the data.  Otherwise simply proceed
+	 * with filling the whole space between the old allocated size and the
+	 * new allocated size with clusters.
+	 */
+	if ((start >= 0 && start <= allocated_size) || ni->type != AT_DATA ||
+			!NVolSparseEnabled(vol) || NInoSparseDisabled(ni))
+		goto skip_sparse;
+	// TODO: This is not implemented yet.  We just fill in with real
+	// clusters for now...
+	ntfs_debug("Inserting holes is not-implemented yet.  Falling back to "
+			"allocating real clusters instead.");
+skip_sparse:
+	rl = ni->runlist.rl;
+	if (likely(rl)) {
+		/* Seek to the end of the runlist. */
+		while (rl->length)
+			rl++;
+	}
+	/* If this attribute extent is not mapped, map it now. */
+	if (unlikely(!rl || rl->lcn == LCN_RL_NOT_MAPPED ||
+			(rl->lcn == LCN_ENOENT && rl > ni->runlist.rl &&
+			(rl-1)->lcn == LCN_RL_NOT_MAPPED))) {
+		if (!rl && !allocated_size)
+			goto first_alloc;
+		rl = ntfs_mapping_pairs_decompress(vol, a, ni->runlist.rl);
+		if (IS_ERR(rl)) {
+			err = PTR_ERR(rl);
+			if (start < 0 || start >= allocated_size)
+				ntfs_error(vol->sb, "Cannot extend allocation "
+						"of inode 0x%lx, attribute "
+						"type 0x%x, because the "
+						"mapping of a runlist "
+						"fragment failed with error "
+						"code %i.", vi->i_ino,
+						(unsigned)le32_to_cpu(ni->type),
+						err);
+			if (err != -ENOMEM)
+				err = -EIO;
+			goto err_out;
+		}
+		ni->runlist.rl = rl;
+		/* Seek to the end of the runlist. */
+		while (rl->length)
+			rl++;
+	}
+	/*
+	 * We now know the runlist of the last extent is mapped and @rl is at
+	 * the end of the runlist.  We want to begin allocating clusters
+	 * starting at the last allocated cluster to reduce fragmentation.  If
+	 * there are no valid LCNs in the attribute we let the cluster
+	 * allocator choose the starting cluster.
+	 */
+	/* If the last LCN is a hole or simillar seek back to last real LCN. */
+	while (rl->lcn < 0 && rl > ni->runlist.rl)
+		rl--;
+first_alloc:
+	// FIXME: Need to implement partial allocations so at least part of the
+	// write can be performed when start >= 0.  (Needed for POSIX write(2)
+	// conformance.)
+	rl2 = ntfs_cluster_alloc(vol, allocated_size >> vol->cluster_size_bits,
+			(new_alloc_size - allocated_size) >>
+			vol->cluster_size_bits, (rl && (rl->lcn >= 0)) ?
+			rl->lcn + rl->length : -1, DATA_ZONE, TRUE);
+	if (IS_ERR(rl2)) {
+		err = PTR_ERR(rl2);
+		if (start < 0 || start >= allocated_size)
+			ntfs_error(vol->sb, "Cannot extend allocation of "
+					"inode 0x%lx, attribute type 0x%x, "
+					"because the allocation of clusters "
+					"failed with error code %i.", vi->i_ino,
+					(unsigned)le32_to_cpu(ni->type), err);
+		if (err != -ENOMEM && err != -ENOSPC)
+			err = -EIO;
+		goto err_out;
+	}
+	rl = ntfs_runlists_merge(ni->runlist.rl, rl2);
+	if (IS_ERR(rl)) {
+		err = PTR_ERR(rl);
+		if (start < 0 || start >= allocated_size)
+			ntfs_error(vol->sb, "Cannot extend allocation of "
+					"inode 0x%lx, attribute type 0x%x, "
+					"because the runlist merge failed "
+					"with error code %i.", vi->i_ino,
+					(unsigned)le32_to_cpu(ni->type), err);
+		if (err != -ENOMEM)
+			err = -EIO;
+		if (ntfs_cluster_free_from_rl(vol, rl2)) {
+			ntfs_error(vol->sb, "Failed to release allocated "
+					"cluster(s) in error code path.  Run "
+					"chkdsk to recover the lost "
+					"cluster(s).");
+			NVolSetErrors(vol);
+		}
+		ntfs_free(rl2);
+		goto err_out;
+	}
+	ni->runlist.rl = rl;
+	ntfs_debug("Allocated 0x%llx clusters.", (long long)(new_alloc_size -
+			allocated_size) >> vol->cluster_size_bits);
+	/* Find the runlist element with which the attribute extent starts. */
+	ll = sle64_to_cpu(a->data.non_resident.lowest_vcn);
+	rl2 = ntfs_rl_find_vcn_nolock(rl, ll);
+	BUG_ON(!rl2);
+	BUG_ON(!rl2->length);
+	BUG_ON(rl2->lcn < LCN_HOLE);
+	mp_rebuilt = FALSE;
+	/* Get the size for the new mapping pairs array for this extent. */
+	mp_size = ntfs_get_size_for_mapping_pairs(vol, rl2, ll, -1);
+	if (unlikely(mp_size <= 0)) {
+		err = mp_size;
+		if (start < 0 || start >= allocated_size)
+			ntfs_error(vol->sb, "Cannot extend allocation of "
+					"inode 0x%lx, attribute type 0x%x, "
+					"because determining the size for the "
+					"mapping pairs failed with error code "
+					"%i.", vi->i_ino,
+					(unsigned)le32_to_cpu(ni->type), err);
+		err = -EIO;
+		goto undo_alloc;
+	}
+	/* Extend the attribute record to fit the bigger mapping pairs array. */
+	attr_len = le32_to_cpu(a->length);
+	err = ntfs_attr_record_resize(m, a, mp_size +
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset));
+	if (unlikely(err)) {
+		BUG_ON(err != -ENOSPC);
+		// TODO: Deal with this by moving this extent to a new mft
+		// record or by starting a new extent in a new mft record,
+		// possibly by extending this extent partially and filling it
+		// and creating a new extent for the remainder, or by making
+		// other attributes non-resident and/or by moving other
+		// attributes out of this mft record.
+		if (start < 0 || start >= allocated_size)
+			ntfs_error(vol->sb, "Not enough space in the mft "
+					"record for the extended attribute "
+					"record.  This case is not "
+					"implemented yet.");
+		err = -EOPNOTSUPP;
+		goto undo_alloc;
+	}
+	mp_rebuilt = TRUE;
+	/* Generate the mapping pairs array directly into the attr record. */
+	err = ntfs_mapping_pairs_build(vol, (u8*)a +
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset),
+			mp_size, rl2, ll, -1, NULL);
+	if (unlikely(err)) {
+		if (start < 0 || start >= allocated_size)
+			ntfs_error(vol->sb, "Cannot extend allocation of "
+					"inode 0x%lx, attribute type 0x%x, "
+					"because building the mapping pairs "
+					"failed with error code %i.", vi->i_ino,
+					(unsigned)le32_to_cpu(ni->type), err);
+		err = -EIO;
+		goto undo_alloc;
+	}
+	/* Update the highest_vcn. */
+	a->data.non_resident.highest_vcn = cpu_to_sle64((new_alloc_size >>
+			vol->cluster_size_bits) - 1);
+	/*
+	 * We now have extended the allocated size of the attribute.  Reflect
+	 * this in the ntfs_inode structure and the attribute record.
+	 */
+	if (a->data.non_resident.lowest_vcn) {
+		/*
+		 * We are not in the first attribute extent, switch to it, but
+		 * first ensure the changes will make it to disk later.
+		 */
+		flush_dcache_mft_record_page(ctx->ntfs_ino);
+		mark_mft_record_dirty(ctx->ntfs_ino);
+		ntfs_attr_reinit_search_ctx(ctx);
+		err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+				CASE_SENSITIVE, 0, NULL, 0, ctx);
+		if (unlikely(err))
+			goto restore_undo_alloc;
+		/* @m is not used any more so no need to set it. */
+		a = ctx->attr;
+	}
+	write_lock_irqsave(&ni->size_lock, flags);
+	ni->allocated_size = new_alloc_size;
+	a->data.non_resident.allocated_size = cpu_to_sle64(new_alloc_size);
+	/*
+	 * FIXME: This would fail if @ni is a directory, $MFT, or an index,
+	 * since those can have sparse/compressed set.  For example can be
+	 * set compressed even though it is not compressed itself and in that
+	 * case the bit means that files are to be created compressed in the
+	 * directory...  At present this is ok as this code is only called for
+	 * regular files, and only for their $DATA attribute(s).
+	 * FIXME: The calculation is wrong if we created a hole above.  For now
+	 * it does not matter as we never create holes.
+	 */
+	if (NInoSparse(ni) || NInoCompressed(ni)) {
+		ni->itype.compressed.size += new_alloc_size - allocated_size;
+		a->data.non_resident.compressed_size =
+				cpu_to_sle64(ni->itype.compressed.size);
+		vi->i_blocks = ni->itype.compressed.size >> 9;
+	} else
+		vi->i_blocks = new_alloc_size >> 9;
+	write_unlock_irqrestore(&ni->size_lock, flags);
+alloc_done:
+	if (new_data_size >= 0) {
+		BUG_ON(new_data_size <
+				sle64_to_cpu(a->data.non_resident.data_size));
+		a->data.non_resident.data_size = cpu_to_sle64(new_data_size);
+	}
+flush_done:
+	/* Ensure the changes make it to disk. */
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+done:
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(base_ni);
+	up_write(&ni->runlist.lock);
+	ntfs_debug("Done, new_allocated_size 0x%llx.",
+			(unsigned long long)new_alloc_size);
+	return new_alloc_size;
+restore_undo_alloc:
+	if (start < 0 || start >= allocated_size)
+		ntfs_error(vol->sb, "Cannot complete extension of allocation "
+				"of inode 0x%lx, attribute type 0x%x, because "
+				"lookup of first attribute extent failed with "
+				"error code %i.", vi->i_ino,
+				(unsigned)le32_to_cpu(ni->type), err);
+	if (err == -ENOENT)
+		err = -EIO;
+	ntfs_attr_reinit_search_ctx(ctx);
+	if (ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
+			allocated_size >> vol->cluster_size_bits, NULL, 0,
+			ctx)) {
+		ntfs_error(vol->sb, "Failed to find last attribute extent of "
+				"attribute in error code path.  Run chkdsk to "
+				"recover.");
+		write_lock_irqsave(&ni->size_lock, flags);
+		ni->allocated_size = new_alloc_size;
+		/*
+		 * FIXME: This would fail if @ni is a directory...  See above.
+		 * FIXME: The calculation is wrong if we created a hole above.
+		 * For now it does not matter as we never create holes.
+		 */
+		if (NInoSparse(ni) || NInoCompressed(ni)) {
+			ni->itype.compressed.size += new_alloc_size -
+					allocated_size;
+			vi->i_blocks = ni->itype.compressed.size >> 9;
+		} else
+			vi->i_blocks = new_alloc_size >> 9;
+		write_unlock_irqrestore(&ni->size_lock, flags);
+		ntfs_attr_put_search_ctx(ctx);
+		unmap_mft_record(base_ni);
+		up_write(&ni->runlist.lock);
+		/*
+		 * The only thing that is now wrong is the allocated size of the
+		 * base attribute extent which chkdsk should be able to fix.
+		 */
+		NVolSetErrors(vol);
+		return err;
+	}
+	ctx->attr->data.non_resident.highest_vcn = cpu_to_sle64(
+			(allocated_size >> vol->cluster_size_bits) - 1);
+undo_alloc:
+	ll = allocated_size >> vol->cluster_size_bits;
+	if (ntfs_cluster_free(ni, ll, -1, ctx) < 0) {
+		ntfs_error(vol->sb, "Failed to release allocated cluster(s) "
+				"in error code path.  Run chkdsk to recover "
+				"the lost cluster(s).");
+		NVolSetErrors(vol);
+	}
+	m = ctx->mrec;
+	a = ctx->attr;
+	/*
+	 * If the runlist truncation fails and/or the search context is no
+	 * longer valid, we cannot resize the attribute record or build the
+	 * mapping pairs array thus we mark the inode bad so that no access to
+	 * the freed clusters can happen.
+	 */
+	if (ntfs_rl_truncate_nolock(vol, &ni->runlist, ll) || IS_ERR(m)) {
+		ntfs_error(vol->sb, "Failed to %s in error code path.  Run "
+				"chkdsk to recover.", IS_ERR(m) ?
+				"restore attribute search context" :
+				"truncate attribute runlist");
+		make_bad_inode(vi);
+		make_bad_inode(VFS_I(base_ni));
+		NVolSetErrors(vol);
+	} else if (mp_rebuilt) {
+		if (ntfs_attr_record_resize(m, a, attr_len)) {
+			ntfs_error(vol->sb, "Failed to restore attribute "
+					"record in error code path.  Run "
+					"chkdsk to recover.");
+			make_bad_inode(vi);
+			make_bad_inode(VFS_I(base_ni));
+			NVolSetErrors(vol);
+		} else /* if (success) */ {
+			if (ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(
+					a->data.non_resident.
+					mapping_pairs_offset), attr_len -
+					le16_to_cpu(a->data.non_resident.
+					mapping_pairs_offset), rl2, ll, -1,
+					NULL)) {
+				ntfs_error(vol->sb, "Failed to restore "
+						"mapping pairs array in error "
+						"code path.  Run chkdsk to "
+						"recover.");
+				make_bad_inode(vi);
+				make_bad_inode(VFS_I(base_ni));
+				NVolSetErrors(vol);
+			}
+			flush_dcache_mft_record_page(ctx->ntfs_ino);
+			mark_mft_record_dirty(ctx->ntfs_ino);
+		}
+	}
+err_out:
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	if (m)
+		unmap_mft_record(base_ni);
+	up_write(&ni->runlist.lock);
+conv_err_out:
+	ntfs_debug("Failed.  Returning error code %i.", err);
+	return err;
+}
+
+/**
  * ntfs_attr_set - fill (a part of) an attribute with a byte
  * @ni:		ntfs inode describing the attribute to fill
  * @ofs:	offset inside the attribute at which to start to fill
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index a959af9..9074886 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -105,6 +105,9 @@ extern int ntfs_resident_attr_value_resi
 
 extern int ntfs_attr_make_non_resident(ntfs_inode *ni, const u32 data_size);
 
+extern s64 ntfs_attr_extend_allocation(ntfs_inode *ni, s64 new_alloc_size,
+		const s64 new_data_size, const s64 data_start);
+
 extern int ntfs_attr_set(ntfs_inode *ni, const s64 ofs, const s64 cnt,
 		const u8 val);
 
---
0.99.9
