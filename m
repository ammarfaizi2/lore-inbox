Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVFWHxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVFWHxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVFWHwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:52:22 -0400
Received: from [24.22.56.4] ([24.22.56.4]:8166 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262204AbVFWGSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:39 -0400
Message-Id: <20050623061759.325157000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:17 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 25/38] CKRM e18: Add fork rate control to the numtasks controller
Content-Disposition: inline; filename=ckrm-numtasks_forkrate
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add fork rate control to the numtasks controller.

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

---------------------------------------------------------------------

Index: linux-2.6.12-ckrm1/Documentation/ckrm/numtasks
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/Documentation/ckrm/numtasks	2005-06-20 15:04:51.000000000 -0700
@@ -0,0 +1,122 @@
+Introduction
+-------------
+
+Numtasks is a resource controller under the CKRM framework that allows the
+user/sysadmin to manage the number of tasks a class can create. It also allows
+one to limit the fork rate across the system.
+
+As with any other resource under the CKRM framework, numtasks also assigns
+all the resources to the detault class(/rcfs/taskclass). Since , the number
+of tasks in a system is not limited, this resource controller provides a
+way to set the total number of tasks available in the system through the config
+file. By default this value is 128k(131072). In other words, if not changed,
+the total number of tasks allowed in a system is 131072.
+
+The config variable that affect this is sys_total_tasks.
+
+This resource controller also allows the sysadmin to limit the number of forks
+that are allowed in the system within the specified number of seconds. This
+can be acheived by changing the attributes forkrate and forkrate_interval in
+the config file. Through this feature one can protect the system from being
+attacked by fork bomb type applications.
+
+Installation
+-------------
+
+1. Configure "Number of Tasks Resource Manager" under CKRM (see
+      Documentation/ckrm/installation). This can be configured as a module
+      also. But, when inserted as a module it cannot be removed.
+
+2. Reboot the system with the new kernel. Insert the module, if compiled
+      as a module.
+
+3. Verify that the memory controller is present by reading the file
+   /rcfs/taskclass/config (should show a line with res=numtasks)
+
+Usage
+-----
+
+For brevity, unless otherwise specified all the following commands are
+executed in the default class (/rcfs/taskclass).
+
+As explained above the config file shows sys_total_tasks and forkrate
+info.
+
+   # cd /rcfs/taskclass
+   # cat config
+   res=numtasks,sys_total_tasks=131072,forkrate=1000000,forkrate_interval=3600
+
+By default, the sys_total_tasks is set to 131072(128k), and forkrate is set
+to 1 million and forkrate_interval is set to 3600 seconds. Which means the
+total number of tasks in a system is limited to 131072 and the forks are
+limited to 1 million per hour.
+
+sysadmin can change these values by just writing the attribute/value pair
+to the config file.
+
+   # echo res=numtasks,forkrate=100,forkrate_interval=10 > config
+   # cat config
+   res=numtasks,sys_total_tasks=1000,forkrate=100,forkrate_interval=10
+
+   # echo res=numtasks,forkrate=100,forkrate_interval=10 > config
+   # cat config
+   res=numtasks,sys_total_tasks=1000,forkrate=100,forkrate_interval=10
+
+By making total_guarantee and max_limit to be same as sys_total_tasks,
+sysadmin can make the numbers in shares file be same as the number of tasks
+for a class.
+
+   # echo res=numtasks,total_guarantee=131072,max_limit=131072 > shares
+   # cat shares
+   res=numtasks,guarantee=-2,limit=-2,total_guarantee=131072,max_limit=131072
+
+
+Class creation
+--------------
+
+   # mkdir c1
+
+Its initial share is don't care. The parent's share values will be unchanged.
+
+Setting a new class share
+-------------------------
+
+'guarantee' specifies the number of tasks this class is entitled to get
+'limit' is the maximum number of tasks this class can get.
+
+Following command will set the guarantee of class c1 to be 25000 and the limit
+to be 50000
+
+   # echo 'res=numtasks,guarantee=25000,limit=50000' > c1/shares
+   # cat c1/shares
+   res=numtasks,guarantee=25000,limit=50000,total_guarantee=100,max_limit=100
+
+Limiting forks in a time period
+-------------------------------
+By default, this resource controller allows forking of 1 million tasks in
+an hour.
+
+Folowing command would change it to allow only 100 forks per 10 seconds
+
+   # echo res=numtasks,forkrate=100,forkrate_interval=10 > config
+   # cat config
+   res=numtasks,sys_total_tasks=1000,forkrate=100,forkrate_interval=10
+
+Note that the same set of values is used across the system. In other words,
+each individual class will be allowed 'forkrate' forks in 'forkrate_interval'
+seconds.
+
+Monitoring
+----------
+
+stats file shows statistics of the number of tasks usage of a class
+[root@localhost taskclass]# cat stats
+Number of tasks resource:
+Total Over limit failures: 0
+Total Over guarantee sucesses: 0
+Total Over guarantee failures: 0
+Maximum Over limit failures: 0
+Maximum Over guarantee sucesses: 0
+Maximum Over guarantee failures: 0
+cur_alloc 38; borrowed 0; cnt_guar 131072; cnt_limit 131072 cnt_unused 131072, unused_guarantee 100, cur_max_limit 0
+
Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm_numtasks.c	2005-06-20 15:04:50.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c	2005-06-20 15:04:51.000000000 -0700
@@ -36,6 +36,15 @@ static int total_cnt_alloc = 0;
 #define NUMTASKS_DEBUG
 #define NUMTASKS_NAME "numtasks"
 
+#define DEF_FORKRATE (1000000)		/* 1 million tasks */
+#define DEF_FORKRATE_INTERVAL (3600)    /* per hour */
+#define FORKRATE "forkrate"
+#define FORKRATE_INTERVAL "forkrate_interval"
+
+static int forkrate = DEF_FORKRATE;
+static int forkrate_interval = DEF_FORKRATE_INTERVAL;
+static struct ckrm_core_class *root_core;
+
 struct ckrm_numtasks {
 	struct ckrm_core_class *core;	/* the core i am part of... */
 	struct ckrm_core_class *parent;	/* parent of the core above. */
@@ -64,6 +73,10 @@ struct ckrm_numtasks {
 	int tot_limit_failures;
 	int tot_borrow_sucesses;
 	int tot_borrow_failures;
+
+	/* Fork rate fields */
+	int forks_in_period;
+	unsigned long period_start;
 };
 
 struct ckrm_res_ctlr numtasks_rcbs;
@@ -112,6 +125,7 @@ static int numtasks_get_ref_local(struct
 {
 	int rc, resid = numtasks_rcbs.resid, borrowed = 0;
 	struct ckrm_numtasks *res;
+	unsigned long now = jiffies, chg_at;
 
 	if ((resid < 0) || (core == NULL))
 		return 1;
@@ -182,8 +196,11 @@ static int numtasks_get_ref_local(struct
 
 	if (!rc)
 		atomic_dec(&res->cnt_cur_alloc);
-	else if (!borrowed)
+	else if (!borrowed) {
 		total_cnt_alloc++;
+		if (!force) /* force is not associated with a real fork. */
+			res->forks_in_period++;
+	}
 	return rc;
 }
 
@@ -233,6 +250,7 @@ static void *numtasks_res_alloc(struct c
  			res->cnt_guarantee = total_numtasks;
  			res->cnt_unused = total_numtasks;
  			res->cnt_limit = total_numtasks;
+			root_core = core; /* store the root core. */
 		}
 		try_module_get(THIS_MODULE);
 	} else {
@@ -432,29 +450,57 @@ static int numtasks_show_config(void *my
 
 	if (!res)
 		return -EINVAL;
-	seq_printf(sfile, "res=%s,%s=%d\n", NUMTASKS_NAME,
-		   SYS_TOTAL_TASKS, total_numtasks);
+	seq_printf(sfile, "res=%s,%s=%d,%s=%d,%s=%d\n", NUMTASKS_NAME,
+			SYS_TOTAL_TASKS, total_numtasks,
+			FORKRATE, forkrate,
+			FORKRATE_INTERVAL, forkrate_interval);
 	return 0;
 }
 
 enum numtasks_token_t {
 	numtasks_token_total,
+	numtasks_token_forkrate,
+	numtasks_token_interval,
 	numtasks_token_err
 };
 
 static match_table_t numtasks_tokens = {
 	{numtasks_token_total, SYS_TOTAL_TASKS "=%d"},
+	{numtasks_token_forkrate, FORKRATE "=%d"},
+	{numtasks_token_interval, FORKRATE_INTERVAL "=%d"},
 	{numtasks_token_err, NULL},
 };
 
+
+static void reset_forkrates(struct ckrm_core_class *parent, unsigned long now)
+{
+	struct ckrm_numtasks *parres;
+	struct ckrm_core_class *child = NULL;
+
+	parres = ckrm_get_res_class(parent, numtasks_rcbs.resid,
+				    struct ckrm_numtasks);
+	if (!parres) {
+		return;
+	}
+	parres->forks_in_period = 0;
+	parres->period_start = now;
+
+	ckrm_lock_hier(parent);
+	while ((child = ckrm_get_next_child(parent, child)) != NULL) {
+		reset_forkrates(child, now);
+	}
+	ckrm_unlock_hier(parent);
+}
+
 static int numtasks_set_config(void *my_res, const char *cfgstr)
 {
 	char *p;
 	struct ckrm_numtasks *res = my_res;
-	int new_total = 0;
+	int new_total, fr = 0, itvl = 0, err = 0;
 
 	if (!res)
 		return -EINVAL;
+
 	while ((p = strsep(&cfgstr, ",")) != NULL) {
 		substring_t args[MAX_OPT_ARGS];
 		int token;
@@ -464,26 +510,46 @@ static int numtasks_set_config(void *my_
 		token = match_token(p, numtasks_tokens, args);
 		switch (token) {
 		case numtasks_token_total:
-			if (match_int(args, &new_total))
-				return -EINVAL;
+			if (match_int(args, &new_total) ||
+						(new_total < total_cnt_alloc)) {
+				err = -EINVAL;
+			} else {
+				total_numtasks = new_total;
+				/*
+				 * res is the default class, as config is
+				 * present only in that directory.
+				 */
+				spin_lock(&res->cnt_lock);
+				res->cnt_guarantee = total_numtasks;
+				res->cnt_unused = total_numtasks;
+				res->cnt_limit = total_numtasks;
+				recalc_and_propagate(res, NULL);
+				spin_unlock(&res->cnt_lock);
+			}
+			break;
+		case numtasks_token_forkrate:
+			if (match_int(args, &fr) || (fr <= 0)) {
+				err = -EINVAL;
+			} else {
+				forkrate = fr;
+			}
+			break;
+		case numtasks_token_interval:
+			if (match_int(args, &itvl) || (itvl <= 0)) {
+				err = -EINVAL;
+			} else {
+				forkrate_interval = itvl;
+			}
 			break;
 		default:
-			return -EINVAL;
+			err = -EINVAL;
+			break;
 		}
 	}
-	if (new_total < total_cnt_alloc)
-		return -EINVAL;
-	total_numtasks = new_total;
 
-	/* res if the default class, as config is present only in
-	   that directory */
-	spin_lock(&res->cnt_lock);
-	res->cnt_guarantee = total_numtasks;
-	res->cnt_unused = total_numtasks;
-	res->cnt_limit = total_numtasks;
-	recalc_and_propagate(res, NULL);
-	spin_unlock(&res->cnt_lock);
-	return 0;
+	if ((fr > 0) || (itvl > 0))
+		reset_forkrates(root_core, jiffies);
+	return err;
 }
 
 static void numtasks_change_resclass(void *task, void *old, void *new)

--
