Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbVIIJYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVIIJYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVIIJYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:24:39 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:53716 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965130AbVIIJYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:24:36 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:24:28 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 9/25] NTFS: Add ntfs_rl_punch_nolock() which punches a caller
 specified hole into a runlist.
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091023560.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 9/25] NTFS: Add ntfs_rl_punch_nolock() which punches a caller specified hole into a runlist.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    2 
 fs/ntfs/runlist.c |  284 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs/runlist.h |    3 +
 3 files changed, 289 insertions(+), 0 deletions(-)

6e48321a40610f7213e3ac75ba234f6f8b3ed5f5
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -53,6 +53,8 @@ ToDo/Notes:
 	  pointing this out.
 	- Change ntfs_rl_truncate_nolock() to throw away the runlist if the new
 	  length is zero.
+	- Add runlist.[hc]::ntfs_rl_punch_nolock() which punches a caller
+	  specified hole into a runlist.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -1601,4 +1601,288 @@ int ntfs_rl_truncate_nolock(const ntfs_v
 	return 0;
 }
 
+/**
+ * ntfs_rl_punch_nolock - punch a hole into a runlist
+ * @vol:	ntfs volume (needed for error output)
+ * @runlist:	runlist to punch a hole into
+ * @start:	starting VCN of the hole to be created
+ * @length:	size of the hole to be created in units of clusters
+ *
+ * Punch a hole into the runlist @runlist starting at VCN @start and of size
+ * @length clusters.
+ *
+ * Return 0 on success and -errno on error, in which case @runlist has not been
+ * modified.
+ *
+ * If @start and/or @start + @length are outside the runlist return error code
+ * -ENOENT.
+ *
+ * If the runlist contains unmapped or error elements between @start and @start
+ * + @length return error code -EINVAL.
+ *
+ * Locking: The caller must hold @runlist->lock for writing.
+ */
+int ntfs_rl_punch_nolock(const ntfs_volume *vol, runlist *const runlist,
+		const VCN start, const s64 length)
+{
+	const VCN end = start + length;
+	s64 delta;
+	runlist_element *rl, *rl_end, *rl_real_end, *trl;
+	int old_size;
+	BOOL lcn_fixup = FALSE;
+
+	ntfs_debug("Entering for start 0x%llx, length 0x%llx.",
+			(long long)start, (long long)length);
+	BUG_ON(!runlist);
+	BUG_ON(start < 0);
+	BUG_ON(length < 0);
+	BUG_ON(end < 0);
+	rl = runlist->rl;
+	if (unlikely(!rl)) {
+		if (likely(!start && !length))
+			return 0;
+		return -ENOENT;
+	}
+	/* Find @start in the runlist. */
+	while (likely(rl->length && start >= rl[1].vcn))
+		rl++;
+	rl_end = rl;
+	/* Find @end in the runlist. */
+	while (likely(rl_end->length && end >= rl_end[1].vcn)) {
+		/* Verify there are no unmapped or error elements. */
+		if (unlikely(rl_end->lcn < LCN_HOLE))
+			return -EINVAL;
+		rl_end++;
+	}
+	/* Check the last element. */
+	if (unlikely(rl_end->length && rl_end->lcn < LCN_HOLE))
+		return -EINVAL;
+	/* This covers @start being out of bounds, too. */
+	if (!rl_end->length && end > rl_end->vcn)
+		return -ENOENT;
+	if (!length)
+		return 0;
+	if (!rl->length)
+		return -ENOENT;
+	rl_real_end = rl_end;
+	/* Determine the runlist size. */
+	while (likely(rl_real_end->length))
+		rl_real_end++;
+	old_size = rl_real_end - runlist->rl + 1;
+	/* If @start is in a hole simply extend the hole. */
+	if (rl->lcn == LCN_HOLE) {
+		/*
+		 * If both @start and @end are in the same sparse run, we are
+		 * done.
+		 */
+		if (end <= rl[1].vcn) {
+			ntfs_debug("Done (requested hole is already sparse).");
+			return 0;
+		}
+extend_hole:
+		/* Extend the hole. */
+		rl->length = end - rl->vcn;
+		/* If @end is in a hole, merge it with the current one. */
+		if (rl_end->lcn == LCN_HOLE) {
+			rl_end++;
+			rl->length = rl_end->vcn - rl->vcn;
+		}
+		/* We have done the hole.  Now deal with the remaining tail. */
+		rl++;
+		/* Cut out all runlist elements up to @end. */
+		if (rl < rl_end)
+			memmove(rl, rl_end, (rl_real_end - rl_end + 1) *
+					sizeof(*rl));
+		/* Adjust the beginning of the tail if necessary. */
+		if (end > rl->vcn) {
+			s64 delta = end - rl->vcn;
+			rl->vcn = end;
+			rl->length -= delta;
+			/* Only adjust the lcn if it is real. */
+			if (rl->lcn >= 0)
+				rl->lcn += delta;
+		}
+shrink_allocation:
+		/* Reallocate memory if the allocation changed. */
+		if (rl < rl_end) {
+			rl = ntfs_rl_realloc(runlist->rl, old_size,
+					old_size - (rl_end - rl));
+			if (IS_ERR(rl))
+				ntfs_warning(vol->sb, "Failed to shrink "
+						"runlist buffer.  This just "
+						"wastes a bit of memory "
+						"temporarily so we ignore it "
+						"and return success.");
+			else
+				runlist->rl = rl;
+		}
+		ntfs_debug("Done (extend hole).");
+		return 0;
+	}
+	/*
+	 * If @start is at the beginning of a run things are easier as there is
+	 * no need to split the first run.
+	 */
+	if (start == rl->vcn) {
+		/*
+		 * @start is at the beginning of a run.
+		 *
+		 * If the previous run is sparse, extend its hole.
+		 *
+		 * If @end is not in the same run, switch the run to be sparse
+		 * and extend the newly created hole.
+		 *
+		 * Thus both of these cases reduce the problem to the above
+		 * case of "@start is in a hole".
+		 */
+		if (rl > runlist->rl && (rl - 1)->lcn == LCN_HOLE) {
+			rl--;
+			goto extend_hole;
+		}
+		if (end >= rl[1].vcn) {
+			rl->lcn = LCN_HOLE;
+			goto extend_hole;
+		}
+		/*
+		 * The final case is when @end is in the same run as @start.
+		 * For this need to split the run into two.  One run for the
+		 * sparse region between the beginning of the old run, i.e.
+		 * @start, and @end and one for the remaining non-sparse
+		 * region, i.e. between @end and the end of the old run.
+		 */
+		trl = ntfs_rl_realloc(runlist->rl, old_size, old_size + 1);
+		if (IS_ERR(trl))
+			goto enomem_out;
+		old_size++;
+		if (runlist->rl != trl) {
+			rl = trl + (rl - runlist->rl);
+			rl_end = trl + (rl_end - runlist->rl);
+			rl_real_end = trl + (rl_real_end - runlist->rl);
+			runlist->rl = trl;
+		}
+split_end:
+		/* Shift all the runs up by one. */
+		memmove(rl + 1, rl, (rl_real_end - rl + 1) * sizeof(*rl));
+		/* Finally, setup the two split runs. */
+		rl->lcn = LCN_HOLE;
+		rl->length = length;
+		rl++;
+		rl->vcn += length;
+		/* Only adjust the lcn if it is real. */
+		if (rl->lcn >= 0 || lcn_fixup)
+			rl->lcn += length;
+		rl->length -= length;
+		ntfs_debug("Done (split one).");
+		return 0;
+	}
+	/*
+	 * @start is neither in a hole nor at the beginning of a run.
+	 *
+	 * If @end is in a hole, things are easier as simply truncating the run
+	 * @start is in to end at @start - 1, deleting all runs after that up
+	 * to @end, and finally extending the beginning of the run @end is in
+	 * to be @start is all that is needed.
+	 */
+	if (rl_end->lcn == LCN_HOLE) {
+		/* Truncate the run containing @start. */
+		rl->length = start - rl->vcn;
+		rl++;
+		/* Cut out all runlist elements up to @end. */
+		if (rl < rl_end)
+			memmove(rl, rl_end, (rl_real_end - rl_end + 1) *
+					sizeof(*rl));
+		/* Extend the beginning of the run @end is in to be @start. */
+		rl->vcn = start;
+		rl->length = rl[1].vcn - start;
+		goto shrink_allocation;
+	}
+	/* 
+	 * If @end is not in a hole there are still two cases to distinguish.
+	 * Either @end is or is not in the same run as @start.
+	 *
+	 * The second case is easier as it can be reduced to an already solved
+	 * problem by truncating the run @start is in to end at @start - 1.
+	 * Then, if @end is in the next run need to split the run into a sparse
+	 * run followed by a non-sparse run (already covered above) and if @end
+	 * is not in the next run switching it to be sparse, again reduces the
+	 * problem to the already covered case of "@start is in a hole".
+	 */
+	if (end >= rl[1].vcn) {
+		/*
+		 * If @end is not in the next run, reduce the problem to the
+		 * case of "@start is in a hole".
+		 */
+		if (rl[1].length && end >= rl[2].vcn) {
+			/* Truncate the run containing @start. */
+			rl->length = start - rl->vcn;
+			rl++;
+			rl->vcn = start;
+			rl->lcn = LCN_HOLE;
+			goto extend_hole;
+		}
+		trl = ntfs_rl_realloc(runlist->rl, old_size, old_size + 1);
+		if (IS_ERR(trl))
+			goto enomem_out;
+		old_size++;
+		if (runlist->rl != trl) {
+			rl = trl + (rl - runlist->rl);
+			rl_end = trl + (rl_end - runlist->rl);
+			rl_real_end = trl + (rl_real_end - runlist->rl);
+			runlist->rl = trl;
+		}
+		/* Truncate the run containing @start. */
+		rl->length = start - rl->vcn;
+		rl++;
+		/*
+		 * @end is in the next run, reduce the problem to the case
+		 * where "@start is at the beginning of a run and @end is in
+		 * the same run as @start".
+		 */
+		delta = rl->vcn - start;
+		rl->vcn = start;
+		if (rl->lcn >= 0) {
+			rl->lcn -= delta;
+			/* Need this in case the lcn just became negative. */
+			lcn_fixup = TRUE;
+		}
+		rl->length += delta;
+		goto split_end;
+	}
+	/*
+	 * The first case from above, i.e. @end is in the same run as @start.
+	 * We need to split the run into three.  One run for the non-sparse
+	 * region between the beginning of the old run and @start, one for the
+	 * sparse region between @start and @end, and one for the remaining
+	 * non-sparse region, i.e. between @end and the end of the old run.
+	 */
+	trl = ntfs_rl_realloc(runlist->rl, old_size, old_size + 2);
+	if (IS_ERR(trl))
+		goto enomem_out;
+	old_size += 2;
+	if (runlist->rl != trl) {
+		rl = trl + (rl - runlist->rl);
+		rl_end = trl + (rl_end - runlist->rl);
+		rl_real_end = trl + (rl_real_end - runlist->rl);
+		runlist->rl = trl;
+	}
+	/* Shift all the runs up by two. */
+	memmove(rl + 2, rl, (rl_real_end - rl + 1) * sizeof(*rl));
+	/* Finally, setup the three split runs. */
+	rl->length = start - rl->vcn;
+	rl++;
+	rl->vcn = start;
+	rl->lcn = LCN_HOLE;
+	rl->length = length;
+	rl++;
+	delta = end - rl->vcn;
+	rl->vcn = end;
+	rl->lcn += delta;
+	rl->length -= delta;
+	ntfs_debug("Done (split both).");
+	return 0;
+enomem_out:
+	ntfs_error(vol->sb, "Not enough memory to extend runlist buffer.");
+	return -ENOMEM;
+}
+
 #endif /* NTFS_RW */
diff --git a/fs/ntfs/runlist.h b/fs/ntfs/runlist.h
--- a/fs/ntfs/runlist.h
+++ b/fs/ntfs/runlist.h
@@ -94,6 +94,9 @@ extern int ntfs_mapping_pairs_build(cons
 extern int ntfs_rl_truncate_nolock(const ntfs_volume *vol,
 		runlist *const runlist, const s64 new_length);
 
+int ntfs_rl_punch_nolock(const ntfs_volume *vol, runlist *const runlist,
+		const VCN start, const s64 length);
+
 #endif /* NTFS_RW */
 
 #endif /* _LINUX_NTFS_RUNLIST_H */
