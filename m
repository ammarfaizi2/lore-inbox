Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWD1Bew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWD1Bew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWD1Bed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:34:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:14225 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965189AbWD1Be2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:34:28 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:34:26 -0700
Message-Id: <20060428013426.27212.65397.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
References: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
Subject: [PATCH 03/12] Share Handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03/12 - shares_support

Provides functions to set/get shares of a specific resource of a resource
group.
Defines a teardown function that is intended to be called when user
disables resource group (by umount of the configfs component).
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 include/linux/res_group.h    |   14 ++
 include/linux/res_group_rc.h |   10 +
 kernel/res_group/Makefile    |    2 
 kernel/res_group/local.h     |    6 +
 kernel/res_group/res_group.c |   24 ++++
 kernel/res_group/shares.c    |  242 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 297 insertions(+), 1 deletion(-)

Index: linux-2617-rc3/include/linux/res_group.h
===================================================================
--- linux-2617-rc3.orig/include/linux/res_group.h	2006-04-27 09:22:04.000000000 -0700
+++ linux-2617-rc3/include/linux/res_group.h	2006-04-27 09:22:07.000000000 -0700
@@ -54,6 +54,20 @@
  * resource group need to be locked.
 */
 struct res_shares {
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
Index: linux-2617-rc3/kernel/res_group/shares.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/kernel/res_group/shares.c	2006-04-27 09:22:07.000000000 -0700
@@ -0,0 +1,242 @@
+/*
+ * shares.c - Share management functions for Resource Groups
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
+#include <linux/res_group_rc.h>
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
+	return ((share == SHARE_DONT_CARE) ||
+			(share == SHARE_UNSUPPORTED) ||
+			is_share_quantitative(share));
+}
+
+static inline int did_share_change(int share)
+{
+	return (share != SHARE_UNCHANGED);
+}
+
+static inline int change_supported(int share)
+{
+	return (share != SHARE_UNSUPPORTED);
+}
+
+/*
+ * Caller is responsible for protecting 'parent'
+ * Caller is responsible for making sure that the sum of sibling min_shares
+ * doesn't exceed parent's total min_shares.
+ */
+static inline void child_min_shares_changed(struct res_shares *parent,
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
+static inline void set_cur_max_shares(struct resource_group *parent,
+					struct res_controller *ctlr)
+{
+	int max_shares = 0;
+	struct resource_group *child = NULL;
+	struct res_shares *child_shares, *parent_shares;
+
+	for_each_child(child, parent) {
+		child_shares = get_controller_shares(child, ctlr);
+		max_shares = max(max_shares, child_shares->max_shares);
+	}
+
+	parent_shares = get_controller_shares(parent, ctlr);
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
+static inline int are_shares_valid(struct res_shares *child,
+				   struct res_shares *parent,
+				   int current_usage,
+				   int min_shares_increase)
+{
+	/*
+	 * CHILD <-> PARENT validation
+	 * Increases in child's min_shares or max_shares can't exceed
+	 * limitations imposed by the parent resource group.
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
+ * Set the resource shares of a child resource group given the new shares
+ * specified by userspace, the child's current shares, and the parent
+ * resource group's shares.
+ *
+ * Caller is responsible for holding group_lock of child and parent
+ * resource groups to protect the shares structures passed to this function.
+ */
+static int set_shares(const struct res_shares *new,
+		    struct res_shares *child_shares,
+    		    struct res_shares *parent_shares)
+{
+	int rc, current_usage, min_shares_increase;
+	struct res_shares final_shares;
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
+int set_controller_shares(struct resource_group *rgroup,
+					struct res_controller *ctlr,
+					const struct res_shares *new_shares)
+{
+	struct res_shares *shares, *parent_shares;
+	int prev_min, prev_max, rc;
+
+	if (!ctlr->shares_changed)
+		return -EINVAL;
+
+	shares = get_controller_shares(rgroup, ctlr);
+	if (!shares)
+		return -EINVAL;
+
+	prev_min = shares->min_shares;
+	prev_max = shares->max_shares;
+
+	if (!is_res_group_root(rgroup))
+		spin_lock(&rgroup->parent->group_lock);
+	spin_lock(&rgroup->group_lock);
+	parent_shares = get_controller_shares(rgroup->parent, ctlr);
+	rc = set_shares(new_shares, shares, parent_shares);
+	spin_unlock(&rgroup->group_lock);
+
+	if (rc || is_res_group_root(rgroup))
+		goto done;
+
+	/* Notify parent about changes in my shares */
+	child_min_shares_changed(parent_shares, prev_min,
+				      shares->min_shares);
+	if (prev_max != shares->max_shares)
+		set_cur_max_shares(rgroup->parent, ctlr);
+
+done:
+	if (!is_res_group_root(rgroup))
+		spin_unlock(&rgroup->parent->group_lock);
+	if (!rc)
+		ctlr->shares_changed(shares);
+	return rc;
+}
+
+void set_shares_to_default(struct resource_group *rgroup,
+						struct res_controller *ctlr)
+{
+	struct res_shares shares = {
+		.min_shares = SHARE_DONT_CARE,
+		.max_shares = SHARE_DONT_CARE,
+		.child_shares_divisor = SHARE_DEFAULT_DIVISOR,
+	};
+	set_controller_shares(rgroup, ctlr, &shares);
+}
+
Index: linux-2617-rc3/kernel/res_group/Makefile
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/Makefile	2006-04-27 09:21:42.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/Makefile	2006-04-27 09:22:07.000000000 -0700
@@ -1 +1 @@
-obj-y = res_group.o
+obj-y = res_group.o shares.o
Index: linux-2617-rc3/kernel/res_group/res_group.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/res_group.c	2006-04-27 09:22:04.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/res_group.c	2006-04-27 09:22:07.000000000 -0700
@@ -173,6 +173,8 @@ static void do_free_shares_struct(struct
 	if (shares == NULL)
 		return;
 
+	set_shares_to_default(rgroup, ctlr);
+
 	spin_lock(&rgroup->group_lock);
 	rgroup->shares[ctlr->ctlr_id] = NULL;
 	spin_unlock(&rgroup->group_lock);
@@ -345,6 +347,26 @@ int unregister_controller(struct res_con
 	return remove_controller(ctlr);
 }
 
+/*
+ * Bring the state of Resource Groups to the initial state. Only shares
+ * of the default resource group need to be changed to default values.
+ * At this point no user-defined resource groups should exist.
+ */
+void res_group_teardown(void)
+{
+	int i;
+	struct res_controller *ctlr;
+
+	BUG_ON(num_res_groups != 0);
+	for (i = 0; i < MAX_RES_CTLRS; i++) {
+		ctlr = get_controller_by_id(i);
+		if (ctlr) {
+			set_shares_to_default(&default_res_group, ctlr);
+			put_controller(ctlr);
+		}
+	}
+}
+
 EXPORT_SYMBOL_GPL(register_controller);
 EXPORT_SYMBOL_GPL(unregister_controller);
 EXPORT_SYMBOL_GPL(get_controller_by_name);
@@ -353,3 +375,5 @@ EXPORT_SYMBOL_GPL(put_controller);
 EXPORT_SYMBOL_GPL(alloc_res_group);
 EXPORT_SYMBOL_GPL(free_res_group);
 EXPORT_SYMBOL_GPL(default_res_group);
+EXPORT_SYMBOL_GPL(set_controller_shares);
+EXPORT_SYMBOL_GPL(res_group_teardown);
Index: linux-2617-rc3/include/linux/res_group_rc.h
===================================================================
--- linux-2617-rc3.orig/include/linux/res_group_rc.h	2006-04-27 09:22:04.000000000 -0700
+++ linux-2617-rc3/include/linux/res_group_rc.h	2006-04-27 09:22:07.000000000 -0700
@@ -74,4 +74,14 @@ static inline int is_res_group_root(cons
 #define for_each_child(child, parent)	\
 	list_for_each_entry(child, &parent->children, siblings)
 
+/* Get controller specific shares structure for the given resource group */
+static inline struct res_shares *get_controller_shares(
+		struct resource_group *rgroup, struct res_controller *ctlr)
+{
+	if (rgroup && ctlr)
+		return rgroup->shares[ctlr->ctlr_id];
+	else
+		return NO_SHARE;
+}
+
 #endif /* _LINUX_RES_GROUP_RC_H */
Index: linux-2617-rc3/kernel/res_group/local.h
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/local.h	2006-04-27 09:22:04.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/local.h	2006-04-27 09:22:07.000000000 -0700
@@ -12,3 +12,9 @@ extern struct resource_group *alloc_res_
 							const char *);
 extern int free_res_group(struct resource_group *);
 extern void release_res_group(struct kref *);
+extern int set_controller_shares(struct resource_group *,
+			struct res_controller *, const struct res_shares *);
+/* Set shares for the given resource group and resource to default values */
+extern void set_shares_to_default(struct resource_group *,
+						struct res_controller *);
+extern void res_group_teardown(void);

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
