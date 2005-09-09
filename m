Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbVIIJ2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVIIJ2n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbVIIJ2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:28:41 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:9678 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030187AbVIIJ2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:28:38 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:28:26 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 17/25] NTFS: Fixup handling of sparse, compressed, and
 encrypted attributes in
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091028050.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 17/25] NTFS: Fixup handling of sparse, compressed, and encrypted attributes in
      fs/ntfs/inode.c::ntfs_read_locked_{,attr_,index_}inode().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    2 
 fs/ntfs/inode.c   |  215 ++++++++++++++++++++++++++++-------------------------
 2 files changed, 116 insertions(+), 101 deletions(-)

67bb103725e4cde322cb4ddb160a12933c5c7072
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -75,6 +75,8 @@ ToDo/Notes:
 	  which leads to lock reversal.
 	- Truncate {a,c,m}time to the ntfs supported time granularity when
 	  updating the times in the inode in ntfs_setattr().
+	- Fixup handling of sparse, compressed, and encrypted attributes in
+	  fs/ntfs/inode.c::ntfs_read_locked_{,attr_,index_}inode().
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1013,41 +1013,50 @@ skip_large_dir_stuff:
 		}
 		a = ctx->attr;
 		/* Setup the state. */
-		if (a->non_resident) {
-			NInoSetNonResident(ni);
-			if (a->flags & (ATTR_COMPRESSION_MASK |
-					ATTR_IS_SPARSE)) {
-				if (a->flags & ATTR_COMPRESSION_MASK) {
-					NInoSetCompressed(ni);
-					if (vol->cluster_size > 4096) {
-						ntfs_error(vi->i_sb, "Found "
+		if (a->flags & (ATTR_COMPRESSION_MASK | ATTR_IS_SPARSE)) {
+			if (a->flags & ATTR_COMPRESSION_MASK) {
+				NInoSetCompressed(ni);
+				if (vol->cluster_size > 4096) {
+					ntfs_error(vi->i_sb, "Found "
 							"compressed data but "
 							"compression is "
 							"disabled due to "
 							"cluster size (%i) > "
 							"4kiB.",
 							vol->cluster_size);
-						goto unm_err_out;
-					}
-					if ((a->flags & ATTR_COMPRESSION_MASK)
-							!= ATTR_IS_COMPRESSED) {
-						ntfs_error(vi->i_sb, "Found "
-							"unknown compression "
-							"method or corrupt "
-							"file.");
-						goto unm_err_out;
-					}
+					goto unm_err_out;
+				}
+				if ((a->flags & ATTR_COMPRESSION_MASK)
+						!= ATTR_IS_COMPRESSED) {
+					ntfs_error(vi->i_sb, "Found unknown "
+							"compression method "
+							"or corrupt file.");
+					goto unm_err_out;
 				}
-				if (a->flags & ATTR_IS_SPARSE)
-					NInoSetSparse(ni);
+			}
+			if (a->flags & ATTR_IS_SPARSE)
+				NInoSetSparse(ni);
+		}
+		if (a->flags & ATTR_IS_ENCRYPTED) {
+			if (NInoCompressed(ni)) {
+				ntfs_error(vi->i_sb, "Found encrypted and "
+						"compressed data.");
+				goto unm_err_out;
+			}
+			NInoSetEncrypted(ni);
+		}
+		if (a->non_resident) {
+			NInoSetNonResident(ni);
+			if (NInoCompressed(ni) || NInoSparse(ni)) {
 				if (a->data.non_resident.compression_unit !=
 						4) {
 					ntfs_error(vi->i_sb, "Found "
-						"nonstandard compression unit "
-						"(%u instead of 4).  Cannot "
-						"handle this.",
-						a->data.non_resident.
-						compression_unit);
+							"nonstandard "
+							"compression unit (%u "
+							"instead of 4).  "
+							"Cannot handle this.",
+							a->data.non_resident.
+							compression_unit);
 					err = -EOPNOTSUPP;
 					goto unm_err_out;
 				}
@@ -1065,14 +1074,6 @@ skip_large_dir_stuff:
 						a->data.non_resident.
 						compressed_size);
 			}
-			if (a->flags & ATTR_IS_ENCRYPTED) {
-				if (a->flags & ATTR_COMPRESSION_MASK) {
-					ntfs_error(vi->i_sb, "Found encrypted "
-							"and compressed data.");
-					goto unm_err_out;
-				}
-				NInoSetEncrypted(ni);
-			}
 			if (a->data.non_resident.lowest_vcn) {
 				ntfs_error(vi->i_sb, "First extent of $DATA "
 						"attribute has non zero "
@@ -1212,6 +1213,75 @@ static int ntfs_read_locked_attr_inode(s
 	if (unlikely(err))
 		goto unm_err_out;
 	a = ctx->attr;
+	if (a->flags & (ATTR_COMPRESSION_MASK | ATTR_IS_SPARSE)) {
+		if (a->flags & ATTR_COMPRESSION_MASK) {
+			NInoSetCompressed(ni);
+			if ((ni->type != AT_DATA) || (ni->type == AT_DATA &&
+					ni->name_len)) {
+				ntfs_error(vi->i_sb, "Found compressed "
+						"non-data or named data "
+						"attribute.  Please report "
+						"you saw this message to "
+						"linux-ntfs-dev@lists."
+						"sourceforge.net");
+				goto unm_err_out;
+			}
+			if (vol->cluster_size > 4096) {
+				ntfs_error(vi->i_sb, "Found compressed "
+						"attribute but compression is "
+						"disabled due to cluster size "
+						"(%i) > 4kiB.",
+						vol->cluster_size);
+				goto unm_err_out;
+			}
+			if ((a->flags & ATTR_COMPRESSION_MASK) !=
+					ATTR_IS_COMPRESSED) {
+				ntfs_error(vi->i_sb, "Found unknown "
+						"compression method.");
+				goto unm_err_out;
+			}
+		}
+		/*
+		 * The encryption flag set in an index root just means to
+		 * compress all files.
+		 */
+		if (NInoMstProtected(ni) && ni->type != AT_INDEX_ROOT) {
+			ntfs_error(vi->i_sb, "Found mst protected attribute "
+					"but the attribute is %s.  Please "
+					"report you saw this message to "
+					"linux-ntfs-dev@lists.sourceforge.net",
+					NInoCompressed(ni) ? "compressed" :
+					"sparse");
+			goto unm_err_out;
+		}
+		if (a->flags & ATTR_IS_SPARSE)
+			NInoSetSparse(ni);
+	}
+	if (a->flags & ATTR_IS_ENCRYPTED) {
+		if (NInoCompressed(ni)) {
+			ntfs_error(vi->i_sb, "Found encrypted and compressed "
+					"data.");
+			goto unm_err_out;
+		}
+		/*
+		 * The encryption flag set in an index root just means to
+		 * encrypt all files.
+		 */
+		if (NInoMstProtected(ni) && ni->type != AT_INDEX_ROOT) {
+			ntfs_error(vi->i_sb, "Found mst protected attribute "
+					"but the attribute is encrypted.  "
+					"Please report you saw this message "
+					"to linux-ntfs-dev@lists.sourceforge."
+					"net");
+			goto unm_err_out;
+		}
+		if (ni->type != AT_DATA) {
+			ntfs_error(vi->i_sb, "Found encrypted non-data "
+					"attribute.");
+			goto unm_err_out;
+		}
+		NInoSetEncrypted(ni);
+	}
 	if (!a->non_resident) {
 		/* Ensure the attribute name is placed before the value. */
 		if (unlikely(a->name_length && (le16_to_cpu(a->name_offset) >=
@@ -1220,11 +1290,10 @@ static int ntfs_read_locked_attr_inode(s
 					"the attribute value.");
 			goto unm_err_out;
 		}
-		if (NInoMstProtected(ni) || a->flags) {
+		if (NInoMstProtected(ni)) {
 			ntfs_error(vi->i_sb, "Found mst protected attribute "
-					"or attribute with non-zero flags but "
-					"the attribute is resident.  Please "
-					"report you saw this message to "
+					"but the attribute is resident.  "
+					"Please report you saw this message to "
 					"linux-ntfs-dev@lists.sourceforge.net");
 			goto unm_err_out;
 		}
@@ -1250,50 +1319,8 @@ static int ntfs_read_locked_attr_inode(s
 					"the mapping pairs array.");
 			goto unm_err_out;
 		}
-		if (a->flags & (ATTR_COMPRESSION_MASK | ATTR_IS_SPARSE)) {
-			if (a->flags & ATTR_COMPRESSION_MASK) {
-				NInoSetCompressed(ni);
-				if ((ni->type != AT_DATA) || (ni->type ==
-						AT_DATA && ni->name_len)) {
-					ntfs_error(vi->i_sb, "Found compressed "
-							"non-data or named "
-							"data attribute.  "
-							"Please report you "
-							"saw this message to "
-							"linux-ntfs-dev@lists."
-							"sourceforge.net");
-					goto unm_err_out;
-				}
-				if (vol->cluster_size > 4096) {
-					ntfs_error(vi->i_sb, "Found compressed "
-							"attribute but "
-							"compression is "
-							"disabled due to "
-							"cluster size (%i) > "
-							"4kiB.",
-							vol->cluster_size);
-					goto unm_err_out;
-				}
-				if ((a->flags & ATTR_COMPRESSION_MASK) !=
-						ATTR_IS_COMPRESSED) {
-					ntfs_error(vi->i_sb, "Found unknown "
-							"compression method.");
-					goto unm_err_out;
-				}
-			}
-			if (NInoMstProtected(ni)) {
-				ntfs_error(vi->i_sb, "Found mst protected "
-						"attribute but the attribute "
-						"is %s.  Please report you "
-						"saw this message to "
-						"linux-ntfs-dev@lists."
-						"sourceforge.net",
-						NInoCompressed(ni) ?
-						"compressed" : "sparse");
-				goto unm_err_out;
-			}
-			if (a->flags & ATTR_IS_SPARSE)
-				NInoSetSparse(ni);
+		if ((NInoCompressed(ni) || NInoSparse(ni)) &&
+				ni->type != AT_INDEX_ROOT) {
 			if (a->data.non_resident.compression_unit != 4) {
 				ntfs_error(vi->i_sb, "Found nonstandard "
 						"compression unit (%u instead "
@@ -1313,23 +1340,6 @@ static int ntfs_read_locked_attr_inode(s
 			ni->itype.compressed.size = sle64_to_cpu(
 					a->data.non_resident.compressed_size);
 		}
-		if (a->flags & ATTR_IS_ENCRYPTED) {
-			if (a->flags & ATTR_COMPRESSION_MASK) {
-				ntfs_error(vi->i_sb, "Found encrypted and "
-						"compressed data.");
-				goto unm_err_out;
-			}
-			if (NInoMstProtected(ni)) {
-				ntfs_error(vi->i_sb, "Found mst protected "
-						"attribute but the attribute "
-						"is encrypted.  Please report "
-						"you saw this message to "
-						"linux-ntfs-dev@lists."
-						"sourceforge.net");
-				goto unm_err_out;
-			}
-			NInoSetEncrypted(ni);
-		}
 		if (a->data.non_resident.lowest_vcn) {
 			ntfs_error(vi->i_sb, "First extent of attribute has "
 					"non-zero lowest_vcn.");
@@ -1348,12 +1358,12 @@ static int ntfs_read_locked_attr_inode(s
 		vi->i_mapping->a_ops = &ntfs_mst_aops;
 	else
 		vi->i_mapping->a_ops = &ntfs_aops;
-	if (NInoCompressed(ni) || NInoSparse(ni))
+	if ((NInoCompressed(ni) || NInoSparse(ni)) && ni->type != AT_INDEX_ROOT)
 		vi->i_blocks = ni->itype.compressed.size >> 9;
 	else
 		vi->i_blocks = ni->allocated_size >> 9;
 	/*
-	 * Make sure the base inode doesn't go away and attach it to the
+	 * Make sure the base inode does not go away and attach it to the
 	 * attribute inode.
 	 */
 	igrab(base_vi);
@@ -1480,7 +1490,10 @@ static int ntfs_read_locked_index_inode(
 				"after the attribute value.");
 		goto unm_err_out;
 	}
-	/* Compressed/encrypted/sparse index root is not allowed. */
+	/*
+	 * Compressed/encrypted/sparse index root is not allowed, except for
+	 * directories of course but those are not dealt with here.
+	 */
 	if (a->flags & (ATTR_COMPRESSION_MASK | ATTR_IS_ENCRYPTED |
 			ATTR_IS_SPARSE)) {
 		ntfs_error(vi->i_sb, "Found compressed/encrypted/sparse index "
