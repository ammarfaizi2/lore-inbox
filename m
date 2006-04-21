Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWDUCcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWDUCcD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWDUCcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:32:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:5514 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750905AbWDUCZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:25:05 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:25:01 -0700
Message-Id: <20060421022501.6145.18395.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 09/12] Add stats file support to RCFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

09/12 - ckrm_configfs_rcfs_stats

Adds attr_store and attr_show support for stats file.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 kernel/ckrm/ckrm_rcfs.c |  114 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 112 insertions(+), 2 deletions(-)

Index: linux2617-rc2/kernel/ckrm/ckrm_rcfs.c
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/ckrm_rcfs.c
+++ linux2617-rc2/kernel/ckrm/ckrm_rcfs.c
@@ -20,8 +20,104 @@
 #include <linux/parser.h>
 #include "ckrm_local.h"
 
-static struct configfs_subsystem rcfs_subsys;
-static struct config_item_type rcfs_class_type;
+#define CKRM_NAME_LEN 20
+
+#define RES_STRING "res"
+
+static ssize_t show_stats(struct ckrm_class *class, char *buf)
+{
+	int i, j = 0, rc = 0;
+	size_t buf_size = PAGE_SIZE-1; /* allow only PAGE_SIZE # of bytes */
+	struct ckrm_controller *ctlr;
+	struct ckrm_shares *shares;
+
+	for (i = 0; i < CKRM_MAX_RES_CTLRS; i++, j = 0) {
+		if (buf_size <= 0)
+			break;
+		ctlr = ckrm_get_controller_by_id(i);
+		if (!ctlr)
+			 continue;
+		shares = ckrm_get_controller_shares(class, ctlr);
+		if (shares && ctlr->show_stats)
+			j = ctlr->show_stats(shares, buf, buf_size);
+		ckrm_put_controller(ctlr);
+		rc += j;
+		buf += j;
+		buf_size -= j;
+	}
+	if (i < CKRM_MAX_RES_CTLRS)
+		rc = -ENOSPC;
+	return rc;
+}
+
+enum parse_token_t {
+	parse_res_type, parse_err
+};
+
+static match_table_t parse_tokens = {
+	{parse_res_type, RES_STRING"=%s"},
+	{parse_err, NULL}
+};
+
+static int ckrm_stats_parse(const char *options,
+				char **resname, char **remaining_line)
+{
+	char *p, *str;
+	int rc = -EINVAL;
+
+	if (!options)
+		return -EINVAL;
+
+	while ((p = strsep((char **)&options, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+
+		if (!*p)
+			continue;
+		token = match_token(p, parse_tokens, args);
+		if (token == parse_res_type) {
+			*resname = match_strdup(args);
+			str = p + strlen(p) + 1;
+			*remaining_line = kmalloc(strlen(str) + 1, GFP_KERNEL);
+			if (*remaining_line == NULL) {
+				kfree(*resname);
+				*resname = NULL;
+				rc = -ENOMEM;
+			} else {
+				strcpy(*remaining_line, str);
+				rc = 0;
+			}
+			break;
+		}
+	}
+	return rc;
+}
+
+static int reset_stats(struct ckrm_class *class, const char *str)
+{
+	int rc;
+	char *resname = NULL, *statstr = NULL;
+	struct ckrm_controller *ctlr;
+	struct ckrm_shares *shares;
+
+	rc = ckrm_stats_parse(str, &resname, &statstr);
+	if (rc)
+		return rc;
+
+	ctlr = ckrm_get_controller_by_name(resname);
+	if (!ctlr) {
+		rc = -EINVAL;
+		goto done;
+	}
+	shares = ckrm_get_controller_shares(class, ctlr);
+	if (shares && ctlr->reset_stats)
+		rc = ctlr->reset_stats(shares, statstr);
+	ckrm_put_controller(ctlr);
+done:
+	kfree(resname);
+	kfree(statstr);
+	return rc;
+}
 
 struct class_attribute {
 	struct configfs_attribute configfs_attr;
@@ -29,6 +125,19 @@ struct class_attribute {
 	int (*store)(struct ckrm_class *, const char *);
 };
 
+struct class_attribute stats_attr = {
+	.configfs_attr = {
+		.ca_name = "stats",
+		.ca_owner = THIS_MODULE,
+		.ca_mode = S_IRUGO | S_IWUSR
+	},
+	.show = show_stats,
+	.store = reset_stats
+};
+
+static struct configfs_subsystem rcfs_subsys;
+static struct config_item_type rcfs_class_type;
+
 struct rcfs_class {
 	char *name;
 	struct ckrm_class *core;
@@ -169,6 +278,7 @@ static struct configfs_group_operations 
 };
 
 static struct configfs_attribute *class_attrs[] = {
+	&stats_attr.configfs_attr,
 	NULL
 };
 

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
