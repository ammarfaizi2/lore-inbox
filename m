Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbWD1BeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbWD1BeS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbWD1BeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:34:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:39637 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965187AbWD1BeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:34:17 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:34:15 -0700
Message-Id: <20060428013415.27212.36269.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
References: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
Subject: [PATCH 01/12] Register/Unregister interface for Controllers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01/12 - controller_support

This patch defines data structures for defining a resource group and
resource controller.
Provides register/unregister functions for a controller.
Provides utility functions to get a controller's data structure.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 include/linux/res_group.h    |   75 +++++++++++++++
 include/linux/res_group_rc.h |   68 +++++++++++++
 init/Kconfig                 |   14 ++
 kernel/Makefile              |    1 
 kernel/res_group/Makefile    |    1 
 kernel/res_group/local.h     |   10 ++
 kernel/res_group/res_group.c |  214 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 383 insertions(+)

Index: linux-2617-rc3/include/linux/res_group.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/include/linux/res_group.h	2006-04-27 09:21:46.000000000 -0700
@@ -0,0 +1,75 @@
+/*
+ *  res_group.h - Header file to be used by Resource Groups
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003, 2004
+ *		(C) Shailabh Nagar,  IBM Corp. 2003, 2004
+ *		(C) Chandra Seetharaman, IBM Corp. 2003, 2004, 2005
+ *
+ * Provides data structures, macros and kernel APIs
+ *
+ * More details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef _LINUX_RES_GROUP_H
+#define _LINUX_RES_GROUP_H
+
+#ifdef CONFIG_RES_GROUPS
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/kref.h>
+
+#define SHARE_UNCHANGED	(-1)	/* implicitly specified by userspace,
+					 * never stored in a resource group'
+					 * shares struct; never displayed */
+#define SHARE_UNSUPPORTED	(-2)	/* If the resource controller doesn't
+					 * support user changing a shares value
+					 * it sets the corresponding share
+					 * value to UNSUPPORTED when it returns
+					 * the newly allocated shares data
+					 * structure */
+#define SHARE_DONT_CARE	(-3)
+
+#define SHARE_DEFAULT_DIVISOR 	(100)
+
+#define MAX_RES_CTLRS	8	/* max # of resource controllers */
+
+#define NO_RES_GROUP		NULL
+#define NO_SHARE		NULL
+#define NO_RES_ID		MAX_RES_CTLRS /* Invalid ID */
+
+/*
+ * Share quantities are a child's fraction of the parent's resource
+ * specified by a divisor in the parent and a dividend in the child.
+ *
+ * Shares are represented as a relative quantity between parent and child
+ * to simplify locking when propagating modifications to the shares of a
+ * resource group. Only the parent and the children of the modified
+ * resource group need to be locked.
+*/
+struct res_shares {
+};
+
+/*
+ * Class is the grouping of tasks with shares of each resource that has
+ * registered a resource controller (see include/linux/res_group_rc.h).
+ */
+struct resource_group {
+	int depth;		/* depth of this resource group. root == 0 */
+	spinlock_t group_lock;	/* protects task_list, shares and children
+				 * When grabbing group_lock in a hierarchy,
+				 * grab parent's group_lock first.
+				 * If resource controller uses a resource_group
+				 * specific lock, grab group_lock before
+				 * grabbing resource specific lock */
+	struct res_shares *shares[MAX_RES_CTLRS];/* resource shares */
+	struct list_head group_list;	/* entry in system-wide list */
+};
+
+#endif /* CONFIG_RES_GROUPS */
+#endif /* _LINUX_RES_GROUP_H */
Index: linux-2617-rc3/include/linux/res_group_rc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/include/linux/res_group_rc.h	2006-04-27 09:21:46.000000000 -0700
@@ -0,0 +1,68 @@
+/*
+ *  res_group_rc.h - Header file to be used by Resource controllers of
+ *		      Resource Groups
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *		(C) Shailabh Nagar,  IBM Corp. 2003
+ *		(C) Chandra Seetharaman, IBM Corp. 2003, 2004, 2005
+ *		(C) Vivek Kashyap , IBM Corp. 2004
+ *
+ * Provides data structures, macros and kernel API of Resource Groups for
+ * resource controllers.
+ *
+ * More details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef _LINUX_RES_GROUP_RC_H
+#define _LINUX_RES_GROUP_RC_H
+
+#include <linux/res_group.h>
+
+struct res_controller {
+	const char *name;
+	int depth_supported;/* maximum hierarchy supported by controller */
+	unsigned int ctlr_id;
+
+	/*
+	 * Keeps number of references to this controller structure. kref
+	 * does not work as we want to be able to allow removal of a
+	 * controller even when some resource group are still defined.
+	 */
+	atomic_t count;
+
+	/*
+	 * Allocate a new shares struct for this resource controller.
+	 * Called when registering a resource controller with pre-existing
+	 * resource groups and when new resource group is created by the user.
+	 */
+	struct res_shares *(*alloc_shares_struct)(struct resource_group *);
+	/* Corresponding free of shares struct for this resource controller */
+	void (*free_shares_struct)(struct res_shares *);
+
+	/* Notifies the controller when the shares are changed */
+	void (*shares_changed)(struct res_shares *);
+
+	/* resource statistics */
+	ssize_t (*show_stats)(struct res_shares *, char *, size_t);
+	int (*reset_stats)(struct res_shares *, const char *);
+
+	/*
+	 * move_task is called when a task moves from one resource group to
+	 * another. First parameter is the task that is moving, the second
+	 * is the resource specific shares of the resource group the task
+	 * was in, and the third is the shares of the resource group the
+	 * task has moved to.
+	 */
+	void (*move_task)(struct task_struct *, struct res_shares *,
+				struct res_shares *);
+};
+
+extern int register_controller(struct res_controller *);
+extern int unregister_controller(struct res_controller *);
+#endif /* _LINUX_RES_GROUP_RC_H */
Index: linux-2617-rc3/kernel/res_group/res_group.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/kernel/res_group/res_group.c	2006-04-27 09:21:46.000000000 -0700
@@ -0,0 +1,214 @@
+/* res_group.c - Resource Groups: Resource management through grouping of
+ *		  unrelated tasks.
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003, 2004
+ *		(C) Shailabh Nagar, IBM Corp. 2003, 2004
+ *		(C) Chandra Seetharaman, IBM Corp. 2003, 2004, 2005
+ *		(C) Vivek Kashyap, IBM Corp. 2004
+ *		(C) Matt Helsley, IBM Corp. 2006
+ *
+ * Provides kernel API of Resource Groups for in-kernel,per-resource
+ * controllers (one each for cpu, memory and io).
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/res_group_rc.h>
+
+static struct res_controller *res_controllers[MAX_RES_CTLRS];
+/* res_ctlrs_lock protects res_controllers array and count in controllers*/
+static spinlock_t res_ctlrs_lock = SPIN_LOCK_UNLOCKED;
+
+static LIST_HEAD(res_groups);/* list of system-wide resource groups */
+static rwlock_t res_group_lock = RW_LOCK_UNLOCKED; /* protects res_groups */
+
+/* Must be called with res_ctlr_lock held */
+static inline int is_ctlr_id_valid(unsigned int ctlr_id)
+{
+	return ((ctlr_id < MAX_RES_CTLRS) &&
+			(res_controllers[ctlr_id] != NULL));
+}
+
+struct res_controller *get_controller_by_id(unsigned int ctlr_id)
+{
+	/*
+	 * inc of controller[i].count has to be atomically done with
+	 * checking the array res_controllers, as remove_controller()
+	 * checks controller[i].count and clears res_controllers[i]
+	 * atomically, under res_ctlrs_lock.
+	 */
+	spin_lock(&res_ctlrs_lock);
+	if (!is_ctlr_id_valid(ctlr_id)) {
+		spin_unlock(&res_ctlrs_lock);
+		return NULL;
+	}
+	atomic_inc(&res_controllers[ctlr_id]->count);
+	spin_unlock(&res_ctlrs_lock);
+	return res_controllers[ctlr_id];
+}
+
+struct res_controller *get_controller_by_name(const char *name)
+{
+	struct res_controller *ctlr;
+	unsigned int i;
+
+	spin_lock(&res_ctlrs_lock);
+	for (i = 0; i < MAX_RES_CTLRS; i++, ctlr = NULL) {
+		ctlr = res_controllers[i];
+		if (!ctlr)
+			continue;
+		if (!strcmp(name, ctlr->name)) {
+			atomic_inc(&res_controllers[i]->count);
+			break;
+		}
+	}
+	spin_unlock(&res_ctlrs_lock);
+	return ctlr;
+}
+
+static void get_controller(struct res_controller *ctlr)
+{
+	atomic_inc(&ctlr->count);
+}
+
+void put_controller(struct res_controller *ctlr)
+{
+	atomic_dec(&ctlr->count);
+}
+
+/* Allocate resource specific information for a resource group */
+static void do_alloc_shares_struct(struct resource_group *rgroup,
+					struct res_controller *ctlr)
+{
+	if (rgroup->shares[ctlr->ctlr_id]) /* already allocated */
+		return;
+
+	if (rgroup->depth > ctlr->depth_supported)
+		return;
+
+	rgroup->shares[ctlr->ctlr_id] = ctlr->alloc_shares_struct(rgroup);
+	if (rgroup->shares[ctlr->ctlr_id] != NULL)
+		get_controller(ctlr);
+}
+
+/* Free up the given resource specific information in a resource group */
+static void do_free_shares_struct(struct resource_group *rgroup,
+						struct res_controller *ctlr)
+{
+	struct res_shares *shares = rgroup->shares[ctlr->ctlr_id];
+
+	/* No shares alloced previously */
+	if (shares == NULL)
+		return;
+
+	spin_lock(&rgroup->group_lock);
+	rgroup->shares[ctlr->ctlr_id] = NULL;
+	spin_unlock(&rgroup->group_lock);
+	ctlr->free_shares_struct(shares);
+	put_controller(ctlr); /* Drop reference acquired in do_alloc */
+}
+
+static int add_controller(struct res_controller *ctlr)
+{
+	int ctlr_id, ret = -ENOSPC;
+
+	spin_lock(&res_ctlrs_lock);
+	for (ctlr_id = 0; ctlr_id < MAX_RES_CTLRS; ctlr_id++)
+		if (res_controllers[ctlr_id] == NULL) {
+			res_controllers[ctlr_id] = ctlr;
+			ret = ctlr_id;
+			break;
+		}
+	spin_unlock(&res_ctlrs_lock);
+	return ret;
+}
+
+/*
+ * Interface for registering a resource controller.
+ *
+ * Returns the 0 on success, -errno for failure.
+ * Fills ctlr->ctlr_id with a valid controller id on success.
+ */
+int register_controller(struct res_controller *ctlr)
+{
+	int ret;
+	struct resource_group *rgroup;
+
+	if (!ctlr)
+		return -EINVAL;
+
+	/* Make sure there is an alloc and a free */
+	if (!ctlr->alloc_shares_struct || !ctlr->free_shares_struct)
+		return -EINVAL;
+
+	ret = add_controller(ctlr);
+
+	if (ret < 0)
+		return ret;
+
+	ctlr->ctlr_id = ret;
+
+	atomic_set(&ctlr->count, 0);
+
+	/*
+	 * Run through all resource groups and create the controller specific
+	 * data structures.
+	 */
+	read_lock(&res_group_lock);
+	list_for_each_entry(rgroup, &res_groups, group_list)
+		do_alloc_shares_struct(rgroup, ctlr);
+	read_unlock(&res_group_lock);
+	return 0;
+}
+
+static int remove_controller(struct res_controller *ctlr)
+{
+	spin_lock(&res_ctlrs_lock);
+	if (atomic_read(&ctlr->count) > 0) {
+		spin_unlock(&res_ctlrs_lock);
+		return -EBUSY;
+	}
+
+	res_controllers[ctlr->ctlr_id] = NULL;
+	ctlr->ctlr_id = NO_RES_ID;
+	spin_unlock(&res_ctlrs_lock);
+	return 0;
+}
+
+/*
+ * Unregistering resource controller.
+ *
+ * Returns 0 on success -errno for failure.
+ */
+int unregister_controller(struct res_controller *ctlr)
+{
+	struct resource_group *rgroup;
+
+	if (!ctlr)
+		return -EINVAL;
+
+	if (get_controller_by_id(ctlr->ctlr_id) != ctlr)
+		return -EINVAL;
+
+	/* free shares structs for this resource from all resource groups */
+	read_lock(&res_group_lock);
+	list_for_each_entry_reverse(rgroup, &res_groups, group_list)
+		do_free_shares_struct(rgroup, ctlr);
+	read_unlock(&res_group_lock);
+
+	put_controller(ctlr);
+	return remove_controller(ctlr);
+}
+
+EXPORT_SYMBOL_GPL(register_controller);
+EXPORT_SYMBOL_GPL(unregister_controller);
+EXPORT_SYMBOL_GPL(get_controller_by_name);
+EXPORT_SYMBOL_GPL(get_controller_by_id);
+EXPORT_SYMBOL_GPL(put_controller);
Index: linux-2617-rc3/kernel/Makefile
===================================================================
--- linux-2617-rc3.orig/kernel/Makefile	2006-04-27 09:18:25.000000000 -0700
+++ linux-2617-rc3/kernel/Makefile	2006-04-27 09:20:59.000000000 -0700
@@ -38,6 +38,7 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RELAY) += relay.o
+obj-$(CONFIG_RES_GROUPS) += res_group/
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2617-rc3/kernel/res_group/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/kernel/res_group/Makefile	2006-04-27 09:21:42.000000000 -0700
@@ -0,0 +1 @@
+obj-y = res_group.o
Index: linux-2617-rc3/init/Kconfig
===================================================================
--- linux-2617-rc3.orig/init/Kconfig	2006-04-27 09:18:25.000000000 -0700
+++ linux-2617-rc3/init/Kconfig	2006-04-27 09:20:59.000000000 -0700
@@ -150,6 +150,20 @@ config BSD_PROCESS_ACCT_V3
 	  for processing it. A preliminary version of these tools is available
 	  at <http://www.physik3.uni-rostock.de/tim/kernel/utils/acct/>.
 
+menu "Resource Groups"
+
+config RES_GROUPS
+	bool "Resource Groups"
+	depends on EXPERIMENTAL
+	help
+	  Resource Groups is a framework for controlling and monitoring
+	  resource allocation of user-defined groups of tasks. For more
+	  information, please visit http://ckrm.sf.net.
+
+	  If you say Y here, enable the Resource Group File System and at least
+	  one of the resource controllers below. Say N if you are unsure.
+
+endmenu
 config SYSCTL
 	bool "Sysctl support"
 	---help---
Index: linux-2617-rc3/kernel/res_group/local.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/kernel/res_group/local.h	2006-04-27 09:21:46.000000000 -0700
@@ -0,0 +1,10 @@
+/*
+ * Contains function definitions that are local to the Resource Groups.
+ * NOT to be included by controllers.
+ */
+
+#include <linux/res_group_rc.h>
+
+extern struct res_controller *get_controller_by_name(const char *);
+extern struct res_controller *get_controller_by_id(unsigned int);
+extern void put_controller(struct res_controller *);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
