Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424476AbWKKBG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424476AbWKKBG2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 20:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424477AbWKKBG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 20:06:27 -0500
Received: from mga05.intel.com ([192.55.52.89]:43416 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1424476AbWKKBG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 20:06:26 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,412,1157353200"; 
   d="scan'208"; a="161795034:sNHT24884720"
Date: Fri, 10 Nov 2006 16:43:38 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ashok.raj@intel.com, tony.luck@intel.com,
       paulus@samba.org, ak@suse.de
Subject: [patch] change the 'no_control' field to 'hotpluggable' in the struct cpu
Message-ID: <20061110164338.B25478@unix-os.sc.intel.com>
References: <20061107173306.C3262@unix-os.sc.intel.com> <20061107173624.A5401@unix-os.sc.intel.com> <20061107174024.B5401@unix-os.sc.intel.com> <20061107195430.37f8deb0.akpm@osdl.org> <20061107200133.A5933@unix-os.sc.intel.com> <20061107203504.b8e17ea8.akpm@osdl.org> <20061107212332.A6418@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061107212332.A6418@unix-os.sc.intel.com>; from suresh.b.siddha@intel.com on Tue, Nov 07, 2006 at 09:23:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 09:23:32PM -0800, Siddha, Suresh B wrote:
> On Tue, Nov 07, 2006 at 08:35:04PM -0800, Andrew Morton wrote:
> > "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> > 
> > > I wanted to add something like disable_cpu_hotplug
> > 
> > My point is, `enable_cpu_hotplug' is nicer
> 
> Yep. I got it and hence my "will clean this up" assurance :)
> 
> This is all coming from the `no_control' member in cpu structure and I will
> change that to something like `hotpluggable'. That will make the patch slightly
> big but def clean.

Andrew, Appended the cleanup patch which goes on top of your -mm tree.
Please apply. Thanks.
---

Change the 'no_control' field in the cpu struct to a more positive
and better term 'hotpluggable'. And change(/cleanup) the logic accordingly.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
---

diff --git a/arch/i386/kernel/topology.c b/arch/i386/kernel/topology.c
index 844c08f..79cf608 100644
--- a/arch/i386/kernel/topology.c
+++ b/arch/i386/kernel/topology.c
@@ -44,8 +44,8 @@ int arch_register_cpu(int num)
 	 * Also certain PCI quirks require not to enable hotplug control
 	 * for all CPU's.
 	 */
-	if (!num || !enable_cpu_hotplug)
-		cpu_devices[num].cpu.no_control = 1;
+	if (num && enable_cpu_hotplug)
+		cpu_devices[num].cpu.hotpluggable = 1;
 
 	return register_cpu(&cpu_devices[num].cpu, num);
 }
diff --git a/arch/ia64/kernel/topology.c b/arch/ia64/kernel/topology.c
index 5629b45..687500d 100644
--- a/arch/ia64/kernel/topology.c
+++ b/arch/ia64/kernel/topology.c
@@ -31,11 +31,11 @@ int arch_register_cpu(int num)
 {
 #if defined (CONFIG_ACPI) && defined (CONFIG_HOTPLUG_CPU)
 	/*
-	 * If CPEI cannot be re-targetted, and this is
-	 * CPEI target, then dont create the control file
+	 * If CPEI can be re-targetted or if this is not
+	 * CPEI target, then it is hotpluggable
 	 */
-	if (!can_cpei_retarget() && is_cpu_cpei_target(num))
-		sysfs_cpus[num].cpu.no_control = 1;
+	if (can_cpei_retarget() || !is_cpu_cpei_target(num))
+		sysfs_cpus[num].cpu.hotpluggable = 1;
 	map_cpu_to_node(num, node_cpuid[num].nid);
 #endif
 
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index d45a168..bf65a15 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -240,7 +240,7 @@ static void unregister_cpu_online(unsign
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 	struct sys_device *s = &c->sysdev;
 
-	BUG_ON(c->no_control);
+	BUG_ON(!c->hotpluggable);
 
 #ifndef CONFIG_PPC_ISERIES
 	if (cpu_has_feature(CPU_FTR_SMT))
@@ -360,10 +360,10 @@ static int __init topology_init(void)
 		 * CPU.  For instance, the boot cpu might never be valid
 		 * for hotplugging.
 		 */
-		if (!ppc_md.cpu_die)
-			c->no_control = 1;
+		if (ppc_md.cpu_die)
+			c->hotpluggable = 1;
 
-		if (cpu_online(cpu) || (c->no_control == 0)) {
+		if (cpu_online(cpu) || c->hotpluggable) {
 			register_cpu(c, cpu);
 
 			sysdev_create_file(&c->sysdev, &attr_physical_id);
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4bef76a..d00c67c 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -103,8 +103,8 @@ #endif
 
 /*
  * register_cpu - Setup a driverfs device for a CPU.
- * @cpu - Callers can set the cpu->no_control field to 1, to indicate not to
- *		  generate a control file in sysfs for this CPU.
+ * @cpu - cpu->hotpluggable field set to 1 will generate a control file in
+ *	  sysfs for this CPU.
  * @num - CPU number to use when creating the device.
  *
  * Initialize and register the CPU device.
@@ -118,7 +118,7 @@ int __devinit register_cpu(struct cpu *c
 
 	error = sysdev_register(&cpu->sysdev);
 
-	if (!error && !cpu->no_control)
+	if (!error && cpu->hotpluggable)
 		register_cpu_control(cpu);
 	if (!error)
 		cpu_sys_devices[num] = &cpu->sysdev;
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 3fef7d6..a1fd791 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -27,7 +27,7 @@ #include <asm/semaphore.h>
 
 struct cpu {
 	int node_id;		/* The node which contains the CPU */
-	int no_control;		/* Should the sysfs control file be created? */
+	int hotpluggable;	/* creates sysfs control file if hotpluggable */
 	struct sys_device sysdev;
 };
 
