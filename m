Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbWD1Bec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbWD1Bec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbWD1Beb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:34:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:53973 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965188AbWD1BeX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:34:23 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:34:21 -0700
Message-Id: <20060428013421.27212.73375.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
References: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
Subject: [PATCH 02/12] Resource group creation/deletion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02/12 - resource_group_support

Provides functions to alloc and free a user defined resource group.
Provides utility macro to walk through the resource group hierarchy.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>
Signed-Off-By: Vivek Kashyap <kashyapv@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 include/linux/res_group.h    |    9 ++
 include/linux/res_group_rc.h |    9 ++
 kernel/res_group/local.h     |    4 +
 kernel/res_group/res_group.c |  167 +++++++++++++++++++++++++++++++++++++++----
 4 files changed, 176 insertions(+), 13 deletions(-)

Index: linux-2617-rc3/include/linux/res_group.h
===================================================================
--- linux-2617-rc3.orig/include/linux/res_group.h	2006-04-27 09:21:46.000000000 -0700
+++ linux-2617-rc3/include/linux/res_group.h	2006-04-27 09:22:04.000000000 -0700
@@ -38,6 +38,7 @@
 #define SHARE_DEFAULT_DIVISOR 	(100)
 
 #define MAX_RES_CTLRS	8	/* max # of resource controllers */
+#define MAX_DEPTH	5	/* max depth of hierarchy supported */
 
 #define NO_RES_GROUP		NULL
 #define NO_SHARE		NULL
@@ -60,6 +61,8 @@ struct res_shares {
  * registered a resource controller (see include/linux/res_group_rc.h).
  */
 struct resource_group {
+	const char *name;
+	struct kref ref;
 	int depth;		/* depth of this resource group. root == 0 */
 	spinlock_t group_lock;	/* protects task_list, shares and children
 				 * When grabbing group_lock in a hierarchy,
@@ -69,6 +72,12 @@ struct resource_group {
 				 * grabbing resource specific lock */
 	struct res_shares *shares[MAX_RES_CTLRS];/* resource shares */
 	struct list_head group_list;	/* entry in system-wide list */
+
+	struct list_head task_list;	/* this resource groups's tasks */
+
+	struct resource_group *parent;
+	struct list_head siblings;	/* entry in list of siblings */
+	struct list_head children;	/* head of children */
 };
 
 #endif /* CONFIG_RES_GROUPS */
Index: linux-2617-rc3/kernel/res_group/res_group.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/res_group.c	2006-04-27 09:21:46.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/res_group.c	2006-04-27 09:22:04.000000000 -0700
@@ -20,14 +20,26 @@
  */
 
 #include <linux/module.h>
-#include <linux/res_group_rc.h>
+#include "local.h"
 
 static struct res_controller *res_controllers[MAX_RES_CTLRS];
 /* res_ctlrs_lock protects res_controllers array and count in controllers*/
 static spinlock_t res_ctlrs_lock = SPIN_LOCK_UNLOCKED;
 
 static LIST_HEAD(res_groups);/* list of system-wide resource groups */
-static rwlock_t res_group_lock = RW_LOCK_UNLOCKED; /* protects res_groups */
+static int num_res_groups;	/* Number of user defined resource groups */
+static rwlock_t res_group_lock = RW_LOCK_UNLOCKED;
+			/* protects res_groups list and num_res_groups */
+
+struct resource_group default_res_group = {
+	.task_list = LIST_HEAD_INIT(default_res_group.task_list),
+	.group_lock = SPIN_LOCK_UNLOCKED,
+	.name = "task",
+	.group_list = LIST_HEAD_INIT(default_res_group.group_list),
+	.siblings = LIST_HEAD_INIT(default_res_group.siblings),
+	.children = LIST_HEAD_INIT(default_res_group.children),
+};
+
 
 /* Must be called with res_ctlr_lock held */
 static inline int is_ctlr_id_valid(unsigned int ctlr_id)
@@ -98,6 +110,59 @@ static void do_alloc_shares_struct(struc
 		get_controller(ctlr);
 }
 
+static void init_res_group(struct resource_group *rgroup)
+{
+	rgroup->group_lock = SPIN_LOCK_UNLOCKED;
+	kref_init(&rgroup->ref);
+	INIT_LIST_HEAD(&rgroup->task_list);
+	INIT_LIST_HEAD(&rgroup->children);
+	INIT_LIST_HEAD(&rgroup->siblings);
+}
+
+struct resource_group *alloc_res_group(struct resource_group *parent,
+						const char *name)
+{
+	int i;
+	struct resource_group *rgroup;
+
+	BUG_ON(parent == NULL);
+
+	/* Only upto MAX_DEPTH level of hierarchy is supported */
+	if (parent->depth == MAX_DEPTH)
+		return NULL;
+
+	kref_get(&parent->ref);
+	rgroup = kzalloc(sizeof(struct resource_group), GFP_KERNEL);
+	if (!rgroup) {
+		kref_put(&parent->ref, release_res_group);
+		return NULL;
+	}
+	init_res_group(rgroup);
+	rgroup->name = name;
+	rgroup->depth = parent->depth + 1;
+
+	/* Add to parent */
+	spin_lock(&parent->group_lock);
+	rgroup->parent = parent;
+	list_add(&rgroup->siblings, &parent->children);
+	spin_unlock(&parent->group_lock);
+
+	write_lock(&res_group_lock);
+	list_add_tail(&rgroup->group_list, &res_groups);
+	num_res_groups++;
+	write_unlock(&res_group_lock);
+
+	for (i = 0; i < MAX_RES_CTLRS; i++) {
+		struct res_controller *ctlr = get_controller_by_id(i);
+		if (!ctlr)
+			continue;
+		do_alloc_shares_struct(rgroup, ctlr);
+		put_controller(ctlr);
+	}
+
+	return rgroup;
+}
+
 /* Free up the given resource specific information in a resource group */
 static void do_free_shares_struct(struct resource_group *rgroup,
 						struct res_controller *ctlr)
@@ -115,6 +180,60 @@ static void do_free_shares_struct(struct
 	put_controller(ctlr); /* Drop reference acquired in do_alloc */
 }
 
+/*
+ * Release a resource group
+ *  requires that all tasks were previously reassigned to another resource
+ *  group.
+ *
+ * Returns 0 on success -errno on failure.
+ */
+void release_res_group(struct kref *kref)
+{
+	int i;
+	struct resource_group *rgroup = container_of(kref,
+				struct resource_group, ref);
+	struct resource_group *parent = rgroup->parent;
+
+	BUG_ON(is_res_group_root(rgroup));
+
+	for (i = 0; i < MAX_RES_CTLRS; i++) {
+		struct res_controller *ctlr = get_controller_by_id(i);
+		if (!ctlr)
+			continue;
+		do_free_shares_struct(rgroup, ctlr);
+		put_controller(ctlr);
+	}
+
+	/* Remove this resource group from the list system-wide groups */
+	write_lock(&res_group_lock);
+	list_del(&rgroup->group_list);
+	num_res_groups--;
+	write_unlock(&res_group_lock);
+
+	/* remove from parent */
+	spin_lock(&parent->group_lock);
+	list_del(&rgroup->siblings);
+	rgroup->parent = NO_RES_GROUP;
+	spin_unlock(&parent->group_lock);
+
+	kref_put(&parent->ref, release_res_group);
+	kfree(rgroup);
+}
+
+int free_res_group(struct resource_group *rgroup)
+{
+	BUG_ON(is_res_group_root(rgroup));
+	spin_lock(&rgroup->group_lock);
+	if (!list_empty(&rgroup->children)) {
+		spin_unlock(&rgroup->group_lock);
+		return -EBUSY;
+	}
+	spin_unlock(&rgroup->group_lock);
+	kref_put(&rgroup->ref, release_res_group);
+	return 0;
+}
+
+
 static int add_controller(struct res_controller *ctlr)
 {
 	int ctlr_id, ret = -ENOSPC;
@@ -129,7 +248,6 @@ static int add_controller(struct res_con
 	spin_unlock(&res_ctlrs_lock);
 	return ret;
 }
-
 /*
  * Interface for registering a resource controller.
  *
@@ -139,7 +257,7 @@ static int add_controller(struct res_con
 int register_controller(struct res_controller *ctlr)
 {
 	int ret;
-	struct resource_group *rgroup;
+	struct resource_group *rgroup, *prev_rgroup;
 
 	if (!ctlr)
 		return -EINVAL;
@@ -161,10 +279,20 @@ int register_controller(struct res_contr
 	 * Run through all resource groups and create the controller specific
 	 * data structures.
 	 */
-	read_lock(&res_group_lock);
-	list_for_each_entry(rgroup, &res_groups, group_list)
-		do_alloc_shares_struct(rgroup, ctlr);
-	read_unlock(&res_group_lock);
+	prev_rgroup = NULL;
+  	read_lock(&res_group_lock);
+	list_for_each_entry(rgroup, &res_groups, group_list) {
+		kref_get(&rgroup->ref);
+		read_unlock(&res_group_lock);
+  		do_alloc_shares_struct(rgroup, ctlr);
+		if (prev_rgroup)
+			kref_put(&prev_rgroup->ref, release_res_group);
+		prev_rgroup = rgroup;
+		read_lock(&res_group_lock);
+	}
+  	read_unlock(&res_group_lock);
+	if (prev_rgroup)
+		kref_put(&prev_rgroup->ref, release_res_group);
 	return 0;
 }
 
@@ -189,7 +317,7 @@ static int remove_controller(struct res_
  */
 int unregister_controller(struct res_controller *ctlr)
 {
-	struct resource_group *rgroup;
+	struct resource_group *rgroup, *prev_rgroup;
 
 	if (!ctlr)
 		return -EINVAL;
@@ -198,10 +326,20 @@ int unregister_controller(struct res_con
 		return -EINVAL;
 
 	/* free shares structs for this resource from all resource groups */
-	read_lock(&res_group_lock);
-	list_for_each_entry_reverse(rgroup, &res_groups, group_list)
-		do_free_shares_struct(rgroup, ctlr);
-	read_unlock(&res_group_lock);
+	prev_rgroup = NULL;
+  	read_lock(&res_group_lock);
+	list_for_each_entry_reverse(rgroup, &res_groups, group_list) {
+		kref_get(&rgroup->ref);
+		read_unlock(&res_group_lock);
+  		do_free_shares_struct(rgroup, ctlr);
+		if (prev_rgroup)
+			kref_put(&prev_rgroup->ref, release_res_group);
+		prev_rgroup = rgroup;
+		read_lock(&res_group_lock);
+	}
+  	read_unlock(&res_group_lock);
+	if (prev_rgroup)
+		kref_put(&prev_rgroup->ref, release_res_group);
 
 	put_controller(ctlr);
 	return remove_controller(ctlr);
@@ -212,3 +350,6 @@ EXPORT_SYMBOL_GPL(unregister_controller)
 EXPORT_SYMBOL_GPL(get_controller_by_name);
 EXPORT_SYMBOL_GPL(get_controller_by_id);
 EXPORT_SYMBOL_GPL(put_controller);
+EXPORT_SYMBOL_GPL(alloc_res_group);
+EXPORT_SYMBOL_GPL(free_res_group);
+EXPORT_SYMBOL_GPL(default_res_group);
Index: linux-2617-rc3/include/linux/res_group_rc.h
===================================================================
--- linux-2617-rc3.orig/include/linux/res_group_rc.h	2006-04-27 09:21:46.000000000 -0700
+++ linux-2617-rc3/include/linux/res_group_rc.h	2006-04-27 09:22:04.000000000 -0700
@@ -65,4 +65,13 @@ struct res_controller {
 
 extern int register_controller(struct res_controller *);
 extern int unregister_controller(struct res_controller *);
+extern struct resource_group default_res_group;
+static inline int is_res_group_root(const struct resource_group *rgroup)
+{
+	return (rgroup == &default_res_group);
+}
+
+#define for_each_child(child, parent)	\
+	list_for_each_entry(child, &parent->children, siblings)
+
 #endif /* _LINUX_RES_GROUP_RC_H */
Index: linux-2617-rc3/kernel/res_group/local.h
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/local.h	2006-04-27 09:21:46.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/local.h	2006-04-27 09:22:04.000000000 -0700
@@ -8,3 +8,7 @@
 extern struct res_controller *get_controller_by_name(const char *);
 extern struct res_controller *get_controller_by_id(unsigned int);
 extern void put_controller(struct res_controller *);
+extern struct resource_group *alloc_res_group(struct resource_group *,
+							const char *);
+extern int free_res_group(struct resource_group *);
+extern void release_res_group(struct kref *);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
