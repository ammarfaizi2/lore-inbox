Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVHLUTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVHLUTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 16:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVHLUTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 16:19:03 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41964 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750810AbVHLUTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 16:19:01 -0400
Date: Sat, 13 Aug 2005 01:49:46 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com
Cc: akpm@osdl.org, george@mvista.com, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com, ak@muc.de, johnstul@us.ibm.com
Subject: [PATCH] dynamic-tick patch modified for SMP
Message-ID: <20050812201946.GA5327@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Here's finally the SMP changes that I had promised. The patch 
breaks the earlier restriction that all CPUs have to be idle before 
cutting of timers and now allows each idle CPU to skip ticks independent
of others. The patch is against 2.6.13-rc6 and applies on top of Con's 
patch maintained here:

	http://ck.kolivas.org/patches/dyn-ticks/2.6.13-rc6-dtck-1.patch

I have done some prelimnary tests on a 4way P3 box. An important concern
I have is how time is recovered after wakeup. Right now I am depending
on the logic present in cur_timer->mark_offset() to recover time. Not
sure how well this performs for extended periods of sleep.

Still on my Todo List:

	- next_timer_interrupt needs to be fixed (as pointed out by George)
	- Would be good to have S390/Arm converted over to use this
	- Tony mentioned that some AMD SMP machines require that
	  CPUs skip timers (& put themselves in some low power state) only 
	  when all are idle. This patch does not address that yet. It is
	  also not clear whether such configuration are common that we have
	  to bother about now. Perhaps the arch_all_cpus_idle interface
	  that I have added could be put to some use here.
	- Extend jiffies recovery code in timer_tsc.c to be based on 
	  64-bit snapshot of TSC. Will enable longer sleep durations
	- Code-style changes (havent give lot of my attention here yet)

Patch follows:



This patch modifies dynamic-tick patch to let CPUs sleep independent of
each other. Important changes introduced in this patch are:

	- Modify dyn_tick_reprogram_timer to support this feature.
	- Add calls to dyn_tick_interrupt from all possible interrupt paths
	- Add arch_all_cpus_idle interface, which can be used to do platform 
	  specific things like stopping PIT timer when all CPUs are idle
	- Let kernel code recover time/jiffies (instead of handling it in 
	  dynamic-tick patch)

Some of the other changes in this patch (like masking PIT interrupts instead of 
reprogramming it and conditionally running local timers) comes from VST 
(Variable Sleep Time).


Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.13-rc6-work-root/arch/i386/kernel/apic.c             |   16 -
 linux-2.6.13-rc6-work-root/arch/i386/kernel/dyn-tick.c         |  121 ++++------
 linux-2.6.13-rc6-work-root/arch/i386/kernel/io_apic.c          |   23 +
 linux-2.6.13-rc6-work-root/arch/i386/kernel/process.c          |    7 
 linux-2.6.13-rc6-work-root/arch/i386/kernel/smp.c              |    8 
 linux-2.6.13-rc6-work-root/arch/i386/kernel/time.c             |    3 
 linux-2.6.13-rc6-work-root/arch/i386/kernel/timers/timer_pit.c |   16 -
 linux-2.6.13-rc6-work-root/arch/i386/kernel/timers/timer_pm.c  |    4 
 linux-2.6.13-rc6-work-root/arch/i386/kernel/timers/timer_tsc.c |   10 
 linux-2.6.13-rc6-work-root/arch/i386/mach-default/setup.c      |   16 -
 linux-2.6.13-rc6-work-root/include/asm-i386/dyn-tick.h         |   15 -
 linux-2.6.13-rc6-work-root/include/linux/dyn-tick.h            |   11 
 linux-2.6.13-rc6-work-root/include/linux/timer.h               |    1 
 linux-2.6.13-rc6-work-root/kernel/dyn-tick.c                   |   67 ++---
 linux-2.6.13-rc6-work-root/kernel/timer.c                      |    8 
 15 files changed, 155 insertions(+), 171 deletions(-)

diff -puN arch/i386/kernel/apic.c~dynamic-tick-smp arch/i386/kernel/apic.c
--- linux-2.6.13-rc6-work/arch/i386/kernel/apic.c~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/arch/i386/kernel/apic.c	2005-08-13 00:20:25.000000000 +0530
@@ -954,9 +954,6 @@ static void __setup_APIC_LVTT(unsigned i
 
 	apic_timer_val = clocks / APIC_DIVISOR;
 
-	if (apic_timer_val)
-		set_dyn_tick_max_skip(apic_timer_val);
-
 	apic_write_around(APIC_TMICT, apic_timer_val);
 }
 
@@ -1071,6 +1068,7 @@ void __init setup_boot_APIC_clock(void)
 	setup_APIC_timer(calibration_result);
 
 	setup_dyn_tick_use_apic(calibration_result);
+	set_dyn_tick_max_skip( (0xFFFFFFFF/calibration_result) * APIC_DIVISOR);
 
 	local_irq_enable();
 }
@@ -1211,11 +1209,7 @@ fastcall void smp_apic_timer_interrupt(s
 	 */
 	irq_enter();
 
-	/*
-	 * Check if we need to wake up PIT interrupt handler.
-	 * Otherwise just wake up local APIC timer.
-	 */
-	wakeup_pit_or_apic(cpu, regs);
+	dyn_tick_interrupt(LOCAL_TIMER_VECTOR, regs);
 
 	smp_local_timer_interrupt(regs);
 	irq_exit();
@@ -1229,6 +1223,9 @@ fastcall void smp_spurious_interrupt(str
 	unsigned long v;
 
 	irq_enter();
+
+	dyn_tick_interrupt(SPURIOUS_APIC_VECTOR, regs);
+
 	/*
 	 * Check if this really is a spurious interrupt and ACK it
 	 * if it is a vectored one.  Just in case...
@@ -1253,6 +1250,9 @@ fastcall void smp_error_interrupt(struct
 	unsigned long v, v1;
 
 	irq_enter();
+
+	dyn_tick_interrupt(ERROR_APIC_VECTOR, regs);
+
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v = apic_read(APIC_ESR);
 	apic_write(APIC_ESR, 0);
diff -puN arch/i386/kernel/dyn-tick.c~dynamic-tick-smp arch/i386/kernel/dyn-tick.c
--- linux-2.6.13-rc6-work/arch/i386/kernel/dyn-tick.c~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/arch/i386/kernel/dyn-tick.c	2005-08-13 01:10:54.000000000 +0530
@@ -16,24 +16,37 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/dyn-tick.h>
+#include <linux/timer.h>
 #include <asm/apic.h>
 
-static void arch_reprogram_timer(void)
+
+static void arch_reprogram_timer(unsigned long jif_next)
 {
+	unsigned int skip = jif_next - jiffies;
+
 	if (cpu_has_local_apic()) {
-		disable_pit_timer();
 		if (dyn_tick->state & DYN_TICK_TIMER_INT)
-			reprogram_apic_timer(dyn_tick->skip);
+			reprogram_apic_timer(skip);
 	} else {
 		if (dyn_tick->state & DYN_TICK_TIMER_INT)
-			reprogram_pit_timer(dyn_tick->skip);
+			reprogram_pit_timer(skip);
 		else
 			disable_pit_timer();
 	}
+
+	/* Fixme: Disable NMI Watchdog */
+}
+
+static void arch_all_cpus_idle(int how_long)
+{
+	if (cpu_has_local_apic())
+		if (dyn_tick->state & DYN_TICK_TIMER_INT)
+			disable_pit_timer();
 }
 
 static struct dyn_tick_timer arch_dyn_tick_timer = {
 	.arch_reprogram_timer	= &arch_reprogram_timer,
+	.arch_all_cpus_idle	= &arch_all_cpus_idle,
 };
 
 static int __init dyn_tick_init(void)
@@ -46,65 +59,22 @@ static int __init dyn_tick_init(void)
 
 arch_initcall(dyn_tick_init);
 
-static unsigned long long last_tick;
-
-/*
- * This interrupt handler updates the time based on number of jiffies skipped
- * It would be somewhat more optimized to have a custom handler in each timer
- * using hardware ticks instead of nanoseconds. Note that CONFIG_NO_IDLE_HZ
- * currently disables timer fallback on skipped jiffies.
- */
-static irqreturn_t dyn_tick_timer_interrupt(int irq, void *dev_id,
-				     struct pt_regs *regs)
-{
-	unsigned long flags;
-	volatile unsigned long long now;
-	unsigned int skipped = 0;
-
-	write_seqlock_irqsave(&xtime_lock, flags);
-	now = cur_timer->monotonic_clock();
-	while (now - last_tick >= NS_TICK_LEN) {
-		last_tick += NS_TICK_LEN;
-		cur_timer->mark_offset();
-		do_timer_interrupt(irq, NULL, regs);
-		skipped++;
-	}
-	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING)) {
-		dyn_tick->skip = 1;
-		if (cpu_has_local_apic())
-			reprogram_apic_timer(dyn_tick->skip);
-		reprogram_pit_timer(dyn_tick->skip);
-		dyn_tick->state |= DYN_TICK_ENABLED;
-		dyn_tick->state &= ~DYN_TICK_SKIPPING;
-	}
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-
-	return IRQ_HANDLED;
-}
-
 int __init dyn_tick_arch_init(void)
 {
-	unsigned long flags;
 
-	write_seqlock_irqsave(&xtime_lock, flags);
-	last_tick = cur_timer->monotonic_clock();
-	dyn_tick->skip = 1;
 	if (!(dyn_tick->state & DYN_TICK_USE_APIC) || !cpu_has_local_apic())
 		dyn_tick->max_skip = 0xffff / LATCH;	/* PIT timer length */
 	printk(KERN_INFO "dyn-tick: Maximum ticks to skip limited to %i\n",
 	       dyn_tick->max_skip);
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-
-	dyn_tick->interrupt = dyn_tick_timer_interrupt;
-	replace_timer_interrupt(dyn_tick->interrupt);
 
 	return 0;
 }
 
 /* Functions that need blank prototypes for !CONFIG_NO_IDLE_HZ below here */
-void set_dyn_tick_max_skip(u32 apic_timer_val)
+void set_dyn_tick_max_skip(unsigned int max_skip)
 {
-	dyn_tick->max_skip = 0xffffff / apic_timer_val;
+	if (!dyn_tick->max_skip || max_skip < dyn_tick->max_skip)
+		dyn_tick->max_skip = max_skip;
 }
 
 void setup_dyn_tick_use_apic(unsigned int calibration_result)
@@ -115,30 +85,47 @@ void setup_dyn_tick_use_apic(unsigned in
 		printk(KERN_INFO "dyn-tick: Cannot use local APIC\n");
 }
 
-void wakeup_pit_or_apic(int cpu, struct pt_regs *regs)
+void dyn_tick_interrupt(int irq, struct pt_regs *regs)
 {
-	unsigned long seq; 
+	int all_were_sleeping = 0;
+	int cpu = smp_processor_id();
 
-	do {
-		seq = read_seqbegin(&xtime_lock);
-		if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING)) {
-			if (dyn_tick->skip_cpu == cpu &&
-				dyn_tick->skip > DYN_TICK_MIN_SKIP)
-					dyn_tick->interrupt(99, NULL, regs);
-				else
-					reprogram_apic_timer(1);
-		}
-	} while (read_seqretry(&xtime_lock, seq));
-}
+	if (!cpu_isset(cpu, nohz_cpu_mask))
+		return;
 
-void dyn_tick_interrupt(int irq, struct pt_regs *regs)
-{
-	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING) && irq)
-		dyn_tick->interrupt(irq, NULL, regs);
+	spin_lock(&dyn_tick_lock);
+
+	if (cpus_equal(nohz_cpu_mask, cpu_online_map))
+		all_were_sleeping = 1;
+	cpu_clear(cpu, nohz_cpu_mask);
+
+	if (all_were_sleeping) {
+		/* Recover jiffies */
+		cur_timer->mark_offset();
+		if (cpu_has_local_apic())
+			if (dyn_tick->state & DYN_TICK_TIMER_INT)
+				enable_pit_timer();
+	}
+
+	spin_unlock(&dyn_tick_lock);
+
+	if (cpu_has_local_apic()) {
+		/* Fixme: Needs to be more accurate */
+		reprogram_apic_timer(1);
+	} else {
+		reprogram_pit_timer(1);
+	}
+
+	conditional_run_local_timers();
+
+	/* Fixme: Enable NMI watchdog */
 }
 
+
 void dyn_tick_time_init(struct timer_opts *cur_timer)
 {
+	spin_lock_init(&dyn_tick_lock);
+
 	if (strncmp(cur_timer->name, "tsc", 3) == 0 ||
 	    strncmp(cur_timer->name, "pmtmr", 3) == 0) {
 		dyn_tick->state |= DYN_TICK_SUITABLE;
diff -puN arch/i386/kernel/process.c~dynamic-tick-smp arch/i386/kernel/process.c
--- linux-2.6.13-rc6-work/arch/i386/kernel/process.c~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/arch/i386/kernel/process.c	2005-08-13 00:17:53.000000000 +0530
@@ -104,9 +104,10 @@ void default_idle(void)
 {
 	if (!hlt_counter && boot_cpu_data.hlt_works_ok) {
 		local_irq_disable();
-		if (!need_resched())
+		if (!need_resched()) {
+			dyn_tick_reprogram_timer();
 			safe_halt();
-		else
+		} else
 			local_irq_enable();
 	} else {
 		cpu_relax();
@@ -201,8 +202,6 @@ void cpu_idle(void)
 			if (cpu_is_offline(cpu))
 				play_dead();
 
-			dyn_tick_reprogram_timer();
-
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
diff -puN arch/i386/kernel/smp.c~dynamic-tick-smp arch/i386/kernel/smp.c
--- linux-2.6.13-rc6-work/arch/i386/kernel/smp.c~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/arch/i386/kernel/smp.c	2005-08-12 18:24:20.000000000 +0530
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
@@ -314,6 +315,8 @@ fastcall void smp_invalidate_interrupt(s
 {
 	unsigned long cpu;
 
+	dyn_tick_interrupt(INVALIDATE_TLB_VECTOR, regs);
+
 	cpu = get_cpu();
 
 	if (!cpu_isset(cpu, flush_cpumask))
@@ -601,6 +604,8 @@ void smp_send_stop(void)
 fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(RESCHEDULE_VECTOR, regs);
 }
 
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)
@@ -610,6 +615,9 @@ fastcall void smp_call_function_interrup
 	int wait = call_data->wait;
 
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(CALL_FUNCTION_VECTOR, regs);
+
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
diff -puN arch/i386/kernel/time.c~dynamic-tick-smp arch/i386/kernel/time.c
--- linux-2.6.13-rc6-work/arch/i386/kernel/time.c~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/arch/i386/kernel/time.c	2005-08-12 17:55:30.000000000 +0530
@@ -253,7 +253,8 @@ EXPORT_SYMBOL(profile_pc);
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static inline void do_timer_interrupt(int irq, void *dev_id,
+				       struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
diff -puN arch/i386/kernel/timers/timer_pit.c~dynamic-tick-smp arch/i386/kernel/timers/timer_pit.c
--- linux-2.6.13-rc6-work/arch/i386/kernel/timers/timer_pit.c~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/arch/i386/kernel/timers/timer_pit.c	2005-08-12 17:57:36.000000000 +0530
@@ -148,20 +148,14 @@ static unsigned long get_offset_pit(void
 	return count;
 }
 
-/*
- * REVISIT: Looks like on P3 APIC timer keeps running if PIT mode
- *	    is changed. On P4, changing PIT mode seems to kill
- *	    APIC timer interrupts. Same thing with disabling PIT
- *	    interrupt.
- */
 void disable_pit_timer(void)
 {
-	extern spinlock_t i8253_lock;
-	unsigned long flags;
+	irq_desc[0].handler->disable(0);
+}
 
-	spin_lock_irqsave(&i8253_lock, flags);
-	outb_p(0x32, PIT_MODE);		/* binary, mode 1, LSB/MSB, ch 0 */
-	spin_unlock_irqrestore(&i8253_lock, flags);
+void enable_pit_timer(void)
+{
+	irq_desc[0].handler->enable(0);
 }
 
 /*
diff -puN arch/i386/kernel/timers/timer_tsc.c~dynamic-tick-smp arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.13-rc6-work/arch/i386/kernel/timers/timer_tsc.c~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/arch/i386/kernel/timers/timer_tsc.c	2005-08-13 01:01:41.000000000 +0530
@@ -375,12 +375,6 @@ static void mark_offset_tsc(void)
 
 	rdtsc(last_tsc_low, last_tsc_high);
 
-	if (dyn_tick_enabled()) {
-		update_monotonic_base(last_offset);
-		write_sequnlock(&monotonic_lock);
-		return;
-	}
-
 	spin_lock(&i8253_lock);
 	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
 
@@ -431,6 +425,7 @@ static void mark_offset_tsc(void)
 	if (lost >= 2) {
 		jiffies_64 += lost-1;
 
+#ifndef CONFIG_NO_IDLE_HZ
 		/* sanity check to ensure we're not always losing ticks */
 		if (lost_count++ > 100) {
 			printk(KERN_WARNING "Losing too many ticks!\n");
@@ -446,6 +441,7 @@ static void mark_offset_tsc(void)
 		/* ... but give the TSC a fair chance */
 		if (lost_count > 25)
 			cpufreq_delayed_get();
+#endif
 	} else
 		lost_count = 0;
 
@@ -550,6 +546,8 @@ static int __init init_tsc(char* overrid
 					cpu_khz / 1000, cpu_khz % 1000);
 			}
 			set_cyc2ns_scale(cpu_khz/1000);
+			/* Fixme: Make use of 64-bit TSC to recover jiffies */
+			set_dyn_tick_max_skip( (0xFFFFFFFF / (cpu_khz * 1000)) * HZ);
 			return 0;
 		}
 	}
diff -puN arch/i386/kernel/io_apic.c~dynamic-tick-smp arch/i386/kernel/io_apic.c
--- linux-2.6.13-rc6-work/arch/i386/kernel/io_apic.c~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/arch/i386/kernel/io_apic.c	2005-08-12 21:43:36.000000000 +0530
@@ -1157,6 +1157,7 @@ next:
 
 static struct hw_interrupt_type ioapic_level_type;
 static struct hw_interrupt_type ioapic_edge_type;
+static struct hw_interrupt_type ioapic_edge_type_irq0;
 
 #define IOAPIC_AUTO	-1
 #define IOAPIC_EDGE	0
@@ -1168,15 +1169,19 @@ static inline void ioapic_register_intr(
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 				trigger == IOAPIC_LEVEL)
 			irq_desc[vector].handler = &ioapic_level_type;
-		else
+		else if (vector)
 			irq_desc[vector].handler = &ioapic_edge_type;
+		else
+			irq_desc[vector].handler = &ioapic_edge_type_irq0;
 		set_intr_gate(vector, interrupt[vector]);
 	} else	{
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 				trigger == IOAPIC_LEVEL)
 			irq_desc[irq].handler = &ioapic_level_type;
-		else
+		else if (irq)
 			irq_desc[irq].handler = &ioapic_edge_type;
+		else
+			irq_desc[irq].handler = &ioapic_edge_type_irq0;
 		set_intr_gate(vector, interrupt[irq]);
 	}
 }
@@ -1288,7 +1293,7 @@ static void __init setup_ExtINT_IRQ0_pin
 	 * The timer IRQ doesn't have to know that behind the
 	 * scene we have a 8259A-master in AEOI mode ...
 	 */
-	irq_desc[0].handler = &ioapic_edge_type;
+	irq_desc[0].handler = &ioapic_edge_type_irq0;
 
 	/*
 	 * Add it to the IO-APIC irq-routing table:
@@ -2014,6 +2019,18 @@ static struct hw_interrupt_type ioapic_l
 	.set_affinity 	= set_ioapic_affinity,
 };
 
+/* Needed to disable PIT interrupts when all CPUs sleep */
+static struct hw_interrupt_type ioapic_edge_type_irq0 = {
+	.typename 	= "IO-APIC-edge-irq0",
+	.startup 	= startup_edge_ioapic,
+	.shutdown 	= shutdown_edge_ioapic,
+	.enable 	= unmask_IO_APIC_irq,
+	.disable 	= mask_IO_APIC_irq,
+	.ack 		= ack_edge_ioapic,
+	.end 		= end_edge_ioapic,
+	.set_affinity 	= set_ioapic_affinity,
+};
+
 static inline void init_IO_APIC_traps(void)
 {
 	int irq;
diff -puN arch/i386/mach-default/setup.c~dynamic-tick-smp arch/i386/mach-default/setup.c
--- linux-2.6.13-rc6-work/arch/i386/mach-default/setup.c~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/arch/i386/mach-default/setup.c	2005-08-12 18:14:54.000000000 +0530
@@ -93,22 +93,6 @@ void __init time_init_hook(void)
 	setup_irq(0, &irq0);
 }
 
-/**
- * replace_timer_interrupt - allow replacing timer interrupt handler
- *
- * Description:
- *	Can be used to replace timer interrupt handler with a more optimized
- *	handler. Used for enabling and disabling of CONFIG_NO_IDLE_HZ.
- */
-void replace_timer_interrupt(void *new_handler)
-{
-	unsigned long flags;
-
-	write_seqlock_irqsave(&xtime_lock, flags);
-	irq0.handler = new_handler;
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-}
-
 #ifdef CONFIG_MCA
 /**
  * mca_nmi_hook - hook into MCA specific NMI chain
diff -puN include/asm-i386/dyn-tick.h~dynamic-tick-smp include/asm-i386/dyn-tick.h
--- linux-2.6.13-rc6-work/include/asm-i386/dyn-tick.h~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/include/asm-i386/dyn-tick.h	2005-08-12 21:36:50.000000000 +0530
@@ -18,14 +18,12 @@
 #ifdef CONFIG_NO_IDLE_HZ
 extern int dyn_tick_arch_init(void);
 extern void disable_pit_timer(void);
+extern void enable_pit_timer(void);
 extern void reprogram_pit_timer(int jiffies_to_skip);
-extern void replace_timer_interrupt(void *new_handler);
-extern void set_dyn_tick_max_skip(u32 apic_timer_val);
+extern void set_dyn_tick_max_skip(unsigned int max_skip);
 extern void setup_dyn_tick_use_apic(unsigned int calibration_result);
-extern void wakeup_pit_or_apic(int cpu, struct pt_regs *regs);
 extern void dyn_tick_interrupt(int irq, struct pt_regs *regs);
 extern void dyn_tick_time_init(struct timer_opts *cur_timer);
-extern void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 extern u32 apic_timer_val;
 
 #if defined(CONFIG_DYN_TICK_USE_APIC)
@@ -57,6 +55,9 @@ static inline void reprogram_apic_timer(
 #ifdef CONFIG_X86_LOCAL_APIC
 	unsigned long flags;
 
+	/* Fixme: Make count more accurate. Otherwise can lead
+	 * 	  to latencies of upto 1 jiffy in servicing timers.
+	 */
 	count *= apic_timer_val;
 	local_irq_save(flags);
 	apic_write_around(APIC_TMICT, count);
@@ -65,7 +66,7 @@ static inline void reprogram_apic_timer(
 }
 
 #else /* CONFIG_NO_IDLE_HZ */
-static inline void set_dyn_tick_max_skip(u32 apic_timer_val)
+static inline void set_dyn_tick_max_skip(unsigned int max_skip)
 {
 }
 
@@ -77,10 +78,6 @@ static inline void setup_dyn_tick_use_ap
 {
 }
 
-static inline void wakeup_pit_or_apic(int cpu, struct pt_regs *regs)
-{
-}
-
 static inline void dyn_tick_interrupt(int irq, struct pt_regs *regs)
 {
 }
diff -puN include/linux/dyn-tick.h~dynamic-tick-smp include/linux/dyn-tick.h
--- linux-2.6.13-rc6-work/include/linux/dyn-tick.h~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/include/linux/dyn-tick.h	2005-08-12 18:19:24.000000000 +0530
@@ -23,26 +23,23 @@
 #define DYN_TICK_ENABLED	(1 << 1)
 #define DYN_TICK_SUITABLE	(1 << 0)
 
-#define NS_TICK_LEN		((1 * 1000000000) / HZ)
 #define DYN_TICK_MIN_SKIP	2
 
 struct dyn_tick_state {
 	unsigned int state;		/* Current state */
-	int skip_cpu;			/* Skip handling processor */
-	unsigned long skip;		/* Ticks to skip */
 	unsigned int max_skip;		/* Max number of ticks to skip */
-	unsigned long irq_skip_mask;	/* Do not update time from these irqs */
-	irqreturn_t (*interrupt)(int, void *, struct pt_regs *);
 };
 
 struct dyn_tick_timer {
 	int (*arch_init) (void);
 	void (*arch_enable) (void);
 	void (*arch_disable) (void);
-	void (*arch_reprogram_timer) (void);
+	void (*arch_reprogram_timer) (unsigned long);
+	void (*arch_all_cpus_idle) (int);
 };
 
 extern struct dyn_tick_state *dyn_tick;
+extern spinlock_t dyn_tick_lock;
 extern void dyn_tick_register(struct dyn_tick_timer *new_timer);
 
 #ifdef CONFIG_NO_IDLE_HZ
@@ -59,7 +56,7 @@ static inline int arch_has_safe_halt(voi
 	return 0;
 }
 
-static inline void dyn_tick_reprogram_timer(void)
+static inline unsigned long dyn_tick_reprogram_timer(void)
 {
 }
 
diff -puN include/linux/timer.h~dynamic-tick-smp include/linux/timer.h
--- linux-2.6.13-rc6-work/include/linux/timer.h~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/include/linux/timer.h	2005-08-12 21:40:14.000000000 +0530
@@ -87,6 +87,7 @@ static inline void add_timer(struct time
 
 extern void init_timers(void);
 extern void run_local_timers(void);
+extern void conditional_run_local_timers(void);
 extern void it_real_fn(unsigned long);
 
 #endif
diff -puN kernel/dyn-tick.c~dynamic-tick-smp kernel/dyn-tick.c
--- linux-2.6.13-rc6-work/kernel/dyn-tick.c~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/kernel/dyn-tick.c	2005-08-13 00:35:31.000000000 +0530
@@ -22,6 +22,7 @@
 #include <linux/cpumask.h>
 #include <linux/pm.h>
 #include <linux/dyn-tick.h>
+#include <linux/rcupdate.h>
 #include <asm/io.h>
 
 #include "io_ports.h"
@@ -32,56 +33,50 @@
 static struct dyn_tick_state dyn_tick_state;
 struct dyn_tick_state *dyn_tick = &dyn_tick_state;
 static struct dyn_tick_timer *dyn_tick_cfg;
-static cpumask_t dyn_cpu_map;
+spinlock_t dyn_tick_lock;
 
 /*
  * Arch independent code needed to reprogram next timer interrupt.
- * Gets called from cpu_idle() before entering idle loop. Note that
- * we want to have all processors idle before reprogramming the
- * next timer interrupt.
+ * Gets called with IRQs disabled from cpu_idle() before entering idle loop.
  */
 unsigned long dyn_tick_reprogram_timer(void)
 {
-	int cpu;
-	unsigned long flags;
-	cpumask_t idle_cpus;
-	unsigned long next;
+	int cpu = smp_processor_id();
+	unsigned long delta;
 
 	if (!DYN_TICK_IS_SET(DYN_TICK_ENABLED))
 		return 0;
 
-	/* Check if we are already skipping ticks and can idle other cpus */
-	if (DYN_TICK_IS_SET(DYN_TICK_SKIPPING)) {
-		if (cpu_has_local_apic())
-			reprogram_apic_timer(dyn_tick->skip);
+	if (rcu_pending(cpu) || local_softirq_pending())
 		return 0;
-	}
 
 	/* Check if we can start skipping ticks */
-	write_seqlock_irqsave(&xtime_lock, flags);
-	cpu = smp_processor_id();
-	cpu_set(cpu, dyn_cpu_map);
-	cpus_and(idle_cpus, dyn_cpu_map, cpu_online_map);
-	if (cpus_equal(idle_cpus, cpu_online_map)) {
-		next = next_timer_interrupt();
-		if (jiffies > next)
-			dyn_tick->skip = 1;
-		else
-			dyn_tick->skip = next_timer_interrupt() - jiffies;
-		if (dyn_tick->skip > DYN_TICK_MIN_SKIP) {
-			if (dyn_tick->skip > dyn_tick->max_skip)
-				dyn_tick->skip = dyn_tick->max_skip;
-
-			dyn_tick_cfg->arch_reprogram_timer();
-
-			dyn_tick->skip_cpu = cpu;
-			dyn_tick->state |= DYN_TICK_SKIPPING;
-		}
-		cpus_clear(dyn_cpu_map);
-	}
-	write_sequnlock_irqrestore(&xtime_lock, flags);
+	write_seqlock(&xtime_lock);
+
+	delta = next_timer_interrupt() - jiffies;
+	if (delta > dyn_tick->max_skip)
+		delta = dyn_tick->max_skip;
+
+	if (delta > DYN_TICK_MIN_SKIP) {
+		int idle_time = 0;
+
+		spin_lock(&dyn_tick_lock);
+
+		dyn_tick_cfg->arch_reprogram_timer(jiffies + delta);
+
+		cpu_set(cpu, nohz_cpu_mask);
+		if (cpus_equal(nohz_cpu_mask, cpu_online_map))
+			/* Fixme: idle_time needs to be computed */
+			dyn_tick_cfg->arch_all_cpus_idle(idle_time);
+
+		spin_unlock(&dyn_tick_lock);
+
+	} else
+		delta = 0;
+
+	write_sequnlock(&xtime_lock);
 
-	return dyn_tick->skip;
+	return delta;
 }
 
 void __init dyn_tick_register(struct dyn_tick_timer *arch_timer)
diff -puN kernel/timer.c~dynamic-tick-smp kernel/timer.c
--- linux-2.6.13-rc6-work/kernel/timer.c~dynamic-tick-smp	2005-08-12 17:25:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/kernel/timer.c	2005-08-12 21:39:38.000000000 +0530
@@ -924,6 +924,14 @@ void run_local_timers(void)
 	raise_softirq(TIMER_SOFTIRQ);
 }
 
+void conditional_run_local_timers(void)
+{
+	tvec_base_t *base  = &__get_cpu_var(tvec_bases);
+
+	if (base->timer_jiffies != jiffies)
+		run_local_timers();
+}
+
 /*
  * Called by the timer interrupt. xtime_lock must already be taken
  * by the timer IRQ!
diff -puN arch/i386/kernel/timers/timer_pm.c~dynamic-tick-smp arch/i386/kernel/timers/timer_pm.c
--- linux-2.6.13-rc6-work/arch/i386/kernel/timers/timer_pm.c~dynamic-tick-smp	2005-08-12 18:08:19.000000000 +0530
+++ linux-2.6.13-rc6-work-root/arch/i386/kernel/timers/timer_pm.c	2005-08-13 01:04:03.000000000 +0530
@@ -129,6 +129,7 @@ pm_good:
 		return -ENODEV;
 
 	init_cpu_khz();
+	set_dyn_tick_max_skip( (0xFFFFFF / (286 * 1000000)) * 1024 * HZ );
 	return 0;
 }
 
@@ -169,9 +170,6 @@ static void mark_offset_pmtmr(void)
 	monotonic_base += delta * NSEC_PER_USEC;
 	write_sequnlock(&monotonic_lock);
 
-	if (dyn_tick_enabled())
-		return;
-
 	/* convert to ticks */
 	delta += offset_delay;
 	lost = delta / (USEC_PER_SEC / HZ);
_





-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
