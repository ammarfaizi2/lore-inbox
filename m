Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWD1Bgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWD1Bgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWD1Bf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:35:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:4274 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030236AbWD1BfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:35:02 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:35:00 -0700
Message-Id: <20060428013500.27212.70582.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
References: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
Subject: [PATCH 09/12] Add stats file support to RGCS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

09/12 - user_interface_stats

Adds attr_store and attr_show support for stats file.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 rgcs.c |  112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 110 insertions(+), 2 deletions(-)

Index: linux-2617-rc3/kernel/res_group/rgcs.c
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/rgcs.c	2006-04-27 10:18:44.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/rgcs.c	2006-04-27 10:18:45.000000000 -0700
@@ -20,8 +20,102 @@
 #include <linux/parser.h>
 #include "local.h"
 
-static struct configfs_subsystem rgcs_subsys;
-static struct config_item_type rgcs_item_type;
+#define RES_STRING "res"
+
+static ssize_t show_stats(struct resource_group *rgroup, char *buf)
+{
+	int i, j = 0, rc = 0;
+	size_t buf_size = PAGE_SIZE-1; /* allow only PAGE_SIZE # of bytes */
+	struct res_controller *ctlr;
+	struct res_shares *shares;
+
+	for (i = 0; i < MAX_RES_CTLRS; i++, j = 0) {
+		if (buf_size <= 0)
+			break;
+		ctlr = get_controller_by_id(i);
+		if (!ctlr)
+			 continue;
+		shares = get_controller_shares(rgroup, ctlr);
+		if (shares && ctlr->show_stats)
+			j = ctlr->show_stats(shares, buf, buf_size);
+		put_controller(ctlr);
+		rc += j;
+		buf += j;
+		buf_size -= j;
+	}
+	if (i < MAX_RES_CTLRS)
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
+static int stats_parse(const char *options,
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
+static int reset_stats(struct resource_group *rgroup, const char *str)
+{
+	int rc;
+	char *resname = NULL, *statstr = NULL;
+	struct res_controller *ctlr;
+	struct res_shares *shares;
+
+	rc = stats_parse(str, &resname, &statstr);
+	if (rc)
+		return rc;
+
+	ctlr = get_controller_by_name(resname);
+	if (!ctlr) {
+		rc = -EINVAL;
+		goto done;
+	}
+	shares = get_controller_shares(rgroup, ctlr);
+	if (shares && ctlr->reset_stats)
+		rc = ctlr->reset_stats(shares, statstr);
+	put_controller(ctlr);
+done:
+	kfree(resname);
+	kfree(statstr);
+	return rc;
+}
 
 struct rgroup_attribute {
 	struct configfs_attribute configfs_attr;
@@ -29,6 +123,19 @@ struct rgroup_attribute {
 	int (*store)(struct resource_group *, const char *);
 };
 
+struct rgroup_attribute stats_attr = {
+	.configfs_attr = {
+		.ca_name = "stats",
+		.ca_owner = THIS_MODULE,
+		.ca_mode = S_IRUGO | S_IWUSR
+	},
+	.show = show_stats,
+	.store = reset_stats
+};
+
+static struct configfs_subsystem rgcs_subsys;
+static struct config_item_type rgcs_item_type;
+
 struct rgcs_rgroup {
 	char *name;
 	struct resource_group *core;
@@ -173,6 +280,7 @@ static struct configfs_group_operations 
 };
 
 static struct configfs_attribute *rgroup_attrs[] = {
+	&stats_attr.configfs_attr,
 	NULL
 };
 

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
