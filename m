Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWDUCds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWDUCds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWDUCY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:24:59 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:27355 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750895AbWDUCYw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:24:52 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:24:50 -0700
Message-Id: <20060421022450.6145.58259.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 07/12] Configfs based filesystem user interface - RCFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

07/12 - ckrm_configfs_rcfs

Create the filesystem(RCFS) for managing CKRM. Hooks up with configfs.
Provides functions for creating and deleting classes.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 init/Kconfig            |   12 +++
 kernel/ckrm/Makefile    |    1 
 kernel/ckrm/ckrm_rcfs.c |  160 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)

Index: linux2617-rc2/init/Kconfig
===================================================================
--- linux2617-rc2.orig/init/Kconfig
+++ linux2617-rc2/init/Kconfig
@@ -163,6 +163,18 @@ config CKRM
 	  If you say Y here, enable the Resource Class File System and at least
 	  one of the resource controllers below. Say N if you are unsure.
 
+config CKRM_RCFS
+	tristate "Resource Control File System (User API for CKRM)"
+	depends on CKRM
+	select CONFIGFS_FS
+	default m
+	help
+	  RCFS is the filesystem API for CKRM. Compiling it as a module permits
+	  users to only load RCFS if they intend to use CKRM.
+
+	  Say M if unsure, Y to save on module loading. N doesn't make sense
+	  when CKRM has been configured.
+
 endmenu
 config SYSCTL
 	bool "Sysctl support"
Index: linux2617-rc2/kernel/ckrm/ckrm_rcfs.c
===================================================================
--- /dev/null
+++ linux2617-rc2/kernel/ckrm/ckrm_rcfs.c
@@ -0,0 +1,160 @@
+/*
+ * kernel/ckrm/ckrm_rcfs.c
+ *
+ * Copyright (C) Shailabh Nagar,  IBM Corp. 2005
+ *               Chandra Seetharaman,   IBM Corp. 2005, 2006
+ *
+ * Configfs based Resource class filesystem (rcfs) serving the
+ * user interface to Class-based Kernel Resource Management (CKRM).
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
+#include "ckrm_local.h"
+
+static struct configfs_subsystem rcfs_subsys;
+static struct config_item_type rcfs_class_type;
+
+struct rcfs_class {
+	char *name;
+	struct ckrm_class *core;
+	struct config_group group;
+};
+
+static inline struct rcfs_class *group_to_rcfs_class(struct config_group *grp)
+{
+	return container_of(grp, struct rcfs_class, group);
+}
+
+static inline struct rcfs_class *item_to_rcfs_class(struct config_item *item)
+{
+	return group_to_rcfs_class(to_config_group(item));
+}
+
+static inline struct ckrm_class *group_to_ckrm_class(struct config_group *grp)
+{
+	struct rcfs_class *rclass;
+	/*
+	 * A configfs wrinkle forces us to treat the root group as a special
+	 * case instead of wrapping the group in a struct rcfs_class like all
+	 * other groups.
+	 */
+	if (grp == &rcfs_subsys.su_group)
+		return &ckrm_default_class;
+	rclass = group_to_rcfs_class(grp);
+	return rclass->core;
+}
+
+static inline struct ckrm_class *item_to_ckrm_class(struct config_item *item)
+{
+	return group_to_ckrm_class(to_config_group(item));
+}
+
+/*
+ * This is the function that is called when a 'mkdir' command
+ * is issued under our filesystem
+ */
+static struct config_group *make_rcfs_class(struct config_group *group,
+					const char *name)
+{
+	struct rcfs_class *rclass, *rc_par;
+	struct ckrm_class *core, *parent;
+	char *new_name = NULL, *par_name = NULL;
+	int par_sz = 0;
+
+	rclass = kzalloc(sizeof(struct rcfs_class), GFP_KERNEL);
+	if (!rclass)
+		return NULL;
+
+	parent = group_to_ckrm_class(group);
+
+	if (parent != &ckrm_default_class) {
+		rc_par = group_to_rcfs_class(group);
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
+	core = ckrm_alloc_class(parent, new_name);
+	if (!core)
+		goto nocore;
+	rclass->core = core;
+	rclass->name = new_name;
+
+	config_group_init_type_name(&rclass->group, name, &rcfs_class_type);
+	return &rclass->group;
+
+nocore:
+	kfree(new_name);
+noname:
+	kfree(rclass);
+	return NULL;
+}
+
+/*
+ * This is the function that is called when a 'rmdir' command
+ * is issued under our filesystem
+ */
+static void rcfs_class_release_item(struct config_item *item)
+{
+	struct rcfs_class *rclass = item_to_rcfs_class(item);
+
+	ckrm_free_class(rclass->core);
+	kfree(rclass->name);
+	kfree(rclass);
+}
+
+static struct configfs_item_operations rcfs_class_item_ops = {
+	.release	= rcfs_class_release_item,
+};
+
+static struct configfs_group_operations rcfs_class_group_ops = {
+	.make_group     = make_rcfs_class,
+};
+
+static struct config_item_type rcfs_class_type = {
+	.ct_owner	= THIS_MODULE,
+	.ct_item_ops    = &rcfs_class_item_ops,
+	.ct_group_ops	= &rcfs_class_group_ops,
+};
+
+static struct configfs_subsystem rcfs_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "ckrm",
+			.ci_type = &rcfs_class_type,
+		}
+	}
+};
+
+static int __init rcfs_init(void)
+{
+	config_group_init(&rcfs_subsys.su_group);
+	init_MUTEX(&rcfs_subsys.su_sem);
+	return configfs_register_subsystem(&rcfs_subsys);
+}
+
+static void __exit rcfs_exit(void)
+{
+	configfs_unregister_subsystem(&rcfs_subsys);
+	ckrm_teardown();
+}
+
+late_initcall(rcfs_init);
+module_exit(rcfs_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RCFS - Provides an interface to classes and allows control "
+		   "of their resource usage");
Index: linux2617-rc2/kernel/ckrm/Makefile
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/Makefile
+++ linux2617-rc2/kernel/ckrm/Makefile
@@ -1 +1,2 @@
 obj-y = ckrm.o ckrm_shares.o ckrm_task.o
+obj-$(CONFIG_CKRM_RCFS) += ckrm_rcfs.o

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
