Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWCWRYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWCWRYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWCWRYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:24:48 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:14211 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932174AbWCWRYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:24:47 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:24:16 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 05/14] NTFS: Fix comparison of $MFT and $MFTMirr
In-Reply-To: <Pine.LNX.4.64.0603231722330.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231723320.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231721240.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231722330.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix comparison of $MFT and $MFTMirr to not bail out when there are
      unused, invalid mft records which are the same in both $MFT and
      $MFTMirr.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/ChangeLog |    3 +++
 fs/ntfs/super.c   |   38 +++++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 13 deletions(-)

949763b2b8822c6dc6da0d0e1d4af092152546c2
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 8df1070..548d905 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -28,6 +28,9 @@ ToDo/Notes:
 	  continued the attribute lookup loop instead of aborting it.
 	- Use buffer_migrate_page() for the ->migratepage function of all ntfs
 	  address space operations.
+	- Fix comparison of $MFT and $MFTMirr to not bail out when there are
+	  unused, invalid mft records which are the same in both $MFT and
+	  $MFTMirr.
 
 2.1.26 - Minor bug fixes and updates.
 
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 71c58ec..fd4aecc 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1099,26 +1099,38 @@ static BOOL check_mft_mirror(ntfs_volume
 			kmirr = page_address(mirr_page);
 			++index;
 		}
-		/* Make sure the record is ok. */
-		if (ntfs_is_baad_recordp((le32*)kmft)) {
-			ntfs_error(sb, "Incomplete multi sector transfer "
-					"detected in mft record %i.", i);
+		/* Do not check the record if it is not in use. */
+		if (((MFT_RECORD*)kmft)->flags & MFT_RECORD_IN_USE) {
+			/* Make sure the record is ok. */
+			if (ntfs_is_baad_recordp((le32*)kmft)) {
+				ntfs_error(sb, "Incomplete multi sector "
+						"transfer detected in mft "
+						"record %i.", i);
 mm_unmap_out:
-			ntfs_unmap_page(mirr_page);
+				ntfs_unmap_page(mirr_page);
 mft_unmap_out:
-			ntfs_unmap_page(mft_page);
-			return FALSE;
+				ntfs_unmap_page(mft_page);
+				return FALSE;
+			}
 		}
-		if (ntfs_is_baad_recordp((le32*)kmirr)) {
-			ntfs_error(sb, "Incomplete multi sector transfer "
-					"detected in mft mirror record %i.", i);
-			goto mm_unmap_out;
+		/* Do not check the mirror record if it is not in use. */
+		if (((MFT_RECORD*)kmirr)->flags & MFT_RECORD_IN_USE) {
+			if (ntfs_is_baad_recordp((le32*)kmirr)) {
+				ntfs_error(sb, "Incomplete multi sector "
+						"transfer detected in mft "
+						"mirror record %i.", i);
+				goto mm_unmap_out;
+			}
 		}
 		/* Get the amount of data in the current record. */
 		bytes = le32_to_cpu(((MFT_RECORD*)kmft)->bytes_in_use);
-		if (!bytes || bytes > vol->mft_record_size) {
+		if (bytes < sizeof(MFT_RECORD_OLD) ||
+				bytes > vol->mft_record_size ||
+				ntfs_is_baad_recordp((le32*)kmft)) {
 			bytes = le32_to_cpu(((MFT_RECORD*)kmirr)->bytes_in_use);
-			if (!bytes || bytes > vol->mft_record_size)
+			if (bytes < sizeof(MFT_RECORD_OLD) ||
+					bytes > vol->mft_record_size ||
+					ntfs_is_baad_recordp((le32*)kmirr))
 				bytes = vol->mft_record_size;
 		}
 		/* Compare the two records. */
-- 
1.2.3.g9821

