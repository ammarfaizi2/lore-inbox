Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVJaObb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVJaObb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVJaObb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:31:31 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:18565 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751303AbVJaOb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:31:29 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:31:27 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 8/17] NTFS: Implement fs/ntfs/inode.[hc]::ntfs_truncate(). 
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311430410.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Implement fs/ntfs/inode.[hc]::ntfs_truncate().  It only supports
      uncompressed and unencrypted files.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |   20 +-
 fs/ntfs/inode.c   |  491 +++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 468 insertions(+), 43 deletions(-)

applies-to: deec965c0fb9681376fc4317846eaf5d0e922f21
dd072330d1a60be11a5c284fa1e645350750a4fc
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 6c5bdfb..70ad4be 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -3,16 +3,14 @@ ToDo/Notes:
 	- In between ntfs_prepare/commit_write, need exclusion between
 	  simultaneous file extensions.  This is given to us by holding i_sem
 	  on the inode.  The only places in the kernel when a file is resized
-	  are prepare/commit write and truncate for both of which i_sem is
-	  held.  Just have to be careful in readpage/writepage and all other
-	  helpers not running under i_sem that we play nice...
-	  Also need to be careful with initialized_size extention in
-	  ntfs_prepare_write. Basically, just be _very_ careful in this code...
-	  UPDATE: The only things that need to be checked are read/writepage
-	  which do not hold i_sem.  Note writepage cannot change i_size but it
-	  needs to cope with a concurrent i_size change, just like readpage.
-	  Also both need to cope with concurrent changes to the other sizes,
-	  i.e. initialized/allocated/compressed size, as well.
+	  are prepare/commit write and ntfs_truncate() for both of which i_sem
+	  is held.  Just have to be careful in read-/writepage and other helpers
+	  not running under i_sem that we play nice...  Also need to be careful
+	  with initialized_size extention in ntfs_prepare_write and writepage.
+	  UPDATE: The only things that need to be checked are
+	  prepare/commit_write as well as the compressed write and the other
+	  attribute resize/write cases like index attributes, etc.  For now
+	  none of these are implemented so are safe.
 	- Implement mft.c::sync_mft_mirror_umount().  We currently will just
 	  leave the volume dirty on umount if the final iput(vol->mft_ino)
 	  causes a write of any mirrored mft records due to the mft mirror
@@ -50,6 +48,8 @@ ToDo/Notes:
 	- Add fs/ntfs/attrib.[hc]::ntfs_attr_extend_allocation(), a function to
 	  extend the allocation of an attributes.  Optionally, the data size,
 	  but not the initialized size can be extended, too.
+	- Implement fs/ntfs/inode.[hc]::ntfs_truncate().  It only supports
+	  uncompressed and unencrypted files.
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 7ec0451..a168234 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -30,6 +30,7 @@
 #include "debug.h"
 #include "inode.h"
 #include "attrib.h"
+#include "lcnalloc.h"
 #include "malloc.h"
 #include "mft.h"
 #include "time.h"
@@ -2291,11 +2292,16 @@ int ntfs_show_options(struct seq_file *s
 
 #ifdef NTFS_RW
 
+static const char *es = "  Leaving inconsistent metadata.  Unmount and run "
+		"chkdsk.";
+
 /**
  * ntfs_truncate - called when the i_size of an ntfs inode is changed
  * @vi:		inode for which the i_size was changed
  *
- * We do not support i_size changes yet.
+ * We only support i_size changes for normal files at present, i.e. not
+ * compressed and not encrypted.  This is enforced in ntfs_setattr(), see
+ * below.
  *
  * The kernel guarantees that @vi is a regular file (S_ISREG() is true) and
  * that the change is allowed.
@@ -2306,80 +2312,499 @@ int ntfs_show_options(struct seq_file *s
  * Returns 0 on success or -errno on error.
  *
  * Called with ->i_sem held.  In all but one case ->i_alloc_sem is held for
- * writing.  The only case where ->i_alloc_sem is not held is
+ * writing.  The only case in the kernel where ->i_alloc_sem is not held is
  * mm/filemap.c::generic_file_buffered_write() where vmtruncate() is called
- * with the current i_size as the offset which means that it is a noop as far
- * as ntfs_truncate() is concerned.
+ * with the current i_size as the offset.  The analogous place in NTFS is in
+ * fs/ntfs/file.c::ntfs_file_buffered_write() where we call vmtruncate() again
+ * without holding ->i_alloc_sem.
  */
 int ntfs_truncate(struct inode *vi)
 {
-	ntfs_inode *ni = NTFS_I(vi);
+	s64 new_size, old_size, nr_freed, new_alloc_size, old_alloc_size;
+	VCN highest_vcn;
+	unsigned long flags;
+	ntfs_inode *base_ni, *ni = NTFS_I(vi);
 	ntfs_volume *vol = ni->vol;
 	ntfs_attr_search_ctx *ctx;
 	MFT_RECORD *m;
 	ATTR_RECORD *a;
 	const char *te = "  Leaving file length out of sync with i_size.";
-	int err;
+	int err, mp_size, size_change, alloc_change;
+	u32 attr_len;
 
 	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
 	BUG_ON(NInoAttr(ni));
+	BUG_ON(S_ISDIR(vi->i_mode));
+	BUG_ON(NInoMstProtected(ni));
 	BUG_ON(ni->nr_extents < 0);
-	m = map_mft_record(ni);
+retry_truncate:
+	/*
+	 * Lock the runlist for writing and map the mft record to ensure it is
+	 * safe to mess with the attribute runlist and sizes.
+	 */
+	down_write(&ni->runlist.lock);
+	if (!NInoAttr(ni))
+		base_ni = ni;
+	else
+		base_ni = ni->ext.base_ntfs_ino;
+	m = map_mft_record(base_ni);
 	if (IS_ERR(m)) {
 		err = PTR_ERR(m);
 		ntfs_error(vi->i_sb, "Failed to map mft record for inode 0x%lx "
 				"(error code %d).%s", vi->i_ino, err, te);
 		ctx = NULL;
 		m = NULL;
-		goto err_out;
+		goto old_bad_out;
 	}
-	ctx = ntfs_attr_get_search_ctx(ni, m);
+	ctx = ntfs_attr_get_search_ctx(base_ni, m);
 	if (unlikely(!ctx)) {
 		ntfs_error(vi->i_sb, "Failed to allocate a search context for "
 				"inode 0x%lx (not enough memory).%s",
 				vi->i_ino, te);
 		err = -ENOMEM;
-		goto err_out;
+		goto old_bad_out;
 	}
 	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
 			CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (unlikely(err)) {
-		if (err == -ENOENT)
+		if (err == -ENOENT) {
 			ntfs_error(vi->i_sb, "Open attribute is missing from "
 					"mft record.  Inode 0x%lx is corrupt.  "
-					"Run chkdsk.", vi->i_ino);
-		else
+					"Run chkdsk.%s", vi->i_ino, te);
+			err = -EIO;
+		} else
 			ntfs_error(vi->i_sb, "Failed to lookup attribute in "
-					"inode 0x%lx (error code %d).",
-					vi->i_ino, err);
-		goto err_out;
+					"inode 0x%lx (error code %d).%s",
+					vi->i_ino, err, te);
+		goto old_bad_out;
 	}
+	m = ctx->mrec;
 	a = ctx->attr;
-	/* If the size has not changed there is nothing to do. */
-	if (ntfs_attr_size(a) == i_size_read(vi))
-		goto done;
-	// TODO: Implement the truncate...
-	ntfs_error(vi->i_sb, "Inode size has changed but this is not "
-			"implemented yet.  Resetting inode size to old value. "
-			" This is most likely a bug in the ntfs driver!");
-	i_size_write(vi, ntfs_attr_size(a)); 
-done:
+	/*
+	 * The i_size of the vfs inode is the new size for the attribute value.
+	 */
+	new_size = i_size_read(vi);
+	/* The current size of the attribute value is the old size. */
+	old_size = ntfs_attr_size(a);
+	/* Calculate the new allocated size. */
+	if (NInoNonResident(ni))
+		new_alloc_size = (new_size + vol->cluster_size - 1) &
+				~(s64)vol->cluster_size_mask;
+	else
+		new_alloc_size = (new_size + 7) & ~7;
+	/* The current allocated size is the old allocated size. */
+	read_lock_irqsave(&ni->size_lock, flags);
+	old_alloc_size = ni->allocated_size;
+	read_unlock_irqrestore(&ni->size_lock, flags);
+	/*
+	 * The change in the file size.  This will be 0 if no change, >0 if the
+	 * size is growing, and <0 if the size is shrinking.
+	 */
+	size_change = -1;
+	if (new_size - old_size >= 0) {
+		size_change = 1;
+		if (new_size == old_size)
+			size_change = 0;
+	}
+	/* As above for the allocated size. */
+	alloc_change = -1;
+	if (new_alloc_size - old_alloc_size >= 0) {
+		alloc_change = 1;
+		if (new_alloc_size == old_alloc_size)
+			alloc_change = 0;
+	}
+	/*
+	 * If neither the size nor the allocation are being changed there is
+	 * nothing to do.
+	 */
+	if (!size_change && !alloc_change)
+		goto unm_done;
+	/* If the size is changing, check if new size is allowed in $AttrDef. */
+	if (size_change) {
+		err = ntfs_attr_size_bounds_check(vol, ni->type, new_size);
+		if (unlikely(err)) {
+			if (err == -ERANGE) {
+				ntfs_error(vol->sb, "Truncate would cause the "
+						"inode 0x%lx to %simum size "
+						"for its attribute type "
+						"(0x%x).  Aborting truncate.",
+						vi->i_ino,
+						new_size > old_size ? "exceed "
+						"the max" : "go under the min",
+						le32_to_cpu(ni->type));
+				err = -EFBIG;
+			} else {
+				ntfs_error(vol->sb, "Inode 0x%lx has unknown "
+						"attribute type 0x%x.  "
+						"Aborting truncate.",
+						vi->i_ino,
+						le32_to_cpu(ni->type));
+				err = -EIO;
+			}
+			/* Reset the vfs inode size to the old size. */
+			i_size_write(vi, old_size);
+			goto err_out;
+		}
+	}
+	if (NInoCompressed(ni) || NInoEncrypted(ni)) {
+		ntfs_warning(vi->i_sb, "Changes in inode size are not "
+				"supported yet for %s files, ignoring.",
+				NInoCompressed(ni) ? "compressed" :
+				"encrypted");
+		err = -EOPNOTSUPP;
+		goto bad_out;
+	}
+	if (a->non_resident)
+		goto do_non_resident_truncate;
+	BUG_ON(NInoNonResident(ni));
+	/* Resize the attribute record to best fit the new attribute size. */
+	if (new_size < vol->mft_record_size &&
+			!ntfs_resident_attr_value_resize(m, a, new_size)) {
+		unsigned long flags;
+
+		/* The resize succeeded! */
+		flush_dcache_mft_record_page(ctx->ntfs_ino);
+		mark_mft_record_dirty(ctx->ntfs_ino);
+		write_lock_irqsave(&ni->size_lock, flags);
+		/* Update the sizes in the ntfs inode and all is done. */
+		ni->allocated_size = le32_to_cpu(a->length) -
+				le16_to_cpu(a->data.resident.value_offset);
+		/*
+		 * Note ntfs_resident_attr_value_resize() has already done any
+		 * necessary data clearing in the attribute record.  When the
+		 * file is being shrunk vmtruncate() will already have cleared
+		 * the top part of the last partial page, i.e. since this is
+		 * the resident case this is the page with index 0.  However,
+		 * when the file is being expanded, the page cache page data
+		 * between the old data_size, i.e. old_size, and the new_size
+		 * has not been zeroed.  Fortunately, we do not need to zero it
+		 * either since on one hand it will either already be zero due
+		 * to both readpage and writepage clearing partial page data
+		 * beyond i_size in which case there is nothing to do or in the
+		 * case of the file being mmap()ped at the same time, POSIX
+		 * specifies that the behaviour is unspecified thus we do not
+		 * have to do anything.  This means that in our implementation
+		 * in the rare case that the file is mmap()ped and a write
+		 * occured into the mmap()ped region just beyond the file size
+		 * and writepage has not yet been called to write out the page
+		 * (which would clear the area beyond the file size) and we now
+		 * extend the file size to incorporate this dirty region
+		 * outside the file size, a write of the page would result in
+		 * this data being written to disk instead of being cleared.
+		 * Given both POSIX and the Linux mmap(2) man page specify that
+		 * this corner case is undefined, we choose to leave it like
+		 * that as this is much simpler for us as we cannot lock the
+		 * relevant page now since we are holding too many ntfs locks
+		 * which would result in a lock reversal deadlock.
+		 */
+		ni->initialized_size = new_size;
+		write_unlock_irqrestore(&ni->size_lock, flags);
+		goto unm_done;
+	}
+	/* If the above resize failed, this must be an attribute extension. */
+	BUG_ON(size_change < 0);
+	/*
+	 * We have to drop all the locks so we can call
+	 * ntfs_attr_make_non_resident().  This could be optimised by try-
+	 * locking the first page cache page and only if that fails dropping
+	 * the locks, locking the page, and redoing all the locking and
+	 * lookups.  While this would be a huge optimisation, it is not worth
+	 * it as this is definitely a slow code path as it only ever can happen
+	 * once for any given file.
+	 */
 	ntfs_attr_put_search_ctx(ctx);
-	unmap_mft_record(ni);
-	NInoClearTruncateFailed(ni);
-	ntfs_debug("Done.");
-	return 0;
-err_out:
-	if (err != -ENOMEM) {
+	unmap_mft_record(base_ni);
+	up_write(&ni->runlist.lock);
+	/*
+	 * Not enough space in the mft record, try to make the attribute
+	 * non-resident and if successful restart the truncation process.
+	 */
+	err = ntfs_attr_make_non_resident(ni, old_size);
+	if (likely(!err))
+		goto retry_truncate;
+	/*
+	 * Could not make non-resident.  If this is due to this not being
+	 * permitted for this attribute type or there not being enough space,
+	 * try to make other attributes non-resident.  Otherwise fail.
+	 */
+	if (unlikely(err != -EPERM && err != -ENOSPC)) {
+		ntfs_error(vol->sb, "Cannot truncate inode 0x%lx, attribute "
+				"type 0x%x, because the conversion from "
+				"resident to non-resident attribute failed "
+				"with error code %i.", vi->i_ino,
+				(unsigned)le32_to_cpu(ni->type), err);
+		if (err != -ENOMEM)
+			err = -EIO;
+		goto conv_err_out;
+	}
+	/* TODO: Not implemented from here, abort. */
+	if (err == -ENOSPC)
+		ntfs_error(vol->sb, "Not enough space in the mft record/on "
+				"disk for the non-resident attribute value.  "
+				"This case is not implemented yet.");
+	else /* if (err == -EPERM) */
+		ntfs_error(vol->sb, "This attribute type may not be "
+				"non-resident.  This case is not implemented "
+				"yet.");
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
+do_non_resident_truncate:
+	BUG_ON(!NInoNonResident(ni));
+	if (alloc_change < 0) {
+		highest_vcn = sle64_to_cpu(a->data.non_resident.highest_vcn);
+		if (highest_vcn > 0 &&
+				old_alloc_size >> vol->cluster_size_bits >
+				highest_vcn + 1) {
+			/*
+			 * This attribute has multiple extents.  Not yet
+			 * supported.
+			 */
+			ntfs_error(vol->sb, "Cannot truncate inode 0x%lx, "
+					"attribute type 0x%x, because the "
+					"attribute is highly fragmented (it "
+					"consists of multiple extents) and "
+					"this case is not implemented yet.",
+					vi->i_ino,
+					(unsigned)le32_to_cpu(ni->type));
+			err = -EOPNOTSUPP;
+			goto bad_out;
+		}
+	}
+	/*
+	 * If the size is shrinking, need to reduce the initialized_size and
+	 * the data_size before reducing the allocation.
+	 */
+	if (size_change < 0) {
+		/*
+		 * Make the valid size smaller (i_size is already up-to-date).
+		 */
+		write_lock_irqsave(&ni->size_lock, flags);
+		if (new_size < ni->initialized_size) {
+			ni->initialized_size = new_size;
+			a->data.non_resident.initialized_size =
+					cpu_to_sle64(new_size);
+		}
+		a->data.non_resident.data_size = cpu_to_sle64(new_size);
+		write_unlock_irqrestore(&ni->size_lock, flags);
+		flush_dcache_mft_record_page(ctx->ntfs_ino);
+		mark_mft_record_dirty(ctx->ntfs_ino);
+		/* If the allocated size is not changing, we are done. */
+		if (!alloc_change)
+			goto unm_done;
+		/*
+		 * If the size is shrinking it makes no sense for the
+		 * allocation to be growing.
+		 */
+		BUG_ON(alloc_change > 0);
+	} else /* if (size_change >= 0) */ {
+		/*
+		 * The file size is growing or staying the same but the
+		 * allocation can be shrinking, growing or staying the same.
+		 */
+		if (alloc_change > 0) {
+			/*
+			 * We need to extend the allocation and possibly update
+			 * the data size.  If we are updating the data size,
+			 * since we are not touching the initialized_size we do
+			 * not need to worry about the actual data on disk.
+			 * And as far as the page cache is concerned, there
+			 * will be no pages beyond the old data size and any
+			 * partial region in the last page between the old and
+			 * new data size (or the end of the page if the new
+			 * data size is outside the page) does not need to be
+			 * modified as explained above for the resident
+			 * attribute truncate case.  To do this, we simply drop
+			 * the locks we hold and leave all the work to our
+			 * friendly helper ntfs_attr_extend_allocation().
+			 */
+			ntfs_attr_put_search_ctx(ctx);
+			unmap_mft_record(base_ni);
+			up_write(&ni->runlist.lock);
+			err = ntfs_attr_extend_allocation(ni, new_size,
+					size_change > 0 ? new_size : -1, -1);
+			/*
+			 * ntfs_attr_extend_allocation() will have done error
+			 * output already.
+			 */
+			goto done;
+		}
+		if (!alloc_change)
+			goto alloc_done;
+	}
+	/* alloc_change < 0 */
+	/* Free the clusters. */
+	nr_freed = ntfs_cluster_free(ni, new_alloc_size >>
+			vol->cluster_size_bits, -1, ctx);
+	m = ctx->mrec;
+	a = ctx->attr;
+	if (unlikely(nr_freed < 0)) {
+		ntfs_error(vol->sb, "Failed to release cluster(s) (error code "
+				"%lli).  Unmount and run chkdsk to recover "
+				"the lost cluster(s).", (long long)nr_freed);
 		NVolSetErrors(vol);
+		nr_freed = 0;
+	}
+	/* Truncate the runlist. */
+	err = ntfs_rl_truncate_nolock(vol, &ni->runlist,
+			new_alloc_size >> vol->cluster_size_bits);
+	/*
+	 * If the runlist truncation failed and/or the search context is no
+	 * longer valid, we cannot resize the attribute record or build the
+	 * mapping pairs array thus we mark the inode bad so that no access to
+	 * the freed clusters can happen.
+	 */
+	if (unlikely(err || IS_ERR(m))) {
+		ntfs_error(vol->sb, "Failed to %s (error code %li).%s",
+				IS_ERR(m) ?
+				"restore attribute search context" :
+				"truncate attribute runlist",
+				IS_ERR(m) ? PTR_ERR(m) : err, es);
+		err = -EIO;
+		goto bad_out;
+	}
+	/* Get the size for the shrunk mapping pairs array for the runlist. */
+	mp_size = ntfs_get_size_for_mapping_pairs(vol, ni->runlist.rl, 0, -1);
+	if (unlikely(mp_size <= 0)) {
+		ntfs_error(vol->sb, "Cannot shrink allocation of inode 0x%lx, "
+				"attribute type 0x%x, because determining the "
+				"size for the mapping pairs failed with error "
+				"code %i.%s", vi->i_ino,
+				(unsigned)le32_to_cpu(ni->type), mp_size, es);
+		err = -EIO;
+		goto bad_out;
+	}
+	/*
+	 * Shrink the attribute record for the new mapping pairs array.  Note,
+	 * this cannot fail since we are making the attribute smaller thus by
+	 * definition there is enough space to do so.
+	 */
+	attr_len = le32_to_cpu(a->length);
+	err = ntfs_attr_record_resize(m, a, mp_size +
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset));
+	BUG_ON(err);
+	/*
+	 * Generate the mapping pairs array directly into the attribute record.
+	 */
+	err = ntfs_mapping_pairs_build(vol, (u8*)a +
+			le16_to_cpu(a->data.non_resident.mapping_pairs_offset),
+			mp_size, ni->runlist.rl, 0, -1, NULL);
+	if (unlikely(err)) {
+		ntfs_error(vol->sb, "Cannot shrink allocation of inode 0x%lx, "
+				"attribute type 0x%x, because building the "
+				"mapping pairs failed with error code %i.%s",
+				vi->i_ino, (unsigned)le32_to_cpu(ni->type),
+				err, es);
+		err = -EIO;
+		goto bad_out;
+	}
+	/* Update the allocated/compressed size as well as the highest vcn. */
+	a->data.non_resident.highest_vcn = cpu_to_sle64((new_alloc_size >>
+			vol->cluster_size_bits) - 1);
+	write_lock_irqsave(&ni->size_lock, flags);
+	ni->allocated_size = new_alloc_size;
+	a->data.non_resident.allocated_size = cpu_to_sle64(new_alloc_size);
+	if (NInoSparse(ni) || NInoCompressed(ni)) {
+		if (nr_freed) {
+			ni->itype.compressed.size -= nr_freed <<
+					vol->cluster_size_bits;
+			BUG_ON(ni->itype.compressed.size < 0);
+			a->data.non_resident.compressed_size = cpu_to_sle64(
+					ni->itype.compressed.size);
+			vi->i_blocks = ni->itype.compressed.size >> 9;
+		}
+	} else
+		vi->i_blocks = new_alloc_size >> 9;
+	write_unlock_irqrestore(&ni->size_lock, flags);
+	/*
+	 * We have shrunk the allocation.  If this is a shrinking truncate we
+	 * have already dealt with the initialized_size and the data_size above
+	 * and we are done.  If the truncate is only changing the allocation
+	 * and not the data_size, we are also done.  If this is an extending
+	 * truncate, need to extend the data_size now which is ensured by the
+	 * fact that @size_change is positive.
+	 */
+alloc_done:
+	/*
+	 * If the size is growing, need to update it now.  If it is shrinking,
+	 * we have already updated it above (before the allocation change).
+	 */
+	if (size_change > 0)
+		a->data.non_resident.data_size = cpu_to_sle64(new_size);
+	/* Ensure the modified mft record is written out. */
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
+	mark_mft_record_dirty(ctx->ntfs_ino);
+unm_done:
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(base_ni);
+	up_write(&ni->runlist.lock);
+done:
+	/* Update the mtime and ctime on the base inode. */
+	inode_update_time(VFS_I(base_ni), 1);
+	if (likely(!err)) {
+		NInoClearTruncateFailed(ni);
+		ntfs_debug("Done.");
+	}
+	return err;
+old_bad_out:
+	old_size = -1;
+bad_out:
+	if (err != -ENOMEM && err != -EOPNOTSUPP) {
 		make_bad_inode(vi);
+		make_bad_inode(VFS_I(base_ni));
+		NVolSetErrors(vol);
 	}
+	if (err != -EOPNOTSUPP)
+		NInoSetTruncateFailed(ni);
+	else if (old_size >= 0)
+		i_size_write(vi, old_size);
+err_out:
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
 	if (m)
-		unmap_mft_record(ni);
-	NInoSetTruncateFailed(ni);
+		unmap_mft_record(base_ni);
+	up_write(&ni->runlist.lock);
+out:
+	ntfs_debug("Failed.  Returning error code %i.", err);
 	return err;
+conv_err_out:
+	if (err != -ENOMEM && err != -EOPNOTSUPP) {
+		make_bad_inode(vi);
+		make_bad_inode(VFS_I(base_ni));
+		NVolSetErrors(vol);
+	}
+	if (err != -EOPNOTSUPP)
+		NInoSetTruncateFailed(ni);
+	else
+		i_size_write(vi, old_size);
+	goto out;
 }
 
 /**
---
0.99.9
