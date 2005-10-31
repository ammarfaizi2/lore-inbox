Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVJaOZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVJaOZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVJaOZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:25:48 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:22913 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932314AbVJaOZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:25:47 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:25:40 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 2/17] NTFS: Change ntfs_attr_find_vcn_nolock() to also take
 an optional attribute search context
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311425000.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Change ntfs_attr_find_vcn_nolock() to also take an optional attribute
      search context as argument.  This allows calling it with the mft
      record mapped.  Update all callers.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog  |    6 ++--
 fs/ntfs/attrib.c   |   86 ++++++++++++++++++++++++++++++----------------------
 fs/ntfs/attrib.h   |    2 +
 fs/ntfs/lcnalloc.c |    4 +-
 fs/ntfs/mft.c      |    7 ++--
 5 files changed, 60 insertions(+), 45 deletions(-)

applies-to: 34dcdb5b47c9d89b4dbc8c98cd93617bb14eaca7
69b41e3c0223bd38cf23e3d8f1385963089fbf22
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 85f797a..0a361dd 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -24,8 +24,10 @@ ToDo/Notes:
 
 2.1.25-WIP
 
-	- Change ntfs_map_runlist_nolock() to also take an optional attribute
-	  search context.  This allows calling it with the mft record mapped.
+	- Change ntfs_map_runlist_nolock() and ntfs_attr_find_vcn_nolock() to
+	  also take an optional attribute search context as argument.  This
+	  allows calling these functions with the mft record mapped.  Update
+	  all callers.
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index b194197..2aafc87 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -406,9 +406,9 @@ retry_remap:
 
 /**
  * ntfs_attr_find_vcn_nolock - find a vcn in the runlist of an ntfs inode
- * @ni:			ntfs inode describing the runlist to search
- * @vcn:		vcn to find
- * @write_locked:	true if the runlist is locked for writing
+ * @ni:		ntfs inode describing the runlist to search
+ * @vcn:	vcn to find
+ * @ctx:	active attribute search context if present or NULL if not
  *
  * Find the virtual cluster number @vcn in the runlist described by the ntfs
  * inode @ni and return the address of the runlist element containing the @vcn.
@@ -416,9 +416,22 @@ retry_remap:
  * If the @vcn is not mapped yet, the attempt is made to map the attribute
  * extent containing the @vcn and the vcn to lcn conversion is retried.
  *
- * If @write_locked is true the caller has locked the runlist for writing and
- * if false for reading.
- *
+ * If @ctx is specified, it is an active search context of @ni and its base mft
+ * record.  This is needed when ntfs_attr_find_vcn_nolock() encounters unmapped
+ * runlist fragments and allows their mapping.  If you do not have the mft
+ * record mapped, you can specify @ctx as NULL and ntfs_attr_find_vcn_nolock()
+ * will perform the necessary mapping and unmapping.
+ *
+ * Note, ntfs_attr_find_vcn_nolock() saves the state of @ctx on entry and
+ * restores it before returning.  Thus, @ctx will be left pointing to the same
+ * attribute on return as on entry.  However, the actual pointers in @ctx may
+ * point to different memory locations on return, so you must remember to reset
+ * any cached pointers from the @ctx, i.e. after the call to
+ * ntfs_attr_find_vcn_nolock(), you will probably want to do:
+ *	m = ctx->mrec;
+ *	a = ctx->attr;
+ * Assuming you cache ctx->attr in a variable @a of type ATTR_RECORD * and that
+ * you cache ctx->mrec in a variable @m of type MFT_RECORD *.
  * Note you need to distinguish between the lcn of the returned runlist element
  * being >= 0 and LCN_HOLE.  In the later case you have to return zeroes on
  * read and allocate clusters on write.
@@ -433,22 +446,31 @@ retry_remap:
  *	-ENOMEM - Not enough memory to map runlist.
  *	-EIO	- Critical error (runlist/file is corrupt, i/o error, etc).
  *
- * Locking: - The runlist must be locked on entry and is left locked on return.
- *	    - If @write_locked is FALSE, i.e. the runlist is locked for reading,
- *	      the lock may be dropped inside the function so you cannot rely on
- *	      the runlist still being the same when this function returns.
+ * WARNING: If @ctx is supplied, regardless of whether success or failure is
+ *	    returned, you need to check IS_ERR(@ctx->mrec) and if TRUE the @ctx
+ *	    is no longer valid, i.e. you need to either call
+ *	    ntfs_attr_reinit_search_ctx() or ntfs_attr_put_search_ctx() on it.
+ *	    In that case PTR_ERR(@ctx->mrec) will give you the error code for
+ *	    why the mapping of the old inode failed.
+ *
+ * Locking: - The runlist described by @ni must be locked for writing on entry
+ *	      and is locked on return.  Note the runlist may be modified when
+ *	      needed runlist fragments need to be mapped.
+ *	    - If @ctx is NULL, the base mft record of @ni must not be mapped on
+ *	      entry and it will be left unmapped on return.
+ *	    - If @ctx is not NULL, the base mft record must be mapped on entry
+ *	      and it will be left mapped on return.
  */
 runlist_element *ntfs_attr_find_vcn_nolock(ntfs_inode *ni, const VCN vcn,
-		const BOOL write_locked)
+		ntfs_attr_search_ctx *ctx)
 {
 	unsigned long flags;
 	runlist_element *rl;
 	int err = 0;
 	BOOL is_retry = FALSE;
 
-	ntfs_debug("Entering for i_ino 0x%lx, vcn 0x%llx, %s_locked.",
-			ni->mft_no, (unsigned long long)vcn,
-			write_locked ? "write" : "read");
+	ntfs_debug("Entering for i_ino 0x%lx, vcn 0x%llx, with%s ctx.",
+			ni->mft_no, (unsigned long long)vcn, ctx ? "" : "out");
 	BUG_ON(!ni);
 	BUG_ON(!NInoNonResident(ni));
 	BUG_ON(vcn < 0);
@@ -482,33 +504,22 @@ retry_remap:
 	}
 	if (!err && !is_retry) {
 		/*
-		 * The @vcn is in an unmapped region, map the runlist and
-		 * retry.
+		 * If the search context is invalid we cannot map the unmapped
+		 * region.
 		 */
-		if (!write_locked) {
-			up_read(&ni->runlist.lock);
-			down_write(&ni->runlist.lock);
-			if (unlikely(ntfs_rl_vcn_to_lcn(ni->runlist.rl, vcn) !=
-					LCN_RL_NOT_MAPPED)) {
-				up_write(&ni->runlist.lock);
-				down_read(&ni->runlist.lock);
+		if (IS_ERR(ctx->mrec))
+			err = PTR_ERR(ctx->mrec);
+		else {
+			/*
+			 * The @vcn is in an unmapped region, map the runlist
+			 * and retry.
+			 */
+			err = ntfs_map_runlist_nolock(ni, vcn, ctx);
+			if (likely(!err)) {
+				is_retry = TRUE;
 				goto retry_remap;
 			}
 		}
-		err = ntfs_map_runlist_nolock(ni, vcn, NULL);
-		if (!write_locked) {
-			up_write(&ni->runlist.lock);
-			down_read(&ni->runlist.lock);
-		}
-		if (likely(!err)) {
-			is_retry = TRUE;
-			goto retry_remap;
-		}
-		/*
-		 * -EINVAL coming from a failed mapping attempt is equivalent
-		 * to i/o error for us as it should not happen in our code
-		 * paths.
-		 */
 		if (err == -EINVAL)
 			err = -EIO;
 	} else if (!err)
@@ -1181,6 +1192,7 @@ int ntfs_attr_lookup(const ATTR_TYPE typ
 	ntfs_inode *base_ni;
 
 	ntfs_debug("Entering.");
+	BUG_ON(IS_ERR(ctx->mrec));
 	if (ctx->base_ntfs_ino)
 		base_ni = ctx->base_ntfs_ino;
 	else
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index eeca8e5..62f7625 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -68,7 +68,7 @@ extern LCN ntfs_attr_vcn_to_lcn_nolock(n
 		const BOOL write_locked);
 
 extern runlist_element *ntfs_attr_find_vcn_nolock(ntfs_inode *ni,
-		const VCN vcn, const BOOL write_locked);
+		const VCN vcn, ntfs_attr_search_ctx *ctx);
 
 int ntfs_attr_lookup(const ATTR_TYPE type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic,
diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
index 5af3bf0..8e60c47 100644
--- a/fs/ntfs/lcnalloc.c
+++ b/fs/ntfs/lcnalloc.c
@@ -839,7 +839,7 @@ s64 __ntfs_cluster_free(ntfs_inode *ni, 
 
 	total_freed = real_freed = 0;
 
-	rl = ntfs_attr_find_vcn_nolock(ni, start_vcn, TRUE);
+	rl = ntfs_attr_find_vcn_nolock(ni, start_vcn, NULL);
 	if (IS_ERR(rl)) {
 		if (!is_rollback)
 			ntfs_error(vol->sb, "Failed to find first runlist "
@@ -893,7 +893,7 @@ s64 __ntfs_cluster_free(ntfs_inode *ni, 
 
 			/* Attempt to map runlist. */
 			vcn = rl->vcn;
-			rl = ntfs_attr_find_vcn_nolock(ni, vcn, TRUE);
+			rl = ntfs_attr_find_vcn_nolock(ni, vcn, NULL);
 			if (IS_ERR(rl)) {
 				err = PTR_ERR(rl);
 				if (!is_rollback)
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index b011369..15df34f 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -49,7 +49,8 @@ static inline MFT_RECORD *map_mft_record
 	ntfs_volume *vol = ni->vol;
 	struct inode *mft_vi = vol->mft_ino;
 	struct page *page;
-	unsigned long index, ofs, end_index;
+	unsigned long index, end_index;
+	unsigned ofs;
 
 	BUG_ON(ni->page);
 	/*
@@ -1308,7 +1309,7 @@ static int ntfs_mft_bitmap_extend_alloca
 	ll = mftbmp_ni->allocated_size;
 	read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
 	rl = ntfs_attr_find_vcn_nolock(mftbmp_ni,
-			(ll - 1) >> vol->cluster_size_bits, TRUE);
+			(ll - 1) >> vol->cluster_size_bits, NULL);
 	if (unlikely(IS_ERR(rl) || !rl->length || rl->lcn < 0)) {
 		up_write(&mftbmp_ni->runlist.lock);
 		ntfs_error(vol->sb, "Failed to determine last allocated "
@@ -1738,7 +1739,7 @@ static int ntfs_mft_data_extend_allocati
 	ll = mft_ni->allocated_size;
 	read_unlock_irqrestore(&mft_ni->size_lock, flags);
 	rl = ntfs_attr_find_vcn_nolock(mft_ni,
-			(ll - 1) >> vol->cluster_size_bits, TRUE);
+			(ll - 1) >> vol->cluster_size_bits, NULL);
 	if (unlikely(IS_ERR(rl) || !rl->length || rl->lcn < 0)) {
 		up_write(&mft_ni->runlist.lock);
 		ntfs_error(vol->sb, "Failed to determine last allocated "
---
0.99.9
