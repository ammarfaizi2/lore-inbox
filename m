Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWDUCY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWDUCY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWDUCYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:24:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:25038 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750851AbWDUCY2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:24:28 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:24:17 -0700
Message-Id: <20060421022417.6145.43602.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 01/12] Register/Unregister interface for Controllers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01/12 - ckrm_core

This patch defines data structures for defining a class and resource
controller.
Provides register/unregister functions for a controller.
Provides utility functions to get a controller's data structure.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 include/linux/ckrm.h     |   76 +++++++++++++++++
 include/linux/ckrm_rc.h  |   67 ++++++++++++++
 init/Kconfig             |   14 +++
 kernel/Makefile          |    1 
 kernel/ckrm/Makefile     |    1 
 kernel/ckrm/ckrm.c       |  210 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/ckrm/ckrm_local.h |   13 ++
 7 files changed, 382 insertions(+)

Index: linux2617-rc2/include/linux/ckrm.h
===================================================================
--- /dev/null
+++ linux2617-rc2/include/linux/ckrm.h
@@ -0,0 +1,76 @@
+/*
+ *  ckrm.h - Header file to be used by Class-based Kernel Resource
+ *  Management (CKRM).
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
+#ifndef _LINUX_CKRM_H
+#define _LINUX_CKRM_H
+
+#ifdef CONFIG_CKRM
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/kref.h>
+
+#define CKRM_SHARE_UNCHANGED	(-1)	/* implicitly specified by userspace,
+					 * never stored in a class' shares
+					 * struct, and never displayed */
+#define CKRM_SHARE_UNSUPPORTED	(-2)	/* If the resource controller doesn't
+					 * support user changing a shares value
+					 * it sets the corresponding share
+					 * value to UNSUPPORTED when it returns
+					 * the newly allocated shares data
+					 * structure */
+#define CKRM_SHARE_DONT_CARE	(-3)
+
+#define CKRM_SHARE_DEFAULT_DIVISOR 	(100)
+
+#define CKRM_MAX_RES_CTLRS	8	/* max # of resource controllers */
+
+#define CKRM_NO_CLASS		NULL
+#define CKRM_NO_SHARE		NULL
+#define CKRM_NO_RES_ID		CKRM_MAX_RES_CTLRS /* Invalid ID */
+
+/*
+ * Share quantities are a child's fraction of the parent's resource
+ * specified by a divisor in the parent and a dividend in the child.
+ *
+ * Shares are represented as a relative quantity between parent and child
+ * to simplify locking when propagating modifications to the shares of a
+ * class. Only the parent and the children of the modified class need to be
+ * locked.
+*/
+struct ckrm_shares {
+};
+
+/*
+ * Class is the grouping of tasks with shares of each resource that has
+ * registered a resource controller (see include/linux/ckrm_rc.h).
+ */
+struct ckrm_class {
+	int depth;		/* depth of this class. root == 0 */
+	spinlock_t class_lock;	/* protects task_list, shares and children
+				 * When grabbing class_lock in a hierarchy,
+				 * grab parent's class_lock first.
+				 * If resource controller uses a class
+				 * specific lock, grab class_lock before
+				 * grabbing resource specific lock */
+	struct ckrm_shares *shares[CKRM_MAX_RES_CTLRS];/* resource shares */
+	struct list_head class_list;	/* entry in list of all classes */
+};
+
+#endif /* CONFIG_CKRM */
+#endif /* _LINUX_CKRM_H */
Index: linux2617-rc2/include/linux/ckrm_rc.h
===================================================================
--- /dev/null
+++ linux2617-rc2/include/linux/ckrm_rc.h
@@ -0,0 +1,67 @@
+/*
+ *  ckrm_rc.h - Header file to be used by Resource controllers of CKRM
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *		(C) Shailabh Nagar,  IBM Corp. 2003
+ *		(C) Chandra Seetharaman, IBM Corp. 2003, 2004, 2005
+ *		(C) Vivek Kashyap , IBM Corp. 2004
+ *
+ * Provides data structures, macros and kernel API of CKRM for
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
+#ifndef _LINUX_CKRM_RC_H
+#define _LINUX_CKRM_RC_H
+
+#include <linux/ckrm.h>
+
+struct ckrm_controller {
+	const char *name;
+	int depth_supported;/* maximum hierarchy supported by controller */
+	unsigned int ctlr_id;
+
+	/*
+	 * Keeps number of references to this controller structure. kref
+	 * does not work as we want to be able to allow removal of a
+	 * controller even when some classes are defined.
+	 */
+	atomic_t count;
+
+	/*
+	 * Allocate a new shares struct for this resource controller.
+	 * Called when registering a resource controller with pre-existing
+	 * classes and when new classes are created by the user.
+	 */
+	struct ckrm_shares *(*alloc_shares_struct)(struct ckrm_class *);
+	/* Corresponding free of shares struct for this resource controller */
+	void (*free_shares_struct)(struct ckrm_shares *);
+
+	/* Notifies the controller when the shares are changed */
+	void (*shares_changed)(struct ckrm_shares *);
+
+	/* resource statistics */
+	ssize_t (*show_stats)(struct ckrm_shares *, char *, size_t);
+	int (*reset_stats)(struct ckrm_shares *, const char *);
+
+	/*
+	 * move_task is called when a task moves from one class to another.
+	 * The first parameter is the task that is moving, the second
+	 * is the resource specific shares of the previous class the task
+	 * was in, and the third is the shares of the class the task has
+	 * moved to.
+	 */
+	void (*move_task)(struct task_struct *, struct ckrm_shares *,
+				struct ckrm_shares *);
+};
+
+extern int ckrm_register_controller(struct ckrm_controller *);
+extern int ckrm_unregister_controller(struct ckrm_controller *);
+#endif /* _LINUX_CKRM_RC_H */
Index: linux2617-rc2/kernel/ckrm/ckrm.c
===================================================================
--- /dev/null
+++ linux2617-rc2/kernel/ckrm/ckrm.c
@@ -0,0 +1,210 @@
+/* ckrm.c - Class-based Kernel Resource Management (CKRM)
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003, 2004
+ *		(C) Shailabh Nagar, IBM Corp. 2003, 2004
+ *		(C) Chandra Seetharaman, IBM Corp. 2003, 2004, 2005
+ *		(C) Vivek Kashyap, IBM Corp. 2004
+ *		(C) Matt Helsley, IBM Corp. 2006
+ *
+ * Provides kernel API of CKRM for in-kernel,per-resource controllers
+ * (one each for cpu, memory and io).
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
+#include <linux/ckrm_rc.h>
+
+static struct ckrm_controller *ckrm_controllers[CKRM_MAX_RES_CTLRS];
+/* res_ctlrs_lock protects ckrm_controllers array and count in controllers*/
+static spinlock_t res_ctlrs_lock = SPIN_LOCK_UNLOCKED;
+
+static LIST_HEAD(ckrm_classes);/* link all classes */
+static rwlock_t ckrm_class_lock = RW_LOCK_UNLOCKED; /* protects ckrm_classes */
+
+/* Must be called with res_ctlr_lock held */
+static inline int is_ctlr_id_valid(unsigned int ctlr_id)
+{
+	return ((ctlr_id < CKRM_MAX_RES_CTLRS) &&
+			(ckrm_controllers[ctlr_id] != NULL));
+}
+
+struct ckrm_controller *ckrm_get_controller_by_id(unsigned int ctlr_id)
+{
+	/*
+	 * inc of controller[i].count has to be atomically done with
+	 * checking the array ckrm_controllers, as remove_controller()
+	 * checks controller[i].count and clears ckrm_controllers[i]
+	 * atomically, under res_ctlrs_lock.
+	 */
+	spin_lock(&res_ctlrs_lock);
+	if (!is_ctlr_id_valid(ctlr_id)) {
+		spin_unlock(&res_ctlrs_lock);
+		return NULL;
+	}
+	atomic_inc(&ckrm_controllers[ctlr_id]->count);
+	spin_unlock(&res_ctlrs_lock);
+	return ckrm_controllers[ctlr_id];
+}
+
+struct ckrm_controller *ckrm_get_controller_by_name(const char *name)
+{
+	struct ckrm_controller *ctlr;
+	unsigned int i;
+
+	spin_lock(&res_ctlrs_lock);
+	for (i = 0; i < CKRM_MAX_RES_CTLRS; i++, ctlr = NULL) {
+		ctlr = ckrm_controllers[i];
+		if (!ctlr)
+			continue;
+		if (!strcmp(name, ctlr->name)) {
+			atomic_inc(&ckrm_controllers[i]->count);
+			break;
+		}
+	}
+	spin_unlock(&res_ctlrs_lock);
+	return ctlr;
+}
+
+static void ckrm_get_controller(struct ckrm_controller *ctlr)
+{
+	atomic_inc(&ctlr->count);
+}
+
+void ckrm_put_controller(struct ckrm_controller *ctlr)
+{
+	atomic_dec(&ctlr->count);
+}
+
+/* Allocate resource specific information for a class */
+static void do_alloc_shares_struct(struct ckrm_class *class,
+					struct ckrm_controller *ctlr)
+{
+	if (class->shares[ctlr->ctlr_id]) /* already allocated */
+		return;
+
+	if (class->depth > ctlr->depth_supported)
+		return;
+
+	class->shares[ctlr->ctlr_id] = ctlr->alloc_shares_struct(class);
+	if (class->shares[ctlr->ctlr_id] != NULL)
+		ckrm_get_controller(ctlr);
+}
+
+/* Free up the given resource specific information in a class */
+static void do_free_shares_struct(struct ckrm_class *class,
+						struct ckrm_controller *ctlr)
+{
+	struct ckrm_shares *shares = class->shares[ctlr->ctlr_id];
+
+	/* No shares alloced previously */
+	if (shares == NULL)
+		return;
+
+	spin_lock(&class->class_lock);
+	class->shares[ctlr->ctlr_id] = NULL;
+	spin_unlock(&class->class_lock);
+	ctlr->free_shares_struct(shares);
+	ckrm_put_controller(ctlr); /* Drop reference acquired in do_alloc */
+}
+
+static int add_controller(struct ckrm_controller *ctlr)
+{
+	int ctlr_id, ret = -ENOSPC;
+
+	spin_lock(&res_ctlrs_lock);
+	for (ctlr_id = 0; ctlr_id < CKRM_MAX_RES_CTLRS; ctlr_id++)
+		if (ckrm_controllers[ctlr_id] == NULL) {
+			ckrm_controllers[ctlr_id] = ctlr;
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
+int ckrm_register_controller(struct ckrm_controller *ctlr)
+{
+	int ret;
+	struct ckrm_class *class;
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
+	 * Run through all classes and create the controller specific data
+	 * structures.
+	 */
+	read_lock(&ckrm_class_lock);
+	list_for_each_entry(class, &ckrm_classes, class_list)
+		do_alloc_shares_struct(class, ctlr);
+	read_unlock(&ckrm_class_lock);
+	return 0;
+}
+
+static int remove_controller(struct ckrm_controller *ctlr)
+{
+	spin_lock(&res_ctlrs_lock);
+	if (atomic_read(&ctlr->count) > 0) {
+		spin_unlock(&res_ctlrs_lock);
+		return -EBUSY;
+	}
+
+	ckrm_controllers[ctlr->ctlr_id] = NULL;
+	ctlr->ctlr_id = CKRM_NO_RES_ID;
+	spin_unlock(&res_ctlrs_lock);
+	return 0;
+}
+
+/*
+ * Unregistering resource controller.
+ *
+ * Returns 0 on success -errno for failure.
+ */
+int ckrm_unregister_controller(struct ckrm_controller *ctlr)
+{
+	struct ckrm_class *class;
+
+	if (!ctlr)
+		return -EINVAL;
+
+	if (ckrm_get_controller_by_id(ctlr->ctlr_id) != ctlr)
+		return -EINVAL;
+
+	/* free shares structs for this resource from all the classes */
+	read_lock(&ckrm_class_lock);
+	list_for_each_entry_reverse(class, &ckrm_classes, class_list)
+		do_free_shares_struct(class, ctlr);
+	read_unlock(&ckrm_class_lock);
+
+	ckrm_put_controller(ctlr);
+	return remove_controller(ctlr);
+}
+
+EXPORT_SYMBOL_GPL(ckrm_register_controller);
+EXPORT_SYMBOL_GPL(ckrm_unregister_controller);
Index: linux2617-rc2/kernel/Makefile
===================================================================
--- linux2617-rc2.orig/kernel/Makefile
+++ linux2617-rc2/kernel/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RELAY) += relay.o
+obj-$(CONFIG_CKRM) += ckrm/
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux2617-rc2/kernel/ckrm/Makefile
===================================================================
--- /dev/null
+++ linux2617-rc2/kernel/ckrm/Makefile
@@ -0,0 +1 @@
+obj-y = ckrm.o
Index: linux2617-rc2/init/Kconfig
===================================================================
--- linux2617-rc2.orig/init/Kconfig
+++ linux2617-rc2/init/Kconfig
@@ -150,6 +150,20 @@ config BSD_PROCESS_ACCT_V3
 	  for processing it. A preliminary version of these tools is available
 	  at <http://www.physik3.uni-rostock.de/tim/kernel/utils/acct/>.
 
+menu "Class Based Kernel Resource Management"
+
+config CKRM
+	bool "Class Based Kernel Resource Management Core"
+	depends on EXPERIMENTAL
+	help
+	  Class-based Kernel Resource Management is a framework for controlling
+	  and monitoring resource allocation of user-defined groups of tasks.
+	  For more information, please visit http://ckrm.sf.net.
+
+	  If you say Y here, enable the Resource Class File System and at least
+	  one of the resource controllers below. Say N if you are unsure.
+
+endmenu
 config SYSCTL
 	bool "Sysctl support"
 	---help---
Index: linux2617-rc2/kernel/ckrm/ckrm_local.h
===================================================================
--- /dev/null
+++ linux2617-rc2/kernel/ckrm/ckrm_local.h
@@ -0,0 +1,13 @@
+/*
+ * Contains function definitions that are local to ckrm core.
+ * NOT to be included by controllers.
+ */
+
+#include <linux/ckrm_rc.h>
+
+extern struct ckrm_controller *ckrm_get_controller_by_name(const char *);
+extern struct ckrm_controller *ckrm_get_controller_by_id(unsigned int);
+extern void ckrm_put_controller(struct ckrm_controller *);
+extern struct ckrm_class *ckrm_alloc_class(struct ckrm_class *, const char *);
+extern int ckrm_free_class(struct ckrm_class *);
+extern void ckrm_release_class(struct kref *);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
