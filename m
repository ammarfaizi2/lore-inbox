Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbUKJOuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbUKJOuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUKJOrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:47:10 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:19842 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261919AbUKJNpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:39 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 20/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsmu-0006Rr-P5@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:28 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 20/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/05 1.2026.1.55)
   NTFS: Fix error handling in fs/ntfs/quota.c::ntfs_mark_quotas_out_of_date()
         where we failed to release i_sem on the $Quota/$Q attribute inode.
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:45:32 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:45:32 +00:00
@@ -81,6 +81,8 @@
 	  where we cannot access any of the ntfs records in a page when a
 	  single one of them had an mst error.  (Thanks to Ken MacFerrin for
 	  the bug report.)
+	- Fix error handling in fs/ntfs/quota.c::ntfs_mark_quotas_out_of_date()
+	  where we failed to release i_sem on the $Quota/$Q attribute inode.
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/quota.c b/fs/ntfs/quota.c
--- a/fs/ntfs/quota.c	2004-11-10 13:45:32 +00:00
+++ b/fs/ntfs/quota.c	2004-11-10 13:45:32 +00:00
@@ -52,7 +52,7 @@
 	ictx = ntfs_index_ctx_get(NTFS_I(vol->quota_q_ino));
 	if (!ictx) {
 		ntfs_error(vol->sb, "Failed to get index context.");
-		return FALSE;
+		goto err_out;
 	}
 	err = ntfs_index_lookup(&qid, sizeof(qid), ictx);
 	if (err) {
@@ -108,7 +108,8 @@
 	ntfs_debug("Done.");
 	return TRUE;
 err_out:
-	ntfs_index_ctx_put(ictx);
+	if (ictx)
+		ntfs_index_ctx_put(ictx);
 	up(&vol->quota_q_ino->i_sem);
 	return FALSE;
 }
