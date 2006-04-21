Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWDUCY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWDUCY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWDUCYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:24:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:35496 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750857AbWDUCYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:24:30 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:24:28 -0700
Message-Id: <20060421022428.6145.51693.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 03/12] Share Handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03/12 - ckrm_core_handle_shares

Provides functions to set/get shares of a specific resource of a class
Defines a teardown function that is intended to be called when user
disables CKRM (by umount of RCFS)
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 include/linux/ckrm.h      |   14 ++
 include/linux/ckrm_rc.h   |   10 +
 kernel/ckrm/Makefile      |    2 
 kernel/ckrm/ckrm.c        |   24 ++++
 kernel/ckrm/ckrm_local.h  |    6 +
 kernel/ckrm/ckrm_shares.c |  242 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 297 insertions(+), 1 deletion(-)

Index: linux2617-rc2/include/linux/ckrm.h
===================================================================
--- linux2617-rc2.orig/include/linux/ckrm.h
+++ linux2617-rc2/include/linux/ckrm.h
@@ -54,6 +54,20 @@
  * locked.
 */
 struct ckrm_shares {
+	/* shares only set by userspace */
+	int min_shares; /* minimun fraction of parent's resources allowed */
+	int max_shares; /* maximum fraction of parent's resources allowed */
+	int child_shares_divisor; /* >= 1, may not be DONT_CARE */
+
+	/*
+	 * share values invisible to userspace.  adjusted when userspace
+	 * sets shares
+	 */
+	int unused_min_shares;
+		/* 0 <= unused_min_shares <= (child_shares_divisor -
+		 * 			Sum of min_shares of children)
+		 */
+	int cur_max_shares; /* max(children's max_shares). need better name */
 };
 
 /*
Index: linux2617-rc2/kernel/ckrm/ckrm_shares.c
===================================================================
--- /dev/null
+++ linux2617-rc2/kernel/ckrm/ckrm_shares.c
@@ -0,0 +1,242 @@
+/*
+ * ckrm_shares.c - Share management functions for CKRM
+ *
+ * Copyright (C) Chandra Seetharaman,  IBM Corp. 2003, 2004, 2005, 2006
+ *		(C) Hubertus Franke,  IBM Corp. 2004
+ *		(C) Matt Helsley,  IBM Corp. 2006
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/errno.h>
+#include <linux/ckrm_rc.h>
+
+/*
+ * Share values can be quantitative (quantity of memory for instance) or
+ * symbolic. The symbolic value DONT_CARE allows for any quantity of a resource
+ * to be substituted in its place. The symbolic value UNCHANGED is only used
+ * when setting share values and means that the old value should be used.
+ */
+
+/* Is the share a quantity (as opposed to "symbols" DONT_CARE or UNCHANGED) */
+static inline int is_share_quantitative(int share)
+{
+	return (share >= 0);
+}
+
+static inline int is_share_symbolic(int share)
+{
+	return !is_share_quantitative(share);
+}
+
+static inline int is_share_valid(int share)
+{
+	return ((share == CKRM_SHARE_DONT_CARE) ||
+			(share == CKRM_SHARE_UNSUPPORTED) ||
+			is_share_quantitative(share));
+}
+
+static inline int did_share_change(int share)
+{
+	return (share != CKRM_SHARE_UNCHANGED);
+}
+
+static inline int change_supported(int share)
+{
+	return (share != CKRM_SHARE_UNSUPPORTED);
+}
+
+/*
+ * Caller is responsible for protecting 'parent'
+ * Caller is responsible for making sure that the sum of sibling min_shares
+ * doesn't exceed parent's total min_shares.
+ */
+static inline void ckrm_child_min_shares_changed(struct ckrm_shares *parent,
+				   int child_cur_min_shares,
+				   int child_new_min_shares)
+{
+	if (is_share_quantitative(child_new_min_shares))
+		parent->unused_min_shares -= child_new_min_shares;
+	if (is_share_quantitative(child_cur_min_shares))
+		parent->unused_min_shares += child_cur_min_shares;
+}
+
+/*
+ * Set parent's cur_max_shares to the largest 'max_shares' of all
+ * of its children.
+ */
+static inline void ckrm_set_cur_max_shares(struct ckrm_class *parent,
+					struct ckrm_controller *ctlr)
+{
+	int max_shares = 0;
+	struct ckrm_class *child = NULL;
+	struct ckrm_shares *child_shares, *parent_shares;
+
+	for_each_child(child, parent) {
+		child_shares = ckrm_get_controller_shares(child, ctlr);
+		max_shares = max(max_shares, child_shares->max_shares);
+	}
+
+	parent_shares = ckrm_get_controller_shares(parent, ctlr);
+	parent_shares->cur_max_shares = max_shares;
+}
+
+/*
+ * Return -EINVAL if the child's shares violate self-consistency or
+ * parent-imposed restrictions. Otherwise return 0.
+ *
+ * This involves checking shares between the child and its parent;
+ * the child and itself (userspace can't be trusted).
+ */
+static inline int are_shares_valid(struct ckrm_shares *child,
+				   struct ckrm_shares *parent,
+				   int current_usage,
+				   int min_shares_increase)
+{
+	/*
+	 * CHILD <-> PARENT validation
+	 * Increases in child's min_shares or max_shares can't exceed
+	 * limitations imposed by the parent class.
+	 * Only validate this if we have a parent.
+	 */
+	if (parent &&
+	    ((is_share_quantitative(child->min_shares) &&
+	      (min_shares_increase > parent->unused_min_shares)) ||
+	     (is_share_quantitative(child->max_shares) &&
+	      (child->max_shares > parent->child_shares_divisor))))
+		return -EINVAL;
+
+	/* CHILD validation: is min valid */
+	if (!is_share_valid(child->min_shares))
+		return -EINVAL;
+
+	/* CHILD validation: is max valid */
+	if (!is_share_valid(child->max_shares))
+		return -EINVAL;
+
+	/*
+	 * CHILD validation: is divisor quantitative & current_usage
+	 * is not more than the new divisor
+	 */
+	if (!is_share_quantitative(child->child_shares_divisor) ||
+			(current_usage > child->child_shares_divisor))
+		return -EINVAL;
+
+	/*
+	 * CHILD validation: is the new child_shares_divisor large
+	 * enough to accomodate largest max_shares of any of my child
+	 */
+	if (child->child_shares_divisor < child->cur_max_shares)
+		return -EINVAL;
+
+	/* CHILD validation: min <= max */
+	if (is_share_quantitative(child->min_shares) &&
+			is_share_quantitative(child->max_shares) &&
+			(child->min_shares > child->max_shares))
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Set the resource shares of a child class given the new shares
+ * specified by userspace, the child's current shares, and the parent class'
+ * shares.
+ *
+ * Caller is responsible for holding class->lock of child and parent
+ * classes to protect the shares structures passed to this function.
+ */
+static int ckrm_set_shares(const struct ckrm_shares *new,
+		    struct ckrm_shares *child_shares,
+    		    struct ckrm_shares *parent_shares)
+{
+	int rc, current_usage, min_shares_increase;
+	struct ckrm_shares final_shares;
+
+	BUG_ON(!new || !child_shares);
+
+	final_shares = *child_shares;
+	if (did_share_change(new->child_shares_divisor) &&
+			change_supported(child_shares->child_shares_divisor))
+		final_shares.child_shares_divisor = new->child_shares_divisor;
+	if (did_share_change(new->min_shares) &&
+			change_supported(child_shares->min_shares))
+		final_shares.min_shares = new->min_shares;
+	if (did_share_change(new->max_shares) &&
+			change_supported(child_shares->max_shares))
+		final_shares.max_shares = new->max_shares;
+
+	current_usage = child_shares->child_shares_divisor -
+	    		 child_shares->unused_min_shares;
+	min_shares_increase = final_shares.min_shares;
+	if (is_share_quantitative(child_shares->min_shares))
+		min_shares_increase -= child_shares->min_shares;
+
+	rc = are_shares_valid(&final_shares, parent_shares, current_usage,
+   			      min_shares_increase);
+	if (rc)
+		return rc; /* new shares would violate restrictions */
+
+	if (did_share_change(new->child_shares_divisor))
+		final_shares.unused_min_shares =
+			(final_shares.child_shares_divisor - current_usage);
+	*child_shares = final_shares;
+	return 0;
+}
+
+int ckrm_set_controller_shares(struct ckrm_class *class,
+					struct ckrm_controller *ctlr,
+					const struct ckrm_shares *new_shares)
+{
+	struct ckrm_shares *shares, *parent_shares;
+	int prev_min, prev_max, rc;
+
+	if (!ctlr->shares_changed)
+		return -EINVAL;
+
+	shares = ckrm_get_controller_shares(class, ctlr);
+	if (!shares)
+		return -EINVAL;
+
+	prev_min = shares->min_shares;
+	prev_max = shares->max_shares;
+
+	if (!ckrm_is_class_root(class))
+		spin_lock(&class->parent->class_lock);
+	spin_lock(&class->class_lock);
+	parent_shares = ckrm_get_controller_shares(class->parent, ctlr);
+	rc = ckrm_set_shares(new_shares, shares, parent_shares);
+	spin_unlock(&class->class_lock);
+
+	if (rc || ckrm_is_class_root(class))
+		goto done;
+
+	/* Notify parent about changes in my shares */
+	ckrm_child_min_shares_changed(parent_shares, prev_min,
+				      shares->min_shares);
+	if (prev_max != shares->max_shares)
+		ckrm_set_cur_max_shares(class->parent, ctlr);
+
+done:
+	if (!ckrm_is_class_root(class))
+		spin_unlock(&class->parent->class_lock);
+	if (!rc)
+		ctlr->shares_changed(shares);
+	return rc;
+}
+
+void ckrm_set_shares_to_default(struct ckrm_class *class,
+						struct ckrm_controller *ctlr)
+{
+	struct ckrm_shares shares = {
+		.min_shares = CKRM_SHARE_DONT_CARE,
+		.max_shares = CKRM_SHARE_DONT_CARE,
+		.child_shares_divisor = CKRM_SHARE_DEFAULT_DIVISOR,
+	};
+	ckrm_set_controller_shares(class, ctlr, &shares);
+}
+
Index: linux2617-rc2/kernel/ckrm/Makefile
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/Makefile
+++ linux2617-rc2/kernel/ckrm/Makefile
@@ -1 +1 @@
-obj-y = ckrm.o
+obj-y = ckrm.o ckrm_shares.o
Index: linux2617-rc2/kernel/ckrm/ckrm.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm.c
+++ linux2617-rc2/kernel/ckrm/ckrm.c
@@ -174,6 +174,8 @@ static void do_free_shares_struct(struct
 	if (shares == NULL)
 		return;
 
+	ckrm_set_shares_to_default(class, ctlr);
+
 	spin_lock(&class->class_lock);
 	class->shares[ctlr->ctlr_id] = NULL;
 	spin_unlock(&class->class_lock);
@@ -345,6 +347,26 @@ int ckrm_unregister_controller(struct ck
 	return remove_controller(ctlr);
 }
 
+/*
+ * Bring the state of CKRM to the initial state.
+ * Only shares of the default class need to be changed to default values.
+ * At this point no user-defined classes should exist.
+ */
+void ckrm_teardown(void)
+{
+	int i;
+	struct ckrm_controller *ctlr;
+
+	BUG_ON(ckrm_num_classes != 0);
+	for (i = 0; i < CKRM_MAX_RES_CTLRS; i++) {
+		ctlr = ckrm_get_controller_by_id(i);
+		if (ctlr) {
+			ckrm_set_shares_to_default(&ckrm_default_class, ctlr);
+			ckrm_put_controller(ctlr);
+		}
+	}
+}
+
 EXPORT_SYMBOL_GPL(ckrm_register_controller);
 EXPORT_SYMBOL_GPL(ckrm_unregister_controller);
 EXPORT_SYMBOL_GPL(ckrm_alloc_class);
@@ -353,3 +375,5 @@ EXPORT_SYMBOL_GPL(ckrm_default_class);
 EXPORT_SYMBOL_GPL(ckrm_get_controller_by_name);
 EXPORT_SYMBOL_GPL(ckrm_get_controller_by_id);
 EXPORT_SYMBOL_GPL(ckrm_put_controller);
+EXPORT_SYMBOL_GPL(ckrm_set_controller_shares);
+EXPORT_SYMBOL_GPL(ckrm_teardown);
Index: linux2617-rc2/include/linux/ckrm_rc.h
===================================================================
--- linux2617-rc2.orig/include/linux/ckrm_rc.h
+++ linux2617-rc2/include/linux/ckrm_rc.h
@@ -73,4 +73,14 @@ static inline int ckrm_is_class_root(con
 #define for_each_child(child, parent)	\
 	list_for_each_entry(child, &parent->children, siblings)
 
+/* Get controller specific shares structure for the given class */
+static inline struct ckrm_shares *ckrm_get_controller_shares(
+			struct ckrm_class *class, struct ckrm_controller *ctlr)
+{
+	if (class && ctlr)
+		return class->shares[ctlr->ctlr_id];
+	else
+		return CKRM_NO_SHARE;
+}
+
 #endif /* _LINUX_CKRM_RC_H */
Index: linux2617-rc2/kernel/ckrm/ckrm_local.h
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm_local.h
+++ linux2617-rc2/kernel/ckrm/ckrm_local.h
@@ -11,3 +11,9 @@ extern void ckrm_put_controller(struct c
 extern struct ckrm_class *ckrm_alloc_class(struct ckrm_class *, const char *);
 extern int ckrm_free_class(struct ckrm_class *);
 extern void ckrm_release_class(struct kref *);
+extern int ckrm_set_controller_shares(struct ckrm_class *,
+			struct ckrm_controller *, const struct ckrm_shares *);
+/* Set the shares for the given class and resource to default values */
+extern void ckrm_set_shares_to_default(struct ckrm_class *,
+						struct ckrm_controller *);
+extern void ckrm_teardown(void);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
