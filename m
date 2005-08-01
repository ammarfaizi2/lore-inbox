Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVHAVMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVHAVMt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVHAUed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:34:33 -0400
Received: from fmr20.intel.com ([134.134.136.19]:4275 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261240AbVHAUdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:33:20 -0400
Message-Id: <20050801203011.631334000@araj-em64t>
References: <20050801202017.043754000@araj-em64t>
Date: Mon, 01 Aug 2005 13:20:24 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
       zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [patch 7/8] x86_64:Use common functions in cluster and physflat mode 
Content-Disposition: inline; filename=use-common-physflat-cluster
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Newly introduced physflat_* shares way too much with cluster with only
a very differences. So we introduce some common functions in that can be
reused in both cases.

In addition the following are also fixed.
- Use of non-existent CONFIG_CPU_HOTPLUG option renamed to actual one in use.
- Removed comment that ACPI would provide a way to select this dynamically
  since ACPI_CONFIG_HOTPLUG_CPU already exists that indicates platform support
  for hotplug via ACPI. In addition CONFIG_HOTPLUG_CPU only indicates logical 
  offline/online which is even used by Suspend/Resume folks where the same 
  support (for no-broadcast) is required.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
------------------------------------------------------------
 arch/x86_64/kernel/genapic.c         |   52 +++++++++++++++++++++++++++++----
 arch/x86_64/kernel/genapic_cluster.c |   55 +++--------------------------------
 arch/x86_64/kernel/genapic_flat.c    |   49 +++----------------------------
 include/asm-x86_64/ipi.h             |    5 +++
 4 files changed, 61 insertions(+), 100 deletions(-)

Index: linux-2.6.13-rc4-mm1/include/asm-x86_64/ipi.h
===================================================================
--- linux-2.6.13-rc4-mm1.orig/include/asm-x86_64/ipi.h
+++ linux-2.6.13-rc4-mm1/include/asm-x86_64/ipi.h
@@ -107,4 +107,9 @@ static inline void send_IPI_mask_sequenc
 	local_irq_restore(flags);
 }
 
+extern cpumask_t generic_target_cpus(void);
+extern void generic_send_IPI_mask(cpumask_t mask, int vector);
+extern void generic_send_IPI_allbutself(int vector);
+extern void generic_send_IPI_all(int vector);
+extern unsigned int generic_cpu_mask_to_apicid(cpumask_t cpumask);
 #endif /* __ASM_IPI_H */
Index: linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic_flat.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/arch/x86_64/kernel/genapic_flat.c
+++ linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic_flat.c
@@ -134,56 +134,17 @@ struct genapic apic_flat =  {
  * overflows, so use physical mode.
  */
 
-static cpumask_t physflat_target_cpus(void)
-{
-	return cpumask_of_cpu(0);
-}
-
-static void physflat_send_IPI_mask(cpumask_t cpumask, int vector)
-{
-	send_IPI_mask_sequence(cpumask, vector);
-}
-
-static void physflat_send_IPI_allbutself(int vector)
-{
-	cpumask_t allbutme = cpu_online_map;
-	int me = get_cpu();
-	cpu_clear(me, allbutme);
-	physflat_send_IPI_mask(allbutme, vector);
-	put_cpu();
-}
-
-static void physflat_send_IPI_all(int vector)
-{
-	physflat_send_IPI_mask(cpu_online_map, vector);
-}
-
-static unsigned int physflat_cpu_mask_to_apicid(cpumask_t cpumask)
-{
-	int cpu;
-
-	/*
-	 * We're using fixed IRQ delivery, can only return one phys APIC ID.
-	 * May as well be the first.
-	 */
-	cpu = first_cpu(cpumask);
-	if ((unsigned)cpu < NR_CPUS)
-		return x86_cpu_to_apicid[cpu];
-	else
-		return BAD_APICID;
-}
-
 struct genapic apic_physflat =  {
 	.name = "physical flat",
 	.int_delivery_mode = dest_Fixed,
 	.int_dest_mode = (APIC_DEST_PHYSICAL != 0),
 	.int_delivery_dest = APIC_DEST_PHYSICAL | APIC_DM_FIXED,
-	.target_cpus = physflat_target_cpus,
+	.target_cpus = generic_target_cpus,
 	.apic_id_registered = flat_apic_id_registered,
 	.init_apic_ldr = flat_init_apic_ldr,/*not needed, but shouldn't hurt*/
-	.send_IPI_all = physflat_send_IPI_all,
-	.send_IPI_allbutself = physflat_send_IPI_allbutself,
-	.send_IPI_mask = physflat_send_IPI_mask,
-	.cpu_mask_to_apicid = physflat_cpu_mask_to_apicid,
+	.send_IPI_all = generic_send_IPI_all,
+	.send_IPI_allbutself = generic_send_IPI_allbutself,
+	.send_IPI_mask = generic_send_IPI_mask,
+	.cpu_mask_to_apicid = generic_cpu_mask_to_apicid,
 	.phys_pkg_id = phys_pkg_id,
 };
Index: linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic_cluster.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/arch/x86_64/kernel/genapic_cluster.c
+++ linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic_cluster.c
@@ -57,56 +57,11 @@ static void cluster_init_apic_ldr(void)
 	apic_write_around(APIC_LDR, val);
 }
 
-/* Start with all IRQs pointing to boot CPU.  IRQ balancing will shift them. */
-
-static cpumask_t cluster_target_cpus(void)
-{
-	return cpumask_of_cpu(0);
-}
-
-static void cluster_send_IPI_mask(cpumask_t mask, int vector)
-{
-	send_IPI_mask_sequence(mask, vector);
-}
-
-static void cluster_send_IPI_allbutself(int vector)
-{
-	cpumask_t mask = cpu_online_map;
-	int me = get_cpu(); /* Ensure we are not preempted when we clear */
-
-	cpu_clear(me, mask);
-
-	if (!cpus_empty(mask))
-		cluster_send_IPI_mask(mask, vector);
-
-	put_cpu();
-}
-
-static void cluster_send_IPI_all(int vector)
-{
-	cluster_send_IPI_mask(cpu_online_map, vector);
-}
-
 static int cluster_apic_id_registered(void)
 {
 	return 1;
 }
 
-static unsigned int cluster_cpu_mask_to_apicid(cpumask_t cpumask)
-{
-	int cpu;
-
-	/*
-	 * We're using fixed IRQ delivery, can only return one phys APIC ID.
-	 * May as well be the first.
-	 */
-	cpu = first_cpu(cpumask);
-	if ((unsigned)cpu < NR_CPUS)
-		return x86_cpu_to_apicid[cpu];
-	else
-		return BAD_APICID;
-}
-
 /* cpuid returns the value latched in the HW at reset, not the APIC ID
  * register's value.  For any box whose BIOS changes APIC IDs, like
  * clustered APIC systems, we must use hard_smp_processor_id.
@@ -123,12 +78,12 @@ struct genapic apic_cluster = {
 	.int_delivery_mode = dest_Fixed,
 	.int_dest_mode = (APIC_DEST_PHYSICAL != 0),
 	.int_delivery_dest = APIC_DEST_PHYSICAL | APIC_DM_FIXED,
-	.target_cpus = cluster_target_cpus,
+	.target_cpus = generic_target_cpus,
 	.apic_id_registered = cluster_apic_id_registered,
 	.init_apic_ldr = cluster_init_apic_ldr,
-	.send_IPI_all = cluster_send_IPI_all,
-	.send_IPI_allbutself = cluster_send_IPI_allbutself,
-	.send_IPI_mask = cluster_send_IPI_mask,
-	.cpu_mask_to_apicid = cluster_cpu_mask_to_apicid,
+	.send_IPI_all = generic_send_IPI_all,
+	.send_IPI_allbutself = generic_send_IPI_allbutself,
+	.send_IPI_mask = generic_send_IPI_mask,
+	.cpu_mask_to_apicid = generic_cpu_mask_to_apicid,
 	.phys_pkg_id = phys_pkg_id,
 };
Index: linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/arch/x86_64/kernel/genapic.c
+++ linux-2.6.13-rc4-mm1/arch/x86_64/kernel/genapic.c
@@ -71,14 +71,10 @@ void __init clustered_apic_check(void)
 	/* Don't use clustered mode on AMD platforms. */
  	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
 		genapic = &apic_physflat;
-#ifndef CONFIG_CPU_HOTPLUG
 		/* In the CPU hotplug case we cannot use broadcast mode
 		   because that opens a race when a CPU is removed.
-		   Stay at physflat mode in this case.
-		   It is bad to do this unconditionally though. Once
-		   we have ACPI platform support for CPU hotplug
-		   we should detect hotplug capablity from ACPI tables and
-		   only do this when really needed. -AK */
+		   Stay at physflat mode in this case. - AK */
+#ifdef CONFIG_HOTPLUG_CPU
 		if (num_cpus <= 8)
 			genapic = &apic_flat;
 #endif
@@ -118,3 +114,47 @@ void send_IPI_self(int vector)
 {
 	__send_IPI_shortcut(APIC_DEST_SELF, vector, APIC_DEST_PHYSICAL);
 }
+
+/* Start with all IRQS pointing to current CPU. IRQ balancing will shift them */
+cpumask_t generic_target_cpus(void)
+{
+	int cpu = smp_processor_id();
+
+	return cpumask_of_cpu(cpu);
+}
+
+void generic_send_IPI_mask(cpumask_t mask, int vector)
+{
+	send_IPI_mask_sequence(mask, vector);
+}
+
+void generic_send_IPI_allbutself(int vector)
+{
+	cpumask_t mask = cpu_online_map;
+	int me=get_cpu(); /* Ensure we dont move to new cpu when clearing self */
+
+	cpu_clear(me, mask);
+	if (!cpus_empty(mask))
+		generic_send_IPI_mask(mask, vector);
+	put_cpu();
+}
+
+void generic_send_IPI_all(int vector)
+{
+	generic_send_IPI_mask(cpu_online_map, vector);
+}
+
+unsigned int generic_cpu_mask_to_apicid(cpumask_t cpumask)
+{
+	int cpu;
+
+	/*
+	 * We're using fixed IRQ delivery, can only return one phys APIC ID.
+	 * May as well be the first.
+	 */
+	cpu = first_cpu(cpumask);
+	if ((unsigned)cpu < NR_CPUS)
+		return x86_cpu_to_apicid[cpu];
+	else
+		return BAD_APICID;
+}

--

