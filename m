Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbVIAObD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbVIAObD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbVIAOac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:30:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50651 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965148AbVIAO3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:29:10 -0400
Date: Thu, 1 Sep 2005 21:54:53 +0800
From: David Teigland <teigland@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02a/13] GFS: core fs
Message-ID: <20050901135453.GB25581@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Core file system functions.

Signed-off-by: Ken Preslan <ken@preslan.org>
Signed-off-by: David Teigland <teigland@redhat.com>

---

 fs/gfs2/bmap.c   | 1213 +++++++++++++++++++++++++++++++++++++
 fs/gfs2/bmap.h   |   39 +
 fs/gfs2/daemon.c |  226 ++++++
 fs/gfs2/daemon.h |   20 
 fs/gfs2/format.h |   21 
 fs/gfs2/glops.c  |  488 ++++++++++++++
 fs/gfs2/glops.h  |   23 
 fs/gfs2/inode.c  | 1793 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/inode.h  |   74 ++
 9 files changed, 3897 insertions(+)

--- a/fs/gfs2/bmap.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/bmap.c	2005-09-01 17:36:55.156139640 +0800
@@ -0,0 +1,1213 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "bmap.h"
+#include "glock.h"
+#include "inode.h"
+#include "jdata.h"
+#include "meta_io.h"
+#include "page.h"
+#include "quota.h"
+#include "rgrp.h"
+#include "trans.h"
+
+struct metapath {
+	unsigned int mp_list[GFS2_MAX_META_HEIGHT];
+};
+
+typedef int (*block_call_t) (struct gfs2_inode *ip, struct buffer_head *dibh,
+			     struct buffer_head *bh, uint64_t *top,
+			     uint64_t *bottom, unsigned int height,
+			     void *data);
+
+struct strip_mine {
+	int sm_first;
+	unsigned int sm_height;
+};
+
+/**
+ * @gfs2_unstuffer_sync - Synchronously unstuff a dinode
+ * @ip:
+ * @dibh:
+ * @block:
+ * @private:
+ *
+ * Cheat and use a metadata buffer instead of a data page.
+ *
+ * Returns: errno
+ */
+
+int gfs2_unstuffer_sync(struct gfs2_inode *ip, struct buffer_head *dibh,
+			uint64_t block, void *private)
+{
+	struct buffer_head *bh;
+	int error;
+
+	bh = gfs2_meta_new(ip->i_gl, block);
+
+	gfs2_buffer_copy_tail(bh, 0, dibh, sizeof(struct gfs2_dinode));
+
+	set_buffer_dirty(bh);
+	error = sync_dirty_buffer(bh);
+
+	brelse(bh);
+
+	return error;
+}
+
+/**
+ * gfs2_unstuff_dinode - Unstuff a dinode when the data has grown too big
+ * @ip: The GFS2 inode to unstuff
+ * @unstuffer: the routine that handles unstuffing a non-zero length file
+ * @private: private data for the unstuffer
+ *
+ * This routine unstuffs a dinode and returns it to a "normal" state such
+ * that the height can be grown in the traditional way.
+ *
+ * Returns: errno
+ */
+
+int gfs2_unstuff_dinode(struct gfs2_inode *ip, gfs2_unstuffer_t unstuffer,
+			void *private)
+{
+	struct buffer_head *bh, *dibh;
+	uint64_t block = 0;
+	int journaled = gfs2_is_jdata(ip);
+	int error;
+
+	down_write(&ip->i_rw_mutex);
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		goto out;
+		
+	if (ip->i_di.di_size) {
+		/* Get a free block, fill it with the stuffed data,
+		   and write it out to disk */
+
+		if (journaled) {
+			block = gfs2_alloc_meta(ip);
+
+			error = gfs2_jdata_get_buffer(ip, block, TRUE, &bh);
+			if (error)
+				goto out_brelse;
+			gfs2_buffer_copy_tail(bh,
+					      sizeof(struct gfs2_meta_header),
+					      dibh, sizeof(struct gfs2_dinode));
+			brelse(bh);
+		} else {
+			block = gfs2_alloc_data(ip);
+
+			error = unstuffer(ip, dibh, block, private);
+			if (error)
+				goto out_brelse;
+		}
+	}
+
+	/*  Set up the pointer to the new block  */
+
+	gfs2_trans_add_bh(ip->i_gl, dibh);
+
+	gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
+
+	if (ip->i_di.di_size) {
+		*(uint64_t *)(dibh->b_data + sizeof(struct gfs2_dinode)) = cpu_to_gfs2_64(block);
+		ip->i_di.di_blocks++;
+	}
+
+	ip->i_di.di_height = 1;
+
+	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+
+ out_brelse:
+	brelse(dibh);
+
+ out:
+	up_write(&ip->i_rw_mutex);
+
+	return error;
+}
+
+/**
+ * calc_tree_height - Calculate the height of a metadata tree
+ * @ip: The GFS2 inode
+ * @size: The proposed size of the file
+ *
+ * Work out how tall a metadata tree needs to be in order to accommodate a
+ * file of a particular size. If size is less than the current size of
+ * the inode, then the current size of the inode is used instead of the
+ * supplied one.
+ *
+ * Returns: the height the tree should be
+ */
+
+static unsigned int calc_tree_height(struct gfs2_inode *ip, uint64_t size)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	uint64_t *arr;
+	unsigned int max, height;
+
+	if (ip->i_di.di_size > size)
+		size = ip->i_di.di_size;
+
+	if (gfs2_is_jdata(ip)) {
+		arr = sdp->sd_jheightsize;
+		max = sdp->sd_max_jheight;
+	} else {
+		arr = sdp->sd_heightsize;
+		max = sdp->sd_max_height;
+	}
+
+	for (height = 0; height < max; height++)
+		if (arr[height] >= size)
+			break;
+
+	return height;
+}
+
+/**
+ * build_height - Build a metadata tree of the requested height
+ * @ip: The GFS2 inode
+ * @height: The height to build to
+ *
+ * This routine makes sure that the metadata tree is tall enough to hold
+ * "size" bytes of data.
+ *
+ * Returns: errno
+ */
+
+static int build_height(struct gfs2_inode *ip, int height)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct buffer_head *bh, *dibh;
+	uint64_t block = 0, *bp;
+	unsigned int x;
+	int new_block;
+	int error;
+
+	while (ip->i_di.di_height < height) {
+		error = gfs2_meta_inode_buffer(ip, &dibh);
+		if (error)
+			return error;
+
+		new_block = FALSE;
+		bp = (uint64_t *)(dibh->b_data + sizeof(struct gfs2_dinode));
+		for (x = 0; x < sdp->sd_diptrs; x++, bp++)
+			if (*bp) {
+				new_block = TRUE;
+				break;
+			}
+
+		if (new_block) {
+			/* Get a new block, fill it with the old direct
+			   pointers, and write it out */
+
+			block = gfs2_alloc_meta(ip);
+
+			bh = gfs2_meta_new(ip->i_gl, block);
+			gfs2_trans_add_bh(ip->i_gl, bh);
+			gfs2_metatype_set(bh,
+					  GFS2_METATYPE_IN,
+					  GFS2_FORMAT_IN);
+			gfs2_buffer_copy_tail(bh,
+					      sizeof(struct gfs2_meta_header),
+					      dibh, sizeof(struct gfs2_dinode));
+
+			brelse(bh);
+		}
+
+		/*  Set up the new direct pointer and write it out to disk  */
+
+		gfs2_trans_add_bh(ip->i_gl, dibh);
+
+		gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
+
+		if (new_block) {
+			*(uint64_t *)(dibh->b_data + sizeof(struct gfs2_dinode)) = cpu_to_gfs2_64(block);
+			ip->i_di.di_blocks++;
+		}
+
+		ip->i_di.di_height++;
+
+		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		brelse(dibh);
+	}
+
+	return 0;
+}
+
+/**
+ * find_metapath - Find path through the metadata tree
+ * @ip: The inode pointer
+ * @mp: The metapath to return the result in
+ * @block: The disk block to look up
+ *
+ *   This routine returns a struct metapath structure that defines a path
+ *   through the metadata of inode "ip" to get to block "block".
+ *
+ *   Example:
+ *   Given:  "ip" is a height 3 file, "offset" is 101342453, and this is a
+ *   filesystem with a blocksize of 4096.
+ *
+ *   find_metapath() would return a struct metapath structure set to:
+ *   mp_offset = 101342453, mp_height = 3, mp_list[0] = 0, mp_list[1] = 48,
+ *   and mp_list[2] = 165.
+ *
+ *   That means that in order to get to the block containing the byte at
+ *   offset 101342453, we would load the indirect block pointed to by pointer
+ *   0 in the dinode.  We would then load the indirect block pointed to by
+ *   pointer 48 in that indirect block.  We would then load the data block
+ *   pointed to by pointer 165 in that indirect block.
+ *
+ *             ----------------------------------------
+ *             | Dinode |                             |
+ *             |        |                            4|
+ *             |        |0 1 2 3 4 5                 9|
+ *             |        |                            6|
+ *             ----------------------------------------
+ *                       |
+ *                       |
+ *                       V
+ *             ----------------------------------------
+ *             | Indirect Block                       |
+ *             |                                     5|
+ *             |            4 4 4 4 4 5 5            1|
+ *             |0           5 6 7 8 9 0 1            2|
+ *             ----------------------------------------
+ *                                |
+ *                                |
+ *                                V
+ *             ----------------------------------------
+ *             | Indirect Block                       |
+ *             |                         1 1 1 1 1   5|
+ *             |                         6 6 6 6 6   1|
+ *             |0                        3 4 5 6 7   2|
+ *             ----------------------------------------
+ *                                           |
+ *                                           |
+ *                                           V
+ *             ----------------------------------------
+ *             | Data block containing offset         |
+ *             |            101342453                 |
+ *             |                                      |
+ *             |                                      |
+ *             ----------------------------------------
+ *
+ */
+
+static struct metapath *find_metapath(struct gfs2_inode *ip, uint64_t block)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct metapath *mp;
+	uint64_t b = block;
+	unsigned int i;
+
+	mp = kzalloc(sizeof(struct metapath), GFP_KERNEL | __GFP_NOFAIL);
+
+	for (i = ip->i_di.di_height; i--;)
+		mp->mp_list[i] = do_div(b, sdp->sd_inptrs);
+
+	return mp;
+}
+
+/**
+ * metapointer - Return pointer to start of metadata in a buffer
+ * @bh: The buffer
+ * @height: The metadata height (0 = dinode)
+ * @mp: The metapath
+ *
+ * Return a pointer to the block number of the next height of the metadata
+ * tree given a buffer containing the pointer to the current height of the
+ * metadata tree.
+ */
+
+static inline uint64_t *metapointer(struct buffer_head *bh,
+				    unsigned int height, struct metapath *mp)
+{
+	unsigned int head_size = (height > 0) ?
+		sizeof(struct gfs2_meta_header) : sizeof(struct gfs2_dinode);
+
+	return ((uint64_t *)(bh->b_data + head_size)) + mp->mp_list[height];
+}
+
+/**
+ * lookup_block - Get the next metadata block in metadata tree
+ * @ip: The GFS2 inode
+ * @bh: Buffer containing the pointers to metadata blocks
+ * @height: The height of the tree (0 = dinode)
+ * @mp: The metapath
+ * @create: Non-zero if we may create a new meatdata block
+ * @new: Used to indicate if we did create a new metadata block
+ * @block: the returned disk block number
+ *
+ * Given a metatree, complete to a particular height, checks to see if the next
+ * height of the tree exists. If not the next height of the tree is created.
+ * The block number of the next height of the metadata tree is returned.
+ *
+ */
+
+static void lookup_block(struct gfs2_inode *ip, struct buffer_head *bh,
+			 unsigned int height, struct metapath *mp, int create,
+			 int *new, uint64_t *block)
+{
+	uint64_t *ptr = metapointer(bh, height, mp);
+
+	if (*ptr) {
+		*block = gfs2_64_to_cpu(*ptr);
+		return;
+	}
+
+	*block = 0;
+
+	if (!create)
+		return;
+
+	if (height == ip->i_di.di_height - 1 &&
+	    !gfs2_is_jdata(ip))
+		*block = gfs2_alloc_data(ip);
+	else
+		*block = gfs2_alloc_meta(ip);
+
+	gfs2_trans_add_bh(ip->i_gl, bh);
+
+	*ptr = cpu_to_gfs2_64(*block);
+	ip->i_di.di_blocks++;
+
+	*new = 1;
+}
+
+/**
+ * gfs2_block_map - Map a block from an inode to a disk block
+ * @ip: The GFS2 inode
+ * @lblock: The logical block number
+ * @new: Value/Result argument (1 = may create/did create new blocks)
+ * @dblock: the disk block number of the start of an extent
+ * @extlen: the size of the extent
+ *
+ * Find the block number on the current device which corresponds to an
+ * inode's block. If the block had to be created, "new" will be set.
+ *
+ * Returns: errno
+ */
+
+int gfs2_block_map(struct gfs2_inode *ip, uint64_t lblock, int *new,
+		   uint64_t *dblock, uint32_t *extlen)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct buffer_head *bh;
+	struct metapath *mp;
+	int create = *new;
+	unsigned int bsize;
+	unsigned int height;
+	unsigned int end_of_metadata;
+	unsigned int x;
+	int error = 0;
+
+	*new = 0;
+	*dblock = 0;
+	if (extlen)
+		*extlen = 0;
+
+	if (create)
+		down_write(&ip->i_rw_mutex);
+	else
+		down_read(&ip->i_rw_mutex);
+
+	if (gfs2_assert_warn(sdp, !gfs2_is_stuffed(ip)))
+		goto out;
+
+	bsize = (gfs2_is_jdata(ip)) ? sdp->sd_jbsize : sdp->sd_sb.sb_bsize;
+
+	height = calc_tree_height(ip, (lblock + 1) * bsize);
+	if (ip->i_di.di_height < height) {
+		if (!create)
+			goto out;
+
+		error = build_height(ip, height);
+		if (error)
+			goto out;
+	}
+
+	mp = find_metapath(ip, lblock);
+	end_of_metadata = ip->i_di.di_height - 1;
+
+	error = gfs2_meta_inode_buffer(ip, &bh);
+	if (error)
+		goto out_kfree;
+
+	for (x = 0; x < end_of_metadata; x++) {
+		lookup_block(ip, bh, x, mp, create, new, dblock);
+		brelse(bh);
+		if (!*dblock)
+			goto out_kfree;
+
+		error = gfs2_meta_indirect_buffer(ip, x+1, *dblock, *new, &bh);
+		if (error)
+			goto out_kfree;
+	}
+
+	lookup_block(ip, bh, end_of_metadata, mp, create, new, dblock);
+
+	if (extlen && *dblock) {
+		*extlen = 1;
+
+		if (!*new) {
+			uint64_t tmp_dblock;
+			int tmp_new;
+			unsigned int nptrs;
+
+			nptrs = (end_of_metadata) ? sdp->sd_inptrs :
+						    sdp->sd_diptrs;
+
+			while (++mp->mp_list[end_of_metadata] < nptrs) {
+				lookup_block(ip, bh, end_of_metadata, mp,
+					     FALSE, &tmp_new, &tmp_dblock);
+
+				if (*dblock + *extlen != tmp_dblock)
+					break;
+
+				(*extlen)++;
+			}
+		}
+	}
+
+	brelse(bh);
+
+	if (*new) {
+		error = gfs2_meta_inode_buffer(ip, &bh);
+		if (!error) {
+			gfs2_trans_add_bh(ip->i_gl, bh);
+			gfs2_dinode_out(&ip->i_di, bh->b_data);
+			brelse(bh);
+		}
+	}
+
+ out_kfree:
+	kfree(mp);
+
+ out:
+	if (create)
+		up_write(&ip->i_rw_mutex);
+	else
+		up_read(&ip->i_rw_mutex);
+
+	return error;
+}
+
+/**
+ * recursive_scan - recursively scan through the end of a file
+ * @ip: the inode
+ * @dibh: the dinode buffer
+ * @mp: the path through the metadata to the point to start
+ * @height: the height the recursion is at
+ * @block: the indirect block to look at
+ * @first: TRUE if this is the first block
+ * @bc: the call to make for each piece of metadata
+ * @data: data opaque to this function to pass to @bc
+ *
+ * When this is first called @height and @block should be zero and
+ * @first should be TRUE.
+ *
+ * Returns: errno
+ */
+
+static int recursive_scan(struct gfs2_inode *ip, struct buffer_head *dibh,
+			  struct metapath *mp, unsigned int height,
+			  uint64_t block, int first, block_call_t bc,
+			  void *data)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct buffer_head *bh = NULL;
+	uint64_t *top, *bottom;
+	uint64_t bn;
+	int error;
+	int mh_size = sizeof(struct gfs2_meta_header);
+
+	if (!height) {
+		error = gfs2_meta_inode_buffer(ip, &bh);
+		if (error)
+			return error;
+		dibh = bh;
+
+		top = (uint64_t *)(bh->b_data + sizeof(struct gfs2_dinode)) +
+			mp->mp_list[0];
+		bottom = (uint64_t *)(bh->b_data + sizeof(struct gfs2_dinode)) +
+			sdp->sd_diptrs;
+	} else {
+		error = gfs2_meta_indirect_buffer(ip, height, block, FALSE,
+						  &bh);
+		if (error)
+			return error;
+
+		top = (uint64_t *)(bh->b_data + mh_size) +
+				  ((first) ? mp->mp_list[height] : 0);
+
+		bottom = (uint64_t *)(bh->b_data + mh_size) + sdp->sd_inptrs;
+	}
+
+	error = bc(ip, dibh, bh, top, bottom, height, data);
+	if (error)
+		goto out;
+
+	if (height < ip->i_di.di_height - 1)
+		for (; top < bottom; top++, first = FALSE) {
+			if (!*top)
+				continue;
+
+			bn = gfs2_64_to_cpu(*top);
+
+			error = recursive_scan(ip, dibh, mp, height + 1, bn,
+					       first, bc, data);
+			if (error)
+				break;
+		}
+
+ out:
+	brelse(bh);
+
+	return error;
+}
+
+/**
+ * do_strip - Look for a layer a particular layer of the file and strip it off
+ * @ip: the inode
+ * @dibh: the dinode buffer
+ * @bh: A buffer of pointers
+ * @top: The first pointer in the buffer
+ * @bottom: One more than the last pointer
+ * @height: the height this buffer is at
+ * @data: a pointer to a struct strip_mine
+ *
+ * Returns: errno
+ */
+
+static int do_strip(struct gfs2_inode *ip, struct buffer_head *dibh,
+		    struct buffer_head *bh, uint64_t *top, uint64_t *bottom,
+		    unsigned int height, void *data)
+{
+	struct strip_mine *sm = (struct strip_mine *)data;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct gfs2_rgrp_list rlist;
+	uint64_t bn, bstart;
+	uint32_t blen;
+	uint64_t *p;
+	unsigned int rg_blocks = 0;
+	int metadata;
+	unsigned int revokes = 0;
+	int x;
+	int error;
+
+	if (!*top)
+		sm->sm_first = FALSE;
+
+	if (height != sm->sm_height)
+		return 0;
+
+	if (sm->sm_first) {
+		top++;
+		sm->sm_first = FALSE;
+	}
+
+	metadata = (height != ip->i_di.di_height - 1) || gfs2_is_jdata(ip);
+	if (metadata)
+		revokes = (height) ? sdp->sd_inptrs : sdp->sd_diptrs;
+
+	error = gfs2_rindex_hold(sdp, &ip->i_alloc->al_ri_gh);
+	if (error)
+		return error;
+
+	memset(&rlist, 0, sizeof(struct gfs2_rgrp_list));
+	bstart = 0;
+	blen = 0;
+
+	for (p = top; p < bottom; p++) {
+		if (!*p)
+			continue;
+
+		bn = gfs2_64_to_cpu(*p);
+
+		if (bstart + blen == bn)
+			blen++;
+		else {
+			if (bstart)
+				gfs2_rlist_add(sdp, &rlist, bstart);
+
+			bstart = bn;
+			blen = 1;
+		}
+	}
+
+	if (bstart)
+		gfs2_rlist_add(sdp, &rlist, bstart);
+	else
+		goto out; /* Nothing to do */
+
+	gfs2_rlist_alloc(&rlist, LM_ST_EXCLUSIVE, 0);
+
+	for (x = 0; x < rlist.rl_rgrps; x++) {
+		struct gfs2_rgrpd *rgd;
+		rgd = get_gl2rgd(rlist.rl_ghs[x].gh_gl);
+		rg_blocks += rgd->rd_ri.ri_length;
+	}
+
+	error = gfs2_glock_nq_m(rlist.rl_rgrps, rlist.rl_ghs);
+	if (error)
+		goto out_rlist;
+
+	error = gfs2_trans_begin(sdp, rg_blocks + RES_DINODE +
+				 RES_INDIRECT + RES_STATFS + RES_QUOTA,
+				 revokes);
+	if (error)
+		goto out_rg_gunlock;
+
+	down_write(&ip->i_rw_mutex);
+
+	gfs2_trans_add_bh(ip->i_gl, dibh);
+	gfs2_trans_add_bh(ip->i_gl, bh);
+
+	bstart = 0;
+	blen = 0;
+
+	for (p = top; p < bottom; p++) {
+		if (!*p)
+			continue;
+
+		bn = gfs2_64_to_cpu(*p);
+
+		if (bstart + blen == bn)
+			blen++;
+		else {
+			if (bstart) {
+				if (metadata)
+					gfs2_free_meta(ip, bstart, blen);
+				else
+					gfs2_free_data(ip, bstart, blen);
+			}
+
+			bstart = bn;
+			blen = 1;
+		}
+
+		*p = 0;
+		if (!ip->i_di.di_blocks)
+			gfs2_consist_inode(ip);
+		ip->i_di.di_blocks--;
+	}
+	if (bstart) {
+		if (metadata)
+			gfs2_free_meta(ip, bstart, blen);
+		else
+			gfs2_free_data(ip, bstart, blen);
+	}
+
+	ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
+
+	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+
+	up_write(&ip->i_rw_mutex);
+
+	gfs2_trans_end(sdp);
+
+ out_rg_gunlock:
+	gfs2_glock_dq_m(rlist.rl_rgrps, rlist.rl_ghs);
+
+ out_rlist:
+	gfs2_rlist_free(&rlist);
+
+ out:
+	gfs2_glock_dq_uninit(&ip->i_alloc->al_ri_gh);
+
+	return error;
+}
+
+/**
+ * do_grow - Make a file look bigger than it is
+ * @ip: the inode
+ * @size: the size to set the file to
+ *
+ * Called with an exclusive lock on @ip.
+ *
+ * Returns: errno
+ */
+
+static int do_grow(struct gfs2_inode *ip, uint64_t size)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct gfs2_alloc *al;
+	struct buffer_head *dibh;
+	unsigned int h;
+	int error;
+
+	al = gfs2_alloc_get(ip);
+
+	error = gfs2_quota_lock(ip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
+	if (error)
+		goto out;
+
+	error = gfs2_quota_check(ip, ip->i_di.di_uid, ip->i_di.di_gid);
+	if (error)
+		goto out_gunlock_q;
+
+	al->al_requested = sdp->sd_max_height + RES_DATA;
+
+	error = gfs2_inplace_reserve(ip);
+	if (error)
+		goto out_gunlock_q;
+
+	error = gfs2_trans_begin(sdp,
+			sdp->sd_max_height + al->al_rgd->rd_ri.ri_length +
+			RES_JDATA + RES_DINODE + RES_STATFS + RES_QUOTA, 0);
+	if (error)
+		goto out_ipres;
+
+	if (size > sdp->sd_sb.sb_bsize - sizeof(struct gfs2_dinode)) {
+		if (gfs2_is_stuffed(ip)) {
+			error = gfs2_unstuff_dinode(ip, gfs2_unstuffer_page,
+						    NULL);
+			if (error)
+				goto out_end_trans;
+		}
+
+		h = calc_tree_height(ip, size);
+		if (ip->i_di.di_height < h) {
+			down_write(&ip->i_rw_mutex);
+			error = build_height(ip, h);
+			up_write(&ip->i_rw_mutex);
+			if (error)
+				goto out_end_trans;
+		}
+	}
+
+	ip->i_di.di_size = size;
+	ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		goto out_end_trans;
+
+	gfs2_trans_add_bh(ip->i_gl, dibh);
+	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	brelse(dibh);
+
+ out_end_trans:
+	gfs2_trans_end(sdp);
+
+ out_ipres:
+	gfs2_inplace_release(ip);
+
+ out_gunlock_q:
+	gfs2_quota_unlock(ip);
+
+ out:
+	gfs2_alloc_put(ip);
+
+	return error;
+}
+
+static int truncator_journaled(struct gfs2_inode *ip, uint64_t size)
+{
+	uint64_t lbn, dbn;
+	uint32_t off;
+	struct buffer_head *bh;
+	int new = FALSE;
+	int error;
+
+	lbn = size;
+	off = do_div(lbn, ip->i_sbd->sd_jbsize);
+
+	error = gfs2_block_map(ip, lbn, &new, &dbn, NULL);
+	if (error || !dbn)
+		return error;
+
+	error = gfs2_jdata_get_buffer(ip, dbn, FALSE, &bh);
+	if (error)
+		return error;
+
+	gfs2_trans_add_bh(ip->i_gl, bh);
+	gfs2_buffer_clear_tail(bh, sizeof(struct gfs2_meta_header) + off);
+
+	brelse(bh);
+
+	return 0;
+}
+
+static int trunc_start(struct gfs2_inode *ip, uint64_t size,
+		       gfs2_truncator_t truncator)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct buffer_head *dibh;
+	int journaled = gfs2_is_jdata(ip);
+	int error;
+
+	error = gfs2_trans_begin(sdp,
+				 RES_DINODE + ((journaled) ? RES_JDATA : 0), 0);
+	if (error)
+		return error;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		goto out;
+
+	if (gfs2_is_stuffed(ip)) {
+		ip->i_di.di_size = size;
+		ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
+		gfs2_trans_add_bh(ip->i_gl, dibh);
+		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode) + size);
+		error = 1;
+
+	} else {
+		if (journaled) {
+			uint64_t junk = size;
+			/* we're just interested in the modulus */
+			if (do_div(junk, sdp->sd_jbsize))
+				error = truncator_journaled(ip, size);
+		} else if (size & (uint64_t)(sdp->sd_sb.sb_bsize - 1))
+			error = truncator(ip, size);
+
+		if (!error) {
+			ip->i_di.di_size = size;
+			ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
+			ip->i_di.di_flags |= GFS2_DIF_TRUNC_IN_PROG;
+			gfs2_trans_add_bh(ip->i_gl, dibh);
+			gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		}
+	}
+
+	brelse(dibh);
+
+ out:
+	gfs2_trans_end(sdp);
+
+	return error;
+}
+
+static int trunc_dealloc(struct gfs2_inode *ip, uint64_t size)
+{
+	unsigned int height = ip->i_di.di_height;
+	uint64_t lblock;
+	struct metapath *mp;
+	int error;
+
+	if (!size)
+		lblock = 0;
+	else if (gfs2_is_jdata(ip)) {
+		lblock = size - 1;
+		do_div(lblock, ip->i_sbd->sd_jbsize);
+	} else
+		lblock = (size - 1) >> ip->i_sbd->sd_sb.sb_bsize_shift;
+
+	mp = find_metapath(ip, lblock);
+	gfs2_alloc_get(ip);
+
+	error = gfs2_quota_hold(ip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
+	if (error)
+		goto out;
+
+	while (height--) {
+		struct strip_mine sm;
+		sm.sm_first = !!size;
+		sm.sm_height = height;
+
+		error = recursive_scan(ip, NULL, mp, 0, 0, TRUE, do_strip, &sm);
+		if (error)
+			break;
+	}
+
+	gfs2_quota_unhold(ip);
+
+ out:
+	gfs2_alloc_put(ip);
+	kfree(mp);
+
+	return error;
+}
+
+static int trunc_end(struct gfs2_inode *ip)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct buffer_head *dibh;
+	int error;
+
+	error = gfs2_trans_begin(sdp, RES_DINODE, 0);
+	if (error)
+		return error;
+
+	down_write(&ip->i_rw_mutex);
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		goto out;
+
+	if (!ip->i_di.di_size) {
+		ip->i_di.di_height = 0;
+		ip->i_di.di_goal_meta =
+			ip->i_di.di_goal_data =
+			ip->i_num.no_addr;
+		gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
+	}
+	ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
+	ip->i_di.di_flags &= ~GFS2_DIF_TRUNC_IN_PROG;
+
+	gfs2_trans_add_bh(ip->i_gl, dibh);
+	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	brelse(dibh);
+
+ out:
+	up_write(&ip->i_rw_mutex);
+
+	gfs2_trans_end(sdp);
+
+	return error;
+}
+
+/**
+ * do_shrink - make a file smaller
+ * @ip: the inode
+ * @size: the size to make the file
+ * @truncator: function to truncate the last partial block
+ *
+ * Called with an exclusive lock on @ip.
+ *
+ * Returns: errno
+ */
+
+static int do_shrink(struct gfs2_inode *ip, uint64_t size,
+		     gfs2_truncator_t truncator)
+{
+	int error;
+
+	error = trunc_start(ip, size, truncator);
+	if (error < 0)
+		return error;
+	if (error > 0)
+		return 0;
+
+	error = trunc_dealloc(ip, size);
+	if (!error)
+		error = trunc_end(ip);
+
+	return error;
+}
+
+/**
+ * gfs2_truncatei - make a file a give size
+ * @ip: the inode
+ * @size: the size to make the file
+ * @truncator: function to truncate the last partial block
+ *
+ * The file size can grow, shrink, or stay the same size.
+ *
+ * Returns: errno
+ */
+
+int gfs2_truncatei(struct gfs2_inode *ip, uint64_t size,
+		   gfs2_truncator_t truncator)
+{
+	int error;
+
+	if (gfs2_assert_warn(ip->i_sbd, S_ISREG(ip->i_di.di_mode)))
+		return -EINVAL;
+
+	if (size > ip->i_di.di_size)
+		error = do_grow(ip, size);
+	else
+		error = do_shrink(ip, size, truncator);
+
+	return error;
+}
+
+int gfs2_truncatei_resume(struct gfs2_inode *ip)
+{
+	int error;
+	error = trunc_dealloc(ip, ip->i_di.di_size);
+	if (!error)
+		error = trunc_end(ip);
+	return error;
+}
+
+int gfs2_file_dealloc(struct gfs2_inode *ip)
+{
+	return trunc_dealloc(ip, 0);
+}
+
+/**
+ * gfs2_write_calc_reserv - calculate number of blocks needed to write to a file
+ * @ip: the file
+ * @len: the number of bytes to be written to the file
+ * @data_blocks: returns the number of data blocks required
+ * @ind_blocks: returns the number of indirect blocks required
+ *
+ */
+
+void gfs2_write_calc_reserv(struct gfs2_inode *ip, unsigned int len,
+			    unsigned int *data_blocks, unsigned int *ind_blocks)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	unsigned int tmp;
+
+	if (gfs2_is_jdata(ip)) {
+		*data_blocks = DIV_RU(len, sdp->sd_jbsize) + 2;
+		*ind_blocks = 3 * (sdp->sd_max_jheight - 1);
+	} else {
+		*data_blocks = (len >> sdp->sd_sb.sb_bsize_shift) + 3;
+		*ind_blocks = 3 * (sdp->sd_max_height - 1);
+	}
+
+	for (tmp = *data_blocks; tmp > sdp->sd_diptrs;) {
+		tmp = DIV_RU(tmp, sdp->sd_inptrs);
+		*ind_blocks += tmp;
+	}
+}
+
+/**
+ * gfs2_write_alloc_required - figure out if a write will require an allocation
+ * @ip: the file being written to
+ * @offset: the offset to write to
+ * @len: the number of bytes being written
+ * @alloc_required: set to TRUE if an alloc is required, FALSE otherwise
+ *
+ * Returns: errno
+ */
+
+int gfs2_write_alloc_required(struct gfs2_inode *ip, uint64_t offset,
+			      unsigned int len, int *alloc_required)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	uint64_t lblock, lblock_stop, dblock;
+	uint32_t extlen;
+	int new = FALSE;
+	int error = 0;
+
+	*alloc_required = FALSE;
+
+	if (!len)
+		return 0;
+
+	if (gfs2_is_stuffed(ip)) {
+		if (offset + len >
+		    sdp->sd_sb.sb_bsize - sizeof(struct gfs2_dinode))
+			*alloc_required = TRUE;
+		return 0;
+	}
+
+	if (gfs2_is_jdata(ip)) {
+		unsigned int bsize = sdp->sd_jbsize;
+		lblock = offset;
+		do_div(lblock, bsize);
+		lblock_stop = offset + len + bsize - 1;
+		do_div(lblock_stop, bsize);
+	} else {
+		unsigned int shift = sdp->sd_sb.sb_bsize_shift;
+		lblock = offset >> shift;
+		lblock_stop = (offset + len + sdp->sd_sb.sb_bsize - 1) >> shift;
+	}
+
+	for (; lblock < lblock_stop; lblock += extlen) {
+		error = gfs2_block_map(ip, lblock, &new, &dblock, &extlen);
+		if (error)
+			return error;
+
+		if (!dblock) {
+			*alloc_required = TRUE;
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * do_gfm - Copy out the dinode/indirect blocks of a file
+ * @ip: the file
+ * @dibh: the dinode buffer
+ * @bh: the indirect buffer we're looking at
+ * @top: the first pointer in the block
+ * @bottom: one more than the last pointer in the block
+ * @height: the height the block is at
+ * @data: a pointer to a struct gfs2_user_buffer structure
+ *
+ * If this is a journaled file, copy out the data too.
+ *
+ * Returns: errno
+ */
+
+static int do_gfm(struct gfs2_inode *ip, struct buffer_head *dibh,
+		  struct buffer_head *bh, uint64_t *top, uint64_t *bottom,
+		  unsigned int height, void *data)
+{
+	struct gfs2_user_buffer *ub = (struct gfs2_user_buffer *)data;
+	int error;
+
+	error = gfs2_add_bh_to_ub(ub, bh);
+	if (error)
+		return error;
+
+	if (!S_ISDIR(ip->i_di.di_mode) ||
+	    height + 1 != ip->i_di.di_height)
+		return 0;
+
+	for (; top < bottom; top++)
+		if (*top) {
+			struct buffer_head *data_bh;
+
+			error = gfs2_meta_read(ip->i_gl, gfs2_64_to_cpu(*top),
+					       DIO_START | DIO_WAIT,
+					       &data_bh);
+			if (error)
+				return error;
+
+			error = gfs2_add_bh_to_ub(ub, data_bh);
+
+			brelse(data_bh);
+
+			if (error)
+				return error;
+		}
+
+	return 0;
+}
+
+/**
+ * gfs2_get_file_meta - return all the metadata for a file
+ * @ip: the file
+ * @ub: the structure representing the meta
+ *
+ * Returns: errno
+ */
+
+int gfs2_get_file_meta(struct gfs2_inode *ip, struct gfs2_user_buffer *ub)
+{
+	int error;
+
+	if (gfs2_is_stuffed(ip)) {
+		struct buffer_head *dibh;
+		error = gfs2_meta_inode_buffer(ip, &dibh);
+		if (!error) {
+			error = gfs2_add_bh_to_ub(ub, dibh);
+			brelse(dibh);
+		}
+	} else {
+		struct metapath *mp = find_metapath(ip, 0);
+		error = recursive_scan(ip, NULL, mp, 0, 0, TRUE, do_gfm, ub);
+		kfree(mp);
+	}
+
+	return error;
+}
+
--- a/fs/gfs2/bmap.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/bmap.h	2005-09-01 17:36:55.156139640 +0800
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __BMAP_DOT_H__
+#define __BMAP_DOT_H__
+
+typedef int (*gfs2_unstuffer_t) (struct gfs2_inode * ip,
+				 struct buffer_head * dibh, uint64_t block,
+				 void *private);
+int gfs2_unstuffer_sync(struct gfs2_inode *ip, struct buffer_head *dibh,
+			uint64_t block, void *private);
+int gfs2_unstuff_dinode(struct gfs2_inode *ip, gfs2_unstuffer_t unstuffer,
+			void *private);
+
+int gfs2_block_map(struct gfs2_inode *ip,
+		   uint64_t lblock, int *new,
+		   uint64_t *dblock, uint32_t *extlen);
+
+typedef int (*gfs2_truncator_t) (struct gfs2_inode * ip, uint64_t size);
+int gfs2_truncatei(struct gfs2_inode *ip, uint64_t size,
+		   gfs2_truncator_t truncator);
+int gfs2_truncatei_resume(struct gfs2_inode *ip);
+int gfs2_file_dealloc(struct gfs2_inode *ip);
+
+void gfs2_write_calc_reserv(struct gfs2_inode *ip, unsigned int len,
+			    unsigned int *data_blocks,
+			    unsigned int *ind_blocks);
+int gfs2_write_alloc_required(struct gfs2_inode *ip, uint64_t offset,
+			      unsigned int len, int *alloc_required);
+
+int gfs2_get_file_meta(struct gfs2_inode *ip, struct gfs2_user_buffer *ub);
+
+#endif /* __BMAP_DOT_H__ */
--- a/fs/gfs2/daemon.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/daemon.c	2005-09-01 17:36:55.167137968 +0800
@@ -0,0 +1,226 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "daemon.h"
+#include "glock.h"
+#include "log.h"
+#include "quota.h"
+#include "recovery.h"
+#include "super.h"
+#include "unlinked.h"
+
+/* This uses schedule_timeout() instead of msleep() because it's good for
+   the daemons to wake up more often than the timeout when unmounting so
+   the user's unmount doesn't sit there forever.
+   
+   The kthread functions used to start these daemons block and flush signals. */
+
+/**
+ * gfs2_scand - Look for cached glocks and inodes to toss from memory
+ * @sdp: Pointer to GFS2 superblock
+ *
+ * One of these daemons runs, finding candidates to add to sd_reclaim_list.
+ * See gfs2_glockd()
+ */
+
+int gfs2_scand(void *data)
+{
+	struct gfs2_sbd *sdp = (struct gfs2_sbd *)data;
+	unsigned long t;
+
+	while (!kthread_should_stop()) {
+		gfs2_scand_internal(sdp);
+		t = gfs2_tune_get(sdp, gt_scand_secs) * HZ;
+		schedule_timeout_interruptible(t);
+	}
+
+	return 0;
+}
+
+/**
+ * gfs2_glockd - Reclaim unused glock structures
+ * @sdp: Pointer to GFS2 superblock
+ *
+ * One or more of these daemons run, reclaiming glocks on sd_reclaim_list.
+ * Number of daemons can be set by user, with num_glockd mount option.
+ */
+
+int gfs2_glockd(void *data)
+{
+	struct gfs2_sbd *sdp = (struct gfs2_sbd *)data;
+	DECLARE_WAITQUEUE(wait_chan, current);
+
+	while (!kthread_should_stop()) {
+		while (atomic_read(&sdp->sd_reclaim_count))
+			gfs2_reclaim_glock(sdp);
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		add_wait_queue(&sdp->sd_reclaim_wq, &wait_chan);
+		if (!atomic_read(&sdp->sd_reclaim_count) &&
+		    !kthread_should_stop())
+			schedule();
+		remove_wait_queue(&sdp->sd_reclaim_wq, &wait_chan);
+		set_current_state(TASK_RUNNING);
+	}
+
+	return 0;
+}
+
+/**
+ * gfs2_recoverd - Recover dead machine's journals
+ * @sdp: Pointer to GFS2 superblock
+ *
+ */
+
+int gfs2_recoverd(void *data)
+{
+	struct gfs2_sbd *sdp = (struct gfs2_sbd *)data;
+	unsigned long t;
+
+	while (!kthread_should_stop()) {
+		gfs2_check_journals(sdp);
+		t = gfs2_tune_get(sdp,  gt_recoverd_secs) * HZ;
+		schedule_timeout_interruptible(t);
+	}
+
+	return 0;
+}
+
+/**
+ * gfs2_logd - Update log tail as Active Items get flushed to in-place blocks
+ * @sdp: Pointer to GFS2 superblock
+ *
+ * Also, periodically check to make sure that we're using the most recent
+ * journal index.
+ */
+
+int gfs2_logd(void *data)
+{
+	struct gfs2_sbd *sdp = (struct gfs2_sbd *)data;
+	struct gfs2_holder ji_gh;
+	unsigned long t;
+
+	while (!kthread_should_stop()) {
+		/* Advance the log tail */
+
+		t = sdp->sd_log_flush_time +
+		    gfs2_tune_get(sdp, gt_log_flush_secs) * HZ;
+
+		gfs2_ail1_empty(sdp, DIO_ALL);
+
+		if (time_after_eq(jiffies, t)) {
+			gfs2_log_flush(sdp);
+			sdp->sd_log_flush_time = jiffies;
+		}
+
+		/* Check for latest journal index */
+
+		t = sdp->sd_jindex_refresh_time +
+		    gfs2_tune_get(sdp, gt_jindex_refresh_secs) * HZ;
+
+		if (time_after_eq(jiffies, t)) {
+			if (!gfs2_jindex_hold(sdp, &ji_gh))
+				gfs2_glock_dq_uninit(&ji_gh);
+			sdp->sd_jindex_refresh_time = jiffies;
+		}
+
+		t = gfs2_tune_get(sdp, gt_logd_secs) * HZ;
+		schedule_timeout_interruptible(t);
+	}
+
+	return 0;
+}
+
+/**
+ * gfs2_quotad - Write cached quota changes into the quota file
+ * @sdp: Pointer to GFS2 superblock
+ *
+ */
+
+int gfs2_quotad(void *data)
+{
+	struct gfs2_sbd *sdp = (struct gfs2_sbd *)data;
+	unsigned long t;
+	int error;
+
+	while (!kthread_should_stop()) {
+		/* Update the master statfs file */
+
+		t = sdp->sd_statfs_sync_time +
+		    gfs2_tune_get(sdp, gt_statfs_quantum) * HZ;
+
+		if (time_after_eq(jiffies, t)) {
+			error = gfs2_statfs_sync(sdp);
+			if (error &&
+			    error != -EROFS &&
+			    !test_bit(SDF_SHUTDOWN, &sdp->sd_flags))
+				fs_err(sdp, "quotad: (1) error=%d\n", error);
+			sdp->sd_statfs_sync_time = jiffies;
+		}
+
+		/* Update quota file */
+
+		t = sdp->sd_quota_sync_time +
+		    gfs2_tune_get(sdp, gt_quota_quantum) * HZ;
+
+		if (time_after_eq(jiffies, t)) {
+			error = gfs2_quota_sync(sdp);
+			if (error &&
+			    error != -EROFS &&
+			    !test_bit(SDF_SHUTDOWN, &sdp->sd_flags))
+				fs_err(sdp, "quotad: (2) error=%d\n", error);
+			sdp->sd_quota_sync_time = jiffies;
+		}
+
+		gfs2_quota_scan(sdp);
+
+		t = gfs2_tune_get(sdp, gt_quotad_secs) * HZ;
+		schedule_timeout_interruptible(t);
+	}
+
+	return 0;
+}
+
+/**
+ * gfs2_inoded - Deallocate unlinked inodes
+ * @sdp: Pointer to GFS2 superblock
+ *
+ */
+
+int gfs2_inoded(void *data)
+{
+	struct gfs2_sbd *sdp = (struct gfs2_sbd *)data;
+	unsigned long t;
+	int error;
+
+	while (!kthread_should_stop()) {
+		error = gfs2_unlinked_dealloc(sdp);
+		if (error &&
+		    error != -EROFS &&
+		    !test_bit(SDF_SHUTDOWN, &sdp->sd_flags))
+			fs_err(sdp, "inoded: error = %d\n", error);
+
+		t = gfs2_tune_get(sdp, gt_inoded_secs) * HZ;
+		schedule_timeout_interruptible(t);
+	}
+
+	return 0;
+}
+
--- a/fs/gfs2/daemon.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/daemon.h	2005-09-01 17:36:55.172137208 +0800
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __DAEMON_DOT_H__
+#define __DAEMON_DOT_H__
+
+int gfs2_scand(void *data);
+int gfs2_glockd(void *data);
+int gfs2_recoverd(void *data);
+int gfs2_logd(void *data);
+int gfs2_quotad(void *data);
+int gfs2_inoded(void *data);
+
+#endif /* __DAEMON_DOT_H__ */
--- a/fs/gfs2/format.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/format.h	2005-09-01 17:36:55.202132648 +0800
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __FORMAT_DOT_H__
+#define __FORMAT_DOT_H__
+
+static const uint32_t gfs2_old_fs_formats[] = {
+	0
+};
+
+static const uint32_t gfs2_old_multihost_formats[] = {
+	0
+};
+
+#endif /* __FORMAT_DOT_H__ */
--- a/fs/gfs2/glops.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/glops.c	2005-09-01 17:36:55.262123528 +0800
@@ -0,0 +1,488 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "bmap.h"
+#include "glock.h"
+#include "glops.h"
+#include "inode.h"
+#include "log.h"
+#include "meta_io.h"
+#include "page.h"
+#include "recovery.h"
+#include "rgrp.h"
+
+/**
+ * meta_go_sync - sync out the metadata for this glock
+ * @gl: the glock
+ * @flags: DIO_*
+ *
+ * Called when demoting or unlocking an EX glock.  We must flush
+ * to disk all dirty buffers/pages relating to this glock, and must not
+ * not return to caller to demote/unlock the glock until I/O is complete.
+ */
+
+static void meta_go_sync(struct gfs2_glock *gl, int flags)
+{
+	if (!(flags & DIO_METADATA))
+		return;
+
+	if (test_and_clear_bit(GLF_DIRTY, &gl->gl_flags)) {
+		gfs2_log_flush_glock(gl);
+		gfs2_meta_sync(gl, flags | DIO_START | DIO_WAIT);
+		if (flags & DIO_RELEASE)
+			gfs2_ail_empty_gl(gl);
+	}
+
+	clear_bit(GLF_SYNC, &gl->gl_flags);
+}
+
+/**
+ * meta_go_inval - invalidate the metadata for this glock
+ * @gl: the glock
+ * @flags:
+ *
+ */
+
+static void meta_go_inval(struct gfs2_glock *gl, int flags)
+{
+	if (!(flags & DIO_METADATA))
+		return;
+
+	gfs2_meta_inval(gl);
+	gl->gl_vn++;
+}
+
+/**
+ * meta_go_demote_ok - Check to see if it's ok to unlock a glock
+ * @gl: the glock
+ *
+ * Returns: TRUE if we have no cached data; ok to demote meta glock
+ */
+
+static int meta_go_demote_ok(struct gfs2_glock *gl)
+{
+	return !gl->gl_aspace->i_mapping->nrpages;
+}
+
+/**
+ * inode_go_xmote_th - promote/demote a glock
+ * @gl: the glock
+ * @state: the requested state
+ * @flags:
+ *
+ */
+
+static void inode_go_xmote_th(struct gfs2_glock *gl, unsigned int state,
+			      int flags)
+{
+	if (gl->gl_state != LM_ST_UNLOCKED)
+		gfs2_pte_inval(gl);
+	gfs2_glock_xmote_th(gl, state, flags);
+}
+
+/**
+ * inode_go_xmote_bh - After promoting/demoting a glock
+ * @gl: the glock
+ *
+ */
+
+static void inode_go_xmote_bh(struct gfs2_glock *gl)
+{
+	struct gfs2_holder *gh = gl->gl_req_gh;
+	struct buffer_head *bh;
+	int error;
+
+	if (gl->gl_state != LM_ST_UNLOCKED &&
+	    (!gh || !(gh->gh_flags & GL_SKIP))) {
+		error = gfs2_meta_read(gl, gl->gl_name.ln_number, DIO_START,
+				       &bh);
+		if (!error)
+			brelse(bh);
+	}
+}
+
+/**
+ * inode_go_drop_th - unlock a glock
+ * @gl: the glock
+ *
+ * Invoked from rq_demote().
+ * Another node needs the lock in EXCLUSIVE mode, or lock (unused for too long)
+ * is being purged from our node's glock cache; we're dropping lock.
+ */
+
+static void inode_go_drop_th(struct gfs2_glock *gl)
+{
+	gfs2_pte_inval(gl);
+	gfs2_glock_drop_th(gl);
+}
+
+/**
+ * inode_go_sync - Sync the dirty data and/or metadata for an inode glock
+ * @gl: the glock protecting the inode
+ * @flags:
+ *
+ */
+
+static void inode_go_sync(struct gfs2_glock *gl, int flags)
+{
+	int meta = (flags & DIO_METADATA);
+	int data = (flags & DIO_DATA);
+
+	if (test_bit(GLF_DIRTY, &gl->gl_flags)) {
+		if (meta && data) {
+			gfs2_page_sync(gl, flags | DIO_START);
+			gfs2_log_flush_glock(gl);
+			gfs2_meta_sync(gl, flags | DIO_START | DIO_WAIT);
+			gfs2_page_sync(gl, flags | DIO_WAIT);
+			clear_bit(GLF_DIRTY, &gl->gl_flags);
+		} else if (meta) {
+			gfs2_log_flush_glock(gl);
+			gfs2_meta_sync(gl, flags | DIO_START | DIO_WAIT);
+		} else if (data)
+			gfs2_page_sync(gl, flags | DIO_START | DIO_WAIT);
+		if (flags & DIO_RELEASE)
+			gfs2_ail_empty_gl(gl);
+	}
+
+	clear_bit(GLF_SYNC, &gl->gl_flags);
+}
+
+/**
+ * inode_go_inval - prepare a inode glock to be released
+ * @gl: the glock
+ * @flags:
+ *
+ */
+
+static void inode_go_inval(struct gfs2_glock *gl, int flags)
+{
+	int meta = (flags & DIO_METADATA);
+	int data = (flags & DIO_DATA);
+
+	if (meta) {
+		gfs2_meta_inval(gl);
+		gl->gl_vn++;
+	}
+	if (data)
+		gfs2_page_inval(gl);
+}
+
+/**
+ * inode_go_demote_ok - Check to see if it's ok to unlock an inode glock
+ * @gl: the glock
+ *
+ * Returns: TRUE if it's ok
+ */
+
+static int inode_go_demote_ok(struct gfs2_glock *gl)
+{
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+	int demote = FALSE;
+
+	if (!get_gl2ip(gl) && !gl->gl_aspace->i_mapping->nrpages)
+		demote = TRUE;
+	else if (!sdp->sd_args.ar_localcaching &&
+		 time_after_eq(jiffies, gl->gl_stamp +
+			       gfs2_tune_get(sdp, gt_demote_secs) * HZ))
+		demote = TRUE;
+
+	return demote;
+}
+
+/**
+ * inode_go_lock - operation done after an inode lock is locked by a process
+ * @gl: the glock
+ * @flags:
+ *
+ * Returns: errno
+ */
+
+static int inode_go_lock(struct gfs2_holder *gh)
+{
+	struct gfs2_glock *gl = gh->gh_gl;
+	struct gfs2_inode *ip = get_gl2ip(gl);
+	int error = 0;
+
+	if (!ip)
+		return 0;
+
+	if (ip->i_vn != gl->gl_vn) {
+		error = gfs2_inode_refresh(ip);
+		if (error)
+			return error;
+		gfs2_inode_attr_in(ip);
+	}
+
+	if ((ip->i_di.di_flags & GFS2_DIF_TRUNC_IN_PROG) &&
+	    (gl->gl_state == LM_ST_EXCLUSIVE) &&
+	    (gh->gh_flags & GL_LOCAL_EXCL))
+		error = gfs2_truncatei_resume(ip);
+
+	return error;
+}
+
+/**
+ * inode_go_unlock - operation done before an inode lock is unlocked by a
+ *		     process
+ * @gl: the glock
+ * @flags:
+ *
+ */
+
+static void inode_go_unlock(struct gfs2_holder *gh)
+{
+	struct gfs2_glock *gl = gh->gh_gl;
+	struct gfs2_inode *ip = get_gl2ip(gl);
+
+	if (ip && test_bit(GLF_DIRTY, &gl->gl_flags))
+		gfs2_inode_attr_in(ip);
+
+	if (ip)
+		gfs2_meta_cache_flush(ip);
+}
+
+/**
+ * inode_greedy -
+ * @gl: the glock
+ *
+ */
+
+static void inode_greedy(struct gfs2_glock *gl)
+{
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+	struct gfs2_inode *ip = get_gl2ip(gl);
+	unsigned int quantum = gfs2_tune_get(sdp, gt_greedy_quantum);
+	unsigned int max = gfs2_tune_get(sdp, gt_greedy_max);
+	unsigned int new_time;
+
+	spin_lock(&ip->i_spin);
+
+	if (time_after(ip->i_last_pfault + quantum, jiffies)) {
+		new_time = ip->i_greedy + quantum;
+		if (new_time > max)
+			new_time = max;
+	} else {
+		new_time = ip->i_greedy - quantum;
+		if (!new_time || new_time > max)
+			new_time = 1;
+	}
+
+	ip->i_greedy = new_time;
+
+	spin_unlock(&ip->i_spin);
+
+	gfs2_inode_put(ip);
+}
+
+/**
+ * rgrp_go_demote_ok - Check to see if it's ok to unlock a RG's glock
+ * @gl: the glock
+ *
+ * Returns: TRUE if it's ok
+ */
+
+static int rgrp_go_demote_ok(struct gfs2_glock *gl)
+{
+	return !gl->gl_aspace->i_mapping->nrpages;
+}
+
+/**
+ * rgrp_go_lock - operation done after an rgrp lock is locked by
+ *    a first holder on this node.
+ * @gl: the glock
+ * @flags:
+ *
+ * Returns: errno
+ */
+
+static int rgrp_go_lock(struct gfs2_holder *gh)
+{
+	return gfs2_rgrp_bh_get(get_gl2rgd(gh->gh_gl));
+}
+
+/**
+ * rgrp_go_unlock - operation done before an rgrp lock is unlocked by
+ *    a last holder on this node.
+ * @gl: the glock
+ * @flags:
+ *
+ */
+
+static void rgrp_go_unlock(struct gfs2_holder *gh)
+{
+	gfs2_rgrp_bh_put(get_gl2rgd(gh->gh_gl));
+}
+
+/**
+ * trans_go_xmote_th - promote/demote the transaction glock
+ * @gl: the glock
+ * @state: the requested state
+ * @flags:
+ *
+ */
+
+static void trans_go_xmote_th(struct gfs2_glock *gl, unsigned int state,
+			      int flags)
+{
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+
+	if (gl->gl_state != LM_ST_UNLOCKED &&
+	    test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
+		gfs2_meta_syncfs(sdp);
+		gfs2_log_shutdown(sdp);
+	}
+
+	gfs2_glock_xmote_th(gl, state, flags);
+}
+
+/**
+ * trans_go_xmote_bh - After promoting/demoting the transaction glock
+ * @gl: the glock
+ *
+ */
+
+static void trans_go_xmote_bh(struct gfs2_glock *gl)
+{
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+	struct gfs2_glock *j_gl = sdp->sd_jdesc->jd_inode->i_gl;
+	struct gfs2_log_header head;
+	int error;
+
+	if (gl->gl_state != LM_ST_UNLOCKED &&
+	    test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
+		gfs2_meta_cache_flush(sdp->sd_jdesc->jd_inode);
+		j_gl->gl_ops->go_inval(j_gl, DIO_METADATA | DIO_DATA);
+
+		error = gfs2_find_jhead(sdp->sd_jdesc, &head);
+		if (error)
+			gfs2_consist(sdp);
+		if (!(head.lh_flags & GFS2_LOG_HEAD_UNMOUNT))
+			gfs2_consist(sdp);
+
+		/*  Initialize some head of the log stuff  */
+		if (!test_bit(SDF_SHUTDOWN, &sdp->sd_flags)) {
+			sdp->sd_log_sequence = head.lh_sequence + 1;
+			gfs2_log_pointers_init(sdp, head.lh_blkno);
+		}
+	}
+}
+
+/**
+ * trans_go_drop_th - unlock the transaction glock
+ * @gl: the glock
+ *
+ * We want to sync the device even with localcaching.  Remember
+ * that localcaching journal replay only marks buffers dirty.
+ */
+
+static void trans_go_drop_th(struct gfs2_glock *gl)
+{
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+
+	if (test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
+		gfs2_meta_syncfs(sdp);
+		gfs2_log_shutdown(sdp);
+	}
+
+	gfs2_glock_drop_th(gl);
+}
+
+/**
+ * quota_go_demote_ok - Check to see if it's ok to unlock a quota glock
+ * @gl: the glock
+ *
+ * Returns: TRUE if it's ok
+ */
+
+static int quota_go_demote_ok(struct gfs2_glock *gl)
+{
+	return !atomic_read(&gl->gl_lvb_count);
+}
+
+struct gfs2_glock_operations gfs2_meta_glops = {
+	.go_xmote_th = gfs2_glock_xmote_th,
+	.go_drop_th = gfs2_glock_drop_th,
+	.go_sync = meta_go_sync,
+	.go_inval = meta_go_inval,
+	.go_demote_ok = meta_go_demote_ok,
+	.go_type = LM_TYPE_META
+};
+
+struct gfs2_glock_operations gfs2_inode_glops = {
+	.go_xmote_th = inode_go_xmote_th,
+	.go_xmote_bh = inode_go_xmote_bh,
+	.go_drop_th = inode_go_drop_th,
+	.go_sync = inode_go_sync,
+	.go_inval = inode_go_inval,
+	.go_demote_ok = inode_go_demote_ok,
+	.go_lock = inode_go_lock,
+	.go_unlock = inode_go_unlock,
+	.go_greedy = inode_greedy,
+	.go_type = LM_TYPE_INODE
+};
+
+struct gfs2_glock_operations gfs2_rgrp_glops = {
+	.go_xmote_th = gfs2_glock_xmote_th,
+	.go_drop_th = gfs2_glock_drop_th,
+	.go_sync = meta_go_sync,
+	.go_inval = meta_go_inval,
+	.go_demote_ok = rgrp_go_demote_ok,
+	.go_lock = rgrp_go_lock,
+	.go_unlock = rgrp_go_unlock,
+	.go_type = LM_TYPE_RGRP
+};
+
+struct gfs2_glock_operations gfs2_trans_glops = {
+	.go_xmote_th = trans_go_xmote_th,
+	.go_xmote_bh = trans_go_xmote_bh,
+	.go_drop_th = trans_go_drop_th,
+	.go_type = LM_TYPE_NONDISK
+};
+
+struct gfs2_glock_operations gfs2_iopen_glops = {
+	.go_xmote_th = gfs2_glock_xmote_th,
+	.go_drop_th = gfs2_glock_drop_th,
+	.go_callback = gfs2_iopen_go_callback,
+	.go_type = LM_TYPE_IOPEN
+};
+
+struct gfs2_glock_operations gfs2_flock_glops = {
+	.go_xmote_th = gfs2_glock_xmote_th,
+	.go_drop_th = gfs2_glock_drop_th,
+	.go_type = LM_TYPE_FLOCK
+};
+
+struct gfs2_glock_operations gfs2_nondisk_glops = {
+	.go_xmote_th = gfs2_glock_xmote_th,
+	.go_drop_th = gfs2_glock_drop_th,
+	.go_type = LM_TYPE_NONDISK
+};
+
+struct gfs2_glock_operations gfs2_quota_glops = {
+	.go_xmote_th = gfs2_glock_xmote_th,
+	.go_drop_th = gfs2_glock_drop_th,
+	.go_demote_ok = quota_go_demote_ok,
+	.go_type = LM_TYPE_QUOTA
+};
+
+struct gfs2_glock_operations gfs2_journal_glops = {
+	.go_xmote_th = gfs2_glock_xmote_th,
+	.go_drop_th = gfs2_glock_drop_th,
+	.go_type = LM_TYPE_JOURNAL
+};
+
--- a/fs/gfs2/glops.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/glops.h	2005-09-01 17:36:55.262123528 +0800
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __GLOPS_DOT_H__
+#define __GLOPS_DOT_H__
+
+extern struct gfs2_glock_operations gfs2_meta_glops;
+extern struct gfs2_glock_operations gfs2_inode_glops;
+extern struct gfs2_glock_operations gfs2_rgrp_glops;
+extern struct gfs2_glock_operations gfs2_trans_glops;
+extern struct gfs2_glock_operations gfs2_iopen_glops;
+extern struct gfs2_glock_operations gfs2_flock_glops;
+extern struct gfs2_glock_operations gfs2_nondisk_glops;
+extern struct gfs2_glock_operations gfs2_quota_glops;
+extern struct gfs2_glock_operations gfs2_journal_glops;
+
+#endif /* __GLOPS_DOT_H__ */
--- a/fs/gfs2/inode.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/inode.c	2005-09-01 17:36:55.303117296 +0800
@@ -0,0 +1,1793 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/posix_acl.h>
+#include <linux/sort.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "acl.h"
+#include "bmap.h"
+#include "dir.h"
+#include "eattr.h"
+#include "glock.h"
+#include "glops.h"
+#include "inode.h"
+#include "log.h"
+#include "meta_io.h"
+#include "ops_address.h"
+#include "ops_file.h"
+#include "ops_inode.h"
+#include "quota.h"
+#include "rgrp.h"
+#include "trans.h"
+#include "unlinked.h"
+
+/**
+ * inode_attr_in - Copy attributes from the dinode into the VFS inode
+ * @ip: The GFS2 inode (with embedded disk inode data)
+ * @inode:  The Linux VFS inode
+ *
+ */
+
+static void inode_attr_in(struct gfs2_inode *ip, struct inode *inode)
+{
+	inode->i_ino = ip->i_num.no_formal_ino;
+
+	switch (ip->i_di.di_mode & S_IFMT) {
+	case S_IFBLK:
+	case S_IFCHR:
+		inode->i_rdev = MKDEV(ip->i_di.di_major, ip->i_di.di_minor);
+		break;
+	default:
+		inode->i_rdev = 0;
+		break;
+	};
+
+	inode->i_mode = ip->i_di.di_mode;
+	inode->i_nlink = ip->i_di.di_nlink;
+	inode->i_uid = ip->i_di.di_uid;
+	inode->i_gid = ip->i_di.di_gid;
+	i_size_write(inode, ip->i_di.di_size);
+	inode->i_atime.tv_sec = ip->i_di.di_atime;
+	inode->i_mtime.tv_sec = ip->i_di.di_mtime;
+	inode->i_ctime.tv_sec = ip->i_di.di_ctime;
+	inode->i_atime.tv_nsec = 0;
+	inode->i_mtime.tv_nsec = 0;
+	inode->i_ctime.tv_nsec = 0;
+	inode->i_blksize = PAGE_SIZE;
+	inode->i_blocks = ip->i_di.di_blocks <<
+		(ip->i_sbd->sd_sb.sb_bsize_shift - GFS2_BASIC_BLOCK_SHIFT);
+
+	if (ip->i_di.di_flags & GFS2_DIF_IMMUTABLE)
+		inode->i_flags |= S_IMMUTABLE;
+	else
+		inode->i_flags &= ~S_IMMUTABLE;
+
+	if (ip->i_di.di_flags & GFS2_DIF_APPENDONLY)
+		inode->i_flags |= S_APPEND;
+	else
+		inode->i_flags &= ~S_APPEND;
+}
+
+/**
+ * gfs2_inode_attr_in - Copy attributes from the dinode into the VFS inode
+ * @ip: The GFS2 inode (with embedded disk inode data)
+ *
+ */
+
+void gfs2_inode_attr_in(struct gfs2_inode *ip)
+{
+	struct inode *inode;
+
+	inode = gfs2_ip2v_lookup(ip);
+	if (inode) {
+		inode_attr_in(ip, inode);
+		iput(inode);
+	}
+}
+
+/**
+ * gfs2_inode_attr_out - Copy attributes from VFS inode into the dinode
+ * @ip: The GFS2 inode
+ *
+ * Only copy out the attributes that we want the VFS layer
+ * to be able to modify.
+ */
+
+void gfs2_inode_attr_out(struct gfs2_inode *ip)
+{
+	struct inode *inode = ip->i_vnode;
+
+	gfs2_assert_withdraw(ip->i_sbd,
+		(ip->i_di.di_mode & S_IFMT) == (inode->i_mode & S_IFMT));
+	ip->i_di.di_mode = inode->i_mode;
+	ip->i_di.di_uid = inode->i_uid;
+	ip->i_di.di_gid = inode->i_gid;
+	ip->i_di.di_atime = inode->i_atime.tv_sec;
+	ip->i_di.di_mtime = inode->i_mtime.tv_sec;
+	ip->i_di.di_ctime = inode->i_ctime.tv_sec;
+}
+
+/**
+ * gfs2_ip2v_lookup - Get the struct inode for a struct gfs2_inode
+ * @ip: the struct gfs2_inode to get the struct inode for
+ *
+ * Returns: A VFS inode, or NULL if none
+ */
+
+struct inode *gfs2_ip2v_lookup(struct gfs2_inode *ip)
+{
+	struct inode *inode = NULL;
+
+	gfs2_assert_warn(ip->i_sbd, test_bit(GIF_MIN_INIT, &ip->i_flags));
+
+	spin_lock(&ip->i_spin);
+	if (ip->i_vnode)
+		inode = igrab(ip->i_vnode);
+	spin_unlock(&ip->i_spin);
+
+	return inode;
+}
+
+/**
+ * gfs2_ip2v - Get/Create a struct inode for a struct gfs2_inode
+ * @ip: the struct gfs2_inode to get the struct inode for
+ *
+ * Returns: A VFS inode, or NULL if no mem
+ */
+
+struct inode *gfs2_ip2v(struct gfs2_inode *ip)
+{
+	struct inode *inode, *tmp;
+
+	inode = gfs2_ip2v_lookup(ip);
+	if (inode)
+		return inode;
+
+	tmp = new_inode(ip->i_sbd->sd_vfs);
+	if (!tmp)
+		return NULL;
+
+	inode_attr_in(ip, tmp);
+
+	if (S_ISREG(ip->i_di.di_mode)) {
+		tmp->i_op = &gfs2_file_iops;
+		tmp->i_fop = &gfs2_file_fops;
+		tmp->i_mapping->a_ops = &gfs2_file_aops;
+	} else if (S_ISDIR(ip->i_di.di_mode)) {
+		tmp->i_op = &gfs2_dir_iops;
+		tmp->i_fop = &gfs2_dir_fops;
+	} else if (S_ISLNK(ip->i_di.di_mode)) {
+		tmp->i_op = &gfs2_symlink_iops;
+	} else {
+		tmp->i_op = &gfs2_dev_iops;
+		init_special_inode(tmp, tmp->i_mode, tmp->i_rdev);
+	}
+
+	set_v2ip(tmp, NULL);
+
+	for (;;) {
+		spin_lock(&ip->i_spin);
+		if (!ip->i_vnode)
+			break;
+		inode = igrab(ip->i_vnode);
+		spin_unlock(&ip->i_spin);
+
+		if (inode) {
+			iput(tmp);
+			return inode;
+		}
+		yield();
+	}
+
+	inode = tmp;
+
+	gfs2_inode_hold(ip);
+	ip->i_vnode = inode;
+	set_v2ip(inode, ip);
+
+	spin_unlock(&ip->i_spin);
+
+	insert_inode_hash(inode);
+
+	return inode;
+}
+
+static int iget_test(struct inode *inode, void *opaque)
+{
+	struct gfs2_inode *ip = get_v2ip(inode);
+	struct gfs2_inum *inum = (struct gfs2_inum *)opaque;
+
+	if (ip && ip->i_num.no_addr == inum->no_addr)
+		return 1;
+
+	return 0;
+}
+
+struct inode *gfs2_iget(struct super_block *sb, struct gfs2_inum *inum)
+{
+	return ilookup5(sb, (unsigned long)inum->no_formal_ino,
+			iget_test, inum);
+}
+
+void gfs2_inode_min_init(struct gfs2_inode *ip, unsigned int type)
+{
+	spin_lock(&ip->i_spin);
+	if (!test_and_set_bit(GIF_MIN_INIT, &ip->i_flags)) {
+		ip->i_di.di_nlink = 1;
+		ip->i_di.di_mode = DT2IF(type);
+	}
+	spin_unlock(&ip->i_spin);
+}
+
+/**
+ * gfs2_inode_refresh - Refresh the incore copy of the dinode
+ * @ip: The GFS2 inode
+ *
+ * Returns: errno
+ */
+
+int gfs2_inode_refresh(struct gfs2_inode *ip)
+{
+	struct buffer_head *dibh;
+	int error;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		return error;
+
+	if (gfs2_metatype_check(ip->i_sbd, dibh, GFS2_METATYPE_DI)) {
+		brelse(dibh);
+		return -EIO;
+	}
+
+	spin_lock(&ip->i_spin);
+	gfs2_dinode_in(&ip->i_di, dibh->b_data);
+	set_bit(GIF_MIN_INIT, &ip->i_flags);
+	spin_unlock(&ip->i_spin);
+
+	brelse(dibh);
+
+	if (ip->i_num.no_addr != ip->i_di.di_num.no_addr) {
+		if (gfs2_consist_inode(ip))
+			gfs2_dinode_print(&ip->i_di);
+		return -EIO;
+	}
+	if (ip->i_num.no_formal_ino != ip->i_di.di_num.no_formal_ino)
+		return -ESTALE;
+
+	ip->i_vn = ip->i_gl->gl_vn;
+
+	return 0;
+}
+
+/**
+ * inode_create - create a struct gfs2_inode
+ * @i_gl: The glock covering the inode
+ * @inum: The inode number
+ * @io_gl: the iopen glock to acquire/hold (using holder in new gfs2_inode)
+ * @io_state: the state the iopen glock should be acquired in
+ * @ipp: pointer to put the returned inode in
+ *
+ * Returns: errno
+ */
+
+static int inode_create(struct gfs2_glock *i_gl, struct gfs2_inum *inum,
+			struct gfs2_glock *io_gl, unsigned int io_state,
+			struct gfs2_inode **ipp)
+{
+	struct gfs2_sbd *sdp = i_gl->gl_sbd;
+	struct gfs2_inode *ip;
+	int error = 0;
+
+	ip = kmem_cache_alloc(gfs2_inode_cachep, GFP_KERNEL);
+	if (!ip)
+		return -ENOMEM;
+	memset(ip, 0, sizeof(struct gfs2_inode));
+
+	ip->i_num = *inum;
+
+	atomic_set(&ip->i_count, 1);
+
+	ip->i_vn = i_gl->gl_vn - 1;
+
+	ip->i_gl = i_gl;
+	ip->i_sbd = sdp;
+
+	spin_lock_init(&ip->i_spin);
+	init_rwsem(&ip->i_rw_mutex);
+
+	ip->i_greedy = gfs2_tune_get(sdp, gt_greedy_default);
+
+	error = gfs2_glock_nq_init(io_gl,
+				   io_state, GL_LOCAL_EXCL | GL_EXACT,
+				   &ip->i_iopen_gh);
+	if (error)
+		goto fail;
+	ip->i_iopen_gh.gh_owner = NULL;
+
+	spin_lock(&io_gl->gl_spin);
+	gfs2_glock_hold(i_gl);
+	set_gl2gl(io_gl, i_gl);
+	spin_unlock(&io_gl->gl_spin);
+
+	gfs2_glock_hold(i_gl);
+	set_gl2ip(i_gl, ip);
+
+	atomic_inc(&sdp->sd_inode_count);
+
+	*ipp = ip;
+
+	return 0;
+
+ fail:
+	gfs2_meta_cache_flush(ip);
+	kmem_cache_free(gfs2_inode_cachep, ip);
+	*ipp = NULL;
+
+	return error;
+}
+
+/**
+ * gfs2_inode_get - Create or get a reference on an inode
+ * @i_gl: The glock covering the inode
+ * @inum: The inode number
+ * @create:
+ * @ipp: pointer to put the returned inode in
+ *
+ * Returns: errno
+ */
+
+int gfs2_inode_get(struct gfs2_glock *i_gl, struct gfs2_inum *inum, int create,
+		   struct gfs2_inode **ipp)
+{
+	struct gfs2_sbd *sdp = i_gl->gl_sbd;
+	struct gfs2_glock *io_gl;
+	int error = 0;
+
+	gfs2_glmutex_lock(i_gl);
+
+	*ipp = get_gl2ip(i_gl);
+	if (*ipp) {
+		error = -ESTALE;
+		if ((*ipp)->i_num.no_formal_ino != inum->no_formal_ino)
+			goto out;
+		atomic_inc(&(*ipp)->i_count);
+		error = 0;
+		goto out;
+	}
+
+	if (!create)
+		goto out;
+
+	error = gfs2_glock_get(sdp, inum->no_addr, &gfs2_iopen_glops,
+			       CREATE, &io_gl);
+	if (!error) {
+		error = inode_create(i_gl, inum, io_gl, LM_ST_SHARED, ipp);
+		gfs2_glock_put(io_gl);
+	}
+
+ out:
+	gfs2_glmutex_unlock(i_gl);
+
+	return error;
+}
+
+void gfs2_inode_hold(struct gfs2_inode *ip)
+{
+	gfs2_assert(ip->i_sbd, atomic_read(&ip->i_count) > 0,);
+	atomic_inc(&ip->i_count);
+}
+
+void gfs2_inode_put(struct gfs2_inode *ip)
+{
+	gfs2_assert(ip->i_sbd, atomic_read(&ip->i_count) > 0,);
+	atomic_dec(&ip->i_count);
+}
+
+void gfs2_inode_destroy(struct gfs2_inode *ip)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct gfs2_glock *io_gl = ip->i_iopen_gh.gh_gl;
+	struct gfs2_glock *i_gl = ip->i_gl;
+
+	gfs2_assert_warn(sdp, !atomic_read(&ip->i_count));
+	gfs2_assert(sdp, get_gl2gl(io_gl) == i_gl,);
+
+	spin_lock(&io_gl->gl_spin);
+	set_gl2gl(io_gl, NULL);
+	gfs2_glock_put(i_gl);
+	spin_unlock(&io_gl->gl_spin);
+
+	gfs2_glock_dq_uninit(&ip->i_iopen_gh);
+
+	gfs2_meta_cache_flush(ip);
+	kmem_cache_free(gfs2_inode_cachep, ip);
+
+	set_gl2ip(i_gl, NULL);
+	gfs2_glock_put(i_gl);
+
+	atomic_dec(&sdp->sd_inode_count);
+}
+
+static int dinode_dealloc(struct gfs2_inode *ip, struct gfs2_unlinked *ul)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct gfs2_alloc *al;
+	struct gfs2_rgrpd *rgd;
+	int error;
+
+	if (ip->i_di.di_blocks != 1) {
+		if (gfs2_consist_inode(ip))
+			gfs2_dinode_print(&ip->i_di);
+		return -EIO;
+	}
+
+	al = gfs2_alloc_get(ip);
+
+	error = gfs2_quota_hold(ip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
+	if (error)
+		goto out;
+
+	error = gfs2_rindex_hold(sdp, &al->al_ri_gh);
+	if (error)
+		goto out_qs;
+
+	rgd = gfs2_blk2rgrpd(sdp, ip->i_num.no_addr);
+	if (!rgd) {
+		gfs2_consist_inode(ip);
+		error = -EIO;
+		goto out_rindex_relse;
+	}
+
+	error = gfs2_glock_nq_init(rgd->rd_gl, LM_ST_EXCLUSIVE, 0,
+				   &al->al_rgd_gh);
+	if (error)
+		goto out_rindex_relse;
+
+	error = gfs2_trans_begin(sdp, RES_RG_BIT + RES_UNLINKED +
+				 RES_STATFS + RES_QUOTA, 1);
+	if (error)
+		goto out_rg_gunlock;
+
+	gfs2_trans_add_gl(ip->i_gl);
+
+	gfs2_free_di(rgd, ip);
+
+	error = gfs2_unlinked_ondisk_rm(sdp, ul);
+
+	gfs2_trans_end(sdp);
+	clear_bit(GLF_STICKY, &ip->i_gl->gl_flags);
+
+ out_rg_gunlock:
+	gfs2_glock_dq_uninit(&al->al_rgd_gh);
+
+ out_rindex_relse:
+	gfs2_glock_dq_uninit(&al->al_ri_gh);
+
+ out_qs:
+	gfs2_quota_unhold(ip);
+
+ out:
+	gfs2_alloc_put(ip);
+
+	return error;
+}
+
+/**
+ * inode_dealloc - Deallocate all on-disk blocks for an inode (dinode)
+ * @sdp: the filesystem
+ * @inum: the inode number to deallocate
+ * @io_gh: a holder for the iopen glock for this inode
+ *
+ * Returns: errno
+ */
+
+static int inode_dealloc(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul,
+			 struct gfs2_holder *io_gh)
+{
+	struct gfs2_inode *ip;
+	struct gfs2_holder i_gh;
+	int error;
+
+	error = gfs2_glock_nq_num(sdp,
+				  ul->ul_ut.ut_inum.no_addr, &gfs2_inode_glops,
+				  LM_ST_EXCLUSIVE, 0, &i_gh);
+	if (error)
+		return error;
+
+	/* We reacquire the iopen lock here to avoid a race with the NFS server
+	   calling gfs2_read_inode() with the inode number of a inode we're in
+	   the process of deallocating.  And we can't keep our hold on the lock
+	   from inode_dealloc_init() for deadlock reasons. */
+
+	gfs2_holder_reinit(LM_ST_EXCLUSIVE, LM_FLAG_TRY, io_gh);
+	error = gfs2_glock_nq(io_gh);
+	switch (error) {
+	case 0:
+		break;
+	case GLR_TRYFAILED:
+		error = 1;
+	default:
+		goto out;
+	}
+
+	gfs2_assert_warn(sdp, !get_gl2ip(i_gh.gh_gl));
+	error = inode_create(i_gh.gh_gl, &ul->ul_ut.ut_inum, io_gh->gh_gl,
+			     LM_ST_EXCLUSIVE, &ip);
+
+	gfs2_glock_dq(io_gh);
+
+	if (error)
+		goto out;
+
+	error = gfs2_inode_refresh(ip);
+	if (error)
+		goto out_iput;
+
+	if (ip->i_di.di_nlink) {
+		if (gfs2_consist_inode(ip))
+			gfs2_dinode_print(&ip->i_di);
+		error = -EIO;
+		goto out_iput;
+	}
+
+	if (S_ISDIR(ip->i_di.di_mode) &&
+	    (ip->i_di.di_flags & GFS2_DIF_EXHASH)) {
+		error = gfs2_dir_exhash_dealloc(ip);
+		if (error)
+			goto out_iput;
+	}
+
+	if (ip->i_di.di_eattr) {
+		error = gfs2_ea_dealloc(ip);
+		if (error)
+			goto out_iput;
+	}
+
+	if (!gfs2_is_stuffed(ip)) {
+		error = gfs2_file_dealloc(ip);
+		if (error)
+			goto out_iput;
+	}
+
+	error = dinode_dealloc(ip, ul);
+	if (error)
+		goto out_iput;
+
+ out_iput:
+	gfs2_glmutex_lock(i_gh.gh_gl);
+	gfs2_inode_put(ip);
+	gfs2_inode_destroy(ip);
+	gfs2_glmutex_unlock(i_gh.gh_gl);
+
+ out:
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return error;
+}
+
+/**
+ * try_inode_dealloc - Try to deallocate an inode and all its blocks
+ * @sdp: the filesystem
+ *
+ * Returns: 0 on success, -errno on error, 1 on busy (inode open)
+ */
+
+static int try_inode_dealloc(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul)
+{
+	struct gfs2_holder io_gh;
+	int error = 0;
+
+	gfs2_try_toss_inode(sdp, &ul->ul_ut.ut_inum);
+
+	error = gfs2_glock_nq_num(sdp,
+				  ul->ul_ut.ut_inum.no_addr, &gfs2_iopen_glops,
+				  LM_ST_EXCLUSIVE, LM_FLAG_TRY_1CB, &io_gh);
+	switch (error) {
+	case 0:
+		break;
+	case GLR_TRYFAILED:
+		return 1;
+	default:
+		return error;
+	}
+
+	gfs2_glock_dq(&io_gh);
+	error = inode_dealloc(sdp, ul, &io_gh);
+	gfs2_holder_uninit(&io_gh);
+
+	return error;
+}
+
+static int inode_dealloc_uninit(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul)
+{
+	struct gfs2_rgrpd *rgd;
+	struct gfs2_holder ri_gh, rgd_gh;
+	int error;
+
+	error = gfs2_rindex_hold(sdp, &ri_gh);
+	if (error)
+		return error;
+
+	rgd = gfs2_blk2rgrpd(sdp, ul->ul_ut.ut_inum.no_addr);
+	if (!rgd) {
+		gfs2_consist(sdp);
+		error = -EIO;
+		goto out;
+	}
+
+	error = gfs2_glock_nq_init(rgd->rd_gl, LM_ST_EXCLUSIVE, 0, &rgd_gh);
+	if (error)
+		goto out;
+
+	error = gfs2_trans_begin(sdp,
+				 RES_RG_BIT + RES_UNLINKED + RES_STATFS,
+				 0);
+	if (error)
+		goto out_gunlock;
+
+	gfs2_free_uninit_di(rgd, ul->ul_ut.ut_inum.no_addr);
+	gfs2_unlinked_ondisk_rm(sdp, ul);
+
+	gfs2_trans_end(sdp);
+
+ out_gunlock:
+	gfs2_glock_dq_uninit(&rgd_gh);
+ out:
+	gfs2_glock_dq_uninit(&ri_gh);
+
+	return error;
+}
+
+int gfs2_inode_dealloc(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul)
+{
+	if (ul->ul_ut.ut_flags & GFS2_UTF_UNINIT)
+		return inode_dealloc_uninit(sdp, ul);
+	else
+		return try_inode_dealloc(sdp, ul);
+}
+
+/**
+ * gfs2_change_nlink - Change nlink count on inode
+ * @ip: The GFS2 inode
+ * @diff: The change in the nlink count required
+ *
+ * Returns: errno
+ */
+
+int gfs2_change_nlink(struct gfs2_inode *ip, int diff)
+{
+	struct buffer_head *dibh;
+	uint32_t nlink;
+	int error;
+
+	nlink = ip->i_di.di_nlink + diff;
+
+	/* If we are reducing the nlink count, but the new value ends up being
+	   bigger than the old one, we must have underflowed. */
+	if (diff < 0 && nlink > ip->i_di.di_nlink) {
+		if (gfs2_consist_inode(ip))
+			gfs2_dinode_print(&ip->i_di);
+		return -EIO;
+	}
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		return error;
+
+	ip->i_di.di_nlink = nlink;
+	ip->i_di.di_ctime = get_seconds();
+
+	gfs2_trans_add_bh(ip->i_gl, dibh);
+	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	brelse(dibh);
+
+	return 0;
+}
+
+/**
+ * gfs2_lookupi - Look up a filename in a directory and return its inode
+ * @d_gh: An initialized holder for the directory glock
+ * @name: The name of the inode to look for
+ * @is_root: If TRUE, ignore the caller's permissions
+ * @i_gh: An uninitialized holder for the new inode glock
+ *
+ * There will always be a vnode (Linux VFS inode) for the d_gh inode unless
+ * @is_root is true.
+ *
+ * Returns: errno
+ */
+
+int gfs2_lookupi(struct gfs2_inode *dip, struct qstr *name, int is_root,
+		 struct gfs2_inode **ipp)
+{
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_holder d_gh;
+	struct gfs2_inum inum;
+	unsigned int type;
+	struct gfs2_glock *gl;
+	int error;
+
+	if (!name->len || name->len > GFS2_FNAMESIZE)
+		return -ENAMETOOLONG;
+
+	if (gfs2_filecmp(name, ".", 1) ||
+	    (gfs2_filecmp(name, "..", 2) && dip == sdp->sd_root_dir)) {
+		gfs2_inode_hold(dip);
+		*ipp = dip;
+		return 0;
+	}
+
+	error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
+	if (error)
+		return error;
+
+	if (!is_root) {
+		error = gfs2_repermission(dip->i_vnode, MAY_EXEC, NULL);
+		if (error)
+			goto out;
+	}
+
+	error = gfs2_dir_search(dip, name, &inum, &type);
+	if (error)
+		goto out;
+
+	error = gfs2_glock_get(sdp, inum.no_addr, &gfs2_inode_glops,
+			       CREATE, &gl);
+	if (error)
+		goto out;
+
+	error = gfs2_inode_get(gl, &inum, CREATE, ipp);
+	if (!error)
+		gfs2_inode_min_init(*ipp, type);
+
+	gfs2_glock_put(gl);
+
+ out:
+	gfs2_glock_dq_uninit(&d_gh);
+
+	return error;
+}
+
+static int pick_formal_ino_1(struct gfs2_sbd *sdp, uint64_t *formal_ino)
+{
+	struct gfs2_inode *ip = sdp->sd_ir_inode;
+	struct buffer_head *bh;
+	struct gfs2_inum_range ir;
+	int error;
+
+	error = gfs2_trans_begin(sdp, RES_DINODE, 0);
+	if (error)
+		return error;
+	down(&sdp->sd_inum_mutex);
+
+	error = gfs2_meta_inode_buffer(ip, &bh);
+	if (error) {
+		up(&sdp->sd_inum_mutex);
+		gfs2_trans_end(sdp);
+		return error;
+	}
+
+	gfs2_inum_range_in(&ir, bh->b_data + sizeof(struct gfs2_dinode));
+
+	if (ir.ir_length) {
+		*formal_ino = ir.ir_start++;
+		ir.ir_length--;
+		gfs2_trans_add_bh(ip->i_gl, bh);
+		gfs2_inum_range_out(&ir,
+				    bh->b_data + sizeof(struct gfs2_dinode));
+		brelse(bh);
+		up(&sdp->sd_inum_mutex);
+		gfs2_trans_end(sdp);
+		return 0;
+	}
+
+	brelse(bh);
+
+	up(&sdp->sd_inum_mutex);
+	gfs2_trans_end(sdp);
+
+	return 1;
+}
+
+static int pick_formal_ino_2(struct gfs2_sbd *sdp, uint64_t *formal_ino)
+{
+	struct gfs2_inode *ip = sdp->sd_ir_inode;
+	struct gfs2_inode *m_ip = sdp->sd_inum_inode;
+	struct gfs2_holder gh;
+	struct buffer_head *bh;
+	struct gfs2_inum_range ir;
+	int error;
+
+	error = gfs2_glock_nq_init(m_ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	if (error)
+		return error;
+
+	error = gfs2_trans_begin(sdp, 2 * RES_DINODE, 0);
+	if (error)
+		goto out;
+	down(&sdp->sd_inum_mutex);
+
+	error = gfs2_meta_inode_buffer(ip, &bh);
+	if (error)
+		goto out_end_trans;
+	
+	gfs2_inum_range_in(&ir, bh->b_data + sizeof(struct gfs2_dinode));
+
+	if (!ir.ir_length) {
+		struct buffer_head *m_bh;
+		uint64_t x, y;
+
+		error = gfs2_meta_inode_buffer(m_ip, &m_bh);
+		if (error)
+			goto out_brelse;
+
+		x = *(uint64_t *)(m_bh->b_data + sizeof(struct gfs2_dinode));
+		x = y = gfs2_64_to_cpu(x);
+		ir.ir_start = x;
+		ir.ir_length = GFS2_INUM_QUANTUM;
+		x += GFS2_INUM_QUANTUM;
+		if (x < y)
+			gfs2_consist_inode(m_ip);
+		x = cpu_to_gfs2_64(x);
+		gfs2_trans_add_bh(m_ip->i_gl, m_bh);
+		*(uint64_t *)(m_bh->b_data + sizeof(struct gfs2_dinode)) = x;
+
+		brelse(m_bh);
+	}
+
+	*formal_ino = ir.ir_start++;
+	ir.ir_length--;
+
+	gfs2_trans_add_bh(ip->i_gl, bh);
+	gfs2_inum_range_out(&ir, bh->b_data + sizeof(struct gfs2_dinode));
+
+ out_brelse:
+	brelse(bh);
+
+ out_end_trans:
+	up(&sdp->sd_inum_mutex);
+	gfs2_trans_end(sdp);
+
+ out:
+	gfs2_glock_dq_uninit(&gh);
+
+	return error;
+}
+
+static int pick_formal_ino(struct gfs2_sbd *sdp, uint64_t *inum)
+{
+	int error;
+
+	error = pick_formal_ino_1(sdp, inum);
+	if (error <= 0)
+		return error;
+
+	error = pick_formal_ino_2(sdp, inum);
+
+	return error;
+}
+
+/**
+ * create_ok - OK to create a new on-disk inode here?
+ * @dip:  Directory in which dinode is to be created
+ * @name:  Name of new dinode
+ * @mode:
+ *
+ * Returns: errno
+ */
+
+static int create_ok(struct gfs2_inode *dip, struct qstr *name,
+		     unsigned int mode)
+{
+	int error;
+
+	error = gfs2_repermission(dip->i_vnode, MAY_WRITE | MAY_EXEC, NULL);
+	if (error)
+		return error;
+
+	/*  Don't create entries in an unlinked directory  */
+	if (!dip->i_di.di_nlink)
+		return -EPERM;
+
+	error = gfs2_dir_search(dip, name, NULL, NULL);
+	switch (error) {
+	case -ENOENT:
+		error = 0;
+		break;
+	case 0:
+		return -EEXIST;
+	default:
+		return error;
+	}
+
+	if (dip->i_di.di_entries == (uint32_t)-1)
+		return -EFBIG;
+	if (S_ISDIR(mode) && dip->i_di.di_nlink == (uint32_t)-1)
+		return -EMLINK;
+
+	return 0;
+}
+
+static void munge_mode_uid_gid(struct gfs2_inode *dip, unsigned int *mode,
+			       unsigned int *uid, unsigned int *gid)
+{
+	if (dip->i_sbd->sd_args.ar_suiddir &&
+	    (dip->i_di.di_mode & S_ISUID) &&
+	    dip->i_di.di_uid) {
+		if (S_ISDIR(*mode))
+			*mode |= S_ISUID;
+		else if (dip->i_di.di_uid != current->fsuid)
+			*mode &= ~07111;
+		*uid = dip->i_di.di_uid;
+	} else
+		*uid = current->fsuid;
+
+	if (dip->i_di.di_mode & S_ISGID) {
+		if (S_ISDIR(*mode))
+			*mode |= S_ISGID;
+		*gid = dip->i_di.di_gid;
+	} else
+		*gid = current->fsgid;
+}
+
+static int alloc_dinode(struct gfs2_inode *dip, struct gfs2_unlinked *ul)
+{
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	int error;
+
+	gfs2_alloc_get(dip);
+
+	dip->i_alloc->al_requested = RES_DINODE;
+	error = gfs2_inplace_reserve(dip);
+	if (error)
+		goto out;
+
+	error = gfs2_trans_begin(sdp, RES_RG_BIT + RES_UNLINKED +
+				 RES_STATFS, 0);
+	if (error)
+		goto out_ipreserv;
+
+	ul->ul_ut.ut_inum.no_addr = gfs2_alloc_di(dip);
+
+	ul->ul_ut.ut_flags = GFS2_UTF_UNINIT;
+	error = gfs2_unlinked_ondisk_add(sdp, ul);
+
+	gfs2_trans_end(sdp);
+
+ out_ipreserv:
+	gfs2_inplace_release(dip);
+
+ out:
+	gfs2_alloc_put(dip);
+
+	return error;
+}
+
+/**
+ * init_dinode - Fill in a new dinode structure
+ * @dip: the directory this inode is being created in
+ * @gl: The glock covering the new inode
+ * @inum: the inode number
+ * @mode: the file permissions
+ * @uid:
+ * @gid:
+ *
+ */
+
+static void init_dinode(struct gfs2_inode *dip, struct gfs2_glock *gl,
+			struct gfs2_inum *inum, unsigned int mode,
+			unsigned int uid, unsigned int gid)
+{
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_dinode di;
+	struct buffer_head *dibh;
+
+	dibh = gfs2_meta_new(gl, inum->no_addr);
+	gfs2_trans_add_bh(gl, dibh);
+	gfs2_metatype_set(dibh, GFS2_METATYPE_DI, GFS2_FORMAT_DI);
+	gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
+
+	memset(&di, 0, sizeof(struct gfs2_dinode));
+	gfs2_meta_header_in(&di.di_header, dibh->b_data);
+	di.di_num = *inum;
+	di.di_mode = mode;
+	di.di_uid = uid;
+	di.di_gid = gid;
+	di.di_blocks = 1;
+	di.di_atime = di.di_mtime = di.di_ctime = get_seconds();
+	di.di_goal_meta = di.di_goal_data = inum->no_addr;
+
+	if (S_ISREG(mode)) {
+		if ((dip->i_di.di_flags & GFS2_DIF_INHERIT_JDATA) ||
+		    gfs2_tune_get(sdp, gt_new_files_jdata))
+			di.di_flags |= GFS2_DIF_JDATA;
+		if ((dip->i_di.di_flags & GFS2_DIF_INHERIT_DIRECTIO) ||
+		    gfs2_tune_get(sdp, gt_new_files_directio))
+			di.di_flags |= GFS2_DIF_DIRECTIO;
+	} else if (S_ISDIR(mode)) {
+		di.di_flags |= (dip->i_di.di_flags & GFS2_DIF_INHERIT_DIRECTIO);
+		di.di_flags |= (dip->i_di.di_flags & GFS2_DIF_INHERIT_JDATA);
+	}
+
+	gfs2_dinode_out(&di, dibh->b_data);
+	brelse(dibh);
+}
+
+static int make_dinode(struct gfs2_inode *dip, struct gfs2_glock *gl,
+		       unsigned int mode, struct gfs2_unlinked *ul)
+{
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	unsigned int uid, gid;
+	int error;
+
+	munge_mode_uid_gid(dip, &mode, &uid, &gid);
+
+	gfs2_alloc_get(dip);
+
+	error = gfs2_quota_lock(dip, uid, gid);
+	if (error)
+		goto out;
+
+	error = gfs2_quota_check(dip, uid, gid);
+	if (error)
+		goto out_quota;
+
+	error = gfs2_trans_begin(sdp, RES_DINODE + RES_UNLINKED +
+				 RES_QUOTA, 0);
+	if (error)
+		goto out_quota;
+
+	ul->ul_ut.ut_flags = 0;
+	error = gfs2_unlinked_ondisk_munge(sdp, ul);
+
+	init_dinode(dip, gl, &ul->ul_ut.ut_inum,
+		     mode, uid, gid);
+
+	gfs2_quota_change(dip, +1, uid, gid);
+
+	gfs2_trans_end(sdp);
+
+ out_quota:
+	gfs2_quota_unlock(dip);
+
+ out:
+	gfs2_alloc_put(dip);
+
+	return error;
+}
+
+static int link_dinode(struct gfs2_inode *dip, struct qstr *name,
+		       struct gfs2_inode *ip, struct gfs2_unlinked *ul)
+{
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_alloc *al;
+	int alloc_required;
+	struct buffer_head *dibh;
+	int error;
+
+	al = gfs2_alloc_get(dip);
+
+	error = gfs2_quota_lock(dip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
+	if (error)
+		goto fail;
+
+	error = gfs2_diradd_alloc_required(dip, name, &alloc_required);
+	if (alloc_required) {
+		error = gfs2_quota_check(dip, dip->i_di.di_uid,
+					 dip->i_di.di_gid);
+		if (error)
+			goto fail_quota_locks;
+
+		al->al_requested = sdp->sd_max_dirres;
+
+		error = gfs2_inplace_reserve(dip);
+		if (error)
+			goto fail_quota_locks;
+
+		error = gfs2_trans_begin(sdp,
+					 sdp->sd_max_dirres +
+					 al->al_rgd->rd_ri.ri_length +
+					 2 * RES_DINODE + RES_UNLINKED +
+					 RES_STATFS + RES_QUOTA, 0);
+		if (error)
+			goto fail_ipreserv;
+	} else {
+		error = gfs2_trans_begin(sdp,
+					 RES_LEAF +
+					 2 * RES_DINODE +
+					 RES_UNLINKED, 0);
+		if (error)
+			goto fail_quota_locks;
+	}
+
+	error = gfs2_dir_add(dip, name, &ip->i_num, IF2DT(ip->i_di.di_mode));
+	if (error)
+		goto fail_end_trans;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		goto fail_end_trans;
+	ip->i_di.di_nlink = 1;
+	gfs2_trans_add_bh(ip->i_gl, dibh);
+	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	brelse(dibh);
+
+	error = gfs2_unlinked_ondisk_rm(sdp, ul);
+	if (error)
+		goto fail_end_trans;
+
+	return 0;
+
+ fail_end_trans:
+	gfs2_trans_end(sdp);
+
+ fail_ipreserv:
+	if (dip->i_alloc->al_rgd)
+		gfs2_inplace_release(dip);
+
+ fail_quota_locks:
+	gfs2_quota_unlock(dip);
+
+ fail:
+	gfs2_alloc_put(dip);
+
+	return error;
+}
+
+/**
+ * gfs2_createi - Create a new inode
+ * @ghs: An array of two holders
+ * @name: The name of the new file
+ * @mode: the permissions on the new inode
+ *
+ * @ghs[0] is an initialized holder for the directory
+ * @ghs[1] is the holder for the inode lock
+ *
+ * If the return value is 0, the glocks on both the directory and the new
+ * file are held.  A transaction has been started and an inplace reservation
+ * is held, as well.
+ *
+ * Returns: errno
+ */
+
+int gfs2_createi(struct gfs2_holder *ghs, struct qstr *name, unsigned int mode)
+{
+	struct gfs2_inode *dip = get_gl2ip(ghs->gh_gl);
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_unlinked *ul;
+	struct gfs2_inode *ip;
+	int error;
+
+	if (!name->len || name->len > GFS2_FNAMESIZE)
+		return -ENAMETOOLONG;
+
+	error = gfs2_unlinked_get(sdp, &ul);
+	if (error)
+		return error;
+
+	gfs2_holder_reinit(LM_ST_EXCLUSIVE, 0, ghs);
+	error = gfs2_glock_nq(ghs);
+	if (error)
+		goto fail;
+
+	error = create_ok(dip, name, mode);
+	if (error)
+		goto fail_gunlock;
+
+	error = pick_formal_ino(sdp, &ul->ul_ut.ut_inum.no_formal_ino);
+	if (error)
+		goto fail_gunlock;
+
+	error = alloc_dinode(dip, ul);
+	if (error)
+		goto fail_gunlock;
+
+	if (ul->ul_ut.ut_inum.no_addr < dip->i_num.no_addr) {
+		gfs2_glock_dq(ghs);
+
+		error = gfs2_glock_nq_num(sdp,
+					  ul->ul_ut.ut_inum.no_addr,
+					  &gfs2_inode_glops,
+					  LM_ST_EXCLUSIVE, GL_SKIP,
+					  ghs + 1);
+		if (error) {
+			gfs2_unlinked_put(sdp, ul);
+			return error;
+		}
+
+		gfs2_holder_reinit(LM_ST_EXCLUSIVE, 0, ghs);
+		error = gfs2_glock_nq(ghs);
+		if (error) {
+			gfs2_glock_dq_uninit(ghs + 1);
+			gfs2_unlinked_put(sdp, ul);
+			return error;
+		}
+
+		error = create_ok(dip, name, mode);
+		if (error)
+			goto fail_gunlock2;
+	} else {
+		error = gfs2_glock_nq_num(sdp,
+					  ul->ul_ut.ut_inum.no_addr,
+					  &gfs2_inode_glops,
+					  LM_ST_EXCLUSIVE, GL_SKIP,
+					  ghs + 1);
+		if (error)
+			goto fail_gunlock;
+	}
+
+	error = make_dinode(dip, ghs[1].gh_gl, mode, ul);
+	if (error)
+		goto fail_gunlock2;
+
+	error = gfs2_inode_get(ghs[1].gh_gl, &ul->ul_ut.ut_inum, CREATE, &ip);
+	if (error)
+		goto fail_gunlock2;
+
+	error = gfs2_inode_refresh(ip);
+	if (error)
+		goto fail_iput;
+
+	error = gfs2_acl_create(dip, ip);
+	if (error)
+		goto fail_iput;
+
+	error = link_dinode(dip, name, ip, ul);
+	if (error)
+		goto fail_iput;
+
+	gfs2_unlinked_put(sdp, ul);
+
+	return 0;
+
+ fail_iput:
+	gfs2_inode_put(ip);
+
+ fail_gunlock2:
+	gfs2_glock_dq_uninit(ghs + 1);
+
+ fail_gunlock:
+	gfs2_glock_dq(ghs);
+
+ fail:
+	gfs2_unlinked_put(sdp, ul);
+
+	return error;
+}
+
+/**
+ * gfs2_unlinki - Unlink a file
+ * @dip: The inode of the directory
+ * @name: The name of the file to be unlinked
+ * @ip: The inode of the file to be removed
+ *
+ * Assumes Glocks on both dip and ip are held.
+ *
+ * Returns: errno
+ */
+
+int gfs2_unlinki(struct gfs2_inode *dip, struct qstr *name,
+		 struct gfs2_inode *ip, struct gfs2_unlinked *ul)
+{
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	int error;
+
+	error = gfs2_dir_del(dip, name);
+	if (error)
+		return error;
+
+	error = gfs2_change_nlink(ip, -1);
+	if (error)
+		return error;
+
+	/* If this inode is being unlinked from the directory structure,
+	   we need to mark that in the log so that it isn't lost during
+	   a crash. */
+
+	if (!ip->i_di.di_nlink) {
+		ul->ul_ut.ut_inum = ip->i_num;
+		error = gfs2_unlinked_ondisk_add(sdp, ul);
+		if (!error)
+			set_bit(GLF_STICKY, &ip->i_gl->gl_flags);
+	}
+
+	return error;
+}
+
+/**
+ * gfs2_rmdiri - Remove a directory
+ * @dip: The parent directory of the directory to be removed
+ * @name: The name of the directory to be removed
+ * @ip: The GFS2 inode of the directory to be removed
+ *
+ * Assumes Glocks on dip and ip are held
+ *
+ * Returns: errno
+ */
+
+int gfs2_rmdiri(struct gfs2_inode *dip, struct qstr *name,
+		struct gfs2_inode *ip, struct gfs2_unlinked *ul)
+{
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct qstr dotname;
+	int error;
+
+	if (ip->i_di.di_entries != 2) {
+		if (gfs2_consist_inode(ip))
+			gfs2_dinode_print(&ip->i_di);
+		return -EIO;
+	}
+
+	error = gfs2_dir_del(dip, name);
+	if (error)
+		return error;
+
+	error = gfs2_change_nlink(dip, -1);
+	if (error)
+		return error;
+
+	dotname.len = 1;
+	dotname.name = ".";
+	error = gfs2_dir_del(ip, &dotname);
+	if (error)
+		return error;
+
+	dotname.len = 2;
+	dotname.name = "..";
+	error = gfs2_dir_del(ip, &dotname);
+	if (error)
+		return error;
+
+	error = gfs2_change_nlink(ip, -2);
+	if (error)
+		return error;
+
+	/* This inode is being unlinked from the directory structure and
+	   we need to mark that in the log so that it isn't lost during
+	   a crash. */
+
+	ul->ul_ut.ut_inum = ip->i_num;
+	error = gfs2_unlinked_ondisk_add(sdp, ul);
+	if (!error)
+		set_bit(GLF_STICKY, &ip->i_gl->gl_flags);
+
+	return error;
+}
+
+/*
+ * gfs2_unlink_ok - check to see that a inode is still in a directory
+ * @dip: the directory
+ * @name: the name of the file
+ * @ip: the inode
+ *
+ * Assumes that the lock on (at least) @dip is held.
+ *
+ * Returns: 0 if the parent/child relationship is correct, errno if it isn't
+ */
+
+int gfs2_unlink_ok(struct gfs2_inode *dip, struct qstr *name,
+		   struct gfs2_inode *ip)
+{
+	struct gfs2_inum inum;
+	unsigned int type;
+	int error;
+
+	if (IS_IMMUTABLE(ip->i_vnode) || IS_APPEND(ip->i_vnode))
+		return -EPERM;
+
+	if ((dip->i_di.di_mode & S_ISVTX) &&
+	    dip->i_di.di_uid != current->fsuid &&
+	    ip->i_di.di_uid != current->fsuid &&
+	    !capable(CAP_FOWNER))
+		return -EPERM;
+
+	if (IS_APPEND(dip->i_vnode))
+		return -EPERM;
+
+	error = gfs2_repermission(dip->i_vnode, MAY_WRITE | MAY_EXEC, NULL);
+	if (error)
+		return error;
+
+	error = gfs2_dir_search(dip, name, &inum, &type);
+	if (error)
+		return error;
+
+	if (!gfs2_inum_equal(&inum, &ip->i_num))
+		return -ENOENT;
+
+	if (IF2DT(ip->i_di.di_mode) != type) {
+		gfs2_consist_inode(dip);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * gfs2_ok_to_move - check if it's ok to move a directory to another directory
+ * @this: move this
+ * @to: to here
+ *
+ * Follow @to back to the root and make sure we don't encounter @this
+ * Assumes we already hold the rename lock.
+ *
+ * Returns: errno
+ */
+
+int gfs2_ok_to_move(struct gfs2_inode *this, struct gfs2_inode *to)
+{
+	struct gfs2_sbd *sdp = this->i_sbd;
+	struct gfs2_inode *tmp;
+	struct qstr dotdot;
+	int error = 0;
+
+	memset(&dotdot, 0, sizeof(struct qstr));
+	dotdot.name = "..";
+	dotdot.len = 2;
+
+	gfs2_inode_hold(to);
+
+	for (;;) {
+		if (to == this) {
+			error = -EINVAL;
+			break;
+		}
+		if (to == sdp->sd_root_dir) {
+			error = 0;
+			break;
+		}
+
+		error = gfs2_lookupi(to, &dotdot, TRUE, &tmp);
+		if (error)
+			break;
+
+		gfs2_inode_put(to);
+		to = tmp;
+	}
+
+	gfs2_inode_put(to);
+
+	return error;
+}
+
+/**
+ * gfs2_readlinki - return the contents of a symlink
+ * @ip: the symlink's inode
+ * @buf: a pointer to the buffer to be filled
+ * @len: a pointer to the length of @buf
+ *
+ * If @buf is too small, a piece of memory is kmalloc()ed and needs
+ * to be freed by the caller.
+ *
+ * Returns: errno
+ */
+
+int gfs2_readlinki(struct gfs2_inode *ip, char **buf, unsigned int *len)
+{
+	struct gfs2_holder i_gh;
+	struct buffer_head *dibh;
+	unsigned int x;
+	int error;
+
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME, &i_gh);
+	error = gfs2_glock_nq_atime(&i_gh);
+	if (error) {
+		gfs2_holder_uninit(&i_gh);
+		return error;
+	}
+
+	if (!ip->i_di.di_size) {
+		gfs2_consist_inode(ip);
+		error = -EIO;
+		goto out;
+	}
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		goto out;
+
+	x = ip->i_di.di_size + 1;
+	if (x > *len) {
+		*buf = kmalloc(x, GFP_KERNEL);
+		if (!*buf) {
+			error = -ENOMEM;
+			goto out_brelse;
+		}
+	}
+
+	memcpy(*buf, dibh->b_data + sizeof(struct gfs2_dinode), x);
+	*len = x;
+
+ out_brelse:
+	brelse(dibh);
+
+ out:
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return error;
+}
+
+/**
+ * gfs2_glock_nq_atime - Acquire a hold on an inode's glock, and
+ *       conditionally update the inode's atime
+ * @gh: the holder to acquire
+ *
+ * Tests atime (access time) for gfs2_read, gfs2_readdir and gfs2_mmap
+ * Update if the difference between the current time and the inode's current
+ * atime is greater than an interval specified at mount.
+ *
+ * Returns: errno
+ */
+
+int gfs2_glock_nq_atime(struct gfs2_holder *gh)
+{
+	struct gfs2_glock *gl = gh->gh_gl;
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+	struct gfs2_inode *ip = get_gl2ip(gl);
+	int64_t curtime, quantum = gfs2_tune_get(sdp, gt_atime_quantum);
+	unsigned int state;
+	int flags;
+	int error;
+
+	if (gfs2_assert_warn(sdp, gh->gh_flags & GL_ATIME) ||
+	    gfs2_assert_warn(sdp, !(gh->gh_flags & GL_ASYNC)) ||
+	    gfs2_assert_warn(sdp, gl->gl_ops == &gfs2_inode_glops))
+		return -EINVAL;
+
+	state = gh->gh_state;
+	flags = gh->gh_flags;
+
+	error = gfs2_glock_nq(gh);
+	if (error)
+		return error;
+
+	if (test_bit(SDF_NOATIME, &sdp->sd_flags) ||
+	    (sdp->sd_vfs->s_flags & MS_RDONLY))
+		return 0;
+
+	curtime = get_seconds();
+	if (curtime - ip->i_di.di_atime >= quantum) {
+		gfs2_glock_dq(gh);
+		gfs2_holder_reinit(LM_ST_EXCLUSIVE,
+				  gh->gh_flags & ~LM_FLAG_ANY,
+				  gh);
+		error = gfs2_glock_nq(gh);
+		if (error)
+			return error;
+
+		/* Verify that atime hasn't been updated while we were
+		   trying to get exclusive lock. */
+
+		curtime = get_seconds();
+		if (curtime - ip->i_di.di_atime >= quantum) {
+			struct buffer_head *dibh;
+
+			error = gfs2_trans_begin(sdp, RES_DINODE, 0);
+			if (error == -EROFS)
+				return 0;
+			if (error)
+				goto fail;
+
+			error = gfs2_meta_inode_buffer(ip, &dibh);
+			if (error)
+				goto fail_end_trans;
+
+			ip->i_di.di_atime = curtime;
+
+			gfs2_trans_add_bh(ip->i_gl, dibh);
+			gfs2_dinode_out(&ip->i_di, dibh->b_data);
+			brelse(dibh);
+
+			gfs2_trans_end(sdp);
+		}
+
+		/* If someone else has asked for the glock,
+		   unlock and let them have it. Then reacquire
+		   in the original state. */
+		if (gfs2_glock_is_blocking(gl)) {
+			gfs2_glock_dq(gh);
+			gfs2_holder_reinit(state, flags, gh);
+			return gfs2_glock_nq(gh);
+		}
+	}
+
+	return 0;
+
+ fail_end_trans:
+	gfs2_trans_end(sdp);
+
+ fail:
+	gfs2_glock_dq(gh);
+
+	return error;
+}
+
+/**
+ * glock_compare_atime - Compare two struct gfs2_glock structures for sort
+ * @arg_a: the first structure
+ * @arg_b: the second structure
+ *
+ * Returns: 1 if A > B
+ *         -1 if A < B
+ *          0 if A = B
+ */
+
+static int glock_compare_atime(const void *arg_a, const void *arg_b)
+{
+	struct gfs2_holder *gh_a = *(struct gfs2_holder **)arg_a;
+	struct gfs2_holder *gh_b = *(struct gfs2_holder **)arg_b;
+	struct lm_lockname *a = &gh_a->gh_gl->gl_name;
+	struct lm_lockname *b = &gh_b->gh_gl->gl_name;
+	int ret = 0;
+
+	if (a->ln_number > b->ln_number)
+		ret = 1;
+	else if (a->ln_number < b->ln_number)
+		ret = -1;
+	else {
+		if (gh_a->gh_state == LM_ST_SHARED &&
+		    gh_b->gh_state == LM_ST_EXCLUSIVE)
+			ret = 1;
+		else if (gh_a->gh_state == LM_ST_SHARED &&
+			 (gh_b->gh_flags & GL_ATIME))
+			ret = 1;
+	}
+
+	return ret;
+}
+
+/**
+ * gfs2_glock_nq_m_atime - acquire multiple glocks where one may need an
+ *      atime update
+ * @num_gh: the number of structures
+ * @ghs: an array of struct gfs2_holder structures
+ *
+ * Returns: 0 on success (all glocks acquired),
+ *          errno on failure (no glocks acquired)
+ */
+
+int gfs2_glock_nq_m_atime(unsigned int num_gh, struct gfs2_holder *ghs)
+{
+	struct gfs2_holder **p;
+	unsigned int x;
+	int error = 0;
+
+	if (!num_gh)
+		return 0;
+
+	if (num_gh == 1) {
+		ghs->gh_flags &= ~(LM_FLAG_TRY | GL_ASYNC);
+		if (ghs->gh_flags & GL_ATIME)
+			error = gfs2_glock_nq_atime(ghs);
+		else
+			error = gfs2_glock_nq(ghs);
+		return error;
+	}
+
+	p = kcalloc(num_gh, sizeof(struct gfs2_holder *), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	for (x = 0; x < num_gh; x++)
+		p[x] = &ghs[x];
+
+	sort(p, num_gh, sizeof(struct gfs2_holder *), glock_compare_atime,NULL);
+
+	for (x = 0; x < num_gh; x++) {
+		p[x]->gh_flags &= ~(LM_FLAG_TRY | GL_ASYNC);
+
+		if (p[x]->gh_flags & GL_ATIME)
+			error = gfs2_glock_nq_atime(p[x]);
+		else
+			error = gfs2_glock_nq(p[x]);
+
+		if (error) {
+			while (x--)
+				gfs2_glock_dq(p[x]);
+			break;
+		}
+	}
+
+	kfree(p);
+
+	return error;
+}
+
+/**
+ * gfs2_try_toss_vnode - See if we can toss a vnode from memory
+ * @ip: the inode
+ *
+ * Returns:  TRUE if the vnode was tossed
+ */
+
+void gfs2_try_toss_vnode(struct gfs2_inode *ip)
+{
+	struct inode *inode;
+
+	inode = gfs2_ip2v_lookup(ip);
+	if (!inode)
+		return;
+
+	d_prune_aliases(inode);
+
+	if (S_ISDIR(ip->i_di.di_mode)) {
+		struct list_head *head = &inode->i_dentry;
+		struct dentry *d = NULL;
+
+		spin_lock(&dcache_lock);
+		if (list_empty(head))
+			spin_unlock(&dcache_lock);
+		else {
+			d = list_entry(head->next, struct dentry, d_alias);
+			dget_locked(d);
+			spin_unlock(&dcache_lock);
+
+			if (have_submounts(d))
+				dput(d);
+			else {
+				shrink_dcache_parent(d);
+				dput(d);
+				d_prune_aliases(inode);
+			}
+		}
+	}
+
+	inode->i_nlink = 0;
+	iput(inode);
+}
+
+/**
+ * gfs2_setattr_simple -
+ * @ip:
+ * @attr:
+ *
+ * Called with a reference on the vnode.
+ *
+ * Returns: errno
+ */
+
+int gfs2_setattr_simple(struct gfs2_inode *ip, struct iattr *attr)
+{
+	struct buffer_head *dibh;
+	int error;
+
+	error = gfs2_trans_begin(ip->i_sbd, RES_DINODE, 0);
+	if (error)
+		return error;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (!error) {
+		error = inode_setattr(ip->i_vnode, attr);
+		gfs2_assert_warn(ip->i_sbd, !error);
+		gfs2_inode_attr_out(ip);
+
+		gfs2_trans_add_bh(ip->i_gl, dibh);
+		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		brelse(dibh);
+	}
+
+	gfs2_trans_end(ip->i_sbd);
+
+	return error;
+}
+
+int gfs2_repermission(struct inode *inode, int mask, struct nameidata *nd)
+{
+	return permission(inode, mask, nd);
+}
+
--- a/fs/gfs2/inode.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/inode.h	2005-09-01 17:36:55.314115624 +0800
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __INODE_DOT_H__
+#define __INODE_DOT_H__
+
+static inline int gfs2_is_stuffed(struct gfs2_inode *ip)
+{
+	return !ip->i_di.di_height;
+}
+
+static inline int gfs2_is_jdata(struct gfs2_inode *ip)
+{
+	return ip->i_di.di_flags & GFS2_DIF_JDATA;
+}
+
+void gfs2_inode_attr_in(struct gfs2_inode *ip);
+void gfs2_inode_attr_out(struct gfs2_inode *ip);
+struct inode *gfs2_ip2v_lookup(struct gfs2_inode *ip);
+struct inode *gfs2_ip2v(struct gfs2_inode *ip);
+struct inode *gfs2_iget(struct super_block *sb, struct gfs2_inum *inum);
+
+void gfs2_inode_min_init(struct gfs2_inode *ip, unsigned int type);
+int gfs2_inode_refresh(struct gfs2_inode *ip);
+
+int gfs2_inode_get(struct gfs2_glock *i_gl,
+		   struct gfs2_inum *inum, int create,
+		   struct gfs2_inode **ipp);
+void gfs2_inode_hold(struct gfs2_inode *ip);
+void gfs2_inode_put(struct gfs2_inode *ip);
+void gfs2_inode_destroy(struct gfs2_inode *ip);
+
+int gfs2_inode_dealloc(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul);
+
+int gfs2_change_nlink(struct gfs2_inode *ip, int diff);
+int gfs2_lookupi(struct gfs2_inode *dip, struct qstr *name, int is_root,
+		 struct gfs2_inode **ipp);
+int gfs2_createi(struct gfs2_holder *ghs, struct qstr *name, unsigned int mode);
+int gfs2_unlinki(struct gfs2_inode *dip, struct qstr *name,
+		 struct gfs2_inode *ip, struct gfs2_unlinked *ul);
+int gfs2_rmdiri(struct gfs2_inode *dip, struct qstr *name,
+		struct gfs2_inode *ip, struct gfs2_unlinked *ul);
+int gfs2_unlink_ok(struct gfs2_inode *dip, struct qstr *name,
+		   struct gfs2_inode *ip);
+int gfs2_ok_to_move(struct gfs2_inode *this, struct gfs2_inode *to);
+int gfs2_readlinki(struct gfs2_inode *ip, char **buf, unsigned int *len);
+
+int gfs2_glock_nq_atime(struct gfs2_holder *gh);
+int gfs2_glock_nq_m_atime(unsigned int num_gh, struct gfs2_holder *ghs);
+
+void gfs2_try_toss_vnode(struct gfs2_inode *ip);
+
+int gfs2_setattr_simple(struct gfs2_inode *ip, struct iattr *attr);
+
+int gfs2_repermission(struct inode *inode, int mask, struct nameidata *nd);
+
+static inline int gfs2_lookup_simple(struct gfs2_inode *dip, char *name,
+				     struct gfs2_inode **ipp)
+{
+	struct qstr qstr;
+	memset(&qstr, 0, sizeof(struct qstr));
+	qstr.name = name;
+	qstr.len = strlen(name);
+	return gfs2_lookupi(dip, &qstr, TRUE, ipp);
+}
+
+#endif /* __INODE_DOT_H__ */
+
