Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbVIAO3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbVIAO3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVIAO3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:29:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32987 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965142AbVIAO2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:28:54 -0400
Date: Thu, 1 Sep 2005 21:55:04 +0800
From: David Teigland <teigland@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02b/13] GFS: core fs
Message-ID: <20050901135504.GC25581@redhat.com>
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

 fs/gfs2/jdata.c       |  383 +++++++++++++++++++++
 fs/gfs2/jdata.h       |   52 ++
 fs/gfs2/lops.c        |  510 ++++++++++++++++++++++++++++
 fs/gfs2/lops.h        |   95 +++++
 fs/gfs2/main.c        |  102 +++++
 fs/gfs2/meta_io.c     |  884 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/meta_io.h     |   88 ++++
 fs/gfs2/ondisk.c      |   28 +
 fs/gfs2/ops_address.c |  516 +++++++++++++++++++++++++++++
 fs/gfs2/ops_address.h |   15 
 10 files changed, 2673 insertions(+)

--- a/fs/gfs2/jdata.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/jdata.c	2005-09-01 17:36:55.324114104 +0800
@@ -0,0 +1,383 @@
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
+#include <asm/uaccess.h>
+
+#include "gfs2.h"
+#include "bmap.h"
+#include "inode.h"
+#include "jdata.h"
+#include "meta_io.h"
+#include "trans.h"
+
+int gfs2_jdata_get_buffer(struct gfs2_inode *ip, uint64_t block, int new,
+			  struct buffer_head **bhp)
+{
+	struct buffer_head *bh;
+	int error = 0;
+
+	if (new) {
+		bh = gfs2_meta_new(ip->i_gl, block);
+		gfs2_trans_add_bh(ip->i_gl, bh);
+		gfs2_metatype_set(bh, GFS2_METATYPE_JD, GFS2_FORMAT_JD);
+		gfs2_buffer_clear_tail(bh, sizeof(struct gfs2_meta_header));
+	} else {
+		error = gfs2_meta_read(ip->i_gl, block,
+				       DIO_START | DIO_WAIT, &bh);
+		if (error)
+			return error;
+		if (gfs2_metatype_check(ip->i_sbd, bh, GFS2_METATYPE_JD)) {
+			brelse(bh);
+			return -EIO;
+		}
+	}
+
+	*bhp = bh;
+
+	return 0;
+}
+
+/**
+ * gfs2_copy2mem - Trivial copy function for gfs2_jdata_read()
+ * @bh: The buffer to copy from, or NULL meaning zero the buffer
+ * @buf: The buffer to copy/zero
+ * @offset: The offset in the buffer to copy from
+ * @size: The amount of data to copy/zero
+ *
+ * Returns: errno
+ */
+
+int gfs2_copy2mem(struct buffer_head *bh, char **buf, unsigned int offset,
+		  unsigned int size)
+{
+	if (bh)
+		memcpy(*buf, bh->b_data + offset, size);
+	else
+		memset(*buf, 0, size);
+	*buf += size;
+	return 0;
+}
+
+/**
+ * gfs2_copy2user - Copy bytes to user space for gfs2_jdata_read()
+ * @bh: The buffer
+ * @buf: The destination of the data
+ * @offset: The offset into the buffer
+ * @size: The amount of data to copy
+ *
+ * Returns: errno
+ */
+
+int gfs2_copy2user(struct buffer_head *bh, char **buf, unsigned int offset,
+		   unsigned int size)
+{
+	int error;
+
+	if (bh)
+		error = copy_to_user(*buf, bh->b_data + offset, size);
+	else
+		error = clear_user(*buf, size);
+
+	if (error)
+		error = -EFAULT;
+	else
+		*buf += size;
+
+	return error;
+}
+
+static int jdata_read_stuffed(struct gfs2_inode *ip, char *buf,
+			      unsigned int offset, unsigned int size,
+			      read_copy_fn_t copy_fn)
+{
+	struct buffer_head *dibh;
+	int error;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (!error) {
+		error = copy_fn(dibh, &buf,
+				offset + sizeof(struct gfs2_dinode), size);
+		brelse(dibh);
+	}
+
+	return (error) ? error : size;
+}
+
+/**
+ * gfs2_jdata_read - Read a jdata file
+ * @ip: The GFS2 Inode
+ * @buf: The buffer to place result into
+ * @offset: File offset to begin jdata_readng from
+ * @size: Amount of data to transfer
+ * @copy_fn: Function to actually perform the copy
+ *
+ * The @copy_fn only copies a maximum of a single block at once so
+ * we are safe calling it with int arguments. It is done so that
+ * we don't needlessly put 64bit arguments on the stack and it
+ * also makes the code in the @copy_fn nicer too.
+ *
+ * Returns: The amount of data actually copied or the error
+ */
+
+int gfs2_jdata_read(struct gfs2_inode *ip, char *buf, uint64_t offset,
+		    unsigned int size, read_copy_fn_t copy_fn)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	uint64_t lblock, dblock;
+	uint32_t extlen = 0;
+	unsigned int o;
+	int copied = 0;
+	int error = 0;
+
+	if (offset >= ip->i_di.di_size)
+		return 0;
+
+	if ((offset + size) > ip->i_di.di_size)
+		size = ip->i_di.di_size - offset;
+
+	if (!size)
+		return 0;
+
+	if (gfs2_is_stuffed(ip))
+		return jdata_read_stuffed(ip, buf, (unsigned int)offset, size,
+					  copy_fn);
+
+	if (gfs2_assert_warn(sdp, gfs2_is_jdata(ip)))
+		return -EINVAL;
+
+	lblock = offset;
+	o = do_div(lblock, sdp->sd_jbsize) +
+		sizeof(struct gfs2_meta_header);
+
+	while (copied < size) {
+		unsigned int amount;
+		struct buffer_head *bh;
+		int new;
+
+		amount = size - copied;
+		if (amount > sdp->sd_sb.sb_bsize - o)
+			amount = sdp->sd_sb.sb_bsize - o;
+
+		if (!extlen) {
+			new = FALSE;
+			error = gfs2_block_map(ip, lblock, &new,
+					       &dblock, &extlen);
+			if (error)
+				goto fail;
+		}
+
+		if (extlen > 1)
+			gfs2_meta_ra(ip->i_gl, dblock, extlen);
+
+		if (dblock) {
+			error = gfs2_jdata_get_buffer(ip, dblock, new, &bh);
+			if (error)
+				goto fail;
+			dblock++;
+			extlen--;
+		} else
+			bh = NULL;
+
+		error = copy_fn(bh, &buf, o, amount);
+		brelse(bh);
+		if (error)
+			goto fail;
+
+		copied += amount;
+		lblock++;
+
+		o = sizeof(struct gfs2_meta_header);
+	}
+
+	return copied;
+
+ fail:
+	return (copied) ? copied : error;
+}
+
+/**
+ * gfs2_copy_from_mem - Trivial copy function for gfs2_jdata_write()
+ * @bh: The buffer to copy to or clear
+ * @buf: The buffer to copy from
+ * @offset: The offset in the buffer to write to
+ * @size: The amount of data to write
+ *
+ * Returns: errno
+ */
+
+int gfs2_copy_from_mem(struct gfs2_inode *ip, struct buffer_head *bh,
+		       char **buf, unsigned int offset, unsigned int size)
+{
+	gfs2_trans_add_bh(ip->i_gl, bh);
+	memcpy(bh->b_data + offset, *buf, size);
+
+	*buf += size;
+
+	return 0;
+}
+
+/**
+ * gfs2_copy_from_user - Copy bytes from user space for gfs2_jdata_write()
+ * @bh: The buffer to copy to or clear
+ * @buf: The buffer to copy from
+ * @offset: The offset in the buffer to write to
+ * @size: The amount of data to write
+ *
+ * Returns: errno
+ */
+
+int gfs2_copy_from_user(struct gfs2_inode *ip, struct buffer_head *bh,
+			char **buf, unsigned int offset, unsigned int size)
+{
+	int error = 0;
+
+	gfs2_trans_add_bh(ip->i_gl, bh);
+	if (copy_from_user(bh->b_data + offset, *buf, size))
+		error = -EFAULT;
+	else
+		*buf += size;
+
+	return error;
+}
+
+static int jdata_write_stuffed(struct gfs2_inode *ip, char *buf,
+			       unsigned int offset, unsigned int size,
+			       write_copy_fn_t copy_fn)
+{
+	struct buffer_head *dibh;
+	int error;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		return error;
+
+	error = copy_fn(ip,
+			dibh, &buf,
+			offset + sizeof(struct gfs2_dinode), size);
+	if (!error) {
+		if (ip->i_di.di_size < offset + size)
+			ip->i_di.di_size = offset + size;
+		ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
+		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	}
+
+	brelse(dibh);
+
+	return (error) ? error : size;
+}
+
+/**
+ * gfs2_jdata_write - Write bytes to a file
+ * @ip: The GFS2 inode
+ * @buf: The buffer containing information to be written
+ * @offset: The file offset to start writing at
+ * @size: The amount of data to write
+ * @copy_fn: Function to do the actual copying
+ *
+ * Returns: The number of bytes correctly written or error code
+ */
+
+int gfs2_jdata_write(struct gfs2_inode *ip, char *buf, uint64_t offset,
+		     unsigned int size, write_copy_fn_t copy_fn)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct buffer_head *dibh;
+	uint64_t lblock, dblock;
+	uint32_t extlen = 0;
+	unsigned int o;
+	int copied = 0;
+	int error = 0;
+
+	if (!size)
+		return 0;
+
+	if (gfs2_is_stuffed(ip) &&
+	    offset + size <= sdp->sd_sb.sb_bsize - sizeof(struct gfs2_dinode))
+		return jdata_write_stuffed(ip, buf, (unsigned int)offset, size,
+					   copy_fn);
+
+	if (gfs2_assert_warn(sdp, gfs2_is_jdata(ip)))
+		return -EINVAL;
+
+	if (gfs2_is_stuffed(ip)) {
+		error = gfs2_unstuff_dinode(ip, NULL, NULL);
+		if (error)
+			return error;
+	}
+
+	lblock = offset;
+	o = do_div(lblock, sdp->sd_jbsize) + sizeof(struct gfs2_meta_header);
+
+	while (copied < size) {
+		unsigned int amount;
+		struct buffer_head *bh;
+		int new;
+
+		amount = size - copied;
+		if (amount > sdp->sd_sb.sb_bsize - o)
+			amount = sdp->sd_sb.sb_bsize - o;
+
+		if (!extlen) {
+			new = TRUE;
+			error = gfs2_block_map(ip, lblock, &new,
+					       &dblock, &extlen);
+			if (error)
+				goto fail;
+			error = -EIO;
+			if (gfs2_assert_withdraw(sdp, dblock))
+				goto fail;
+		}
+
+		error = gfs2_jdata_get_buffer(ip, dblock,
+				(amount == sdp->sd_jbsize) ? TRUE : new,
+				&bh);
+		if (error)
+			goto fail;
+
+		error = copy_fn(ip, bh, &buf, o, amount);
+		brelse(bh);
+		if (error)
+			goto fail;
+
+		copied += amount;
+		lblock++;
+		dblock++;
+		extlen--;
+
+		o = sizeof(struct gfs2_meta_header);
+	}
+
+ out:
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		return error;
+
+	if (ip->i_di.di_size < offset + copied)
+		ip->i_di.di_size = offset + copied;
+	ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
+
+	gfs2_trans_add_bh(ip->i_gl, dibh);
+	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	brelse(dibh);
+
+	return copied;
+
+ fail:
+	if (copied)
+		goto out;
+	return error;
+}
+
--- a/fs/gfs2/jdata.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/jdata.h	2005-09-01 17:36:55.325113952 +0800
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __FILE_DOT_H__
+#define __FILE_DOT_H__
+
+int gfs2_jdata_get_buffer(struct gfs2_inode *ip, uint64_t block, int new,
+			  struct buffer_head **bhp);
+
+typedef int (*read_copy_fn_t) (struct buffer_head *bh, char **buf,
+			       unsigned int offset, unsigned int size);
+typedef int (*write_copy_fn_t) (struct gfs2_inode *ip,
+				struct buffer_head *bh, char **buf,
+				unsigned int offset, unsigned int size);
+
+int gfs2_copy2mem(struct buffer_head *bh, char **buf,
+		  unsigned int offset, unsigned int size);
+int gfs2_copy2user(struct buffer_head *bh, char **buf,
+		   unsigned int offset, unsigned int size);
+int gfs2_jdata_read(struct gfs2_inode *ip, char *buf,
+		    uint64_t offset, unsigned int size,
+		    read_copy_fn_t copy_fn);
+
+int gfs2_copy_from_mem(struct gfs2_inode *ip,
+		       struct buffer_head *bh, char **buf,
+		       unsigned int offset, unsigned int size);
+int gfs2_copy_from_user(struct gfs2_inode *ip,
+			struct buffer_head *bh, char **buf,
+			unsigned int offset, unsigned int size);
+int gfs2_jdata_write(struct gfs2_inode *ip, char *buf,
+		     uint64_t offset, unsigned int size,
+		     write_copy_fn_t copy_fn);
+
+static inline int gfs2_jdata_read_mem(struct gfs2_inode *ip, char *buf,
+				      uint64_t offset, unsigned int size)
+{
+	return gfs2_jdata_read(ip, buf, offset, size, gfs2_copy2mem);
+}
+
+static inline int gfs2_jdata_write_mem(struct gfs2_inode *ip, char *buf,
+				       uint64_t offset, unsigned int size)
+{
+	return gfs2_jdata_write(ip, buf, offset, size, gfs2_copy_from_mem);
+}
+
+#endif /* __FILE_DOT_H__ */
--- a/fs/gfs2/lops.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/lops.c	2005-09-01 17:36:55.359108784 +0800
@@ -0,0 +1,510 @@
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
+#include "glock.h"
+#include "log.h"
+#include "lops.h"
+#include "meta_io.h"
+#include "recovery.h"
+#include "rgrp.h"
+#include "trans.h"
+
+static void glock_lo_add(struct gfs2_sbd *sdp, struct gfs2_log_element *le)
+{
+	struct gfs2_glock *gl;
+
+	get_transaction->tr_touched = TRUE;
+
+	if (!list_empty(&le->le_list))
+		return;
+
+	gl = container_of(le, struct gfs2_glock, gl_le);
+	if (gfs2_assert_withdraw(sdp, gfs2_glock_is_held_excl(gl)))
+		return;
+	gfs2_glock_hold(gl);
+	set_bit(GLF_DIRTY, &gl->gl_flags);
+
+	gfs2_log_lock(sdp);
+	sdp->sd_log_num_gl++;
+	list_add(&le->le_list, &sdp->sd_log_le_gl);
+	gfs2_log_unlock(sdp);
+}
+
+static void glock_lo_after_commit(struct gfs2_sbd *sdp, struct gfs2_ail *ai)
+{
+	struct list_head *head = &sdp->sd_log_le_gl;
+	struct gfs2_glock *gl;
+
+	while (!list_empty(head)) {
+		gl = list_entry(head->next, struct gfs2_glock, gl_le.le_list);
+		list_del_init(&gl->gl_le.le_list);
+		sdp->sd_log_num_gl--;
+
+		gfs2_assert_withdraw(sdp, gfs2_glock_is_held_excl(gl));
+		gfs2_glock_put(gl);
+	}
+	gfs2_assert_warn(sdp, !sdp->sd_log_num_gl);
+}
+
+static void buf_lo_add(struct gfs2_sbd *sdp, struct gfs2_log_element *le)
+{
+	struct gfs2_bufdata *bd = container_of(le, struct gfs2_bufdata, bd_le);
+	struct gfs2_trans *tr;
+
+	if (!list_empty(&bd->bd_list_tr))
+		return;
+
+	tr = get_transaction;
+	tr->tr_touched = TRUE;
+	tr->tr_num_buf++;
+	list_add(&bd->bd_list_tr, &tr->tr_list_buf);
+
+	if (!list_empty(&le->le_list))
+		return;
+
+	gfs2_trans_add_gl(bd->bd_gl);
+
+	gfs2_meta_check(sdp, bd->bd_bh);
+	gfs2_meta_pin(sdp, bd->bd_bh);
+
+	gfs2_log_lock(sdp);
+	sdp->sd_log_num_buf++;
+	list_add(&le->le_list, &sdp->sd_log_le_buf);
+	gfs2_log_unlock(sdp);
+
+	tr->tr_num_buf_new++;
+}
+
+static void buf_lo_incore_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
+{
+	struct list_head *head = &tr->tr_list_buf;
+	struct gfs2_bufdata *bd;
+
+	while (!list_empty(head)) {
+		bd = list_entry(head->next, struct gfs2_bufdata, bd_list_tr);
+		list_del_init(&bd->bd_list_tr);
+		tr->tr_num_buf--;
+	}
+	gfs2_assert_warn(sdp, !tr->tr_num_buf);
+}
+
+static void buf_lo_before_commit(struct gfs2_sbd *sdp)
+{
+	struct buffer_head *bh;
+	struct gfs2_log_descriptor ld;
+	struct gfs2_bufdata *bd;
+
+	if (!sdp->sd_log_num_buf)
+		return;
+
+	bh = gfs2_log_get_buf(sdp);
+	memset(&ld, 0, sizeof(struct gfs2_log_descriptor));
+	ld.ld_header.mh_magic = GFS2_MAGIC;
+	ld.ld_header.mh_type = GFS2_METATYPE_LD;
+	ld.ld_header.mh_format = GFS2_FORMAT_LD;
+	ld.ld_header.mh_blkno = bh->b_blocknr;
+	ld.ld_type = GFS2_LOG_DESC_METADATA;
+	ld.ld_length = sdp->sd_log_num_buf + 1;
+	ld.ld_data1 = sdp->sd_log_num_buf;
+	gfs2_log_descriptor_out(&ld, bh->b_data);
+
+	set_buffer_dirty(bh);
+	ll_rw_block(WRITE, 1, &bh);
+
+	list_for_each_entry(bd, &sdp->sd_log_le_buf, bd_le.le_list) {
+		bh = gfs2_log_fake_buf(sdp, bd->bd_bh);
+		set_buffer_dirty(bh);
+		ll_rw_block(WRITE, 1, &bh);
+	}
+}
+
+static void buf_lo_after_commit(struct gfs2_sbd *sdp, struct gfs2_ail *ai)
+{
+	struct list_head *head = &sdp->sd_log_le_buf;
+	struct gfs2_bufdata *bd;
+
+	while (!list_empty(head)) {
+		bd = list_entry(head->next, struct gfs2_bufdata, bd_le.le_list);
+		list_del_init(&bd->bd_le.le_list);
+		sdp->sd_log_num_buf--;
+
+		gfs2_meta_unpin(sdp, bd->bd_bh, ai);
+	}
+	gfs2_assert_warn(sdp, !sdp->sd_log_num_buf);
+}
+
+static void buf_lo_before_scan(struct gfs2_jdesc *jd,
+			       struct gfs2_log_header *head, int pass)
+{
+	struct gfs2_sbd *sdp = jd->jd_inode->i_sbd;
+
+	if (pass != 0)
+		return;
+
+	sdp->sd_found_blocks = 0;
+	sdp->sd_replayed_blocks = 0;
+}
+
+static int buf_lo_scan_elements(struct gfs2_jdesc *jd, unsigned int start,
+				struct gfs2_log_descriptor *ld, int pass)
+{
+	struct gfs2_sbd *sdp = jd->jd_inode->i_sbd;
+	struct gfs2_glock *gl = jd->jd_inode->i_gl;
+	unsigned int blks = ld->ld_data1;
+	struct buffer_head *bh_log, *bh_ip;
+	uint64_t blkno;
+	int error = 0;
+
+	if (pass != 1 || ld->ld_type != GFS2_LOG_DESC_METADATA)
+		return 0;
+
+	gfs2_replay_incr_blk(sdp, &start);
+
+	for (; blks; gfs2_replay_incr_blk(sdp, &start), blks--) {
+		error = gfs2_replay_read_block(jd, start, &bh_log);
+		if (error)
+			return error;
+
+		blkno = ((struct gfs2_meta_header *)bh_log->b_data)->mh_blkno;
+		blkno = gfs2_64_to_cpu(blkno);
+
+		sdp->sd_found_blocks++;
+
+		if (gfs2_revoke_check(sdp, blkno, start)) {
+			brelse(bh_log);
+			continue;
+		}
+
+		bh_ip = gfs2_meta_new(gl, blkno);
+		memcpy(bh_ip->b_data, bh_log->b_data, bh_log->b_size);
+
+		if (gfs2_meta_check(sdp, bh_ip))
+			error = -EIO;
+		else
+			mark_buffer_dirty(bh_ip);
+
+		brelse(bh_log);
+		brelse(bh_ip);
+
+		if (error)
+			break;
+
+		sdp->sd_replayed_blocks++;
+	}
+
+	return error;
+}
+
+static void buf_lo_after_scan(struct gfs2_jdesc *jd, int error, int pass)
+{
+	struct gfs2_sbd *sdp = jd->jd_inode->i_sbd;
+
+	if (error) {
+		gfs2_meta_sync(jd->jd_inode->i_gl, DIO_START | DIO_WAIT);
+		return;
+	}
+	if (pass != 1)
+		return;
+
+	gfs2_meta_sync(jd->jd_inode->i_gl, DIO_START | DIO_WAIT);
+
+	fs_info(sdp, "jid=%u: Replayed %u of %u blocks\n",
+	        jd->jd_jid, sdp->sd_replayed_blocks, sdp->sd_found_blocks);
+}
+
+static void revoke_lo_add(struct gfs2_sbd *sdp, struct gfs2_log_element *le)
+{
+	struct gfs2_trans *tr;
+
+	tr = get_transaction;
+	tr->tr_touched = TRUE;
+	tr->tr_num_revoke++;
+
+	gfs2_log_lock(sdp);
+	sdp->sd_log_num_revoke++;
+	list_add(&le->le_list, &sdp->sd_log_le_revoke);
+	gfs2_log_unlock(sdp);
+}
+
+static void revoke_lo_before_commit(struct gfs2_sbd *sdp)
+{
+	struct gfs2_log_descriptor ld;
+	struct gfs2_meta_header *mh = &ld.ld_header;
+	struct buffer_head *bh;
+	unsigned int offset;
+	struct list_head *head = &sdp->sd_log_le_revoke;
+	struct gfs2_revoke *rv;
+
+	if (!sdp->sd_log_num_revoke)
+		return;
+
+	bh = gfs2_log_get_buf(sdp);
+	memset(&ld, 0, sizeof(struct gfs2_log_descriptor));
+	ld.ld_header.mh_magic = GFS2_MAGIC;
+	ld.ld_header.mh_type = GFS2_METATYPE_LD;
+	ld.ld_header.mh_format = GFS2_FORMAT_LD;
+	ld.ld_header.mh_blkno = bh->b_blocknr;
+	ld.ld_type = GFS2_LOG_DESC_REVOKE;
+	ld.ld_length = gfs2_struct2blk(sdp, sdp->sd_log_num_revoke, sizeof(uint64_t));
+	ld.ld_data1 = sdp->sd_log_num_revoke;
+	gfs2_log_descriptor_out(&ld, bh->b_data);
+	offset = sizeof(struct gfs2_log_descriptor);
+
+	while (!list_empty(head)) {
+		rv = list_entry(head->next, struct gfs2_revoke, rv_le.le_list);
+		list_del(&rv->rv_le.le_list);
+		sdp->sd_log_num_revoke--;
+
+		if (offset + sizeof(uint64_t) > sdp->sd_sb.sb_bsize) {
+			set_buffer_dirty(bh);
+			ll_rw_block(WRITE, 1, &bh);
+
+			bh = gfs2_log_get_buf(sdp);
+			mh->mh_type = GFS2_METATYPE_LB;
+			mh->mh_format = GFS2_FORMAT_LB;
+			mh->mh_blkno = bh->b_blocknr;
+			gfs2_meta_header_out(mh, bh->b_data);
+			offset = sizeof(struct gfs2_meta_header);
+		}
+
+		*(uint64_t *)(bh->b_data + offset) = cpu_to_gfs2_64(rv->rv_blkno);
+		kfree(rv);
+
+		offset += sizeof(uint64_t);
+	}
+	gfs2_assert_withdraw(sdp, !sdp->sd_log_num_revoke);
+
+	set_buffer_dirty(bh);
+	ll_rw_block(WRITE, 1, &bh);
+}
+
+static void revoke_lo_before_scan(struct gfs2_jdesc *jd,
+				  struct gfs2_log_header *head, int pass)
+{
+	struct gfs2_sbd *sdp = jd->jd_inode->i_sbd;
+
+	if (pass != 0)
+		return;
+
+	sdp->sd_found_revokes = 0;
+	sdp->sd_replay_tail = head->lh_tail;
+}
+
+static int revoke_lo_scan_elements(struct gfs2_jdesc *jd, unsigned int start,
+				   struct gfs2_log_descriptor *ld, int pass)
+{
+	struct gfs2_sbd *sdp = jd->jd_inode->i_sbd;
+	unsigned int blks = ld->ld_length;
+	unsigned int revokes = ld->ld_data1;
+	struct buffer_head *bh;
+	unsigned int offset;
+	uint64_t blkno;
+	int first = TRUE;
+	int error;
+
+	if (pass != 0 || ld->ld_type != GFS2_LOG_DESC_REVOKE)
+		return 0;
+
+	offset = sizeof(struct gfs2_log_descriptor);
+
+	for (; blks; gfs2_replay_incr_blk(sdp, &start), blks--) {
+		error = gfs2_replay_read_block(jd, start, &bh);
+		if (error)
+			return error;
+
+		if (!first)
+			gfs2_metatype_check(sdp, bh, GFS2_METATYPE_LB);
+
+		while (offset + sizeof(uint64_t) <= sdp->sd_sb.sb_bsize) {
+			blkno = *(uint64_t *)(bh->b_data + offset);
+			blkno = gfs2_64_to_cpu(blkno);
+
+			error = gfs2_revoke_add(sdp, blkno, start);
+			if (error < 0)
+				return error;
+			else if (error)
+				sdp->sd_found_revokes++;
+
+			if (!--revokes)
+				break;
+			offset += sizeof(uint64_t);
+		}
+
+		brelse(bh);
+		offset = sizeof(struct gfs2_meta_header);
+		first = FALSE;
+	}
+
+	return 0;
+}
+
+static void revoke_lo_after_scan(struct gfs2_jdesc *jd, int error, int pass)
+{
+	struct gfs2_sbd *sdp = jd->jd_inode->i_sbd;
+
+	if (error) {
+		gfs2_revoke_clean(sdp);
+		return;
+	}
+	if (pass != 1)
+		return;
+
+	fs_info(sdp, "jid=%u: Found %u revoke tags\n",
+	        jd->jd_jid, sdp->sd_found_revokes);
+
+	gfs2_revoke_clean(sdp);
+}
+
+static void rg_lo_add(struct gfs2_sbd *sdp, struct gfs2_log_element *le)
+{
+	struct gfs2_rgrpd *rgd;
+
+	get_transaction->tr_touched = TRUE;
+
+	if (!list_empty(&le->le_list))
+		return;
+
+	rgd = container_of(le, struct gfs2_rgrpd, rd_le);
+	gfs2_rgrp_bh_hold(rgd);
+
+	gfs2_log_lock(sdp);
+	sdp->sd_log_num_rg++;
+	list_add(&le->le_list, &sdp->sd_log_le_rg);
+	gfs2_log_unlock(sdp);	
+}
+
+static void rg_lo_after_commit(struct gfs2_sbd *sdp, struct gfs2_ail *ai)
+{
+	struct list_head *head = &sdp->sd_log_le_rg;
+	struct gfs2_rgrpd *rgd;
+
+	while (!list_empty(head)) {
+		rgd = list_entry(head->next, struct gfs2_rgrpd, rd_le.le_list);
+		list_del_init(&rgd->rd_le.le_list);
+		sdp->sd_log_num_rg--;
+
+		gfs2_rgrp_repolish_clones(rgd);
+		gfs2_rgrp_bh_put(rgd);
+	}
+	gfs2_assert_warn(sdp, !sdp->sd_log_num_rg);
+}
+
+static void databuf_lo_add(struct gfs2_sbd *sdp, struct gfs2_log_element *le)
+{
+	get_transaction->tr_touched = TRUE;
+
+	gfs2_log_lock(sdp);
+	sdp->sd_log_num_databuf++;
+	list_add(&le->le_list, &sdp->sd_log_le_databuf);
+	gfs2_log_unlock(sdp);
+}
+
+static void databuf_lo_before_commit(struct gfs2_sbd *sdp)
+{
+	struct list_head *head = &sdp->sd_log_le_databuf;
+	LIST_HEAD(started);
+	struct gfs2_databuf *db;
+	struct buffer_head *bh;
+
+	while (!list_empty(head)) {
+		db = list_entry(head->prev, struct gfs2_databuf, db_le.le_list);
+		list_move(&db->db_le.le_list, &started);
+
+		gfs2_log_lock(sdp);
+		bh = db->db_bh;
+		if (bh) {
+			get_bh(bh);
+			gfs2_log_unlock(sdp);
+			if (buffer_dirty(bh)) {
+				wait_on_buffer(bh);
+				ll_rw_block(WRITE, 1, &bh);
+			}
+			brelse(bh);
+		} else
+			gfs2_log_unlock(sdp);
+	}
+
+	while (!list_empty(&started)) {
+		db = list_entry(started.next, struct gfs2_databuf,
+				db_le.le_list);
+		list_del(&db->db_le.le_list);
+		sdp->sd_log_num_databuf--;
+
+		gfs2_log_lock(sdp);
+		bh = db->db_bh;
+		if (bh) {
+			set_v2db(bh, NULL);
+			gfs2_log_unlock(sdp);
+			wait_on_buffer(bh);
+			brelse(bh);
+		} else
+			gfs2_log_unlock(sdp);
+
+		kfree(db);
+	}
+
+	gfs2_assert_warn(sdp, !sdp->sd_log_num_databuf);
+}
+
+struct gfs2_log_operations gfs2_glock_lops = {
+	.lo_add = glock_lo_add,
+	.lo_after_commit = glock_lo_after_commit,
+	.lo_name = "glock"
+};
+
+struct gfs2_log_operations gfs2_buf_lops = {
+	.lo_add = buf_lo_add,
+	.lo_incore_commit = buf_lo_incore_commit,
+	.lo_before_commit = buf_lo_before_commit,
+	.lo_after_commit = buf_lo_after_commit,
+	.lo_before_scan = buf_lo_before_scan,
+	.lo_scan_elements = buf_lo_scan_elements,
+	.lo_after_scan = buf_lo_after_scan,
+	.lo_name = "buf"
+};
+
+struct gfs2_log_operations gfs2_revoke_lops = {
+	.lo_add = revoke_lo_add,
+	.lo_before_commit = revoke_lo_before_commit,
+	.lo_before_scan = revoke_lo_before_scan,
+	.lo_scan_elements = revoke_lo_scan_elements,
+	.lo_after_scan = revoke_lo_after_scan,
+	.lo_name = "revoke"
+};
+
+struct gfs2_log_operations gfs2_rg_lops = {
+	.lo_add = rg_lo_add,
+	.lo_after_commit = rg_lo_after_commit,
+	.lo_name = "rg"
+};
+
+struct gfs2_log_operations gfs2_databuf_lops = {
+	.lo_add = databuf_lo_add,
+	.lo_before_commit = databuf_lo_before_commit,
+	.lo_name = "databuf"
+};
+
+struct gfs2_log_operations *gfs2_log_ops[] = {
+	&gfs2_glock_lops,
+	&gfs2_buf_lops,
+	&gfs2_revoke_lops,
+	&gfs2_rg_lops,
+	&gfs2_databuf_lops,
+	NULL
+};
+
--- a/fs/gfs2/lops.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/lops.h	2005-09-01 17:36:55.360108632 +0800
@@ -0,0 +1,95 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __LOPS_DOT_H__
+#define __LOPS_DOT_H__
+
+extern struct gfs2_log_operations gfs2_glock_lops;
+extern struct gfs2_log_operations gfs2_buf_lops;
+extern struct gfs2_log_operations gfs2_revoke_lops;
+extern struct gfs2_log_operations gfs2_rg_lops;
+extern struct gfs2_log_operations gfs2_databuf_lops;
+
+extern struct gfs2_log_operations *gfs2_log_ops[];
+
+static inline void lops_init_le(struct gfs2_log_element *le,
+				struct gfs2_log_operations *lops)
+{
+	INIT_LIST_HEAD(&le->le_list);
+	le->le_ops = lops;
+}
+
+static inline void lops_add(struct gfs2_sbd *sdp, struct gfs2_log_element *le)
+{
+	if (le->le_ops->lo_add)
+		le->le_ops->lo_add(sdp, le);
+}
+
+static inline void lops_incore_commit(struct gfs2_sbd *sdp,
+				      struct gfs2_trans *tr)
+{
+	int x;
+	for (x = 0; gfs2_log_ops[x]; x++)
+		if (gfs2_log_ops[x]->lo_incore_commit)
+			gfs2_log_ops[x]->lo_incore_commit(sdp, tr);
+}
+
+static inline void lops_before_commit(struct gfs2_sbd *sdp)
+{
+	int x;
+	for (x = 0; gfs2_log_ops[x]; x++)
+		if (gfs2_log_ops[x]->lo_before_commit)
+			gfs2_log_ops[x]->lo_before_commit(sdp);
+}
+
+static inline void lops_after_commit(struct gfs2_sbd *sdp, struct gfs2_ail *ai)
+{
+	int x;
+	for (x = 0; gfs2_log_ops[x]; x++)
+		if (gfs2_log_ops[x]->lo_after_commit)
+			gfs2_log_ops[x]->lo_after_commit(sdp, ai);
+}
+
+static inline void lops_before_scan(struct gfs2_jdesc *jd,
+				    struct gfs2_log_header *head,
+				    unsigned int pass)
+{
+	int x;
+	for (x = 0; gfs2_log_ops[x]; x++)
+		if (gfs2_log_ops[x]->lo_before_scan)
+			gfs2_log_ops[x]->lo_before_scan(jd, head, pass);
+}
+
+static inline int lops_scan_elements(struct gfs2_jdesc *jd, unsigned int start,
+				     struct gfs2_log_descriptor *ld,
+				     unsigned int pass)
+{
+	int x, error;
+	for (x = 0; gfs2_log_ops[x]; x++)
+		if (gfs2_log_ops[x]->lo_scan_elements) {
+			error = gfs2_log_ops[x]->lo_scan_elements(jd, start,
+								  ld, pass);
+			if (error)
+				return error;
+		}
+
+	return 0;
+}
+
+static inline void lops_after_scan(struct gfs2_jdesc *jd, int error,
+				   unsigned int pass)
+{
+	int x;
+	for (x = 0; gfs2_log_ops[x]; x++)
+		if (gfs2_log_ops[x]->lo_before_scan)
+			gfs2_log_ops[x]->lo_after_scan(jd, error, pass);
+}
+
+#endif /* __LOPS_DOT_H__ */
+
--- a/fs/gfs2/main.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/main.c	2005-09-01 17:36:55.367107568 +0800
@@ -0,0 +1,102 @@
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
+#include <linux/module.h>
+#include <linux/init.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "ops_fstype.h"
+#include "sys.h"
+
+/**
+ * init_gfs2_fs - Register GFS2 as a filesystem
+ *
+ * Returns: 0 on success, error code on failure
+ */
+
+static int __init init_gfs2_fs(void)
+{
+	int error;
+
+	error = gfs2_sys_init();
+	if (error)
+		return error;
+
+	error = -ENOMEM;
+
+	gfs2_glock_cachep = kmem_cache_create("gfs2_glock",
+					      sizeof(struct gfs2_glock),
+					      0, 0, NULL, NULL);
+	if (!gfs2_glock_cachep)
+		goto fail;
+
+	gfs2_inode_cachep = kmem_cache_create("gfs2_inode",
+					      sizeof(struct gfs2_inode),
+					      0, 0, NULL, NULL);
+	if (!gfs2_inode_cachep)
+		goto fail;
+
+	gfs2_bufdata_cachep = kmem_cache_create("gfs2_bufdata",
+						sizeof(struct gfs2_bufdata),
+					        0, 0, NULL, NULL);
+	if (!gfs2_bufdata_cachep)
+		goto fail;
+
+	error = register_filesystem(&gfs2_fs_type);
+	if (error)
+		goto fail;
+
+	printk("GFS2 (built %s %s) installed\n", __DATE__, __TIME__);
+
+	return 0;
+
+ fail:
+	if (gfs2_bufdata_cachep)
+		kmem_cache_destroy(gfs2_bufdata_cachep);
+
+	if (gfs2_inode_cachep)
+		kmem_cache_destroy(gfs2_inode_cachep);
+
+	if (gfs2_glock_cachep)
+		kmem_cache_destroy(gfs2_glock_cachep);
+
+	gfs2_sys_uninit();
+	return error;
+}
+
+/**
+ * exit_gfs2_fs - Unregister the file system
+ *
+ */
+
+static void __exit exit_gfs2_fs(void)
+{
+	unregister_filesystem(&gfs2_fs_type);
+
+	kmem_cache_destroy(gfs2_bufdata_cachep);
+	kmem_cache_destroy(gfs2_inode_cachep);
+	kmem_cache_destroy(gfs2_glock_cachep);
+
+	gfs2_sys_uninit();
+}
+
+MODULE_DESCRIPTION("Global File System");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+module_init(init_gfs2_fs);
+module_exit(exit_gfs2_fs);
+
--- a/fs/gfs2/meta_io.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/meta_io.c	2005-09-01 17:36:55.367107568 +0800
@@ -0,0 +1,884 @@
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
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/writeback.h>
+#include <linux/swap.h>
+#include <linux/delay.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "glock.h"
+#include "glops.h"
+#include "inode.h"
+#include "log.h"
+#include "lops.h"
+#include "meta_io.h"
+#include "rgrp.h"
+#include "trans.h"
+
+#define buffer_busy(bh) \
+((bh)->b_state & ((1ul << BH_Dirty) | (1ul << BH_Lock) | (1ul << BH_Pinned)))
+#define buffer_in_io(bh) \
+((bh)->b_state & ((1ul << BH_Dirty) | (1ul << BH_Lock)))
+
+static int aspace_get_block(struct inode *inode, sector_t lblock,
+			    struct buffer_head *bh_result, int create)
+{
+	gfs2_assert_warn(get_v2sdp(inode->i_sb), FALSE);
+	return -EOPNOTSUPP;
+}
+
+static int gfs2_aspace_writepage(struct page *page,
+				 struct writeback_control *wbc)
+{
+	return block_write_full_page(page, aspace_get_block, wbc);
+}
+
+/**
+ * stuck_releasepage - We're stuck in gfs2_releasepage().  Print stuff out.
+ * @bh: the buffer we're stuck on
+ *
+ */
+
+static void stuck_releasepage(struct buffer_head *bh)
+{
+	struct gfs2_sbd *sdp = get_v2sdp(bh->b_page->mapping->host->i_sb);
+	struct gfs2_bufdata *bd = get_v2bd(bh);
+	struct gfs2_glock *gl;
+
+	fs_warn(sdp, "stuck in gfs2_releasepage()\n");
+	fs_warn(sdp, "blkno = %"PRIu64", bh->b_count = %d\n",
+		(uint64_t)bh->b_blocknr, atomic_read(&bh->b_count));
+	fs_warn(sdp, "pinned = %u\n", buffer_pinned(bh));
+	fs_warn(sdp, "get_v2bd(bh) = %s\n", (bd) ? "!NULL" : "NULL");
+
+	if (!bd)
+		return;
+
+	gl = bd->bd_gl;
+
+	fs_warn(sdp, "gl = (%u, %"PRIu64")\n", 
+		gl->gl_name.ln_type, gl->gl_name.ln_number);
+
+	fs_warn(sdp, "bd_list_tr = %s, bd_le.le_list = %s\n",
+		(list_empty(&bd->bd_list_tr)) ? "no" : "yes",
+		(list_empty(&bd->bd_le.le_list)) ? "no" : "yes");
+
+	if (gl->gl_ops == &gfs2_inode_glops) {
+		struct gfs2_inode *ip = get_gl2ip(gl);
+		unsigned int x;
+
+		if (!ip)
+			return;
+
+		fs_warn(sdp, "ip = %"PRIu64"/%"PRIu64"\n",
+			ip->i_num.no_formal_ino, ip->i_num.no_addr);
+		fs_warn(sdp, "ip->i_count = %d, ip->i_vnode = %s\n",
+			atomic_read(&ip->i_count),
+			(ip->i_vnode) ? "!NULL" : "NULL");
+
+		for (x = 0; x < GFS2_MAX_META_HEIGHT; x++)
+			fs_warn(sdp, "ip->i_cache[%u] = %s\n",
+				x, (ip->i_cache[x]) ? "!NULL" : "NULL");
+	}
+}
+
+/**
+ * gfs2_aspace_releasepage - free the metadata associated with a page
+ * @page: the page that's being released
+ * @gfp_mask: passed from Linux VFS, ignored by us
+ *
+ * Call try_to_free_buffers() if the buffers in this page can be
+ * released.
+ *
+ * Returns: 0
+ */
+
+static int gfs2_aspace_releasepage(struct page *page, int gfp_mask)
+{
+	struct inode *aspace = page->mapping->host;
+	struct gfs2_sbd *sdp = get_v2sdp(aspace->i_sb);
+	struct buffer_head *bh, *head;
+	struct gfs2_bufdata *bd;
+	unsigned long t;
+
+	if (!page_has_buffers(page))
+		goto out;
+
+	head = bh = page_buffers(page);
+	do {
+		t = jiffies;
+
+		while (atomic_read(&bh->b_count)) {
+			if (atomic_read(&aspace->i_writecount)) {
+				if (time_after_eq(jiffies, t +
+				    gfs2_tune_get(sdp, gt_stall_secs) * HZ)) {
+					stuck_releasepage(bh);
+					t = jiffies;
+				}
+
+				yield();
+				continue;
+			}
+
+			return 0;
+		}
+
+		gfs2_assert_warn(sdp, !buffer_pinned(bh));
+
+		bd = get_v2bd(bh);
+		if (bd) {
+			gfs2_assert_warn(sdp, bd->bd_bh == bh);
+			gfs2_assert_warn(sdp, list_empty(&bd->bd_list_tr));
+			gfs2_assert_warn(sdp, list_empty(&bd->bd_le.le_list));
+			gfs2_assert_warn(sdp, !bd->bd_ail);
+			kmem_cache_free(gfs2_bufdata_cachep, bd);
+			atomic_dec(&sdp->sd_bufdata_count);
+			set_v2bd(bh, NULL);
+		}
+
+		bh = bh->b_this_page;
+	}
+	while (bh != head);
+
+ out:
+	return try_to_free_buffers(page);
+}
+
+static struct address_space_operations aspace_aops = {
+	.writepage = gfs2_aspace_writepage,
+	.releasepage = gfs2_aspace_releasepage,
+};
+
+/**
+ * gfs2_aspace_get - Create and initialize a struct inode structure
+ * @sdp: the filesystem the aspace is in
+ *
+ * Right now a struct inode is just a struct inode.  Maybe Linux
+ * will supply a more lightweight address space construct (that works)
+ * in the future.
+ *
+ * Make sure pages/buffers in this aspace aren't in high memory.
+ *
+ * Returns: the aspace
+ */
+
+struct inode *gfs2_aspace_get(struct gfs2_sbd *sdp)
+{
+	struct inode *aspace;
+
+	aspace = new_inode(sdp->sd_vfs);
+	if (aspace) {
+		mapping_set_gfp_mask(aspace->i_mapping, GFP_KERNEL);
+		aspace->i_mapping->a_ops = &aspace_aops;
+		aspace->i_size = ~0ULL;
+		set_v2ip(aspace, NULL);
+		insert_inode_hash(aspace);
+	}
+
+	return aspace;
+}
+
+void gfs2_aspace_put(struct inode *aspace)
+{
+	remove_inode_hash(aspace);
+	iput(aspace);
+}
+
+/**
+ * gfs2_ail1_start_one - Start I/O on a part of the AIL
+ * @sdp: the filesystem
+ * @tr: the part of the AIL
+ *
+ */
+
+void gfs2_ail1_start_one(struct gfs2_sbd *sdp, struct gfs2_ail *ai)
+{
+	struct list_head *head, *tmp, *prev;
+	struct gfs2_bufdata *bd;
+	struct buffer_head *bh;
+	int retry;
+
+	do {
+		retry = FALSE;
+
+		for (head = &ai->ai_ail1_list, tmp = head->prev, prev = tmp->prev;
+		     tmp != head;
+		     tmp = prev, prev = tmp->prev) {
+			bd = list_entry(tmp, struct gfs2_bufdata, bd_ail_st_list);
+			bh = bd->bd_bh;
+
+			gfs2_assert(sdp, bd->bd_ail == ai,);
+
+			if (!buffer_busy(bh)) {
+				if (!buffer_uptodate(bh))
+					gfs2_io_error_bh(sdp, bh);
+				list_move(&bd->bd_ail_st_list,
+					  &ai->ai_ail2_list);
+				continue;
+			}
+
+			if (!buffer_dirty(bh))
+				continue;
+
+			list_move(&bd->bd_ail_st_list, head);
+
+			gfs2_log_unlock(sdp);
+			wait_on_buffer(bh);
+			ll_rw_block(WRITE, 1, &bh);
+			gfs2_log_lock(sdp);
+
+			retry = TRUE;
+			break;
+		}
+	} while (retry);
+}
+
+/**
+ * gfs2_ail1_empty_one - Check whether or not a trans in the AIL has been synced
+ * @sdp: the filesystem
+ * @ai: the AIL entry
+ *
+ */
+
+int gfs2_ail1_empty_one(struct gfs2_sbd *sdp, struct gfs2_ail *ai, int flags)
+{
+	struct list_head *head, *tmp, *prev;
+	struct gfs2_bufdata *bd;
+	struct buffer_head *bh;
+
+	for (head = &ai->ai_ail1_list, tmp = head->prev, prev = tmp->prev;
+	     tmp != head;
+	     tmp = prev, prev = tmp->prev) {
+		bd = list_entry(tmp, struct gfs2_bufdata, bd_ail_st_list);
+		bh = bd->bd_bh;
+
+		gfs2_assert(sdp, bd->bd_ail == ai,);
+
+		if (buffer_busy(bh)) {
+			if (flags & DIO_ALL)
+				continue;
+			else
+				break;
+		}
+
+		if (!buffer_uptodate(bh))
+			gfs2_io_error_bh(sdp, bh);
+
+		list_move(&bd->bd_ail_st_list, &ai->ai_ail2_list);
+	}
+
+	return list_empty(head);
+}
+
+/**
+ * gfs2_ail2_empty_one - Check whether or not a trans in the AIL has been synced
+ * @sdp: the filesystem
+ * @ai: the AIL entry
+ *
+ */
+
+void gfs2_ail2_empty_one(struct gfs2_sbd *sdp, struct gfs2_ail *ai)
+{
+	struct list_head *head = &ai->ai_ail2_list;
+	struct gfs2_bufdata *bd;
+
+	while (!list_empty(head)) {
+		bd = list_entry(head->prev, struct gfs2_bufdata,
+				bd_ail_st_list);
+		gfs2_assert(sdp, bd->bd_ail == ai,);
+		bd->bd_ail = NULL;
+		list_del(&bd->bd_ail_st_list);
+		list_del(&bd->bd_ail_gl_list);
+		atomic_dec(&bd->bd_gl->gl_ail_count);
+		brelse(bd->bd_bh);
+	}
+}
+
+/**
+ * ail_empty_gl - remove all buffers for a given lock from the AIL
+ * @gl: the glock
+ *
+ * None of the buffers should be dirty, locked, or pinned.
+ */
+
+void gfs2_ail_empty_gl(struct gfs2_glock *gl)
+{
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+	unsigned int blocks;
+	struct list_head *head = &gl->gl_ail_list;
+	struct gfs2_bufdata *bd;
+	struct buffer_head *bh;
+	uint64_t blkno;
+	int error;
+
+	blocks = atomic_read(&gl->gl_ail_count);
+	if (!blocks)
+		return;
+
+	error = gfs2_trans_begin(sdp, 0, blocks);
+	if (gfs2_assert_withdraw(sdp, !error))
+		return;
+
+	gfs2_log_lock(sdp);
+	while (!list_empty(head)) {
+		bd = list_entry(head->next, struct gfs2_bufdata,
+				bd_ail_gl_list);
+		bh = bd->bd_bh;
+		blkno = bh->b_blocknr;
+		gfs2_assert_withdraw(sdp, !buffer_busy(bh));
+
+		bd->bd_ail = NULL;
+		list_del(&bd->bd_ail_st_list);
+		list_del(&bd->bd_ail_gl_list);
+		atomic_dec(&gl->gl_ail_count);
+		brelse(bh);
+		gfs2_log_unlock(sdp);
+
+		gfs2_trans_add_revoke(sdp, blkno);
+
+		gfs2_log_lock(sdp);
+	}
+	gfs2_assert_withdraw(sdp, !atomic_read(&gl->gl_ail_count));
+	gfs2_log_unlock(sdp);
+
+	gfs2_trans_end(sdp);
+	gfs2_log_flush(sdp);
+}
+
+/**
+ * gfs2_meta_inval - Invalidate all buffers associated with a glock
+ * @gl: the glock
+ *
+ */
+
+void gfs2_meta_inval(struct gfs2_glock *gl)
+{
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+	struct inode *aspace = gl->gl_aspace;
+	struct address_space *mapping = gl->gl_aspace->i_mapping;
+
+	gfs2_assert_withdraw(sdp, !atomic_read(&gl->gl_ail_count));
+
+	atomic_inc(&aspace->i_writecount);
+	truncate_inode_pages(mapping, 0);
+	atomic_dec(&aspace->i_writecount);
+
+	gfs2_assert_withdraw(sdp, !mapping->nrpages);
+}
+
+/**
+ * gfs2_meta_sync - Sync all buffers associated with a glock
+ * @gl: The glock
+ * @flags: DIO_START | DIO_WAIT
+ *
+ */
+
+void gfs2_meta_sync(struct gfs2_glock *gl, int flags)
+{
+	struct address_space *mapping = gl->gl_aspace->i_mapping;
+	int error = 0;
+
+	if (flags & DIO_START)
+		filemap_fdatawrite(mapping);
+	if (!error && (flags & DIO_WAIT))
+		error = filemap_fdatawait(mapping);
+
+	if (error)
+		gfs2_io_error(gl->gl_sbd);
+}
+
+/**
+ * getbuf - Get a buffer with a given address space
+ * @sdp: the filesystem
+ * @aspace: the address space
+ * @blkno: the block number (filesystem scope)
+ * @create: TRUE if the buffer should be created
+ *
+ * Returns: the buffer
+ */
+
+static struct buffer_head *getbuf(struct gfs2_sbd *sdp, struct inode *aspace,
+				  uint64_t blkno, int create)
+{
+	struct page *page;
+	struct buffer_head *bh;
+	unsigned int shift;
+	unsigned long index;
+	unsigned int bufnum;
+
+	shift = PAGE_CACHE_SHIFT - sdp->sd_sb.sb_bsize_shift;
+	index = blkno >> shift;             /* convert block to page */
+	bufnum = blkno - (index << shift);  /* block buf index within page */
+
+	if (create) {
+		for (;;) {
+			page = grab_cache_page(aspace->i_mapping, index);
+			if (page)
+				break;
+			yield();
+		}
+	} else {
+		page = find_lock_page(aspace->i_mapping, index);
+		if (!page)
+			return NULL;
+	}
+
+	if (!page_has_buffers(page))
+		create_empty_buffers(page, sdp->sd_sb.sb_bsize, 0);
+
+	/* Locate header for our buffer within our page */
+	for (bh = page_buffers(page); bufnum--; bh = bh->b_this_page)
+		/* Do nothing */;
+	get_bh(bh);
+
+	if (!buffer_mapped(bh))
+		map_bh(bh, sdp->sd_vfs, blkno);
+
+	unlock_page(page);
+	mark_page_accessed(page);
+	page_cache_release(page);
+
+	return bh;
+}
+
+static void meta_prep_new(struct buffer_head *bh)
+{
+	struct gfs2_meta_header *mh = (struct gfs2_meta_header *)bh->b_data;
+
+	lock_buffer(bh);
+	clear_buffer_dirty(bh);
+	set_buffer_uptodate(bh);
+	unlock_buffer(bh);
+
+	mh->mh_magic = cpu_to_gfs2_32(GFS2_MAGIC);
+	mh->mh_blkno = cpu_to_gfs2_64(bh->b_blocknr);
+}
+
+/**
+ * gfs2_meta_new - Get a block
+ * @gl: The glock associated with this block
+ * @blkno: The block number
+ *
+ * Returns: The buffer
+ */
+
+struct buffer_head *gfs2_meta_new(struct gfs2_glock *gl, uint64_t blkno)
+{
+	struct buffer_head *bh;
+	bh = getbuf(gl->gl_sbd, gl->gl_aspace, blkno, CREATE);
+	meta_prep_new(bh);
+	return bh;
+}
+
+/**
+ * gfs2_meta_read - Read a block from disk
+ * @gl: The glock covering the block
+ * @blkno: The block number
+ * @flags: flags to gfs2_dreread()
+ * @bhp: the place where the buffer is returned (NULL on failure)
+ *
+ * Returns: errno
+ */
+
+int gfs2_meta_read(struct gfs2_glock *gl, uint64_t blkno, int flags,
+		   struct buffer_head **bhp)
+{
+	int error;
+
+	*bhp = getbuf(gl->gl_sbd, gl->gl_aspace, blkno, CREATE);
+	error = gfs2_meta_reread(gl->gl_sbd, *bhp, flags);
+	if (error)
+		brelse(*bhp);
+
+	return error;
+}
+
+/**
+ * gfs2_meta_reread - Reread a block from disk
+ * @sdp: the filesystem
+ * @bh: The block to read
+ * @flags: Flags that control the read
+ *
+ * Returns: errno
+ */
+
+int gfs2_meta_reread(struct gfs2_sbd *sdp, struct buffer_head *bh, int flags)
+{
+	if (unlikely(test_bit(SDF_SHUTDOWN, &sdp->sd_flags)))
+		return -EIO;
+
+	if (flags & DIO_FORCE)
+		clear_buffer_uptodate(bh);
+
+	if ((flags & DIO_START) && !buffer_uptodate(bh))
+		ll_rw_block(READ, 1, &bh);
+
+	if (flags & DIO_WAIT) {
+		wait_on_buffer(bh);
+
+		if (!buffer_uptodate(bh)) {
+			struct gfs2_trans *tr = get_transaction;
+			if (tr && tr->tr_touched)
+				gfs2_io_error_bh(sdp, bh);
+			return -EIO;
+		}
+		if (unlikely(test_bit(SDF_SHUTDOWN, &sdp->sd_flags)))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * gfs2_meta_attach_bufdata - attach a struct gfs2_bufdata structure to a buffer
+ * @gl: the glock the buffer belongs to
+ * @bh: The buffer to be attached to
+ *
+ */
+
+void gfs2_meta_attach_bufdata(struct gfs2_glock *gl, struct buffer_head *bh)
+{
+	struct gfs2_bufdata *bd;
+
+	lock_page(bh->b_page);
+
+	if (get_v2bd(bh)) {
+		unlock_page(bh->b_page);
+		return;
+	}
+
+	bd = kmem_cache_alloc(gfs2_bufdata_cachep, GFP_KERNEL | __GFP_NOFAIL),
+	atomic_inc(&gl->gl_sbd->sd_bufdata_count);
+
+	memset(bd, 0, sizeof(struct gfs2_bufdata));
+
+	bd->bd_bh = bh;
+	bd->bd_gl = gl;
+
+	INIT_LIST_HEAD(&bd->bd_list_tr);
+	lops_init_le(&bd->bd_le, &gfs2_buf_lops);
+
+	set_v2bd(bh, bd);
+
+	unlock_page(bh->b_page);
+}
+
+/**
+ * gfs2_meta_pin - Pin a metadata buffer in memory
+ * @sdp: the filesystem the buffer belongs to
+ * @bh: The buffer to be pinned
+ *
+ */
+
+void gfs2_meta_pin(struct gfs2_sbd *sdp, struct buffer_head *bh)
+{
+	struct gfs2_bufdata *bd = get_v2bd(bh);
+
+	gfs2_assert_withdraw(sdp, test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));
+
+	if (test_set_buffer_pinned(bh))
+		gfs2_assert_withdraw(sdp, FALSE);
+
+	wait_on_buffer(bh);
+
+	/* If this buffer is in the AIL and it has already been written
+	   to in-place disk block, remove it from the AIL. */
+
+	gfs2_log_lock(sdp);
+	if (bd->bd_ail && !buffer_in_io(bh))
+		list_move(&bd->bd_ail_st_list, &bd->bd_ail->ai_ail2_list);
+	gfs2_log_unlock(sdp);
+
+	clear_buffer_dirty(bh);
+	wait_on_buffer(bh);
+
+	if (!buffer_uptodate(bh))
+		gfs2_io_error_bh(sdp, bh);
+
+	get_bh(bh);
+}
+
+/**
+ * gfs2_meta_unpin - Unpin a buffer
+ * @sdp: the filesystem the buffer belongs to
+ * @bh: The buffer to unpin
+ * @ai:
+ *
+ */
+
+void gfs2_meta_unpin(struct gfs2_sbd *sdp, struct buffer_head *bh,
+		     struct gfs2_ail *ai)
+{
+	struct gfs2_bufdata *bd = get_v2bd(bh);
+
+	gfs2_assert_withdraw(sdp, buffer_uptodate(bh));
+
+	if (!buffer_pinned(bh))
+		gfs2_assert_withdraw(sdp, FALSE);
+
+	mark_buffer_dirty(bh);
+	clear_buffer_pinned(bh);
+
+	gfs2_log_lock(sdp);
+	if (bd->bd_ail) {
+		list_del(&bd->bd_ail_st_list);
+		brelse(bh);
+	} else {
+		struct gfs2_glock *gl = bd->bd_gl;
+		list_add(&bd->bd_ail_gl_list, &gl->gl_ail_list);
+		atomic_inc(&gl->gl_ail_count);
+	}
+	bd->bd_ail = ai;
+	list_add(&bd->bd_ail_st_list, &ai->ai_ail1_list);
+	gfs2_log_unlock(sdp);
+}
+
+/**
+ * gfs2_meta_wipe - make inode's buffers so they aren't dirty/pinned anymore
+ * @ip: the inode who owns the buffers
+ * @bstart: the first buffer in the run
+ * @blen: the number of buffers in the run
+ *
+ */
+
+void gfs2_meta_wipe(struct gfs2_inode *ip, uint64_t bstart, uint32_t blen)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct inode *aspace = ip->i_gl->gl_aspace;
+	struct buffer_head *bh;
+
+	while (blen) {
+		bh = getbuf(sdp, aspace, bstart, NO_CREATE);
+		if (bh) {
+			struct gfs2_bufdata *bd = get_v2bd(bh);
+
+			if (test_clear_buffer_pinned(bh)) {
+				gfs2_log_lock(sdp);
+				list_del_init(&bd->bd_le.le_list);
+				gfs2_assert_warn(sdp, sdp->sd_log_num_buf);
+				sdp->sd_log_num_buf--;
+				gfs2_log_unlock(sdp);
+				get_transaction->tr_num_buf_rm++;
+				brelse(bh);
+			}
+			if (bd) {
+				gfs2_log_lock(sdp);
+				if (bd->bd_ail) {
+					uint64_t blkno = bh->b_blocknr;
+					bd->bd_ail = NULL;
+					list_del(&bd->bd_ail_st_list);
+					list_del(&bd->bd_ail_gl_list);
+					atomic_dec(&bd->bd_gl->gl_ail_count);
+					brelse(bh);
+					gfs2_log_unlock(sdp);
+					gfs2_trans_add_revoke(sdp, blkno);
+				} else
+					gfs2_log_unlock(sdp);
+			}
+
+			lock_buffer(bh);
+			clear_buffer_dirty(bh);
+			clear_buffer_uptodate(bh);
+			unlock_buffer(bh);
+
+			brelse(bh);
+		}
+
+		bstart++;
+		blen--;
+	}
+}
+
+/**
+ * gfs2_meta_cache_flush - get rid of any references on buffers for this inode
+ * @ip: The GFS2 inode
+ *
+ * This releases buffers that are in the most-recently-used array of
+ * blocks used for indirect block addressing for this inode.
+ */
+
+void gfs2_meta_cache_flush(struct gfs2_inode *ip)
+{
+	struct buffer_head **bh_slot;
+	unsigned int x;
+
+	spin_lock(&ip->i_spin);
+
+	for (x = 0; x < GFS2_MAX_META_HEIGHT; x++) {
+		bh_slot = &ip->i_cache[x];
+		if (!*bh_slot)
+			break;
+		brelse(*bh_slot);
+		*bh_slot = NULL;
+	}
+
+	spin_unlock(&ip->i_spin);
+}
+
+/**
+ * gfs2_meta_indirect_buffer - Get a metadata buffer
+ * @ip: The GFS2 inode
+ * @height: The level of this buf in the metadata (indir addr) tree (if any)
+ * @num: The block number (device relative) of the buffer
+ * @new: Non-zero if we may create a new buffer
+ * @bhp: the buffer is returned here
+ *
+ * Try to use the gfs2_inode's MRU metadata tree cache.
+ *
+ * Returns: errno
+ */
+
+int gfs2_meta_indirect_buffer(struct gfs2_inode *ip, int height, uint64_t num,
+			      int new, struct buffer_head **bhp)
+{
+	struct buffer_head *bh, **bh_slot = ip->i_cache + height;
+	int error;
+
+	spin_lock(&ip->i_spin);
+	bh = *bh_slot;
+	if (bh) {
+		if (bh->b_blocknr == num)
+			get_bh(bh);
+		else
+			bh = NULL;
+	}
+	spin_unlock(&ip->i_spin);
+
+	if (bh) {
+		if (new)
+			meta_prep_new(bh);
+		else {
+			error = gfs2_meta_reread(ip->i_sbd, bh,
+						 DIO_START | DIO_WAIT);
+			if (error) {
+				brelse(bh);
+				return error;
+			}
+		}
+	} else {
+		if (new)
+			bh = gfs2_meta_new(ip->i_gl, num);
+		else {
+			error = gfs2_meta_read(ip->i_gl, num,
+					       DIO_START | DIO_WAIT, &bh);
+			if (error)
+				return error;
+		}
+
+		spin_lock(&ip->i_spin);
+		if (*bh_slot != bh) {
+			brelse(*bh_slot);
+			*bh_slot = bh;
+			get_bh(bh);
+		}
+		spin_unlock(&ip->i_spin);
+	}
+
+	if (new) {
+		if (gfs2_assert_warn(ip->i_sbd, height)) {
+			brelse(bh);
+			return -EIO;
+		}
+		gfs2_trans_add_bh(ip->i_gl, bh);
+		gfs2_metatype_set(bh, GFS2_METATYPE_IN, GFS2_FORMAT_IN);
+		gfs2_buffer_clear_tail(bh, sizeof(struct gfs2_meta_header));
+
+	} else if (gfs2_metatype_check(ip->i_sbd, bh,
+			     (height) ? GFS2_METATYPE_IN : GFS2_METATYPE_DI)) {
+		brelse(bh);
+		return -EIO;
+	}
+
+	*bhp = bh;
+
+	return 0;
+}
+
+/**
+ * gfs2_meta_ra - start readahead on an extent of a file
+ * @gl: the glock the blocks belong to
+ * @dblock: the starting disk block
+ * @extlen: the number of blocks in the extent
+ *
+ */
+
+void gfs2_meta_ra(struct gfs2_glock *gl, uint64_t dblock, uint32_t extlen)
+{
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+	struct inode *aspace = gl->gl_aspace;
+	struct buffer_head *first_bh, *bh;
+	uint32_t max_ra = gfs2_tune_get(sdp, gt_max_readahead) >> sdp->sd_sb.sb_bsize_shift;
+	int error;
+
+	if (!extlen || !max_ra)
+		return;
+	if (extlen > max_ra)
+		extlen = max_ra;
+
+	first_bh = getbuf(sdp, aspace, dblock, CREATE);
+
+	if (buffer_uptodate(first_bh))
+		goto out;
+	if (!buffer_locked(first_bh)) {
+		error = gfs2_meta_reread(sdp, first_bh, DIO_START);
+		if (error)
+			goto out;
+	}
+
+	dblock++;
+	extlen--;
+
+	while (extlen) {
+		bh = getbuf(sdp, aspace, dblock, CREATE);
+
+		if (!buffer_uptodate(bh) && !buffer_locked(bh)) {
+			error = gfs2_meta_reread(sdp, bh, DIO_START);
+			brelse(bh);
+			if (error)
+				goto out;
+		} else
+			brelse(bh);
+
+		dblock++;
+		extlen--;
+
+		if (buffer_uptodate(first_bh))
+			break;
+	}
+
+ out:
+	brelse(first_bh);
+}
+
+/**
+ * gfs2_meta_syncfs - sync all the buffers in a filesystem
+ * @sdp: the filesystem
+ *
+ */
+
+void gfs2_meta_syncfs(struct gfs2_sbd *sdp)
+{
+	gfs2_log_flush(sdp);
+	for (;;) {
+		gfs2_ail1_start(sdp, DIO_ALL);
+		if (gfs2_ail1_empty(sdp, DIO_ALL))
+			break;
+		msleep(100);
+	}
+}
+
--- a/fs/gfs2/meta_io.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/meta_io.h	2005-09-01 17:36:55.368107416 +0800
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __DIO_DOT_H__
+#define __DIO_DOT_H__
+
+static inline void gfs2_buffer_clear(struct buffer_head *bh)
+{
+	memset(bh->b_data, 0, bh->b_size);
+}
+
+static inline void gfs2_buffer_clear_tail(struct buffer_head *bh, int head)
+{
+	memset(bh->b_data + head, 0, bh->b_size - head);
+}
+
+static inline void gfs2_buffer_clear_ends(struct buffer_head *bh, int offset,
+					  int amount, int journaled)
+{
+	int z_off1 = (journaled) ? sizeof(struct gfs2_meta_header) : 0;
+	int z_len1 = offset - z_off1;
+	int z_off2 = offset + amount;
+	int z_len2 = (bh)->b_size - z_off2;
+
+	if (z_len1)
+		memset(bh->b_data + z_off1, 0, z_len1);
+
+	if (z_len2)
+		memset(bh->b_data + z_off2, 0, z_len2);
+}
+
+static inline void gfs2_buffer_copy_tail(struct buffer_head *to_bh,
+					 int to_head,
+					 struct buffer_head *from_bh,
+					 int from_head)
+{
+	memcpy(to_bh->b_data + to_head,
+	       from_bh->b_data + from_head,
+	       from_bh->b_size - from_head);
+	memset(to_bh->b_data + to_bh->b_size + to_head - from_head,
+	       0,
+	       from_head - to_head);
+}
+
+struct inode *gfs2_aspace_get(struct gfs2_sbd *sdp);
+void gfs2_aspace_put(struct inode *aspace);
+
+void gfs2_ail1_start_one(struct gfs2_sbd *sdp, struct gfs2_ail *ai);
+int gfs2_ail1_empty_one(struct gfs2_sbd *sdp, struct gfs2_ail *ai, int flags);
+void gfs2_ail2_empty_one(struct gfs2_sbd *sdp, struct gfs2_ail *ai);
+void gfs2_ail_empty_gl(struct gfs2_glock *gl);
+
+void gfs2_meta_inval(struct gfs2_glock *gl);
+void gfs2_meta_sync(struct gfs2_glock *gl, int flags);
+
+struct buffer_head *gfs2_meta_new(struct gfs2_glock *gl, uint64_t blkno);
+int gfs2_meta_read(struct gfs2_glock *gl, uint64_t blkno,
+		   int flags, struct buffer_head **bhp);
+int gfs2_meta_reread(struct gfs2_sbd *sdp, struct buffer_head *bh, int flags);
+
+void gfs2_meta_attach_bufdata(struct gfs2_glock *gl, struct buffer_head *bh);
+void gfs2_meta_pin(struct gfs2_sbd *sdp, struct buffer_head *bh);
+void gfs2_meta_unpin(struct gfs2_sbd *sdp, struct buffer_head *bh,
+		 struct gfs2_ail *ai);
+
+void gfs2_meta_wipe(struct gfs2_inode *ip, uint64_t bstart, uint32_t blen);
+
+void gfs2_meta_cache_flush(struct gfs2_inode *ip);
+int gfs2_meta_indirect_buffer(struct gfs2_inode *ip, int height, uint64_t num,
+			      int new, struct buffer_head **bhp);
+
+static inline int gfs2_meta_inode_buffer(struct gfs2_inode *ip,
+					 struct buffer_head **bhp)
+{
+	return gfs2_meta_indirect_buffer(ip, 0, ip->i_num.no_addr, FALSE, bhp);
+}
+
+void gfs2_meta_ra(struct gfs2_glock *gl, uint64_t dblock, uint32_t extlen);
+void gfs2_meta_syncfs(struct gfs2_sbd *sdp);
+
+#endif /* __DIO_DOT_H__ */
+
--- a/fs/gfs2/ondisk.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ondisk.c	2005-09-01 17:36:55.391103920 +0800
@@ -0,0 +1,28 @@
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
+
+#define pv(struct, member, fmt) printk("  "#member" = "fmt"\n", struct->member);
+
+#define WANT_GFS2_CONVERSION_FUNCTIONS
+#include <linux/gfs2_ondisk.h>
+
+#ifdef GFS2_ENDIAN_BIG
+#warning Big endian is set.
+#endif
+
--- a/fs/gfs2/ops_address.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_address.c	2005-09-01 17:36:55.392103768 +0800
@@ -0,0 +1,516 @@
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
+#include <linux/pagemap.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "bmap.h"
+#include "glock.h"
+#include "inode.h"
+#include "jdata.h"
+#include "log.h"
+#include "meta_io.h"
+#include "ops_address.h"
+#include "page.h"
+#include "quota.h"
+#include "trans.h"
+
+/**
+ * get_block - Fills in a buffer head with details about a block
+ * @inode: The inode
+ * @lblock: The block number to look up
+ * @bh_result: The buffer head to return the result in
+ * @create: Non-zero if we may add block to the file
+ *
+ * Returns: errno
+ */
+
+static int get_block(struct inode *inode, sector_t lblock,
+		     struct buffer_head *bh_result, int create)
+{
+	struct gfs2_inode *ip = get_v2ip(inode);
+	int new = create;
+	uint64_t dblock;
+	int error;
+
+	error = gfs2_block_map(ip, lblock, &new, &dblock, NULL);
+	if (error)
+		return error;
+
+	if (!dblock)
+		return 0;
+
+	map_bh(bh_result, inode->i_sb, dblock);
+	if (new)
+		set_buffer_new(bh_result);
+
+	return 0;
+}
+
+/**
+ * get_block_noalloc - Fills in a buffer head with details about a block
+ * @inode: The inode
+ * @lblock: The block number to look up
+ * @bh_result: The buffer head to return the result in
+ * @create: Non-zero if we may add block to the file
+ *
+ * Returns: errno
+ */
+
+static int get_block_noalloc(struct inode *inode, sector_t lblock,
+			     struct buffer_head *bh_result, int create)
+{
+	struct gfs2_inode *ip = get_v2ip(inode);
+	int new = FALSE;
+	uint64_t dblock;
+	int error;
+
+	error = gfs2_block_map(ip, lblock, &new, &dblock, NULL);
+	if (error)
+		return error;
+
+	if (dblock)
+		map_bh(bh_result, inode->i_sb, dblock);
+	else if (gfs2_assert_withdraw(ip->i_sbd, !create))
+		error = -EIO;
+
+	return error;
+}
+
+static int get_blocks(struct inode *inode, sector_t lblock,
+		      unsigned long max_blocks, struct buffer_head *bh_result,
+		      int create)
+{
+	struct gfs2_inode *ip = get_v2ip(inode);
+	int new = create;
+	uint64_t dblock;
+	uint32_t extlen;
+	int error;
+
+	error = gfs2_block_map(ip, lblock, &new, &dblock, &extlen);
+	if (error)
+		return error;
+
+	if (!dblock)
+		return 0;
+
+	map_bh(bh_result, inode->i_sb, dblock);
+	if (new)
+		set_buffer_new(bh_result);
+
+	if (extlen > max_blocks)
+		extlen = max_blocks;
+	bh_result->b_size = extlen << inode->i_blkbits;
+
+	return 0;
+}
+
+static int get_blocks_noalloc(struct inode *inode, sector_t lblock,
+			      unsigned long max_blocks,
+			      struct buffer_head *bh_result, int create)
+{
+	struct gfs2_inode *ip = get_v2ip(inode);
+	int new = FALSE;
+	uint64_t dblock;
+	uint32_t extlen;
+	int error;
+
+	error = gfs2_block_map(ip, lblock, &new, &dblock, &extlen);
+	if (error)
+		return error;
+
+	if (dblock) {
+		map_bh(bh_result, inode->i_sb, dblock);
+		if (extlen > max_blocks)
+			extlen = max_blocks;
+		bh_result->b_size = extlen << inode->i_blkbits;
+	} else if (gfs2_assert_withdraw(ip->i_sbd, !create))
+		error = -EIO;
+
+	return error;
+}
+
+/**
+ * gfs2_writepage - Write complete page
+ * @page: Page to write
+ *
+ * Returns: errno
+ *
+ * Use Linux VFS block_write_full_page() to write one page,
+ *   using GFS2's get_block_noalloc to find which blocks to write.
+ */
+
+static int gfs2_writepage(struct page *page, struct writeback_control *wbc)
+{
+	struct gfs2_inode *ip = get_v2ip(page->mapping->host);
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	int error;
+
+	atomic_inc(&sdp->sd_ops_address);
+
+	if (gfs2_assert_withdraw(sdp, gfs2_glock_is_held_excl(ip->i_gl))) {
+		unlock_page(page);
+		return -EIO;
+	}
+	if (get_transaction) {
+		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
+		return 0;
+	}
+
+	error = block_write_full_page(page, get_block_noalloc, wbc);
+
+	gfs2_meta_cache_flush(ip);
+
+	return error;
+}
+
+/**
+ * stuffed_readpage - Fill in a Linux page with stuffed file data
+ * @ip: the inode
+ * @page: the page
+ *
+ * Returns: errno
+ */
+
+static int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
+{
+	struct buffer_head *dibh;
+	void *kaddr;
+	int error;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		return error;
+
+	kaddr = kmap(page);
+	memcpy((char *)kaddr,
+	       dibh->b_data + sizeof(struct gfs2_dinode),
+	       ip->i_di.di_size);
+	memset((char *)kaddr + ip->i_di.di_size,
+	       0,
+	       PAGE_CACHE_SIZE - ip->i_di.di_size);
+	kunmap(page);
+
+	brelse(dibh);
+
+	SetPageUptodate(page);
+
+	return 0;
+}
+
+static int zero_readpage(struct page *page)
+{
+	void *kaddr;
+
+	kaddr = kmap(page);
+	memset(kaddr, 0, PAGE_CACHE_SIZE);
+	kunmap(page);
+
+	SetPageUptodate(page);
+	unlock_page(page);
+
+	return 0;
+}
+
+/**
+ * jdata_readpage - readpage that goes through gfs2_jdata_read_mem()
+ * @ip:
+ * @page: The page to read
+ *
+ * Returns: errno
+ */
+
+static int jdata_readpage(struct gfs2_inode *ip, struct page *page)
+{
+	void *kaddr;
+	int ret;
+
+	kaddr = kmap(page);
+
+	ret = gfs2_jdata_read_mem(ip, kaddr,
+				  (uint64_t)page->index << PAGE_CACHE_SHIFT,
+				  PAGE_CACHE_SIZE);
+	if (ret >= 0) {
+		if (ret < PAGE_CACHE_SIZE)
+			memset(kaddr + ret, 0, PAGE_CACHE_SIZE - ret);
+		SetPageUptodate(page);
+		ret = 0;
+	}
+
+	kunmap(page);
+
+	unlock_page(page);
+
+	return ret;
+}
+
+/**
+ * gfs2_readpage - readpage with locking
+ * @file: The file to read a page for
+ * @page: The page to read
+ *
+ * Returns: errno
+ */
+
+static int gfs2_readpage(struct file *file, struct page *page)
+{
+	struct gfs2_inode *ip = get_v2ip(page->mapping->host);
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	int error;
+
+	atomic_inc(&sdp->sd_ops_address);
+
+	if (gfs2_assert_warn(sdp, gfs2_glock_is_locked_by_me(ip->i_gl))) {
+		unlock_page(page);
+		return -EOPNOTSUPP;
+	}
+
+	if (!gfs2_is_jdata(ip)) {
+		if (gfs2_is_stuffed(ip)) {
+			if (!page->index) {
+				error = stuffed_readpage(ip, page);
+				unlock_page(page);
+			} else
+				error = zero_readpage(page);
+		} else
+			error = block_read_full_page(page, get_block);
+	} else
+		error = jdata_readpage(ip, page);
+
+	if (unlikely(test_bit(SDF_SHUTDOWN, &sdp->sd_flags)))
+		error = -EIO;
+
+	return error;
+}
+
+/**
+ * gfs2_prepare_write - Prepare to write a page to a file
+ * @file: The file to write to
+ * @page: The page which is to be prepared for writing
+ * @from: From (byte range within page)
+ * @to: To (byte range within page)
+ *
+ * Returns: errno
+ */
+
+static int gfs2_prepare_write(struct file *file, struct page *page,
+			      unsigned from, unsigned to)
+{
+	struct gfs2_inode *ip = get_v2ip(page->mapping->host);
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	int error = 0;
+
+	atomic_inc(&sdp->sd_ops_address);
+
+	if (gfs2_assert_warn(sdp, gfs2_glock_is_locked_by_me(ip->i_gl)))
+		return -EOPNOTSUPP;
+
+	if (gfs2_is_stuffed(ip)) {
+		uint64_t file_size;
+		file_size = ((uint64_t)page->index << PAGE_CACHE_SHIFT) + to;
+
+		if (file_size > sdp->sd_sb.sb_bsize -
+				sizeof(struct gfs2_dinode)) {
+			error = gfs2_unstuff_dinode(ip, gfs2_unstuffer_page,
+						    page);
+			if (!error)
+				error = block_prepare_write(page, from, to,
+							    get_block);
+		} else if (!PageUptodate(page))
+			error = stuffed_readpage(ip, page);
+	} else
+		error = block_prepare_write(page, from, to, get_block);
+
+	return error;
+}
+
+/**
+ * gfs2_commit_write - Commit write to a file
+ * @file: The file to write to
+ * @page: The page containing the data
+ * @from: From (byte range within page)
+ * @to: To (byte range within page)
+ *
+ * Returns: errno
+ */
+
+static int gfs2_commit_write(struct file *file, struct page *page,
+			     unsigned from, unsigned to)
+{
+	struct inode *inode = page->mapping->host;
+	struct gfs2_inode *ip = get_v2ip(inode);
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	int error;
+
+	atomic_inc(&sdp->sd_ops_address);
+
+	if (gfs2_is_stuffed(ip)) {
+		struct buffer_head *dibh;
+		uint64_t file_size;
+		void *kaddr;
+
+		file_size = ((uint64_t)page->index << PAGE_CACHE_SHIFT) + to;
+
+		error = gfs2_meta_inode_buffer(ip, &dibh);
+		if (error)
+			goto fail;
+
+		gfs2_trans_add_bh(ip->i_gl, dibh);
+
+		kaddr = kmap(page);
+		memcpy(dibh->b_data + sizeof(struct gfs2_dinode) + from,
+		       (char *)kaddr + from,
+		       to - from);
+		kunmap(page);
+
+		brelse(dibh);
+
+		SetPageUptodate(page);
+
+		if (inode->i_size < file_size)
+			i_size_write(inode, file_size);
+	} else {
+		if (sdp->sd_args.ar_data == GFS2_DATA_ORDERED)
+			gfs2_page_add_databufs(sdp, page, from, to);
+		error = generic_commit_write(file, page, from, to);
+		if (error)
+			goto fail;
+	}
+
+	return 0;
+
+ fail:
+	ClearPageUptodate(page);
+
+	return error;
+}
+
+/**
+ * gfs2_bmap - Block map function
+ * @mapping: Address space info
+ * @lblock: The block to map
+ *
+ * Returns: The disk address for the block or 0 on hole or error
+ */
+
+static sector_t gfs2_bmap(struct address_space *mapping, sector_t lblock)
+{
+	struct gfs2_inode *ip = get_v2ip(mapping->host);
+	struct gfs2_holder i_gh;
+	sector_t dblock = 0;
+	int error;
+
+	atomic_inc(&ip->i_sbd->sd_ops_address);
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
+	if (error)
+		return 0;
+
+	if (!gfs2_is_stuffed(ip))
+		dblock = generic_block_bmap(mapping, lblock, get_block);
+
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return dblock;
+}
+
+static void discard_buffer(struct gfs2_sbd *sdp, struct buffer_head *bh)
+{
+	struct gfs2_databuf *db;
+
+	gfs2_log_lock(sdp);
+	db = get_v2db(bh);
+	if (db) {
+		db->db_bh = NULL;
+		set_v2db(bh, NULL);
+		gfs2_log_unlock(sdp);
+		brelse(bh);
+	} else
+		gfs2_log_unlock(sdp);
+
+	lock_buffer(bh);
+	clear_buffer_dirty(bh);
+	bh->b_bdev = NULL;
+	clear_buffer_mapped(bh);
+	clear_buffer_req(bh);
+	clear_buffer_new(bh);
+	clear_buffer_delay(bh);
+	unlock_buffer(bh);
+}
+
+static int gfs2_invalidatepage(struct page *page, unsigned long offset)
+{
+	struct gfs2_sbd *sdp = get_v2sdp(page->mapping->host->i_sb);
+	struct buffer_head *head, *bh, *next;
+	unsigned int curr_off = 0;
+	int ret = 1;
+
+	BUG_ON(!PageLocked(page));
+	if (!page_has_buffers(page))
+		return 1;
+
+	bh = head = page_buffers(page);
+	do {
+		unsigned int next_off = curr_off + bh->b_size;
+		next = bh->b_this_page;
+
+		if (offset <= curr_off)
+			discard_buffer(sdp, bh);
+
+		curr_off = next_off;
+		bh = next;
+	} while (bh != head);
+
+	if (!offset)
+		ret = try_to_release_page(page, 0);
+
+	return ret;
+}
+
+static int gfs2_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
+			  loff_t offset, unsigned long nr_segs)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	struct gfs2_inode *ip = get_v2ip(inode);
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	get_blocks_t *gb = get_blocks;
+
+	atomic_inc(&sdp->sd_ops_address);
+
+	if (gfs2_assert_warn(sdp, gfs2_glock_is_locked_by_me(ip->i_gl)) ||
+	    gfs2_assert_warn(sdp, !gfs2_is_stuffed(ip)))
+		return -EINVAL;
+
+	if (rw == WRITE && !get_transaction)
+		gb = get_blocks_noalloc;
+
+	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
+				  offset, nr_segs, gb, NULL);
+}
+
+struct address_space_operations gfs2_file_aops = {
+	.writepage = gfs2_writepage,
+	.readpage = gfs2_readpage,
+	.sync_page = block_sync_page,
+	.prepare_write = gfs2_prepare_write,
+	.commit_write = gfs2_commit_write,
+	.bmap = gfs2_bmap,
+	.invalidatepage = gfs2_invalidatepage,
+	.direct_IO = gfs2_direct_IO,
+};
+
--- a/fs/gfs2/ops_address.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_address.h	2005-09-01 17:36:55.392103768 +0800
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __OPS_ADDRESS_DOT_H__
+#define __OPS_ADDRESS_DOT_H__
+
+extern struct address_space_operations gfs2_file_aops;
+
+#endif /* __OPS_ADDRESS_DOT_H__ */
