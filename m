Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWHZBzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWHZBzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 21:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422834AbWHZBzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 21:55:50 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:40064 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751574AbWHZBzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 21:55:48 -0400
Message-ID: <44EFABAD.4050303@student.ltu.se>
Date: Sat, 26 Aug 2006 04:02:21 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, aia21@cam.ac.uk
Subject: [PATCH 2.6.18-rc4-mm2] fs/ntfs: Conversion to generic boolean
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Conversion of booleans to: generic-boolean.patch (2006-08-23)

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 aops.c     |   30 +++++-----
 aops.h     |    2
 attrib.c   |   54 +++++++++---------
 attrib.h   |    8 +-
 bitmap.c   |    8 +-
 bitmap.h   |    4 -
 collate.h  |    8 +-
 compress.c |    4 -
 file.c     |   34 +++++------
 index.c    |    4 -
 index.h    |   12 ++--
 inode.c    |   10 +--
 layout.h   |    6 +-
 lcnalloc.c |   20 +++---
 lcnalloc.h |    8 +-
 logfile.c  |  108 ++++++++++++++++++-------------------
 logfile.h  |    6 +-
 mft.c      |   58 +++++++++----------
 mft.h      |    2
 ntfs.h     |    2
 quota.c    |   12 ++--
 quota.h    |    2
 runlist.c  |   54 +++++++++---------
 super.c    |  178 ++++++++++++++++++++++++++++++-------------------------------
 types.h    |    5 -
 unistr.c   |    8 +-
 usnjrnl.c  |    8 +-
 usnjrnl.h  |    2
 28 files changed, 326 insertions(+), 331 deletions(-)


diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index bc579bf..7b2c8f4 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -254,7 +254,7 @@ static int ntfs_read_block(struct page *
 		bh->b_bdev = vol->sb->s_bdev;
 		/* Is the block within the allowed limits? */
 		if (iblock < lblock) {
-			BOOL is_retry = FALSE;
+			bool is_retry = false;
 
 			/* Convert iblock into corresponding vcn and offset. */
 			vcn = (VCN)iblock << blocksize_bits >>
@@ -292,7 +292,7 @@ lock_retry_remap:
 				goto handle_hole;
 			/* If first try and runlist unmapped, map and retry. */
 			if (!is_retry && lcn == LCN_RL_NOT_MAPPED) {
-				is_retry = TRUE;
+				is_retry = true;
 				/*
 				 * Attempt to map runlist, dropping lock for
 				 * the duration.
@@ -558,7 +558,7 @@ static int ntfs_write_block(struct page 
 	unsigned long flags;
 	unsigned int blocksize, vcn_ofs;
 	int err;
-	BOOL need_end_writeback;
+	bool need_end_writeback;
 	unsigned char blocksize_bits;
 
 	vi = page->mapping->host;
@@ -626,7 +626,7 @@ static int ntfs_write_block(struct page 
 	rl = NULL;
 	err = 0;
 	do {
-		BOOL is_retry = FALSE;
+		bool is_retry = false;
 
 		if (unlikely(block >= dblock)) {
 			/*
@@ -768,7 +768,7 @@ lock_retry_remap:
 		}
 		/* If first try and runlist unmapped, map and retry. */
 		if (!is_retry && lcn == LCN_RL_NOT_MAPPED) {
-			is_retry = TRUE;
+			is_retry = true;
 			/*
 			 * Attempt to map runlist, dropping lock for
 			 * the duration.
@@ -874,12 +874,12 @@ lock_retry_remap:
 	set_page_writeback(page);	/* Keeps try_to_free_buffers() away. */
 
 	/* Submit the prepared buffers for i/o. */
-	need_end_writeback = TRUE;
+	need_end_writeback = true;
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
 			submit_bh(WRITE, bh);
-			need_end_writeback = FALSE;
+			need_end_writeback = false;
 		}
 		bh = next;
 	} while (bh != head);
@@ -932,7 +932,7 @@ static int ntfs_write_mst_block(struct p
 	runlist_element *rl;
 	int i, nr_locked_nis, nr_recs, nr_bhs, max_bhs, bhs_per_rec, err, err2;
 	unsigned bh_size, rec_size_bits;
-	BOOL sync, is_mft, page_is_dirty, rec_is_dirty;
+	bool sync, is_mft, page_is_dirty, rec_is_dirty;
 	unsigned char bh_size_bits;
 
 	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
@@ -975,10 +975,10 @@ static int ntfs_write_mst_block(struct p
 
 	rl = NULL;
 	err = err2 = nr_bhs = nr_recs = nr_locked_nis = 0;
-	page_is_dirty = rec_is_dirty = FALSE;
+	page_is_dirty = rec_is_dirty = false;
 	rec_start_bh = NULL;
 	do {
-		BOOL is_retry = FALSE;
+		bool is_retry = false;
 
 		if (likely(block < rec_block)) {
 			if (unlikely(block >= dblock)) {
@@ -1009,10 +1009,10 @@ static int ntfs_write_mst_block(struct p
 			}
 			if (!buffer_dirty(bh)) {
 				/* Clean records are not written out. */
-				rec_is_dirty = FALSE;
+				rec_is_dirty = false;
 				continue;
 			}
-			rec_is_dirty = TRUE;
+			rec_is_dirty = true;
 			rec_start_bh = bh;
 		}
 		/* Need to map the buffer if it is not mapped already. */
@@ -1053,7 +1053,7 @@ lock_retry_remap:
 				 */
 				if (!is_mft && !is_retry &&
 						lcn == LCN_RL_NOT_MAPPED) {
-					is_retry = TRUE;
+					is_retry = true;
 					/*
 					 * Attempt to map runlist, dropping
 					 * lock for the duration.
@@ -1063,7 +1063,7 @@ lock_retry_remap:
 					if (likely(!err2))
 						goto lock_retry_remap;
 					if (err2 == -ENOMEM)
-						page_is_dirty = TRUE;
+						page_is_dirty = true;
 					lcn = err2;
 				} else {
 					err2 = -EIO;
@@ -1145,7 +1145,7 @@ lock_retry_remap:
 				 * means we need to redirty the page before
 				 * returning.
 				 */
-				page_is_dirty = TRUE;
+				page_is_dirty = true;
 				/*
 				 * Remove the buffers in this mft record from
 				 * the list of buffers to write.
diff --git a/fs/ntfs/aops.h b/fs/ntfs/aops.h
index 325ce26..9393f4b 100644
--- a/fs/ntfs/aops.h
+++ b/fs/ntfs/aops.h
@@ -80,7 +80,7 @@ static inline void ntfs_unmap_page(struc
  *
  * The unlocked and uptodate page is returned on success or an encoded error
  * on failure. Caller has to test for error using the IS_ERR() macro on the
- * return value. If that evaluates to TRUE, the negative error code can be
+ * return value. If that evaluates to 'true', the negative error code can be
  * obtained using PTR_ERR() on the return value of ntfs_map_page().
  */
 static inline struct page *ntfs_map_page(struct address_space *mapping,
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 6708e1d..9f08e85 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -67,7 +67,7 @@ #include "types.h"
  * the attribute has zero allocated size, i.e. there simply is no runlist.
  *
  * WARNING: If @ctx is supplied, regardless of whether success or failure is
- *	    returned, you need to check IS_ERR(@ctx->mrec) and if TRUE the @ctx
+ *	    returned, you need to check IS_ERR(@ctx->mrec) and if 'true' the @ctx
  *	    is no longer valid, i.e. you need to either call
  *	    ntfs_attr_reinit_search_ctx() or ntfs_attr_put_search_ctx() on it.
  *	    In that case PTR_ERR(@ctx->mrec) will give you the error code for
@@ -90,7 +90,7 @@ int ntfs_map_runlist_nolock(ntfs_inode *
 	runlist_element *rl;
 	struct page *put_this_page = NULL;
 	int err = 0;
-	BOOL ctx_is_temporary, ctx_needs_reset;
+	bool ctx_is_temporary, ctx_needs_reset;
 	ntfs_attr_search_ctx old_ctx = { NULL, };
 
 	ntfs_debug("Mapping runlist part containing vcn 0x%llx.",
@@ -100,7 +100,7 @@ int ntfs_map_runlist_nolock(ntfs_inode *
 	else
 		base_ni = ni->ext.base_ntfs_ino;
 	if (!ctx) {
-		ctx_is_temporary = ctx_needs_reset = TRUE;
+		ctx_is_temporary = ctx_needs_reset = true;
 		m = map_mft_record(base_ni);
 		if (IS_ERR(m))
 			return PTR_ERR(m);
@@ -115,7 +115,7 @@ int ntfs_map_runlist_nolock(ntfs_inode *
 		BUG_ON(IS_ERR(ctx->mrec));
 		a = ctx->attr;
 		BUG_ON(!a->non_resident);
-		ctx_is_temporary = FALSE;
+		ctx_is_temporary = false;
 		end_vcn = sle64_to_cpu(a->data.non_resident.highest_vcn);
 		read_lock_irqsave(&ni->size_lock, flags);
 		allocated_size_vcn = ni->allocated_size >>
@@ -136,7 +136,7 @@ int ntfs_map_runlist_nolock(ntfs_inode *
 				ni->name, ni->name_len) &&
 				sle64_to_cpu(a->data.non_resident.lowest_vcn)
 				<= vcn && end_vcn >= vcn))
-			ctx_needs_reset = FALSE;
+			ctx_needs_reset = false;
 		else {
 			/* Save the old search context. */
 			old_ctx = *ctx;
@@ -158,7 +158,7 @@ int ntfs_map_runlist_nolock(ntfs_inode *
 			 * needed attribute extent.
 			 */
 			ntfs_attr_reinit_search_ctx(ctx);
-			ctx_needs_reset = TRUE;
+			ctx_needs_reset = true;
 		}
 	}
 	if (ctx_needs_reset) {
@@ -336,16 +336,16 @@ int ntfs_map_runlist(ntfs_inode *ni, VCN
  *  LCN_EIO	Critical error (runlist/file is corrupt, i/o error, etc).
  *
  * Locking: - The runlist must be locked on entry and is left locked on return.
- *	    - If @write_locked is FALSE, i.e. the runlist is locked for reading,
+ *	    - If @write_locked is 'false', i.e. the runlist is locked for reading,
  *	      the lock may be dropped inside the function so you cannot rely on
  *	      the runlist still being the same when this function returns.
  */
 LCN ntfs_attr_vcn_to_lcn_nolock(ntfs_inode *ni, const VCN vcn,
-		const BOOL write_locked)
+		const bool write_locked)
 {
 	LCN lcn;
 	unsigned long flags;
-	BOOL is_retry = FALSE;
+	bool is_retry = false;
 
 	ntfs_debug("Entering for i_ino 0x%lx, vcn 0x%llx, %s_locked.",
 			ni->mft_no, (unsigned long long)vcn,
@@ -390,7 +390,7 @@ retry_remap:
 			down_read(&ni->runlist.lock);
 		}
 		if (likely(!err)) {
-			is_retry = TRUE;
+			is_retry = true;
 			goto retry_remap;
 		}
 		if (err == -ENOENT)
@@ -449,7 +449,7 @@ retry_remap:
  *	-EIO	- Critical error (runlist/file is corrupt, i/o error, etc).
  *
  * WARNING: If @ctx is supplied, regardless of whether success or failure is
- *	    returned, you need to check IS_ERR(@ctx->mrec) and if TRUE the @ctx
+ *	    returned, you need to check IS_ERR(@ctx->mrec) and if 'true' the @ctx
  *	    is no longer valid, i.e. you need to either call
  *	    ntfs_attr_reinit_search_ctx() or ntfs_attr_put_search_ctx() on it.
  *	    In that case PTR_ERR(@ctx->mrec) will give you the error code for
@@ -469,7 +469,7 @@ runlist_element *ntfs_attr_find_vcn_nolo
 	unsigned long flags;
 	runlist_element *rl;
 	int err = 0;
-	BOOL is_retry = FALSE;
+	bool is_retry = false;
 
 	ntfs_debug("Entering for i_ino 0x%lx, vcn 0x%llx, with%s ctx.",
 			ni->mft_no, (unsigned long long)vcn, ctx ? "" : "out");
@@ -518,7 +518,7 @@ retry_remap:
 			 */
 			err = ntfs_map_runlist_nolock(ni, vcn, ctx);
 			if (likely(!err)) {
-				is_retry = TRUE;
+				is_retry = true;
 				goto retry_remap;
 			}
 		}
@@ -558,8 +558,8 @@ retry_remap:
  * On actual error, ntfs_attr_find() returns -EIO.  In this case @ctx->attr is
  * undefined and in particular do not rely on it not changing.
  *
- * If @ctx->is_first is TRUE, the search begins with @ctx->attr itself.  If it
- * is FALSE, the search begins after @ctx->attr.
+ * If @ctx->is_first is 'true', the search begins with @ctx->attr itself.  If it
+ * is 'false', the search begins after @ctx->attr.
  *
  * If @ic is IGNORE_CASE, the @name comparisson is not case sensitive and
  * @ctx->ntfs_ino must be set to the ntfs inode to which the mft record
@@ -599,11 +599,11 @@ static int ntfs_attr_find(const ATTR_TYP
 
 	/*
 	 * Iterate over attributes in mft record starting at @ctx->attr, or the
-	 * attribute following that, if @ctx->is_first is TRUE.
+	 * attribute following that, if @ctx->is_first is 'true'.
 	 */
 	if (ctx->is_first) {
 		a = ctx->attr;
-		ctx->is_first = FALSE;
+		ctx->is_first = false;
 	} else
 		a = (ATTR_RECORD*)((u8*)ctx->attr +
 				le32_to_cpu(ctx->attr->length));
@@ -890,11 +890,11 @@ static int ntfs_external_attr_find(const
 		ctx->al_entry = (ATTR_LIST_ENTRY*)al_start;
 	/*
 	 * Iterate over entries in attribute list starting at @ctx->al_entry,
-	 * or the entry following that, if @ctx->is_first is TRUE.
+	 * or the entry following that, if @ctx->is_first is 'true'.
 	 */
 	if (ctx->is_first) {
 		al_entry = ctx->al_entry;
-		ctx->is_first = FALSE;
+		ctx->is_first = false;
 	} else
 		al_entry = (ATTR_LIST_ENTRY*)((u8*)ctx->al_entry +
 				le16_to_cpu(ctx->al_entry->length));
@@ -1127,7 +1127,7 @@ not_found:
 	ctx->mrec = ctx->base_mrec;
 	ctx->attr = (ATTR_RECORD*)((u8*)ctx->mrec +
 			le16_to_cpu(ctx->mrec->attrs_offset));
-	ctx->is_first = TRUE;
+	ctx->is_first = true;
 	ctx->ntfs_ino = base_ni;
 	ctx->base_ntfs_ino = NULL;
 	ctx->base_mrec = NULL;
@@ -1224,7 +1224,7 @@ static inline void ntfs_attr_init_search
 		/* Sanity checks are performed elsewhere. */
 		.attr = (ATTR_RECORD*)((u8*)mrec +
 				le16_to_cpu(mrec->attrs_offset)),
-		.is_first = TRUE,
+		.is_first = true,
 		.ntfs_ino = ni,
 	};
 }
@@ -1243,7 +1243,7 @@ void ntfs_attr_reinit_search_ctx(ntfs_at
 {
 	if (likely(!ctx->base_ntfs_ino)) {
 		/* No attribute list. */
-		ctx->is_first = TRUE;
+		ctx->is_first = true;
 		/* Sanity checks are performed elsewhere. */
 		ctx->attr = (ATTR_RECORD*)((u8*)ctx->mrec +
 				le16_to_cpu(ctx->mrec->attrs_offset));
@@ -1585,7 +1585,7 @@ int ntfs_attr_make_non_resident(ntfs_ino
 			return -ENOMEM;
 		/* Start by allocating clusters to hold the attribute value. */
 		rl = ntfs_cluster_alloc(vol, 0, new_size >>
-				vol->cluster_size_bits, -1, DATA_ZONE, TRUE);
+				vol->cluster_size_bits, -1, DATA_ZONE, true);
 		if (IS_ERR(rl)) {
 			err = PTR_ERR(rl);
 			ntfs_debug("Failed to allocate cluster%s, error code "
@@ -1919,7 +1919,7 @@ s64 ntfs_attr_extend_allocation(ntfs_ino
 	unsigned long flags;
 	int err, mp_size;
 	u32 attr_len = 0; /* Silence stupid gcc warning. */
-	BOOL mp_rebuilt;
+	bool mp_rebuilt;
 
 #ifdef NTFS_DEBUG
 	read_lock_irqsave(&ni->size_lock, flags);
@@ -2222,7 +2222,7 @@ first_alloc:
 	rl2 = ntfs_cluster_alloc(vol, allocated_size >> vol->cluster_size_bits,
 			(new_alloc_size - allocated_size) >>
 			vol->cluster_size_bits, (rl && (rl->lcn >= 0)) ?
-			rl->lcn + rl->length : -1, DATA_ZONE, TRUE);
+			rl->lcn + rl->length : -1, DATA_ZONE, true);
 	if (IS_ERR(rl2)) {
 		err = PTR_ERR(rl2);
 		if (start < 0 || start >= allocated_size)
@@ -2265,7 +2265,7 @@ first_alloc:
 	BUG_ON(!rl2);
 	BUG_ON(!rl2->length);
 	BUG_ON(rl2->lcn < LCN_HOLE);
-	mp_rebuilt = FALSE;
+	mp_rebuilt = false;
 	/* Get the size for the new mapping pairs array for this extent. */
 	mp_size = ntfs_get_size_for_mapping_pairs(vol, rl2, ll, -1);
 	if (unlikely(mp_size <= 0)) {
@@ -2300,7 +2300,7 @@ first_alloc:
 		err = -EOPNOTSUPP;
 		goto undo_alloc;
 	}
-	mp_rebuilt = TRUE;
+	mp_rebuilt = true;
 	/* Generate the mapping pairs array directly into the attr record. */
 	err = ntfs_mapping_pairs_build(vol, (u8*)a +
 			le16_to_cpu(a->data.non_resident.mapping_pairs_offset),
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index 9074886..3c8b74c 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -40,10 +40,10 @@ #include "volume.h"
  * Structure must be initialized to zero before the first call to one of the
  * attribute search functions. Initialize @mrec to point to the mft record to
  * search, and @attr to point to the first attribute within @mrec (not necessary
- * if calling the _first() functions), and set @is_first to TRUE (not necessary
+ * if calling the _first() functions), and set @is_first to 'true' (not necessary
  * if calling the _first() functions).
  *
- * If @is_first is TRUE, the search begins with @attr. If @is_first is FALSE,
+ * If @is_first is 'true', the search begins with @attr. If @is_first is 'false',
  * the search begins after @attr. This is so that, after the first call to one
  * of the search attribute functions, we can call the function again, without
  * any modification of the search context, to automagically get the next
@@ -52,7 +52,7 @@ #include "volume.h"
 typedef struct {
 	MFT_RECORD *mrec;
 	ATTR_RECORD *attr;
-	BOOL is_first;
+	bool is_first;
 	ntfs_inode *ntfs_ino;
 	ATTR_LIST_ENTRY *al_entry;
 	ntfs_inode *base_ntfs_ino;
@@ -65,7 +65,7 @@ extern int ntfs_map_runlist_nolock(ntfs_
 extern int ntfs_map_runlist(ntfs_inode *ni, VCN vcn);
 
 extern LCN ntfs_attr_vcn_to_lcn_nolock(ntfs_inode *ni, const VCN vcn,
-		const BOOL write_locked);
+		const bool write_locked);
 
 extern runlist_element *ntfs_attr_find_vcn_nolock(ntfs_inode *ni,
 		const VCN vcn, ntfs_attr_search_ctx *ctx);
diff --git a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
index 7a190cd..0809cf8 100644
--- a/fs/ntfs/bitmap.c
+++ b/fs/ntfs/bitmap.c
@@ -34,18 +34,18 @@ #include "ntfs.h"
  * @start_bit:		first bit to set
  * @count:		number of bits to set
  * @value:		value to set the bits to (i.e. 0 or 1)
- * @is_rollback:	if TRUE this is a rollback operation
+ * @is_rollback:	if 'true' this is a rollback operation
  *
  * Set @count bits starting at bit @start_bit in the bitmap described by the
  * vfs inode @vi to @value, where @value is either 0 or 1.
  *
- * @is_rollback should always be FALSE, it is for internal use to rollback
+ * @is_rollback should always be 'false', it is for internal use to rollback
  * errors.  You probably want to use ntfs_bitmap_set_bits_in_run() instead.
  *
  * Return 0 on success and -errno on error.
  */
 int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
-		const s64 count, const u8 value, const BOOL is_rollback)
+		const s64 count, const u8 value, const bool is_rollback)
 {
 	s64 cnt = count;
 	pgoff_t index, end_index;
@@ -172,7 +172,7 @@ rollback:
 		return PTR_ERR(page);
 	if (count != cnt)
 		pos = __ntfs_bitmap_set_bits_in_run(vi, start_bit, count - cnt,
-				value ? 0 : 1, TRUE);
+				value ? 0 : 1, true);
 	else
 		pos = 0;
 	if (!pos) {
diff --git a/fs/ntfs/bitmap.h b/fs/ntfs/bitmap.h
index bb50d6b..72c9ad8 100644
--- a/fs/ntfs/bitmap.h
+++ b/fs/ntfs/bitmap.h
@@ -30,7 +30,7 @@ #include <linux/fs.h>
 #include "types.h"
 
 extern int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
-		const s64 count, const u8 value, const BOOL is_rollback);
+		const s64 count, const u8 value, const bool is_rollback);
 
 /**
  * ntfs_bitmap_set_bits_in_run - set a run of bits in a bitmap to a value
@@ -48,7 +48,7 @@ static inline int ntfs_bitmap_set_bits_i
 		const s64 start_bit, const s64 count, const u8 value)
 {
 	return __ntfs_bitmap_set_bits_in_run(vi, start_bit, count, value,
-			FALSE);
+			false);
 }
 
 /**
diff --git a/fs/ntfs/collate.h b/fs/ntfs/collate.h
index e027f36..aba8334 100644
--- a/fs/ntfs/collate.h
+++ b/fs/ntfs/collate.h
@@ -26,7 +26,7 @@ #define _LINUX_NTFS_COLLATE_H
 #include "types.h"
 #include "volume.h"
 
-static inline BOOL ntfs_is_collation_rule_supported(COLLATION_RULE cr) {
+static inline bool ntfs_is_collation_rule_supported(COLLATION_RULE cr) {
 	int i;
 
 	/*
@@ -35,12 +35,12 @@ static inline BOOL ntfs_is_collation_rul
 	 * now.
 	 */
 	if (unlikely(cr != COLLATION_BINARY && cr != COLLATION_NTOFS_ULONG))
-		return FALSE;
+		return false;
 	i = le32_to_cpu(cr);
 	if (likely(((i >= 0) && (i <= 0x02)) ||
 			((i >= 0x10) && (i <= 0x13))))
-		return TRUE;
-	return FALSE;
+		return true;
+	return false;
 }
 
 extern int ntfs_collate(ntfs_volume *vol, COLLATION_RULE cr,
diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 68a607f..d98daf5 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -600,7 +600,7 @@ do_next_cb:
 	rl = NULL;
 	for (vcn = start_vcn, start_vcn += cb_clusters; vcn < start_vcn;
 			vcn++) {
-		BOOL is_retry = FALSE;
+		bool is_retry = false;
 
 		if (!rl) {
 lock_retry_remap:
@@ -626,7 +626,7 @@ lock_retry_remap:
 				break;
 			if (is_retry || lcn != LCN_RL_NOT_MAPPED)
 				goto rl_err;
-			is_retry = TRUE;
+			is_retry = true;
 			/*
 			 * Attempt to map runlist, dropping lock for the
 			 * duration.
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 2e42c2d..585a79d 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -509,7 +509,7 @@ static int ntfs_prepare_pages_for_non_re
 	u32 attr_rec_len = 0;
 	unsigned blocksize, u;
 	int err, mp_size;
-	BOOL rl_write_locked, was_hole, is_retry;
+	bool rl_write_locked, was_hole, is_retry;
 	unsigned char blocksize_bits;
 	struct {
 		u8 runlist_merged:1;
@@ -543,13 +543,13 @@ static int ntfs_prepare_pages_for_non_re
 				return -ENOMEM;
 		}
 	} while (++u < nr_pages);
-	rl_write_locked = FALSE;
+	rl_write_locked = false;
 	rl = NULL;
 	err = 0;
 	vcn = lcn = -1;
 	vcn_len = 0;
 	lcn_block = -1;
-	was_hole = FALSE;
+	was_hole = false;
 	cpos = pos >> vol->cluster_size_bits;
 	end = pos + bytes;
 	cend = (end + vol->cluster_size - 1) >> vol->cluster_size_bits;
@@ -760,7 +760,7 @@ map_buffer_cached:
 			}
 			continue;
 		}
-		is_retry = FALSE;
+		is_retry = false;
 		if (!rl) {
 			down_read(&ni->runlist.lock);
 retry_remap:
@@ -776,7 +776,7 @@ retry_remap:
 				 * Successful remap, setup the map cache and
 				 * use that to deal with the buffer.
 				 */
-				was_hole = FALSE;
+				was_hole = false;
 				vcn = bh_cpos;
 				vcn_len = rl[1].vcn - vcn;
 				lcn_block = lcn << (vol->cluster_size_bits -
@@ -792,7 +792,7 @@ retry_remap:
 				if (likely(vcn + vcn_len >= cend)) {
 					if (rl_write_locked) {
 						up_write(&ni->runlist.lock);
-						rl_write_locked = FALSE;
+						rl_write_locked = false;
 					} else
 						up_read(&ni->runlist.lock);
 					rl = NULL;
@@ -818,13 +818,13 @@ retry_remap:
 					 */
 					up_read(&ni->runlist.lock);
 					down_write(&ni->runlist.lock);
-					rl_write_locked = TRUE;
+					rl_write_locked = true;
 					goto retry_remap;
 				}
 				err = ntfs_map_runlist_nolock(ni, bh_cpos,
 						NULL);
 				if (likely(!err)) {
-					is_retry = TRUE;
+					is_retry = true;
 					goto retry_remap;
 				}
 				/*
@@ -903,7 +903,7 @@ rl_not_mapped_enoent:
 		if (!rl_write_locked) {
 			up_read(&ni->runlist.lock);
 			down_write(&ni->runlist.lock);
-			rl_write_locked = TRUE;
+			rl_write_locked = true;
 			goto retry_remap;
 		}
 		/* Find the previous last allocated cluster. */
@@ -917,7 +917,7 @@ rl_not_mapped_enoent:
 			}
 		}
 		rl2 = ntfs_cluster_alloc(vol, bh_cpos, 1, lcn, DATA_ZONE,
-				FALSE);
+				false);
 		if (IS_ERR(rl2)) {
 			err = PTR_ERR(rl2);
 			ntfs_debug("Failed to allocate cluster, error code %i.",
@@ -1093,7 +1093,7 @@ rl_not_mapped_enoent:
 		status.mft_attr_mapped = 0;
 		status.mp_rebuilt = 0;
 		/* Setup the map cache and use that to deal with the buffer. */
-		was_hole = TRUE;
+		was_hole = true;
 		vcn = bh_cpos;
 		vcn_len = 1;
 		lcn_block = lcn << (vol->cluster_size_bits - blocksize_bits);
@@ -1105,7 +1105,7 @@ rl_not_mapped_enoent:
 		 */
 		if (likely(vcn + vcn_len >= cend)) {
 			up_write(&ni->runlist.lock);
-			rl_write_locked = FALSE;
+			rl_write_locked = false;
 			rl = NULL;
 		}
 		goto map_buffer_cached;
@@ -1117,7 +1117,7 @@ rl_not_mapped_enoent:
 	if (likely(!err)) {
 		if (unlikely(rl_write_locked)) {
 			up_write(&ni->runlist.lock);
-			rl_write_locked = FALSE;
+			rl_write_locked = false;
 		} else if (unlikely(rl))
 			up_read(&ni->runlist.lock);
 		rl = NULL;
@@ -1528,19 +1528,19 @@ static inline int ntfs_commit_pages_afte
 	do {
 		s64 bh_pos;
 		struct page *page;
-		BOOL partial;
+		bool partial;
 
 		page = pages[u];
 		bh_pos = (s64)page->index << PAGE_CACHE_SHIFT;
 		bh = head = page_buffers(page);
-		partial = FALSE;
+		partial = false;
 		do {
 			s64 bh_end;
 
 			bh_end = bh_pos + blocksize;
 			if (bh_end <= pos || bh_pos >= end) {
 				if (!buffer_uptodate(bh))
-					partial = TRUE;
+					partial = true;
 			} else {
 				set_buffer_uptodate(bh);
 				mark_buffer_dirty(bh);
@@ -1997,7 +1997,7 @@ static ssize_t ntfs_file_buffered_write(
 				 */
 				down_read(&ni->runlist.lock);
 				lcn = ntfs_attr_vcn_to_lcn_nolock(ni, pos >>
-						vol->cluster_size_bits, FALSE);
+						vol->cluster_size_bits, false);
 				up_read(&ni->runlist.lock);
 				if (unlikely(lcn < LCN_HOLE)) {
 					status = -EIO;
diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 9f5427c..e32cde4 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -204,7 +204,7 @@ int ntfs_index_lookup(const void *key, c
 		if ((key_len == le16_to_cpu(ie->key_length)) && !memcmp(key,
 				&ie->key, key_len)) {
 ir_done:
-			ictx->is_in_root = TRUE;
+			ictx->is_in_root = true;
 			ictx->ir = ir;
 			ictx->actx = actx;
 			ictx->base_ni = base_ni;
@@ -374,7 +374,7 @@ fast_descend_into_child_node:
 		if ((key_len == le16_to_cpu(ie->key_length)) && !memcmp(key,
 				&ie->key, key_len)) {
 ia_done:
-			ictx->is_in_root = FALSE;
+			ictx->is_in_root = false;
 			ictx->actx = NULL;
 			ictx->base_ni = NULL;
 			ictx->ia = ia;
diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
index 846a489..8745469 100644
--- a/fs/ntfs/index.h
+++ b/fs/ntfs/index.h
@@ -37,12 +37,12 @@ #include "aops.h"
  * @entry:	index entry (points into @ir or @ia)
  * @data:	index entry data (points into @entry)
  * @data_len:	length in bytes of @data
- * @is_in_root:	TRUE if @entry is in @ir and FALSE if it is in @ia
+ * @is_in_root:	'true' if @entry is in @ir and 'false' if it is in @ia
  * @ir:		index root if @is_in_root and NULL otherwise
  * @actx:	attribute search context if @is_in_root and NULL otherwise
  * @base_ni:	base inode if @is_in_root and NULL otherwise
- * @ia:		index block if @is_in_root is FALSE and NULL otherwise
- * @page:	page if @is_in_root is FALSE and NULL otherwise
+ * @ia:		index block if @is_in_root is 'false' and NULL otherwise
+ * @page:	page if @is_in_root is 'false' and NULL otherwise
  *
  * @idx_ni is the index inode this context belongs to.
  *
@@ -50,11 +50,11 @@ #include "aops.h"
  * are the index entry data and its length in bytes, respectively.  @data
  * simply points into @entry.  This is probably what the user is interested in.
  *
- * If @is_in_root is TRUE, @entry is in the index root attribute @ir described
+ * If @is_in_root is 'true', @entry is in the index root attribute @ir described
  * by the attribute search context @actx and the base inode @base_ni.  @ia and
  * @page are NULL in this case.
  *
- * If @is_in_root is FALSE, @entry is in the index allocation attribute and @ia
+ * If @is_in_root is 'false', @entry is in the index allocation attribute and @ia
  * and @page point to the index allocation block and the mapped, locked page it
  * is in, respectively.  @ir, @actx and @base_ni are NULL in this case.
  *
@@ -77,7 +77,7 @@ typedef struct {
 	INDEX_ENTRY *entry;
 	void *data;
 	u16 data_len;
-	BOOL is_in_root;
+	bool is_in_root;
 	INDEX_ROOT *ir;
 	ntfs_attr_search_ctx *actx;
 	ntfs_inode *base_ni;
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index d313f35..ff383bb 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2305,7 +2305,7 @@ void ntfs_clear_big_inode(struct inode *
 	}
 #ifdef NTFS_RW
 	if (NInoDirty(ni)) {
-		BOOL was_bad = (is_bad_inode(vi));
+		bool was_bad = (is_bad_inode(vi));
 
 		/* Committing the inode also commits all extent inodes. */
 		ntfs_commit_inode(vi);
@@ -3019,7 +3019,7 @@ int ntfs_write_inode(struct inode *vi, i
 	MFT_RECORD *m;
 	STANDARD_INFORMATION *si;
 	int err = 0;
-	BOOL modified = FALSE;
+	bool modified = false;
 
 	ntfs_debug("Entering for %sinode 0x%lx.", NInoAttr(ni) ? "attr " : "",
 			vi->i_ino);
@@ -3061,7 +3061,7 @@ int ntfs_write_inode(struct inode *vi, i
 				sle64_to_cpu(si->last_data_change_time),
 				(long long)sle64_to_cpu(nt));
 		si->last_data_change_time = nt;
-		modified = TRUE;
+		modified = true;
 	}
 	nt = utc2ntfs(vi->i_ctime);
 	if (si->last_mft_change_time != nt) {
@@ -3070,7 +3070,7 @@ int ntfs_write_inode(struct inode *vi, i
 				sle64_to_cpu(si->last_mft_change_time),
 				(long long)sle64_to_cpu(nt));
 		si->last_mft_change_time = nt;
-		modified = TRUE;
+		modified = true;
 	}
 	nt = utc2ntfs(vi->i_atime);
 	if (si->last_access_time != nt) {
@@ -3079,7 +3079,7 @@ int ntfs_write_inode(struct inode *vi, i
 				(long long)sle64_to_cpu(si->last_access_time),
 				(long long)sle64_to_cpu(nt));
 		si->last_access_time = nt;
-		modified = TRUE;
+		modified = true;
 	}
 	/*
 	 * If we just modified the standard information attribute we need to
diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
index d34b93c..1e38332 100644
--- a/fs/ntfs/layout.h
+++ b/fs/ntfs/layout.h
@@ -142,13 +142,13 @@ typedef le32 NTFS_RECORD_TYPE;
  * operator! (-8
  */
 
-static inline BOOL __ntfs_is_magic(le32 x, NTFS_RECORD_TYPE r)
+static inline bool __ntfs_is_magic(le32 x, NTFS_RECORD_TYPE r)
 {
 	return (x == r);
 }
 #define ntfs_is_magic(x, m)	__ntfs_is_magic(x, magic_##m)
 
-static inline BOOL __ntfs_is_magicp(le32 *p, NTFS_RECORD_TYPE r)
+static inline bool __ntfs_is_magicp(le32 *p, NTFS_RECORD_TYPE r)
 {
 	return (*p == r);
 }
@@ -323,7 +323,7 @@ #define MSEQNO(x)	((u16)(((x) >> 48) & 0
 #define MREF_LE(x)	((unsigned long)(le64_to_cpu(x) & MFT_REF_MASK_CPU))
 #define MSEQNO_LE(x)	((u16)((le64_to_cpu(x) >> 48) & 0xffff))
 
-#define IS_ERR_MREF(x)	(((x) & 0x0000800000000000ULL) ? 1 : 0)
+#define IS_ERR_MREF(x)	(((x) & 0x0000800000000000ULL) ? true : false)
 #define ERR_MREF(x)	((u64)((s64)(x)))
 #define MREF_ERR(x)	((int)((s64)(x)))
 
diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
index 29cabf9..1711b71 100644
--- a/fs/ntfs/lcnalloc.c
+++ b/fs/ntfs/lcnalloc.c
@@ -76,7 +76,7 @@ int ntfs_cluster_free_from_rl_nolock(ntf
  * @count:	number of clusters to allocate
  * @start_lcn:	starting lcn at which to allocate the clusters (or -1 if none)
  * @zone:	zone from which to allocate the clusters
- * @is_extension:	if TRUE, this is an attribute extension
+ * @is_extension:	if 'true', this is an attribute extension
  *
  * Allocate @count clusters preferably starting at cluster @start_lcn or at the
  * current allocator position if @start_lcn is -1, on the mounted ntfs volume
@@ -87,11 +87,11 @@ int ntfs_cluster_free_from_rl_nolock(ntf
  * @start_vcn specifies the vcn of the first allocated cluster.  This makes
  * merging the resulting runlist with the old runlist easier.
  *
- * If @is_extension is TRUE, the caller is allocating clusters to extend an
- * attribute and if it is FALSE, the caller is allocating clusters to fill a
+ * If @is_extension is 'true', the caller is allocating clusters to extend an
+ * attribute and if it is 'false', the caller is allocating clusters to fill a
  * hole in an attribute.  Practically the difference is that if @is_extension
- * is TRUE the returned runlist will be terminated with LCN_ENOENT and if
- * @is_extension is FALSE the runlist will be terminated with
+ * is 'true' the returned runlist will be terminated with LCN_ENOENT and if
+ * @is_extension is 'false' the runlist will be terminated with
  * LCN_RL_NOT_MAPPED.
  *
  * You need to check the return value with IS_ERR().  If this is false, the
@@ -146,7 +146,7 @@ int ntfs_cluster_free_from_rl_nolock(ntf
 runlist_element *ntfs_cluster_alloc(ntfs_volume *vol, const VCN start_vcn,
 		const s64 count, const LCN start_lcn,
 		const NTFS_CLUSTER_ALLOCATION_ZONES zone,
-		const BOOL is_extension)
+		const bool is_extension)
 {
 	LCN zone_start, zone_end, bmp_pos, bmp_initial_pos, last_read_pos, lcn;
 	LCN prev_lcn = 0, prev_run_len = 0, mft_zone_size;
@@ -818,7 +818,7 @@ out:
  * Assuming you cache ctx->attr in a variable @a of type ATTR_RECORD * and that
  * you cache ctx->mrec in a variable @m of type MFT_RECORD *.
  *
- * @is_rollback should always be FALSE, it is for internal use to rollback
+ * @is_rollback should always be 'false', it is for internal use to rollback
  * errors.  You probably want to use ntfs_cluster_free() instead.
  *
  * Note, __ntfs_cluster_free() does not modify the runlist, so you have to
@@ -828,7 +828,7 @@ out:
  * success and -errno on error.
  *
  * WARNING: If @ctx is supplied, regardless of whether success or failure is
- *	    returned, you need to check IS_ERR(@ctx->mrec) and if TRUE the @ctx
+ *	    returned, you need to check IS_ERR(@ctx->mrec) and if 'true' the @ctx
  *	    is no longer valid, i.e. you need to either call
  *	    ntfs_attr_reinit_search_ctx() or ntfs_attr_put_search_ctx() on it.
  *	    In that case PTR_ERR(@ctx->mrec) will give you the error code for
@@ -847,7 +847,7 @@ out:
  *	      and it will be left mapped on return.
  */
 s64 __ntfs_cluster_free(ntfs_inode *ni, const VCN start_vcn, s64 count,
-		ntfs_attr_search_ctx *ctx, const BOOL is_rollback)
+		ntfs_attr_search_ctx *ctx, const bool is_rollback)
 {
 	s64 delta, to_free, total_freed, real_freed;
 	ntfs_volume *vol;
@@ -999,7 +999,7 @@ err_out:
 	 * If rollback fails, set the volume errors flag, emit an error
 	 * message, and return the error code.
 	 */
-	delta = __ntfs_cluster_free(ni, start_vcn, total_freed, ctx, TRUE);
+	delta = __ntfs_cluster_free(ni, start_vcn, total_freed, ctx, true);
 	if (delta < 0) {
 		ntfs_error(vol->sb, "Failed to rollback (error %i).  Leaving "
 				"inconsistent metadata!  Unmount and run "
diff --git a/fs/ntfs/lcnalloc.h b/fs/ntfs/lcnalloc.h
index 72cbca7..2adb043 100644
--- a/fs/ntfs/lcnalloc.h
+++ b/fs/ntfs/lcnalloc.h
@@ -43,10 +43,10 @@ typedef enum {
 extern runlist_element *ntfs_cluster_alloc(ntfs_volume *vol,
 		const VCN start_vcn, const s64 count, const LCN start_lcn,
 		const NTFS_CLUSTER_ALLOCATION_ZONES zone,
-		const BOOL is_extension);
+		const bool is_extension);
 
 extern s64 __ntfs_cluster_free(ntfs_inode *ni, const VCN start_vcn,
-		s64 count, ntfs_attr_search_ctx *ctx, const BOOL is_rollback);
+		s64 count, ntfs_attr_search_ctx *ctx, const bool is_rollback);
 
 /**
  * ntfs_cluster_free - free clusters on an ntfs volume
@@ -86,7 +86,7 @@ extern s64 __ntfs_cluster_free(ntfs_inod
  * success and -errno on error.
  *
  * WARNING: If @ctx is supplied, regardless of whether success or failure is
- *	    returned, you need to check IS_ERR(@ctx->mrec) and if TRUE the @ctx
+ *	    returned, you need to check IS_ERR(@ctx->mrec) and if 'true' the @ctx
  *	    is no longer valid, i.e. you need to either call
  *	    ntfs_attr_reinit_search_ctx() or ntfs_attr_put_search_ctx() on it.
  *	    In that case PTR_ERR(@ctx->mrec) will give you the error code for
@@ -107,7 +107,7 @@ extern s64 __ntfs_cluster_free(ntfs_inod
 static inline s64 ntfs_cluster_free(ntfs_inode *ni, const VCN start_vcn,
 		s64 count, ntfs_attr_search_ctx *ctx)
 {
-	return __ntfs_cluster_free(ni, start_vcn, count, ctx, FALSE);
+	return __ntfs_cluster_free(ni, start_vcn, count, ctx, false);
 }
 
 extern int ntfs_cluster_free_from_rl_nolock(ntfs_volume *vol,
diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
index 4af2ad1..acfed32 100644
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -41,18 +41,18 @@ #include "ntfs.h"
  * @rp:		restart page header to check
  * @pos:	position in @vi at which the restart page header resides
  *
- * Check the restart page header @rp for consistency and return TRUE if it is
- * consistent and FALSE otherwise.
+ * Check the restart page header @rp for consistency and return 'true' if it is
+ * consistent and 'false' otherwise.
  *
  * This function only needs NTFS_BLOCK_SIZE bytes in @rp, i.e. it does not
  * require the full restart page.
  */
-static BOOL ntfs_check_restart_page_header(struct inode *vi,
+static bool ntfs_check_restart_page_header(struct inode *vi,
 		RESTART_PAGE_HEADER *rp, s64 pos)
 {
 	u32 logfile_system_page_size, logfile_log_page_size;
 	u16 ra_ofs, usa_count, usa_ofs, usa_end = 0;
-	BOOL have_usa = TRUE;
+	bool have_usa = true;
 
 	ntfs_debug("Entering.");
 	/*
@@ -67,7 +67,7 @@ static BOOL ntfs_check_restart_page_head
 			(logfile_system_page_size - 1) ||
 			logfile_log_page_size & (logfile_log_page_size - 1)) {
 		ntfs_error(vi->i_sb, "$LogFile uses unsupported page size.");
-		return FALSE;
+		return false;
 	}
 	/*
 	 * We must be either at !pos (1st restart page) or at pos = system page
@@ -76,7 +76,7 @@ static BOOL ntfs_check_restart_page_head
 	if (pos && pos != logfile_system_page_size) {
 		ntfs_error(vi->i_sb, "Found restart area in incorrect "
 				"position in $LogFile.");
-		return FALSE;
+		return false;
 	}
 	/* We only know how to handle version 1.1. */
 	if (sle16_to_cpu(rp->major_ver) != 1 ||
@@ -85,14 +85,14 @@ static BOOL ntfs_check_restart_page_head
 				"supported.  (This driver supports version "
 				"1.1 only.)", (int)sle16_to_cpu(rp->major_ver),
 				(int)sle16_to_cpu(rp->minor_ver));
-		return FALSE;
+		return false;
 	}
 	/*
 	 * If chkdsk has been run the restart page may not be protected by an
 	 * update sequence array.
 	 */
 	if (ntfs_is_chkd_record(rp->magic) && !le16_to_cpu(rp->usa_count)) {
-		have_usa = FALSE;
+		have_usa = false;
 		goto skip_usa_checks;
 	}
 	/* Verify the size of the update sequence array. */
@@ -100,7 +100,7 @@ static BOOL ntfs_check_restart_page_head
 	if (usa_count != le16_to_cpu(rp->usa_count)) {
 		ntfs_error(vi->i_sb, "$LogFile restart page specifies "
 				"inconsistent update sequence array count.");
-		return FALSE;
+		return false;
 	}
 	/* Verify the position of the update sequence array. */
 	usa_ofs = le16_to_cpu(rp->usa_ofs);
@@ -109,7 +109,7 @@ static BOOL ntfs_check_restart_page_head
 			usa_end > NTFS_BLOCK_SIZE - sizeof(u16)) {
 		ntfs_error(vi->i_sb, "$LogFile restart page specifies "
 				"inconsistent update sequence array offset.");
-		return FALSE;
+		return false;
 	}
 skip_usa_checks:
 	/*
@@ -124,7 +124,7 @@ skip_usa_checks:
 			ra_ofs > logfile_system_page_size) {
 		ntfs_error(vi->i_sb, "$LogFile restart page specifies "
 				"inconsistent restart area offset.");
-		return FALSE;
+		return false;
 	}
 	/*
 	 * Only restart pages modified by chkdsk are allowed to have chkdsk_lsn
@@ -133,10 +133,10 @@ skip_usa_checks:
 	if (!ntfs_is_chkd_record(rp->magic) && sle64_to_cpu(rp->chkdsk_lsn)) {
 		ntfs_error(vi->i_sb, "$LogFile restart page is not modified "
 				"by chkdsk but a chkdsk LSN is specified.");
-		return FALSE;
+		return false;
 	}
 	ntfs_debug("Done.");
-	return TRUE;
+	return true;
 }
 
 /**
@@ -145,7 +145,7 @@ skip_usa_checks:
  * @rp:		restart page whose restart area to check
  *
  * Check the restart area of the restart page @rp for consistency and return
- * TRUE if it is consistent and FALSE otherwise.
+ * 'true' if it is consistent and 'false' otherwise.
  *
  * This function assumes that the restart page header has already been
  * consistency checked.
@@ -153,7 +153,7 @@ skip_usa_checks:
  * This function only needs NTFS_BLOCK_SIZE bytes in @rp, i.e. it does not
  * require the full restart page.
  */
-static BOOL ntfs_check_restart_area(struct inode *vi, RESTART_PAGE_HEADER *rp)
+static bool ntfs_check_restart_area(struct inode *vi, RESTART_PAGE_HEADER *rp)
 {
 	u64 file_size;
 	RESTART_AREA *ra;
@@ -172,7 +172,7 @@ static BOOL ntfs_check_restart_area(stru
 			NTFS_BLOCK_SIZE - sizeof(u16)) {
 		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
 				"inconsistent file offset.");
-		return FALSE;
+		return false;
 	}
 	/*
 	 * Now that we can access ra->client_array_offset, make sure everything
@@ -186,7 +186,7 @@ static BOOL ntfs_check_restart_area(stru
 			ra_ofs + ca_ofs > NTFS_BLOCK_SIZE - sizeof(u16)) {
 		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
 				"inconsistent client array offset.");
-		return FALSE;
+		return false;
 	}
 	/*
 	 * The restart area must end within the system page size both when
@@ -203,7 +203,7 @@ static BOOL ntfs_check_restart_area(stru
 				"of the system page size specified by the "
 				"restart page header and/or the specified "
 				"restart area length is inconsistent.");
-		return FALSE;
+		return false;
 	}
 	/*
 	 * The ra->client_free_list and ra->client_in_use_list must be either
@@ -218,7 +218,7 @@ static BOOL ntfs_check_restart_area(stru
 			le16_to_cpu(ra->log_clients))) {
 		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
 				"overflowing client free and/or in use lists.");
-		return FALSE;
+		return false;
 	}
 	/*
 	 * Check ra->seq_number_bits against ra->file_size for consistency.
@@ -233,24 +233,24 @@ static BOOL ntfs_check_restart_area(stru
 	if (le32_to_cpu(ra->seq_number_bits) != 67 - fs_bits) {
 		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
 				"inconsistent sequence number bits.");
-		return FALSE;
+		return false;
 	}
 	/* The log record header length must be a multiple of 8. */
 	if (((le16_to_cpu(ra->log_record_header_length) + 7) & ~7) !=
 			le16_to_cpu(ra->log_record_header_length)) {
 		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
 				"inconsistent log record header length.");
-		return FALSE;
+		return false;
 	}
 	/* Dito for the log page data offset. */
 	if (((le16_to_cpu(ra->log_page_data_offset) + 7) & ~7) !=
 			le16_to_cpu(ra->log_page_data_offset)) {
 		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
 				"inconsistent log page data offset.");
-		return FALSE;
+		return false;
 	}
 	ntfs_debug("Done.");
-	return TRUE;
+	return true;
 }
 
 /**
@@ -259,7 +259,7 @@ static BOOL ntfs_check_restart_area(stru
  * @rp:		restart page whose log client array to check
  *
  * Check the log client array of the restart page @rp for consistency and
- * return TRUE if it is consistent and FALSE otherwise.
+ * return 'true' if it is consistent and 'false' otherwise.
  *
  * This function assumes that the restart page header and the restart area have
  * already been consistency checked.
@@ -268,13 +268,13 @@ static BOOL ntfs_check_restart_area(stru
  * function needs @rp->system_page_size bytes in @rp, i.e. it requires the full
  * restart page and the page must be multi sector transfer deprotected.
  */
-static BOOL ntfs_check_log_client_array(struct inode *vi,
+static bool ntfs_check_log_client_array(struct inode *vi,
 		RESTART_PAGE_HEADER *rp)
 {
 	RESTART_AREA *ra;
 	LOG_CLIENT_RECORD *ca, *cr;
 	u16 nr_clients, idx;
-	BOOL in_free_list, idx_is_first;
+	bool in_free_list, idx_is_first;
 
 	ntfs_debug("Entering.");
 	ra = (RESTART_AREA*)((u8*)rp + le16_to_cpu(rp->restart_area_offset));
@@ -290,9 +290,9 @@ static BOOL ntfs_check_log_client_array(
 	 */
 	nr_clients = le16_to_cpu(ra->log_clients);
 	idx = le16_to_cpu(ra->client_free_list);
-	in_free_list = TRUE;
+	in_free_list = true;
 check_list:
-	for (idx_is_first = TRUE; idx != LOGFILE_NO_CLIENT_CPU; nr_clients--,
+	for (idx_is_first = true; idx != LOGFILE_NO_CLIENT_CPU; nr_clients--,
 			idx = le16_to_cpu(cr->next_client)) {
 		if (!nr_clients || idx >= le16_to_cpu(ra->log_clients))
 			goto err_out;
@@ -302,20 +302,20 @@ check_list:
 		if (idx_is_first) {
 			if (cr->prev_client != LOGFILE_NO_CLIENT)
 				goto err_out;
-			idx_is_first = FALSE;
+			idx_is_first = false;
 		}
 	}
 	/* Switch to and check the in use list if we just did the free list. */
 	if (in_free_list) {
-		in_free_list = FALSE;
+		in_free_list = false;
 		idx = le16_to_cpu(ra->client_in_use_list);
 		goto check_list;
 	}
 	ntfs_debug("Done.");
-	return TRUE;
+	return true;
 err_out:
 	ntfs_error(vi->i_sb, "$LogFile log client array is corrupt.");
-	return FALSE;
+	return false;
 }
 
 /**
@@ -468,8 +468,8 @@ err_out:
  * @log_vi:	struct inode of loaded journal $LogFile to check
  * @rp:		[OUT] on success this is a copy of the current restart page
  *
- * Check the $LogFile journal for consistency and return TRUE if it is
- * consistent and FALSE if not.  On success, the current restart page is
+ * Check the $LogFile journal for consistency and return 'true' if it is
+ * consistent and 'false' if not.  On success, the current restart page is
  * returned in *@rp.  Caller must call ntfs_free(*@rp) when finished with it.
  *
  * At present we only check the two restart pages and ignore the log record
@@ -480,7 +480,7 @@ err_out:
  * if the $LogFile was created on a system with a different page size to ours
  * yet and mst deprotection would fail if our page size is smaller.
  */
-BOOL ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
+bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 {
 	s64 size, pos;
 	LSN rstr1_lsn, rstr2_lsn;
@@ -491,7 +491,7 @@ BOOL ntfs_check_logfile(struct inode *lo
 	RESTART_PAGE_HEADER *rstr1_ph = NULL;
 	RESTART_PAGE_HEADER *rstr2_ph = NULL;
 	int log_page_size, log_page_mask, err;
-	BOOL logfile_is_empty = TRUE;
+	bool logfile_is_empty = true;
 	u8 log_page_bits;
 
 	ntfs_debug("Entering.");
@@ -527,7 +527,7 @@ BOOL ntfs_check_logfile(struct inode *lo
 	if (size < log_page_size * 2 || (size - log_page_size * 2) >>
 			log_page_bits < MinLogRecordPages) {
 		ntfs_error(vol->sb, "$LogFile is too small.");
-		return FALSE;
+		return false;
 	}
 	/*
 	 * Read through the file looking for a restart page.  Since the restart
@@ -556,7 +556,7 @@ BOOL ntfs_check_logfile(struct inode *lo
 		 * means we are done.
 		 */
 		if (!ntfs_is_empty_recordp((le32*)kaddr))
-			logfile_is_empty = FALSE;
+			logfile_is_empty = false;
 		else if (!logfile_is_empty)
 			break;
 		/*
@@ -615,13 +615,13 @@ BOOL ntfs_check_logfile(struct inode *lo
 		NVolSetLogFileEmpty(vol);
 is_empty:
 		ntfs_debug("Done.  ($LogFile is empty.)");
-		return TRUE;
+		return true;
 	}
 	if (!rstr1_ph) {
 		BUG_ON(rstr2_ph);
 		ntfs_error(vol->sb, "Did not find any restart pages in "
 				"$LogFile and it was not empty.");
-		return FALSE;
+		return false;
 	}
 	/* If both restart pages were found, use the more recent one. */
 	if (rstr2_ph) {
@@ -648,11 +648,11 @@ is_empty:
 	else
 		ntfs_free(rstr1_ph);
 	ntfs_debug("Done.");
-	return TRUE;
+	return true;
 err_out:
 	if (rstr1_ph)
 		ntfs_free(rstr1_ph);
-	return FALSE;
+	return false;
 }
 
 /**
@@ -660,8 +660,8 @@ err_out:
  * @log_vi:	struct inode of loaded journal $LogFile to check
  * @rp:		copy of the current restart page
  *
- * Analyze the $LogFile journal and return TRUE if it indicates the volume was
- * shutdown cleanly and FALSE if not.
+ * Analyze the $LogFile journal and return 'true' if it indicates the volume was
+ * shutdown cleanly and 'false' if not.
  *
  * At present we only look at the two restart pages and ignore the log record
  * pages.  This is a little bit crude in that there will be a very small number
@@ -675,7 +675,7 @@ err_out:
  * is empty this function requires that NVolLogFileEmpty() is true otherwise an
  * empty volume will be reported as dirty.
  */
-BOOL ntfs_is_logfile_clean(struct inode *log_vi, const RESTART_PAGE_HEADER *rp)
+bool ntfs_is_logfile_clean(struct inode *log_vi, const RESTART_PAGE_HEADER *rp)
 {
 	ntfs_volume *vol = NTFS_SB(log_vi->i_sb);
 	RESTART_AREA *ra;
@@ -684,7 +684,7 @@ BOOL ntfs_is_logfile_clean(struct inode 
 	/* An empty $LogFile must have been clean before it got emptied. */
 	if (NVolLogFileEmpty(vol)) {
 		ntfs_debug("Done.  ($LogFile is empty.)");
-		return TRUE;
+		return true;
 	}
 	BUG_ON(!rp);
 	if (!ntfs_is_rstr_record(rp->magic) &&
@@ -693,7 +693,7 @@ BOOL ntfs_is_logfile_clean(struct inode 
 				"probably a bug in that the $LogFile should "
 				"have been consistency checked before calling "
 				"this function.");
-		return FALSE;
+		return false;
 	}
 	ra = (RESTART_AREA*)((u8*)rp + le16_to_cpu(rp->restart_area_offset));
 	/*
@@ -704,25 +704,25 @@ BOOL ntfs_is_logfile_clean(struct inode 
 	if (ra->client_in_use_list != LOGFILE_NO_CLIENT &&
 			!(ra->flags & RESTART_VOLUME_IS_CLEAN)) {
 		ntfs_debug("Done.  $LogFile indicates a dirty shutdown.");
-		return FALSE;
+		return false;
 	}
 	/* $LogFile indicates a clean shutdown. */
 	ntfs_debug("Done.  $LogFile indicates a clean shutdown.");
-	return TRUE;
+	return true;
 }
 
 /**
  * ntfs_empty_logfile - empty the contents of the $LogFile journal
  * @log_vi:	struct inode of loaded journal $LogFile to empty
  *
- * Empty the contents of the $LogFile journal @log_vi and return TRUE on
- * success and FALSE on error.
+ * Empty the contents of the $LogFile journal @log_vi and return 'true' on
+ * success and 'false' on error.
  *
  * This function assumes that the $LogFile journal has already been consistency
  * checked by a call to ntfs_check_logfile() and that ntfs_is_logfile_clean()
  * has been used to ensure that the $LogFile is clean.
  */
-BOOL ntfs_empty_logfile(struct inode *log_vi)
+bool ntfs_empty_logfile(struct inode *log_vi)
 {
 	ntfs_volume *vol = NTFS_SB(log_vi->i_sb);
 
@@ -735,13 +735,13 @@ BOOL ntfs_empty_logfile(struct inode *lo
 		if (unlikely(err)) {
 			ntfs_error(vol->sb, "Failed to fill $LogFile with "
 					"0xff bytes (error code %i).", err);
-			return FALSE;
+			return false;
 		}
 		/* Set the flag so we do not have to do it again on remount. */
 		NVolSetLogFileEmpty(vol);
 	}
 	ntfs_debug("Done.");
-	return TRUE;
+	return true;
 }
 
 #endif /* NTFS_RW */
diff --git a/fs/ntfs/logfile.h b/fs/ntfs/logfile.h
index a51f3dd..9468e1c 100644
--- a/fs/ntfs/logfile.h
+++ b/fs/ntfs/logfile.h
@@ -296,13 +296,13 @@ typedef struct {
 /* sizeof() = 160 (0xa0) bytes */
 } __attribute__ ((__packed__)) LOG_CLIENT_RECORD;
 
-extern BOOL ntfs_check_logfile(struct inode *log_vi,
+extern bool ntfs_check_logfile(struct inode *log_vi,
 		RESTART_PAGE_HEADER **rp);
 
-extern BOOL ntfs_is_logfile_clean(struct inode *log_vi,
+extern bool ntfs_is_logfile_clean(struct inode *log_vi,
 		const RESTART_PAGE_HEADER *rp);
 
-extern BOOL ntfs_empty_logfile(struct inode *log_vi);
+extern bool ntfs_empty_logfile(struct inode *log_vi);
 
 #endif /* NTFS_RW */
 
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 2438c00..6576058 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -251,7 +251,7 @@ MFT_RECORD *map_extent_mft_record(ntfs_i
 	int i;
 	unsigned long mft_no = MREF(mref);
 	u16 seq_no = MSEQNO(mref);
-	BOOL destroy_ni = FALSE;
+	bool destroy_ni = false;
 
 	ntfs_debug("Mapping extent mft record 0x%lx (base mft record 0x%lx).",
 			mft_no, base_ni->mft_no);
@@ -322,7 +322,7 @@ map_err_out:
 	if (seq_no && (le16_to_cpu(m->sequence_number) != seq_no)) {
 		ntfs_error(base_ni->vol->sb, "Found stale extent mft "
 				"reference! Corrupt filesystem. Run chkdsk.");
-		destroy_ni = TRUE;
+		destroy_ni = true;
 		m = ERR_PTR(-EIO);
 		goto unm_err_out;
 	}
@@ -335,7 +335,7 @@ map_err_out:
 		if (unlikely(!tmp)) {
 			ntfs_error(base_ni->vol->sb, "Failed to allocate "
 					"internal buffer.");
-			destroy_ni = TRUE;
+			destroy_ni = true;
 			m = ERR_PTR(-ENOMEM);
 			goto unm_err_out;
 		}
@@ -857,7 +857,7 @@ err_out:
  * caller is responsible for unlocking the ntfs inode and unpinning the base
  * vfs inode.
  *
- * Return TRUE if the mft record may be written out and FALSE if not.
+ * Return 'true' if the mft record may be written out and 'false' if not.
  *
  * The caller has locked the page and cleared the uptodate flag on it which
  * means that we can safely write out any dirty mft records that do not have
@@ -868,7 +868,7 @@ err_out:
  * Here is a description of the tests we perform:
  *
  * If the inode is found in icache we know the mft record must be a base mft
- * record.  If it is dirty, we do not write it and return FALSE as the vfs
+ * record.  If it is dirty, we do not write it and return 'false' as the vfs
  * inode write paths will result in the access times being updated which would
  * cause the base mft record to be redirtied and written out again.  (We know
  * the access time update will modify the base mft record because Windows
@@ -877,11 +877,11 @@ err_out:
  *
  * If the inode is in icache and not dirty, we attempt to lock the mft record
  * and if we find the lock was already taken, it is not safe to write the mft
- * record and we return FALSE.
+ * record and we return 'false'.
  *
  * If we manage to obtain the lock we have exclusive access to the mft record,
  * which also allows us safe writeout of the mft record.  We then set
- * @locked_ni to the locked ntfs inode and return TRUE.
+ * @locked_ni to the locked ntfs inode and return 'true'.
  *
  * Note we cannot just lock the mft record and sleep while waiting for the lock
  * because this would deadlock due to lock reversal (normally the mft record is
@@ -891,24 +891,24 @@ err_out:
  * If the inode is not in icache we need to perform further checks.
  *
  * If the mft record is not a FILE record or it is a base mft record, we can
- * safely write it and return TRUE.
+ * safely write it and return 'true'.
  *
  * We now know the mft record is an extent mft record.  We check if the inode
  * corresponding to its base mft record is in icache and obtain a reference to
- * it if it is.  If it is not, we can safely write it and return TRUE.
+ * it if it is.  If it is not, we can safely write it and return 'true'.
  *
  * We now have the base inode for the extent mft record.  We check if it has an
  * ntfs inode for the extent mft record attached and if not it is safe to write
- * the extent mft record and we return TRUE.
+ * the extent mft record and we return 'true'.
  *
  * The ntfs inode for the extent mft record is attached to the base inode so we
  * attempt to lock the extent mft record and if we find the lock was already
- * taken, it is not safe to write the extent mft record and we return FALSE.
+ * taken, it is not safe to write the extent mft record and we return 'false'.
  *
  * If we manage to obtain the lock we have exclusive access to the extent mft
  * record, which also allows us safe writeout of the extent mft record.  We
  * set the ntfs inode of the extent mft record clean and then set @locked_ni to
- * the now locked ntfs inode and return TRUE.
+ * the now locked ntfs inode and return 'true'.
  *
  * Note, the reason for actually writing dirty mft records here and not just
  * relying on the vfs inode dirty code paths is that we can have mft records
@@ -922,7 +922,7 @@ err_out:
  * appear if the mft record is reused for a new inode before it got written
  * out.
  */
-BOOL ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
+bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
 		const MFT_RECORD *m, ntfs_inode **locked_ni)
 {
 	struct super_block *sb = vol->sb;
@@ -977,7 +977,7 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 					mft_no);
 			atomic_dec(&ni->count);
 			iput(vi);
-			return FALSE;
+			return false;
 		}
 		ntfs_debug("Inode 0x%lx is not dirty.", mft_no);
 		/* The inode is not dirty, try to take the mft record lock. */
@@ -986,7 +986,7 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 					"not write it.", mft_no);
 			atomic_dec(&ni->count);
 			iput(vi);
-			return FALSE;
+			return false;
 		}
 		ntfs_debug("Managed to lock mft record 0x%lx, write it.",
 				mft_no);
@@ -995,7 +995,7 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 		 * return the locked ntfs inode.
 		 */
 		*locked_ni = ni;
-		return TRUE;
+		return true;
 	}
 	ntfs_debug("Inode 0x%lx is not in icache.", mft_no);
 	/* The inode is not in icache. */
@@ -1003,13 +1003,13 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 	if (!ntfs_is_mft_record(m->magic)) {
 		ntfs_debug("Mft record 0x%lx is not a FILE record, write it.",
 				mft_no);
-		return TRUE;
+		return true;
 	}
 	/* Write the mft record if it is a base inode. */
 	if (!m->base_mft_record) {
 		ntfs_debug("Mft record 0x%lx is a base record, write it.",
 				mft_no);
-		return TRUE;
+		return true;
 	}
 	/*
 	 * This is an extent mft record.  Check if the inode corresponding to
@@ -1033,7 +1033,7 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 		 */
 		ntfs_debug("Base inode 0x%lx is not in icache, write the "
 				"extent record.", na.mft_no);
-		return TRUE;
+		return true;
 	}
 	ntfs_debug("Base inode 0x%lx is in icache.", na.mft_no);
 	/*
@@ -1051,7 +1051,7 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 		iput(vi);
 		ntfs_debug("Base inode 0x%lx has no attached extent inodes, "
 				"write the extent record.", na.mft_no);
-		return TRUE;
+		return true;
 	}
 	/* Iterate over the attached extent inodes. */
 	extent_nis = ni->ext.extent_ntfs_inos;
@@ -1075,7 +1075,7 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 		ntfs_debug("Extent inode 0x%lx is not attached to its base "
 				"inode 0x%lx, write the extent record.",
 				mft_no, na.mft_no);
-		return TRUE;
+		return true;
 	}
 	ntfs_debug("Extent inode 0x%lx is attached to its base inode 0x%lx.",
 			mft_no, na.mft_no);
@@ -1091,7 +1091,7 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 		iput(vi);
 		ntfs_debug("Extent mft record 0x%lx is already locked, do "
 				"not write it.", mft_no);
-		return FALSE;
+		return false;
 	}
 	ntfs_debug("Managed to lock extent mft record 0x%lx, write it.",
 			mft_no);
@@ -1103,7 +1103,7 @@ BOOL ntfs_may_write_mft_record(ntfs_volu
 	 * the locked extent ntfs inode.
 	 */
 	*locked_ni = eni;
-	return TRUE;
+	return true;
 }
 
 static const char *es = "  Leaving inconsistent metadata.  Unmount and run "
@@ -1354,7 +1354,7 @@ static int ntfs_mft_bitmap_extend_alloca
 		ntfs_unmap_page(page);
 		/* Allocate a cluster from the DATA_ZONE. */
 		rl2 = ntfs_cluster_alloc(vol, rl[1].vcn, 1, lcn, DATA_ZONE,
-				TRUE);
+				true);
 		if (IS_ERR(rl2)) {
 			up_write(&mftbmp_ni->runlist.lock);
 			ntfs_error(vol->sb, "Failed to allocate a cluster for "
@@ -1724,7 +1724,7 @@ static int ntfs_mft_data_extend_allocati
 	ATTR_RECORD *a = NULL;
 	int ret, mp_size;
 	u32 old_alen = 0;
-	BOOL mp_rebuilt = FALSE;
+	bool mp_rebuilt = false;
 
 	ntfs_debug("Extending mft data allocation.");
 	mft_ni = NTFS_I(vol->mft_ino);
@@ -1780,7 +1780,7 @@ static int ntfs_mft_data_extend_allocati
 	old_last_vcn = rl[1].vcn;
 	do {
 		rl2 = ntfs_cluster_alloc(vol, old_last_vcn, nr, lcn, MFT_ZONE,
-				TRUE);
+				true);
 		if (likely(!IS_ERR(rl2)))
 			break;
 		if (PTR_ERR(rl2) != -ENOSPC || nr == min_nr) {
@@ -1884,7 +1884,7 @@ static int ntfs_mft_data_extend_allocati
 		ret = -EOPNOTSUPP;
 		goto undo_alloc;
 	}
-	mp_rebuilt = TRUE;
+	mp_rebuilt = true;
 	/* Generate the mapping pairs array directly into the attr record. */
 	ret = ntfs_mapping_pairs_build(vol, (u8*)a +
 			le16_to_cpu(a->data.non_resident.mapping_pairs_offset),
@@ -2255,7 +2255,7 @@ ntfs_inode *ntfs_mft_record_alloc(ntfs_v
 	unsigned int ofs;
 	int err;
 	le16 seq_no, usn;
-	BOOL record_formatted = FALSE;
+	bool record_formatted = false;
 
 	if (base_ni) {
 		ntfs_debug("Entering (allocating an extent mft record for "
@@ -2454,7 +2454,7 @@ have_alloc_rec:
 		mft_ni->initialized_size = new_initialized_size;
 	}
 	write_unlock_irqrestore(&mft_ni->size_lock, flags);
-	record_formatted = TRUE;
+	record_formatted = true;
 	/* Update the mft data attribute record to reflect the new sizes. */
 	m = map_mft_record(mft_ni);
 	if (IS_ERR(m)) {
diff --git a/fs/ntfs/mft.h b/fs/ntfs/mft.h
index 639cd1b..b52bf87 100644
--- a/fs/ntfs/mft.h
+++ b/fs/ntfs/mft.h
@@ -111,7 +111,7 @@ static inline int write_mft_record(ntfs_
 	return err;
 }
 
-extern BOOL ntfs_may_write_mft_record(ntfs_volume *vol,
+extern bool ntfs_may_write_mft_record(ntfs_volume *vol,
 		const unsigned long mft_no, const MFT_RECORD *m,
 		ntfs_inode **locked_ni);
 
diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
index ddd3d50..a12847a 100644
--- a/fs/ntfs/ntfs.h
+++ b/fs/ntfs/ntfs.h
@@ -105,7 +105,7 @@ extern int pre_write_mst_fixup(NTFS_RECO
 extern void post_write_mst_fixup(NTFS_RECORD *b);
 
 /* From fs/ntfs/unistr.c */
-extern BOOL ntfs_are_names_equal(const ntfschar *s1, size_t s1_len,
+extern bool ntfs_are_names_equal(const ntfschar *s1, size_t s1_len,
 		const ntfschar *s2, size_t s2_len,
 		const IGNORE_CASE_BOOL ic,
 		const ntfschar *upcase, const u32 upcase_size);
diff --git a/fs/ntfs/quota.c b/fs/ntfs/quota.c
index d0ef418..d80e331 100644
--- a/fs/ntfs/quota.c
+++ b/fs/ntfs/quota.c
@@ -31,10 +31,10 @@ #include "ntfs.h"
  * ntfs_mark_quotas_out_of_date - mark the quotas out of date on an ntfs volume
  * @vol:	ntfs volume on which to mark the quotas out of date
  *
- * Mark the quotas out of date on the ntfs volume @vol and return TRUE on
- * success and FALSE on error.
+ * Mark the quotas out of date on the ntfs volume @vol and return 'true' on
+ * success and 'false' on error.
  */
-BOOL ntfs_mark_quotas_out_of_date(ntfs_volume *vol)
+bool ntfs_mark_quotas_out_of_date(ntfs_volume *vol)
 {
 	ntfs_index_context *ictx;
 	QUOTA_CONTROL_ENTRY *qce;
@@ -46,7 +46,7 @@ BOOL ntfs_mark_quotas_out_of_date(ntfs_v
 		goto done;
 	if (!vol->quota_ino || !vol->quota_q_ino) {
 		ntfs_error(vol->sb, "Quota inodes are not open.");
-		return FALSE;
+		return false;
 	}
 	mutex_lock(&vol->quota_q_ino->i_mutex);
 	ictx = ntfs_index_ctx_get(NTFS_I(vol->quota_q_ino));
@@ -106,12 +106,12 @@ set_done:
 	NVolSetQuotaOutOfDate(vol);
 done:
 	ntfs_debug("Done.");
-	return TRUE;
+	return true;
 err_out:
 	if (ictx)
 		ntfs_index_ctx_put(ictx);
 	mutex_unlock(&vol->quota_q_ino->i_mutex);
-	return FALSE;
+	return false;
 }
 
 #endif /* NTFS_RW */
diff --git a/fs/ntfs/quota.h b/fs/ntfs/quota.h
index 40e4763..4cbe559 100644
--- a/fs/ntfs/quota.h
+++ b/fs/ntfs/quota.h
@@ -28,7 +28,7 @@ #ifdef NTFS_RW
 #include "types.h"
 #include "volume.h"
 
-extern BOOL ntfs_mark_quotas_out_of_date(ntfs_volume *vol);
+extern bool ntfs_mark_quotas_out_of_date(ntfs_volume *vol);
 
 #endif /* NTFS_RW */
 
diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index eb52b80..9afd72c 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -149,10 +149,10 @@ static inline runlist_element *ntfs_rl_r
  *
  * It is up to the caller to serialize access to the runlists @dst and @src.
  *
- * Return: TRUE   Success, the runlists can be merged.
- *	   FALSE  Failure, the runlists cannot be merged.
+ * Return: true   Success, the runlists can be merged.
+ *	   false  Failure, the runlists cannot be merged.
  */
-static inline BOOL ntfs_are_rl_mergeable(runlist_element *dst,
+static inline bool ntfs_are_rl_mergeable(runlist_element *dst,
 		runlist_element *src)
 {
 	BUG_ON(!dst);
@@ -160,19 +160,19 @@ static inline BOOL ntfs_are_rl_mergeable
 
 	/* We can merge unmapped regions even if they are misaligned. */
 	if ((dst->lcn == LCN_RL_NOT_MAPPED) && (src->lcn == LCN_RL_NOT_MAPPED))
-		return TRUE;
+		return true;
 	/* If the runs are misaligned, we cannot merge them. */
 	if ((dst->vcn + dst->length) != src->vcn)
-		return FALSE;
+		return false;
 	/* If both runs are non-sparse and contiguous, we can merge them. */
 	if ((dst->lcn >= 0) && (src->lcn >= 0) &&
 			((dst->lcn + dst->length) == src->lcn))
-		return TRUE;
+		return true;
 	/* If we are merging two holes, we can merge them. */
 	if ((dst->lcn == LCN_HOLE) && (src->lcn == LCN_HOLE))
-		return TRUE;
+		return true;
 	/* Cannot merge. */
-	return FALSE;
+	return false;
 }
 
 /**
@@ -218,7 +218,7 @@ static inline void __ntfs_rl_merge(runli
 static inline runlist_element *ntfs_rl_append(runlist_element *dst,
 		int dsize, runlist_element *src, int ssize, int loc)
 {
-	BOOL right = FALSE;	/* Right end of @src needs merging. */
+	bool right = false;	/* Right end of @src needs merging. */
 	int marker;		/* End of the inserted runs. */
 
 	BUG_ON(!dst);
@@ -285,8 +285,8 @@ static inline runlist_element *ntfs_rl_a
 static inline runlist_element *ntfs_rl_insert(runlist_element *dst,
 		int dsize, runlist_element *src, int ssize, int loc)
 {
-	BOOL left = FALSE;	/* Left end of @src needs merging. */
-	BOOL disc = FALSE;	/* Discontinuity between @dst and @src. */
+	bool left = false;	/* Left end of @src needs merging. */
+	bool disc = false;	/* Discontinuity between @dst and @src. */
 	int marker;		/* End of the inserted runs. */
 
 	BUG_ON(!dst);
@@ -382,8 +382,8 @@ static inline runlist_element *ntfs_rl_r
 		int dsize, runlist_element *src, int ssize, int loc)
 {
 	signed delta;
-	BOOL left = FALSE;	/* Left end of @src needs merging. */
-	BOOL right = FALSE;	/* Right end of @src needs merging. */
+	bool left = false;	/* Left end of @src needs merging. */
+	bool right = false;	/* Right end of @src needs merging. */
 	int tail;		/* Start of tail of @dst. */
 	int marker;		/* End of the inserted runs. */
 
@@ -620,8 +620,8 @@ #endif
 		;
 
 	{
-	BOOL start;
-	BOOL finish;
+	bool start;
+	bool finish;
 	int ds = dend + 1;		/* Number of elements in drl & srl */
 	int ss = sfinal - sstart + 1;
 
@@ -635,7 +635,7 @@ #endif
 	if (finish && !drl[dins].length)
 		ss++;
 	if (marker && (drl[dins].vcn + drl[dins].length > srl[send - 1].vcn))
-		finish = FALSE;
+		finish = false;
 #if 0
 	ntfs_debug("dfinal = %i, dend = %i", dfinal, dend);
 	ntfs_debug("sstart = %i, sfinal = %i, send = %i", sstart, sfinal, send);
@@ -1134,7 +1134,7 @@ int ntfs_get_size_for_mapping_pairs(cons
 {
 	LCN prev_lcn;
 	int rls;
-	BOOL the_end = FALSE;
+	bool the_end = false;
 
 	BUG_ON(first_vcn < 0);
 	BUG_ON(last_vcn < -1);
@@ -1168,7 +1168,7 @@ int ntfs_get_size_for_mapping_pairs(cons
 			s64 s1 = last_vcn + 1;
 			if (unlikely(rl[1].vcn > s1))
 				length = s1 - rl->vcn;
-			the_end = TRUE;
+			the_end = true;
 		}
 		delta = first_vcn - rl->vcn;
 		/* Header byte + length. */
@@ -1204,7 +1204,7 @@ int ntfs_get_size_for_mapping_pairs(cons
 			s64 s1 = last_vcn + 1;
 			if (unlikely(rl[1].vcn > s1))
 				length = s1 - rl->vcn;
-			the_end = TRUE;
+			the_end = true;
 		}
 		/* Header byte + length. */
 		rls += 1 + ntfs_get_nr_significant_bytes(length);
@@ -1327,7 +1327,7 @@ int ntfs_mapping_pairs_build(const ntfs_
 	LCN prev_lcn;
 	s8 *dst_max, *dst_next;
 	int err = -ENOSPC;
-	BOOL the_end = FALSE;
+	bool the_end = false;
 	s8 len_len, lcn_len;
 
 	BUG_ON(first_vcn < 0);
@@ -1370,7 +1370,7 @@ int ntfs_mapping_pairs_build(const ntfs_
 			s64 s1 = last_vcn + 1;
 			if (unlikely(rl[1].vcn > s1))
 				length = s1 - rl->vcn;
-			the_end = TRUE;
+			the_end = true;
 		}
 		delta = first_vcn - rl->vcn;
 		/* Write length. */
@@ -1422,7 +1422,7 @@ int ntfs_mapping_pairs_build(const ntfs_
 			s64 s1 = last_vcn + 1;
 			if (unlikely(rl[1].vcn > s1))
 				length = s1 - rl->vcn;
-			the_end = TRUE;
+			the_end = true;
 		}
 		/* Write length. */
 		len_len = ntfs_write_significant_bytes(dst + 1, dst_max,
@@ -1541,7 +1541,7 @@ int ntfs_rl_truncate_nolock(const ntfs_v
 	 */
 	if (rl->length) {
 		runlist_element *trl;
-		BOOL is_end;
+		bool is_end;
 
 		ntfs_debug("Shrinking runlist.");
 		/* Determine the runlist size. */
@@ -1555,11 +1555,11 @@ int ntfs_rl_truncate_nolock(const ntfs_v
 		 * If a run was partially truncated, make the following runlist
 		 * element a terminator.
 		 */
-		is_end = FALSE;
+		is_end = false;
 		if (rl->length) {
 			rl++;
 			if (!rl->length)
-				is_end = TRUE;
+				is_end = true;
 			rl->vcn = new_length;
 			rl->length = 0;
 		}
@@ -1648,7 +1648,7 @@ int ntfs_rl_punch_nolock(const ntfs_volu
 	s64 delta;
 	runlist_element *rl, *rl_end, *rl_real_end, *trl;
 	int old_size;
-	BOOL lcn_fixup = FALSE;
+	bool lcn_fixup = false;
 
 	ntfs_debug("Entering for start 0x%llx, length 0x%llx.",
 			(long long)start, (long long)length);
@@ -1862,7 +1862,7 @@ split_end:
 		if (rl->lcn >= 0) {
 			rl->lcn -= delta;
 			/* Need this in case the lcn just became negative. */
-			lcn_fixup = TRUE;
+			lcn_fixup = true;
 		}
 		rl->length += delta;
 		goto split_end;
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 74e0ee8..68fb3d6 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -74,18 +74,18 @@ const option_t on_errors_arr[] = {
  *
  * Copied from old ntfs driver (which copied from vfat driver).
  */
-static int simple_getbool(char *s, BOOL *setval)
+static int simple_getbool(char *s, bool *setval)
 {
 	if (s) {
 		if (!strcmp(s, "1") || !strcmp(s, "yes") || !strcmp(s, "true"))
-			*setval = TRUE;
+			*setval = true;
 		else if (!strcmp(s, "0") || !strcmp(s, "no") ||
 							!strcmp(s, "false"))
-			*setval = FALSE;
+			*setval = false;
 		else
 			return 0;
 	} else
-		*setval = TRUE;
+		*setval = true;
 	return 1;
 }
 
@@ -96,7 +96,7 @@ static int simple_getbool(char *s, BOOL 
  *
  * Parse the recognized options in @opt for the ntfs volume described by @vol.
  */
-static BOOL parse_options(ntfs_volume *vol, char *opt)
+static bool parse_options(ntfs_volume *vol, char *opt)
 {
 	char *p, *v, *ov;
 	static char *utf8 = "utf8";
@@ -137,7 +137,7 @@ #define NTFS_GETOPT_OCTAL(option, variab
 	}
 #define NTFS_GETOPT_BOOL(option, variable)				\
 	if (!strcmp(p, option)) {					\
-		BOOL val;						\
+		bool val;						\
 		if (!simple_getbool(v, &val))				\
 			goto needs_bool;				\
 		variable = val;						\
@@ -170,7 +170,7 @@ #define NTFS_GETOPT_OPTIONS_ARRAY(option
 		else NTFS_GETOPT_OCTAL("fmask", fmask)
 		else NTFS_GETOPT_OCTAL("dmask", dmask)
 		else NTFS_GETOPT("mft_zone_multiplier", mft_zone_multiplier)
-		else NTFS_GETOPT_WITH_DEFAULT("sloppy", sloppy, TRUE)
+		else NTFS_GETOPT_WITH_DEFAULT("sloppy", sloppy, true)
 		else NTFS_GETOPT_BOOL("show_sys_files", show_sys_files)
 		else NTFS_GETOPT_BOOL("case_sensitive", case_sensitive)
 		else NTFS_GETOPT_BOOL("disable_sparse", disable_sparse)
@@ -194,7 +194,7 @@ use_utf8:
 				if (!old_nls) {
 					ntfs_error(vol->sb, "NLS character set "
 							"%s not found.", v);
-					return FALSE;
+					return false;
 				}
 				ntfs_error(vol->sb, "NLS character set %s not "
 						"found. Using previous one %s.",
@@ -205,14 +205,14 @@ use_utf8:
 					unload_nls(old_nls);
 			}
 		} else if (!strcmp(p, "utf8")) {
-			BOOL val = FALSE;
+			bool val = false;
 			ntfs_warning(vol->sb, "Option utf8 is no longer "
 				   "supported, using option nls=utf8. Please "
 				   "use option nls=utf8 in the future and "
 				   "make sure utf8 is compiled either as a "
 				   "module or into the kernel.");
 			if (!v || !*v)
-				val = TRUE;
+				val = true;
 			else if (!simple_getbool(v, &val))
 				goto needs_bool;
 			if (val) {
@@ -231,7 +231,7 @@ #undef NTFS_GETOPT_WITH_DEFAULT
 	}
 no_mount_options:
 	if (errors && !sloppy)
-		return FALSE;
+		return false;
 	if (sloppy)
 		ntfs_warning(vol->sb, "Sloppy option given. Ignoring "
 				"unrecognized mount option(s) and continuing.");
@@ -240,14 +240,14 @@ no_mount_options:
 		if (!on_errors) {
 			ntfs_error(vol->sb, "Invalid errors option argument "
 					"or bug in options parser.");
-			return FALSE;
+			return false;
 		}
 	}
 	if (nls_map) {
 		if (vol->nls_map && vol->nls_map != nls_map) {
 			ntfs_error(vol->sb, "Cannot change NLS character set "
 					"on remount.");
-			return FALSE;
+			return false;
 		} /* else (!vol->nls_map) */
 		ntfs_debug("Using NLS character set %s.", nls_map->charset);
 		vol->nls_map = nls_map;
@@ -257,7 +257,7 @@ no_mount_options:
 			if (!vol->nls_map) {
 				ntfs_error(vol->sb, "Failed to load default "
 						"NLS character set.");
-				return FALSE;
+				return false;
 			}
 			ntfs_debug("Using default NLS character set (%s).",
 					vol->nls_map->charset);
@@ -268,7 +268,7 @@ no_mount_options:
 				mft_zone_multiplier) {
 			ntfs_error(vol->sb, "Cannot change mft_zone_multiplier "
 					"on remount.");
-			return FALSE;
+			return false;
 		}
 		if (mft_zone_multiplier < 1 || mft_zone_multiplier > 4) {
 			ntfs_error(vol->sb, "Invalid mft_zone_multiplier. "
@@ -318,16 +318,16 @@ no_mount_options:
 				NVolSetSparseEnabled(vol);
 		}
 	}
-	return TRUE;
+	return true;
 needs_arg:
 	ntfs_error(vol->sb, "The %s option requires an argument.", p);
-	return FALSE;
+	return false;
 needs_bool:
 	ntfs_error(vol->sb, "The %s option requires a boolean argument.", p);
-	return FALSE;
+	return false;
 needs_val:
 	ntfs_error(vol->sb, "Invalid %s option argument: %s", p, ov);
-	return FALSE;
+	return false;
 }
 
 #ifdef NTFS_RW
@@ -543,16 +543,16 @@ #endif /* NTFS_RW */
  * is_boot_sector_ntfs - check whether a boot sector is a valid NTFS boot sector
  * @sb:		Super block of the device to which @b belongs.
  * @b:		Boot sector of device @sb to check.
- * @silent:	If TRUE, all output will be silenced.
+ * @silent:	If 'true', all output will be silenced.
  *
  * is_boot_sector_ntfs() checks whether the boot sector @b is a valid NTFS boot
- * sector. Returns TRUE if it is valid and FALSE if not.
+ * sector. Returns 'true' if it is valid and 'false' if not.
  *
  * @sb is only needed for warning/error output, i.e. it can be NULL when silent
- * is TRUE.
+ * is 'true'.
  */
-static BOOL is_boot_sector_ntfs(const struct super_block *sb,
-		const NTFS_BOOT_SECTOR *b, const BOOL silent)
+static bool is_boot_sector_ntfs(const struct super_block *sb,
+		const NTFS_BOOT_SECTOR *b, const bool silent)
 {
 	/*
 	 * Check that checksum == sum of u32 values from b to the checksum
@@ -620,9 +620,9 @@ static BOOL is_boot_sector_ntfs(const st
 	 */
 	if (!silent && b->end_of_sector_marker != const_cpu_to_le16(0xaa55))
 		ntfs_warning(sb, "Invalid end of sector marker.");
-	return TRUE;
+	return true;
 not_ntfs:
-	return FALSE;
+	return false;
 }
 
 /**
@@ -732,9 +732,9 @@ hotfix_primary_boot_sector:
  * @b:		boot sector to parse
  *
  * Parse the ntfs boot sector @b and store all imporant information therein in
- * the ntfs super block @vol.  Return TRUE on success and FALSE on error.
+ * the ntfs super block @vol.  Return 'true' on success and 'false' on error.
  */
-static BOOL parse_ntfs_boot_sector(ntfs_volume *vol, const NTFS_BOOT_SECTOR *b)
+static bool parse_ntfs_boot_sector(ntfs_volume *vol, const NTFS_BOOT_SECTOR *b)
 {
 	unsigned int sectors_per_cluster_bits, nr_hidden_sects;
 	int clusters_per_mft_record, clusters_per_index_record;
@@ -751,7 +751,7 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 				"device block size (%lu).  This is not "
 				"supported.  Sorry.", vol->sector_size,
 				vol->sb->s_blocksize);
-		return FALSE;
+		return false;
 	}
 	ntfs_debug("sectors_per_cluster = 0x%x", b->bpb.sectors_per_cluster);
 	sectors_per_cluster_bits = ffs(b->bpb.sectors_per_cluster) - 1;
@@ -770,7 +770,7 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 		ntfs_error(vol->sb, "Cluster size (%i) is smaller than the "
 				"sector size (%i).  This is not supported.  "
 				"Sorry.", vol->cluster_size, vol->sector_size);
-		return FALSE;
+		return false;
 	}
 	clusters_per_mft_record = b->clusters_per_mft_record;
 	ntfs_debug("clusters_per_mft_record = %i (0x%x)",
@@ -802,7 +802,7 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 				"PAGE_CACHE_SIZE on your system (%lu).  "
 				"This is not supported.  Sorry.",
 				vol->mft_record_size, PAGE_CACHE_SIZE);
-		return FALSE;
+		return false;
 	}
 	/* We cannot support mft record sizes below the sector size. */
 	if (vol->mft_record_size < vol->sector_size) {
@@ -810,7 +810,7 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 				"sector size (%i).  This is not supported.  "
 				"Sorry.", vol->mft_record_size,
 				vol->sector_size);
-		return FALSE;
+		return false;
 	}
 	clusters_per_index_record = b->clusters_per_index_record;
 	ntfs_debug("clusters_per_index_record = %i (0x%x)",
@@ -841,7 +841,7 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 				"the sector size (%i).  This is not "
 				"supported.  Sorry.", vol->index_record_size,
 				vol->sector_size);
-		return FALSE;
+		return false;
 	}
 	/*
 	 * Get the size of the volume in clusters and check for 64-bit-ness.
@@ -851,7 +851,7 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 	ll = sle64_to_cpu(b->number_of_sectors) >> sectors_per_cluster_bits;
 	if ((u64)ll >= 1ULL << 32) {
 		ntfs_error(vol->sb, "Cannot handle 64-bit clusters.  Sorry.");
-		return FALSE;
+		return false;
 	}
 	vol->nr_clusters = ll;
 	ntfs_debug("vol->nr_clusters = 0x%llx", (long long)vol->nr_clusters);
@@ -867,7 +867,7 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 					"Maximum supported is 2TiB.  Sorry.",
 					(unsigned long long)ll >> (40 -
 					vol->cluster_size_bits));
-			return FALSE;
+			return false;
 		}
 	}
 	ll = sle64_to_cpu(b->mft_lcn);
@@ -875,7 +875,7 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 		ntfs_error(vol->sb, "MFT LCN (%lli, 0x%llx) is beyond end of "
 				"volume.  Weird.", (unsigned long long)ll,
 				(unsigned long long)ll);
-		return FALSE;
+		return false;
 	}
 	vol->mft_lcn = ll;
 	ntfs_debug("vol->mft_lcn = 0x%llx", (long long)vol->mft_lcn);
@@ -884,7 +884,7 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 		ntfs_error(vol->sb, "MFTMirr LCN (%lli, 0x%llx) is beyond end "
 				"of volume.  Weird.", (unsigned long long)ll,
 				(unsigned long long)ll);
-		return FALSE;
+		return false;
 	}
 	vol->mftmirr_lcn = ll;
 	ntfs_debug("vol->mftmirr_lcn = 0x%llx", (long long)vol->mftmirr_lcn);
@@ -907,7 +907,7 @@ #endif /* NTFS_RW */
 	vol->serial_no = le64_to_cpu(b->volume_serial_number);
 	ntfs_debug("vol->serial_no = 0x%llx",
 			(unsigned long long)vol->serial_no);
-	return TRUE;
+	return true;
 }
 
 /**
@@ -1000,9 +1000,9 @@ #ifdef NTFS_RW
  * load_and_init_mft_mirror - load and setup the mft mirror inode for a volume
  * @vol:	ntfs super block describing device whose mft mirror to load
  *
- * Return TRUE on success or FALSE on error.
+ * Return 'true' on success or 'false' on error.
  */
-static BOOL load_and_init_mft_mirror(ntfs_volume *vol)
+static bool load_and_init_mft_mirror(ntfs_volume *vol)
 {
 	struct inode *tmp_ino;
 	ntfs_inode *tmp_ni;
@@ -1014,7 +1014,7 @@ static BOOL load_and_init_mft_mirror(ntf
 		if (!IS_ERR(tmp_ino))
 			iput(tmp_ino);
 		/* Caller will display error message. */
-		return FALSE;
+		return false;
 	}
 	/*
 	 * Re-initialize some specifics about $MFTMirr's inode as
@@ -1041,20 +1041,20 @@ static BOOL load_and_init_mft_mirror(ntf
 	tmp_ni->itype.index.block_size_bits = vol->mft_record_size_bits;
 	vol->mftmirr_ino = tmp_ino;
 	ntfs_debug("Done.");
-	return TRUE;
+	return true;
 }
 
 /**
  * check_mft_mirror - compare contents of the mft mirror with the mft
  * @vol:	ntfs super block describing device whose mft mirror to check
  *
- * Return TRUE on success or FALSE on error.
+ * Return 'true' on success or 'false' on error.
  *
  * Note, this function also results in the mft mirror runlist being completely
  * mapped into memory.  The mft mirror write code requires this and will BUG()
  * should it find an unmapped runlist element.
  */
-static BOOL check_mft_mirror(ntfs_volume *vol)
+static bool check_mft_mirror(ntfs_volume *vol)
 {
 	struct super_block *sb = vol->sb;
 	ntfs_inode *mirr_ni;
@@ -1086,7 +1086,7 @@ static BOOL check_mft_mirror(ntfs_volume
 					index);
 			if (IS_ERR(mft_page)) {
 				ntfs_error(sb, "Failed to read $MFT.");
-				return FALSE;
+				return false;
 			}
 			kmft = page_address(mft_page);
 			/* Get the $MFTMirr page. */
@@ -1110,7 +1110,7 @@ mm_unmap_out:
 				ntfs_unmap_page(mirr_page);
 mft_unmap_out:
 				ntfs_unmap_page(mft_page);
-				return FALSE;
+				return false;
 			}
 		}
 		/* Do not check the mirror record if it is not in use. */
@@ -1169,21 +1169,21 @@ mft_unmap_out:
 			ntfs_error(sb, "$MFTMirr location mismatch.  "
 					"Run chkdsk.");
 			up_read(&mirr_ni->runlist.lock);
-			return FALSE;
+			return false;
 		}
 	} while (rl2[i++].length);
 	up_read(&mirr_ni->runlist.lock);
 	ntfs_debug("Done.");
-	return TRUE;
+	return true;
 }
 
 /**
  * load_and_check_logfile - load and check the logfile inode for a volume
  * @vol:	ntfs super block describing device whose logfile to load
  *
- * Return TRUE on success or FALSE on error.
+ * Return 'true' on success or 'false' on error.
  */
-static BOOL load_and_check_logfile(ntfs_volume *vol,
+static bool load_and_check_logfile(ntfs_volume *vol,
 		RESTART_PAGE_HEADER **rp)
 {
 	struct inode *tmp_ino;
@@ -1194,17 +1194,17 @@ static BOOL load_and_check_logfile(ntfs_
 		if (!IS_ERR(tmp_ino))
 			iput(tmp_ino);
 		/* Caller will display error message. */
-		return FALSE;
+		return false;
 	}
 	if (!ntfs_check_logfile(tmp_ino, rp)) {
 		iput(tmp_ino);
 		/* ntfs_check_logfile() will have displayed error output. */
-		return FALSE;
+		return false;
 	}
 	NInoSetSparseDisabled(NTFS_I(tmp_ino));
 	vol->logfile_ino = tmp_ino;
 	ntfs_debug("Done.");
-	return TRUE;
+	return true;
 }
 
 #define NTFS_HIBERFIL_HEADER_SIZE	4096
@@ -1329,10 +1329,10 @@ iput_out:
  * load_and_init_quota - load and setup the quota file for a volume if present
  * @vol:	ntfs super block describing device whose quota file to load
  *
- * Return TRUE on success or FALSE on error.  If $Quota is not present, we
+ * Return 'true' on success or 'false' on error.  If $Quota is not present, we
  * leave vol->quota_ino as NULL and return success.
  */
-static BOOL load_and_init_quota(ntfs_volume *vol)
+static bool load_and_init_quota(ntfs_volume *vol)
 {
 	MFT_REF mref;
 	struct inode *tmp_ino;
@@ -1366,11 +1366,11 @@ static BOOL load_and_init_quota(ntfs_vol
 			 * not enabled.
 			 */
 			NVolSetQuotaOutOfDate(vol);
-			return TRUE;
+			return true;
 		}
 		/* A real error occured. */
 		ntfs_error(vol->sb, "Failed to find inode number for $Quota.");
-		return FALSE;
+		return false;
 	}
 	/* We do not care for the type of match that was found. */
 	kfree(name);
@@ -1380,25 +1380,25 @@ static BOOL load_and_init_quota(ntfs_vol
 		if (!IS_ERR(tmp_ino))
 			iput(tmp_ino);
 		ntfs_error(vol->sb, "Failed to load $Quota.");
-		return FALSE;
+		return false;
 	}
 	vol->quota_ino = tmp_ino;
 	/* Get the $Q index allocation attribute. */
 	tmp_ino = ntfs_index_iget(vol->quota_ino, Q, 2);
 	if (IS_ERR(tmp_ino)) {
 		ntfs_error(vol->sb, "Failed to load $Quota/$Q index.");
-		return FALSE;
+		return false;
 	}
 	vol->quota_q_ino = tmp_ino;
 	ntfs_debug("Done.");
-	return TRUE;
+	return true;
 }
 
 /**
  * load_and_init_usnjrnl - load and setup the transaction log if present
  * @vol:	ntfs super block describing device whose usnjrnl file to load
  *
- * Return TRUE on success or FALSE on error.
+ * Return 'true' on success or 'false' on error.
  *
  * If $UsnJrnl is not present or in the process of being disabled, we set
  * NVolUsnJrnlStamped() and return success.
@@ -1408,7 +1408,7 @@ static BOOL load_and_init_quota(ntfs_vol
  * stamped and nothing has been logged since, we also set NVolUsnJrnlStamped()
  * and return success.
  */
-static BOOL load_and_init_usnjrnl(ntfs_volume *vol)
+static bool load_and_init_usnjrnl(ntfs_volume *vol)
 {
 	MFT_REF mref;
 	struct inode *tmp_ino;
@@ -1450,12 +1450,12 @@ not_enabled:
 			 * transaction logging is not enabled.
 			 */
 			NVolSetUsnJrnlStamped(vol);
-			return TRUE;
+			return true;
 		}
 		/* A real error occured. */
 		ntfs_error(vol->sb, "Failed to find inode number for "
 				"$UsnJrnl.");
-		return FALSE;
+		return false;
 	}
 	/* We do not care for the type of match that was found. */
 	kfree(name);
@@ -1465,7 +1465,7 @@ not_enabled:
 		if (!IS_ERR(tmp_ino))
 			iput(tmp_ino);
 		ntfs_error(vol->sb, "Failed to load $UsnJrnl.");
-		return FALSE;
+		return false;
 	}
 	vol->usnjrnl_ino = tmp_ino;
 	/*
@@ -1483,7 +1483,7 @@ not_enabled:
 	if (IS_ERR(tmp_ino)) {
 		ntfs_error(vol->sb, "Failed to load $UsnJrnl/$DATA/$Max "
 				"attribute.");
-		return FALSE;
+		return false;
 	}
 	vol->usnjrnl_max_ino = tmp_ino;
 	if (unlikely(i_size_read(tmp_ino) < sizeof(USN_HEADER))) {
@@ -1491,14 +1491,14 @@ not_enabled:
 				"attribute (size is 0x%llx but should be at "
 				"least 0x%zx bytes).", i_size_read(tmp_ino),
 				sizeof(USN_HEADER));
-		return FALSE;
+		return false;
 	}
 	/* Get the $DATA/$J attribute. */
 	tmp_ino = ntfs_attr_iget(vol->usnjrnl_ino, AT_DATA, J, 2);
 	if (IS_ERR(tmp_ino)) {
 		ntfs_error(vol->sb, "Failed to load $UsnJrnl/$DATA/$J "
 				"attribute.");
-		return FALSE;
+		return false;
 	}
 	vol->usnjrnl_j_ino = tmp_ino;
 	/* Verify $J is non-resident and sparse. */
@@ -1506,14 +1506,14 @@ not_enabled:
 	if (unlikely(!NInoNonResident(tmp_ni) || !NInoSparse(tmp_ni))) {
 		ntfs_error(vol->sb, "$UsnJrnl/$DATA/$J attribute is resident "
 				"and/or not sparse.");
-		return FALSE;
+		return false;
 	}
 	/* Read the USN_HEADER from $DATA/$Max. */
 	page = ntfs_map_page(vol->usnjrnl_max_ino->i_mapping, 0);
 	if (IS_ERR(page)) {
 		ntfs_error(vol->sb, "Failed to read from $UsnJrnl/$DATA/$Max "
 				"attribute.");
-		return FALSE;
+		return false;
 	}
 	uh = (USN_HEADER*)page_address(page);
 	/* Sanity check the $Max. */
@@ -1524,7 +1524,7 @@ not_enabled:
 				(long long)sle64_to_cpu(uh->allocation_delta),
 				(long long)sle64_to_cpu(uh->maximum_size));
 		ntfs_unmap_page(page);
-		return FALSE;
+		return false;
 	}
 	/*
 	 * If the transaction log has been stamped and nothing has been written
@@ -1548,20 +1548,20 @@ not_enabled:
 				(long long)sle64_to_cpu(uh->lowest_valid_usn),
 				i_size_read(vol->usnjrnl_j_ino));
 		ntfs_unmap_page(page);
-		return FALSE;
+		return false;
 	}
 	ntfs_unmap_page(page);
 	ntfs_debug("Done.");
-	return TRUE;
+	return true;
 }
 
 /**
  * load_and_init_attrdef - load the attribute definitions table for a volume
  * @vol:	ntfs super block describing device whose attrdef to load
  *
- * Return TRUE on success or FALSE on error.
+ * Return 'true' on success or 'false' on error.
  */
-static BOOL load_and_init_attrdef(ntfs_volume *vol)
+static bool load_and_init_attrdef(ntfs_volume *vol)
 {
 	loff_t i_size;
 	struct super_block *sb = vol->sb;
@@ -1607,7 +1607,7 @@ read_partial_attrdef_page:
 	vol->attrdef_size = i_size;
 	ntfs_debug("Read %llu bytes from $AttrDef.", i_size);
 	iput(ino);
-	return TRUE;
+	return true;
 free_iput_failed:
 	ntfs_free(vol->attrdef);
 	vol->attrdef = NULL;
@@ -1615,7 +1615,7 @@ iput_failed:
 	iput(ino);
 failed:
 	ntfs_error(sb, "Failed to initialize attribute definition table.");
-	return FALSE;
+	return false;
 }
 
 #endif /* NTFS_RW */
@@ -1624,9 +1624,9 @@ #endif /* NTFS_RW */
  * load_and_init_upcase - load the upcase table for an ntfs volume
  * @vol:	ntfs super block describing device whose upcase to load
  *
- * Return TRUE on success or FALSE on error.
+ * Return 'true' on success or 'false' on error.
  */
-static BOOL load_and_init_upcase(ntfs_volume *vol)
+static bool load_and_init_upcase(ntfs_volume *vol)
 {
 	loff_t i_size;
 	struct super_block *sb = vol->sb;
@@ -1682,7 +1682,7 @@ read_partial_upcase_page:
 		ntfs_debug("Using volume specified $UpCase since default is "
 				"not present.");
 		mutex_unlock(&ntfs_lock);
-		return TRUE;
+		return true;
 	}
 	max = default_upcase_len;
 	if (max > vol->upcase_len)
@@ -1698,12 +1698,12 @@ read_partial_upcase_page:
 		mutex_unlock(&ntfs_lock);
 		ntfs_debug("Volume specified $UpCase matches default. Using "
 				"default.");
-		return TRUE;
+		return true;
 	}
 	mutex_unlock(&ntfs_lock);
 	ntfs_debug("Using volume specified $UpCase since it does not match "
 			"the default.");
-	return TRUE;
+	return true;
 iput_upcase_failed:
 	iput(ino);
 	ntfs_free(vol->upcase);
@@ -1717,11 +1717,11 @@ upcase_failed:
 		mutex_unlock(&ntfs_lock);
 		ntfs_error(sb, "Failed to load $UpCase from the volume. Using "
 				"default.");
-		return TRUE;
+		return true;
 	}
 	mutex_unlock(&ntfs_lock);
 	ntfs_error(sb, "Failed to initialize upcase table.");
-	return FALSE;
+	return false;
 }
 
 /*
@@ -1739,9 +1739,9 @@ static struct lock_class_key
  * Open the system files with normal access functions and complete setting up
  * the ntfs super block @vol.
  *
- * Return TRUE on success or FALSE on error.
+ * Return 'true' on success or 'false' on error.
  */
-static BOOL load_system_files(ntfs_volume *vol)
+static bool load_system_files(ntfs_volume *vol)
 {
 	struct super_block *sb = vol->sb;
 	MFT_RECORD *m;
@@ -2067,7 +2067,7 @@ #endif
 #endif /* NTFS_RW */
 	/* If on NTFS versions before 3.0, we are done. */
 	if (unlikely(vol->major_ver < 3))
-		return TRUE;
+		return true;
 	/* NTFS 3.0+ specific initialization. */
 	/* Get the security descriptors inode. */
 	vol->secure_ino = ntfs_iget(sb, FILE_Secure);
@@ -2173,7 +2173,7 @@ #ifdef NTFS_RW
 		NVolSetErrors(vol);
 	}
 #endif /* NTFS_RW */
-	return TRUE;
+	return true;
 #ifdef NTFS_RW
 iput_usnjrnl_err_out:
 	if (vol->usnjrnl_j_ino)
@@ -2229,7 +2229,7 @@ #ifdef NTFS_RW
 	if (vol->mftmirr_ino)
 		iput(vol->mftmirr_ino);
 #endif /* NTFS_RW */
-	return FALSE;
+	return false;
 }
 
 /**
diff --git a/fs/ntfs/types.h b/fs/ntfs/types.h
index 6e4a7e3..8c8053b 100644
--- a/fs/ntfs/types.h
+++ b/fs/ntfs/types.h
@@ -62,11 +62,6 @@ typedef s64 USN;
 typedef sle64 leUSN;
 
 typedef enum {
-	FALSE = 0,
-	TRUE = 1
-} BOOL;
-
-typedef enum {
 	CASE_SENSITIVE = 0,
 	IGNORE_CASE = 1,
 } IGNORE_CASE_BOOL;
diff --git a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
index b123c0f..c92a7cf 100644
--- a/fs/ntfs/unistr.c
+++ b/fs/ntfs/unistr.c
@@ -61,16 +61,16 @@ static const u8 legal_ansi_char_array[0x
  * @upcase:		upcase table (only if @ic == IGNORE_CASE)
  * @upcase_size:	length in Unicode characters of @upcase (if present)
  *
- * Compare the names @s1 and @s2 and return TRUE (1) if the names are
- * identical, or FALSE (0) if they are not identical. If @ic is IGNORE_CASE,
+ * Compare the names @s1 and @s2 and return 'true' (1) if the names are
+ * identical, or 'false' (0) if they are not identical. If @ic is IGNORE_CASE,
  * the @upcase table is used to performa a case insensitive comparison.
  */
-BOOL ntfs_are_names_equal(const ntfschar *s1, size_t s1_len,
+bool ntfs_are_names_equal(const ntfschar *s1, size_t s1_len,
 		const ntfschar *s2, size_t s2_len, const IGNORE_CASE_BOOL ic,
 		const ntfschar *upcase, const u32 upcase_size)
 {
 	if (s1_len != s2_len)
-		return FALSE;
+		return false;
 	if (ic == CASE_SENSITIVE)
 		return !ntfs_ucsncmp(s1, s2, s1_len);
 	return !ntfs_ucsncasecmp(s1, s2, s1_len, upcase, upcase_size);
diff --git a/fs/ntfs/usnjrnl.c b/fs/ntfs/usnjrnl.c
index 7777324..b2bc0d5 100644
--- a/fs/ntfs/usnjrnl.c
+++ b/fs/ntfs/usnjrnl.c
@@ -39,12 +39,12 @@ #include "volume.h"
  * @vol:	ntfs volume on which to stamp the transaction log
  *
  * Stamp the transaction log ($UsnJrnl) on the ntfs volume @vol and return
- * TRUE on success and FALSE on error.
+ * 'true' on success and 'false' on error.
  *
  * This function assumes that the transaction log has already been loaded and
  * consistency checked by a call to fs/ntfs/super.c::load_and_init_usnjrnl().
  */
-BOOL ntfs_stamp_usnjrnl(ntfs_volume *vol)
+bool ntfs_stamp_usnjrnl(ntfs_volume *vol)
 {
 	ntfs_debug("Entering.");
 	if (likely(!NVolUsnJrnlStamped(vol))) {
@@ -56,7 +56,7 @@ BOOL ntfs_stamp_usnjrnl(ntfs_volume *vol
 		if (IS_ERR(page)) {
 			ntfs_error(vol->sb, "Failed to read from "
 					"$UsnJrnl/$DATA/$Max attribute.");
-			return FALSE;
+			return false;
 		}
 		uh = (USN_HEADER*)page_address(page);
 		stamp = get_current_ntfs_time();
@@ -78,7 +78,7 @@ BOOL ntfs_stamp_usnjrnl(ntfs_volume *vol
 		NVolSetUsnJrnlStamped(vol);
 	}
 	ntfs_debug("Done.");
-	return TRUE;
+	return true;
 }
 
 #endif /* NTFS_RW */
diff --git a/fs/ntfs/usnjrnl.h b/fs/ntfs/usnjrnl.h
index ff988b0..3a8af75 100644
--- a/fs/ntfs/usnjrnl.h
+++ b/fs/ntfs/usnjrnl.h
@@ -198,7 +198,7 @@ typedef struct {
 /* sizeof() = 60 (0x3c) bytes */
 } __attribute__ ((__packed__)) USN_RECORD;
 
-extern BOOL ntfs_stamp_usnjrnl(ntfs_volume *vol);
+extern bool ntfs_stamp_usnjrnl(ntfs_volume *vol);
 
 #endif /* NTFS_RW */
 


