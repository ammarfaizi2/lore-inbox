Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWD1BjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWD1BjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWD1Biq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:38:46 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:53922 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030264AbWD1Bi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:38:29 -0400
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Date: Fri, 28 Apr 2006 10:38:12 +0900
Message-Id: <20060428013812.9582.20493.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [PATCH 8/9] CPU controller - Add cpu hotplug support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

8/9: cpu_hotplug

Adds cpu hotplug notifier for the Resouce Groups CPU controller.

Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>

 kernel/res_group/cpu.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+)

Index: linux-2.6.17-rc3/kernel/res_group/cpu.c
===================================================================
--- linux-2.6.17-rc3.orig/kernel/res_group/cpu.c
+++ linux-2.6.17-rc3/kernel/res_group/cpu.c
@@ -231,6 +231,50 @@ static ssize_t cpu_show_stats(struct res
 	return i;
 }
 
+static void clear_stat_and_propagate(struct cpu_res * res, int cpu)
+{
+	struct resource_group *child = NULL;
+	struct cpu_res *childres;
+
+	cpu_rc_clear_stat(&res->cpu_rc, cpu);
+
+	/* propagate to children */
+	spin_lock(&res->rgroup->group_lock);
+	for_each_child(child, res->rgroup) {
+		childres = get_res_group_cpu(child);
+		if (childres)
+			clear_stat_and_propagate(childres, cpu);
+	}
+	spin_unlock(&res->rgroup->group_lock);
+}
+
+static int __devinit cpu_notify(struct notifier_block *self,
+				unsigned long action, void *hcpu)
+{
+	struct resource_group *root = &default_res_group;
+	struct cpu_res *res;
+	int	cpu = (long) hcpu;
+
+	switch (action)	{
+
+	case CPU_DEAD:
+		res = get_res_group_cpu(root);
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
+static struct notifier_block cpu_nb = {
+	.notifier_call	= cpu_notify,
+};
+
 struct res_controller cpu_ctlr = {
 	.name = res_ctlr_name,
 	.depth_supported = 3,
@@ -246,6 +290,8 @@ int __init init_cpu_res(void)
 	if (cpu_ctlr.ctlr_id != NO_RES_ID)
 		return -EBUSY; /* already registered */
 	cpu_rc_init_rcd(&grcd);
+ 	/* Register notifier for hot plugged/unplugged CPUs */
+ 	register_cpu_notifier(&cpu_nb);
 	return register_controller(&cpu_ctlr);
 }
 
@@ -256,6 +302,7 @@ void __exit exit_cpu_res(void)
 		rc = unregister_controller(&cpu_ctlr);
 	} while (rc == -EBUSY);
 	BUG_ON(rc != 0);
+	unregister_cpu_notifier(&cpu_nb);
 }
 
 module_init(init_cpu_res)
