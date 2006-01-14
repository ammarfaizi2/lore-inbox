Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWANO5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWANO5y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWANO5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:57:54 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:28367 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751758AbWANO5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:57:53 -0500
Date: Sat, 14 Jan 2006 15:58:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       aia21@cantab.net
Subject: [patch 2.6.15-mm4] sem2mutex: NTFS
Message-ID: <20060114145804.GA21978@elte.hu>
References: <20060114142633.GA17012@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114142633.GA17012@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build and boot tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 fs/ntfs/aops.c     |    6 ++---
 fs/ntfs/compress.c |    4 +--
 fs/ntfs/inode.c    |    8 +++----
 fs/ntfs/inode.h    |    6 ++---
 fs/ntfs/mft.c      |   58 ++++++++++++++++++++++++++---------------------------
 fs/ntfs/ntfs.h     |    2 -
 fs/ntfs/super.c    |   42 +++++++++++++++++++-------------------
 7 files changed, 63 insertions(+), 63 deletions(-)

Index: linux/fs/ntfs/aops.c
===================================================================
--- linux.orig/fs/ntfs/aops.c
+++ linux/fs/ntfs/aops.c
@@ -1279,18 +1279,18 @@ unm_done:
 		
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
Index: linux/fs/ntfs/compress.c
===================================================================
--- linux.orig/fs/ntfs/compress.c
+++ linux/fs/ntfs/compress.c
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
Index: linux/fs/ntfs/inode.c
===================================================================
--- linux.orig/fs/ntfs/inode.c
+++ linux/fs/ntfs/inode.c
@@ -382,7 +382,7 @@ void __ntfs_init_inode(struct super_bloc
 	atomic_set(&ni->count, 1);
 	ni->vol = NTFS_SB(sb);
 	ntfs_init_runlist(&ni->runlist);
-	init_MUTEX(&ni->mrec_lock);
+	mutex_init(&ni->mrec_lock);
 	ni->page = NULL;
 	ni->page_ofs = 0;
 	ni->attr_list_size = 0;
@@ -394,7 +394,7 @@ void __ntfs_init_inode(struct super_bloc
 	ni->itype.index.collation_rule = 0;
 	ni->itype.index.block_size_bits = 0;
 	ni->itype.index.vcn_size_bits = 0;
-	init_MUTEX(&ni->extent_lock);
+	mutex_init(&ni->extent_lock);
 	ni->nr_extents = 0;
 	ni->ext.base_ntfs_ino = NULL;
 }
@@ -3023,7 +3023,7 @@ int ntfs_write_inode(struct inode *vi, i
 	if (NInoDirty(ni))
 		err = write_mft_record(ni, m, sync);
 	/* Write all attached extent mft records. */
-	down(&ni->extent_lock);
+	mutex_lock(&ni->extent_lock);
 	if (ni->nr_extents > 0) {
 		ntfs_inode **extent_nis = ni->ext.extent_ntfs_inos;
 		int i;
@@ -3050,7 +3050,7 @@ int ntfs_write_inode(struct inode *vi, i
 			}
 		}
 	}
-	up(&ni->extent_lock);
+	mutex_unlock(&ni->extent_lock);
 	unmap_mft_record(ni);
 	if (unlikely(err))
 		goto err_out;
Index: linux/fs/ntfs/inode.h
===================================================================
--- linux.orig/fs/ntfs/inode.h
+++ linux/fs/ntfs/inode.h
@@ -29,7 +29,7 @@
 #include <linux/seq_file.h>
 #include <linux/list.h>
 #include <asm/atomic.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 #include "layout.h"
 #include "volume.h"
@@ -81,7 +81,7 @@ struct _ntfs_inode {
 	 * The following fields are only valid for real inodes and extent
 	 * inodes.
 	 */
-	struct semaphore mrec_lock; /* Lock for serializing access to the
+	struct mutex mrec_lock; /* Lock for serializing access to the
 				   mft record belonging to this inode. */
 	struct page *page;	/* The page containing the mft record of the
 				   inode. This should only be touched by the
@@ -119,7 +119,7 @@ struct _ntfs_inode {
 			u8 block_clusters;	/* Number of clusters per cb. */
 		} compressed;
 	} itype;
-	struct semaphore extent_lock;	/* Lock for accessing/modifying the
+	struct mutex extent_lock;	/* Lock for accessing/modifying the
 					   below . */
 	s32 nr_extents;	/* For a base mft record, the number of attached extent
 			   inodes (0 if none), for extent records and for fake
Index: linux/fs/ntfs/mft.c
===================================================================
--- linux.orig/fs/ntfs/mft.c
+++ linux/fs/ntfs/mft.c
@@ -104,8 +104,8 @@ err_out:
  * map_mft_record - map, pin and lock an mft record
  * @ni:		ntfs inode whose MFT record to map
  *
- * First, take the mrec_lock semaphore. We might now be sleeping, while waiting
- * for the semaphore if it was already locked by someone else.
+ * First, take the mrec_lock mutex. We might now be sleeping, while waiting
+ * for the mutex if it was already locked by someone else.
  *
  * The page of the record is mapped using map_mft_record_page() before being
  * returned to the caller.
@@ -135,7 +135,7 @@ err_out:
  * So that code will end up having to own the mrec_lock of all mft
  * records/inodes present in the page before I/O can proceed. In that case we
  * wouldn't need to bother with PG_locked and PG_uptodate as nobody will be
- * accessing anything without owning the mrec_lock semaphore. But we do need
+ * accessing anything without owning the mrec_lock mutex. But we do need
  * to use them because of the read_cache_page() invocation and the code becomes
  * so much simpler this way that it is well worth it.
  *
@@ -160,13 +160,13 @@ MFT_RECORD *map_mft_record(ntfs_inode *n
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
@@ -217,7 +217,7 @@ void unmap_mft_record(ntfs_inode *ni)
 	ntfs_debug("Entering for mft_no 0x%lx.", ni->mft_no);
 
 	unmap_mft_record_page(ni);
-	up(&ni->mrec_lock);
+	mutex_unlock(&ni->mrec_lock);
 	atomic_dec(&ni->count);
 	/*
 	 * If pure ntfs_inode, i.e. no vfs inode attached, we leave it to
@@ -261,7 +261,7 @@ MFT_RECORD *map_extent_mft_record(ntfs_i
 	 * in which case just return it. If not found, add it to the base
 	 * inode before returning it.
 	 */
-	down(&base_ni->extent_lock);
+	mutex_lock(&base_ni->extent_lock);
 	if (base_ni->nr_extents > 0) {
 		extent_nis = base_ni->ext.extent_ntfs_inos;
 		for (i = 0; i < base_ni->nr_extents; i++) {
@@ -274,7 +274,7 @@ MFT_RECORD *map_extent_mft_record(ntfs_i
 		}
 	}
 	if (likely(ni != NULL)) {
-		up(&base_ni->extent_lock);
+		mutex_unlock(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
 		/* We found the record; just have to map and return it. */
 		m = map_mft_record(ni);
@@ -301,7 +301,7 @@ map_err_out:
 	/* Record wasn't there. Get a new ntfs inode and initialize it. */
 	ni = ntfs_new_extent_inode(base_ni->vol->sb, mft_no);
 	if (unlikely(!ni)) {
-		up(&base_ni->extent_lock);
+		mutex_unlock(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -312,7 +312,7 @@ map_err_out:
 	/* Now map the record. */
 	m = map_mft_record(ni);
 	if (IS_ERR(m)) {
-		up(&base_ni->extent_lock);
+		mutex_unlock(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
 		ntfs_clear_extent_inode(ni);
 		goto map_err_out;
@@ -347,14 +347,14 @@ map_err_out:
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
@@ -399,12 +399,12 @@ void __mark_mft_record_dirty(ntfs_inode 
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
 
@@ -983,7 +983,7 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 		}
 		ntfs_debug("Inode 0x%lx is not dirty.", mft_no);
 		/* The inode is not dirty, try to take the mft record lock. */
-		if (unlikely(down_trylock(&ni->mrec_lock))) {
+		if (unlikely(!mutex_trylock(&ni->mrec_lock))) {
 			ntfs_debug("Mft record 0x%lx is already locked, do "
 					"not write it.", mft_no);
 			atomic_dec(&ni->count);
@@ -1043,13 +1043,13 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
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
@@ -1072,7 +1072,7 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 	 * extent mft record.
 	 */
 	if (!eni) {
-		up(&ni->extent_lock);
+		mutex_unlock(&ni->extent_lock);
 		iput(vi);
 		ntfs_debug("Extent inode 0x%lx is not attached to its base "
 				"inode 0x%lx, write the extent record.",
@@ -1083,12 +1083,12 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
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
@@ -2711,7 +2711,7 @@ mft_rec_already_initialized:
 		 * have its page mapped and it is very easy to do.
 		 */
 		atomic_inc(&ni->count);
-		down(&ni->mrec_lock);
+		mutex_lock(&ni->mrec_lock);
 		ni->page = page;
 		ni->page_ofs = ofs;
 		/*
@@ -2798,22 +2798,22 @@ int ntfs_extent_mft_record_free(ntfs_ino
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
 
@@ -2831,7 +2831,7 @@ int ntfs_extent_mft_record_free(ntfs_ino
 		break;
 	}
 
-	up(&base_ni->extent_lock);
+	mutex_unlock(&base_ni->extent_lock);
 
 	if (unlikely(err)) {
 		ntfs_error(vol->sb, "Extent inode 0x%lx is not attached to "
@@ -2890,7 +2890,7 @@ rollback_error:
 	return 0;
 rollback:
 	/* Rollback what we did... */
-	down(&base_ni->extent_lock);
+	mutex_lock(&base_ni->extent_lock);
 	extent_nis = base_ni->ext.extent_ntfs_inos;
 	if (!(base_ni->nr_extents & 3)) {
 		int new_size = (base_ni->nr_extents + 4) * sizeof(ntfs_inode*);
@@ -2899,7 +2899,7 @@ rollback:
 		if (unlikely(!extent_nis)) {
 			ntfs_error(vol->sb, "Failed to allocate internal "
 					"buffer during rollback.%s", es);
-			up(&base_ni->extent_lock);
+			mutex_unlock(&base_ni->extent_lock);
 			NVolSetErrors(vol);
 			goto rollback_error;
 		}
@@ -2914,7 +2914,7 @@ rollback:
 	m->flags |= MFT_RECORD_IN_USE;
 	m->sequence_number = old_seq_no;
 	extent_nis[base_ni->nr_extents++] = ni;
-	up(&base_ni->extent_lock);
+	mutex_unlock(&base_ni->extent_lock);
 	mark_mft_record_dirty(ni);
 	return err;
 }
Index: linux/fs/ntfs/ntfs.h
===================================================================
--- linux.orig/fs/ntfs/ntfs.h
+++ linux/fs/ntfs/ntfs.h
@@ -91,7 +91,7 @@ extern void free_compression_buffers(voi
 
 /* From fs/ntfs/super.c */
 #define default_upcase_len 0x10000
-extern struct semaphore ntfs_lock;
+extern struct mutex ntfs_lock;
 
 typedef struct {
 	int val;
Index: linux/fs/ntfs/super.c
===================================================================
--- linux.orig/fs/ntfs/super.c
+++ linux/fs/ntfs/super.c
@@ -1635,11 +1635,11 @@ read_partial_upcase_page:
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
@@ -1653,12 +1653,12 @@ read_partial_upcase_page:
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
@@ -1667,17 +1667,17 @@ iput_upcase_failed:
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
@@ -2140,12 +2140,12 @@ iput_attrdef_err_out:
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
@@ -2350,7 +2350,7 @@ static void ntfs_put_super(struct super_
 	 * Destroy the global default upcase table if necessary.  Also decrease
 	 * the number of upcase users if we are a user.
 	 */
-	down(&ntfs_lock);
+	mutex_lock(&ntfs_lock);
 	if (vol->upcase == default_upcase) {
 		ntfs_nr_upcase_users--;
 		vol->upcase = NULL;
@@ -2361,7 +2361,7 @@ static void ntfs_put_super(struct super_
 	}
 	if (vol->cluster_size <= 4096 && !--ntfs_nr_compression_users)
 		free_compression_buffers();
-	up(&ntfs_lock);
+	mutex_unlock(&ntfs_lock);
 	if (vol->upcase) {
 		ntfs_free(vol->upcase);
 		vol->upcase = NULL;
@@ -2811,7 +2811,7 @@ static int ntfs_fill_super(struct super_
 			ntfs_error(sb, "Failed to load essential metadata.");
 		goto iput_tmp_ino_err_out_now;
 	}
-	down(&ntfs_lock);
+	mutex_lock(&ntfs_lock);
 	/*
 	 * The current mount is a compression user if the cluster size is
 	 * less than or equal 4kiB.
@@ -2822,7 +2822,7 @@ static int ntfs_fill_super(struct super_
 			ntfs_error(NULL, "Failed to allocate buffers "
 					"for compression engine.");
 			ntfs_nr_compression_users--;
-			up(&ntfs_lock);
+			mutex_unlock(&ntfs_lock);
 			goto iput_tmp_ino_err_out_now;
 		}
 	}
@@ -2834,7 +2834,7 @@ static int ntfs_fill_super(struct super_
 	if (!default_upcase)
 		default_upcase = generate_default_upcase();
 	ntfs_nr_upcase_users++;
-	up(&ntfs_lock);
+	mutex_unlock(&ntfs_lock);
 	/*
 	 * From now on, ignore @silent parameter. If we fail below this line,
 	 * it will be due to a corrupt fs or a system error, so we report it.
@@ -2852,12 +2852,12 @@ static int ntfs_fill_super(struct super_
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
@@ -2925,12 +2925,12 @@ static int ntfs_fill_super(struct super_
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
@@ -2945,14 +2945,14 @@ unl_upcase_iput_tmp_ino_err_out_now:
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
@@ -3012,7 +3012,7 @@ kmem_cache_t *ntfs_attr_ctx_cache;
 kmem_cache_t *ntfs_index_ctx_cache;
 
 /* Driver wide semaphore. */
-DECLARE_MUTEX(ntfs_lock);
+DEFINE_MUTEX(ntfs_lock);
 
 static struct super_block *ntfs_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
