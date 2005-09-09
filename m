Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbVIIJ1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbVIIJ1m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbVIIJ1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:27:42 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:45970 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030187AbVIIJ1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:27:41 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:27:27 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 15/25] NTFS: Fix cluster (de)allocators to work when the
 runlist is NULL and more
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091027100.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 15/25] NTFS: Fix cluster (de)allocators to work when the runlist is NULL and more
      importantly to take a locked runlist rather than them locking it
      which leads to lock reversal.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog  |    3 +++
 fs/ntfs/lcnalloc.c |   39 ++++++++++++++++-----------------------
 fs/ntfs/lcnalloc.h |   21 ++++++++++++---------
 fs/ntfs/mft.c      |    2 +-
 4 files changed, 32 insertions(+), 33 deletions(-)

bbf1813fb8ff9d21171bf22e6d1f0e0393601e86
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -70,6 +70,9 @@ ToDo/Notes:
 	- Add BUG() checks to ntfs_attr_make_non_resident() and ntfs_attr_set()
 	  to ensure that these functions are never called for compressed or
 	  encrypted attributes.
+	- Fix cluster (de)allocators to work when the runlist is NULL and more
+	  importantly to take a locked runlist rather than them locking it
+	  which leads to lock reversal.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
--- a/fs/ntfs/lcnalloc.c
+++ b/fs/ntfs/lcnalloc.c
@@ -54,6 +54,8 @@ int ntfs_cluster_free_from_rl_nolock(ntf
 	int ret = 0;
 
 	ntfs_debug("Entering.");
+	if (!rl)
+		return 0;
 	for (; rl->length; rl++) {
 		int err;
 
@@ -163,17 +165,9 @@ runlist_element *ntfs_cluster_alloc(ntfs
 	BUG_ON(zone < FIRST_ZONE);
 	BUG_ON(zone > LAST_ZONE);
 
-	/* Return empty runlist if @count == 0 */
-	// FIXME: Do we want to just return NULL instead? (AIA)
-	if (!count) {
-		rl = ntfs_malloc_nofs(PAGE_SIZE);
-		if (!rl)
-			return ERR_PTR(-ENOMEM);
-		rl[0].vcn = start_vcn;
-		rl[0].lcn = LCN_RL_NOT_MAPPED;
-		rl[0].length = 0;
-		return rl;
-	}
+	/* Return NULL if @count is zero. */
+	if (!count)
+		return NULL;
 	/* Take the lcnbmp lock for writing. */
 	down_write(&vol->lcnbmp_lock);
 	/*
@@ -788,7 +782,8 @@ out:
  * @vi:		vfs inode whose runlist describes the clusters to free
  * @start_vcn:	vcn in the runlist of @vi at which to start freeing clusters
  * @count:	number of clusters to free or -1 for all clusters
- * @is_rollback:	if TRUE this is a rollback operation
+ * @write_locked:	true if the runlist is locked for writing
+ * @is_rollback:	true if this is a rollback operation
  *
  * Free @count clusters starting at the cluster @start_vcn in the runlist
  * described by the vfs inode @vi.
@@ -806,17 +801,17 @@ out:
  * Return the number of deallocated clusters (not counting sparse ones) on
  * success and -errno on error.
  *
- * Locking: - The runlist described by @vi must be unlocked on entry and is
- *	      unlocked on return.
- *	    - This function takes the runlist lock of @vi for reading and
- *	      sometimes for writing and sometimes modifies the runlist.
+ * Locking: - The runlist described by @vi must be locked on entry and is
+ *	      locked on return.  Note if the runlist is locked for reading the
+ *	      lock may be dropped and reacquired.  Note the runlist may be
+ *	      modified when needed runlist fragments need to be mapped.
  *	    - The volume lcn bitmap must be unlocked on entry and is unlocked
  *	      on return.
  *	    - This function takes the volume lcn bitmap lock for writing and
  *	      modifies the bitmap contents.
  */
 s64 __ntfs_cluster_free(struct inode *vi, const VCN start_vcn, s64 count,
-		const BOOL is_rollback)
+		const BOOL write_locked, const BOOL is_rollback)
 {
 	s64 delta, to_free, total_freed, real_freed;
 	ntfs_inode *ni;
@@ -848,8 +843,7 @@ s64 __ntfs_cluster_free(struct inode *vi
 
 	total_freed = real_freed = 0;
 
-	down_read(&ni->runlist.lock);
-	rl = ntfs_attr_find_vcn_nolock(ni, start_vcn, FALSE);
+	rl = ntfs_attr_find_vcn_nolock(ni, start_vcn, write_locked);
 	if (IS_ERR(rl)) {
 		if (!is_rollback)
 			ntfs_error(vol->sb, "Failed to find first runlist "
@@ -903,7 +897,7 @@ s64 __ntfs_cluster_free(struct inode *vi
 
 			/* Attempt to map runlist. */
 			vcn = rl->vcn;
-			rl = ntfs_attr_find_vcn_nolock(ni, vcn, FALSE);
+			rl = ntfs_attr_find_vcn_nolock(ni, vcn, write_locked);
 			if (IS_ERR(rl)) {
 				err = PTR_ERR(rl);
 				if (!is_rollback)
@@ -950,7 +944,6 @@ s64 __ntfs_cluster_free(struct inode *vi
 		/* Update the total done clusters. */
 		total_freed += to_free;
 	}
-	up_read(&ni->runlist.lock);
 	if (likely(!is_rollback))
 		up_write(&vol->lcnbmp_lock);
 
@@ -960,7 +953,6 @@ s64 __ntfs_cluster_free(struct inode *vi
 	ntfs_debug("Done.");
 	return real_freed;
 err_out:
-	up_read(&ni->runlist.lock);
 	if (is_rollback)
 		return err;
 	/* If no real clusters were freed, no need to rollback. */
@@ -973,7 +965,8 @@ err_out:
 	 * If rollback fails, set the volume errors flag, emit an error
 	 * message, and return the error code.
 	 */
-	delta = __ntfs_cluster_free(vi, start_vcn, total_freed, TRUE);
+	delta = __ntfs_cluster_free(vi, start_vcn, total_freed, write_locked,
+			TRUE);
 	if (delta < 0) {
 		ntfs_error(vol->sb, "Failed to rollback (error %i).  Leaving "
 				"inconsistent metadata!  Unmount and run "
diff --git a/fs/ntfs/lcnalloc.h b/fs/ntfs/lcnalloc.h
--- a/fs/ntfs/lcnalloc.h
+++ b/fs/ntfs/lcnalloc.h
@@ -43,13 +43,14 @@ extern runlist_element *ntfs_cluster_all
 		const NTFS_CLUSTER_ALLOCATION_ZONES zone);
 
 extern s64 __ntfs_cluster_free(struct inode *vi, const VCN start_vcn,
-		s64 count, const BOOL is_rollback);
+		s64 count, const BOOL write_locked, const BOOL is_rollback);
 
 /**
  * ntfs_cluster_free - free clusters on an ntfs volume
  * @vi:		vfs inode whose runlist describes the clusters to free
  * @start_vcn:	vcn in the runlist of @vi at which to start freeing clusters
  * @count:	number of clusters to free or -1 for all clusters
+ * @write_locked:	true if the runlist is locked for writing
  *
  * Free @count clusters starting at the cluster @start_vcn in the runlist
  * described by the vfs inode @vi.
@@ -64,19 +65,19 @@ extern s64 __ntfs_cluster_free(struct in
  * Return the number of deallocated clusters (not counting sparse ones) on
  * success and -errno on error.
  *
- * Locking: - The runlist described by @vi must be unlocked on entry and is
- *	      unlocked on return.
- *	    - This function takes the runlist lock of @vi for reading and
- *	      sometimes for writing and sometimes modifies the runlist.
+ * Locking: - The runlist described by @vi must be locked on entry and is
+ *	      locked on return.  Note if the runlist is locked for reading the
+ *	      lock may be dropped and reacquired.  Note the runlist may be
+ *	      modified when needed runlist fragments need to be mapped.
  *	    - The volume lcn bitmap must be unlocked on entry and is unlocked
  *	      on return.
  *	    - This function takes the volume lcn bitmap lock for writing and
  *	      modifies the bitmap contents.
  */
 static inline s64 ntfs_cluster_free(struct inode *vi, const VCN start_vcn,
-		s64 count)
+		s64 count, const BOOL write_locked)
 {
-	return __ntfs_cluster_free(vi, start_vcn, count, FALSE);
+	return __ntfs_cluster_free(vi, start_vcn, count, write_locked, FALSE);
 }
 
 extern int ntfs_cluster_free_from_rl_nolock(ntfs_volume *vol,
@@ -93,8 +94,10 @@ extern int ntfs_cluster_free_from_rl_nol
  *
  * Return 0 on success and -errno on error.
  *
- * Locking: This function takes the volume lcn bitmap lock for writing and
- *	    modifies the bitmap contents.
+ * Locking: - This function takes the volume lcn bitmap lock for writing and
+ *	      modifies the bitmap contents.
+ *	    - The caller must have locked the runlist @rl for reading or
+ *	      writing.
  */
 static inline int ntfs_cluster_free_from_rl(ntfs_volume *vol,
 		const runlist_element *rl)
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1953,7 +1953,7 @@ restore_undo_alloc:
 	a = ctx->attr;
 	a->data.non_resident.highest_vcn = cpu_to_sle64(old_last_vcn - 1);
 undo_alloc:
-	if (ntfs_cluster_free(vol->mft_ino, old_last_vcn, -1) < 0) {
+	if (ntfs_cluster_free(vol->mft_ino, old_last_vcn, -1, TRUE) < 0) {
 		ntfs_error(vol->sb, "Failed to free clusters from mft data "
 				"attribute.%s", es);
 		NVolSetErrors(vol);
