Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbUKJOEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUKJOEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbUKJOAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:00:02 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:55426 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261923AbUKJNp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:56 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 25/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsnE-0006TH-G6@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:48 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 25/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/09 1.2026.1.65)
   NTFS: Disable the file size changing code from
         fs/ntfs/aops.c::ntfs_prepare_write() for now as it is not safe.
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:45:52 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:45:52 +00:00
@@ -49,11 +49,6 @@
 	- In fs/ntfs/aops.c::ntfs_writepage(), if the page is fully outside
 	  i_size, i.e. race with truncate, invalidate the buffers on the page
 	  so that they become freeable and hence the page does not leak.
-	- Implement extension of resident files in the regular file write code
-	  paths (fs/ntfs/aops.c::ntfs_{prepare,commit}_write()).  At present
-	  this only works until the data attribute becomes too big for the mft
-	  record after which we abort the write returning -EOPNOTSUPP from
-	  ntfs_prepare_write().
 	- Remove unused function fs/ntfs/runlist.c::ntfs_rl_merge().  (Adrian
 	  Bunk)
 	- Fix stupid bug in fs/ntfs/attrib.c::ntfs_attr_find() that resulted in
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-11-10 13:45:52 +00:00
+++ b/fs/ntfs/aops.c	2004-11-10 13:45:52 +00:00
@@ -1884,6 +1884,12 @@
 	/* If we do not need to resize the attribute allocation we are done. */
 	if (new_size <= vi->i_size)
 		goto done;
+
+	// FIXME: We abort for now as this code is not safe.
+	ntfs_error(vi->i_sb, "Changing the file size is not supported yet.  "
+			"Sorry.");
+	return -EOPNOTSUPP;
+
 	/* Map, pin, and lock the (base) mft record. */
 	if (!NInoAttr(ni))
 		base_ni = ni;
