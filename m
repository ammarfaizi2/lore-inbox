Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936317AbWK3MSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936317AbWK3MSX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936324AbWK3MSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:18:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63114 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936322AbWK3MSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:18:17 -0500
Subject: [GFS2] Remove gfs2_inode_attr_in [35/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:18:37 +0000
Message-Id: <1164889117.3752.374.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 9e2dbdac3df300516ffdd9a8631f23164d068a50 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 8 Nov 2006 15:45:46 -0500
Subject: [PATCH] [GFS2] Remove gfs2_inode_attr_in

This function wasn't really doing the right thing. There was no need
to update the inode size at this point and the updating of the
i_blocks field has now been moved to the places where di_blocks is
updated. A result of this patch and some those preceeding it is that
unlocking a glock is now a much more efficient process, since there
is no longer any requirement to copy data from the gfs2 inode into
the vfs inode at this point.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/bmap.c  |    4 ++++
 fs/gfs2/dir.c   |    4 ++++
 fs/gfs2/eattr.c |    6 ++++++
 fs/gfs2/glops.c |    8 ++------
 fs/gfs2/inode.c |   21 +++------------------
 fs/gfs2/inode.h |    7 +++++++
 6 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 692d4a3..06e3447 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -163,6 +163,7 @@ int gfs2_unstuff_dinode(struct gfs2_inod
 	if (ip->i_di.di_size) {
 		*(__be64 *)(di + 1) = cpu_to_be64(block);
 		ip->i_di.di_blocks++;
+		gfs2_set_inode_blocks(&ip->i_inode);
 		di->di_blocks = cpu_to_be64(ip->i_di.di_blocks);
 	}
 
@@ -272,6 +273,7 @@ static int build_height(struct inode *in
 	*(__be64 *)(di + 1) = cpu_to_be64(bn);
 	ip->i_di.di_height += new_height;
 	ip->i_di.di_blocks += new_height;
+	gfs2_set_inode_blocks(&ip->i_inode);
 	di->di_height = cpu_to_be16(ip->i_di.di_height);
 	di->di_blocks = cpu_to_be64(ip->i_di.di_blocks);
 	brelse(dibh);
@@ -415,6 +417,7 @@ static int lookup_block(struct gfs2_inod
 
 	*ptr = cpu_to_be64(*block);
 	ip->i_di.di_blocks++;
+	gfs2_set_inode_blocks(&ip->i_inode);
 
 	*new = 1;
 	return 0;
@@ -770,6 +773,7 @@ static int do_strip(struct gfs2_inode *i
 		if (!ip->i_di.di_blocks)
 			gfs2_consist_inode(ip);
 		ip->i_di.di_blocks--;
+		gfs2_set_inode_blocks(&ip->i_inode);
 	}
 	if (bstart) {
 		if (metadata)
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index c82d7cb..a2923fb 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -901,6 +901,7 @@ static int dir_make_exhash(struct inode 
 
 	dip->i_di.di_size = sdp->sd_sb.sb_bsize / 2;
 	dip->i_di.di_blocks++;
+	gfs2_set_inode_blocks(&dip->i_inode);
 	dip->i_di.di_flags |= GFS2_DIF_EXHASH;
 
 	for (x = sdp->sd_hash_ptrs, y = -1; x; x >>= 1, y++) ;
@@ -1038,6 +1039,7 @@ static int dir_split_leaf(struct inode *
 	error = gfs2_meta_inode_buffer(dip, &dibh);
 	if (!gfs2_assert_withdraw(GFS2_SB(&dip->i_inode), !error)) {
 		dip->i_di.di_blocks++;
+		gfs2_set_inode_blocks(&dip->i_inode);
 		gfs2_dinode_out(dip, dibh->b_data);
 		brelse(dibh);
 	}
@@ -1516,6 +1518,7 @@ static int dir_new_leaf(struct inode *in
 		return error;
 	gfs2_trans_add_bh(ip->i_gl, bh, 1);
 	ip->i_di.di_blocks++;
+	gfs2_set_inode_blocks(&ip->i_inode);
 	gfs2_dinode_out(ip, bh->b_data);
 	brelse(bh);
 	return 0;
@@ -1860,6 +1863,7 @@ static int leaf_dealloc(struct gfs2_inod
 		if (!dip->i_di.di_blocks)
 			gfs2_consist_inode(dip);
 		dip->i_di.di_blocks--;
+		gfs2_set_inode_blocks(&dip->i_inode);
 	}
 
 	error = gfs2_dir_write_data(dip, ht, index * sizeof(u64), size);
diff --git a/fs/gfs2/eattr.c b/fs/gfs2/eattr.c
index 7dde847..ebebbdc 100644
--- a/fs/gfs2/eattr.c
+++ b/fs/gfs2/eattr.c
@@ -281,6 +281,7 @@ static int ea_dealloc_unstuffed(struct g
 		if (!ip->i_di.di_blocks)
 			gfs2_consist_inode(ip);
 		ip->i_di.di_blocks--;
+		gfs2_set_inode_blocks(&ip->i_inode);
 	}
 	if (bstart)
 		gfs2_free_meta(ip, bstart, blen);
@@ -598,6 +599,7 @@ static int ea_alloc_blk(struct gfs2_inod
 	ea->ea_num_ptrs = 0;
 
 	ip->i_di.di_blocks++;
+	gfs2_set_inode_blocks(&ip->i_inode);
 
 	return 0;
 }
@@ -649,6 +651,7 @@ static int ea_write(struct gfs2_inode *i
 			gfs2_metatype_set(bh, GFS2_METATYPE_ED, GFS2_FORMAT_ED);
 
 			ip->i_di.di_blocks++;
+			gfs2_set_inode_blocks(&ip->i_inode);
 
 			copy = data_len > sdp->sd_jbsize ? sdp->sd_jbsize :
 							   data_len;
@@ -977,6 +980,7 @@ static int ea_set_block(struct gfs2_inod
 		ip->i_di.di_eattr = blk;
 		ip->i_di.di_flags |= GFS2_DIF_EA_INDIRECT;
 		ip->i_di.di_blocks++;
+		gfs2_set_inode_blocks(&ip->i_inode);
 
 		eablk++;
 	}
@@ -1387,6 +1391,7 @@ static int ea_dealloc_indirect(struct gf
 		if (!ip->i_di.di_blocks)
 			gfs2_consist_inode(ip);
 		ip->i_di.di_blocks--;
+		gfs2_set_inode_blocks(&ip->i_inode);
 	}
 	if (bstart)
 		gfs2_free_meta(ip, bstart, blen);
@@ -1441,6 +1446,7 @@ static int ea_dealloc_block(struct gfs2_
 	if (!ip->i_di.di_blocks)
 		gfs2_consist_inode(ip);
 	ip->i_di.di_blocks--;
+	gfs2_set_inode_blocks(&ip->i_inode);
 
 	error = gfs2_meta_inode_buffer(ip, &dibh);
 	if (!error) {
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 9c20337..b92de0a 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -356,7 +356,6 @@ static int inode_go_lock(struct gfs2_hol
 		error = gfs2_inode_refresh(ip);
 		if (error)
 			return error;
-		gfs2_inode_attr_in(ip);
 	}
 
 	if ((ip->i_di.di_flags & GFS2_DIF_TRUNC_IN_PROG) &&
@@ -380,11 +379,8 @@ static void inode_go_unlock(struct gfs2_
 	struct gfs2_glock *gl = gh->gh_gl;
 	struct gfs2_inode *ip = gl->gl_object;
 
-	if (ip == NULL)
-		return;
-	if (test_bit(GLF_DIRTY, &gl->gl_flags))
-		gfs2_inode_attr_in(ip);
-	gfs2_meta_cache_flush(ip);
+	if (ip)
+		gfs2_meta_cache_flush(ip);
 }
 
 /**
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 19b2736..ea9ca23 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -38,29 +38,12 @@ #include "rgrp.h"
 #include "trans.h"
 #include "util.h"
 
-/**
- * gfs2_inode_attr_in - Copy attributes from the dinode into the VFS inode
- * @ip: The GFS2 inode (with embedded disk inode data)
- * @inode:  The Linux VFS inode
- *
- */
-
-void gfs2_inode_attr_in(struct gfs2_inode *ip)
-{
-	struct inode *inode = &ip->i_inode;
-	struct gfs2_dinode_host *di = &ip->i_di;
-
-	i_size_write(inode, di->di_size);
-	inode->i_blocks = di->di_blocks <<
-		(GFS2_SB(inode)->sd_sb.sb_bsize_shift - GFS2_BASIC_BLOCK_SHIFT);
-}
-
 static int iget_test(struct inode *inode, void *opaque)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_inum_host *inum = opaque;
 
-	if (ip && ip->i_num.no_addr == inum->no_addr)
+	if (ip->i_num.no_addr == inum->no_addr)
 		return 1;
 
 	return 0;
@@ -187,7 +170,9 @@ static int gfs2_dinode_in(struct gfs2_in
 	 */
 	ip->i_inode.i_nlink = be32_to_cpu(str->di_nlink);
 	di->di_size = be64_to_cpu(str->di_size);
+	i_size_write(&ip->i_inode, di->di_size);
 	di->di_blocks = be64_to_cpu(str->di_blocks);
+	gfs2_set_inode_blocks(&ip->i_inode);
 	ip->i_inode.i_atime.tv_sec = be64_to_cpu(str->di_atime);
 	ip->i_inode.i_atime.tv_nsec = 0;
 	ip->i_inode.i_mtime.tv_sec = be64_to_cpu(str->di_mtime);
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index 54d584e..46917ed 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -25,6 +25,13 @@ static inline int gfs2_is_dir(struct gfs
 	return S_ISDIR(ip->i_inode.i_mode);
 }
 
+static inline void gfs2_set_inode_blocks(struct inode *inode)
+{
+	struct gfs2_inode *ip = GFS2_I(inode);
+	inode->i_blocks = ip->i_di.di_blocks <<
+		(GFS2_SB(inode)->sd_sb.sb_bsize_shift - GFS2_BASIC_BLOCK_SHIFT);
+}
+
 void gfs2_inode_attr_in(struct gfs2_inode *ip);
 struct inode *gfs2_inode_lookup(struct super_block *sb, struct gfs2_inum_host *inum, unsigned type);
 struct inode *gfs2_ilookup(struct super_block *sb, struct gfs2_inum_host *inum);
-- 
1.4.1



