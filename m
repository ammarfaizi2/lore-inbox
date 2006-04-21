Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWDUC3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWDUC3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWDUC3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:29:21 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:43474 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932123AbWDUC3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:29:03 -0400
From: maeda.naoaki@jp.fujitsu.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: maeda.naoaki@jp.fujitsu.com
Date: Fri, 21 Apr 2006 11:28:08 +0900
Message-Id: <20060421022808.13598.60372.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [RFC][PATCH 8/9] CPU controller - Adds cpu hotplug notifier
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

8/9: ckrm_cpu_hotplug

Adds cpu hotplug notifier for the CKRM CPU controller.

Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>

 kernel/ckrm/ckrm_cpu.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+)

Index: linux-2.6.17-rc2/kernel/ckrm/ckrm_cpu.c
===================================================================
--- linux-2.6.17-rc2.orig/kernel/ckrm/ckrm_cpu.c
+++ linux-2.6.17-rc2/kernel/ckrm/ckrm_cpu.c
@@ -243,12 +243,61 @@ struct ckrm_controller cpu_ctlr = {
 	.show_stats = cpu_show_stats,
 };
 
+static void clear_stat_and_propagate(struct ckrm_cpu * res, int cpu)
+{
+	struct ckrm_class *child = NULL;
+	struct ckrm_cpu *childres;
+
+	cpu_rc_clear_stat(&res->cpu_rc, cpu);
+
+	/* propagate to children */
+	spin_lock(&res->class->class_lock);
+	for_each_child(child, res->class) {
+		childres = get_class_cpu(child);
+		if (childres) {
+		    spin_lock(&child->class_lock);
+		    clear_stat_and_propagate(childres, cpu);
+		    spin_unlock(&child->class_lock);
+		}
+	}
+	spin_unlock(&res->class->class_lock);
+}
+
+static int __devinit ckrm_cpu_notify(struct notifier_block *self,
+				unsigned long action, void *hcpu)
+{
+	struct ckrm_class *cls = &ckrm_default_class;
+	struct ckrm_cpu *res;
+	int	cpu = (long) hcpu;
+
+	switch (action)	{
+
+	case CPU_DEAD:
+		res = get_class_cpu(cls);
+		clear_stat_and_propagate(res, cpu);
+		/* FALL THROUGH */
+	case CPU_ONLINE:
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
 int __init init_ckrm_cpu_res(void)
 {
 	if (cpu_ctlr.ctlr_id != CKRM_NO_RES_ID)
 		return -EBUSY; /* already registered */
 	cpu_rc_init_rcd(&grcd);
 	printk(KERN_INFO "init_ckrm_cpu_res %d cpus available\n", grcd.numcpus);
+	/* Register notifier for non-boot CPUs */
+	register_cpu_notifier(&ckrm_cpu_nb);
 	return ckrm_register_controller(&cpu_ctlr);
 }
 
@@ -259,6 +308,7 @@ void __exit exit_ckrm_cpu_res(void)
 		rc = ckrm_unregister_controller(&cpu_ctlr);
 	} while (rc == -EBUSY);
 	BUG_ON(rc != 0);
+	unregister_cpu_notifier(&ckrm_cpu_nb);
 }
 
 module_init(init_ckrm_cpu_res)
