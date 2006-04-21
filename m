Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWDUQPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWDUQPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWDUQPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:15:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42667 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932405AbWDUQPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:15:49 -0400
Subject: [PATCH 15/16] GFS2: The "nolock" module
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 21 Apr 2006 17:24:21 +0100
Message-Id: <1145636661.3856.122.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 15/16] GFS2: The "nolock" module

The "nolock" locking module provides locking services for single node
GFS2 set ups and is also useful for testing.



Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>


 fs/gfs2/locking/nolock/Makefile |    3 
 fs/gfs2/locking/nolock/main.c   |  259 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 262 insertions(+)

--- /dev/null
+++ b/fs/gfs2/locking/nolock/main.c
@@ -0,0 +1,259 @@
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
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/smp_lock.h>
+
+#include "../../lm_interface.h"
+
+struct nolock_lockspace {
+	unsigned int nl_lvb_size;
+};
+
+struct lm_lockops nolock_ops;
+
+static int nolock_mount(char *table_name, char *host_data,
+			lm_callback_t cb, lm_fsdata_t *fsdata,
+			unsigned int min_lvb_size, int flags,
+			struct lm_lockstruct *lockstruct,
+			struct kobject *fskobj)
+{
+	char *c;
+	unsigned int jid;
+	struct nolock_lockspace *nl;
+
+	c = strstr(host_data, "jid=");
+	if (!c)
+		jid = 0;
+	else {
+		c += 4;
+		sscanf(c, "%u", &jid);
+	}
+
+	nl = kzalloc(sizeof(struct nolock_lockspace), GFP_KERNEL);
+	if (!nl)
+		return -ENOMEM;
+
+	nl->nl_lvb_size = min_lvb_size;
+
+	lockstruct->ls_jid = jid;
+	lockstruct->ls_first = 1;
+	lockstruct->ls_lvb_size = min_lvb_size;
+	lockstruct->ls_lockspace = (lm_lockspace_t *)nl;
+	lockstruct->ls_ops = &nolock_ops;
+	lockstruct->ls_flags = LM_LSFLAG_LOCAL;
+
+	return 0;
+}
+
+static void nolock_others_may_mount(lm_lockspace_t *lockspace)
+{
+}
+
+static void nolock_unmount(lm_lockspace_t *lockspace)
+{
+	struct nolock_lockspace *nl = (struct nolock_lockspace *)lockspace;
+	kfree(nl);
+}
+
+static void nolock_withdraw(lm_lockspace_t *lockspace)
+{
+}
+
+/**
+ * nolock_get_lock - get a lm_lock_t given a descripton of the lock
+ * @lockspace: the lockspace the lock lives in
+ * @name: the name of the lock
+ * @lockp: return the lm_lock_t here
+ *
+ * Returns: 0 on success, -EXXX on failure
+ */
+
+static int nolock_get_lock(lm_lockspace_t *lockspace, struct lm_lockname *name,
+			   lm_lock_t **lockp)
+{
+	*lockp = (lm_lock_t *)lockspace;
+	return 0;
+}
+
+/**
+ * nolock_put_lock - get rid of a lock structure
+ * @lock: the lock to throw away
+ *
+ */
+
+static void nolock_put_lock(lm_lock_t *lock)
+{
+}
+
+/**
+ * nolock_lock - acquire a lock
+ * @lock: the lock to manipulate
+ * @cur_state: the current state
+ * @req_state: the requested state
+ * @flags: modifier flags
+ *
+ * Returns: A bitmap of LM_OUT_*
+ */
+
+static unsigned int nolock_lock(lm_lock_t *lock, unsigned int cur_state,
+				unsigned int req_state, unsigned int flags)
+{
+	return req_state | LM_OUT_CACHEABLE;
+}
+
+/**
+ * nolock_unlock - unlock a lock
+ * @lock: the lock to manipulate
+ * @cur_state: the current state
+ *
+ * Returns: 0
+ */
+
+static unsigned int nolock_unlock(lm_lock_t *lock, unsigned int cur_state)
+{
+	return 0;
+}
+
+static void nolock_cancel(lm_lock_t *lock)
+{
+}
+
+/**
+ * nolock_hold_lvb - hold on to a lock value block
+ * @lock: the lock the LVB is associated with
+ * @lvbp: return the lm_lvb_t here
+ *
+ * Returns: 0 on success, -EXXX on failure
+ */
+
+static int nolock_hold_lvb(lm_lock_t *lock, char **lvbp)
+{
+	struct nolock_lockspace *nl = (struct nolock_lockspace *)lock;
+	int error = 0;
+
+	*lvbp = kzalloc(nl->nl_lvb_size, GFP_KERNEL);
+	if (!*lvbp)
+		error = -ENOMEM;
+
+	return error;
+}
+
+/**
+ * nolock_unhold_lvb - release a LVB
+ * @lock: the lock the LVB is associated with
+ * @lvb: the lock value block
+ *
+ */
+
+static void nolock_unhold_lvb(lm_lock_t *lock, char *lvb)
+{
+	kfree(lvb);
+}
+
+/**
+ * nolock_sync_lvb - sync out the value of a lvb
+ * @lock: the lock the LVB is associated with
+ * @lvb: the lock value block
+ *
+ */
+
+static void nolock_sync_lvb(lm_lock_t *lock, char *lvb)
+{
+}
+
+static int nolock_plock_get(lm_lockspace_t *lockspace, struct lm_lockname *name,
+			    struct file *file, struct file_lock *fl)
+{
+	struct file_lock tmp;
+	int ret;
+
+	ret = posix_test_lock(file, fl, &tmp);
+	fl->fl_type = F_UNLCK;
+	if (ret)
+		memcpy(fl, &tmp, sizeof(struct file_lock));
+
+	return 0;
+}
+
+static int nolock_plock(lm_lockspace_t *lockspace, struct lm_lockname *name,
+			struct file *file, int cmd, struct file_lock *fl)
+{
+	int error;
+	error = posix_lock_file_wait(file, fl);
+	return error;
+}
+
+static int nolock_punlock(lm_lockspace_t *lockspace, struct lm_lockname *name,
+			  struct file *file, struct file_lock *fl)
+{
+	int error;
+	error = posix_lock_file_wait(file, fl);
+	return error;
+}
+
+static void nolock_recovery_done(lm_lockspace_t *lockspace, unsigned int jid,
+				 unsigned int message)
+{
+}
+
+struct lm_lockops nolock_ops = {
+	.lm_proto_name = "lock_nolock",
+	.lm_mount = nolock_mount,
+	.lm_others_may_mount = nolock_others_may_mount,
+	.lm_unmount = nolock_unmount,
+	.lm_withdraw = nolock_withdraw,
+	.lm_get_lock = nolock_get_lock,
+	.lm_put_lock = nolock_put_lock,
+	.lm_lock = nolock_lock,
+	.lm_unlock = nolock_unlock,
+	.lm_cancel = nolock_cancel,
+	.lm_hold_lvb = nolock_hold_lvb,
+	.lm_unhold_lvb = nolock_unhold_lvb,
+	.lm_sync_lvb = nolock_sync_lvb,
+	.lm_plock_get = nolock_plock_get,
+	.lm_plock = nolock_plock,
+	.lm_punlock = nolock_punlock,
+	.lm_recovery_done = nolock_recovery_done,
+	.lm_owner = THIS_MODULE,
+};
+
+int __init init_nolock(void)
+{
+	int error;
+
+	error = gfs_register_lockproto(&nolock_ops);
+	if (error) {
+		printk(KERN_WARNING
+		       "lock_nolock: can't register protocol: %d\n", error);
+		return error;
+	}
+
+	printk(KERN_INFO
+	       "Lock_Nolock (built %s %s) installed\n", __DATE__, __TIME__);
+	return 0;
+}
+
+void __exit exit_nolock(void)
+{
+	gfs_unregister_lockproto(&nolock_ops);
+}
+
+module_init(init_nolock);
+module_exit(exit_nolock);
+
+MODULE_DESCRIPTION("GFS Nolock Locking Module");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
--- /dev/null
+++ b/fs/gfs2/locking/nolock/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_GFS2_FS) += lock_nolock.o
+lock_nolock-y := main.o
+


