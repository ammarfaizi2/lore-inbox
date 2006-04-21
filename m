Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWDUC16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWDUC16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWDUCZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:25:19 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:43484 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750946AbWDUCZO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:25:14 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:25:13 -0700
Message-Id: <20060421022513.6145.20550.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 11/12] Add members file support to RCFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

11/12 - ckrm_configfs_rcfs_members

Adds attr_store and attr_show support for members file.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 kernel/ckrm/ckrm_rcfs.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+)

Index: linux2617-rc2/kernel/ckrm/ckrm_rcfs.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm_rcfs.c
+++ linux2617-rc2/kernel/ckrm/ckrm_rcfs.c
@@ -244,6 +244,43 @@ static ssize_t show_shares(struct ckrm_c
 	return rc;
 }
 
+/*
+ * Given a buffer with a pid in it, add the task with that pid to the class.
+ * Ignores entire buffer after the first pid is parsed.
+ */
+static int add_member(struct ckrm_class *class, const char *str)
+{
+	pid_t pid;
+
+	pid = (pid_t) simple_strtol(str, NULL, 0);
+	if (pid <= 0)
+		return -EINVAL; /* Not a valid pid */
+	return ckrm_setclass(pid, class);
+}
+
+/*
+ * Lists pids of tasks that belong to the given class.
+ */
+static ssize_t show_members(struct ckrm_class *class, char *buf)
+{
+	ssize_t i, rc = 0, bufsize = PAGE_SIZE;
+	struct task_struct *tsk;
+
+	spin_lock(&class->class_lock);
+	list_for_each_entry(tsk, &class->task_list, member_list) {
+		if (bufsize <= 0) {
+			rc = -ENOSPC;
+			break;
+		}
+		if (!tsk->pid)	/* Ignore swappers */
+			continue;
+		i = snprintf(buf, bufsize, "%ld\n", (long)tsk->pid);
+		buf += i; rc += i; bufsize -= i;
+	}
+	spin_unlock(&class->class_lock);
+	return rc;
+}
+
 struct class_attribute {
 	struct configfs_attribute configfs_attr;
 	ssize_t (*show)(struct ckrm_class *, char *);
@@ -270,6 +307,17 @@ struct class_attribute shares_attr = {
 	.store = set_shares
 };
 
+struct class_attribute members_attr = {
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
 static struct configfs_subsystem rcfs_subsys;
 static struct config_item_type rcfs_class_type;
 
@@ -415,6 +463,7 @@ static struct configfs_group_operations 
 static struct configfs_attribute *class_attrs[] = {
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
