Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268212AbUJSKcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268212AbUJSKcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268210AbUJSK3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:29:31 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:34510 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268207AbUJSJqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:46:48 -0400
Date: Tue, 19 Oct 2004 10:46:41 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 32/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191046160.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191046300.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042440.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043240.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043370.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043500.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044130.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044280.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045410.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046000.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046160.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 32/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/15 1.2052)
   NTFS: Simplify setup of i_mode in fs/ntfs/inode.c::ntfs_read_locked_inode().
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:15:02 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:15:02 +01:00
@@ -132,6 +132,7 @@
 	  inode.h and make fs/ntfs/inode.c::__ntfs_init_inode() non-static and
 	  add a declaration for it to inode.h.  Fix some compilation issues
 	  that resulted due to #includes and header file interdependencies.
+	- Simplify setup of i_mode in fs/ntfs/inode.c::ntfs_read_locked_inode().
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-10-19 10:15:02 +01:00
+++ b/fs/ntfs/inode.c	2004-10-19 10:15:02 +01:00
@@ -594,14 +594,26 @@
 	 * Also if not a directory, it could be something else, rather than
 	 * a regular file. But again, will do for now.
 	 */
+	/* Everyone gets all permissions. */
+	vi->i_mode |= S_IRWXUGO;
+	/* If read-only, noone gets write permissions. */
+	if (IS_RDONLY(vi))
+		vi->i_mode &= ~S_IWUGO;
 	if (m->flags & MFT_RECORD_IS_DIRECTORY) {
 		vi->i_mode |= S_IFDIR;
+		/*
+		 * Apply the directory permissions mask set in the mount
+		 * options.
+		 */
+		vi->i_mode &= ~vol->dmask;
 		/* Things break without this kludge! */
 		if (vi->i_nlink > 1)
 			vi->i_nlink = 1;
-	} else
+	} else {
 		vi->i_mode |= S_IFREG;
-
+		/* Apply the file permissions mask set in the mount options. */
+		vi->i_mode &= ~vol->fmask;
+	}
 	/*
 	 * Find the standard information attribute in the mft record. At this
 	 * stage we haven't setup the attribute list stuff yet, so this could
@@ -944,16 +956,6 @@
 			goto unm_err_out;
 		}
 skip_large_dir_stuff:
-		/* Everyone gets read and scan permissions. */
-		vi->i_mode |= S_IRUGO | S_IXUGO;
-		/* If not read-only, set write permissions. */
-		if (!IS_RDONLY(vi))
-			vi->i_mode |= S_IWUGO;
-		/*
-		 * Apply the directory permissions mask set in the mount
-		 * options.
-		 */
-		vi->i_mode &= ~vol->dmask;
 		/* Setup the operations for this inode. */
 		vi->i_op = &ntfs_dir_inode_ops;
 		vi->i_fop = &ntfs_dir_ops;
@@ -1090,13 +1092,6 @@
 		unmap_mft_record(ni);
 		m = NULL;
 		ctx = NULL;
-		/* Everyone gets all permissions. */
-		vi->i_mode |= S_IRWXUGO;
-		/* If read-only, noone gets write permissions. */
-		if (IS_RDONLY(vi))
-			vi->i_mode &= ~S_IWUGO;
-		/* Apply the file permissions mask set in the mount options. */
-		vi->i_mode &= ~vol->fmask;
 		/* Setup the operations for this inode. */
 		vi->i_op = &ntfs_file_inode_ops;
 		vi->i_fop = &ntfs_file_ops;
