Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWFUJAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWFUJAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWFUJAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:00:31 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:17053 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751314AbWFUJAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:00:30 -0400
Subject: [PATCH] Per-task watchers: Enable inheritance
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 01:47:15 -0700
Message-Id: <1150879635.21787.964.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows per-task watchers to implement inheritance of the same function
and/or data in response to the initialization of new tasks. A watcher might
implement inheritance using the following notifier_call snippet:

int my_notify_func(struct notifier_block *nb, unsigned long val, void *t)
{
	struct task_struct *tsk = t;
	struct notifier_block *child_nb;
	
	switch(get_watch_event(val)){
	case WATCH_TASK_INIT: /* use container_of() to associate extra data */
		child_nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
		if (!child_nb)
			return NOTIFY_DONE;
		child_nb->notifier_call = my_notify_func;
		register_per_task_watcher(tsk, child_nb);
		return NOTIFY_OK;
	case WATCH_TASK_FREE:
		unregister_per_task_watcher(tsk, nb);
		kfree(nb);
		return NOTIFY_OK;

Compile tested only. Peter, is this useful to you?

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>
---

 include/linux/notifier.h |    6 ++++--
 ipc/sem.c                |    2 +-
 kernel/sys.c             |   12 ++++++++----
 3 files changed, 13 insertions(+), 7 deletions(-)

Index: linux-2.6.17-rc6-mm2/kernel/sys.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/sys.c
+++ linux-2.6.17-rc6-mm2/kernel/sys.c
@@ -462,19 +462,23 @@ static inline int notify_per_task_watche
 		return raw_notifier_call_chain(&task->real_parent->notify,
 		   			       val, task);
 	return 0;
 }
 
-int register_per_task_watcher(struct notifier_block *nb)
+/* tsk must be current or the fork|clone-ing child of current */
+int register_per_task_watcher(struct task_struct *tsk,
+			      struct notifier_block *nb)
 {
-	return raw_notifier_chain_register(&current->notify, nb);
+	return raw_notifier_chain_register(&tsk->notify, nb);
 }
 EXPORT_SYMBOL_GPL(register_per_task_watcher);
 
-int unregister_per_task_watcher(struct notifier_block *nb)
+/* tsk must be current or the fork|clone-ing child of current */
+int unregister_per_task_watcher(struct task_struct *tsk,
+				struct notifier_block *nb)
 {
-	return raw_notifier_chain_unregister(&current->notify, nb);
+	return raw_notifier_chain_unregister(&tsk->notify, nb);
 }
 EXPORT_SYMBOL_GPL(unregister_per_task_watcher);
 
 int notify_watchers(unsigned long val, void *v)
 {
Index: linux-2.6.17-rc6-mm2/include/linux/notifier.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/notifier.h
+++ linux-2.6.17-rc6-mm2/include/linux/notifier.h
@@ -154,12 +154,14 @@ extern int raw_notifier_call_chain(struc
 #define CPU_DOWN_FAILED		0x0006 /* CPU (unsigned)v NOT going down */
 #define CPU_DEAD		0x0007 /* CPU (unsigned)v dead */
 
 extern int register_task_watcher(struct notifier_block *nb);
 extern int unregister_task_watcher(struct notifier_block *nb);
-extern int register_per_task_watcher(struct notifier_block *nb);
-extern int unregister_per_task_watcher(struct notifier_block *nb);
+extern int register_per_task_watcher(struct task_struct *tsk,
+				     struct notifier_block *nb);
+extern int unregister_per_task_watcher(struct task_struct *tsk,
+				       struct notifier_block *nb);
 #define WATCH_FLAGS_MASK		((-1) ^ 0x0FFFFUL)
 #define get_watch_event(v)		({ ((v) & ~WATCH_FLAGS_MASK); })
 #define get_watch_flags(v) 		({ ((v) & WATCH_FLAGS_MASK); })
 
 #define WATCH_TASK_INIT			0x00000001 /* initialize task_struct */
Index: linux-2.6.17-rc6-mm2/ipc/sem.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/ipc/sem.c
+++ linux-2.6.17-rc6-mm2/ipc/sem.c
@@ -1035,11 +1035,11 @@ static inline int get_undo_list(struct s
 			goto err;
 		semun_nb = kzalloc(sizeof(*semun_nb), GFP_KERNEL);
 		if (semun_nb == NULL)
 			goto err;
 		semun_nb->notifier_call = sem_undo_task_exit;
-		retval = register_per_task_watcher(semun_nb);
+		retval = register_per_task_watcher(current, semun_nb);
 		if (retval)
 			goto err;
 		memset(undo_list, 0, size);
 		spin_lock_init(&undo_list->lock);
 		atomic_set(&undo_list->refcnt, 1);


