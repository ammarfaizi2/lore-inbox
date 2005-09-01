Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbVIANuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbVIANuL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbVIANuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:50:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51908 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965108AbVIANuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:50:01 -0400
Date: Thu, 1 Sep 2005 21:55:52 +0800
From: David Teigland <teigland@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] GFS: logging and recovery
Message-ID: <20050901135552.GI25581@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A per-node on-disk log is used for recovery.

Signed-off-by: Ken Preslan <ken@preslan.org>
Signed-off-by: David Teigland <teigland@redhat.com>

---

 fs/gfs2/log.c      |  670 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/log.h      |   68 +++++
 fs/gfs2/recovery.c |  561 ++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/recovery.h |   32 ++
 4 files changed, 1331 insertions(+)

--- a/fs/gfs2/log.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/log.c	2005-09-01 17:36:55.338111976 +0800
@@ -0,0 +1,670 @@
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
+#include "log.h"
+#include "lops.h"
+#include "meta_io.h"
+
+#define PULL 1
+
+static inline int is_done(struct gfs2_sbd *sdp, atomic_t *a)
+{
+	int done;
+	gfs2_log_lock(sdp);
+	done = atomic_read(a) ? FALSE : TRUE;
+	gfs2_log_unlock(sdp);
+	return done;
+}
+
+static void do_lock_wait(struct gfs2_sbd *sdp, wait_queue_head_t *wq,
+			 atomic_t *a)
+{
+	gfs2_log_unlock(sdp);
+	wait_event(*wq, is_done(sdp, a));
+	gfs2_log_lock(sdp);
+}
+
+static void lock_for_trans(struct gfs2_sbd *sdp)
+{
+	gfs2_log_lock(sdp);
+	do_lock_wait(sdp, &sdp->sd_log_trans_wq, &sdp->sd_log_flush_count);
+	atomic_inc(&sdp->sd_log_trans_count);
+	gfs2_log_unlock(sdp);
+}
+
+static void unlock_from_trans(struct gfs2_sbd *sdp)
+{
+	gfs2_assert_warn(sdp, atomic_read(&sdp->sd_log_trans_count));
+	if (atomic_dec_and_test(&sdp->sd_log_trans_count))
+		wake_up(&sdp->sd_log_flush_wq);
+}
+
+void gfs2_lock_for_flush(struct gfs2_sbd *sdp)
+{
+	gfs2_log_lock(sdp);
+	atomic_inc(&sdp->sd_log_flush_count);
+	do_lock_wait(sdp, &sdp->sd_log_flush_wq, &sdp->sd_log_trans_count);
+	gfs2_log_unlock(sdp);
+}
+
+void gfs2_unlock_from_flush(struct gfs2_sbd *sdp)
+{
+	gfs2_assert_warn(sdp, atomic_read(&sdp->sd_log_flush_count));
+	if (atomic_dec_and_test(&sdp->sd_log_flush_count))
+		wake_up(&sdp->sd_log_trans_wq);
+}
+
+/**
+ * gfs2_struct2blk - compute stuff
+ * @sdp: the filesystem
+ * @nstruct: the number of structures
+ * @ssize: the size of the structures
+ *
+ * Compute the number of log descriptor blocks needed to hold a certain number
+ * of structures of a certain size.
+ *
+ * Returns: the number of blocks needed (minimum is always 1)
+ */
+
+unsigned int gfs2_struct2blk(struct gfs2_sbd *sdp, unsigned int nstruct,
+			     unsigned int ssize)
+{
+	unsigned int blks;
+	unsigned int first, second;
+
+	blks = 1;
+	first = (sdp->sd_sb.sb_bsize - sizeof(struct gfs2_log_descriptor)) / ssize;
+
+	if (nstruct > first) {
+		second = (sdp->sd_sb.sb_bsize - sizeof(struct gfs2_meta_header)) / ssize;
+		blks += DIV_RU(nstruct - first, second);
+	}
+
+	return blks;
+}
+
+void gfs2_ail1_start(struct gfs2_sbd *sdp, int flags)
+{
+	struct list_head *head = &sdp->sd_ail1_list;
+	uint64_t sync_gen;
+	struct list_head *first, *tmp;
+	struct gfs2_ail *first_ai, *ai;
+
+	gfs2_log_lock(sdp);
+	if (list_empty(head)) {
+		gfs2_log_unlock(sdp);
+		return;
+	}
+	sync_gen = sdp->sd_ail_sync_gen++;
+
+	first = head->prev;
+	first_ai = list_entry(first, struct gfs2_ail, ai_list);
+	first_ai->ai_sync_gen = sync_gen;
+	gfs2_ail1_start_one(sdp, first_ai);
+
+	if (flags & DIO_ALL)
+		first = NULL;
+
+	for (;;) {
+		if (first &&
+		    (head->prev != first ||
+		     gfs2_ail1_empty_one(sdp, first_ai, 0)))
+			break;
+
+		for (tmp = head->prev; tmp != head; tmp = tmp->prev) {
+			ai = list_entry(tmp, struct gfs2_ail, ai_list);
+			if (ai->ai_sync_gen >= sync_gen)
+				continue;
+			ai->ai_sync_gen = sync_gen;
+			gfs2_ail1_start_one(sdp, ai);
+			break;
+		}
+
+		if (tmp == head)
+			break;
+	}
+
+	gfs2_log_unlock(sdp);
+}
+
+int gfs2_ail1_empty(struct gfs2_sbd *sdp, int flags)
+{
+	struct list_head *head, *tmp, *prev;
+	struct gfs2_ail *ai;
+	int ret;
+
+	gfs2_log_lock(sdp);
+
+	for (head = &sdp->sd_ail1_list, tmp = head->prev, prev = tmp->prev;
+	     tmp != head;
+	     tmp = prev, prev = tmp->prev) {
+		ai = list_entry(tmp, struct gfs2_ail, ai_list);
+		if (gfs2_ail1_empty_one(sdp, ai, flags))
+			list_move(&ai->ai_list, &sdp->sd_ail2_list);
+		else if (!(flags & DIO_ALL))
+			break;
+	}
+
+	ret = list_empty(head);
+
+	gfs2_log_unlock(sdp);
+
+	return ret;
+}
+
+static void ail2_empty(struct gfs2_sbd *sdp, unsigned int new_tail)
+{
+	struct list_head *head, *tmp, *next;
+	struct gfs2_ail *ai;
+	unsigned int old_tail = sdp->sd_log_tail;
+	int wrap = (new_tail < old_tail);
+	int a, b, rm;
+
+	gfs2_log_lock(sdp);
+
+	for (head = &sdp->sd_ail2_list, tmp = head->next, next = tmp->next;
+	     tmp != head;
+	     tmp = next, next = tmp->next) {
+		ai = list_entry(tmp, struct gfs2_ail, ai_list);
+
+		a = (old_tail <= ai->ai_first);
+		b = (ai->ai_first < new_tail);
+		rm = (wrap) ? (a || b) : (a && b);
+		if (!rm)
+			continue;
+
+		gfs2_ail2_empty_one(sdp, ai);
+		list_del(&ai->ai_list);
+		gfs2_assert_warn(sdp, list_empty(&ai->ai_ail1_list));
+		gfs2_assert_warn(sdp, list_empty(&ai->ai_ail2_list));
+		kfree(ai);
+	}
+
+	gfs2_log_unlock(sdp);
+}
+
+/**
+ * gfs2_log_reserve - Make a log reservation
+ * @sdp: The GFS2 superblock
+ * @blks: The number of blocks to reserve
+ *
+ * Returns: errno
+ */
+
+int gfs2_log_reserve(struct gfs2_sbd *sdp, unsigned int blks)
+{
+	LIST_HEAD(list);
+	unsigned int try = 0;
+
+	if (gfs2_assert_warn(sdp, blks) ||
+	    gfs2_assert_warn(sdp, blks <= sdp->sd_jdesc->jd_blocks))
+		return -EINVAL;
+
+	for (;;) {
+		gfs2_log_lock(sdp);
+
+		if (list_empty(&list)) {
+			list_add_tail(&list, &sdp->sd_log_blks_list);
+			while (sdp->sd_log_blks_list.next != &list) {
+				DECLARE_WAITQUEUE(__wait_chan, current);
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				add_wait_queue(&sdp->sd_log_blks_wait,
+					       &__wait_chan);
+				gfs2_log_unlock(sdp);
+				schedule();
+				gfs2_log_lock(sdp);
+				remove_wait_queue(&sdp->sd_log_blks_wait,
+						  &__wait_chan);
+				set_current_state(TASK_RUNNING);
+			}
+		}
+
+		/* Never give away the last block so we can
+		   always pull the tail if we need to. */
+		if (sdp->sd_log_blks_free > blks) {
+			sdp->sd_log_blks_free -= blks;
+			list_del(&list);
+			gfs2_log_unlock(sdp);
+			wake_up(&sdp->sd_log_blks_wait);
+			break;
+		}
+
+		gfs2_log_unlock(sdp);
+
+		gfs2_ail1_empty(sdp, 0);
+		gfs2_log_flush(sdp);
+
+		if (try++)
+			gfs2_ail1_start(sdp, 0);
+	}
+
+	lock_for_trans(sdp);
+
+	return 0;
+}
+
+/**
+ * gfs2_log_release - Release a given number of log blocks
+ * @sdp: The GFS2 superblock
+ * @blks: The number of blocks
+ *
+ */
+
+void gfs2_log_release(struct gfs2_sbd *sdp, unsigned int blks)
+{
+	unlock_from_trans(sdp);
+
+	gfs2_log_lock(sdp);
+	sdp->sd_log_blks_free += blks;
+	gfs2_assert_withdraw(sdp,
+			     sdp->sd_log_blks_free <= sdp->sd_jdesc->jd_blocks);
+	gfs2_log_unlock(sdp);
+}
+
+static uint64_t log_bmap(struct gfs2_sbd *sdp, unsigned int lbn)
+{
+	int new = FALSE;
+	uint64_t dbn;
+	int error;
+
+	error = gfs2_block_map(sdp->sd_jdesc->jd_inode, lbn, &new, &dbn, NULL);
+	gfs2_assert_withdraw(sdp, !error && dbn);
+
+	return dbn;
+}
+
+/**
+ * log_distance - Compute distance between two journal blocks
+ * @sdp: The GFS2 superblock
+ * @newer: The most recent journal block of the pair
+ * @older: The older journal block of the pair
+ *
+ *   Compute the distance (in the journal direction) between two
+ *   blocks in the journal
+ *
+ * Returns: the distance in blocks
+ */
+
+static inline unsigned int log_distance(struct gfs2_sbd *sdp,
+					unsigned int newer,
+					unsigned int older)
+{
+	int dist;
+
+	dist = newer - older;
+	if (dist < 0)
+		dist += sdp->sd_jdesc->jd_blocks;
+
+	return dist;
+}
+
+static unsigned int current_tail(struct gfs2_sbd *sdp)
+{
+	struct gfs2_ail *ai;
+	unsigned int tail;
+
+	gfs2_log_lock(sdp);
+
+	if (list_empty(&sdp->sd_ail1_list))
+		tail = sdp->sd_log_head;
+	else {
+		ai = list_entry(sdp->sd_ail1_list.prev,
+				struct gfs2_ail, ai_list);
+		tail = ai->ai_first;
+	}
+
+	gfs2_log_unlock(sdp);
+
+	return tail;
+}
+
+static inline void log_incr_head(struct gfs2_sbd *sdp)
+{
+	if (sdp->sd_log_flush_head == sdp->sd_log_tail)
+		gfs2_assert_withdraw(sdp,
+				sdp->sd_log_flush_head == sdp->sd_log_head);
+
+	if (++sdp->sd_log_flush_head == sdp->sd_jdesc->jd_blocks) {
+		sdp->sd_log_flush_head = 0;
+		sdp->sd_log_flush_wrapped = TRUE;
+	}
+}
+
+/**
+ * gfs2_log_get_buf - Get and initialize a buffer to use for log control data
+ * @sdp: The GFS2 superblock
+ *
+ * Returns: the buffer_head
+ */
+
+struct buffer_head *gfs2_log_get_buf(struct gfs2_sbd *sdp)
+{
+	uint64_t blkno = log_bmap(sdp, sdp->sd_log_flush_head);
+	struct gfs2_log_buf *lb;
+	struct buffer_head *bh;
+
+	lb = kzalloc(sizeof(struct gfs2_log_buf), GFP_KERNEL | __GFP_NOFAIL);
+	list_add(&lb->lb_list, &sdp->sd_log_flush_list);
+
+	bh = lb->lb_bh = sb_getblk(sdp->sd_vfs, blkno);
+	lock_buffer(bh);
+	memset(bh->b_data, 0, bh->b_size);
+	set_buffer_uptodate(bh);
+	clear_buffer_dirty(bh);
+	unlock_buffer(bh);
+
+	log_incr_head(sdp);
+
+	return bh;
+}
+
+/**
+ * gfs2_log_fake_buf - Build a fake buffer head to write metadata buffer to log
+ * @sdp: the filesystem
+ * @data: the data the buffer_head should point to
+ *
+ * Returns: the log buffer descriptor
+ */
+
+struct buffer_head *gfs2_log_fake_buf(struct gfs2_sbd *sdp,
+				      struct buffer_head *real)
+{
+	uint64_t blkno = log_bmap(sdp, sdp->sd_log_flush_head);
+	struct gfs2_log_buf *lb;
+	struct buffer_head *bh;
+
+	lb = kzalloc(sizeof(struct gfs2_log_buf), GFP_KERNEL | __GFP_NOFAIL);
+	list_add(&lb->lb_list, &sdp->sd_log_flush_list);
+	lb->lb_real = real;
+
+	bh = lb->lb_bh = alloc_buffer_head(GFP_NOFS | __GFP_NOFAIL);
+	atomic_set(&bh->b_count, 1);
+	bh->b_state = (1 << BH_Mapped) | (1 << BH_Uptodate);
+	set_bh_page(bh, virt_to_page(real->b_data),
+		    ((unsigned long)real->b_data) & (PAGE_SIZE - 1));
+	bh->b_blocknr = blkno;
+	bh->b_size = sdp->sd_sb.sb_bsize;
+	bh->b_bdev = sdp->sd_vfs->s_bdev;
+
+	log_incr_head(sdp);
+
+	return bh;
+}
+
+static void log_pull_tail(struct gfs2_sbd *sdp, unsigned int new_tail, int pull)
+{
+	unsigned int dist = log_distance(sdp, new_tail, sdp->sd_log_tail);
+
+	ail2_empty(sdp, new_tail);
+
+	gfs2_log_lock(sdp);
+	sdp->sd_log_blks_free += dist - ((pull) ? 1 : 0);
+	gfs2_assert_withdraw(sdp,
+			     sdp->sd_log_blks_free <= sdp->sd_jdesc->jd_blocks);
+	gfs2_log_unlock(sdp);
+
+	sdp->sd_log_tail = new_tail;
+}
+
+/**
+ * log_write_header - Get and initialize a journal header buffer
+ * @sdp: The GFS2 superblock
+ *
+ * Returns: the initialized log buffer descriptor
+ */
+
+static void log_write_header(struct gfs2_sbd *sdp, uint32_t flags, int pull)
+{
+	uint64_t blkno = log_bmap(sdp, sdp->sd_log_flush_head);
+	struct buffer_head *bh;
+	struct gfs2_log_header lh;
+	unsigned int tail;
+	uint32_t hash;
+
+	atomic_inc(&sdp->sd_log_flush_ondisk);
+
+	bh = sb_getblk(sdp->sd_vfs, blkno);
+	lock_buffer(bh);
+	memset(bh->b_data, 0, bh->b_size);
+	set_buffer_uptodate(bh);
+	clear_buffer_dirty(bh);
+	unlock_buffer(bh);
+
+	gfs2_ail1_empty(sdp, 0);
+	tail = current_tail(sdp);
+
+	memset(&lh, 0, sizeof(struct gfs2_log_header));
+	lh.lh_header.mh_magic = GFS2_MAGIC;
+	lh.lh_header.mh_type = GFS2_METATYPE_LH;
+	lh.lh_header.mh_format = GFS2_FORMAT_LH;
+	lh.lh_header.mh_blkno = blkno;
+	lh.lh_sequence = sdp->sd_log_sequence++;
+	lh.lh_flags = flags;
+	lh.lh_tail = tail;
+	lh.lh_blkno = sdp->sd_log_flush_head;
+	gfs2_log_header_out(&lh, bh->b_data);
+	hash = gfs2_disk_hash(bh->b_data, sizeof(struct gfs2_log_header));
+	((struct gfs2_log_header *)bh->b_data)->lh_hash = cpu_to_gfs2_32(hash);
+
+	set_buffer_dirty(bh);
+	if (sync_dirty_buffer(bh))
+		gfs2_io_error_bh(sdp, bh);
+	brelse(bh);
+
+	if (sdp->sd_log_tail != tail)
+		log_pull_tail(sdp, tail, pull);
+	else
+		gfs2_assert_withdraw(sdp, !pull);
+
+	sdp->sd_log_idle = (tail == sdp->sd_log_flush_head);
+	log_incr_head(sdp);
+}
+
+static void log_flush_commit(struct gfs2_sbd *sdp)
+{
+	struct list_head *head = &sdp->sd_log_flush_list;
+	struct gfs2_log_buf *lb;
+	struct buffer_head *bh;
+	unsigned int d;
+
+	d = log_distance(sdp, sdp->sd_log_flush_head, sdp->sd_log_head);
+
+	gfs2_assert_withdraw(sdp, d + 1 == sdp->sd_log_blks_reserved);
+
+	while (!list_empty(head)) {
+		lb = list_entry(head->next, struct gfs2_log_buf, lb_list);
+		list_del(&lb->lb_list);
+		bh = lb->lb_bh;
+
+		wait_on_buffer(bh);
+		if (!buffer_uptodate(bh))
+			gfs2_io_error_bh(sdp, bh);
+		if (lb->lb_real) {
+			while (atomic_read(&bh->b_count) != 1)  /* Grrrr... */
+				schedule();
+			free_buffer_head(bh);
+		} else
+			brelse(bh);
+		kfree(lb);
+	}
+
+	log_write_header(sdp, 0, 0);
+}
+
+/**
+ * gfs2_log_flush_i - flush incore transaction(s)
+ * @sdp: the filesystem
+ * @gl: The glock structure to flush.  If NULL, flush the whole incore log
+ *
+ */
+
+void gfs2_log_flush_i(struct gfs2_sbd *sdp, struct gfs2_glock *gl)
+{
+	struct gfs2_ail *ai;
+
+	atomic_inc(&sdp->sd_log_flush_incore);
+
+	ai = kzalloc(sizeof(struct gfs2_ail), GFP_KERNEL | __GFP_NOFAIL);
+	INIT_LIST_HEAD(&ai->ai_ail1_list);
+	INIT_LIST_HEAD(&ai->ai_ail2_list);
+
+	gfs2_lock_for_flush(sdp);
+	down(&sdp->sd_log_flush_lock);
+
+	gfs2_assert_withdraw(sdp,
+			sdp->sd_log_num_buf == sdp->sd_log_commited_buf);
+	gfs2_assert_withdraw(sdp,
+			sdp->sd_log_num_revoke == sdp->sd_log_commited_revoke);
+
+	if (gl && list_empty(&gl->gl_le.le_list)) {
+		up(&sdp->sd_log_flush_lock);
+		gfs2_unlock_from_flush(sdp);
+		kfree(ai);
+		return;
+	}
+
+	sdp->sd_log_flush_head = sdp->sd_log_head;
+	sdp->sd_log_flush_wrapped = FALSE;
+	ai->ai_first = sdp->sd_log_flush_head;
+
+	lops_before_commit(sdp);
+	if (!list_empty(&sdp->sd_log_flush_list))
+		log_flush_commit(sdp);
+	else if (sdp->sd_log_tail != current_tail(sdp) && !sdp->sd_log_idle)
+		log_write_header(sdp, 0, PULL);
+	lops_after_commit(sdp, ai);
+
+	sdp->sd_log_head = sdp->sd_log_flush_head;
+	if (sdp->sd_log_flush_wrapped)
+		sdp->sd_log_wraps++;
+
+	sdp->sd_log_blks_reserved =
+		sdp->sd_log_commited_buf =
+		sdp->sd_log_commited_revoke = 0;
+
+	gfs2_log_lock(sdp);
+	if (!list_empty(&ai->ai_ail1_list)) {
+		list_add(&ai->ai_list, &sdp->sd_ail1_list);
+		ai = NULL;
+	}
+	gfs2_log_unlock(sdp);
+
+	up(&sdp->sd_log_flush_lock);
+	sdp->sd_vfs->s_dirt = FALSE;
+	gfs2_unlock_from_flush(sdp);
+
+	kfree(ai);
+}
+
+static void log_refund(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
+{
+	unsigned int reserved = 1;
+	unsigned int old;
+
+	gfs2_log_lock(sdp);
+
+	sdp->sd_log_commited_buf += tr->tr_num_buf_new - tr->tr_num_buf_rm;
+	gfs2_assert_withdraw(sdp, ((int)sdp->sd_log_commited_buf) >= 0);
+	sdp->sd_log_commited_revoke += tr->tr_num_revoke - tr->tr_num_revoke_rm;
+	gfs2_assert_withdraw(sdp, ((int)sdp->sd_log_commited_revoke) >= 0);
+
+	if (sdp->sd_log_commited_buf)
+		reserved += 1 + sdp->sd_log_commited_buf;
+	if (sdp->sd_log_commited_revoke)
+		reserved += gfs2_struct2blk(sdp, sdp->sd_log_commited_revoke,
+					    sizeof(uint64_t));
+
+	old = sdp->sd_log_blks_free;
+	sdp->sd_log_blks_free += tr->tr_reserved -
+				 (reserved - sdp->sd_log_blks_reserved);
+
+	gfs2_assert_withdraw(sdp,
+			     sdp->sd_log_blks_free >= old);
+	gfs2_assert_withdraw(sdp,
+			     sdp->sd_log_blks_free <= sdp->sd_jdesc->jd_blocks);
+
+	sdp->sd_log_blks_reserved = reserved;
+
+	gfs2_log_unlock(sdp);
+}
+
+/**
+ * gfs2_log_commit - Commit a transaction to the log
+ * @sdp: the filesystem
+ * @tr: the transaction
+ *
+ * Returns: errno
+ */
+
+void gfs2_log_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
+{
+	log_refund(sdp, tr);
+	lops_incore_commit(sdp, tr);
+
+	sdp->sd_vfs->s_dirt = TRUE;
+	unlock_from_trans(sdp);
+
+	kfree(tr);
+
+	gfs2_log_lock(sdp);
+	if (sdp->sd_log_num_buf > gfs2_tune_get(sdp, gt_incore_log_blocks)) {
+		gfs2_log_unlock(sdp);
+		gfs2_log_flush(sdp);
+	} else
+		gfs2_log_unlock(sdp);
+}
+
+/**
+ * gfs2_log_shutdown - write a shutdown header into a journal
+ * @sdp: the filesystem
+ *
+ */
+
+void gfs2_log_shutdown(struct gfs2_sbd *sdp)
+{
+	down(&sdp->sd_log_flush_lock);
+
+	gfs2_assert_withdraw(sdp, !atomic_read(&sdp->sd_log_trans_count));
+	gfs2_assert_withdraw(sdp, !sdp->sd_log_blks_reserved);
+	gfs2_assert_withdraw(sdp, !sdp->sd_log_num_gl);
+	gfs2_assert_withdraw(sdp, !sdp->sd_log_num_buf);
+	gfs2_assert_withdraw(sdp, !sdp->sd_log_num_revoke);
+	gfs2_assert_withdraw(sdp, !sdp->sd_log_num_rg);
+	gfs2_assert_withdraw(sdp, !sdp->sd_log_num_databuf);
+	gfs2_assert_withdraw(sdp, list_empty(&sdp->sd_ail1_list));
+
+	sdp->sd_log_flush_head = sdp->sd_log_head;
+	sdp->sd_log_flush_wrapped = FALSE;
+
+	log_write_header(sdp, GFS2_LOG_HEAD_UNMOUNT, 0);
+
+	gfs2_assert_withdraw(sdp, sdp->sd_log_blks_free ==
+			     sdp->sd_jdesc->jd_blocks);
+	gfs2_assert_withdraw(sdp, sdp->sd_log_head == sdp->sd_log_tail);
+	gfs2_assert_withdraw(sdp, list_empty(&sdp->sd_ail2_list));
+
+	sdp->sd_log_head = sdp->sd_log_flush_head;
+	if (sdp->sd_log_flush_wrapped)
+		sdp->sd_log_wraps++;
+	sdp->sd_log_tail = sdp->sd_log_head;
+
+	up(&sdp->sd_log_flush_lock);
+}
+
--- a/fs/gfs2/log.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/log.h	2005-09-01 17:36:55.338111976 +0800
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __LOG_DOT_H__
+#define __LOG_DOT_H__
+
+/**
+ * gfs2_log_lock - acquire the right to mess with the log manager
+ * @sdp: the filesystem
+ *
+ */
+
+static inline void gfs2_log_lock(struct gfs2_sbd *sdp)
+{
+	spin_lock(&sdp->sd_log_lock);
+}
+
+/**
+ * gfs2_log_unlock - release the right to mess with the log manager
+ * @sdp: the filesystem
+ *
+ */
+
+static inline void gfs2_log_unlock(struct gfs2_sbd *sdp)
+{
+	spin_unlock(&sdp->sd_log_lock);
+}
+
+static inline void gfs2_log_pointers_init(struct gfs2_sbd *sdp,
+					  unsigned int value)
+{
+	if (++value == sdp->sd_jdesc->jd_blocks) {
+		value = 0;
+		sdp->sd_log_wraps++;
+	}
+	sdp->sd_log_head = sdp->sd_log_tail = value;
+}
+
+void gfs2_lock_for_flush(struct gfs2_sbd *sdp);
+void gfs2_unlock_from_flush(struct gfs2_sbd *sdp);
+
+unsigned int gfs2_struct2blk(struct gfs2_sbd *sdp, unsigned int nstruct,
+			    unsigned int ssize);
+
+void gfs2_ail1_start(struct gfs2_sbd *sdp, int flags);
+int gfs2_ail1_empty(struct gfs2_sbd *sdp, int flags);
+
+int gfs2_log_reserve(struct gfs2_sbd *sdp, unsigned int blks);
+void gfs2_log_release(struct gfs2_sbd *sdp, unsigned int blks);
+
+struct buffer_head *gfs2_log_get_buf(struct gfs2_sbd *sdp);
+struct buffer_head *gfs2_log_fake_buf(struct gfs2_sbd *sdp,
+				      struct buffer_head *real);
+
+#define gfs2_log_flush(sdp) gfs2_log_flush_i((sdp), NULL)
+#define gfs2_log_flush_glock(gl) gfs2_log_flush_i((gl)->gl_sbd, (gl))
+void gfs2_log_flush_i(struct gfs2_sbd *sdp, struct gfs2_glock *gl);
+void gfs2_log_commit(struct gfs2_sbd *sdp, struct gfs2_trans *trans);
+
+void gfs2_log_shutdown(struct gfs2_sbd *sdp);
+
+#endif /* __LOG_DOT_H__ */
--- a/fs/gfs2/recovery.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/recovery.c	2005-09-01 17:36:55.451094800 +0800
@@ -0,0 +1,561 @@
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
+#include "lm.h"
+#include "lops.h"
+#include "meta_io.h"
+#include "recovery.h"
+#include "super.h"
+
+int gfs2_replay_read_block(struct gfs2_jdesc *jd, unsigned int blk,
+			   struct buffer_head **bh)
+{
+	struct gfs2_glock *gl = jd->jd_inode->i_gl;
+	int new = FALSE;
+	uint64_t dblock;
+	uint32_t extlen;
+	int error;
+
+	error = gfs2_block_map(jd->jd_inode, blk, &new, &dblock, &extlen);
+	if (error)
+		return error;
+	if (!dblock) {
+		gfs2_consist_inode(jd->jd_inode);
+		return -EIO;
+	}
+
+	gfs2_meta_ra(gl, dblock, extlen);
+	error = gfs2_meta_read(gl, dblock, DIO_START | DIO_WAIT, bh);
+
+	return error;
+}
+
+int gfs2_revoke_add(struct gfs2_sbd *sdp, uint64_t blkno, unsigned int where)
+{
+	struct list_head *head = &sdp->sd_revoke_list;
+	struct gfs2_revoke_replay *rr;
+	int found = FALSE;
+
+	list_for_each_entry(rr, head, rr_list) {
+		if (rr->rr_blkno == blkno) {
+			found = TRUE;
+			break;
+		}
+	}
+
+	if (found) {
+		rr->rr_where = where;
+		return 0;
+	}
+
+	rr = kmalloc(sizeof(struct gfs2_revoke_replay), GFP_KERNEL);
+	if (!rr)
+		return -ENOMEM;
+
+	rr->rr_blkno = blkno;
+	rr->rr_where = where;
+	list_add(&rr->rr_list, head);
+
+	return 1;
+}
+
+int gfs2_revoke_check(struct gfs2_sbd *sdp, uint64_t blkno, unsigned int where)
+{
+	struct gfs2_revoke_replay *rr;
+	int wrap, a, b, revoke;
+	int found = FALSE;
+
+	list_for_each_entry(rr, &sdp->sd_revoke_list, rr_list) {
+		if (rr->rr_blkno == blkno) {
+			found = TRUE;
+			break;
+		}
+	}
+
+	if (!found)
+		return 0;
+
+	wrap = (rr->rr_where < sdp->sd_replay_tail);
+	a = (sdp->sd_replay_tail < where);
+	b = (where < rr->rr_where);
+	revoke = (wrap) ? (a || b) : (a && b);
+
+	return revoke;
+}
+
+void gfs2_revoke_clean(struct gfs2_sbd *sdp)
+{
+	struct list_head *head = &sdp->sd_revoke_list;
+	struct gfs2_revoke_replay *rr;
+
+	while (!list_empty(head)) {
+		rr = list_entry(head->next, struct gfs2_revoke_replay, rr_list);
+		list_del(&rr->rr_list);
+		kfree(rr);
+	}
+}
+
+/**
+ * get_log_header - read the log header for a given segment
+ * @jd: the journal
+ * @blk: the block to look at
+ * @lh: the log header to return
+ *
+ * Read the log header for a given segement in a given journal.  Do a few
+ * sanity checks on it.
+ *
+ * Returns: 0 on success,
+ *          1 if the header was invalid or incomplete,
+ *          errno on error
+ */
+
+static int get_log_header(struct gfs2_jdesc *jd, unsigned int blk,
+			  struct gfs2_log_header *head)
+{
+	struct buffer_head *bh;
+	struct gfs2_log_header lh;
+	uint32_t hash;
+	int error;
+
+	error = gfs2_replay_read_block(jd, blk, &bh);
+	if (error)
+		return error;
+
+	memcpy(&lh, bh->b_data, sizeof(struct gfs2_log_header));
+	lh.lh_hash = 0;
+	hash = gfs2_disk_hash((char *)&lh, sizeof(struct gfs2_log_header));
+	gfs2_log_header_in(&lh, bh->b_data);
+
+	brelse(bh);
+
+	if (lh.lh_header.mh_magic != GFS2_MAGIC ||
+	    lh.lh_header.mh_type != GFS2_METATYPE_LH ||
+	    lh.lh_header.mh_blkno != bh->b_blocknr ||
+	    lh.lh_blkno != blk ||
+	    lh.lh_hash != hash)
+		return 1;
+
+	*head = lh;
+
+	return 0;
+}
+
+/**
+ * find_good_lh - find a good log header
+ * @jd: the journal
+ * @blk: the segment to start searching from
+ * @lh: the log header to fill in
+ * @forward: if true search forward in the log, else search backward
+ *
+ * Call get_log_header() to get a log header for a segment, but if the
+ * segment is bad, either scan forward or backward until we find a good one.
+ *
+ * Returns: errno
+ */
+
+static int find_good_lh(struct gfs2_jdesc *jd, unsigned int *blk,
+			struct gfs2_log_header *head)
+{
+	unsigned int orig_blk = *blk;
+	int error;
+
+	for (;;) {
+		error = get_log_header(jd, *blk, head);
+		if (error <= 0)
+			return error;
+
+		if (++*blk == jd->jd_blocks)
+			*blk = 0;
+
+		if (*blk == orig_blk) {
+			gfs2_consist_inode(jd->jd_inode);
+			return -EIO;
+		}
+	}
+}
+
+/**
+ * jhead_scan - make sure we've found the head of the log
+ * @jd: the journal
+ * @head: this is filled in with the log descriptor of the head
+ *
+ * At this point, seg and lh should be either the head of the log or just
+ * before.  Scan forward until we find the head.
+ *
+ * Returns: errno
+ */
+
+static int jhead_scan(struct gfs2_jdesc *jd, struct gfs2_log_header *head)
+{
+	unsigned int blk = head->lh_blkno;
+	struct gfs2_log_header lh;
+	int error;
+
+	for (;;) {
+		if (++blk == jd->jd_blocks)
+			blk = 0;
+
+		error = get_log_header(jd, blk, &lh);
+		if (error < 0)
+			return error;
+		if (error == 1)
+			continue;
+
+		if (lh.lh_sequence == head->lh_sequence) {
+			gfs2_consist_inode(jd->jd_inode);
+			return -EIO;
+		}
+		if (lh.lh_sequence < head->lh_sequence)
+			break;
+
+		*head = lh;
+	}
+
+	return 0;
+}
+
+/**
+ * gfs2_find_jhead - find the head of a log
+ * @jd: the journal
+ * @head: the log descriptor for the head of the log is returned here
+ *
+ * Do a binary search of a journal and find the valid log entry with the
+ * highest sequence number.  (i.e. the log head)
+ *
+ * Returns: errno
+ */
+
+int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header *head)
+{
+	struct gfs2_log_header lh_1, lh_m;
+	uint32_t blk_1, blk_2, blk_m;
+	int error;
+
+	blk_1 = 0;
+	blk_2 = jd->jd_blocks - 1;
+
+	for (;;) {
+		blk_m = (blk_1 + blk_2) / 2;
+
+		error = find_good_lh(jd, &blk_1, &lh_1);
+		if (error)
+			return error;
+
+		error = find_good_lh(jd, &blk_m, &lh_m);
+		if (error)
+			return error;
+
+		if (blk_1 == blk_m || blk_m == blk_2)
+			break;
+
+		if (lh_1.lh_sequence <= lh_m.lh_sequence)
+			blk_1 = blk_m;
+		else
+			blk_2 = blk_m;
+	}
+
+	error = jhead_scan(jd, &lh_1);
+	if (error)
+		return error;
+
+	*head = lh_1;
+
+	return error;
+}
+
+/**
+ * foreach_descriptor - go through the active part of the log
+ * @jd: the journal
+ * @start: the first log header in the active region
+ * @end: the last log header (don't process the contents of this entry))
+ *
+ * Call a given function once for every log descriptor in the active
+ * portion of the log.
+ *
+ * Returns: errno
+ */
+
+static int foreach_descriptor(struct gfs2_jdesc *jd, unsigned int start,
+			      unsigned int end, int pass)
+{
+	struct gfs2_sbd *sdp = jd->jd_inode->i_sbd;
+	struct buffer_head *bh;
+	struct gfs2_log_descriptor ld;
+	int error = 0;
+
+	while (start != end) {
+		error = gfs2_replay_read_block(jd, start, &bh);
+		if (error)
+			return error;
+		if (gfs2_meta_check(sdp, bh)) {
+			brelse(bh);
+			return -EIO;
+		}
+		gfs2_log_descriptor_in(&ld, bh->b_data);
+		brelse(bh);
+
+		if (ld.ld_header.mh_type == GFS2_METATYPE_LH) {
+			struct gfs2_log_header lh;
+			error = get_log_header(jd, start, &lh);
+			if (!error) {
+				gfs2_replay_incr_blk(sdp, &start);
+				continue;
+			}
+			if (error == 1) {
+				gfs2_consist_inode(jd->jd_inode);
+				error = -EIO;
+			}
+			return error;
+		} else if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_LD))
+			return -EIO;
+
+		error = lops_scan_elements(jd, start, &ld, pass);
+		if (error)
+			return error;
+
+		while (ld.ld_length--)
+			gfs2_replay_incr_blk(sdp, &start);
+	}
+
+	return 0;
+}
+
+/**
+ * clean_journal - mark a dirty journal as being clean
+ * @sdp: the filesystem
+ * @jd: the journal
+ * @gl: the journal's glock
+ * @head: the head journal to start from
+ *
+ * Returns: errno
+ */
+
+static int clean_journal(struct gfs2_jdesc *jd, struct gfs2_log_header *head)
+{
+	struct gfs2_inode *ip = jd->jd_inode;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	unsigned int lblock;
+	int new = FALSE;
+	uint64_t dblock;
+	struct gfs2_log_header lh;
+	uint32_t hash;
+	struct buffer_head *bh;
+	int error;
+	
+	lblock = head->lh_blkno;
+	gfs2_replay_incr_blk(sdp, &lblock);
+	error = gfs2_block_map(ip, lblock, &new, &dblock, NULL);
+	if (error)
+		return error;
+	if (!dblock) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
+
+	bh = sb_getblk(sdp->sd_vfs, dblock);
+	lock_buffer(bh);
+	memset(bh->b_data, 0, bh->b_size);
+	set_buffer_uptodate(bh);
+	clear_buffer_dirty(bh);
+	unlock_buffer(bh);
+
+	memset(&lh, 0, sizeof(struct gfs2_log_header));
+	lh.lh_header.mh_magic = GFS2_MAGIC;
+	lh.lh_header.mh_type = GFS2_METATYPE_LH;
+	lh.lh_header.mh_format = GFS2_FORMAT_LH;
+	lh.lh_header.mh_blkno = dblock;
+	lh.lh_sequence = head->lh_sequence + 1;
+	lh.lh_flags = GFS2_LOG_HEAD_UNMOUNT;
+	lh.lh_blkno = lblock;
+	gfs2_log_header_out(&lh, bh->b_data);
+	hash = gfs2_disk_hash(bh->b_data, sizeof(struct gfs2_log_header));
+	((struct gfs2_log_header *)bh->b_data)->lh_hash = cpu_to_gfs2_32(hash);
+
+	set_buffer_dirty(bh);
+	if (sync_dirty_buffer(bh))
+		gfs2_io_error_bh(sdp, bh);
+	brelse(bh);
+
+	return error;
+}
+
+/**
+ * gfs2_recover_journal - recovery a given journal
+ * @jd: the struct gfs2_jdesc describing the journal
+ * @wait: Don't return until the journal is clean (or an error is encountered)
+ *
+ * Acquire the journal's lock, check to see if the journal is clean, and
+ * do recovery if necessary.
+ *
+ * Returns: errno
+ */
+
+int gfs2_recover_journal(struct gfs2_jdesc *jd, int wait)
+{
+	struct gfs2_sbd *sdp = jd->jd_inode->i_sbd;
+	struct gfs2_log_header head;
+	struct gfs2_holder j_gh, ji_gh, t_gh;
+	unsigned long t;
+	int ro = FALSE;
+	unsigned int pass;
+	int error;
+
+	fs_info(sdp, "jid=%u: Trying to acquire journal lock...\n", jd->jd_jid);
+
+	/* Aquire the journal lock so we can do recovery */
+
+	error = gfs2_glock_nq_num(sdp,
+				  jd->jd_jid, &gfs2_journal_glops,
+				  LM_ST_EXCLUSIVE,
+				  LM_FLAG_NOEXP |
+				  ((wait) ? 0 : LM_FLAG_TRY) |
+				  GL_NOCACHE, &j_gh);
+	switch (error) {
+	case 0:
+		break;
+
+	case GLR_TRYFAILED:
+		fs_info(sdp, "jid=%u: Busy\n", jd->jd_jid);
+		error = 0;
+
+	default:
+		goto fail;
+	};
+
+	error = gfs2_glock_nq_init(jd->jd_inode->i_gl, LM_ST_SHARED,
+				   LM_FLAG_NOEXP, &ji_gh);
+	if (error)
+		goto fail_gunlock_j;
+
+	fs_info(sdp, "jid=%u: Looking at journal...\n", jd->jd_jid);
+
+	error = gfs2_jdesc_check(jd);
+	if (error)
+		goto fail_gunlock_ji;
+
+	error = gfs2_find_jhead(jd, &head);
+	if (error)
+		goto fail_gunlock_ji;
+
+	if (!(head.lh_flags & GFS2_LOG_HEAD_UNMOUNT)) {
+		fs_info(sdp, "jid=%u: Acquiring the transaction lock...\n",
+			jd->jd_jid);
+
+		t = jiffies;
+
+		/* Acquire a shared hold on the transaction lock */
+
+		error = gfs2_glock_nq_init(sdp->sd_trans_gl,
+					   LM_ST_SHARED,
+					   LM_FLAG_NOEXP |
+					   LM_FLAG_PRIORITY |
+					   GL_NEVER_RECURSE |
+					   GL_NOCANCEL |
+					   GL_NOCACHE,
+					   &t_gh);
+		if (error)
+			goto fail_gunlock_ji;
+
+		if (test_bit(SDF_JOURNAL_CHECKED, &sdp->sd_flags)) {
+			if (!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
+				ro = TRUE;
+		} else {
+			if (sdp->sd_vfs->s_flags & MS_RDONLY)
+				ro = TRUE;
+		}
+
+		if (ro) {
+			fs_warn(sdp, "jid=%u: Can't replay: read-only FS\n",
+				jd->jd_jid);
+			error = -EROFS;
+			goto fail_gunlock_tr;
+		}
+
+		fs_info(sdp, "jid=%u: Replaying journal...\n", jd->jd_jid);
+
+		for (pass = 0; pass < 2; pass++) {
+			lops_before_scan(jd, &head, pass);
+			error = foreach_descriptor(jd, head.lh_tail,
+						   head.lh_blkno, pass);
+			lops_after_scan(jd, error, pass);
+			if (error)
+				goto fail_gunlock_tr;
+		}
+
+		error = clean_journal(jd, &head);
+		if (error)
+			goto fail_gunlock_tr;
+
+		gfs2_glock_dq_uninit(&t_gh);
+
+		t = DIV_RU(jiffies - t, HZ);
+		
+		fs_info(sdp, "jid=%u: Journal replayed in %lus\n",
+			jd->jd_jid, t);
+	}
+
+	gfs2_glock_dq_uninit(&ji_gh);
+
+	gfs2_lm_recovery_done(sdp, jd->jd_jid, LM_RD_SUCCESS);
+
+	gfs2_glock_dq_uninit(&j_gh);
+
+	fs_info(sdp, "jid=%u: Done\n", jd->jd_jid);
+
+	return 0;
+
+ fail_gunlock_tr:
+	gfs2_glock_dq_uninit(&t_gh);
+
+ fail_gunlock_ji:
+	gfs2_glock_dq_uninit(&ji_gh);
+
+ fail_gunlock_j:
+	gfs2_glock_dq_uninit(&j_gh);
+
+	fs_info(sdp, "jid=%u: %s\n", jd->jd_jid, (error) ? "Failed" : "Done");
+
+ fail:
+	gfs2_lm_recovery_done(sdp, jd->jd_jid, LM_RD_GAVEUP);
+
+	return error;
+}
+
+/**
+ * gfs2_check_journals - Recover any dirty journals
+ * @sdp: the filesystem
+ *
+ */
+
+void gfs2_check_journals(struct gfs2_sbd *sdp)
+{
+	struct gfs2_jdesc *jd;
+
+	for (;;) {
+		jd = gfs2_jdesc_find_dirty(sdp);
+		if (!jd)
+			break;
+
+		if (jd != sdp->sd_jdesc)
+			gfs2_recover_journal(jd, NO_WAIT);
+	}
+}
+
--- a/fs/gfs2/recovery.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/recovery.h	2005-09-01 17:36:55.451094800 +0800
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __RECOVERY_DOT_H__
+#define __RECOVERY_DOT_H__
+
+static inline void gfs2_replay_incr_blk(struct gfs2_sbd *sdp, unsigned int *blk)
+{
+	if (++*blk == sdp->sd_jdesc->jd_blocks)
+	        *blk = 0;
+}
+
+int gfs2_replay_read_block(struct gfs2_jdesc *jd, unsigned int blk,
+			   struct buffer_head **bh);
+
+int gfs2_revoke_add(struct gfs2_sbd *sdp, uint64_t blkno, unsigned int where);
+int gfs2_revoke_check(struct gfs2_sbd *sdp, uint64_t blkno, unsigned int where);
+void gfs2_revoke_clean(struct gfs2_sbd *sdp);
+
+int gfs2_find_jhead(struct gfs2_jdesc *jd,
+		    struct gfs2_log_header *head);
+int gfs2_recover_journal(struct gfs2_jdesc *gfs2_jd, int wait);
+void gfs2_check_journals(struct gfs2_sbd *sdp);
+
+#endif /* __RECOVERY_DOT_H__ */
+
