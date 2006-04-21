Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWDUCby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWDUCby (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWDUCZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:25:16 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:54953 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750876AbWDUCZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:25:08 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:25:07 -0700
Message-Id: <20060421022507.6145.18691.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 10/12] Add shares file support to RCFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

10/12 - ckrm_configfs_rcfs_shares

Adds attr_store and attr_show support for shares file.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 kernel/ckrm/ckrm_rcfs.c |  136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 136 insertions(+)

Index: linux2617-rc2/kernel/ckrm/ckrm_rcfs.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm_rcfs.c
+++ linux2617-rc2/kernel/ckrm/ckrm_rcfs.c
@@ -23,6 +23,9 @@
 #define CKRM_NAME_LEN 20
 
 #define RES_STRING "res"
+#define MIN_SHARES_STRING "min_shares"
+#define MAX_SHARES_STRING "max_shares"
+#define CHILD_SHARES_DIVISOR_STRING "child_shares_divisor"
 
 static ssize_t show_stats(struct ckrm_class *class, char *buf)
 {
@@ -119,6 +122,128 @@ done:
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
+					struct ckrm_shares *shares)
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
+static int set_shares(struct ckrm_class *class, const char *str)
+{
+	char *resname = NULL;
+	int rc;
+	struct ckrm_controller *ctlr;
+	struct ckrm_shares shares = {
+		.min_shares = CKRM_SHARE_UNCHANGED,
+		.max_shares = CKRM_SHARE_UNCHANGED,
+		.child_shares_divisor = CKRM_SHARE_UNCHANGED,
+	};
+
+	rc = shares_parse(str, &resname, &shares);
+	if (!rc) {
+		ctlr = ckrm_get_controller_by_name(resname);
+		if (ctlr) {
+			rc = ckrm_set_controller_shares(class, ctlr, &shares);
+			ckrm_put_controller(ctlr);
+		} else
+			rc = -EINVAL;
+		kfree(resname);
+	}
+	return rc;
+}
+
+static ssize_t show_shares(struct ckrm_class *class, char *buf)
+{
+	int i;
+	ssize_t j, rc = 0, bufsize = PAGE_SIZE;
+	struct ckrm_shares *shares;
+	struct ckrm_controller *ctlr;
+
+	for (i = 0; i < CKRM_MAX_RES_CTLRS; i++) {
+		ctlr = ckrm_get_controller_by_id(i);
+		if (!ctlr)
+			continue;
+		shares = ckrm_get_controller_shares(class, ctlr);
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
+		ckrm_put_controller(ctlr);
+	}
+	if (i < CKRM_MAX_RES_CTLRS)
+		rc = -ENOSPC;
+	return rc;
+}
+
 struct class_attribute {
 	struct configfs_attribute configfs_attr;
 	ssize_t (*show)(struct ckrm_class *, char *);
@@ -135,6 +260,16 @@ struct class_attribute stats_attr = {
 	.store = reset_stats
 };
 
+struct class_attribute shares_attr = {
+	.configfs_attr = {
+		.ca_name = "shares",
+		.ca_owner = THIS_MODULE,
+		.ca_mode = S_IRUGO | S_IWUSR
+	},
+	.show = show_shares,
+	.store = set_shares
+};
+
 static struct configfs_subsystem rcfs_subsys;
 static struct config_item_type rcfs_class_type;
 
@@ -279,6 +414,7 @@ static struct configfs_group_operations 
 
 static struct configfs_attribute *class_attrs[] = {
 	&stats_attr.configfs_attr,
+	&shares_attr.configfs_attr,
 	NULL
 };
 

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
