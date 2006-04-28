Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWD1Bfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWD1Bfn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWD1Bfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:35:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:31448 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030247AbWD1Bfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:35:37 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:35:35 -0700
Message-Id: <20060428013535.27212.49684.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013518.27212.954.sendpatchset@localhost.localdomain>
References: <20060428013518.27212.954.sendpatchset@localhost.localdomain>
Subject: [PATCH 3/6] numtasks - Add shares and stats support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3/6: numtasks_shares_n_stats

Sets interface to be called from core when a resource group's shares are
changes or when stats are requested.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 numtasks.c |  134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 134 insertions(+)

Index: linux-2617-rc3/kernel/res_group/numtasks.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/numtasks.c	2006-04-27 10:18:50.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/numtasks.c	2006-04-27 10:18:50.000000000 -0700
@@ -130,6 +130,10 @@ static void numtasks_res_init_one(struct
 	numtasks_res->shares.max_shares = SHARE_DONT_CARE;
 	numtasks_res->shares.child_shares_divisor = SHARE_DEFAULT_DIVISOR;
 	numtasks_res->shares.unused_min_shares = SHARE_DEFAULT_DIVISOR;
+
+	numtasks_res->cnt_min_shares = SHARE_DONT_CARE;
+	numtasks_res->cnt_unused = SHARE_DONT_CARE;
+	numtasks_res->cnt_max_shares = SHARE_DONT_CARE;
 }
 
 static struct res_shares *numtasks_alloc_shares_struct(
@@ -164,6 +168,134 @@ static void numtasks_free_shares_struct(
 	kfree(res);
 }
 
+static int recalc_shares(int self_shares, int parent_shares, int parent_divisor)
+{
+	u64 numerator;
+
+	if ((self_shares == SHARE_DONT_CARE) ||
+				(parent_shares == SHARE_DONT_CARE))
+		return SHARE_DONT_CARE;
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
+	if (self_cnt_min_shares == SHARE_DONT_CARE)
+		return SHARE_DONT_CARE;
+	if (self_divisor == 0)
+		return 0;
+	numerator = (u64) self_unused_min_shares * self_cnt_min_shares;
+	do_div(numerator, self_divisor);
+	return numerator;
+}
+
+static void recalc_self(struct numtasks *res,
+				struct numtasks *parres)
+{
+	struct res_shares *par = &parres->shares;
+	struct res_shares *self = &res->shares;
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
+ * Called with parent's (resource group to which parres belongs) lock held.
+ */
+static void recalc_and_propagate(struct numtasks *res,
+				struct numtasks *parres)
+{
+	struct resource_group *child = NULL;
+	struct numtasks *childres;
+
+	if (parres)
+		recalc_self(res, parres);
+
+	/* propagate to children */
+	spin_lock(&res->rgroup->group_lock);
+	for_each_child(child, res->rgroup) {
+		childres = get_numtasks(child);
+		BUG_ON(!childres);
+		spin_lock(&child->group_lock);
+		recalc_and_propagate(childres, res);
+		spin_unlock(&child->group_lock);
+	}
+	spin_unlock(&res->rgroup->group_lock);
+}
+
+static void numtasks_shares_changed(struct res_shares *my_res)
+{
+	struct numtasks *parres, *res;
+	struct res_shares *cur, *par;
+
+	res = get_shares_numtasks(my_res);
+	if (!res)
+		return;
+	cur = &res->shares;
+
+	if (!is_res_group_root(res->rgroup)) {
+		spin_lock(&res->rgroup->parent->group_lock);
+		parres = get_numtasks(res->rgroup->parent);
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
+	if (!is_res_group_root(res->rgroup))
+		spin_unlock(&res->rgroup->parent->group_lock);
+}
+
+static ssize_t numtasks_show_stats(struct res_shares *my_res,
+					char *buf, size_t buf_size)
+{
+	ssize_t i, j = 0;
+	struct numtasks *res;
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
 struct res_controller numtasks_ctlr = {
 	.name = res_ctlr_name,
 	.depth_supported = 3,
@@ -171,6 +303,8 @@ struct res_controller numtasks_ctlr = {
 	.alloc_shares_struct = numtasks_alloc_shares_struct,
 	.free_shares_struct = numtasks_free_shares_struct,
 	.move_task = numtasks_move_task,
+	.shares_changed = numtasks_shares_changed,
+	.show_stats = numtasks_show_stats,
 };
 
 int __init init_numtasks_res(void)

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
