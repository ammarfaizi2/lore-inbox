Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWDUCau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWDUCau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWDUC2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:28:49 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:16869 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932126AbWDUC2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:28:11 -0400
From: maeda.naoaki@jp.fujitsu.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: maeda.naoaki@jp.fujitsu.com
Date: Fri, 21 Apr 2006 11:27:58 +0900
Message-Id: <20060421022758.13598.56871.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [RFC][PATCH 6/9] CPU controller - Adds basic functions and registering the controller
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

6/9: ckrm_cpu_init

Adds the basic functions and registering the CPU controller to CKRM.

Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>

 init/Kconfig           |   10 +++
 kernel/ckrm/Makefile   |    1 
 kernel/ckrm/ckrm_cpu.c |  142 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)

Index: linux-2.6.17-rc2/init/Kconfig
===================================================================
--- linux-2.6.17-rc2.orig/init/Kconfig
+++ linux-2.6.17-rc2/init/Kconfig
@@ -185,6 +185,16 @@ config CKRM_RES_NUMTASKS
 
 	  Say N if unsure, Y to use the feature.
 
+config CKRM_RES_CPU
+	bool "CPU Resource Controller"
+	select CPU_RC
+	depends on CKRM
+	default y
+	help
+	  Provides a CPU Resource Controller for CKRM.
+
+	  Say N if unsure, Y to use the feature.
+
 endmenu
 config SYSCTL
 	bool "Sysctl support"
Index: linux-2.6.17-rc2/kernel/ckrm/Makefile
===================================================================
--- linux-2.6.17-rc2.orig/kernel/ckrm/Makefile
+++ linux-2.6.17-rc2/kernel/ckrm/Makefile
@@ -1,3 +1,4 @@
 obj-y = ckrm.o ckrm_shares.o ckrm_task.o
 obj-$(CONFIG_CKRM_RES_NUMTASKS) += ckrm_numtasks.o
+obj-$(CONFIG_CKRM_RES_CPU) += ckrm_cpu.o
 obj-$(CONFIG_CKRM_RCFS) += ckrm_rcfs.o
Index: linux-2.6.17-rc2/kernel/ckrm/ckrm_cpu.c
===================================================================
--- /dev/null
+++ linux-2.6.17-rc2/kernel/ckrm/ckrm_cpu.c
@@ -0,0 +1,142 @@
+/*
+ *  kernel/ckrm/ckrm_cpu.c
+ *
+ *  CPU resource controller for CKRM
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
+#include <linux/ckrm_rc.h>
+
+static const char res_ctlr_name[] = "cpu";
+
+struct ckrm_cpu {
+	struct ckrm_class *class;	/* the class I belong to */
+	struct ckrm_shares shares;
+	struct cpu_rc	cpu_rc;	/* cpu resource controller */
+	int 	cnt_total_min_shares; 	/* total min_shares behind the class */
+};
+
+static struct cpu_rc_domain grcd; /* system wide resource controller domain */
+struct ckrm_controller cpu_ctlr;
+
+static struct ckrm_cpu *get_shares_cpu(struct ckrm_shares *shares)
+{
+	if (shares)
+		return container_of(shares, struct ckrm_cpu, shares);
+	return NULL;
+}
+
+static struct ckrm_cpu *get_class_cpu(struct ckrm_class *class)
+{
+	return get_shares_cpu(ckrm_get_controller_shares(class, &cpu_ctlr));
+}
+
+struct cpu_rc *cpu_rc_get(task_t *tsk)
+{
+	struct ckrm_class *class = tsk->class;
+	struct ckrm_cpu *res;
+
+	/* controller is not registered; no class is given */
+	if ((cpu_ctlr.ctlr_id == CKRM_NO_RES_ID) || (class == NULL))
+		return NULL;
+
+	res = get_class_cpu(class);
+	/* cpu controller is not available for this class */
+	if (!res)
+		return NULL;
+
+	return &res->cpu_rc;
+}
+
+static void cpu_res_initcls_one(struct ckrm_cpu * res)
+{
+	res->shares.min_shares = 0;
+	res->shares.max_shares = CKRM_SHARE_UNSUPPORTED;
+	res->shares.child_shares_divisor = CKRM_SHARE_DEFAULT_DIVISOR;
+	res->shares.unused_min_shares = CKRM_SHARE_DEFAULT_DIVISOR;
+
+	res->cnt_total_min_shares = 0;
+	cpu_rc_init_cr(&res->cpu_rc, &grcd);
+	cpu_rc_get_cr(&res->cpu_rc);
+}
+
+static struct ckrm_shares *cpu_alloc_shares_struct(struct ckrm_class *class)
+{
+	struct ckrm_cpu *res;
+
+	res = kzalloc(sizeof(struct ckrm_cpu), GFP_KERNEL);
+	if (!res)
+		return NULL;
+	res->class = class;
+	cpu_res_initcls_one(res);
+	if (ckrm_is_class_root(class))	{
+		res->cpu_rc.share = CKRM_SHARE_DEFAULT_DIVISOR;
+		res->cnt_total_min_shares = CKRM_SHARE_DEFAULT_DIVISOR;
+		res->shares.min_shares = CKRM_SHARE_DONT_CARE;
+		res->shares.max_shares = CKRM_SHARE_DONT_CARE;
+	}
+	return &res->shares;
+}
+
+static void cpu_free_shares_struct(struct ckrm_shares *my_res)
+{
+	struct ckrm_cpu *res, *parres;
+	u64	temp = 0;
+
+	res = get_shares_cpu(my_res);
+	if (!res)
+		return;
+
+	parres = get_class_cpu(res->class->parent);
+	/* return child's min_shares to parent class */
+	spin_lock(&parres->class->class_lock);
+	if (parres->shares.child_shares_divisor) {
+		temp = (u64) parres->shares.unused_min_shares
+				* parres->cnt_total_min_shares;
+		do_div(temp, parres->shares.child_shares_divisor);
+	}
+	cpu_rc_set_share(&parres->cpu_rc, (int)temp);
+	spin_unlock(&parres->class->class_lock);
+
+	cpu_rc_put_cr(&res->cpu_rc);
+	kfree(res);
+}
+
+struct ckrm_controller cpu_ctlr = {
+	.name = res_ctlr_name,
+	.depth_supported = 3,
+	.ctlr_id = CKRM_NO_RES_ID,
+	.alloc_shares_struct = cpu_alloc_shares_struct,
+	.free_shares_struct = cpu_free_shares_struct,
+};
+
+int __init init_ckrm_cpu_res(void)
+{
+	if (cpu_ctlr.ctlr_id != CKRM_NO_RES_ID)
+		return -EBUSY; /* already registered */
+	cpu_rc_init_rcd(&grcd);
+	printk(KERN_INFO "init_ckrm_cpu_res %d cpus available\n", grcd.numcpus);
+	return ckrm_register_controller(&cpu_ctlr);
+}
+
+void __exit exit_ckrm_cpu_res(void)
+{
+	int rc;
+	do {
+		rc = ckrm_unregister_controller(&cpu_ctlr);
+	} while (rc == -EBUSY);
+	BUG_ON(rc != 0);
+}
+
+module_init(init_ckrm_cpu_res)
+module_exit(exit_ckrm_cpu_res)
