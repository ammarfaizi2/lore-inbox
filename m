Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbUKJPBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbUKJPBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 10:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbUKJOvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:51:16 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:46028 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261914AbUKJNp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:28 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 18/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsmm-0006RI-Tk@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:20 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 18/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/04 1.2026.1.53)
   NTFS: Drop the runlist lock after the vcn has been read in
         fs/ntfs/lcnalloc.c::__ntfs_cluster_free().
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:45:24 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:45:24 +00:00
@@ -70,6 +70,8 @@
 	  error handling code path that resulted in a BUG() due to trying to
 	  unmap an extent mft record when the mapping of it had failed and it
 	  thus was not mapped.  (Thanks to Ken MacFerrin for the bug report.)
+	- Drop the runlist lock after the vcn has been read in
+	  fs/ntfs/lcnalloc.c::__ntfs_cluster_free().
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
--- a/fs/ntfs/lcnalloc.c	2004-11-10 13:45:24 +00:00
+++ b/fs/ntfs/lcnalloc.c	2004-11-10 13:45:24 +00:00
@@ -903,8 +903,8 @@
 			 * Attempt to map runlist, dropping runlist lock for
 			 * the duration.
 			 */
-			up_read(&ni->runlist.lock);
 			vcn = rl->vcn;
+			up_read(&ni->runlist.lock);
 			err = ntfs_map_runlist(ni, vcn);
 			if (err) {
 				if (!is_rollback)
