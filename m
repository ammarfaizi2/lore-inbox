Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbUKJOAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbUKJOAC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUKJN5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:57:52 -0500
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:41944 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261906AbUKJNpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:11 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 13/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsmT-0006Pw-8l@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:01 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 13/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/01 1.2026.48.1)
   NTFS: Fix stupid bug in fs/ntfs/attrib.c::ntfs_attr_find() that resulted in
         a NULL pointer dereference in the error code path when a corrupt
         attribute was found.
   
   Thanks to Domen Puncer for the bug report.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-11-10 13:45:05 +00:00
+++ b/fs/ntfs/attrib.c	2004-11-10 13:45:05 +00:00
@@ -250,19 +250,10 @@
 		const u8 *val, const u32 val_len, ntfs_attr_search_ctx *ctx)
 {
 	ATTR_RECORD *a;
-	ntfs_volume *vol;
-	ntfschar *upcase;
-	u32 upcase_len;
+	ntfs_volume *vol = ctx->ntfs_ino->vol;
+	ntfschar *upcase = vol->upcase;
+	u32 upcase_len = vol->upcase_len;
 
-	if (ic == IGNORE_CASE) {
-		vol = ctx->ntfs_ino->vol;
-		upcase = vol->upcase;
-		upcase_len = vol->upcase_len;
-	} else {
-		vol = NULL;
-		upcase = NULL;
-		upcase_len = 0;
-	}
 	/*
 	 * Iterate over attributes in mft record starting at @ctx->attr, or the
 	 * attribute following that, if @ctx->is_first is TRUE.
@@ -354,7 +345,7 @@
 				return -ENOENT;
 		}
 	}
-	ntfs_error(NULL, "Inode is corrupt.  Run chkdsk.");
+	ntfs_error(vol->sb, "Inode is corrupt.  Run chkdsk.");
 	NVolSetErrors(vol);
 	return -EIO;
 }
