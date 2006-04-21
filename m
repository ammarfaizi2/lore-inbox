Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWDUC1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWDUC1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWDUC0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:26:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:57040 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750959AbWDUCZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:25:27 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:25:25 -0700
Message-Id: <20060421022525.6145.81708.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022519.6145.78248.sendpatchset@localhost.localdomain>
References: <20060421022519.6145.78248.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 1/6] numtasks - Initialization routines
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1/6: ckrm_numtasks_init

Hooks up with CKRM core by defining the basic alloc/free functions and
registering the controller with the core.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 init/Kconfig                |   10 ++++
 kernel/ckrm/Makefile        |    1 
 kernel/ckrm/ckrm_numtasks.c |   90 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

Index: linux2617-rc2/kernel/ckrm/Makefile
===================================================================
--- linux2617-rc2.orig/kernel/ckrm/Makefile
+++ linux2617-rc2/kernel/ckrm/Makefile
@@ -1,2 +1,3 @@
 obj-y = ckrm.o ckrm_shares.o ckrm_task.o
+obj-$(CONFIG_CKRM_RES_NUMTASKS) += ckrm_numtasks.o
 obj-$(CONFIG_CKRM_RCFS) += ckrm_rcfs.o
Index: linux2617-rc2/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- /dev/null
+++ linux2617-rc2/kernel/ckrm/ckrm_numtasks.c
@@ -0,0 +1,90 @@
+/* ckrm_numtasks.c - "Number of tasks" resource controller for CKRM
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
+ * CKRM Resource controller for tracking number of tasks in a class.
+ */
+#include <linux/module.h>
+#include <linux/ckrm_rc.h>
+
+static const char res_ctlr_name[] = "numtasks";
+
+struct ckrm_numtasks {
+	struct ckrm_shares shares;
+};
+
+struct ckrm_controller numtasks_ctlr;
+
+static struct ckrm_numtasks *get_shares_numtasks(struct ckrm_shares *shares)
+{
+	if (shares)
+		return container_of(shares, struct ckrm_numtasks, shares);
+	return NULL;
+}
+
+/* Initialize share struct values */
+static void numtasks_res_init_one(struct ckrm_numtasks *numtasks_res)
+{
+	numtasks_res->shares.min_shares = CKRM_SHARE_DONT_CARE;
+	numtasks_res->shares.max_shares = CKRM_SHARE_DONT_CARE;
+	numtasks_res->shares.child_shares_divisor = CKRM_SHARE_DEFAULT_DIVISOR;
+	numtasks_res->shares.unused_min_shares = CKRM_SHARE_DEFAULT_DIVISOR;
+}
+
+static struct ckrm_shares *numtasks_alloc_shares_struct(
+						struct ckrm_class *class)
+{
+	struct ckrm_numtasks *res;
+
+	res = kzalloc(sizeof(struct ckrm_numtasks), GFP_KERNEL);
+	if (!res)
+		return NULL;
+	numtasks_res_init_one(res);
+	return &res->shares;
+}
+
+/*
+ * No locking of this resource class object necessary as we are not
+ * supposed to be assigned (or used) when/after this function is called.
+ */
+static void numtasks_free_shares_struct(struct ckrm_shares *my_res)
+{
+	kfree(get_shares_numtasks(my_res));
+}
+
+struct ckrm_controller numtasks_ctlr = {
+	.name = res_ctlr_name,
+	.depth_supported = 3,
+	.ctlr_id = CKRM_NO_RES_ID,
+	.alloc_shares_struct = numtasks_alloc_shares_struct,
+	.free_shares_struct = numtasks_free_shares_struct,
+};
+
+int __init init_ckrm_numtasks_res(void)
+{
+	if (numtasks_ctlr.ctlr_id != CKRM_NO_RES_ID)
+		return -EBUSY; /* already registered */
+	return ckrm_register_controller(&numtasks_ctlr);
+}
+
+void __exit exit_ckrm_numtasks_res(void)
+{
+	int rc;
+	do {
+		rc = ckrm_unregister_controller(&numtasks_ctlr);
+	} while (rc == -EBUSY);
+	BUG_ON(rc != 0);
+}
+module_init(init_ckrm_numtasks_res)
+module_exit(exit_ckrm_numtasks_res)
Index: linux2617-rc2/init/Kconfig
===================================================================
--- linux2617-rc2.orig/init/Kconfig
+++ linux2617-rc2/init/Kconfig
@@ -175,6 +175,16 @@ config CKRM_RCFS
 	  Say M if unsure, Y to save on module loading. N doesn't make sense
 	  when CKRM has been configured.
 
+config CKRM_RES_NUMTASKS
+	bool "Number of Tasks Resource Manager"
+	depends on CKRM
+	default y
+	help
+	  Provides a Resource Controller for CKRM that allows limiting no of
+	  tasks a task class can have.
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
