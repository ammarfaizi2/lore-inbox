Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVBFD6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVBFD6i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 22:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272756AbVBFD63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 22:58:29 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:11403 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S271409AbVBFDzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 22:55:21 -0500
Date: Sat, 5 Feb 2005 19:54:18 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050206035417.GB15853@atomide.com>
References: <20050201204008.GD14274@atomide.com> <20050201212542.GA3691@openzaurus.ucw.cz> <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz> <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com> <20050205230017.GA1070@elf.ucw.cz> <20050206023344.GA15853@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20050206023344.GA15853@atomide.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [050205 18:39]:
> * Pavel Machek <pavel@ucw.cz> [050205 15:08]:
> > 
> > Ok, works slightly better: time no longer runs 2x too fast. When TSC
> > is used, I get same behaviour  as before ("sleepy machine"). With
> > "notsc", machine seems to work okay, but I still get 1000 timer
> > interrupts a second.

...

> 
> Sounds like your system is not running with the dyn-tick... I'll try
> to fix that TSC bug.

The following patch fixes TSC timer with dyn-tick, and local APIC
timer on UP system with CONFIG_SMP.

Tony

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-2.6.11-rc3-dyn-tick-050205-1"

diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2005-02-05 19:46:47 -08:00
+++ b/arch/i386/Kconfig	2005-02-05 19:46:47 -08:00
@@ -452,6 +452,16 @@
 	bool "Provide RTC interrupt"
 	depends on HPET_TIMER && RTC=y
 
+config NO_IDLE_HZ
+	bool "Dynamic Tick Timer - Skip timer ticks during idle"
+	help
+	  This option enables support for skipping timer ticks when the
+	  processor is idle. During system load, timer is continuous.
+	  This option saves power, as it allows the system to stay in
+	  idle mode longer. Currently supported timers are ACPI PM
+	  timer, local APIC timer, and TSC timer. HPET timer is currently
+	  not supported.
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
diff -Nru a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	2005-02-05 19:46:47 -08:00
+++ b/arch/i386/kernel/apic.c	2005-02-05 19:46:47 -08:00
@@ -26,6 +26,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
+#include <linux/dyn-tick-timer.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -909,6 +910,8 @@
 
 #define APIC_DIVISOR 16
 
+static u32 apic_timer_val;
+
 void __setup_APIC_LVTT(unsigned int clocks)
 {
 	unsigned int lvtt_value, tmp_value, ver;
@@ -927,7 +930,15 @@
 				& ~(APIC_TDR_DIV_1 | APIC_TDR_DIV_TMBASE))
 				| APIC_TDR_DIV_16);
 
-	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
+	apic_timer_val = clocks/APIC_DIVISOR;
+
+#ifdef CONFIG_NO_IDLE_HZ
+	/* Local APIC timer is 24-bit */
+	if (apic_timer_val)
+		dyn_tick->max_skip = 0xffffff / apic_timer_val;
+#endif
+
+	apic_write_around(APIC_TMICT, apic_timer_val);
 }
 
 static void setup_APIC_timer(unsigned int clocks)
@@ -1040,6 +1051,13 @@
 	 */
 	setup_APIC_timer(calibration_result);
 
+#ifdef CONFIG_NO_IDLE_HZ
+	if (calibration_result)
+		dyn_tick->state |= DYN_TICK_USE_APIC;
+	else
+		printk(KERN_INFO "dyn-tick: Cannot use local APIC\n");
+#endif
+
 	local_irq_enable();
 }
 
@@ -1068,6 +1086,18 @@
 	}
 }
 
+#if defined(CONFIG_NO_IDLE_HZ)
+void reprogram_apic_timer(unsigned int count)
+{
+	unsigned long flags;
+
+	count *= apic_timer_val;
+	local_irq_save(flags);
+	apic_write_around(APIC_TMICT, count);
+	local_irq_restore(flags);
+}
+#endif
+
 /*
  * the frequency of the profiling timer can be changed
  * by writing a multiplier value into /proc/profile.
@@ -1160,6 +1190,7 @@
 
 fastcall void smp_apic_timer_interrupt(struct pt_regs *regs)
 {
+	unsigned long seq;
 	int cpu = smp_processor_id();
 
 	/*
@@ -1178,6 +1209,23 @@
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
+
+#ifdef CONFIG_NO_IDLE_HZ
+	/*
+	 * Check if we need to wake up PIT interrupt handler.
+	 * Otherwise just wake up local APIC timer.
+	 */
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING)) {
+			if (dyn_tick->skip_cpu == cpu && dyn_tick->skip > DYN_TICK_MIN_SKIP)
+				dyn_tick->interrupt(99, NULL, regs);
+			else
+				reprogram_apic_timer(1);
+		}
+	} while (read_seqretry(&xtime_lock, seq));
+#endif
+
 	smp_local_timer_interrupt(regs);
 	irq_exit();
 }
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	2005-02-05 19:46:47 -08:00
+++ b/arch/i386/kernel/irq.c	2005-02-05 19:46:47 -08:00
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/dyn-tick-timer.h>
 
 #ifndef CONFIG_X86_LOCAL_APIC
 /*
@@ -100,6 +101,11 @@
 	} else
 #endif
 		__do_IRQ(irq, regs);
+
+#ifdef CONFIG_NO_IDLE_HZ
+	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING) && irq != 0)
+		dyn_tick->interrupt(irq, NULL, regs);
+#endif
 
 	irq_exit();
 
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	2005-02-05 19:46:47 -08:00
+++ b/arch/i386/kernel/time.c	2005-02-05 19:46:47 -08:00
@@ -46,6 +46,7 @@
 #include <linux/bcd.h>
 #include <linux/efi.h>
 #include <linux/mca.h>
+#include <linux/dyn-tick-timer.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -301,6 +302,60 @@
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_NO_IDLE_HZ
+static unsigned long long last_tick;
+void reprogram_pit_tick(int jiffies_to_skip);
+extern void replace_timer_interrupt(void * new_handler);
+
+#if defined(CONFIG_NO_IDLE_HZ) && defined(CONFIG_X86_LOCAL_APIC)
+extern void reprogram_apic_timer(unsigned int count);
+#else
+void reprogram_apic_timer(unsigned int count) {}
+#endif
+
+#ifdef DEBUG
+#define dbg_dyn_tick_irq() {if (skipped && skipped < dyn_tick->skip) \
+				printk("%u/%li ", skipped, dyn_tick->skip);}
+#else
+#define dbg_dyn_tick_irq() {}
+#endif
+
+
+
+/*
+ * This interrupt handler updates the time based on number of jiffies skipped
+ * It would be somewhat more optimized to have a customa handler in each timer
+ * using hardware ticks instead of nanoseconds. Note that CONFIG_NO_IDLE_HZ
+ * currently disables timer fallback on skipped jiffies.
+ */
+irqreturn_t dyn_tick_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long flags;
+	volatile unsigned long long now;
+	unsigned int skipped = 0;
+	write_seqlock_irqsave(&xtime_lock, flags);
+	now = cur_timer->get_hw_time();
+	while (now - last_tick >= NS_TICK_LEN) {
+		last_tick += NS_TICK_LEN;
+		cur_timer->mark_offset();
+		do_timer_interrupt(irq, NULL, regs);
+		skipped++;
+	}
+	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING)) {
+		dbg_dyn_tick_irq();
+		dyn_tick->skip = 1;
+		if (cpu_has_local_apic())
+			reprogram_apic_timer(dyn_tick->skip);
+		reprogram_pit_tick(dyn_tick->skip);
+		dyn_tick->state |= DYN_TICK_ENABLED;
+		dyn_tick->state &= ~DYN_TICK_SKIPPING;
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return IRQ_HANDLED;
+}
+#endif
+
 /* not static: needed by APM */
 unsigned long get_cmos_time(void)
 {
@@ -396,6 +451,72 @@
 }
 #endif
 
+#ifdef CONFIG_NO_IDLE_HZ
+static struct dyn_tick_timer arch_ltt;
+
+#if defined(CONFIG_X86_UP_APIC) || defined(CONFIG_SMP)
+void disable_pit_tick(void)
+{
+	extern spinlock_t i8253_lock;
+	unsigned long flags;
+	spin_lock_irqsave(&i8253_lock, flags);
+	outb_p(0x31, PIT_MODE);		/* binary, mode 1, LSB/MSB, ch 0 */
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
+#endif
+
+/*
+ * Reprograms the next timer interrupt
+ * PIT timer reprogramming code taken from APM code.
+ * Note that PIT timer is a 16-bit timer, which allows max
+ * skip of only few seconds.
+ */
+void reprogram_pit_tick(int jiffies_to_skip)
+{
+	int skip;
+	extern spinlock_t i8253_lock;
+	unsigned long flags;
+
+	skip = jiffies_to_skip * LATCH;
+	if (skip > 0xffff) {
+		skip = 0xffff;
+	}      
+
+	spin_lock_irqsave(&i8253_lock, flags);
+	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
+	outb_p(skip & 0xff, PIT_CH0);	/* LSB */
+	outb(skip >> 8, PIT_CH0);	/* MSB */
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
+
+static int __init dyn_tick_late_init(void)
+{
+	unsigned long flags;
+
+	if (!cur_timer->get_hw_time)
+		return -ENODEV;
+	write_seqlock_irqsave(&xtime_lock, flags);
+	last_tick = cur_timer->get_hw_time();
+	dyn_tick->skip = 1;
+	if (!cpu_has_local_apic())
+		dyn_tick->max_skip = 0xffff/LATCH;	/* PIT timer length */
+	printk(KERN_INFO "dyn-tick: Maximum ticks to skip limited to %i\n",
+	       dyn_tick->max_skip);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	if (cur_timer->late_init)
+		cur_timer->late_init();
+	dyn_tick->interrupt = dyn_tick_timer_interrupt;
+	replace_timer_interrupt(dyn_tick->interrupt);
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	dyn_tick->state |= DYN_TICK_ENABLED;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return 0;
+}
+#endif
+
 void __init time_init(void)
 {
 #ifdef CONFIG_HPET_TIMER
@@ -415,6 +536,16 @@
 
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
+
+#ifdef CONFIG_NO_IDLE_HZ
+	if (strncmp(cur_timer->name, "tsc", 3) == 0 ||
+	    strncmp(cur_timer->name, "pmtmr", 3) == 0) {
+		arch_ltt.init = dyn_tick_late_init;
+		dyn_tick_register(&arch_ltt);
+	} else
+		printk(KERN_INFO "dyn-tick: Cannot use timer %s\n",
+		       cur_timer->name);
+#endif
 
 	time_init_hook();
 }
diff -Nru a/arch/i386/kernel/timers/timer_pm.c b/arch/i386/kernel/timers/timer_pm.c
--- a/arch/i386/kernel/timers/timer_pm.c	2005-02-05 19:46:47 -08:00
+++ b/arch/i386/kernel/timers/timer_pm.c	2005-02-05 19:46:47 -08:00
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/dyn-tick-timer.h>
 #include <asm/types.h>
 #include <asm/timer.h>
 #include <asm/smp.h>
@@ -168,6 +169,7 @@
 	monotonic_base += delta * NSEC_PER_USEC;
 	write_sequnlock(&monotonic_lock);
 
+#ifndef CONFIG_NO_IDLE_HZ
 	/* convert to ticks */
 	delta += offset_delay;
 	lost = delta / (USEC_PER_SEC / HZ);
@@ -184,6 +186,7 @@
 		first_run = 0;
 		offset_delay = 0;
 	}
+#endif
 }
 
 
@@ -238,6 +241,25 @@
 	return (unsigned long) offset_delay + cyc2us(delta);
 }
 
+static unsigned long long ns_time;
+
+static unsigned long long get_hw_time_pmtmr(void)
+{
+	u32 now, delta;
+	static unsigned int last_cycles;
+	now = read_pmtmr();
+	delta = (now - last_cycles) & ACPI_PM_MASK;
+	last_cycles = now;
+	ns_time += cyc2us(delta) * NSEC_PER_USEC;
+	return ns_time;
+}
+
+static void late_init_pmtmr(void)
+{
+	ns_time = monotonic_clock_pmtmr();
+}
+
+extern irqreturn_t pmtmr_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 /* acpi timer_opts struct */
 static struct timer_opts timer_pmtmr = {
@@ -245,7 +267,9 @@
 	.mark_offset		= mark_offset_pmtmr,
 	.get_offset		= get_offset_pmtmr,
 	.monotonic_clock 	= monotonic_clock_pmtmr,
+	.get_hw_time		= get_hw_time_pmtmr,
 	.delay 			= delay_pmtmr,
+	.late_init		= late_init_pmtmr,
 };
 
 struct init_timer_opts __initdata timer_pmtmr_init = {
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	2005-02-05 19:46:47 -08:00
+++ b/arch/i386/kernel/timers/timer_tsc.c	2005-02-05 19:46:47 -08:00
@@ -112,6 +112,15 @@
 	return delay_at_last_interrupt + edx;
 }
 
+static unsigned long get_hw_time_tsc(void)
+{
+	register unsigned long eax, edx;
+
+	unsigned long long hw_time;
+	rdtscll(hw_time);
+	return cycles_2_ns(hw_time);
+}
+
 static unsigned long long monotonic_clock_tsc(void)
 {
 	unsigned long long last_offset, this_offset, base;
@@ -348,6 +357,7 @@
 
 	rdtsc(last_tsc_low, last_tsc_high);
 
+#ifndef CONFIG_NO_IDLE_HZ
 	spin_lock(&i8253_lock);
 	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
 
@@ -415,11 +425,14 @@
 			cpufreq_delayed_get();
 	} else
 		lost_count = 0;
+#endif
+
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
 	write_sequnlock(&monotonic_lock);
 
+#ifndef CONFIG_NO_IDLE_HZ
 	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
@@ -430,6 +443,7 @@
 	 */
 	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
+#endif
 }
 
 static int __init init_tsc(char* override)
@@ -551,6 +565,7 @@
 	.mark_offset = mark_offset_tsc, 
 	.get_offset = get_offset_tsc,
 	.monotonic_clock = monotonic_clock_tsc,
+	.get_hw_time = get_hw_time_tsc,
 	.delay = delay_tsc,
 };
 
diff -Nru a/arch/i386/mach-default/setup.c b/arch/i386/mach-default/setup.c
--- a/arch/i386/mach-default/setup.c	2005-02-05 19:46:47 -08:00
+++ b/arch/i386/mach-default/setup.c	2005-02-05 19:46:47 -08:00
@@ -85,6 +85,22 @@
 	setup_irq(0, &irq0);
 }
 
+/**
+ * replace_timer_interrupt - allow replacing timer interrupt handler
+ *
+ * Description:
+ *	Can be used to replace timer interrupt handler with a more optimized
+ *	handler. Used for enabling and disabling of CONFIG_NO_IDLE_HZ.
+ */
+void replace_timer_interrupt(void * new_handler)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	irq0.handler = new_handler;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+}
+
 #ifdef CONFIG_MCA
 /**
  * mca_nmi_hook - hook into MCA specific NMI chain
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	2005-02-05 19:46:47 -08:00
+++ b/include/asm-i386/timer.h	2005-02-05 19:46:47 -08:00
@@ -1,6 +1,7 @@
 #ifndef _ASMi386_TIMER_H
 #define _ASMi386_TIMER_H
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 /**
  * struct timer_ops - used to define a timer source
@@ -21,7 +22,9 @@
 	void (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
 	unsigned long long (*monotonic_clock)(void);
+	unsigned long long (*get_hw_time)(void);
 	void (*delay)(unsigned long);
+	void (*late_init)(void);
 };
 
 struct init_timer_opts {
diff -Nru a/include/linux/dyn-tick-timer.h b/include/linux/dyn-tick-timer.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/dyn-tick-timer.h	2005-02-05 19:46:47 -08:00
@@ -0,0 +1,71 @@
+/*
+ * linux/include/linux/dyn-tick-timer.h
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/interrupt.h>
+
+#define DYN_TICK_USE_APIC	(1 << 2)
+#define DYN_TICK_SKIPPING	(1 << 1)
+#define DYN_TICK_ENABLED	(1 << 0)
+
+struct dyn_tick_state {
+	unsigned int state;		/* Current state */
+	int skip_cpu;			/* Skip handling processor */
+	unsigned long skip;		/* Ticks to skip */
+	unsigned int max_skip;		/* Max number of ticks to skip */
+	unsigned long irq_skip_mask;	/* Do not update time from these irqs */
+	irqreturn_t (*interrupt)(int, void *, struct pt_regs *);
+};
+
+/* REVISIT: Add functions to enable/disable dyn-tick on the fly */
+struct dyn_tick_timer {
+	int (*init) (void);
+};
+
+extern struct dyn_tick_state * dyn_tick;
+extern void dyn_tick_register(struct dyn_tick_timer * new_timer);
+
+#define NS_TICK_LEN		((1 * 1000000000)/HZ)
+#define DYN_TICK_MIN_SKIP	2
+
+#if defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC)
+#define cpu_has_local_apic()	(dyn_tick->state & DYN_TICK_USE_APIC)
+#else
+#define cpu_has_local_apic()	0
+#endif
+
+#ifdef CONFIG_NO_IDLE_HZ
+
+#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_X86_64)
+#define arch_has_safe_halt()	1
+#endif
+
+#else
+
+#define arch_has_safe_halt()	0
+
+#endif
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2005-02-05 19:46:47 -08:00
+++ b/kernel/Makefile	2005-02-05 19:46:47 -08:00
@@ -26,6 +26,7 @@
 obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
+obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick-timer.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -Nru a/kernel/dyn-tick-timer.c b/kernel/dyn-tick-timer.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/kernel/dyn-tick-timer.c	2005-02-05 19:46:47 -08:00
@@ -0,0 +1,149 @@
+/*
+ * linux/arch/i386/kernel/dyn-tick.c
+ *
+ * Beginnings of generic dynamic tick timer support
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ * TODO:
+ * - Add functions for enabling/disabling dyn-tick on the fly
+ * - Generalize to work with ARM sys_timer
+ */
+
+#include <linux/version.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/cpumask.h>
+#include <linux/pm.h>
+#include <linux/dyn-tick-timer.h>
+#include <asm/io.h>
+
+#include "io_ports.h"
+
+#define VERSION	050205-1
+
+struct dyn_tick_state dyn_tick_state;
+struct dyn_tick_state * dyn_tick = &dyn_tick_state;
+struct dyn_tick_timer dyn_tick_timer;
+struct dyn_tick_timer * dyn_tick_cfg = &dyn_tick_timer;
+static void (*orig_idle) (void) = 0;
+extern void disable_pit_tick(void);
+extern void reprogram_pit_tick(int jiffies_to_skip);
+extern void reprogram_apic_timer(unsigned int count);
+extern void reprogram_pit_tick(int jiffies_to_skip);
+static cpumask_t dyn_cpu_map;
+
+/*
+ * We want to have all processors idle before reprogramming the next
+ * timer interrupt. Note that we must maintain the state for dynamic tick,
+ * otherwise the idle loop could be reprogramming the timer continuously
+ * further into the future, and the timer interrupt would never happen.
+ */
+static void dyn_tick_idle(void)
+{
+	int cpu;
+	unsigned long flags;
+	cpumask_t idle_cpus;
+	unsigned long next;
+
+	if (!(dyn_tick->state & DYN_TICK_ENABLED))
+		goto out;
+
+	/* Check if we are already skipping ticks and can idle other cpus */
+	if (dyn_tick->state & DYN_TICK_SKIPPING) {
+		reprogram_apic_timer(dyn_tick->skip);
+		goto out;
+	}
+
+	/* Check if we can start skipping ticks */
+	write_seqlock_irqsave(&xtime_lock, flags);
+	cpu = smp_processor_id();
+	cpu_set(cpu, dyn_cpu_map);
+	cpus_and(idle_cpus, dyn_cpu_map, cpu_online_map);
+	if (cpus_equal(idle_cpus, cpu_online_map)) {
+		next = next_timer_interrupt();
+		if (jiffies > next) {
+			//printk("Too late? next: %lu jiffies: %lu\n",
+			//       next, jjiffies);
+			dyn_tick->skip = 1;
+		} else
+			dyn_tick->skip = next_timer_interrupt() - jiffies;
+		if (dyn_tick->skip > DYN_TICK_MIN_SKIP) {
+			if (dyn_tick->skip > dyn_tick->max_skip)
+				dyn_tick->skip = dyn_tick->max_skip;
+			if (cpu_has_local_apic()) {
+				disable_pit_tick();
+				reprogram_apic_timer(dyn_tick->skip);
+			} else
+				reprogram_pit_tick(dyn_tick->skip);
+			dyn_tick->skip_cpu = cpu;
+			dyn_tick->state |= DYN_TICK_SKIPPING;
+		}
+		cpus_clear(dyn_cpu_map);
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+out:
+	if (orig_idle)
+		orig_idle();
+	else if (arch_has_safe_halt())
+		safe_halt();
+}
+
+void __init dyn_tick_register(struct dyn_tick_timer * new_timer)
+{
+	dyn_tick_cfg->init = new_timer->init;
+	printk(KERN_INFO "dyn-tick: Registering dynamic tick timer\n");
+}
+
+/*
+ * We need to initialize dynamic tick after calibrate delay
+ */
+static int __init dyn_tick_init(void)
+{
+	int ret = 0;
+
+	if (dyn_tick_cfg->init == NULL)
+		return -ENODEV;
+
+	ret = dyn_tick_cfg->init();
+	if (ret != 0) {
+		printk(KERN_WARNING "dyn-tick: Init failed\n");
+		return -ENODEV;
+	}
+	orig_idle = pm_idle;
+	pm_idle = dyn_tick_idle;
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,10))
+	cpu_idle_wait();
+#endif
+	printk(KERN_INFO "dyn-tick: Timer using dynamic tick\n");
+
+	return ret;
+}
+late_initcall(dyn_tick_init);

--bp/iNruPH9dso1Pn--
