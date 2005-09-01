Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbVIANvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVIANvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbVIANvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:51:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4293 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965112AbVIANuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:50:17 -0400
Date: Thu, 1 Sep 2005 21:56:03 +0800
From: David Teigland <teigland@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] GFS: mount and tuning options
Message-ID: <20050901135603.GK25581@redhat.com>
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

 fs/gfs2/ioctl.c  | 1485 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/ioctl.h  |   15 
 fs/gfs2/mount.c  |  209 +++++++
 fs/gfs2/mount.h  |   15 
 fs/gfs2/resize.c |  285 ++++++++++
 fs/gfs2/resize.h |   19 
 fs/gfs2/sys.c    |  201 +++++++
 fs/gfs2/sys.h    |   24 
 8 files changed, 2253 insertions(+)

--- a/fs/gfs2/ioctl.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ioctl.c	2005-09-01 17:36:55.321114560 +0800
@@ -0,0 +1,1485 @@
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
+typedef int (*gi_filler_t) (struct gfs2_inode *ip,
+			    struct gfs2_ioctl *gi,
+			    char *buf,
+			    unsigned int size,
+			    unsigned int *count);
+
+#define ARG_SIZE 32
+
+/**
+ * gi_skeleton - Setup a buffer that functions can print into
+ * @ip:
+ * @gi:
+ * @filler:
+ *
+ * Returns: -errno or count of bytes copied to userspace
+ */
+
+static int gi_skeleton(struct gfs2_inode *ip, struct gfs2_ioctl *gi,
+		       gi_filler_t filler)
+{
+	unsigned int size = gfs2_tune_get(ip->i_sbd, gt_lockdump_size);
+	char *buf;
+	unsigned int count = 0;
+	int error;
+
+	if (size > gi->gi_size)
+		size = gi->gi_size;
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	error = filler(ip, gi, buf, size, &count);
+	if (error)
+		goto out;
+
+	if (copy_to_user(gi->gi_data, buf, count + 1))
+		error = -EFAULT;
+	else
+		error = count + 1;
+
+ out:
+	kfree(buf);
+
+	return error;
+}
+
+/**
+ * gi_get_cookie - Return the "cookie" (identifying string) for a
+ *		 filesystem mount
+ * @ip:
+ * @gi:
+ * @buf:
+ * @size:
+ * @count:
+ *
+ * Returns: errno
+ */
+
+static int gi_get_cookie(struct gfs2_inode *ip, struct gfs2_ioctl *gi,
+			 char *buf, unsigned int size, unsigned int *count)
+{
+	int error = -ENOBUFS;
+
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+
+	gfs2_printf("version 0\n");
+	gfs2_printf("%lu", (unsigned long)ip->i_sbd);
+
+	error = 0;
+
+ out:
+	return error;
+}
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
+	if (copy_to_user(gi->gi_data, sb,
+			 sizeof(struct gfs2_sb)))
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
+/**
+ * gi_get_args - Return the mount arguments
+ * @ip:
+ * @gi:
+ * @buf:
+ * @size:
+ * @count:
+ *
+ * Returns: errno
+ */
+
+static int gi_get_args(struct gfs2_inode *ip, struct gfs2_ioctl *gi,
+		       char *buf, unsigned int size, unsigned int *count)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct gfs2_args *args = &sdp->sd_args;
+	int error = -ENOBUFS;
+
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+
+	gfs2_printf("version 0\n");
+	gfs2_printf("lockproto %s\n", args->ar_lockproto);
+	gfs2_printf("locktable %s\n", args->ar_locktable);
+	gfs2_printf("hostdata %s\n", args->ar_hostdata);
+	gfs2_printf("spectator %d\n", args->ar_spectator);
+	gfs2_printf("ignore_local_fs %d\n", args->ar_ignore_local_fs);
+	gfs2_printf("localcaching %d\n", args->ar_localcaching);
+	gfs2_printf("localflocks %d\n", args->ar_localflocks);
+	gfs2_printf("oopses_ok %d\n", args->ar_oopses_ok);
+	gfs2_printf("debug %d\n", args->ar_debug);
+	gfs2_printf("upgrade %d\n", args->ar_upgrade);
+	gfs2_printf("num_glockd %u\n", args->ar_num_glockd);
+	gfs2_printf("posix_acl %d\n", args->ar_posix_acl);
+	gfs2_printf("quota %u\n", args->ar_quota);
+	gfs2_printf("suiddir %d\n", args->ar_suiddir);
+	gfs2_printf("data %d\n", args->ar_data);
+	gfs2_printf("noatime %d\n", !!test_bit(SDF_NOATIME, &sdp->sd_flags));
+
+	error = 0;
+	
+ out:
+	return error;
+}
+
+/**
+ * gi_get_lockstruct - Return the information in the FS' lockstruct
+ * @ip:
+ * @gi:
+ * @buf:
+ * @size:
+ * @count:
+ *
+ * Returns: errno
+ */
+
+static int gi_get_lockstruct(struct gfs2_inode *ip, struct gfs2_ioctl *gi,
+			     char *buf, unsigned int size, unsigned int *count)
+{
+	struct lm_lockstruct *ls = &ip->i_sbd->sd_lockstruct;
+	int error = -ENOBUFS;
+
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+
+	gfs2_printf("version 0\n");
+	gfs2_printf("jid %u\n", ls->ls_jid);
+	gfs2_printf("first %u\n", ls->ls_first);
+	gfs2_printf("lvb_size %u\n", ls->ls_lvb_size);
+	gfs2_printf("flags %d\n", ls->ls_flags);
+
+	error = 0;
+
+ out:
+	return error;
+}
+
+/**
+ * gi_get_statfs - Return a filesystem's space usage information
+ * @ip:
+ * @gi:
+ * @buf:
+ * @size:
+ * @count:
+ *
+ * Returns: errno
+ */
+
+static int gi_get_statfs(struct gfs2_inode *ip, struct gfs2_ioctl *gi,
+			 char *buf, unsigned int size, unsigned int *count)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct gfs2_statfs_change sc;
+	int error;
+
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+
+	if (gfs2_tune_get(sdp, gt_statfs_slow))
+		error = gfs2_statfs_slow(sdp, &sc);
+	else
+		error = gfs2_statfs_i(sdp, &sc);
+
+	if (error)
+		return error;
+
+	error = -ENOBUFS;
+
+	gfs2_printf("version 0\n");
+	gfs2_printf("bsize %u\n", sdp->sd_sb.sb_bsize);
+	gfs2_printf("total %"PRIu64"\n", sc.sc_total);
+	gfs2_printf("free %"PRIu64"\n", sc.sc_free);
+	gfs2_printf("dinodes %"PRIu64"\n", sc.sc_dinodes);
+
+	error = 0;
+
+ out:
+	return error;
+}
+
+/**
+ * handle_roll - Read a atomic_t as an unsigned int
+ * @a: a counter
+ *
+ * if @a is negative, reset it to zero
+ *
+ * Returns: the value of the counter
+ */
+
+static unsigned int handle_roll(atomic_t *a)
+{
+	int x = atomic_read(a);
+	if (x < 0) {
+		atomic_set(a, 0);
+		return 0;
+	}
+	return (unsigned int)x;
+}
+
+/**
+ * gi_get_counters - Return usage counters
+ * @ip:
+ * @gi:
+ * @buf:
+ * @size:
+ * @count:
+ *
+ * Returns: errno
+ */
+
+static int gi_get_counters(struct gfs2_inode *ip, struct gfs2_ioctl *gi,
+			   char *buf, unsigned int size, unsigned int *count)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	int error = -ENOBUFS;
+
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+
+	gfs2_printf("version 0\n");
+	gfs2_printf("sd_glock_count:locks::%d\n",
+		    atomic_read(&sdp->sd_glock_count));
+	gfs2_printf("sd_glock_held_count:locks held::%d\n",
+		    atomic_read(&sdp->sd_glock_held_count));
+	gfs2_printf("sd_inode_count:incore inodes::%d\n",
+		    atomic_read(&sdp->sd_inode_count));
+	gfs2_printf("sd_bufdata_count:metadata buffers::%d\n",
+		    atomic_read(&sdp->sd_bufdata_count));
+	gfs2_printf("sd_unlinked_count:unlinked inodes::%d\n",
+		    atomic_read(&sdp->sd_unlinked_count));
+	gfs2_printf("sd_quota_count:quota IDs::%d\n",
+		    atomic_read(&sdp->sd_quota_count));
+	gfs2_printf("sd_log_num_gl:Glocks in current transaction::%u\n",
+		    sdp->sd_log_num_gl);
+	gfs2_printf("sd_log_num_buf:Blocks in current transaction::%u\n",
+		    sdp->sd_log_num_buf);
+	gfs2_printf("sd_log_num_revoke:Revokes in current transaction::%u\n",
+		    sdp->sd_log_num_revoke);
+	gfs2_printf("sd_log_num_rg:RGs in current transaction::%u\n",
+		    sdp->sd_log_num_rg);
+	gfs2_printf("sd_log_num_databuf:Databufs in current transaction::%u\n",
+		    sdp->sd_log_num_databuf);
+	gfs2_printf("sd_log_blks_free:log blks free::%u\n",
+		    sdp->sd_log_blks_free);
+	gfs2_printf("jd_blocks:log blocks total::%u\n",
+		    sdp->sd_jdesc->jd_blocks);
+	gfs2_printf("sd_reclaim_count:glocks on reclaim list::%d\n",
+		    atomic_read(&sdp->sd_reclaim_count));
+	gfs2_printf("sd_log_wraps:log wraps::%"PRIu64"\n",
+		    sdp->sd_log_wraps);
+	gfs2_printf("sd_bio_outstanding:outstanding BIO calls::%u\n",
+		    atomic_read(&sdp->sd_bio_outstanding));
+	gfs2_printf("sd_fh2dentry_misses:fh2dentry misses:diff:%u\n",
+		    handle_roll(&sdp->sd_fh2dentry_misses));
+	gfs2_printf("sd_reclaimed:glocks reclaimed:diff:%u\n",
+		    handle_roll(&sdp->sd_reclaimed));
+	gfs2_printf("sd_log_flush_incore:log incore flushes:diff:%u\n",
+		    handle_roll(&sdp->sd_log_flush_incore));
+	gfs2_printf("sd_log_flush_ondisk:log ondisk flushes:diff:%u\n",
+		    handle_roll(&sdp->sd_log_flush_ondisk));
+	gfs2_printf("sd_glock_nq_calls:glock nq calls:diff:%u\n",
+		    handle_roll(&sdp->sd_glock_nq_calls));
+	gfs2_printf("sd_glock_dq_calls:glock dq calls:diff:%u\n",
+		    handle_roll(&sdp->sd_glock_dq_calls));
+	gfs2_printf("sd_glock_prefetch_calls:glock prefetch calls:diff:%u\n",
+		    handle_roll(&sdp->sd_glock_prefetch_calls));
+	gfs2_printf("sd_lm_lock_calls:lm_lock calls:diff:%u\n",
+		    handle_roll(&sdp->sd_lm_lock_calls));
+	gfs2_printf("sd_lm_unlock_calls:lm_unlock calls:diff:%u\n",
+		    handle_roll(&sdp->sd_lm_unlock_calls));
+	gfs2_printf("sd_lm_callbacks:lm callbacks:diff:%u\n",
+		    handle_roll(&sdp->sd_lm_callbacks));
+	gfs2_printf("sd_ops_address:address operations:diff:%u\n",
+		    handle_roll(&sdp->sd_ops_address));
+	gfs2_printf("sd_ops_dentry:dentry operations:diff:%u\n",
+		    handle_roll(&sdp->sd_ops_dentry));
+	gfs2_printf("sd_ops_export:export operations:diff:%u\n",
+		    handle_roll(&sdp->sd_ops_export));
+	gfs2_printf("sd_ops_file:file operations:diff:%u\n",
+		    handle_roll(&sdp->sd_ops_file));
+	gfs2_printf("sd_ops_inode:inode operations:diff:%u\n",
+		    handle_roll(&sdp->sd_ops_inode));
+	gfs2_printf("sd_ops_super:super operations:diff:%u\n",
+		    handle_roll(&sdp->sd_ops_super));
+	gfs2_printf("sd_ops_vm:vm operations:diff:%u\n",
+		    handle_roll(&sdp->sd_ops_vm));
+	gfs2_printf("sd_bio_reads:block I/O reads:diff:%u\n",
+		    handle_roll(&sdp->sd_bio_reads) >>
+		    (sdp->sd_sb.sb_bsize_shift - 9));
+	gfs2_printf("sd_bio_writes:block I/O writes:diff:%u\n",
+		    handle_roll(&sdp->sd_bio_writes) >>
+		    (sdp->sd_sb.sb_bsize_shift - 9));
+
+	error = 0;
+
+ out:
+	return error;
+}
+
+/**
+ * gi_get_tune - Return current values of the tuneable parameters
+ * @ip:
+ * @gi:
+ * @buf:
+ * @size:
+ * @count:
+ *
+ * Returns: errno
+ */
+
+static int gi_get_tune(struct gfs2_inode *ip, struct gfs2_ioctl *gi,
+		       char *buf, unsigned int size, unsigned int *count)
+{
+	struct gfs2_tune *gt = &ip->i_sbd->sd_tune;
+	int error = -ENOBUFS;
+
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+
+	spin_lock(&gt->gt_spin);
+
+	gfs2_printf("version 0\n");
+	gfs2_printf("ilimit %u\n", gt->gt_ilimit);
+	gfs2_printf("ilimit_tries %u\n", gt->gt_ilimit_tries);
+	gfs2_printf("ilimit_min %u\n", gt->gt_ilimit_min);
+	gfs2_printf("demote_secs %u\n", gt->gt_demote_secs);
+	gfs2_printf("incore_log_blocks %u\n", gt->gt_incore_log_blocks);
+	gfs2_printf("log_flush_secs %u\n", gt->gt_log_flush_secs);
+	gfs2_printf("jindex_refresh_secs %u\n", gt->gt_jindex_refresh_secs);
+	gfs2_printf("scand_secs %u\n", gt->gt_scand_secs);
+	gfs2_printf("recoverd_secs %u\n", gt->gt_recoverd_secs);
+	gfs2_printf("logd_secs %u\n", gt->gt_logd_secs);
+	gfs2_printf("quotad_secs %u\n", gt->gt_quotad_secs);
+	gfs2_printf("inoded_secs %u\n", gt->gt_inoded_secs);
+	gfs2_printf("quota_simul_sync %u\n", gt->gt_quota_simul_sync);
+	gfs2_printf("quota_warn_period %u\n", gt->gt_quota_warn_period);
+	gfs2_printf("quota_scale_num %u\n", gt->gt_quota_scale_num);
+	gfs2_printf("quota_scale_den %u\n", gt->gt_quota_scale_den);
+	gfs2_printf("quota_cache_secs %u\n", gt->gt_quota_cache_secs);
+	gfs2_printf("quota_quantum %u\n", gt->gt_quota_quantum);
+	gfs2_printf("atime_quantum %u\n", gt->gt_atime_quantum);
+	gfs2_printf("new_files_jdata %u\n", gt->gt_new_files_jdata);
+	gfs2_printf("new_files_directio %u\n", gt->gt_new_files_directio);
+	gfs2_printf("max_atomic_write %u\n", gt->gt_max_atomic_write);
+	gfs2_printf("max_readahead %u\n", gt->gt_max_readahead);
+	gfs2_printf("lockdump_size %u\n", gt->gt_lockdump_size);
+	gfs2_printf("stall_secs %u\n", gt->gt_stall_secs);
+	gfs2_printf("complain_secs %u\n", gt->gt_complain_secs);
+	gfs2_printf("reclaim_limit %u\n", gt->gt_reclaim_limit);
+	gfs2_printf("entries_per_readdir %u\n", gt->gt_entries_per_readdir);
+	gfs2_printf("prefetch_secs %u\n", gt->gt_prefetch_secs);
+	gfs2_printf("greedy_default %u\n", gt->gt_greedy_default);
+	gfs2_printf("greedy_quantum %u\n", gt->gt_greedy_quantum);
+	gfs2_printf("greedy_max %u\n", gt->gt_greedy_max);
+	gfs2_printf("statfs_quantum %u\n", gt->gt_statfs_quantum);
+	gfs2_printf("statfs_slow %u\n", gt->gt_statfs_slow);
+
+	error = 0;
+
+ out:
+	spin_unlock(&gt->gt_spin);
+
+	return error;
+}
+
+#define tune_set(f, v) \
+do { \
+	spin_lock(&gt->gt_spin); \
+	gt->f = (v); \
+	spin_unlock(&gt->gt_spin); \
+} while (0)
+
+/**
+ * gi_set_tune - Set a tuneable parameter
+ * @sdp:
+ * @gi:
+ *
+ * Returns: errno
+ */
+
+static int gi_set_tune(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	struct gfs2_tune *gt = &sdp->sd_tune;
+	char param[ARG_SIZE], value[ARG_SIZE];
+	unsigned int x;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (gi->gi_argc != 3)
+		return -EINVAL;
+
+	if (strncpy_from_user(param, gi->gi_argv[1], ARG_SIZE) < 0)
+		return -EFAULT;
+	param[ARG_SIZE - 1] = 0;
+
+	if (strncpy_from_user(value, gi->gi_argv[2], ARG_SIZE) < 0)
+		return -EFAULT;
+	value[ARG_SIZE - 1] = 0;
+
+	if (strcmp(param, "ilimit") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_ilimit, x);
+
+	} else if (strcmp(param, "ilimit_tries") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_ilimit_tries, x);
+
+	} else if (strcmp(param, "ilimit_min") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_ilimit_min, x);
+
+	} else if (strcmp(param, "demote_secs") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_demote_secs, x);
+
+	} else if (strcmp(param, "incore_log_blocks") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_incore_log_blocks, x);
+
+	} else if (strcmp(param, "log_flush_secs") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_log_flush_secs, x);
+
+	} else if (strcmp(param, "jindex_refresh_secs") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_jindex_refresh_secs, x);
+
+	} else if (strcmp(param, "scand_secs") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_scand_secs, x);
+		wake_up_process(sdp->sd_scand_process);
+
+	} else if (strcmp(param, "recoverd_secs") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_recoverd_secs, x);
+		wake_up_process(sdp->sd_recoverd_process);
+
+	} else if (strcmp(param, "logd_secs") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_logd_secs, x);
+		wake_up_process(sdp->sd_logd_process);
+
+	} else if (strcmp(param, "quotad_secs") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_quotad_secs, x);
+		wake_up_process(sdp->sd_quotad_process);
+
+	} else if (strcmp(param, "inoded_secs") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_inoded_secs, x);
+		wake_up_process(sdp->sd_inoded_process);
+
+	} else if (strcmp(param, "quota_simul_sync") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_quota_simul_sync, x);
+
+	} else if (strcmp(param, "quota_warn_period") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_quota_warn_period, x);
+
+	} else if (strcmp(param, "quota_scale") == 0) {
+		unsigned int y;
+		if (sscanf(value, "%u %u", &x, &y) != 2 || !y)
+			return -EINVAL;
+		spin_lock(&gt->gt_spin);
+		gt->gt_quota_scale_num = x;
+		gt->gt_quota_scale_den = y;
+		spin_unlock(&gt->gt_spin);
+
+	} else if (strcmp(param, "quota_cache_secs") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_quota_cache_secs, x);
+
+	} else if (strcmp(param, "quota_quantum") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_quota_quantum, x);
+
+	} else if (strcmp(param, "atime_quantum") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_atime_quantum, x);
+
+	} else if (strcmp(param, "new_files_jdata") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		x = !!x;
+		tune_set(gt_new_files_jdata, x);
+
+	} else if (strcmp(param, "new_files_directio") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		x = !!x;
+		tune_set(gt_new_files_directio, x);
+
+	} else if (strcmp(param, "max_atomic_write") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_max_atomic_write, x);
+
+	} else if (strcmp(param, "max_readahead") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_max_readahead, x);
+
+	} else if (strcmp(param, "lockdump_size") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_lockdump_size, x);
+
+	} else if (strcmp(param, "stall_secs") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_stall_secs, x);
+
+	} else if (strcmp(param, "complain_secs") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_complain_secs, x);
+
+	} else if (strcmp(param, "reclaim_limit") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_reclaim_limit, x);
+
+	} else if (strcmp(param, "entries_per_readdir") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_entries_per_readdir, x);
+
+	} else if (strcmp(param, "prefetch_secs") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_prefetch_secs, x);
+
+	} else if (strcmp(param, "greedy_default") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_greedy_default, x);
+
+	} else if (strcmp(param, "greedy_quantum") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_greedy_quantum, x);
+
+	} else if (strcmp(param, "greedy_max") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_greedy_max, x);
+
+	} else if (strcmp(param, "statfs_quantum") == 0) {
+		if (sscanf(value, "%u", &x) != 1 || !x)
+			return -EINVAL;
+		tune_set(gt_statfs_quantum, x);
+
+	} else if (strcmp(param, "statfs_slow") == 0) {
+		if (sscanf(value, "%u", &x) != 1)
+			return -EINVAL;
+		tune_set(gt_statfs_slow, x);
+
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * gi_do_shrink - throw out unused glocks
+ * @sdp:
+ * @gi:
+ *
+ * Returns: 0
+ */
+
+static int gi_do_shrink(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+	gfs2_gl_hash_clear(sdp, NO_WAIT);
+	return 0;
+}
+
+/**
+ * gi_get_file_stat -
+ * @ip:
+ * @gi:
+ *
+ * Returns: the number of bytes copied, or -errno
+ */
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
+	if (copy_to_user(gi->gi_data, di,
+			 sizeof(struct gfs2_dinode)))
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
+ * gi_set_file_flag - set or clear a flag on a file
+ * @ip:
+ * @gi:
+ *
+ * Returns: errno
+ */
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
+		set = TRUE;
+	else if (strcmp(buf, "clear") == 0)
+		set = FALSE;
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
+	int new = FALSE;
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
+ *		    drop the cache (and lock) for a file.
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
+	if (copy_to_user(gi->gi_data, di,
+			 sizeof(struct gfs2_dinode)))
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
+		user = TRUE;
+		break;
+	case 'g':
+		user = FALSE;
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
+		user = TRUE;
+		break;
+	case 'g':
+		user = FALSE;
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
+/**
+ * gi_do_statfs_sync - sync the outstanding statfs changes for a FS
+ * @sdp:
+ * @gi:
+ *
+ * Returns: errno
+ */
+
+static int gi_do_statfs_sync(struct gfs2_sbd *sdp, struct gfs2_ioctl *gi)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (gi->gi_argc != 1)
+		return -EINVAL;
+	return gfs2_statfs_sync(sdp);
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
+	int put_new_dip = FALSE;
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
+		put_new_dip = TRUE;
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
+/**
+ * gfs2_ioctl_i -
+ * @ip:
+ * @arg:
+ *
+ * Returns: -errno or positive byte count
+ */
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
+	if (copy_from_user(argv, gi.gi_argv,
+			   gi.gi_argc * sizeof(char *)))
+		goto out;
+	gi.gi_argv = argv;
+
+	if (strncpy_from_user(arg0, argv[0], ARG_SIZE) < 0)
+		goto out;
+	arg0[ARG_SIZE - 1] = 0;
+
+	if (strcmp(arg0, "get_cookie") == 0)
+		error = gi_skeleton(ip, &gi, gi_get_cookie);
+	else if (strcmp(arg0, "get_super") == 0)
+		error = gi_get_super(ip->i_sbd, &gi);
+	else if (strcmp(arg0, "get_args") == 0)
+		error = gi_skeleton(ip, &gi, gi_get_args);
+	else if (strcmp(arg0, "get_lockstruct") == 0)
+		error = gi_skeleton(ip, &gi, gi_get_lockstruct);
+	else if (strcmp(arg0, "get_statfs") == 0)
+		error = gi_skeleton(ip, &gi, gi_get_statfs);
+	else if (strcmp(arg0, "get_counters") == 0)
+		error = gi_skeleton(ip, &gi, gi_get_counters);
+	else if (strcmp(arg0, "get_tune") == 0)
+		error = gi_skeleton(ip, &gi, gi_get_tune);
+	else if (strcmp(arg0, "set_tune") == 0)
+		error = gi_set_tune(ip->i_sbd, &gi);
+	else if (strcmp(arg0, "do_shrink") == 0)
+		error = gi_do_shrink(ip->i_sbd, &gi);
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
+	else if (strcmp(arg0, "do_statfs_sync") == 0)
+		error = gi_do_statfs_sync(ip->i_sbd, &gi);
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
--- a/fs/gfs2/ioctl.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ioctl.h	2005-09-01 17:36:55.324114104 +0800
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
--- a/fs/gfs2/sys.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/sys.c	2005-09-01 17:36:55.507086288 +0800
@@ -0,0 +1,201 @@
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
+#include <linux/kobject.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include "gfs2.h"
+#include "lm.h"
+#include "sys.h"
+#include "super.h"
+
+char *gfs2_sys_margs;
+spinlock_t gfs2_sys_margs_lock;
+
+static ssize_t gfs2_id_show(struct gfs2_sbd *sdp, char *buf)
+{
+	return sprintf(buf, "%s\n", sdp->sd_vfs->s_id);
+}
+
+static ssize_t gfs2_fsname_show(struct gfs2_sbd *sdp, char *buf)
+{
+	return sprintf(buf, "%s\n", sdp->sd_fsname);
+}
+
+static ssize_t gfs2_freeze_show(struct gfs2_sbd *sdp, char *buf)
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
+static ssize_t gfs2_freeze_store(struct gfs2_sbd *sdp, const char *buf,
+				 size_t len)
+{
+	ssize_t ret = len;
+	int error = 0;
+	int n = simple_strtol(buf, NULL, 0);
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
+static ssize_t gfs2_withdraw_show(struct gfs2_sbd *sdp, char *buf)
+{
+	unsigned int b = test_bit(SDF_SHUTDOWN, &sdp->sd_flags);
+	return sprintf(buf, "%u\n", b);
+}
+
+static ssize_t gfs2_withdraw_store(struct gfs2_sbd *sdp, const char *buf,
+				   size_t len)
+{
+	ssize_t ret = len;
+	int n = simple_strtol(buf, NULL, 0);
+
+	if (n != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	gfs2_lm_withdraw(sdp,
+		"GFS2: fsid=%s: withdrawing from cluster at user's request\n",
+		sdp->sd_fsname);
+ out:
+	return ret;
+}
+
+struct gfs2_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct gfs2_sbd*, char *);
+	ssize_t (*store)(struct gfs2_sbd*, const char *, size_t);
+};
+
+static struct gfs2_attr gfs2_attr_id = {
+	.attr = {.name = "id", .mode = S_IRUSR},
+	.show = gfs2_id_show
+};
+
+static struct gfs2_attr gfs2_attr_fsname = {
+	.attr = {.name = "fsname", .mode = S_IRUSR},
+	.show = gfs2_fsname_show
+};
+
+static struct gfs2_attr gfs2_attr_freeze = {
+	.attr  = {.name = "freeze", .mode = S_IRUSR | S_IWUSR},
+	.show  = gfs2_freeze_show,
+	.store = gfs2_freeze_store
+};
+
+static struct gfs2_attr gfs2_attr_withdraw = {
+	.attr  = {.name = "withdraw", .mode = S_IRUSR | S_IWUSR},
+	.show  = gfs2_withdraw_show,
+	.store = gfs2_withdraw_store
+};
+
+static struct attribute *gfs2_attrs[] = {
+	&gfs2_attr_id.attr,
+	&gfs2_attr_fsname.attr,
+	&gfs2_attr_freeze.attr,
+	&gfs2_attr_withdraw.attr,
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
+/* FIXME: should this go under /sys/fs/ ? */
+
+static struct kset gfs2_kset = {
+	.subsys = &kernel_subsys,
+	.kobj   = {.name = "gfs2",},
+	.ktype  = &gfs2_ktype,
+};
+
+int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
+{
+	int error;
+
+	error = kobject_set_name(&sdp->sd_kobj, "%s", sdp->sd_fsname);
+	if (error)
+		goto out;
+
+	sdp->sd_kobj.kset = &gfs2_kset;
+	sdp->sd_kobj.ktype = &gfs2_ktype;
+
+	error = kobject_register(&sdp->sd_kobj);
+ out:
+	return error;
+}
+
+void gfs2_sys_fs_del(struct gfs2_sbd *sdp)
+{
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
--- a/fs/gfs2/sys.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/sys.h	2005-09-01 17:36:55.517084768 +0800
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
--- a/fs/gfs2/resize.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/resize.c	2005-09-01 17:36:55.452094648 +0800
@@ -0,0 +1,285 @@
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
--- a/fs/gfs2/resize.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/resize.h	2005-09-01 17:36:55.461093280 +0800
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
--- a/fs/gfs2/mount.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/mount.c	2005-09-01 17:36:55.391103920 +0800
@@ -0,0 +1,209 @@
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
+			args->ar_spectator = TRUE;
+			sdp->sd_vfs->s_flags |= MS_RDONLY;
+
+		} else if (!strcmp(o, "ignore_local_fs")) {
+			if (remount && !args->ar_ignore_local_fs)
+				goto cant_remount;
+			args->ar_ignore_local_fs = TRUE;
+
+		} else if (!strcmp(o, "localflocks")) {
+			if (remount && !args->ar_localflocks)
+				goto cant_remount;
+			args->ar_localflocks = TRUE;
+
+		} else if (!strcmp(o, "localcaching")) {
+			if (remount && !args->ar_localcaching)
+				goto cant_remount;
+			args->ar_localcaching = TRUE;
+
+		} else if (!strcmp(o, "oopses_ok"))
+			args->ar_oopses_ok = TRUE;
+
+		else if (!strcmp(o, "nooopses_ok"))
+			args->ar_oopses_ok = FALSE;
+
+		else if (!strcmp(o, "debug")) {
+			args->ar_debug = TRUE;
+
+		} else if (!strcmp(o, "nodebug"))
+			args->ar_debug = FALSE;
+
+		else if (!strcmp(o, "upgrade")) {
+			if (remount && !args->ar_upgrade)
+				goto cant_remount;
+			args->ar_upgrade = TRUE;
+
+		} else if (!strcmp(o, "num_glockd")) {
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
+			args->ar_posix_acl = TRUE;
+			sdp->sd_vfs->s_flags |= MS_POSIXACL;
+
+		} else if (!strcmp(o, "noacl")) {
+			args->ar_posix_acl = FALSE;
+			sdp->sd_vfs->s_flags &= ~MS_POSIXACL;
+
+		} else if (!strcmp(o, "quota")) {
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
+
+		} else if (!strcmp(o, "suiddir"))
+			args->ar_suiddir = TRUE;
+
+		else if (!strcmp(o, "nosuiddir"))
+			args->ar_suiddir = FALSE;
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
+
+		} else {
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
--- a/fs/gfs2/mount.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/mount.h	2005-09-01 17:36:55.391103920 +0800
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
