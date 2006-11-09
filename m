Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWKITge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWKITge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWKITgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:36:19 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:58611 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1030398AbWKITgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:36:12 -0500
From: Balbir Singh <balbir@in.ibm.com>
To: Linux MM <linux-mm@kvack.org>
Cc: dev@openvz.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       rohitseth@google.com, Balbir Singh <balbir@in.ibm.com>
Date: Fri, 10 Nov 2006 01:05:51 +0530
Message-Id: <20061109193551.21437.44408.sendpatchset@balbir.in.ibm.com>
In-Reply-To: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
Subject: [RFC][PATCH 3/8] RSS controller add callbacks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Add callbacks to allocate and free instances of the controller as the
hierarchy of resource groups is modified.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 kernel/res_group/memctlr.c |   58 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff -puN kernel/res_group/memctlr.c~container-memctlr-callbacks kernel/res_group/memctlr.c
--- linux-2.6.19-rc2/kernel/res_group/memctlr.c~container-memctlr-callbacks	2006-11-09 21:42:35.000000000 +0530
+++ linux-2.6.19-rc2-balbir/kernel/res_group/memctlr.c	2006-11-09 21:42:35.000000000 +0530
@@ -34,6 +34,8 @@
 
 static const char res_ctlr_name[] = "memctlr";
 static struct resource_group *root_rgroup;
+static const char version[] = "0.01";
+static struct memctlr *memctlr_root;
 
 struct mem_counter {
 	atomic_long_t	rss;
@@ -64,14 +66,64 @@ static struct memctlr *get_memctlr(struc
 								&memctlr_rg));
 }
 
+static void memctlr_init_new(struct memctlr *res)
+{
+	res->shares.min_shares = SHARE_DONT_CARE;
+	res->shares.max_shares = SHARE_DONT_CARE;
+	res->shares.child_shares_divisor = SHARE_DEFAULT_DIVISOR;
+	res->shares.unused_min_shares = SHARE_DEFAULT_DIVISOR;
+}
+
+static struct res_shares *memctlr_alloc_instance(struct resource_group *rgroup)
+{
+	struct memctlr *res;
+
+	res = kzalloc(sizeof(struct memctlr), GFP_KERNEL);
+	if (!res)
+		return NULL;
+	res->rgroup = rgroup;
+	memctlr_init_new(res);
+	if (is_res_group_root(rgroup)) {
+		root_rgroup = rgroup;
+		memctlr_root = res;
+		printk("Memory Controller version %s\n", version);
+	}
+	return &res->shares;
+}
+
+static void memctlr_free_instance(struct res_shares *shares)
+{
+	struct memctlr *res, *parres;
+
+	res = get_memctlr_from_shares(shares);
+	BUG_ON(!res);
+	/*
+	 * Containers do not allow removal of groups that have tasks
+	 * associated with them. To free a container, it must be empty.
+	 * Handle transfer of charges in the move_task notification
+	 */
+	kfree(res);
+}
+
+static ssize_t memctlr_show_stats(struct res_shares *shares, char *buf,
+					size_t len)
+{
+	int i = 0;
+
+	i += snprintf(buf, len, "Accounting will be added soon\n");
+	buf += i;
+	len -= i;
+	return i;
+}
+
 struct res_controller memctlr_rg = {
 	.name = res_ctlr_name,
 	.ctlr_id = NO_RES_ID,
-	.alloc_shares_struct = NULL,
-	.free_shares_struct = NULL,
+	.alloc_shares_struct = memctlr_alloc_instance,
+	.free_shares_struct = memctlr_free_instance,
 	.move_task = NULL,
 	.shares_changed = NULL,
-	.show_stats = NULL,
+	.show_stats = memctlr_show_stats,
 };
 
 int __init memctlr_init(void)
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
