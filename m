Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbWCWR1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWCWR1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWCWR1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:27:47 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:63940 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932170AbWCWR1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:27:44 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:24:54 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 06/14] NTFS: Add support for sparse files which have a
 compression unit of 0.
In-Reply-To: <Pine.LNX.4.64.0603231723320.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231724200.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231721240.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231722330.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231723320.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Add support for sparse files which have a compression unit of 0.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/ChangeLog |    1 +
 fs/ntfs/attrib.c  |   25 +++++++++++++------
 fs/ntfs/inode.c   |   68 +++++++++++++++++++++++++++++++++++------------------
 fs/ntfs/layout.h  |   19 +++++++++------
 4 files changed, 75 insertions(+), 38 deletions(-)

a0646a1f04f1ec4c7514e5b00496b54e054a2c99
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 548d905..b577423 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -31,6 +31,7 @@ ToDo/Notes:
 	- Fix comparison of $MFT and $MFTMirr to not bail out when there are
 	  unused, invalid mft records which are the same in both $MFT and
 	  $MFTMirr.
+	- Add support for sparse files which have a compression unit of 0.
 
 2.1.26 - Minor bug fixes and updates.
 
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index a92b9e9..7a568eb 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1695,7 +1695,9 @@ int ntfs_attr_make_non_resident(ntfs_ino
 			a->data.non_resident.initialized_size =
 			cpu_to_sle64(attr_size);
 	if (NInoSparse(ni) || NInoCompressed(ni)) {
-		a->data.non_resident.compression_unit = 4;
+		a->data.non_resident.compression_unit = 0;
+		if (NInoCompressed(ni) || vol->major_ver < 3)
+			a->data.non_resident.compression_unit = 4;
 		a->data.non_resident.compressed_size =
 				a->data.non_resident.allocated_size;
 	} else
@@ -1714,13 +1716,20 @@ int ntfs_attr_make_non_resident(ntfs_ino
 	ni->allocated_size = new_size;
 	if (NInoSparse(ni) || NInoCompressed(ni)) {
 		ni->itype.compressed.size = ni->allocated_size;
-		ni->itype.compressed.block_size = 1U <<
-				(a->data.non_resident.compression_unit +
-				vol->cluster_size_bits);
-		ni->itype.compressed.block_size_bits =
-				ffs(ni->itype.compressed.block_size) - 1;
-		ni->itype.compressed.block_clusters = 1U <<
-				a->data.non_resident.compression_unit;
+		if (a->data.non_resident.compression_unit) {
+			ni->itype.compressed.block_size = 1U << (a->data.
+					non_resident.compression_unit +
+					vol->cluster_size_bits);
+			ni->itype.compressed.block_size_bits =
+					ffs(ni->itype.compressed.block_size) -
+					1;
+			ni->itype.compressed.block_clusters = 1U <<
+					a->data.non_resident.compression_unit;
+		} else {
+			ni->itype.compressed.block_size = 0;
+			ni->itype.compressed.block_size_bits = 0;
+			ni->itype.compressed.block_clusters = 0;
+		}
 		vi->i_blocks = ni->itype.compressed.size >> 9;
 	} else
 		vi->i_blocks = ni->allocated_size >> 9;
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 55263b7..ae34192 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1,7 +1,7 @@
 /**
  * inode.c - NTFS kernel inode handling. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2005 Anton Altaparmakov
+ * Copyright (c) 2001-2006 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -24,8 +24,10 @@
 #include <linux/smp_lock.h>
 #include <linux/quotaops.h>
 #include <linux/mount.h>
+#include <linux/mutex.h>
 
 #include "aops.h"
+#include "attrib.h"
 #include "dir.h"
 #include "debug.h"
 #include "inode.h"
@@ -1064,10 +1066,10 @@ skip_large_dir_stuff:
 		if (a->non_resident) {
 			NInoSetNonResident(ni);
 			if (NInoCompressed(ni) || NInoSparse(ni)) {
-				if (a->data.non_resident.compression_unit !=
-						4) {
+				if (NInoCompressed(ni) && a->data.non_resident.
+						compression_unit != 4) {
 					ntfs_error(vi->i_sb, "Found "
-							"nonstandard "
+							"non-standard "
 							"compression unit (%u "
 							"instead of 4).  "
 							"Cannot handle this.",
@@ -1076,16 +1078,26 @@ skip_large_dir_stuff:
 					err = -EOPNOTSUPP;
 					goto unm_err_out;
 				}
-				ni->itype.compressed.block_clusters = 1U <<
-						a->data.non_resident.
-						compression_unit;
-				ni->itype.compressed.block_size = 1U << (
-						a->data.non_resident.
-						compression_unit +
-						vol->cluster_size_bits);
-				ni->itype.compressed.block_size_bits = ffs(
-						ni->itype.compressed.
-						block_size) - 1;
+				if (a->data.non_resident.compression_unit) {
+					ni->itype.compressed.block_size = 1U <<
+							(a->data.non_resident.
+							compression_unit +
+							vol->cluster_size_bits);
+					ni->itype.compressed.block_size_bits =
+							ffs(ni->itype.
+							compressed.
+							block_size) - 1;
+					ni->itype.compressed.block_clusters =
+							1U << a->data.
+							non_resident.
+							compression_unit;
+				} else {
+					ni->itype.compressed.block_size = 0;
+					ni->itype.compressed.block_size_bits =
+							0;
+					ni->itype.compressed.block_clusters =
+							0;
+				}
 				ni->itype.compressed.size = sle64_to_cpu(
 						a->data.non_resident.
 						compressed_size);
@@ -1338,8 +1350,9 @@ static int ntfs_read_locked_attr_inode(s
 			goto unm_err_out;
 		}
 		if (NInoCompressed(ni) || NInoSparse(ni)) {
-			if (a->data.non_resident.compression_unit != 4) {
-				ntfs_error(vi->i_sb, "Found nonstandard "
+			if (NInoCompressed(ni) && a->data.non_resident.
+					compression_unit != 4) {
+				ntfs_error(vi->i_sb, "Found non-standard "
 						"compression unit (%u instead "
 						"of 4).  Cannot handle this.",
 						a->data.non_resident.
@@ -1347,13 +1360,22 @@ static int ntfs_read_locked_attr_inode(s
 				err = -EOPNOTSUPP;
 				goto unm_err_out;
 			}
-			ni->itype.compressed.block_clusters = 1U <<
-					a->data.non_resident.compression_unit;
-			ni->itype.compressed.block_size = 1U << (
-					a->data.non_resident.compression_unit +
-					vol->cluster_size_bits);
-			ni->itype.compressed.block_size_bits = ffs(
-					ni->itype.compressed.block_size) - 1;
+			if (a->data.non_resident.compression_unit) {
+				ni->itype.compressed.block_size = 1U <<
+						(a->data.non_resident.
+						compression_unit +
+						vol->cluster_size_bits);
+				ni->itype.compressed.block_size_bits =
+						ffs(ni->itype.compressed.
+						block_size) - 1;
+				ni->itype.compressed.block_clusters = 1U <<
+						a->data.non_resident.
+						compression_unit;
+			} else {
+				ni->itype.compressed.block_size = 0;
+				ni->itype.compressed.block_size_bits = 0;
+				ni->itype.compressed.block_clusters = 0;
+			}
 			ni->itype.compressed.size = sle64_to_cpu(
 					a->data.non_resident.compressed_size);
 		}
diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
index bb408d4..f4283e1 100644
--- a/fs/ntfs/layout.h
+++ b/fs/ntfs/layout.h
@@ -769,7 +769,7 @@ typedef struct {
 				compressed.  (This effectively limits the
 				compression unit size to be a power of two
 				clusters.)  WinNT4 only uses a value of 4.
-				Sparse files also have this set to 4. */
+				Sparse files have this set to 0 on XPSP2. */
 /* 35*/			u8 reserved[5];		/* Align to 8-byte boundary. */
 /* The sizes below are only used when lowest_vcn is zero, as otherwise it would
    be difficult to keep them up-to-date.*/
@@ -1076,16 +1076,21 @@ typedef struct {
 /* 20*/	sle64 last_access_time;		/* Time this mft record was last
 					   accessed. */
 /* 28*/	sle64 allocated_size;		/* Byte size of on-disk allocated space
-					   for the data attribute.  So for
-					   normal $DATA, this is the
+					   for the unnamed data attribute.  So
+					   for normal $DATA, this is the
 					   allocated_size from the unnamed
 					   $DATA attribute and for compressed
 					   and/or sparse $DATA, this is the
 					   compressed_size from the unnamed
-					   $DATA attribute.  NOTE: This is a
-					   multiple of the cluster size. */
-/* 30*/	sle64 data_size;		/* Byte size of actual data in data
-					   attribute. */
+					   $DATA attribute.  For a directory or
+					   other inode without an unnamed $DATA
+					   attribute, this is always 0.  NOTE:
+					   This is a multiple of the cluster
+					   size. */
+/* 30*/	sle64 data_size;		/* Byte size of actual data in unnamed
+					   data attribute.  For a directory or
+					   other inode without an unnamed $DATA
+					   attribute, this is always 0. */
 /* 38*/	FILE_ATTR_FLAGS file_attributes;	/* Flags describing the file. */
 /* 3c*/	union {
 	/* 3c*/	struct {
-- 
1.2.3.g9821

