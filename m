Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268115AbUJSJp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268115AbUJSJp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUJSJp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:45:59 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:43479 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268115AbUJSJjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:39:32 -0400
Date: Tue, 19 Oct 2004 10:39:29 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 3/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 3/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/30 1.2000.1.2)
   NTFS: Add vol->mft_data_pos and initialize it at mount time.
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:13:15 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:13:15 +01:00
@@ -26,6 +26,7 @@
 	- Implement extent mft record deallocation
 	  fs/ntfs/mft.c::ntfs_extent_mft_record_free().
 	- Splitt runlist related functions off from attrib.[hc] to runlist.[hc].
+	- Add vol->mft_data_pos and initialize it at mount time.
 
 2.1.19 - Many cleanups, improvements, and a minor bug fix.
 
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-10-19 10:13:15 +01:00
+++ b/fs/ntfs/super.c	2004-10-19 10:13:15 +01:00
@@ -827,12 +827,12 @@
 }
 
 /**
- * setup_lcn_allocator - initialize the cluster allocator
- * @vol:	volume structure for which to setup the lcn allocator
+ * ntfs_setup_allocators - initialize the cluster and mft allocators
+ * @vol:	volume structure for which to setup the allocators
  *
- * Setup the cluster (lcn) allocator to the starting values.
+ * Setup the cluster (lcn) and mft allocators to the starting values.
  */
-static void setup_lcn_allocator(ntfs_volume *vol)
+static void ntfs_setup_allocators(ntfs_volume *vol)
 {
 #ifdef NTFS_RW
 	LCN mft_zone_size, mft_lcn;
@@ -902,6 +902,11 @@
 	vol->data2_zone_pos = 0;
 	ntfs_debug("vol->data2_zone_pos = 0x%llx",
 			(unsigned long long)vol->data2_zone_pos);
+
+	/* Set the mft data allocation position to mft record 24. */
+	vol->mft_data_pos = 24;
+	ntfs_debug("vol->mft_data_pos = 0x%llx",
+			(unsigned long long)vol->mft_data_pos);
 #endif /* NTFS_RW */
 }
 
@@ -2334,8 +2339,8 @@
 	 */
 	result = parse_ntfs_boot_sector(vol, (NTFS_BOOT_SECTOR*)bh->b_data);
 
-	/* Initialize the cluster allocator. */
-	setup_lcn_allocator(vol);
+	/* Initialize the cluster and mft allocators. */
+	ntfs_setup_allocators(vol);
 
 	brelse(bh);
 
diff -Nru a/fs/ntfs/volume.h b/fs/ntfs/volume.h
--- a/fs/ntfs/volume.h	2004-10-19 10:13:15 +01:00
+++ b/fs/ntfs/volume.h	2004-10-19 10:13:15 +01:00
@@ -81,6 +81,8 @@
 
 #ifdef NTFS_RW
 	/* Variables used by the cluster and mft allocators. */
+	s64 mft_data_pos;		/* Mft record number at which to
+					   allocate the next mft record. */
 	LCN mft_zone_start;		/* First cluster of the mft zone. */
 	LCN mft_zone_end;		/* First cluster beyond the mft zone. */
 	LCN mft_zone_pos;		/* Current position in the mft zone. */
