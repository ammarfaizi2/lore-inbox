Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263073AbVCQLqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbVCQLqj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263043AbVCQLqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:46:18 -0500
Received: from ozlabs.org ([203.10.76.45]:34965 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263053AbVCQKpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:45:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16953.24568.732871.914505@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 21:46:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Nathan Lynch <ntl@pobox.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] PPC64 use pSeries reconfig notifier for cpu DLPAR
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pSeries_reconfig notifier API to handle processor addition and
removal on pSeries LPAR.  This is the "right" way to do it, as opposed
to setting cpu_present_map = cpu_possible_map at boot (this is fixed
in a following patch).

Signed-off-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

 arch/ppc64/kernel/pSeries_smp.c |  126 ++++++++++++++++++++
 1 files changed, 126 insertions(+)

Index: linux-2.6.11-bk10/arch/ppc64/kernel/pSeries_smp.c
===================================================================
--- linux-2.6.11-bk10.orig/arch/ppc64/kernel/pSeries_smp.c	2005-03-14 21:28:14.000000000 +0000
+++ linux-2.6.11-bk10/arch/ppc64/kernel/pSeries_smp.c	2005-03-14 22:29:53.000000000 +0000
@@ -44,6 +44,7 @@
 #include <asm/system.h>
 #include <asm/rtas.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/pSeries_reconfig.h>
 
 #include "mpic.h"
 
@@ -213,6 +214,127 @@ static inline int __devinit smp_startup_
 	}
 	return 1;
 }
+
+/*
+ * Update cpu_present_map and paca(s) for a new cpu node.  The wrinkle
+ * here is that a cpu device node may represent up to two logical cpus
+ * in the SMT case.  We must honor the assumption in other code that
+ * the logical ids for sibling SMT threads x and y are adjacent, such
+ * that x^1 == y and y^1 == x.
+ */
+static int pSeries_add_processor(struct device_node *np)
+{
+	unsigned int cpu;
+	cpumask_t candidate_map, tmp = CPU_MASK_NONE;
+	int err = -ENOSPC, len, nthreads, i;
+	u32 *intserv;
+
+	intserv = (u32 *)get_property(np, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv)
+		return 0;
+
+	nthreads = len / sizeof(u32);
+	for (i = 0; i < nthreads; i++)
+		cpu_set(i, tmp);
+
+	lock_cpu_hotplug();
+
+	BUG_ON(!cpus_subset(cpu_present_map, cpu_possible_map));
+
+	/* Get a bitmap of unoccupied slots. */
+	cpus_xor(candidate_map, cpu_possible_map, cpu_present_map);
+	if (cpus_empty(candidate_map)) {
+		/* If we get here, it most likely means that NR_CPUS is
+		 * less than the partition's max processors setting.
+		 */
+		printk(KERN_ERR "Cannot add cpu %s; this system configuration"
+		       " supports %d logical cpus.\n", np->full_name,
+		       cpus_weight(cpu_possible_map));
+		goto out_unlock;
+	}
+
+	while (!cpus_empty(tmp))
+		if (cpus_subset(tmp, candidate_map))
+			/* Found a range where we can insert the new cpu(s) */
+			break;
+		else
+			cpus_shift_left(tmp, tmp, nthreads);
+
+	if (cpus_empty(tmp)) {
+		printk(KERN_ERR "Unable to find space in cpu_present_map for"
+		       " processor %s with %d thread(s)\n", np->name,
+		       nthreads);
+		goto out_unlock;
+	}
+
+	for_each_cpu_mask(cpu, tmp) {
+		BUG_ON(cpu_isset(cpu, cpu_present_map));
+		cpu_set(cpu, cpu_present_map);
+		set_hard_smp_processor_id(cpu, *intserv++);
+	}
+	err = 0;
+out_unlock:
+	unlock_cpu_hotplug();
+	return err;
+}
+
+/*
+ * Update the present map for a cpu node which is going away, and set
+ * the hard id in the paca(s) to -1 to be consistent with boot time
+ * convention for non-present cpus.
+ */
+static void pSeries_remove_processor(struct device_node *np)
+{
+	unsigned int cpu;
+	int len, nthreads, i;
+	u32 *intserv;
+
+	intserv = (u32 *)get_property(np, "ibm,ppc-interrupt-server#s", &len);
+	if (!intserv)
+		return;
+
+	nthreads = len / sizeof(u32);
+
+	lock_cpu_hotplug();
+	for (i = 0; i < nthreads; i++) {
+		for_each_present_cpu(cpu) {
+			if (get_hard_smp_processor_id(cpu) != intserv[i])
+				continue;
+			BUG_ON(cpu_online(cpu));
+			cpu_clear(cpu, cpu_present_map);
+			set_hard_smp_processor_id(cpu, -1);
+			break;
+		}
+		if (cpu == NR_CPUS)
+			printk(KERN_WARNING "Could not find cpu to remove "
+			       "with physical id 0x%x\n", intserv[i]);
+	}
+	unlock_cpu_hotplug();
+}
+
+static int pSeries_smp_notifier(struct notifier_block *nb, unsigned long action, void *node)
+{
+	int err = NOTIFY_OK;
+
+	switch (action) {
+	case PSERIES_RECONFIG_ADD:
+		if (pSeries_add_processor(node))
+			err = NOTIFY_BAD;
+		break;
+	case PSERIES_RECONFIG_REMOVE:
+		pSeries_remove_processor(node);
+		break;
+	default:
+		err = NOTIFY_DONE;
+		break;
+	}
+	return err;
+}
+
+static struct notifier_block pSeries_smp_nb = {
+	.notifier_call = pSeries_smp_notifier,
+};
+
 #else /* ... CONFIG_HOTPLUG_CPU */
 static inline int __devinit smp_startup_cpu(unsigned int lcpu)
 {
@@ -336,6 +458,10 @@ void __init smp_init_pSeries(void)
 #ifdef CONFIG_HOTPLUG_CPU
 	smp_ops->cpu_disable = pSeries_cpu_disable;
 	smp_ops->cpu_die = pSeries_cpu_die;
+
+	/* Processors can be added/removed only on LPAR */
+	if (systemcfg->platform == PLATFORM_PSERIES_LPAR)
+		pSeries_reconfig_notifier_register(&pSeries_smp_nb);
 #endif
 
 	/* Start secondary threads on SMT systems; primary threads
