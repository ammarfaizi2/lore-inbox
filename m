Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWD1BjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWD1BjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWD1Bio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:38:44 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:54434 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030265AbWD1Bia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:38:30 -0400
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Date: Fri, 28 Apr 2006 10:38:01 +0900
Message-Id: <20060428013801.9582.56264.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [PATCH 6/9] CPU controller - Add basic functions and registering the controller
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

6/9: cpu_init

Adds the basic functions and registering the CPU controller to resource group.

Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>

 init/Kconfig              |   10 +++
 kernel/res_group/Makefile |    1 
 kernel/res_group/cpu.c    |  142 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)

Index: linux-2.6.17-rc3/init/Kconfig
===================================================================
--- linux-2.6.17-rc3.orig/init/Kconfig
+++ linux-2.6.17-rc3/init/Kconfig
@@ -185,6 +185,16 @@ config RES_GROUPS_NUMTASKS
 
 	  Say N if unsure, Y to use the feature.
 
+config RES_GROUPS_CPU
+	bool "CPU Resource Controller"
+	select CPU_RC
+	depends on RES_GROUPS
+	default y
+	help
+	  Provides a CPU Resource Controller for Resource Groups.
+
+	  Say N if unsure, Y to use the feature.
+
 endmenu
 config SYSCTL
 	bool "Sysctl support"
Index: linux-2.6.17-rc3/kernel/res_group/Makefile
===================================================================
--- linux-2.6.17-rc3.orig/kernel/res_group/Makefile
+++ linux-2.6.17-rc3/kernel/res_group/Makefile
@@ -1,3 +1,4 @@
 obj-y = res_group.o shares.o task.o
 obj-$(CONFIG_RES_GROUPS_NUMTASKS) += numtasks.o
+obj-$(CONFIG_RES_GROUPS_CPU) += cpu.o
 obj-$(CONFIG_RGCS) += rgcs.o
Index: linux-2.6.17-rc3/kernel/res_group/cpu.c
===================================================================
--- /dev/null
+++ linux-2.6.17-rc3/kernel/res_group/cpu.c
@@ -0,0 +1,142 @@
+/*
+ *  kernel/res_group/cpu.c
+ *
+ *  CPU resource controller for Resource Groups
+ *
+ *  Copyright 2005-2006 FUJITSU LIMITED
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of the Linux
+ *  distribution for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+#include <linux/cpu_rc.h>
+#include <linux/res_group_rc.h>
+
+static const char res_ctlr_name[] = "cpu";
+
+struct cpu_res {
+	struct resource_group *rgroup;	/* resouce group I belong to */
+	struct res_shares shares;
+	struct cpu_rc	cpu_rc;	/* cpu resource controller */
+	int 	cnt_total_min_shares;/* total min_shares behind the res_group */
+};
+
+static struct cpu_rc_domain grcd; /* system wide resource controller domain */
+struct res_controller cpu_ctlr;
+
+static struct cpu_res *get_shares_cpu(struct res_shares *shares)
+{
+	if (shares)
+		return container_of(shares, struct cpu_res, shares);
+	return NULL;
+}
+
+static struct cpu_res *get_res_group_cpu(struct resource_group *rgroup)
+{
+	return get_shares_cpu(get_controller_shares(rgroup, &cpu_ctlr));
+}
+
+struct cpu_rc *cpu_rc_get(task_t *tsk)
+{
+	struct resoruce_group *rgroup = tsk->res_group;
+	struct cpu_res *res;
+
+	/* controller is not registered; no resource group is given */
+	if ((cpu_ctlr.ctlr_id == NO_RES_ID) || (rgroup == NULL))
+		return NULL;
+
+	res = get_res_group_cpu(rgroup);
+	/* cpu controller is not available for this resource group */
+	if (!res)
+		return NULL;
+
+	return &res->cpu_rc;
+}
+
+static void cpu_res_init_one(struct cpu_res *cpu_res)
+{
+	cpu_res->shares.min_shares = 0;
+	cpu_res->shares.max_shares = SHARE_UNSUPPORTED;
+	cpu_res->shares.child_shares_divisor = SHARE_DEFAULT_DIVISOR;
+	cpu_res->shares.unused_min_shares = SHARE_DEFAULT_DIVISOR;
+
+	cpu_res->cnt_total_min_shares = 0;
+	cpu_rc_init_cr(&cpu_res->cpu_rc, &grcd);
+	cpu_rc_get_cr(&cpu_res->cpu_rc);
+}
+
+static struct res_shares *cpu_alloc_shares_struct(
+						struct resource_group *rgroup)
+{
+	struct cpu_res *res;
+
+	res = kzalloc(sizeof(struct cpu), GFP_KERNEL);
+	if (!res)
+		return NULL;
+	res->rgroup = rgroup;
+	cpu_res_init_one(res);
+	if (is_res_group_root(rgroup))	{
+		res->cpu_rc.share = SHARE_DEFAULT_DIVISOR;
+		res->cnt_total_min_shares = SHARE_DEFAULT_DIVISOR;
+		res->shares.min_shares = SHARE_DONT_CARE;
+		res->shares.max_shares = SHARE_DONT_CARE;
+	}
+	return &res->shares;
+}
+
+static void cpu_free_shares_struct(struct res_shares *my_res)
+{
+	struct cpu_res *res, *parres;
+	u64	temp = 0;
+
+	res = get_shares_cpu(my_res);
+	if (!res)
+		return;
+
+	parres = get_res_group_cpu(res->rgroup->parent);
+	/* return child's min_shares to parent resource group */
+	spin_lock(&parres->rgroup->group_lock);
+	if (parres->shares.child_shares_divisor) {
+		temp = (u64) parres->shares.unused_min_shares
+				* parres->cnt_total_min_shares;
+		do_div(temp, parres->shares.child_shares_divisor);
+	}
+	cpu_rc_set_share(&parres->cpu_rc, (int)temp);
+	spin_unlock(&parres->rgroup->group_lock);
+
+	cpu_rc_put_cr(&res->cpu_rc);
+	kfree(res);
+}
+
+struct res_controller cpu_ctlr = {
+	.name = res_ctlr_name,
+	.depth_supported = 3,
+	.ctlr_id = NO_RES_ID,
+	.alloc_shares_struct = cpu_alloc_shares_struct,
+	.free_shares_struct = cpu_free_shares_struct,
+};
+
+int __init init_cpu_res(void)
+{
+	if (cpu_ctlr.ctlr_id != NO_RES_ID)
+		return -EBUSY; /* already registered */
+	cpu_rc_init_rcd(&grcd);
+	return register_controller(&cpu_ctlr);
+}
+
+void __exit exit_cpu_res(void)
+{
+	int rc;
+	do {
+		rc = unregister_controller(&cpu_ctlr);
+	} while (rc == -EBUSY);
+	BUG_ON(rc != 0);
+}
+
+module_init(init_cpu_res)
+module_exit(exit_cpu_res)
