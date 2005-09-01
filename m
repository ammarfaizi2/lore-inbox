Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbVIANuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbVIANuu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbVIANuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:50:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24773 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965120AbVIANuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:50:46 -0400
Date: Thu, 1 Sep 2005 21:56:34 +0800
From: David Teigland <teigland@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] GFS: lock_harness module
Message-ID: <20050901135634.GN25581@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lock_harness module allows a gfs file system to connect to a given
lock module.

Signed-off-by: Ken Preslan <ken@preslan.org>
Signed-off-by: David Teigland <teigland@redhat.com>

---

 fs/gfs2/locking/harness/Makefile       |    3 
 fs/gfs2/locking/harness/lm_interface.h |  286 +++++++++++++++++++++++++++++++++
 fs/gfs2/locking/harness/main.c         |  206 +++++++++++++++++++++++
 3 files changed, 495 insertions(+)

diff -urpN a/fs/gfs2/locking/harness/Makefile b/fs/gfs2/locking/harness/Makefile
--- a/fs/gfs2/locking/harness/Makefile	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/locking/harness/Makefile	2005-09-01 17:23:36.150606944 +0800
@@ -0,0 +1,3 @@
+obj-$(CONFIG_GFS2_FS) += lock_harness.o
+lock_harness-y := main.o
+
diff -urpN a/fs/gfs2/locking/harness/lm_interface.h b/fs/gfs2/locking/harness/lm_interface.h
--- a/fs/gfs2/locking/harness/lm_interface.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/locking/harness/lm_interface.h	2005-09-01 17:23:36.119611656 +0800
@@ -0,0 +1,286 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __LM_INTERFACE_DOT_H__
+#define __LM_INTERFACE_DOT_H__
+
+/*
+ * Opaque handles represent the lock module's lockspace structure, the lock
+ * module's lock structures, and GFS's file system (superblock) structure.
+ */
+
+typedef void lm_lockspace_t;
+typedef void lm_lock_t;
+typedef void lm_fsdata_t;
+
+typedef void (*lm_callback_t) (lm_fsdata_t *fsdata, unsigned int type,
+			       void *data);
+
+/*
+ * lm_mount() flags
+ *
+ * LM_MFLAG_SPECTATOR
+ * GFS is asking to join the filesystem's lockspace, but it doesn't want to
+ * modify the filesystem.  The lock module shouldn't assign a journal to the FS
+ * mount.  It shouldn't send recovery callbacks to the FS mount.  If the node
+ * dies or withdraws, all locks can be wiped immediately.
+ */
+
+#define LM_MFLAG_SPECTATOR	0x00000001
+
+/*
+ * lm_lockstruct flags
+ *
+ * LM_LSFLAG_LOCAL
+ * The lock_nolock module returns LM_LSFLAG_LOCAL to GFS, indicating that GFS
+ * can make single-node optimizations.
+ */
+
+#define LM_LSFLAG_LOCAL		0x00000001
+
+/*
+ * lm_lockname types
+ */
+
+#define LM_TYPE_RESERVED	0x00
+#define LM_TYPE_NONDISK		0x01
+#define LM_TYPE_INODE		0x02
+#define LM_TYPE_RGRP		0x03
+#define LM_TYPE_META		0x04
+#define LM_TYPE_IOPEN		0x05
+#define LM_TYPE_FLOCK		0x06
+#define LM_TYPE_PLOCK		0x07
+#define LM_TYPE_QUOTA		0x08
+#define LM_TYPE_JOURNAL		0x09
+
+/*
+ * lm_lock() states
+ *
+ * SHARED is compatible with SHARED, not with DEFERRED or EX.
+ * DEFERRED is compatible with DEFERRED, not with SHARED or EX.
+ */
+
+#define LM_ST_UNLOCKED		0
+#define LM_ST_EXCLUSIVE		1
+#define LM_ST_DEFERRED		2
+#define LM_ST_SHARED		3
+
+/*
+ * lm_lock() flags
+ *
+ * LM_FLAG_TRY
+ * Don't wait to acquire the lock if it can't be granted immediately.
+ *
+ * LM_FLAG_TRY_1CB
+ * Send one blocking callback if TRY is set and the lock is not granted.
+ *
+ * LM_FLAG_NOEXP
+ * GFS sets this flag on lock requests it makes while doing journal recovery.
+ * These special requests should not be blocked due to the recovery like
+ * ordinary locks would be.
+ *
+ * LM_FLAG_ANY
+ * A SHARED request may also be granted in DEFERRED, or a DEFERRED request may
+ * also be granted in SHARED.  The preferred state is whichever is compatible
+ * with other granted locks, or the specified state if no other locks exist.
+ *
+ * LM_FLAG_PRIORITY
+ * Override fairness considerations.  Suppose a lock is held in a shared state
+ * and there is a pending request for the deferred state.  A shared lock
+ * request with the priority flag would be allowed to bypass the deferred
+ * request and directly join the other shared lock.  A shared lock request
+ * without the priority flag might be forced to wait until the deferred
+ * requested had acquired and released the lock.
+ */
+
+#define LM_FLAG_TRY		0x00000001
+#define LM_FLAG_TRY_1CB		0x00000002
+#define LM_FLAG_NOEXP		0x00000004
+#define LM_FLAG_ANY		0x00000008
+#define LM_FLAG_PRIORITY	0x00000010
+
+/*
+ * lm_lock() and lm_async_cb return flags
+ *
+ * LM_OUT_ST_MASK
+ * Masks the lower two bits of lock state in the returned value.
+ *
+ * LM_OUT_CACHEABLE
+ * The lock hasn't been released so GFS can continue to cache data for it.
+ *
+ * LM_OUT_CANCELED
+ * The lock request was canceled.
+ *
+ * LM_OUT_ASYNC
+ * The result of the request will be returned in an LM_CB_ASYNC callback.
+ */
+
+#define LM_OUT_ST_MASK		0x00000003
+#define LM_OUT_CACHEABLE	0x00000004
+#define LM_OUT_CANCELED		0x00000008
+#define LM_OUT_ASYNC		0x00000080
+
+/*
+ * lm_callback_t types
+ *
+ * LM_CB_NEED_E LM_CB_NEED_D LM_CB_NEED_S
+ * Blocking callback, a remote node is requesting the given lock in
+ * EXCLUSIVE, DEFERRED, or SHARED.
+ *
+ * LM_CB_NEED_RECOVERY
+ * The given journal needs to be recovered.
+ *
+ * LM_CB_DROPLOCKS
+ * Reduce the number of cached locks.
+ *
+ * LM_CB_ASYNC
+ * The given lock has been granted.
+ */
+
+#define LM_CB_NEED_E		257
+#define LM_CB_NEED_D		258
+#define LM_CB_NEED_S		259
+#define LM_CB_NEED_RECOVERY	260
+#define LM_CB_DROPLOCKS		261
+#define LM_CB_ASYNC		262
+
+/*
+ * lm_recovery_done() messages
+ */
+
+#define LM_RD_GAVEUP		308
+#define LM_RD_SUCCESS		309
+
+
+struct lm_lockname {
+	uint64_t ln_number;
+	unsigned int ln_type;
+};
+
+#define lm_name_equal(name1, name2) \
+	(((name1)->ln_number == (name2)->ln_number) && \
+	 ((name1)->ln_type == (name2)->ln_type)) \
+
+struct lm_async_cb {
+	struct lm_lockname lc_name;
+	int lc_ret;
+};
+
+struct lm_lockstruct;
+
+struct lm_lockops {
+	char lm_proto_name[256];
+
+	/*
+	 * Mount/Unmount
+	 */
+
+	int (*lm_mount) (char *table_name, char *host_data,
+			 lm_callback_t cb, lm_fsdata_t *fsdata,
+			 unsigned int min_lvb_size, int flags,
+			 struct lm_lockstruct *lockstruct);
+
+	void (*lm_others_may_mount) (lm_lockspace_t *lockspace);
+
+	void (*lm_unmount) (lm_lockspace_t *lockspace);
+
+	void (*lm_withdraw) (lm_lockspace_t *lockspace);
+
+	/*
+	 * Lock oriented operations
+	 */
+
+	int (*lm_get_lock) (lm_lockspace_t *lockspace,
+			    struct lm_lockname *name, lm_lock_t **lockp);
+
+	void (*lm_put_lock) (lm_lock_t *lock);
+
+	unsigned int (*lm_lock) (lm_lock_t *lock, unsigned int cur_state,
+				 unsigned int req_state, unsigned int flags);
+
+	unsigned int (*lm_unlock) (lm_lock_t *lock, unsigned int cur_state);
+
+	void (*lm_cancel) (lm_lock_t *lock);
+
+	int (*lm_hold_lvb) (lm_lock_t *lock, char **lvbp);
+	void (*lm_unhold_lvb) (lm_lock_t *lock, char *lvb);
+	void (*lm_sync_lvb) (lm_lock_t *lock, char *lvb);
+
+	/*
+	 * Posix Lock oriented operations
+	 */
+
+	int (*lm_plock_get) (lm_lockspace_t *lockspace,
+			     struct lm_lockname *name,
+			     struct file *file, struct file_lock *fl);
+
+	int (*lm_plock) (lm_lockspace_t *lockspace,
+			 struct lm_lockname *name,
+			 struct file *file, int cmd, struct file_lock *fl);
+
+	int (*lm_punlock) (lm_lockspace_t *lockspace,
+			   struct lm_lockname *name,
+			   struct file *file, struct file_lock *fl);
+
+	/*
+	 * Client oriented operations
+	 */
+
+	void (*lm_recovery_done) (lm_lockspace_t *lockspace, unsigned int jid,
+				  unsigned int message);
+
+	struct module *lm_owner;
+};
+
+/*
+ * lm_mount() return values
+ *
+ * ls_jid - the journal ID this node should use
+ * ls_first - this node is the first to mount the file system
+ * ls_lvb_size - size in bytes of lock value blocks
+ * ls_lockspace - lock module's context for this file system
+ * ls_ops - lock module's functions
+ * ls_flags - lock module features
+ */
+
+struct lm_lockstruct {
+	unsigned int ls_jid;
+	unsigned int ls_first;
+	unsigned int ls_lvb_size;
+	lm_lockspace_t *ls_lockspace;
+	struct lm_lockops *ls_ops;
+	int ls_flags;
+};
+
+/*
+ * Lock module bottom interface.  A lock module makes itself available to GFS
+ * with these functions.
+ */
+
+int lm_register_proto(struct lm_lockops *proto);
+
+void lm_unregister_proto(struct lm_lockops *proto);
+
+/*
+ * Lock module top interface.  GFS calls these functions when mounting or
+ * unmounting a file system.
+ */
+
+int lm_mount(char *proto_name,
+	     char *table_name, char *host_data,
+	     lm_callback_t cb, lm_fsdata_t *fsdata,
+	     unsigned int min_lvb_size, int flags,
+	     struct lm_lockstruct *lockstruct);
+
+void lm_unmount(struct lm_lockstruct *lockstruct);
+
+void lm_withdraw(struct lm_lockstruct *lockstruct);
+
+#endif /* __LM_INTERFACE_DOT_H__ */
+
diff -urpN a/fs/gfs2/locking/harness/main.c b/fs/gfs2/locking/harness/main.c
--- a/fs/gfs2/locking/harness/main.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/locking/harness/main.c	2005-09-01 17:23:36.141608312 +0800
@@ -0,0 +1,206 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/kmod.h>
+#include <linux/fs.h>
+
+#include "lm_interface.h"
+
+struct lmh_wrapper {
+	struct list_head lw_list;
+	struct lm_lockops *lw_ops;
+};
+
+static struct semaphore lmh_lock;
+static struct list_head lmh_list;
+
+/**
+ * lm_register_proto - Register a low-level locking protocol
+ * @proto: the protocol definition
+ *
+ * Returns: 0 on success, -EXXX on failure
+ */
+
+int lm_register_proto(struct lm_lockops *proto)
+{
+	struct lmh_wrapper *lw;
+
+	down(&lmh_lock);
+
+	list_for_each_entry(lw, &lmh_list, lw_list) {
+		if (!strcmp(lw->lw_ops->lm_proto_name, proto->lm_proto_name)) {
+			up(&lmh_lock);
+			printk("lock_harness:  protocol %s already exists\n",
+			       proto->lm_proto_name);
+			return -EEXIST;
+		}
+	}
+
+	lw = kmalloc(sizeof(struct lmh_wrapper), GFP_KERNEL);
+	if (!lw) {
+		up(&lmh_lock);
+		return -ENOMEM;
+	}
+	memset(lw, 0, sizeof(struct lmh_wrapper));
+
+	lw->lw_ops = proto;
+	list_add(&lw->lw_list, &lmh_list);
+
+	up(&lmh_lock);
+
+	return 0;
+}
+
+/**
+ * lm_unregister_proto - Unregister a low-level locking protocol
+ * @proto: the protocol definition
+ *
+ */
+
+void lm_unregister_proto(struct lm_lockops *proto)
+{
+	struct lmh_wrapper *lw;
+
+	down(&lmh_lock);
+
+	list_for_each_entry(lw, &lmh_list, lw_list) {
+		if (!strcmp(lw->lw_ops->lm_proto_name, proto->lm_proto_name)) {
+			list_del(&lw->lw_list);
+			up(&lmh_lock);
+			kfree(lw);
+			return;
+		}
+	}
+
+	up(&lmh_lock);
+
+	printk("lock_harness:  can't unregister lock protocol %s\n",
+	       proto->lm_proto_name);
+}
+
+/**
+ * lm_mount - Mount a lock protocol
+ * @proto_name - the name of the protocol
+ * @table_name - the name of the lock space
+ * @host_data - data specific to this host
+ * @cb - the callback to the code using the lock module
+ * @fsdata - data to pass back with the callback
+ * @min_lvb_size - the mininum LVB size that the caller can deal with
+ * @flags - LM_MFLAG_*
+ * @lockstruct - a structure returned describing the mount
+ *
+ * Returns: 0 on success, -EXXX on failure
+ */
+
+int lm_mount(char *proto_name, char *table_name, char *host_data,
+	 lm_callback_t cb, lm_fsdata_t * fsdata,
+	 unsigned int min_lvb_size, int flags,
+	 struct lm_lockstruct *lockstruct)
+{
+	struct lmh_wrapper *lw = NULL;
+	int try = 0;
+	int error, found;
+
+ retry:
+	down(&lmh_lock);
+
+	found = 0;
+	list_for_each_entry(lw, &lmh_list, lw_list) {
+		if (!strcmp(lw->lw_ops->lm_proto_name, proto_name)) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found) {
+		if (!try && capable(CAP_SYS_MODULE)) {
+			try = 1;
+			up(&lmh_lock);
+			request_module(proto_name);
+			goto retry;
+		}
+		printk("lock_harness:  can't find protocol %s\n", proto_name);
+		error = -ENOENT;
+		goto out;
+	}
+
+	if (!try_module_get(lw->lw_ops->lm_owner)) {
+		try = 0;
+		up(&lmh_lock);
+		current->state = TASK_UNINTERRUPTIBLE;
+		schedule_timeout(HZ);
+		goto retry;
+	}
+
+	error = lw->lw_ops->lm_mount(table_name, host_data,
+				     cb, fsdata,
+				     min_lvb_size, flags,
+				     lockstruct);
+	if (error)
+		module_put(lw->lw_ops->lm_owner);
+ out:
+	up(&lmh_lock);
+	return error;
+}
+
+void lm_unmount(struct lm_lockstruct *lockstruct)
+{
+	down(&lmh_lock);
+	lockstruct->ls_ops->lm_unmount(lockstruct->ls_lockspace);
+	if (lockstruct->ls_ops->lm_owner)
+		module_put(lockstruct->ls_ops->lm_owner);
+	up(&lmh_lock);
+}
+
+/**
+ * lm_withdraw - abnormally unmount a lock module
+ * @lockstruct: the lockstruct passed into mount
+ *
+ */
+
+void lm_withdraw(struct lm_lockstruct *lockstruct)
+{
+	down(&lmh_lock);
+	lockstruct->ls_ops->lm_withdraw(lockstruct->ls_lockspace);
+	if (lockstruct->ls_ops->lm_owner)
+		module_put(lockstruct->ls_ops->lm_owner);
+	up(&lmh_lock);
+}
+
+int __init init_lmh(void)
+{
+	init_MUTEX(&lmh_lock);
+	INIT_LIST_HEAD(&lmh_list);
+	printk("Lock_Harness (built %s %s) installed\n", __DATE__, __TIME__);
+	return 0;
+}
+
+void __exit exit_lmh(void)
+{
+}
+
+module_init(init_lmh);
+module_exit(exit_lmh);
+
+MODULE_DESCRIPTION("GFS Lock Module Harness");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL_GPL(lm_register_proto);
+EXPORT_SYMBOL_GPL(lm_unregister_proto);
+EXPORT_SYMBOL_GPL(lm_mount);
+EXPORT_SYMBOL_GPL(lm_unmount);
+EXPORT_SYMBOL_GPL(lm_withdraw);
+
