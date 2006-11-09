Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWKITgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWKITgR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWKITgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:36:00 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:10119 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1030388AbWKITf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:35:57 -0500
From: Balbir Singh <balbir@in.ibm.com>
To: Linux MM <linux-mm@kvack.org>
Cc: dev@openvz.org, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       haveblue@us.ibm.com, rohitseth@google.com,
       Balbir Singh <balbir@in.ibm.com>
Date: Fri, 10 Nov 2006 01:05:41 +0530
Message-Id: <20061109193541.21437.8046.sendpatchset@balbir.in.ibm.com>
In-Reply-To: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
Subject: [RFC][PATCH 2/8] RSS controller setup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Basic setup for a controller written for resource groups. This patch
registers a dummy controller.


Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/linux/memctlr.h    |   31 ++++++++++++++
 init/Kconfig               |   11 +++++
 kernel/res_group/Makefile  |    1 
 kernel/res_group/memctlr.c |   94 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+)

diff -puN /dev/null include/linux/memctlr.h
--- /dev/null	2006-05-31 06:45:07.000000000 +0530
+++ linux-2.6.19-rc2-balbir/include/linux/memctlr.h	2006-11-09 23:56:03.000000000 +0530
@@ -0,0 +1,31 @@
+/*
+ * Memory controller - "Account and Control Memory Usage"
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * Author: Balbir Singh <balbir@in.ibm.com>
+ *
+ */
+
+#ifndef _LINUX_MEMCTRL_H
+#define _LINUX_MEMCTRL_H
+
+#ifdef CONFIG_RES_GROUPS_MEMORY
+#include <linux/res_group_rc.h>
+#endif /* CONFIG_RES_GROUPS_MEMORY */
+
+#endif /* _LINUX_MEMCTRL_H */
diff -puN init/Kconfig~container-memctlr-setup init/Kconfig
--- linux-2.6.19-rc2/init/Kconfig~container-memctlr-setup	2006-11-09 23:09:03.000000000 +0530
+++ linux-2.6.19-rc2-balbir/init/Kconfig	2006-11-09 23:56:47.000000000 +0530
@@ -325,6 +325,17 @@ config RES_GROUPS_NUMTASKS
 
 	  Say N if unsure, Y to use the feature.
 
+config RES_GROUPS_MEMORY
+	bool "Memory Controller for RSS"
+	depends on RES_GROUPS
+	default y
+	help
+	  Provides a Resource Controller for Resource Groups.
+	  It limits the resident pages of the tasks belonging to the resource
+	  group.
+
+	  Say N if unsure, Y to use the feature.
+
 endmenu
 config SYSCTL
 	bool
diff -puN kernel/res_group/Makefile~container-memctlr-setup kernel/res_group/Makefile
--- linux-2.6.19-rc2/kernel/res_group/Makefile~container-memctlr-setup	2006-11-09 23:09:03.000000000 +0530
+++ linux-2.6.19-rc2-balbir/kernel/res_group/Makefile	2006-11-09 23:09:03.000000000 +0530
@@ -1,2 +1,3 @@
 obj-y = res_group.o shares.o rgcs.o
 obj-$(CONFIG_RES_GROUPS_NUMTASKS) += numtasks.o
+obj-$(CONFIG_RES_GROUPS_MEMORY) += memctlr.o
diff -puN /dev/null kernel/res_group/memctlr.c
--- /dev/null	2006-05-31 06:45:07.000000000 +0530
+++ linux-2.6.19-rc2-balbir/kernel/res_group/memctlr.c	2006-11-09 23:56:03.000000000 +0530
@@ -0,0 +1,94 @@
+/*
+ * Memory controller - "Account and Control Memory Usage"
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * Author: Balbir Singh <balbir@in.ibm.com>
+ *
+ */
+
+/*
+ * Simple memory controller.
+ * Supports limits, guarantees not supported right now
+ *
+ * Tasks are group'ed virtually by thread groups - Add more details
+ */
+
+#include <linux/module.h>
+#include <linux/res_group_rc.h>
+#include <linux/memctlr.h>
+
+static const char res_ctlr_name[] = "memctlr";
+static struct resource_group *root_rgroup;
+
+struct mem_counter {
+	atomic_long_t	rss;
+};
+
+struct memctlr {
+	struct resource_group *rgroup;		/* My resource group	*/
+	struct res_shares shares;		/* My shares		*/
+
+	struct mem_counter counter;		/* Accounting information */
+	/* Statistics */
+	int successes;
+	int failures;
+};
+
+struct res_controller memctlr_rg;
+
+static struct memctlr *get_memctlr_from_shares(struct res_shares *shares)
+{
+	if (shares)
+		return container_of(shares, struct memctlr, shares);
+	return NULL;
+}
+
+static struct memctlr *get_memctlr(struct resource_group *rgroup)
+{
+	return get_memctlr_from_shares(get_controller_shares(rgroup,
+								&memctlr_rg));
+}
+
+struct res_controller memctlr_rg = {
+	.name = res_ctlr_name,
+	.ctlr_id = NO_RES_ID,
+	.alloc_shares_struct = NULL,
+	.free_shares_struct = NULL,
+	.move_task = NULL,
+	.shares_changed = NULL,
+	.show_stats = NULL,
+};
+
+int __init memctlr_init(void)
+{
+	if (memctlr_rg.ctlr_id != NO_RES_ID)
+		return -EBUSY;	/* already registered */
+	return register_controller(&memctlr_rg);
+}
+
+void __exit memctlr_exit(void)
+{
+	int rc;
+	do {
+		rc = unregister_controller(&memctlr_rg);
+	} while (rc == -EBUSY);
+	BUG_ON(rc != 0);
+}
+
+module_init(memctlr_init);
+module_exit(memctlr_exit);
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
