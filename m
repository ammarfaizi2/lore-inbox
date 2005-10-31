Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVJaO1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVJaO1e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVJaO1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:27:33 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:5807 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751255AbVJaO1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:27:31 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:27:14 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 4/17] NTFS: - Change ntfs_cluster_alloc() to take an extra
 boolean parameter
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311426310.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: - Change ntfs_cluster_alloc() to take an extra boolean parameter
        specifying whether the cluster are being allocated to extend an
        attribute or to fill a hole.
      - Change ntfs_attr_make_non_resident() to call ntfs_cluster_alloc()
        with @is_extension set to TRUE and remove the runlist terminator
        fixup code as this is now done by ntfs_cluster_alloc().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog  |    6 ++++++
 fs/ntfs/attrib.c   |   10 +---------
 fs/ntfs/lcnalloc.c |   15 ++++++++++++---
 fs/ntfs/lcnalloc.h |    3 ++-
 fs/ntfs/mft.c      |    6 ++++--
 5 files changed, 25 insertions(+), 15 deletions(-)

applies-to: 142b89f44ebb15f2db326a246e0eb6c454ade6e7
fc0fa7dc7d243afabdb3fb6a11d59a944a9c91f8
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 6e4f44e..aad2a3f 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -31,6 +31,12 @@ ToDo/Notes:
 	- Fix potential deadlock in ntfs_mft_data_extend_allocation_nolock()
 	  error handling by passing in the active search context when calling
 	  ntfs_cluster_free().
+	- Change ntfs_cluster_alloc() to take an extra boolean parameter
+	  specifying whether the cluster are being allocated to extend an
+	  attribute or to fill a hole.
+	- Change ntfs_attr_make_non_resident() to call ntfs_cluster_alloc()
+	  with @is_extension set to TRUE and remove the runlist terminator
+	  fixup code as this is now done by ntfs_cluster_alloc().
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 2aafc87..33e689f 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1566,8 +1566,6 @@ int ntfs_attr_make_non_resident(ntfs_ino
 	new_size = (i_size_read(vi) + vol->cluster_size - 1) &
 			~(vol->cluster_size - 1);
 	if (new_size > 0) {
-		runlist_element *rl2;
-
 		/*
 		 * Will need the page later and since the page lock nests
 		 * outside all ntfs locks, we need to get the page now.
@@ -1578,7 +1576,7 @@ int ntfs_attr_make_non_resident(ntfs_ino
 			return -ENOMEM;
 		/* Start by allocating clusters to hold the attribute value. */
 		rl = ntfs_cluster_alloc(vol, 0, new_size >>
-				vol->cluster_size_bits, -1, DATA_ZONE);
+				vol->cluster_size_bits, -1, DATA_ZONE, TRUE);
 		if (IS_ERR(rl)) {
 			err = PTR_ERR(rl);
 			ntfs_debug("Failed to allocate cluster%s, error code "
@@ -1587,12 +1585,6 @@ int ntfs_attr_make_non_resident(ntfs_ino
 					err);
 			goto page_err_out;
 		}
-		/* Change the runlist terminator to LCN_ENOENT. */
-		rl2 = rl;
-		while (rl2->length)
-			rl2++;
-		BUG_ON(rl2->lcn != LCN_RL_NOT_MAPPED);
-		rl2->lcn = LCN_ENOENT;
 	} else {
 		rl = NULL;
 		page = NULL;
diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
index 75313f4..29cabf9 100644
--- a/fs/ntfs/lcnalloc.c
+++ b/fs/ntfs/lcnalloc.c
@@ -76,6 +76,7 @@ int ntfs_cluster_free_from_rl_nolock(ntf
  * @count:	number of clusters to allocate
  * @start_lcn:	starting lcn at which to allocate the clusters (or -1 if none)
  * @zone:	zone from which to allocate the clusters
+ * @is_extension:	if TRUE, this is an attribute extension
  *
  * Allocate @count clusters preferably starting at cluster @start_lcn or at the
  * current allocator position if @start_lcn is -1, on the mounted ntfs volume
@@ -86,6 +87,13 @@ int ntfs_cluster_free_from_rl_nolock(ntf
  * @start_vcn specifies the vcn of the first allocated cluster.  This makes
  * merging the resulting runlist with the old runlist easier.
  *
+ * If @is_extension is TRUE, the caller is allocating clusters to extend an
+ * attribute and if it is FALSE, the caller is allocating clusters to fill a
+ * hole in an attribute.  Practically the difference is that if @is_extension
+ * is TRUE the returned runlist will be terminated with LCN_ENOENT and if
+ * @is_extension is FALSE the runlist will be terminated with
+ * LCN_RL_NOT_MAPPED.
+ *
  * You need to check the return value with IS_ERR().  If this is false, the
  * function was successful and the return value is a runlist describing the
  * allocated cluster(s).  If IS_ERR() is true, the function failed and
@@ -137,7 +145,8 @@ int ntfs_cluster_free_from_rl_nolock(ntf
  */
 runlist_element *ntfs_cluster_alloc(ntfs_volume *vol, const VCN start_vcn,
 		const s64 count, const LCN start_lcn,
-		const NTFS_CLUSTER_ALLOCATION_ZONES zone)
+		const NTFS_CLUSTER_ALLOCATION_ZONES zone,
+		const BOOL is_extension)
 {
 	LCN zone_start, zone_end, bmp_pos, bmp_initial_pos, last_read_pos, lcn;
 	LCN prev_lcn = 0, prev_run_len = 0, mft_zone_size;
@@ -310,7 +319,7 @@ runlist_element *ntfs_cluster_alloc(ntfs
 				continue;
 			}
 			bit = 1 << (lcn & 7);
-			ntfs_debug("bit %i.", bit);
+			ntfs_debug("bit 0x%x.", bit);
 			/* If the bit is already set, go onto the next one. */
 			if (*byte & bit) {
 				lcn++;
@@ -729,7 +738,7 @@ out:
 	/* Add runlist terminator element. */
 	if (likely(rl)) {
 		rl[rlpos].vcn = rl[rlpos - 1].vcn + rl[rlpos - 1].length;
-		rl[rlpos].lcn = LCN_RL_NOT_MAPPED;
+		rl[rlpos].lcn = is_extension ? LCN_ENOENT : LCN_RL_NOT_MAPPED;
 		rl[rlpos].length = 0;
 	}
 	if (likely(page && !IS_ERR(page))) {
diff --git a/fs/ntfs/lcnalloc.h b/fs/ntfs/lcnalloc.h
index aa05185..72cbca7 100644
--- a/fs/ntfs/lcnalloc.h
+++ b/fs/ntfs/lcnalloc.h
@@ -42,7 +42,8 @@ typedef enum {
 
 extern runlist_element *ntfs_cluster_alloc(ntfs_volume *vol,
 		const VCN start_vcn, const s64 count, const LCN start_lcn,
-		const NTFS_CLUSTER_ALLOCATION_ZONES zone);
+		const NTFS_CLUSTER_ALLOCATION_ZONES zone,
+		const BOOL is_extension);
 
 extern s64 __ntfs_cluster_free(ntfs_inode *ni, const VCN start_vcn,
 		s64 count, ntfs_attr_search_ctx *ctx, const BOOL is_rollback);
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 5577fc6..0c65cbb 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1355,7 +1355,8 @@ static int ntfs_mft_bitmap_extend_alloca
 		up_write(&vol->lcnbmp_lock);
 		ntfs_unmap_page(page);
 		/* Allocate a cluster from the DATA_ZONE. */
-		rl2 = ntfs_cluster_alloc(vol, rl[1].vcn, 1, lcn, DATA_ZONE);
+		rl2 = ntfs_cluster_alloc(vol, rl[1].vcn, 1, lcn, DATA_ZONE,
+				TRUE);
 		if (IS_ERR(rl2)) {
 			up_write(&mftbmp_ni->runlist.lock);
 			ntfs_error(vol->sb, "Failed to allocate a cluster for "
@@ -1780,7 +1781,8 @@ static int ntfs_mft_data_extend_allocati
 			nr > min_nr ? "default" : "minimal", (long long)nr);
 	old_last_vcn = rl[1].vcn;
 	do {
-		rl2 = ntfs_cluster_alloc(vol, old_last_vcn, nr, lcn, MFT_ZONE);
+		rl2 = ntfs_cluster_alloc(vol, old_last_vcn, nr, lcn, MFT_ZONE,
+				TRUE);
 		if (likely(!IS_ERR(rl2)))
 			break;
 		if (PTR_ERR(rl2) != -ENOSPC || nr == min_nr) {
---
0.99.9
