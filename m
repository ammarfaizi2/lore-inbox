Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268293AbUJSJzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268293AbUJSJzi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268130AbUJSJxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:53:38 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:44742 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268132AbUJSJlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:41:52 -0400
Date: Tue, 19 Oct 2004 10:41:40 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 12/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191041180.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191041290.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039510.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040220.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040360.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040490.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041180.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 12/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/02 1.2011.1.2)
   NTFS: Implement fs/ntfs/runlist.c::ntfs_rl_truncate_nolock().
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:13:49 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:13:49 +01:00
@@ -44,6 +44,7 @@
 	  fs/ntfs/attrib.[hc]::ntfs_attr_set() and switch
 	  fs/ntfs/logfile.c::ntfs_empty_logfile() to using it.
 	- Remove unnecessary casts from LCN_* constants.
+	- Implement fs/ntfs/runlist.c::ntfs_rl_truncate().
 
 2.1.19 - Many cleanups, improvements, and a minor bug fix.
 
diff -Nru a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c	2004-10-19 10:13:49 +01:00
+++ b/fs/ntfs/runlist.c	2004-10-19 10:13:49 +01:00
@@ -1321,3 +1321,139 @@
 		err = -EIO;
 	return err;
 }
+
+/**
+ * ntfs_rl_truncate_nolock - truncate a runlist starting at a specified vcn
+ * @runlist:	runlist to truncate
+ * @new_length:	the new length of the runlist in VCNs
+ *
+ * Truncate the runlist described by @runlist as well as the memory buffer
+ * holding the runlist elements to a length of @new_length VCNs.
+ *
+ * If @new_length lies within the runlist, the runlist elements with VCNs of
+ * @new_length and above are discarded.
+ *
+ * If @new_length lies beyond the runlist, a sparse runlist element is added to
+ * the end of the runlist @runlist or if the last runlist element is a sparse
+ * one already, this is extended.
+ *
+ * Return 0 on success and -errno on error.
+ *
+ * Locking: The caller must hold @runlist->lock for writing.
+ */
+int ntfs_rl_truncate_nolock(const ntfs_volume *vol, runlist *const runlist,
+		const s64 new_length)
+{
+	runlist_element *rl;
+	int old_size;
+
+	ntfs_debug("Entering for new_length 0x%llx.", (long long)new_length);
+	BUG_ON(!runlist);
+	BUG_ON(new_length < 0);
+	rl = runlist->rl;
+	if (unlikely(!rl)) {
+		/*
+		 * Create a runlist consisting of a sparse runlist element of
+		 * length @new_length followed by a terminator runlist element.
+		 */
+		rl = ntfs_malloc_nofs(PAGE_SIZE);
+		if (unlikely(!rl)) {
+			ntfs_error(vol->sb, "Not enough memory to allocate "
+					"runlist element buffer.");
+			return -ENOMEM;
+		}
+		runlist->rl = rl;
+		rl[1].length = rl->vcn = 0;
+		rl->lcn = LCN_HOLE;
+		rl[1].vcn = rl->length = new_length;
+		rl[1].lcn = LCN_ENOENT;
+		return 0;
+	}
+	BUG_ON(new_length < rl->vcn);
+	/* Find @new_length in the runlist. */
+	while (likely(rl->length && new_length >= rl[1].vcn))
+		rl++;
+	/*
+	 * If not at the end of the runlist we need to shrink it.
+	 * If at the end of the runlist we need to expand it.
+	 */
+	if (rl->length) {
+		runlist_element *trl;
+		BOOL is_end;
+
+		ntfs_debug("Shrinking runlist.");
+		/* Determine the runlist size. */
+		trl = rl + 1;
+		while (likely(trl->length))
+			trl++;
+		old_size = trl - runlist->rl + 1;
+		/* Truncate the run. */
+		rl->length = new_length - rl->vcn;
+		/*
+		 * If a run was partially truncated, make the following runlist
+		 * element a terminator.
+		 */
+		is_end = FALSE;
+		if (rl->length) {
+			rl++;
+			if (!rl->length)
+				is_end = TRUE;
+			rl->vcn = new_length;
+			rl->length = 0;
+		}
+		rl->lcn = LCN_ENOENT;
+		/* Reallocate memory if necessary. */
+		if (!is_end) {
+			int new_size = rl - runlist->rl + 1;
+			rl = ntfs_rl_realloc(runlist->rl, old_size, new_size);
+			if (IS_ERR(rl))
+				ntfs_warning(vol->sb, "Failed to shrink "
+						"runlist buffer.  This just "
+						"wastes a bit of memory "
+						"temporarily so we ignore it "
+						"and return success.");
+			else
+				runlist->rl = rl;
+		}
+	} else if (likely(/* !rl->length && */ new_length > rl->vcn)) {
+		ntfs_debug("Expanding runlist.");
+		/*
+		 * If there is a previous runlist element and it is a sparse
+		 * one, extend it.  Otherwise need to add a new, sparse runlist
+		 * element.
+		 */
+		if ((rl > runlist->rl) && ((rl - 1)->lcn == LCN_HOLE))
+			(rl - 1)->length = new_length - (rl - 1)->vcn;
+		else {
+			/* Determine the runlist size. */
+			old_size = rl - runlist->rl + 1;
+			/* Reallocate memory if necessary. */
+			rl = ntfs_rl_realloc(runlist->rl, old_size,
+					old_size + 1);
+			if (IS_ERR(rl)) {
+				ntfs_error(vol->sb, "Failed to expand runlist "
+						"buffer, aborting.");
+				return PTR_ERR(rl);
+			}
+			runlist->rl = rl;
+			/*
+			 * Set @rl to the same runlist element in the new
+			 * runlist as before in the old runlist.
+			 */
+			rl += old_size - 1;
+			/* Add a new, sparse runlist element. */
+			rl->lcn = LCN_HOLE;
+			rl->length = new_length - rl->vcn;
+			/* Add a new terminator runlist element. */
+			rl++;
+			rl->length = 0;
+		}
+		rl->vcn = new_length;
+		rl->lcn = LCN_ENOENT;
+	} else /* if (unlikely(!rl->length && new_length == rl->vcn)) */ {
+		/* Runlist already has same size as requested. */
+		rl->lcn = LCN_ENOENT;
+	}
+	ntfs_debug("Done.");
+	return 0;
+}
diff -Nru a/fs/ntfs/runlist.h b/fs/ntfs/runlist.h
--- a/fs/ntfs/runlist.h	2004-10-19 10:13:49 +01:00
+++ b/fs/ntfs/runlist.h	2004-10-19 10:13:49 +01:00
@@ -55,4 +55,7 @@
 		const int dst_len, const runlist_element *rl,
 		const VCN start_vcn, VCN *const stop_vcn);
 
+extern int ntfs_rl_truncate_nolock(const ntfs_volume *vol,
+		runlist *const runlist, const s64 new_length);
+
 #endif /* _LINUX_NTFS_RUNLIST_H */
