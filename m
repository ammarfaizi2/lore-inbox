Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422817AbWBIGMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422817AbWBIGMH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 01:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422818AbWBIGMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 01:12:07 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:61157 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1422817AbWBIGLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 01:11:53 -0500
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Message-Id: <20060209061152.2164.64958.sendpatchset@debian>
In-Reply-To: <20060209061142.2164.35994.sendpatchset@debian>
References: <20060209061142.2164.35994.sendpatchset@debian>
Subject: [PATCH 2/2] connect the CPU resource controller to CKRM
Date: Thu,  9 Feb 2006 15:11:52 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a resource controller for controlling the CPU ratio 
per class in CKRM. It is just an interface to kernel/cpu_rc.c

Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>

---
 Documentation/ckrm/cpurc |   71 +++++++++
 init/Kconfig             |   10 +
 kernel/ckrm/Makefile     |    1 
 kernel/ckrm/ckrm_cpu.c   |  334 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 416 insertions(+)

Index: linux-2.6.15-f0.4-cpurc-v0.3/kernel/ckrm/ckrm_cpu.c
===================================================================
--- /dev/null
+++ linux-2.6.15-f0.4-cpurc-v0.3/kernel/ckrm/ckrm_cpu.c
@@ -0,0 +1,334 @@
+/*
+ *  kernel/ckrm/ckrm_cpu.c
+ *
+ *  CPU resource controller for CKRM
+ *
+ *  Copyright 2005 FUJITSU LIMITED
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
+struct ckrm_cpu {
+	struct ckrm_class *class;	/* the class I belong to */
+	struct ckrm_class *parent;	/* parent of the class above. */
+	struct ckrm_shares shares;
+	spinlock_t cnt_lock;	/* always grab parent's lock before child's */
+	struct cpu_rc	cpu_rc;	/* cpu resource controller */
+	int 	cnt_total_guarantee; 	/* total guarantee behind the class */
+};
+
+static struct cpu_rc_domain grcd; /* system wide resource controller domain */
+static struct ckrm_res_ctlr rcbs; /* resource controller callback structure */
+
+struct cpu_rc *cpu_rc_get(task_t *tsk)
+{
+	struct ckrm_class *class = tsk->class;
+	struct ckrm_cpu *res;
+
+	if (unlikely(class == NULL))
+		return NULL;
+
+	res = ckrm_get_res_class(class, rcbs.resid, struct ckrm_cpu);
+
+	if (unlikely(res == NULL))
+		return NULL;
+
+	return &res->cpu_rc;
+}
+
+static void cpu_rc_set_guarantee(struct ckrm_cpu *res, int val)
+{
+	spin_lock(&res->cpu_rc.rcd->lock);
+	res->cpu_rc.guarantee = val;
+	spin_unlock(&res->cpu_rc.rcd->lock);
+}
+
+static void cpu_res_initcls_one(struct ckrm_cpu * res)
+{
+	res->shares.my_guarantee = 0;
+	res->shares.my_limit = CKRM_SHARE_DONTCARE;
+	res->shares.total_guarantee = CKRM_SHARE_DFLT_TOTAL_GUARANTEE;
+	res->shares.max_limit = CKRM_SHARE_DONTCARE;
+	res->shares.unused_guarantee = CKRM_SHARE_DFLT_TOTAL_GUARANTEE;
+
+	res->cpu_rc.rcd = &grcd;
+	res->cpu_rc.guarantee = 0;
+	res->cpu_rc.ts_factor = CPU_RC_TSFACTOR_MAX;
+	res->cnt_total_guarantee = 0;
+	spin_lock(&res->cpu_rc.rcd->lock);
+	res->cpu_rc.rcd->numcrs++;
+	spin_unlock(&res->cpu_rc.rcd->lock);
+
+	return;
+}
+
+static void *cpu_res_alloc(struct ckrm_class *class,
+				struct ckrm_class *parent)
+{
+	struct ckrm_cpu *res;
+
+	res = kmalloc(sizeof(struct ckrm_cpu), GFP_ATOMIC);
+
+	if (res) {
+		memset(res, 0, sizeof(struct ckrm_cpu));
+		res->class = class;
+		res->parent = parent;
+		cpu_res_initcls_one(res);
+		res->cnt_lock = SPIN_LOCK_UNLOCKED;
+		if (!parent)	{	/* root class */
+			res->cpu_rc.guarantee = CKRM_SHARE_DFLT_TOTAL_GUARANTEE;
+			res->cnt_total_guarantee = CKRM_SHARE_DFLT_TOTAL_GUARANTEE;
+			res->shares.my_guarantee = CKRM_SHARE_DONTCARE;
+		}
+	} else {
+		printk(KERN_ERR
+		       "cpu_res_alloc: failed GFP_ATOMIC alloc\n");
+	}
+	return res;
+}
+
+static void cpu_res_free(void *my_res)
+{
+	struct ckrm_cpu *res = my_res, *parres;
+	u64	temp = 0;
+
+	if (!res)
+		return;
+
+	parres = ckrm_get_res_class(res->parent, rcbs.resid, struct ckrm_cpu);
+	/* return child's guarantee to parent class */
+	spin_lock(&parres->cnt_lock);
+	ckrm_child_guarantee_changed(&parres->shares, res->shares.my_guarantee, 0);
+	if (parres->shares.total_guarantee) {
+		temp = (u64) parres->shares.unused_guarantee
+				* parres->cnt_total_guarantee;
+		do_div(temp, parres->shares.total_guarantee);
+	}
+	cpu_rc_set_guarantee(parres, temp);
+	spin_unlock(&parres->cnt_lock);
+
+	spin_lock(&res->cpu_rc.rcd->lock);
+	res->cpu_rc.is_hungry = 0;
+	res->cpu_rc.rcd->numcrs--;
+	spin_unlock(&res->cpu_rc.rcd->lock);
+	kfree(res);
+	return;
+}
+
+static void
+recalc_and_propagate(struct ckrm_cpu * res)
+{
+	struct ckrm_class *child = NULL;
+	struct ckrm_cpu *parres, *childres;
+	u64	cnt_total = 0,	cnt_guar = 0;
+
+	parres = ckrm_get_res_class(res->parent, rcbs.resid, struct ckrm_cpu);
+
+	if (parres) {
+		struct ckrm_shares *par = &parres->shares;
+		struct ckrm_shares *self = &res->shares;
+
+		/* calculate total and currnet guarantee */
+		if (par->total_guarantee && self->total_guarantee) {
+			cnt_total = (u64) self->my_guarantee
+					 * parres->cnt_total_guarantee;
+			do_div(cnt_total, par->total_guarantee);
+			cnt_guar = (u64) self->unused_guarantee * cnt_total;
+			do_div(cnt_guar, self->total_guarantee);
+		}
+		cpu_rc_set_guarantee(res, (int) cnt_guar);
+		res->cnt_total_guarantee = (int ) cnt_total;
+	}
+
+	/* propagate to children */
+	ckrm_lock_hier(res->class);
+	while ((child = ckrm_get_next_child(res->class, child)) != NULL) {
+		childres =
+			ckrm_get_res_class(child, rcbs.resid, struct ckrm_cpu);
+		if (childres) {
+		    spin_lock(&childres->cnt_lock);
+		    recalc_and_propagate(childres);
+		    spin_unlock(&childres->cnt_lock);
+		}
+	}
+	ckrm_unlock_hier(res->class);
+	return;
+}
+
+static int cpu_set_share_values(void *my_res, struct ckrm_shares *new)
+{
+	struct ckrm_cpu *parres, *res = my_res;
+	struct ckrm_shares *cur = &res->shares, *par;
+	int rc = -EINVAL;
+	u64	temp = 0;
+
+	if (!res)
+		return rc;
+
+	if (res->parent) {
+		parres =
+		   ckrm_get_res_class(res->parent, rcbs.resid, struct ckrm_cpu);
+		spin_lock(&parres->cnt_lock);
+		spin_lock(&res->cnt_lock);
+		par = &parres->shares;
+	} else {
+		spin_lock(&res->cnt_lock);
+		par = NULL;
+		parres = NULL;
+	}
+
+	/* limit is not supported */
+	new->my_limit = new->max_limit = CKRM_SHARE_UNCHANGED;
+
+	rc = ckrm_set_shares(new, cur, par);
+
+	if (rc)
+		goto share_err;
+
+	if (parres) {
+		/* adjust parent's unused guarantee */
+		if (par->total_guarantee) {
+			temp = (u64) par->unused_guarantee
+					* parres->cnt_total_guarantee;
+			do_div(temp, par->total_guarantee);
+		}
+		cpu_rc_set_guarantee(parres, temp);
+	} else {
+		/* adjust root class's unused guarantee */
+		temp = (u64) cur->unused_guarantee
+				* CKRM_SHARE_DFLT_TOTAL_GUARANTEE;
+		do_div(temp, cur->total_guarantee);
+		cpu_rc_set_guarantee(res, temp);
+	}
+	recalc_and_propagate(res);
+
+share_err:
+	spin_unlock(&res->cnt_lock);
+	if (res->parent)
+		spin_unlock(&parres->cnt_lock);
+	return rc;
+}
+
+static int cpu_get_share_values(void *my_res, struct ckrm_shares *shares)
+{
+	struct ckrm_cpu *res = my_res;
+
+	if (!res)
+		return -EINVAL;
+	*shares = res->shares;
+	return 0;
+}
+
+static ssize_t cpu_show_stats(void *my_res, char *buf)
+{
+	struct ckrm_cpu *res = my_res;
+	unsigned int load = 0;
+	ssize_t	i;
+
+	if (!res)
+		return -EINVAL;
+
+	load = cpu_rc_load(&res->cpu_rc);
+	i = sprintf(buf, "cpu:effective_guarantee=%d, load=%d\n",
+			res->cpu_rc.guarantee, load);
+	return i;
+}
+
+static struct ckrm_res_ctlr rcbs = {
+	.res_name = "cpu",
+	.resid = -1,
+	.res_alloc = cpu_res_alloc,
+	.res_free = cpu_res_free,
+	.set_share_values = cpu_set_share_values,
+	.get_share_values = cpu_get_share_values,
+	.show_stats = cpu_show_stats,
+};
+
+static void init_global_rcd(void)
+{
+	grcd.cpus = cpu_online_map;
+	spin_lock_init(&grcd.lock);
+	grcd.hungry_count = 0;
+	grcd.numcpus = cpus_weight(cpu_online_map);
+	grcd.numcrs = 0;
+}
+
+static inline void clear_cpu_rc_stat(struct ckrm_cpu *res, int cpu)
+{
+	if (res == NULL)
+		return;
+
+	res->cpu_rc.stat[cpu].timestamp = 0;
+	res->cpu_rc.stat[cpu].load = 0;
+	res->cpu_rc.stat[cpu].maybe_hungry = 0;
+}
+
+static int __devinit ckrm_cpu_notify(struct notifier_block *self,
+				unsigned long action, void *hcpu)
+{
+	struct ckrm_class *cls = &ckrm_default_class;
+	struct ckrm_class *child = NULL;
+	struct ckrm_cpu *res;
+	int	cpu = (long) hcpu;
+
+	switch (action)	{
+
+	case CPU_DEAD:
+		ckrm_lock_hier(cls);
+		res = ckrm_get_res_class(cls, rcbs.resid, struct ckrm_cpu);
+		clear_cpu_rc_stat(res, cpu);
+		while ((child = ckrm_get_next_child(cls, child)) != NULL) {
+			res = ckrm_get_res_class(child, rcbs.resid,
+							struct ckrm_cpu);
+			spin_lock(&res->cnt_lock);
+			clear_cpu_rc_stat(res, cpu);
+			spin_unlock(&res->cnt_lock);
+		}
+		ckrm_unlock_hier(cls);
+		/* FALL THROUGH */
+	case CPU_UP_PREPARE:
+		grcd.cpus = cpu_online_map;
+		grcd.numcpus = cpus_weight(cpu_online_map);
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block ckrm_cpu_nb = {
+	.notifier_call	= ckrm_cpu_notify,
+};
+
+int __init init_ckrm_cpu_res(void)
+{
+	init_global_rcd();
+	if (rcbs.resid == CKRM_NO_RES)	{
+		ckrm_register_res_ctlr(&rcbs);
+		printk(KERN_INFO
+			 "init_ckrm_cpu_res %d cpus available\n", grcd.numcpus);
+	}
+	/* Register notifier for non-boot CPUs */
+	register_cpu_notifier(&ckrm_cpu_nb);
+	return 0;
+}
+
+void __exit exit_ckrm_cpu_res(void)
+{
+	ckrm_unregister_res_ctlr(&rcbs);
+	unregister_cpu_notifier(&ckrm_cpu_nb);
+}
+
+module_init(init_ckrm_cpu_res)
+module_exit(exit_ckrm_cpu_res)
+
+MODULE_LICENSE("GPL")
Index: linux-2.6.15-f0.4-cpurc-v0.3/init/Kconfig
===================================================================
--- linux-2.6.15-f0.4-cpurc-v0.3.orig/init/Kconfig
+++ linux-2.6.15-f0.4-cpurc-v0.3/init/Kconfig
@@ -197,6 +197,16 @@ config CKRM_RES_NUMTASKS
 
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
Index: linux-2.6.15-f0.4-cpurc-v0.3/kernel/ckrm/Makefile
===================================================================
--- linux-2.6.15-f0.4-cpurc-v0.3.orig/kernel/ckrm/Makefile
+++ linux-2.6.15-f0.4-cpurc-v0.3/kernel/ckrm/Makefile
@@ -4,3 +4,4 @@
 
 obj-y = ckrm.o ckrmutils.o ckrm_tc.o ckrm_iface.o
 obj-$(CONFIG_CKRM_RES_NUMTASKS) += ckrm_numtasks.o
+obj-$(CONFIG_CKRM_RES_CPU) += ckrm_cpu.o
Index: linux-2.6.15-f0.4-cpurc-v0.3/Documentation/ckrm/cpurc
===================================================================
--- /dev/null
+++ linux-2.6.15-f0.4-cpurc-v0.3/Documentation/ckrm/cpurc
@@ -0,0 +1,71 @@
+Introduction
+------------
+
+CPU resource controller enables user/sysadmin to control CPU time
+percentage of tasks in a class. It controls time_slice of tasks based on
+the feedback of difference between the target value and the current usage
+in order to control the percentage of the CPU usage to the target value.
+
+Installation
+------------
+
+1. Configure "CPU Resource Controller" under CKRM. Currently, this cannot be
+   configured as a module.
+
+2. Reboot the system with the new kernel.
+
+3. Verify that the CPU resource controller is present by reading
+   the file /config/ckrm/shares (should show a line with res=cpu).
+
+Assigning shares
+----------------
+
+Follows the general approach of setting shares for a class in CKRM.
+
+# echo "res=cpu,guarantee=val" > shares
+
+sets the guarantee of a class.
+
+The CPU resource controller calculates an effective guarantee in percent
+for each class. The followings is an example of class/guarantee settings
+and each effective guarantee.
+
+				/
+				  effective_guarantee
+				  = 100% - 15% - 30% - 10% - 25%
+				  = 20%
+		+---------------+---------------+
+		/A guarantee=50%		/B guarantee=30%
+		   effective_guarantee		   effective_guarantee
+	    	   = 50% - 10% - 25%	    	   = 30% - 0%
+		   = 15%			   = 30%
++---------------+---------------+
+/C guarantee=20%		/D guarantee=50%
+   effective_guarantee		   effective_guarantee
+   = 20% of 50% - 0% = 10%	   = 50% of 50% - 0 %
+   = 10%			   = 25%
+
+If the guarantee in the class /A is changed 50% to 40% in the above
+example, the effective_guarantee of the class /A, /C and /D are automatically
+changed to 12%, 8% and 20% respectively.
+
+Although the total_guarantee can be changed, the effective_guarantee is
+always calculated in percent.
+
+Note that the CPU resource controller doesn't support the limit, so assigning
+the limit for "res=cpu" is meaningless.
+
+Monitoring
+----------
+
+stats file shows the effective guarantee and the current cpu usage of a class
+in percentage.
+
+# cat stats
+cpu:effective_guarantee=50, load=40
+
+That means the effective guarantee of the class is 50% and the current load
+average of the class is 40%.
+
+Since the tasks in the class do not always try to consume CPU, the load could be
+less or greater than the effective_guarantee. Both cases are normal.
