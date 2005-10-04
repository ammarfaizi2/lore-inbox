Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVJDPG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVJDPG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVJDPG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:06:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56539 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932527AbVJDPG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:06:27 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <fastboot@osdl.org>
Subject: [PATCH] i386: move apic init in init_IRQs
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Oct 2005 09:04:59 -0600
Message-ID: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All kinds of ugliness exists because we don't initialize
the apics during init_IRQs.
- We calibrate jiffies in non apic mode even when we are using apics.
- We have to have special code to initialize the apics when non-smp.
- The legacy i8259 must exist and be setup correctly, even
  when we won't use it past initialization.
- The kexec on panic code must restore the state of the io_apics.
- init/main.c needs a special case for !smp smp_init on x86

In addition to pure code movement I needed a couple
of non-obvious changes:
- Move setup_boot_APIC_clock into APIC_late_time_init for
  simplicity.
- Use cpu_khz to generate a better approximation of loops_per_jiffies
  so I can verify the timer interrupt is working.
- Call setup_apic_nmi_watchdog again after cpu_khz is initialized on
  the boot cpu.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 arch/i386/kernel/apic.c                       |   83 ++++++++++++++++++++-----
 arch/i386/kernel/i8259.c                      |    4 +
 arch/i386/kernel/io_apic.c                    |    6 ++
 arch/i386/kernel/smpboot.c                    |   68 +++++---------------
 arch/i386/kernel/time.c                       |   14 ++++
 include/asm-i386/apic.h                       |    3 +
 include/asm-i386/hw_irq.h                     |    1 
 include/asm-i386/mach-default/smpboot_hooks.h |   15 -----
 include/asm-i386/mach-visws/smpboot_hooks.h   |    7 --
 init/main.c                                   |   11 ---
 10 files changed, 106 insertions(+), 106 deletions(-)

a3b2016a27cf9d583dce93f2375af7277049000f
diff --git a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c
+++ b/arch/i386/kernel/apic.c
@@ -803,6 +803,7 @@ no_apic:
 
 void __init init_apic_mappings(void)
 {
+	unsigned int orig_apicid;
 	unsigned long apic_phys;
 
 	/*
@@ -824,8 +825,11 @@ void __init init_apic_mappings(void)
 	 * Fetch the APIC ID of the BSP in case we have a
 	 * default configuration (or the MP table is broken).
 	 */
-	if (boot_cpu_physical_apicid == -1U)
-		boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
+	orig_apicid = boot_cpu_physical_apicid;
+	boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
+	if ((orig_apicid != -1U) && (orig_apicid != boot_cpu_physical_apicid))
+		printk(KERN_WARNING "Boot APIC ID in local APIC unexpected (%d vs %d)",
+			orig_apicid, boot_cpu_physical_apicid);
 
 #ifdef CONFIG_X86_IO_APIC
 	{
@@ -1046,9 +1050,11 @@ static unsigned int calibration_result;
 
 void __init setup_boot_APIC_clock(void)
 {
+	unsigned long flags;
 	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n");
 	using_apic_timer = 1;
 
+	local_irq_save(flags);
 	local_irq_disable();
 
 	calibration_result = calibrate_APIC_clock();
@@ -1057,7 +1063,7 @@ void __init setup_boot_APIC_clock(void)
 	 */
 	setup_APIC_timer(calibration_result);
 
-	local_irq_enable();
+	local_irq_restore(flags);
 }
 
 void __devinit setup_secondary_APIC_clock(void)
@@ -1254,40 +1260,81 @@ fastcall void smp_error_interrupt(struct
 }
 
 /*
- * This initializes the IO-APIC and APIC hardware if this is
- * a UP kernel.
+ * This initializes the IO-APIC and APIC hardware.
  */
-int __init APIC_init_uniprocessor (void)
+int __init APIC_init(void)
 {
-	if (enable_local_apic < 0)
-		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
-
-	if (!smp_found_config && !cpu_has_apic)
+	if (enable_local_apic < 0) {
+		printk(KERN_INFO "Apic disabled\n");
+		return -1;
+	}
+	
+	/* See if we have a SMP configuration or have forced enabled
+	 * the local apic.
+	 */
+	if (!smp_found_config && !acpi_lapic && !cpu_has_apic) {
+		enable_local_apic = -1;
 		return -1;
+	}
 
 	/*
-	 * Complain if the BIOS pretends there is one.
+	 * Complain if the BIOS pretends there is an apic.
+	 * Then get out because we don't have an a local apic.
 	 */
 	if (!cpu_has_apic && APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid])) {
 		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
 			boot_cpu_physical_apicid);
+		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
+		enable_local_apic = -1;
 		return -1;
 	}
 
 	verify_local_APIC();
 
+	/*
+	 * Should not be necessary because the MP table should list the boot
+	 * CPU too, but we do it for the sake of robustness anyway.
+	 * Makes no sense to do this check in clustered apic mode, so skip it
+	 */
+	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
+		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
+				boot_cpu_physical_apicid);
+		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
+	}
+
+	/*
+	 * Switch from PIC to APIC mode.
+	 */
 	connect_bsp_APIC();
+	setup_local_APIC();
 
-	phys_cpu_present_map = physid_mask_of_physid(boot_cpu_physical_apicid);
+#ifdef CONFIG_X86_IO_APIC
+	/*
+	 * Now start the IO-APICs
+	 */
+	if (smp_found_config && !skip_ioapic_setup && nr_ioapics)
+		setup_IO_APIC();
+#endif
+	return 0;
+}
 
-	setup_local_APIC();
+void __init APIC_late_time_init(void)
+{
+	/* Improve our loops per jiffy estimate */
+	loops_per_jiffy = ((1000 + HZ - 1)/HZ)*cpu_khz;
+	boot_cpu_data.loops_per_jiffy = loops_per_jiffy;
+	cpu_data[0].loops_per_jiffy = loops_per_jiffy;
+
+	/* setup_apic_nmi_watchdog doesn't work properly before cpu_khz is
+	 * initialized.  So redo it here to ensure the boot cpu is setup
+	 * properly.  
+	 */
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		setup_apic_nmi_watchdog();
 
 #ifdef CONFIG_X86_IO_APIC
-	if (smp_found_config)
-		if (!skip_ioapic_setup && nr_ioapics)
-			setup_IO_APIC();
+	if (smp_found_config && !skip_ioapic_setup && nr_ioapics)
+		IO_APIC_late_time_init();
 #endif
 	setup_boot_APIC_clock();
-
-	return 0;
 }
diff --git a/arch/i386/kernel/i8259.c b/arch/i386/kernel/i8259.c
--- a/arch/i386/kernel/i8259.c
+++ b/arch/i386/kernel/i8259.c
@@ -435,4 +435,8 @@ void __init init_IRQ(void)
 		setup_irq(FPU_IRQ, &fpu_irq);
 
 	irq_ctx_init(smp_processor_id());
+	
+#ifdef CONFIG_X86_LOCAL_APIC
+	APIC_init();
+#endif
 }
diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -2310,11 +2310,15 @@ void __init setup_IO_APIC(void)
 	sync_Arb_IDs();
 	setup_IO_APIC_irqs();
 	init_IO_APIC_traps();
-	check_timer();
 	if (!acpi_ioapic)
 		print_IO_APIC();
 }
 
+void __init IO_APIC_late_time_init(void)
+{
+	check_timer();
+}
+
 /*
  *	Called after all the initialization is done. If we didnt find any
  *	APIC bugs then we can allow the modify fast path
diff --git a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -1074,6 +1074,16 @@ void *xquad_portio;
 EXPORT_SYMBOL(xquad_portio);
 #endif
 
+/*
+ * Fall back to non SMP mode after errors.
+ *
+ */
+static __init void disable_smp(void)
+{
+	cpu_set(0, cpu_sibling_map[0]);
+	cpu_set(0, cpu_core_map[0]);
+}
+
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu, bit, kicked;
@@ -1086,7 +1096,6 @@ static void __init smp_boot_cpus(unsigne
 	printk("CPU%d: ", 0);
 	print_cpu_info(&cpu_data[0]);
 
-	boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
 	boot_cpu_logical_apicid = logical_smp_processor_id();
 	x86_cpu_to_apicid[0] = boot_cpu_physical_apicid;
 
@@ -1098,68 +1107,27 @@ static void __init smp_boot_cpus(unsigne
 	cpus_clear(cpu_core_map[0]);
 	cpu_set(0, cpu_core_map[0]);
 
+	map_cpu_to_logical_apicid();
+
 	/*
 	 * If we couldn't find an SMP configuration at boot time,
 	 * get out of here now!
 	 */
 	if (!smp_found_config && !acpi_lapic) {
 		printk(KERN_NOTICE "SMP motherboard not detected.\n");
-		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = physid_mask_of_physid(0);
-		if (APIC_init_uniprocessor())
-			printk(KERN_NOTICE "Local APIC not detected."
-					   " Using dummy APIC emulation.\n");
-		map_cpu_to_logical_apicid();
-		cpu_set(0, cpu_sibling_map[0]);
-		cpu_set(0, cpu_core_map[0]);
+		disable_smp();
 		return;
 	}
 
 	/*
-	 * Should not be necessary because the MP table should list the boot
-	 * CPU too, but we do it for the sake of robustness anyway.
-	 * Makes no sense to do this check in clustered apic mode, so skip it
-	 */
-	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
-		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
-				boot_cpu_physical_apicid);
-		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
-	}
-
-	/*
-	 * If we couldn't find a local APIC, then get out of here now!
-	 */
-	if (APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid]) && !cpu_has_apic) {
-		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
-			boot_cpu_physical_apicid);
-		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
-		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = physid_mask_of_physid(0);
-		cpu_set(0, cpu_sibling_map[0]);
-		cpu_set(0, cpu_core_map[0]);
-		return;
-	}
-
-	verify_local_APIC();
-
-	/*
 	 * If SMP should be disabled, then really disable it!
 	 */
-	if (!max_cpus) {
-		smp_found_config = 0;
-		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
-		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = physid_mask_of_physid(0);
-		cpu_set(0, cpu_sibling_map[0]);
-		cpu_set(0, cpu_core_map[0]);
+	if (!max_cpus || (enable_local_apic < 0)) {
+		printk(KERN_INFO "SMP mode deactivated.\n");
+		disable_smp();
 		return;
 	}
 
-	connect_bsp_APIC();
-	setup_local_APIC();
-	map_cpu_to_logical_apicid();
-
-
 	setup_portio_remap();
 
 	/*
@@ -1240,10 +1208,6 @@ static void __init smp_boot_cpus(unsigne
 	cpu_set(0, cpu_sibling_map[0]);
 	cpu_set(0, cpu_core_map[0]);
 
-	smpboot_setup_io_apic();
-
-	setup_boot_APIC_clock();
-
 	/*
 	 * Synchronize the TSC with the AP
 	 */
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -444,8 +444,8 @@ static int time_init_device(void)
 
 device_initcall(time_init_device);
 
-#ifdef CONFIG_HPET_TIMER
 extern void (*late_time_init)(void);
+#ifdef CONFIG_HPET_TIMER
 /* Duplicate of time_init() below, with hpet_enable part added */
 static void __init hpet_time_init(void)
 {
@@ -462,6 +462,12 @@ static void __init hpet_time_init(void)
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
 	time_init_hook();
+
+#if CONFIG_X86_LOCAL_APIC
+	if (enable_local_apic >= 0) {
+		APIC_late_time_init();
+	}
+#endif
 }
 #endif
 
@@ -486,4 +492,10 @@ void __init time_init(void)
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
 	time_init_hook();
+
+#if CONFIG_X86_LOCAL_APIC
+	if (enable_local_apic >= 0) {
+		late_time_init = APIC_late_time_init;
+	}
+#endif
 }
diff --git a/include/asm-i386/apic.h b/include/asm-i386/apic.h
--- a/include/asm-i386/apic.h
+++ b/include/asm-i386/apic.h
@@ -118,7 +118,8 @@ extern void release_lapic_nmi(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
 extern void nmi_watchdog_tick (struct pt_regs * regs);
-extern int APIC_init_uniprocessor (void);
+extern int APIC_init(void);
+extern void APIC_late_time_init(void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
 
diff --git a/include/asm-i386/hw_irq.h b/include/asm-i386/hw_irq.h
--- a/include/asm-i386/hw_irq.h
+++ b/include/asm-i386/hw_irq.h
@@ -55,6 +55,7 @@ void init_8259A(int aeoi);
 void FASTCALL(send_IPI_self(int vector));
 void init_VISWS_APIC_irqs(void);
 void setup_IO_APIC(void);
+void IO_APIC_late_time_init(void);
 void disable_IO_APIC(void);
 void print_IO_APIC(void);
 int IO_APIC_get_PCI_irq_vector(int bus, int slot, int fn);
diff --git a/include/asm-i386/mach-default/smpboot_hooks.h b/include/asm-i386/mach-default/smpboot_hooks.h
--- a/include/asm-i386/mach-default/smpboot_hooks.h
+++ b/include/asm-i386/mach-default/smpboot_hooks.h
@@ -1,11 +1,6 @@
 /* two abstractions specific to kernel/smpboot.c, mainly to cater to visws
  * which needs to alter them. */
 
-static inline void smpboot_clear_io_apic_irqs(void)
-{
-	io_apic_irqs = 0;
-}
-
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
 {
 	CMOS_WRITE(0xa, 0xf);
@@ -32,13 +27,3 @@ static inline void smpboot_restore_warm_
 
 	*((volatile long *) phys_to_virt(0x467)) = 0;
 }
-
-static inline void smpboot_setup_io_apic(void)
-{
-	/*
-	 * Here we can be sure that there is an IO-APIC in the system. Let's
-	 * go and set it up:
-	 */
-	if (!skip_ioapic_setup && nr_ioapics)
-		setup_IO_APIC();
-}
diff --git a/include/asm-i386/mach-visws/smpboot_hooks.h b/include/asm-i386/mach-visws/smpboot_hooks.h
--- a/include/asm-i386/mach-visws/smpboot_hooks.h
+++ b/include/asm-i386/mach-visws/smpboot_hooks.h
@@ -11,14 +11,7 @@ static inline void smpboot_setup_warm_re
 
 /* for visws do nothing for any of these */
 
-static inline void smpboot_clear_io_apic_irqs(void)
-{
-}
-
 static inline void smpboot_restore_warm_reset_vector(void)
 {
 }
 
-static inline void smpboot_setup_io_apic(void)
-{
-}
diff --git a/init/main.c b/init/main.c
--- a/init/main.c
+++ b/init/main.c
@@ -64,10 +64,6 @@
 #endif
 #endif
 
-#ifdef CONFIG_X86_LOCAL_APIC
-#include <asm/smp.h>
-#endif
-
 /*
  * Versions of gcc older than that listed below may actually compile
  * and link okay, but the end product can have subtle run time bugs.
@@ -314,14 +310,7 @@ extern void setup_arch(char **);
 
 #ifndef CONFIG_SMP
 
-#ifdef CONFIG_X86_LOCAL_APIC
-static void __init smp_init(void)
-{
-	APIC_init_uniprocessor();
-}
-#else
 #define smp_init()	do { } while (0)
-#endif
 
 static inline void setup_per_cpu_areas(void) { }
 static inline void smp_prepare_cpus(unsigned int maxcpus) { }
