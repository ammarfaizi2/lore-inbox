Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWDUCcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWDUCcu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWDUCby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:31:54 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:5606 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932134AbWDUC2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:28:42 -0400
From: maeda.naoaki@jp.fujitsu.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: maeda.naoaki@jp.fujitsu.com
Date: Fri, 21 Apr 2006 11:28:03 +0900
Message-Id: <20060421022803.13598.51949.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [RFC][PATCH 7/9] CPU controller - Adds routines to change share values and show stat
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

7/9: ckrm_cpu_shares_n_stats

Adds routine to change share values and show statistics.

Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>

 kernel/ckrm/ckrm_cpu.c |  123 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 123 insertions(+)

Index: linux-2.6.17-rc2/kernel/ckrm/ckrm_cpu.c
===================================================================
--- linux-2.6.17-rc2.orig/kernel/ckrm/ckrm_cpu.c
+++ linux-2.6.17-rc2/kernel/ckrm/ckrm_cpu.c
@@ -112,12 +112,135 @@ static void cpu_free_shares_struct(struc
 	kfree(res);
 }
 
+static int recalc_shares(int self_shares, int parent_shares, int parent_divisor)
+{
+	u64 numerator;
+
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
+	if (self_divisor == 0)
+		return 0;
+	numerator = (u64) self_unused_min_shares * self_cnt_min_shares;
+	do_div(numerator, self_divisor);
+	return numerator;
+}
+
+static void recalc_self(struct ckrm_cpu *res, struct ckrm_cpu *parres)
+{
+	struct ckrm_shares *par = &parres->shares;
+	struct ckrm_shares *self = &res->shares;
+	u64 cnt_total, cnt_min_shares;
+
+	/* calculate total and current min_shares */
+	cnt_total = recalc_shares(self->min_shares,
+					parres->cnt_total_min_shares,
+					par->child_shares_divisor);
+	cnt_min_shares = recalc_unused_shares(self->unused_min_shares,
+					cnt_total,
+					par->child_shares_divisor);
+	cpu_rc_set_share(&res->cpu_rc, (int) cnt_min_shares);
+	res->cnt_total_min_shares = (int) cnt_total;
+}
+
+static void
+recalc_and_propagate(struct ckrm_cpu * res)
+{
+	struct ckrm_class *child = NULL;
+	struct ckrm_cpu *parres, *childres;
+
+	parres = get_class_cpu(res->class->parent);
+
+	if (parres)
+		recalc_self(res, parres);
+
+	/* propagate to children */
+	spin_lock(&res->class->class_lock);
+	for_each_child(child, res->class) {
+		childres = get_class_cpu(child);
+		if (childres) {
+			spin_lock(&child->class_lock);
+			recalc_and_propagate(childres);
+			spin_unlock(&child->class_lock);
+		}
+	}
+	spin_unlock(&res->class->class_lock);
+	return;
+}
+
+static void cpu_shares_changed(struct ckrm_shares *my_res)
+{
+	struct ckrm_cpu *parres, *res;
+	struct ckrm_shares *cur, *par;
+	u64    temp = 0;
+
+	res = get_shares_cpu(my_res);
+	if (!res)
+		return;
+	cur = &res->shares;
+
+	if (!ckrm_is_class_root(res->class)) {
+		spin_lock(&res->class->parent->class_lock);
+		parres = get_class_cpu(res->class->parent);
+		par = &parres->shares;
+	} else {
+		par = NULL;
+		parres = NULL;
+	}
+
+	if (parres) {
+		/* adjust parent's unused min_shares */
+		temp = recalc_unused_shares(parres->cnt_total_min_shares,
+					par->unused_min_shares,
+					par->child_shares_divisor);
+		cpu_rc_set_share(&parres->cpu_rc, temp);
+	} else {
+		/* adjust root class's unused min_shares */
+		temp = recalc_unused_shares(CKRM_SHARE_DEFAULT_DIVISOR,
+					cur->unused_min_shares,
+					cur->child_shares_divisor);
+		cpu_rc_set_share(&res->cpu_rc, temp);
+	}
+	recalc_and_propagate(res);
+
+	if (!ckrm_is_class_root(res->class))
+		spin_unlock(&res->class->parent->class_lock);
+}
+
+static ssize_t cpu_show_stats(struct ckrm_shares *my_res, char *buf,
+							size_t buf_size)
+{
+	struct ckrm_cpu *res;
+	unsigned int load = 0;
+	ssize_t	i;
+
+	res = get_shares_cpu(my_res);
+	if (!res)
+		return -EINVAL;
+
+	load = cpu_rc_load(&res->cpu_rc);
+	i = snprintf(buf, buf_size, "%s:effective_min_shares=%d, load=%d\n",
+				res_ctlr_name, res->cpu_rc.share, load);
+	return i;
+}
+
 struct ckrm_controller cpu_ctlr = {
 	.name = res_ctlr_name,
 	.depth_supported = 3,
 	.ctlr_id = CKRM_NO_RES_ID,
 	.alloc_shares_struct = cpu_alloc_shares_struct,
 	.free_shares_struct = cpu_free_shares_struct,
+	.shares_changed = cpu_shares_changed,
+	.show_stats = cpu_show_stats,
 };
 
 int __init init_ckrm_cpu_res(void)
