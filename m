Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268303AbUJSJsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268303AbUJSJsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268218AbUJSJrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:47:19 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:18824 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268117AbUJSJkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:40:33 -0400
Date: Tue, 19 Oct 2004 10:40:19 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 6/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191039510.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191040050.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039510.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 6/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/30 1.2005)
   NTFS: Add fs/ntfs/runlist.[hc]::ntfs_get_nr_significant_bytes(),
         ntfs_get_size_for_mapping_pairs(), ntfs_write_significant_bytes(),
         and ntfs_mapping_pairs_build(), adapted from libntfs.
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:13:26 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:13:26 +01:00
@@ -30,6 +30,9 @@
 	- Rename init_runlist() to ntfs_init_runlist(), ntfs_vcn_to_lcn() to
 	  ntfs_rl_vcn_to_lcn(), decompress_mapping_pairs() to
 	  ntfs_mapping_pairs_decompress() and adapt all callers.
+	- Add fs/ntfs/runlist.[hc]::ntfs_get_nr_significant_bytes(),
+	  ntfs_get_size_for_mapping_pairs(), ntfs_write_significant_bytes(),
+	  and ntfs_mapping_pairs_build(), adapted from libntfs.
 
 2.1.19 - Many cleanups, improvements, and a minor bug fix.
 
diff -Nru a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c	2004-10-19 10:13:26 +01:00
+++ b/fs/ntfs/runlist.c	2004-10-19 10:13:26 +01:00
@@ -984,3 +984,340 @@
 	/* Just in case... We could replace this with BUG() some day. */
 	return (LCN)LCN_ENOENT;
 }
+
+/**
+ * ntfs_get_nr_significant_bytes - get number of bytes needed to store a number
+ * @n:		number for which to get the number of bytes for
+ *
+ * Return the number of bytes required to store @n unambiguously as
+ * a signed number.
+ *
+ * This is used in the context of the mapping pairs array to determine how
+ * many bytes will be needed in the array to store a given logical cluster
+ * number (lcn) or a specific run length.
+ *
+ * Return the number of bytes written.  This function cannot fail.
+ */
+static inline int ntfs_get_nr_significant_bytes(const s64 n)
+{
+	s64 l = n;
+	int i;
+	s8 j;
+
+	i = 0;
+	do {
+		l >>= 8;
+		i++;
+	} while (l != 0 && l != -1);
+	j = (n >> 8 * (i - 1)) & 0xff;
+	/* If the sign bit is wrong, we need an extra byte. */
+	if ((n < 0 && j >= 0) || (n > 0 && j < 0))
+		i++;
+	return i;
+}
+
+/**
+ * ntfs_get_size_for_mapping_pairs - get bytes needed for mapping pairs array
+ * @vol:	ntfs volume (needed for the ntfs version)
+ * @rl:		locked runlist to determine the size of the mapping pairs of
+ * @start_vcn:	vcn at which to start the mapping pairs array
+ *
+ * Walk the locked runlist @rl and calculate the size in bytes of the mapping
+ * pairs array corresponding to the runlist @rl, starting at vcn @start_vcn.
+ * This for example allows us to allocate a buffer of the right size when
+ * building the mapping pairs array.
+ *
+ * If @rl is NULL, just return 1 (for the single terminator byte).
+ *
+ * Return the calculated size in bytes on success.  On error, return -errno.
+ * The following error codes are defined:
+ *	-EINVAL	- Run list contains unmapped elements.  Make sure to only pass
+ *		  fully mapped runlists to this function.
+ *	-EIO	- The runlist is corrupt.
+ *
+ * Locking: @rl must be locked on entry (either for reading or writing), it
+ *	    remains locked throughout, and is left locked upon return.
+ */
+int ntfs_get_size_for_mapping_pairs(const ntfs_volume *vol,
+		const runlist_element *rl, const VCN start_vcn)
+{
+	LCN prev_lcn;
+	int rls;
+
+	BUG_ON(start_vcn < 0);
+	if (!rl) {
+		BUG_ON(start_vcn);
+		return 1;
+	}
+	/* Skip to runlist element containing @start_vcn. */
+	while (rl->length && start_vcn >= rl[1].vcn)
+		rl++;
+	if ((!rl->length && start_vcn > rl->vcn) || start_vcn < rl->vcn)
+		return -EINVAL;
+	prev_lcn = 0;
+	/* Always need the termining zero byte. */
+	rls = 1;
+	/* Do the first partial run if present. */
+	if (start_vcn > rl->vcn) {
+		s64 delta;
+
+		/* We know rl->length != 0 already. */
+		if (rl->length < 0 || rl->lcn < LCN_HOLE)
+			goto err_out;
+		delta = start_vcn - rl->vcn;
+		/* Header byte + length. */
+		rls += 1 + ntfs_get_nr_significant_bytes(rl->length - delta);
+		/*
+		 * If the logical cluster number (lcn) denotes a hole and we
+		 * are on NTFS 3.0+, we don't store it at all, i.e. we need
+		 * zero space.  On earlier NTFS versions we just store the lcn.
+		 * Note: this assumes that on NTFS 1.2-, holes are stored with
+		 * an lcn of -1 and not a delta_lcn of -1 (unless both are -1).
+		 */
+		if (rl->lcn >= 0 || vol->major_ver < 3) {
+			prev_lcn = rl->lcn;
+			if (rl->lcn >= 0)
+				prev_lcn += delta;
+			/* Change in lcn. */
+			rls += ntfs_get_nr_significant_bytes(prev_lcn);
+		}
+		/* Go to next runlist element. */
+		rl++;
+	}
+	/* Do the full runs. */
+	for (; rl->length; rl++) {
+		if (rl->length < 0 || rl->lcn < LCN_HOLE)
+			goto err_out;
+		/* Header byte + length. */
+		rls += 1 + ntfs_get_nr_significant_bytes(rl->length);
+		/*
+		 * If the logical cluster number (lcn) denotes a hole and we
+		 * are on NTFS 3.0+, we don't store it at all, i.e. we need
+		 * zero space.  On earlier NTFS versions we just store the lcn.
+		 * Note: this assumes that on NTFS 1.2-, holes are stored with
+		 * an lcn of -1 and not a delta_lcn of -1 (unless both are -1).
+		 */
+		if (rl->lcn >= 0 || vol->major_ver < 3) {
+			/* Change in lcn. */
+			rls += ntfs_get_nr_significant_bytes(rl->lcn -
+					prev_lcn);
+			prev_lcn = rl->lcn;
+		}
+	}
+	return rls;
+err_out:
+	if (rl->lcn == LCN_RL_NOT_MAPPED)
+		rls = -EINVAL;
+	else
+		rls = -EIO;
+	return rls;
+}
+
+/**
+ * ntfs_write_significant_bytes - write the significant bytes of a number
+ * @dst:	destination buffer to write to
+ * @dst_max:	pointer to last byte of destination buffer for bounds checking
+ * @n:		number whose significant bytes to write
+ *
+ * Store in @dst, the minimum bytes of the number @n which are required to
+ * identify @n unambiguously as a signed number, taking care not to exceed
+ * @dest_max, the maximum position within @dst to which we are allowed to
+ * write.
+ *
+ * This is used when building the mapping pairs array of a runlist to compress
+ * a given logical cluster number (lcn) or a specific run length to the minumum
+ * size possible.
+ *
+ * Return the number of bytes written on success.  On error, i.e. the
+ * destination buffer @dst is too small, return -ENOSPC.
+ */
+static inline int ntfs_write_significant_bytes(s8 *dst, const s8 *dst_max,
+		const s64 n)
+{
+	s64 l = n;
+	int i;
+	s8 j;
+
+	i = 0;
+	do {
+		if (dst > dst_max)
+			goto err_out;
+		*dst++ = l & 0xffll;
+		l >>= 8;
+		i++;
+	} while (l != 0 && l != -1);
+	j = (n >> 8 * (i - 1)) & 0xff;
+	/* If the sign bit is wrong, we need an extra byte. */
+	if (n < 0 && j >= 0) {
+		if (dst > dst_max)
+			goto err_out;
+		i++;
+		*dst = (s8)-1;
+	} else if (n > 0 && j < 0) {
+		if (dst > dst_max)
+			goto err_out;
+		i++;
+		*dst = (s8)0;
+	}
+	return i;
+err_out:
+	return -ENOSPC;
+}
+
+/**
+ * ntfs_mapping_pairs_build - build the mapping pairs array from a runlist
+ * @vol:	ntfs volume (needed for the ntfs version)
+ * @dst:	destination buffer to which to write the mapping pairs array
+ * @dst_len:	size of destination buffer @dst in bytes
+ * @rl:		locked runlist for which to build the mapping pairs array
+ * @start_vcn:	vcn at which to start the mapping pairs array
+ * @stop_vcn:	first vcn outside destination buffer on success or -ENOSPC
+ *
+ * Create the mapping pairs array from the locked runlist @rl, starting at vcn
+ * @start_vcn and save the array in @dst.  @dst_len is the size of @dst in
+ * bytes and it should be at least equal to the value obtained by calling
+ * ntfs_get_size_for_mapping_pairs().
+ *
+ * If @rl is NULL, just write a single terminator byte to @dst.
+ *
+ * On success or -ENOSPC error, if @stop_vcn is not NULL, *@stop_vcn is set to
+ * the first vcn outside the destination buffer.  Note that on error, @dst has
+ * been filled with all the mapping pairs that will fit, thus it can be treated
+ * as partial success, in that a new attribute extent needs to be created or
+ * the next extent has to be used and the mapping pairs build has to be
+ * continued with @start_vcn set to *@stop_vcn.
+ *
+ * Return 0 on success and -errno on error.  The following error codes are
+ * defined:
+ *	-EINVAL	- Run list contains unmapped elements.  Make sure to only pass
+ *		  fully mapped runlists to this function.
+ *	-EIO	- The runlist is corrupt.
+ *	-ENOSPC	- The destination buffer is too small.
+ *
+ * Locking: @rl must be locked on entry (either for reading or writing), it
+ *	    remains locked throughout, and is left locked upon return.
+ */
+int ntfs_mapping_pairs_build(const ntfs_volume *vol, s8 *dst,
+		const int dst_len, const runlist_element *rl,
+		const VCN start_vcn, VCN *const stop_vcn)
+{
+	LCN prev_lcn;
+	s8 *dst_max, *dst_next;
+	int err = -ENOSPC;
+	s8 len_len, lcn_len;
+
+	BUG_ON(start_vcn < 0);
+	BUG_ON(dst_len < 1);
+	if (!rl) {
+		BUG_ON(start_vcn);
+		if (stop_vcn)
+			*stop_vcn = 0;
+		/* Terminator byte. */
+		*dst = 0;
+		return 0;
+	}
+	/* Skip to runlist element containing @start_vcn. */
+	while (rl->length && start_vcn >= rl[1].vcn)
+		rl++;
+	if ((!rl->length && start_vcn > rl->vcn) || start_vcn < rl->vcn)
+		return -EINVAL;
+	/*
+	 * @dst_max is used for bounds checking in
+	 * ntfs_write_significant_bytes().
+	 */
+	dst_max = dst + dst_len - 1;
+	prev_lcn = 0;
+	/* Do the first partial run if present. */
+	if (start_vcn > rl->vcn) {
+		s64 delta;
+
+		/* We know rl->length != 0 already. */
+		if (rl->length < 0 || rl->lcn < LCN_HOLE)
+			goto err_out;
+		delta = start_vcn - rl->vcn;
+		/* Write length. */
+		len_len = ntfs_write_significant_bytes(dst + 1, dst_max,
+				rl->length - delta);
+		if (len_len < 0)
+			goto size_err;
+		/*
+		 * If the logical cluster number (lcn) denotes a hole and we
+		 * are on NTFS 3.0+, we don't store it at all, i.e. we need
+		 * zero space.  On earlier NTFS versions we just write the lcn
+		 * change.  FIXME: Do we need to write the lcn change or just
+		 * the lcn in that case?  Not sure as I have never seen this
+		 * case on NT4. - We assume that we just need to write the lcn
+		 * change until someone tells us otherwise... (AIA)
+		 */
+		if (rl->lcn >= 0 || vol->major_ver < 3) {
+			prev_lcn = rl->lcn;
+			if (rl->lcn >= 0)
+				prev_lcn += delta;
+			/* Write change in lcn. */
+			lcn_len = ntfs_write_significant_bytes(dst + 1 +
+					len_len, dst_max, prev_lcn);
+			if (lcn_len < 0)
+				goto size_err;
+		} else
+			lcn_len = 0;
+		dst_next = dst + len_len + lcn_len + 1;
+		if (dst_next > dst_max)
+			goto size_err;
+		/* Update header byte. */
+		*dst = lcn_len << 4 | len_len;
+		/* Position at next mapping pairs array element. */
+		dst = dst_next;
+		/* Go to next runlist element. */
+		rl++;
+	}
+	/* Do the full runs. */
+	for (; rl->length; rl++) {
+		if (rl->length < 0 || rl->lcn < LCN_HOLE)
+			goto err_out;
+		/* Write length. */
+		len_len = ntfs_write_significant_bytes(dst + 1, dst_max,
+				rl->length);
+		if (len_len < 0)
+			goto size_err;
+		/*
+		 * If the logical cluster number (lcn) denotes a hole and we
+		 * are on NTFS 3.0+, we don't store it at all, i.e. we need
+		 * zero space.  On earlier NTFS versions we just write the lcn
+		 * change.  FIXME: Do we need to write the lcn change or just
+		 * the lcn in that case?  Not sure as I have never seen this
+		 * case on NT4. - We assume that we just need to write the lcn
+		 * change until someone tells us otherwise... (AIA)
+		 */
+		if (rl->lcn >= 0 || vol->major_ver < 3) {
+			/* Write change in lcn. */
+			lcn_len = ntfs_write_significant_bytes(dst + 1 +
+					len_len, dst_max, rl->lcn - prev_lcn);
+			if (lcn_len < 0)
+				goto size_err;
+			prev_lcn = rl->lcn;
+		} else
+			lcn_len = 0;
+		dst_next = dst + len_len + lcn_len + 1;
+		if (dst_next > dst_max)
+			goto size_err;
+		/* Update header byte. */
+		*dst = lcn_len << 4 | len_len;
+		/* Position at next mapping pairs array element. */
+		dst = dst_next;
+	}
+	/* Success. */
+	err = 0;
+size_err:
+	/* Set stop vcn. */
+	if (stop_vcn)
+		*stop_vcn = rl->vcn;
+	/* Add terminator byte. */
+	*dst = 0;
+	return err;
+err_out:
+	if (rl->lcn == LCN_RL_NOT_MAPPED)
+		err = -EINVAL;
+	else
+		err = -EIO;
+	return err;
+}
diff -Nru a/fs/ntfs/runlist.h b/fs/ntfs/runlist.h
--- a/fs/ntfs/runlist.h	2004-10-19 10:13:26 +01:00
+++ b/fs/ntfs/runlist.h	2004-10-19 10:13:26 +01:00
@@ -45,4 +45,11 @@
 
 extern LCN ntfs_rl_vcn_to_lcn(const runlist_element *rl, const VCN vcn);
 
+extern int ntfs_get_size_for_mapping_pairs(const ntfs_volume *vol,
+		const runlist_element *rl, const VCN start_vcn);
+
+extern int ntfs_mapping_pairs_build(const ntfs_volume *vol, s8 *dst,
+		const int dst_len, const runlist_element *rl,
+		const VCN start_vcn, VCN *const stop_vcn);
+
 #endif /* _LINUX_NTFS_RUNLIST_H */
