Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWDUCY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWDUCY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWDUCY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:24:27 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:19624 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750785AbWDUCYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:24:25 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:24:23 -0700
Message-Id: <20060421022423.6145.97615.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 02/12] Class creation/deletion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02/12 - ckrm_core_class_support

Provides functions to alloc and free a user defined class.
Provides utility macro to walk through the class hierarchy
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>
Signed-Off-By: Vivek Kashyap <kashyapv@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 include/linux/ckrm.h    |    8 ++
 include/linux/ckrm_rc.h |    9 ++
 kernel/ckrm/ckrm.c      |  171 ++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 175 insertions(+), 13 deletions(-)

Index: linux2617-rc2/include/linux/ckrm.h
===================================================================
--- linux2617-rc2.orig/include/linux/ckrm.h
+++ linux2617-rc2/include/linux/ckrm.h
@@ -61,6 +61,8 @@ struct ckrm_shares {
  * registered a resource controller (see include/linux/ckrm_rc.h).
  */
 struct ckrm_class {
+	const char *name;
+	struct kref ref;
 	int depth;		/* depth of this class. root == 0 */
 	spinlock_t class_lock;	/* protects task_list, shares and children
 				 * When grabbing class_lock in a hierarchy,
@@ -70,6 +72,12 @@ struct ckrm_class {
 				 * grabbing resource specific lock */
 	struct ckrm_shares *shares[CKRM_MAX_RES_CTLRS];/* resource shares */
 	struct list_head class_list;	/* entry in list of all classes */
+
+	struct list_head task_list;	/* this class's tasks */
+
+	struct ckrm_class *parent;
+	struct list_head siblings;	/* entry in list of siblings */
+	struct list_head children;	/* head of children */
 };
 
 #endif /* CONFIG_CKRM */
Index: linux2617-rc2/kernel/ckrm/ckrm.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm.c
+++ linux2617-rc2/kernel/ckrm/ckrm.c
@@ -19,14 +19,32 @@
  */
 
 #include <linux/module.h>
-#include <linux/ckrm_rc.h>
+#include "ckrm_local.h"
 
 static struct ckrm_controller *ckrm_controllers[CKRM_MAX_RES_CTLRS];
 /* res_ctlrs_lock protects ckrm_controllers array and count in controllers*/
 static spinlock_t res_ctlrs_lock = SPIN_LOCK_UNLOCKED;
 
 static LIST_HEAD(ckrm_classes);/* link all classes */
-static rwlock_t ckrm_class_lock = RW_LOCK_UNLOCKED; /* protects ckrm_classes */
+static int ckrm_num_classes;	/* Number of user defined classes */
+static rwlock_t ckrm_class_lock = RW_LOCK_UNLOCKED;
+			/* protects ckrm_classes list and ckrm_num_classes */
+
+struct ckrm_class ckrm_default_class = {
+	.task_list = LIST_HEAD_INIT(ckrm_default_class.task_list),
+	.class_lock = SPIN_LOCK_UNLOCKED,
+	.name = "task",
+	.class_list = LIST_HEAD_INIT(ckrm_default_class.class_list),
+	.siblings = LIST_HEAD_INIT(ckrm_default_class.siblings),
+	.children = LIST_HEAD_INIT(ckrm_default_class.children),
+};
+
+/* Must be called with parent's class_lock held */
+static inline void ckrm_remove_child(struct ckrm_class *child)
+{
+	list_del(&child->siblings);
+	child->parent = CKRM_NO_CLASS;
+}
 
 /* Must be called with res_ctlr_lock held */
 static inline int is_ctlr_id_valid(unsigned int ctlr_id)
@@ -97,6 +115,55 @@ static void do_alloc_shares_struct(struc
 		ckrm_get_controller(ctlr);
 }
 
+static void ckrm_class_init(struct ckrm_class *class)
+{
+	class->class_lock = SPIN_LOCK_UNLOCKED;
+	kref_init(&class->ref);
+	INIT_LIST_HEAD(&class->task_list);
+	INIT_LIST_HEAD(&class->children);
+	INIT_LIST_HEAD(&class->siblings);
+}
+
+struct ckrm_class *ckrm_alloc_class(struct ckrm_class *parent,
+						const char *name)
+{
+	int i;
+	struct ckrm_class *class;
+
+	BUG_ON(parent == NULL);
+
+	kref_get(&parent->ref);
+	class = kzalloc(sizeof(struct ckrm_class), GFP_KERNEL);
+	if (!class) {
+		kref_put(&parent->ref, ckrm_release_class);
+		return NULL;
+	}
+	ckrm_class_init(class);
+	class->name = name;
+	class->depth = parent->depth + 1;
+
+	/* Add to parent */
+	spin_lock(&parent->class_lock);
+	class->parent = parent;
+	list_add(&class->siblings, &parent->children);
+	spin_unlock(&parent->class_lock);
+
+	write_lock(&ckrm_class_lock);
+	list_add_tail(&class->class_list, &ckrm_classes);
+	ckrm_num_classes++;
+	write_unlock(&ckrm_class_lock);
+
+	for (i = 0; i < CKRM_MAX_RES_CTLRS; i++) {
+		struct ckrm_controller *ctlr = ckrm_get_controller_by_id(i);
+		if (!ctlr)
+			continue;
+		do_alloc_shares_struct(class, ctlr);
+		ckrm_put_controller(ctlr);
+	}
+
+	return class;
+}
+
 /* Free up the given resource specific information in a class */
 static void do_free_shares_struct(struct ckrm_class *class,
 						struct ckrm_controller *ctlr)
@@ -114,6 +181,59 @@ static void do_free_shares_struct(struct
 	ckrm_put_controller(ctlr); /* Drop reference acquired in do_alloc */
 }
 
+/*
+ * Release a class
+ *  requires that all tasks were previously reassigned to another class
+ *
+ * Returns 0 on success -errno on failure.
+ */
+void ckrm_release_class(struct kref *kref)
+{
+	int i;
+	struct ckrm_class *class = container_of(kref,
+				struct ckrm_class, ref);
+	struct ckrm_class *parent = class->parent;
+
+	BUG_ON(ckrm_is_class_root(class));
+
+	for (i = 0; i < CKRM_MAX_RES_CTLRS; i++) {
+		struct ckrm_controller *ctlr = ckrm_get_controller_by_id(i);
+		if (!ctlr)
+			continue;
+		do_free_shares_struct(class, ctlr);
+		ckrm_put_controller(ctlr);
+	}
+
+	/* Remove this class from the list of all classes */
+	write_lock(&ckrm_class_lock);
+	list_del(&class->class_list);
+	ckrm_num_classes--;
+	write_unlock(&ckrm_class_lock);
+
+	/* remove from parent */
+	spin_lock(&parent->class_lock);
+	list_del(&class->siblings);
+	class->parent = CKRM_NO_CLASS;
+	spin_unlock(&parent->class_lock);
+
+	kref_put(&parent->ref, ckrm_release_class);
+	kfree(class);
+}
+
+int ckrm_free_class(struct ckrm_class *class)
+{
+	BUG_ON(ckrm_is_class_root(class));
+	spin_lock(&class->class_lock);
+	if (!list_empty(&class->children)) {
+		spin_unlock(&class->class_lock);
+		return -EBUSY;
+	}
+	spin_unlock(&class->class_lock);
+	kref_put(&class->ref, ckrm_release_class);
+	return 0;
+}
+
+
 static int add_controller(struct ckrm_controller *ctlr)
 {
 	int ctlr_id, ret = -ENOSPC;
@@ -128,7 +248,6 @@ static int add_controller(struct ckrm_co
 	spin_unlock(&res_ctlrs_lock);
 	return ret;
 }
-
 /*
  * Interface for registering a resource controller.
  *
@@ -138,7 +257,7 @@ static int add_controller(struct ckrm_co
 int ckrm_register_controller(struct ckrm_controller *ctlr)
 {
 	int ret;
-	struct ckrm_class *class;
+	struct ckrm_class *class, *prev_class;
 
 	if (!ctlr)
 		return -EINVAL;
@@ -160,10 +279,20 @@ int ckrm_register_controller(struct ckrm
 	 * Run through all classes and create the controller specific data
 	 * structures.
 	 */
-	read_lock(&ckrm_class_lock);
-	list_for_each_entry(class, &ckrm_classes, class_list)
-		do_alloc_shares_struct(class, ctlr);
-	read_unlock(&ckrm_class_lock);
+	prev_class = NULL;
+  	read_lock(&ckrm_class_lock);
+	list_for_each_entry(class, &ckrm_classes, class_list) {
+		kref_get(&class->ref);
+		read_unlock(&ckrm_class_lock);
+  		do_alloc_shares_struct(class, ctlr);
+		if (prev_class)
+			kref_put(&prev_class->ref, ckrm_release_class);
+		prev_class = class;
+		read_lock(&ckrm_class_lock);
+	}
+  	read_unlock(&ckrm_class_lock);
+	if (prev_class)
+		kref_put(&prev_class->ref, ckrm_release_class);
 	return 0;
 }
 
@@ -188,7 +317,7 @@ static int remove_controller(struct ckrm
  */
 int ckrm_unregister_controller(struct ckrm_controller *ctlr)
 {
-	struct ckrm_class *class;
+	struct ckrm_class *class, *prev_class;
 
 	if (!ctlr)
 		return -EINVAL;
@@ -197,10 +326,20 @@ int ckrm_unregister_controller(struct ck
 		return -EINVAL;
 
 	/* free shares structs for this resource from all the classes */
-	read_lock(&ckrm_class_lock);
-	list_for_each_entry_reverse(class, &ckrm_classes, class_list)
-		do_free_shares_struct(class, ctlr);
-	read_unlock(&ckrm_class_lock);
+	prev_class = NULL;
+  	read_lock(&ckrm_class_lock);
+	list_for_each_entry_reverse(class, &ckrm_classes, class_list) {
+		kref_get(&class->ref);
+		read_unlock(&ckrm_class_lock);
+  		do_free_shares_struct(class, ctlr);
+		if (prev_class)
+			kref_put(&prev_class->ref, ckrm_release_class);
+		prev_class = class;
+		read_lock(&ckrm_class_lock);
+	}
+  	read_unlock(&ckrm_class_lock);
+	if (prev_class)
+		kref_put(&prev_class->ref, ckrm_release_class);
 
 	ckrm_put_controller(ctlr);
 	return remove_controller(ctlr);
@@ -208,3 +347,9 @@ int ckrm_unregister_controller(struct ck
 
 EXPORT_SYMBOL_GPL(ckrm_register_controller);
 EXPORT_SYMBOL_GPL(ckrm_unregister_controller);
+EXPORT_SYMBOL_GPL(ckrm_alloc_class);
+EXPORT_SYMBOL_GPL(ckrm_free_class);
+EXPORT_SYMBOL_GPL(ckrm_default_class);
+EXPORT_SYMBOL_GPL(ckrm_get_controller_by_name);
+EXPORT_SYMBOL_GPL(ckrm_get_controller_by_id);
+EXPORT_SYMBOL_GPL(ckrm_put_controller);
Index: linux2617-rc2/include/linux/ckrm_rc.h
===================================================================
--- linux2617-rc2.orig/include/linux/ckrm_rc.h
+++ linux2617-rc2/include/linux/ckrm_rc.h
@@ -64,4 +64,13 @@ struct ckrm_controller {
 
 extern int ckrm_register_controller(struct ckrm_controller *);
 extern int ckrm_unregister_controller(struct ckrm_controller *);
+extern struct ckrm_class ckrm_default_class;
+static inline int ckrm_is_class_root(const struct ckrm_class* class)
+{
+	return (class == &ckrm_default_class);
+}
+
+#define for_each_child(child, parent)	\
+	list_for_each_entry(child, &parent->children, siblings)
+
 #endif /* _LINUX_CKRM_RC_H */

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
