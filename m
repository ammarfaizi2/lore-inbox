Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUKJNw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUKJNw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 08:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbUKJNsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:48:38 -0500
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:33750 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261892AbUKJNor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:44:47 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 8/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsm8-0006OA-RC@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:44:40 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 8/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/27 1.2026.1.31)
   NTFS: Ensure the mft record size does not exceed the PAGE_CACHE_SIZE at
         mount time as this cannot work with the current implementation.
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:44:44 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:44:44 +00:00
@@ -38,6 +38,8 @@
 	- In fs/ntfs/aops.c::mark_ntfs_record_dirty(), take the
 	  mapping->private_lock around the dirtying of the buffer heads
 	  analagous to the way it is done in __set_page_dirty_buffers().
+	- Ensure the mft record size does not exceed the PAGE_CACHE_SIZE at
+	  mount time as this cannot work with the current implementation.
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-11-10 13:44:44 +00:00
+++ b/fs/ntfs/super.c	2004-11-10 13:44:44 +00:00
@@ -680,7 +680,7 @@
  * @b:		boot sector to parse
  *
  * Parse the ntfs boot sector @b and store all imporant information therein in
- * the ntfs super block @vol. Return TRUE on success and FALSE on error.
+ * the ntfs super block @vol.  Return TRUE on success and FALSE on error.
  */
 static BOOL parse_ntfs_boot_sector(ntfs_volume *vol, const NTFS_BOOT_SECTOR *b)
 {
@@ -713,12 +713,12 @@
 			vol->cluster_size_bits, vol->cluster_size_bits);
 	if (vol->sector_size > vol->cluster_size) {
 		ntfs_error(vol->sb, "Sector sizes above the cluster size are "
-				"not supported. Sorry.");
+				"not supported.  Sorry.");
 		return FALSE;
 	}
 	if (vol->sb->s_blocksize > vol->cluster_size) {
 		ntfs_error(vol->sb, "Cluster sizes smaller than the device "
-				"sector size are not supported. Sorry.");
+				"sector size are not supported.  Sorry.");
 		return FALSE;
 	}
 	clusters_per_mft_record = b->clusters_per_mft_record;
@@ -742,6 +742,18 @@
 			vol->mft_record_size_mask);
 	ntfs_debug("vol->mft_record_size_bits = %i (0x%x)",
 			vol->mft_record_size_bits, vol->mft_record_size_bits);
+	/*
+	 * We cannot support mft record sizes above the PAGE_CACHE_SIZE since
+	 * we store $MFT/$DATA, the table of mft records in the page cache.
+	 */
+	if (vol->mft_record_size > PAGE_CACHE_SIZE) {
+		ntfs_error(vol->sb, "Mft record size %i (0x%x) exceeds the "
+				"page cache size on your system %lu (0x%lx).  "
+				"This is not supported.  Sorry.",
+				vol->mft_record_size, vol->mft_record_size,
+				PAGE_CACHE_SIZE, PAGE_CACHE_SIZE);
+		return FALSE;
+	}
 	clusters_per_index_record = b->clusters_per_index_record;
 	ntfs_debug("clusters_per_index_record = %i (0x%x)",
 			clusters_per_index_record, clusters_per_index_record);
@@ -772,7 +784,7 @@
 	 */
 	ll = sle64_to_cpu(b->number_of_sectors) >> sectors_per_cluster_bits;
 	if ((u64)ll >= 1ULL << 32) {
-		ntfs_error(vol->sb, "Cannot handle 64-bit clusters. Sorry.");
+		ntfs_error(vol->sb, "Cannot handle 64-bit clusters.  Sorry.");
 		return FALSE;
 	}
 	vol->nr_clusters = ll;
@@ -785,8 +797,8 @@
 	if (sizeof(unsigned long) < 8) {
 		if ((ll << vol->cluster_size_bits) >= (1ULL << 41)) {
 			ntfs_error(vol->sb, "Volume size (%lluTiB) is too "
-					"large for this architecture. Maximum "
-					"supported is 2TiB. Sorry.",
+					"large for this architecture.  "
+					"Maximum supported is 2TiB.  Sorry.",
 					(unsigned long long)ll >> (40 -
 					vol->cluster_size_bits));
 			return FALSE;
@@ -794,14 +806,14 @@
 	}
 	ll = sle64_to_cpu(b->mft_lcn);
 	if (ll >= vol->nr_clusters) {
-		ntfs_error(vol->sb, "MFT LCN is beyond end of volume. Weird.");
+		ntfs_error(vol->sb, "MFT LCN is beyond end of volume.  Weird.");
 		return FALSE;
 	}
 	vol->mft_lcn = ll;
 	ntfs_debug("vol->mft_lcn = 0x%llx", (long long)vol->mft_lcn);
 	ll = sle64_to_cpu(b->mftmirr_lcn);
 	if (ll >= vol->nr_clusters) {
-		ntfs_error(vol->sb, "MFTMirr LCN is beyond end of volume. "
+		ntfs_error(vol->sb, "MFTMirr LCN is beyond end of volume.  "
 				"Weird.");
 		return FALSE;
 	}
