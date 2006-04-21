Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWDUQES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWDUQES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWDUQES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:04:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23972 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932374AbWDUQEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:04:10 -0400
Subject: [PATCH 04/16] GFS2: Daemons and address space operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 21 Apr 2006 17:12:29 +0100
Message-Id: <1145635949.3856.100.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 04/16] GFS2: Daemons and address space operations

The GFS2 kernel threads, logging operations and page cache
interface code.


Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>


 fs/gfs2/daemon.c      |  229 ++++++++++++
 fs/gfs2/daemon.h      |   20 +
 fs/gfs2/lops.c        |  805 +++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/lops.h        |   96 +++++
 fs/gfs2/main.c        |  114 ++++++
 fs/gfs2/meta_io.c     |  889 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/meta_io.h     |   89 +++++
 fs/gfs2/ondisk.c      |  517 +++++++++++++++++++++++++++++
 fs/gfs2/ops_address.c |  582 ++++++++++++++++++++++++++++++++
 fs/gfs2/ops_address.h |   17 
 10 files changed, 3358 insertions(+)

--- /dev/null
+++ b/fs/gfs2/daemon.c
@@ -0,0 +1,229 @@
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
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/gfs2_ondisk.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "daemon.h"
+#include "glock.h"
+#include "log.h"
+#include "quota.h"
+#include "recovery.h"
+#include "super.h"
+#include "unlinked.h"
+#include "util.h"
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
+			gfs2_log_flush(sdp, NULL);
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
--- /dev/null
+++ b/fs/gfs2/daemon.h
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
--- /dev/null
+++ b/fs/gfs2/lops.c
@@ -0,0 +1,805 @@
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
+#include <linux/gfs2_ondisk.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "glock.h"
+#include "log.h"
+#include "lops.h"
+#include "meta_io.h"
+#include "recovery.h"
+#include "rgrp.h"
+#include "trans.h"
+#include "util.h"
+
+static void glock_lo_add(struct gfs2_sbd *sdp, struct gfs2_log_element *le)
+{
+	struct gfs2_glock *gl;
+	struct gfs2_trans *tr = current->journal_info;
+
+	tr->tr_touched = 1;
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
+	tr = current->journal_info;
+	tr->tr_touched = 1;
+	tr->tr_num_buf++;
+	list_add(&bd->bd_list_tr, &tr->tr_list_buf);
+
+	if (!list_empty(&le->le_list))
+		return;
+
+	gfs2_trans_add_gl(bd->bd_gl);
+
+	gfs2_meta_check(sdp, bd->bd_bh);
+	gfs2_pin(sdp, bd->bd_bh);
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
+	struct gfs2_log_descriptor *ld;
+	struct gfs2_bufdata *bd1 = NULL, *bd2;
+	unsigned int total = sdp->sd_log_num_buf;
+	unsigned int offset = sizeof(struct gfs2_log_descriptor);
+	unsigned int limit;
+	unsigned int num;
+	unsigned n;
+	__be64 *ptr;
+
+	offset += (sizeof(__be64) - 1);
+	offset &= ~(sizeof(__be64) - 1);
+	limit = (sdp->sd_sb.sb_bsize - offset)/sizeof(__be64);
+	/* for 4k blocks, limit = 503 */
+
+	bd1 = bd2 = list_prepare_entry(bd1, &sdp->sd_log_le_buf, bd_le.le_list);
+	while(total) {
+		num = total;
+		if (total > limit)
+			num = limit;
+		bh = gfs2_log_get_buf(sdp);
+		sdp->sd_log_num_hdrs++;
+		ld = (struct gfs2_log_descriptor *)bh->b_data;
+		ptr = (__be64 *)(bh->b_data + offset);
+		ld->ld_header.mh_magic = cpu_to_be32(GFS2_MAGIC);
+		ld->ld_header.mh_type = cpu_to_be32(GFS2_METATYPE_LD);
+		ld->ld_header.mh_format = cpu_to_be32(GFS2_FORMAT_LD);
+		ld->ld_type = cpu_to_be32(GFS2_LOG_DESC_METADATA);
+		ld->ld_length = cpu_to_be32(num + 1);
+		ld->ld_data1 = cpu_to_be32(num);
+		ld->ld_data2 = cpu_to_be32(0);
+		memset(ld->ld_reserved, 0, sizeof(ld->ld_reserved));
+
+		n = 0;
+		list_for_each_entry_continue(bd1, &sdp->sd_log_le_buf,
+					     bd_le.le_list) {
+			*ptr++ = cpu_to_be64(bd1->bd_bh->b_blocknr);
+			if (++n >= num)
+				break;
+		}
+
+		set_buffer_dirty(bh);
+		ll_rw_block(WRITE, 1, &bh);
+
+		n = 0;
+		list_for_each_entry_continue(bd2, &sdp->sd_log_le_buf,
+					     bd_le.le_list) {
+			bh = gfs2_log_fake_buf(sdp, bd2->bd_bh);
+			set_buffer_dirty(bh);
+			ll_rw_block(WRITE, 1, &bh);
+			if (++n >= num)
+				break;
+		}
+
+		total -= num;
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
+		gfs2_unpin(sdp, bd->bd_bh, ai);
+	}
+	gfs2_assert_warn(sdp, !sdp->sd_log_num_buf);
+}
+
+static void buf_lo_before_scan(struct gfs2_jdesc *jd,
+			       struct gfs2_log_header *head, int pass)
+{
+	struct gfs2_inode *ip = jd->jd_inode->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+
+	if (pass != 0)
+		return;
+
+	sdp->sd_found_blocks = 0;
+	sdp->sd_replayed_blocks = 0;
+}
+
+static int buf_lo_scan_elements(struct gfs2_jdesc *jd, unsigned int start,
+				struct gfs2_log_descriptor *ld, __be64 *ptr,
+				int pass)
+{
+	struct gfs2_inode *ip = jd->jd_inode->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct gfs2_glock *gl = ip->i_gl;
+	unsigned int blks = be32_to_cpu(ld->ld_data1);
+	struct buffer_head *bh_log, *bh_ip;
+	uint64_t blkno;
+	int error = 0;
+
+	if (pass != 1 || be32_to_cpu(ld->ld_type) != GFS2_LOG_DESC_METADATA)
+		return 0;
+
+	gfs2_replay_incr_blk(sdp, &start);
+
+	for (; blks; gfs2_replay_incr_blk(sdp, &start), blks--) {
+		blkno = be64_to_cpu(*ptr++);
+
+		sdp->sd_found_blocks++;
+
+		if (gfs2_revoke_check(sdp, blkno, start))
+			continue;
+
+		error = gfs2_replay_read_block(jd, start, &bh_log);
+                if (error)
+                        return error;
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
+	struct gfs2_inode *ip = jd->jd_inode->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+
+	if (error) {
+		gfs2_meta_sync(ip->i_gl,
+			       DIO_START | DIO_WAIT);
+		return;
+	}
+	if (pass != 1)
+		return;
+
+	gfs2_meta_sync(ip->i_gl, DIO_START | DIO_WAIT);
+
+	fs_info(sdp, "jid=%u: Replayed %u of %u blocks\n",
+	        jd->jd_jid, sdp->sd_replayed_blocks, sdp->sd_found_blocks);
+}
+
+static void revoke_lo_add(struct gfs2_sbd *sdp, struct gfs2_log_element *le)
+{
+	struct gfs2_trans *tr;
+
+	tr = current->journal_info;
+	tr->tr_touched = 1;
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
+	struct gfs2_log_descriptor *ld;
+	struct gfs2_meta_header *mh;
+	struct buffer_head *bh;
+	unsigned int offset;
+	struct list_head *head = &sdp->sd_log_le_revoke;
+	struct gfs2_revoke *rv;
+
+	if (!sdp->sd_log_num_revoke)
+		return;
+
+	bh = gfs2_log_get_buf(sdp);
+	ld = (struct gfs2_log_descriptor *)bh->b_data;
+	ld->ld_header.mh_magic = cpu_to_be32(GFS2_MAGIC);
+	ld->ld_header.mh_type = cpu_to_be32(GFS2_METATYPE_LD);
+	ld->ld_header.mh_format = cpu_to_be32(GFS2_FORMAT_LD);
+	ld->ld_type = cpu_to_be32(GFS2_LOG_DESC_REVOKE);
+	ld->ld_length = cpu_to_be32(gfs2_struct2blk(sdp, sdp->sd_log_num_revoke,
+						    sizeof(uint64_t)));
+	ld->ld_data1 = cpu_to_be32(sdp->sd_log_num_revoke);
+	ld->ld_data2 = cpu_to_be32(0);
+	memset(ld->ld_reserved, 0, sizeof(ld->ld_reserved));
+	offset = sizeof(struct gfs2_log_descriptor);
+
+	while (!list_empty(head)) {
+		rv = list_entry(head->next, struct gfs2_revoke, rv_le.le_list);
+		list_del_init(&rv->rv_le.le_list);
+		sdp->sd_log_num_revoke--;
+
+		if (offset + sizeof(uint64_t) > sdp->sd_sb.sb_bsize) {
+			set_buffer_dirty(bh);
+			ll_rw_block(WRITE, 1, &bh);
+
+			bh = gfs2_log_get_buf(sdp);
+			mh = (struct gfs2_meta_header *)bh->b_data;
+			mh->mh_magic = cpu_to_be32(GFS2_MAGIC);
+			mh->mh_type = cpu_to_be32(GFS2_METATYPE_LB);
+			mh->mh_format = cpu_to_be32(GFS2_FORMAT_LB);
+			offset = sizeof(struct gfs2_meta_header);
+		}
+
+		*(__be64 *)(bh->b_data + offset) = cpu_to_be64(rv->rv_blkno);
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
+	struct gfs2_inode *ip = jd->jd_inode->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+
+	if (pass != 0)
+		return;
+
+	sdp->sd_found_revokes = 0;
+	sdp->sd_replay_tail = head->lh_tail;
+}
+
+static int revoke_lo_scan_elements(struct gfs2_jdesc *jd, unsigned int start,
+				   struct gfs2_log_descriptor *ld, __be64 *ptr,
+				   int pass)
+{
+	struct gfs2_inode *ip = jd->jd_inode->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	unsigned int blks = be32_to_cpu(ld->ld_length);
+	unsigned int revokes = be32_to_cpu(ld->ld_data1);
+	struct buffer_head *bh;
+	unsigned int offset;
+	uint64_t blkno;
+	int first = 1;
+	int error;
+
+	if (pass != 0 || be32_to_cpu(ld->ld_type) != GFS2_LOG_DESC_REVOKE)
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
+			blkno = be64_to_cpu(*(__be64 *)(bh->b_data + offset));
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
+		first = 0;
+	}
+
+	return 0;
+}
+
+static void revoke_lo_after_scan(struct gfs2_jdesc *jd, int error, int pass)
+{
+	struct gfs2_inode *ip = jd->jd_inode->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
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
+	struct gfs2_trans *tr = current->journal_info;
+
+	tr->tr_touched = 1;
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
+/**
+ * databuf_lo_add - Add a databuf to the transaction.
+ *
+ * This is used in two distinct cases:
+ * i) In ordered write mode
+ *    We put the data buffer on a list so that we can ensure that its
+ *    synced to disk at the right time
+ * ii) In journaled data mode
+ *    We need to journal the data block in the same way as metadata in
+ *    the functions above. The difference is that here we have a tag
+ *    which is two __be64's being the block number (as per meta data)
+ *    and a flag which says whether the data block needs escaping or
+ *    not. This means we need a new log entry for each 251 or so data
+ *    blocks, which isn't an enormous overhead but twice as much as
+ *    for normal metadata blocks.
+ */
+static void databuf_lo_add(struct gfs2_sbd *sdp, struct gfs2_log_element *le)
+{
+	struct gfs2_bufdata *bd = container_of(le, struct gfs2_bufdata, bd_le);
+	struct gfs2_trans *tr = current->journal_info;
+	struct address_space *mapping = bd->bd_bh->b_page->mapping;
+	struct gfs2_inode *ip = mapping->host->u.generic_ip;
+
+	tr->tr_touched = 1;
+	if (!list_empty(&bd->bd_list_tr) &&
+	    (ip->i_di.di_flags & GFS2_DIF_JDATA)) {
+		tr->tr_num_buf++;
+		gfs2_trans_add_gl(bd->bd_gl);
+		list_add(&bd->bd_list_tr, &tr->tr_list_buf);
+		gfs2_pin(sdp, bd->bd_bh);
+		tr->tr_num_buf_new++;
+	}
+	gfs2_log_lock(sdp);
+	if (!list_empty(&le->le_list)) {
+		if (ip->i_di.di_flags & GFS2_DIF_JDATA)
+			sdp->sd_log_num_jdata++;
+		sdp->sd_log_num_databuf++;
+		list_add(&le->le_list, &sdp->sd_log_le_databuf);
+	}
+	gfs2_log_unlock(sdp);
+}
+
+static int gfs2_check_magic(struct buffer_head *bh)
+{
+	struct page *page = bh->b_page;
+	void *kaddr;
+	__be32 *ptr;
+	int rv = 0;
+
+	kaddr = kmap_atomic(page, KM_USER0);
+	ptr = kaddr + bh_offset(bh);
+	if (*ptr == cpu_to_be32(GFS2_MAGIC))
+		rv = 1;
+	kunmap_atomic(page, KM_USER0);
+
+	return rv;
+}
+
+/**
+ * databuf_lo_before_commit - Scan the data buffers, writing as we go
+ *
+ * Here we scan through the lists of buffers and make the assumption
+ * that any buffer thats been pinned is being journaled, and that
+ * any unpinned buffer is an ordered write data buffer and therefore
+ * will be written back rather than journaled.
+ */
+static void databuf_lo_before_commit(struct gfs2_sbd *sdp)
+{
+	LIST_HEAD(started);
+	struct gfs2_bufdata *bd1 = NULL, *bd2, *bdt;
+	struct buffer_head *bh = NULL;
+	unsigned int offset = sizeof(struct gfs2_log_descriptor);
+	struct gfs2_log_descriptor *ld;
+	unsigned int limit;
+	unsigned int total_dbuf = sdp->sd_log_num_databuf;
+	unsigned int total_jdata = sdp->sd_log_num_jdata;
+	unsigned int num, n;
+	__be64 *ptr = NULL;
+
+	offset += (2*sizeof(__be64) - 1);
+	offset &= ~(2*sizeof(__be64) - 1);
+	limit = (sdp->sd_sb.sb_bsize - offset)/sizeof(__be64);
+
+	/*
+	 * Start writing ordered buffers, write journaled buffers
+	 * into the log along with a header
+	 */
+	gfs2_log_lock(sdp);
+	bd2 = bd1 = list_prepare_entry(bd1, &sdp->sd_log_le_databuf,
+				       bd_le.le_list);
+	while(total_dbuf) {
+		num = total_jdata;
+		if (num > limit)
+			num = limit;
+		n = 0;
+		list_for_each_entry_safe_continue(bd1, bdt,
+						  &sdp->sd_log_le_databuf,
+						  bd_le.le_list) {
+			/* An ordered write buffer */
+			if (bd1->bd_bh && !buffer_pinned(bd1->bd_bh)) {
+				list_move(&bd1->bd_le.le_list, &started);
+				if (bd1 == bd2) {
+					bd2 = NULL;
+					bd2 = list_prepare_entry(bd2,
+							&sdp->sd_log_le_databuf,
+							bd_le.le_list);
+				}
+				total_dbuf--;
+				if (bd1->bd_bh) {
+					get_bh(bd1->bd_bh);
+					if (buffer_dirty(bd1->bd_bh)) {
+						gfs2_log_unlock(sdp);
+						wait_on_buffer(bd1->bd_bh);
+						ll_rw_block(WRITE, 1,
+							    &bd1->bd_bh);
+						gfs2_log_lock(sdp);
+					}
+					brelse(bd1->bd_bh);
+					continue;
+				}
+				continue;
+			} else if (bd1->bd_bh) { /* A journaled buffer */
+				int magic;
+				gfs2_log_unlock(sdp);
+				if (!bh) {
+					bh = gfs2_log_get_buf(sdp);
+					sdp->sd_log_num_hdrs++;
+					ld = (struct gfs2_log_descriptor *)
+					     bh->b_data;
+					ptr = (__be64 *)(bh->b_data + offset);
+					ld->ld_header.mh_magic =
+						cpu_to_be32(GFS2_MAGIC);
+					ld->ld_header.mh_type =
+						cpu_to_be32(GFS2_METATYPE_LD);
+					ld->ld_header.mh_format =
+						cpu_to_be32(GFS2_FORMAT_LD);
+					ld->ld_type =
+						cpu_to_be32(GFS2_LOG_DESC_JDATA);
+					ld->ld_length = cpu_to_be32(num + 1);
+					ld->ld_data1 = cpu_to_be32(num);
+					ld->ld_data2 = cpu_to_be32(0);
+					memset(ld->ld_reserved, 0, sizeof(ld->ld_reserved));
+				}
+				magic = gfs2_check_magic(bd1->bd_bh);
+				*ptr++ = cpu_to_be64(bd1->bd_bh->b_blocknr);
+				*ptr++ = cpu_to_be64((__u64)magic);
+				clear_buffer_escaped(bd1->bd_bh);
+				if (unlikely(magic != 0))
+					set_buffer_escaped(bd1->bd_bh);
+				gfs2_log_lock(sdp);
+				if (n++ > num)
+					break;
+			}
+		}
+		gfs2_log_unlock(sdp);
+		if (bh) {
+			set_buffer_dirty(bh);
+			ll_rw_block(WRITE, 1, &bh);
+			bh = NULL;
+		}
+		n = 0;
+		gfs2_log_lock(sdp);
+		list_for_each_entry_continue(bd2, &sdp->sd_log_le_databuf,
+					     bd_le.le_list) {
+			if (!bd2->bd_bh)
+				continue;
+			/* copy buffer if it needs escaping */
+			gfs2_log_unlock(sdp);
+			if (unlikely(buffer_escaped(bd2->bd_bh))) {
+				void *kaddr;
+				struct page *page = bd2->bd_bh->b_page;
+				bh = gfs2_log_get_buf(sdp);
+				kaddr = kmap_atomic(page, KM_USER0);
+				memcpy(bh->b_data,
+				       kaddr + bh_offset(bd2->bd_bh),
+				       sdp->sd_sb.sb_bsize);
+				kunmap_atomic(page, KM_USER0);
+				*(__be32 *)bh->b_data = 0;
+			} else {
+				bh = gfs2_log_fake_buf(sdp, bd2->bd_bh);
+			}
+			set_buffer_dirty(bh);
+			ll_rw_block(WRITE, 1, &bh);
+			gfs2_log_lock(sdp);
+			if (++n >= num)
+				break;
+		}
+		bh = NULL;
+		total_dbuf -= num;
+		total_jdata -= num;
+	}
+	gfs2_log_unlock(sdp);
+
+	/* Wait on all ordered buffers */
+	while (!list_empty(&started)) {
+		gfs2_log_lock(sdp);
+		bd1 = list_entry(started.next, struct gfs2_bufdata,
+				 bd_le.le_list);
+		list_del(&bd1->bd_le.le_list);
+		sdp->sd_log_num_databuf--;
+
+		bh = bd1->bd_bh;
+		if (bh) {
+			bh->b_private = NULL;
+			gfs2_log_unlock(sdp);
+			wait_on_buffer(bh);
+			brelse(bh);
+		} else
+			gfs2_log_unlock(sdp);
+
+		kfree(bd1);
+	}
+
+	/* We've removed all the ordered write bufs here, so only jdata left */
+	gfs2_assert_warn(sdp, sdp->sd_log_num_databuf == sdp->sd_log_num_jdata);
+}
+
+static int databuf_lo_scan_elements(struct gfs2_jdesc *jd, unsigned int start,
+				    struct gfs2_log_descriptor *ld,
+				    __be64 *ptr, int pass)
+{
+	struct gfs2_inode *ip = jd->jd_inode->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct gfs2_glock *gl = ip->i_gl;
+	unsigned int blks = be32_to_cpu(ld->ld_data1);
+	struct buffer_head *bh_log, *bh_ip;
+	uint64_t blkno;
+	uint64_t esc;
+	int error = 0;
+
+	if (pass != 1 || be32_to_cpu(ld->ld_type) != GFS2_LOG_DESC_JDATA)
+		return 0;
+
+	gfs2_replay_incr_blk(sdp, &start);
+	for (; blks; gfs2_replay_incr_blk(sdp, &start), blks--) {
+		blkno = be64_to_cpu(*ptr++);
+		esc = be64_to_cpu(*ptr++);
+
+		sdp->sd_found_blocks++;
+
+		if (gfs2_revoke_check(sdp, blkno, start))
+			continue;
+
+		error = gfs2_replay_read_block(jd, start, &bh_log);
+		if (error)
+			return error;
+
+		bh_ip = gfs2_meta_new(gl, blkno);
+		memcpy(bh_ip->b_data, bh_log->b_data, bh_log->b_size);
+
+		/* Unescape */
+		if (esc) {
+			__be32 *eptr = (__be32 *)bh_ip->b_data;
+			*eptr = cpu_to_be32(GFS2_MAGIC);
+		}
+		mark_buffer_dirty(bh_ip);
+
+		brelse(bh_log);
+		brelse(bh_ip);
+		if (error)
+			break;
+
+		sdp->sd_replayed_blocks++;
+	}
+
+	return error;
+}
+
+/* FIXME: sort out accounting for log blocks etc. */
+
+static void databuf_lo_after_scan(struct gfs2_jdesc *jd, int error, int pass)
+{
+	struct gfs2_inode *ip = jd->jd_inode->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+
+	if (error) {
+		gfs2_meta_sync(ip->i_gl,
+			       DIO_START | DIO_WAIT);
+		return;
+	}
+	if (pass != 1)
+		return;
+
+	/* data sync? */
+	gfs2_meta_sync(ip->i_gl, DIO_START | DIO_WAIT);
+
+	fs_info(sdp, "jid=%u: Replayed %u of %u data blocks\n",
+		jd->jd_jid, sdp->sd_replayed_blocks, sdp->sd_found_blocks);
+}
+
+static void databuf_lo_after_commit(struct gfs2_sbd *sdp, struct gfs2_ail *ai)
+{
+	struct list_head *head = &sdp->sd_log_le_databuf;
+	struct gfs2_bufdata *bd;
+
+	while (!list_empty(head)) {
+		bd = list_entry(head->next, struct gfs2_bufdata, bd_le.le_list);
+		list_del(&bd->bd_le.le_list);
+		sdp->sd_log_num_databuf--;
+		sdp->sd_log_num_jdata--;
+		gfs2_unpin(sdp, bd->bd_bh, ai);
+	}
+	gfs2_assert_warn(sdp, !sdp->sd_log_num_databuf);
+	gfs2_assert_warn(sdp, !sdp->sd_log_num_jdata);
+}
+
+
+const struct gfs2_log_operations gfs2_glock_lops = {
+	.lo_add = glock_lo_add,
+	.lo_after_commit = glock_lo_after_commit,
+	.lo_name = "glock"
+};
+
+const struct gfs2_log_operations gfs2_buf_lops = {
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
+const struct gfs2_log_operations gfs2_revoke_lops = {
+	.lo_add = revoke_lo_add,
+	.lo_before_commit = revoke_lo_before_commit,
+	.lo_before_scan = revoke_lo_before_scan,
+	.lo_scan_elements = revoke_lo_scan_elements,
+	.lo_after_scan = revoke_lo_after_scan,
+	.lo_name = "revoke"
+};
+
+const struct gfs2_log_operations gfs2_rg_lops = {
+	.lo_add = rg_lo_add,
+	.lo_after_commit = rg_lo_after_commit,
+	.lo_name = "rg"
+};
+
+const struct gfs2_log_operations gfs2_databuf_lops = {
+	.lo_add = databuf_lo_add,
+	.lo_incore_commit = buf_lo_incore_commit,
+	.lo_before_commit = databuf_lo_before_commit,
+	.lo_after_commit = databuf_lo_after_commit,
+	.lo_scan_elements = databuf_lo_scan_elements,
+	.lo_after_scan = databuf_lo_after_scan,
+	.lo_name = "databuf"
+};
+
+const struct gfs2_log_operations *gfs2_log_ops[] = {
+	&gfs2_glock_lops,
+	&gfs2_buf_lops,
+	&gfs2_revoke_lops,
+	&gfs2_rg_lops,
+	&gfs2_databuf_lops,
+	NULL
+};
+
--- /dev/null
+++ b/fs/gfs2/lops.h
@@ -0,0 +1,96 @@
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
+extern const struct gfs2_log_operations gfs2_glock_lops;
+extern const struct gfs2_log_operations gfs2_buf_lops;
+extern const struct gfs2_log_operations gfs2_revoke_lops;
+extern const struct gfs2_log_operations gfs2_rg_lops;
+extern const struct gfs2_log_operations gfs2_databuf_lops;
+
+extern const struct gfs2_log_operations *gfs2_log_ops[];
+
+static inline void lops_init_le(struct gfs2_log_element *le,
+				const struct gfs2_log_operations *lops)
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
+				     __be64 *ptr,
+				     unsigned int pass)
+{
+	int x, error;
+	for (x = 0; gfs2_log_ops[x]; x++)
+		if (gfs2_log_ops[x]->lo_scan_elements) {
+			error = gfs2_log_ops[x]->lo_scan_elements(jd, start,
+								  ld, ptr, pass);
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
--- /dev/null
+++ b/fs/gfs2/main.c
@@ -0,0 +1,114 @@
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
+#include <linux/init.h>
+#include <linux/gfs2_ondisk.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "ops_fstype.h"
+#include "sys.h"
+#include "util.h"
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
+	gfs2_init_lmh();
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
+	error = register_filesystem(&gfs2meta_fs_type);
+	if (error)
+		goto fail_unregister;
+
+	printk("GFS2 (built %s %s) installed\n", __DATE__, __TIME__);
+
+	return 0;
+
+fail_unregister:
+	unregister_filesystem(&gfs2_fs_type);
+fail:
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
+	unregister_filesystem(&gfs2meta_fs_type);
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
--- /dev/null
+++ b/fs/gfs2/meta_io.c
@@ -0,0 +1,889 @@
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
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/writeback.h>
+#include <linux/swap.h>
+#include <linux/delay.h>
+#include <linux/gfs2_ondisk.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "glock.h"
+#include "glops.h"
+#include "inode.h"
+#include "log.h"
+#include "lops.h"
+#include "meta_io.h"
+#include "rgrp.h"
+#include "trans.h"
+#include "util.h"
+
+#define buffer_busy(bh) \
+((bh)->b_state & ((1ul << BH_Dirty) | (1ul << BH_Lock) | (1ul << BH_Pinned)))
+#define buffer_in_io(bh) \
+((bh)->b_state & ((1ul << BH_Dirty) | (1ul << BH_Lock)))
+
+static int aspace_get_block(struct inode *inode, sector_t lblock,
+			    struct buffer_head *bh_result, int create)
+{
+	gfs2_assert_warn(inode->i_sb->s_fs_info, 0);
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
+	struct inode *inode = bh->b_page->mapping->host;
+	struct gfs2_sbd *sdp = inode->i_sb->s_fs_info;
+	struct gfs2_bufdata *bd = bh->b_private;
+	struct gfs2_glock *gl;
+
+	fs_warn(sdp, "stuck in gfs2_releasepage() %p\n", inode);
+	fs_warn(sdp, "blkno = %llu, bh->b_count = %d\n",
+		(uint64_t)bh->b_blocknr, atomic_read(&bh->b_count));
+	fs_warn(sdp, "pinned = %u\n", buffer_pinned(bh));
+	fs_warn(sdp, "bh->b_private = %s\n", (bd) ? "!NULL" : "NULL");
+
+	if (!bd)
+		return;
+
+	gl = bd->bd_gl;
+
+	fs_warn(sdp, "gl = (%u, %llu)\n", 
+		gl->gl_name.ln_type, gl->gl_name.ln_number);
+
+	fs_warn(sdp, "bd_list_tr = %s, bd_le.le_list = %s\n",
+		(list_empty(&bd->bd_list_tr)) ? "no" : "yes",
+		(list_empty(&bd->bd_le.le_list)) ? "no" : "yes");
+
+	if (gl->gl_ops == &gfs2_inode_glops) {
+		struct gfs2_inode *ip = gl->gl_object;
+		unsigned int x;
+
+		if (!ip)
+			return;
+
+		fs_warn(sdp, "ip = %llu %llu\n",
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
+static int gfs2_aspace_releasepage(struct page *page, gfp_t gfp_mask)
+{
+	struct inode *aspace = page->mapping->host;
+	struct gfs2_sbd *sdp = aspace->i_sb->s_fs_info;
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
+		bd = bh->b_private;
+		if (bd) {
+			gfs2_assert_warn(sdp, bd->bd_bh == bh);
+			gfs2_assert_warn(sdp, list_empty(&bd->bd_list_tr));
+			gfs2_assert_warn(sdp, list_empty(&bd->bd_le.le_list));
+			gfs2_assert_warn(sdp, !bd->bd_ail);
+			kmem_cache_free(gfs2_bufdata_cachep, bd);
+			bh->b_private = NULL;
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
+		aspace->u.generic_ip = NULL;
+		insert_inode_hash(aspace);
+	}
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
+	struct gfs2_bufdata *bd, *s;
+	struct buffer_head *bh;
+	int retry;
+
+	BUG_ON(!spin_is_locked(&sdp->sd_log_lock));
+
+	do {
+		retry = 0;
+
+		list_for_each_entry_safe_reverse(bd, s, &ai->ai_ail1_list,
+						 bd_ail_st_list) {
+			bh = bd->bd_bh;
+
+			gfs2_assert(sdp, bd->bd_ail == ai);
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
+			list_move(&bd->bd_ail_st_list, &ai->ai_ail1_list);
+
+			gfs2_log_unlock(sdp);
+			wait_on_buffer(bh);
+			ll_rw_block(WRITE, 1, &bh);
+			gfs2_log_lock(sdp);
+
+			retry = 1;
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
+	struct gfs2_bufdata *bd, *s;
+	struct buffer_head *bh;
+
+	list_for_each_entry_safe_reverse(bd, s, &ai->ai_ail1_list,
+					 bd_ail_st_list) {
+		bh = bd->bd_bh;
+
+		gfs2_assert(sdp, bd->bd_ail == ai);
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
+	return list_empty(&ai->ai_ail1_list);
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
+		gfs2_assert(sdp, bd->bd_ail == ai);
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
+	gfs2_log_flush(sdp, NULL);
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
+ * @create: 1 if the buffer should be created
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
+	mh->mh_magic = cpu_to_be32(GFS2_MAGIC);
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
+			struct gfs2_trans *tr = current->journal_info;
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
+ * gfs2_attach_bufdata - attach a struct gfs2_bufdata structure to a buffer
+ * @gl: the glock the buffer belongs to
+ * @bh: The buffer to be attached to
+ * @meta: Flag to indicate whether its metadata or not
+ */
+
+void gfs2_attach_bufdata(struct gfs2_glock *gl, struct buffer_head *bh,
+			 int meta)
+{
+	struct gfs2_bufdata *bd;
+
+	if (meta)
+		lock_page(bh->b_page);
+
+	if (bh->b_private) {
+		if (meta)
+			unlock_page(bh->b_page);
+		return;
+	}
+
+	bd = kmem_cache_alloc(gfs2_bufdata_cachep, GFP_NOFS | __GFP_NOFAIL),
+	memset(bd, 0, sizeof(struct gfs2_bufdata));
+
+	bd->bd_bh = bh;
+	bd->bd_gl = gl;
+
+	INIT_LIST_HEAD(&bd->bd_list_tr);
+	if (meta) {
+		lops_init_le(&bd->bd_le, &gfs2_buf_lops);
+	} else {
+		lops_init_le(&bd->bd_le, &gfs2_databuf_lops);
+		get_bh(bh);
+	}
+	bh->b_private = bd;
+
+	if (meta)
+		unlock_page(bh->b_page);
+}
+
+/**
+ * gfs2_pin - Pin a buffer in memory
+ * @sdp: the filesystem the buffer belongs to
+ * @bh: The buffer to be pinned
+ *
+ */
+
+void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh)
+{
+	struct gfs2_bufdata *bd = bh->b_private;
+
+	gfs2_assert_withdraw(sdp, test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));
+
+	if (test_set_buffer_pinned(bh))
+		gfs2_assert_withdraw(sdp, 0);
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
+ * gfs2_unpin - Unpin a buffer
+ * @sdp: the filesystem the buffer belongs to
+ * @bh: The buffer to unpin
+ * @ai:
+ *
+ */
+
+void gfs2_unpin(struct gfs2_sbd *sdp, struct buffer_head *bh,
+	        struct gfs2_ail *ai)
+{
+	struct gfs2_bufdata *bd = bh->b_private;
+
+	gfs2_assert_withdraw(sdp, buffer_uptodate(bh));
+
+	if (!buffer_pinned(bh))
+		gfs2_assert_withdraw(sdp, 0);
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
+			struct gfs2_bufdata *bd = bh->b_private;
+
+			if (test_clear_buffer_pinned(bh)) {
+				struct gfs2_trans *tr = current->journal_info;
+				gfs2_log_lock(sdp);
+				list_del_init(&bd->bd_le.le_list);
+				gfs2_assert_warn(sdp, sdp->sd_log_num_buf);
+				sdp->sd_log_num_buf--;
+				gfs2_log_unlock(sdp);
+				tr->tr_num_buf_rm++;
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
+		gfs2_trans_add_bh(ip->i_gl, bh, 1);
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
+	uint32_t max_ra = gfs2_tune_get(sdp, gt_max_readahead) >>
+			  sdp->sd_sb.sb_bsize_shift;
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
+	gfs2_log_flush(sdp, NULL);
+	for (;;) {
+		gfs2_ail1_start(sdp, DIO_ALL);
+		if (gfs2_ail1_empty(sdp, DIO_ALL))
+			break;
+		msleep(10);
+	}
+}
+
--- /dev/null
+++ b/fs/gfs2/meta_io.h
@@ -0,0 +1,89 @@
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
+void gfs2_attach_bufdata(struct gfs2_glock *gl, struct buffer_head *bh,
+			 int meta);
+void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh);
+void gfs2_unpin(struct gfs2_sbd *sdp, struct buffer_head *bh,
+		struct gfs2_ail *ai);
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
+	return gfs2_meta_indirect_buffer(ip, 0, ip->i_num.no_addr, 0, bhp);
+}
+
+void gfs2_meta_ra(struct gfs2_glock *gl, uint64_t dblock, uint32_t extlen);
+void gfs2_meta_syncfs(struct gfs2_sbd *sdp);
+
+#endif /* __DIO_DOT_H__ */
+
--- /dev/null
+++ b/fs/gfs2/ondisk.c
@@ -0,0 +1,517 @@
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
+#include <linux/gfs2_ondisk.h>
+
+#define pv(struct, member, fmt) printk(KERN_INFO "  "#member" = "fmt"\n", \
+				       struct->member);
+#define pa(struct, member, count) print_array(#member, struct->member, count);
+
+/**
+ * print_array - Print out an array of bytes
+ * @title: what to print before the array
+ * @buf: the array
+ * @count: the number of bytes
+ *
+ */
+
+static void print_array(char *title, char *buf, int count)
+{
+	int x;
+
+	printk(KERN_INFO "  %s =\n" KERN_INFO, title);
+	for (x = 0; x < count; x++) {
+		printk("%.2X ", (unsigned char)buf[x]);
+		if (x % 16 == 15)
+			printk("\n" KERN_INFO);
+	}
+	if (x % 16)
+		printk("\n");
+}
+
+/*
+ * gfs2_xxx_in - read in an xxx struct
+ * first arg: the cpu-order structure
+ * buf: the disk-order buffer
+ *
+ * gfs2_xxx_out - write out an xxx struct
+ * first arg: the cpu-order structure
+ * buf: the disk-order buffer
+ *
+ * gfs2_xxx_print - print out an xxx struct
+ * first arg: the cpu-order structure
+ */
+
+void gfs2_inum_in(struct gfs2_inum *no, char *buf)
+{
+	struct gfs2_inum *str = (struct gfs2_inum *)buf;
+
+	no->no_formal_ino = be64_to_cpu(str->no_formal_ino);
+	no->no_addr = be64_to_cpu(str->no_addr);
+}
+
+void gfs2_inum_out(const struct gfs2_inum *no, char *buf)
+{
+	struct gfs2_inum *str = (struct gfs2_inum *)buf;
+
+	str->no_formal_ino = cpu_to_be64(no->no_formal_ino);
+	str->no_addr = cpu_to_be64(no->no_addr);
+}
+
+void gfs2_inum_print(struct gfs2_inum *no)
+{
+	pv(no, no_formal_ino, "%llu");
+	pv(no, no_addr, "%llu");
+}
+
+static void gfs2_meta_header_in(struct gfs2_meta_header *mh, char *buf)
+{
+	struct gfs2_meta_header *str = (struct gfs2_meta_header *)buf;
+
+	mh->mh_magic = be32_to_cpu(str->mh_magic);
+	mh->mh_type = be32_to_cpu(str->mh_type);
+	mh->mh_format = be32_to_cpu(str->mh_format);
+}
+
+static void gfs2_meta_header_out(struct gfs2_meta_header *mh, char *buf)
+{
+	struct gfs2_meta_header *str = (struct gfs2_meta_header *)buf;
+
+	str->mh_magic = cpu_to_be32(mh->mh_magic);
+	str->mh_type = cpu_to_be32(mh->mh_type);
+	str->mh_format = cpu_to_be32(mh->mh_format);
+}
+
+void gfs2_meta_header_print(struct gfs2_meta_header *mh)
+{
+	pv(mh, mh_magic, "0x%.8X");
+	pv(mh, mh_type, "%u");
+	pv(mh, mh_format, "%u");
+}
+
+void gfs2_sb_in(struct gfs2_sb *sb, char *buf)
+{
+	struct gfs2_sb *str = (struct gfs2_sb *)buf;
+
+	gfs2_meta_header_in(&sb->sb_header, buf);
+
+	sb->sb_fs_format = be32_to_cpu(str->sb_fs_format);
+	sb->sb_multihost_format = be32_to_cpu(str->sb_multihost_format);
+	sb->sb_bsize = be32_to_cpu(str->sb_bsize);
+	sb->sb_bsize_shift = be32_to_cpu(str->sb_bsize_shift);
+
+	gfs2_inum_in(&sb->sb_master_dir, (char *)&str->sb_master_dir);
+	gfs2_inum_in(&sb->sb_root_dir, (char *)&str->sb_root_dir);
+
+	memcpy(sb->sb_lockproto, str->sb_lockproto, GFS2_LOCKNAME_LEN);
+	memcpy(sb->sb_locktable, str->sb_locktable, GFS2_LOCKNAME_LEN);
+}
+
+void gfs2_sb_print(struct gfs2_sb *sb)
+{
+	gfs2_meta_header_print(&sb->sb_header);
+
+	pv(sb, sb_fs_format, "%u");
+	pv(sb, sb_multihost_format, "%u");
+
+	pv(sb, sb_bsize, "%u");
+	pv(sb, sb_bsize_shift, "%u");
+
+	gfs2_inum_print(&sb->sb_master_dir);
+
+	pv(sb, sb_lockproto, "%s");
+	pv(sb, sb_locktable, "%s");
+}
+
+void gfs2_rindex_in(struct gfs2_rindex *ri, char *buf)
+{
+	struct gfs2_rindex *str = (struct gfs2_rindex *)buf;
+
+	ri->ri_addr = be64_to_cpu(str->ri_addr);
+	ri->ri_length = be32_to_cpu(str->ri_length);
+	ri->ri_data0 = be64_to_cpu(str->ri_data0);
+	ri->ri_data = be32_to_cpu(str->ri_data);
+	ri->ri_bitbytes = be32_to_cpu(str->ri_bitbytes);
+
+}
+
+void gfs2_rindex_out(struct gfs2_rindex *ri, char *buf)
+{
+	struct gfs2_rindex *str = (struct gfs2_rindex *)buf;
+
+	str->ri_addr = cpu_to_be64(ri->ri_addr);
+	str->ri_length = cpu_to_be32(ri->ri_length);
+	str->__pad = 0;
+
+	str->ri_data0 = cpu_to_be64(ri->ri_data0);
+	str->ri_data = cpu_to_be32(ri->ri_data);
+	str->ri_bitbytes = cpu_to_be32(ri->ri_bitbytes);
+	memset(str->ri_reserved, 0, sizeof(str->ri_reserved));
+}
+
+void gfs2_rindex_print(struct gfs2_rindex *ri)
+{
+	pv(ri, ri_addr, "%llu");
+	pv(ri, ri_length, "%u");
+
+	pv(ri, ri_data0, "%llu");
+	pv(ri, ri_data, "%u");
+
+	pv(ri, ri_bitbytes, "%u");
+}
+
+void gfs2_rgrp_in(struct gfs2_rgrp *rg, char *buf)
+{
+	struct gfs2_rgrp *str = (struct gfs2_rgrp *)buf;
+
+	gfs2_meta_header_in(&rg->rg_header, buf);
+	rg->rg_flags = be32_to_cpu(str->rg_flags);
+	rg->rg_free = be32_to_cpu(str->rg_free);
+	rg->rg_dinodes = be32_to_cpu(str->rg_dinodes);
+}
+
+void gfs2_rgrp_out(struct gfs2_rgrp *rg, char *buf)
+{
+	struct gfs2_rgrp *str = (struct gfs2_rgrp *)buf;
+
+	gfs2_meta_header_out(&rg->rg_header, buf);
+	str->rg_flags = cpu_to_be32(rg->rg_flags);
+	str->rg_free = cpu_to_be32(rg->rg_free);
+	str->rg_dinodes = cpu_to_be32(rg->rg_dinodes);
+
+	memset(&str->rg_reserved, 0, sizeof(str->rg_reserved));
+}
+
+void gfs2_rgrp_print(struct gfs2_rgrp *rg)
+{
+	gfs2_meta_header_print(&rg->rg_header);
+	pv(rg, rg_flags, "%u");
+	pv(rg, rg_free, "%u");
+	pv(rg, rg_dinodes, "%u");
+
+	pa(rg, rg_reserved, 36);
+}
+
+void gfs2_quota_in(struct gfs2_quota *qu, char *buf)
+{
+	struct gfs2_quota *str = (struct gfs2_quota *)buf;
+
+	qu->qu_limit = be64_to_cpu(str->qu_limit);
+	qu->qu_warn = be64_to_cpu(str->qu_warn);
+	qu->qu_value = be64_to_cpu(str->qu_value);
+}
+
+void gfs2_quota_out(struct gfs2_quota *qu, char *buf)
+{
+	struct gfs2_quota *str = (struct gfs2_quota *)buf;
+
+	str->qu_limit = cpu_to_be64(qu->qu_limit);
+	str->qu_warn = cpu_to_be64(qu->qu_warn);
+	str->qu_value = cpu_to_be64(qu->qu_value);
+}
+
+void gfs2_quota_print(struct gfs2_quota *qu)
+{
+	pv(qu, qu_limit, "%llu");
+	pv(qu, qu_warn, "%llu");
+	pv(qu, qu_value, "%lld");
+}
+
+void gfs2_dinode_in(struct gfs2_dinode *di, char *buf)
+{
+	struct gfs2_dinode *str = (struct gfs2_dinode *)buf;
+
+	gfs2_meta_header_in(&di->di_header, buf);
+	gfs2_inum_in(&di->di_num, (char *)&str->di_num);
+
+	di->di_mode = be32_to_cpu(str->di_mode);
+	di->di_uid = be32_to_cpu(str->di_uid);
+	di->di_gid = be32_to_cpu(str->di_gid);
+	di->di_nlink = be32_to_cpu(str->di_nlink);
+	di->di_size = be64_to_cpu(str->di_size);
+	di->di_blocks = be64_to_cpu(str->di_blocks);
+	di->di_atime = be64_to_cpu(str->di_atime);
+	di->di_mtime = be64_to_cpu(str->di_mtime);
+	di->di_ctime = be64_to_cpu(str->di_ctime);
+	di->di_major = be32_to_cpu(str->di_major);
+	di->di_minor = be32_to_cpu(str->di_minor);
+
+	di->di_goal_meta = be64_to_cpu(str->di_goal_meta);
+	di->di_goal_data = be64_to_cpu(str->di_goal_data);
+
+	di->di_flags = be32_to_cpu(str->di_flags);
+	di->di_payload_format = be32_to_cpu(str->di_payload_format);
+	di->di_height = be16_to_cpu(str->di_height);
+
+	di->di_depth = be16_to_cpu(str->di_depth);
+	di->di_entries = be32_to_cpu(str->di_entries);
+
+	di->di_eattr = be64_to_cpu(str->di_eattr);
+
+}
+
+void gfs2_dinode_out(struct gfs2_dinode *di, char *buf)
+{
+	struct gfs2_dinode *str = (struct gfs2_dinode *)buf;
+
+	gfs2_meta_header_out(&di->di_header, buf);
+	gfs2_inum_out(&di->di_num, (char *)&str->di_num);
+
+	str->di_mode = cpu_to_be32(di->di_mode);
+	str->di_uid = cpu_to_be32(di->di_uid);
+	str->di_gid = cpu_to_be32(di->di_gid);
+	str->di_nlink = cpu_to_be32(di->di_nlink);
+	str->di_size = cpu_to_be64(di->di_size);
+	str->di_blocks = cpu_to_be64(di->di_blocks);
+	str->di_atime = cpu_to_be64(di->di_atime);
+	str->di_mtime = cpu_to_be64(di->di_mtime);
+	str->di_ctime = cpu_to_be64(di->di_ctime);
+	str->di_major = cpu_to_be32(di->di_major);
+	str->di_minor = cpu_to_be32(di->di_minor);
+
+	str->di_goal_meta = cpu_to_be64(di->di_goal_meta);
+	str->di_goal_data = cpu_to_be64(di->di_goal_data);
+
+	str->di_flags = cpu_to_be32(di->di_flags);
+	str->di_payload_format = cpu_to_be32(di->di_payload_format);
+	str->di_height = cpu_to_be16(di->di_height);
+
+	str->di_depth = cpu_to_be16(di->di_depth);
+	str->di_entries = cpu_to_be32(di->di_entries);
+
+	str->di_eattr = cpu_to_be64(di->di_eattr);
+
+}
+
+void gfs2_dinode_print(struct gfs2_dinode *di)
+{
+	gfs2_meta_header_print(&di->di_header);
+	gfs2_inum_print(&di->di_num);
+
+	pv(di, di_mode, "0%o");
+	pv(di, di_uid, "%u");
+	pv(di, di_gid, "%u");
+	pv(di, di_nlink, "%u");
+	pv(di, di_size, "%llu");
+	pv(di, di_blocks, "%llu");
+	pv(di, di_atime, "%lld");
+	pv(di, di_mtime, "%lld");
+	pv(di, di_ctime, "%lld");
+	pv(di, di_major, "%u");
+	pv(di, di_minor, "%u");
+
+	pv(di, di_goal_meta, "%llu");
+	pv(di, di_goal_data, "%llu");
+
+	pv(di, di_flags, "0x%.8X");
+	pv(di, di_payload_format, "%u");
+	pv(di, di_height, "%u");
+
+	pv(di, di_depth, "%u");
+	pv(di, di_entries, "%u");
+
+	pv(di, di_eattr, "%llu");
+}
+
+void gfs2_dirent_print(struct gfs2_dirent *de, char *name)
+{
+	char buf[GFS2_FNAMESIZE + 1];
+
+	gfs2_inum_print(&de->de_inum);
+	pv(de, de_hash, "0x%.8X");
+	pv(de, de_rec_len, "%u");
+	pv(de, de_name_len, "%u");
+	pv(de, de_type, "%u");
+
+	memset(buf, 0, GFS2_FNAMESIZE + 1);
+	memcpy(buf, name, de->de_name_len);
+	printk(KERN_INFO "  name = %s\n", buf);
+}
+
+void gfs2_leaf_print(struct gfs2_leaf *lf)
+{
+	gfs2_meta_header_print(&lf->lf_header);
+	pv(lf, lf_depth, "%u");
+	pv(lf, lf_entries, "%u");
+	pv(lf, lf_dirent_format, "%u");
+	pv(lf, lf_next, "%llu");
+
+	pa(lf, lf_reserved, 32);
+}
+
+void gfs2_ea_header_in(struct gfs2_ea_header *ea, char *buf)
+{
+	struct gfs2_ea_header *str = (struct gfs2_ea_header *)buf;
+
+	ea->ea_rec_len = be32_to_cpu(str->ea_rec_len);
+	ea->ea_data_len = be32_to_cpu(str->ea_data_len);
+	ea->ea_name_len = str->ea_name_len;
+	ea->ea_type = str->ea_type;
+	ea->ea_flags = str->ea_flags;
+	ea->ea_num_ptrs = str->ea_num_ptrs;
+}
+
+void gfs2_ea_header_out(struct gfs2_ea_header *ea, char *buf)
+{
+	struct gfs2_ea_header *str = (struct gfs2_ea_header *)buf;
+
+	str->ea_rec_len = cpu_to_be32(ea->ea_rec_len);
+	str->ea_data_len = cpu_to_be32(ea->ea_data_len);
+	str->ea_name_len = ea->ea_name_len;
+	str->ea_type = ea->ea_type;
+	str->ea_flags = ea->ea_flags;
+	str->ea_num_ptrs = ea->ea_num_ptrs;
+	str->__pad = 0;
+}
+
+void gfs2_ea_header_print(struct gfs2_ea_header *ea, char *name)
+{
+	char buf[GFS2_EA_MAX_NAME_LEN + 1];
+
+	pv(ea, ea_rec_len, "%u");
+	pv(ea, ea_data_len, "%u");
+	pv(ea, ea_name_len, "%u");
+	pv(ea, ea_type, "%u");
+	pv(ea, ea_flags, "%u");
+	pv(ea, ea_num_ptrs, "%u");
+
+	memset(buf, 0, GFS2_EA_MAX_NAME_LEN + 1);
+	memcpy(buf, name, ea->ea_name_len);
+	printk(KERN_INFO "  name = %s\n", buf);
+}
+
+void gfs2_log_header_in(struct gfs2_log_header *lh, char *buf)
+{
+	struct gfs2_log_header *str = (struct gfs2_log_header *)buf;
+
+	gfs2_meta_header_in(&lh->lh_header, buf);
+	lh->lh_sequence = be64_to_cpu(str->lh_sequence);
+	lh->lh_flags = be32_to_cpu(str->lh_flags);
+	lh->lh_tail = be32_to_cpu(str->lh_tail);
+	lh->lh_blkno = be32_to_cpu(str->lh_blkno);
+	lh->lh_hash = be32_to_cpu(str->lh_hash);
+}
+
+void gfs2_log_header_print(struct gfs2_log_header *lh)
+{
+	gfs2_meta_header_print(&lh->lh_header);
+	pv(lh, lh_sequence, "%llu");
+	pv(lh, lh_flags, "0x%.8X");
+	pv(lh, lh_tail, "%u");
+	pv(lh, lh_blkno, "%u");
+	pv(lh, lh_hash, "0x%.8X");
+}
+
+void gfs2_log_descriptor_print(struct gfs2_log_descriptor *ld)
+{
+	gfs2_meta_header_print(&ld->ld_header);
+	pv(ld, ld_type, "%u");
+	pv(ld, ld_length, "%u");
+	pv(ld, ld_data1, "%u");
+	pv(ld, ld_data2, "%u");
+
+	pa(ld, ld_reserved, 32);
+}
+
+void gfs2_inum_range_in(struct gfs2_inum_range *ir, char *buf)
+{
+	struct gfs2_inum_range *str = (struct gfs2_inum_range *)buf;
+
+	ir->ir_start = be64_to_cpu(str->ir_start);
+	ir->ir_length = be64_to_cpu(str->ir_length);
+}
+
+void gfs2_inum_range_out(struct gfs2_inum_range *ir, char *buf)
+{
+	struct gfs2_inum_range *str = (struct gfs2_inum_range *)buf;
+
+	str->ir_start = cpu_to_be64(ir->ir_start);
+	str->ir_length = cpu_to_be64(ir->ir_length);
+}
+
+void gfs2_inum_range_print(struct gfs2_inum_range *ir)
+{
+	pv(ir, ir_start, "%llu");
+	pv(ir, ir_length, "%llu");
+}
+
+void gfs2_statfs_change_in(struct gfs2_statfs_change *sc, char *buf)
+{
+	struct gfs2_statfs_change *str = (struct gfs2_statfs_change *)buf;
+
+	sc->sc_total = be64_to_cpu(str->sc_total);
+	sc->sc_free = be64_to_cpu(str->sc_free);
+	sc->sc_dinodes = be64_to_cpu(str->sc_dinodes);
+}
+
+void gfs2_statfs_change_out(struct gfs2_statfs_change *sc, char *buf)
+{
+	struct gfs2_statfs_change *str = (struct gfs2_statfs_change *)buf;
+
+	str->sc_total = cpu_to_be64(sc->sc_total);
+	str->sc_free = cpu_to_be64(sc->sc_free);
+	str->sc_dinodes = cpu_to_be64(sc->sc_dinodes);
+}
+
+void gfs2_statfs_change_print(struct gfs2_statfs_change *sc)
+{
+	pv(sc, sc_total, "%lld");
+	pv(sc, sc_free, "%lld");
+	pv(sc, sc_dinodes, "%lld");
+}
+
+void gfs2_unlinked_tag_in(struct gfs2_unlinked_tag *ut, char *buf)
+{
+	struct gfs2_unlinked_tag *str = (struct gfs2_unlinked_tag *)buf;
+
+	gfs2_inum_in(&ut->ut_inum, buf);
+	ut->ut_flags = be32_to_cpu(str->ut_flags);
+}
+
+void gfs2_unlinked_tag_out(struct gfs2_unlinked_tag *ut, char *buf)
+{
+	struct gfs2_unlinked_tag *str = (struct gfs2_unlinked_tag *)buf;
+
+	gfs2_inum_out(&ut->ut_inum, buf);
+	str->ut_flags = cpu_to_be32(ut->ut_flags);
+	str->__pad = 0;
+}
+
+void gfs2_unlinked_tag_print(struct gfs2_unlinked_tag *ut)
+{
+	gfs2_inum_print(&ut->ut_inum);
+	pv(ut, ut_flags, "%u");
+}
+
+void gfs2_quota_change_in(struct gfs2_quota_change *qc, char *buf)
+{
+	struct gfs2_quota_change *str = (struct gfs2_quota_change *)buf;
+
+	qc->qc_change = be64_to_cpu(str->qc_change);
+	qc->qc_flags = be32_to_cpu(str->qc_flags);
+	qc->qc_id = be32_to_cpu(str->qc_id);
+}
+
+void gfs2_quota_change_print(struct gfs2_quota_change *qc)
+{
+	pv(qc, qc_change, "%lld");
+	pv(qc, qc_flags, "0x%.8X");
+	pv(qc, qc_id, "%u");
+}
+
+
+
--- /dev/null
+++ b/fs/gfs2/ops_address.c
@@ -0,0 +1,582 @@
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
+#include <linux/pagemap.h>
+#include <linux/mpage.h>
+#include <linux/fs.h>
+#include <linux/gfs2_ondisk.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "bmap.h"
+#include "glock.h"
+#include "inode.h"
+#include "log.h"
+#include "meta_io.h"
+#include "ops_address.h"
+#include "page.h"
+#include "quota.h"
+#include "trans.h"
+#include "rgrp.h"
+#include "ops_file.h"
+#include "util.h"
+
+/**
+ * gfs2_get_block - Fills in a buffer head with details about a block
+ * @inode: The inode
+ * @lblock: The block number to look up
+ * @bh_result: The buffer head to return the result in
+ * @create: Non-zero if we may add block to the file
+ *
+ * Returns: errno
+ */
+
+int gfs2_get_block(struct inode *inode, sector_t lblock,
+	           struct buffer_head *bh_result, int create)
+{
+	struct gfs2_inode *ip = inode->u.generic_ip;
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
+	struct gfs2_inode *ip = inode->u.generic_ip;
+	int new = 0;
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
+/**
+ * gfs2_writepage - Write complete page
+ * @page: Page to write
+ *
+ * Returns: errno
+ *
+ * Some of this is copied from block_write_full_page() although we still
+ * call it to do most of the work.
+ */
+
+static int gfs2_writepage(struct page *page, struct writeback_control *wbc)
+{
+	struct inode *inode = page->mapping->host;
+	struct gfs2_inode *ip = page->mapping->host->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	loff_t i_size = i_size_read(inode);
+	pgoff_t end_index = i_size >> PAGE_CACHE_SHIFT;
+	unsigned offset;
+	int error;
+	int done_trans = 0;
+
+	if (gfs2_assert_withdraw(sdp, gfs2_glock_is_held_excl(ip->i_gl))) {
+		unlock_page(page);
+		return -EIO;
+	}
+	if (current->journal_info)
+		goto out_ignore;
+
+	/* Is the page fully outside i_size? (truncate in progress) */
+        offset = i_size & (PAGE_CACHE_SIZE-1);
+	if (page->index >= end_index+1 || !offset) {
+		page->mapping->a_ops->invalidatepage(page, 0);
+		unlock_page(page);
+		return 0; /* don't care */
+	}
+
+	if (sdp->sd_args.ar_data == GFS2_DATA_ORDERED || gfs2_is_jdata(ip)) {
+		error = gfs2_trans_begin(sdp, RES_DINODE + 1, 0);
+		if (error)
+			goto out_ignore;
+		gfs2_page_add_databufs(ip, page, 0, sdp->sd_vfs->s_blocksize-1);
+		done_trans = 1;
+	}
+	error = block_write_full_page(page, get_block_noalloc, wbc);
+	if (done_trans)
+		gfs2_trans_end(sdp);
+	gfs2_meta_cache_flush(ip);
+	return error;
+
+out_ignore:
+	redirty_page_for_writepage(wbc, page);
+	unlock_page(page);
+	return 0;
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
+	kaddr = kmap_atomic(page, KM_USER0);
+	memcpy((char *)kaddr,
+	       dibh->b_data + sizeof(struct gfs2_dinode),
+	       ip->i_di.di_size);
+	memset((char *)kaddr + ip->i_di.di_size,
+	       0,
+	       PAGE_CACHE_SIZE - ip->i_di.di_size);
+	kunmap_atomic(page, KM_USER0);
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
+	kaddr = kmap_atomic(page, KM_USER0);
+	memset(kaddr, 0, PAGE_CACHE_SIZE);
+	kunmap_atomic(page, KM_USER0);
+
+	SetPageUptodate(page);
+	unlock_page(page);
+
+	return 0;
+}
+
+/**
+ * gfs2_readpage - readpage with locking
+ * @file: The file to read a page for. N.B. This may be NULL if we are
+ * reading an internal file.
+ * @page: The page to read
+ *
+ * Returns: errno
+ */
+
+static int gfs2_readpage(struct file *file, struct page *page)
+{
+	struct gfs2_inode *ip = page->mapping->host->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct gfs2_holder gh;
+	int error;
+
+	if (file != &gfs2_internal_file_sentinal) {
+		gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME|GL_AOP, &gh);
+		error = gfs2_glock_nq_m_atime(1, &gh);
+		if (error)
+			goto out_unlock;
+	}
+
+	if (gfs2_is_stuffed(ip)) {
+		if (!page->index) {
+			error = stuffed_readpage(ip, page);
+			unlock_page(page);
+		} else
+			error = zero_readpage(page);
+	} else
+		error = mpage_readpage(page, gfs2_get_block);
+
+	if (unlikely(test_bit(SDF_SHUTDOWN, &sdp->sd_flags)))
+		error = -EIO;
+
+	if (file != &gfs2_internal_file_sentinal) {
+		gfs2_glock_dq_m(1, &gh);
+		gfs2_holder_uninit(&gh);
+	}
+out:
+	return error;
+out_unlock:
+	unlock_page(page);
+	goto out;
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
+	struct gfs2_inode *ip = page->mapping->host->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	unsigned int data_blocks, ind_blocks, rblocks;
+	int alloc_required;
+	int error = 0;
+	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + from;
+	loff_t end = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
+	struct gfs2_alloc *al;
+
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_ATIME|GL_AOP, &ip->i_gh);
+	error = gfs2_glock_nq_m_atime(1, &ip->i_gh);
+	if (error)
+		goto out_uninit;
+
+	gfs2_write_calc_reserv(ip, to - from, &data_blocks, &ind_blocks);
+
+	error = gfs2_write_alloc_required(ip, pos, from - to, &alloc_required);
+	if (error)
+		goto out_unlock;
+
+
+	if (alloc_required) {
+		al = gfs2_alloc_get(ip);
+
+		error = gfs2_quota_lock(ip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
+		if (error)
+			goto out_alloc_put;
+
+		error = gfs2_quota_check(ip, ip->i_di.di_uid, ip->i_di.di_gid);
+		if (error)
+			goto out_qunlock;
+
+		al->al_requested = data_blocks + ind_blocks;
+		error = gfs2_inplace_reserve(ip);
+		if (error)
+			goto out_qunlock;
+	}
+
+	rblocks = RES_DINODE + ind_blocks;
+	if (gfs2_is_jdata(ip))
+		rblocks += data_blocks ? data_blocks : 1;
+	if (ind_blocks || data_blocks)
+		rblocks += RES_STATFS + RES_QUOTA;
+
+	error = gfs2_trans_begin(sdp, rblocks, 0);
+	if (error)
+		goto out;
+
+	if (gfs2_is_stuffed(ip)) {
+		if (end > sdp->sd_sb.sb_bsize - sizeof(struct gfs2_dinode)) {
+			error = gfs2_unstuff_dinode(ip, gfs2_unstuffer_page,
+						    page);
+			if (error == 0)
+				goto prepare_write;
+		} else if (!PageUptodate(page))
+			error = stuffed_readpage(ip, page);
+		goto out;
+	}
+
+prepare_write:
+	error = block_prepare_write(page, from, to, gfs2_get_block);
+
+out:
+	if (error) {
+		gfs2_trans_end(sdp);
+		if (alloc_required) {
+			gfs2_inplace_release(ip);
+out_qunlock:
+			gfs2_quota_unlock(ip);
+out_alloc_put:
+			gfs2_alloc_put(ip);
+		}
+out_unlock:
+		gfs2_glock_dq_m(1, &ip->i_gh);
+out_uninit:
+		gfs2_holder_uninit(&ip->i_gh);
+	}
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
+	struct gfs2_inode *ip = inode->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	int error = -EOPNOTSUPP;
+	struct buffer_head *dibh;
+	struct gfs2_alloc *al = &ip->i_alloc;;
+
+	if (gfs2_assert_withdraw(sdp, gfs2_glock_is_locked_by_me(ip->i_gl)))
+                goto fail_nounlock;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		goto fail_endtrans;
+
+	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
+
+	if (gfs2_is_stuffed(ip)) {
+		uint64_t file_size;
+		void *kaddr;
+
+		file_size = ((uint64_t)page->index << PAGE_CACHE_SHIFT) + to;
+
+		kaddr = kmap_atomic(page, KM_USER0);
+		memcpy(dibh->b_data + sizeof(struct gfs2_dinode) + from,
+		       (char *)kaddr + from, to - from);
+		kunmap_atomic(page, KM_USER0);
+
+		SetPageUptodate(page);
+
+		if (inode->i_size < file_size)
+			i_size_write(inode, file_size);
+	} else {
+		if (sdp->sd_args.ar_data == GFS2_DATA_ORDERED ||
+		    gfs2_is_jdata(ip))
+			gfs2_page_add_databufs(ip, page, from, to);
+		error = generic_commit_write(file, page, from, to);
+		if (error)
+			goto fail;
+	}
+
+	if (ip->i_di.di_size < inode->i_size)
+		ip->i_di.di_size = inode->i_size;
+
+	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	brelse(dibh);
+	gfs2_trans_end(sdp);
+	if (al->al_requested) {
+		gfs2_inplace_release(ip);
+		gfs2_quota_unlock(ip);
+		gfs2_alloc_put(ip);
+	}
+	gfs2_glock_dq_m(1, &ip->i_gh);
+	gfs2_holder_uninit(&ip->i_gh);
+	return 0;
+
+fail:
+	brelse(dibh);
+fail_endtrans:
+	gfs2_trans_end(sdp);
+	if (al->al_requested) {
+		gfs2_inplace_release(ip);
+		gfs2_quota_unlock(ip);
+		gfs2_alloc_put(ip);
+	}
+	gfs2_glock_dq_m(1, &ip->i_gh);
+	gfs2_holder_uninit(&ip->i_gh);
+fail_nounlock:
+	ClearPageUptodate(page);
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
+	struct gfs2_inode *ip = mapping->host->u.generic_ip;
+	struct gfs2_holder i_gh;
+	sector_t dblock = 0;
+	int error;
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
+	if (error)
+		return 0;
+
+	if (!gfs2_is_stuffed(ip))
+		dblock = generic_block_bmap(mapping, lblock, gfs2_get_block);
+
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return dblock;
+}
+
+static void discard_buffer(struct gfs2_sbd *sdp, struct buffer_head *bh)
+{
+	struct gfs2_bufdata *bd;
+
+	gfs2_log_lock(sdp);
+	bd = bh->b_private;
+	if (bd) {
+		bd->bd_bh = NULL;
+		bh->b_private = NULL;
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
+static void gfs2_invalidatepage(struct page *page, unsigned long offset)
+{
+	struct gfs2_sbd *sdp = page->mapping->host->i_sb->s_fs_info;
+	struct buffer_head *head, *bh, *next;
+	unsigned int curr_off = 0;
+
+	BUG_ON(!PageLocked(page));
+	if (!page_has_buffers(page))
+		return;
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
+		try_to_release_page(page, 0);
+
+	return;
+}
+
+static ssize_t gfs2_direct_IO_write(struct kiocb *iocb, const struct iovec *iov,
+				    loff_t offset, unsigned long nr_segs)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	struct gfs2_inode *ip = inode->u.generic_ip;
+	struct gfs2_holder gh;
+	int rv;
+
+	/*
+	 * Shared lock, even though its write, since we do no allocation
+	 * on this path. All we need change is atime.
+	 */
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME, &gh);
+	rv = gfs2_glock_nq_m_atime(1, &gh);
+	if (rv)
+		goto out;
+
+	/*
+	 * Should we return an error here? I can't see that O_DIRECT for
+	 * a journaled file makes any sense. For now we'll silently fall
+	 * back to buffered I/O, likewise we do the same for stuffed
+	 * files since they are (a) small and (b) unaligned.
+	 */
+	if (gfs2_is_jdata(ip))
+		goto out;
+
+	if (gfs2_is_stuffed(ip))
+		goto out;
+
+	rv = __blockdev_direct_IO(WRITE, iocb, inode, inode->i_sb->s_bdev,
+				  iov, offset, nr_segs, gfs2_get_block,
+				  NULL, DIO_OWN_LOCKING);
+out:
+	gfs2_glock_dq_m(1, &gh);
+	gfs2_holder_uninit(&gh);
+
+	return rv;
+}
+
+/**
+ * gfs2_direct_IO
+ *
+ * This is called with a shared lock already held for the read path.
+ * Currently, no locks are held when the write path is called.
+ */
+static ssize_t gfs2_direct_IO(int rw, struct kiocb *iocb,
+			      const struct iovec *iov, loff_t offset,
+			      unsigned long nr_segs)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	struct gfs2_inode *ip = inode->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+
+	if (rw == WRITE)
+		return gfs2_direct_IO_write(iocb, iov, offset, nr_segs);
+
+	if (gfs2_assert_warn(sdp, gfs2_glock_is_locked_by_me(ip->i_gl)) ||
+	    gfs2_assert_warn(sdp, !gfs2_is_stuffed(ip)))
+		return -EINVAL;
+
+	return __blockdev_direct_IO(READ, iocb, inode, inode->i_sb->s_bdev, iov,
+			 	    offset, nr_segs, gfs2_get_block, NULL,
+				    DIO_OWN_LOCKING);
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
--- /dev/null
+++ b/fs/gfs2/ops_address.h
@@ -0,0 +1,17 @@
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
+extern int gfs2_get_block(struct inode *inode, sector_t lblock,
+			  struct buffer_head *bh_result, int create);
+
+#endif /* __OPS_ADDRESS_DOT_H__ */


