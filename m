Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264402AbUEDOof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbUEDOof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 10:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbUEDOoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 10:44:34 -0400
Received: from fmr03.intel.com ([143.183.121.5]:43398 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S264392AbUEDOoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 10:44:08 -0400
Date: Tue, 4 May 2004 07:43:53 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, davidm@hpl.hp.com, pj@sgi.com, linux-ia64@vger.kernel.org,
       rusty@rustycorp.com.au
Subject: take3: Updated CPU Hotplug patches for IA64 (pj blessed) Patch [3/7]
Message-ID: <20040504074353.C1909@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Name: sysfs_ia64.patch
Author: Ashok Raj (Intel Corporation)
D: Creation of sysfs via topology_init() creates sysfs entries. The creation of
D: the online control file is created separately when the cpu_up is invoked
D: in arch independent code.
---



---

 linux-2.6.5-lhcs-root/arch/ia64/dig/Makefile   |    5 ++
 linux-2.6.5-lhcs-root/arch/ia64/dig/topology.c |   43 +++++++++++++++++++++++++
 linux-2.6.5-lhcs-root/include/asm-ia64/cpu.h   |   17 +++++++++
 3 files changed, 65 insertions(+)

diff -puN arch/ia64/dig/Makefile~sysfs_ia64 arch/ia64/dig/Makefile
--- linux-2.6.5-lhcs/arch/ia64/dig/Makefile~sysfs_ia64	2004-05-03 16:30:06.886772352 -0700
+++ linux-2.6.5-lhcs-root/arch/ia64/dig/Makefile	2004-05-03 16:30:06.888725478 -0700
@@ -6,4 +6,9 @@
 #
 
 obj-y := setup.o
+
+ifndef CONFIG_NUMA
+obj-$(CONFIG_IA64_DIG) += topology.o
+endif
+
 obj-$(CONFIG_IA64_GENERIC) += machvec.o
diff -puN /dev/null arch/ia64/dig/topology.c
--- /dev/null	2003-09-15 06:02:17.000000000 -0700
+++ linux-2.6.5-lhcs-root/arch/ia64/dig/topology.c	2004-05-03 16:30:06.888725478 -0700
@@ -0,0 +1,43 @@
+/*
+ * arch/ia64/dig/topology.c
+ *	Popuate driverfs with topology information.
+ *	Derived entirely from i386/mach-default.c
+ *  Intel Corporation - Ashok Raj
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/cpumask.h>
+#include <linux/percpu.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+#include <asm/cpu.h>
+
+static DEFINE_PER_CPU(struct ia64_cpu, cpu_devices);
+
+/*
+ * First Pass: simply borrowed code for now. Later should hook into
+ * hotplug notification for node/cpu/memory as applicable
+ */
+
+static int arch_register_cpu(int num)
+{
+	struct node *parent = NULL;
+
+#ifdef CONFIG_NUMA
+	//parent = &node_devices[cpu_to_node(num)].node;
+#endif
+
+	return register_cpu(&per_cpu(cpu_devices,num).cpu, num, parent);
+}
+
+static int __init topology_init(void)
+{
+    int i;
+
+    for_each_cpu(i) {
+        arch_register_cpu(i);
+	}
+    return 0;
+}
+
+subsys_initcall(topology_init);
diff -puN /dev/null include/asm-ia64/cpu.h
--- /dev/null	2003-09-15 06:02:17.000000000 -0700
+++ linux-2.6.5-lhcs-root/include/asm-ia64/cpu.h	2004-05-03 16:30:06.888725478 -0700
@@ -0,0 +1,17 @@
+#ifndef _ASM_IA64_CPU_H_
+#define _ASM_IA64_CPU_H_
+
+#include <linux/device.h>
+#include <linux/cpu.h>
+#include <linux/topology.h>
+#include <linux/percpu.h>
+
+struct ia64_cpu {
+	struct cpu cpu;
+};
+
+DECLARE_PER_CPU(struct ia64_cpu, cpu_devices);
+
+DECLARE_PER_CPU(int, cpu_state);
+
+#endif /* _ASM_IA64_CPU_H_ */

_
