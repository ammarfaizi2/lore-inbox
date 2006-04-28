Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWD1Bgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWD1Bgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWD1Bf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:35:56 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:38629 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030244AbWD1BfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:35:08 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:35:06 -0700
Message-Id: <20060428013506.27212.17402.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
References: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
Subject: [PATCH 10/12] Add shares file support to RGCS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

10/12 - user_interface_shares

Adds attr_store and attr_show support for shares file.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 rgcs.c |  136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 136 insertions(+)

Index: linux-2617-rc3/kernel/res_group/rgcs.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/rgcs.c	2006-04-27 10:18:45.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/rgcs.c	2006-04-27 10:18:47.000000000 -0700
@@ -21,6 +21,9 @@
 #include "local.h"
 
 #define RES_STRING "res"
+#define MIN_SHARES_STRING "min_shares"
+#define MAX_SHARES_STRING "max_shares"
+#define CHILD_SHARES_DIVISOR_STRING "child_shares_divisor"
 
 static ssize_t show_stats(struct resource_group *rgroup, char *buf)
 {
@@ -117,6 +120,128 @@ done:
 	return rc;
 }
 
+
+enum share_token_t {
+	MIN_SHARES_TOKEN,
+	MAX_SHARES_TOKEN,
+	CHILD_SHARES_DIVISOR_TOKEN,
+	RESOURCE_TYPE_TOKEN,
+	ERROR_TOKEN
+};
+
+/* Token matching for parsing input to this magic file */
+static match_table_t shares_tokens = {
+	{RESOURCE_TYPE_TOKEN, RES_STRING"=%s"},
+	{MIN_SHARES_TOKEN, MIN_SHARES_STRING"=%d"},
+	{MAX_SHARES_TOKEN, MAX_SHARES_STRING"=%d"},
+	{CHILD_SHARES_DIVISOR_TOKEN, CHILD_SHARES_DIVISOR_STRING"=%d"},
+	{ERROR_TOKEN, NULL}
+};
+
+static int shares_parse(const char *options, char **resname,
+					struct res_shares *shares)
+{
+	char *p;
+	int option, rc = -EINVAL;
+
+	*resname = NULL;
+	if (!options)
+		goto done;
+	while ((p = strsep((char **)&options, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+
+		if (!*p)
+			continue;
+		token = match_token(p, shares_tokens, args);
+		switch (token) {
+		case RESOURCE_TYPE_TOKEN:
+			if (*resname)
+				goto done;
+			*resname = match_strdup(args);
+			break;
+		case MIN_SHARES_TOKEN:
+			if (match_int(args, &option))
+				goto done;
+			shares->min_shares = option;
+			break;
+		case MAX_SHARES_TOKEN:
+			if (match_int(args, &option))
+				goto done;
+			shares->max_shares = option;
+			break;
+		case CHILD_SHARES_DIVISOR_TOKEN:
+			if (match_int(args, &option))
+				goto done;
+			shares->child_shares_divisor = option;
+			break;
+		default:
+			goto done;
+		}
+	}
+	rc = 0;
+done:
+	if (rc) {
+		kfree(*resname);
+		*resname = NULL;
+	}
+	return rc;
+}
+
+static int set_shares(struct resource_group *rgroup, const char *str)
+{
+	char *resname = NULL;
+	int rc;
+	struct res_controller *ctlr;
+	struct res_shares shares = {
+		.min_shares = SHARE_UNCHANGED,
+		.max_shares = SHARE_UNCHANGED,
+		.child_shares_divisor = SHARE_UNCHANGED,
+	};
+
+	rc = shares_parse(str, &resname, &shares);
+	if (!rc) {
+		ctlr = get_controller_by_name(resname);
+		if (ctlr) {
+			rc = set_controller_shares(rgroup, ctlr, &shares);
+			put_controller(ctlr);
+		} else
+			rc = -EINVAL;
+		kfree(resname);
+	}
+	return rc;
+}
+
+static ssize_t show_shares(struct resource_group *rgroup, char *buf)
+{
+	int i;
+	ssize_t j, rc = 0, bufsize = PAGE_SIZE;
+	struct res_shares *shares;
+	struct res_controller *ctlr;
+
+	for (i = 0; i < MAX_RES_CTLRS; i++) {
+		ctlr = get_controller_by_id(i);
+		if (!ctlr)
+			continue;
+		shares = get_controller_shares(rgroup, ctlr);
+		if (shares) {
+			if (bufsize <= 0)
+				break;
+			j = snprintf(buf, bufsize, "%s=%s,%s=%d,%s=%d,%s=%d\n",
+				RES_STRING, ctlr->name,
+				MIN_SHARES_STRING, shares->min_shares,
+				MAX_SHARES_STRING, shares->max_shares,
+				CHILD_SHARES_DIVISOR_STRING,
+				shares->child_shares_divisor);
+			rc += j; buf += j; bufsize -= j;
+		}
+		put_controller(ctlr);
+	}
+	if (i < MAX_RES_CTLRS)
+		rc = -ENOSPC;
+	return rc;
+}
+
 struct rgroup_attribute {
 	struct configfs_attribute configfs_attr;
 	ssize_t (*show)(struct resource_group *, char *);
@@ -133,6 +258,16 @@ struct rgroup_attribute stats_attr = {
 	.store = reset_stats
 };
 
+struct rgroup_attribute shares_attr = {
+	.configfs_attr = {
+		.ca_name = "shares",
+		.ca_owner = THIS_MODULE,
+		.ca_mode = S_IRUGO | S_IWUSR
+	},
+	.show = show_shares,
+	.store = set_shares
+};
+
 static struct configfs_subsystem rgcs_subsys;
 static struct config_item_type rgcs_item_type;
 
@@ -281,6 +416,7 @@ static struct configfs_group_operations 
 
 static struct configfs_attribute *rgroup_attrs[] = {
 	&stats_attr.configfs_attr,
+	&shares_attr.configfs_attr,
 	NULL
 };
 

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
