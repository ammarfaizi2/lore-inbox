Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWD1Be6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWD1Be6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWD1Bez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:34:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:8082 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030238AbWD1Bev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:34:51 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:34:49 -0700
Message-Id: <20060428013449.27212.21160.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
References: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
Subject: [PATCH 07/12] Resource Groups Configfs Subsystem (RGCS)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

07/12 - user_interface

Create the configfs component for managing Resource groups. Hooks up with
configfs. Provides functions for creating and deleting resource groups.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 init/Kconfig              |   12 +++
 kernel/res_group/Makefile |    1 
 kernel/res_group/rgcs.c   |  162 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)

Index: linux-2617-rc3/init/Kconfig
===================================================================
--- linux-2617-rc3.orig/init/Kconfig	2006-04-27 09:20:59.000000000 -0700
+++ linux-2617-rc3/init/Kconfig	2006-04-27 10:17:11.000000000 -0700
@@ -163,6 +163,18 @@ config RES_GROUPS
 	  If you say Y here, enable the Resource Group File System and at least
 	  one of the resource controllers below. Say N if you are unsure.
 
+config RGCS
+	tristate "Resource Groups Configfs Subsystem"
+	depends on RES_GROUPS
+	select CONFIGFS_FS
+	default m
+	help
+	  RGCS is the User Interface for Resource Groups. Compiling it as
+	  a module permits users to only load RGCS if they intend to use it.
+
+	  Say M if unsure, Y to save on module loading. N doesn't make sense
+	  when Resource Groups has been configured.
+
 endmenu
 config SYSCTL
 	bool "Sysctl support"
Index: linux-2617-rc3/kernel/res_group/rgcs.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/kernel/res_group/rgcs.c	2006-04-27 10:18:39.000000000 -0700
@@ -0,0 +1,162 @@
+/*
+ * kernel/res_group/rgcs.c
+ *
+ * Copyright (C) Shailabh Nagar,  IBM Corp. 2005
+ *               Chandra Seetharaman,   IBM Corp. 2005, 2006
+ *
+ * Resource Group Configfs Subsystem (rgcs) provides the user interface
+ * for Resource groups.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the  GNU General Public License
+ * as published by the Free Software Foundation.
+ *
+ */
+#include <linux/module.h>
+#include <linux/configfs.h>
+#include "local.h"
+
+static struct configfs_subsystem rgcs_subsys;
+static struct config_item_type rgcs_item_type;
+
+struct rgcs_rgroup {
+	char *name;
+	struct resource_group *core;
+	struct config_group group;
+};
+
+static inline struct rgcs_rgroup *group_to_rgcs_rgroup(struct config_group *grp)
+{
+	return container_of(grp, struct rgcs_rgroup, group);
+}
+
+static inline struct rgcs_rgroup *item_to_rgcs_rgroup(struct config_item *item)
+{
+	return group_to_rgcs_rgroup(to_config_group(item));
+}
+
+static inline struct resource_group *group_to_res_group(
+					struct config_group *grp)
+{
+	struct rgcs_rgroup *rgroup;
+	/*
+	 * A configfs wrinkle forces us to treat the root group as a special
+	 * case instead of wrapping the group in a struct rgcs_rgroup like all
+	 * other groups.
+	 */
+	if (grp == &rgcs_subsys.su_group)
+		return &default_res_group;
+	rgroup = group_to_rgcs_rgroup(grp);
+	return rgroup->core;
+}
+
+static inline struct resource_group *item_to_res_group(
+					struct config_item *item)
+{
+	return group_to_res_group(to_config_group(item));
+}
+
+/*
+ * This is the function that is called when a 'mkdir' command
+ * is issued under our filesystem
+ */
+static struct config_group *make_rgcs_rgroup(struct config_group *group,
+					const char *name)
+{
+	struct rgcs_rgroup *rgroup, *rc_par;
+	struct resource_group *core, *parent;
+	char *new_name = NULL, *par_name = NULL;
+	int par_sz = 0;
+
+	rgroup = kzalloc(sizeof(struct rgcs_rgroup), GFP_KERNEL);
+	if (!rgroup)
+		return NULL;
+
+	parent = group_to_res_group(group);
+
+	if (parent != &default_res_group) {
+		rc_par = group_to_rgcs_rgroup(group);
+		par_name = rc_par->name;
+		par_sz = strlen(par_name);
+	}
+	new_name = kmalloc(par_sz + strlen(name) + 2, GFP_KERNEL);
+	if (!new_name)
+		goto noname;
+	if (par_name)
+		sprintf(new_name, "%s/%s", par_name, name);
+	else
+		sprintf(new_name, "%s", name);
+
+	core = alloc_res_group(parent, new_name);
+	if (!core)
+		goto nocore;
+	rgroup->core = core;
+	rgroup->name = new_name;
+
+	config_group_init_type_name(&rgroup->group, name, &rgcs_item_type);
+	return &rgroup->group;
+
+nocore:
+	kfree(new_name);
+noname:
+	kfree(rgroup);
+	return NULL;
+}
+
+/*
+ * This is the function that is called when a 'rmdir' command
+ * is issued under our filesystem
+ */
+static void rgcs_rgroup_release_item(struct config_item *item)
+{
+	struct rgcs_rgroup *rgroup = item_to_rgcs_rgroup(item);
+
+	free_res_group(rgroup->core);
+	kfree(rgroup->name);
+	kfree(rgroup);
+}
+
+static struct configfs_item_operations rgcs_rgroup_item_ops = {
+	.release	= rgcs_rgroup_release_item,
+};
+
+static struct configfs_group_operations rgcs_rgroup_group_ops = {
+	.make_group     = make_rgcs_rgroup,
+};
+
+static struct config_item_type rgcs_item_type = {
+	.ct_owner	= THIS_MODULE,
+	.ct_item_ops    = &rgcs_rgroup_item_ops,
+	.ct_group_ops	= &rgcs_rgroup_group_ops,
+};
+
+static struct configfs_subsystem rgcs_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "res_groups",
+			.ci_type = &rgcs_item_type,
+		}
+	}
+};
+
+static int __init rgcs_init(void)
+{
+	config_group_init(&rgcs_subsys.su_group);
+	init_MUTEX(&rgcs_subsys.su_sem);
+	return configfs_register_subsystem(&rgcs_subsys);
+}
+
+static void __exit rgcs_exit(void)
+{
+	configfs_unregister_subsystem(&rgcs_subsys);
+	res_group_teardown();
+}
+
+late_initcall(rgcs_init);
+module_exit(rgcs_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RGCS - Provides an interface to Resource Groups"
+			" and allows control of their resource usage");
Index: linux-2617-rc3/kernel/res_group/Makefile
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/Makefile	2006-04-27 09:22:16.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/Makefile	2006-04-27 10:14:38.000000000 -0700
@@ -1 +1,2 @@
 obj-y = res_group.o shares.o task.o
+obj-$(CONFIG_RGCS) += rgcs.o

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
