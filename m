Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWD1Bfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWD1Bfu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWD1Bfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:35:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:9944 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030246AbWD1BfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:35:25 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:35:24 -0700
Message-Id: <20060428013524.27212.37711.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013518.27212.954.sendpatchset@localhost.localdomain>
References: <20060428013518.27212.954.sendpatchset@localhost.localdomain>
Subject: [PATCH 1/6] numtasks - Initialization routines
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1/6: numtasks_init

Hooks up with Resource Groups core by defining the basic alloc/free
functions and registering the controller with the core.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 init/Kconfig                |   10 ++++
 kernel/res_group/Makefile   |    1 
 kernel/res_group/numtasks.c |   90 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

Index: linux-2617-rc3/kernel/res_group/Makefile
===================================================================
--- linux-2617-rc3.orig/kernel/res_group/Makefile	2006-04-27 10:14:38.000000000 -0700
+++ linux-2617-rc3/kernel/res_group/Makefile	2006-04-27 10:18:49.000000000 -0700
@@ -1,2 +1,3 @@
 obj-y = res_group.o shares.o task.o
+obj-$(CONFIG_RES_GROUPS_NUMTASKS) += numtasks.o
 obj-$(CONFIG_RGCS) += rgcs.o
Index: linux-2617-rc3/kernel/res_group/numtasks.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/kernel/res_group/numtasks.c	2006-04-27 10:18:49.000000000 -0700
@@ -0,0 +1,90 @@
+/* numtasks.c - "Number of tasks" resource controller for Resource Groups
+ *
+ * Copyright (C) Chandra Seetharaman,  IBM Corp. 2003-2006
+ *	      (C) Matt Helsley, IBM Corp. 2006
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/*
+ * Resource controller for tracking number of tasks in a resource group.
+ */
+#include <linux/module.h>
+#include <linux/res_group_rc.h>
+
+static const char res_ctlr_name[] = "numtasks";
+
+struct numtasks {
+	struct res_shares shares;
+};
+
+struct res_controller numtasks_ctlr;
+
+static struct numtasks *get_shares_numtasks(struct res_shares *shares)
+{
+	if (shares)
+		return container_of(shares, struct numtasks, shares);
+	return NULL;
+}
+
+/* Initialize share struct values */
+static void numtasks_res_init_one(struct numtasks *numtasks_res)
+{
+	numtasks_res->shares.min_shares = SHARE_DONT_CARE;
+	numtasks_res->shares.max_shares = SHARE_DONT_CARE;
+	numtasks_res->shares.child_shares_divisor = SHARE_DEFAULT_DIVISOR;
+	numtasks_res->shares.unused_min_shares = SHARE_DEFAULT_DIVISOR;
+}
+
+static struct res_shares *numtasks_alloc_shares_struct(
+					struct resource_group *rgroup)
+{
+	struct numtasks *res;
+
+	res = kzalloc(sizeof(struct numtasks), GFP_KERNEL);
+	if (!res)
+		return NULL;
+	numtasks_res_init_one(res);
+	return &res->shares;
+}
+
+/*
+ * No locking of this resource group object necessary as we are not
+ * supposed to be assigned (or used) when/after this function is called.
+ */
+static void numtasks_free_shares_struct(struct res_shares *my_res)
+{
+	kfree(get_shares_numtasks(my_res));
+}
+
+struct res_controller numtasks_ctlr = {
+	.name = res_ctlr_name,
+	.depth_supported = 3,
+	.ctlr_id = NO_RES_ID,
+	.alloc_shares_struct = numtasks_alloc_shares_struct,
+	.free_shares_struct = numtasks_free_shares_struct,
+};
+
+int __init init_numtasks_res(void)
+{
+	if (numtasks_ctlr.ctlr_id != NO_RES_ID)
+		return -EBUSY; /* already registered */
+	return register_controller(&numtasks_ctlr);
+}
+
+void __exit exit_numtasks_res(void)
+{
+	int rc;
+	do {
+		rc = unregister_controller(&numtasks_ctlr);
+	} while (rc == -EBUSY);
+	BUG_ON(rc != 0);
+}
+module_init(init_numtasks_res)
+module_exit(exit_numtasks_res)
Index: linux-2617-rc3/init/Kconfig
===================================================================
--- linux-2617-rc3.orig/init/Kconfig	2006-04-27 10:17:11.000000000 -0700
+++ linux-2617-rc3/init/Kconfig	2006-04-27 10:18:49.000000000 -0700
@@ -175,6 +175,16 @@ config RGCS
 	  Say M if unsure, Y to save on module loading. N doesn't make sense
 	  when Resource Groups has been configured.
 
+config RES_GROUPS_NUMTASKS
+	bool "Number of Tasks Resource Controller"
+	depends on RES_GROUPS
+	default y
+	help
+	  Provides a Resource Controller for Resource Groups that allows
+	  limiting number of tasks a resource group can have.
+
+	  Say N if unsure, Y to use the feature.
+
 endmenu
 config SYSCTL
 	bool "Sysctl support"

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
