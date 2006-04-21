Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWDUCYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWDUCYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWDUCYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:24:40 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:49358 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750876AbWDUCYf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:24:35 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:24:34 -0700
Message-Id: <20060421022434.6145.44399.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 04/12] Add task logic to class
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04/12 - ckrm_tasksupport

Adds logic to support adding/removing task to/from a class
Provides interface to set a task's class
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 include/linux/sched.h    |    4 +
 kernel/ckrm/Makefile     |    2 
 kernel/ckrm/ckrm.c       |   24 +++++++
 kernel/ckrm/ckrm_local.h |    1 
 kernel/ckrm/ckrm_task.c  |  144 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 174 insertions(+), 1 deletion(-)

Index: linux2617-rc2/include/linux/sched.h
===================================================================
--- linux2617-rc2.orig/include/linux/sched.h
+++ linux2617-rc2/include/linux/sched.h
@@ -888,6 +888,10 @@ struct task_struct {
 	 * cache last used pipe for splice
 	 */
 	struct pipe_inode_info *splice_pipe;
+#ifdef CONFIG_CKRM
+	struct ckrm_class *class;
+	struct list_head member_list; /* list of tasks in class */
+#endif /* CONFIG_CKRM */
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: linux2617-rc2/kernel/ckrm/ckrm_task.c
===================================================================
--- /dev/null
+++ linux2617-rc2/kernel/ckrm/ckrm_task.c
@@ -0,0 +1,144 @@
+/* ckrm_task.c - Class-based Kernel Resource Management (CKRM)
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003,2004
+ *		(C) Shailabh Nagar,  IBM Corp. 2003
+ *		(C) Chandra Seetharaman,  IBM Corp. 2003, 2004, 2005
+ *		(C) Vivek Kashyap,	IBM Corp. 2004
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#include <linux/sched.h>
+#include <linux/module.h>
+#include "ckrm_local.h"
+
+static inline struct ckrm_class *remove_from_old_class(struct task_struct *tsk)
+{
+	struct ckrm_class *class;
+
+retry:
+	class = tsk->class;
+	if (class == CKRM_NO_CLASS)
+		goto done;
+
+	spin_lock(&class->class_lock);
+	if (class != tsk->class) { /* lost the race, retry */
+		spin_unlock(&class->class_lock);
+		goto retry;
+	}
+	/* take out of old class */
+	list_del_init(&tsk->member_list);
+	tsk->class = CKRM_NO_CLASS;
+	spin_unlock(&class->class_lock);
+done:
+	return class;
+}
+
+static void move_to_new_class(struct task_struct *tsk,
+				struct ckrm_class *newclass)
+{
+	BUG_ON(!list_empty(&tsk->member_list));
+	BUG_ON(tsk->class != CKRM_NO_CLASS);
+
+	spin_lock(&newclass->class_lock);
+	tsk->class = newclass;
+	list_add(&tsk->member_list, &newclass->task_list);
+	spin_unlock(&newclass->class_lock);
+}
+
+static void notify_res_ctlrs(struct task_struct *tsk,
+		struct ckrm_class *oldclass, struct ckrm_class *newclass)
+{
+	int i;
+	struct ckrm_controller *ctlr;
+	struct ckrm_shares *old_shares, *new_shares;
+
+	for (i = 0; i < CKRM_MAX_RES_CTLRS; i++) {
+		ctlr = ckrm_get_controller_by_id(i);
+		if (ctlr == NULL)
+			continue;
+		if (ctlr->move_task) {
+			old_shares = ckrm_get_controller_shares(oldclass, ctlr);
+			new_shares = ckrm_get_controller_shares(newclass, ctlr);
+			ctlr->move_task(tsk, old_shares, new_shares);
+		}
+		ckrm_put_controller(ctlr);
+	}
+}
+
+/*
+ * Change the class of the given task to "newclass"
+ *
+ * Caller is responsible to make sure the task structure stays put
+ * through this function.
+ *
+ * This function should be called without holding class_lock of
+ * newclass and tsk->class.
+ *
+ * Called with a reference to the new class held. The reference is
+ * dropped only when the task is assigned to a different class
+ * or when the task exits.
+ */
+static void ckrm_setclass_internal(struct task_struct *tsk,
+				struct ckrm_class *newclass)
+{
+	struct ckrm_class *oldclass;
+
+retry:
+	oldclass = remove_from_old_class(tsk);
+
+	/* The task is either exiting or is moving to a different class. */
+	if (oldclass == CKRM_NO_CLASS) {
+		/* In the exit path, must succeed */
+		if (newclass == CKRM_NO_CLASS)
+			goto retry;
+		kref_put(&newclass->ref, ckrm_release_class);
+		return;
+	}
+
+	/*
+	 * notify resource controllers before we actually set the class
+	 * in the task to avoid a race with notify_res_ctlrs being called
+	 * from another ckrm_setclass_internal.
+	 */
+	notify_res_ctlrs(tsk, oldclass, newclass);
+	if (newclass != CKRM_NO_CLASS)
+		move_to_new_class(tsk, newclass);
+	kref_put(&oldclass->ref, ckrm_release_class);
+}
+
+/*
+ * Set class of the task associated with pid to class.
+ * returns 0 on success, -errno on error.
+ */
+int ckrm_setclass(pid_t pid, struct ckrm_class *class)
+{
+	int rc = 0;
+	struct task_struct *tsk;
+
+	read_lock(&tasklist_lock);
+	tsk = find_task_by_pid(pid);
+	if (tsk == NULL) {
+		read_unlock(&tasklist_lock);
+		return -ESRCH; /* pid not found */
+	}
+	get_task_struct(tsk);
+	read_unlock(&tasklist_lock);
+
+	/* Check permissions */
+	if ((!capable(CAP_SYS_NICE)) &&
+		(!capable(CAP_SYS_RESOURCE)) && (current->user != tsk->user))
+		rc = -EPERM;
+	else {
+		kref_get(&class->ref);
+		ckrm_setclass_internal(tsk, class);
+	}
+	put_task_struct(tsk);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ckrm_setclass);
Index: linux2617-rc2/kernel/ckrm/Makefile
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/Makefile
+++ linux2617-rc2/kernel/ckrm/Makefile
@@ -1 +1 @@
-obj-y = ckrm.o ckrm_shares.o
+obj-y = ckrm.o ckrm_shares.o ckrm_task.o
Index: linux2617-rc2/kernel/ckrm/ckrm.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm.c
+++ linux2617-rc2/kernel/ckrm/ckrm.c
@@ -251,6 +251,26 @@ static int add_controller(struct ckrm_co
 	return ret;
 }
 /*
+ * Helper function to move all tasks in a class to/from the registering
+ * /unregistering resource controller.
+ *
+ * Assumes ctlr is valid and class is initialized with resource
+ * controller's shares.
+ */
+static void move_tasks(struct ckrm_class *class, struct ckrm_controller *ctlr,
+		struct ckrm_shares *from, struct ckrm_shares *to)
+{
+	struct task_struct *tsk;
+
+	if (!ctlr->move_task)
+		return;
+	spin_lock(&class->class_lock);
+	list_for_each_entry(tsk, &class->task_list, member_list)
+		ctlr->move_task(tsk, from, to);
+	spin_unlock(&class->class_lock);
+}
+
+/*
  * Interface for registering a resource controller.
  *
  * Returns the 0 on success, -errno for failure.
@@ -287,6 +307,8 @@ int ckrm_register_controller(struct ckrm
 		kref_get(&class->ref);
 		read_unlock(&ckrm_class_lock);
   		do_alloc_shares_struct(class, ctlr);
+		move_tasks(class, ctlr, CKRM_NO_SHARE,
+					class->shares[ctlr->ctlr_id]);
 		if (prev_class)
 			kref_put(&prev_class->ref, ckrm_release_class);
 		prev_class = class;
@@ -333,6 +355,8 @@ int ckrm_unregister_controller(struct ck
 	list_for_each_entry_reverse(class, &ckrm_classes, class_list) {
 		kref_get(&class->ref);
 		read_unlock(&ckrm_class_lock);
+		move_tasks(class, ctlr, class->shares[ctlr->ctlr_id],
+							CKRM_NO_SHARE);
   		do_free_shares_struct(class, ctlr);
 		if (prev_class)
 			kref_put(&prev_class->ref, ckrm_release_class);
Index: linux2617-rc2/kernel/ckrm/ckrm_local.h
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm_local.h
+++ linux2617-rc2/kernel/ckrm/ckrm_local.h
@@ -17,3 +17,4 @@ extern int ckrm_set_controller_shares(st
 extern void ckrm_set_shares_to_default(struct ckrm_class *,
 						struct ckrm_controller *);
 extern void ckrm_teardown(void);
+extern int ckrm_setclass(pid_t, struct ckrm_class *);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
