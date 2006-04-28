Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWD1Be6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWD1Be6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWD1Be5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:34:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:28817 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030235AbWD1Bee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:34:34 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:34:32 -0700
Message-Id: <20060428013432.27212.51985.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
References: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
Subject: [PATCH 04/12] Add task logic to resource groups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04/12 - tasksupport

Adds logic to support adding/removing task to/from a resource group
Provides interface to set a task's resource group.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 include/linux/sched.h        |    4 +
 kernel/res_group/Makefile    |    2 
 kernel/res_group/local.h     |    1 
 kernel/res_group/res_group.c |   25 +++++++
 kernel/res_group/task.c      |  145 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 176 insertions(+), 1 deletion(-)

Index: linux-2617-rc3/include/linux/sched.h
===================================================================
--- linux-2617-rc3.orig/include/linux/sched.h	2006-04-27 09:22:14.000000000 -0700
+++ linux-2617-rc3/include/linux/sched.h	2006-04-27 09:22:16.000000000 -0700
@@ -888,6 +888,10 @@ struct task_struct {
 	 * cache last used pipe for splice
 	 */
 	struct pipe_inode_info *splice_pipe;
+#ifdef CONFIG_RES_GROUPS
+	struct resource_group *res_group;
+	struct list_head member_list; /* list of tasks in the resource group */
+#endif /* CONFIG_RES_GROUPS */
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: linux-2617-rc3/kernel/res_group/task.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/kernel/res_group/task.c	2006-04-27 09:22:16.000000000 -0700
@@ -0,0 +1,145 @@
+/* task.c - Resource Groups
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
+#include "local.h"
+
+static inline struct resource_group
+			*remove_from_old_rgroup(struct task_struct *tsk)
+{
+	struct resource_group *rgroup;
+
+retry:
+	rgroup = tsk->res_group;
+	if (rgroup == NO_RES_GROUP)
+		goto done;
+
+	spin_lock(&rgroup->group_lock);
+	if (rgroup != tsk->res_group) { /* lost the race, retry */
+		spin_unlock(&rgroup->group_lock);
+		goto retry;
+	}
+	/* take out of old resource group */
+	list_del_init(&tsk->member_list);
+	tsk->res_group = NO_RES_GROUP;
+	spin_unlock(&rgroup->group_lock);
+done:
+	return rgroup;
+}
+
+static void move_to_new_rgroup(struct task_struct *tsk,
+				struct resource_group *new_rgroup)
+{
+	BUG_ON(!list_empty(&tsk->member_list));
+	BUG_ON(tsk->res_group != NO_RES_GROUP);
+
+	spin_lock(&new_rgroup->group_lock);
+	tsk->res_group = new_rgroup;
+	list_add(&tsk->member_list, &new_rgroup->task_list);
+	spin_unlock(&new_rgroup->group_lock);
+}
+
+static void notify_res_ctlrs(struct task_struct *tsk,
+	struct resource_group *old_rgroup, struct resource_group *new_rgroup)
+{
+	int i;
+	struct res_controller *ctlr;
+	struct res_shares *old_shares, *new_shares;
+
+	for (i = 0; i < MAX_RES_CTLRS; i++) {
+		ctlr = get_controller_by_id(i);
+		if (ctlr == NULL)
+			continue;
+		if (ctlr->move_task) {
+			old_shares = get_controller_shares(old_rgroup, ctlr);
+			new_shares = get_controller_shares(new_rgroup, ctlr);
+			ctlr->move_task(tsk, old_shares, new_shares);
+		}
+		put_controller(ctlr);
+	}
+}
+
+/*
+ * Change the resource group of the given task to "new_rgroup"
+ *
+ * Caller is responsible to make sure the task structure stays put
+ * through this function.
+ *
+ * This function should be called without holding group_lock of
+ * new_rgroup and tsk->res_group.
+ *
+ * Called with a reference to the new resource group held. The reference is
+ * dropped only when the task is assigned to a different resource group
+ * or when the task exits.
+ */
+static void __set_res_group(struct task_struct *tsk,
+				struct resource_group *new_rgroup)
+{
+	struct resource_group *old_rgroup;
+
+retry:
+	old_rgroup = remove_from_old_rgroup(tsk);
+
+	/* task is exiting or is moving to a different resource group. */
+	if (old_rgroup == NO_RES_GROUP) {
+		/* In the exit path, must succeed */
+		if (new_rgroup == NO_RES_GROUP)
+			goto retry;
+		kref_put(&new_rgroup->ref, release_res_group);
+		return;
+	}
+
+	/*
+	 * notify resource controllers before we actually set the resource
+	 * group in the task to avoid a race with notify_res_ctlrs being
+	 * called from another __set_res_group.
+	 */
+	notify_res_ctlrs(tsk, old_rgroup, new_rgroup);
+	if (new_rgroup != NO_RES_GROUP)
+		move_to_new_rgroup(tsk, new_rgroup);
+	kref_put(&old_rgroup->ref, release_res_group);
+}
+
+/*
+ * Set resource group of the task associated with pid to rgroup.
+ * returns 0 on success, -errno on error.
+ */
+int set_res_group(pid_t pid, struct resource_group *rgroup)
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
+		kref_get(&rgroup->ref);
+		__set_res_group(tsk, rgroup);
+	}
+	put_task_struct(tsk);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(set_res_group);
Index: linux-2617-rc3/kernel/res_group/Makefile
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/Makefile	2006-04-27 09:22:14.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/Makefile	2006-04-27 09:22:16.000000000 -0700
@@ -1 +1 @@
-obj-y = res_group.o shares.o
+obj-y = res_group.o shares.o task.o
Index: linux-2617-rc3/kernel/res_group/res_group.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/res_group.c	2006-04-27 09:22:14.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/res_group.c	2006-04-27 09:22:16.000000000 -0700
@@ -251,6 +251,27 @@ static int add_controller(struct res_con
 	return ret;
 }
 /*
+ * Helper function to move all tasks in a resource group to/from the
+ * registering/unregistering resource controller.
+ *
+ * Assumes ctlr is valid and rgroup is initialized with resource
+ * controller's shares.
+ */
+static void move_tasks(struct resource_group *rgroup,
+		struct res_controller *ctlr,
+		struct res_shares *from, struct res_shares *to)
+{
+	struct task_struct *tsk;
+
+	if (!ctlr->move_task)
+		return;
+	spin_lock(&rgroup->group_lock);
+	list_for_each_entry(tsk, &rgroup->task_list, member_list)
+		ctlr->move_task(tsk, from, to);
+	spin_unlock(&rgroup->group_lock);
+}
+
+/*
  * Interface for registering a resource controller.
  *
  * Returns the 0 on success, -errno for failure.
@@ -287,6 +308,8 @@ int register_controller(struct res_contr
 		kref_get(&rgroup->ref);
 		read_unlock(&res_group_lock);
   		do_alloc_shares_struct(rgroup, ctlr);
+		move_tasks(rgroup, ctlr, NO_SHARE,
+					rgroup->shares[ctlr->ctlr_id]);
 		if (prev_rgroup)
 			kref_put(&prev_rgroup->ref, release_res_group);
 		prev_rgroup = rgroup;
@@ -333,6 +356,8 @@ int unregister_controller(struct res_con
 	list_for_each_entry_reverse(rgroup, &res_groups, group_list) {
 		kref_get(&rgroup->ref);
 		read_unlock(&res_group_lock);
+		move_tasks(rgroup, ctlr, rgroup->shares[ctlr->ctlr_id],
+								NO_SHARE);
   		do_free_shares_struct(rgroup, ctlr);
 		if (prev_rgroup)
 			kref_put(&prev_rgroup->ref, release_res_group);
Index: linux-2617-rc3/kernel/res_group/local.h
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/local.h	2006-04-27 09:22:14.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/local.h	2006-04-27 09:22:16.000000000 -0700
@@ -18,3 +18,4 @@ extern int set_controller_shares(struct 
 extern void set_shares_to_default(struct resource_group *,
 						struct res_controller *);
 extern void res_group_teardown(void);
+extern int set_res_group(pid_t, struct resource_group *);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
