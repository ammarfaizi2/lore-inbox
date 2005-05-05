Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVEETc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVEETc6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVEETcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:32:53 -0400
Received: from c-24-22-18-178.hsd1.or.comcast.net ([24.22.18.178]:49297 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262192AbVEES3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:29:19 -0400
Message-Id: <20050505180932.845564000@us.ibm.com>
References: <20050505180731.010896000@us.ibm.com>
Date: Thu, 05 May 2005 11:07:44 -0700
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: [patch 13/21] CKRM: Minor cosmetic cleanups in numtasks controller
From: gh@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
Content-Disposition: inline; filename=07c-numtasks_cleanup


Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

Simple code cleanup. No functional changes.

 ckrm_numtasks.c |   98 +++++++++++++++++---------------------------------------
 1 files changed, 30 insertions(+), 68 deletions(-)

Index: linux-2.6.12-rc3-ckrm5/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- linux-2.6.12-rc3-ckrm5.orig/kernel/ckrm/ckrm_numtasks.c	2005-05-05 09:36:29.000000000 -0700
+++ linux-2.6.12-rc3-ckrm5/kernel/ckrm/ckrm_numtasks.c	2005-05-05 09:37:41.000000000 -0700
@@ -99,17 +99,6 @@ static void numtasks_res_initcls_one(str
 	return;
 }
 
-#if 0
-static void numtasks_res_initcls(void *my_res)
-{
-	struct ckrm_numtasks *res = my_res;
-
-	/* Write a version which propagates values all the way down
-	   and replace rcbs callback with that version */
-
-}
-#endif
-
 static int numtasks_get_ref_local(struct ckrm_core_class *core, int force)
 {
 	int rc, resid = numtasks_rcbs.resid;
@@ -144,29 +133,24 @@ static int numtasks_get_ref_local(struct
 				res->borrow_failures++;
 				res->tot_borrow_failures++;
 			}
-		} else {
+		} else
 			rc = force;
-		}
 	} else if (res->over_guarantee) {
 		res->over_guarantee = 0;
 
-		if (res->max_limit_failures < res->limit_failures) {
+		if (res->max_limit_failures < res->limit_failures)
 			res->max_limit_failures = res->limit_failures;
-		}
-		if (res->max_borrow_sucesses < res->borrow_sucesses) {
+		if (res->max_borrow_sucesses < res->borrow_sucesses)
 			res->max_borrow_sucesses = res->borrow_sucesses;
-		}
-		if (res->max_borrow_failures < res->borrow_failures) {
+		if (res->max_borrow_failures < res->borrow_failures)
 			res->max_borrow_failures = res->borrow_failures;
-		}
 		res->limit_failures = 0;
 		res->borrow_sucesses = 0;
 		res->borrow_failures = 0;
 	}
 
-	if (!rc) {
+	if (!rc)
 		atomic_dec(&res->cnt_cur_alloc);
-	}
 	return rc;
 }
 
@@ -175,18 +159,12 @@ static void numtasks_put_ref_local(struc
 	int resid = numtasks_rcbs.resid;
 	struct ckrm_numtasks *res;
 
-	if ((resid == -1) || (core == NULL)) {
+	if ((resid == -1) || (core == NULL))
 		return;
-	}
 
 	res = ckrm_get_res_class(core, resid, struct ckrm_numtasks);
 	if (res == NULL)
 		return;
-	if (unlikely(atomic_read(&res->cnt_cur_alloc) == 0)) {
-		printk(KERN_WARNING "numtasks_put_ref: Trying to decrement "
-					"counter below 0\n");
-		return;
-	}
 	atomic_dec(&res->cnt_cur_alloc);
 	if (atomic_read(&res->cnt_borrowed) > 0) {
 		atomic_dec(&res->cnt_borrowed);
@@ -242,19 +220,10 @@ static void numtasks_res_free(void *my_r
 
 	parres = ckrm_get_res_class(res->parent, resid, struct ckrm_numtasks);
 
-	if (unlikely(atomic_read(&res->cnt_cur_alloc) < 0)) {
-		printk(KERN_WARNING "numtasks_res: counter below 0\n");
-	}
-	if (unlikely(atomic_read(&res->cnt_cur_alloc) > 0 ||
-				atomic_read(&res->cnt_borrowed) > 0)) {
-		printk(KERN_WARNING "numtasks_res_free: resource still "
-		       "alloc'd %p\n", res);
-		if ((borrowed = atomic_read(&res->cnt_borrowed)) > 0) {
-			for (i = 0; i < borrowed; i++) {
-				numtasks_put_ref_local(parres->core);
-			}
-		}
-	}
+	if ((borrowed = atomic_read(&res->cnt_borrowed)) > 0)
+		for (i = 0; i < borrowed; i++)
+			numtasks_put_ref_local(parres->core);
+
 	/* return child's limit/guarantee to parent node */
 	spin_lock(&parres->cnt_lock);
 	child_guarantee_changed(&parres->shares, res->shares.my_guarantee, 0);
@@ -264,14 +233,12 @@ static void numtasks_res_free(void *my_r
 	maxlimit = 0;
 	while ((child = ckrm_get_next_child(parres->core, child)) != NULL) {
 		childres = ckrm_get_res_class(child, resid, struct ckrm_numtasks);
-		if (maxlimit < childres->shares.my_limit) {
+		if (maxlimit < childres->shares.my_limit)
 			maxlimit = childres->shares.my_limit;
-		}
 	}
 	ckrm_unlock_hier(parres->core);
-	if (parres->shares.cur_max_limit < maxlimit) {
+	if (parres->shares.cur_max_limit < maxlimit)
 		parres->shares.cur_max_limit = maxlimit;
-	}
 
 	spin_unlock(&parres->cnt_lock);
 	kfree(res);
@@ -297,39 +264,37 @@ recalc_and_propagate(struct ckrm_numtask
 
 		/* calculate cnt_guarantee and cnt_limit */
 		if ((parres->cnt_guarantee == CKRM_SHARE_DONTCARE) ||
-				(self->my_guarantee == CKRM_SHARE_DONTCARE)) {
+				(self->my_guarantee == CKRM_SHARE_DONTCARE))
 			res->cnt_guarantee = CKRM_SHARE_DONTCARE;
-		} else if (par->total_guarantee) {
+		else if (par->total_guarantee) {
 			u64 temp = (u64) self->my_guarantee * parres->cnt_guarantee;
 			do_div(temp, par->total_guarantee);
 			res->cnt_guarantee = (int) temp;
-		} else {
+		} else
 			res->cnt_guarantee = 0;
-		}
 
 		if ((parres->cnt_limit == CKRM_SHARE_DONTCARE) ||
-				(self->my_limit == CKRM_SHARE_DONTCARE)) {
+				(self->my_limit == CKRM_SHARE_DONTCARE))
 			res->cnt_limit = CKRM_SHARE_DONTCARE;
-		} else if (par->max_limit) {
+		else if (par->max_limit) {
 			u64 temp = (u64) self->my_limit * parres->cnt_limit;
 			do_div(temp, par->max_limit);
 			res->cnt_limit = (int) temp;
-		} else {
+		} else
 			res->cnt_limit = 0;
-		}
 
 		/* Calculate unused units */
 		if ((res->cnt_guarantee == CKRM_SHARE_DONTCARE) ||
-				(self->my_guarantee == CKRM_SHARE_DONTCARE)) {
+				(self->my_guarantee == CKRM_SHARE_DONTCARE))
 			res->cnt_unused = CKRM_SHARE_DONTCARE;
-		} else if (self->total_guarantee) {
+		else if (self->total_guarantee) {
 			u64 temp = (u64) self->unused_guarantee * res->cnt_guarantee;
 			do_div(temp, self->total_guarantee);
 			res->cnt_unused = (int) temp;
-		} else {
+		} else
 			res->cnt_unused = 0;
-		}
 	}
+
 	/* propagate to children */
 	ckrm_lock_hier(res->core);
 	while ((child = ckrm_get_next_child(res->core, child)) != NULL) {
@@ -368,21 +333,19 @@ static int numtasks_set_share_values(voi
 
 	if ((rc == 0) && parres) {
 		/* Calculate parent's unused units */
-		if (parres->cnt_guarantee == CKRM_SHARE_DONTCARE) {
+		if (parres->cnt_guarantee == CKRM_SHARE_DONTCARE)
 			parres->cnt_unused = CKRM_SHARE_DONTCARE;
-		} else if (par->total_guarantee) {
+		else if (par->total_guarantee) {
 			u64 temp = (u64) par->unused_guarantee * parres->cnt_guarantee;
 			do_div(temp, par->total_guarantee);
 			parres->cnt_unused = (int) temp;
-		} else {
+		} else
 			parres->cnt_unused = 0;
-		}
 		recalc_and_propagate(res, parres);
 	}
 	spin_unlock(&res->cnt_lock);
-	if (res->parent) {
+	if (res->parent)
 		spin_unlock(&parres->cnt_lock);
-	}
 	return rc;
 }
 
@@ -403,7 +366,7 @@ static int numtasks_get_stats(void *my_r
 	if (!res)
 		return -EINVAL;
 
-	seq_printf(sfile, "Number of tasks resource:\n");
+	seq_printf(sfile, "---------Number of tasks stats start---------\n");
 	seq_printf(sfile, "Total Over limit failures: %d\n",
 		   res->tot_limit_failures);
 	seq_printf(sfile, "Total Over guarantee sucesses: %d\n",
@@ -417,6 +380,7 @@ static int numtasks_get_stats(void *my_r
 		   res->max_borrow_sucesses);
 	seq_printf(sfile, "Maximum Over guarantee failures: %d\n",
 		   res->max_borrow_failures);
+	seq_printf(sfile, "---------Number of tasks stats end---------\n");
 #ifdef NUMTASKS_DEBUG
 	seq_printf(sfile,
 		   "cur_alloc %d; borrowed %d; cnt_guar %d; cnt_limit %d "
@@ -468,9 +432,8 @@ static void numtasks_change_resclass(voi
 		}
 		numtasks_put_ref_local(oldres->core);
 	}
-	if (newres) {
+	if (newres)
 		(void)numtasks_get_ref_local(newres->core, 1);
-	}
 }
 
 struct ckrm_res_ctlr numtasks_rcbs = {
@@ -512,9 +475,8 @@ int __init init_ckrm_numtasks_res(void)
 
 void __exit exit_ckrm_numtasks_res(void)
 {
-	if (numtasks_rcbs.resid != -1) {
+	if (numtasks_rcbs.resid != -1)
 		ckrm_numtasks_register(NULL, NULL);
-	}
 	ckrm_unregister_res_ctlr(&numtasks_rcbs);
 	numtasks_rcbs.resid = -1;
 }

--

