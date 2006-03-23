Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWCWRaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWCWRaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWCWRaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:30:18 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:1443 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964917AbWCWRaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:30:15 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:30:11 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 13/14] NTFS: Semaphore to mutex conversion.
In-Reply-To: <Pine.LNX.4.64.0603231728310.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231729160.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231721240.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231722330.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231723320.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724200.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724570.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231725420.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231726250.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231727040.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231727450.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231728310.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

NTFS: Semaphore to mutex conversion.

The conversion was generated via scripts, and the result was validated
automatically via a script as well.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---


Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/ChangeLog  |    1 +
 fs/ntfs/aops.c     |    6 +++--
 fs/ntfs/compress.c |    4 ++-
 fs/ntfs/inode.c    |   10 ++++----
 fs/ntfs/inode.h    |   13 ++++++-----
 fs/ntfs/mft.c      |   62 ++++++++++++++++++++++++++--------------------------
 fs/ntfs/ntfs.h     |    2 +-
 fs/ntfs/super.c    |   42 ++++++++++++++++++-----------------
 8 files changed, 71 insertions(+), 69 deletions(-)

4e5e529ad684f1b3fba957f5dd4eb7c2b534ee92
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 9fb08ef..35cc4b1 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -43,6 +43,7 @@ ToDo/Notes:
 	  fs/ntfs/inode.c::ntfs_write_inode().
 	- Handle the recently introduced -ENAMETOOLONG return value from
 	  fs/ntfs/unistr.c::ntfs_nlstoucs() in fs/ntfs/namei.c::ntfs_lookup().
+	- Semaphore to mutex conversion.  (Ingo Molnar)
 
 2.1.26 - Minor bug fixes and updates.
 
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 1cf105b..580412d 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1278,18 +1278,18 @@ unm_done:
 		
 		tni = locked_nis[nr_locked_nis];
 		/* Get the base inode. */
-		down(&tni->extent_lock);
+		mutex_lock(&tni->extent_lock);
 		if (tni->nr_extents >= 0)
 			base_tni = tni;
 		else {
 			base_tni = tni->ext.base_ntfs_ino;
 			BUG_ON(!base_tni);
 		}
-		up(&tni->extent_lock);
+		mutex_unlock(&tni->extent_lock);
 		ntfs_debug("Unlocking %s inode 0x%lx.",
 				tni == base_tni ? "base" : "extent",
 				tni->mft_no);
-		up(&tni->mrec_lock);
+		mutex_unlock(&tni->mrec_lock);
 		atomic_dec(&tni->count);
 		iput(VFS_I(base_tni));
 	}
diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 25d2410..68a607f 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -67,7 +67,7 @@ static DEFINE_SPINLOCK(ntfs_cb_lock);
 /**
  * allocate_compression_buffers - allocate the decompression buffers
  *
- * Caller has to hold the ntfs_lock semaphore.
+ * Caller has to hold the ntfs_lock mutex.
  *
  * Return 0 on success or -ENOMEM if the allocations failed.
  */
@@ -84,7 +84,7 @@ int allocate_compression_buffers(void)
 /**
  * free_compression_buffers - free the decompression buffers
  *
- * Caller has to hold the ntfs_lock semaphore.
+ * Caller has to hold the ntfs_lock mutex.
  */
 void free_compression_buffers(void)
 {
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 73791b2..4c86b7e 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -388,7 +388,7 @@ void __ntfs_init_inode(struct super_bloc
 	atomic_set(&ni->count, 1);
 	ni->vol = NTFS_SB(sb);
 	ntfs_init_runlist(&ni->runlist);
-	init_MUTEX(&ni->mrec_lock);
+	mutex_init(&ni->mrec_lock);
 	ni->page = NULL;
 	ni->page_ofs = 0;
 	ni->attr_list_size = 0;
@@ -400,7 +400,7 @@ void __ntfs_init_inode(struct super_bloc
 	ni->itype.index.collation_rule = 0;
 	ni->itype.index.block_size_bits = 0;
 	ni->itype.index.vcn_size_bits = 0;
-	init_MUTEX(&ni->extent_lock);
+	mutex_init(&ni->extent_lock);
 	ni->nr_extents = 0;
 	ni->ext.base_ntfs_ino = NULL;
 }
@@ -3066,7 +3066,7 @@ int ntfs_write_inode(struct inode *vi, i
 	 */
 	if (modified) {
 		flush_dcache_mft_record_page(ctx->ntfs_ino);
-		if (!NInoTestSetDirty(ctx->ntfs_ino)) {
+		if (!NInoTestSetDirty(ctx->ntfs_ino))
 			mark_ntfs_record_dirty(ctx->ntfs_ino->page,
 					ctx->ntfs_ino->page_ofs);
 	}
@@ -3075,7 +3075,7 @@ int ntfs_write_inode(struct inode *vi, i
 	if (NInoDirty(ni))
 		err = write_mft_record(ni, m, sync);
 	/* Write all attached extent mft records. */
-	down(&ni->extent_lock);
+	mutex_lock(&ni->extent_lock);
 	if (ni->nr_extents > 0) {
 		ntfs_inode **extent_nis = ni->ext.extent_ntfs_inos;
 		int i;
@@ -3102,7 +3102,7 @@ int ntfs_write_inode(struct inode *vi, i
 			}
 		}
 	}
-	up(&ni->extent_lock);
+	mutex_unlock(&ni->extent_lock);
 	unmap_mft_record(ni);
 	if (unlikely(err))
 		goto err_out;
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index 3de5c02..f088291 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -24,12 +24,13 @@
 #ifndef _LINUX_NTFS_INODE_H
 #define _LINUX_NTFS_INODE_H
 
-#include <linux/mm.h>
+#include <asm/atomic.h>
+
 #include <linux/fs.h>
-#include <linux/seq_file.h>
 #include <linux/list.h>
-#include <asm/atomic.h>
-#include <asm/semaphore.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/seq_file.h>
 
 #include "layout.h"
 #include "volume.h"
@@ -81,7 +82,7 @@ struct _ntfs_inode {
 	 * The following fields are only valid for real inodes and extent
 	 * inodes.
 	 */
-	struct semaphore mrec_lock; /* Lock for serializing access to the
+	struct mutex mrec_lock;	/* Lock for serializing access to the
 				   mft record belonging to this inode. */
 	struct page *page;	/* The page containing the mft record of the
 				   inode. This should only be touched by the
@@ -119,7 +120,7 @@ struct _ntfs_inode {
 			u8 block_clusters;	/* Number of clusters per cb. */
 		} compressed;
 	} itype;
-	struct semaphore extent_lock;	/* Lock for accessing/modifying the
+	struct mutex extent_lock;	/* Lock for accessing/modifying the
 					   below . */
 	s32 nr_extents;	/* For a base mft record, the number of attached extent
 			   inodes (0 if none), for extent records and for fake
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index eb3eb14..4e72bc7 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -105,8 +105,8 @@ err_out:
  * map_mft_record - map, pin and lock an mft record
  * @ni:		ntfs inode whose MFT record to map
  *
- * First, take the mrec_lock semaphore. We might now be sleeping, while waiting
- * for the semaphore if it was already locked by someone else.
+ * First, take the mrec_lock mutex.  We might now be sleeping, while waiting
+ * for the mutex if it was already locked by someone else.
  *
  * The page of the record is mapped using map_mft_record_page() before being
  * returned to the caller.
@@ -136,9 +136,9 @@ err_out:
  * So that code will end up having to own the mrec_lock of all mft
  * records/inodes present in the page before I/O can proceed. In that case we
  * wouldn't need to bother with PG_locked and PG_uptodate as nobody will be
- * accessing anything without owning the mrec_lock semaphore. But we do need
- * to use them because of the read_cache_page() invocation and the code becomes
- * so much simpler this way that it is well worth it.
+ * accessing anything without owning the mrec_lock mutex.  But we do need to
+ * use them because of the read_cache_page() invocation and the code becomes so
+ * much simpler this way that it is well worth it.
  *
  * The mft record is now ours and we return a pointer to it. You need to check
  * the returned pointer with IS_ERR() and if that is true, PTR_ERR() will return
@@ -161,13 +161,13 @@ MFT_RECORD *map_mft_record(ntfs_inode *n
 	atomic_inc(&ni->count);
 
 	/* Serialize access to this mft record. */
-	down(&ni->mrec_lock);
+	mutex_lock(&ni->mrec_lock);
 
 	m = map_mft_record_page(ni);
 	if (likely(!IS_ERR(m)))
 		return m;
 
-	up(&ni->mrec_lock);
+	mutex_unlock(&ni->mrec_lock);
 	atomic_dec(&ni->count);
 	ntfs_error(ni->vol->sb, "Failed with error code %lu.", -PTR_ERR(m));
 	return m;
@@ -218,7 +218,7 @@ void unmap_mft_record(ntfs_inode *ni)
 	ntfs_debug("Entering for mft_no 0x%lx.", ni->mft_no);
 
 	unmap_mft_record_page(ni);
-	up(&ni->mrec_lock);
+	mutex_unlock(&ni->mrec_lock);
 	atomic_dec(&ni->count);
 	/*
 	 * If pure ntfs_inode, i.e. no vfs inode attached, we leave it to
@@ -262,7 +262,7 @@ MFT_RECORD *map_extent_mft_record(ntfs_i
 	 * in which case just return it. If not found, add it to the base
 	 * inode before returning it.
 	 */
-	down(&base_ni->extent_lock);
+	mutex_lock(&base_ni->extent_lock);
 	if (base_ni->nr_extents > 0) {
 		extent_nis = base_ni->ext.extent_ntfs_inos;
 		for (i = 0; i < base_ni->nr_extents; i++) {
@@ -275,7 +275,7 @@ MFT_RECORD *map_extent_mft_record(ntfs_i
 		}
 	}
 	if (likely(ni != NULL)) {
-		up(&base_ni->extent_lock);
+		mutex_unlock(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
 		/* We found the record; just have to map and return it. */
 		m = map_mft_record(ni);
@@ -302,7 +302,7 @@ map_err_out:
 	/* Record wasn't there. Get a new ntfs inode and initialize it. */
 	ni = ntfs_new_extent_inode(base_ni->vol->sb, mft_no);
 	if (unlikely(!ni)) {
-		up(&base_ni->extent_lock);
+		mutex_unlock(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -313,7 +313,7 @@ map_err_out:
 	/* Now map the record. */
 	m = map_mft_record(ni);
 	if (IS_ERR(m)) {
-		up(&base_ni->extent_lock);
+		mutex_unlock(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
 		ntfs_clear_extent_inode(ni);
 		goto map_err_out;
@@ -348,14 +348,14 @@ map_err_out:
 		base_ni->ext.extent_ntfs_inos = tmp;
 	}
 	base_ni->ext.extent_ntfs_inos[base_ni->nr_extents++] = ni;
-	up(&base_ni->extent_lock);
+	mutex_unlock(&base_ni->extent_lock);
 	atomic_dec(&base_ni->count);
 	ntfs_debug("Done 2.");
 	*ntfs_ino = ni;
 	return m;
 unm_err_out:
 	unmap_mft_record(ni);
-	up(&base_ni->extent_lock);
+	mutex_unlock(&base_ni->extent_lock);
 	atomic_dec(&base_ni->count);
 	/*
 	 * If the extent inode was not attached to the base inode we need to
@@ -400,12 +400,12 @@ void __mark_mft_record_dirty(ntfs_inode 
 	BUG_ON(NInoAttr(ni));
 	mark_ntfs_record_dirty(ni->page, ni->page_ofs);
 	/* Determine the base vfs inode and mark it dirty, too. */
-	down(&ni->extent_lock);
+	mutex_lock(&ni->extent_lock);
 	if (likely(ni->nr_extents >= 0))
 		base_ni = ni;
 	else
 		base_ni = ni->ext.base_ntfs_ino;
-	up(&ni->extent_lock);
+	mutex_unlock(&ni->extent_lock);
 	__mark_inode_dirty(VFS_I(base_ni), I_DIRTY_SYNC | I_DIRTY_DATASYNC);
 }
 
@@ -981,7 +981,7 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 		}
 		ntfs_debug("Inode 0x%lx is not dirty.", mft_no);
 		/* The inode is not dirty, try to take the mft record lock. */
-		if (unlikely(down_trylock(&ni->mrec_lock))) {
+		if (unlikely(!mutex_trylock(&ni->mrec_lock))) {
 			ntfs_debug("Mft record 0x%lx is already locked, do "
 					"not write it.", mft_no);
 			atomic_dec(&ni->count);
@@ -1041,13 +1041,13 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 	 * corresponding to this extent mft record attached.
 	 */
 	ni = NTFS_I(vi);
-	down(&ni->extent_lock);
+	mutex_lock(&ni->extent_lock);
 	if (ni->nr_extents <= 0) {
 		/*
 		 * The base inode has no attached extent inodes, write this
 		 * extent mft record.
 		 */
-		up(&ni->extent_lock);
+		mutex_unlock(&ni->extent_lock);
 		iput(vi);
 		ntfs_debug("Base inode 0x%lx has no attached extent inodes, "
 				"write the extent record.", na.mft_no);
@@ -1070,7 +1070,7 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 	 * extent mft record.
 	 */
 	if (!eni) {
-		up(&ni->extent_lock);
+		mutex_unlock(&ni->extent_lock);
 		iput(vi);
 		ntfs_debug("Extent inode 0x%lx is not attached to its base "
 				"inode 0x%lx, write the extent record.",
@@ -1081,12 +1081,12 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 			mft_no, na.mft_no);
 	/* Take a reference to the extent ntfs inode. */
 	atomic_inc(&eni->count);
-	up(&ni->extent_lock);
+	mutex_unlock(&ni->extent_lock);
 	/*
 	 * Found the extent inode coresponding to this extent mft record.
 	 * Try to take the mft record lock.
 	 */
-	if (unlikely(down_trylock(&eni->mrec_lock))) {
+	if (unlikely(!mutex_trylock(&eni->mrec_lock))) {
 		atomic_dec(&eni->count);
 		iput(vi);
 		ntfs_debug("Extent mft record 0x%lx is already locked, do "
@@ -2709,7 +2709,7 @@ mft_rec_already_initialized:
 		 * have its page mapped and it is very easy to do.
 		 */
 		atomic_inc(&ni->count);
-		down(&ni->mrec_lock);
+		mutex_lock(&ni->mrec_lock);
 		ni->page = page;
 		ni->page_ofs = ofs;
 		/*
@@ -2796,22 +2796,22 @@ int ntfs_extent_mft_record_free(ntfs_ino
 	BUG_ON(NInoAttr(ni));
 	BUG_ON(ni->nr_extents != -1);
 
-	down(&ni->extent_lock);
+	mutex_lock(&ni->extent_lock);
 	base_ni = ni->ext.base_ntfs_ino;
-	up(&ni->extent_lock);
+	mutex_unlock(&ni->extent_lock);
 
 	BUG_ON(base_ni->nr_extents <= 0);
 
 	ntfs_debug("Entering for extent inode 0x%lx, base inode 0x%lx.\n",
 			mft_no, base_ni->mft_no);
 
-	down(&base_ni->extent_lock);
+	mutex_lock(&base_ni->extent_lock);
 
 	/* Make sure we are holding the only reference to the extent inode. */
 	if (atomic_read(&ni->count) > 2) {
 		ntfs_error(vol->sb, "Tried to free busy extent inode 0x%lx, "
 				"not freeing.", base_ni->mft_no);
-		up(&base_ni->extent_lock);
+		mutex_unlock(&base_ni->extent_lock);
 		return -EBUSY;
 	}
 
@@ -2829,7 +2829,7 @@ int ntfs_extent_mft_record_free(ntfs_ino
 		break;
 	}
 
-	up(&base_ni->extent_lock);
+	mutex_unlock(&base_ni->extent_lock);
 
 	if (unlikely(err)) {
 		ntfs_error(vol->sb, "Extent inode 0x%lx is not attached to "
@@ -2888,7 +2888,7 @@ rollback_error:
 	return 0;
 rollback:
 	/* Rollback what we did... */
-	down(&base_ni->extent_lock);
+	mutex_lock(&base_ni->extent_lock);
 	extent_nis = base_ni->ext.extent_ntfs_inos;
 	if (!(base_ni->nr_extents & 3)) {
 		int new_size = (base_ni->nr_extents + 4) * sizeof(ntfs_inode*);
@@ -2897,7 +2897,7 @@ rollback:
 		if (unlikely(!extent_nis)) {
 			ntfs_error(vol->sb, "Failed to allocate internal "
 					"buffer during rollback.%s", es);
-			up(&base_ni->extent_lock);
+			mutex_unlock(&base_ni->extent_lock);
 			NVolSetErrors(vol);
 			goto rollback_error;
 		}
@@ -2912,7 +2912,7 @@ rollback:
 	m->flags |= MFT_RECORD_IN_USE;
 	m->sequence_number = old_seq_no;
 	extent_nis[base_ni->nr_extents++] = ni;
-	up(&base_ni->extent_lock);
+	mutex_unlock(&base_ni->extent_lock);
 	mark_mft_record_dirty(ni);
 	return err;
 }
diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
index 653d2a5..0624c8e 100644
--- a/fs/ntfs/ntfs.h
+++ b/fs/ntfs/ntfs.h
@@ -91,7 +91,7 @@ extern void free_compression_buffers(voi
 
 /* From fs/ntfs/super.c */
 #define default_upcase_len 0x10000
-extern struct semaphore ntfs_lock;
+extern struct mutex ntfs_lock;
 
 typedef struct {
 	int val;
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index fd4aecc..6816eda 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1677,11 +1677,11 @@ read_partial_upcase_page:
 	ntfs_debug("Read %llu bytes from $UpCase (expected %zu bytes).",
 			i_size, 64 * 1024 * sizeof(ntfschar));
 	iput(ino);
-	down(&ntfs_lock);
+	mutex_lock(&ntfs_lock);
 	if (!default_upcase) {
 		ntfs_debug("Using volume specified $UpCase since default is "
 				"not present.");
-		up(&ntfs_lock);
+		mutex_unlock(&ntfs_lock);
 		return TRUE;
 	}
 	max = default_upcase_len;
@@ -1695,12 +1695,12 @@ read_partial_upcase_page:
 		vol->upcase = default_upcase;
 		vol->upcase_len = max;
 		ntfs_nr_upcase_users++;
-		up(&ntfs_lock);
+		mutex_unlock(&ntfs_lock);
 		ntfs_debug("Volume specified $UpCase matches default. Using "
 				"default.");
 		return TRUE;
 	}
-	up(&ntfs_lock);
+	mutex_unlock(&ntfs_lock);
 	ntfs_debug("Using volume specified $UpCase since it does not match "
 			"the default.");
 	return TRUE;
@@ -1709,17 +1709,17 @@ iput_upcase_failed:
 	ntfs_free(vol->upcase);
 	vol->upcase = NULL;
 upcase_failed:
-	down(&ntfs_lock);
+	mutex_lock(&ntfs_lock);
 	if (default_upcase) {
 		vol->upcase = default_upcase;
 		vol->upcase_len = default_upcase_len;
 		ntfs_nr_upcase_users++;
-		up(&ntfs_lock);
+		mutex_unlock(&ntfs_lock);
 		ntfs_error(sb, "Failed to load $UpCase from the volume. Using "
 				"default.");
 		return TRUE;
 	}
-	up(&ntfs_lock);
+	mutex_unlock(&ntfs_lock);
 	ntfs_error(sb, "Failed to initialize upcase table.");
 	return FALSE;
 }
@@ -2195,12 +2195,12 @@ iput_attrdef_err_out:
 iput_upcase_err_out:
 #endif /* NTFS_RW */
 	vol->upcase_len = 0;
-	down(&ntfs_lock);
+	mutex_lock(&ntfs_lock);
 	if (vol->upcase == default_upcase) {
 		ntfs_nr_upcase_users--;
 		vol->upcase = NULL;
 	}
-	up(&ntfs_lock);
+	mutex_unlock(&ntfs_lock);
 	if (vol->upcase) {
 		ntfs_free(vol->upcase);
 		vol->upcase = NULL;
@@ -2405,7 +2405,7 @@ static void ntfs_put_super(struct super_
 	 * Destroy the global default upcase table if necessary.  Also decrease
 	 * the number of upcase users if we are a user.
 	 */
-	down(&ntfs_lock);
+	mutex_lock(&ntfs_lock);
 	if (vol->upcase == default_upcase) {
 		ntfs_nr_upcase_users--;
 		vol->upcase = NULL;
@@ -2416,7 +2416,7 @@ static void ntfs_put_super(struct super_
 	}
 	if (vol->cluster_size <= 4096 && !--ntfs_nr_compression_users)
 		free_compression_buffers();
-	up(&ntfs_lock);
+	mutex_unlock(&ntfs_lock);
 	if (vol->upcase) {
 		ntfs_free(vol->upcase);
 		vol->upcase = NULL;
@@ -2890,7 +2890,7 @@ static int ntfs_fill_super(struct super_
 			ntfs_error(sb, "Failed to load essential metadata.");
 		goto iput_tmp_ino_err_out_now;
 	}
-	down(&ntfs_lock);
+	mutex_lock(&ntfs_lock);
 	/*
 	 * The current mount is a compression user if the cluster size is
 	 * less than or equal 4kiB.
@@ -2901,7 +2901,7 @@ static int ntfs_fill_super(struct super_
 			ntfs_error(NULL, "Failed to allocate buffers "
 					"for compression engine.");
 			ntfs_nr_compression_users--;
-			up(&ntfs_lock);
+			mutex_unlock(&ntfs_lock);
 			goto iput_tmp_ino_err_out_now;
 		}
 	}
@@ -2913,7 +2913,7 @@ static int ntfs_fill_super(struct super_
 	if (!default_upcase)
 		default_upcase = generate_default_upcase();
 	ntfs_nr_upcase_users++;
-	up(&ntfs_lock);
+	mutex_unlock(&ntfs_lock);
 	/*
 	 * From now on, ignore @silent parameter. If we fail below this line,
 	 * it will be due to a corrupt fs or a system error, so we report it.
@@ -2931,12 +2931,12 @@ static int ntfs_fill_super(struct super_
 		atomic_inc(&vol->root_ino->i_count);
 		ntfs_debug("Exiting, status successful.");
 		/* Release the default upcase if it has no users. */
-		down(&ntfs_lock);
+		mutex_lock(&ntfs_lock);
 		if (!--ntfs_nr_upcase_users && default_upcase) {
 			ntfs_free(default_upcase);
 			default_upcase = NULL;
 		}
-		up(&ntfs_lock);
+		mutex_unlock(&ntfs_lock);
 		sb->s_export_op = &ntfs_export_ops;
 		lock_kernel();
 		return 0;
@@ -3004,12 +3004,12 @@ static int ntfs_fill_super(struct super_
 		vol->attrdef = NULL;
 	}
 	vol->upcase_len = 0;
-	down(&ntfs_lock);
+	mutex_lock(&ntfs_lock);
 	if (vol->upcase == default_upcase) {
 		ntfs_nr_upcase_users--;
 		vol->upcase = NULL;
 	}
-	up(&ntfs_lock);
+	mutex_unlock(&ntfs_lock);
 	if (vol->upcase) {
 		ntfs_free(vol->upcase);
 		vol->upcase = NULL;
@@ -3024,14 +3024,14 @@ unl_upcase_iput_tmp_ino_err_out_now:
 	 * Decrease the number of upcase users and destroy the global default
 	 * upcase table if necessary.
 	 */
-	down(&ntfs_lock);
+	mutex_lock(&ntfs_lock);
 	if (!--ntfs_nr_upcase_users && default_upcase) {
 		ntfs_free(default_upcase);
 		default_upcase = NULL;
 	}
 	if (vol->cluster_size <= 4096 && !--ntfs_nr_compression_users)
 		free_compression_buffers();
-	up(&ntfs_lock);
+	mutex_unlock(&ntfs_lock);
 iput_tmp_ino_err_out_now:
 	iput(tmp_ino);
 	if (vol->mft_ino && vol->mft_ino != tmp_ino)
@@ -3091,7 +3091,7 @@ struct kmem_cache *ntfs_attr_ctx_cache;
 struct kmem_cache *ntfs_index_ctx_cache;
 
 /* Driver wide semaphore. */
-DECLARE_MUTEX(ntfs_lock);
+DEFINE_MUTEX(ntfs_lock);
 
 static struct super_block *ntfs_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
-- 
1.2.3.g9821

