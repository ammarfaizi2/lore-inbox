Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWD1Bj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWD1Bj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWD1Bjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:39:48 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:22964 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030264AbWD1Bj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:39:26 -0400
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Date: Fri, 28 Apr 2006 10:38:06 +0900
Message-Id: <20060428013806.9582.46781.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [PATCH 7/9] CPU controller - Add routines to change share values and show stat
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

7/9: cpu_shares_n_stats

Adds routine to change share values and show statistics.

Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>

 kernel/res_group/cpu.c |  120 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 120 insertions(+)

Index: linux-2.6.17-rc3/kernel/res_group/cpu.c
===================================================================
--- linux-2.6.17-rc3.orig/kernel/res_group/cpu.c
+++ linux-2.6.17-rc3/kernel/res_group/cpu.c
@@ -113,12 +113,132 @@ static void cpu_free_shares_struct(struc
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
+static void recalc_self(struct cpu_res *res, struct cpu_res *parres)
+{
+	struct res_shares *par = &parres->shares;
+	struct res_shares *self = &res->shares;
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
+recalc_and_propagate(struct cpu_res *res)
+{
+	struct resource_group *child = NULL;
+	struct cpu_res *parres, *childres;
+
+	parres = get_res_group_cpu(res->rgroup->parent);
+
+	if (parres)
+		recalc_self(res, parres);
+
+	/* propagate to children */
+	spin_lock(&res->rgroup->group_lock);
+	for_each_child(child, res->rgroup) {
+		childres = get_res_group_cpu(child);
+		if (childres)
+			recalc_and_propagate(childres);
+	}
+	spin_unlock(&res->rgroup->group_lock);
+	return;
+}
+
+static void cpu_shares_changed(struct res_shares *my_res)
+{
+	struct cpu_res *parres, *res;
+	struct res_shares *cur, *par;
+	u64    temp = 0;
+
+	res = get_shares_cpu(my_res);
+	if (!res)
+		return;
+	cur = &res->shares;
+
+	if (!is_res_group_root(res->rgroup)) {
+		spin_lock(&res->rgroup->parent->group_lock);
+		parres = get_res_group_cpu(res->rgroup->parent);
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
+		/* adjust root resouce group's unused min_shares */
+		temp = recalc_unused_shares(SHARE_DEFAULT_DIVISOR,
+					cur->unused_min_shares,
+					cur->child_shares_divisor);
+		cpu_rc_set_share(&res->cpu_rc, temp);
+	}
+	recalc_and_propagate(res);
+
+	if (!is_res_group_root(res->rgroup))
+		spin_unlock(&res->rgroup->parent->group_lock);
+}
+
+static ssize_t cpu_show_stats(struct res_shares *my_res, char *buf,
+							size_t buf_size)
+{
+	struct cpu_res *res;
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
 struct res_controller cpu_ctlr = {
 	.name = res_ctlr_name,
 	.depth_supported = 3,
 	.ctlr_id = NO_RES_ID,
 	.alloc_shares_struct = cpu_alloc_shares_struct,
 	.free_shares_struct = cpu_free_shares_struct,
+	.shares_changed = cpu_shares_changed,
+	.show_stats = cpu_show_stats,
 };
 
 int __init init_cpu_res(void)
