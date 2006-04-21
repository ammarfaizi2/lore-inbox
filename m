Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWDUC0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWDUC0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWDUCZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:25:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:8587 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751069AbWDUCZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:25:32 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:25:30 -0700
Message-Id: <20060421022530.6145.22499.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022519.6145.78248.sendpatchset@localhost.localdomain>
References: <20060421022519.6145.78248.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 2/6] numtasks - Add task control support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2/6: ckrm_numtasks_tasksupport

Adds task management support by defining a function to be called from
fork() to see if the class is within its share allocation
Sets interface to be called from core when a class is moved to a class.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>

 include/linux/ckrm_tsk.h    |   28 +++++++++++
 kernel/ckrm/ckrm_numtasks.c |  104 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/fork.c               |    7 ++
 3 files changed, 137 insertions(+), 2 deletions(-)

Index: linux2617-rc2/include/linux/ckrm_tsk.h
===================================================================
--- /dev/null
+++ linux2617-rc2/include/linux/ckrm_tsk.h
@@ -0,0 +1,28 @@
+/* ckrm_tsk.h - No. of tasks resource controller for CKRM
+ *
+ * Copyright (C) Chandra Seetharaman, IBM Corp. 2003, 2004, 2005
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
+#ifndef _LINUX_CKRM_TSK_H
+#define _LINUX_CKRM_TSK_H
+
+#ifdef CONFIG_CKRM_RES_NUMTASKS
+#include <linux/ckrm_rc.h>
+
+extern int numtasks_allow_fork(struct ckrm_class *);
+
+#else /* CONFIG_CKRM_RES_NUMTASKS */
+
+#define numtasks_allow_fork(class) (0)
+
+#endif /* CONFIG_CKRM_RES_NUMTASKS */
+#endif /* _LINUX_CKRM_RES_H */
Index: linux2617-rc2/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm_numtasks.c
+++ linux2617-rc2/kernel/ckrm/ckrm_numtasks.c
@@ -21,7 +21,19 @@
 static const char res_ctlr_name[] = "numtasks";
 
 struct ckrm_numtasks {
+	struct ckrm_class *class;	/* the class i am part of... */
 	struct ckrm_shares shares;
+	int cnt_min_shares;	/* num_tasks min_shares in local units */
+	int cnt_unused;		/* has to borrow if more than this is needed */
+	int cnt_max_shares;	/* no tasks over this limit. */
+				/* Three above cnt_* fields are protected
+				 * by class's class_lock */
+	atomic_t cnt_cur_alloc;	/* current alloc from self */
+	atomic_t cnt_borrowed;	/* borrowed from the parent */
+
+	/* stats */
+	int successes;
+	int failures;
 };
 
 struct ckrm_controller numtasks_ctlr;
@@ -33,6 +45,84 @@ static struct ckrm_numtasks *get_shares_
 	return NULL;
 }
 
+static struct ckrm_numtasks *get_class_numtasks(struct ckrm_class *class)
+{
+	return get_shares_numtasks(ckrm_get_controller_shares(class,
+						&numtasks_ctlr));
+}
+
+int numtasks_allow_fork(struct ckrm_class *class)
+{
+	struct ckrm_numtasks *res;
+
+	/* controller is not registered; no class is given */
+	if ((numtasks_ctlr.ctlr_id == CKRM_NO_RES_ID) || (class == NULL))
+		return 0;
+	res = get_class_numtasks(class);
+
+	/* numtasks not available for this class */
+	if (!res)
+		return 0;
+
+	if (res->cnt_max_shares == CKRM_SHARE_DONT_CARE)
+		return 0;
+
+	/* Over the limit ? */
+	if (atomic_read(&res->cnt_cur_alloc) >= res->cnt_max_shares) {
+		res->failures++;
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
+static void inc_usage_count(struct ckrm_numtasks *res)
+{
+	atomic_inc(&res->cnt_cur_alloc);
+
+	if (ckrm_is_class_root(res->class)) {
+		res->successes++;
+		return;
+	}
+	/* Do we need to borrow from our parent ? */
+	if ((res->cnt_unused == CKRM_SHARE_DONT_CARE) ||
+			(atomic_read(&res->cnt_cur_alloc) > res->cnt_unused)) {
+		inc_usage_count(get_class_numtasks(res->class->parent));
+		atomic_inc(&res->cnt_borrowed);
+	} else
+		res->successes++;
+}
+
+static void dec_usage_count(struct ckrm_numtasks *res)
+{
+	if (atomic_read(&res->cnt_cur_alloc) == 0)
+		return;
+	atomic_dec(&res->cnt_cur_alloc);
+	if (atomic_read(&res->cnt_borrowed) > 0) {
+		atomic_dec(&res->cnt_borrowed);
+		dec_usage_count(get_class_numtasks(res->class->parent));
+	}
+}
+
+static void numtasks_move_task(struct task_struct *task,
+		struct ckrm_shares *old, struct ckrm_shares *new)
+{
+	struct ckrm_numtasks *oldres, *newres;
+
+	if (old == new)
+		return;
+
+	/* Decrement usage count of old class */
+	oldres = get_shares_numtasks(old);
+	if (oldres)
+		dec_usage_count(oldres);
+
+	/* Increment usage count of new class */
+	newres = get_shares_numtasks(new);
+	if (newres)
+		inc_usage_count(newres);
+}
+
 /* Initialize share struct values */
 static void numtasks_res_init_one(struct ckrm_numtasks *numtasks_res)
 {
@@ -50,6 +140,7 @@ static struct ckrm_shares *numtasks_allo
 	res = kzalloc(sizeof(struct ckrm_numtasks), GFP_KERNEL);
 	if (!res)
 		return NULL;
+	res->class = class;
 	numtasks_res_init_one(res);
 	return &res->shares;
 }
@@ -60,7 +151,17 @@ static struct ckrm_shares *numtasks_allo
  */
 static void numtasks_free_shares_struct(struct ckrm_shares *my_res)
 {
-	kfree(get_shares_numtasks(my_res));
+	struct ckrm_numtasks *res, *parres;
+	int i, borrowed;
+
+	res = get_shares_numtasks(my_res);
+	if (!ckrm_is_class_root(res->class)) {
+		parres = get_class_numtasks(res->class->parent);
+		borrowed = atomic_read(&res->cnt_borrowed);
+		for (i = 0; i < borrowed; i++)
+			dec_usage_count(parres);
+	}
+	kfree(res);
 }
 
 struct ckrm_controller numtasks_ctlr = {
@@ -69,6 +170,7 @@ struct ckrm_controller numtasks_ctlr = {
 	.ctlr_id = CKRM_NO_RES_ID,
 	.alloc_shares_struct = numtasks_alloc_shares_struct,
 	.free_shares_struct = numtasks_free_shares_struct,
+	.move_task = numtasks_move_task,
 };
 
 int __init init_ckrm_numtasks_res(void)
Index: linux2617-rc2/kernel/fork.c
===================================================================
--- linux2617-rc2.orig/kernel/fork.c
+++ linux2617-rc2/kernel/fork.c
@@ -45,6 +45,7 @@
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
 #include <linux/ckrm.h>
+#include <linux/ckrm_tsk.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1310,7 +1311,7 @@ long do_fork(unsigned long clone_flags,
 	      int __user *child_tidptr)
 {
 	struct task_struct *p;
-	int trace = 0;
+	int trace = 0, rc;
 	struct pid *pid = alloc_pid();
 	long nr;
 
@@ -1323,6 +1324,10 @@ long do_fork(unsigned long clone_flags,
 			clone_flags |= CLONE_PTRACE;
 	}
 
+	rc = numtasks_allow_fork(current->class);
+	if (rc)
+		return rc;
+
 	p = copy_process(clone_flags, stack_start, regs, stack_size, parent_tidptr, child_tidptr, nr);
 	/*
 	 * Do this prior waking up the new thread - the thread pointer

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
