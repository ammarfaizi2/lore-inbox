Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVC3Vy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVC3Vy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVC3Vyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:54:31 -0500
Received: from pat.uio.no ([129.240.130.16]:47536 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262326AbVC3Vvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:51:38 -0500
Subject: [RFC] Add support for semaphore-like structure with support for
	asynchronous I/O
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: linux-kernel@vger.kernel.org
Cc: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 16:51:30 -0500
Message-Id: <1112219491.10771.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.779, required 12,
	autolearn=disabled, AWL 1.22, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In NFSv4 we often want to serialize asynchronous RPC calls with ordinary
RPC calls (OPEN and CLOSE for instance). On paper, semaphores would
appear to fit the bill, however there is no support for asynchronous I/O
with semaphores.
<rant>What's more, trying to add that type of support is an exercise in
futility: there are currently 23 slightly different arch-dependent and
over-optimized versions of semaphores (not counting the different
versions of read/write semaphores).</rant>

Anyhow, the following is a simple implementation of semaphores designed
to satisfy the needs of those I/O subsystems that want to support
asynchronous behaviour too. Please comment.

Cheers,
  Trond

--------------------------------------
NFS: Add support for iosems.

 These act rather like semaphores, but also have support for asynchronous
 I/O, using the wait_queue_t callback features.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---
 include/linux/iosem.h |   63 ++++++++++++++++++++++++++++++
 lib/Makefile          |    2 
 lib/iosem.c           |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc1/include/linux/iosem.h
===================================================================
--- /dev/null
+++ linux-2.6.12-rc1/include/linux/iosem.h
@@ -0,0 +1,63 @@
+/*
+ * include/linux/iosem.h
+ *
+ * Copyright (C) 2005 Trond Myklebust <Trond.Myklebust@netapp.com>
+ *
+ * Definitions for iosems. These can act as mutexes, but unlike
+ * semaphores, their code is 100% arch-independent, and can therefore
+ * easily be expanded in order to provide for things like
+ * asynchronous I/O.
+ */
+
+#ifndef __LINUX_SEM_LOCK_H
+#define __LINUX_SEM_LOCK_H
+
+#ifdef __KERNEL__
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+struct iosem {
+	unsigned long state;
+	wait_queue_head_t wait;
+};
+
+#define IOSEM_LOCK_EXCLUSIVE (24)
+/* #define IOSEM_LOCK_SHARED (25) */
+
+struct iosem_wait {
+	struct iosem *lock;
+	wait_queue_t wait;
+};
+
+struct iosem_work {
+	struct work_struct work;
+	struct iosem_wait waiter;
+};
+
+extern void FASTCALL(iosem_lock(struct iosem *lk));
+extern void FASTCALL(iosem_unlock(struct iosem *lk));
+extern int iosem_lock_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
+
+static inline void init_iosem(struct iosem *lk)
+{
+	lk->state = 0;
+	init_waitqueue_head(&lk->wait);
+}
+
+static inline void init_iosem_waiter(struct iosem_wait *waiter)
+{
+	waiter->lock = NULL;
+	init_waitqueue_entry(&waiter->wait, current);
+	INIT_LIST_HEAD(&waiter->wait.task_list);
+}
+
+static inline void init_iosem_work(struct iosem_work *wk, void (*func)(void *), void *data)
+{
+	INIT_WORK(&wk->work, func, data);
+}
+
+extern int FASTCALL(iosem_lock_and_schedule_work(struct iosem *lk, struct iosem_work *wk));
+extern int iosem_lock_and_schedule_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_SEM_LOCK_H */
Index: linux-2.6.12-rc1/lib/iosem.c
===================================================================
--- /dev/null
+++ linux-2.6.12-rc1/lib/iosem.c
@@ -0,0 +1,103 @@
+/*
+ * linux/fs/nfs/iosem.c
+ *
+ * Copyright (C) 2005 Trond Myklebust <Trond.Myklebust@netapp.com>
+ *
+ * A set of primitives for semaphore-like locks that also support notification
+ * callbacks for waiters.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/iosem.h>
+
+static int fastcall __iosem_lock(struct iosem *lk, struct iosem_wait *waiter)
+{
+	int ret;
+
+	spin_lock(&lk->wait.lock);
+	if (lk->state != 0) {
+		waiter->lock = lk;
+		add_wait_queue_exclusive_locked(&lk->wait, &waiter->wait);
+		ret = -EINPROGRESS;
+	} else {
+		lk->state |= 1 << IOSEM_LOCK_EXCLUSIVE;
+		ret = 0;
+	}
+	spin_unlock(&lk->wait.lock);
+	return ret;
+}
+
+void fastcall iosem_unlock(struct iosem *lk)
+{
+	spin_lock(&lk->wait.lock);
+	lk->state &= ~(1 << IOSEM_LOCK_EXCLUSIVE);
+	wake_up_locked(&lk->wait);
+	spin_unlock(&lk->wait.lock);
+}
+EXPORT_SYMBOL(iosem_unlock);
+
+int iosem_lock_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
+{
+	struct iosem_wait *waiter = container_of(wait, struct iosem_wait, wait);
+	unsigned long *lk_state = &waiter->lock->state;
+	int ret = 0;
+
+	if (*lk_state == 0) {
+		ret = default_wake_function(wait, mode, sync, key);
+		if (ret) {
+			*lk_state |= 1 << IOSEM_LOCK_EXCLUSIVE;
+			list_del_init(&wait->task_list);
+		}
+	}
+	return ret;
+}
+
+void fastcall iosem_lock(struct iosem *lk)
+{
+	struct iosem_wait waiter;
+
+	might_sleep();
+
+	init_iosem_waiter(&waiter);
+	waiter.wait.func = iosem_lock_wake_function;
+
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	if (__iosem_lock(lk, &waiter))
+		schedule();
+	__set_current_state(TASK_RUNNING);
+
+	BUG_ON(!list_empty(&waiter.wait.task_list));
+}
+EXPORT_SYMBOL(iosem_lock);
+
+int iosem_lock_and_schedule_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
+{
+	struct iosem_wait *waiter = container_of(wait, struct iosem_wait, wait);
+	struct iosem_work *wk = container_of(waiter, struct iosem_work, waiter);
+	unsigned long *lk_state = &waiter->lock->state;
+	int ret = 0;
+
+	if (*lk_state == 0) {
+		ret = schedule_work(&wk->work);
+		if (ret) {
+			*lk_state |= 1 << IOSEM_LOCK_EXCLUSIVE;
+			list_del_init(&wait->task_list);
+		}
+	}
+	return ret;
+}
+
+int fastcall iosem_lock_and_schedule_work(struct iosem *lk, struct iosem_work *wk)
+{
+	int ret;
+
+	init_iosem_waiter(&wk->waiter);
+	wk->waiter.wait.func = iosem_lock_and_schedule_function;
+	ret = __iosem_lock(lk, &wk->waiter);
+	if (ret == 0)
+		ret = schedule_work(&wk->work);
+	return ret;
+}
+EXPORT_SYMBOL(iosem_lock_and_schedule_work);
Index: linux-2.6.12-rc1/lib/Makefile
===================================================================
--- linux-2.6.12-rc1.orig/lib/Makefile
+++ linux-2.6.12-rc1/lib/Makefile
@@ -8,7 +8,7 @@ lib-y := errno.o ctype.o string.o vsprin
 	 bitmap.o extable.o kobject_uevent.o prio_tree.o sha1.o \
 	 halfmd4.o
 
-obj-y += sort.o parser.o
+obj-y += sort.o parser.o iosem.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

