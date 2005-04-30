Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263084AbVD3A1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbVD3A1A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 20:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbVD3A07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 20:26:59 -0400
Received: from fmr24.intel.com ([143.183.121.16]:38320 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S263084AbVD3A0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 20:26:20 -0400
Date: Fri, 29 Apr 2005 17:26:05 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Rajesh Shah <rajesh.shah@intel.com>, John Stultz <johnstul@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Asit K Mallick <asit.k.mallick@intel.com>
Subject: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Message-ID: <20050429172605.A23722@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Background: 
Local APIC timer stops functioning when CPU is in C3 state. As a
result the local APIC timer interrupt will fire at uncertain times, depending
on how long we spend in C3 state. And this has two side effects
* Idle balancing will not happen as we expect it to.
* Kernel statistics for idle time will not be proper (as we get less LAPIC
  interrupts when we are idle). This can result in confusing other parts of
  kernel (like ondemand cpufreq governor) which depends on this idle stats.


Proposed Fix: 
Attached is a prototype patch, that tries to eliminate the dependency on 
local APIC timer for update_process_times(). The patch gets rid of Local APIC 
timer altogether. We use the timer interrupt (IRQ 0) configured in 
broadcast mode in IOAPIC instead (Doesn't work with 8259). 
As changing anything related to basic timer interrupt is a little bit risky, 
I have a boot parameter currently ("useapictimer") to switch back to original 
local APIC timer way of doing things.

This may seem like a overkill to solve this particular problem. But, I feel
it simplifies things and will have other advantages:
* Should help dynamick tick as one has to change only global timer interrupt 
  freq with varying jiffies.
* Reduces one interrupt per jiffy. 
* One less interrupt source to worry about.


The patch handles i386 and x86-64.

BEFORE:
/proc/interrupts at random time
lcoyote1-32-SLES9:~ # cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
  0:      32615      32194      32159      32166    IO-APIC-edge  timer
   :
   :
LOC:     128584     128699     128585     128699 
   :

AFTER:
/proc/interrupts at random time
lcoyote1-32-SLES9:~ # cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
  0:     719237     718797     718913     718911    IO-APIC-edge  timer
   :
   :
LOC:          0          0          0          0 
   :


TBD: 
* This is tested in normal i386 and x86-64 hardware. I think that this scheme 
  should work on NUMAQ and other subarchitectures as well. But, haven't really 
  tested it on such hardware.


Comments/concerns?

Thanks,
Venki

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

diff -purN linux-2.6.12-rc2-mm3/arch/i386/kernel/apic.c linux-2.6.12-rc2-mm3-new/arch/i386/kernel/apic.c
--- linux-2.6.12-rc2-mm3/arch/i386/kernel/apic.c	2005-04-30 07:20:19.500689424 -0700
+++ linux-2.6.12-rc2-mm3-new/arch/i386/kernel/apic.c	2005-04-30 07:24:37.064533768 -0700
@@ -707,6 +707,13 @@ static void apic_pm_activate(void) { }
  * Original code written by Keir Fraser.
  */
 
+static __init int setup_apictimer(char *str)
+{
+	using_apic_timer = 1;
+	return 0;
+}
+__setup("useapictimer", setup_apictimer);
+
 static int __init apic_set_verbosity(char *str)
 {
 	if (strcmp("debug", str) == 0)
@@ -1051,8 +1058,19 @@ static unsigned int calibration_result;
 
 void __init setup_boot_APIC_clock(void)
 {
+	/*
+	 * Special case: If we were not able to setup IOAPIC timer interrupt
+	 * to broadcast mode on an SMP capable system, then we have to use
+	 * local apic timer...
+	 */
+	if (!using_apic_timer && !timer_broadcast && (num_possible_cpus() > 1))
+		using_apic_timer = 1;
+
+	if (!using_apic_timer) {
+		apic_printk(APIC_VERBOSE, "Disabling APIC timer\n");
+		return;
+	}
 	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n");
-	using_apic_timer = 1;
 
 	local_irq_disable();
 
@@ -1154,9 +1172,7 @@ inline void smp_local_timer_interrupt(st
 						per_cpu(prof_counter, cpu);
 		}
 
-#ifdef CONFIG_SMP
 		update_process_times(user_mode(regs));
-#endif
 	}
 
 	/*
diff -purN linux-2.6.12-rc2-mm3/arch/i386/kernel/io_apic.c linux-2.6.12-rc2-mm3-new/arch/i386/kernel/io_apic.c
--- linux-2.6.12-rc2-mm3/arch/i386/kernel/io_apic.c	2005-04-30 07:20:19.514687296 -0700
+++ linux-2.6.12-rc2-mm3-new/arch/i386/kernel/io_apic.c	2005-04-30 07:24:37.066533464 -0700
@@ -84,6 +84,8 @@ int vector_irq[NR_VECTORS] = { [0 ... NR
 #define vector_to_irq(vector)	(vector)
 #endif
 
+int timer_broadcast;
+
 /*
  * The common case is 1:1 IRQ<->pin mappings. Sometimes there are
  * shared ISA-space IRQs, so we have to support them. We are super
@@ -221,6 +223,21 @@ static void clear_IO_APIC (void)
 			clear_IO_APIC_pin(apic, pin);
 }
 
+static void __init setup_IO_APIC_timer_broadcast(int pin)
+{
+	struct IO_APIC_route_entry entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	*(((int*)&entry) + 0) = io_apic_read(0, 0x10 + 2 * pin);
+	*(((int*)&entry) + 1) = io_apic_read(0, 0x11 + 2 * pin);
+	entry.delivery_mode = dest_Fixed;
+	entry.dest.logical.logical_dest = 0xff;
+	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry) + 1));
+	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry) + 0));
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
 static void set_ioapic_affinity_irq(unsigned int irq, cpumask_t cpumask)
 {
 	unsigned long flags;
@@ -228,6 +245,9 @@ static void set_ioapic_affinity_irq(unsi
 	struct irq_pin_list *entry = irq_2_pin + irq;
 	unsigned int apicid_value;
 	
+	if (irq_desc[irq].status & IRQ_PER_CPU)
+		return;
+
 	apicid_value = cpu_mask_to_apicid(cpumask);
 	/* Prepare to do the io_apic_write */
 	apicid_value = apicid_value << 24;
@@ -2207,6 +2227,11 @@ static inline void check_timer(void)
 				setup_nmi();
 				enable_8259A_irq(0);
 			}
+			if (!using_apic_timer) {
+				timer_broadcast = 1;
+				irq_desc[0].status |= IRQ_PER_CPU;
+				setup_IO_APIC_timer_broadcast(pin1);
+			}
 			return;
 		}
 		clear_IO_APIC_pin(0, pin1);
diff -purN linux-2.6.12-rc2-mm3/arch/i386/kernel/nmi.c linux-2.6.12-rc2-mm3-new/arch/i386/kernel/nmi.c
--- linux-2.6.12-rc2-mm3/arch/i386/kernel/nmi.c	2005-04-30 07:20:19.520686384 -0700
+++ linux-2.6.12-rc2-mm3-new/arch/i386/kernel/nmi.c	2005-04-30 07:25:43.341458144 -0700
@@ -504,7 +504,11 @@ void nmi_watchdog_tick (struct pt_regs *
 	 */
 	int sum, cpu = smp_processor_id();
 
-	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
+	if (using_apic_timer)
+		sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
+	else
+		sum = kstat_cpu(cpu).irqs[0];
+
 
 #ifdef CONFIG_KGDB
 	if (!in_kgdb(regs) && last_irq_sums[cpu] == sum) {
diff -purN linux-2.6.12-rc2-mm3/arch/i386/kernel/time.c linux-2.6.12-rc2-mm3-new/arch/i386/kernel/time.c
--- linux-2.6.12-rc2-mm3/arch/i386/kernel/time.c	2005-04-30 07:20:19.526685472 -0700
+++ linux-2.6.12-rc2-mm3-new/arch/i386/kernel/time.c	2005-04-30 07:24:37.067533312 -0700
@@ -297,14 +297,19 @@ irqreturn_t timer_interrupt(int irq, voi
 	 * CPU. We need to avoid to SMP race with it. NOTE: we don' t need
 	 * the irq version of write_lock because as just said we have irq
 	 * locally disabled. -arca
+	 * When timer interrupt is broadcast CPU0 becomes our timekeeper CPU
+	 * Side effect: CPU0 cannot be hot added/removed
 	 */
-	write_seqlock(&xtime_lock);
+	if (using_apic_timer || smp_processor_id() == 0) {
+		write_seqlock(&xtime_lock);
+		cur_timer->mark_offset();
+		do_timer_interrupt(irq, NULL, regs);
+		write_sequnlock(&xtime_lock);
+	}
 
-	cur_timer->mark_offset();
- 
-	do_timer_interrupt(irq, NULL, regs);
+	/* We don't need to grab xtime lock to handle per cpu schedule, etc */
+	do_timer_interrupt_hook_percpu(regs);
 
-	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
 }
 
diff -purN linux-2.6.12-rc2-mm3/arch/x86_64/kernel/apic.c linux-2.6.12-rc2-mm3-new/arch/x86_64/kernel/apic.c
--- linux-2.6.12-rc2-mm3/arch/x86_64/kernel/apic.c	2005-04-30 07:20:19.631669512 -0700
+++ linux-2.6.12-rc2-mm3-new/arch/x86_64/kernel/apic.c	2005-04-30 07:24:37.068533160 -0700
@@ -36,8 +36,6 @@
 
 int apic_verbosity;
 
-int disable_apic_timer __initdata;
-
 /* Using APIC to generate smp_local_timer_interrupt? */
 int using_apic_timer = 0;
 
@@ -790,13 +788,20 @@ static unsigned int calibration_result;
 
 void __init setup_boot_APIC_clock (void)
 {
-	if (disable_apic_timer) { 
+	/*
+	 * Special case: If we were not able to setup IOAPIC timer interrupt
+	 * to broadcast mode on an SMP capable system, then we have to use
+	 * local apic timer...
+	 */
+	if (!using_apic_timer && !timer_broadcast && (num_possible_cpus() > 1))
+		using_apic_timer = 1;
+
+	if (!using_apic_timer) { 
 		printk(KERN_INFO "Disabling APIC timer\n"); 
 		return; 
 	} 
 
 	printk(KERN_INFO "Using local APIC timer interrupts.\n");
-	using_apic_timer = 1;
 
 	local_irq_disable();
 
@@ -899,9 +904,7 @@ void smp_local_timer_interrupt(struct pt
 				per_cpu(prof_counter, cpu);
 		}
 
-#ifdef CONFIG_SMP
 		update_process_times(user_mode(regs));
-#endif
 	}
 
 	/*
@@ -1108,9 +1111,9 @@ static __init int setup_nolapic(char *st
 	return 0;
 } 
 
-static __init int setup_noapictimer(char *str) 
+static __init int setup_apictimer(char *str) 
 { 
-	disable_apic_timer = 1;
+	using_apic_timer = 1;
 	return 0;
 } 
 
@@ -1119,6 +1122,6 @@ static __init int setup_noapictimer(char
 __setup("disableapic", setup_disableapic); 
 __setup("nolapic", setup_nolapic);  /* same as disableapic, for compatibility */
 
-__setup("noapictimer", setup_noapictimer); 
+__setup("useapictimer", setup_apictimer); 
 
 /* no "lapic" flag - we only use the lapic when the BIOS tells us so. */
diff -purN linux-2.6.12-rc2-mm3/arch/x86_64/kernel/io_apic.c linux-2.6.12-rc2-mm3-new/arch/x86_64/kernel/io_apic.c
--- linux-2.6.12-rc2-mm3/arch/x86_64/kernel/io_apic.c	2005-04-30 07:20:19.636668752 -0700
+++ linux-2.6.12-rc2-mm3-new/arch/x86_64/kernel/io_apic.c	2005-04-30 07:24:37.070532856 -0700
@@ -75,6 +75,8 @@ int vector_irq[NR_VECTORS] = { [0 ... NR
 #define vector_to_irq(vector)	(vector)
 #endif
 
+int timer_broadcast;
+
 /*
  * The common case is 1:1 IRQ<->pin mappings. Sometimes there are
  * shared ISA-space IRQs, so we have to support them. We are super
@@ -179,6 +181,21 @@ static void clear_IO_APIC (void)
 			clear_IO_APIC_pin(apic, pin);
 }
 
+static void __init setup_IO_APIC_timer_broadcast(int pin)
+{
+	struct IO_APIC_route_entry entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	*(((int*)&entry) + 0) = io_apic_read(0, 0x10 + 2 * pin);
+	*(((int*)&entry) + 1) = io_apic_read(0, 0x11 + 2 * pin);
+	entry.delivery_mode = dest_Fixed;
+	entry.dest.logical.logical_dest = 0xff;
+	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry) + 1));
+	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry) + 0));
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
 /*
  * support for broken MP BIOSs, enables hand-redirection of PIRQ0-7 to
  * specific CPU-side IRQs.
@@ -1349,6 +1366,9 @@ static void set_ioapic_affinity_irq(unsi
 	unsigned long flags;
 	unsigned int dest;
 
+	if (irq_desc[irq].status & IRQ_PER_CPU)
+		return;
+
 	dest = cpu_mask_to_apicid(mask);
 
 	/*
@@ -1640,6 +1660,11 @@ static inline void check_timer(void)
 				setup_nmi();
 				enable_8259A_irq(0);
 			}
+			if (!using_apic_timer) {
+				timer_broadcast = 1;
+				irq_desc[0].status |= IRQ_PER_CPU;
+				setup_IO_APIC_timer_broadcast(pin1);
+			}
 			return;
 		}
 		clear_IO_APIC_pin(0, pin1);
diff -purN linux-2.6.12-rc2-mm3/arch/x86_64/kernel/nmi.c linux-2.6.12-rc2-mm3-new/arch/x86_64/kernel/nmi.c
--- linux-2.6.12-rc2-mm3/arch/x86_64/kernel/nmi.c	2005-04-30 07:20:19.643667688 -0700
+++ linux-2.6.12-rc2-mm3-new/arch/x86_64/kernel/nmi.c	2005-04-30 07:24:37.070532856 -0700
@@ -389,7 +389,11 @@ void nmi_watchdog_tick (struct pt_regs *
 	int sum, cpu;
 
 	cpu = safe_smp_processor_id();
-	sum = read_pda(apic_timer_irqs);
+	if (using_apic_timer)
+		sum = read_pda(apic_timer_irqs);
+	else
+		sum = kstat_cpu(cpu).irqs[0];
+
 	if (last_irq_sums[cpu] == sum) {
 		/*
 		 * Ayiee, looks like this CPU is stuck ...
diff -purN linux-2.6.12-rc2-mm3/arch/x86_64/kernel/time.c linux-2.6.12-rc2-mm3-new/arch/x86_64/kernel/time.c
--- linux-2.6.12-rc2-mm3/arch/x86_64/kernel/time.c	2005-04-30 07:20:19.650666624 -0700
+++ linux-2.6.12-rc2-mm3-new/arch/x86_64/kernel/time.c	2005-04-30 07:24:37.071532704 -0700
@@ -358,7 +358,7 @@ static noinline void handle_lost_ticks(i
 #endif
 }
 
-static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	static unsigned long rtc_update = 0;
 	unsigned long tsc;
@@ -423,27 +423,10 @@ static irqreturn_t timer_interrupt(int i
 		jiffies += lost;
 	}
 
-/*
- * Do the timer stuff.
- */
-
+	/*
+	 * Do the timer stuff.
+	 */
 	do_timer(regs);
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
-#endif
-
-/*
- * In the SMP case we use the local APIC timer interrupt to do the profiling,
- * except when we simulate SMP mode on a uniprocessor system, in that case we
- * have to call the local interrupt handler.
- */
-
-#ifndef CONFIG_X86_LOCAL_APIC
-	profile_tick(CPU_PROFILING, regs);
-#else
-	if (!using_apic_timer)
-		smp_local_timer_interrupt(regs);
-#endif
 
 /*
  * If we have an externally synchronized Linux clock, then update CMOS clock
@@ -461,6 +444,31 @@ static irqreturn_t timer_interrupt(int i
  
 	write_sequnlock(&xtime_lock);
 
+	return;
+}
+
+static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	/*
+	 * CPU0 becomes our timekeeper CPU
+	 * Side effect: CPU0 cannot be hot added/removed
+	 */
+	if (using_apic_timer || smp_processor_id() == 0)
+		do_timer_interrupt(irq, dev_id, regs);
+
+        /*
+	 * In case we are using local APIC timer interrupt these calls
+	 * will be done there.
+	 */
+#ifndef CONFIG_X86_LOCAL_APIC
+	update_process_times(user_mode(regs));
+	profile_tick(CPU_PROFILING, regs);
+#else
+	if (!using_apic_timer) {
+		update_process_times(user_mode(regs));
+		profile_tick(CPU_PROFILING, regs);
+	}
+#endif
 	return IRQ_HANDLED;
 }
 
diff -purN linux-2.6.12-rc2-mm3/include/asm-i386/io_apic.h linux-2.6.12-rc2-mm3-new/include/asm-i386/io_apic.h
--- linux-2.6.12-rc2-mm3/include/asm-i386/io_apic.h	2005-03-01 23:38:13.000000000 -0800
+++ linux-2.6.12-rc2-mm3-new/include/asm-i386/io_apic.h	2005-04-30 07:24:37.072532552 -0700
@@ -13,6 +13,8 @@
 
 #ifdef CONFIG_X86_IO_APIC
 
+extern int timer_broadcast;
+
 #ifdef CONFIG_PCI_MSI
 static inline int use_pci_vector(void)	{return 1;}
 static inline void disable_edge_ioapic_vector(unsigned int vector) { }
diff -purN linux-2.6.12-rc2-mm3/include/asm-i386/mach-default/do_timer.h linux-2.6.12-rc2-mm3-new/include/asm-i386/mach-default/do_timer.h
--- linux-2.6.12-rc2-mm3/include/asm-i386/mach-default/do_timer.h	2005-03-01 23:38:26.000000000 -0800
+++ linux-2.6.12-rc2-mm3-new/include/asm-i386/mach-default/do_timer.h	2005-04-30 07:24:37.072532552 -0700
@@ -16,23 +16,36 @@
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
 	do_timer(regs);
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
-#endif
-/*
- * In the SMP case we use the local APIC timer interrupt to do the
- * profiling, except when we simulate SMP mode on a uniprocessor
- * system, in that case we have to call the local interrupt handler.
- */
+}
+
+
+/**
+ * do_timer_interrupt_hook_percpu - hook into timer tick for each cpu
+ * @regs:	standard registers from interrupt
+ *
+ * Description:
+ *	It's primary purpose is to allow architectures that don't use
+ *	individual per CPU clocks (like the CPU APICs supply) to handle
+ *	timer interrupt as a means of triggering reschedules etc.
+ **/
+
+static inline void do_timer_interrupt_hook_percpu(struct pt_regs *regs)
+{
+	/*
+	 * In case we are using local APIC timer interrupt these calls
+	 * will be done there.
+	 */
 #ifndef CONFIG_X86_LOCAL_APIC
+	update_process_times(user_mode(regs));
 	profile_tick(CPU_PROFILING, regs);
 #else
-	if (!using_apic_timer)
-		smp_local_timer_interrupt(regs);
+	if (!using_apic_timer) {
+		update_process_times(user_mode(regs));
+		profile_tick(CPU_PROFILING, regs);
+	}
 #endif
 }
 
-
 /* you can safely undefine this if you don't have the Neptune chipset */
 
 #define BUGGY_NEPTUN_TIMER
diff -purN linux-2.6.12-rc2-mm3/include/asm-i386/mach-visws/do_timer.h linux-2.6.12-rc2-mm3-new/include/asm-i386/mach-visws/do_timer.h
--- linux-2.6.12-rc2-mm3/include/asm-i386/mach-visws/do_timer.h	2005-03-01 23:37:53.000000000 -0800
+++ linux-2.6.12-rc2-mm3-new/include/asm-i386/mach-visws/do_timer.h	2005-04-30 07:24:37.072532552 -0700
@@ -9,15 +9,13 @@ static inline void do_timer_interrupt_ho
 	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
 
 	do_timer(regs);
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
-#endif
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
  * profiling, except when we simulate SMP mode on a uniprocessor
  * system, in that case we have to call the local interrupt handler.
  */
 #ifndef CONFIG_X86_LOCAL_APIC
+	update_process_times(user_mode(regs));
 	profile_tick(CPU_PROFILING, regs);
 #else
 	if (!using_apic_timer)
@@ -25,6 +23,17 @@ static inline void do_timer_interrupt_ho
 #endif
 }
 
+/**
+ * do_timer_interrupt_hook_percpu - hook into timer tick for each cpu
+ * @regs:	standard registers from interrupt
+ *
+ * Description:
+ *	It's primary purpose is to allow architectures that don't use
+ *	individual per CPU clocks (like the CPU APICs supply) to handle
+ *	timer interrupt as a means of triggering reschedules etc.
+ **/
+static inline void do_timer_interrupt_hook_percpu(struct pt_regs *regs) {}
+
 static inline int do_timer_overflow(int count)
 {
 	int i;
diff -purN linux-2.6.12-rc2-mm3/include/asm-i386/mach-voyager/do_timer.h linux-2.6.12-rc2-mm3-new/include/asm-i386/mach-voyager/do_timer.h
--- linux-2.6.12-rc2-mm3/include/asm-i386/mach-voyager/do_timer.h	2005-03-01 23:38:17.000000000 -0800
+++ linux-2.6.12-rc2-mm3-new/include/asm-i386/mach-voyager/do_timer.h	2005-04-30 07:24:37.073532400 -0700
@@ -11,6 +11,17 @@ static inline void do_timer_interrupt_ho
 	voyager_timer_interrupt(regs);
 }
 
+/**
+ * do_timer_interrupt_hook_percpu - hook into timer tick for each cpu
+ * @regs:	standard registers from interrupt
+ *
+ * Description:
+ *	It's primary purpose is to allow architectures that don't use
+ *	individual per CPU clocks (like the CPU APICs supply) to handle
+ *	timer interrupt as a means of triggering reschedules etc.
+ **/
+static inline void do_timer_interrupt_hook_percpu(struct pt_regs *regs) {}
+
 static inline int do_timer_overflow(int count)
 {
 	/* can't read the ISR, just assume 1 tick
diff -purN linux-2.6.12-rc2-mm3/include/asm-x86_64/io_apic.h linux-2.6.12-rc2-mm3-new/include/asm-x86_64/io_apic.h
--- linux-2.6.12-rc2-mm3/include/asm-x86_64/io_apic.h	2005-03-01 23:37:49.000000000 -0800
+++ linux-2.6.12-rc2-mm3-new/include/asm-x86_64/io_apic.h	2005-04-30 07:24:37.073532400 -0700
@@ -13,6 +13,8 @@
 
 #ifdef CONFIG_X86_IO_APIC
 
+extern int timer_broadcast;
+
 #ifdef CONFIG_PCI_MSI
 static inline int use_pci_vector(void)	{return 1;}
 static inline void disable_edge_ioapic_vector(unsigned int vector) { }
