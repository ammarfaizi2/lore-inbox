Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936378AbWK3MWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936378AbWK3MWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936380AbWK3MWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:22:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49038 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936378AbWK3MWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:22:41 -0500
Subject: [GFS2] Reduce number of arguments to meta_io.c:getbuf() [58/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:22:11 +0000
Message-Id: <1164889331.3752.421.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From cb4c03131836a55bf95e1c165409244ac6b4f39f Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Thu, 23 Nov 2006 11:16:32 -0500
Subject: [PATCH] [GFS2] Reduce number of arguments to meta_io.c:getbuf()

Since the superblock and the address_space are determined by the
glock, we might as well just pass that as the argument since all
the callers already have that available.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/meta_io.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index fbeba81..0e34d99 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -127,17 +127,17 @@ void gfs2_meta_sync(struct gfs2_glock *g
 
 /**
  * getbuf - Get a buffer with a given address space
- * @sdp: the filesystem
- * @aspace: the address space
+ * @gl: the glock
  * @blkno: the block number (filesystem scope)
  * @create: 1 if the buffer should be created
  *
  * Returns: the buffer
  */
 
-static struct buffer_head *getbuf(struct gfs2_sbd *sdp, struct inode *aspace,
-				  u64 blkno, int create)
+static struct buffer_head *getbuf(struct gfs2_glock *gl, u64 blkno, int create)
 {
+	struct address_space *mapping = gl->gl_aspace->i_mapping;
+	struct gfs2_sbd *sdp = gl->gl_sbd;
 	struct page *page;
 	struct buffer_head *bh;
 	unsigned int shift;
@@ -150,13 +150,13 @@ static struct buffer_head *getbuf(struct
 
 	if (create) {
 		for (;;) {
-			page = grab_cache_page(aspace->i_mapping, index);
+			page = grab_cache_page(mapping, index);
 			if (page)
 				break;
 			yield();
 		}
 	} else {
-		page = find_lock_page(aspace->i_mapping, index);
+		page = find_lock_page(mapping, index);
 		if (!page)
 			return NULL;
 	}
@@ -202,7 +202,7 @@ static void meta_prep_new(struct buffer_
 struct buffer_head *gfs2_meta_new(struct gfs2_glock *gl, u64 blkno)
 {
 	struct buffer_head *bh;
-	bh = getbuf(gl->gl_sbd, gl->gl_aspace, blkno, CREATE);
+	bh = getbuf(gl, blkno, CREATE);
 	meta_prep_new(bh);
 	return bh;
 }
@@ -220,7 +220,7 @@ struct buffer_head *gfs2_meta_new(struct
 int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 		   struct buffer_head **bhp)
 {
-	*bhp = getbuf(gl->gl_sbd, gl->gl_aspace, blkno, CREATE);
+	*bhp = getbuf(gl, blkno, CREATE);
 	if (!buffer_uptodate(*bhp))
 		ll_rw_block(READ_META, 1, bhp);
 	if (flags & DIO_WAIT) {
@@ -379,11 +379,10 @@ void gfs2_unpin(struct gfs2_sbd *sdp, st
 void gfs2_meta_wipe(struct gfs2_inode *ip, u64 bstart, u32 blen)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
-	struct inode *aspace = ip->i_gl->gl_aspace;
 	struct buffer_head *bh;
 
 	while (blen) {
-		bh = getbuf(sdp, aspace, bstart, NO_CREATE);
+		bh = getbuf(ip->i_gl, bstart, NO_CREATE);
 		if (bh) {
 			struct gfs2_bufdata *bd = bh->b_private;
 
@@ -484,7 +483,7 @@ int gfs2_meta_indirect_buffer(struct gfs
 	spin_unlock(&ip->i_spin);
 
 	if (!bh)
-		bh = getbuf(gl->gl_sbd, gl->gl_aspace, num, CREATE);
+		bh = getbuf(gl, num, CREATE);
 
 	if (!bh)
 		return -ENOBUFS;
@@ -535,7 +534,6 @@ err:
 struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 {
 	struct gfs2_sbd *sdp = gl->gl_sbd;
-	struct inode *aspace = gl->gl_aspace;
 	struct buffer_head *first_bh, *bh;
 	u32 max_ra = gfs2_tune_get(sdp, gt_max_readahead) >>
 			  sdp->sd_sb.sb_bsize_shift;
@@ -547,7 +545,7 @@ struct buffer_head *gfs2_meta_ra(struct 
 	if (extlen > max_ra)
 		extlen = max_ra;
 
-	first_bh = getbuf(sdp, aspace, dblock, CREATE);
+	first_bh = getbuf(gl, dblock, CREATE);
 
 	if (buffer_uptodate(first_bh))
 		goto out;
@@ -558,7 +556,7 @@ struct buffer_head *gfs2_meta_ra(struct 
 	extlen--;
 
 	while (extlen) {
-		bh = getbuf(sdp, aspace, dblock, CREATE);
+		bh = getbuf(gl, dblock, CREATE);
 
 		if (!buffer_uptodate(bh) && !buffer_locked(bh))
 			ll_rw_block(READA, 1, &bh);
-- 
1.4.1



