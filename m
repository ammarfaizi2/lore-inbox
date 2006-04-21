Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWDUCZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWDUCZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWDUCZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:25:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:45963 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751092AbWDUCZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:25:48 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:25:47 -0700
Message-Id: <20060421022547.6145.11460.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022519.6145.78248.sendpatchset@localhost.localdomain>
References: <20060421022519.6145.78248.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 5/6] numtasks - Add fork rate control support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

5/6: ckrm_numtasks_forkrate

Adds support to control the forkrate in the system.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 kernel/ckrm/ckrm_numtasks.c |   75 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+)

Index: linux2617-rc2/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm_numtasks.c
+++ linux2617-rc2/kernel/ckrm/ckrm_numtasks.c
@@ -27,6 +27,11 @@ static int total_numtasks __read_mostly 
 static struct ckrm_class *root_class;
 static int total_cnt_alloc = 0;
 
+#define DEF_FORKRATE UNLIMITED
+#define DEF_FORKRATE_INTERVAL (1)
+static int forkrate __read_mostly = DEF_FORKRATE;
+static int forkrate_interval __read_mostly = DEF_FORKRATE_INTERVAL;
+
 struct ckrm_numtasks {
 	struct ckrm_class *class;	/* the class i am part of... */
 	struct ckrm_shares shares;
@@ -41,6 +46,11 @@ struct ckrm_numtasks {
 	/* stats */
 	int successes;
 	int failures;
+	int forkrate_failures;
+
+	/* Fork rate fields */
+	int forks_in_period;
+	unsigned long period_start;
 };
 
 struct ckrm_controller numtasks_ctlr;
@@ -58,8 +68,24 @@ static struct ckrm_numtasks *get_class_n
 						&numtasks_ctlr));
 }
 
+static inline int check_forkrate(struct ckrm_numtasks *res)
+{
+	if (time_after(jiffies, res->period_start + forkrate_interval * HZ)) {
+		res->period_start = jiffies;
+		res->forks_in_period = 0;
+	}
+
+	if (res->forks_in_period >= forkrate) {
+ 		res->forkrate_failures++;
+		return -ENOSPC;
+	}
+	res->forks_in_period++;
+	return 0;
+}
+
 int numtasks_allow_fork(struct ckrm_class *class)
 {
+	int rc;
 	struct ckrm_numtasks *res;
 
 	/* controller is not registered; no class is given */
@@ -71,6 +97,11 @@ int numtasks_allow_fork(struct ckrm_clas
 	if (!res)
 		return 0;
 
+	/* Check forkrate before checking class's usage */
+	rc = check_forkrate(res);
+	if (rc)
+		return rc;
+
 	if (res->cnt_max_shares == CKRM_SHARE_DONT_CARE)
 		return 0;
 
@@ -146,6 +177,7 @@ static void numtasks_res_init_one(struct
 	numtasks_res->cnt_min_shares = CKRM_SHARE_DONT_CARE;
 	numtasks_res->cnt_unused = CKRM_SHARE_DONT_CARE;
 	numtasks_res->cnt_max_shares = CKRM_SHARE_DONT_CARE;
+	numtasks_res->period_start = jiffies;
 }
 
 static struct ckrm_shares *numtasks_alloc_shares_struct(
@@ -306,6 +338,9 @@ static ssize_t numtasks_show_stats(struc
 	buf += i; j += i; buf_size -= i;
 	i = snprintf(buf, buf_size, "%s: Number of failures %d\n",
 					res_ctlr_name, res->failures);
+	buf += i; j += i; buf_size -= i;
+	i = snprintf(buf, buf_size, "%s: Number of forkrate failures %d\n",
+					res_ctlr_name, res->forkrate_failures);
 	j += i;
 	return j;
 }
@@ -365,6 +400,46 @@ static int set_total_numtasks(const char
 module_param_set_call(total_numtasks, int, set_total_numtasks,
 			S_IRUGO | S_IWUSR);
 
+static void reset_forkrates(struct ckrm_class *class, unsigned long now)
+{
+	struct ckrm_numtasks *res;
+	struct ckrm_class *child = NULL;
+
+	res = get_class_numtasks(class);
+	if (!res)
+		return;
+	res->forks_in_period = 0;
+	res->period_start = now;
+
+	spin_lock(&class->class_lock);
+	for_each_child(child, class)
+		reset_forkrates(child, now);
+	spin_unlock(&class->class_lock);
+}
+
+static int set_forkrate(const char *val, struct kernel_param *kp)
+{
+	int prev = forkrate;
+	int rc = set_numtasks_config_val(&forkrate, prev, val, kp);
+	if (rc < 0)
+		return rc;
+	reset_forkrates(root_class, jiffies);
+	return 0;
+}
+module_param_set_call(forkrate, int, set_forkrate, S_IRUGO | S_IWUSR);
+
+static int set_forkrate_interval(const char *val, struct kernel_param *kp)
+{
+	int prev = forkrate_interval;
+	int rc = set_numtasks_config_val(&forkrate_interval, prev, val, kp);
+	if (rc < 0)
+		return rc;
+	reset_forkrates(root_class, jiffies);
+	return 0;
+}
+module_param_set_call(forkrate_interval, int, set_forkrate_interval,
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
