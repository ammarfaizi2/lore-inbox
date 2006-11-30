Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936291AbWK3MPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936291AbWK3MPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936279AbWK3MOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:14:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64647 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936266AbWK3MOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:14:33 -0500
Subject: [GFS2] gfs2 misc endianness annotations [15/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:15:08 +0000
Message-Id: <1164888908.3752.334.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From b44b84d765b02f813a67b96bf79e3b5d4d621631 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sat, 14 Oct 2006 10:46:30 -0400
Subject: [PATCH] [GFS2] gfs2 misc endianness annotations

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/bmap.c       |   32 ++++++++++++++++----------------
 fs/gfs2/dir.c        |   24 +++++++++++++-----------
 fs/gfs2/eattr.c      |   27 ++++++++++++++-------------
 fs/gfs2/eattr.h      |    6 +++---
 fs/gfs2/inode.c      |    9 +++++----
 fs/gfs2/ops_export.c |   30 ++++++++++++------------------
 fs/gfs2/quota.c      |    3 +--
 fs/gfs2/util.h       |    6 ++----
 8 files changed, 66 insertions(+), 71 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 06e9a8c..51f6356 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -38,8 +38,8 @@ struct metapath {
 };
 
 typedef int (*block_call_t) (struct gfs2_inode *ip, struct buffer_head *dibh,
-			     struct buffer_head *bh, u64 *top,
-			     u64 *bottom, unsigned int height,
+			     struct buffer_head *bh, __be64 *top,
+			     __be64 *bottom, unsigned int height,
 			     void *data);
 
 struct strip_mine {
@@ -230,7 +230,7 @@ static int build_height(struct inode *in
 	struct buffer_head *blocks[GFS2_MAX_META_HEIGHT];
 	struct gfs2_dinode *di;
 	int error;
-	u64 *bp;
+	__be64 *bp;
 	u64 bn;
 	unsigned n;
 
@@ -255,7 +255,7 @@ static int build_height(struct inode *in
 					  GFS2_FORMAT_IN);
 			gfs2_buffer_clear_tail(blocks[n],
 					       sizeof(struct gfs2_meta_header));
-			bp = (u64 *)(blocks[n]->b_data +
+			bp = (__be64 *)(blocks[n]->b_data +
 				     sizeof(struct gfs2_meta_header));
 			*bp = cpu_to_be64(blocks[n+1]->b_blocknr);
 			brelse(blocks[n]);
@@ -360,15 +360,15 @@ static void find_metapath(struct gfs2_in
  * metadata tree.
  */
 
-static inline u64 *metapointer(struct buffer_head *bh, int *boundary,
+static inline __be64 *metapointer(struct buffer_head *bh, int *boundary,
 			       unsigned int height, const struct metapath *mp)
 {
 	unsigned int head_size = (height > 0) ?
 		sizeof(struct gfs2_meta_header) : sizeof(struct gfs2_dinode);
-	u64 *ptr;
+	__be64 *ptr;
 	*boundary = 0;
-	ptr = ((u64 *)(bh->b_data + head_size)) + mp->mp_list[height];
-	if (ptr + 1 == (u64 *)(bh->b_data + bh->b_size))
+	ptr = ((__be64 *)(bh->b_data + head_size)) + mp->mp_list[height];
+	if (ptr + 1 == (__be64 *)(bh->b_data + bh->b_size))
 		*boundary = 1;
 	return ptr;
 }
@@ -394,7 +394,7 @@ static int lookup_block(struct gfs2_inod
 			int *new, u64 *block)
 {
 	int boundary;
-	u64 *ptr = metapointer(bh, &boundary, height, mp);
+	__be64 *ptr = metapointer(bh, &boundary, height, mp);
 
 	if (*ptr) {
 		*block = be64_to_cpu(*ptr);
@@ -600,7 +600,7 @@ static int recursive_scan(struct gfs2_in
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct buffer_head *bh = NULL;
-	u64 *top, *bottom;
+	__be64 *top, *bottom;
 	u64 bn;
 	int error;
 	int mh_size = sizeof(struct gfs2_meta_header);
@@ -611,17 +611,17 @@ static int recursive_scan(struct gfs2_in
 			return error;
 		dibh = bh;
 
-		top = (u64 *)(bh->b_data + sizeof(struct gfs2_dinode)) + mp->mp_list[0];
-		bottom = (u64 *)(bh->b_data + sizeof(struct gfs2_dinode)) + sdp->sd_diptrs;
+		top = (__be64 *)(bh->b_data + sizeof(struct gfs2_dinode)) + mp->mp_list[0];
+		bottom = (__be64 *)(bh->b_data + sizeof(struct gfs2_dinode)) + sdp->sd_diptrs;
 	} else {
 		error = gfs2_meta_indirect_buffer(ip, height, block, 0, &bh);
 		if (error)
 			return error;
 
-		top = (u64 *)(bh->b_data + mh_size) +
+		top = (__be64 *)(bh->b_data + mh_size) +
 				  (first ? mp->mp_list[height] : 0);
 
-		bottom = (u64 *)(bh->b_data + mh_size) + sdp->sd_inptrs;
+		bottom = (__be64 *)(bh->b_data + mh_size) + sdp->sd_inptrs;
 	}
 
 	error = bc(ip, dibh, bh, top, bottom, height, data);
@@ -660,7 +660,7 @@ out:
  */
 
 static int do_strip(struct gfs2_inode *ip, struct buffer_head *dibh,
-		    struct buffer_head *bh, u64 *top, u64 *bottom,
+		    struct buffer_head *bh, __be64 *top, __be64 *bottom,
 		    unsigned int height, void *data)
 {
 	struct strip_mine *sm = data;
@@ -668,7 +668,7 @@ static int do_strip(struct gfs2_inode *i
 	struct gfs2_rgrp_list rlist;
 	u64 bn, bstart;
 	u32 blen;
-	u64 *p;
+	__be64 *p;
 	unsigned int rg_blocks = 0;
 	int metadata;
 	unsigned int revokes = 0;
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index d67a376..59dc823 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -713,12 +713,12 @@ static int get_leaf(struct gfs2_inode *d
 static int get_leaf_nr(struct gfs2_inode *dip, u32 index,
 		       u64 *leaf_out)
 {
-	u64 leaf_no;
+	__be64 leaf_no;
 	int error;
 
 	error = gfs2_dir_read_data(dip, (char *)&leaf_no,
-				    index * sizeof(u64),
-				    sizeof(u64), 0);
+				    index * sizeof(__be64),
+				    sizeof(__be64), 0);
 	if (error != sizeof(u64))
 		return (error < 0) ? error : -EIO;
 
@@ -837,7 +837,8 @@ static int dir_make_exhash(struct inode 
 	struct gfs2_leaf *leaf;
 	int y;
 	u32 x;
-	u64 *lp, bn;
+	__be64 *lp;
+	u64 bn;
 	int error;
 
 	error = gfs2_meta_inode_buffer(dip, &dibh);
@@ -893,7 +894,7 @@ static int dir_make_exhash(struct inode 
 	gfs2_trans_add_bh(dip->i_gl, dibh, 1);
 	gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
 
-	lp = (u64 *)(dibh->b_data + sizeof(struct gfs2_dinode));
+	lp = (__be64 *)(dibh->b_data + sizeof(struct gfs2_dinode));
 
 	for (x = sdp->sd_hash_ptrs; x--; lp++)
 		*lp = cpu_to_be64(bn);
@@ -929,7 +930,8 @@ static int dir_split_leaf(struct inode *
 	struct gfs2_leaf *nleaf, *oleaf;
 	struct gfs2_dirent *dent = NULL, *prev = NULL, *next = NULL, *new;
 	u32 start, len, half_len, divider;
-	u64 bn, *lp, leaf_no;
+	u64 bn, leaf_no;
+	__be64 *lp;
 	u32 index;
 	int x, moved = 0;
 	int error;
@@ -974,7 +976,7 @@ static int dir_split_leaf(struct inode *
 	/* Change the pointers.
 	   Don't bother distinguishing stuffed from non-stuffed.
 	   This code is complicated enough already. */
-	lp = kmalloc(half_len * sizeof(u64), GFP_NOFS | __GFP_NOFAIL);
+	lp = kmalloc(half_len * sizeof(__be64), GFP_NOFS | __GFP_NOFAIL);
 	/*  Change the pointers  */
 	for (x = 0; x < half_len; x++)
 		lp[x] = cpu_to_be64(bn);
@@ -1341,7 +1343,7 @@ static int dir_e_read(struct inode *inod
 	u32 hsize, len = 0;
 	u32 ht_offset, lp_offset, ht_offset_cur = -1;
 	u32 hash, index;
-	u64 *lp;
+	__be64 *lp;
 	int copied = 0;
 	int error = 0;
 	unsigned depth = 0;
@@ -1365,7 +1367,7 @@ static int dir_e_read(struct inode *inod
 
 		if (ht_offset_cur != ht_offset) {
 			error = gfs2_dir_read_data(dip, (char *)lp,
-						ht_offset * sizeof(u64),
+						ht_offset * sizeof(__be64),
 						sdp->sd_hash_bsize, 1);
 			if (error != sdp->sd_hash_bsize) {
 				if (error >= 0)
@@ -1715,7 +1717,7 @@ static int foreach_leaf(struct gfs2_inod
 	u32 hsize, len;
 	u32 ht_offset, lp_offset, ht_offset_cur = -1;
 	u32 index = 0;
-	u64 *lp;
+	__be64 *lp;
 	u64 leaf_no;
 	int error = 0;
 
@@ -1735,7 +1737,7 @@ static int foreach_leaf(struct gfs2_inod
 
 		if (ht_offset_cur != ht_offset) {
 			error = gfs2_dir_read_data(dip, (char *)lp,
-						ht_offset * sizeof(u64),
+						ht_offset * sizeof(__be64),
 						sdp->sd_hash_bsize, 1);
 			if (error != sdp->sd_hash_bsize) {
 				if (error >= 0)
diff --git a/fs/gfs2/eattr.c b/fs/gfs2/eattr.c
index a65a4cc..518f0c0 100644
--- a/fs/gfs2/eattr.c
+++ b/fs/gfs2/eattr.c
@@ -112,7 +112,7 @@ fail:
 static int ea_foreach(struct gfs2_inode *ip, ea_call_t ea_call, void *data)
 {
 	struct buffer_head *bh, *eabh;
-	u64 *eablk, *end;
+	__be64 *eablk, *end;
 	int error;
 
 	error = gfs2_meta_read(ip->i_gl, ip->i_di.di_eattr, DIO_WAIT, &bh);
@@ -129,7 +129,7 @@ static int ea_foreach(struct gfs2_inode 
 		goto out;
 	}
 
-	eablk = (u64 *)(bh->b_data + sizeof(struct gfs2_meta_header));
+	eablk = (__be64 *)(bh->b_data + sizeof(struct gfs2_meta_header));
 	end = eablk + GFS2_SB(&ip->i_inode)->sd_inptrs;
 
 	for (; eablk < end; eablk++) {
@@ -224,7 +224,8 @@ static int ea_dealloc_unstuffed(struct g
 	struct gfs2_rgrpd *rgd;
 	struct gfs2_holder rg_gh;
 	struct buffer_head *dibh;
-	u64 *dataptrs, bn = 0;
+	__be64 *dataptrs;
+	u64 bn = 0;
 	u64 bstart = 0;
 	unsigned int blen = 0;
 	unsigned int blks = 0;
@@ -444,7 +445,7 @@ static int ea_get_unstuffed(struct gfs2_
 	struct buffer_head **bh;
 	unsigned int amount = GFS2_EA_DATA_LEN(ea);
 	unsigned int nptrs = DIV_ROUND_UP(amount, sdp->sd_jbsize);
-	u64 *dataptrs = GFS2_EA2DATAPTRS(ea);
+	__be64 *dataptrs = GFS2_EA2DATAPTRS(ea);
 	unsigned int x;
 	int error = 0;
 
@@ -629,7 +630,7 @@ static int ea_write(struct gfs2_inode *i
 		ea->ea_num_ptrs = 0;
 		memcpy(GFS2_EA2DATA(ea), er->er_data, er->er_data_len);
 	} else {
-		u64 *dataptr = GFS2_EA2DATAPTRS(ea);
+		__be64 *dataptr = GFS2_EA2DATAPTRS(ea);
 		const char *data = er->er_data;
 		unsigned int data_len = er->er_data_len;
 		unsigned int copy;
@@ -931,12 +932,12 @@ static int ea_set_block(struct gfs2_inod
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct buffer_head *indbh, *newbh;
-	u64 *eablk;
+	__be64 *eablk;
 	int error;
 	int mh_size = sizeof(struct gfs2_meta_header);
 
 	if (ip->i_di.di_flags & GFS2_DIF_EA_INDIRECT) {
-		u64 *end;
+		__be64 *end;
 
 		error = gfs2_meta_read(ip->i_gl, ip->i_di.di_eattr, DIO_WAIT,
 				       &indbh);
@@ -948,7 +949,7 @@ static int ea_set_block(struct gfs2_inod
 			goto out;
 		}
 
-		eablk = (u64 *)(indbh->b_data + mh_size);
+		eablk = (__be64 *)(indbh->b_data + mh_size);
 		end = eablk + sdp->sd_inptrs;
 
 		for (; eablk < end; eablk++)
@@ -971,7 +972,7 @@ static int ea_set_block(struct gfs2_inod
 		gfs2_metatype_set(indbh, GFS2_METATYPE_IN, GFS2_FORMAT_IN);
 		gfs2_buffer_clear_tail(indbh, mh_size);
 
-		eablk = (u64 *)(indbh->b_data + mh_size);
+		eablk = (__be64 *)(indbh->b_data + mh_size);
 		*eablk = cpu_to_be64(ip->i_di.di_eattr);
 		ip->i_di.di_eattr = blk;
 		ip->i_di.di_flags |= GFS2_DIF_EA_INDIRECT;
@@ -1202,7 +1203,7 @@ static int ea_acl_chmod_unstuffed(struct
 	struct buffer_head **bh;
 	unsigned int amount = GFS2_EA_DATA_LEN(ea);
 	unsigned int nptrs = DIV_ROUND_UP(amount, sdp->sd_jbsize);
-	u64 *dataptrs = GFS2_EA2DATAPTRS(ea);
+	__be64 *dataptrs = GFS2_EA2DATAPTRS(ea);
 	unsigned int x;
 	int error;
 
@@ -1300,7 +1301,7 @@ static int ea_dealloc_indirect(struct gf
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct gfs2_rgrp_list rlist;
 	struct buffer_head *indbh, *dibh;
-	u64 *eablk, *end;
+	__be64 *eablk, *end;
 	unsigned int rg_blocks = 0;
 	u64 bstart = 0;
 	unsigned int blen = 0;
@@ -1319,7 +1320,7 @@ static int ea_dealloc_indirect(struct gf
 		goto out;
 	}
 
-	eablk = (u64 *)(indbh->b_data + sizeof(struct gfs2_meta_header));
+	eablk = (__be64 *)(indbh->b_data + sizeof(struct gfs2_meta_header));
 	end = eablk + sdp->sd_inptrs;
 
 	for (; eablk < end; eablk++) {
@@ -1363,7 +1364,7 @@ static int ea_dealloc_indirect(struct gf
 
 	gfs2_trans_add_bh(ip->i_gl, indbh, 1);
 
-	eablk = (u64 *)(indbh->b_data + sizeof(struct gfs2_meta_header));
+	eablk = (__be64 *)(indbh->b_data + sizeof(struct gfs2_meta_header));
 	bstart = 0;
 	blen = 0;
 
diff --git a/fs/gfs2/eattr.h b/fs/gfs2/eattr.h
index ffa6594..c82dbe0 100644
--- a/fs/gfs2/eattr.h
+++ b/fs/gfs2/eattr.h
@@ -19,7 +19,7 @@ #define GFS2_EA_DATA_LEN(ea) be32_to_cpu
 #define GFS2_EA_SIZE(ea) \
 ALIGN(sizeof(struct gfs2_ea_header) + (ea)->ea_name_len + \
       ((GFS2_EA_IS_STUFFED(ea)) ? GFS2_EA_DATA_LEN(ea) : \
-                                  (sizeof(u64) * (ea)->ea_num_ptrs)), 8)
+                                  (sizeof(__be64) * (ea)->ea_num_ptrs)), 8)
 
 #define GFS2_EA_IS_STUFFED(ea) (!(ea)->ea_num_ptrs)
 #define GFS2_EA_IS_LAST(ea) ((ea)->ea_flags & GFS2_EAFLAG_LAST)
@@ -29,13 +29,13 @@ ALIGN(sizeof(struct gfs2_ea_header) + (e
 
 #define GFS2_EAREQ_SIZE_UNSTUFFED(sdp, er) \
 ALIGN(sizeof(struct gfs2_ea_header) + (er)->er_name_len + \
-      sizeof(u64) * DIV_ROUND_UP((er)->er_data_len, (sdp)->sd_jbsize), 8)
+      sizeof(__be64) * DIV_ROUND_UP((er)->er_data_len, (sdp)->sd_jbsize), 8)
 
 #define GFS2_EA2NAME(ea) ((char *)((struct gfs2_ea_header *)(ea) + 1))
 #define GFS2_EA2DATA(ea) (GFS2_EA2NAME(ea) + (ea)->ea_name_len)
 
 #define GFS2_EA2DATAPTRS(ea) \
-((u64 *)(GFS2_EA2NAME(ea) + ALIGN((ea)->ea_name_len, 8)))
+((__be64 *)(GFS2_EA2NAME(ea) + ALIGN((ea)->ea_name_len, 8)))
 
 #define GFS2_EA2NEXT(ea) \
 ((struct gfs2_ea_header *)((char *)(ea) + GFS2_EA_REC_LEN(ea)))
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index dadd1f3..fb96930 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -500,21 +500,22 @@ static int pick_formal_ino_2(struct gfs2
 	if (!ir.ir_length) {
 		struct buffer_head *m_bh;
 		u64 x, y;
+		__be64 z;
 
 		error = gfs2_meta_inode_buffer(m_ip, &m_bh);
 		if (error)
 			goto out_brelse;
 
-		x = *(u64 *)(m_bh->b_data + sizeof(struct gfs2_dinode));
-		x = y = be64_to_cpu(x);
+		z = *(__be64 *)(m_bh->b_data + sizeof(struct gfs2_dinode));
+		x = y = be64_to_cpu(z);
 		ir.ir_start = x;
 		ir.ir_length = GFS2_INUM_QUANTUM;
 		x += GFS2_INUM_QUANTUM;
 		if (x < y)
 			gfs2_consist_inode(m_ip);
-		x = cpu_to_be64(x);
+		z = cpu_to_be64(x);
 		gfs2_trans_add_bh(m_ip->i_gl, m_bh, 1);
-		*(u64 *)(m_bh->b_data + sizeof(struct gfs2_dinode)) = x;
+		*(__be64 *)(m_bh->b_data + sizeof(struct gfs2_dinode)) = z;
 
 		brelse(m_bh);
 	}
diff --git a/fs/gfs2/ops_export.c b/fs/gfs2/ops_export.c
index 33423a5..b4e7b87 100644
--- a/fs/gfs2/ops_export.c
+++ b/fs/gfs2/ops_export.c
@@ -27,13 +27,14 @@ #include "rgrp.h"
 #include "util.h"
 
 static struct dentry *gfs2_decode_fh(struct super_block *sb,
-				     __u32 *fh,
+				     __u32 *p,
 				     int fh_len,
 				     int fh_type,
 				     int (*acceptable)(void *context,
 						       struct dentry *dentry),
 				     void *context)
 {
+	__be32 *fh = (__force __be32 *)p;
 	struct gfs2_fh_obj fh_obj;
 	struct gfs2_inum_host *this, parent;
 
@@ -65,9 +66,10 @@ static struct dentry *gfs2_decode_fh(str
 						    acceptable, context);
 }
 
-static int gfs2_encode_fh(struct dentry *dentry, __u32 *fh, int *len,
+static int gfs2_encode_fh(struct dentry *dentry, __u32 *p, int *len,
 			  int connectable)
 {
+	__be32 *fh = (__force __be32 *)p;
 	struct inode *inode = dentry->d_inode;
 	struct super_block *sb = inode->i_sb;
 	struct gfs2_inode *ip = GFS2_I(inode);
@@ -76,14 +78,10 @@ static int gfs2_encode_fh(struct dentry 
 	    (connectable && *len < GFS2_LARGE_FH_SIZE))
 		return 255;
 
-	fh[0] = ip->i_num.no_formal_ino >> 32;
-	fh[0] = cpu_to_be32(fh[0]);
-	fh[1] = ip->i_num.no_formal_ino & 0xFFFFFFFF;
-	fh[1] = cpu_to_be32(fh[1]);
-	fh[2] = ip->i_num.no_addr >> 32;
-	fh[2] = cpu_to_be32(fh[2]);
-	fh[3] = ip->i_num.no_addr & 0xFFFFFFFF;
-	fh[3] = cpu_to_be32(fh[3]);
+	fh[0] = cpu_to_be32(ip->i_num.no_formal_ino >> 32);
+	fh[1] = cpu_to_be32(ip->i_num.no_formal_ino & 0xFFFFFFFF);
+	fh[2] = cpu_to_be32(ip->i_num.no_addr >> 32);
+	fh[3] = cpu_to_be32(ip->i_num.no_addr & 0xFFFFFFFF);
 	*len = GFS2_SMALL_FH_SIZE;
 
 	if (!connectable || inode == sb->s_root->d_inode)
@@ -95,14 +93,10 @@ static int gfs2_encode_fh(struct dentry 
 	igrab(inode);
 	spin_unlock(&dentry->d_lock);
 
-	fh[4] = ip->i_num.no_formal_ino >> 32;
-	fh[4] = cpu_to_be32(fh[4]);
-	fh[5] = ip->i_num.no_formal_ino & 0xFFFFFFFF;
-	fh[5] = cpu_to_be32(fh[5]);
-	fh[6] = ip->i_num.no_addr >> 32;
-	fh[6] = cpu_to_be32(fh[6]);
-	fh[7] = ip->i_num.no_addr & 0xFFFFFFFF;
-	fh[7] = cpu_to_be32(fh[7]);
+	fh[4] = cpu_to_be32(ip->i_num.no_formal_ino >> 32);
+	fh[5] = cpu_to_be32(ip->i_num.no_formal_ino & 0xFFFFFFFF);
+	fh[6] = cpu_to_be32(ip->i_num.no_addr >> 32);
+	fh[7] = cpu_to_be32(ip->i_num.no_addr & 0xFFFFFFFF);
 
 	fh[8]  = cpu_to_be32(inode->i_mode);
 	fh[9]  = 0;	/* pad to double word */
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 009d86c..5d00e9b 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -539,8 +539,7 @@ static void do_qc(struct gfs2_quota_data
 		qc->qc_id = cpu_to_be32(qd->qd_id);
 	}
 
-	x = qc->qc_change;
-	x = be64_to_cpu(x) + change;
+	x = be64_to_cpu(qc->qc_change) + change;
 	qc->qc_change = cpu_to_be64(x);
 
 	spin_lock(&sdp->sd_quota_spin);
diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index 76a5089..ca8667c 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -83,8 +83,7 @@ static inline int gfs2_meta_check_i(stru
 				    char *file, unsigned int line)
 {
 	struct gfs2_meta_header *mh = (struct gfs2_meta_header *)bh->b_data;
-	u32 magic = mh->mh_magic;
-	magic = be32_to_cpu(magic);
+	u32 magic = be32_to_cpu(mh->mh_magic);
 	if (unlikely(magic != GFS2_MAGIC))
 		return gfs2_meta_check_ii(sdp, bh, "magic number", function,
 					  file, line);
@@ -107,9 +106,8 @@ static inline int gfs2_metatype_check_i(
 					char *file, unsigned int line)
 {
 	struct gfs2_meta_header *mh = (struct gfs2_meta_header *)bh->b_data;
-	u32 magic = mh->mh_magic;
+	u32 magic = be32_to_cpu(mh->mh_magic);
 	u16 t = be32_to_cpu(mh->mh_type);
-	magic = be32_to_cpu(magic);
 	if (unlikely(magic != GFS2_MAGIC))
 		return gfs2_meta_check_ii(sdp, bh, "magic number", function,
 					  file, line);
-- 
1.4.1



