Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268127AbUJSJsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268127AbUJSJsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268231AbUJSJs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:48:28 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:27043 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268119AbUJSJj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:39:58 -0400
Date: Tue, 19 Oct 2004 10:39:48 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 4/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 4/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/30 1.2000.1.3)
   NTFS: Rename init_runlist() to ntfs_init_runlist(), ntfs_vcn_to_lcn() to
         ntfs_rl_vcn_to_lcn(), decompress_mapping_pairs() to
         ntfs_mapping_pairs_decompress() and adapt all callers.
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:13:19 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:13:19 +01:00
@@ -27,6 +27,9 @@
 	  fs/ntfs/mft.c::ntfs_extent_mft_record_free().
 	- Splitt runlist related functions off from attrib.[hc] to runlist.[hc].
 	- Add vol->mft_data_pos and initialize it at mount time.
+	- Rename init_runlist() to ntfs_init_runlist(), ntfs_vcn_to_lcn() to
+	  ntfs_rl_vcn_to_lcn(), decompress_mapping_pairs() to
+	  ntfs_mapping_pairs_decompress() and adapt all callers.
 
 2.1.19 - Many cleanups, improvements, and a minor bug fix.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-10-19 10:13:19 +01:00
+++ b/fs/ntfs/aops.c	2004-10-19 10:13:19 +01:00
@@ -232,7 +232,7 @@
 				/* Seek to element containing target vcn. */
 				while (rl->length && rl[1].vcn <= vcn)
 					rl++;
-				lcn = ntfs_vcn_to_lcn(rl, vcn);
+				lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
 			} else
 				lcn = (LCN)LCN_RL_NOT_MAPPED;
 			/* Successful remap. */
@@ -266,7 +266,7 @@
 			}
 			/* Hard error, zero out region. */
 			SetPageError(page);
-			ntfs_error(vol->sb, "ntfs_vcn_to_lcn(vcn = 0x%llx) "
+			ntfs_error(vol->sb, "ntfs_rl_vcn_to_lcn(vcn = 0x%llx) "
 					"failed with error code 0x%llx%s.",
 					(unsigned long long)vcn,
 					(unsigned long long)-lcn,
@@ -274,9 +274,9 @@
 			// FIXME: Depending on vol->on_errors, do something.
 		}
 		/*
-		 * Either iblock was outside lblock limits or ntfs_vcn_to_lcn()
-		 * returned error. Just zero that portion of the page and set
-		 * the buffer uptodate.
+		 * Either iblock was outside lblock limits or
+		 * ntfs_rl_vcn_to_lcn() returned error.  Just zero that portion
+		 * of the page and set the buffer uptodate.
 		 */
 handle_hole:
 		bh->b_blocknr = -1UL;
@@ -637,7 +637,7 @@
 			/* Seek to element containing target vcn. */
 			while (rl->length && rl[1].vcn <= vcn)
 				rl++;
-			lcn = ntfs_vcn_to_lcn(rl, vcn);
+			lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
 		} else
 			lcn = (LCN)LCN_RL_NOT_MAPPED;
 		/* Successful remap. */
@@ -673,7 +673,7 @@
 		}
 		/* Failed to map the buffer, even after retrying. */
 		bh->b_blocknr = -1UL;
-		ntfs_error(vol->sb, "ntfs_vcn_to_lcn(vcn = 0x%llx) failed "
+		ntfs_error(vol->sb, "ntfs_rl_vcn_to_lcn(vcn = 0x%llx) failed "
 				"with error code 0x%llx%s.",
 				(unsigned long long)vcn,
 				(unsigned long long)-lcn,
@@ -1402,7 +1402,7 @@
 				/* Seek to element containing target vcn. */
 				while (rl->length && rl[1].vcn <= vcn)
 					rl++;
-				lcn = ntfs_vcn_to_lcn(rl, vcn);
+				lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
 			} else
 				lcn = (LCN)LCN_RL_NOT_MAPPED;
 			if (unlikely(lcn < 0)) {
@@ -1451,7 +1451,7 @@
 				 * retrying.
 				 */
 				bh->b_blocknr = -1UL;
-				ntfs_error(vol->sb, "ntfs_vcn_to_lcn(vcn = "
+				ntfs_error(vol->sb, "ntfs_rl_vcn_to_lcn(vcn = "
 						"0x%llx) failed with error "
 						"code 0x%llx%s.",
 						(unsigned long long)vcn,
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-10-19 10:13:19 +01:00
+++ b/fs/ntfs/attrib.c	2004-10-19 10:13:19 +01:00
@@ -22,7 +22,6 @@
 
 #include <linux/buffer_head.h>
 #include "ntfs.h"
-//#include "dir.h"
 
 /**
  * ntfs_map_runlist - map (a part of) a runlist of an ntfs inode
@@ -66,10 +65,11 @@
 
 	down_write(&ni->runlist.lock);
 	/* Make sure someone else didn't do the work while we were sleeping. */
-	if (likely(ntfs_vcn_to_lcn(ni->runlist.rl, vcn) <= LCN_RL_NOT_MAPPED)) {
+	if (likely(ntfs_rl_vcn_to_lcn(ni->runlist.rl, vcn) <=
+			LCN_RL_NOT_MAPPED)) {
 		runlist_element *rl;
 
-		rl = decompress_mapping_pairs(ni->vol, ctx->attr,
+		rl = ntfs_mapping_pairs_decompress(ni->vol, ctx->attr,
 				ni->runlist.rl);
 		if (IS_ERR(rl))
 			err = PTR_ERR(rl);
@@ -398,14 +398,14 @@
 	rl = runlist->rl;
 	/* Read all clusters specified by the runlist one run at a time. */
 	while (rl->length) {
-		lcn = ntfs_vcn_to_lcn(rl, rl->vcn);
+		lcn = ntfs_rl_vcn_to_lcn(rl, rl->vcn);
 		ntfs_debug("Reading vcn = 0x%llx, lcn = 0x%llx.",
 				(unsigned long long)rl->vcn,
 				(unsigned long long)lcn);
 		/* The attribute list cannot be sparse. */
 		if (lcn < 0) {
-			ntfs_error(sb, "ntfs_vcn_to_lcn() failed. Cannot read "
-					"attribute list.");
+			ntfs_error(sb, "ntfs_rl_vcn_to_lcn() failed.  Cannot "
+					"read attribute list.");
 			goto err_out;
 		}
 		block = lcn << vol->cluster_size_bits >> block_size_bits;
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	2004-10-19 10:13:19 +01:00
+++ b/fs/ntfs/compress.c	2004-10-19 10:13:19 +01:00
@@ -600,7 +600,7 @@
 			/* Seek to element containing target vcn. */
 			while (rl->length && rl[1].vcn <= vcn)
 				rl++;
-			lcn = ntfs_vcn_to_lcn(rl, vcn);
+			lcn = ntfs_rl_vcn_to_lcn(rl, vcn);
 		} else
 			lcn = (LCN)LCN_RL_NOT_MAPPED;
 		ntfs_debug("Reading vcn = 0x%llx, lcn = 0x%llx.",
@@ -926,7 +926,7 @@
 
 rl_err:
 	up_read(&ni->runlist.lock);
-	ntfs_error(vol->sb, "ntfs_vcn_to_lcn() failed. Cannot read "
+	ntfs_error(vol->sb, "ntfs_rl_vcn_to_lcn() failed. Cannot read "
 			"compression block.");
 	goto err_out;
 
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-10-19 10:13:19 +01:00
+++ b/fs/ntfs/inode.c	2004-10-19 10:13:19 +01:00
@@ -376,13 +376,13 @@
 	ni->seq_no = 0;
 	atomic_set(&ni->count, 1);
 	ni->vol = NTFS_SB(sb);
-	init_runlist(&ni->runlist);
+	ntfs_init_runlist(&ni->runlist);
 	init_MUTEX(&ni->mrec_lock);
 	ni->page = NULL;
 	ni->page_ofs = 0;
 	ni->attr_list_size = 0;
 	ni->attr_list = NULL;
-	init_runlist(&ni->attr_list_rl);
+	ntfs_init_runlist(&ni->attr_list_rl);
 	ni->itype.index.bmp_ino = NULL;
 	ni->itype.index.block_size = 0;
 	ni->itype.index.vcn_size = 0;
@@ -701,7 +701,7 @@
 			 * Setup the runlist. No need for locking as we have
 			 * exclusive access to the inode at this time.
 			 */
-			ni->attr_list_rl.rl = decompress_mapping_pairs(vol,
+			ni->attr_list_rl.rl = ntfs_mapping_pairs_decompress(vol,
 					ctx->attr, NULL);
 			if (IS_ERR(ni->attr_list_rl.rl)) {
 				err = PTR_ERR(ni->attr_list_rl.rl);
@@ -1672,7 +1672,7 @@
  *
  * We solve these problems by starting with the $DATA attribute before anything
  * else and iterating using ntfs_attr_lookup($DATA) over all extents.  As each
- * extent is found, we decompress_mapping_pairs() including the implied
+ * extent is found, we ntfs_mapping_pairs_decompress() including the implied
  * ntfs_merge_runlists().  Each step of the iteration necessarily provides
  * sufficient information for the next step to complete.
  *
@@ -1810,7 +1810,7 @@
 				goto put_err_out;
 			}
 			/* Setup the runlist. */
-			ni->attr_list_rl.rl = decompress_mapping_pairs(vol,
+			ni->attr_list_rl.rl = ntfs_mapping_pairs_decompress(vol,
 					ctx->attr, NULL);
 			if (IS_ERR(ni->attr_list_rl.rl)) {
 				err = PTR_ERR(ni->attr_list_rl.rl);
@@ -1942,11 +1942,11 @@
 		 * as we have exclusive access to the inode at this time and we
 		 * are a mount in progress task, too.
 		 */
-		nrl = decompress_mapping_pairs(vol, attr, ni->runlist.rl);
+		nrl = ntfs_mapping_pairs_decompress(vol, attr, ni->runlist.rl);
 		if (IS_ERR(nrl)) {
-			ntfs_error(sb, "decompress_mapping_pairs() failed with "
-					"error code %ld. $MFT is corrupt.",
-					PTR_ERR(nrl));
+			ntfs_error(sb, "ntfs_mapping_pairs_decompress() "
+					"failed with error code %ld.  $MFT is "
+					"corrupt.", PTR_ERR(nrl));
 			goto put_err_out;
 		}
 		ni->runlist.rl = nrl;
diff -Nru a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c	2004-10-19 10:13:19 +01:00
+++ b/fs/ntfs/runlist.c	2004-10-19 10:13:19 +01:00
@@ -685,7 +685,7 @@
 }
 
 /**
- * decompress_mapping_pairs - convert mapping pairs array to runlist
+ * ntfs_mapping_pairs_decompress - convert mapping pairs array to runlist
  * @vol:	ntfs volume on which the attribute resides
  * @attr:	attribute record whose mapping pairs array to decompress
  * @old_rl:	optional runlist in which to insert @attr's runlist
@@ -712,7 +712,7 @@
  * two into one, if that is possible (we check for overlap and discard the new
  * runlist if overlap present before returning ERR_PTR(-ERANGE)).
  */
-runlist_element *decompress_mapping_pairs(const ntfs_volume *vol,
+runlist_element *ntfs_mapping_pairs_decompress(const ntfs_volume *vol,
 		const ATTR_RECORD *attr, runlist_element *old_rl)
 {
 	VCN vcn;		/* Current vcn. */
@@ -929,7 +929,7 @@
 }
 
 /**
- * ntfs_vcn_to_lcn - convert a vcn into a lcn given a runlist
+ * ntfs_rl_vcn_to_lcn - convert a vcn into a lcn given a runlist
  * @rl:		runlist to use for conversion
  * @vcn:	vcn to convert
  *
@@ -951,7 +951,7 @@
  * Locking: - The caller must have locked the runlist (for reading or writing).
  *	    - This function does not touch the lock.
  */
-LCN ntfs_vcn_to_lcn(const runlist_element *rl, const VCN vcn)
+LCN ntfs_rl_vcn_to_lcn(const runlist_element *rl, const VCN vcn)
 {
 	int i;
 
diff -Nru a/fs/ntfs/runlist.h b/fs/ntfs/runlist.h
--- a/fs/ntfs/runlist.h	2004-10-19 10:13:19 +01:00
+++ b/fs/ntfs/runlist.h	2004-10-19 10:13:19 +01:00
@@ -28,7 +28,7 @@
 #include "layout.h"
 #include "volume.h"
 
-static inline void init_runlist(runlist *rl)
+static inline void ntfs_init_runlist(runlist *rl)
 {
 	rl->rl = NULL;
 	init_rwsem(&rl->lock);
@@ -40,9 +40,9 @@
 	LCN_ENOENT		= -3,
 } LCN_SPECIAL_VALUES;
 
-extern runlist_element *decompress_mapping_pairs(const ntfs_volume *vol,
+extern runlist_element *ntfs_mapping_pairs_decompress(const ntfs_volume *vol,
 		const ATTR_RECORD *attr, runlist_element *old_rl);
 
-extern LCN ntfs_vcn_to_lcn(const runlist_element *rl, const VCN vcn);
+extern LCN ntfs_rl_vcn_to_lcn(const runlist_element *rl, const VCN vcn);
 
 #endif /* _LINUX_NTFS_RUNLIST_H */
