Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVJDPOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVJDPOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVJDPOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:14:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:476 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964799AbVJDPOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:14:51 -0400
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>, <fastboot@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH 2/2] x86_64: move apic init in init_IRQs
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Oct 2005 09:13:23 -0600
Message-ID: <m13bnh8gdo.fsf@ebiederm.dsl.xmission.com>
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
  we won't use it past initialization.
- The kexec on panic code must restore the state of the io_apics.
- init/main.c needs a special case for !smp smp_init on x86

In addition to code movement I needed a couple of non-obvious changes:
- Move setup_boot_APIC_clock into APIC_late_time_init for
  simplicity.
- Use cpu_khz to generate a better approximation of loops_per_jiffies
  so I can verify the timer interrupt is working.
- Call setup_apic_nmi_watchdog again after cpu_khz is initialized on
  the boot cpu.

This code is tested and works on both Opterons and Xeons.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 arch/x86_64/kernel/apic.c    |   65 +++++++++++++++++++++++++++++++++---------
 arch/x86_64/kernel/i8259.c   |    4 +++
 arch/x86_64/kernel/io_apic.c |    6 +++-
 arch/x86_64/kernel/smpboot.c |   61 +--------------------------------------
 arch/x86_64/kernel/time.c    |    6 ++++
 include/asm-x86_64/apic.h    |    3 +-
 include/asm-x86_64/hw_irq.h  |    1 +
 7 files changed, 71 insertions(+), 75 deletions(-)

14b537ae0d84dcbc726183297bdaf2befc48ba13
diff --git a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
--- a/arch/x86_64/kernel/apic.c
+++ b/arch/x86_64/kernel/apic.c
@@ -601,6 +601,7 @@ static int __init detect_init_APIC (void
 
 void __init init_apic_mappings(void)
 {
+	unsigned int orig_boot_cpu_id;
 	unsigned long apic_phys;
 
 	/*
@@ -621,7 +622,11 @@ void __init init_apic_mappings(void)
 	 * Fetch the APIC ID of the BSP in case we have a
 	 * default configuration (or the MP table is broken).
 	 */
+	orig_boot_cpu_id = boot_cpu_id;
 	boot_cpu_id = GET_APIC_ID(apic_read(APIC_ID));
+	if ((orig_boot_cpu_id != -1U) && (orig_boot_cpu_id != boot_cpu_id))
+		printk(KERN_WARNING "Boot APIC ID in local APIC unexpected (%d vs %d)",
+			orig_boot_cpu_id, boot_cpu_id);
 
 #ifdef CONFIG_X86_IO_APIC
 	{
@@ -759,6 +764,7 @@ static unsigned int calibration_result;
 
 void __init setup_boot_APIC_clock (void)
 {
+	unsigned long flags;
 	if (disable_apic_timer) { 
 		printk(KERN_INFO "Disabling APIC timer\n"); 
 		return; 
@@ -767,6 +773,7 @@ void __init setup_boot_APIC_clock (void)
 	printk(KERN_INFO "Using local APIC timer interrupts.\n");
 	using_apic_timer = 1;
 
+	local_save_flags(flags);
 	local_irq_disable();
 
 	calibration_result = calibrate_APIC_clock();
@@ -775,7 +782,7 @@ void __init setup_boot_APIC_clock (void)
 	 */
 	setup_APIC_timer(calibration_result);
 
-	local_irq_enable();
+	local_irq_restore(flags);
 }
 
 void __cpuinit setup_secondary_APIC_clock(void)
@@ -1029,17 +1036,17 @@ asmlinkage void smp_error_interrupt(void
 
 int disable_apic; 
 
+
 /*
- * This initializes the IO-APIC and APIC hardware if this is
- * a UP kernel.
+ * This initializes the IO-APIC and APIC hardware.
  */
-int __init APIC_init_uniprocessor (void)
+int __init APIC_init(void)
 {
-	if (disable_apic) { 
+	if (disable_apic) {
 		printk(KERN_INFO "Apic disabled\n");
-		return -1; 
+		return -1;
 	}
-	if (!cpu_has_apic) { 
+	if (!cpu_has_apic) {
 		disable_apic = 1;
 		printk(KERN_INFO "Apic disabled by BIOS\n");
 		return -1;
@@ -1047,21 +1054,51 @@ int __init APIC_init_uniprocessor (void)
 
 	verify_local_APIC();
 
+	/*
+	 * Should not be necessary because the MP table should list the boot
+	 * CPU too, but we do it for the sake of robustness anyway.
+	 */
+	if (!physid_isset(boot_cpu_id, phys_cpu_present_map)) {
+		printk(KERN_NOTICE "weird, boot CPU (#%d) not listed by the BIOS.\n",
+			boot_cpu_id);
+		physid_set(boot_cpu_id, phys_cpu_present_map);
+	}
+
+	/*
+	 * Switch from PIC to APIC mode.
+	 */
 	connect_bsp_APIC();
+	setup_local_APIC();
 
-	phys_cpu_present_map = physid_mask_of_physid(boot_cpu_id);
-	apic_write_around(APIC_ID, boot_cpu_id);
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
 	if (smp_found_config && !skip_ioapic_setup && nr_ioapics)
-			setup_IO_APIC();
-	else
-		nr_ioapics = 0;
+		IO_APIC_late_time_init();
 #endif
 	setup_boot_APIC_clock();
-	return 0;
 }
 
 static __init int setup_disableapic(char *str) 
diff --git a/arch/x86_64/kernel/i8259.c b/arch/x86_64/kernel/i8259.c
--- a/arch/x86_64/kernel/i8259.c
+++ b/arch/x86_64/kernel/i8259.c
@@ -598,4 +598,8 @@ void __init init_IRQ(void)
 
 	if (!acpi_ioapic)
 		setup_irq(2, &irq2);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	APIC_init();
+#endif
 }
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -1760,11 +1760,15 @@ void __init setup_IO_APIC(void)
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
 struct sysfs_ioapic_data {
 	struct sys_device dev;
 	struct IO_APIC_route_entry entry[0];
diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -871,10 +871,6 @@ static __init void disable_smp(void)
 {
 	cpu_present_map = cpumask_of_cpu(0);
 	cpu_possible_map = cpumask_of_cpu(0);
-	if (smp_found_config)
-		phys_cpu_present_map = physid_mask_of_physid(boot_cpu_id);
-	else
-		phys_cpu_present_map = physid_mask_of_physid(0);
 	cpu_set(0, cpu_sibling_map[0]);
 	cpu_set(0, cpu_core_map[0]);
 }
@@ -917,40 +913,14 @@ static int __init smp_sanity_check(unsig
 	 */
 	if (!smp_found_config) {
 		printk(KERN_NOTICE "SMP motherboard not detected.\n");
-		disable_smp();
-		if (APIC_init_uniprocessor())
-			printk(KERN_NOTICE "Local APIC not detected."
-					   " Using dummy APIC emulation.\n");
-		return -1;
-	}
-
-	/*
-	 * Should not be necessary because the MP table should list the boot
-	 * CPU too, but we do it for the sake of robustness anyway.
-	 */
-	if (!physid_isset(boot_cpu_id, phys_cpu_present_map)) {
-		printk(KERN_NOTICE "weird, boot CPU (#%d) not listed by the BIOS.\n",
-								 boot_cpu_id);
-		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
-	}
-
-	/*
-	 * If we couldn't find a local APIC, then get out of here now!
-	 */
-	if (APIC_INTEGRATED(apic_version[boot_cpu_id]) && !cpu_has_apic) {
-		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
-			boot_cpu_id);
-		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
-		nr_ioapics = 0;
 		return -1;
 	}
 
 	/*
 	 * If SMP should be disabled, then really disable it!
 	 */
-	if (!max_cpus) {
-		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
-		nr_ioapics = 0;
+	if (!max_cpus || disable_apic) {
+		printk(KERN_INFO "SMP mode deactivated\n");
 		return -1;
 	}
 
@@ -976,33 +946,6 @@ void __init smp_prepare_cpus(unsigned in
 		disable_smp();
 		return;
 	}
-
-
-	/*
-	 * Switch from PIC to APIC mode.
-	 */
-	connect_bsp_APIC();
-	setup_local_APIC();
-
-	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_id) {
-		panic("Boot APIC ID in local APIC unexpected (%d vs %d)",
-		      GET_APIC_ID(apic_read(APIC_ID)), boot_cpu_id);
-		/* Or can we switch back to PIC here? */
-	}
-
-	/*
-	 * Now start the IO-APICs
-	 */
-	if (!skip_ioapic_setup && nr_ioapics)
-		setup_IO_APIC();
-	else
-		nr_ioapics = 0;
-
-	/*
-	 * Set up local APIC timer on boot CPU.
-	 */
-
-	setup_boot_APIC_clock();
 }
 
 /*
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -884,6 +884,7 @@ static struct irqaction irq0 = {
 
 extern void __init config_acpi_tables(void);
 
+extern void (*late_time_init)(void);
 void __init time_init(void)
 {
 	char *timename;
@@ -941,6 +942,11 @@ void __init time_init(void)
 
 	set_cyc2ns_scale(cpu_khz / 1000);
 
+#if CONFIG_X86_LOCAL_APIC
+	if (!disable_apic) {
+		late_time_init = APIC_late_time_init;
+	}
+#endif
 #ifndef CONFIG_SMP
 	time_init_gtod();
 #endif
diff --git a/include/asm-x86_64/apic.h b/include/asm-x86_64/apic.h
--- a/include/asm-x86_64/apic.h
+++ b/include/asm-x86_64/apic.h
@@ -94,7 +94,8 @@ extern void release_lapic_nmi(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
 extern void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
-extern int APIC_init_uniprocessor (void);
+extern int APIC_init(void);
+extern void APIC_late_time_init(void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
 extern void clustered_apic_check(void);
diff --git a/include/asm-x86_64/hw_irq.h b/include/asm-x86_64/hw_irq.h
--- a/include/asm-x86_64/hw_irq.h
+++ b/include/asm-x86_64/hw_irq.h
@@ -97,6 +97,7 @@ extern void init_8259A(int aeoi);
 extern void FASTCALL(send_IPI_self(int vector));
 extern void init_VISWS_APIC_irqs(void);
 extern void setup_IO_APIC(void);
+extern void IO_APIC_late_time_init(void);
 extern void disable_IO_APIC(void);
 extern void print_IO_APIC(void);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int slot, int fn);
