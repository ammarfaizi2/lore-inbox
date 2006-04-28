Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWD1Bh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWD1Bh4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWD1Bfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:35:54 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:25778 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030242AbWD1BfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:35:13 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:35:11 -0700
Message-Id: <20060428013511.27212.78544.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
References: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
Subject: [PATCH 11/12] Add members file support to RGCS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

11/12 - user_interface_members

Adds attr_store and attr_show support for members file.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 rgcs.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+)

Index: linux-2617-rc3/kernel/res_group/rgcs.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/rgcs.c	2006-04-27 10:18:47.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/rgcs.c	2006-04-27 10:18:47.000000000 -0700
@@ -242,6 +242,43 @@ static ssize_t show_shares(struct resour
 	return rc;
 }
 
+/*
+ * Given a buffer with a pid in it, add the task with that pid to the
+ * resource group. Ignores entire buffer after the first pid is parsed.
+ */
+static int add_member(struct resource_group *rgroup, const char *str)
+{
+	pid_t pid;
+
+	pid = (pid_t) simple_strtol(str, NULL, 0);
+	if (pid <= 0)
+		return -EINVAL; /* Not a valid pid */
+	return set_res_group(pid, rgroup);
+}
+
+/*
+ * Lists pids of tasks that belong to the given rgroup.
+ */
+static ssize_t show_members(struct resource_group *rgroup, char *buf)
+{
+	ssize_t i, rc = 0, bufsize = PAGE_SIZE;
+	struct task_struct *tsk;
+
+	spin_lock(&rgroup->group_lock);
+	list_for_each_entry(tsk, &rgroup->task_list, member_list) {
+		if (bufsize <= 0) {
+			rc = -ENOSPC;
+			break;
+		}
+		if (!tsk->pid)	/* Ignore swappers */
+			continue;
+		i = snprintf(buf, bufsize, "%ld\n", (long)tsk->pid);
+		buf += i; rc += i; bufsize -= i;
+	}
+	spin_unlock(&rgroup->group_lock);
+	return rc;
+}
+
 struct rgroup_attribute {
 	struct configfs_attribute configfs_attr;
 	ssize_t (*show)(struct resource_group *, char *);
@@ -268,6 +305,17 @@ struct rgroup_attribute shares_attr = {
 	.store = set_shares
 };
 
+struct rgroup_attribute members_attr = {
+	.configfs_attr = {
+		.ca_name = "members",
+		.ca_owner = THIS_MODULE,
+		.ca_mode = S_IRUGO | S_IWUSR
+	},
+	.show = show_members,
+	.store = add_member
+};
+
+
 static struct configfs_subsystem rgcs_subsys;
 static struct config_item_type rgcs_item_type;
 
@@ -417,6 +465,7 @@ static struct configfs_group_operations 
 static struct configfs_attribute *rgroup_attrs[] = {
 	&stats_attr.configfs_attr,
 	&shares_attr.configfs_attr,
+	&members_attr.configfs_attr,
 	NULL
 };
 

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
