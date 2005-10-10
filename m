Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVJJRPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVJJRPF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVJJRPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:15:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58036 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750992AbVJJRLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:11:02 -0400
Date: Mon, 10 Oct 2005 12:10:52 -0500
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/16] GFS: mount and tuning options
Message-ID: <20051010171052.GL22483@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a variety of mount options, tunable parameters, internal
statistics, and methods of online file system manipulation.

Signed-off-by: Ken Preslan <ken@preslan.org>
Signed-off-by: David Teigland <teigland@redhat.com>

---

 fs/gfs2/ioctl.c  |  808 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/ioctl.h  |   15 +
 fs/gfs2/mount.c  |  211 ++++++++++++++
 fs/gfs2/mount.h  |   15 +
 fs/gfs2/resize.c |  284 +++++++++++++++++++
 fs/gfs2/resize.h |   19 +
 fs/gfs2/sys.c    |  617 +++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/sys.h    |   24 +
 8 files changed, 1993 insertions(+)

--- a/fs/gfs2/ioctl.c	1969-12-31 17:00:00.000000000 -0700
+++ b/fs/gfs2/ioctl.c	2005-10-10 11:28:49.218799108 -0500
@@ -0,0 +1,808 @@
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
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/gfs2_ioctl.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include "gfs2.h"
+#include "bmap.h"
+#include "dir.h"
+#include "eattr.h"
+#include "glock.h"
+#include "glops.h"
+#include "inode.h"
+#include "ioctl.h"
+#include "jdata.h"
+#include "log.h"
+#include "meta_io.h"
+#include "quota.h"
+#include "resize.h"
+#include "rgrp.h"
+#include "super.h"
+#include "trans.h"
+
+#define ARG_SIZE 32
+
+/**
+ * gi_get_super - Return the "struct gfs2_sb" for a filesystem
+ * @sdp:
+ * @gi:
+ *
+ * Returns: errno
+ */
+
+static int gi_get_super(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	struct gfs2_holder sb_gh;
+	struct buffer_head *bh;
+	struct gfs2_sb *sb;
+	int error;
+
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+	if (gi->gi_size != sizeof(struct gfs2_sb))
+		return -EINVAL;
+
+	sb = kmalloc(sizeof(struct gfs2_sb), GFP_KERNEL);
+	if (!sb)
+		return -ENOMEM;
+
+	error = gfs2_glock_nq_num(sdp,
+				 GFS2_SB_LOCK, &gfs2_meta_glops,
+				 LM_ST_SHARED, 0, &sb_gh);
+	if (error)
+		goto out;
+
+	error = gfs2_meta_read(sb_gh.gh_gl,
+			       GFS2_SB_ADDR >> sdp->sd_fsb2bb_shift,
+			       DIO_START | DIO_WAIT,
+			       &bh);
+	if (error) {
+		gfs2_glock_dq_uninit(&sb_gh);
+		goto out;
+	}
+	gfs2_sb_in(sb, bh->b_data);
+	brelse(bh);
+
+	gfs2_glock_dq_uninit(&sb_gh);
+
+	if (copy_to_user(gi->gi_data, sb, sizeof(struct gfs2_sb)))
+		error = -EFAULT;
+	else
+		error = sizeof(struct gfs2_sb);
+
+ out:
+	kfree(sb);
+
+	return error;
+}
+
+static int gi_get_file_stat(struct gfs2_inode *ip, struct gfs2_ioctl *gi)
+{
+	struct gfs2_holder i_gh;
+	struct gfs2_dinode *di;
+	int error;
+
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+	if (gi->gi_size != sizeof(struct gfs2_dinode))
+		return -EINVAL;
+
+	di = kmalloc(sizeof(struct gfs2_dinode), GFP_KERNEL);
+	if (!di)
+		return -ENOMEM;
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
+	if (error)
+		goto out;
+	memcpy(di, &ip->i_di, sizeof(struct gfs2_dinode));
+	gfs2_glock_dq_uninit(&i_gh);
+
+	if (copy_to_user(gi->gi_data, di, sizeof(struct gfs2_dinode)))
+		error = -EFAULT;
+	else
+		error = sizeof(struct gfs2_dinode);
+
+ out:
+	kfree(di);
+
+	return error;
+}
+
+static int gi_set_file_flag(struct gfs2_inode *ip, struct gfs2_ioctl *gi)
+{
+	char buf[ARG_SIZE];
+	int set;
+	uint32_t flag;
+	struct gfs2_holder i_gh;
+	struct buffer_head *dibh;
+	int error;
+
+	if (gi->gi_argc != 3)
+		return -EINVAL;
+
+	if (strncpy_from_user(buf, gi->gi_argv[1], ARG_SIZE) < 0)
+		return -EFAULT;
+	buf[ARG_SIZE - 1] = 0;
+
+	if (strcmp(buf, "set") == 0)
+		set = 1;
+	else if (strcmp(buf, "clear") == 0)
+		set = 0;
+	else
+		return -EINVAL;
+
+	if (strncpy_from_user(buf, gi->gi_argv[2], ARG_SIZE) < 0)
+		return -EFAULT;
+	buf[ARG_SIZE - 1] = 0;
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &i_gh);
+	if (error)
+		return error;
+
+	error = -EACCES;
+	if (ip->i_di.di_uid != current->fsuid && !capable(CAP_FOWNER))
+		goto out;
+
+	error = -EINVAL;
+
+	if (strcmp(buf, "jdata") == 0) {
+		if (!S_ISREG(ip->i_di.di_mode) || ip->i_di.di_size)
+			goto out;
+		flag = GFS2_DIF_JDATA;
+	} else if (strcmp(buf, "directio") == 0) {
+		if (!S_ISREG(ip->i_di.di_mode))
+			goto out;
+		flag = GFS2_DIF_DIRECTIO;
+	} else if (strcmp(buf, "immutable") == 0) {
+		/* The IMMUTABLE flag can only be changed by
+		   the relevant capability. */
+		error = -EPERM;
+		if (!capable(CAP_LINUX_IMMUTABLE))
+			goto out;
+		flag = GFS2_DIF_IMMUTABLE;
+	} else if (strcmp(buf, "appendonly") == 0) {
+		/* The APPENDONLY flag can only be changed by
+		   the relevant capability. */
+		error = -EPERM;
+		if (!capable(CAP_LINUX_IMMUTABLE))
+			goto out;
+		flag = GFS2_DIF_APPENDONLY;
+	} else if (strcmp(buf, "inherit_jdata") == 0) {
+		if (!S_ISDIR(ip->i_di.di_mode))
+			goto out;
+		flag = GFS2_DIF_INHERIT_JDATA;
+	} else if (strcmp(buf, "inherit_directio") == 0) {
+		if (S_ISDIR(ip->i_di.di_mode))
+			goto out;
+		flag = GFS2_DIF_INHERIT_DIRECTIO;
+	} else
+		goto out;
+
+	error = gfs2_trans_begin(ip->i_sbd, RES_DINODE, 0);
+	if (error)
+		goto out;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		goto out_trans_end;
+
+	if (set)
+		ip->i_di.di_flags |= flag;
+	else
+		ip->i_di.di_flags &= ~flag;
+
+	gfs2_trans_add_bh(ip->i_gl, dibh);
+	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+
+	brelse(dibh);
+
+ out_trans_end:
+	gfs2_trans_end(ip->i_sbd);
+
+ out:
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return error;
+
+}
+
+static int gi_get_bmap(struct gfs2_inode *ip, struct gfs2_ioctl *gi)
+{
+	struct gfs2_holder gh;
+	uint64_t lblock, dblock = 0;
+	int new = 0;
+	int error;
+
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+	if (gi->gi_size != sizeof(uint64_t))
+		return -EINVAL;
+
+	error = copy_from_user(&lblock, gi->gi_data, sizeof(uint64_t));
+	if (error)
+		return -EFAULT;
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
+	if (error)
+		return error;
+
+	error = -EACCES;
+	if (ip->i_di.di_uid == current->fsuid || capable(CAP_FOWNER)) {
+		error = 0;
+		if (!gfs2_is_stuffed(ip))
+			error = gfs2_block_map(ip, lblock, &new, &dblock, NULL);
+	}
+
+	gfs2_glock_dq_uninit(&gh);
+
+	if (!error) {
+		error = copy_to_user(gi->gi_data, &dblock, sizeof(uint64_t));
+		if (error)
+			error = -EFAULT;
+	}
+
+	return error;
+}
+
+/**
+ * gi_get_file_meta - Return all the metadata for a file
+ * @ip:
+ * @gi:
+ *
+ * Returns: the number of bytes copied, or -errno
+ */
+
+static int gi_get_file_meta(struct gfs2_inode *ip, struct gfs2_ioctl *gi)
+{
+	struct gfs2_holder i_gh;
+	struct gfs2_user_buffer ub;
+	int error;
+
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+
+	ub.ub_data = gi->gi_data;
+	ub.ub_size = gi->gi_size;
+	ub.ub_count = 0;
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
+	if (error)
+		return error;
+
+	error = -EACCES;
+	if (ip->i_di.di_uid != current->fsuid && !capable(CAP_FOWNER))
+		goto out;
+
+	error = gfs2_get_file_meta(ip, &ub);
+	if (error)
+		goto out;
+
+	if (S_ISDIR(ip->i_di.di_mode) &&
+	    (ip->i_di.di_flags & GFS2_DIF_EXHASH)) {
+		error = gfs2_get_dir_meta(ip, &ub);
+		if (error)
+			goto out;
+	}
+
+	if (ip->i_di.di_eattr) {
+		error = gfs2_get_eattr_meta(ip, &ub);
+		if (error)
+			goto out;
+	}
+
+	error = ub.ub_count;
+
+ out:
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return error;
+}
+
+/**
+ * gi_do_file_flush - sync out all dirty data and
+ *                    drop the cache (and lock) for a file.
+ * @ip:
+ * @gi:
+ *
+ * Returns: errno
+ */
+
+static int gi_do_file_flush(struct gfs2_inode *ip, struct gfs2_ioctl *gi)
+{
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+	gfs2_glock_force_drop(ip->i_gl);
+	return 0;
+}
+
+/**
+ * gi2hip - return the "struct gfs2_inode" for a hidden file
+ * @sdp:
+ * @gi:
+ *
+ * Returns: the "struct gfs2_inode"
+ */
+
+static struct gfs2_inode *gi2hip(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	char buf[ARG_SIZE];
+
+	if (gi->gi_argc != 2)
+		return ERR_PTR(-EINVAL);
+
+	if (strncpy_from_user(buf, gi->gi_argv[1], ARG_SIZE) < 0)
+		return ERR_PTR(-EFAULT);
+	buf[ARG_SIZE - 1] = 0;
+
+	if (strcmp(buf, "jindex") == 0)
+		return sdp->sd_jindex;
+	if (strcmp(buf, "rindex") == 0)
+		return sdp->sd_rindex;
+	if (strcmp(buf, "quota") == 0)
+		return sdp->sd_quota_inode;
+
+	return ERR_PTR(-EINVAL);
+}
+
+/**
+ * gi_get_hfile_stat - get stat info on a hidden file
+ * @sdp:
+ * @gi:
+ *
+ * Returns: the number of bytes copied, or -errno
+ */
+
+static int gi_get_hfile_stat(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	struct gfs2_inode *ip;
+	struct gfs2_dinode *di;
+	struct gfs2_holder i_gh;
+	int error;
+
+	ip = gi2hip(sdp, gi);
+	if (IS_ERR(ip))
+		return PTR_ERR(ip);
+
+	if (gi->gi_size != sizeof(struct gfs2_dinode))
+		return -EINVAL;
+
+	di = kmalloc(sizeof(struct gfs2_dinode), GFP_KERNEL);
+	if (!di)
+		return -ENOMEM;
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
+	if (error)
+		goto out;
+	memcpy(di, &ip->i_di, sizeof(struct gfs2_dinode));
+	gfs2_glock_dq_uninit(&i_gh);
+
+	if (copy_to_user(gi->gi_data, di, sizeof(struct gfs2_dinode)))
+		error = -EFAULT;
+	else
+		error = sizeof(struct gfs2_dinode);
+
+ out:
+	kfree(di);
+
+	return error;
+}
+
+/**
+ * gi_do_hfile_read - Read data from a hidden file
+ * @sdp:
+ * @gi:
+ *
+ * Returns: the number of bytes read, or -errno
+ */
+
+static int gi_do_hfile_read(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	struct gfs2_inode *ip;
+	struct gfs2_holder i_gh;
+	int error;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	ip = gi2hip(sdp, gi);
+	if (IS_ERR(ip))
+		return PTR_ERR(ip);
+
+	if (!S_ISREG(ip->i_di.di_mode))
+		return -EINVAL;
+
+	if (!access_ok(VERIFY_WRITE, gi->gi_data, gi->gi_size))
+		return -EFAULT;
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &i_gh);
+	if (error)
+		return error;
+
+	error = gfs2_jdata_read(ip, gi->gi_data, gi->gi_offset, gi->gi_size,
+				gfs2_copy2user);
+
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return error;
+}
+
+/**
+ * gi_do_hfile_write - Write data to a hidden file
+ * @sdp:
+ * @gi:
+ *
+ * Returns: the number of bytes written, or -errno
+ */
+
+static int gi_do_hfile_write(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	struct gfs2_inode *ip;
+	struct gfs2_alloc *al = NULL;
+	struct gfs2_holder i_gh;
+	unsigned int data_blocks, ind_blocks;
+	int alloc_required;
+	int error;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	ip = gi2hip(sdp, gi);
+	if (IS_ERR(ip))
+		return PTR_ERR(ip);
+
+	if (!S_ISREG(ip->i_di.di_mode))
+		return -EINVAL;
+
+	if (!access_ok(VERIFY_READ, gi->gi_data, gi->gi_size))
+		return -EFAULT;
+
+	gfs2_write_calc_reserv(ip, gi->gi_size, &data_blocks, &ind_blocks);
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE,
+				   LM_FLAG_PRIORITY, &i_gh);
+	if (error)
+		return error;
+
+	if (!gfs2_is_jdata(ip)) {
+		gfs2_consist_inode(ip);
+		error = -EIO;
+		goto out;
+	}
+
+	error = gfs2_write_alloc_required(ip, gi->gi_offset, gi->gi_size,
+					  &alloc_required);
+	if (error)
+		goto out;
+
+	if (alloc_required) {
+		al = gfs2_alloc_get(ip);
+
+		al->al_requested = data_blocks + ind_blocks;
+
+		error = gfs2_inplace_reserve(ip);
+		if (error)
+			goto out_alloc;
+
+		error = gfs2_trans_begin(sdp,
+					 al->al_rgd->rd_ri.ri_length +
+					 data_blocks + ind_blocks +
+					 RES_DINODE + RES_STATFS, 0);
+		if (error)
+			goto out_relse;
+	} else {
+		error = gfs2_trans_begin(sdp, data_blocks + RES_DINODE, 0);
+		if (error)
+			goto out;
+	}
+
+	error = gfs2_jdata_write(ip, gi->gi_data, gi->gi_offset, gi->gi_size,
+				 gfs2_copy_from_user);
+
+	gfs2_trans_end(sdp);
+
+ out_relse:
+	if (alloc_required)
+		gfs2_inplace_release(ip);
+
+ out_alloc:
+	if (alloc_required)
+		gfs2_alloc_put(ip);
+
+ out:
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return error;
+}
+
+/**
+ * gi_do_hfile_trunc - truncate a hidden file
+ * @sdp:
+ * @gi:
+ *
+ * Returns: the number of bytes copied, or -errno
+ */
+
+static int gi_do_hfile_trunc(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	struct gfs2_inode *ip;
+	struct gfs2_holder i_gh;
+	int error;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	ip = gi2hip(sdp, gi);
+	if (IS_ERR(ip))
+		return PTR_ERR(ip);
+
+	if (!S_ISREG(ip->i_di.di_mode))
+		return -EINVAL;
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &i_gh);
+	if (error)
+		return error;
+
+	error = gfs2_truncatei(ip, gi->gi_offset, NULL);
+
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return error;
+}
+
+/**
+ * gi_do_quota_sync - sync the outstanding quota changes for a FS
+ * @sdp:
+ * @gi:
+ *
+ * Returns: errno
+ */
+
+static int gi_do_quota_sync(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+	return gfs2_quota_sync(sdp);
+}
+
+/**
+ * gi_do_quota_refresh - Refresh the a quota LVB from the quota file
+ * @sdp:
+ * @gi:
+ *
+ * Returns: errno
+ */
+
+static int gi_do_quota_refresh(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	char buf[ARG_SIZE];
+	int user;
+	uint32_t id;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (gi->gi_argc != 2)
+		return -EINVAL;
+
+	if (strncpy_from_user(buf, gi->gi_argv[1], ARG_SIZE) < 0)
+		return -EFAULT;
+	buf[ARG_SIZE - 1] = 0;
+
+	switch (buf[0]) {
+	case 'u':
+		user = 1;
+		break;
+	case 'g':
+		user = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (buf[1] != ':')
+		return -EINVAL;
+
+	if (sscanf(buf + 2, "%u", &id) != 1)
+		return -EINVAL;
+
+	return gfs2_quota_refresh(sdp, user, id);
+}
+
+/**
+ * gi_do_quota_read - read quota values from the quota file
+ * @sdp:
+ * @gi:
+ *
+ * Returns: errno
+ */
+
+static int gi_do_quota_read(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	char buf[ARG_SIZE];
+	int user;
+	uint32_t id;
+	struct gfs2_quota q;
+	int error;
+
+	if (gi->gi_argc != 2)
+		return -EINVAL;
+	if (gi->gi_size != sizeof(struct gfs2_quota))
+		return -EINVAL;
+
+	if (strncpy_from_user(buf, gi->gi_argv[1], ARG_SIZE) < 0)
+		return -EFAULT;
+	buf[ARG_SIZE - 1] = 0;
+
+	switch (buf[0]) {
+	case 'u':
+		user = 1;
+		break;
+	case 'g':
+		user = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (buf[1] != ':')
+		return -EINVAL;
+
+	if (sscanf(buf + 2, "%u", &id) != 1)
+		return -EINVAL;
+
+	error = gfs2_quota_read(sdp, user, id, &q);
+	if (error)
+		return error;
+
+	if (copy_to_user(gi->gi_data, &q, sizeof(struct gfs2_quota)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int gi_resize_add_rgrps(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+	if (gi->gi_size % sizeof(struct gfs2_rindex))
+		return -EINVAL;
+
+	return gfs2_resize_add_rgrps(sdp, gi->gi_data, gi->gi_size);
+}
+
+static int gi_rename2system(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	char new_dir[ARG_SIZE], new_name[ARG_SIZE];
+	struct gfs2_inode *old_dip, *ip, *new_dip;
+	int put_new_dip = 0;
+	int error;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (gi->gi_argc != 3)
+		return -EINVAL;
+
+	if (strncpy_from_user(new_dir, gi->gi_argv[1], ARG_SIZE) < 0)
+		return -EFAULT;
+	new_dir[ARG_SIZE - 1] = 0;
+	if (strncpy_from_user(new_name, gi->gi_argv[2], ARG_SIZE) < 0)
+		return -EFAULT;
+	new_name[ARG_SIZE - 1] = 0;
+
+	error = gfs2_lookup_simple(sdp->sd_root_dir, ".gfs2_admin", &old_dip);
+	if (error)
+		return error;
+
+	error = -ENOTDIR;
+	if (!S_ISDIR(old_dip->i_di.di_mode))
+		goto out;
+
+	error = gfs2_lookup_simple(old_dip, "new_inode", &ip);
+	if (error)
+		goto out;
+
+	if (!strcmp(new_dir, "per_node")) {
+		error = gfs2_lookup_simple(sdp->sd_master_dir, "per_node",
+					   &new_dip);
+		if (error)
+			goto out2;
+		put_new_dip = 1;
+	} else if (!strcmp(new_dir, "jindex"))
+		new_dip = sdp->sd_jindex;
+	else {
+		error = -EINVAL;
+		goto out2;
+	}
+
+	error = gfs2_rename2system(ip, old_dip, "new_inode", new_dip, new_name);
+
+	if (put_new_dip)
+		gfs2_inode_put(new_dip);
+
+ out2:
+	gfs2_inode_put(ip);
+	
+ out:
+	gfs2_inode_put(old_dip);
+
+	return error;
+}
+
+int gfs2_ioctl_i(struct gfs2_inode *ip, void *arg)
+{
+	struct gfs2_ioctl *gi_user = (struct gfs2_ioctl *)arg;
+	struct gfs2_ioctl gi;
+	char **argv;
+	char arg0[ARG_SIZE];
+	int error = -EFAULT;
+
+	if (copy_from_user(&gi, gi_user, sizeof(struct gfs2_ioctl)))
+		return -EFAULT;
+	if (!gi.gi_argc)
+		return -EINVAL;
+	argv = kcalloc(gi.gi_argc, sizeof(char *), GFP_KERNEL);
+	if (!argv)
+		return -ENOMEM;
+	if (copy_from_user(argv, gi.gi_argv, gi.gi_argc * sizeof(char *)))
+		goto out;
+	gi.gi_argv = argv;
+
+	if (strncpy_from_user(arg0, argv[0], ARG_SIZE) < 0)
+		goto out;
+	arg0[ARG_SIZE - 1] = 0;
+
+	if (strcmp(arg0, "get_super") == 0)
+		error = gi_get_super(ip->i_sbd, &gi);
+	else if (strcmp(arg0, "get_file_stat") == 0)
+		error = gi_get_file_stat(ip, &gi);
+	else if (strcmp(arg0, "set_file_flag") == 0)
+		error = gi_set_file_flag(ip, &gi);
+	else if (strcmp(arg0, "get_bmap") == 0)
+		error = gi_get_bmap(ip, &gi);
+	else if (strcmp(arg0, "get_file_meta") == 0)
+		error = gi_get_file_meta(ip, &gi);
+	else if (strcmp(arg0, "do_file_flush") == 0)
+		error = gi_do_file_flush(ip, &gi);
+	else if (strcmp(arg0, "get_hfile_stat") == 0)
+		error = gi_get_hfile_stat(ip->i_sbd, &gi);
+	else if (strcmp(arg0, "do_hfile_read") == 0)
+		error = gi_do_hfile_read(ip->i_sbd, &gi);
+	else if (strcmp(arg0, "do_hfile_write") == 0)
+		error = gi_do_hfile_write(ip->i_sbd, &gi);
+	else if (strcmp(arg0, "do_hfile_trunc") == 0)
+		error = gi_do_hfile_trunc(ip->i_sbd, &gi);
+	else if (strcmp(arg0, "do_quota_sync") == 0)
+		error = gi_do_quota_sync(ip->i_sbd, &gi);
+	else if (strcmp(arg0, "do_quota_refresh") == 0)
+		error = gi_do_quota_refresh(ip->i_sbd, &gi);
+	else if (strcmp(arg0, "do_quota_read") == 0)
+		error = gi_do_quota_read(ip->i_sbd, &gi);
+	else if (strcmp(arg0, "resize_add_rgrps") == 0)
+		error = gi_resize_add_rgrps(ip->i_sbd, &gi);
+	else if (strcmp(arg0, "rename2system") == 0)
+		error = gi_rename2system(ip->i_sbd, &gi);
+	else
+		error = -ENOTTY;
+
+ out:
+	kfree(argv);
+
+	return error;
+}
+
--- a/fs/gfs2/ioctl.h	1969-12-31 17:00:00.000000000 -0700
+++ b/fs/gfs2/ioctl.h	2005-10-10 11:28:49.218799108 -0500
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
+#ifndef __IOCTL_DOT_H__
+#define __IOCTL_DOT_H__
+
+int gfs2_ioctl_i(struct gfs2_inode *ip, void *arg);
+
+#endif /* __IOCTL_DOT_H__ */
--- a/fs/gfs2/sys.c	1969-12-31 17:00:00.000000000 -0700
+++ b/fs/gfs2/sys.c	2005-10-10 11:28:49.363776501 -0500
@@ -0,0 +1,617 @@
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
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/module.h>
+#include <linux/kobject.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include "gfs2.h"
+#include "lm.h"
+#include "sys.h"
+#include "super.h"
+#include "glock.h"
+
+char *gfs2_sys_margs;
+spinlock_t gfs2_sys_margs_lock;
+
+static ssize_t id_show(struct gfs2_sbd *sdp, char *buf)
+{
+	return sprintf(buf, "%s\n", sdp->sd_vfs->s_id);
+}
+
+static ssize_t fsname_show(struct gfs2_sbd *sdp, char *buf)
+{
+	return sprintf(buf, "%s\n", sdp->sd_fsname);
+}
+
+static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
+{
+	unsigned int count;
+
+	down(&sdp->sd_freeze_lock);
+	count = sdp->sd_freeze_count;
+	up(&sdp->sd_freeze_lock);
+
+	return sprintf(buf, "%u\n", count);
+}
+
+static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
+{
+	ssize_t ret = len;
+	int error = 0;
+	int n = simple_strtol(buf, NULL, 0);
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	switch (n) {
+	case 0:
+		gfs2_unfreeze_fs(sdp);
+		break;
+	case 1:
+		error = gfs2_freeze_fs(sdp);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (error)
+		fs_warn(sdp, "freeze %d error %d", n, error);
+
+	return ret;
+}
+
+static ssize_t withdraw_show(struct gfs2_sbd *sdp, char *buf)
+{
+	unsigned int b = test_bit(SDF_SHUTDOWN, &sdp->sd_flags);
+	return sprintf(buf, "%u\n", b);
+}
+
+static ssize_t withdraw_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (simple_strtol(buf, NULL, 0) != 1)
+		return -EINVAL;
+
+	gfs2_lm_withdraw(sdp,
+		"GFS2: fsid=%s: withdrawing from cluster at user's request\n",
+		sdp->sd_fsname);
+	return len;
+}
+
+static ssize_t statfs_show(struct gfs2_sbd *sdp, char *buf)
+{
+	struct gfs2_statfs_change sc;
+	int rv;
+
+	if (gfs2_tune_get(sdp, gt_statfs_slow))
+		rv = gfs2_statfs_slow(sdp, &sc);
+	else
+		rv = gfs2_statfs_i(sdp, &sc);
+
+	if (rv)
+		goto out;
+
+	rv += sprintf(buf + rv, "bsize %u\n", sdp->sd_sb.sb_bsize);
+	rv += sprintf(buf + rv, "total %lld\n", sc.sc_total);
+	rv += sprintf(buf + rv, "free %lld\n", sc.sc_free);
+	rv += sprintf(buf + rv, "dinodes %lld\n", sc.sc_dinodes);
+ out:
+	return rv;
+}
+
+static ssize_t statfs_sync_store(struct gfs2_sbd *sdp, const char *buf,
+				 size_t len)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (simple_strtol(buf, NULL, 0) != 1)
+		return -EINVAL;
+
+	gfs2_statfs_sync(sdp);
+	return len;
+}
+
+static ssize_t shrink_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (simple_strtol(buf, NULL, 0) != 1)
+		return -EINVAL;
+
+	gfs2_gl_hash_clear(sdp, NO_WAIT);
+	return len;
+}
+
+struct gfs2_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct gfs2_sbd *, char *);
+	ssize_t (*store)(struct gfs2_sbd *, const char *, size_t);
+};
+
+#define GFS2_ATTR(name, mode, show, store) \
+static struct gfs2_attr gfs2_attr_##name = __ATTR(name, mode, show, store)
+
+GFS2_ATTR(id,          0444, id_show,       NULL);
+GFS2_ATTR(fsname,      0444, fsname_show,   NULL);
+GFS2_ATTR(freeze,      0644, freeze_show,   freeze_store);
+GFS2_ATTR(withdraw,    0644, withdraw_show, withdraw_store);
+GFS2_ATTR(statfs,      0444, statfs_show,   NULL);
+GFS2_ATTR(statfs_sync, 0200, NULL,          statfs_sync_store);
+GFS2_ATTR(shrink,      0200, NULL,          shrink_store);
+
+static struct attribute *gfs2_attrs[] = {
+	&gfs2_attr_id.attr,
+	&gfs2_attr_fsname.attr,
+	&gfs2_attr_freeze.attr,
+	&gfs2_attr_withdraw.attr,
+	&gfs2_attr_statfs.attr,
+	&gfs2_attr_statfs_sync.attr,
+	&gfs2_attr_shrink.attr,
+	NULL,
+};
+
+static ssize_t gfs2_attr_show(struct kobject *kobj, struct attribute *attr,
+			      char *buf)
+{
+	struct gfs2_sbd *sdp = container_of(kobj, struct gfs2_sbd, sd_kobj);
+	struct gfs2_attr *a = container_of(attr, struct gfs2_attr, attr);
+	return a->show ? a->show(sdp, buf) : 0;
+}
+
+static ssize_t gfs2_attr_store(struct kobject *kobj, struct attribute *attr,
+			       const char *buf, size_t len)
+{
+	struct gfs2_sbd *sdp = container_of(kobj, struct gfs2_sbd, sd_kobj);
+	struct gfs2_attr *a = container_of(attr, struct gfs2_attr, attr);
+	return a->store ? a->store(sdp, buf, len) : len;
+}
+
+static struct sysfs_ops gfs2_attr_ops = {
+	.show  = gfs2_attr_show,
+	.store = gfs2_attr_store,
+};
+
+static struct kobj_type gfs2_ktype = {
+	.default_attrs = gfs2_attrs,
+	.sysfs_ops     = &gfs2_attr_ops,
+};
+
+/* FIXME: this should go under fs_subsys, /sys/fs/ */
+
+static struct kset gfs2_kset = {
+	.subsys = &kernel_subsys,
+	.kobj   = {.name = "gfs2",},
+	.ktype  = &gfs2_ktype,
+};
+
+/*
+ * display struct lm_lockstruct fields
+ */
+
+struct lockstruct_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct gfs2_sbd *, char *);
+};
+
+#define LOCKSTRUCT_ATTR(name, fmt)                                          \
+static ssize_t name##_show(struct gfs2_sbd *sdp, char *buf)                 \
+{                                                                           \
+	return sprintf(buf, fmt, sdp->sd_lockstruct.ls_##name);             \
+}                                                                           \
+static struct lockstruct_attr lockstruct_attr_##name = __ATTR_RO(name)
+
+LOCKSTRUCT_ATTR(jid,      "%u\n");
+LOCKSTRUCT_ATTR(first,    "%u\n");
+LOCKSTRUCT_ATTR(lvb_size, "%u\n");
+LOCKSTRUCT_ATTR(flags,    "%d\n");
+
+static struct attribute *lockstruct_attrs[] = {
+	&lockstruct_attr_jid.attr,
+	&lockstruct_attr_first.attr,
+	&lockstruct_attr_lvb_size.attr,
+	&lockstruct_attr_flags.attr,
+	NULL
+};
+
+/*
+ * display struct gfs2_args fields
+ */
+
+struct args_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct gfs2_sbd *, char *);
+};
+
+#define ARGS_ATTR(name, fmt)                                                \
+static ssize_t name##_show(struct gfs2_sbd *sdp, char *buf)                 \
+{                                                                           \
+	return sprintf(buf, fmt, sdp->sd_args.ar_##name);                   \
+}                                                                           \
+static struct args_attr args_attr_##name = __ATTR_RO(name)
+
+ARGS_ATTR(lockproto,       "%s\n");
+ARGS_ATTR(locktable,       "%s\n");
+ARGS_ATTR(hostdata,        "%s\n");
+ARGS_ATTR(spectator,       "%d\n");
+ARGS_ATTR(ignore_local_fs, "%d\n");
+ARGS_ATTR(localcaching,    "%d\n");
+ARGS_ATTR(localflocks,     "%d\n");
+ARGS_ATTR(debug,           "%d\n");
+ARGS_ATTR(upgrade,         "%d\n");
+ARGS_ATTR(num_glockd,      "%u\n");
+ARGS_ATTR(posix_acl,       "%d\n");
+ARGS_ATTR(quota,           "%u\n");
+ARGS_ATTR(suiddir,         "%d\n");
+ARGS_ATTR(data,            "%d\n");
+
+/* one oddball doesn't fit the macro mold */
+static ssize_t noatime_show(struct gfs2_sbd *sdp, char *buf)
+{
+	return sprintf(buf, "%d\n", !!test_bit(SDF_NOATIME, &sdp->sd_flags));
+}
+static struct args_attr args_attr_noatime = __ATTR_RO(noatime);
+
+static struct attribute *args_attrs[] = {
+	&args_attr_lockproto.attr,
+	&args_attr_locktable.attr,
+	&args_attr_hostdata.attr,
+	&args_attr_spectator.attr,
+	&args_attr_ignore_local_fs.attr,
+	&args_attr_localcaching.attr,
+	&args_attr_localflocks.attr,
+	&args_attr_debug.attr,
+	&args_attr_upgrade.attr,
+	&args_attr_num_glockd.attr,
+	&args_attr_posix_acl.attr,
+	&args_attr_quota.attr,
+	&args_attr_suiddir.attr,
+	&args_attr_data.attr,
+	&args_attr_noatime.attr,
+	NULL
+};
+
+/*
+ * display counters from superblock
+ */
+
+struct counters_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct gfs2_sbd *, char *);
+};
+
+#define COUNTERS_ATTR_GENERAL(name, fmt, val)                               \
+static ssize_t name##_show(struct gfs2_sbd *sdp, char *buf)                 \
+{                                                                           \
+	return sprintf(buf, fmt, val);                                      \
+}                                                                           \
+static struct counters_attr counters_attr_##name = __ATTR_RO(name)
+
+#define COUNTERS_ATTR_SIMPLE(name, fmt) \
+	COUNTERS_ATTR_GENERAL(name, fmt, sdp->sd_##name)
+
+#define COUNTERS_ATTR_ATOMIC(name, fmt) \
+	COUNTERS_ATTR_GENERAL(name, fmt, (unsigned int)atomic_read(&sdp->sd_##name))
+
+COUNTERS_ATTR_ATOMIC(glock_count,          "%u\n");
+COUNTERS_ATTR_ATOMIC(glock_held_count,     "%u\n");
+COUNTERS_ATTR_ATOMIC(inode_count,          "%u\n");
+COUNTERS_ATTR_ATOMIC(bufdata_count,        "%u\n");
+COUNTERS_ATTR_ATOMIC(unlinked_count,       "%u\n");
+COUNTERS_ATTR_ATOMIC(quota_count,          "%u\n");
+COUNTERS_ATTR_SIMPLE(log_num_gl,           "%u\n");
+COUNTERS_ATTR_SIMPLE(log_num_buf,          "%u\n");
+COUNTERS_ATTR_SIMPLE(log_num_revoke,       "%u\n");
+COUNTERS_ATTR_SIMPLE(log_num_rg,           "%u\n");
+COUNTERS_ATTR_SIMPLE(log_num_databuf,      "%u\n");
+COUNTERS_ATTR_SIMPLE(log_blks_free,        "%u\n");
+COUNTERS_ATTR_GENERAL(jd_blocks,           "%u\n", sdp->sd_jdesc->jd_blocks);
+COUNTERS_ATTR_ATOMIC(reclaim_count,        "%u\n");
+COUNTERS_ATTR_SIMPLE(log_wraps,            "%llu\n");
+COUNTERS_ATTR_ATOMIC(fh2dentry_misses,     "%u\n");
+COUNTERS_ATTR_ATOMIC(reclaimed,            "%u\n");
+COUNTERS_ATTR_ATOMIC(log_flush_incore,     "%u\n");
+COUNTERS_ATTR_ATOMIC(log_flush_ondisk,     "%u\n");
+COUNTERS_ATTR_ATOMIC(glock_nq_calls,       "%u\n");
+COUNTERS_ATTR_ATOMIC(glock_dq_calls,       "%u\n");
+COUNTERS_ATTR_ATOMIC(glock_prefetch_calls, "%u\n");
+COUNTERS_ATTR_ATOMIC(lm_lock_calls,        "%u\n");
+COUNTERS_ATTR_ATOMIC(lm_unlock_calls,      "%u\n");
+COUNTERS_ATTR_ATOMIC(lm_callbacks,         "%u\n");
+COUNTERS_ATTR_ATOMIC(ops_address,          "%u\n");
+COUNTERS_ATTR_ATOMIC(ops_dentry,           "%u\n");
+COUNTERS_ATTR_ATOMIC(ops_export,           "%u\n");
+COUNTERS_ATTR_ATOMIC(ops_file,             "%u\n");
+COUNTERS_ATTR_ATOMIC(ops_inode,            "%u\n");
+COUNTERS_ATTR_ATOMIC(ops_super,            "%u\n");
+COUNTERS_ATTR_ATOMIC(ops_vm,               "%u\n");
+
+static struct attribute *counters_attrs[] = {
+	&counters_attr_glock_count.attr,
+	&counters_attr_glock_held_count.attr,
+	&counters_attr_inode_count.attr,
+	&counters_attr_bufdata_count.attr,
+	&counters_attr_unlinked_count.attr,
+	&counters_attr_quota_count.attr,
+	&counters_attr_log_num_gl.attr,
+	&counters_attr_log_num_buf.attr,
+	&counters_attr_log_num_revoke.attr,
+	&counters_attr_log_num_rg.attr,
+	&counters_attr_log_num_databuf.attr,
+	&counters_attr_log_blks_free.attr,
+	&counters_attr_jd_blocks.attr,
+	&counters_attr_reclaim_count.attr,
+	&counters_attr_log_wraps.attr,
+	&counters_attr_fh2dentry_misses.attr,
+	&counters_attr_reclaimed.attr,
+	&counters_attr_log_flush_incore.attr,
+	&counters_attr_log_flush_ondisk.attr,
+	&counters_attr_glock_nq_calls.attr,
+	&counters_attr_glock_dq_calls.attr,
+	&counters_attr_glock_prefetch_calls.attr,
+	&counters_attr_lm_lock_calls.attr,
+	&counters_attr_lm_unlock_calls.attr,
+	&counters_attr_lm_callbacks.attr,
+	&counters_attr_ops_address.attr,
+	&counters_attr_ops_dentry.attr,
+	&counters_attr_ops_export.attr,
+	&counters_attr_ops_file.attr,
+	&counters_attr_ops_inode.attr,
+	&counters_attr_ops_super.attr,
+	&counters_attr_ops_vm.attr,
+	NULL
+};
+
+/*
+ * get and set struct gfs2_tune fields
+ */
+
+static ssize_t quota_scale_show(struct gfs2_sbd *sdp, char *buf)
+{
+	return sprintf(buf, "%u %u\n", sdp->sd_tune.gt_quota_scale_num,
+				       sdp->sd_tune.gt_quota_scale_den);
+}
+
+static ssize_t quota_scale_store(struct gfs2_sbd *sdp, const char *buf,
+				 size_t len)
+{
+	struct gfs2_tune *gt = &sdp->sd_tune;
+	unsigned int x, y;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (sscanf(buf, "%u %u", &x, &y) != 2 || !y)
+		return -EINVAL;
+
+	spin_lock(&gt->gt_spin);
+	gt->gt_quota_scale_num = x;
+	gt->gt_quota_scale_den = y;
+	spin_unlock(&gt->gt_spin);
+	return len;
+}
+
+static ssize_t tune_set(struct gfs2_sbd *sdp, unsigned int *field,
+			int check_zero, const char *buf, size_t len)
+{
+	struct gfs2_tune *gt = &sdp->sd_tune;
+	unsigned int x;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	x = simple_strtoul(buf, NULL, 0);
+
+	if (check_zero && !x)
+		return -EINVAL;
+
+	spin_lock(&gt->gt_spin);
+	*field = x;
+	spin_unlock(&gt->gt_spin);
+	return len;
+}
+
+struct tune_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct gfs2_sbd *, char *);
+	ssize_t (*store)(struct gfs2_sbd *, const char *, size_t);
+};
+
+#define TUNE_ATTR_3(name, show, store)                                        \
+static struct tune_attr tune_attr_##name = __ATTR(name, 0644, show, store)
+
+#define TUNE_ATTR_2(name, store)                                              \
+static ssize_t name##_show(struct gfs2_sbd *sdp, char *buf)                   \
+{                                                                             \
+	return sprintf(buf, "%u\n", sdp->sd_tune.gt_##name);                  \
+}                                                                             \
+TUNE_ATTR_3(name, name##_show, store)
+
+#define TUNE_ATTR(name, check_zero)                                           \
+static ssize_t name##_store(struct gfs2_sbd *sdp, const char *buf, size_t len)\
+{                                                                             \
+	return tune_set(sdp, &sdp->sd_tune.gt_##name, check_zero, buf, len);  \
+}                                                                             \
+TUNE_ATTR_2(name, name##_store)
+
+#define TUNE_ATTR_DAEMON(name, process)                                       \
+static ssize_t name##_store(struct gfs2_sbd *sdp, const char *buf, size_t len)\
+{                                                                             \
+	ssize_t r = tune_set(sdp, &sdp->sd_tune.gt_##name, 1, buf, len);      \
+	wake_up_process(sdp->sd_##process);                                   \
+	return r;                                                             \
+}                                                                             \
+TUNE_ATTR_2(name, name##_store)
+
+TUNE_ATTR(ilimit, 0);
+TUNE_ATTR(ilimit_tries, 0);
+TUNE_ATTR(ilimit_min, 0);
+TUNE_ATTR(demote_secs, 0);
+TUNE_ATTR(incore_log_blocks, 0);
+TUNE_ATTR(log_flush_secs, 0);
+TUNE_ATTR(jindex_refresh_secs, 0);
+TUNE_ATTR(quota_warn_period, 0);
+TUNE_ATTR(quota_quantum, 0);
+TUNE_ATTR(atime_quantum, 0);
+TUNE_ATTR(max_readahead, 0);
+TUNE_ATTR(complain_secs, 0);
+TUNE_ATTR(reclaim_limit, 0);
+TUNE_ATTR(prefetch_secs, 0);
+TUNE_ATTR(statfs_slow, 0);
+TUNE_ATTR(new_files_jdata, 0);
+TUNE_ATTR(new_files_directio, 0);
+TUNE_ATTR(quota_simul_sync, 1);
+TUNE_ATTR(quota_cache_secs, 1);
+TUNE_ATTR(max_atomic_write, 1);
+TUNE_ATTR(stall_secs, 1);
+TUNE_ATTR(entries_per_readdir, 1);
+TUNE_ATTR(greedy_default, 1);
+TUNE_ATTR(greedy_quantum, 1);
+TUNE_ATTR(greedy_max, 1);
+TUNE_ATTR(statfs_quantum, 1);
+TUNE_ATTR_DAEMON(scand_secs, scand_process);
+TUNE_ATTR_DAEMON(recoverd_secs, recoverd_process);
+TUNE_ATTR_DAEMON(logd_secs, logd_process);
+TUNE_ATTR_DAEMON(quotad_secs, quotad_process);
+TUNE_ATTR_DAEMON(inoded_secs, inoded_process);
+TUNE_ATTR_3(quota_scale, quota_scale_show, quota_scale_store);
+
+static struct attribute *tune_attrs[] = {
+	&tune_attr_ilimit.attr,
+	&tune_attr_ilimit_tries.attr,
+	&tune_attr_ilimit_min.attr,
+	&tune_attr_demote_secs.attr,
+	&tune_attr_incore_log_blocks.attr,
+	&tune_attr_log_flush_secs.attr,
+	&tune_attr_jindex_refresh_secs.attr,
+	&tune_attr_quota_warn_period.attr,
+	&tune_attr_quota_quantum.attr,
+	&tune_attr_atime_quantum.attr,
+	&tune_attr_max_readahead.attr,
+	&tune_attr_complain_secs.attr,
+	&tune_attr_reclaim_limit.attr,
+	&tune_attr_prefetch_secs.attr,
+	&tune_attr_statfs_slow.attr,
+	&tune_attr_quota_simul_sync.attr,
+	&tune_attr_quota_cache_secs.attr,
+	&tune_attr_max_atomic_write.attr,
+	&tune_attr_stall_secs.attr,
+	&tune_attr_entries_per_readdir.attr,
+	&tune_attr_greedy_default.attr,
+	&tune_attr_greedy_quantum.attr,
+	&tune_attr_greedy_max.attr,
+	&tune_attr_statfs_quantum.attr,
+	&tune_attr_scand_secs.attr,
+	&tune_attr_recoverd_secs.attr,
+	&tune_attr_logd_secs.attr,
+	&tune_attr_quotad_secs.attr,
+	&tune_attr_inoded_secs.attr,
+	&tune_attr_quota_scale.attr,
+	&tune_attr_new_files_jdata.attr,
+	&tune_attr_new_files_directio.attr,
+	NULL
+};
+
+static struct attribute_group lockstruct_group = {
+	.name = "lockstruct",
+	.attrs = lockstruct_attrs
+};
+
+static struct attribute_group counters_group = {
+	.name = "counters",
+	.attrs = counters_attrs
+};
+
+static struct attribute_group args_group = {
+	.name = "args",
+	.attrs = args_attrs
+};
+
+static struct attribute_group tune_group = {
+	.name = "tune",
+	.attrs = tune_attrs
+};
+
+int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
+{
+	int error;
+
+	sdp->sd_kobj.kset = &gfs2_kset;
+	sdp->sd_kobj.ktype = &gfs2_ktype;
+
+	error = kobject_set_name(&sdp->sd_kobj, "%s", sdp->sd_table_name);
+	if (error)
+		goto fail;
+
+	error = kobject_register(&sdp->sd_kobj);
+	if (error)
+		goto fail;
+
+	error = sysfs_create_group(&sdp->sd_kobj, &lockstruct_group);
+	if (error)
+		goto fail_reg;
+
+	error = sysfs_create_group(&sdp->sd_kobj, &counters_group);
+	if (error)
+		goto fail_lockstruct;
+
+	error = sysfs_create_group(&sdp->sd_kobj, &args_group);
+	if (error)
+		goto fail_counters;
+
+	error = sysfs_create_group(&sdp->sd_kobj, &tune_group);
+	if (error)
+		goto fail_args;
+
+	return 0;
+
+ fail_args:
+	sysfs_remove_group(&sdp->sd_kobj, &args_group);
+ fail_counters:
+	sysfs_remove_group(&sdp->sd_kobj, &counters_group);
+ fail_lockstruct:
+	sysfs_remove_group(&sdp->sd_kobj, &lockstruct_group);
+ fail_reg:
+	kobject_unregister(&sdp->sd_kobj);
+ fail:
+	return error;
+}
+
+void gfs2_sys_fs_del(struct gfs2_sbd *sdp)
+{
+	sysfs_remove_group(&sdp->sd_kobj, &tune_group);
+	sysfs_remove_group(&sdp->sd_kobj, &args_group);
+	sysfs_remove_group(&sdp->sd_kobj, &counters_group);
+	sysfs_remove_group(&sdp->sd_kobj, &lockstruct_group);
+	kobject_unregister(&sdp->sd_kobj);
+}
+
+int gfs2_sys_init(void)
+{
+	gfs2_sys_margs = NULL;
+	spin_lock_init(&gfs2_sys_margs_lock);
+	return kset_register(&gfs2_kset);
+}
+
+void gfs2_sys_uninit(void)
+{
+	kfree(gfs2_sys_margs);
+	kset_unregister(&gfs2_kset);
+}
+
--- a/fs/gfs2/sys.h	1969-12-31 17:00:00.000000000 -0700
+++ b/fs/gfs2/sys.h	2005-10-10 11:28:49.363776501 -0500
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __SYS_DOT_H__
+#define __SYS_DOT_H__
+
+/* Allow args to be passed to GFS2 when using an initial ram disk */
+extern char *gfs2_sys_margs;
+extern spinlock_t gfs2_sys_margs_lock;
+
+int gfs2_sys_fs_add(struct gfs2_sbd *sdp);
+void gfs2_sys_fs_del(struct gfs2_sbd *sdp);
+
+int gfs2_sys_init(void);
+void gfs2_sys_uninit(void);
+
+#endif /* __SYS_DOT_H__ */
+
--- a/fs/gfs2/resize.c	1969-12-31 17:00:00.000000000 -0700
+++ b/fs/gfs2/resize.c	2005-10-10 11:28:49.349778684 -0500
@@ -0,0 +1,284 @@
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
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "bmap.h"
+#include "dir.h"
+#include "glock.h"
+#include "inode.h"
+#include "jdata.h"
+#include "meta_io.h"
+#include "quota.h"
+#include "resize.h"
+#include "rgrp.h"
+#include "super.h"
+#include "trans.h"
+
+int gfs2_resize_add_rgrps(struct gfs2_sbd *sdp, char __user *buf,
+			  unsigned int size)
+{
+	unsigned int num = size / sizeof(struct gfs2_rindex);
+	struct gfs2_inode *ip = sdp->sd_rindex;
+	struct gfs2_alloc *al = NULL;
+	struct gfs2_holder i_gh;
+	unsigned int data_blocks, ind_blocks;
+	int alloc_required;
+	unsigned int x;
+	int error;
+
+	gfs2_write_calc_reserv(ip, size, &data_blocks, &ind_blocks);
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE,
+				   LM_FLAG_PRIORITY | GL_SYNC, &i_gh);
+	if (error)
+		return error;
+
+	if (!gfs2_is_jdata(ip)) {
+		gfs2_consist_inode(ip);
+		error = -EIO;
+		goto out;
+	}
+
+	error = gfs2_write_alloc_required(ip, ip->i_di.di_size, size,
+					  &alloc_required);
+	if (error)
+		goto out;
+
+	if (alloc_required) {
+		al = gfs2_alloc_get(ip);
+
+		al->al_requested = data_blocks + ind_blocks;
+
+		error = gfs2_inplace_reserve(ip);
+		if (error)
+			goto out_alloc;
+
+		error = gfs2_trans_begin(sdp,
+					 al->al_rgd->rd_ri.ri_length +
+					 data_blocks + ind_blocks +
+					 RES_DINODE + RES_STATFS, 0);
+		if (error)
+			goto out_relse;
+	} else {
+		error = gfs2_trans_begin(sdp, data_blocks +
+					 RES_DINODE + RES_STATFS, 0);
+		if (error)
+			goto out;
+	}
+
+	for (x = 0; x < num; x++) {
+		struct gfs2_rindex ri;
+		char ri_buf[sizeof(struct gfs2_rindex)];
+
+		error = copy_from_user(&ri, buf, sizeof(struct gfs2_rindex));
+		if (error) {
+			error = -EFAULT;
+			goto out_trans;
+		}
+		gfs2_rindex_out(&ri, ri_buf);
+
+		error = gfs2_jdata_write_mem(ip, ri_buf, ip->i_di.di_size,
+					     sizeof(struct gfs2_rindex));
+		if (error < 0)
+			goto out_trans;
+		gfs2_assert_withdraw(sdp, error == sizeof(struct gfs2_rindex));
+		error = 0;
+
+		gfs2_statfs_change(sdp, ri.ri_data, ri.ri_data, 0);
+
+		buf += sizeof(struct gfs2_rindex);
+	}
+
+ out_trans:
+	gfs2_trans_end(sdp);
+
+ out_relse:
+	if (alloc_required)
+		gfs2_inplace_release(ip);
+
+ out_alloc:
+	if (alloc_required)
+		gfs2_alloc_put(ip);
+
+ out:
+	ip->i_gl->gl_vn++;
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return error;
+}
+
+static void drop_dentries(struct gfs2_inode *ip)
+{
+	struct inode *inode;
+	struct dentry *d;
+
+	inode = gfs2_ip2v_lookup(ip);
+	if (!inode)
+		return;
+
+ restart:
+	spin_lock(&dcache_lock);
+	list_for_each_entry(d, &inode->i_dentry, d_alias) {
+		if (d_unhashed(d))
+			continue;
+		dget_locked(d);
+		__d_drop(d);
+		spin_unlock(&dcache_lock);
+		dput(d);
+		goto restart;
+	}
+	spin_unlock(&dcache_lock);
+
+	iput(inode);
+}
+
+int gfs2_rename2system(struct gfs2_inode *ip,
+		       struct gfs2_inode *old_dip, char *old_name,
+		       struct gfs2_inode *new_dip, char *new_name)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct gfs2_holder ghs[3];
+	struct qstr old_qstr, new_qstr;
+	struct gfs2_inum inum;
+	int alloc_required;
+	struct buffer_head *dibh;
+	int error;
+
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_NOCACHE, ghs);
+	gfs2_holder_init(old_dip->i_gl, LM_ST_EXCLUSIVE, 0, ghs + 1);
+	gfs2_holder_init(new_dip->i_gl, LM_ST_EXCLUSIVE, GL_SYNC, ghs + 2);
+
+	error = gfs2_glock_nq_m(3, ghs);
+	if (error)
+		goto out;	
+
+	error = -EMLINK;
+	if (ip->i_di.di_nlink != 1)
+		goto out_gunlock;
+	error = -EINVAL;
+	if (!S_ISREG(ip->i_di.di_mode))
+		goto out_gunlock;
+
+	old_qstr.name = old_name;
+	old_qstr.len = strlen(old_name);
+	error = gfs2_dir_search(old_dip, &old_qstr, &inum, NULL);
+	switch (error) {
+	case 0:
+		break;
+	default:
+		goto out_gunlock;
+	}
+
+	error = -EINVAL;
+	if (!gfs2_inum_equal(&inum, &ip->i_num))
+		goto out_gunlock;
+
+	new_qstr.name = new_name;
+	new_qstr.len = strlen(new_name);
+	error = gfs2_dir_search(new_dip, &new_qstr, NULL, NULL);
+	switch (error) {
+	case -ENOENT:
+		break;
+	case 0:
+		error = -EEXIST;
+	default:
+		goto out_gunlock;
+	}
+
+	gfs2_alloc_get(ip);
+
+	error = gfs2_quota_hold(ip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
+	if (error)
+		goto out_alloc;
+
+	error = gfs2_diradd_alloc_required(new_dip, &new_qstr, &alloc_required);
+	if (error)
+		goto out_unhold;
+
+	if (alloc_required) {
+		struct gfs2_alloc *al = gfs2_alloc_get(new_dip);
+
+		al->al_requested = sdp->sd_max_dirres;
+
+		error = gfs2_inplace_reserve(new_dip);
+		if (error)
+			goto out_alloc2;
+
+		error = gfs2_trans_begin(sdp,
+					 sdp->sd_max_dirres +
+					 al->al_rgd->rd_ri.ri_length +
+					 3 * RES_DINODE + RES_LEAF +
+					 RES_STATFS + RES_QUOTA, 0);
+		if (error)
+			goto out_ipreserv;
+	} else {
+		error = gfs2_trans_begin(sdp,
+					 3 * RES_DINODE + 2 * RES_LEAF +
+					 RES_QUOTA, 0);
+		if (error)
+			goto out_unhold;
+	}
+	
+	error = gfs2_dir_del(old_dip, &old_qstr);
+	if (error)
+		goto out_trans;
+
+	error = gfs2_dir_add(new_dip, &new_qstr, &ip->i_num,
+			     IF2DT(ip->i_di.di_mode));
+	if (error)
+		goto out_trans;
+
+	gfs2_quota_change(ip, -ip->i_di.di_blocks, ip->i_di.di_uid,
+			  ip->i_di.di_gid);
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		goto out_trans;
+	ip->i_di.di_flags |= GFS2_DIF_SYSTEM;
+	gfs2_trans_add_bh(ip->i_gl, dibh);
+	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	brelse(dibh);
+
+	drop_dentries(ip);
+
+ out_trans:
+	gfs2_trans_end(sdp);
+
+ out_ipreserv:
+	if (alloc_required)
+		gfs2_inplace_release(new_dip);
+
+ out_alloc2:
+	if (alloc_required)
+		gfs2_alloc_put(new_dip);
+
+ out_unhold:
+	gfs2_quota_unhold(ip);
+
+ out_alloc:
+	gfs2_alloc_put(ip);
+
+ out_gunlock:
+	gfs2_glock_dq_m(3, ghs);
+
+ out:
+	gfs2_holder_uninit(ghs);
+	gfs2_holder_uninit(ghs + 1);
+	gfs2_holder_uninit(ghs + 2);
+
+	return error;
+}
+
--- a/fs/gfs2/resize.h	1969-12-31 17:00:00.000000000 -0700
+++ b/fs/gfs2/resize.h	2005-10-10 11:28:49.349778684 -0500
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __RESIZE_DOT_H__
+#define __RESIZE_DOT_H__
+
+int gfs2_resize_add_rgrps(struct gfs2_sbd *sdp, char __user *buf,
+			  unsigned int size);
+int gfs2_rename2system(struct gfs2_inode *ip,
+		       struct gfs2_inode *old_dip, char *old_name,
+		       struct gfs2_inode *new_dip, char *new_name);
+
+#endif /* __RESIZE_DOT_H__ */
--- a/fs/gfs2/mount.c	1969-12-31 17:00:00.000000000 -0700
+++ b/fs/gfs2/mount.c	2005-10-10 11:28:49.259792716 -0500
@@ -0,0 +1,211 @@
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
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "mount.h"
+#include "sys.h"
+
+/**
+ * gfs2_mount_args - Parse mount options
+ * @sdp:
+ * @data:
+ *
+ * Return: errno
+ */
+
+int gfs2_mount_args(struct gfs2_sbd *sdp, char *data_arg, int remount)
+{
+	struct gfs2_args *args = &sdp->sd_args;
+	char *data = data_arg;
+	char *options, *o, *v;
+	int error = 0;
+
+	if (!remount) {
+		/*  If someone preloaded options, use those instead  */
+		spin_lock(&gfs2_sys_margs_lock);
+		if (gfs2_sys_margs) {
+			data = gfs2_sys_margs;
+			gfs2_sys_margs = NULL;
+		}
+		spin_unlock(&gfs2_sys_margs_lock);
+
+		/*  Set some defaults  */
+		args->ar_num_glockd = GFS2_GLOCKD_DEFAULT;
+		args->ar_quota = GFS2_QUOTA_DEFAULT;
+		args->ar_data = GFS2_DATA_DEFAULT;
+	}
+
+	/* Split the options into tokens with the "," character and
+	   process them */
+
+	for (options = data; (o = strsep(&options, ",")); ) {
+		if (!*o)
+			continue;
+
+		v = strchr(o, '=');
+		if (v)
+			*v++ = 0;
+
+		if (!strcmp(o, "lockproto")) {
+			if (!v)
+				goto need_value;
+			if (remount && strcmp(v, args->ar_lockproto))
+				goto cant_remount;
+			strncpy(args->ar_lockproto, v, GFS2_LOCKNAME_LEN);
+			args->ar_lockproto[GFS2_LOCKNAME_LEN - 1] = 0;
+		}
+
+		else if (!strcmp(o, "locktable")) {
+			if (!v)
+				goto need_value;
+			if (remount && strcmp(v, args->ar_locktable))
+				goto cant_remount;
+			strncpy(args->ar_locktable, v, GFS2_LOCKNAME_LEN);
+			args->ar_locktable[GFS2_LOCKNAME_LEN - 1] = 0;
+		}
+
+		else if (!strcmp(o, "hostdata")) {
+			if (!v)
+				goto need_value;
+			if (remount && strcmp(v, args->ar_hostdata))
+				goto cant_remount;
+			strncpy(args->ar_hostdata, v, GFS2_LOCKNAME_LEN);
+			args->ar_hostdata[GFS2_LOCKNAME_LEN - 1] = 0;
+		}
+
+		else if (!strcmp(o, "spectator")) {
+			if (remount && !args->ar_spectator)
+				goto cant_remount;
+			args->ar_spectator = 1;
+			sdp->sd_vfs->s_flags |= MS_RDONLY;
+		}
+
+		else if (!strcmp(o, "ignore_local_fs")) {
+			if (remount && !args->ar_ignore_local_fs)
+				goto cant_remount;
+			args->ar_ignore_local_fs = 1;
+		}
+
+		else if (!strcmp(o, "localflocks")) {
+			if (remount && !args->ar_localflocks)
+				goto cant_remount;
+			args->ar_localflocks = 1;
+		}
+
+		else if (!strcmp(o, "localcaching")) {
+			if (remount && !args->ar_localcaching)
+				goto cant_remount;
+			args->ar_localcaching = 1;
+		}
+
+		else if (!strcmp(o, "debug"))
+			args->ar_debug = 1;
+
+		else if (!strcmp(o, "nodebug"))
+			args->ar_debug = 0;
+
+		else if (!strcmp(o, "upgrade")) {
+			if (remount && !args->ar_upgrade)
+				goto cant_remount;
+			args->ar_upgrade = 1;
+		}
+
+		else if (!strcmp(o, "num_glockd")) {
+			unsigned int x;
+			if (!v)
+				goto need_value;
+			sscanf(v, "%u", &x);
+			if (remount && x != args->ar_num_glockd)
+				goto cant_remount;
+			if (!x || x > GFS2_GLOCKD_MAX) {
+				fs_info(sdp, "0 < num_glockd <= %u  (not %u)\n",
+				        GFS2_GLOCKD_MAX, x);
+				error = -EINVAL;
+				break;
+			}
+			args->ar_num_glockd = x;
+		}
+
+		else if (!strcmp(o, "acl")) {
+			args->ar_posix_acl = 1;
+			sdp->sd_vfs->s_flags |= MS_POSIXACL;
+		}
+
+		else if (!strcmp(o, "noacl")) {
+			args->ar_posix_acl = 0;
+			sdp->sd_vfs->s_flags &= ~MS_POSIXACL;
+		}
+
+		else if (!strcmp(o, "quota")) {
+			if (!v)
+				goto need_value;
+			if (!strcmp(v, "off"))
+				args->ar_quota = GFS2_QUOTA_OFF;
+			else if (!strcmp(v, "account"))
+				args->ar_quota = GFS2_QUOTA_ACCOUNT;
+			else if (!strcmp(v, "on"))
+				args->ar_quota = GFS2_QUOTA_ON;
+			else {
+				fs_info(sdp, "invalid value for quota\n");
+				error = -EINVAL;
+				break;
+			}
+		}
+
+		else if (!strcmp(o, "suiddir"))
+			args->ar_suiddir = 1;
+
+		else if (!strcmp(o, "nosuiddir"))
+			args->ar_suiddir = 0;
+
+		else if (!strcmp(o, "data")) {
+			if (!v)
+				goto need_value;
+			if (!strcmp(v, "writeback"))
+				args->ar_data = GFS2_DATA_WRITEBACK;
+			else if (!strcmp(v, "ordered"))
+				args->ar_data = GFS2_DATA_ORDERED;
+			else {
+				fs_info(sdp, "invalid value for data\n");
+				error = -EINVAL;
+				break;
+			}
+		}
+
+		else {
+			fs_info(sdp, "unknown option: %s\n", o);
+			error = -EINVAL;
+			break;
+		}
+	}
+
+	if (error)
+		fs_info(sdp, "invalid mount option(s)\n");
+
+	if (data != data_arg)
+		kfree(data);
+
+	return error;
+
+ need_value:
+	fs_info(sdp, "need value for option %s\n", o);
+	return -EINVAL;
+
+ cant_remount:
+	fs_info(sdp, "can't remount with option %s\n", o);
+	return -EINVAL;
+}
+
--- a/fs/gfs2/mount.h	1969-12-31 17:00:00.000000000 -0700
+++ b/fs/gfs2/mount.h	2005-10-10 11:28:49.261792404 -0500
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
+#ifndef __MOUNT_DOT_H__
+#define __MOUNT_DOT_H__
+
+int gfs2_mount_args(struct gfs2_sbd *sdp, char *data_arg, int remount);
+
+#endif /* __MOUNT_DOT_H__ */
