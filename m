Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUJSKcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUJSKcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268212AbUJSK3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:29:54 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:65484 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268216AbUJSJrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:47:16 -0400
Date: Tue, 19 Oct 2004 10:47:09 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 34/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191046440.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191046580.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
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
 <Pine.LNX.4.60.0410191046300.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046440.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 34/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/15 1.2054)
   NTFS: Modify fs/ntfs/mft.c::map_extent_mft_record() to only verify the mft
         record sequence number if it is specified (i.e. not zero).
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:15:10 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:15:10 +01:00
@@ -134,6 +134,8 @@
 	  that resulted due to #includes and header file interdependencies.
 	- Simplify setup of i_mode in fs/ntfs/inode.c::ntfs_read_locked_inode().
 	- Add helpers fs/ntfs/layout.h::MK_MREF() and MK_LE_MREF().
+	- Modify fs/ntfs/mft.c::map_extent_mft_record() to only verify the mft
+	  record sequence number if it is specified (i.e. not zero).
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:15:10 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:15:10 +01:00
@@ -302,8 +302,8 @@
 		ntfs_clear_extent_inode(ni);
 		goto map_err_out;
 	}
-	/* Verify the sequence number. */
-	if (unlikely(le16_to_cpu(m->sequence_number) != seq_no)) {
+	/* Verify the sequence number if it is present. */
+	if (seq_no && (le16_to_cpu(m->sequence_number) != seq_no)) {
 		ntfs_error(base_ni->vol->sb, "Found stale extent mft "
 				"reference! Corrupt file system. Run chkdsk.");
 		destroy_ni = TRUE;
