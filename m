Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269093AbUIXXmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269093AbUIXXmy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269088AbUIXXmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:42:54 -0400
Received: from fmr03.intel.com ([143.183.121.5]:35989 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269077AbUIXXkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 19:40:31 -0400
Date: Fri, 24 Sep 2004 16:40:14 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[4/6]-Dynamic cpu register/unregister support
Message-ID: <20040924164014.D27778@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <20040920094106.F14208@unix-os.sc.intel.com> <20040922173400.4e717946.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040922173400.4e717946.tokunaga.keiich@jp.fujitsu.com>; from tokunaga.keiich@jp.fujitsu.com on Wed, Sep 22, 2004 at 05:34:00PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 05:34:00PM +0900, Keiichiro Tokunaga wrote:
> On Mon, 20 Sep 2004 09:41:07 -0700 Keshavamurthy Anil S wrote:
> I don't think that the check 'if (node_online(node))' is necessary
> because sysfs_nodes[node] is there no matter if the node is online
> or offline.  sysfs_nodes[] is cleared only when unregister_node()
> is called and it would be always called after unregister_cpu().

Refreshed this patch to address the above issues. Please let me know if you see
any other issue with this patch.


---
Name:topology.patch
Status:Tested on 2.6.9-rc2
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Depends:	
Version: applies on 2.6.9-rc2	
Description:
Extends support for dynamic registration and unregistration of the cpu,
by implementing and exporting arch_register_cpu()/arch_unregister_cpu().
Also combines multiple implementation of topology_init() functions to
single topology_init() in case of ia64 architecture.
---

 /dev/null                                                  |   43 ------
 linux-2.6.9-rc2-askeshav/arch/i386/mach-default/topology.c |   31 ++++
 linux-2.6.9-rc2-askeshav/arch/ia64/dig/Makefile            |    5 
 linux-2.6.9-rc2-askeshav/arch/ia64/kernel/Makefile         |    3 
 linux-2.6.9-rc2-askeshav/arch/ia64/kernel/topology.c       |   90 +++++++++++++
 linux-2.6.9-rc2-askeshav/arch/ia64/mm/numa.c               |   35 -----
 linux-2.6.9-rc2-askeshav/drivers/base/cpu.c                |   20 ++
 linux-2.6.9-rc2-askeshav/include/asm-i386/cpu.h            |   17 --
 linux-2.6.9-rc2-askeshav/include/asm-ia64/cpu.h            |    5 
 linux-2.6.9-rc2-askeshav/include/linux/cpu.h               |    3 
 10 files changed, 153 insertions(+), 99 deletions(-)

diff -L arch/ia64/dig/topology.c -puN arch/ia64/dig/topology.c~topology /dev/null
--- linux-2.6.9-rc2/arch/ia64/dig/topology.c
+++ /dev/null	2004-06-30 13:03:36.000000000 -0700
@@ -1,43 +0,0 @@
-/*
- * arch/ia64/dig/topology.c
- *	Popuate driverfs with topology information.
- *	Derived entirely from i386/mach-default.c
- *  Intel Corporation - Ashok Raj
- */
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/cpumask.h>
-#include <linux/percpu.h>
-#include <linux/notifier.h>
-#include <linux/cpu.h>
-#include <asm/cpu.h>
-
-static DEFINE_PER_CPU(struct ia64_cpu, cpu_devices);
-
-/*
- * First Pass: simply borrowed code for now. Later should hook into
- * hotplug notification for node/cpu/memory as applicable
- */
-
-static int arch_register_cpu(int num)
-{
-	struct node *parent = NULL;
-
-#ifdef CONFIG_NUMA
-	//parent = &node_devices[cpu_to_node(num)].node;
-#endif
-
-	return register_cpu(&per_cpu(cpu_devices,num).cpu, num, parent);
-}
-
-static int __init topology_init(void)
-{
-    int i;
-
-    for_each_cpu(i) {
-        arch_register_cpu(i);
-	}
-    return 0;
-}
-
-subsys_initcall(topology_init);
diff -puN arch/ia64/dig/Makefile~topology arch/ia64/dig/Makefile
--- linux-2.6.9-rc2/arch/ia64/dig/Makefile~topology	2004-09-24 15:26:26.939098651 -0700
+++ linux-2.6.9-rc2-askeshav/arch/ia64/dig/Makefile	2004-09-24 15:26:27.062145524 -0700
@@ -6,9 +6,4 @@
 #
 
 obj-y := setup.o
-
-ifndef CONFIG_NUMA
-obj-$(CONFIG_IA64_DIG) += topology.o
-endif
-
 obj-$(CONFIG_IA64_GENERIC) += machvec.o
diff -puN arch/ia64/mm/numa.c~topology arch/ia64/mm/numa.c
--- linux-2.6.9-rc2/arch/ia64/mm/numa.c~topology	2004-09-24 15:26:26.943004901 -0700
+++ linux-2.6.9-rc2-askeshav/arch/ia64/mm/numa.c	2004-09-24 15:26:27.063122087 -0700
@@ -20,8 +20,6 @@
 #include <asm/mmzone.h>
 #include <asm/numa.h>
 
-static struct node *sysfs_nodes;
-static struct cpu *sysfs_cpus;
 
 /*
  * The following structures are usually initialized by ACPI or
@@ -50,36 +48,3 @@ paddr_to_nid(unsigned long paddr)
 	return (i < num_node_memblks) ? node_memblk[i].nid : (num_node_memblks ? -1 : 0);
 }
 
-static int __init topology_init(void)
-{
-	int i, err = 0;
-
-	sysfs_nodes = kmalloc(sizeof(struct node) * numnodes, GFP_KERNEL);
-	if (!sysfs_nodes) {
-		err = -ENOMEM;
-		goto out;
-	}
-	memset(sysfs_nodes, 0, sizeof(struct node) * numnodes);
-
-	sysfs_cpus = kmalloc(sizeof(struct cpu) * NR_CPUS, GFP_KERNEL);
-	if (!sysfs_cpus) {
-		kfree(sysfs_nodes);
-		err = -ENOMEM;
-		goto out;
-	}
-	memset(sysfs_cpus, 0, sizeof(struct cpu) * NR_CPUS);
-
-	for (i = 0; i < numnodes; i++)
-		if ((err = register_node(&sysfs_nodes[i], i, 0)))
-			goto out;
-
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_online(i))
-			if((err = register_cpu(&sysfs_cpus[i], i,
-					       &sysfs_nodes[cpu_to_node(i)])))
-				goto out;
- out:
-	return err;
-}
-
-__initcall(topology_init);
diff -puN include/linux/cpu.h~topology include/linux/cpu.h
--- linux-2.6.9-rc2/include/linux/cpu.h~topology	2004-09-24 15:26:26.946911150 -0700
+++ linux-2.6.9-rc2-askeshav/include/linux/cpu.h	2004-09-24 15:26:27.063122087 -0700
@@ -32,6 +32,9 @@ struct cpu {
 };
 
 extern int register_cpu(struct cpu *, int, struct node *);
+#ifdef CONFIG_HOTPLUG_CPU
+extern void unregister_cpu(struct cpu *, struct node *);
+#endif
 struct notifier_block;
 
 #ifdef CONFIG_SMP
diff -puN include/asm-ia64/cpu.h~topology include/asm-ia64/cpu.h
--- linux-2.6.9-rc2/include/asm-ia64/cpu.h~topology	2004-09-24 15:26:26.951793963 -0700
+++ linux-2.6.9-rc2-askeshav/include/asm-ia64/cpu.h	2004-09-24 15:26:27.064098649 -0700
@@ -14,4 +14,9 @@ DECLARE_PER_CPU(struct ia64_cpu, cpu_dev
 
 DECLARE_PER_CPU(int, cpu_state);
 
+extern int arch_register_cpu(int num);
+#ifdef CONFIG_HOTPLUG_CPU
+extern void arch_unregister_cpu(int);
+#endif
+
 #endif /* _ASM_IA64_CPU_H_ */
diff -puN /dev/null arch/ia64/kernel/topology.c
--- /dev/null	2004-06-30 13:03:36.000000000 -0700
+++ linux-2.6.9-rc2-askeshav/arch/ia64/kernel/topology.c	2004-09-24 15:26:27.065075212 -0700
@@ -0,0 +1,90 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * This file contains NUMA specific variables and functions which can
+ * be split away from DISCONTIGMEM and are used on NUMA machines with
+ * contiguous memory.
+ * 		2002/08/07 Erich Focht <efocht@ess.nec.de>
+ * Populate cpu entries in sysfs for non-numa systems as well
+ *  	Intel Corporation - Ashok Raj
+ */
+
+#include <linux/config.h>
+#include <linux/cpu.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/node.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <asm/mmzone.h>
+#include <asm/numa.h>
+#include <asm/cpu.h>
+
+#ifdef CONFIG_NUMA
+static struct node *sysfs_nodes;
+#endif
+static struct ia64_cpu *sysfs_cpus;
+
+int arch_register_cpu(int num)
+{
+	struct node *parent = NULL;
+	
+#ifdef CONFIG_NUMA
+	parent = &sysfs_nodes[cpu_to_node(num)];
+#endif /* CONFIG_NUMA */
+
+	return register_cpu(&sysfs_cpus[num].cpu, num, parent);
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+void arch_unregister_cpu(int num)
+{
+	struct node *parent = NULL;
+
+#ifdef CONFIG_NUMA
+	int node = cpu_to_node(num);
+	parent = &sysfs_nodes[node];
+#endif /* CONFIG_NUMA */
+
+	return unregister_cpu(&sysfs_cpus[num].cpu, parent);
+}
+EXPORT_SYMBOL(arch_register_cpu);
+EXPORT_SYMBOL(arch_unregister_cpu);
+#endif /*CONFIG_HOTPLUG_CPU*/
+
+
+static int __init topology_init(void)
+{
+	int i, err = 0;
+
+#ifdef CONFIG_NUMA
+	sysfs_nodes = kmalloc(sizeof(struct node) * MAX_NUMNODES, GFP_KERNEL);
+	if (!sysfs_nodes) {
+		err = -ENOMEM;
+		goto out;
+	}
+	memset(sysfs_nodes, 0, sizeof(struct node) * MAX_NUMNODES);
+
+	for (i = 0; i < numnodes; i++)
+		if ((err = register_node(&sysfs_nodes[i], i, 0)))
+			goto out;
+#endif
+
+	sysfs_cpus = kmalloc(sizeof(struct ia64_cpu) * NR_CPUS, GFP_KERNEL);
+	if (!sysfs_cpus) {
+		err = -ENOMEM;
+		goto out;
+	}
+	memset(sysfs_cpus, 0, sizeof(struct ia64_cpu) * NR_CPUS);
+
+	for_each_present_cpu(i)
+		if((err = arch_register_cpu(i)))
+			goto out;
+out:
+	return err;
+}
+
+__initcall(topology_init);
diff -puN arch/ia64/kernel/Makefile~topology arch/ia64/kernel/Makefile
--- linux-2.6.9-rc2/arch/ia64/kernel/Makefile~topology	2004-09-24 15:26:26.956676775 -0700
+++ linux-2.6.9-rc2-askeshav/arch/ia64/kernel/Makefile	2004-09-24 15:26:27.065075212 -0700
@@ -6,7 +6,8 @@ extra-y	:= head.o init_task.o vmlinux.ld
 
 obj-y := acpi.o entry.o efi.o efi_stub.o gate-data.o fsys.o ia64_ksyms.o irq.o irq_ia64.o	\
 	 irq_lsapic.o ivt.o machvec.o pal.o patch.o process.o perfmon.o ptrace.o sal.o		\
-	 salinfo.o semaphore.o setup.o signal.o sys_ia64.o time.o traps.o unaligned.o unwind.o mca.o mca_asm.o
+	 salinfo.o semaphore.o setup.o signal.o sys_ia64.o time.o traps.o unaligned.o \
+	 unwind.o mca.o mca_asm.o topology.o
 
 obj-$(CONFIG_IA64_BRL_EMU)	+= brl_emu.o
 obj-$(CONFIG_IA64_GENERIC)	+= acpi-ext.o
diff -puN include/asm-i386/cpu.h~topology include/asm-i386/cpu.h
--- linux-2.6.9-rc2/include/asm-i386/cpu.h~topology	2004-09-24 15:26:26.960583025 -0700
+++ linux-2.6.9-rc2-askeshav/include/asm-i386/cpu.h	2004-09-24 15:26:27.066051774 -0700
@@ -11,18 +11,9 @@ struct i386_cpu {
 	struct cpu cpu;
 };
 extern struct i386_cpu cpu_devices[NR_CPUS];
-
-
-static inline int arch_register_cpu(int num){
-	struct node *parent = NULL;
-	
-#ifdef CONFIG_NUMA
-	int node = cpu_to_node(num);
-	if (node_online(node))
-		parent = &node_devices[node].node;
-#endif /* CONFIG_NUMA */
-
-	return register_cpu(&cpu_devices[num].cpu, num, parent);
-}
+extern int arch_register_cpu(int num);
+#ifdef CONFIG_HOTPLUG_CPU
+extern void arch_unregister_cpu(int);
+#endif
 
 #endif /* _ASM_I386_CPU_H_ */
diff -puN arch/i386/mach-default/topology.c~topology arch/i386/mach-default/topology.c
--- linux-2.6.9-rc2/arch/i386/mach-default/topology.c~topology	2004-09-24 15:26:26.966442400 -0700
+++ linux-2.6.9-rc2-askeshav/arch/i386/mach-default/topology.c	2004-09-24 15:26:27.067028336 -0700
@@ -31,6 +31,37 @@
 
 struct i386_cpu cpu_devices[NR_CPUS];
 
+int arch_register_cpu(int num){
+	struct node *parent = NULL;
+	
+#ifdef CONFIG_NUMA
+	int node = cpu_to_node(num);
+	if (node_online(node))
+		parent = &node_devices[node].node;
+#endif /* CONFIG_NUMA */
+
+	return register_cpu(&cpu_devices[num].cpu, num, parent);
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+void arch_unregister_cpu(int num) {
+	struct node *parent = NULL;
+
+#ifdef CONFIG_NUMA
+	int node = cpu_to_node(num);
+	if (node_online(node))
+		parent = &node_devices[node].node;
+#endif /* CONFIG_NUMA */
+
+	return unregister_cpu(&cpu_devices[num].cpu, parent);
+}
+EXPORT_SYMBOL(arch_register_cpu);
+EXPORT_SYMBOL(arch_unregister_cpu);
+#endif /*CONFIG_HOTPLUG_CPU*/
+
+
+
 #ifdef CONFIG_NUMA
 #include <linux/mmzone.h>
 #include <asm/node.h>
diff -puN drivers/base/cpu.c~topology drivers/base/cpu.c
--- linux-2.6.9-rc2/drivers/base/cpu.c~topology	2004-09-24 15:26:26.971325213 -0700
+++ linux-2.6.9-rc2-askeshav/drivers/base/cpu.c	2004-09-24 15:26:27.068004899 -0700
@@ -46,10 +46,23 @@ static ssize_t store_online(struct sys_d
 }
 static SYSDEV_ATTR(online, 0600, show_online, store_online);
 
-static void __init register_cpu_control(struct cpu *cpu)
+static void __devinit register_cpu_control(struct cpu *cpu)
 {
 	sysdev_create_file(&cpu->sysdev, &attr_online);
 }
+void unregister_cpu(struct cpu *cpu, struct node *root)
+{
+
+	if (root)
+		sysfs_remove_link(&root->sysdev.kobj,
+				  kobject_name(&cpu->sysdev.kobj));
+	sysdev_remove_file(&cpu->sysdev, &attr_online);
+
+	sysdev_unregister(&cpu->sysdev);
+
+	return;
+}
+EXPORT_SYMBOL(unregister_cpu);
 #else /* ... !CONFIG_HOTPLUG_CPU */
 static inline void register_cpu_control(struct cpu *cpu)
 {
@@ -64,7 +77,7 @@ static inline void register_cpu_control(
  *
  * Initialize and register the CPU device.
  */
-int __init register_cpu(struct cpu *cpu, int num, struct node *root)
+int __devinit register_cpu(struct cpu *cpu, int num, struct node *root)
 {
 	int error;
 
@@ -81,6 +94,9 @@ int __init register_cpu(struct cpu *cpu,
 		register_cpu_control(cpu);
 	return error;
 }
+#ifdef CONFIG_HOTPLUG_CPU
+EXPORT_SYMBOL(register_cpu);
+#endif
 
 
 
_
