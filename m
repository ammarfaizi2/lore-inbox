Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVJaO0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVJaO0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVJaO0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:26:37 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:35243 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932430AbVJaO0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:26:36 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:26:28 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 3/17] NTFS: - Change {__,}ntfs_cluster_free() to also take
 an optional attribute search context
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311425430.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: - Change {__,}ntfs_cluster_free() to also take an optional attribute
        search context as argument.  This allows calling it with the mft
        record mapped.  Update all callers.
      - Fix potential deadlock in ntfs_mft_data_extend_allocation_nolock()
	error handling by passing in the active search context when calling
	ntfs_cluster_free().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog  |   11 +++++++----
 fs/ntfs/lcnalloc.c |   41 +++++++++++++++++++++++++++++++++++------
 fs/ntfs/lcnalloc.h |   40 +++++++++++++++++++++++++++++++++++-----
 fs/ntfs/mft.c      |   13 +++++++++----
 4 files changed, 86 insertions(+), 19 deletions(-)

applies-to: 6a1fc55f654d6f7cb745bba032115d5590cc5931
511bea5ea2b2b330e67c9e58ffb5027caebf9052
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 0a361dd..6e4f44e 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -24,10 +24,13 @@ ToDo/Notes:
 
 2.1.25-WIP
 
-	- Change ntfs_map_runlist_nolock() and ntfs_attr_find_vcn_nolock() to
-	  also take an optional attribute search context as argument.  This
-	  allows calling these functions with the mft record mapped.  Update
-	  all callers.
+	- Change ntfs_map_runlist_nolock(), ntfs_attr_find_vcn_nolock() and
+	  {__,}ntfs_cluster_free() to also take an optional attribute search
+	  context as argument.  This allows calling these functions with the
+	  mft record mapped.  Update all callers.
+	- Fix potential deadlock in ntfs_mft_data_extend_allocation_nolock()
+	  error handling by passing in the active search context when calling
+	  ntfs_cluster_free().
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
index 8e60c47..75313f4 100644
--- a/fs/ntfs/lcnalloc.c
+++ b/fs/ntfs/lcnalloc.c
@@ -782,6 +782,7 @@ out:
  * @ni:		ntfs inode whose runlist describes the clusters to free
  * @start_vcn:	vcn in the runlist of @ni at which to start freeing clusters
  * @count:	number of clusters to free or -1 for all clusters
+ * @ctx:	active attribute search context if present or NULL if not
  * @is_rollback:	true if this is a rollback operation
  *
  * Free @count clusters starting at the cluster @start_vcn in the runlist
@@ -791,15 +792,39 @@ out:
  * deallocated.  Thus, to completely free all clusters in a runlist, use
  * @start_vcn = 0 and @count = -1.
  *
+ * If @ctx is specified, it is an active search context of @ni and its base mft
+ * record.  This is needed when __ntfs_cluster_free() encounters unmapped
+ * runlist fragments and allows their mapping.  If you do not have the mft
+ * record mapped, you can specify @ctx as NULL and __ntfs_cluster_free() will
+ * perform the necessary mapping and unmapping.
+ *
+ * Note, __ntfs_cluster_free() saves the state of @ctx on entry and restores it
+ * before returning.  Thus, @ctx will be left pointing to the same attribute on
+ * return as on entry.  However, the actual pointers in @ctx may point to
+ * different memory locations on return, so you must remember to reset any
+ * cached pointers from the @ctx, i.e. after the call to __ntfs_cluster_free(),
+ * you will probably want to do:
+ *	m = ctx->mrec;
+ *	a = ctx->attr;
+ * Assuming you cache ctx->attr in a variable @a of type ATTR_RECORD * and that
+ * you cache ctx->mrec in a variable @m of type MFT_RECORD *.
+ *
  * @is_rollback should always be FALSE, it is for internal use to rollback
  * errors.  You probably want to use ntfs_cluster_free() instead.
  *
- * Note, ntfs_cluster_free() does not modify the runlist at all, so the caller
- * has to deal with it later.
+ * Note, __ntfs_cluster_free() does not modify the runlist, so you have to
+ * remove from the runlist or mark sparse the freed runs later.
  *
  * Return the number of deallocated clusters (not counting sparse ones) on
  * success and -errno on error.
  *
+ * WARNING: If @ctx is supplied, regardless of whether success or failure is
+ *	    returned, you need to check IS_ERR(@ctx->mrec) and if TRUE the @ctx
+ *	    is no longer valid, i.e. you need to either call
+ *	    ntfs_attr_reinit_search_ctx() or ntfs_attr_put_search_ctx() on it.
+ *	    In that case PTR_ERR(@ctx->mrec) will give you the error code for
+ *	    why the mapping of the old inode failed.
+ *
  * Locking: - The runlist described by @ni must be locked for writing on entry
  *	      and is locked on return.  Note the runlist may be modified when
  *	      needed runlist fragments need to be mapped.
@@ -807,9 +832,13 @@ out:
  *	      on return.
  *	    - This function takes the volume lcn bitmap lock for writing and
  *	      modifies the bitmap contents.
+ *	    - If @ctx is NULL, the base mft record of @ni must not be mapped on
+ *	      entry and it will be left unmapped on return.
+ *	    - If @ctx is not NULL, the base mft record must be mapped on entry
+ *	      and it will be left mapped on return.
  */
 s64 __ntfs_cluster_free(ntfs_inode *ni, const VCN start_vcn, s64 count,
-		const BOOL is_rollback)
+		ntfs_attr_search_ctx *ctx, const BOOL is_rollback)
 {
 	s64 delta, to_free, total_freed, real_freed;
 	ntfs_volume *vol;
@@ -839,7 +868,7 @@ s64 __ntfs_cluster_free(ntfs_inode *ni, 
 
 	total_freed = real_freed = 0;
 
-	rl = ntfs_attr_find_vcn_nolock(ni, start_vcn, NULL);
+	rl = ntfs_attr_find_vcn_nolock(ni, start_vcn, ctx);
 	if (IS_ERR(rl)) {
 		if (!is_rollback)
 			ntfs_error(vol->sb, "Failed to find first runlist "
@@ -893,7 +922,7 @@ s64 __ntfs_cluster_free(ntfs_inode *ni, 
 
 			/* Attempt to map runlist. */
 			vcn = rl->vcn;
-			rl = ntfs_attr_find_vcn_nolock(ni, vcn, NULL);
+			rl = ntfs_attr_find_vcn_nolock(ni, vcn, ctx);
 			if (IS_ERR(rl)) {
 				err = PTR_ERR(rl);
 				if (!is_rollback)
@@ -961,7 +990,7 @@ err_out:
 	 * If rollback fails, set the volume errors flag, emit an error
 	 * message, and return the error code.
 	 */
-	delta = __ntfs_cluster_free(ni, start_vcn, total_freed, TRUE);
+	delta = __ntfs_cluster_free(ni, start_vcn, total_freed, ctx, TRUE);
 	if (delta < 0) {
 		ntfs_error(vol->sb, "Failed to rollback (error %i).  Leaving "
 				"inconsistent metadata!  Unmount and run "
diff --git a/fs/ntfs/lcnalloc.h b/fs/ntfs/lcnalloc.h
index a6a8827..aa05185 100644
--- a/fs/ntfs/lcnalloc.h
+++ b/fs/ntfs/lcnalloc.h
@@ -27,6 +27,7 @@
 
 #include <linux/fs.h>
 
+#include "attrib.h"
 #include "types.h"
 #include "inode.h"
 #include "runlist.h"
@@ -44,13 +45,14 @@ extern runlist_element *ntfs_cluster_all
 		const NTFS_CLUSTER_ALLOCATION_ZONES zone);
 
 extern s64 __ntfs_cluster_free(ntfs_inode *ni, const VCN start_vcn,
-		s64 count, const BOOL is_rollback);
+		s64 count, ntfs_attr_search_ctx *ctx, const BOOL is_rollback);
 
 /**
  * ntfs_cluster_free - free clusters on an ntfs volume
  * @ni:		ntfs inode whose runlist describes the clusters to free
  * @start_vcn:	vcn in the runlist of @ni at which to start freeing clusters
  * @count:	number of clusters to free or -1 for all clusters
+ * @ctx:	active attribute search context if present or NULL if not
  *
  * Free @count clusters starting at the cluster @start_vcn in the runlist
  * described by the ntfs inode @ni.
@@ -59,12 +61,36 @@ extern s64 __ntfs_cluster_free(ntfs_inod
  * deallocated.  Thus, to completely free all clusters in a runlist, use
  * @start_vcn = 0 and @count = -1.
  *
- * Note, ntfs_cluster_free() does not modify the runlist at all, so the caller
- * has to deal with it later.
+ * If @ctx is specified, it is an active search context of @ni and its base mft
+ * record.  This is needed when ntfs_cluster_free() encounters unmapped runlist
+ * fragments and allows their mapping.  If you do not have the mft record
+ * mapped, you can specify @ctx as NULL and ntfs_cluster_free() will perform
+ * the necessary mapping and unmapping.
+ *
+ * Note, ntfs_cluster_free() saves the state of @ctx on entry and restores it
+ * before returning.  Thus, @ctx will be left pointing to the same attribute on
+ * return as on entry.  However, the actual pointers in @ctx may point to
+ * different memory locations on return, so you must remember to reset any
+ * cached pointers from the @ctx, i.e. after the call to ntfs_cluster_free(),
+ * you will probably want to do:
+ *	m = ctx->mrec;
+ *	a = ctx->attr;
+ * Assuming you cache ctx->attr in a variable @a of type ATTR_RECORD * and that
+ * you cache ctx->mrec in a variable @m of type MFT_RECORD *.
+ *
+ * Note, ntfs_cluster_free() does not modify the runlist, so you have to remove
+ * from the runlist or mark sparse the freed runs later.
  *
  * Return the number of deallocated clusters (not counting sparse ones) on
  * success and -errno on error.
  *
+ * WARNING: If @ctx is supplied, regardless of whether success or failure is
+ *	    returned, you need to check IS_ERR(@ctx->mrec) and if TRUE the @ctx
+ *	    is no longer valid, i.e. you need to either call
+ *	    ntfs_attr_reinit_search_ctx() or ntfs_attr_put_search_ctx() on it.
+ *	    In that case PTR_ERR(@ctx->mrec) will give you the error code for
+ *	    why the mapping of the old inode failed.
+ *
  * Locking: - The runlist described by @ni must be locked for writing on entry
  *	      and is locked on return.  Note the runlist may be modified when
  *	      needed runlist fragments need to be mapped.
@@ -72,11 +98,15 @@ extern s64 __ntfs_cluster_free(ntfs_inod
  *	      on return.
  *	    - This function takes the volume lcn bitmap lock for writing and
  *	      modifies the bitmap contents.
+ *	    - If @ctx is NULL, the base mft record of @ni must not be mapped on
+ *	      entry and it will be left unmapped on return.
+ *	    - If @ctx is not NULL, the base mft record must be mapped on entry
+ *	      and it will be left mapped on return.
  */
 static inline s64 ntfs_cluster_free(ntfs_inode *ni, const VCN start_vcn,
-		s64 count)
+		s64 count, ntfs_attr_search_ctx *ctx)
 {
-	return __ntfs_cluster_free(ni, start_vcn, count, FALSE);
+	return __ntfs_cluster_free(ni, start_vcn, count, ctx, FALSE);
 }
 
 extern int ntfs_cluster_free_from_rl_nolock(ntfs_volume *vol,
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 15df34f..5577fc6 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1952,20 +1952,21 @@ restore_undo_alloc:
 		NVolSetErrors(vol);
 		return ret;
 	}
-	a = ctx->attr;
-	a->data.non_resident.highest_vcn = cpu_to_sle64(old_last_vcn - 1);
+	ctx->attr->data.non_resident.highest_vcn =
+			cpu_to_sle64(old_last_vcn - 1);
 undo_alloc:
-	if (ntfs_cluster_free(mft_ni, old_last_vcn, -1) < 0) {
+	if (ntfs_cluster_free(mft_ni, old_last_vcn, -1, ctx) < 0) {
 		ntfs_error(vol->sb, "Failed to free clusters from mft data "
 				"attribute.%s", es);
 		NVolSetErrors(vol);
 	}
+	a = ctx->attr;
 	if (ntfs_rl_truncate_nolock(vol, &mft_ni->runlist, old_last_vcn)) {
 		ntfs_error(vol->sb, "Failed to truncate mft data attribute "
 				"runlist.%s", es);
 		NVolSetErrors(vol);
 	}
-	if (mp_rebuilt) {
+	if (mp_rebuilt && !IS_ERR(ctx->mrec)) {
 		if (ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(
 				a->data.non_resident.mapping_pairs_offset),
 				old_alen - le16_to_cpu(
@@ -1982,6 +1983,10 @@ undo_alloc:
 		}
 		flush_dcache_mft_record_page(ctx->ntfs_ino);
 		mark_mft_record_dirty(ctx->ntfs_ino);
+	} else if (IS_ERR(ctx->mrec)) {
+		ntfs_error(vol->sb, "Failed to restore attribute search "
+				"context.%s", es);
+		NVolSetErrors(vol);
 	}
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
---
0.99.9
