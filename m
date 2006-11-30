Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936348AbWK3M3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936348AbWK3M3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936356AbWK3MVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:21:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13197 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936336AbWK3MUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:20:54 -0500
Subject: [GFS2] Tidy up bmap & fix boundary bug [48/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:20:59 +0000
Message-Id: <1164889259.3752.401.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 4cf1ed8144e740de27c6146c25d5d7ea26679cc5 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 15 Nov 2006 15:21:06 -0500
Subject: [PATCH] [GFS2] Tidy up bmap & fix boundary bug

This moves the locking for bmap into the bmap function itself
rather than using a wrapper function. It also fixes a bug where
the boundary flag was set on the wrong bh. Also the flags on
the mapped bh are reset earlier in the function to ensure that
they are 100% correct on the error path.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/bmap.c |  117 ++++++++++++++++++++++++++------------------------------
 1 files changed, 54 insertions(+), 63 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 06e3447..8240c1f 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -423,12 +423,29 @@ static int lookup_block(struct gfs2_inod
 	return 0;
 }
 
+static inline void bmap_lock(struct inode *inode, int create)
+{
+	struct gfs2_inode *ip = GFS2_I(inode);
+	if (create)
+		down_write(&ip->i_rw_mutex);
+	else
+		down_read(&ip->i_rw_mutex);
+}
+
+static inline void bmap_unlock(struct inode *inode, int create)
+{
+	struct gfs2_inode *ip = GFS2_I(inode);
+	if (create)
+		up_write(&ip->i_rw_mutex);
+	else
+		up_read(&ip->i_rw_mutex);
+}
+
 /**
- * gfs2_block_pointers - Map a block from an inode to a disk block
+ * gfs2_block_map - Map a block from an inode to a disk block
  * @inode: The inode
  * @lblock: The logical block number
- * @map_bh: The bh to be mapped
- * @mp: metapath to use
+ * @bh_map: The bh to be mapped
  *
  * Find the block number on the current device which corresponds to an
  * inode's block. If the block had to be created, "new" will be set.
@@ -436,8 +453,8 @@ static int lookup_block(struct gfs2_inod
  * Returns: errno
  */
 
-static int gfs2_block_pointers(struct inode *inode, u64 lblock, int create,
-			       struct buffer_head *bh_map, struct metapath *mp)
+int gfs2_block_map(struct inode *inode, u64 lblock, int create,
+		   struct buffer_head *bh_map)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
@@ -451,51 +468,55 @@ static int gfs2_block_pointers(struct in
 	u64 dblock = 0;
 	int boundary;
 	unsigned int maxlen = bh_map->b_size >> inode->i_blkbits;
+	struct metapath mp;
+	u64 size;
 
 	BUG_ON(maxlen == 0);
 
 	if (gfs2_assert_warn(sdp, !gfs2_is_stuffed(ip)))
 		return 0;
 
+	bmap_lock(inode, create);
+	clear_buffer_mapped(bh_map);
+	clear_buffer_new(bh_map);
+	clear_buffer_boundary(bh_map);
 	bsize = gfs2_is_dir(ip) ? sdp->sd_jbsize : sdp->sd_sb.sb_bsize;
-
-	height = calc_tree_height(ip, (lblock + 1) * bsize);
-	if (ip->i_di.di_height < height) {
-		if (!create)
-			return 0;
-
-		error = build_height(inode, height);
-		if (error)
-			return error;
+	size = (lblock + 1) * bsize;
+
+	if (size > ip->i_di.di_size) {
+		height = calc_tree_height(ip, size);
+		if (ip->i_di.di_height < height) {
+			if (!create)
+				goto out_ok;
+	
+			error = build_height(inode, height);
+			if (error)
+				goto out_fail;
+		}
 	}
 
-	find_metapath(ip, lblock, mp);
+	find_metapath(ip, lblock, &mp);
 	end_of_metadata = ip->i_di.di_height - 1;
-
 	error = gfs2_meta_inode_buffer(ip, &bh);
 	if (error)
-		return error;
+		goto out_fail;
 
 	for (x = 0; x < end_of_metadata; x++) {
-		lookup_block(ip, bh, x, mp, create, &new, &dblock);
+		lookup_block(ip, bh, x, &mp, create, &new, &dblock);
 		brelse(bh);
 		if (!dblock)
-			return 0;
+			goto out_ok;
 
 		error = gfs2_meta_indirect_buffer(ip, x+1, dblock, new, &bh);
 		if (error)
-			return error;
+			goto out_fail;
 	}
 
-	boundary = lookup_block(ip, bh, end_of_metadata, mp, create, &new, &dblock);
-	clear_buffer_mapped(bh_map);
-	clear_buffer_new(bh_map);
-	clear_buffer_boundary(bh_map);
-
+	boundary = lookup_block(ip, bh, end_of_metadata, &mp, create, &new, &dblock);
 	if (dblock) {
 		map_bh(bh_map, inode->i_sb, dblock);
 		if (boundary)
-			set_buffer_boundary(bh);
+			set_buffer_boundary(bh_map);
 		if (new) {
 			struct buffer_head *dibh;
 			error = gfs2_meta_inode_buffer(ip, &dibh);
@@ -510,8 +531,8 @@ static int gfs2_block_pointers(struct in
 		while(--maxlen && !buffer_boundary(bh_map)) {
 			u64 eblock;
 
-			mp->mp_list[end_of_metadata]++;
-			boundary = lookup_block(ip, bh, end_of_metadata, mp, 0, &new, &eblock);
+			mp.mp_list[end_of_metadata]++;
+			boundary = lookup_block(ip, bh, end_of_metadata, &mp, 0, &new, &eblock);
 			if (eblock != ++dblock)
 				break;
 			bh_map->b_size += (1 << inode->i_blkbits);
@@ -521,43 +542,15 @@ static int gfs2_block_pointers(struct in
 	}
 out_brelse:
 	brelse(bh);
-	return 0;
-}
-
-
-static inline void bmap_lock(struct inode *inode, int create)
-{
-	struct gfs2_inode *ip = GFS2_I(inode);
-	if (create)
-		down_write(&ip->i_rw_mutex);
-	else
-		down_read(&ip->i_rw_mutex);
-}
-
-static inline void bmap_unlock(struct inode *inode, int create)
-{
-	struct gfs2_inode *ip = GFS2_I(inode);
-	if (create)
-		up_write(&ip->i_rw_mutex);
-	else
-		up_read(&ip->i_rw_mutex);
-}
-
-int gfs2_block_map(struct inode *inode, u64 lblock, int create,
-		   struct buffer_head *bh)
-{
-	struct metapath mp;
-	int ret;
-
-	bmap_lock(inode, create);
-	ret = gfs2_block_pointers(inode, lblock, create, bh, &mp);
+out_ok:
+	error = 0;
+out_fail:
 	bmap_unlock(inode, create);
-	return ret;
+	return error;
 }
 
 int gfs2_extent_map(struct inode *inode, u64 lblock, int *new, u64 *dblock, unsigned *extlen)
 {
-	struct metapath mp;
 	struct buffer_head bh = { .b_state = 0, .b_blocknr = 0 };
 	int ret;
 	int create = *new;
@@ -567,9 +560,7 @@ int gfs2_extent_map(struct inode *inode,
 	BUG_ON(!new);
 
 	bh.b_size = 1 << (inode->i_blkbits + 5);
-	bmap_lock(inode, create);
-	ret = gfs2_block_pointers(inode, lblock, create, &bh, &mp);
-	bmap_unlock(inode, create);
+	ret = gfs2_block_map(inode, lblock, create, &bh);
 	*extlen = bh.b_size >> inode->i_blkbits;
 	*dblock = bh.b_blocknr;
 	if (buffer_new(&bh))
-- 
1.4.1



