Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWD1Bgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWD1Bgb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWD1BgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:36:02 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:60827 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030248AbWD1Bfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:35:48 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:35:46 -0700
Message-Id: <20060428013546.27212.79472.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013518.27212.954.sendpatchset@localhost.localdomain>
References: <20060428013518.27212.954.sendpatchset@localhost.localdomain>
Subject: [PATCH 5/6] numtasks - Add fork rate control support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

5/6: numtasks_forkrate

Adds support to control the forkrate in the system.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 numtasks.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+)

Index: linux-2617-rc3/kernel/res_group/numtasks.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/numtasks.c	2006-04-27 10:18:50.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/numtasks.c	2006-04-27 10:18:51.000000000 -0700
@@ -27,6 +27,11 @@ static int total_numtasks __read_mostly 
 static struct resource_group *root_rgroup;
 static int total_cnt_alloc = 0;
 
+#define DEF_FORKRATE UNLIMITED
+#define DEF_FORKRATE_INTERVAL (1)
+static int forkrate __read_mostly = DEF_FORKRATE;
+static int forkrate_interval __read_mostly = DEF_FORKRATE_INTERVAL;
+
 struct numtasks {
 	struct resource_group *rgroup;/* resource group i am part of... */
 	struct res_shares shares;
@@ -41,6 +46,11 @@ struct numtasks {
 	/* stats */
 	int successes;
 	int failures;
+	int forkrate_failures;
+
+	/* Fork rate fields */
+	int forks_in_period;
+	unsigned long period_start;
 };
 
 struct res_controller numtasks_ctlr;
@@ -58,8 +68,24 @@ static struct numtasks *get_numtasks(str
 						&numtasks_ctlr));
 }
 
+static inline int check_forkrate(struct numtasks *res)
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
 int numtasks_allow_fork(struct resource_group *rgroup)
 {
+	int rc;
 	struct numtasks *res;
 
 	/* controller is not registered; no resource group is given */
@@ -71,6 +97,11 @@ int numtasks_allow_fork(struct resource_
 	if (!res)
 		return 0;
 
+	/* Check forkrate before checking resource group's usage */
+	rc = check_forkrate(res);
+	if (rc)
+		return rc;
+
 	if (res->cnt_max_shares == SHARE_DONT_CARE)
 		return 0;
 
@@ -146,6 +177,7 @@ static void numtasks_res_init_one(struct
 	numtasks_res->cnt_min_shares = SHARE_DONT_CARE;
 	numtasks_res->cnt_unused = SHARE_DONT_CARE;
 	numtasks_res->cnt_max_shares = SHARE_DONT_CARE;
+	numtasks_res->period_start = jiffies;
 }
 
 static struct res_shares *numtasks_alloc_shares_struct(
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
 
+static void reset_forkrates(struct resource_group *rgroup, unsigned long now)
+{
+	struct numtasks *res;
+	struct resource_group *child = NULL;
+
+	res = get_numtasks(rgroup);
+	if (!res)
+		return;
+	res->forks_in_period = 0;
+	res->period_start = now;
+
+	spin_lock(&rgroup->group_lock);
+	for_each_child(child, rgroup)
+		reset_forkrates(child, now);
+	spin_unlock(&rgroup->group_lock);
+}
+
+static int set_forkrate(const char *val, struct kernel_param *kp)
+{
+	int prev = forkrate;
+	int rc = set_numtasks_config_val(&forkrate, prev, val, kp);
+	if (rc < 0)
+		return rc;
+	reset_forkrates(root_rgroup, jiffies);
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
+	reset_forkrates(root_rgroup, jiffies);
+	return 0;
+}
+module_param_set_call(forkrate_interval, int, set_forkrate_interval,
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
