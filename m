Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWD1Bgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWD1Bgb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWD1BgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:36:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:40664 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030251AbWD1Bfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:35:42 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:35:41 -0700
Message-Id: <20060428013541.27212.37346.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013518.27212.954.sendpatchset@localhost.localdomain>
References: <20060428013518.27212.954.sendpatchset@localhost.localdomain>
Subject: [PATCH 4/6] numtasks - Add configuration support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4/6: numtasks_config

Use module parameters to dynamically set the total numtasks and maximum
forkrate allowed
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 include/linux/moduleparam.h |   12 ++++++--
 kernel/res_group/numtasks.c |   64 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 70 insertions(+), 6 deletions(-)

Index: linux-2617-rc3/include/linux/moduleparam.h
===================================================================
--- linux-2617-rc3.orig/include/linux/moduleparam.h	2006-04-27 10:14:36.000000000 -0700
+++ linux-2617-rc3/include/linux/moduleparam.h	2006-04-27 10:18:50.000000000 -0700
@@ -75,11 +75,17 @@ struct kparam_array
 /* Helper functions: type is byte, short, ushort, int, uint, long,
    ulong, charp, bool or invbool, or XXX if you define param_get_XXX,
    param_set_XXX and param_check_XXX. */
-#define module_param_named(name, value, type, perm)			   \
-	param_check_##type(name, &(value));				   \
-	module_param_call(name, param_set_##type, param_get_##type, &value, perm); \
+#define module_param_named_call(name, value, type, set, perm)		\
+	param_check_##type(name, &(value));				\
+	module_param_call(name, set, param_get_##type, &(value), perm); \
 	__MODULE_PARM_TYPE(name, #type)
 
+#define module_param_named(name, value, type, perm)			   \
+	module_param_named_call(name, value, type, param_set_##type, perm)
+
+#define module_param_set_call(name, type, setfn, perm) \
+	module_param_named_call(name, name, type, setfn, perm)
+
 #define module_param(name, type, perm)				\
 	module_param_named(name, name, type, perm)
 
Index: linux-2617-rc3/kernel/res_group/numtasks.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/numtasks.c	2006-04-27 10:18:50.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/numtasks.c	2006-04-27 10:18:50.000000000 -0700
@@ -20,6 +20,13 @@
 
 static const char res_ctlr_name[] = "numtasks";
 
+#define UNLIMITED INT_MAX
+#define DEF_TOTAL_NUM_TASKS UNLIMITED
+static int total_numtasks __read_mostly = DEF_TOTAL_NUM_TASKS;
+
+static struct resource_group *root_rgroup;
+static int total_cnt_alloc = 0;
+
 struct numtasks {
 	struct resource_group *rgroup;/* resource group i am part of... */
 	struct res_shares shares;
@@ -81,6 +88,7 @@ static void inc_usage_count(struct numta
 	atomic_inc(&res->cnt_cur_alloc);
 
 	if (is_res_group_root(res->rgroup)) {
+		total_cnt_alloc++;
 		res->successes++;
 		return;
 	}
@@ -89,8 +97,10 @@ static void inc_usage_count(struct numta
 			(atomic_read(&res->cnt_cur_alloc) > res->cnt_unused)) {
 		inc_usage_count(get_numtasks(res->rgroup->parent));
 		atomic_inc(&res->cnt_borrowed);
-	} else
-		res->successes++;
+	} else {
+		total_cnt_alloc++;
+  		res->successes++;
+	}
 }
 
 static void dec_usage_count(struct numtasks *res)
@@ -101,7 +111,9 @@ static void dec_usage_count(struct numta
 	if (atomic_read(&res->cnt_borrowed) > 0) {
 		atomic_dec(&res->cnt_borrowed);
 		dec_usage_count(get_numtasks(res->rgroup->parent));
-	}
+	} else
+		total_cnt_alloc--;
+
 }
 
 static void numtasks_move_task(struct task_struct *task,
@@ -146,6 +158,8 @@ static struct res_shares *numtasks_alloc
 		return NULL;
 	res->rgroup = rgroup;
 	numtasks_res_init_one(res);
+	if (is_res_group_root(rgroup))
+		root_rgroup = rgroup; /* store root's resource group. */
 	return &res->shares;
 }
 
@@ -307,6 +321,50 @@ struct res_controller numtasks_ctlr = {
 	.show_stats = numtasks_show_stats,
 };
 
+/*
+ * Writeable module parameters use these set_<parameter> functions to respond
+ * to changes. Otherwise the values can be read and used any time.
+ */
+static int set_numtasks_config_val(int *var, int old_value, const char *val,
+				struct kernel_param *kp)
+{
+	int rc = param_set_int(val, kp);
+
+	if (rc < 0)
+		return rc;
+	if (*var < 1) {
+		*var = old_value;
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int set_total_numtasks(const char *val, struct kernel_param *kp)
+{
+	int prev = total_numtasks;
+	int rc = set_numtasks_config_val(&total_numtasks, prev, val, kp);
+	struct numtasks *res = NULL;
+
+	if (!root_rgroup)
+		return 0;
+	if (rc < 0)
+		return rc;
+	if (total_numtasks <= total_cnt_alloc) {
+		total_numtasks = prev;
+		return -EINVAL;
+	}
+	res = get_numtasks(root_rgroup);
+	spin_lock(&root_rgroup->group_lock);
+	res->cnt_min_shares = total_numtasks;
+	res->cnt_unused = total_numtasks;
+	res->cnt_max_shares = total_numtasks;
+	recalc_and_propagate(res, NULL);
+	spin_unlock(&root_rgroup->group_lock);
+	return 0;
+}
+module_param_set_call(total_numtasks, int, set_total_numtasks,
+			S_IRUGO | S_IWUSR);
+
 int __init init_numtasks_res(void)
 {
 	if (numtasks_ctlr.ctlr_id != NO_RES_ID)

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
