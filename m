Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWD1Bfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWD1Bfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWD1Be7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:34:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:25242 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030242AbWD1Be4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:34:56 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:34:54 -0700
Message-Id: <20060428013454.27212.70077.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
References: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
Subject: [PATCH 08/12] Add attribute support to RGCS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

08/12 - user_interface_attr_support

Adds the basic attribute store and show functions.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 rgcs.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 52 insertions(+), 1 deletion(-)

Index: linux-2617-rc3/kernel/res_group/rgcs.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/rgcs.c	2006-04-27 10:18:39.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/rgcs.c	2006-04-27 10:18:44.000000000 -0700
@@ -14,13 +14,21 @@
  * as published by the Free Software Foundation.
  *
  */
+#include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/configfs.h>
+#include <linux/parser.h>
 #include "local.h"
 
 static struct configfs_subsystem rgcs_subsys;
 static struct config_item_type rgcs_item_type;
 
+struct rgroup_attribute {
+	struct configfs_attribute configfs_attr;
+	ssize_t (*show)(struct resource_group *, char *);
+	int (*store)(struct resource_group *, const char *);
+};
+
 struct rgcs_rgroup {
 	char *name;
 	struct resource_group *core;
@@ -58,6 +66,42 @@ static inline struct resource_group *ite
 	return group_to_res_group(to_config_group(item));
 }
 
+static ssize_t rgcs_attr_show(struct config_item *item,
+	      		      struct configfs_attribute *attr, char *buf)
+{
+	struct rgroup_attribute *rgroup_attr;
+	struct resource_group *rgroup = item_to_res_group(item);
+
+	rgroup_attr = container_of(attr, struct rgroup_attribute,
+							configfs_attr);
+	return rgroup_attr->show(rgroup, buf);
+}
+
+static ssize_t rgcs_attr_store(struct config_item *item,
+		       struct configfs_attribute *attr, const char *buf,
+		       size_t count)
+{
+	char *filtered_buf, *p;
+	ssize_t rc;
+	struct rgroup_attribute *rgroup_attr;
+	struct resource_group *rgroup = item_to_res_group(item);
+
+	rgroup_attr = container_of(attr, struct rgroup_attribute,
+							configfs_attr);
+	filtered_buf = kzalloc(count + 1, GFP_KERNEL);
+	if (!filtered_buf)
+		return -ENOMEM;
+	strncpy(filtered_buf, buf, count);
+	for (p = filtered_buf; isprint(*p); ++p)
+		;
+	*p = '\0';
+	rc = rgroup_attr->store(rgroup, filtered_buf);
+	kfree(filtered_buf);
+	if (rc)
+		return rc;
+	return count;
+}
+
 /*
  * This is the function that is called when a 'mkdir' command
  * is issued under our filesystem
@@ -119,17 +163,24 @@ static void rgcs_rgroup_release_item(str
 }
 
 static struct configfs_item_operations rgcs_rgroup_item_ops = {
-	.release	= rgcs_rgroup_release_item,
+	.release		= rgcs_rgroup_release_item,
+	.show_attribute		= rgcs_attr_show,
+	.store_attribute	= rgcs_attr_store,
 };
 
 static struct configfs_group_operations rgcs_rgroup_group_ops = {
 	.make_group     = make_rgcs_rgroup,
 };
 
+static struct configfs_attribute *rgroup_attrs[] = {
+	NULL
+};
+
 static struct config_item_type rgcs_item_type = {
 	.ct_owner	= THIS_MODULE,
 	.ct_item_ops    = &rgcs_rgroup_item_ops,
 	.ct_group_ops	= &rgcs_rgroup_group_ops,
+	.ct_attrs       = rgroup_attrs
 };
 
 static struct configfs_subsystem rgcs_subsys = {

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
