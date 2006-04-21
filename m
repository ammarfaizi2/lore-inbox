Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWDUC0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWDUC0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWDUCZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:25:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:1963 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751018AbWDUCZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:25:43 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:25:42 -0700
Message-Id: <20060421022542.6145.77968.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022519.6145.78248.sendpatchset@localhost.localdomain>
References: <20060421022519.6145.78248.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 4/6] numtasks - Add configuration support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4/6: ckrm_numtasks_config

Use module parameters to dynamically set the total numtasks and maximum
forkrate allowed
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 include/linux/moduleparam.h |   12 ++++++--
 kernel/ckrm/ckrm_numtasks.c |   64 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 70 insertions(+), 6 deletions(-)

Index: linux2617-rc2/include/linux/moduleparam.h
===================================================================
--- linux2617-rc2.orig/include/linux/moduleparam.h
+++ linux2617-rc2/include/linux/moduleparam.h
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
 
Index: linux2617-rc2/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm_numtasks.c
+++ linux2617-rc2/kernel/ckrm/ckrm_numtasks.c
@@ -20,6 +20,13 @@
 
 static const char res_ctlr_name[] = "numtasks";
 
+#define UNLIMITED INT_MAX
+#define DEF_TOTAL_NUM_TASKS UNLIMITED
+static int total_numtasks __read_mostly = DEF_TOTAL_NUM_TASKS;
+
+static struct ckrm_class *root_class;
+static int total_cnt_alloc = 0;
+
 struct ckrm_numtasks {
 	struct ckrm_class *class;	/* the class i am part of... */
 	struct ckrm_shares shares;
@@ -81,6 +88,7 @@ static void inc_usage_count(struct ckrm_
 	atomic_inc(&res->cnt_cur_alloc);
 
 	if (ckrm_is_class_root(res->class)) {
+		total_cnt_alloc++;
 		res->successes++;
 		return;
 	}
@@ -89,8 +97,10 @@ static void inc_usage_count(struct ckrm_
 			(atomic_read(&res->cnt_cur_alloc) > res->cnt_unused)) {
 		inc_usage_count(get_class_numtasks(res->class->parent));
 		atomic_inc(&res->cnt_borrowed);
-	} else
-		res->successes++;
+	} else {
+		total_cnt_alloc++;
+  		res->successes++;
+	}
 }
 
 static void dec_usage_count(struct ckrm_numtasks *res)
@@ -101,7 +111,9 @@ static void dec_usage_count(struct ckrm_
 	if (atomic_read(&res->cnt_borrowed) > 0) {
 		atomic_dec(&res->cnt_borrowed);
 		dec_usage_count(get_class_numtasks(res->class->parent));
-	}
+	} else
+		total_cnt_alloc--;
+
 }
 
 static void numtasks_move_task(struct task_struct *task,
@@ -146,6 +158,8 @@ static struct ckrm_shares *numtasks_allo
 		return NULL;
 	res->class = class;
 	numtasks_res_init_one(res);
+	if (ckrm_is_class_root(class))
+		root_class = class; /* store the root class. */
 	return &res->shares;
 }
 
@@ -307,6 +321,50 @@ struct ckrm_controller numtasks_ctlr = {
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
+	struct ckrm_numtasks *shares = NULL;
+
+	if (!root_class)
+		return 0;
+	if (rc < 0)
+		return rc;
+	if (total_numtasks <= total_cnt_alloc) {
+		total_numtasks = prev;
+		return -EINVAL;
+	}
+	shares = get_class_numtasks(root_class);
+	spin_lock(&root_class->class_lock);
+	shares->cnt_min_shares = total_numtasks;
+	shares->cnt_unused = total_numtasks;
+	shares->cnt_max_shares = total_numtasks;
+	recalc_and_propagate(shares, NULL);
+	spin_unlock(&root_class->class_lock);
+	return 0;
+}
+module_param_set_call(total_numtasks, int, set_total_numtasks,
+			S_IRUGO | S_IWUSR);
+
 int __init init_ckrm_numtasks_res(void)
 {
 	if (numtasks_ctlr.ctlr_id != CKRM_NO_RES_ID)

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
