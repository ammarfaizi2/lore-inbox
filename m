Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbUKJN4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUKJN4x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 08:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbUKJN42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:56:28 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:11137 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261899AbUKJNpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:03 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 9/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsmC-0006OT-Mk@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:44:44 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 9/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/27 1.2026.1.32)
   NTFS: Check for location of attribute name and improve error handling in
         general in fs/ntfs/inode.c::ntfs_read_locked_inode() and friends.
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:44:48 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:44:48 +00:00
@@ -40,6 +40,8 @@
 	  analagous to the way it is done in __set_page_dirty_buffers().
 	- Ensure the mft record size does not exceed the PAGE_CACHE_SIZE at
 	  mount time as this cannot work with the current implementation.
+	- Check for location of attribute name and improve error handling in
+	  general in fs/ntfs/inode.c::ntfs_read_locked_inode() and friends.
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-11-10 13:44:48 +00:00
+++ b/fs/ntfs/inode.c	2004-11-10 13:44:48 +00:00
@@ -564,13 +564,11 @@
 	}
 
 	if (!(m->flags & MFT_RECORD_IN_USE)) {
-		ntfs_error(vi->i_sb, "Inode is not in use! You should "
-				"run chkdsk.");
+		ntfs_error(vi->i_sb, "Inode is not in use!");
 		goto unm_err_out;
 	}
 	if (m->base_mft_record) {
-		ntfs_error(vi->i_sb, "Inode is an extent inode! You should "
-				"run chkdsk.");
+		ntfs_error(vi->i_sb, "Inode is an extent inode!");
 		goto unm_err_out;
 	}
 
@@ -667,7 +665,7 @@
 	if (err) {
 		if (unlikely(err != -ENOENT)) {
 			ntfs_error(vi->i_sb, "Failed to lookup attribute list "
-					"attribute. You should run chkdsk.");
+					"attribute.");
 			goto unm_err_out;
 		}
 	} else /* if (!err) */ {
@@ -679,9 +677,7 @@
 				ctx->attr->flags & ATTR_COMPRESSION_MASK ||
 				ctx->attr->flags & ATTR_IS_SPARSE) {
 			ntfs_error(vi->i_sb, "Attribute list attribute is "
-					"compressed/encrypted/sparse. Not "
-					"allowed. Corrupt inode. You should "
-					"run chkdsk.");
+					"compressed/encrypted/sparse.");
 			goto unm_err_out;
 		}
 		/* Now allocate memory for the attribute list. */
@@ -697,9 +693,7 @@
 			NInoSetAttrListNonResident(ni);
 			if (ctx->attr->data.non_resident.lowest_vcn) {
 				ntfs_error(vi->i_sb, "Attribute list has non "
-						"zero lowest_vcn. Inode is "
-						"corrupt. You should run "
-						"chkdsk.");
+						"zero lowest_vcn.");
 				goto unm_err_out;
 			}
 			/*
@@ -712,10 +706,7 @@
 				err = PTR_ERR(ni->attr_list_rl.rl);
 				ni->attr_list_rl.rl = NULL;
 				ntfs_error(vi->i_sb, "Mapping pairs "
-						"decompression failed with "
-						"error code %i. Corrupt "
-						"attribute list in inode.",
-						-err);
+						"decompression failed.");
 				goto unm_err_out;
 			}
 			/* Now load the attribute list. */
@@ -770,9 +761,18 @@
 			goto unm_err_out;
 		}
 		/* Set up the state. */
-		if (ctx->attr->non_resident) {
-			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is "
-					"not resident. Not allowed.");
+		if (unlikely(ctx->attr->non_resident)) {
+			ntfs_error(vol->sb, "$INDEX_ROOT attribute is not "
+					"resident.");
+			goto unm_err_out;
+		}
+		/* Ensure the attribute name is placed before the value. */
+		if (unlikely(ctx->attr->name_length &&
+				(le16_to_cpu(ctx->attr->name_offset) >=
+				le16_to_cpu(ctx->attr->data.resident.
+				value_offset)))) {
+			ntfs_error(vol->sb, "$INDEX_ROOT attribute name is "
+					"placed after the attribute value.");
 			goto unm_err_out;
 		}
 		/*
@@ -786,8 +786,7 @@
 		if (ctx->attr->flags & ATTR_IS_ENCRYPTED) {
 			if (ctx->attr->flags & ATTR_COMPRESSION_MASK) {
 				ntfs_error(vi->i_sb, "Found encrypted and "
-						"compressed attribute. Not "
-						"allowed.");
+						"compressed attribute.");
 				goto unm_err_out;
 			}
 			NInoSetEncrypted(ni);
@@ -811,12 +810,12 @@
 		}
 		if (ir->type != AT_FILE_NAME) {
 			ntfs_error(vi->i_sb, "Indexed attribute is not "
-					"$FILE_NAME. Not allowed.");
+					"$FILE_NAME.");
 			goto unm_err_out;
 		}
 		if (ir->collation_rule != COLLATION_FILE_NAME) {
 			ntfs_error(vi->i_sb, "Index collation rule is not "
-					"COLLATION_FILE_NAME. Not allowed.");
+					"COLLATION_FILE_NAME.");
 			goto unm_err_out;
 		}
 		ni->itype.index.collation_rule = ir->collation_rule;
@@ -831,7 +830,7 @@
 		if (ni->itype.index.block_size > PAGE_CACHE_SIZE) {
 			ntfs_error(vi->i_sb, "Index block size (%u) > "
 					"PAGE_CACHE_SIZE (%ld) is not "
-					"supported. Sorry.",
+					"supported.  Sorry.",
 					ni->itype.index.block_size,
 					PAGE_CACHE_SIZE);
 			err = -EOPNOTSUPP;
@@ -840,7 +839,7 @@
 		if (ni->itype.index.block_size < NTFS_BLOCK_SIZE) {
 			ntfs_error(vi->i_sb, "Index block size (%u) < "
 					"NTFS_BLOCK_SIZE (%i) is not "
-					"supported. Sorry.",
+					"supported.  Sorry.",
 					ni->itype.index.block_size,
 					NTFS_BLOCK_SIZE);
 			err = -EOPNOTSUPP;
@@ -883,8 +882,7 @@
 			if (err == -ENOENT)
 				ntfs_error(vi->i_sb, "$INDEX_ALLOCATION "
 						"attribute is not present but "
-						"$INDEX_ROOT indicated it "
-						"is.");
+						"$INDEX_ROOT indicated it is.");
 			else
 				ntfs_error(vi->i_sb, "Failed to lookup "
 						"$INDEX_ALLOCATION "
@@ -896,6 +894,19 @@
 					"is resident.");
 			goto unm_err_out;
 		}
+		/*
+		 * Ensure the attribute name is placed before the mapping pairs
+		 * array.
+		 */
+		if (unlikely(ctx->attr->name_length &&
+				(le16_to_cpu(ctx->attr->name_offset) >=
+				le16_to_cpu(ctx->attr->data.non_resident.
+				mapping_pairs_offset)))) {
+			ntfs_error(vol->sb, "$INDEX_ALLOCATION attribute name "
+					"is placed after the mapping pairs "
+					"array.");
+			goto unm_err_out;
+		}
 		if (ctx->attr->flags & ATTR_IS_ENCRYPTED) {
 			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
 					"is encrypted.");
@@ -914,8 +925,7 @@
 		if (ctx->attr->data.non_resident.lowest_vcn) {
 			ntfs_error(vi->i_sb, "First extent of "
 					"$INDEX_ALLOCATION attribute has non "
-					"zero lowest_vcn. Inode is corrupt. "
-					"You should run chkdsk.");
+					"zero lowest_vcn.");
 			goto unm_err_out;
 		}
 		vi->i_size = sle64_to_cpu(
@@ -997,8 +1007,7 @@
 				goto no_data_attr_special_case;
 			// FIXME: File is corrupt! Hot-fix with empty data
 			// attribute if recovery option is set.
-			ntfs_error(vi->i_sb, "$DATA attribute is "
-					"missing.");
+			ntfs_error(vi->i_sb, "$DATA attribute is missing.");
 			goto unm_err_out;
 		}
 		/* Setup the state. */
@@ -1028,10 +1037,8 @@
 						compression_unit != 4) {
 					ntfs_error(vi->i_sb, "Found "
 						"nonstandard compression unit "
-						"(%u instead of 4). Cannot "
-						"handle this. This might "
-						"indicate corruption so you "
-						"should run chkdsk.",
+						"(%u instead of 4).  Cannot "
+						"handle this.",
 						ctx->attr->data.non_resident.
 						compression_unit);
 					err = -EOPNOTSUPP;
@@ -1057,8 +1064,7 @@
 			if (ctx->attr->data.non_resident.lowest_vcn) {
 				ntfs_error(vi->i_sb, "First extent of $DATA "
 						"attribute has non zero "
-						"lowest_vcn. Inode is corrupt. "
-						"You should run chkdsk.");
+						"lowest_vcn.");
 				goto unm_err_out;
 			}
 			/* Setup all the sizes. */
@@ -1127,9 +1133,11 @@
 	if (m)
 		unmap_mft_record(ni);
 err_out:
-	ntfs_error(vi->i_sb, "Failed with error code %i. Marking inode 0x%lx "
-			"as bad.", -err, vi->i_ino);
+	ntfs_error(vol->sb, "Failed with error code %i.  Marking corrupt "
+			"inode 0x%lx as bad.  Run chkdsk.", err, vi->i_ino);
 	make_bad_inode(vi);
+	if (err != -EOPNOTSUPP && err != -ENOMEM)
+		NVolSetErrors(vol);
 	return err;
 }
 
@@ -1200,15 +1208,21 @@
 		goto unm_err_out;
 
 	if (!ctx->attr->non_resident) {
+		/* Ensure the attribute name is placed before the value. */
+		if (unlikely(ctx->attr->name_length &&
+				(le16_to_cpu(ctx->attr->name_offset) >=
+				le16_to_cpu(ctx->attr->data.resident.
+				value_offset)))) {
+			ntfs_error(vol->sb, "Attribute name is placed after "
+					"the attribute value.");
+			goto unm_err_out;
+		}
 		if (NInoMstProtected(ni) || ctx->attr->flags) {
 			ntfs_error(vi->i_sb, "Found mst protected attribute "
 					"or attribute with non-zero flags but "
-					"the attribute is resident (mft_no "
-					"0x%lx, type 0x%x, name_len %i). "
-					"Please report you saw this message "
-					"to linux-ntfs-dev@lists."
-					"sourceforge.net",
-					vi->i_ino, ni->type, ni->name_len);
+					"the attribute is resident.  Please "
+					"report you saw this message to "
+					"linux-ntfs-dev@lists.sourceforge.net");
 			goto unm_err_out;
 		}
 		/*
@@ -1219,60 +1233,63 @@
 			le32_to_cpu(ctx->attr->data.resident.value_length);
 	} else {
 		NInoSetNonResident(ni);
+		/*
+		 * Ensure the attribute name is placed before the mapping pairs
+		 * array.
+		 */
+		if (unlikely(ctx->attr->name_length &&
+				(le16_to_cpu(ctx->attr->name_offset) >=
+				le16_to_cpu(ctx->attr->data.non_resident.
+				mapping_pairs_offset)))) {
+			ntfs_error(vol->sb, "Attribute name is placed after "
+					"the mapping pairs array.");
+			goto unm_err_out;
+		}
 		if (ctx->attr->flags & ATTR_COMPRESSION_MASK) {
 			if (NInoMstProtected(ni)) {
 				ntfs_error(vi->i_sb, "Found mst protected "
 						"attribute but the attribute "
-						"is compressed (mft_no 0x%lx, "
-						"type 0x%x, name_len %i). "
-						"Please report you saw this "
-						"message to linux-ntfs-dev@"
-						"lists.sourceforge.net",
-						vi->i_ino, ni->type,
-						ni->name_len);
+						"is compressed.  Please report "
+						"you saw this message to "
+						"linux-ntfs-dev@lists."
+						"sourceforge.net");
 				goto unm_err_out;
 			}
 			NInoSetCompressed(ni);
 			if ((ni->type != AT_DATA) || (ni->type == AT_DATA &&
 					ni->name_len)) {
-				ntfs_error(vi->i_sb, "Found compressed non-"
-						"data or named data attribute "
-						"(mft_no 0x%lx, type 0x%x, "
-						"name_len %i). Please report "
+				ntfs_error(vi->i_sb, "Found compressed "
+						"non-data or named data "
+						"attribute.  Please report "
 						"you saw this message to "
 						"linux-ntfs-dev@lists."
-						"sourceforge.net",
-						vi->i_ino, ni->type,
-						ni->name_len);
+						"sourceforge.net");
 				goto unm_err_out;
 			}
 			if (vol->cluster_size > 4096) {
-				ntfs_error(vi->i_sb, "Found "
-					"compressed attribute but "
-					"compression is disabled due "
-					"to cluster size (%i) > 4kiB.",
-					vol->cluster_size);
+				ntfs_error(vi->i_sb, "Found compressed "
+						"attribute but compression is "
+						"disabled due to cluster size "
+						"(%i) > 4kiB.",
+						vol->cluster_size);
 				goto unm_err_out;
 			}
 			if ((ctx->attr->flags & ATTR_COMPRESSION_MASK)
 					!= ATTR_IS_COMPRESSED) {
 				ntfs_error(vi->i_sb, "Found unknown "
-						"compression method or "
-						"corrupt file.");
+						"compression method.");
 				goto unm_err_out;
 			}
 			ni->itype.compressed.block_clusters = 1U <<
 					ctx->attr->data.non_resident.
 					compression_unit;
-			if (ctx->attr->data.non_resident.compression_unit != 4) {
-				ntfs_error(vi->i_sb, "Found "
-					"nonstandard compression unit "
-					"(%u instead of 4). Cannot "
-					"handle this. This might "
-					"indicate corruption so you "
-					"should run chkdsk.",
-					ctx->attr->data.non_resident.
-					compression_unit);
+			if (ctx->attr->data.non_resident.compression_unit !=
+					4) {
+				ntfs_error(vi->i_sb, "Found nonstandard "
+						"compression unit (%u instead "
+						"of 4).  Cannot handle this.",
+						ctx->attr->data.non_resident.
+						compression_unit);
 				err = -EOPNOTSUPP;
 				goto unm_err_out;
 			}
@@ -1292,13 +1309,10 @@
 			if (NInoMstProtected(ni)) {
 				ntfs_error(vi->i_sb, "Found mst protected "
 						"attribute but the attribute "
-						"is encrypted (mft_no 0x%lx, "
-						"type 0x%x, name_len %i). "
-						"Please report you saw this "
-						"message to linux-ntfs-dev@"
-						"lists.sourceforge.net",
-						vi->i_ino, ni->type,
-						ni->name_len);
+						"is encrypted.  Please report "
+						"you saw this message to "
+						"linux-ntfs-dev@lists."
+						"sourceforge.net");
 				goto unm_err_out;
 			}
 			NInoSetEncrypted(ni);
@@ -1307,21 +1321,17 @@
 			if (NInoMstProtected(ni)) {
 				ntfs_error(vi->i_sb, "Found mst protected "
 						"attribute but the attribute "
-						"is sparse (mft_no 0x%lx, "
-						"type 0x%x, name_len %i). "
-						"Please report you saw this "
-						"message to linux-ntfs-dev@"
-						"lists.sourceforge.net",
-						vi->i_ino, ni->type,
-						ni->name_len);
+						"is sparse.  Please report "
+						"you saw this message to "
+						"linux-ntfs-dev@lists."
+						"sourceforge.net");
 				goto unm_err_out;
 			}
 			NInoSetSparse(ni);
 		}
 		if (ctx->attr->data.non_resident.lowest_vcn) {
 			ntfs_error(vi->i_sb, "First extent of attribute has "
-					"non-zero lowest_vcn. Inode is "
-					"corrupt. You should run chkdsk.");
+					"non-zero lowest_vcn.");
 			goto unm_err_out;
 		}
 		/* Setup all the sizes. */
@@ -1372,10 +1382,15 @@
 		ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(base_ni);
 err_out:
-	ntfs_error(vi->i_sb, "Failed with error code %i while reading "
-			"attribute inode (mft_no 0x%lx, type 0x%x, name_len "
-			"%i.", -err, vi->i_ino, ni->type, ni->name_len);
+	ntfs_error(vol->sb, "Failed with error code %i while reading attribute "
+			"inode (mft_no 0x%lx, type 0x%x, name_len %i).  "
+			"Marking corrupt inode and base inode 0x%lx as bad.  "
+			"Run chkdsk.", err, vi->i_ino, ni->type, ni->name_len,
+			base_vi->i_ino);
 	make_bad_inode(vi);
+	make_bad_inode(base_vi);
+	if (err != -ENOMEM)
+		NVolSetErrors(vol);
 	return err;
 }
 
@@ -1460,16 +1475,24 @@
 		goto unm_err_out;
 	}
 	/* Set up the state. */
-	if (ctx->attr->non_resident) {
-		ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is not resident.  "
-				"Not allowed.");
+	if (unlikely(ctx->attr->non_resident)) {
+		ntfs_error(vol->sb, "$INDEX_ROOT attribute is not resident.");
+		goto unm_err_out;
+	}
+	/* Ensure the attribute name is placed before the value. */
+	if (unlikely(ctx->attr->name_length &&
+			(le16_to_cpu(ctx->attr->name_offset) >=
+			le16_to_cpu(ctx->attr->data.resident.
+			value_offset)))) {
+		ntfs_error(vol->sb, "$INDEX_ROOT attribute name is placed "
+				"after the attribute value.");
 		goto unm_err_out;
 	}
 	/* Compressed/encrypted/sparse index root is not allowed. */
 	if (ctx->attr->flags & (ATTR_COMPRESSION_MASK | ATTR_IS_ENCRYPTED |
 			ATTR_IS_SPARSE)) {
 		ntfs_error(vi->i_sb, "Found compressed/encrypted/sparse index "
-				"root attribute.  Not allowed.");
+				"root attribute.");
 		goto unm_err_out;
 	}
 	ir = (INDEX_ROOT*)((u8*)ctx->attr +
@@ -1485,8 +1508,8 @@
 		goto unm_err_out;
 	}
 	if (ir->type) {
-		ntfs_error(vi->i_sb, "Index type is not 0 (type is 0x%x).  "
-				"Not allowed.", le32_to_cpu(ir->type));
+		ntfs_error(vi->i_sb, "Index type is not 0 (type is 0x%x).",
+				le32_to_cpu(ir->type));
 		goto unm_err_out;
 	}
 	ni->itype.index.collation_rule = ir->collation_rule;
@@ -1552,6 +1575,16 @@
 				"resident.");
 		goto unm_err_out;
 	}
+	/*
+	 * Ensure the attribute name is placed before the mapping pairs array.
+	 */
+	if (unlikely(ctx->attr->name_length && (le16_to_cpu(
+			ctx->attr->name_offset) >= le16_to_cpu(
+			ctx->attr->data.non_resident.mapping_pairs_offset)))) {
+		ntfs_error(vol->sb, "$INDEX_ALLOCATION attribute name is "
+				"placed after the mapping pairs array.");
+		goto unm_err_out;
+	}
 	if (ctx->attr->flags & ATTR_IS_ENCRYPTED) {
 		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is "
 				"encrypted.");
@@ -1568,8 +1601,7 @@
 	}
 	if (ctx->attr->data.non_resident.lowest_vcn) {
 		ntfs_error(vi->i_sb, "First extent of $INDEX_ALLOCATION "
-				"attribute has non zero lowest_vcn.  Inode is "
-				"corrupt. You should run chkdsk.");
+				"attribute has non zero lowest_vcn.");
 		goto unm_err_out;
 	}
 	vi->i_size = sle64_to_cpu(ctx->attr->data.non_resident.data_size);
@@ -1595,16 +1627,16 @@
 	bni = NTFS_I(bvi);
 	if (NInoCompressed(bni) || NInoEncrypted(bni) ||
 			NInoSparse(bni)) {
-		ntfs_error(vi->i_sb, "$BITMAP attribute is compressed "
-				"and/or encrypted and/or sparse.");
+		ntfs_error(vi->i_sb, "$BITMAP attribute is compressed and/or "
+				"encrypted and/or sparse.");
 		goto iput_unm_err_out;
 	}
 	/* Consistency check bitmap size vs. index allocation size. */
 	if ((bvi->i_size << 3) < (vi->i_size >>
 			ni->itype.index.block_size_bits)) {
-		ntfs_error(vi->i_sb, "Index bitmap too small (0x%llx) "
-				"for index allocation (0x%llx).",
-				bvi->i_size << 3, vi->i_size);
+		ntfs_error(vi->i_sb, "Index bitmap too small (0x%llx) for "
+				"index allocation (0x%llx).", bvi->i_size << 3,
+				vi->i_size);
 		goto iput_unm_err_out;
 	}
 	ni->itype.index.bmp_ino = bvi;
@@ -1637,9 +1669,11 @@
 		unmap_mft_record(base_ni);
 err_out:
 	ntfs_error(vi->i_sb, "Failed with error code %i while reading index "
-			"inode (mft_no 0x%lx, name_len %i.", -err, vi->i_ino,
+			"inode (mft_no 0x%lx, name_len %i.", err, vi->i_ino,
 			ni->name_len);
 	make_bad_inode(vi);
+	if (err != -EOPNOTSUPP && err != -ENOMEM)
+		NVolSetErrors(vol);
 	return err;
 }
 
