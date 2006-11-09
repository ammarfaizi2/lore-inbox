Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWKITgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWKITgs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWKITgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:36:35 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:40839 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1030426AbWKITgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:36:33 -0500
From: Balbir Singh <balbir@in.ibm.com>
To: Linux MM <linux-mm@kvack.org>
Cc: dev@openvz.org, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       haveblue@us.ibm.com, rohitseth@google.com,
       Balbir Singh <balbir@in.ibm.com>
Date: Fri, 10 Nov 2006 01:06:19 +0530
Message-Id: <20061109193619.21437.84173.sendpatchset@balbir.in.ibm.com>
In-Reply-To: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
Subject: [RFC][PATCH 6/8] RSS controller shares allocation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Support shares assignment and propagation.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 kernel/res_group/memctlr.c |   59 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff -puN kernel/res_group/memctlr.c~container-memctlr-shares kernel/res_group/memctlr.c
--- linux-2.6.19-rc2/kernel/res_group/memctlr.c~container-memctlr-shares	2006-11-09 22:20:28.000000000 +0530
+++ linux-2.6.19-rc2-balbir/kernel/res_group/memctlr.c	2006-11-09 22:20:28.000000000 +0530
@@ -32,6 +32,7 @@
 #include <linux/res_group_rc.h>
 #include <linux/memctlr.h>
 #include <linux/mm.h>
+#include <linux/swap.h>
 #include <asm/pgtable.h>
 
 static const char res_ctlr_name[] = "memctlr";
@@ -55,6 +56,7 @@ struct memctlr {
 	int failures;
 	int magic;
 	spinlock_t lock;
+	long nr_pages;
 };
 
 struct res_controller memctlr_rg;
@@ -180,6 +182,7 @@ static void memctlr_init_new(struct memc
 	res->shares.unused_min_shares = SHARE_DEFAULT_DIVISOR;
 
 	memctlr_init_mem_counter(&res->counter);
+	res->nr_pages = SHARE_DONT_CARE;
 	spin_lock_init(&res->lock);
 }
 
@@ -196,6 +199,7 @@ static struct res_shares *memctlr_alloc_
 	if (is_res_group_root(rgroup)) {
 		root_rgroup = rgroup;
 		memctlr_root = res;
+		res->nr_pages = nr_free_pages();
 		printk("Memory Controller version %s\n", version);
 	}
 	return &res->shares;
@@ -346,6 +350,11 @@ static ssize_t memctlr_show_stats(struct
 	len -= i;
 	j += i;
 
+	i = snprintf(buf, len, "Max Allowed Pages %ld\n", res->nr_pages);
+
+	buf += i;
+	len -= i;
+	j += i;
 	return j;
 }
 
@@ -406,13 +415,61 @@ static void memctlr_move_task(struct tas
 	double_res_unlock(oldres, newres);
 }
 
+static void recalc_and_propagate(struct memctlr *res, struct memctlr *parres)
+{
+	struct resource_group *child = NULL;
+	int child_divisor;
+	u64 numerator;
+	struct memctlr *child_res;
+
+	if (parres) {
+		if (res->shares.max_shares == SHARE_DONT_CARE ||
+			parres->shares.max_shares == SHARE_DONT_CARE)
+			return;
+
+		child_divisor = parres->shares.child_shares_divisor;
+		if (child_divisor == 0)
+			return;
+
+		numerator = (u64)(parres->shares.unused_min_shares *
+				res->shares.max_shares);
+		do_div(numerator, child_divisor);
+		numerator = (u64)(parres->nr_pages * numerator);
+		do_div(numerator, SHARE_DEFAULT_DIVISOR);
+		res->nr_pages = numerator;
+	}
+
+	for_each_child(child, res->rgroup) {
+		child_res = get_memctlr(child);
+		BUG_ON(!child_res);
+		recalc_and_propagate(child_res, res);
+	}
+
+}
+
+static void memctlr_shares_changed(struct res_shares *shares)
+{
+	struct memctlr *res, *parres;
+
+	res = get_memctlr_from_shares(shares);
+	if (!res)
+		return;
+
+	if (is_res_group_root(res->rgroup))
+		parres = NULL;
+	else
+		parres = get_memctlr((struct container *)res->rgroup->parent);
+
+	recalc_and_propagate(res, parres);
+}
+
 struct res_controller memctlr_rg = {
 	.name = res_ctlr_name,
 	.ctlr_id = NO_RES_ID,
 	.alloc_shares_struct = memctlr_alloc_instance,
 	.free_shares_struct = memctlr_free_instance,
 	.move_task = memctlr_move_task,
-	.shares_changed = NULL,
+	.shares_changed = memctlr_shares_changed,
 	.show_stats = memctlr_show_stats,
 };
 
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
