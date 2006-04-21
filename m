Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWDUCcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWDUCcv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWDUCZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:25:04 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:46555 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750902AbWDUCY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:24:57 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:24:56 -0700
Message-Id: <20060421022456.6145.34081.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 08/12] Add attribute support to RCFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

08/12 - ckrm_configfs_rcfs_attr_support

Adds the basic attribute store and show functions.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 kernel/ckrm/ckrm_rcfs.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 50 insertions(+), 1 deletion(-)

Index: linux2617-rc2/kernel/ckrm/ckrm_rcfs.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm_rcfs.c
+++ linux2617-rc2/kernel/ckrm/ckrm_rcfs.c
@@ -14,13 +14,21 @@
  * as published by the Free Software Foundation.
  *
  */
+#include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/configfs.h>
+#include <linux/parser.h>
 #include "ckrm_local.h"
 
 static struct configfs_subsystem rcfs_subsys;
 static struct config_item_type rcfs_class_type;
 
+struct class_attribute {
+	struct configfs_attribute configfs_attr;
+	ssize_t (*show)(struct ckrm_class *, char *);
+	int (*store)(struct ckrm_class *, const char *);
+};
+
 struct rcfs_class {
 	char *name;
 	struct ckrm_class *core;
@@ -56,6 +64,40 @@ static inline struct ckrm_class *item_to
 	return group_to_ckrm_class(to_config_group(item));
 }
 
+static ssize_t rcfs_attr_show(struct config_item *item,
+	      		      struct configfs_attribute *attr, char *buf)
+{
+	struct class_attribute *class_attr;
+	struct ckrm_class *class = item_to_ckrm_class(item);
+
+	class_attr = container_of(attr, struct class_attribute, configfs_attr);
+	return class_attr->show(class, buf);
+}
+
+static ssize_t rcfs_attr_store(struct config_item *item,
+			       struct configfs_attribute *attr, const char *buf,
+			       size_t count)
+{
+	char *filtered_buf, *p;
+	ssize_t rc;
+	struct class_attribute *class_attr;
+	struct ckrm_class *class = item_to_ckrm_class(item);
+
+	class_attr = container_of(attr, struct class_attribute, configfs_attr);
+	filtered_buf = kzalloc(count + 1, GFP_KERNEL);
+	if (!filtered_buf)
+		return -ENOMEM;
+	strncpy(filtered_buf, buf, count);
+	for (p = filtered_buf; isprint(*p); ++p)
+		;
+	*p = '\0';
+	rc = class_attr->store(class, filtered_buf);
+	kfree(filtered_buf);
+	if (rc)
+		return rc;
+	return count;
+}
+
 /*
  * This is the function that is called when a 'mkdir' command
  * is issued under our filesystem
@@ -117,17 +159,24 @@ static void rcfs_class_release_item(stru
 }
 
 static struct configfs_item_operations rcfs_class_item_ops = {
-	.release	= rcfs_class_release_item,
+	.release		= rcfs_class_release_item,
+	.show_attribute		= rcfs_attr_show,
+	.store_attribute	= rcfs_attr_store,
 };
 
 static struct configfs_group_operations rcfs_class_group_ops = {
 	.make_group     = make_rcfs_class,
 };
 
+static struct configfs_attribute *class_attrs[] = {
+	NULL
+};
+
 static struct config_item_type rcfs_class_type = {
 	.ct_owner	= THIS_MODULE,
 	.ct_item_ops    = &rcfs_class_item_ops,
 	.ct_group_ops	= &rcfs_class_group_ops,
+	.ct_attrs       = class_attrs
 };
 
 static struct configfs_subsystem rcfs_subsys = {

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
