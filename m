Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbUKJPBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUKJPBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 10:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUKJOwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:52:04 -0500
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:36226 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261843AbUKJNpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:24 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 17/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsmj-0006R3-1J@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:17 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 17/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/04 1.2026.1.52)
   NTFS: Fix stupid bug in fs/ntfs/attrib.c::ntfs_external_attr_find() in the
         error handling code path that resulted in a BUG() due to trying to
         unmap an extent mft record when the mapping of it had failed and it
         thus was not mapped.  (Thanks to Ken MacFerrin for the bug report.)
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:45:20 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:45:20 +00:00
@@ -66,6 +66,10 @@
 	  buffers belonging to the ntfs record dirty.  This causes the buffers
 	  to become busy and hence they are safe from removal until the page
 	  has been written out.
+	- Fix stupid bug in fs/ntfs/attrib.c::ntfs_external_attr_find() in the
+	  error handling code path that resulted in a BUG() due to trying to
+	  unmap an extent mft record when the mapping of it had failed and it
+	  thus was not mapped.  (Thanks to Ken MacFerrin for the bug report.)
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-11-10 13:45:20 +00:00
+++ b/fs/ntfs/attrib.c	2004-11-10 13:45:20 +00:00
@@ -655,7 +655,6 @@
 				ctx->mrec = map_extent_mft_record(base_ni,
 						le64_to_cpu(
 						al_entry->mft_reference), &ni);
-				ctx->ntfs_ino = ni;
 				if (IS_ERR(ctx->mrec)) {
 					ntfs_error(vol->sb, "Failed to map "
 							"extent mft record "
@@ -667,8 +666,11 @@
 					err = PTR_ERR(ctx->mrec);
 					if (err == -ENOENT)
 						err = -EIO;
+					/* Cause @ctx to be sanitized below. */
+					ni = NULL;
 					break;
 				}
+				ctx->ntfs_ino = ni;
 			}
 			ctx->attr = (ATTR_RECORD*)((u8*)ctx->mrec +
 					le16_to_cpu(ctx->mrec->attrs_offset));
@@ -740,7 +742,8 @@
 		err = -EIO;
 	}
 	if (ni != base_ni) {
-		unmap_extent_mft_record(ni);
+		if (ni)
+			unmap_extent_mft_record(ni);
 		ctx->ntfs_ino = base_ni;
 		ctx->mrec = ctx->base_mrec;
 		ctx->attr = ctx->base_attr;
