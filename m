Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbUC2MUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbUC2MTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:19:39 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:17847 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262859AbUC2MOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:14:17 -0500
Date: Mon, 29 Mar 2004 04:13:00 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT: remove obsolete cpumask macros - i386 [4/22]
Message-Id: <20040329041300.6cfc2adf.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_4_of_22 - Remove/recode obsolete cpumask macros from arch i386
	Remove by recoding all uses of the obsolete cpumask const,
	coerce and promote macros.

diffstat Patch_4_of_22:
 arch/i386/kernel/io_apic.c                |    2 +-
 arch/i386/kernel/smp.c                    |    2 +-
 arch/i386/mach-voyager/voyager_smp.c      |   30 +++++++++++++++---------------
 include/asm-i386/genapic.h                |    2 +-
 include/asm-i386/mach-bigsmp/mach_apic.h  |    8 ++++----
 include/asm-i386/mach-default/mach_apic.h |   10 +++++-----
 include/asm-i386/mach-es7000/mach_apic.h  |   10 +++++-----
 include/asm-i386/mach-numaq/mach_apic.h   |    2 +-
 include/asm-i386/mach-summit/mach_apic.h  |    8 ++++----
 include/asm-i386/mach-visws/mach_apic.h   |    4 ++--
 10 files changed, 39 insertions(+), 39 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1709  -> 1.1710 
#	include/asm-i386/mach-visws/mach_apic.h	1.9     -> 1.10   
#	include/asm-i386/mach-es7000/mach_apic.h	1.6     -> 1.7    
#	arch/i386/kernel/smp.c	1.34    -> 1.35   
#	arch/i386/kernel/io_apic.c	1.88    -> 1.89   
#	arch/i386/mach-voyager/voyager_smp.c	1.18    -> 1.19   
#	include/asm-i386/mach-numaq/mach_apic.h	1.25    -> 1.26   
#	include/asm-i386/genapic.h	1.6     -> 1.7    
#	include/asm-i386/mach-summit/mach_apic.h	1.35    -> 1.36   
#	include/asm-i386/mach-bigsmp/mach_apic.h	1.19    -> 1.20   
#	include/asm-i386/mach-default/mach_apic.h	1.30    -> 1.31   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/28	pj@sgi.com	1.1710
# Remove arch i386 use of obsolete cpumask const, coerce and promote macros
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Mon Mar 29 01:03:32 2004
+++ b/arch/i386/kernel/io_apic.c	Mon Mar 29 01:03:32 2004
@@ -264,7 +264,7 @@
 	struct irq_pin_list *entry = irq_2_pin + irq;
 	unsigned int apicid_value;
 	
-	apicid_value = cpu_mask_to_apicid(mk_cpumask_const(cpumask));
+	apicid_value = cpu_mask_to_apicid(cpumask);
 	/* Prepare to do the io_apic_write */
 	apicid_value = apicid_value << 24;
 	spin_lock_irqsave(&ioapic_lock, flags);
diff -Nru a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
--- a/arch/i386/kernel/smp.c	Mon Mar 29 01:03:32 2004
+++ b/arch/i386/kernel/smp.c	Mon Mar 29 01:03:32 2004
@@ -160,7 +160,7 @@
  */
 inline void send_IPI_mask_bitmask(cpumask_t cpumask, int vector)
 {
-	unsigned long mask = cpus_coerce(cpumask);
+	unsigned long mask = cpus_raw(cpumask)[0];
 	unsigned long cfg;
 	unsigned long flags;
 
diff -Nru a/arch/i386/mach-voyager/voyager_smp.c b/arch/i386/mach-voyager/voyager_smp.c
--- a/arch/i386/mach-voyager/voyager_smp.c	Mon Mar 29 01:03:32 2004
+++ b/arch/i386/mach-voyager/voyager_smp.c	Mon Mar 29 01:03:32 2004
@@ -154,7 +154,7 @@
 send_CPI_allbutself(__u8 cpi)
 {
 	__u8 cpu = smp_processor_id();
-	__u32 mask = cpus_coerce(cpu_online_map) & ~(1 << cpu);
+	__u32 mask = cpus_raw(cpu_online_map)[0] & ~(1 << cpu);
 	send_CPI(mask, cpi);
 }
 
@@ -403,11 +403,11 @@
 	/* set up everything for just this CPU, we can alter
 	 * this as we start the other CPUs later */
 	/* now get the CPU disposition from the extended CMOS */
-	phys_cpu_present_map = cpus_promote(voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK));
-	cpus_coerce(phys_cpu_present_map) |= voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK + 1) << 8;
-	cpus_coerce(phys_cpu_present_map) |= voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK + 2) << 16;
-	cpus_coerce(phys_cpu_present_map) |= voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK + 3) << 24;
-	printk("VOYAGER SMP: phys_cpu_present_map = 0x%lx\n", cpus_coerce(phys_cpu_present_map));
+	cpus_raw(phys_cpu_present_map)[0] = voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK);
+	cpus_raw(phys_cpu_present_map)[0] |= voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK + 1) << 8;
+	cpus_raw(phys_cpu_present_map)[0] |= voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK + 2) << 16;
+	cpus_raw(phys_cpu_present_map)[0] |= voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK + 3) << 24;
+	printk("VOYAGER SMP: phys_cpu_present_map = 0x%lx\n", cpus_raw(phys_cpu_present_map)[0]);
 	/* Here we set up the VIC to enable SMP */
 	/* enable the CPIs by writing the base vector to their register */
 	outb(VIC_DEFAULT_CPI_BASE, VIC_CPI_BASE_REGISTER);
@@ -707,12 +707,12 @@
 		/* now that the cat has probed the Voyager System Bus, sanity
 		 * check the cpu map */
 		if( ((voyager_quad_processors | voyager_extended_vic_processors)
-		     & cpus_coerce(phys_cpu_present_map)) != cpus_coerce(phys_cpu_present_map)) {
+		     & cpus_raw(phys_cpu_present_map)[0]) != cpus_raw(phys_cpu_present_map)[0]) {
 			/* should panic */
 			printk("\n\n***WARNING*** Sanity check of CPU present map FAILED\n");
 		}
 	} else if(voyager_level == 4)
-		voyager_extended_vic_processors = cpus_coerce(phys_cpu_present_map);
+		voyager_extended_vic_processors = cpus_raw(phys_cpu_present_map)[0];
 
 	/* this sets up the idle task to run on the current cpu */
 	voyager_extended_cpus = 1;
@@ -910,7 +910,7 @@
 
 	if (!cpumask)
 		BUG();
-	if ((cpumask & cpus_coerce(cpu_online_map)) != cpumask)
+	if ((cpumask & cpus_raw(cpu_online_map)[0]) != cpumask)
 		BUG();
 	if (cpumask & (1 << smp_processor_id()))
 		BUG();
@@ -953,7 +953,7 @@
 
 	preempt_disable();
 
-	cpu_mask = cpus_coerce(mm->cpu_vm_mask) & ~(1 << smp_processor_id());
+	cpu_mask = cpus_raw(mm->cpu_vm_mask)[0] & ~(1 << smp_processor_id());
 	local_flush_tlb();
 	if (cpu_mask)
 		flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
@@ -969,7 +969,7 @@
 
 	preempt_disable();
 
-	cpu_mask = cpus_coerce(mm->cpu_vm_mask) & ~(1 << smp_processor_id());
+	cpu_mask = cpus_raw(mm->cpu_vm_mask)[0] & ~(1 << smp_processor_id());
 
 	if (current->active_mm == mm) {
 		if (current->mm)
@@ -990,7 +990,7 @@
 
 	preempt_disable();
 
-	cpu_mask = cpus_coerce(mm->cpu_vm_mask) & ~(1 << smp_processor_id());
+	cpu_mask = cpus_raw(mm->cpu_vm_mask)[0] & ~(1 << smp_processor_id());
 	if (current->active_mm == mm) {
 		if(current->mm)
 			__flush_tlb_one(va);
@@ -1099,7 +1099,7 @@
 		   int wait)
 {
 	struct call_data_struct data;
-	__u32 mask = cpus_coerce(cpu_online_map);
+	__u32 mask = cpus_raw(cpu_online_map)[0];
 
 	mask &= ~(1<<smp_processor_id());
 
@@ -1787,9 +1787,9 @@
 	unsigned long irq_mask = 1 << irq;
 	int cpu;
 
-	real_mask = cpus_coerce(mask) & voyager_extended_vic_processors;
+	real_mask = cpus_raw(mask)[0] & voyager_extended_vic_processors;
 	
-	if(cpus_coerce(mask) == 0)
+	if(cpus_raw(mask)[0] == 0)
 		/* can't have no cpu's to accept the interrupt -- extremely
 		 * bad things will happen */
 		return;
diff -Nru a/include/asm-i386/genapic.h b/include/asm-i386/genapic.h
--- a/include/asm-i386/genapic.h	Mon Mar 29 01:03:32 2004
+++ b/include/asm-i386/genapic.h	Mon Mar 29 01:03:32 2004
@@ -62,7 +62,7 @@
 
 	unsigned (*get_apic_id)(unsigned long x);
 	unsigned long apic_id_mask;
-	unsigned int (*cpu_mask_to_apicid)(cpumask_const_t cpumask);
+	unsigned int (*cpu_mask_to_apicid)(cpumask_t cpumask);
 	
 	/* ipi */
 	void (*send_IPI_mask)(cpumask_t mask, int vector);
diff -Nru a/include/asm-i386/mach-bigsmp/mach_apic.h b/include/asm-i386/mach-bigsmp/mach_apic.h
--- a/include/asm-i386/mach-bigsmp/mach_apic.h	Mon Mar 29 01:03:32 2004
+++ b/include/asm-i386/mach-bigsmp/mach_apic.h	Mon Mar 29 01:03:32 2004
@@ -140,14 +140,14 @@
 	return (1);
 }
 
-static inline unsigned int cpu_mask_to_apicid(cpumask_const_t cpumask)
+static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
 {
 	int num_bits_set;
 	int cpus_found = 0;
 	int cpu;
 	int apicid;	
 
-	num_bits_set = cpus_weight_const(cpumask);
+	num_bits_set = cpus_weight(cpumask);
 	/* Return id to all */
 	if (num_bits_set == NR_CPUS)
 		return (int) 0xFF;
@@ -155,10 +155,10 @@
 	 * The cpus in the mask must all be on the apic cluster.  If are not 
 	 * on the same apicid cluster return default value of TARGET_CPUS. 
 	 */
-	cpu = first_cpu_const(cpumask);
+	cpu = first_cpu(cpumask);
 	apicid = cpu_to_logical_apicid(cpu);
 	while (cpus_found < num_bits_set) {
-		if (cpu_isset_const(cpu, cpumask)) {
+		if (cpu_isset(cpu, cpumask)) {
 			int new_apicid = cpu_to_logical_apicid(cpu);
 			if (apicid_cluster(apicid) != 
 					apicid_cluster(new_apicid)){
diff -Nru a/include/asm-i386/mach-default/mach_apic.h b/include/asm-i386/mach-default/mach_apic.h
--- a/include/asm-i386/mach-default/mach_apic.h	Mon Mar 29 01:03:32 2004
+++ b/include/asm-i386/mach-default/mach_apic.h	Mon Mar 29 01:03:32 2004
@@ -5,12 +5,12 @@
 
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
-static inline cpumask_const_t target_cpus(void)
+static inline cpumask_t target_cpus(void)
 { 
 #ifdef CONFIG_SMP
-	return mk_cpumask_const(cpu_online_map);
+	return cpu_online_map;
 #else
-	return mk_cpumask_const(cpumask_of_cpu(0));
+	return cpumask_of_cpu(0);
 #endif
 } 
 #define TARGET_CPUS (target_cpus())
@@ -118,9 +118,9 @@
 	return physid_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map);
 }
 
-static inline unsigned int cpu_mask_to_apicid(cpumask_const_t cpumask)
+static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
 {
-	return cpus_coerce_const(cpumask);
+	return cpus_raw(cpumask)[0];
 }
 
 static inline void enable_apic_mode(void)
diff -Nru a/include/asm-i386/mach-es7000/mach_apic.h b/include/asm-i386/mach-es7000/mach_apic.h
--- a/include/asm-i386/mach-es7000/mach_apic.h	Mon Mar 29 01:03:32 2004
+++ b/include/asm-i386/mach-es7000/mach_apic.h	Mon Mar 29 01:03:32 2004
@@ -89,7 +89,7 @@
 	int apic = bios_cpu_apicid[smp_processor_id()];
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs, target cpus %lx\n",
 		(apic_version[apic] == 0x14) ? 
-		"Physical Cluster" : "Logical Cluster", nr_ioapics, cpus_coerce(TARGET_CPUS));
+		"Physical Cluster" : "Logical Cluster", nr_ioapics, cpus_raw(TARGET_CPUS)[0]);
 }
 
 static inline int multi_timer_check(int apic, int irq)
@@ -159,14 +159,14 @@
 	return (1);
 }
 
-static inline unsigned int cpu_mask_to_apicid(cpumask_const_t cpumask)
+static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
 {
 	int num_bits_set;
 	int cpus_found = 0;
 	int cpu;
 	int apicid;	
 
-	num_bits_set = cpus_weight_const(cpumask);
+	num_bits_set = cpus_weight(cpumask);
 	/* Return id to all */
 	if (num_bits_set == NR_CPUS)
 		return 0xFF;
@@ -174,10 +174,10 @@
 	 * The cpus in the mask must all be on the apic cluster.  If are not 
 	 * on the same apicid cluster return default value of TARGET_CPUS. 
 	 */
-	cpu = first_cpu_const(cpumask);
+	cpu = first_cpu(cpumask);
 	apicid = cpu_to_logical_apicid(cpu);
 	while (cpus_found < num_bits_set) {
-		if (cpu_isset_const(cpu, cpumask)) {
+		if (cpu_isset(cpu, cpumask)) {
 			int new_apicid = cpu_to_logical_apicid(cpu);
 			if (apicid_cluster(apicid) != 
 					apicid_cluster(new_apicid)){
diff -Nru a/include/asm-i386/mach-numaq/mach_apic.h b/include/asm-i386/mach-numaq/mach_apic.h
--- a/include/asm-i386/mach-numaq/mach_apic.h	Mon Mar 29 01:03:32 2004
+++ b/include/asm-i386/mach-numaq/mach_apic.h	Mon Mar 29 01:03:32 2004
@@ -136,7 +136,7 @@
  * We use physical apicids here, not logical, so just return the default
  * physical broadcast to stop people from breaking us
  */
-static inline unsigned int cpu_mask_to_apicid(cpumask_const_t cpumask)
+static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
 {
 	return (int) 0xF;
 }
diff -Nru a/include/asm-i386/mach-summit/mach_apic.h b/include/asm-i386/mach-summit/mach_apic.h
--- a/include/asm-i386/mach-summit/mach_apic.h	Mon Mar 29 01:03:32 2004
+++ b/include/asm-i386/mach-summit/mach_apic.h	Mon Mar 29 01:03:32 2004
@@ -140,14 +140,14 @@
 {
 }
 
-static inline unsigned int cpu_mask_to_apicid(cpumask_const_t cpumask)
+static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
 {
 	int num_bits_set;
 	int cpus_found = 0;
 	int cpu;
 	int apicid;	
 
-	num_bits_set = cpus_weight_const(cpumask);
+	num_bits_set = cpus_weight(cpumask);
 	/* Return id to all */
 	if (num_bits_set == NR_CPUS)
 		return (int) 0xFF;
@@ -155,10 +155,10 @@
 	 * The cpus in the mask must all be on the apic cluster.  If are not 
 	 * on the same apicid cluster return default value of TARGET_CPUS. 
 	 */
-	cpu = first_cpu_const(cpumask);
+	cpu = first_cpu(cpumask);
 	apicid = cpu_to_logical_apicid(cpu);
 	while (cpus_found < num_bits_set) {
-		if (cpu_isset_const(cpu, cpumask)) {
+		if (cpu_isset(cpu, cpumask)) {
 			int new_apicid = cpu_to_logical_apicid(cpu);
 			if (apicid_cluster(apicid) != 
 					apicid_cluster(new_apicid)){
diff -Nru a/include/asm-i386/mach-visws/mach_apic.h b/include/asm-i386/mach-visws/mach_apic.h
--- a/include/asm-i386/mach-visws/mach_apic.h	Mon Mar 29 01:03:32 2004
+++ b/include/asm-i386/mach-visws/mach_apic.h	Mon Mar 29 01:03:32 2004
@@ -84,9 +84,9 @@
 	return physid_isset(boot_cpu_physical_apicid, phys_cpu_present_map);
 }
 
-static inline unsigned int cpu_mask_to_apicid(cpumask_const_t cpumask)
+static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
 {
-	return cpus_coerce_const(cpumask);
+	return cpus_raw(cpumask)[0];
 }
 
 static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
