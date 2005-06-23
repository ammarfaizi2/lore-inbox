Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVFWGmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVFWGmM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVFWGiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:38:17 -0400
Received: from [24.22.56.4] ([24.22.56.4]:16614 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262286AbVFWGSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:48 -0400
Message-Id: <20050623061759.058601000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:16 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 24/38] CKRM e18: Add numtasks controller config file write support
Content-Disposition: inline; filename=ckrm-numtasks_config
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add numtasks controller config file write support

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

---------------------------------------------------------------------

Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm_numtasks.c	2005-06-20 15:02:49.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c	2005-06-20 15:04:50.000000000 -0700
@@ -22,11 +22,17 @@
 #include <asm/div64.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/parser.h>
 #include <linux/ckrm_rc.h>
 #include <linux/ckrm_tc.h>
 #include <linux/ckrm_tsk.h>
 
-#define TOTAL_NUM_TASKS (131072)	/* 128 K */
+#define DEF_TOTAL_NUM_TASKS (131072)	/* 128 K */
+static int total_numtasks = DEF_TOTAL_NUM_TASKS;
+static int total_cnt_alloc = 0;
+
+#define SYS_TOTAL_TASKS "sys_total_tasks"
+
 #define NUMTASKS_DEBUG
 #define NUMTASKS_NAME "numtasks"
 
@@ -94,6 +100,9 @@ static void numtasks_res_initcls_one(str
 	res->tot_borrow_sucesses = 0;
 	res->tot_borrow_failures = 0;
 
+	res->forks_in_period = 0;
+	res->period_start = jiffies;
+
 	atomic_set(&res->cnt_cur_alloc, 0);
 	atomic_set(&res->cnt_borrowed, 0);
 	return;
@@ -101,7 +110,7 @@ static void numtasks_res_initcls_one(str
 
 static int numtasks_get_ref_local(struct ckrm_core_class *core, int force)
 {
-	int rc, resid = numtasks_rcbs.resid;
+	int rc, resid = numtasks_rcbs.resid, borrowed = 0;
 	struct ckrm_numtasks *res;
 
 	if ((resid < 0) || (core == NULL))
@@ -111,6 +120,27 @@ static int numtasks_get_ref_local(struct
 	if (res == NULL)
 		return 1;
 
+	/*
+	 * force is not associated with fork. So, if force is specified
+	 * we don't have to bother about forkrate.
+	 */
+	if (!force) {
+		/* Take care of wraparound situation */
+		chg_at = res->period_start + forkrate_interval * HZ;
+		if (chg_at < res->period_start) {
+			chg_at += forkrate_interval * HZ;
+			now += forkrate_interval * HZ;
+		}
+		if (chg_at <= now) {
+			res->period_start = now;
+			res->forks_in_period = 0;
+		}
+
+		if (res->forks_in_period >= forkrate) {
+			return 0;
+		}
+	}
+
 	atomic_inc(&res->cnt_cur_alloc);
 
 	rc = 1;
@@ -129,6 +159,7 @@ static int numtasks_get_ref_local(struct
 				res->borrow_sucesses++;
 				res->tot_borrow_sucesses++;
 				res->over_guarantee = 1;
+				borrowed++;
 			} else {
 				res->borrow_failures++;
 				res->tot_borrow_failures++;
@@ -151,6 +182,8 @@ static int numtasks_get_ref_local(struct
 
 	if (!rc)
 		atomic_dec(&res->cnt_cur_alloc);
+	else if (!borrowed)
+		total_cnt_alloc++;
 	return rc;
 }
 
@@ -172,7 +205,10 @@ static void numtasks_put_ref_local(struc
 	if (atomic_read(&res->cnt_borrowed) > 0) {
 		atomic_dec(&res->cnt_borrowed);
 		numtasks_put_ref_local(res->parent);
+	} else {
+		total_cnt_alloc--;
 	}
+
 	return;
 }
 
@@ -194,9 +230,9 @@ static void *numtasks_res_alloc(struct c
 			 * I am part of root class. So set the max tasks
 			 * to available default.
 			 */
-			res->cnt_guarantee = TOTAL_NUM_TASKS;
-			res->cnt_unused = TOTAL_NUM_TASKS;
-			res->cnt_limit = TOTAL_NUM_TASKS;
+ 			res->cnt_guarantee = total_numtasks;
+ 			res->cnt_unused = total_numtasks;
+ 			res->cnt_limit = total_numtasks;
 		}
 		try_module_get(THIS_MODULE);
 	} else {
@@ -336,15 +372,7 @@ static int numtasks_set_share_values(voi
 
 	if ((rc == 0) && parres) {
 		/* Calculate parent's unused units */
-		if (parres->cnt_guarantee == CKRM_SHARE_DONTCARE)
-			parres->cnt_unused = CKRM_SHARE_DONTCARE;
-		else if (par->total_guarantee) {
-			u64 temp = (u64) par->unused_guarantee * parres->cnt_guarantee;
-			do_div(temp, par->total_guarantee);
-			parres->cnt_unused = (int) temp;
-		} else
-			parres->cnt_unused = 0;
-		recalc_and_propagate(res, parres);
+		recalc_and_propagate(parres, NULL);
 	}
 	spin_unlock(&res->cnt_lock);
 	if (res->parent)
@@ -404,18 +432,57 @@ static int numtasks_show_config(void *my
 
 	if (!res)
 		return -EINVAL;
-
-	seq_printf(sfile, "res=%s,parameter=somevalue\n", NUMTASKS_NAME);
+	seq_printf(sfile, "res=%s,%s=%d\n", NUMTASKS_NAME,
+		   SYS_TOTAL_TASKS, total_numtasks);
 	return 0;
 }
 
+enum numtasks_token_t {
+	numtasks_token_total,
+	numtasks_token_err
+};
+
+static match_table_t numtasks_tokens = {
+	{numtasks_token_total, SYS_TOTAL_TASKS "=%d"},
+	{numtasks_token_err, NULL},
+};
+
 static int numtasks_set_config(void *my_res, const char *cfgstr)
 {
+	char *p;
 	struct ckrm_numtasks *res = my_res;
+	int new_total = 0;
 
 	if (!res)
 		return -EINVAL;
-	printk("numtasks config='%s'\n", cfgstr);
+	while ((p = strsep(&cfgstr, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+		if (!*p)
+			continue;
+
+		token = match_token(p, numtasks_tokens, args);
+		switch (token) {
+		case numtasks_token_total:
+			if (match_int(args, &new_total))
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	if (new_total < total_cnt_alloc)
+		return -EINVAL;
+	total_numtasks = new_total;
+
+	/* res if the default class, as config is present only in
+	   that directory */
+	spin_lock(&res->cnt_lock);
+	res->cnt_guarantee = total_numtasks;
+	res->cnt_unused = total_numtasks;
+	res->cnt_limit = total_numtasks;
+	recalc_and_propagate(res, NULL);
+	spin_unlock(&res->cnt_lock);
 	return 0;
 }
 

--
