Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVFWH1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVFWH1A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVFWHZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:25:47 -0400
Received: from [24.22.56.4] ([24.22.56.4]:13286 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262263AbVFWGSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:42 -0400
Message-Id: <20050623061801.276853000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:27 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 35/38] CKRM e18: Fix a NULL dereference bug
Content-Disposition: inline; filename=ckrm-numtasks_lockfix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a NULL dereference bug by checking before locking.

Parent shares recalculation fix.

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm_numtasks.c	2005-06-20 15:59:12.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c	2005-06-20 16:01:24.000000000 -0700
@@ -303,6 +303,7 @@ static void numtasks_res_free(void *my_r
 	return;
 }
 
+
 /*
  * Recalculate the guarantee and limit in real units... and propagate the
  * same to children.
@@ -357,9 +358,13 @@ recalc_and_propagate(struct ckrm_numtask
 	while ((child = ckrm_get_next_child(res->core, child)) != NULL) {
 		childres = ckrm_get_res_class(child, resid, struct ckrm_numtasks);
 
-		spin_lock(&childres->cnt_lock);
-		recalc_and_propagate(childres, res);
-		spin_unlock(&childres->cnt_lock);
+		if (childres) {
+		    spin_lock(&childres->cnt_lock);
+		    recalc_and_propagate(childres, res);
+		    spin_unlock(&childres->cnt_lock);
+		} else {
+			printk(KERN_ERR "%s: numtasks resclass missing\n",__FUNCTION__);
+		}
 	}
 	ckrm_unlock_hier(res->core);
 	return;
@@ -376,7 +381,7 @@ static int numtasks_set_share_values(voi
 
 	if (res->parent) {
 		parres =
-		    ckrm_get_res_class(res->parent, resid, struct ckrm_numtasks);
+		   ckrm_get_res_class(res->parent, resid, struct ckrm_numtasks);
 		spin_lock(&parres->cnt_lock);
 		spin_lock(&res->cnt_lock);
 		par = &parres->shares;
@@ -390,7 +395,16 @@ static int numtasks_set_share_values(voi
 
 	if ((rc == 0) && parres) {
 		/* Calculate parent's unused units */
-		recalc_and_propagate(parres, NULL);
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
 	}
 	spin_unlock(&res->cnt_lock);
 	if (res->parent)

--
