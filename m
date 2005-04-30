Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263131AbVD3CeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbVD3CeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 22:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbVD3CeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 22:34:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:17813 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263131AbVD3Cd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 22:33:29 -0400
Date: Fri, 29 Apr 2005 19:32:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: torvalds@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com, johnstul@us.ibm.com, ak@suse.de,
       asit.k.mallick@intel.com
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Message-Id: <20050429193251.2a028150.akpm@osdl.org>
In-Reply-To: <20050429172605.A23722@unix-os.sc.intel.com>
References: <20050429172605.A23722@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> wrote:
>
> Background: 
>  Local APIC timer stops functioning when CPU is in C3 state. As a
>  result the local APIC timer interrupt will fire at uncertain times, depending
>  on how long we spend in C3 state. And this has two side effects
>  * Idle balancing will not happen as we expect it to.
>  * Kernel statistics for idle time will not be proper (as we get less LAPIC
>    interrupts when we are idle). This can result in confusing other parts of
>    kernel (like ondemand cpufreq governor) which depends on this idle stats.
> 
> 
>  Proposed Fix: 
>  Attached is a prototype patch, that tries to eliminate the dependency on 
>  local APIC timer for update_process_times(). The patch gets rid of Local APIC 
>  timer altogether. We use the timer interrupt (IRQ 0) configured in 
>  broadcast mode in IOAPIC instead (Doesn't work with 8259). 
>  As changing anything related to basic timer interrupt is a little bit risky, 
>  I have a boot parameter currently ("useapictimer") to switch back to original 
>  local APIC timer way of doing things.
> 
>  This may seem like a overkill to solve this particular problem. But, I feel
>  it simplifies things and will have other advantages:
>  * Should help dynamick tick as one has to change only global timer interrupt 
>    freq with varying jiffies.
>  * Reduces one interrupt per jiffy. 
>  * One less interrupt source to worry about.

The patch (at least, as I merged it) goes into a ghastly death spiral early
in boot.

Serial console says:


Initializing CPU#1
Calibrating delay using timer specific routine.. 5615.95 BogoMIPS (lpj=2807978)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU1: Intel Pentium 4 (Northwood) stepping 07
Total of 2 processors activated (11238.26 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
Unable to handle kernel NULL pointer dereference

which isn't very helpful.

tty output is at http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02506.jpg

which is also less that totally useful.

There's waaaaaaaaay too much low-level x86 stuff happening at present.  We
need to settle it down, go more slowly, take more care and test things
better, please.  Next -mm has already been delayed by two days due to my
having to chase down all the bugs people have been sending me.

Here's what I merged:




From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

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

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Zwane: 

 I'm rather reluctant to advocate the broadcast scheme as I can see it
 breaking on a lot of systems, e.g.  SMP systems which use i8259 (as you
 noted), IBM x440 and ES7000.  If anything the default mode should be APIC
 timer and have a parameter to disable it.  Regarding things like variable
 timer ticks, reprogramming the PIT is slow, and using it extensively for such
 sounds like a step in the wrong direction.  Is this feature/bug going to
 proliferate amongst newer processor local APICs?

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/apic.c                  |   22 +++++++++++--
 arch/i386/kernel/io_apic.c               |   25 +++++++++++++++
 arch/i386/kernel/nmi.c                   |    6 +++
 arch/i386/kernel/time.c                  |   15 ++++++---
 arch/x86_64/kernel/apic.c                |   21 +++++++------
 arch/x86_64/kernel/io_apic.c             |   25 +++++++++++++++
 arch/x86_64/kernel/nmi.c                 |    6 +++
 arch/x86_64/kernel/time.c                |   50 +++++++++++++++++--------------
 include/asm-i386/io_apic.h               |    2 +
 include/asm-i386/mach-default/do_timer.h |   35 ++++++++++++++-------
 include/asm-i386/mach-visws/do_timer.h   |   15 +++++++--
 include/asm-i386/mach-voyager/do_timer.h |   11 ++++++
 include/asm-x86_64/io_apic.h             |    2 +
 13 files changed, 181 insertions(+), 54 deletions(-)

diff -puN arch/i386/kernel/apic.c~i386-x86-64-eliminate-local-apic-timer-interrupt arch/i386/kernel/apic.c
--- 25/arch/i386/kernel/apic.c~i386-x86-64-eliminate-local-apic-timer-interrupt	2005-04-29 18:32:14.433620256 -0700
+++ 25-akpm/arch/i386/kernel/apic.c	2005-04-29 18:32:14.455616912 -0700
@@ -685,6 +685,13 @@ static int __init lapic_enable(char *str
 }
 __setup("lapic", lapic_enable);
 
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
@@ -1029,8 +1036,19 @@ static unsigned int calibration_result;
 
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
 
@@ -1132,9 +1150,7 @@ inline void smp_local_timer_interrupt(st
 						per_cpu(prof_counter, cpu);
 		}
 
-#ifdef CONFIG_SMP
 		update_process_times(user_mode(regs));
-#endif
 	}
 
 	/*
diff -puN arch/i386/kernel/io_apic.c~i386-x86-64-eliminate-local-apic-timer-interrupt arch/i386/kernel/io_apic.c
--- 25/arch/i386/kernel/io_apic.c~i386-x86-64-eliminate-local-apic-timer-interrupt	2005-04-29 18:32:14.435619952 -0700
+++ 25-akpm/arch/i386/kernel/io_apic.c	2005-04-29 18:32:14.458616456 -0700
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
@@ -235,6 +252,9 @@ static void set_ioapic_affinity_irq(unsi
 
 	cpus_and(cpumask, tmp, CPU_MASK_ALL);
 
+	if (irq_desc[irq].status & IRQ_PER_CPU)
+		return;
+
 	apicid_value = cpu_mask_to_apicid(cpumask);
 	/* Prepare to do the io_apic_write */
 	apicid_value = apicid_value << 24;
@@ -2178,6 +2198,11 @@ static inline void check_timer(void)
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
diff -puN arch/i386/kernel/nmi.c~i386-x86-64-eliminate-local-apic-timer-interrupt arch/i386/kernel/nmi.c
--- 25/arch/i386/kernel/nmi.c~i386-x86-64-eliminate-local-apic-timer-interrupt	2005-04-29 18:32:14.436619800 -0700
+++ 25-akpm/arch/i386/kernel/nmi.c	2005-04-29 18:32:14.458616456 -0700
@@ -486,7 +486,11 @@ void nmi_watchdog_tick (struct pt_regs *
 	 */
 	int sum, cpu = smp_processor_id();
 
-	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
+	if (using_apic_timer)
+		sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
+	else
+		sum = kstat_cpu(cpu).irqs[0];
+
 
 	if (last_irq_sums[cpu] == sum) {
 		/*
diff -puN arch/i386/kernel/time.c~i386-x86-64-eliminate-local-apic-timer-interrupt arch/i386/kernel/time.c
--- 25/arch/i386/kernel/time.c~i386-x86-64-eliminate-local-apic-timer-interrupt	2005-04-29 18:32:14.438619496 -0700
+++ 25-akpm/arch/i386/kernel/time.c	2005-04-29 18:32:14.459616304 -0700
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
 
diff -puN arch/x86_64/kernel/apic.c~i386-x86-64-eliminate-local-apic-timer-interrupt arch/x86_64/kernel/apic.c
--- 25/arch/x86_64/kernel/apic.c~i386-x86-64-eliminate-local-apic-timer-interrupt	2005-04-29 18:32:14.439619344 -0700
+++ 25-akpm/arch/x86_64/kernel/apic.c	2005-04-29 18:32:14.461616000 -0700
@@ -36,8 +36,6 @@
 
 int apic_verbosity;
 
-int disable_apic_timer __initdata;
-
 /* Using APIC to generate smp_local_timer_interrupt? */
 int using_apic_timer = 0;
 
@@ -754,13 +752,20 @@ static unsigned int calibration_result;
 
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
 
@@ -863,9 +868,7 @@ void smp_local_timer_interrupt(struct pt
 				per_cpu(prof_counter, cpu);
 		}
 
-#ifdef CONFIG_SMP
 		update_process_times(user_mode(regs));
-#endif
 	}
 
 	/*
@@ -1072,9 +1075,9 @@ static __init int setup_nolapic(char *st
 	return 0;
 } 
 
-static __init int setup_noapictimer(char *str) 
+static __init int setup_apictimer(char *str)
 { 
-	disable_apic_timer = 1;
+	using_apic_timer = 1;
 	return 0;
 } 
 
@@ -1083,6 +1086,6 @@ static __init int setup_noapictimer(char
 __setup("disableapic", setup_disableapic); 
 __setup("nolapic", setup_nolapic);  /* same as disableapic, for compatibility */
 
-__setup("noapictimer", setup_noapictimer); 
+__setup("useapictimer", setup_apictimer);
 
 /* no "lapic" flag - we only use the lapic when the BIOS tells us so. */
diff -puN arch/x86_64/kernel/io_apic.c~i386-x86-64-eliminate-local-apic-timer-interrupt arch/x86_64/kernel/io_apic.c
--- 25/arch/x86_64/kernel/io_apic.c~i386-x86-64-eliminate-local-apic-timer-interrupt	2005-04-29 18:32:14.441619040 -0700
+++ 25-akpm/arch/x86_64/kernel/io_apic.c	2005-04-29 18:32:14.462615848 -0700
@@ -109,6 +109,9 @@ static void set_ioapic_affinity_irq(unsi
 
 	cpus_and(mask, tmp, CPU_MASK_ALL);
 
+	if (irq_desc[irq].status & IRQ_PER_CPU)
+		return;
+
 	dest = cpu_mask_to_apicid(mask);
 
 	/*
@@ -128,6 +131,8 @@ static void set_ioapic_affinity_irq(unsi
 }
 #endif
 
+int timer_broadcast;
+
 /*
  * The common case is 1:1 IRQ<->pin mappings. Sometimes there are
  * shared ISA-space IRQs, so we have to support them. We are super
@@ -212,6 +217,21 @@ static void clear_IO_APIC (void)
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
@@ -1630,6 +1650,11 @@ static inline void check_timer(void)
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
diff -puN arch/x86_64/kernel/nmi.c~i386-x86-64-eliminate-local-apic-timer-interrupt arch/x86_64/kernel/nmi.c
--- 25/arch/x86_64/kernel/nmi.c~i386-x86-64-eliminate-local-apic-timer-interrupt	2005-04-29 18:32:14.443618736 -0700
+++ 25-akpm/arch/x86_64/kernel/nmi.c	2005-04-29 18:32:14.463615696 -0700
@@ -384,7 +384,11 @@ void nmi_watchdog_tick (struct pt_regs *
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
diff -puN arch/x86_64/kernel/time.c~i386-x86-64-eliminate-local-apic-timer-interrupt arch/x86_64/kernel/time.c
--- 25/arch/x86_64/kernel/time.c~i386-x86-64-eliminate-local-apic-timer-interrupt	2005-04-29 18:32:14.444618584 -0700
+++ 25-akpm/arch/x86_64/kernel/time.c	2005-04-29 18:32:14.464615544 -0700
@@ -361,7 +361,7 @@ static noinline void handle_lost_ticks(i
 #endif
 }
 
-static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	static unsigned long rtc_update = 0;
 	unsigned long tsc;
@@ -433,27 +433,10 @@ static irqreturn_t timer_interrupt(int i
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
@@ -471,6 +454,31 @@ static irqreturn_t timer_interrupt(int i
  
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
 
diff -puN include/asm-i386/io_apic.h~i386-x86-64-eliminate-local-apic-timer-interrupt include/asm-i386/io_apic.h
--- 25/include/asm-i386/io_apic.h~i386-x86-64-eliminate-local-apic-timer-interrupt	2005-04-29 18:32:14.445618432 -0700
+++ 25-akpm/include/asm-i386/io_apic.h	2005-04-29 18:32:14.465615392 -0700
@@ -13,6 +13,8 @@
 
 #ifdef CONFIG_X86_IO_APIC
 
+extern int timer_broadcast;
+
 #ifdef CONFIG_PCI_MSI
 static inline int use_pci_vector(void)	{return 1;}
 static inline void disable_edge_ioapic_vector(unsigned int vector) { }
diff -puN include/asm-i386/mach-default/do_timer.h~i386-x86-64-eliminate-local-apic-timer-interrupt include/asm-i386/mach-default/do_timer.h
--- 25/include/asm-i386/mach-default/do_timer.h~i386-x86-64-eliminate-local-apic-timer-interrupt	2005-04-29 18:32:14.447618128 -0700
+++ 25-akpm/include/asm-i386/mach-default/do_timer.h	2005-04-29 18:32:14.465615392 -0700
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
diff -puN include/asm-i386/mach-visws/do_timer.h~i386-x86-64-eliminate-local-apic-timer-interrupt include/asm-i386/mach-visws/do_timer.h
--- 25/include/asm-i386/mach-visws/do_timer.h~i386-x86-64-eliminate-local-apic-timer-interrupt	2005-04-29 18:32:14.448617976 -0700
+++ 25-akpm/include/asm-i386/mach-visws/do_timer.h	2005-04-29 18:32:14.466615240 -0700
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
diff -puN include/asm-i386/mach-voyager/do_timer.h~i386-x86-64-eliminate-local-apic-timer-interrupt include/asm-i386/mach-voyager/do_timer.h
--- 25/include/asm-i386/mach-voyager/do_timer.h~i386-x86-64-eliminate-local-apic-timer-interrupt	2005-04-29 18:32:14.450617672 -0700
+++ 25-akpm/include/asm-i386/mach-voyager/do_timer.h	2005-04-29 18:32:14.466615240 -0700
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
diff -puN include/asm-x86_64/io_apic.h~i386-x86-64-eliminate-local-apic-timer-interrupt include/asm-x86_64/io_apic.h
--- 25/include/asm-x86_64/io_apic.h~i386-x86-64-eliminate-local-apic-timer-interrupt	2005-04-29 18:32:14.451617520 -0700
+++ 25-akpm/include/asm-x86_64/io_apic.h	2005-04-29 18:32:14.466615240 -0700
@@ -13,6 +13,8 @@
 
 #ifdef CONFIG_X86_IO_APIC
 
+extern int timer_broadcast;
+
 #ifdef CONFIG_PCI_MSI
 static inline int use_pci_vector(void)	{return 1;}
 static inline void disable_edge_ioapic_vector(unsigned int vector) { }
_

