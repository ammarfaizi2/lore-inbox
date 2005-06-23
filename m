Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVFWHDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVFWHDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVFWGpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:45:42 -0400
Received: from [24.22.56.4] ([24.22.56.4]:15590 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262282AbVFWGSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:44 -0400
Message-Id: <20050623061755.520778000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:15:59 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Chandra Seetharaman <sekharan@us.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>, Shailabh Nagar <nagar@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 07/38] CKRM e18: Numtasks Controller
Content-Disposition: inline; filename=07-diff_numtasks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a resource controller for controlling the number
of tasks per class in CKRM.

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>


 include/linux/ckrm_tsk.h         |   35 ++
 init/Kconfig                     |   10 
 kernel/ckrm/Makefile             |    3 
 kernel/ckrm/ckrm_numtasks.c      |  522 +++++++++++++++++++++++++++++++++++++++
 kernel/ckrm/ckrm_numtasks_stub.c |   53 +++
 kernel/fork.c                    |    6 
 6 files changed, 628 insertions(+), 1 deletion(-)

Index: linux-2.6.12-ckrm1/include/linux/ckrm_tsk.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/include/linux/ckrm_tsk.h	2005-06-20 13:08:34.000000000 -0700
@@ -0,0 +1,35 @@
+/* ckrm_tsk.h - No. of tasks resource controller for CKRM
+ *
+ * Copyright (C) Chandra Seetharaman, IBM Corp. 2003
+ *
+ * Provides No. of tasks resource controller for CKRM
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
+#ifndef _LINUX_CKRM_TSK_H
+#define _LINUX_CKRM_TSK_H
+
+#ifdef CONFIG_CKRM_TYPE_TASKCLASS
+#include <linux/ckrm_rc.h>
+
+typedef int (*get_ref_t) (struct ckrm_core_class *, int);
+typedef void (*put_ref_t) (struct ckrm_core_class *);
+
+extern int numtasks_get_ref(struct ckrm_core_class *, int);
+extern void numtasks_put_ref(struct ckrm_core_class *);
+extern void ckrm_numtasks_register(get_ref_t, put_ref_t);
+
+#else /* CONFIG_CKRM_TYPE_TASKCLASS */
+
+#define numtasks_get_ref(core_class, ref) (1)
+#define numtasks_put_ref(core_class)  do {} while (0)
+
+#endif /* CONFIG_CKRM_TYPE_TASKCLASS */
+#endif /* _LINUX_CKRM_RES_H */
Index: linux-2.6.12-ckrm1/init/Kconfig
===================================================================
--- linux-2.6.12-ckrm1.orig/init/Kconfig	2005-06-20 13:08:32.000000000 -0700
+++ linux-2.6.12-ckrm1/init/Kconfig	2005-06-20 13:08:34.000000000 -0700
@@ -193,6 +193,16 @@ config CKRM_TYPE_SOCKETCLASS
 
 	  Say Y if unsure.
 
+config CKRM_RES_NUMTASKS
+	tristate "Number of Tasks Resource Manager"
+	depends on CKRM_TYPE_TASKCLASS
+	default y
+	help
+	  Provides a Resource Controller for CKRM that allows limiting no of
+	  tasks a task class can have.
+
+	  Say N if unsure, Y to use the feature.
+
 endmenu
 
 config SYSCTL
Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c	2005-06-20 13:08:34.000000000 -0700
@@ -0,0 +1,522 @@
+/* ckrm_numtasks.c - "Number of tasks" resource controller for CKRM
+ *
+ * Copyright (C) Chandra Seetharaman,  IBM Corp. 2003
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
+/*
+ * CKRM Resource controller for tracking number of tasks in a class.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <asm/errno.h>
+#include <asm/div64.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/ckrm_rc.h>
+#include <linux/ckrm_tc.h>
+#include <linux/ckrm_tsk.h>
+
+#define TOTAL_NUM_TASKS (131072)	/* 128 K */
+#define NUMTASKS_DEBUG
+#define NUMTASKS_NAME "numtasks"
+
+struct ckrm_numtasks {
+	struct ckrm_core_class *core;	/* the core i am part of... */
+	struct ckrm_core_class *parent;	/* parent of the core above. */
+	struct ckrm_shares shares;
+	spinlock_t cnt_lock;	/* always grab parent's lock before child's */
+	int cnt_guarantee;	/* num_tasks guarantee in local units */
+	int cnt_unused;		/* has to borrow if more than this is needed */
+	int cnt_limit;		/* no tasks over this limit. */
+	atomic_t cnt_cur_alloc;	/* current alloc from self */
+	atomic_t cnt_borrowed;	/* borrowed from the parent */
+
+	int over_guarantee;	/* turn on/off when cur_alloc goes  */
+				/* over/under guarantee */
+
+	/* internally maintained statictics to compare with max numbers */
+	int limit_failures;	/* # failures as request was over the limit */
+	int borrow_sucesses;	/* # successful borrows */
+	int borrow_failures;	/* # borrow failures */
+
+	/* Maximum the specific statictics has reached. */
+	int max_limit_failures;
+	int max_borrow_sucesses;
+	int max_borrow_failures;
+
+	/* Total number of specific statistics */
+	int tot_limit_failures;
+	int tot_borrow_sucesses;
+	int tot_borrow_failures;
+};
+
+struct ckrm_res_ctlr numtasks_rcbs;
+
+/* Initialize rescls values
+ * May be called on each rcfs unmount or as part of error recovery
+ * to make share values sane.
+ * Does not traverse hierarchy reinitializing children.
+ */
+static void numtasks_res_initcls_one(struct ckrm_numtasks * res)
+{
+	res->shares.my_guarantee = CKRM_SHARE_DONTCARE;
+	res->shares.my_limit = CKRM_SHARE_DONTCARE;
+	res->shares.total_guarantee = CKRM_SHARE_DFLT_TOTAL_GUARANTEE;
+	res->shares.max_limit = CKRM_SHARE_DFLT_MAX_LIMIT;
+	res->shares.unused_guarantee = CKRM_SHARE_DFLT_TOTAL_GUARANTEE;
+	res->shares.cur_max_limit = 0;
+
+	res->cnt_guarantee = CKRM_SHARE_DONTCARE;
+	res->cnt_unused = CKRM_SHARE_DONTCARE;
+	res->cnt_limit = CKRM_SHARE_DONTCARE;
+
+	res->over_guarantee = 0;
+
+	res->limit_failures = 0;
+	res->borrow_sucesses = 0;
+	res->borrow_failures = 0;
+
+	res->max_limit_failures = 0;
+	res->max_borrow_sucesses = 0;
+	res->max_borrow_failures = 0;
+
+	res->tot_limit_failures = 0;
+	res->tot_borrow_sucesses = 0;
+	res->tot_borrow_failures = 0;
+
+	atomic_set(&res->cnt_cur_alloc, 0);
+	atomic_set(&res->cnt_borrowed, 0);
+	return;
+}
+
+#if 0
+static void numtasks_res_initcls(void *my_res)
+{
+	struct ckrm_numtasks *res = my_res;
+
+	/* Write a version which propagates values all the way down
+	   and replace rcbs callback with that version */
+
+}
+#endif
+
+static int numtasks_get_ref_local(struct ckrm_core_class *core, int force)
+{
+	int rc, resid = numtasks_rcbs.resid;
+	struct ckrm_numtasks *res;
+
+	if ((resid < 0) || (core == NULL))
+		return 1;
+
+	res = ckrm_get_res_class(core, resid, struct ckrm_numtasks);
+	if (res == NULL)
+		return 1;
+
+	atomic_inc(&res->cnt_cur_alloc);
+
+	rc = 1;
+	if (((res->parent) && (res->cnt_unused == CKRM_SHARE_DONTCARE)) ||
+	    (atomic_read(&res->cnt_cur_alloc) > res->cnt_unused)) {
+
+		rc = 0;
+		if (!force && (res->cnt_limit != CKRM_SHARE_DONTCARE) &&
+		    (atomic_read(&res->cnt_cur_alloc) > res->cnt_limit)) {
+			res->limit_failures++;
+			res->tot_limit_failures++;
+		} else if (res->parent != NULL) {
+			if ((rc =
+			     numtasks_get_ref_local(res->parent, force)) == 1) {
+				atomic_inc(&res->cnt_borrowed);
+				res->borrow_sucesses++;
+				res->tot_borrow_sucesses++;
+				res->over_guarantee = 1;
+			} else {
+				res->borrow_failures++;
+				res->tot_borrow_failures++;
+			}
+		} else {
+			rc = force;
+		}
+	} else if (res->over_guarantee) {
+		res->over_guarantee = 0;
+
+		if (res->max_limit_failures < res->limit_failures) {
+			res->max_limit_failures = res->limit_failures;
+		}
+		if (res->max_borrow_sucesses < res->borrow_sucesses) {
+			res->max_borrow_sucesses = res->borrow_sucesses;
+		}
+		if (res->max_borrow_failures < res->borrow_failures) {
+			res->max_borrow_failures = res->borrow_failures;
+		}
+		res->limit_failures = 0;
+		res->borrow_sucesses = 0;
+		res->borrow_failures = 0;
+	}
+
+	if (!rc) {
+		atomic_dec(&res->cnt_cur_alloc);
+	}
+	return rc;
+}
+
+static void numtasks_put_ref_local(struct ckrm_core_class *core)
+{
+	int resid = numtasks_rcbs.resid;
+	struct ckrm_numtasks *res;
+
+	if ((resid == -1) || (core == NULL)) {
+		return;
+	}
+
+	res = ckrm_get_res_class(core, resid, struct ckrm_numtasks);
+	if (res == NULL)
+		return;
+	if (unlikely(atomic_read(&res->cnt_cur_alloc) == 0)) {
+		printk(KERN_WARNING "numtasks_put_ref: Trying to decrement "
+					"counter below 0\n");
+		return;
+	}
+	atomic_dec(&res->cnt_cur_alloc);
+	if (atomic_read(&res->cnt_borrowed) > 0) {
+		atomic_dec(&res->cnt_borrowed);
+		numtasks_put_ref_local(res->parent);
+	}
+	return;
+}
+
+static void *numtasks_res_alloc(struct ckrm_core_class *core,
+				struct ckrm_core_class *parent)
+{
+	struct ckrm_numtasks *res;
+
+	res = kmalloc(sizeof(struct ckrm_numtasks), GFP_ATOMIC);
+
+	if (res) {
+		memset(res, 0, sizeof(struct ckrm_numtasks));
+		res->core = core;
+		res->parent = parent;
+		numtasks_res_initcls_one(res);
+		res->cnt_lock = SPIN_LOCK_UNLOCKED;
+		if (parent == NULL) {
+			/*
+			 * I am part of root class. So set the max tasks
+			 * to available default.
+			 */
+			res->cnt_guarantee = TOTAL_NUM_TASKS;
+			res->cnt_unused = TOTAL_NUM_TASKS;
+			res->cnt_limit = TOTAL_NUM_TASKS;
+		}
+		try_module_get(THIS_MODULE);
+	} else {
+		printk(KERN_ERR
+		       "numtasks_res_alloc: failed GFP_ATOMIC alloc\n");
+	}
+	return res;
+}
+
+/*
+ * No locking of this resource class object necessary as we are not
+ * supposed to be assigned (or used) when/after this function is called.
+ */
+static void numtasks_res_free(void *my_res)
+{
+	struct ckrm_numtasks *res = my_res, *parres, *childres;
+	struct ckrm_core_class *child = NULL;
+	int i, borrowed, maxlimit, resid = numtasks_rcbs.resid;
+
+	if (!res)
+		return;
+
+	/* Assuming there will be no children when this function is called */
+
+	parres = ckrm_get_res_class(res->parent, resid, struct ckrm_numtasks);
+
+	if (unlikely(atomic_read(&res->cnt_cur_alloc) < 0)) {
+		printk(KERN_WARNING "numtasks_res: counter below 0\n");
+	}
+	if (unlikely(atomic_read(&res->cnt_cur_alloc) > 0 ||
+				atomic_read(&res->cnt_borrowed) > 0)) {
+		printk(KERN_WARNING "numtasks_res_free: resource still "
+		       "alloc'd %p\n", res);
+		if ((borrowed = atomic_read(&res->cnt_borrowed)) > 0) {
+			for (i = 0; i < borrowed; i++) {
+				numtasks_put_ref_local(parres->core);
+			}
+		}
+	}
+	/* return child's limit/guarantee to parent node */
+	spin_lock(&parres->cnt_lock);
+	child_guarantee_changed(&parres->shares, res->shares.my_guarantee, 0);
+
+	/* run thru parent's children and get the new max_limit of the parent */
+	ckrm_lock_hier(parres->core);
+	maxlimit = 0;
+	while ((child = ckrm_get_next_child(parres->core, child)) != NULL) {
+		childres = ckrm_get_res_class(child, resid, struct ckrm_numtasks);
+		if (maxlimit < childres->shares.my_limit) {
+			maxlimit = childres->shares.my_limit;
+		}
+	}
+	ckrm_unlock_hier(parres->core);
+	if (parres->shares.cur_max_limit < maxlimit) {
+		parres->shares.cur_max_limit = maxlimit;
+	}
+
+	spin_unlock(&parres->cnt_lock);
+	kfree(res);
+	module_put(THIS_MODULE);
+	return;
+}
+
+/*
+ * Recalculate the guarantee and limit in real units... and propagate the
+ * same to children.
+ * Caller is responsible for protecting res and for the integrity of parres
+ */
+static void
+recalc_and_propagate(struct ckrm_numtasks * res, struct ckrm_numtasks * parres)
+{
+	struct ckrm_core_class *child = NULL;
+	struct ckrm_numtasks *childres;
+	int resid = numtasks_rcbs.resid;
+
+	if (parres) {
+		struct ckrm_shares *par = &parres->shares;
+		struct ckrm_shares *self = &res->shares;
+
+		/* calculate cnt_guarantee and cnt_limit */
+		if (parres->cnt_guarantee == CKRM_SHARE_DONTCARE) {
+			res->cnt_guarantee = CKRM_SHARE_DONTCARE;
+		} else if (par->total_guarantee) {
+			u64 temp = (u64) self->my_guarantee * parres->cnt_guarantee;
+			do_div(temp, par->total_guarantee);
+			res->cnt_guarantee = (int) temp;
+		} else {
+			res->cnt_guarantee = 0;
+		}
+
+		if (parres->cnt_limit == CKRM_SHARE_DONTCARE) {
+			res->cnt_limit = CKRM_SHARE_DONTCARE;
+		} else if (par->max_limit) {
+			u64 temp = (u64) self->my_limit * parres->cnt_limit;
+			do_div(temp, par->max_limit);
+			res->cnt_limit = (int) temp;
+		} else {
+			res->cnt_limit = 0;
+		}
+
+		/* Calculate unused units */
+		if (res->cnt_guarantee == CKRM_SHARE_DONTCARE) {
+			res->cnt_unused = CKRM_SHARE_DONTCARE;
+		} else if (self->total_guarantee) {
+			u64 temp = (u64) self->unused_guarantee * res->cnt_guarantee;
+			do_div(temp, self->total_guarantee);
+			res->cnt_unused = (int) temp;
+		} else {
+			res->cnt_unused = 0;
+		}
+	}
+	/* propagate to children */
+	ckrm_lock_hier(res->core);
+	while ((child = ckrm_get_next_child(res->core, child)) != NULL) {
+		childres = ckrm_get_res_class(child, resid, struct ckrm_numtasks);
+
+		spin_lock(&childres->cnt_lock);
+		recalc_and_propagate(childres, res);
+		spin_unlock(&childres->cnt_lock);
+	}
+	ckrm_unlock_hier(res->core);
+	return;
+}
+
+static int numtasks_set_share_values(void *my_res, struct ckrm_shares *new)
+{
+	struct ckrm_numtasks *parres, *res = my_res;
+	struct ckrm_shares *cur = &res->shares, *par;
+	int rc = -EINVAL, resid = numtasks_rcbs.resid;
+
+	if (!res)
+		return rc;
+
+	if (res->parent) {
+		parres =
+		    ckrm_get_res_class(res->parent, resid, struct ckrm_numtasks);
+		spin_lock(&parres->cnt_lock);
+		spin_lock(&res->cnt_lock);
+		par = &parres->shares;
+	} else {
+		spin_lock(&res->cnt_lock);
+		par = NULL;
+		parres = NULL;
+	}
+
+	rc = set_shares(new, cur, par);
+
+	if ((rc == 0) && parres) {
+		/* Calculate parent's unused units */
+		if (parres->cnt_guarantee == CKRM_SHARE_DONTCARE) {
+			parres->cnt_unused = CKRM_SHARE_DONTCARE;
+		} else if (par->total_guarantee) {
+			u64 temp = (u64) par->unused_guarantee * parres->cnt_guarantee;
+			do_div(temp, par->total_guarantee);
+			parres->cnt_unused = (int) temp;
+		} else {
+			parres->cnt_unused = 0;
+		}
+		recalc_and_propagate(res, parres);
+	}
+	spin_unlock(&res->cnt_lock);
+	if (res->parent) {
+		spin_unlock(&parres->cnt_lock);
+	}
+	return rc;
+}
+
+static int numtasks_get_share_values(void *my_res, struct ckrm_shares *shares)
+{
+	struct ckrm_numtasks *res = my_res;
+
+	if (!res)
+		return -EINVAL;
+	*shares = res->shares;
+	return 0;
+}
+
+static int numtasks_get_stats(void *my_res, struct seq_file *sfile)
+{
+	struct ckrm_numtasks *res = my_res;
+
+	if (!res)
+		return -EINVAL;
+
+	seq_printf(sfile, "Number of tasks resource:\n");
+	seq_printf(sfile, "Total Over limit failures: %d\n",
+		   res->tot_limit_failures);
+	seq_printf(sfile, "Total Over guarantee sucesses: %d\n",
+		   res->tot_borrow_sucesses);
+	seq_printf(sfile, "Total Over guarantee failures: %d\n",
+		   res->tot_borrow_failures);
+
+	seq_printf(sfile, "Maximum Over limit failures: %d\n",
+		   res->max_limit_failures);
+	seq_printf(sfile, "Maximum Over guarantee sucesses: %d\n",
+		   res->max_borrow_sucesses);
+	seq_printf(sfile, "Maximum Over guarantee failures: %d\n",
+		   res->max_borrow_failures);
+#ifdef NUMTASKS_DEBUG
+	seq_printf(sfile,
+		   "cur_alloc %d; borrowed %d; cnt_guar %d; cnt_limit %d "
+		   "cnt_unused %d, unused_guarantee %d, cur_max_limit %d\n",
+		   atomic_read(&res->cnt_cur_alloc),
+		   atomic_read(&res->cnt_borrowed), res->cnt_guarantee,
+		   res->cnt_limit, res->cnt_unused,
+		   res->shares.unused_guarantee,
+		   res->shares.cur_max_limit);
+#endif
+
+	return 0;
+}
+
+static int numtasks_show_config(void *my_res, struct seq_file *sfile)
+{
+	struct ckrm_numtasks *res = my_res;
+
+	if (!res)
+		return -EINVAL;
+
+	seq_printf(sfile, "res=%s,parameter=somevalue\n", NUMTASKS_NAME);
+	return 0;
+}
+
+static int numtasks_set_config(void *my_res, const char *cfgstr)
+{
+	struct ckrm_numtasks *res = my_res;
+
+	if (!res)
+		return -EINVAL;
+	printk("numtasks config='%s'\n", cfgstr);
+	return 0;
+}
+
+static void numtasks_change_resclass(void *task, void *old, void *new)
+{
+	struct ckrm_numtasks *oldres = old;
+	struct ckrm_numtasks *newres = new;
+
+	if (oldres != (void *)-1) {
+		struct task_struct *tsk = task;
+		if (!oldres) {
+			struct ckrm_core_class *old_core =
+			    &(tsk->parent->taskclass->core);
+			oldres =
+			    ckrm_get_res_class(old_core, numtasks_rcbs.resid,
+					       struct ckrm_numtasks);
+		}
+		numtasks_put_ref_local(oldres->core);
+	}
+	if (newres) {
+		(void)numtasks_get_ref_local(newres->core, 1);
+	}
+}
+
+struct ckrm_res_ctlr numtasks_rcbs = {
+	.res_name = NUMTASKS_NAME,
+	.res_hdepth = 1,
+	.resid = -1,
+	.res_alloc = numtasks_res_alloc,
+	.res_free = numtasks_res_free,
+	.set_share_values = numtasks_set_share_values,
+	.get_share_values = numtasks_get_share_values,
+	.get_stats = numtasks_get_stats,
+	.show_config = numtasks_show_config,
+	.set_config = numtasks_set_config,
+	.change_resclass = numtasks_change_resclass,
+};
+
+int __init init_ckrm_numtasks_res(void)
+{
+	struct ckrm_classtype *clstype;
+	int resid = numtasks_rcbs.resid;
+
+	clstype = ckrm_find_classtype_by_name("taskclass");
+	if (clstype == NULL) {
+		printk(KERN_INFO " Unknown ckrm classtype<taskclass>");
+		return -ENOENT;
+	}
+
+	if (resid == -1) {
+		resid = ckrm_register_res_ctlr(clstype, &numtasks_rcbs);
+		printk("........init_ckrm_numtasks_res -> %d\n", resid);
+		if (resid != -1) {
+			ckrm_numtasks_register(numtasks_get_ref_local,
+					       numtasks_put_ref_local);
+			numtasks_rcbs.classtype = clstype;
+		}
+	}
+	return 0;
+}
+
+void __exit exit_ckrm_numtasks_res(void)
+{
+	if (numtasks_rcbs.resid != -1) {
+		ckrm_numtasks_register(NULL, NULL);
+	}
+	ckrm_unregister_res_ctlr(&numtasks_rcbs);
+	numtasks_rcbs.resid = -1;
+}
+
+module_init(init_ckrm_numtasks_res)
+module_exit(exit_ckrm_numtasks_res)
+
+MODULE_LICENSE("GPL");
Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks_stub.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks_stub.c	2005-06-20 13:08:34.000000000 -0700
@@ -0,0 +1,53 @@
+/* ckrm_tasks_stub.c - Stub file for ckrm_tasks modules
+ *
+ * Copyright (C) Chandra Seetharaman,  IBM Corp. 2004
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
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/ckrm_tsk.h>
+
+static spinlock_t stub_lock = SPIN_LOCK_UNLOCKED;
+
+static get_ref_t real_get_ref = NULL;
+static put_ref_t real_put_ref = NULL;
+
+void ckrm_numtasks_register(get_ref_t gr, put_ref_t pr)
+{
+	spin_lock(&stub_lock);
+	real_get_ref = gr;
+	real_put_ref = pr;
+	spin_unlock(&stub_lock);
+}
+
+int numtasks_get_ref(struct ckrm_core_class *arg, int force)
+{
+	int ret = 1;
+	spin_lock(&stub_lock);
+	if (real_get_ref) {
+		ret = (*real_get_ref) (arg, force);
+	}
+	spin_unlock(&stub_lock);
+	return ret;
+}
+
+void numtasks_put_ref(struct ckrm_core_class *arg)
+{
+	spin_lock(&stub_lock);
+	if (real_put_ref) {
+		(*real_put_ref) (arg);
+	}
+	spin_unlock(&stub_lock);
+}
+
+EXPORT_SYMBOL(ckrm_numtasks_register);
+EXPORT_SYMBOL(numtasks_get_ref);
+EXPORT_SYMBOL(numtasks_put_ref);
Index: linux-2.6.12-ckrm1/kernel/ckrm/Makefile
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/Makefile	2005-06-20 13:08:32.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/Makefile	2005-06-20 13:08:34.000000000 -0700
@@ -3,5 +3,6 @@
 #
 
 obj-y += ckrm_events.o ckrm.o ckrmutils.o
-obj-$(CONFIG_CKRM_TYPE_TASKCLASS) += ckrm_tc.o
+obj-$(CONFIG_CKRM_TYPE_TASKCLASS) += ckrm_tc.o ckrm_numtasks_stub.o
 obj-$(CONFIG_CKRM_TYPE_SOCKETCLASS) += ckrm_sockc.o
+obj-$(CONFIG_CKRM_RES_NUMTASKS) += ckrm_numtasks.o
Index: linux-2.6.12-ckrm1/kernel/fork.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/fork.c	2005-06-20 13:08:27.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/fork.c	2005-06-20 13:08:34.000000000 -0700
@@ -42,6 +42,8 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/ckrm_events.h>
+#include <linux/ckrm_tsk.h>
+#include <linux/ckrm_tc.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1211,6 +1213,9 @@ long do_fork(unsigned long clone_flags,
 			clone_flags |= CLONE_PTRACE;
 	}
 
+	if (numtasks_get_ref(&current->taskclass->core, 0) == 0) {
+		return -ENOMEM;
+	}
 	p = copy_process(clone_flags, stack_start, regs, stack_size, parent_tidptr, child_tidptr, pid);
 	/*
 	 * Do this prior waking up the new thread - the thread pointer
@@ -1250,6 +1255,7 @@ long do_fork(unsigned long clone_flags,
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
 		}
 	} else {
+		numtasks_put_ref(&current->taskclass->core);
 		free_pidmap(pid);
 		pid = PTR_ERR(p);
 	}

--
