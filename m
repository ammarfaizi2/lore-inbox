Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWD1Bfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWD1Bfu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWD1Bfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:35:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:26846 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030250AbWD1Bfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:35:31 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:35:29 -0700
Message-Id: <20060428013529.27212.46309.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013518.27212.954.sendpatchset@localhost.localdomain>
References: <20060428013518.27212.954.sendpatchset@localhost.localdomain>
Subject: [PATCH 2/6] numtasks - Add task control support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2/6: numtasks_tasksupport

Adds task management support by defining a function to be called from
fork() to see if the resource group is within its share allocation
Sets interface to be called from core when a task is moved to a resource
group.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>

 include/linux/numtasks.h    |   28 +++++++++++
 kernel/fork.c               |    7 ++
 kernel/res_group/numtasks.c |  104 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 137 insertions(+), 2 deletions(-)

Index: linux-2617-rc3/include/linux/numtasks.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/include/linux/numtasks.h	2006-04-27 10:18:50.000000000 -0700
@@ -0,0 +1,28 @@
+/* numtasks.h - No. of tasks resource controller for Resource Groups
+ *
+ * Copyright (C) Chandra Seetharaman, IBM Corp. 2003, 2004, 2005
+ *
+ * Provides No. of tasks resource controller for Resource Groups
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#ifndef _LINUX_NUMTASKS_H
+#define _LINUX_NUMTASKS_H
+
+#ifdef CONFIG_RES_GROUPS_NUMTASKS
+#include <linux/res_group_rc.h>
+
+extern int numtasks_allow_fork(struct resource_group *);
+
+#else /* CONFIG_RES_GROUPS_NUMTASKS */
+
+#define numtasks_allow_fork(rgroup) (0)
+
+#endif /* CONFIG_RES_GROUPS_NUMTASKS */
+#endif /* _LINUX_NUMTASKS_H */
Index: linux-2617-rc3/kernel/res_group/numtasks.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/numtasks.c	2006-04-27 10:18:49.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/numtasks.c	2006-04-27 10:18:50.000000000 -0700
@@ -21,7 +21,19 @@
 static const char res_ctlr_name[] = "numtasks";
 
 struct numtasks {
+	struct resource_group *rgroup;/* resource group i am part of... */
 	struct res_shares shares;
+	int cnt_min_shares;	/* num_tasks min_shares in local units */
+	int cnt_unused;		/* has to borrow if more than this is needed */
+	int cnt_max_shares;	/* no tasks over this limit. */
+				/* Three above cnt_* fields are protected
+				 * by resource group's group_lock */
+	atomic_t cnt_cur_alloc;	/* current alloc from self */
+	atomic_t cnt_borrowed;	/* borrowed from the parent */
+
+	/* stats */
+	int successes;
+	int failures;
 };
 
 struct res_controller numtasks_ctlr;
@@ -33,6 +45,84 @@ static struct numtasks *get_shares_numta
 	return NULL;
 }
 
+static struct numtasks *get_numtasks(struct resource_group *rgroup)
+{
+	return get_shares_numtasks(get_controller_shares(rgroup,
+						&numtasks_ctlr));
+}
+
+int numtasks_allow_fork(struct resource_group *rgroup)
+{
+	struct numtasks *res;
+
+	/* controller is not registered; no resource group is given */
+	if ((numtasks_ctlr.ctlr_id == NO_RES_ID) || (rgroup == NULL))
+		return 0;
+	res = get_numtasks(rgroup);
+
+	/* numtasks not available for this resource group */
+	if (!res)
+		return 0;
+
+	if (res->cnt_max_shares == SHARE_DONT_CARE)
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
+static void inc_usage_count(struct numtasks *res)
+{
+	atomic_inc(&res->cnt_cur_alloc);
+
+	if (is_res_group_root(res->rgroup)) {
+		res->successes++;
+		return;
+	}
+	/* Do we need to borrow from our parent ? */
+	if ((res->cnt_unused == SHARE_DONT_CARE) ||
+			(atomic_read(&res->cnt_cur_alloc) > res->cnt_unused)) {
+		inc_usage_count(get_numtasks(res->rgroup->parent));
+		atomic_inc(&res->cnt_borrowed);
+	} else
+		res->successes++;
+}
+
+static void dec_usage_count(struct numtasks *res)
+{
+	if (atomic_read(&res->cnt_cur_alloc) == 0)
+		return;
+	atomic_dec(&res->cnt_cur_alloc);
+	if (atomic_read(&res->cnt_borrowed) > 0) {
+		atomic_dec(&res->cnt_borrowed);
+		dec_usage_count(get_numtasks(res->rgroup->parent));
+	}
+}
+
+static void numtasks_move_task(struct task_struct *task,
+		struct res_shares *old, struct res_shares *new)
+{
+	struct numtasks *oldres, *newres;
+
+	if (old == new)
+		return;
+
+	/* Decrement usage count of old resource group */
+	oldres = get_shares_numtasks(old);
+	if (oldres)
+		dec_usage_count(oldres);
+
+	/* Increment usage count of new resource group */
+	newres = get_shares_numtasks(new);
+	if (newres)
+		inc_usage_count(newres);
+}
+
 /* Initialize share struct values */
 static void numtasks_res_init_one(struct numtasks *numtasks_res)
 {
@@ -50,6 +140,7 @@ static struct res_shares *numtasks_alloc
 	res = kzalloc(sizeof(struct numtasks), GFP_KERNEL);
 	if (!res)
 		return NULL;
+	res->rgroup = rgroup;
 	numtasks_res_init_one(res);
 	return &res->shares;
 }
@@ -60,7 +151,17 @@ static struct res_shares *numtasks_alloc
  */
 static void numtasks_free_shares_struct(struct res_shares *my_res)
 {
-	kfree(get_shares_numtasks(my_res));
+	struct numtasks *res, *parres;
+	int i, borrowed;
+
+	res = get_shares_numtasks(my_res);
+	if (!is_res_group_root(res->rgroup)) {
+		parres = get_numtasks(res->rgroup->parent);
+		borrowed = atomic_read(&res->cnt_borrowed);
+		for (i = 0; i < borrowed; i++)
+			dec_usage_count(parres);
+	}
+	kfree(res);
 }
 
 struct res_controller numtasks_ctlr = {
@@ -69,6 +170,7 @@ struct res_controller numtasks_ctlr = {
 	.ctlr_id = NO_RES_ID,
 	.alloc_shares_struct = numtasks_alloc_shares_struct,
 	.free_shares_struct = numtasks_free_shares_struct,
+	.move_task = numtasks_move_task,
 };
 
 int __init init_numtasks_res(void)
Index: linux-2617-rc3/kernel/fork.c
===================================================================
--- linux-2617-rc3.orig/kernel/fork.c	2006-04-27 10:14:38.000000000 -0700
+++ linux-2617-rc3/kernel/fork.c	2006-04-27 10:18:50.000000000 -0700
@@ -45,6 +45,7 @@
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
 #include <linux/res_group.h>
+#include <linux/numtasks.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1311,7 +1312,7 @@ long do_fork(unsigned long clone_flags,
 	      int __user *child_tidptr)
 {
 	struct task_struct *p;
-	int trace = 0;
+	int trace = 0, rc;
 	struct pid *pid = alloc_pid();
 	long nr;
 
@@ -1324,6 +1325,10 @@ long do_fork(unsigned long clone_flags,
 			clone_flags |= CLONE_PTRACE;
 	}
 
+	rc = numtasks_allow_fork(current->res_group);
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
