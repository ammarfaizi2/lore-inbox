Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbWJTJKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWJTJKG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWJTJKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:10:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13709 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751688AbWJTJKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:10:03 -0400
Subject: [PATCH 2/8] [GFS2] Fix bmap to map extents properly
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 20 Oct 2006 10:18:15 +0100
Message-Id: <1161335895.27980.184.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 23591256d61354e20f12e98d7a496ad5c23de74c Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Fri, 13 Oct 2006 17:25:45 -0400
Subject: [GFS2] Fix bmap to map extents properly

This fix means that bmap will map extents of the length requested
by the VFS rather than guessing at it, or just mapping one block
at a time. The other callers of gfs2_block_map are audited to ensure
they send the correct max extent lengths (i.e. set bh->b_size correctly).

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/bmap.c        |   13 +++++++------
 fs/gfs2/bmap.h        |    2 +-
 fs/gfs2/log.c         |    6 ++++--
 fs/gfs2/ops_address.c |    6 +++---
 fs/gfs2/quota.c       |    5 +++--
 fs/gfs2/recovery.c    |    5 +++--
 6 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index cc57f2e..06e9a8c 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -434,8 +434,7 @@ static int lookup_block(struct gfs2_inod
  */
 
 static int gfs2_block_pointers(struct inode *inode, u64 lblock, int create,
-			       struct buffer_head *bh_map, struct metapath *mp,
-			       unsigned int maxlen)
+			       struct buffer_head *bh_map, struct metapath *mp)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
@@ -448,6 +447,7 @@ static int gfs2_block_pointers(struct in
 	int new = 0;
 	u64 dblock = 0;
 	int boundary;
+	unsigned int maxlen = bh_map->b_size >> inode->i_blkbits;
 
 	BUG_ON(maxlen == 0);
 
@@ -541,13 +541,13 @@ static inline void bmap_unlock(struct in
 }
 
 int gfs2_block_map(struct inode *inode, u64 lblock, int create,
-		   struct buffer_head *bh, unsigned int maxlen)
+		   struct buffer_head *bh)
 {
 	struct metapath mp;
 	int ret;
 
 	bmap_lock(inode, create);
-	ret = gfs2_block_pointers(inode, lblock, create, bh, &mp, maxlen);
+	ret = gfs2_block_pointers(inode, lblock, create, bh, &mp);
 	bmap_unlock(inode, create);
 	return ret;
 }
@@ -555,7 +555,7 @@ int gfs2_block_map(struct inode *inode, 
 int gfs2_extent_map(struct inode *inode, u64 lblock, int *new, u64 *dblock, unsigned *extlen)
 {
 	struct metapath mp;
-	struct buffer_head bh = { .b_state = 0, .b_blocknr = 0, .b_size = 0 };
+	struct buffer_head bh = { .b_state = 0, .b_blocknr = 0 };
 	int ret;
 	int create = *new;
 
@@ -563,8 +563,9 @@ int gfs2_extent_map(struct inode *inode,
 	BUG_ON(!dblock);
 	BUG_ON(!new);
 
+	bh.b_size = 1 << (inode->i_blkbits + 5);
 	bmap_lock(inode, create);
-	ret = gfs2_block_pointers(inode, lblock, create, &bh, &mp, 32);
+	ret = gfs2_block_pointers(inode, lblock, create, &bh, &mp);
 	bmap_unlock(inode, create);
 	*extlen = bh.b_size >> inode->i_blkbits;
 	*dblock = bh.b_blocknr;
diff --git a/fs/gfs2/bmap.h b/fs/gfs2/bmap.h
index 0fd379b..ac2fd04 100644
--- a/fs/gfs2/bmap.h
+++ b/fs/gfs2/bmap.h
@@ -15,7 +15,7 @@ struct gfs2_inode;
 struct page;
 
 int gfs2_unstuff_dinode(struct gfs2_inode *ip, struct page *page);
-int gfs2_block_map(struct inode *inode, u64 lblock, int create, struct buffer_head *bh, unsigned int maxlen);
+int gfs2_block_map(struct inode *inode, u64 lblock, int create, struct buffer_head *bh);
 int gfs2_extent_map(struct inode *inode, u64 lblock, int *new, u64 *dblock, unsigned *extlen);
 
 int gfs2_truncatei(struct gfs2_inode *ip, u64 size);
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 72eec65..0cace3d 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -312,10 +312,12 @@ void gfs2_log_release(struct gfs2_sbd *s
 
 static u64 log_bmap(struct gfs2_sbd *sdp, unsigned int lbn)
 {
+	struct inode *inode = sdp->sd_jdesc->jd_inode;
 	int error;
-	struct buffer_head bh_map;
+	struct buffer_head bh_map = { .b_state = 0, .b_blocknr = 0 };
 
-	error = gfs2_block_map(sdp->sd_jdesc->jd_inode, lbn, 0, &bh_map, 1);
+	bh_map.b_size = 1 << inode->i_blkbits;
+	error = gfs2_block_map(inode, lbn, 0, &bh_map);
 	if (error || !bh_map.b_blocknr)
 		printk(KERN_INFO "error=%d, dbn=%llu lbn=%u", error, bh_map.b_blocknr, lbn);
 	gfs2_assert_withdraw(sdp, !error && bh_map.b_blocknr);
diff --git a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
index e0599fe..8d5963c 100644
--- a/fs/gfs2/ops_address.c
+++ b/fs/gfs2/ops_address.c
@@ -65,7 +65,7 @@ static void gfs2_page_add_databufs(struc
 int gfs2_get_block(struct inode *inode, sector_t lblock,
 	           struct buffer_head *bh_result, int create)
 {
-	return gfs2_block_map(inode, lblock, create, bh_result, 32);
+	return gfs2_block_map(inode, lblock, create, bh_result);
 }
 
 /**
@@ -83,7 +83,7 @@ static int gfs2_get_block_noalloc(struct
 {
 	int error;
 
-	error = gfs2_block_map(inode, lblock, 0, bh_result, 1);
+	error = gfs2_block_map(inode, lblock, 0, bh_result);
 	if (error)
 		return error;
 	if (bh_result->b_blocknr == 0)
@@ -94,7 +94,7 @@ static int gfs2_get_block_noalloc(struct
 static int gfs2_get_block_direct(struct inode *inode, sector_t lblock,
 				 struct buffer_head *bh_result, int create)
 {
-	return gfs2_block_map(inode, lblock, 0, bh_result, 32);
+	return gfs2_block_map(inode, lblock, 0, bh_result);
 }
 
 /**
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index c69b94a..a3deae7 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -251,7 +251,7 @@ static int bh_get(struct gfs2_quota_data
 	unsigned int block, offset;
 	struct buffer_head *bh;
 	int error;
-	struct buffer_head bh_map;
+	struct buffer_head bh_map = { .b_state = 0, .b_blocknr = 0 };
 
 	mutex_lock(&sdp->sd_quota_mutex);
 
@@ -263,7 +263,8 @@ static int bh_get(struct gfs2_quota_data
 	block = qd->qd_slot / sdp->sd_qc_per_block;
 	offset = qd->qd_slot % sdp->sd_qc_per_block;;
 
-	error = gfs2_block_map(&ip->i_inode, block, 0, &bh_map, 1);
+	bh_map.b_size = 1 << ip->i_inode.i_blkbits;
+	error = gfs2_block_map(&ip->i_inode, block, 0, &bh_map);
 	if (error)
 		goto fail;
 	error = gfs2_meta_read(ip->i_gl, bh_map.b_blocknr, DIO_WAIT, &bh);
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 0a8a4b8..62cd223 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -372,11 +372,12 @@ static int clean_journal(struct gfs2_jde
 	u32 hash;
 	struct buffer_head *bh;
 	int error;
-	struct buffer_head bh_map;
+	struct buffer_head bh_map = { .b_state = 0, .b_blocknr = 0 };
 
 	lblock = head->lh_blkno;
 	gfs2_replay_incr_blk(sdp, &lblock);
-	error = gfs2_block_map(&ip->i_inode, lblock, 0, &bh_map, 1);
+	bh_map.b_size = 1 << ip->i_inode.i_blkbits;
+	error = gfs2_block_map(&ip->i_inode, lblock, 0, &bh_map);
 	if (error)
 		return error;
 	if (!bh_map.b_blocknr) {
-- 
1.4.1



