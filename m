Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWDUC0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWDUC0I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWDUCZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:25:54 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:36573 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751079AbWDUCZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:25:37 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:25:36 -0700
Message-Id: <20060421022536.6145.63317.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022519.6145.78248.sendpatchset@localhost.localdomain>
References: <20060421022519.6145.78248.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 3/6] numtasks - Add shares and stats support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3/6: ckrm_numtasks_shares_n_stats

Sets interface to be called from core when a class's shares are
changes or when stats are requested.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 kernel/ckrm/ckrm_numtasks.c |  134 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 134 insertions(+)

Index: linux2617-rc2/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm_numtasks.c
+++ linux2617-rc2/kernel/ckrm/ckrm_numtasks.c
@@ -130,6 +130,10 @@ static void numtasks_res_init_one(struct
 	numtasks_res->shares.max_shares = CKRM_SHARE_DONT_CARE;
 	numtasks_res->shares.child_shares_divisor = CKRM_SHARE_DEFAULT_DIVISOR;
 	numtasks_res->shares.unused_min_shares = CKRM_SHARE_DEFAULT_DIVISOR;
+
+	numtasks_res->cnt_min_shares = CKRM_SHARE_DONT_CARE;
+	numtasks_res->cnt_unused = CKRM_SHARE_DONT_CARE;
+	numtasks_res->cnt_max_shares = CKRM_SHARE_DONT_CARE;
 }
 
 static struct ckrm_shares *numtasks_alloc_shares_struct(
@@ -164,6 +168,134 @@ static void numtasks_free_shares_struct(
 	kfree(res);
 }
 
+static int recalc_shares(int self_shares, int parent_shares, int parent_divisor)
+{
+	u64 numerator;
+
+	if ((self_shares == CKRM_SHARE_DONT_CARE) ||
+				(parent_shares == CKRM_SHARE_DONT_CARE))
+		return CKRM_SHARE_DONT_CARE;
+	if (parent_divisor == 0)
+		return 0;
+	numerator = (u64) self_shares * parent_shares;
+	do_div(numerator, parent_divisor);
+	return numerator;
+}
+
+static int recalc_unused_shares(int self_cnt_min_shares,
+				int self_unused_min_shares, int self_divisor)
+{
+	u64 numerator;
+
+	if (self_cnt_min_shares == CKRM_SHARE_DONT_CARE)
+		return CKRM_SHARE_DONT_CARE;
+	if (self_divisor == 0)
+		return 0;
+	numerator = (u64) self_unused_min_shares * self_cnt_min_shares;
+	do_div(numerator, self_divisor);
+	return numerator;
+}
+
+static void recalc_self(struct ckrm_numtasks *res,
+				struct ckrm_numtasks *parres)
+{
+	struct ckrm_shares *par = &parres->shares;
+	struct ckrm_shares *self = &res->shares;
+
+	res->cnt_min_shares = recalc_shares(self->min_shares,
+						parres->cnt_min_shares,
+						par->child_shares_divisor);
+	res->cnt_max_shares = recalc_shares(self->max_shares,
+						parres->cnt_max_shares,
+						par->child_shares_divisor);
+
+	/*
+	 * Now that we know the new cnt_min/cnt_max boundaries we can update
+	 * the unused quantity.
+	 */
+	res->cnt_unused = recalc_unused_shares(res->cnt_min_shares,
+						self->unused_min_shares,
+						self->child_shares_divisor);
+}
+
+
+/*
+ * Recalculate the min_shares and max_shares in real units and propagate the
+ * same to children.
+ * Called with parent's (class to which parres belongs) lock held.
+ */
+static void recalc_and_propagate(struct ckrm_numtasks *res,
+				struct ckrm_numtasks *parres)
+{
+	struct ckrm_class *child = NULL;
+	struct ckrm_numtasks *childres;
+
+	if (parres)
+		recalc_self(res, parres);
+
+	/* propagate to children */
+	spin_lock(&res->class->class_lock);
+	for_each_child(child, res->class) {
+		childres = get_class_numtasks(child);
+		BUG_ON(!childres);
+		spin_lock(&child->class_lock);
+		recalc_and_propagate(childres, res);
+		spin_unlock(&child->class_lock);
+	}
+	spin_unlock(&res->class->class_lock);
+}
+
+static void numtasks_shares_changed(struct ckrm_shares *my_res)
+{
+	struct ckrm_numtasks *parres, *res;
+	struct ckrm_shares *cur, *par;
+
+	res = get_shares_numtasks(my_res);
+	if (!res)
+		return;
+	cur = &res->shares;
+
+	if (!ckrm_is_class_root(res->class)) {
+		spin_lock(&res->class->parent->class_lock);
+		parres = get_class_numtasks(res->class->parent);
+		par = &parres->shares;
+	} else {
+		parres = NULL;
+		par = NULL;
+	}
+	if (parres)
+		parres->cnt_unused = recalc_unused_shares(
+						parres->cnt_min_shares,
+						par->unused_min_shares,
+						par->child_shares_divisor);
+	recalc_and_propagate(res, parres);
+	if (!ckrm_is_class_root(res->class))
+		spin_unlock(&res->class->parent->class_lock);
+}
+
+static ssize_t numtasks_show_stats(struct ckrm_shares *my_res,
+					char *buf, size_t buf_size)
+{
+	ssize_t i, j = 0;
+	struct ckrm_numtasks *res;
+
+	res = get_shares_numtasks(my_res);
+	if (!res)
+		return -EINVAL;
+
+	i = snprintf(buf, buf_size, "%s: Current usage %d\n",
+					res_ctlr_name,
+					atomic_read(&res->cnt_cur_alloc));
+	buf += i; j += i; buf_size -= i;
+	i = snprintf(buf, buf_size, "%s: Number of successes %d\n",
+					res_ctlr_name, res->successes);
+	buf += i; j += i; buf_size -= i;
+	i = snprintf(buf, buf_size, "%s: Number of failures %d\n",
+					res_ctlr_name, res->failures);
+	j += i;
+	return j;
+}
+
 struct ckrm_controller numtasks_ctlr = {
 	.name = res_ctlr_name,
 	.depth_supported = 3,
@@ -171,6 +303,8 @@ struct ckrm_controller numtasks_ctlr = {
 	.alloc_shares_struct = numtasks_alloc_shares_struct,
 	.free_shares_struct = numtasks_free_shares_struct,
 	.move_task = numtasks_move_task,
+	.shares_changed = numtasks_shares_changed,
+	.show_stats = numtasks_show_stats,
 };
 
 int __init init_ckrm_numtasks_res(void)

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
