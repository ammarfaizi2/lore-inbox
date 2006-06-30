Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933172AbWF3ASI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933172AbWF3ASI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933140AbWF3ARh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:17:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:44487 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S933165AbWF3AR3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:17:29 -0400
Subject: [RFC][Update][Patch 4/16]support 48 bit blk number in extents
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:17:26 -0700
Message-Id: <1151626646.6601.72.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

48bit physical block number support in extents.

Signed-Off-By: Alex Tomas <alex@clusterfs.com>


---

 linux-2.6.17-ming/fs/ext3/extents.c               |  138 +++++++++++++---------
 linux-2.6.17-ming/include/linux/ext3_fs_extents.h |    2 
 linux-2.6.17-ming/include/linux/ext3_fs_i.h       |    2 
 3 files changed, 87 insertions(+), 55 deletions(-)

diff -puN fs/ext3/extents.c~ext3-extents-48bit fs/ext3/extents.c
--- linux-2.6.17/fs/ext3/extents.c~ext3-extents-48bit	2006-06-28 16:46:39.848883567 -0700
+++ linux-2.6.17-ming/fs/ext3/extents.c	2006-06-28 16:46:39.863881846 -0700
@@ -44,6 +44,44 @@
 #include <asm/uaccess.h>
 
 
+/* this macro combines low and hi parts of phys. blocknr into sector_t */
+static inline sector_t ext_pblock(struct ext3_extent *ex)
+{
+	sector_t block;
+
+	block = le32_to_cpu(ex->ee_start);
+	if (sizeof(sector_t) > 4)
+		block |= ((sector_t) le16_to_cpu(ex->ee_start_hi) << 31) << 1;
+	return block;
+}
+
+/* this macro combines low and hi parts of phys. blocknr into sector_t */
+static inline sector_t idx_pblock(struct ext3_extent_idx *ix)
+{
+	sector_t block;
+
+	block = le32_to_cpu(ix->ei_leaf);
+	if (sizeof(sector_t) > 4)
+		block |= ((sector_t) le16_to_cpu(ix->ei_leaf_hi) << 31) << 1;
+	return block;
+}
+
+/* the routine stores large phys. blocknr into extent breaking it into parts */
+static inline void ext3_ext_store_pblock(struct ext3_extent *ex, sector_t pb)
+{
+	ex->ee_start = cpu_to_le32((unsigned long) (pb & 0xffffffff));
+	if (sizeof(sector_t) > 4)
+		ex->ee_start_hi = cpu_to_le16((unsigned long) ((pb >> 31) >> 1) & 0xffff);
+}
+
+/* the routine stores large phys. blocknr into index breaking it into parts */
+static inline void ext3_idx_store_pblock(struct ext3_extent_idx *ix, sector_t pb)
+{
+	ix->ei_leaf = cpu_to_le32((unsigned long) (pb & 0xffffffff));
+	if (sizeof(sector_t) > 4)
+		ix->ei_leaf_hi = cpu_to_le16((unsigned long) ((pb >> 31) >> 1) & 0xffff);
+}
+
 static int ext3_ext_check_header(const char *function, struct inode *inode,
 				struct ext3_extent_header *eh)
 {
@@ -126,7 +164,7 @@ static int ext3_ext_dirty(handle_t *hand
 
 static int ext3_ext_find_goal(struct inode *inode,
 			      struct ext3_ext_path *path,
-			      unsigned long block)
+			      sector_t block)
 {
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	unsigned long bg_start;
@@ -139,8 +177,7 @@ static int ext3_ext_find_goal(struct ino
 
 		/* try to predict block placement */
 		if ((ex = path[depth].p_ext))
-			return le32_to_cpu(ex->ee_start)
-					+ (block - le32_to_cpu(ex->ee_block));
+			return ext_pblock(ex)+(block-le32_to_cpu(ex->ee_block));
 
 		/* it looks index is empty
 		 * try to find starting from index itself */
@@ -230,13 +267,13 @@ static void ext3_ext_show_path(struct in
 	ext_debug("path:");
 	for (k = 0; k <= l; k++, path++) {
 		if (path->p_idx) {
-		  ext_debug("  %d->%d", le32_to_cpu(path->p_idx->ei_block),
-			    le32_to_cpu(path->p_idx->ei_leaf));
+		  ext_debug("  %d->%llu", le32_to_cpu(path->p_idx->ei_block),
+			    idx_pblock(path->p_idx));
 		} else if (path->p_ext) {
-			ext_debug("  %d:%d:%d",
+			ext_debug("  %d:%d:%lld",
 				  le32_to_cpu(path->p_ext->ee_block),
 				  le16_to_cpu(path->p_ext->ee_len),
-				  le32_to_cpu(path->p_ext->ee_start));
+				  ext_pblock(path->p_ext));
 		} else
 			ext_debug("  []");
 	}
@@ -257,9 +294,8 @@ static void ext3_ext_show_leaf(struct in
 	ex = EXT_FIRST_EXTENT(eh);
 
 	for (i = 0; i < le16_to_cpu(eh->eh_entries); i++, ex++) {
-		ext_debug("%d:%d:%d ", le32_to_cpu(ex->ee_block),
-			  le16_to_cpu(ex->ee_len),
-			  le32_to_cpu(ex->ee_start));
+		ext_debug("%d:%d:%lld ", le32_to_cpu(ex->ee_block),
+			  le16_to_cpu(ex->ee_len), ext_pblock(ex));
 	}
 	ext_debug("\n");
 }
@@ -308,8 +344,8 @@ ext3_ext_binsearch_idx(struct inode *ino
 	}
 
 	path->p_idx = l - 1;
-	ext_debug("  -> %d->%d ", le32_to_cpu(path->p_idx->ei_block),
-		  le32_to_cpu(path->p_idx->ei_leaf));
+	ext_debug("  -> %d->%lld ", le32_to_cpu(path->p_idx->ei_block),
+		  idx_block(path->p_idx));
 
 #ifdef CHECK_BINSEARCH
 	{
@@ -374,10 +410,10 @@ ext3_ext_binsearch(struct inode *inode, 
 	}
 
 	path->p_ext = l - 1;
-	ext_debug("  -> %d:%d:%d ",
+	ext_debug("  -> %d:%lld:%d ",
 		        le32_to_cpu(path->p_ext->ee_block),
-		        le32_to_cpu(path->p_ext->ee_start),
-		        le16_to_cpu(path->p_ext->ee_len));
+		        ext_pblock(path->p_ext),
+			le16_to_cpu(path->p_ext->ee_len));
 
 #ifdef CHECK_BINSEARCH
 	{
@@ -442,7 +478,7 @@ ext3_ext_find_extent(struct inode *inode
 		ext_debug("depth %d: num %d, max %d\n",
 			  ppos, le16_to_cpu(eh->eh_entries), le16_to_cpu(eh->eh_max));
 		ext3_ext_binsearch_idx(inode, path + ppos, block);
-		path[ppos].p_block = le32_to_cpu(path[ppos].p_idx->ei_leaf);
+		path[ppos].p_block = idx_pblock(path[ppos].p_idx);
 		path[ppos].p_depth = i;
 		path[ppos].p_ext = NULL;
 
@@ -524,7 +560,7 @@ static int ext3_ext_insert_index(handle_
 	}
 
 	ix->ei_block = cpu_to_le32(logical);
-	ix->ei_leaf = cpu_to_le32(ptr);
+	ext3_idx_store_pblock(ix, ptr);
 	curp->p_hdr->eh_entries = cpu_to_le16(le16_to_cpu(curp->p_hdr->eh_entries)+1);
 
 	BUG_ON(le16_to_cpu(curp->p_hdr->eh_entries)
@@ -633,9 +669,9 @@ static int ext3_ext_split(handle_t *hand
 	path[depth].p_ext++;
 	while (path[depth].p_ext <=
 			EXT_MAX_EXTENT(path[depth].p_hdr)) {
-		ext_debug("move %d:%d:%d in new leaf %lu\n",
+		ext_debug("move %d:%lld:%d in new leaf %lu\n",
 			        le32_to_cpu(path[depth].p_ext->ee_block),
-			        le32_to_cpu(path[depth].p_ext->ee_start),
+			        ext_pblock(path[depth].p_ext),
 			        le16_to_cpu(path[depth].p_ext->ee_len),
 				newblock);
 		/*memmove(ex++, path[depth].p_ext++,
@@ -696,7 +732,7 @@ static int ext3_ext_split(handle_t *hand
 		neh->eh_depth = cpu_to_le16(depth - i);
 		fidx = EXT_FIRST_INDEX(neh);
 		fidx->ei_block = border;
-		fidx->ei_leaf = cpu_to_le32(oldblock);
+		ext3_idx_store_pblock(fidx, oldblock);
 
 		ext_debug("int.index at %d (block %lu): %lu -> %lu\n", i,
 				newblock, (unsigned long) le32_to_cpu(border),
@@ -710,9 +746,9 @@ static int ext3_ext_split(handle_t *hand
 		BUG_ON(EXT_MAX_INDEX(path[i].p_hdr) !=
 				EXT_LAST_INDEX(path[i].p_hdr));
 		while (path[i].p_idx <= EXT_MAX_INDEX(path[i].p_hdr)) {
-			ext_debug("%d: move %d:%d in new index %lu\n", i,
+			ext_debug("%d: move %d:%d in new index %llu\n", i,
 				        le32_to_cpu(path[i].p_idx->ei_block),
-				        le32_to_cpu(path[i].p_idx->ei_leaf),
+				        idx_pblock(path[i].p_idx),
 				        newblock);
 			/*memmove(++fidx, path[i].p_idx++,
 					sizeof(struct ext3_extent_idx));
@@ -839,13 +875,13 @@ static int ext3_ext_grow_indepth(handle_
 	curp->p_idx = EXT_FIRST_INDEX(curp->p_hdr);
 	/* FIXME: it works, but actually path[0] can be index */
 	curp->p_idx->ei_block = EXT_FIRST_EXTENT(path[0].p_hdr)->ee_block;
-	curp->p_idx->ei_leaf = cpu_to_le32(newblock);
+	ext3_idx_store_pblock(curp->p_idx, newblock);
 
 	neh = ext_inode_hdr(inode);
 	fidx = EXT_FIRST_INDEX(neh);
-	ext_debug("new root: num %d(%d), lblock %d, ptr %d\n",
+	ext_debug("new root: num %d(%d), lblock %d, ptr %llu\n",
 		  le16_to_cpu(neh->eh_entries), le16_to_cpu(neh->eh_max),
-		  le32_to_cpu(fidx->ei_block), le32_to_cpu(fidx->ei_leaf));
+		  le32_to_cpu(fidx->ei_block), idx_pblock(fidx));
 
 	neh->eh_depth = cpu_to_le16(path->p_depth + 1);
 	err = ext3_ext_dirty(handle, inode, curp);
@@ -1042,7 +1078,6 @@ static int inline
 ext3_can_extents_be_merged(struct inode *inode, struct ext3_extent *ex1,
 				struct ext3_extent *ex2)
 {
-	/* FIXME: 48bit support */
         if (le32_to_cpu(ex1->ee_block) + le16_to_cpu(ex1->ee_len)
 	    != le32_to_cpu(ex2->ee_block))
 		return 0;
@@ -1052,8 +1087,7 @@ ext3_can_extents_be_merged(struct inode 
 		return 0;
 #endif
 
-        if (le32_to_cpu(ex1->ee_start) + le16_to_cpu(ex1->ee_len)
-	    		== le32_to_cpu(ex2->ee_start))
+        if (ext_pblock(ex1) + le16_to_cpu(ex1->ee_len) == ext_pblock(ex2))
 		return 1;
 	return 0;
 }
@@ -1080,11 +1114,10 @@ int ext3_ext_insert_extent(handle_t *han
 
 	/* try to insert block into found extent and return */
 	if (ex && ext3_can_extents_be_merged(inode, ex, newext)) {
-		ext_debug("append %d block to %d:%d (from %d)\n",
+		ext_debug("append %d block to %d:%d (from %lld)\n",
 				le16_to_cpu(newext->ee_len),
 				le32_to_cpu(ex->ee_block),
-				le16_to_cpu(ex->ee_len),
-				le32_to_cpu(ex->ee_start));
+				le16_to_cpu(ex->ee_len), ext_pblock(ex));
 		if ((err = ext3_ext_get_access(handle, inode, path + depth)))
 			return err;
 		ex->ee_len = cpu_to_le16(le16_to_cpu(ex->ee_len)
@@ -1140,9 +1173,9 @@ has_space:
 
 	if (!nearex) {
 		/* there is no extent in this leaf, create first one */
-		ext_debug("first extent in the leaf: %d:%d:%d\n",
+		ext_debug("first extent in the leaf: %d:%lld:%d\n",
 			        le32_to_cpu(newext->ee_block),
-			        le32_to_cpu(newext->ee_start),
+			        ext_pblock(newext),
 			        le16_to_cpu(newext->ee_len));
 		path[depth].p_ext = EXT_FIRST_EXTENT(eh);
 	} else if (le32_to_cpu(newext->ee_block)
@@ -1152,10 +1185,10 @@ has_space:
 			len = EXT_MAX_EXTENT(eh) - nearex;
 			len = (len - 1) * sizeof(struct ext3_extent);
 			len = len < 0 ? 0 : len;
-			ext_debug("insert %d:%d:%d after: nearest 0x%p, "
+			ext_debug("insert %d:%lld:%d after: nearest 0x%p, "
 					"move %d from 0x%p to 0x%p\n",
 				        le32_to_cpu(newext->ee_block),
-				        le32_to_cpu(newext->ee_start),
+				        ext_pblock(newext),
 				        le16_to_cpu(newext->ee_len),
 					nearex, len, nearex + 1, nearex + 2);
 			memmove(nearex + 2, nearex + 1, len);
@@ -1165,10 +1198,10 @@ has_space:
  		BUG_ON(newext->ee_block == nearex->ee_block);
 		len = (EXT_MAX_EXTENT(eh) - nearex) * sizeof(struct ext3_extent);
 		len = len < 0 ? 0 : len;
-		ext_debug("insert %d:%d:%d before: nearest 0x%p, "
+		ext_debug("insert %d:%lld:%d before: nearest 0x%p, "
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
@@ -1290,7 +1322,7 @@ int ext3_ext_walk_space(struct inode *in
 		} else {
 		        cbex.ec_block = le32_to_cpu(ex->ee_block);
 		        cbex.ec_len = le16_to_cpu(ex->ee_len);
-		        cbex.ec_start = le32_to_cpu(ex->ee_start);
+		        cbex.ec_start = ext_pblock(ex);
 			cbex.ec_type = EXT3_EXT_CACHE_EXTENT;
 		}
 
@@ -1398,7 +1430,7 @@ ext3_ext_in_cache(struct inode *inode, u
 			cex->ec_type != EXT3_EXT_CACHE_EXTENT);
 	if (block >= cex->ec_block && block < cex->ec_block + cex->ec_len) {
 	        ex->ee_block = cpu_to_le32(cex->ec_block);
-	        ex->ee_start = cpu_to_le32(cex->ec_start);
+		ext3_ext_store_pblock(ex, cex->ec_start);
 	        ex->ee_len = cpu_to_le16(cex->ec_len);
 		ext_debug("%lu cached by %lu:%lu:%lu\n",
 				(unsigned long) block,
@@ -1426,7 +1458,7 @@ int ext3_ext_rm_idx(handle_t *handle, st
 
 	/* free index block */
 	path--;
-	leaf = le32_to_cpu(path->p_idx->ei_leaf);
+	leaf = idx_pblock(path->p_idx);
 	BUG_ON(path->p_hdr->eh_entries == 0);
 	if ((err = ext3_ext_get_access(handle, inode, path)))
 		return err;
@@ -1517,7 +1549,7 @@ static int ext3_remove_blocks(handle_t *
 		/* tail removal */
 		unsigned long num, start;
 		num = le32_to_cpu(ex->ee_block) + le16_to_cpu(ex->ee_len) - from;
-		start = le32_to_cpu(ex->ee_start) + le16_to_cpu(ex->ee_len) - num;
+		start = ext_pblock(ex) + le16_to_cpu(ex->ee_len) - num;
 		ext_debug("free last %lu blocks starting %lu\n", num, start);
 		for (i = 0; i < num; i++) {
 			bh = sb_find_get_block(inode->i_sb, start + i);
@@ -1621,7 +1653,7 @@ ext3_ext_rm_leaf(handle_t *handle, struc
 
 		if (num == 0) {
 			/* this extent is removed entirely mark slot unused */
-			ex->ee_start = 0;
+			ext3_ext_store_pblock(ex, 0);
 			eh->eh_entries = cpu_to_le16(le16_to_cpu(eh->eh_entries)-1);
 		}
 
@@ -1632,8 +1664,8 @@ ext3_ext_rm_leaf(handle_t *handle, struc
 		if (err)
 			goto out;
 
-		ext_debug("new extent: %u:%u:%u\n", block, num,
-				le32_to_cpu(ex->ee_start));
+		ext_debug("new extent: %u:%u:%llu\n", block, num,
+				ext_pblock(ex));
 		ex--;
 		ex_ee_block = le32_to_cpu(ex->ee_block);
 		ex_ee_len = le16_to_cpu(ex->ee_len);
@@ -1748,11 +1780,11 @@ int ext3_ext_remove_space(struct inode *
 				path[i].p_idx);
 		if (ext3_ext_more_to_rm(path + i)) {
 			/* go to the next level */
-			ext_debug("move to level %d (block %d)\n",
-				  i + 1, le32_to_cpu(path[i].p_idx->ei_leaf));
+			ext_debug("move to level %d (block %llu)\n",
+				  i + 1, idx_pblock(path[i].p_idx));
 			memset(path + i + 1, 0, sizeof(*path));
 			path[i+1].p_bh =
-				sb_bread(sb, le32_to_cpu(path[i].p_idx->ei_leaf));
+				sb_bread(sb, idx_pblock(path[i].p_idx));
 			if (!path[i+1].p_bh) {
 				/* should we reset i_size? */
 				err = -EIO;
@@ -1878,7 +1910,7 @@ int ext3_ext_get_blocks(handle_t *handle
 			/* block is already allocated */
 		        newblock = iblock
 		                   - le32_to_cpu(newex.ee_block)
-			           + le32_to_cpu(newex.ee_start);
+			           + ext_pblock(&newex);
 			/* number of remain blocks in the extent */
 			allocated = le16_to_cpu(newex.ee_len) -
 					(iblock - le32_to_cpu(newex.ee_block));
@@ -1907,7 +1939,7 @@ int ext3_ext_get_blocks(handle_t *handle
 
 	if ((ex = path[depth].p_ext)) {
 	        unsigned long ee_block = le32_to_cpu(ex->ee_block);
-		unsigned long ee_start = le32_to_cpu(ex->ee_start);
+		unsigned long ee_start = ext_pblock(ex);
 		unsigned short ee_len  = le16_to_cpu(ex->ee_len);
 		/* if found exent covers block, simple return it */
 	        if (iblock >= ee_block && iblock < ee_block + ee_len) {
@@ -1943,7 +1975,7 @@ int ext3_ext_get_blocks(handle_t *handle
 
 	/* try to insert new extent into found leaf and return */
 	newex.ee_block = cpu_to_le32(iblock);
-	newex.ee_start = cpu_to_le32(newblock);
+	ext3_ext_store_pblock(&newex, newblock);
 	newex.ee_len = cpu_to_le16(allocated);
 	err = ext3_ext_insert_extent(handle, inode, path, &newex);
 	if (err)
@@ -1953,7 +1985,7 @@ int ext3_ext_get_blocks(handle_t *handle
 		EXT3_I(inode)->i_disksize = inode->i_size;
 
 	/* previous routine could use block we allocated */
-	newblock = le32_to_cpu(newex.ee_start);
+	newblock = ext_pblock(&newex);
 	__set_bit(BH_New, &bh_result->b_state);
 
 	ext3_ext_put_in_cache(inode, iblock, allocated, newblock,
diff -puN include/linux/ext3_fs_extents.h~ext3-extents-48bit include/linux/ext3_fs_extents.h
--- linux-2.6.17/include/linux/ext3_fs_extents.h~ext3-extents-48bit	2006-06-28 16:46:39.851883223 -0700
+++ linux-2.6.17-ming/include/linux/ext3_fs_extents.h	2006-06-28 16:46:39.864881731 -0700
@@ -108,7 +108,7 @@ struct ext3_extent_header {
  * truncate uses it to simulate recursive walking
  */
 struct ext3_ext_path {
-	__u32				p_block;
+	__u64				p_block;
 	__u16				p_depth;
 	struct ext3_extent		*p_ext;
 	struct ext3_extent_idx		*p_idx;
diff -puN include/linux/ext3_fs_i.h~ext3-extents-48bit include/linux/ext3_fs_i.h
--- linux-2.6.17/include/linux/ext3_fs_i.h~ext3-extents-48bit	2006-06-28 16:46:39.855882764 -0700
+++ linux-2.6.17-ming/include/linux/ext3_fs_i.h	2006-06-28 16:46:39.864881731 -0700
@@ -68,7 +68,7 @@ struct ext3_block_alloc_info {
  * storage for cached extent
  */
 struct ext3_ext_cache {
-	__u32	ec_start;
+	sector_t ec_start;
 	__u32	ec_block;
 	__u32	ec_len; /* must be 32bit to return holes */
 	__u32	ec_type;

_


