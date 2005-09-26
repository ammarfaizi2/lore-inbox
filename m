Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVIZNdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVIZNdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 09:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVIZNdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 09:33:11 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:40940 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932115AbVIZNdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 09:33:09 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 26 Sep 2005 14:33:03 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 2/4] NTFS: Change ntfs_cluster_free() to require a write
 locked runlist on entry
In-Reply-To: <Pine.LNX.4.60.0509261431270.32257@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509261432170.32257@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509261427520.32257@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0509261431270.32257@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Change ntfs_cluster_free() to require a write locked runlist on entry
      since we otherwise get into a lock reversal deadlock if a read locked
      runlist is passed in. In the process also change it to take an ntfs
      inode instead of a vfs inode as parameter.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog  |    4 ++++
 fs/ntfs/Makefile   |    2 +-
 fs/ntfs/lcnalloc.c |   31 +++++++++++++------------------
 fs/ntfs/lcnalloc.h |   27 +++++++++++++--------------
 fs/ntfs/mft.c      |    2 +-
 5 files changed, 32 insertions(+), 34 deletions(-)

715dc636b64b57aee7aee7e8b5bf4f5267a6df48
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -25,6 +25,10 @@ ToDo/Notes:
 2.1.25-WIP
 
 	- Fix sparse warnings that have crept in over time.
+	- Change ntfs_cluster_free() to require a write locked runlist on entry
+	  since we otherwise get into a lock reversal deadlock if a read locked
+	  runlist is passed in. In the process also change it to take an ntfs
+	  inode instead of a vfs inode as parameter.
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile
+++ b/fs/ntfs/Makefile
@@ -6,7 +6,7 @@ ntfs-objs := aops.o attrib.o collate.o c
 	     index.o inode.o mft.o mst.o namei.o runlist.o super.o sysctl.o \
 	     unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.24\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.25-WIP\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
--- a/fs/ntfs/lcnalloc.c
+++ b/fs/ntfs/lcnalloc.c
@@ -779,14 +779,13 @@ out:
 
 /**
  * __ntfs_cluster_free - free clusters on an ntfs volume
- * @vi:		vfs inode whose runlist describes the clusters to free
- * @start_vcn:	vcn in the runlist of @vi at which to start freeing clusters
+ * @ni:		ntfs inode whose runlist describes the clusters to free
+ * @start_vcn:	vcn in the runlist of @ni at which to start freeing clusters
  * @count:	number of clusters to free or -1 for all clusters
- * @write_locked:	true if the runlist is locked for writing
  * @is_rollback:	true if this is a rollback operation
  *
  * Free @count clusters starting at the cluster @start_vcn in the runlist
- * described by the vfs inode @vi.
+ * described by the vfs inode @ni.
  *
  * If @count is -1, all clusters from @start_vcn to the end of the runlist are
  * deallocated.  Thus, to completely free all clusters in a runlist, use
@@ -801,31 +800,28 @@ out:
  * Return the number of deallocated clusters (not counting sparse ones) on
  * success and -errno on error.
  *
- * Locking: - The runlist described by @vi must be locked on entry and is
- *	      locked on return.  Note if the runlist is locked for reading the
- *	      lock may be dropped and reacquired.  Note the runlist may be
- *	      modified when needed runlist fragments need to be mapped.
+ * Locking: - The runlist described by @ni must be locked for writing on entry
+ *	      and is locked on return.  Note the runlist may be modified when
+ *	      needed runlist fragments need to be mapped.
  *	    - The volume lcn bitmap must be unlocked on entry and is unlocked
  *	      on return.
  *	    - This function takes the volume lcn bitmap lock for writing and
  *	      modifies the bitmap contents.
  */
-s64 __ntfs_cluster_free(struct inode *vi, const VCN start_vcn, s64 count,
-		const BOOL write_locked, const BOOL is_rollback)
+s64 __ntfs_cluster_free(ntfs_inode *ni, const VCN start_vcn, s64 count,
+		const BOOL is_rollback)
 {
 	s64 delta, to_free, total_freed, real_freed;
-	ntfs_inode *ni;
 	ntfs_volume *vol;
 	struct inode *lcnbmp_vi;
 	runlist_element *rl;
 	int err;
 
-	BUG_ON(!vi);
+	BUG_ON(!ni);
 	ntfs_debug("Entering for i_ino 0x%lx, start_vcn 0x%llx, count "
-			"0x%llx.%s", vi->i_ino, (unsigned long long)start_vcn,
+			"0x%llx.%s", ni->mft_no, (unsigned long long)start_vcn,
 			(unsigned long long)count,
 			is_rollback ? " (rollback)" : "");
-	ni = NTFS_I(vi);
 	vol = ni->vol;
 	lcnbmp_vi = vol->lcnbmp_ino;
 	BUG_ON(!lcnbmp_vi);
@@ -843,7 +839,7 @@ s64 __ntfs_cluster_free(struct inode *vi
 
 	total_freed = real_freed = 0;
 
-	rl = ntfs_attr_find_vcn_nolock(ni, start_vcn, write_locked);
+	rl = ntfs_attr_find_vcn_nolock(ni, start_vcn, TRUE);
 	if (IS_ERR(rl)) {
 		if (!is_rollback)
 			ntfs_error(vol->sb, "Failed to find first runlist "
@@ -897,7 +893,7 @@ s64 __ntfs_cluster_free(struct inode *vi
 
 			/* Attempt to map runlist. */
 			vcn = rl->vcn;
-			rl = ntfs_attr_find_vcn_nolock(ni, vcn, write_locked);
+			rl = ntfs_attr_find_vcn_nolock(ni, vcn, TRUE);
 			if (IS_ERR(rl)) {
 				err = PTR_ERR(rl);
 				if (!is_rollback)
@@ -965,8 +961,7 @@ err_out:
 	 * If rollback fails, set the volume errors flag, emit an error
 	 * message, and return the error code.
 	 */
-	delta = __ntfs_cluster_free(vi, start_vcn, total_freed, write_locked,
-			TRUE);
+	delta = __ntfs_cluster_free(ni, start_vcn, total_freed, TRUE);
 	if (delta < 0) {
 		ntfs_error(vol->sb, "Failed to rollback (error %i).  Leaving "
 				"inconsistent metadata!  Unmount and run "
diff --git a/fs/ntfs/lcnalloc.h b/fs/ntfs/lcnalloc.h
--- a/fs/ntfs/lcnalloc.h
+++ b/fs/ntfs/lcnalloc.h
@@ -2,7 +2,7 @@
  * lcnalloc.h - Exports for NTFS kernel cluster (de)allocation.  Part of the
  *		Linux-NTFS project.
  *
- * Copyright (c) 2004 Anton Altaparmakov
+ * Copyright (c) 2004-2005 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 
 #include "types.h"
+#include "inode.h"
 #include "runlist.h"
 #include "volume.h"
 
@@ -42,18 +43,17 @@ extern runlist_element *ntfs_cluster_all
 		const VCN start_vcn, const s64 count, const LCN start_lcn,
 		const NTFS_CLUSTER_ALLOCATION_ZONES zone);
 
-extern s64 __ntfs_cluster_free(struct inode *vi, const VCN start_vcn,
-		s64 count, const BOOL write_locked, const BOOL is_rollback);
+extern s64 __ntfs_cluster_free(ntfs_inode *ni, const VCN start_vcn,
+		s64 count, const BOOL is_rollback);
 
 /**
  * ntfs_cluster_free - free clusters on an ntfs volume
- * @vi:		vfs inode whose runlist describes the clusters to free
- * @start_vcn:	vcn in the runlist of @vi at which to start freeing clusters
+ * @ni:		ntfs inode whose runlist describes the clusters to free
+ * @start_vcn:	vcn in the runlist of @ni at which to start freeing clusters
  * @count:	number of clusters to free or -1 for all clusters
- * @write_locked:	true if the runlist is locked for writing
  *
  * Free @count clusters starting at the cluster @start_vcn in the runlist
- * described by the vfs inode @vi.
+ * described by the ntfs inode @ni.
  *
  * If @count is -1, all clusters from @start_vcn to the end of the runlist are
  * deallocated.  Thus, to completely free all clusters in a runlist, use
@@ -65,19 +65,18 @@ extern s64 __ntfs_cluster_free(struct in
  * Return the number of deallocated clusters (not counting sparse ones) on
  * success and -errno on error.
  *
- * Locking: - The runlist described by @vi must be locked on entry and is
- *	      locked on return.  Note if the runlist is locked for reading the
- *	      lock may be dropped and reacquired.  Note the runlist may be
- *	      modified when needed runlist fragments need to be mapped.
+ * Locking: - The runlist described by @ni must be locked for writing on entry
+ *	      and is locked on return.  Note the runlist may be modified when
+ *	      needed runlist fragments need to be mapped.
  *	    - The volume lcn bitmap must be unlocked on entry and is unlocked
  *	      on return.
  *	    - This function takes the volume lcn bitmap lock for writing and
  *	      modifies the bitmap contents.
  */
-static inline s64 ntfs_cluster_free(struct inode *vi, const VCN start_vcn,
-		s64 count, const BOOL write_locked)
+static inline s64 ntfs_cluster_free(ntfs_inode *ni, const VCN start_vcn,
+		s64 count)
 {
-	return __ntfs_cluster_free(vi, start_vcn, count, write_locked, FALSE);
+	return __ntfs_cluster_free(ni, start_vcn, count, FALSE);
 }
 
 extern int ntfs_cluster_free_from_rl_nolock(ntfs_volume *vol,
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1953,7 +1953,7 @@ restore_undo_alloc:
 	a = ctx->attr;
 	a->data.non_resident.highest_vcn = cpu_to_sle64(old_last_vcn - 1);
 undo_alloc:
-	if (ntfs_cluster_free(vol->mft_ino, old_last_vcn, -1, TRUE) < 0) {
+	if (ntfs_cluster_free(mft_ni, old_last_vcn, -1) < 0) {
 		ntfs_error(vol->sb, "Failed to free clusters from mft data "
 				"attribute.%s", es);
 		NVolSetErrors(vol);
