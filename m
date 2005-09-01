Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbVIANwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbVIANwQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbVIANwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:52:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36805 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965127AbVIANvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:51:05 -0400
Date: Thu, 1 Sep 2005 21:56:46 +0800
From: David Teigland <teigland@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] GFS: lock_dlm module
Message-ID: <20050901135646.GP25581@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lock_dlm module uses the DLM in linux/drivers/dlm/ for inter-node
locking.

Signed-off-by: Ken Preslan <ken@preslan.org>
Signed-off-by: David Teigland <teigland@redhat.com>

---

 fs/gfs2/locking/dlm/Makefile   |    3 
 fs/gfs2/locking/dlm/lock.c     |  533 +++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/locking/dlm/lock_dlm.h |  200 +++++++++++++++
 fs/gfs2/locking/dlm/main.c     |   62 ++++
 fs/gfs2/locking/dlm/mount.c    |  218 ++++++++++++++++
 fs/gfs2/locking/dlm/plock.c    |  274 +++++++++++++++++++++
 fs/gfs2/locking/dlm/sysfs.c    |  283 +++++++++++++++++++++
 fs/gfs2/locking/dlm/thread.c   |  355 +++++++++++++++++++++++++++
 include/linux/lock_dlm_plock.h |   40 +++
 9 files changed, 1968 insertions(+)

diff -urpN a/fs/gfs2/locking/dlm/Makefile b/fs/gfs2/locking/dlm/Makefile
--- a/fs/gfs2/locking/dlm/Makefile	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/locking/dlm/Makefile	2005-09-01 17:48:48.143749048 +0800
@@ -0,0 +1,3 @@
+obj-$(CONFIG_GFS2_FS) += lock_dlm.o
+lock_dlm-y := lock.o main.o mount.o sysfs.o thread.o plock.o
+
diff -urpN a/fs/gfs2/locking/dlm/lock.c b/fs/gfs2/locking/dlm/lock.c
--- a/fs/gfs2/locking/dlm/lock.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/locking/dlm/lock.c	2005-09-01 17:48:48.139749656 +0800
@@ -0,0 +1,533 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include "lock_dlm.h"
+
+static char junk_lvb[GDLM_LVB_SIZE];
+
+static void queue_complete(struct gdlm_lock *lp)
+{
+	struct gdlm_ls *ls = lp->ls;
+
+	clear_bit(LFL_ACTIVE, &lp->flags);
+
+	spin_lock(&ls->async_lock);
+	list_add_tail(&lp->clist, &ls->complete);
+	spin_unlock(&ls->async_lock);
+	wake_up(&ls->thread_wait);
+}
+
+static inline void gdlm_ast(void *astarg)
+{
+	queue_complete((struct gdlm_lock *) astarg);
+}
+
+static inline void gdlm_bast(void *astarg, int mode)
+{
+	struct gdlm_lock *lp = astarg;
+	struct gdlm_ls *ls = lp->ls;
+
+	if (!mode) {
+		printk("lock_dlm: bast mode zero %x,%"PRIx64"\n",
+			lp->lockname.ln_type, lp->lockname.ln_number);
+		return;
+	}
+
+	spin_lock(&ls->async_lock);
+	if (!lp->bast_mode) {
+		list_add_tail(&lp->blist, &ls->blocking);
+		lp->bast_mode = mode;
+	} else if (lp->bast_mode < mode)
+		lp->bast_mode = mode;
+	spin_unlock(&ls->async_lock);
+	wake_up(&ls->thread_wait);
+}
+
+void gdlm_queue_delayed(struct gdlm_lock *lp)
+{
+	struct gdlm_ls *ls = lp->ls;
+
+	spin_lock(&ls->async_lock);
+	list_add_tail(&lp->delay_list, &ls->delayed);
+	spin_unlock(&ls->async_lock);
+}
+
+/* convert gfs lock-state to dlm lock-mode */
+
+static int16_t make_mode(int16_t lmstate)
+{
+	switch (lmstate) {
+	case LM_ST_UNLOCKED:
+		return DLM_LOCK_NL;
+	case LM_ST_EXCLUSIVE:
+		return DLM_LOCK_EX;
+	case LM_ST_DEFERRED:
+		return DLM_LOCK_CW;
+	case LM_ST_SHARED:
+		return DLM_LOCK_PR;
+	default:
+		GDLM_ASSERT(0, printk("unknown LM state %d\n", lmstate););
+	}
+}
+
+/* convert dlm lock-mode to gfs lock-state */
+
+int16_t gdlm_make_lmstate(int16_t dlmmode)
+{
+	switch (dlmmode) {
+	case DLM_LOCK_IV:
+	case DLM_LOCK_NL:
+		return LM_ST_UNLOCKED;
+	case DLM_LOCK_EX:
+		return LM_ST_EXCLUSIVE;
+	case DLM_LOCK_CW:
+		return LM_ST_DEFERRED;
+	case DLM_LOCK_PR:
+		return LM_ST_SHARED;
+	default:
+		GDLM_ASSERT(0, printk("unknown DLM mode %d\n", dlmmode););
+	}
+}
+
+/* verify agreement with GFS on the current lock state, NB: DLM_LOCK_NL and
+   DLM_LOCK_IV are both considered LM_ST_UNLOCKED by GFS. */
+
+static void check_cur_state(struct gdlm_lock *lp, unsigned int cur_state)
+{
+	int16_t cur = make_mode(cur_state);
+	if (lp->cur != DLM_LOCK_IV)
+		GDLM_ASSERT(lp->cur == cur, printk("%d, %d\n", lp->cur, cur););
+}
+
+static inline unsigned int make_flags(struct gdlm_lock *lp,
+				      unsigned int gfs_flags,
+				      int16_t cur, int16_t req)
+{
+	unsigned int lkf = 0;
+
+	if (gfs_flags & LM_FLAG_TRY)
+		lkf |= DLM_LKF_NOQUEUE;
+
+	if (gfs_flags & LM_FLAG_TRY_1CB) {
+		lkf |= DLM_LKF_NOQUEUE;
+		lkf |= DLM_LKF_NOQUEUEBAST;
+	}
+
+	if (gfs_flags & LM_FLAG_PRIORITY) {
+		lkf |= DLM_LKF_NOORDER;
+		lkf |= DLM_LKF_HEADQUE;
+	}
+
+	if (gfs_flags & LM_FLAG_ANY) {
+		if (req == DLM_LOCK_PR)
+			lkf |= DLM_LKF_ALTCW;
+		else if (req == DLM_LOCK_CW)
+			lkf |= DLM_LKF_ALTPR;
+	}
+
+	if (lp->lksb.sb_lkid != 0) {
+		lkf |= DLM_LKF_CONVERT;
+
+		/* Conversion deadlock avoidance by DLM */
+
+		if (!test_bit(LFL_FORCE_PROMOTE, &lp->flags) &&
+		    !(lkf & DLM_LKF_NOQUEUE) &&
+		    cur > DLM_LOCK_NL && req > DLM_LOCK_NL && cur != req)
+			lkf |= DLM_LKF_CONVDEADLK;
+	}
+
+	if (lp->lvb)
+		lkf |= DLM_LKF_VALBLK;
+
+	return lkf;
+}
+
+/* make_strname - convert GFS lock numbers to a string */
+
+static inline void make_strname(struct lm_lockname *lockname,
+				struct gdlm_strname *str)
+{
+	sprintf(str->name, "%8x%16"PRIx64, lockname->ln_type,
+		lockname->ln_number);
+	str->namelen = GDLM_STRNAME_BYTES;
+}
+
+int gdlm_create_lp(struct gdlm_ls *ls, struct lm_lockname *name,
+		   struct gdlm_lock **lpp)
+{
+	struct gdlm_lock *lp;
+
+	lp = kmalloc(sizeof(struct gdlm_lock), GFP_KERNEL);
+	if (!lp)
+		return -ENOMEM;
+
+	memset(lp, 0, sizeof(struct gdlm_lock));
+	lp->lockname = *name;
+	lp->ls = ls;
+	lp->cur = DLM_LOCK_IV;
+	lp->lvb = NULL;
+	lp->hold_null = NULL;
+	init_completion(&lp->ast_wait);
+	INIT_LIST_HEAD(&lp->clist);
+	INIT_LIST_HEAD(&lp->blist);
+	INIT_LIST_HEAD(&lp->delay_list);
+
+	spin_lock(&ls->async_lock);
+	list_add(&lp->all_list, &ls->all_locks);
+	ls->all_locks_count++;
+	spin_unlock(&ls->async_lock);
+
+	*lpp = lp;
+	return 0;
+}
+
+void gdlm_delete_lp(struct gdlm_lock *lp)
+{
+	struct gdlm_ls *ls = lp->ls;
+
+	spin_lock(&ls->async_lock);
+	if (!list_empty(&lp->clist))
+		list_del_init(&lp->clist);
+	if (!list_empty(&lp->blist))
+		list_del_init(&lp->blist);
+	if (!list_empty(&lp->delay_list))
+		list_del_init(&lp->delay_list);
+	GDLM_ASSERT(!list_empty(&lp->all_list),);
+	list_del_init(&lp->all_list);
+	ls->all_locks_count--;
+	spin_unlock(&ls->async_lock);
+
+	kfree(lp);
+}
+
+int gdlm_get_lock(lm_lockspace_t *lockspace, struct lm_lockname *name,
+		  lm_lock_t **lockp)
+{
+	struct gdlm_lock *lp;
+	int error;
+
+	error = gdlm_create_lp((struct gdlm_ls *) lockspace, name, &lp);
+
+	*lockp = (lm_lock_t *) lp;
+	return error;
+}
+
+void gdlm_put_lock(lm_lock_t *lock)
+{
+	gdlm_delete_lp((struct gdlm_lock *) lock);
+}
+
+void gdlm_do_lock(struct gdlm_lock *lp, struct dlm_range *range)
+{
+	struct gdlm_ls *ls = lp->ls;
+	struct gdlm_strname str;
+	int error, bast = 1;
+
+	/*
+	 * When recovery is in progress, delay lock requests for submission
+	 * once recovery is done.  Requests for recovery (NOEXP) and unlocks
+	 * can pass.
+	 */
+
+	if (test_bit(DFL_BLOCK_LOCKS, &ls->flags) &&
+	    !test_bit(LFL_NOBLOCK, &lp->flags) && lp->req != DLM_LOCK_NL) {
+		gdlm_queue_delayed(lp);
+		return;
+	}
+
+	/*
+	 * Submit the actual lock request.
+	 */
+
+	if (test_bit(LFL_NOBAST, &lp->flags))
+		bast = 0;
+
+	make_strname(&lp->lockname, &str);
+
+	set_bit(LFL_ACTIVE, &lp->flags);
+
+	log_debug("lk %x,%"PRIx64" id %x %d,%d %x", lp->lockname.ln_type,
+		  lp->lockname.ln_number, lp->lksb.sb_lkid,
+		  lp->cur, lp->req, lp->lkf);
+
+	error = dlm_lock(ls->dlm_lockspace, lp->req, &lp->lksb, lp->lkf,
+			 str.name, str.namelen, 0, gdlm_ast, (void *) lp,
+			 bast ? gdlm_bast : NULL, range);
+
+	if ((error == -EAGAIN) && (lp->lkf & DLM_LKF_NOQUEUE)) {
+		lp->lksb.sb_status = -EAGAIN;
+		queue_complete(lp);
+		error = 0;
+	}
+
+	GDLM_ASSERT(!error,
+		   printk("%s: num=%x,%"PRIx64" err=%d cur=%d req=%d lkf=%x\n",
+			  ls->fsname, lp->lockname.ln_type,
+			  lp->lockname.ln_number, error, lp->cur, lp->req,
+			  lp->lkf););
+}
+
+void gdlm_do_unlock(struct gdlm_lock *lp)
+{
+	unsigned int lkf = 0;
+	int error;
+
+	set_bit(LFL_DLM_UNLOCK, &lp->flags);
+	set_bit(LFL_ACTIVE, &lp->flags);
+
+	if (lp->lvb)
+		lkf = DLM_LKF_VALBLK;
+
+	log_debug("un %x,%"PRIx64" %x %d %x", lp->lockname.ln_type,
+		  lp->lockname.ln_number, lp->lksb.sb_lkid, lp->cur, lkf);
+
+	error = dlm_unlock(lp->ls->dlm_lockspace, lp->lksb.sb_lkid, lkf,
+			   NULL, lp);
+
+	GDLM_ASSERT(!error,
+		   printk("%s: error=%d num=%x,%"PRIx64" lkf=%x flags=%lx\n",
+			  lp->ls->fsname, error, lp->lockname.ln_type,
+			  lp->lockname.ln_number, lkf, lp->flags););
+}
+
+unsigned int gdlm_lock(lm_lock_t *lock, unsigned int cur_state,
+		       unsigned int req_state, unsigned int flags)
+{
+	struct gdlm_lock *lp = (struct gdlm_lock *) lock;
+
+	clear_bit(LFL_DLM_CANCEL, &lp->flags);
+	if (flags & LM_FLAG_NOEXP)
+		set_bit(LFL_NOBLOCK, &lp->flags);
+
+	check_cur_state(lp, cur_state);
+	lp->req = make_mode(req_state);
+	lp->lkf = make_flags(lp, flags, lp->cur, lp->req);
+
+	gdlm_do_lock(lp, NULL);
+	return LM_OUT_ASYNC;
+}
+
+unsigned int gdlm_unlock(lm_lock_t *lock, unsigned int cur_state)
+{
+	struct gdlm_lock *lp = (struct gdlm_lock *) lock;
+
+	clear_bit(LFL_DLM_CANCEL, &lp->flags);
+	if (lp->cur == DLM_LOCK_IV)
+		return 0;
+	gdlm_do_unlock(lp);
+	return LM_OUT_ASYNC;
+}
+
+void gdlm_cancel(lm_lock_t *lock)
+{
+	struct gdlm_lock *lp = (struct gdlm_lock *) lock;
+	struct gdlm_ls *ls = lp->ls;
+	int error, delay_list = 0;
+
+	if (test_bit(LFL_DLM_CANCEL, &lp->flags))
+		return;
+
+	log_info("gdlm_cancel %x,%"PRIx64" flags %lx",
+		 lp->lockname.ln_type, lp->lockname.ln_number, lp->flags);
+
+	spin_lock(&ls->async_lock);
+	if (!list_empty(&lp->delay_list)) {
+		list_del_init(&lp->delay_list);
+		delay_list = 1;
+	}
+	spin_unlock(&ls->async_lock);
+
+	if (delay_list) {
+		set_bit(LFL_CANCEL, &lp->flags);
+		set_bit(LFL_ACTIVE, &lp->flags);
+		queue_complete(lp);
+		return;
+	}
+
+	if (!test_bit(LFL_ACTIVE, &lp->flags) ||
+	    test_bit(LFL_DLM_UNLOCK, &lp->flags))	{
+		log_info("gdlm_cancel skip %x,%"PRIx64" flags %lx",
+		 	 lp->lockname.ln_type, lp->lockname.ln_number,
+			 lp->flags);
+		return;
+	}
+
+	/* the lock is blocked in the dlm */
+
+	set_bit(LFL_DLM_CANCEL, &lp->flags);
+	set_bit(LFL_ACTIVE, &lp->flags);
+
+	error = dlm_unlock(ls->dlm_lockspace, lp->lksb.sb_lkid, DLM_LKF_CANCEL,
+			   NULL, lp);
+
+	log_info("gdlm_cancel rv %d %x,%"PRIx64" flags %lx", error,
+		 lp->lockname.ln_type, lp->lockname.ln_number, lp->flags);
+
+	if (error == -EBUSY)
+		clear_bit(LFL_DLM_CANCEL, &lp->flags);
+}
+
+int gdlm_add_lvb(struct gdlm_lock *lp)
+{
+	char *lvb;
+
+	lvb = kmalloc(GDLM_LVB_SIZE, GFP_KERNEL);
+	if (!lvb)
+		return -ENOMEM;
+
+	memset(lvb, 0, GDLM_LVB_SIZE);
+
+	lp->lksb.sb_lvbptr = lvb;
+	lp->lvb = lvb;
+	return 0;
+}
+
+void gdlm_del_lvb(struct gdlm_lock *lp)
+{
+	kfree(lp->lvb);
+	lp->lvb = NULL;
+	lp->lksb.sb_lvbptr = NULL;
+}
+
+/* This can do a synchronous dlm request (requiring a lock_dlm thread to get
+   the completion) because gfs won't call hold_lvb() during a callback (from
+   the context of a lock_dlm thread). */
+
+static int hold_null_lock(struct gdlm_lock *lp)
+{
+	struct gdlm_lock *lpn = NULL;
+	int error;
+
+	if (lp->hold_null) {
+		printk("lock_dlm: lvb already held\n");
+		return 0;
+	}
+
+	error = gdlm_create_lp(lp->ls, &lp->lockname, &lpn);
+	if (error)
+		goto out;
+
+	lpn->lksb.sb_lvbptr = junk_lvb;
+	lpn->lvb = junk_lvb;
+
+	lpn->req = DLM_LOCK_NL;
+	lpn->lkf = DLM_LKF_VALBLK | DLM_LKF_EXPEDITE;
+	set_bit(LFL_NOBAST, &lpn->flags);
+	set_bit(LFL_INLOCK, &lpn->flags);
+
+	init_completion(&lpn->ast_wait);
+	gdlm_do_lock(lpn, NULL);
+	wait_for_completion(&lpn->ast_wait);
+	error = lp->lksb.sb_status;
+	if (error) {
+		printk("lock_dlm: hold_null_lock dlm error %d\n", error);
+		gdlm_delete_lp(lpn);
+		lpn = NULL;
+	}
+ out:
+	lp->hold_null = lpn;
+	return error;
+}
+
+/* This cannot do a synchronous dlm request (requiring a lock_dlm thread to get
+   the completion) because gfs may call unhold_lvb() during a callback (from
+   the context of a lock_dlm thread) which could cause a deadlock since the
+   other lock_dlm thread could be engaged in recovery. */
+
+static void unhold_null_lock(struct gdlm_lock *lp)
+{
+	struct gdlm_lock *lpn = lp->hold_null;
+
+	GDLM_ASSERT(lpn,);
+	lpn->lksb.sb_lvbptr = NULL;
+	lpn->lvb = NULL;
+	set_bit(LFL_UNLOCK_DELETE, &lpn->flags);
+	gdlm_do_unlock(lpn);
+	lp->hold_null = NULL;
+}
+
+/* Acquire a NL lock because gfs requires the value block to remain
+   intact on the resource while the lvb is "held" even if it's holding no locks
+   on the resource. */
+
+int gdlm_hold_lvb(lm_lock_t *lock, char **lvbp)
+{
+	struct gdlm_lock *lp = (struct gdlm_lock *) lock;
+	int error;
+
+	error = gdlm_add_lvb(lp);
+	if (error)
+		return error;
+
+	*lvbp = lp->lvb;
+
+	error = hold_null_lock(lp);
+	if (error)
+		gdlm_del_lvb(lp);
+
+	return error;
+}
+
+void gdlm_unhold_lvb(lm_lock_t *lock, char *lvb)
+{
+	struct gdlm_lock *lp = (struct gdlm_lock *) lock;
+
+	unhold_null_lock(lp);
+	gdlm_del_lvb(lp);
+}
+
+void gdlm_sync_lvb(lm_lock_t *lock, char *lvb)
+{
+	struct gdlm_lock *lp = (struct gdlm_lock *) lock;
+
+	if (lp->cur != DLM_LOCK_EX)
+		return;
+
+	init_completion(&lp->ast_wait);
+	set_bit(LFL_SYNC_LVB, &lp->flags);
+
+	lp->req = DLM_LOCK_EX;
+	lp->lkf = make_flags(lp, 0, lp->cur, lp->req);
+
+	gdlm_do_lock(lp, NULL);
+	wait_for_completion(&lp->ast_wait);
+}
+
+void gdlm_submit_delayed(struct gdlm_ls *ls)
+{
+	struct gdlm_lock *lp, *safe;
+
+	spin_lock(&ls->async_lock);
+	list_for_each_entry_safe(lp, safe, &ls->delayed, delay_list) {
+		list_del_init(&lp->delay_list);
+		list_add_tail(&lp->delay_list, &ls->submit);
+	}
+	spin_unlock(&ls->async_lock);
+	wake_up(&ls->thread_wait);
+}
+
+int gdlm_release_all_locks(struct gdlm_ls *ls)
+{
+	struct gdlm_lock *lp, *safe;
+	int count = 0;
+
+	spin_lock(&ls->async_lock);
+	list_for_each_entry_safe(lp, safe, &ls->all_locks, all_list) {
+		list_del_init(&lp->all_list);
+
+		if (lp->lvb && lp->lvb != junk_lvb)
+			kfree(lp->lvb);
+		kfree(lp);
+		count++;
+	}
+	spin_unlock(&ls->async_lock);
+
+	return count;
+}
+
diff -urpN a/fs/gfs2/locking/dlm/lock_dlm.h b/fs/gfs2/locking/dlm/lock_dlm.h
--- a/fs/gfs2/locking/dlm/lock_dlm.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/locking/dlm/lock_dlm.h	2005-09-01 17:48:48.147748440 +0800
@@ -0,0 +1,200 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef LOCK_DLM_DOT_H
+#define LOCK_DLM_DOT_H
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/list.h>
+#include <linux/socket.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/kobject.h>
+#include <linux/fcntl.h>
+#include <linux/wait.h>
+#include <net/sock.h>
+
+#include <linux/dlm.h>
+#include "../harness/lm_interface.h"
+
+/*
+ * Internally, we prefix things with gdlm_ and GDLM_ (for gfs-dlm) since a
+ * prefix of lock_dlm_ gets awkward.  Externally, GFS refers to this module
+ * as "lock_dlm".
+ */
+
+#define GDLM_STRNAME_BYTES	24
+#define GDLM_LVB_SIZE		32
+#define GDLM_DROP_COUNT		50000
+#define GDLM_DROP_PERIOD	60
+
+/* GFS uses 12 bytes to identify a resource (32 bit type + 64 bit number).
+   We sprintf these numbers into a 24 byte string of hex values to make them
+   human-readable (to make debugging simpler.) */
+
+struct gdlm_strname {
+	unsigned char		name[GDLM_STRNAME_BYTES];
+	unsigned short		namelen;
+};
+
+#define DFL_BLOCK_LOCKS		0
+#define DFL_JOIN_DONE		1
+#define DFL_LEAVE_DONE		2
+#define DFL_TERMINATE		3
+#define DFL_SPECTATOR		4
+#define DFL_WITHDRAW		5
+
+struct gdlm_ls {
+	uint32_t		id;
+	int			jid;
+	int			first;
+	int			first_done;
+	unsigned long		flags;
+	struct kobject		kobj;
+	char			clustername[128];
+	char			fsname[128];
+	int			fsflags;
+	dlm_lockspace_t		*dlm_lockspace;
+	lm_callback_t		fscb;
+	lm_fsdata_t		*fsdata;
+	int			recover_jid;
+	int			recover_done;
+	spinlock_t		async_lock;
+	struct list_head	complete;
+	struct list_head	blocking;
+	struct list_head	delayed;
+	struct list_head	submit;
+	struct list_head	all_locks;
+	uint32_t		all_locks_count;
+	wait_queue_head_t	wait_control;
+	struct task_struct	*thread1;
+	struct task_struct	*thread2;
+	wait_queue_head_t	thread_wait;
+	unsigned long		drop_time;
+	int			drop_locks_count;
+	int			drop_locks_period;
+};
+
+#define LFL_NOBLOCK		0
+#define LFL_NOCACHE		1
+#define LFL_DLM_UNLOCK		2
+#define LFL_DLM_CANCEL		3
+#define LFL_SYNC_LVB		4
+#define LFL_FORCE_PROMOTE	5
+#define LFL_REREQUEST		6
+#define LFL_ACTIVE		7
+#define LFL_INLOCK		8
+#define LFL_CANCEL		9
+#define LFL_NOBAST		10
+#define LFL_HEADQUE		11
+#define LFL_UNLOCK_DELETE	12
+
+struct gdlm_lock {
+	struct gdlm_ls		*ls;
+	struct lm_lockname	lockname;
+	char			*lvb;
+	struct dlm_lksb		lksb;
+
+	int16_t			cur;
+	int16_t			req;
+	int16_t			prev_req;
+	uint32_t		lkf;		/* dlm flags DLM_LKF_ */
+	unsigned long		flags;		/* lock_dlm flags LFL_ */
+
+	int			bast_mode;	/* protected by async_lock */
+	struct completion	ast_wait;
+
+	struct list_head	clist;		/* complete */
+	struct list_head	blist;		/* blocking */
+	struct list_head	delay_list;	/* delayed */
+	struct list_head	all_list;	/* all locks for the fs */
+	struct gdlm_lock	*hold_null;	/* NL lock for hold_lvb */
+};
+
+#if (BITS_PER_LONG == 64)
+#define PRIx64 "lx"
+#else
+#define PRIx64 "Lx"
+#endif
+
+#define GDLM_ASSERT(x, do) \
+{ \
+  if (!(x)) \
+  { \
+    printk("\nlock_dlm:  Assertion failed on line %d of file %s\n" \
+           "lock_dlm:  assertion:  \"%s\"\n" \
+           "lock_dlm:  time = %lu\n", \
+           __LINE__, __FILE__, #x, jiffies); \
+    {do} \
+    printk("\n"); \
+    BUG(); \
+    panic("lock_dlm:  Record message above and reboot.\n"); \
+  } \
+}
+
+#define log_print(lev, fmt, arg...) printk(lev "lock_dlm: " fmt "\n" , ## arg)
+#define log_info(fmt, arg...)  log_print(KERN_INFO , fmt , ## arg)
+#define log_error(fmt, arg...) log_print(KERN_ERR , fmt , ## arg)
+#ifdef LOCK_DLM_LOG_DEBUG
+#define log_debug(fmt, arg...) log_print(KERN_DEBUG , fmt , ## arg)
+#else
+#define log_debug(fmt, arg...)
+#endif
+
+/* sysfs.c */
+
+int gdlm_sysfs_init(void);
+void gdlm_sysfs_exit(void);
+int gdlm_kobject_setup(struct gdlm_ls *);
+void gdlm_kobject_release(struct gdlm_ls *);
+
+/* thread.c */
+
+int gdlm_init_threads(struct gdlm_ls *);
+void gdlm_release_threads(struct gdlm_ls *);
+
+/* lock.c */
+
+int16_t gdlm_make_lmstate(int16_t);
+void gdlm_queue_delayed(struct gdlm_lock *);
+void gdlm_submit_delayed(struct gdlm_ls *);
+int gdlm_release_all_locks(struct gdlm_ls *);
+int gdlm_create_lp(struct gdlm_ls *, struct lm_lockname *, struct gdlm_lock **);
+void gdlm_delete_lp(struct gdlm_lock *);
+int gdlm_add_lvb(struct gdlm_lock *);
+void gdlm_del_lvb(struct gdlm_lock *);
+void gdlm_do_lock(struct gdlm_lock *, struct dlm_range *);
+void gdlm_do_unlock(struct gdlm_lock *);
+
+int gdlm_get_lock(lm_lockspace_t *, struct lm_lockname *, lm_lock_t **);
+void gdlm_put_lock(lm_lock_t *);
+unsigned int gdlm_lock(lm_lock_t *, unsigned int, unsigned int, unsigned int);
+unsigned int gdlm_unlock(lm_lock_t *, unsigned int);
+void gdlm_cancel(lm_lock_t *);
+int gdlm_hold_lvb(lm_lock_t *, char **);
+void gdlm_unhold_lvb(lm_lock_t *, char *);
+void gdlm_sync_lvb(lm_lock_t *, char *);
+
+/* plock.c */
+
+int gdlm_plock_init(void);
+void gdlm_plock_exit(void);
+int gdlm_plock(lm_lockspace_t *, struct lm_lockname *, struct file *, int,
+		struct file_lock *);
+int gdlm_plock_get(lm_lockspace_t *, struct lm_lockname *, struct file *,
+		struct file_lock *);
+int gdlm_punlock(lm_lockspace_t *, struct lm_lockname *, struct file *,
+		struct file_lock *);
+#endif
+
diff -urpN a/fs/gfs2/locking/dlm/main.c b/fs/gfs2/locking/dlm/main.c
--- a/fs/gfs2/locking/dlm/main.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/locking/dlm/main.c	2005-09-01 17:48:48.140749504 +0800
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/init.h>
+
+#include "lock_dlm.h"
+
+extern int gdlm_drop_count;
+extern int gdlm_drop_period;
+
+extern struct lm_lockops gdlm_ops;
+
+int __init init_lock_dlm(void)
+{
+	int error;
+
+	error = lm_register_proto(&gdlm_ops);
+	if (error) {
+		printk("lock_dlm:  can't register protocol: %d\n", error);
+		return error;
+	}
+
+	error = gdlm_sysfs_init();
+	if (error) {
+		lm_unregister_proto(&gdlm_ops);
+		return error;
+	}
+
+	error = gdlm_plock_init();
+	if (error) {
+		gdlm_sysfs_exit();
+		lm_unregister_proto(&gdlm_ops);
+		return error;
+	}
+
+	gdlm_drop_count = GDLM_DROP_COUNT;
+	gdlm_drop_period = GDLM_DROP_PERIOD;
+
+	printk("Lock_DLM (built %s %s) installed\n", __DATE__, __TIME__);
+	return 0;
+}
+
+void __exit exit_lock_dlm(void)
+{
+	gdlm_plock_exit();
+	gdlm_sysfs_exit();
+	lm_unregister_proto(&gdlm_ops);
+}
+
+module_init(init_lock_dlm);
+module_exit(exit_lock_dlm);
+
+MODULE_DESCRIPTION("GFS DLM Locking Module");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
diff -urpN a/fs/gfs2/locking/dlm/mount.c b/fs/gfs2/locking/dlm/mount.c
--- a/fs/gfs2/locking/dlm/mount.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/locking/dlm/mount.c	2005-09-01 17:48:48.140749504 +0800
@@ -0,0 +1,218 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include "lock_dlm.h"
+
+int gdlm_drop_count;
+int gdlm_drop_period;
+struct lm_lockops gdlm_ops;
+
+
+static struct gdlm_ls *init_gdlm(lm_callback_t cb, lm_fsdata_t *fsdata,
+				 int flags, char *table_name)
+{
+	struct gdlm_ls *ls;
+	char buf[256], *p;
+
+	ls = kmalloc(sizeof(struct gdlm_ls), GFP_KERNEL);
+	if (!ls)
+		return NULL;
+
+	memset(ls, 0, sizeof(struct gdlm_ls));
+
+	ls->drop_locks_count = gdlm_drop_count;
+	ls->drop_locks_period = gdlm_drop_period;
+
+	ls->fscb = cb;
+	ls->fsdata = fsdata;
+	ls->fsflags = flags;
+
+	spin_lock_init(&ls->async_lock);
+
+	INIT_LIST_HEAD(&ls->complete);
+	INIT_LIST_HEAD(&ls->blocking);
+	INIT_LIST_HEAD(&ls->delayed);
+	INIT_LIST_HEAD(&ls->submit);
+	INIT_LIST_HEAD(&ls->all_locks);
+
+	init_waitqueue_head(&ls->thread_wait);
+	init_waitqueue_head(&ls->wait_control);
+	ls->thread1 = NULL;
+	ls->thread2 = NULL;
+	ls->drop_time = jiffies;
+	ls->jid = -1;
+
+	strncpy(buf, table_name, 256);
+	buf[255] = '\0';
+
+	p = strstr(buf, ":");
+	if (!p) {
+		printk("lock_dlm: invalid table_name \"%s\"\n", table_name);
+		kfree(ls);
+		return NULL;
+	}
+	*p = '\0';
+	p++;
+
+	strncpy(ls->clustername, buf, 128);
+	strncpy(ls->fsname, p, 128);
+
+	return ls;
+}
+
+static int gdlm_mount(char *table_name, char *host_data,
+			lm_callback_t cb, lm_fsdata_t *fsdata,
+			unsigned int min_lvb_size, int flags,
+			struct lm_lockstruct *lockstruct)
+{
+	struct gdlm_ls *ls;
+	int error = -ENOMEM;
+
+	if (min_lvb_size > GDLM_LVB_SIZE)
+		goto out;
+
+	ls = init_gdlm(cb, fsdata, flags, table_name);
+	if (!ls)
+		goto out;
+
+	error = gdlm_init_threads(ls);
+	if (error)
+		goto out_free;
+
+	error = dlm_new_lockspace(ls->fsname, strlen(ls->fsname),
+				  &ls->dlm_lockspace, 0, GDLM_LVB_SIZE);
+	if (error) {
+		printk("lock_dlm: dlm_new_lockspace error %d\n", error);
+		goto out_thread;
+	}
+
+	error = gdlm_kobject_setup(ls);
+	if (error)
+		goto out_dlm;
+	kobject_uevent(&ls->kobj, KOBJ_MOUNT, NULL);
+
+	/* Now we depend on userspace to notice the new mount,
+	   join the appropriate group, and do a write to our sysfs
+	   "mounted" or "terminate" file.  Before the start, userspace
+	   must set "jid" and "first". */
+
+	error = wait_event_interruptible(ls->wait_control,
+			test_bit(DFL_JOIN_DONE, &ls->flags));
+	if (error)
+		goto out_sysfs;
+
+	if (test_bit(DFL_TERMINATE, &ls->flags)) {
+		error = -ERESTARTSYS;
+		goto out_sysfs;
+	}
+
+	lockstruct->ls_jid = ls->jid;
+	lockstruct->ls_first = ls->first;
+	lockstruct->ls_lockspace = ls;
+	lockstruct->ls_ops = &gdlm_ops;
+	lockstruct->ls_flags = 0;
+	lockstruct->ls_lvb_size = GDLM_LVB_SIZE;
+	return 0;
+
+ out_sysfs:
+	gdlm_kobject_release(ls);
+ out_dlm:
+	dlm_release_lockspace(ls->dlm_lockspace, 2);
+ out_thread:
+	gdlm_release_threads(ls);
+ out_free:
+	kfree(ls);
+ out:
+	return error;
+}
+
+static void gdlm_unmount(lm_lockspace_t *lockspace)
+{
+	struct gdlm_ls *ls = (struct gdlm_ls *) lockspace;
+	int rv;
+
+	log_debug("unmount flags %lx", ls->flags);
+
+	if (test_bit(DFL_WITHDRAW, &ls->flags)) {
+		gdlm_kobject_release(ls);
+		goto out;
+	}
+
+	kobject_uevent(&ls->kobj, KOBJ_UMOUNT, NULL);
+
+	wait_event_interruptible(ls->wait_control,
+				 test_bit(DFL_LEAVE_DONE, &ls->flags));
+
+	gdlm_kobject_release(ls);
+	dlm_release_lockspace(ls->dlm_lockspace, 2);
+	gdlm_release_threads(ls);
+	rv = gdlm_release_all_locks(ls);
+	if (rv)
+		log_info("lm_dlm_unmount: %d stray locks freed", rv);
+ out:
+	kfree(ls);
+}
+
+static void gdlm_recovery_done(lm_lockspace_t *lockspace, unsigned int jid,
+                               unsigned int message)
+{
+	struct gdlm_ls *ls = (struct gdlm_ls *) lockspace;
+	ls->recover_done = jid;
+	kobject_uevent(&ls->kobj, KOBJ_CHANGE, NULL);
+}
+
+static void gdlm_others_may_mount(lm_lockspace_t *lockspace)
+{
+	struct gdlm_ls *ls = (struct gdlm_ls *) lockspace;
+	ls->first_done = 1;
+	kobject_uevent(&ls->kobj, KOBJ_CHANGE, NULL);
+}
+
+static void gdlm_withdraw(lm_lockspace_t *lockspace)
+{
+	struct gdlm_ls *ls = (struct gdlm_ls *) lockspace;
+
+	/* userspace suspends locking on all other members */
+
+	kobject_uevent(&ls->kobj, KOBJ_OFFLINE, NULL);
+
+	wait_event_interruptible(ls->wait_control,
+				 test_bit(DFL_WITHDRAW, &ls->flags));
+
+	dlm_release_lockspace(ls->dlm_lockspace, 2);
+	gdlm_release_threads(ls);
+	gdlm_release_all_locks(ls);
+
+	kobject_uevent(&ls->kobj, KOBJ_UMOUNT, NULL);
+
+	/* userspace leaves the mount group, we don't need to wait for
+	   that to complete */
+}
+
+struct lm_lockops gdlm_ops = {
+	.lm_proto_name = "lock_dlm",
+	.lm_mount = gdlm_mount,
+	.lm_others_may_mount = gdlm_others_may_mount,
+	.lm_unmount = gdlm_unmount,
+	.lm_withdraw = gdlm_withdraw,
+	.lm_get_lock = gdlm_get_lock,
+	.lm_put_lock = gdlm_put_lock,
+	.lm_lock = gdlm_lock,
+	.lm_unlock = gdlm_unlock,
+	.lm_plock = gdlm_plock,
+	.lm_punlock = gdlm_punlock,
+	.lm_plock_get = gdlm_plock_get,
+	.lm_cancel = gdlm_cancel,
+	.lm_hold_lvb = gdlm_hold_lvb,
+	.lm_unhold_lvb = gdlm_unhold_lvb,
+	.lm_sync_lvb = gdlm_sync_lvb,
+	.lm_recovery_done = gdlm_recovery_done,
+	.lm_owner = THIS_MODULE,
+};
+
diff -urpN a/fs/gfs2/locking/dlm/plock.c b/fs/gfs2/locking/dlm/plock.c
--- a/fs/gfs2/locking/dlm/plock.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/locking/dlm/plock.c	2005-09-01 17:48:48.148748288 +0800
@@ -0,0 +1,274 @@
+/*
+ * Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include "lock_dlm.h"
+#include <linux/lock_dlm_plock.h>
+
+#include <linux/miscdevice.h>
+
+static spinlock_t ops_lock;
+static struct list_head send_list;
+static struct list_head recv_list;
+static wait_queue_head_t send_wq;
+static wait_queue_head_t recv_wq;
+
+struct plock_op {
+	struct list_head list;
+	int done;
+	struct gdlm_plock_info info;
+};
+
+static inline void set_version(struct gdlm_plock_info *info)
+{
+	info->version[0] = GDLM_PLOCK_VERSION_MAJOR;
+	info->version[1] = GDLM_PLOCK_VERSION_MINOR;
+	info->version[2] = GDLM_PLOCK_VERSION_PATCH;
+}
+
+static int check_version(struct gdlm_plock_info *info)
+{
+	if ((GDLM_PLOCK_VERSION_MAJOR != info->version[0]) ||
+	    (GDLM_PLOCK_VERSION_MINOR < info->version[1])) {
+		log_error("plock device version mismatch: "
+			  "kernel (%u.%u.%u), user (%u.%u.%u)",
+			  GDLM_PLOCK_VERSION_MAJOR,
+			  GDLM_PLOCK_VERSION_MINOR,
+			  GDLM_PLOCK_VERSION_PATCH,
+			  info->version[0],
+			  info->version[1],
+			  info->version[2]);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int gdlm_plock(lm_lockspace_t *lockspace, struct lm_lockname *name,
+	       struct file *file, int cmd, struct file_lock *fl)
+{
+	struct gdlm_ls *ls = (struct gdlm_ls *) lockspace;
+	struct plock_op *op;
+	int rv;
+
+	op = kzalloc(sizeof(*op), GFP_KERNEL);
+	if (!op)
+		return -ENOMEM;
+
+	log_debug("en plock %x,%"PRIx64"", name->ln_type, name->ln_number);
+
+	set_version(&op->info);
+	op->info.optype		= GDLM_PLOCK_OP_LOCK;
+	op->info.pid		= (uint32_t) fl->fl_owner;
+	op->info.ex		= (fl->fl_type == F_WRLCK);
+	op->info.wait		= IS_SETLKW(cmd);
+	op->info.fsid		= ls->id;
+	op->info.number		= name->ln_number;
+	op->info.start		= fl->fl_start;
+	op->info.end		= fl->fl_end;
+
+	INIT_LIST_HEAD(&op->list);
+	spin_lock(&ops_lock);
+	list_add_tail(&op->list, &send_list);
+	spin_unlock(&ops_lock);
+	wake_up(&send_wq);
+
+	wait_event(recv_wq, (op->done != 0));
+
+	spin_lock(&ops_lock);
+	if (!list_empty(&op->list)) {
+		printk("plock op on list\n");
+		list_del(&op->list);
+	}
+	spin_unlock(&ops_lock);
+
+	log_debug("ex plock done %d rv %d", op->done, op->info.rv);
+
+	rv = op->info.rv;
+
+	if (!rv) {
+		if (posix_lock_file_wait(file, fl) < 0)
+			log_error("gdlm_plock: vfs lock error %x,%"PRIx64"",
+				  name->ln_type, name->ln_number);
+	}
+
+	kfree(op);
+	return rv;
+}
+
+int gdlm_punlock(lm_lockspace_t *lockspace, struct lm_lockname *name,
+		 struct file *file, struct file_lock *fl)
+{
+	struct gdlm_ls *ls = (struct gdlm_ls *) lockspace;
+	struct plock_op *op;
+	int rv;
+
+	op = kzalloc(sizeof(*op), GFP_KERNEL);
+	if (!op)
+		return -ENOMEM;
+
+	log_debug("en punlock %x,%"PRIx64"", name->ln_type, name->ln_number);
+
+	if (posix_lock_file_wait(file, fl) < 0)
+		log_error("gdlm_punlock: vfs unlock error %x,%"PRIx64"",
+			  name->ln_type, name->ln_number);
+
+	set_version(&op->info);
+	op->info.optype		= GDLM_PLOCK_OP_UNLOCK;
+	op->info.pid		= (uint32_t) fl->fl_owner;
+	op->info.fsid		= ls->id;
+	op->info.number		= name->ln_number;
+	op->info.start		= fl->fl_start;
+	op->info.end		= fl->fl_end;
+
+	INIT_LIST_HEAD(&op->list);
+	spin_lock(&ops_lock);
+	list_add_tail(&op->list, &send_list);
+	spin_unlock(&ops_lock);
+	wake_up(&send_wq);
+
+	wait_event(recv_wq, (op->done != 0));
+
+	spin_lock(&ops_lock);
+	if (!list_empty(&op->list)) {
+		printk("plock op on list\n");
+		list_del(&op->list);
+	}
+	spin_unlock(&ops_lock);
+
+	log_debug("ex punlock done %d rv %d", op->done, op->info.rv);
+
+	rv = op->info.rv;
+
+	kfree(op);
+	return rv;
+}
+
+int gdlm_plock_get(lm_lockspace_t *lockspace, struct lm_lockname *name,
+		   struct file *file, struct file_lock *fl)
+{
+	return -ENOSYS;
+}
+
+/* a read copies out one plock request from the send list */
+static ssize_t dev_read(struct file *file, char __user *u, size_t count,
+			loff_t *ppos)
+{
+	struct gdlm_plock_info info;
+	struct plock_op *op = NULL;
+
+	if (count < sizeof(info))
+		return -EINVAL;
+
+	spin_lock(&ops_lock);
+	if (!list_empty(&send_list)) {
+		op = list_entry(send_list.next, struct plock_op, list);
+		list_move(&op->list, &recv_list);
+		memcpy(&info, &op->info, sizeof(info));
+	}
+	spin_unlock(&ops_lock);
+
+	if (!op)
+		return -EAGAIN;
+
+	log_debug("send %"PRIx64" op %d ex %d wait %d", info.number,
+		  info.optype, info.ex, info.wait);
+
+	if (copy_to_user(u, &info, sizeof(info)))
+		return -EFAULT;
+	return sizeof(info);
+}
+
+/* a write copies in one plock result that should match a plock_op
+   on the recv list */
+static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
+			 loff_t *ppos)
+{
+	struct gdlm_plock_info info;
+	struct plock_op *op;
+	int found = 0;
+
+	if (count != sizeof(info))
+		return -EINVAL;
+
+	if (copy_from_user(&info, u, sizeof(info)))
+		return -EFAULT;
+
+	if (check_version(&info))
+		return -EINVAL;
+
+	log_debug("recv %"PRIx64" op %d ex %d wait %d", info.number,
+		  info.optype, info.ex, info.wait);
+
+	spin_lock(&ops_lock);
+	list_for_each_entry(op, &recv_list, list) {
+		if (op->info.fsid == info.fsid &&
+		    op->info.number == info.number) {
+			list_del_init(&op->list);
+			found = 1;
+			op->done = 1;
+			memcpy(&op->info, &info, sizeof(info));
+			break;
+		}
+	}
+	spin_unlock(&ops_lock);
+
+	if (found)
+		wake_up(&recv_wq);
+	else
+		printk("gdlm dev_write no op %x %"PRIx64"\n", info.fsid,
+			info.number);
+	return count;
+}
+
+static unsigned int dev_poll(struct file *file, poll_table *wait)
+{
+	poll_wait(file, &send_wq, wait);
+
+	spin_lock(&ops_lock);
+	if (!list_empty(&send_list)) {
+		spin_unlock(&ops_lock);
+		return POLLIN | POLLRDNORM;
+	}
+	spin_unlock(&ops_lock);
+	return 0;
+}
+
+static struct file_operations dev_fops = {
+	.read    = dev_read,
+	.write   = dev_write,
+	.poll    = dev_poll,
+	.owner   = THIS_MODULE
+};
+
+static struct miscdevice plock_dev_misc = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = GDLM_PLOCK_MISC_NAME,
+	.fops = &dev_fops
+};
+
+int gdlm_plock_init(void)
+{
+	int rv;
+
+	spin_lock_init(&ops_lock);
+	INIT_LIST_HEAD(&send_list);
+	INIT_LIST_HEAD(&recv_list);
+	init_waitqueue_head(&send_wq);
+	init_waitqueue_head(&recv_wq);
+
+	rv = misc_register(&plock_dev_misc);
+	if (rv)
+		printk("gdlm_plock_init: misc_register failed %d", rv);
+	return rv;
+}
+
+void gdlm_plock_exit(void)
+{
+	if (misc_deregister(&plock_dev_misc) < 0)
+		printk("gdlm_plock_exit: misc_deregister failed");
+}
+
diff -urpN a/fs/gfs2/locking/dlm/sysfs.c b/fs/gfs2/locking/dlm/sysfs.c
--- a/fs/gfs2/locking/dlm/sysfs.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/locking/dlm/sysfs.c	2005-09-01 17:48:48.140749504 +0800
@@ -0,0 +1,283 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/ctype.h>
+#include <linux/stat.h>
+
+#include "lock_dlm.h"
+
+static ssize_t gdlm_block_show(struct gdlm_ls *ls, char *buf)
+{
+	ssize_t ret;
+	int val = 0;
+
+	if (test_bit(DFL_BLOCK_LOCKS, &ls->flags))
+		val = 1;
+	ret = sprintf(buf, "%d\n", val);
+	return ret;
+}
+
+static ssize_t gdlm_block_store(struct gdlm_ls *ls, const char *buf, size_t len)
+{
+	ssize_t ret = len;
+	int val;
+
+	val = simple_strtol(buf, NULL, 0);
+
+	if (val == 1)
+		set_bit(DFL_BLOCK_LOCKS, &ls->flags);
+	else if (val == 0) {
+		clear_bit(DFL_BLOCK_LOCKS, &ls->flags);
+		gdlm_submit_delayed(ls);
+	} else
+		ret = -EINVAL;
+	return ret;
+}
+
+static ssize_t gdlm_mounted_show(struct gdlm_ls *ls, char *buf)
+{
+	ssize_t ret;
+	int val = -2;
+
+	if (test_bit(DFL_TERMINATE, &ls->flags))
+		val = -1;
+	else if (test_bit(DFL_LEAVE_DONE, &ls->flags))
+		val = 0;
+	else if (test_bit(DFL_JOIN_DONE, &ls->flags))
+		val = 1;
+	ret = sprintf(buf, "%d\n", val);
+	return ret;
+}
+
+static ssize_t gdlm_mounted_store(struct gdlm_ls *ls, const char *buf, size_t len)
+{
+	ssize_t ret = len;
+	int val;
+
+	val = simple_strtol(buf, NULL, 0);
+
+	if (val == 1)
+		set_bit(DFL_JOIN_DONE, &ls->flags);
+	else if (val == 0)
+		set_bit(DFL_LEAVE_DONE, &ls->flags);
+	else if (val == -1) {
+		set_bit(DFL_TERMINATE, &ls->flags);
+		set_bit(DFL_JOIN_DONE, &ls->flags);
+		set_bit(DFL_LEAVE_DONE, &ls->flags);
+	} else
+		ret = -EINVAL;
+	wake_up(&ls->wait_control);
+	return ret;
+}
+
+static ssize_t gdlm_withdraw_show(struct gdlm_ls *ls, char *buf)
+{
+	ssize_t ret;
+	int val = 0;
+
+	if (test_bit(DFL_WITHDRAW, &ls->flags))
+		val = 1;
+	ret = sprintf(buf, "%d\n", val);
+	return ret;
+}
+
+static ssize_t gdlm_withdraw_store(struct gdlm_ls *ls, const char *buf, size_t len)
+{
+	ssize_t ret = len;
+	int val;
+
+	val = simple_strtol(buf, NULL, 0);
+
+	if (val == 1)
+		set_bit(DFL_WITHDRAW, &ls->flags);
+	else
+		ret = -EINVAL;
+	wake_up(&ls->wait_control);
+	return ret;
+}
+
+static ssize_t gdlm_id_show(struct gdlm_ls *ls, char *buf)
+{
+	return sprintf(buf, "%u\n", ls->id);
+}
+
+static ssize_t gdlm_id_store(struct gdlm_ls *ls, const char *buf, size_t len)
+{
+	ls->id = simple_strtoul(buf, NULL, 0);
+	return len;
+}
+
+static ssize_t gdlm_jid_show(struct gdlm_ls *ls, char *buf)
+{
+	return sprintf(buf, "%d\n", ls->jid);
+}
+
+static ssize_t gdlm_jid_store(struct gdlm_ls *ls, const char *buf, size_t len)
+{
+	ls->jid = simple_strtol(buf, NULL, 0);
+	return len;
+}
+
+static ssize_t gdlm_first_show(struct gdlm_ls *ls, char *buf)
+{
+	return sprintf(buf, "%d\n", ls->first);
+}
+
+static ssize_t gdlm_first_store(struct gdlm_ls *ls, const char *buf, size_t len)
+{
+	ls->first = simple_strtol(buf, NULL, 0);
+	return len;
+}
+
+static ssize_t gdlm_first_done_show(struct gdlm_ls *ls, char *buf)
+{
+	return sprintf(buf, "%d\n", ls->first_done);
+}
+
+static ssize_t gdlm_recover_show(struct gdlm_ls *ls, char *buf)
+{
+	return sprintf(buf, "%d\n", ls->recover_jid);
+}
+
+static ssize_t gdlm_recover_store(struct gdlm_ls *ls, const char *buf, size_t len)
+{
+	ls->recover_jid = simple_strtol(buf, NULL, 0);
+	ls->fscb(ls->fsdata, LM_CB_NEED_RECOVERY, &ls->recover_jid);
+	return len;
+}
+
+static ssize_t gdlm_recover_done_show(struct gdlm_ls *ls, char *buf)
+{
+	ssize_t ret;
+	ret = sprintf(buf, "%d\n", ls->recover_done);
+	return ret;
+}
+
+static ssize_t gdlm_cluster_show(struct gdlm_ls *ls, char *buf)
+{
+	ssize_t ret;
+	ret = sprintf(buf, "%s\n", ls->clustername);
+	return ret;
+}
+
+static ssize_t gdlm_options_show(struct gdlm_ls *ls, char *buf)
+{
+	ssize_t ret = 0;
+
+	if (ls->fsflags & LM_MFLAG_SPECTATOR)
+		ret += sprintf(buf, "spectator ");
+
+	return ret;
+}
+
+struct gdlm_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct gdlm_ls *, char *);
+	ssize_t (*store)(struct gdlm_ls *, const char *, size_t);
+};
+
+#define GDLM_ATTR(_name,_mode,_show,_store) \
+static struct gdlm_attr gdlm_attr_##_name = __ATTR(_name,_mode,_show,_store)
+
+GDLM_ATTR(block, S_IRUGO | S_IWUSR, gdlm_block_show, gdlm_block_store);
+GDLM_ATTR(mounted, S_IRUGO | S_IWUSR, gdlm_mounted_show, gdlm_mounted_store);
+GDLM_ATTR(withdraw, S_IRUGO | S_IWUSR, gdlm_withdraw_show, gdlm_withdraw_store);
+GDLM_ATTR(id, S_IRUGO | S_IWUSR, gdlm_id_show, gdlm_id_store);
+GDLM_ATTR(jid, S_IRUGO | S_IWUSR, gdlm_jid_show, gdlm_jid_store);
+GDLM_ATTR(first, S_IRUGO | S_IWUSR, gdlm_first_show, gdlm_first_store);
+GDLM_ATTR(first_done, S_IRUGO, gdlm_first_done_show, NULL);
+GDLM_ATTR(recover, S_IRUGO | S_IWUSR, gdlm_recover_show, gdlm_recover_store);
+GDLM_ATTR(recover_done, S_IRUGO, gdlm_recover_done_show, NULL);
+GDLM_ATTR(cluster, S_IRUGO, gdlm_cluster_show, NULL);
+GDLM_ATTR(options, S_IRUGO, gdlm_options_show, NULL);
+
+static struct attribute *gdlm_attrs[] = {
+	&gdlm_attr_block.attr,
+	&gdlm_attr_mounted.attr,
+	&gdlm_attr_withdraw.attr,
+	&gdlm_attr_id.attr,
+	&gdlm_attr_jid.attr,
+	&gdlm_attr_first.attr,
+	&gdlm_attr_first_done.attr,
+	&gdlm_attr_recover.attr,
+	&gdlm_attr_recover_done.attr,
+	&gdlm_attr_cluster.attr,
+	&gdlm_attr_options.attr,
+	NULL,
+};
+
+static ssize_t gdlm_attr_show(struct kobject *kobj, struct attribute *attr,
+			      char *buf)
+{
+	struct gdlm_ls *ls = container_of(kobj, struct gdlm_ls, kobj);
+	struct gdlm_attr *a = container_of(attr, struct gdlm_attr, attr);
+	return a->show ? a->show(ls, buf) : 0;
+}
+
+static ssize_t gdlm_attr_store(struct kobject *kobj, struct attribute *attr,
+			       const char *buf, size_t len)
+{
+	struct gdlm_ls *ls = container_of(kobj, struct gdlm_ls, kobj);
+	struct gdlm_attr *a = container_of(attr, struct gdlm_attr, attr);
+	return a->store ? a->store(ls, buf, len) : len;
+}
+
+static struct sysfs_ops gdlm_attr_ops = {
+	.show  = gdlm_attr_show,
+	.store = gdlm_attr_store,
+};
+
+static struct kobj_type gdlm_ktype = {
+	.default_attrs = gdlm_attrs,
+	.sysfs_ops     = &gdlm_attr_ops,
+};
+
+static struct kset gdlm_kset = {
+	.subsys = &kernel_subsys,
+	.kobj   = {.name = "lock_dlm",},
+	.ktype  = &gdlm_ktype,
+};
+
+int gdlm_kobject_setup(struct gdlm_ls *ls)
+{
+	int error;
+
+	error = kobject_set_name(&ls->kobj, "%s", ls->fsname);
+	if (error)
+		return error;
+
+	ls->kobj.kset = &gdlm_kset;
+	ls->kobj.ktype = &gdlm_ktype;
+
+	error = kobject_register(&ls->kobj);
+
+	return 0;
+}
+
+void gdlm_kobject_release(struct gdlm_ls *ls)
+{
+	kobject_unregister(&ls->kobj);
+}
+
+int gdlm_sysfs_init(void)
+{
+	int error;
+
+	error = kset_register(&gdlm_kset);
+	if (error)
+		printk("lock_dlm: cannot register kset %d\n", error);
+
+	return error;
+}
+
+void gdlm_sysfs_exit(void)
+{
+	kset_unregister(&gdlm_kset);
+}
+
diff -urpN a/fs/gfs2/locking/dlm/thread.c b/fs/gfs2/locking/dlm/thread.c
--- a/fs/gfs2/locking/dlm/thread.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/locking/dlm/thread.c	2005-09-01 17:48:48.140749504 +0800
@@ -0,0 +1,355 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include "lock_dlm.h"
+
+/* A lock placed on this queue is re-submitted to DLM as soon as the lock_dlm
+   thread gets to it. */
+
+static void queue_submit(struct gdlm_lock *lp)
+{
+	struct gdlm_ls *ls = lp->ls;
+
+	spin_lock(&ls->async_lock);
+	list_add_tail(&lp->delay_list, &ls->submit);
+	spin_unlock(&ls->async_lock);
+	wake_up(&ls->thread_wait);
+}
+
+static void process_submit(struct gdlm_lock *lp)
+{
+	gdlm_do_lock(lp, NULL);
+}
+
+static void process_blocking(struct gdlm_lock *lp, int bast_mode)
+{
+	struct gdlm_ls *ls = lp->ls;
+	unsigned int cb;
+
+	switch (gdlm_make_lmstate(bast_mode)) {
+	case LM_ST_EXCLUSIVE:
+		cb = LM_CB_NEED_E;
+		break;
+	case LM_ST_DEFERRED:
+		cb = LM_CB_NEED_D;
+		break;
+	case LM_ST_SHARED:
+		cb = LM_CB_NEED_S;
+		break;
+	default:
+		GDLM_ASSERT(0, printk("unknown bast mode %u\n",lp->bast_mode););
+	}
+
+	ls->fscb(ls->fsdata, cb, &lp->lockname);
+}
+
+static void process_complete(struct gdlm_lock *lp)
+{
+	struct gdlm_ls *ls = lp->ls;
+	struct lm_async_cb acb;
+	int16_t prev_mode = lp->cur;
+
+	memset(&acb, 0, sizeof(acb));
+
+	if (lp->lksb.sb_status == -DLM_ECANCEL) {
+		log_info("complete dlm cancel %x,%"PRIx64" flags %lx",
+		 	 lp->lockname.ln_type, lp->lockname.ln_number,
+			 lp->flags);
+
+		lp->req = lp->cur;
+		acb.lc_ret |= LM_OUT_CANCELED;
+		if (lp->cur == DLM_LOCK_IV)
+			lp->lksb.sb_lkid = 0;
+		goto out;
+	}
+
+	if (test_and_clear_bit(LFL_DLM_UNLOCK, &lp->flags)) {
+		if (lp->lksb.sb_status != -DLM_EUNLOCK) {
+			log_info("unlock sb_status %d %x,%"PRIx64" flags %lx",
+				 lp->lksb.sb_status, lp->lockname.ln_type,
+				 lp->lockname.ln_number, lp->flags);
+			return;
+		}
+
+		lp->cur = DLM_LOCK_IV;
+		lp->req = DLM_LOCK_IV;
+		lp->lksb.sb_lkid = 0;
+
+		if (test_and_clear_bit(LFL_UNLOCK_DELETE, &lp->flags)) {
+			gdlm_delete_lp(lp);
+			return;
+		}
+		goto out;
+	}
+
+	if (lp->lksb.sb_flags & DLM_SBF_VALNOTVALID)
+		memset(lp->lksb.sb_lvbptr, 0, GDLM_LVB_SIZE);
+
+	if (lp->lksb.sb_flags & DLM_SBF_ALTMODE) {
+		if (lp->req == DLM_LOCK_PR)
+			lp->req = DLM_LOCK_CW;
+		else if (lp->req == DLM_LOCK_CW)
+			lp->req = DLM_LOCK_PR;
+	}
+
+	/*
+	 * A canceled lock request.  The lock was just taken off the delayed
+	 * list and was never even submitted to dlm.
+	 */
+
+	if (test_and_clear_bit(LFL_CANCEL, &lp->flags)) {
+		log_info("complete internal cancel %x,%"PRIx64"",
+		 	 lp->lockname.ln_type, lp->lockname.ln_number);
+		lp->req = lp->cur;
+		acb.lc_ret |= LM_OUT_CANCELED;
+		goto out;
+	}
+
+	/*
+	 * An error occured.
+	 */
+
+	if (lp->lksb.sb_status) {
+		/* a "normal" error */
+		if ((lp->lksb.sb_status == -EAGAIN) &&
+		    (lp->lkf & DLM_LKF_NOQUEUE)) {
+			lp->req = lp->cur;
+			if (lp->cur == DLM_LOCK_IV)
+				lp->lksb.sb_lkid = 0;
+			goto out;
+		}
+
+		/* this could only happen with cancels I think */
+		log_info("ast sb_status %d %x,%"PRIx64" flags %lx",
+			 lp->lksb.sb_status, lp->lockname.ln_type,
+			 lp->lockname.ln_number, lp->flags);
+		return;
+	}
+
+	/*
+	 * This is an AST for an EX->EX conversion for sync_lvb from GFS.
+	 */
+
+	if (test_and_clear_bit(LFL_SYNC_LVB, &lp->flags)) {
+		complete(&lp->ast_wait);
+		return;
+	}
+
+	/*
+	 * A lock has been demoted to NL because it initially completed during
+	 * BLOCK_LOCKS.  Now it must be requested in the originally requested
+	 * mode.
+	 */
+
+	if (test_and_clear_bit(LFL_REREQUEST, &lp->flags)) {
+		GDLM_ASSERT(lp->req == DLM_LOCK_NL,);
+		GDLM_ASSERT(lp->prev_req > DLM_LOCK_NL,);
+
+		lp->cur = DLM_LOCK_NL;
+		lp->req = lp->prev_req;
+		lp->prev_req = DLM_LOCK_IV;
+		lp->lkf &= ~DLM_LKF_CONVDEADLK;
+
+		set_bit(LFL_NOCACHE, &lp->flags);
+
+		if (test_bit(DFL_BLOCK_LOCKS, &ls->flags) &&
+		    !test_bit(LFL_NOBLOCK, &lp->flags))
+			gdlm_queue_delayed(lp);
+		else
+			queue_submit(lp);
+		return;
+	}
+
+	/*
+	 * A request is granted during dlm recovery.  It may be granted
+	 * because the locks of a failed node were cleared.  In that case,
+	 * there may be inconsistent data beneath this lock and we must wait
+	 * for recovery to complete to use it.  When gfs recovery is done this
+	 * granted lock will be converted to NL and then reacquired in this
+	 * granted state.
+	 */
+
+	if (test_bit(DFL_BLOCK_LOCKS, &ls->flags) &&
+	    !test_bit(LFL_NOBLOCK, &lp->flags) &&
+	    lp->req != DLM_LOCK_NL) {
+
+		lp->cur = lp->req;
+		lp->prev_req = lp->req;
+		lp->req = DLM_LOCK_NL;
+		lp->lkf |= DLM_LKF_CONVERT;
+		lp->lkf &= ~DLM_LKF_CONVDEADLK;
+
+		log_debug("rereq %x,%"PRIx64" id %x %d,%d",
+			  lp->lockname.ln_type, lp->lockname.ln_number,
+			  lp->lksb.sb_lkid, lp->cur, lp->req);
+
+		set_bit(LFL_REREQUEST, &lp->flags);
+		queue_submit(lp);
+		return;
+	}
+
+	/*
+	 * DLM demoted the lock to NL before it was granted so GFS must be
+	 * told it cannot cache data for this lock.
+	 */
+
+	if (lp->lksb.sb_flags & DLM_SBF_DEMOTED)
+		set_bit(LFL_NOCACHE, &lp->flags);
+
+ out:
+	/*
+	 * This is an internal lock_dlm lock
+	 */
+
+	if (test_bit(LFL_INLOCK, &lp->flags)) {
+		clear_bit(LFL_NOBLOCK, &lp->flags);
+		lp->cur = lp->req;
+		complete(&lp->ast_wait);
+		return;
+	}
+
+	/*
+	 * Normal completion of a lock request.  Tell GFS it now has the lock.
+	 */
+
+	clear_bit(LFL_NOBLOCK, &lp->flags);
+	lp->cur = lp->req;
+
+	acb.lc_name = lp->lockname;
+	acb.lc_ret |= gdlm_make_lmstate(lp->cur);
+
+	if (!test_and_clear_bit(LFL_NOCACHE, &lp->flags) &&
+	    (lp->cur > DLM_LOCK_NL) && (prev_mode > DLM_LOCK_NL))
+		acb.lc_ret |= LM_OUT_CACHEABLE;
+
+	ls->fscb(ls->fsdata, LM_CB_ASYNC, &acb);
+}
+
+static inline int no_work(struct gdlm_ls *ls, int blocking)
+{
+	int ret;
+
+	spin_lock(&ls->async_lock);
+	ret = list_empty(&ls->complete) && list_empty(&ls->submit);
+	if (ret && blocking)
+		ret = list_empty(&ls->blocking);
+	spin_unlock(&ls->async_lock);
+
+	return ret;
+}
+
+static inline int check_drop(struct gdlm_ls *ls)
+{
+	if (!ls->drop_locks_count)
+		return 0;
+
+	if (time_after(jiffies, ls->drop_time + ls->drop_locks_period * HZ)) {
+		ls->drop_time = jiffies;
+		if (ls->all_locks_count >= ls->drop_locks_count)
+			return 1;
+	}
+	return 0;
+}
+
+static int gdlm_thread(void *data)
+{
+	struct gdlm_ls *ls = (struct gdlm_ls *) data;
+	struct gdlm_lock *lp = NULL;
+	int blist = 0;
+	uint8_t complete, blocking, submit, drop;
+	DECLARE_WAITQUEUE(wait, current);
+
+	/* Only thread1 is allowed to do blocking callbacks since gfs
+	   may wait for a completion callback within a blocking cb. */
+
+	if (current == ls->thread1)
+		blist = 1;
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		add_wait_queue(&ls->thread_wait, &wait);
+		if (no_work(ls, blist))
+			schedule();
+		remove_wait_queue(&ls->thread_wait, &wait);
+		set_current_state(TASK_RUNNING);
+
+		complete = blocking = submit = drop = 0;
+
+		spin_lock(&ls->async_lock);
+
+		if (blist && !list_empty(&ls->blocking)) {
+			lp = list_entry(ls->blocking.next, struct gdlm_lock,
+					blist);
+			list_del_init(&lp->blist);
+			blocking = lp->bast_mode;
+			lp->bast_mode = 0;
+		} else if (!list_empty(&ls->complete)) {
+			lp = list_entry(ls->complete.next, struct gdlm_lock,
+					clist);
+			list_del_init(&lp->clist);
+			complete = 1;
+		} else if (!list_empty(&ls->submit)) {
+			lp = list_entry(ls->submit.next, struct gdlm_lock,
+					delay_list);
+			list_del_init(&lp->delay_list);
+			submit = 1;
+		}
+
+		drop = check_drop(ls);
+		spin_unlock(&ls->async_lock);
+
+		if (complete)
+			process_complete(lp);
+
+		else if (blocking)
+			process_blocking(lp, blocking);
+
+		else if (submit)
+			process_submit(lp);
+
+		if (drop)
+			ls->fscb(ls->fsdata, LM_CB_DROPLOCKS, NULL);
+
+		schedule();
+	}
+
+	return 0;
+}
+
+int gdlm_init_threads(struct gdlm_ls *ls)
+{
+	struct task_struct *p;
+	int error;
+
+	p = kthread_run(gdlm_thread, ls, "lock_dlm1");
+	error = IS_ERR(p);
+	if (error) {
+		log_error("can't start lock_dlm1 thread %d", error);
+		return error;
+	}
+	ls->thread1 = p;
+
+	p = kthread_run(gdlm_thread, ls, "lock_dlm2");
+	error = IS_ERR(p);
+	if (error) {
+		log_error("can't start lock_dlm2 thread %d", error);
+		kthread_stop(ls->thread1);
+		return error;
+	}
+	ls->thread2 = p;
+
+	return 0;
+}
+
+void gdlm_release_threads(struct gdlm_ls *ls)
+{
+	kthread_stop(ls->thread1);
+	kthread_stop(ls->thread2);
+}
+
diff -urpN a/include/linux/lock_dlm_plock.h b/include/linux/lock_dlm_plock.h
--- a/include/linux/lock_dlm_plock.h	1970-01-01 07:30:00.000000000 +0730
+++ b/include/linux/lock_dlm_plock.h	2005-09-01 17:48:48.142749200 +0800
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __LOCK_DLM_PLOCK_DOT_H__
+#define __LOCK_DLM_PLOCK_DOT_H__
+
+#define GDLM_PLOCK_MISC_NAME		"lock_dlm_plock"
+
+#define GDLM_PLOCK_VERSION_MAJOR	1
+#define GDLM_PLOCK_VERSION_MINOR	0
+#define GDLM_PLOCK_VERSION_PATCH	0
+
+enum {
+	GDLM_PLOCK_OP_LOCK = 1,
+	GDLM_PLOCK_OP_UNLOCK,
+	GDLM_PLOCK_OP_GET,
+};
+
+struct gdlm_plock_info {
+	__u32 version[3];
+	__u8 optype;
+	__u8 ex;
+	__u8 wait;
+	__u8 pad;
+	__u32 pid;
+	__s32 nodeid;
+	__s32 rv;
+	__u32 fsid;
+	__u64 number;
+	__u64 start;
+	__u64 end;
+};
+
+#endif
+
