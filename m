Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933185AbWF3ASt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185AbWF3ASt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933170AbWF3ASN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:18:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:21448 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S933165AbWF3ARj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:17:39 -0400
Subject: [RFC][Update][Patch 5/16]block type convert in extents
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:17:37 -0700
Message-Id: <1151626657.6601.74.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

convert in-kernel filesystem blocks type to ext3_fsblk_t.

Signed-Off-By: Avantika Mathur <mathur@us.ibm.com> 
Acked-By: Alex Tomas <alex@us.ibm.com>


---

 linux-2.6.17-ming/fs/ext3/extents.c               |  106 +++++++++++-----------
 linux-2.6.17-ming/include/linux/ext3_fs_extents.h |    2 
 linux-2.6.17-ming/include/linux/ext3_fs_i.h       |    8 -
 3 files changed, 59 insertions(+), 57 deletions(-)

diff -puN fs/ext3/extents.c~ext3-extents-ext3_fsblk_t fs/ext3/extents.c
--- linux-2.6.17/fs/ext3/extents.c~ext3-extents-ext3_fsblk_t	2006-06-28 16:46:45.589224909 -0700
+++ linux-2.6.17-ming/fs/ext3/extents.c	2006-06-28 16:46:45.603223303 -0700
@@ -44,41 +44,41 @@
 #include <asm/uaccess.h>
 
 
-/* this macro combines low and hi parts of phys. blocknr into sector_t */
-static inline sector_t ext_pblock(struct ext3_extent *ex)
+/* this macro combines low and hi parts of phys. blocknr into ext3_fsblk_t */
+static inline ext3_fsblk_t ext_pblock(struct ext3_extent *ex)
 {
-	sector_t block;
+	ext3_fsblk_t block;
 
 	block = le32_to_cpu(ex->ee_start);
-	if (sizeof(sector_t) > 4)
-		block |= ((sector_t) le16_to_cpu(ex->ee_start_hi) << 31) << 1;
+	if (sizeof(ext3_fsblk_t) > 4)
+		block |= ((ext3_fsblk_t) le16_to_cpu(ex->ee_start_hi) << 31) << 1;
 	return block;
 }
 
-/* this macro combines low and hi parts of phys. blocknr into sector_t */
-static inline sector_t idx_pblock(struct ext3_extent_idx *ix)
+/* this macro combines low and hi parts of phys. blocknr into ext3_fsblk_t */
+static inline ext3_fsblk_t idx_pblock(struct ext3_extent_idx *ix)
 {
-	sector_t block;
+	ext3_fsblk_t block;
 
 	block = le32_to_cpu(ix->ei_leaf);
-	if (sizeof(sector_t) > 4)
-		block |= ((sector_t) le16_to_cpu(ix->ei_leaf_hi) << 31) << 1;
+	if (sizeof(ext3_fsblk_t) > 4)
+		block |= ((ext3_fsblk_t) le16_to_cpu(ix->ei_leaf_hi) << 31) << 1;
 	return block;
 }
 
 /* the routine stores large phys. blocknr into extent breaking it into parts */
-static inline void ext3_ext_store_pblock(struct ext3_extent *ex, sector_t pb)
+static inline void ext3_ext_store_pblock(struct ext3_extent *ex, ext3_fsblk_t pb)
 {
 	ex->ee_start = cpu_to_le32((unsigned long) (pb & 0xffffffff));
-	if (sizeof(sector_t) > 4)
+	if (sizeof(ext3_fsblk_t) > 4)
 		ex->ee_start_hi = cpu_to_le16((unsigned long) ((pb >> 31) >> 1) & 0xffff);
 }
 
 /* the routine stores large phys. blocknr into index breaking it into parts */
-static inline void ext3_idx_store_pblock(struct ext3_extent_idx *ix, sector_t pb)
+static inline void ext3_idx_store_pblock(struct ext3_extent_idx *ix, ext3_fsblk_t pb)
 {
 	ix->ei_leaf = cpu_to_le32((unsigned long) (pb & 0xffffffff));
-	if (sizeof(sector_t) > 4)
+	if (sizeof(ext3_fsblk_t) > 4)
 		ix->ei_leaf_hi = cpu_to_le16((unsigned long) ((pb >> 31) >> 1) & 0xffff);
 }
 
@@ -162,13 +162,13 @@ static int ext3_ext_dirty(handle_t *hand
 	return err;
 }
 
-static int ext3_ext_find_goal(struct inode *inode,
+static ext3_fsblk_t ext3_ext_find_goal(struct inode *inode,
 			      struct ext3_ext_path *path,
-			      sector_t block)
+			      ext3_fsblk_t block)
 {
 	struct ext3_inode_info *ei = EXT3_I(inode);
-	unsigned long bg_start;
-	unsigned long colour;
+	ext3_fsblk_t bg_start;
+	ext3_grpblk_t colour;
 	int depth;
 
 	if (path) {
@@ -193,12 +193,12 @@ static int ext3_ext_find_goal(struct ino
 	return bg_start + colour + block;
 }
 
-static int
+static ext3_fsblk_t
 ext3_ext_new_block(handle_t *handle, struct inode *inode,
 			struct ext3_ext_path *path,
 			struct ext3_extent *ex, int *err)
 {
-	int goal, newblock;
+	ext3_fsblk_t goal, newblock;
 
 	goal = ext3_ext_find_goal(inode, path, le32_to_cpu(ex->ee_block));
 	newblock = ext3_new_block(handle, inode, goal, err);
@@ -267,10 +267,10 @@ static void ext3_ext_show_path(struct in
 	ext_debug("path:");
 	for (k = 0; k <= l; k++, path++) {
 		if (path->p_idx) {
-		  ext_debug("  %d->%llu", le32_to_cpu(path->p_idx->ei_block),
+		  ext_debug("  %d->"E3FSBLK, le32_to_cpu(path->p_idx->ei_block),
 			    idx_pblock(path->p_idx));
 		} else if (path->p_ext) {
-			ext_debug("  %d:%d:%lld",
+			ext_debug("  %d:%d:"E3FSBLK" ",
 				  le32_to_cpu(path->p_ext->ee_block),
 				  le16_to_cpu(path->p_ext->ee_len),
 				  ext_pblock(path->p_ext));
@@ -294,7 +294,7 @@ static void ext3_ext_show_leaf(struct in
 	ex = EXT_FIRST_EXTENT(eh);
 
 	for (i = 0; i < le16_to_cpu(eh->eh_entries); i++, ex++) {
-		ext_debug("%d:%d:%lld ", le32_to_cpu(ex->ee_block),
+		ext_debug("%d:%d:"E3FSBLK" ", le32_to_cpu(ex->ee_block),
 			  le16_to_cpu(ex->ee_len), ext_pblock(ex));
 	}
 	ext_debug("\n");
@@ -410,7 +410,7 @@ ext3_ext_binsearch(struct inode *inode, 
 	}
 
 	path->p_ext = l - 1;
-	ext_debug("  -> %d:%lld:%d ",
+	ext_debug("  -> %d:"E3FSBLK":%d ",
 		        le32_to_cpu(path->p_ext->ee_block),
 		        ext_pblock(path->p_ext),
 			le16_to_cpu(path->p_ext->ee_len));
@@ -525,7 +525,7 @@ err:
  */
 static int ext3_ext_insert_index(handle_t *handle, struct inode *inode,
 				struct ext3_ext_path *curp,
-				int logical, int ptr)
+				int logical, ext3_fsblk_t ptr)
 {
 	struct ext3_extent_idx *ix;
 	int len, err;
@@ -592,9 +592,9 @@ static int ext3_ext_split(handle_t *hand
 	struct ext3_extent_idx *fidx;
 	struct ext3_extent *ex;
 	int i = at, k, m, a;
-	unsigned long newblock, oldblock;
+	ext3_fsblk_t newblock, oldblock;
 	__le32 border;
-	int *ablocks = NULL; /* array of allocated blocks */
+	ext3_fsblk_t *ablocks = NULL; /* array of allocated blocks */
 	int err = 0;
 
 	/* make decision: where to split? */
@@ -627,10 +627,10 @@ static int ext3_ext_split(handle_t *hand
 	 * we need this to handle errors and free blocks
 	 * upon them
 	 */
-	ablocks = kmalloc(sizeof(unsigned long) * depth, GFP_NOFS);
+	ablocks = kmalloc(sizeof(ext3_fsblk_t) * depth, GFP_NOFS);
 	if (!ablocks)
 		return -ENOMEM;
-	memset(ablocks, 0, sizeof(unsigned long) * depth);
+	memset(ablocks, 0, sizeof(ext3_fsblk_t) * depth);
 
 	/* allocate all needed blocks */
 	ext_debug("allocate %d blocks for indexes/leaf\n", depth - at);
@@ -669,7 +669,7 @@ static int ext3_ext_split(handle_t *hand
 	path[depth].p_ext++;
 	while (path[depth].p_ext <=
 			EXT_MAX_EXTENT(path[depth].p_hdr)) {
-		ext_debug("move %d:%lld:%d in new leaf %lu\n",
+		ext_debug("move %d:"E3FSBLK":%d in new leaf "E3FSBLK"\n",
 			        le32_to_cpu(path[depth].p_ext->ee_block),
 			        ext_pblock(path[depth].p_ext),
 			        le16_to_cpu(path[depth].p_ext->ee_len),
@@ -715,7 +715,7 @@ static int ext3_ext_split(handle_t *hand
 	while (k--) {
 		oldblock = newblock;
 		newblock = ablocks[--a];
-		bh = sb_getblk(inode->i_sb, newblock);
+		bh = sb_getblk(inode->i_sb, (ext3_fsblk_t)newblock);
 		if (!bh) {
 			err = -EIO;
 			goto cleanup;
@@ -734,7 +734,7 @@ static int ext3_ext_split(handle_t *hand
 		fidx->ei_block = border;
 		ext3_idx_store_pblock(fidx, oldblock);
 
-		ext_debug("int.index at %d (block %lu): %lu -> %lu\n", i,
+		ext_debug("int.index at %d (block "E3FSBLK"): %lu -> "E3FSBLK"\n", i,
 				newblock, (unsigned long) le32_to_cpu(border),
 			  	oldblock);
 		/* copy indexes */
@@ -746,7 +746,7 @@ static int ext3_ext_split(handle_t *hand
 		BUG_ON(EXT_MAX_INDEX(path[i].p_hdr) !=
 				EXT_LAST_INDEX(path[i].p_hdr));
 		while (path[i].p_idx <= EXT_MAX_INDEX(path[i].p_hdr)) {
-			ext_debug("%d: move %d:%d in new index %llu\n", i,
+			ext_debug("%d: move %d:%d in new index "E3FSBLK"\n", i,
 				        le32_to_cpu(path[i].p_idx->ei_block),
 				        idx_pblock(path[i].p_idx),
 				        newblock);
@@ -827,7 +827,7 @@ static int ext3_ext_grow_indepth(handle_
 	struct ext3_extent_header *neh;
 	struct ext3_extent_idx *fidx;
 	struct buffer_head *bh;
-	unsigned long newblock;
+	ext3_fsblk_t newblock;
 	int err = 0;
 
 	newblock = ext3_ext_new_block(handle, inode, path, newext, &err);
@@ -879,7 +879,7 @@ static int ext3_ext_grow_indepth(handle_
 
 	neh = ext_inode_hdr(inode);
 	fidx = EXT_FIRST_INDEX(neh);
-	ext_debug("new root: num %d(%d), lblock %d, ptr %llu\n",
+	ext_debug("new root: num %d(%d), lblock %d, ptr "E3FSBLK"\n",
 		  le16_to_cpu(neh->eh_entries), le16_to_cpu(neh->eh_max),
 		  le32_to_cpu(fidx->ei_block), idx_pblock(fidx));
 
@@ -1114,7 +1114,7 @@ int ext3_ext_insert_extent(handle_t *han
 
 	/* try to insert block into found extent and return */
 	if (ex && ext3_can_extents_be_merged(inode, ex, newext)) {
-		ext_debug("append %d block to %d:%d (from %lld)\n",
+		ext_debug("append %d block to %d:%d (from "E3FSBLK")\n",
 				le16_to_cpu(newext->ee_len),
 				le32_to_cpu(ex->ee_block),
 				le16_to_cpu(ex->ee_len), ext_pblock(ex));
@@ -1173,7 +1173,7 @@ has_space:
 
 	if (!nearex) {
 		/* there is no extent in this leaf, create first one */
-		ext_debug("first extent in the leaf: %d:%lld:%d\n",
+		ext_debug("first extent in the leaf: %d:"E3FSBLK":%d\n",
 			        le32_to_cpu(newext->ee_block),
 			        ext_pblock(newext),
 			        le16_to_cpu(newext->ee_len));
@@ -1185,7 +1185,7 @@ has_space:
 			len = EXT_MAX_EXTENT(eh) - nearex;
 			len = (len - 1) * sizeof(struct ext3_extent);
 			len = len < 0 ? 0 : len;
-			ext_debug("insert %d:%lld:%d after: nearest 0x%p, "
+			ext_debug("insert %d:"E3FSBLK":%d after: nearest 0x%p, "
 					"move %d from 0x%p to 0x%p\n",
 				        le32_to_cpu(newext->ee_block),
 				        ext_pblock(newext),
@@ -1198,7 +1198,7 @@ has_space:
  		BUG_ON(newext->ee_block == nearex->ee_block);
 		len = (EXT_MAX_EXTENT(eh) - nearex) * sizeof(struct ext3_extent);
 		len = len < 0 ? 0 : len;
-		ext_debug("insert %d:%lld:%d before: nearest 0x%p, "
+		ext_debug("insert %d:"E3FSBLK":%d before: nearest 0x%p, "
 				"move %d from 0x%p to 0x%p\n",
 				le32_to_cpu(newext->ee_block),
 				ext_pblock(newext),
@@ -1432,11 +1432,11 @@ ext3_ext_in_cache(struct inode *inode, u
 	        ex->ee_block = cpu_to_le32(cex->ec_block);
 		ext3_ext_store_pblock(ex, cex->ec_start);
 	        ex->ee_len = cpu_to_le16(cex->ec_len);
-		ext_debug("%lu cached by %lu:%lu:%lu\n",
+		ext_debug("%lu cached by %lu:%lu:"E3FSBLK"\n",
 				(unsigned long) block,
 				(unsigned long) cex->ec_block,
 				(unsigned long) cex->ec_len,
-				(unsigned long) cex->ec_start);
+				cex->ec_start);
 		return cex->ec_type;
 	}
 
@@ -1454,7 +1454,7 @@ int ext3_ext_rm_idx(handle_t *handle, st
 {
 	struct buffer_head *bh;
 	int err;
-	unsigned long leaf;
+	ext3_fsblk_t leaf;
 
 	/* free index block */
 	path--;
@@ -1465,7 +1465,7 @@ int ext3_ext_rm_idx(handle_t *handle, st
 	path->p_hdr->eh_entries = cpu_to_le16(le16_to_cpu(path->p_hdr->eh_entries)-1);
 	if ((err = ext3_ext_dirty(handle, inode, path)))
 		return err;
-	ext_debug("index is empty, remove it, free block %lu\n", leaf);
+	ext_debug("index is empty, remove it, free block "E3FSBLK"\n", leaf);
 	bh = sb_find_get_block(inode->i_sb, leaf);
 	ext3_forget(handle, 1, inode, bh, leaf);
 	ext3_free_blocks(handle, inode, leaf, 1);
@@ -1547,10 +1547,11 @@ static int ext3_remove_blocks(handle_t *
 	if (from >= le32_to_cpu(ex->ee_block)
 	    && to == le32_to_cpu(ex->ee_block) + le16_to_cpu(ex->ee_len) - 1) {
 		/* tail removal */
-		unsigned long num, start;
+		unsigned long num;
+		ext3_fsblk_t start;
 		num = le32_to_cpu(ex->ee_block) + le16_to_cpu(ex->ee_len) - from;
 		start = ext_pblock(ex) + le16_to_cpu(ex->ee_len) - num;
-		ext_debug("free last %lu blocks starting %lu\n", num, start);
+		ext_debug("free last %lu blocks starting "E3FSBLK"\n", num, start);
 		for (i = 0; i < num; i++) {
 			bh = sb_find_get_block(inode->i_sb, start + i);
 			ext3_forget(handle, 0, inode, bh, start + i);
@@ -1664,7 +1665,7 @@ ext3_ext_rm_leaf(handle_t *handle, struc
 		if (err)
 			goto out;
 
-		ext_debug("new extent: %u:%u:%llu\n", block, num,
+		ext_debug("new extent: %u:%u:"E3FSBLK"\n", block, num,
 				ext_pblock(ex));
 		ex--;
 		ex_ee_block = le32_to_cpu(ex->ee_block);
@@ -1780,7 +1781,7 @@ int ext3_ext_remove_space(struct inode *
 				path[i].p_idx);
 		if (ext3_ext_more_to_rm(path + i)) {
 			/* go to the next level */
-			ext_debug("move to level %d (block %llu)\n",
+			ext_debug("move to level %d (block "E3FSBLK")\n",
 				  i + 1, idx_pblock(path[i].p_idx));
 			memset(path + i + 1, 0, sizeof(*path));
 			path[i+1].p_bh =
@@ -1883,13 +1884,14 @@ void ext3_ext_release(struct super_block
 #endif
 }
 
-int ext3_ext_get_blocks(handle_t *handle, struct inode *inode, sector_t iblock,
+int ext3_ext_get_blocks(handle_t *handle, struct inode *inode, ext3_fsblk_t iblock,
 			unsigned long max_blocks, struct buffer_head *bh_result,
 			int create, int extend_disksize)
 {
 	struct ext3_ext_path *path = NULL;
 	struct ext3_extent newex, *ex;
-	int goal, newblock, err = 0, depth;
+	ext3_fsblk_t goal, newblock;
+	int err = 0, depth;
 	unsigned long allocated = 0;
 
 	__clear_bit(BH_New, &bh_result->b_state);
@@ -1939,14 +1941,14 @@ int ext3_ext_get_blocks(handle_t *handle
 
 	if ((ex = path[depth].p_ext)) {
 	        unsigned long ee_block = le32_to_cpu(ex->ee_block);
-		unsigned long ee_start = ext_pblock(ex);
+		ext3_fsblk_t ee_start = ext_pblock(ex);
 		unsigned short ee_len  = le16_to_cpu(ex->ee_len);
 		/* if found exent covers block, simple return it */
 	        if (iblock >= ee_block && iblock < ee_block + ee_len) {
 			newblock = iblock - ee_block + ee_start;
 			/* number of remain blocks in the extent */
 			allocated = ee_len - (iblock - ee_block);
-			ext_debug("%d fit into %lu:%d -> %d\n", (int) iblock,
+			ext_debug("%d fit into %lu:%d -> "E3FSBLK"\n", (int) iblock,
 					ee_block, ee_len, newblock);
 			ext3_ext_put_in_cache(inode, ee_block, ee_len,
 						ee_start, EXT3_EXT_CACHE_EXTENT);
@@ -1970,7 +1972,7 @@ int ext3_ext_get_blocks(handle_t *handle
 	newblock = ext3_new_blocks(handle, inode, goal, &allocated, &err);
 	if (!newblock)
 		goto out2;
-	ext_debug("allocate new block: goal %d, found %d/%lu\n",
+	ext_debug("allocate new block: goal "E3FSBLK", found "E3FSBLK"/%lu\n",
 			goal, newblock, allocated);
 
 	/* try to insert new extent into found leaf and return */
diff -puN include/linux/ext3_fs_extents.h~ext3-extents-ext3_fsblk_t include/linux/ext3_fs_extents.h
--- linux-2.6.17/include/linux/ext3_fs_extents.h~ext3-extents-ext3_fsblk_t	2006-06-28 16:46:45.592224565 -0700
+++ linux-2.6.17-ming/include/linux/ext3_fs_extents.h	2006-06-28 16:46:45.604223188 -0700
@@ -108,7 +108,7 @@ struct ext3_extent_header {
  * truncate uses it to simulate recursive walking
  */
 struct ext3_ext_path {
-	__u64				p_block;
+	ext3_fsblk_t			p_block;
 	__u16				p_depth;
 	struct ext3_extent		*p_ext;
 	struct ext3_extent_idx		*p_idx;
diff -puN include/linux/ext3_fs_i.h~ext3-extents-ext3_fsblk_t include/linux/ext3_fs_i.h
--- linux-2.6.17/include/linux/ext3_fs_i.h~ext3-extents-ext3_fsblk_t	2006-06-28 16:46:45.596224106 -0700
+++ linux-2.6.17-ming/include/linux/ext3_fs_i.h	2006-06-28 16:46:45.604223188 -0700
@@ -68,10 +68,10 @@ struct ext3_block_alloc_info {
  * storage for cached extent
  */
 struct ext3_ext_cache {
-	sector_t ec_start;
-	__u32	ec_block;
-	__u32	ec_len; /* must be 32bit to return holes */
-	__u32	ec_type;
+	ext3_fsblk_t	ec_start;
+	__u32		ec_block;
+	__u32		ec_len; /* must be 32bit to return holes */
+	__u32		ec_type;
 };
 
 /*

_


