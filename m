Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263602AbUDVHPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263602AbUDVHPV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263643AbUDVHOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:14:40 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:14263 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263602AbUDVHJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:09:47 -0400
Date: Thu, 22 Apr 2004 00:07:33 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [Patch 9 of 17] cpumask v4 - Recode obsolete cpumask macros - arch
 i386
Message-Id: <20040422000733.38951741.pj@sgi.com>
In-Reply-To: <20040421232247.22ffe1f2.pj@sgi.com>
References: <20040421232247.22ffe1f2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mask9-cpumask-i386-fixup - Remove/recode obsolete cpumask macros from arch i386
	Remove by recoding all uses of the obsolete cpumask const,
	coerce and promote macros.

Diffstat Patch_7_of_23:
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

Index: 2.6.5.mask/arch/i386/kernel/io_apic.c
===================================================================
--- 2.6.5.mask.orig/arch/i386/kernel/io_apic.c	2004-04-03 23:37:35.000000000 -0800
+++ 2.6.5.mask/arch/i386/kernel/io_apic.c	2004-04-03 23:51:51.000000000 -0800
@@ -264,7 +264,7 @@
 	struct irq_pin_list *entry = irq_2_pin + irq;
 	unsigned int apicid_value;
 	
-	apicid_value = cpu_mask_to_apicid(mk_cpumask_const(cpumask));
+	apicid_value = cpu_mask_to_apicid(cpumask);
 	/* Prepare to do the io_apic_write */
 	apicid_value = apicid_value << 24;
 	spin_lock_irqsave(&ioapic_lock, flags);
Index: 2.6.5.mask/arch/i386/kernel/smp.c
===================================================================
--- 2.6.5.mask.orig/arch/i386/kernel/smp.c	2004-04-03 23:37:35.000000000 -0800
+++ 2.6.5.mask/arch/i386/kernel/smp.c	2004-04-03 23:51:51.000000000 -0800
@@ -160,7 +160,7 @@
  */
 inline void send_IPI_mask_bitmask(cpumask_t cpumask, int vector)
 {
-	unsigned long mask = cpus_coerce(cpumask);
+	unsigned long mask = cpus_addr(cpumask)[0];
 	unsigned long cfg;
 	unsigned long flags;
 
Index: 2.6.5.mask/arch/i386/mach-voyager/voyager_smp.c
===================================================================
--- 2.6.5.mask.orig/arch/i386/mach-voyager/voyager_smp.c	2004-04-03 23:37:36.000000000 -0800
+++ 2.6.5.mask/arch/i386/mach-voyager/voyager_smp.c	2004-04-03 23:51:51.000000000 -0800
@@ -154,7 +154,7 @@
 send_CPI_allbutself(__u8 cpi)
 {
 	__u8 cpu = smp_processor_id();
-	__u32 mask = cpus_coerce(cpu_online_map) & ~(1 << cpu);
+	__u32 mask = cpus_addr(cpu_online_map)[0] & ~(1 << cpu);
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
+	cpus_addr(phys_cpu_present_map)[0] = voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK);
+	cpus_addr(phys_cpu_present_map)[0] |= voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK + 1) << 8;
+	cpus_addr(phys_cpu_present_map)[0] |= voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK + 2) << 16;
+	cpus_addr(phys_cpu_present_map)[0] |= voyager_extended_cmos_read(VOYAGER_PROCESSOR_PRESENT_MASK + 3) << 24;
+	printk("VOYAGER SMP: phys_cpu_present_map = 0x%lx\n", cpus_addr(phys_cpu_present_map)[0]);
 	/* Here we set up the VIC to enable SMP */
 	/* enable the CPIs by writing the base vector to their register */
 	outb(VIC_DEFAULT_CPI_BASE, VIC_CPI_BASE_REGISTER);
@@ -709,12 +709,12 @@
 		/* now that the cat has probed the Voyager System Bus, sanity
 		 * check the cpu map */
 		if( ((voyager_quad_processors | voyager_extended_vic_processors)
-		     & cpus_coerce(phys_cpu_present_map)) != cpus_coerce(phys_cpu_present_map)) {
+		     & cpus_addr(phys_cpu_present_map)[0]) != cpus_addr(phys_cpu_present_map)[0]) {
 			/* should panic */
 			printk("\n\n***WARNING*** Sanity check of CPU present map FAILED\n");
 		}
 	} else if(voyager_level == 4)
-		voyager_extended_vic_processors = cpus_coerce(phys_cpu_present_map);
+		voyager_extended_vic_processors = cpus_addr(phys_cpu_present_map)[0];
 
 	/* this sets up the idle task to run on the current cpu */
 	voyager_extended_cpus = 1;
@@ -912,7 +912,7 @@
 
 	if (!cpumask)
 		BUG();
-	if ((cpumask & cpus_coerce(cpu_online_map)) != cpumask)
+	if ((cpumask & cpus_addr(cpu_online_map)[0]) != cpumask)
 		BUG();
 	if (cpumask & (1 << smp_processor_id()))
 		BUG();
@@ -955,7 +955,7 @@
 
 	preempt_disable();
 
-	cpu_mask = cpus_coerce(mm->cpu_vm_mask) & ~(1 << smp_processor_id());
+	cpu_mask = cpus_addr(mm->cpu_vm_mask)[0] & ~(1 << smp_processor_id());
 	local_flush_tlb();
 	if (cpu_mask)
 		flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
@@ -971,7 +971,7 @@
 
 	preempt_disable();
 
-	cpu_mask = cpus_coerce(mm->cpu_vm_mask) & ~(1 << smp_processor_id());
+	cpu_mask = cpus_addr(mm->cpu_vm_mask)[0] & ~(1 << smp_processor_id());
 
 	if (current->active_mm == mm) {
 		if (current->mm)
@@ -992,7 +992,7 @@
 
 	preempt_disable();
 
-	cpu_mask = cpus_coerce(mm->cpu_vm_mask) & ~(1 << smp_processor_id());
+	cpu_mask = cpus_addr(mm->cpu_vm_mask)[0] & ~(1 << smp_processor_id());
 	if (current->active_mm == mm) {
 		if(current->mm)
 			__flush_tlb_one(va);
@@ -1101,7 +1101,7 @@
 		   int wait)
 {
 	struct call_data_struct data;
-	__u32 mask = cpus_coerce(cpu_online_map);
+	__u32 mask = cpus_addr(cpu_online_map)[0];
 
 	mask &= ~(1<<smp_processor_id());
 
@@ -1789,9 +1789,9 @@
 	unsigned long irq_mask = 1 << irq;
 	int cpu;
 
-	real_mask = cpus_coerce(mask) & voyager_extended_vic_processors;
+	real_mask = cpus_addr(mask)[0] & voyager_extended_vic_processors;
 	
-	if(cpus_coerce(mask) == 0)
+	if(cpus_addr(mask)[0] == 0)
 		/* can't have no cpu's to accept the interrupt -- extremely
 		 * bad things will happen */
 		return;
Index: 2.6.5.mask/include/asm-i386/genapic.h
===================================================================
--- 2.6.5.mask.orig/include/asm-i386/genapic.h	2004-04-03 23:38:10.000000000 -0800
+++ 2.6.5.mask/include/asm-i386/genapic.h	2004-04-03 23:51:51.000000000 -0800
@@ -62,7 +62,7 @@
 
 	unsigned (*get_apic_id)(unsigned long x);
 	unsigned long apic_id_mask;
-	unsigned int (*cpu_mask_to_apicid)(cpumask_const_t cpumask);
+	unsigned int (*cpu_mask_to_apicid)(cpumask_t cpumask);
 	
 	/* ipi */
 	void (*send_IPI_mask)(cpumask_t mask, int vector);
Index: 2.6.5.mask/include/asm-i386/mach-bigsmp/mach_apic.h
===================================================================
--- 2.6.5.mask.orig/include/asm-i386/mach-bigsmp/mach_apic.h	2004-04-03 23:38:10.000000000 -0800
+++ 2.6.5.mask/include/asm-i386/mach-bigsmp/mach_apic.h	2004-04-03 23:51:51.000000000 -0800
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
Index: 2.6.5.mask/include/asm-i386/mach-default/mach_apic.h
===================================================================
--- 2.6.5.mask.orig/include/asm-i386/mach-default/mach_apic.h	2004-04-03 23:38:10.000000000 -0800
+++ 2.6.5.mask/include/asm-i386/mach-default/mach_apic.h	2004-04-03 23:51:51.000000000 -0800
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
+	return cpus_addr(cpumask)[0];
 }
 
 static inline void enable_apic_mode(void)
Index: 2.6.5.mask/include/asm-i386/mach-es7000/mach_apic.h
===================================================================
--- 2.6.5.mask.orig/include/asm-i386/mach-es7000/mach_apic.h	2004-04-03 23:38:10.000000000 -0800
+++ 2.6.5.mask/include/asm-i386/mach-es7000/mach_apic.h	2004-04-03 23:51:51.000000000 -0800
@@ -89,7 +89,7 @@
 	int apic = bios_cpu_apicid[smp_processor_id()];
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs, target cpus %lx\n",
 		(apic_version[apic] == 0x14) ? 
-		"Physical Cluster" : "Logical Cluster", nr_ioapics, cpus_coerce(TARGET_CPUS));
+		"Physical Cluster" : "Logical Cluster", nr_ioapics, cpus_addr(TARGET_CPUS)[0]);
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
Index: 2.6.5.mask/include/asm-i386/mach-numaq/mach_apic.h
===================================================================
--- 2.6.5.mask.orig/include/asm-i386/mach-numaq/mach_apic.h	2004-04-03 23:38:10.000000000 -0800
+++ 2.6.5.mask/include/asm-i386/mach-numaq/mach_apic.h	2004-04-03 23:51:51.000000000 -0800
@@ -136,7 +136,7 @@
  * We use physical apicids here, not logical, so just return the default
  * physical broadcast to stop people from breaking us
  */
-static inline unsigned int cpu_mask_to_apicid(cpumask_const_t cpumask)
+static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
 {
 	return (int) 0xF;
 }
Index: 2.6.5.mask/include/asm-i386/mach-summit/mach_apic.h
===================================================================
--- 2.6.5.mask.orig/include/asm-i386/mach-summit/mach_apic.h	2004-04-03 23:38:10.000000000 -0800
+++ 2.6.5.mask/include/asm-i386/mach-summit/mach_apic.h	2004-04-03 23:51:51.000000000 -0800
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
Index: 2.6.5.mask/include/asm-i386/mach-visws/mach_apic.h
===================================================================
--- 2.6.5.mask.orig/include/asm-i386/mach-visws/mach_apic.h	2004-04-03 23:38:10.000000000 -0800
+++ 2.6.5.mask/include/asm-i386/mach-visws/mach_apic.h	2004-04-03 23:51:51.000000000 -0800
@@ -84,9 +84,9 @@
 	return physid_isset(boot_cpu_physical_apicid, phys_cpu_present_map);
 }
 
-static inline unsigned int cpu_mask_to_apicid(cpumask_const_t cpumask)
+static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
 {
-	return cpus_coerce_const(cpumask);
+	return cpus_addr(cpumask)[0];
 }
 
 static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
