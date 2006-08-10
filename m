Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030540AbWHJBWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030540AbWHJBWO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbWHJBWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:22:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:51849 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030543AbWHJBWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:22:03 -0400
Subject: [PATCH 4/9] 48bit support in extents
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 09 Aug 2006 18:21:13 -0700
Message-Id: <1155172873.3161.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


48bit physical block number support in extents.

Signed-Off-By: Alex Tomas <alex@clusterfs.com>
Signed-Off-By: Mingming Cao <cmm@us.ibm.com>

---

 linux-2.6.18-rc4-ming/fs/ext4/extents.c               |  186 ++++++++++--------
 linux-2.6.18-rc4-ming/include/linux/ext4_fs_extents.h |    2 
 linux-2.6.18-rc4-ming/include/linux/ext4_fs_i.h       |    8 
 3 files changed, 115 insertions(+), 81 deletions(-)

diff -puN fs/ext4/extents.c~ext4-extents-48bit fs/ext4/extents.c
--- linux-2.6.18-rc4/fs/ext4/extents.c~ext4-extents-48bit	2006-08-09 15:41:54.464309661 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/extents.c	2006-08-09 15:41:54.481309799 -0700
@@ -44,6 +44,44 @@
 #include <asm/uaccess.h>
 

+/* this macro combines low and hi parts of phys. blocknr into ext4_fsblk_t */
+static inline ext4_fsblk_t ext_pblock(struct ext4_extent *ex)
+{
+	ext4_fsblk_t block;
+
+	block = le32_to_cpu(ex->ee_start);
+	if (sizeof(ext4_fsblk_t) > 4)
+		block |= ((ext4_fsblk_t) le16_to_cpu(ex->ee_start_hi) << 31) << 1;
+	return block;
+}
+
+/* this macro combines low and hi parts of phys. blocknr into ext4_fsblk_t */
+static inline ext4_fsblk_t idx_pblock(struct ext4_extent_idx *ix)
+{
+	ext4_fsblk_t block;
+
+	block = le32_to_cpu(ix->ei_leaf);
+	if (sizeof(ext4_fsblk_t) > 4)
+		block |= ((ext4_fsblk_t) le16_to_cpu(ix->ei_leaf_hi) << 31) << 1;
+	return block;
+}
+
+/* the routine stores large phys. blocknr into extent breaking it into parts */
+static inline void ext4_ext_store_pblock(struct ext4_extent *ex, ext4_fsblk_t pb)
+{
+	ex->ee_start = cpu_to_le32((unsigned long) (pb & 0xffffffff));
+	if (sizeof(ext4_fsblk_t) > 4)
+		ex->ee_start_hi = cpu_to_le16((unsigned long) ((pb >> 31) >> 1) & 0xffff);
+}
+
+/* the routine stores large phys. blocknr into index breaking it into parts */
+static inline void ext4_idx_store_pblock(struct ext4_extent_idx *ix, ext4_fsblk_t pb)
+{
+	ix->ei_leaf = cpu_to_le32((unsigned long) (pb & 0xffffffff));
+	if (sizeof(ext4_fsblk_t) > 4)
+		ix->ei_leaf_hi = cpu_to_le16((unsigned long) ((pb >> 31) >> 1) & 0xffff);
+}
+
 static int ext4_ext_check_header(const char *function, struct inode *inode,
 				struct ext4_extent_header *eh)
 {
@@ -124,13 +162,13 @@ static int ext4_ext_dirty(handle_t *hand
 	return err;
 }
 
-static int ext4_ext_find_goal(struct inode *inode,
+static ext4_fsblk_t ext4_ext_find_goal(struct inode *inode,
 			      struct ext4_ext_path *path,
-			      unsigned long block)
+			      ext4_fsblk_t block)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	unsigned long bg_start;
-	unsigned long colour;
+	ext4_fsblk_t bg_start;
+	ext4_grpblk_t colour;
 	int depth;
 
 	if (path) {
@@ -139,8 +177,7 @@ static int ext4_ext_find_goal(struct ino
 
 		/* try to predict block placement */
 		if ((ex = path[depth].p_ext))
-			return le32_to_cpu(ex->ee_start)
-					+ (block - le32_to_cpu(ex->ee_block));
+			return ext_pblock(ex)+(block-le32_to_cpu(ex->ee_block));
 
 		/* it looks index is empty
 		 * try to find starting from index itself */
@@ -156,12 +193,12 @@ static int ext4_ext_find_goal(struct ino
 	return bg_start + colour + block;
 }
 
-static int
+static ext4_fsblk_t
 ext4_ext_new_block(handle_t *handle, struct inode *inode,
 			struct ext4_ext_path *path,
 			struct ext4_extent *ex, int *err)
 {
-	int goal, newblock;
+	ext4_fsblk_t goal, newblock;
 
 	goal = ext4_ext_find_goal(inode, path, le32_to_cpu(ex->ee_block));
 	newblock = ext4_new_block(handle, inode, goal, err);
@@ -230,13 +267,13 @@ static void ext4_ext_show_path(struct in
 	ext_debug("path:");
 	for (k = 0; k <= l; k++, path++) {
 		if (path->p_idx) {
-		  ext_debug("  %d->%d", le32_to_cpu(path->p_idx->ei_block),
-			    le32_to_cpu(path->p_idx->ei_leaf));
+		  ext_debug("  %d->"E3FSBLK, le32_to_cpu(path->p_idx->ei_block),
+			    idx_pblock(path->p_idx));
 		} else if (path->p_ext) {
-			ext_debug("  %d:%d:%d",
+			ext_debug("  %d:%d:"E3FSBLK" ",
 				  le32_to_cpu(path->p_ext->ee_block),
 				  le16_to_cpu(path->p_ext->ee_len),
-				  le32_to_cpu(path->p_ext->ee_start));
+				  ext_pblock(path->p_ext));
 		} else
 			ext_debug("  []");
 	}
@@ -257,9 +294,8 @@ static void ext4_ext_show_leaf(struct in
 	ex = EXT_FIRST_EXTENT(eh);
 
 	for (i = 0; i < le16_to_cpu(eh->eh_entries); i++, ex++) {
-		ext_debug("%d:%d:%d ", le32_to_cpu(ex->ee_block),
-			  le16_to_cpu(ex->ee_len),
-			  le32_to_cpu(ex->ee_start));
+		ext_debug("%d:%d:"E3FSBLK" ", le32_to_cpu(ex->ee_block),
+			  le16_to_cpu(ex->ee_len), ext_pblock(ex));
 	}
 	ext_debug("\n");
 }
@@ -308,8 +344,8 @@ ext4_ext_binsearch_idx(struct inode *ino
 	}
 
 	path->p_idx = l - 1;
-	ext_debug("  -> %d->%d ", le32_to_cpu(path->p_idx->ei_block),
-		  le32_to_cpu(path->p_idx->ei_leaf));
+	ext_debug("  -> %d->%lld ", le32_to_cpu(path->p_idx->ei_block),
+		  idx_block(path->p_idx));
 
 #ifdef CHECK_BINSEARCH
 	{
@@ -374,10 +410,10 @@ ext4_ext_binsearch(struct inode *inode, 
 	}
 
 	path->p_ext = l - 1;
-	ext_debug("  -> %d:%d:%d ",
+	ext_debug("  -> %d:"E3FSBLK":%d ",
 		        le32_to_cpu(path->p_ext->ee_block),
-		        le32_to_cpu(path->p_ext->ee_start),
-		        le16_to_cpu(path->p_ext->ee_len));
+		        ext_pblock(path->p_ext),
+			le16_to_cpu(path->p_ext->ee_len));
 
 #ifdef CHECK_BINSEARCH
 	{
@@ -442,7 +478,7 @@ ext4_ext_find_extent(struct inode *inode
 		ext_debug("depth %d: num %d, max %d\n",
 			  ppos, le16_to_cpu(eh->eh_entries), le16_to_cpu(eh->eh_max));
 		ext4_ext_binsearch_idx(inode, path + ppos, block);
-		path[ppos].p_block = le32_to_cpu(path[ppos].p_idx->ei_leaf);
+		path[ppos].p_block = idx_pblock(path[ppos].p_idx);
 		path[ppos].p_depth = i;
 		path[ppos].p_ext = NULL;
 
@@ -489,7 +525,7 @@ err:
  */
 static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 				struct ext4_ext_path *curp,
-				int logical, int ptr)
+				int logical, ext4_fsblk_t ptr)
 {
 	struct ext4_extent_idx *ix;
 	int len, err;
@@ -524,7 +560,7 @@ static int ext4_ext_insert_index(handle_
 	}
 
 	ix->ei_block = cpu_to_le32(logical);
-	ix->ei_leaf = cpu_to_le32(ptr);
+	ext4_idx_store_pblock(ix, ptr);
 	curp->p_hdr->eh_entries = cpu_to_le16(le16_to_cpu(curp->p_hdr->eh_entries)+1);
 
 	BUG_ON(le16_to_cpu(curp->p_hdr->eh_entries)
@@ -556,9 +592,9 @@ static int ext4_ext_split(handle_t *hand
 	struct ext4_extent_idx *fidx;
 	struct ext4_extent *ex;
 	int i = at, k, m, a;
-	unsigned long newblock, oldblock;
+	ext4_fsblk_t newblock, oldblock;
 	__le32 border;
-	int *ablocks = NULL; /* array of allocated blocks */
+	ext4_fsblk_t *ablocks = NULL; /* array of allocated blocks */
 	int err = 0;
 
 	/* make decision: where to split? */
@@ -591,10 +627,10 @@ static int ext4_ext_split(handle_t *hand
 	 * we need this to handle errors and free blocks
 	 * upon them
 	 */
-	ablocks = kmalloc(sizeof(unsigned long) * depth, GFP_NOFS);
+	ablocks = kmalloc(sizeof(ext4_fsblk_t) * depth, GFP_NOFS);
 	if (!ablocks)
 		return -ENOMEM;
-	memset(ablocks, 0, sizeof(unsigned long) * depth);
+	memset(ablocks, 0, sizeof(ext4_fsblk_t) * depth);
 
 	/* allocate all needed blocks */
 	ext_debug("allocate %d blocks for indexes/leaf\n", depth - at);
@@ -633,9 +669,9 @@ static int ext4_ext_split(handle_t *hand
 	path[depth].p_ext++;
 	while (path[depth].p_ext <=
 			EXT_MAX_EXTENT(path[depth].p_hdr)) {
-		ext_debug("move %d:%d:%d in new leaf %lu\n",
+		ext_debug("move %d:"E3FSBLK":%d in new leaf "E3FSBLK"\n",
 			        le32_to_cpu(path[depth].p_ext->ee_block),
-			        le32_to_cpu(path[depth].p_ext->ee_start),
+			        ext_pblock(path[depth].p_ext),
 			        le16_to_cpu(path[depth].p_ext->ee_len),
 				newblock);
 		/*memmove(ex++, path[depth].p_ext++,
@@ -679,7 +715,7 @@ static int ext4_ext_split(handle_t *hand
 	while (k--) {
 		oldblock = newblock;
 		newblock = ablocks[--a];
-		bh = sb_getblk(inode->i_sb, newblock);
+		bh = sb_getblk(inode->i_sb, (ext4_fsblk_t)newblock);
 		if (!bh) {
 			err = -EIO;
 			goto cleanup;
@@ -696,9 +732,9 @@ static int ext4_ext_split(handle_t *hand
 		neh->eh_depth = cpu_to_le16(depth - i);
 		fidx = EXT_FIRST_INDEX(neh);
 		fidx->ei_block = border;
-		fidx->ei_leaf = cpu_to_le32(oldblock);
+		ext4_idx_store_pblock(fidx, oldblock);
 
-		ext_debug("int.index at %d (block %lu): %lu -> %lu\n", i,
+		ext_debug("int.index at %d (block "E3FSBLK"): %lu -> "E3FSBLK"\n", i,
 				newblock, (unsigned long) le32_to_cpu(border),
 			  	oldblock);
 		/* copy indexes */
@@ -710,9 +746,9 @@ static int ext4_ext_split(handle_t *hand
 		BUG_ON(EXT_MAX_INDEX(path[i].p_hdr) !=
 				EXT_LAST_INDEX(path[i].p_hdr));
 		while (path[i].p_idx <= EXT_MAX_INDEX(path[i].p_hdr)) {
-			ext_debug("%d: move %d:%d in new index %lu\n", i,
+			ext_debug("%d: move %d:%d in new index "E3FSBLK"\n", i,
 				        le32_to_cpu(path[i].p_idx->ei_block),
-				        le32_to_cpu(path[i].p_idx->ei_leaf),
+				        idx_pblock(path[i].p_idx),
 				        newblock);
 			/*memmove(++fidx, path[i].p_idx++,
 					sizeof(struct ext4_extent_idx));
@@ -791,7 +827,7 @@ static int ext4_ext_grow_indepth(handle_
 	struct ext4_extent_header *neh;
 	struct ext4_extent_idx *fidx;
 	struct buffer_head *bh;
-	unsigned long newblock;
+	ext4_fsblk_t newblock;
 	int err = 0;
 
 	newblock = ext4_ext_new_block(handle, inode, path, newext, &err);
@@ -839,13 +875,13 @@ static int ext4_ext_grow_indepth(handle_
 	curp->p_idx = EXT_FIRST_INDEX(curp->p_hdr);
 	/* FIXME: it works, but actually path[0] can be index */
 	curp->p_idx->ei_block = EXT_FIRST_EXTENT(path[0].p_hdr)->ee_block;
-	curp->p_idx->ei_leaf = cpu_to_le32(newblock);
+	ext4_idx_store_pblock(curp->p_idx, newblock);
 
 	neh = ext_inode_hdr(inode);
 	fidx = EXT_FIRST_INDEX(neh);
-	ext_debug("new root: num %d(%d), lblock %d, ptr %d\n",
+	ext_debug("new root: num %d(%d), lblock %d, ptr "E3FSBLK"\n",
 		  le16_to_cpu(neh->eh_entries), le16_to_cpu(neh->eh_max),
-		  le32_to_cpu(fidx->ei_block), le32_to_cpu(fidx->ei_leaf));
+		  le32_to_cpu(fidx->ei_block), idx_pblock(fidx));
 
 	neh->eh_depth = cpu_to_le16(path->p_depth + 1);
 	err = ext4_ext_dirty(handle, inode, curp);
@@ -1042,7 +1078,6 @@ static int inline
 ext4_can_extents_be_merged(struct inode *inode, struct ext4_extent *ex1,
 				struct ext4_extent *ex2)
 {
-	/* FIXME: 48bit support */
         if (le32_to_cpu(ex1->ee_block) + le16_to_cpu(ex1->ee_len)
 	    != le32_to_cpu(ex2->ee_block))
 		return 0;
@@ -1052,8 +1087,7 @@ ext4_can_extents_be_merged(struct inode 
 		return 0;
 #endif
 
-        if (le32_to_cpu(ex1->ee_start) + le16_to_cpu(ex1->ee_len)
-	    		== le32_to_cpu(ex2->ee_start))
+        if (ext_pblock(ex1) + le16_to_cpu(ex1->ee_len) == ext_pblock(ex2))
 		return 1;
 	return 0;
 }
@@ -1080,11 +1114,10 @@ int ext4_ext_insert_extent(handle_t *han
 
 	/* try to insert block into found extent and return */
 	if (ex && ext4_can_extents_be_merged(inode, ex, newext)) {
-		ext_debug("append %d block to %d:%d (from %d)\n",
+		ext_debug("append %d block to %d:%d (from "E3FSBLK")\n",
 				le16_to_cpu(newext->ee_len),
 				le32_to_cpu(ex->ee_block),
-				le16_to_cpu(ex->ee_len),
-				le32_to_cpu(ex->ee_start));
+				le16_to_cpu(ex->ee_len), ext_pblock(ex));
 		if ((err = ext4_ext_get_access(handle, inode, path + depth)))
 			return err;
 		ex->ee_len = cpu_to_le16(le16_to_cpu(ex->ee_len)
@@ -1140,9 +1173,9 @@ has_space:
 
 	if (!nearex) {
 		/* there is no extent in this leaf, create first one */
-		ext_debug("first extent in the leaf: %d:%d:%d\n",
+		ext_debug("first extent in the leaf: %d:"E3FSBLK":%d\n",
 			        le32_to_cpu(newext->ee_block),
-			        le32_to_cpu(newext->ee_start),
+			        ext_pblock(newext),
 			        le16_to_cpu(newext->ee_len));
 		path[depth].p_ext = EXT_FIRST_EXTENT(eh);
 	} else if (le32_to_cpu(newext->ee_block)
@@ -1152,10 +1185,10 @@ has_space:
 			len = EXT_MAX_EXTENT(eh) - nearex;
 			len = (len - 1) * sizeof(struct ext4_extent);
 			len = len < 0 ? 0 : len;
-			ext_debug("insert %d:%d:%d after: nearest 0x%p, "
+			ext_debug("insert %d:"E3FSBLK":%d after: nearest 0x%p, "
 					"move %d from 0x%p to 0x%p\n",
 				        le32_to_cpu(newext->ee_block),
-				        le32_to_cpu(newext->ee_start),
+				        ext_pblock(newext),
 				        le16_to_cpu(newext->ee_len),
 					nearex, len, nearex + 1, nearex + 2);
 			memmove(nearex + 2, nearex + 1, len);
@@ -1165,10 +1198,10 @@ has_space:
  		BUG_ON(newext->ee_block == nearex->ee_block);
 		len = (EXT_MAX_EXTENT(eh) - nearex) * sizeof(struct ext4_extent);
 		len = len < 0 ? 0 : len;
-		ext_debug("insert %d:%d:%d before: nearest 0x%p, "
+		ext_debug("insert %d:"E3FSBLK":%d before: nearest 0x%p, "
 				"move %d from 0x%p to 0x%p\n",
 				le32_to_cpu(newext->ee_block),
-				le32_to_cpu(newext->ee_start),
+				ext_pblock(newext),
 				le16_to_cpu(newext->ee_len),
 				nearex, len, nearex + 1, nearex + 2);
 		memmove(nearex + 1, nearex, len);
@@ -1179,9 +1212,8 @@ has_space:
 	nearex = path[depth].p_ext;
 	nearex->ee_block = newext->ee_block;
 	nearex->ee_start = newext->ee_start;
+	nearex->ee_start_hi = newext->ee_start_hi;
 	nearex->ee_len = newext->ee_len;
-	/* FIXME: support for large fs */
-	nearex->ee_start_hi = 0;
 
 merge:
 	/* try to merge extents to the right */
@@ -1290,7 +1322,7 @@ int ext4_ext_walk_space(struct inode *in
 		} else {
 		        cbex.ec_block = le32_to_cpu(ex->ee_block);
 		        cbex.ec_len = le16_to_cpu(ex->ee_len);
-		        cbex.ec_start = le32_to_cpu(ex->ee_start);
+		        cbex.ec_start = ext_pblock(ex);
 			cbex.ec_type = EXT4_EXT_CACHE_EXTENT;
 		}
 
@@ -1398,13 +1430,13 @@ ext4_ext_in_cache(struct inode *inode, u
 			cex->ec_type != EXT4_EXT_CACHE_EXTENT);
 	if (block >= cex->ec_block && block < cex->ec_block + cex->ec_len) {
 	        ex->ee_block = cpu_to_le32(cex->ec_block);
-	        ex->ee_start = cpu_to_le32(cex->ec_start);
+		ext4_ext_store_pblock(ex, cex->ec_start);
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
 
@@ -1422,18 +1454,18 @@ int ext4_ext_rm_idx(handle_t *handle, st
 {
 	struct buffer_head *bh;
 	int err;
-	unsigned long leaf;
+	ext4_fsblk_t leaf;
 
 	/* free index block */
 	path--;
-	leaf = le32_to_cpu(path->p_idx->ei_leaf);
+	leaf = idx_pblock(path->p_idx);
 	BUG_ON(path->p_hdr->eh_entries == 0);
 	if ((err = ext4_ext_get_access(handle, inode, path)))
 		return err;
 	path->p_hdr->eh_entries = cpu_to_le16(le16_to_cpu(path->p_hdr->eh_entries)-1);
 	if ((err = ext4_ext_dirty(handle, inode, path)))
 		return err;
-	ext_debug("index is empty, remove it, free block %lu\n", leaf);
+	ext_debug("index is empty, remove it, free block "E3FSBLK"\n", leaf);
 	bh = sb_find_get_block(inode->i_sb, leaf);
 	ext4_forget(handle, 1, inode, bh, leaf);
 	ext4_free_blocks(handle, inode, leaf, 1);
@@ -1515,10 +1547,11 @@ static int ext4_remove_blocks(handle_t *
 	if (from >= le32_to_cpu(ex->ee_block)
 	    && to == le32_to_cpu(ex->ee_block) + le16_to_cpu(ex->ee_len) - 1) {
 		/* tail removal */
-		unsigned long num, start;
+		unsigned long num;
+		ext4_fsblk_t start;
 		num = le32_to_cpu(ex->ee_block) + le16_to_cpu(ex->ee_len) - from;
-		start = le32_to_cpu(ex->ee_start) + le16_to_cpu(ex->ee_len) - num;
-		ext_debug("free last %lu blocks starting %lu\n", num, start);
+		start = ext_pblock(ex) + le16_to_cpu(ex->ee_len) - num;
+		ext_debug("free last %lu blocks starting "E3FSBLK"\n", num, start);
 		for (i = 0; i < num; i++) {
 			bh = sb_find_get_block(inode->i_sb, start + i);
 			ext4_forget(handle, 0, inode, bh, start + i);
@@ -1621,7 +1654,7 @@ ext4_ext_rm_leaf(handle_t *handle, struc
 
 		if (num == 0) {
 			/* this extent is removed entirely mark slot unused */
-			ex->ee_start = 0;
+			ext4_ext_store_pblock(ex, 0);
 			eh->eh_entries = cpu_to_le16(le16_to_cpu(eh->eh_entries)-1);
 		}
 
@@ -1632,8 +1665,8 @@ ext4_ext_rm_leaf(handle_t *handle, struc
 		if (err)
 			goto out;
 
-		ext_debug("new extent: %u:%u:%u\n", block, num,
-				le32_to_cpu(ex->ee_start));
+		ext_debug("new extent: %u:%u:"E3FSBLK"\n", block, num,
+				ext_pblock(ex));
 		ex--;
 		ex_ee_block = le32_to_cpu(ex->ee_block);
 		ex_ee_len = le16_to_cpu(ex->ee_len);
@@ -1748,11 +1781,11 @@ int ext4_ext_remove_space(struct inode *
 				path[i].p_idx);
 		if (ext4_ext_more_to_rm(path + i)) {
 			/* go to the next level */
-			ext_debug("move to level %d (block %d)\n",
-				  i + 1, le32_to_cpu(path[i].p_idx->ei_leaf));
+			ext_debug("move to level %d (block "E3FSBLK")\n",
+				  i + 1, idx_pblock(path[i].p_idx));
 			memset(path + i + 1, 0, sizeof(*path));
 			path[i+1].p_bh =
-				sb_bread(sb, le32_to_cpu(path[i].p_idx->ei_leaf));
+				sb_bread(sb, idx_pblock(path[i].p_idx));
 			if (!path[i+1].p_bh) {
 				/* should we reset i_size? */
 				err = -EIO;
@@ -1851,13 +1884,14 @@ void ext4_ext_release(struct super_block
 #endif
 }
 
-int ext4_ext_get_blocks(handle_t *handle, struct inode *inode, sector_t iblock,
+int ext4_ext_get_blocks(handle_t *handle, struct inode *inode, ext4_fsblk_t iblock,
 			unsigned long max_blocks, struct buffer_head *bh_result,
 			int create, int extend_disksize)
 {
 	struct ext4_ext_path *path = NULL;
 	struct ext4_extent newex, *ex;
-	int goal, newblock, err = 0, depth;
+	ext4_fsblk_t goal, newblock;
+	int err = 0, depth;
 	unsigned long allocated = 0;
 
 	__clear_bit(BH_New, &bh_result->b_state);
@@ -1878,7 +1912,7 @@ int ext4_ext_get_blocks(handle_t *handle
 			/* block is already allocated */
 		        newblock = iblock
 		                   - le32_to_cpu(newex.ee_block)
-			           + le32_to_cpu(newex.ee_start);
+			           + ext_pblock(&newex);
 			/* number of remain blocks in the extent */
 			allocated = le16_to_cpu(newex.ee_len) -
 					(iblock - le32_to_cpu(newex.ee_block));
@@ -1907,14 +1941,14 @@ int ext4_ext_get_blocks(handle_t *handle
 
 	if ((ex = path[depth].p_ext)) {
 	        unsigned long ee_block = le32_to_cpu(ex->ee_block);
-		unsigned long ee_start = le32_to_cpu(ex->ee_start);
+		ext4_fsblk_t ee_start = ext_pblock(ex);
 		unsigned short ee_len  = le16_to_cpu(ex->ee_len);
 		/* if found exent covers block, simple return it */
 	        if (iblock >= ee_block && iblock < ee_block + ee_len) {
 			newblock = iblock - ee_block + ee_start;
 			/* number of remain blocks in the extent */
 			allocated = ee_len - (iblock - ee_block);
-			ext_debug("%d fit into %lu:%d -> %d\n", (int) iblock,
+			ext_debug("%d fit into %lu:%d -> "E3FSBLK"\n", (int) iblock,
 					ee_block, ee_len, newblock);
 			ext4_ext_put_in_cache(inode, ee_block, ee_len,
 						ee_start, EXT4_EXT_CACHE_EXTENT);
@@ -1944,12 +1978,12 @@ int ext4_ext_get_blocks(handle_t *handle
 	newblock = ext4_new_blocks(handle, inode, goal, &allocated, &err);
 	if (!newblock)
 		goto out2;
-	ext_debug("allocate new block: goal %d, found %d/%lu\n",
+	ext_debug("allocate new block: goal "E3FSBLK", found "E3FSBLK"/%lu\n",
 			goal, newblock, allocated);
 
 	/* try to insert new extent into found leaf and return */
 	newex.ee_block = cpu_to_le32(iblock);
-	newex.ee_start = cpu_to_le32(newblock);
+	ext4_ext_store_pblock(&newex, newblock);
 	newex.ee_len = cpu_to_le16(allocated);
 	err = ext4_ext_insert_extent(handle, inode, path, &newex);
 	if (err)
@@ -1959,7 +1993,7 @@ int ext4_ext_get_blocks(handle_t *handle
 		EXT4_I(inode)->i_disksize = inode->i_size;
 
 	/* previous routine could use block we allocated */
-	newblock = le32_to_cpu(newex.ee_start);
+	newblock = ext_pblock(&newex);
 	__set_bit(BH_New, &bh_result->b_state);
 
 	ext4_ext_put_in_cache(inode, iblock, allocated, newblock,
diff -puN include/linux/ext4_fs_extents.h~ext4-extents-48bit include/linux/ext4_fs_extents.h
--- linux-2.6.18-rc4/include/linux/ext4_fs_extents.h~ext4-extents-48bit	2006-08-09 15:41:54.468309694 -0700
+++ linux-2.6.18-rc4-ming/include/linux/ext4_fs_extents.h	2006-08-09 15:41:54.482309807 -0700
@@ -108,7 +108,7 @@ struct ext4_extent_header {
  * truncate uses it to simulate recursive walking
  */
 struct ext4_ext_path {
-	__u32				p_block;
+	ext4_fsblk_t			p_block;
 	__u16				p_depth;
 	struct ext4_extent		*p_ext;
 	struct ext4_extent_idx		*p_idx;
diff -puN include/linux/ext4_fs_i.h~ext4-extents-48bit include/linux/ext4_fs_i.h
--- linux-2.6.18-rc4/include/linux/ext4_fs_i.h~ext4-extents-48bit	2006-08-09 15:41:54.472309726 -0700
+++ linux-2.6.18-rc4-ming/include/linux/ext4_fs_i.h	2006-08-09 15:41:54.483309815 -0700
@@ -68,10 +68,10 @@ struct ext4_block_alloc_info {
  * storage for cached extent
  */
 struct ext4_ext_cache {
-	__u32	ec_start;
-	__u32	ec_block;
-	__u32	ec_len; /* must be 32bit to return holes */
-	__u32	ec_type;
+	ext4_fsblk_t	ec_start;
+	__u32		ec_block;
+	__u32		ec_len; /* must be 32bit to return holes */
+	__u32		ec_type;
 };
 
 /*

_


