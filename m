Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbVJaO2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVJaO2U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVJaO2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:28:20 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:20966 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751258AbVJaO2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:28:19 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:27:57 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 5/17] NTFS: Change ntfs_attr_make_non_resident to take the
 attribute value size
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311427190.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Change ntfs_attr_make_non_resident to take the attribute value size
      as an extra parameter.  This is needed since we need to know the size
      before we can map the mft record and our callers always know it.  The
      reason we cannot simply read the size from the vfs inode i_size is
      that this is not necessarily uptodate.  This happens when
      ntfs_attr_make_non_resident() is called in the ->truncate call path.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    6 ++++++
 fs/ntfs/attrib.c  |   13 ++++++++++---
 fs/ntfs/attrib.h  |    2 +-
 3 files changed, 17 insertions(+), 4 deletions(-)

applies-to: 67f28282e658eba6ed0daac0553a77f8352c21bc
8925d4f0d3479b9c5ed7e49acc648beccca95f21
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index aad2a3f..60ba3c5 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -37,6 +37,12 @@ ToDo/Notes:
 	- Change ntfs_attr_make_non_resident() to call ntfs_cluster_alloc()
 	  with @is_extension set to TRUE and remove the runlist terminator
 	  fixup code as this is now done by ntfs_cluster_alloc().
+	- Change ntfs_attr_make_non_resident to take the attribute value size
+	  as an extra parameter.  This is needed since we need to know the size
+	  before we can map the mft record and our callers always know it.  The
+	  reason we cannot simply read the size from the vfs inode i_size is
+	  that this is not necessarily uptodate.  This happens when
+	  ntfs_attr_make_non_resident() is called in the ->truncate call path.
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 33e689f..380f70a 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1501,10 +1501,17 @@ int ntfs_resident_attr_value_resize(MFT_
 /**
  * ntfs_attr_make_non_resident - convert a resident to a non-resident attribute
  * @ni:		ntfs inode describing the attribute to convert
+ * @data_size:	size of the resident data to copy to the non-resident attribute
  *
  * Convert the resident ntfs attribute described by the ntfs inode @ni to a
  * non-resident one.
  *
+ * @data_size must be equal to the attribute value size.  This is needed since
+ * we need to know the size before we can map the mft record and our callers
+ * always know it.  The reason we cannot simply read the size from the vfs
+ * inode i_size is that this is not necessarily uptodate.  This happens when
+ * ntfs_attr_make_non_resident() is called in the ->truncate call path(s).
+ *
  * Return 0 on success and -errno on error.  The following error return codes
  * are defined:
  *	-EPERM	- The attribute is not allowed to be non-resident.
@@ -1525,7 +1532,7 @@ int ntfs_resident_attr_value_resize(MFT_
  *
  * Locking: - The caller must hold i_sem on the inode.
  */
-int ntfs_attr_make_non_resident(ntfs_inode *ni)
+int ntfs_attr_make_non_resident(ntfs_inode *ni, const u32 data_size)
 {
 	s64 new_size;
 	struct inode *vi = VFS_I(ni);
@@ -1563,7 +1570,7 @@ int ntfs_attr_make_non_resident(ntfs_ino
 	 * The size needs to be aligned to a cluster boundary for allocation
 	 * purposes.
 	 */
-	new_size = (i_size_read(vi) + vol->cluster_size - 1) &
+	new_size = (data_size + vol->cluster_size - 1) &
 			~(vol->cluster_size - 1);
 	if (new_size > 0) {
 		/*
@@ -1647,7 +1654,7 @@ int ntfs_attr_make_non_resident(ntfs_ino
 	 * attribute value.
 	 */
 	attr_size = le32_to_cpu(a->data.resident.value_length);
-	BUG_ON(attr_size != i_size_read(vi));
+	BUG_ON(attr_size != data_size);
 	if (page && !PageUptodate(page)) {
 		kaddr = kmap_atomic(page, KM_USER0);
 		memcpy(kaddr, (u8*)a +
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index 62f7625..a959af9 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -103,7 +103,7 @@ extern int ntfs_attr_record_resize(MFT_R
 extern int ntfs_resident_attr_value_resize(MFT_RECORD *m, ATTR_RECORD *a,
 		const u32 new_size);
 
-extern int ntfs_attr_make_non_resident(ntfs_inode *ni);
+extern int ntfs_attr_make_non_resident(ntfs_inode *ni, const u32 data_size);
 
 extern int ntfs_attr_set(ntfs_inode *ni, const s64 ofs, const s64 cnt,
 		const u8 val);
---
0.99.9
