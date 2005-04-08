Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVDHH5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVDHH5o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVDHH5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:57:44 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:38280 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262737AbVDHHvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:51:03 -0400
Date: Fri, 8 Apr 2005 00:50:03 -0700
From: Tony Lindgren <tony@atomide.com>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1
Message-ID: <20050408075001.GC4477@atomide.com>
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20050408062537.GB4477@atomide.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [050407 23:28]:
> 
> I think I have an idea on what's going on; Your system does not wake to
> APIC interrupt, and the system timer updates time only on other interrupts.
> I'm experiencing the same on a loaner ThinkPad T30.
> 
> I'll try to do another patch today. Meanwhile it now should work
> without lapic in cmdline.

Following is an updated patch. Anybody having trouble, please try
disabling CONFIG_DYN_TICK_USE_APIC Kconfig option.

I'm hoping this might work on Pavel's machine too?

Tony

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-dynamic-tick-2.6.12-rc2-050408-1"

diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2005-04-08 00:43:41 -07:00
+++ b/arch/i386/Kconfig	2005-04-08 00:43:41 -07:00
@@ -460,6 +460,26 @@
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
+config DYN_TICK_USE_APIC
+	bool "Use APIC timer instead of PIT timer"
+	help
+	  This option enables using APIC timer interrupt if your hardware
+	  supports it. APIC timer allows longer sleep periods compared
+	  to PIT timer. Note that on some hardware disabling PIT timer
+	  also disables APIC timer interrupts, and system won't run
+	  properly. Symptoms include slow system boot, and time running
+	  slow. If unsure, don't enable this option.
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	2005-04-08 00:43:41 -07:00
+++ b/arch/i386/kernel/Makefile	2005-04-08 00:43:41 -07:00
@@ -30,6 +30,7 @@
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
+obj-$(CONFIG_NO_IDLE_HZ) 	+= dyn-tick.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
diff -Nru a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	2005-04-08 00:43:41 -07:00
+++ b/arch/i386/kernel/apic.c	2005-04-08 00:43:41 -07:00
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
 static void __setup_APIC_LVTT(unsigned int clocks)
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
 
 static void __init setup_APIC_timer(unsigned int clocks)
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
diff -Nru a/arch/i386/kernel/dyn-tick.c b/arch/i386/kernel/dyn-tick.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/i386/kernel/dyn-tick.c	2005-04-08 00:43:41 -07:00
@@ -0,0 +1,64 @@
+/*
+ * linux/arch/i386/kernel/dyn-tick.c
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
+#include <linux/version.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/dyn-tick-timer.h>
+#include "dyn-tick.h"
+
+extern int dyn_tick_arch_init(void);
+
+void arch_reprogram_timer(void)
+{
+	if (cpu_has_local_apic()) {
+		disable_pit_tick();
+		if (dyn_tick->state & DYN_TICK_TIMER_INT)
+			reprogram_apic_timer(dyn_tick->skip);
+	} else {
+		if (dyn_tick->state & DYN_TICK_TIMER_INT)
+			reprogram_pit_tick(dyn_tick->skip);
+		else
+			disable_pit_tick();
+	}
+}
+
+static struct dyn_tick_timer arch_dyn_tick_timer = {
+	.arch_reprogram_timer	= &arch_reprogram_timer,
+};
+
+int __init dyn_tick_init(void)
+{
+	arch_dyn_tick_timer.arch_init = dyn_tick_arch_init;
+	dyn_tick_register(&arch_dyn_tick_timer);
+
+	return 0;
+}
+arch_initcall(dyn_tick_init);
diff -Nru a/arch/i386/kernel/dyn-tick.h b/arch/i386/kernel/dyn-tick.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/i386/kernel/dyn-tick.h	2005-04-08 00:43:41 -07:00
@@ -0,0 +1,33 @@
+/*
+ * linux/arch/i386/kernel/dyn-tick.h
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
+#if defined(CONFIG_DYN_TICK_USE_APIC) && (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC))
+#define cpu_has_local_apic()	(dyn_tick->state & DYN_TICK_USE_APIC)
+#else
+#define cpu_has_local_apic()	0
+#endif
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	2005-04-08 00:43:41 -07:00
+++ b/arch/i386/kernel/irq.c	2005-04-08 00:43:41 -07:00
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/dyn-tick-timer.h>
 
 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_maxaligned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
@@ -102,6 +103,12 @@
 		);
 	} else
 #endif
+
+#ifdef CONFIG_NO_IDLE_HZ
+	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING) && irq != 0)
+		dyn_tick->interrupt(irq, NULL, regs);
+#endif
+
 		__do_IRQ(irq, regs);
 
 	irq_exit();
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	2005-04-08 00:43:41 -07:00
+++ b/arch/i386/kernel/process.c	2005-04-08 00:43:41 -07:00
@@ -160,6 +160,10 @@
 			if (!idle)
 				idle = default_idle;
 
+#ifdef CONFIG_NO_IDLE_HZ
+			dyn_tick_reprogram_timer();
+#endif
+
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	2005-04-08 00:43:41 -07:00
+++ b/arch/i386/kernel/time.c	2005-04-08 00:43:41 -07:00
@@ -46,6 +46,7 @@
 #include <linux/bcd.h>
 #include <linux/efi.h>
 #include <linux/mca.h>
+#include <linux/dyn-tick-timer.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -67,6 +68,7 @@
 #include <asm/arch_hooks.h>
 
 #include "io_ports.h"
+#include "dyn-tick.h"
 
 extern spinlock_t i8259A_lock;
 int pit_latch_buggy;              /* extern */
@@ -308,6 +310,66 @@
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
+
+	if (dyn_tick->state & DYN_TICK_DEBUG) {
+		if (irq == 0)
+			printk(".");
+		else
+			printk("%i ", irq);
+	}
+
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
+#endif	/* CONFIG_NO_IDLE_HZ */
+
 /* not static: needed by APM */
 unsigned long get_cmos_time(void)
 {
@@ -416,7 +478,7 @@
 
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */
-static struct sys_device device_timer = {
+struct sys_device device_timer = {
 	.id	= 0,
 	.cls	= &timer_sysclass,
 };
@@ -452,6 +514,82 @@
 }
 #endif
 
+#ifdef CONFIG_NO_IDLE_HZ
+
+/*
+ * REVISIT: Looks like on p3 APIC timer keeps running if PIT mode
+ *	    is changed. On p4, changing PIT mode seems to kill
+ *	    APIC timer interrupts. Same thing with disabling PIT
+ *	    interrupt.
+ */
+void disable_pit_tick(void)
+{
+	extern spinlock_t i8253_lock;
+	unsigned long flags;
+	spin_lock_irqsave(&i8253_lock, flags);
+	//irq_desc[0].handler->disable(0);
+	outb_p(0x32, PIT_MODE);		/* binary, mode 1, LSB/MSB, ch 0 */
+#if 0
+	outb_p(0xff, PIT_CH0);		/* LSB */
+	outb(0xff, PIT_CH0);		/* MSB */
+#endif
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
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
+	if (skip > 0xffff)
+		skip = 0xffff;
+
+	spin_lock_irqsave(&i8253_lock, flags);
+	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
+	outb_p(skip & 0xff, PIT_CH0);	/* LSB */
+	outb(skip >> 8, PIT_CH0);	/* MSB */
+	//irq_desc[0].handler->enable(0);
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
+
+int __init dyn_tick_arch_init(void)
+{
+	unsigned long flags;
+
+	if (!cur_timer->get_hw_time) {
+		printk(KERN_ERR "dyn-tick: Timer does not have get_hw_time!\n");
+		return -ENODEV;
+	}
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
+#endif	/* CONFIG_NO_IDLE_HZ */
+
 void __init time_init(void)
 {
 #ifdef CONFIG_HPET_TIMER
@@ -471,6 +609,17 @@
 
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
+
+#ifdef CONFIG_NO_IDLE_HZ
+	if (strncmp(cur_timer->name, "tsc", 3) == 0 ||
+	    strncmp(cur_timer->name, "pmtmr", 3) == 0) {
+		dyn_tick->state |= DYN_TICK_SUITABLE;
+		printk(KERN_INFO "dyn-tick: Found suitable timer: %s\n",
+		       cur_timer->name);
+	} else
+		printk(KERN_ERR "dyn-tick: Cannot use timer %s\n",
+		       cur_timer->name);
+#endif
 
 	time_init_hook();
 }
diff -Nru a/arch/i386/kernel/timers/timer_pm.c b/arch/i386/kernel/timers/timer_pm.c
--- a/arch/i386/kernel/timers/timer_pm.c	2005-04-08 00:43:41 -07:00
+++ b/arch/i386/kernel/timers/timer_pm.c	2005-04-08 00:43:41 -07:00
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
--- a/arch/i386/kernel/timers/timer_tsc.c	2005-04-08 00:43:41 -07:00
+++ b/arch/i386/kernel/timers/timer_tsc.c	2005-04-08 00:43:41 -07:00
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
--- a/arch/i386/mach-default/setup.c	2005-04-08 00:43:41 -07:00
+++ b/arch/i386/mach-default/setup.c	2005-04-08 00:43:41 -07:00
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
--- a/include/asm-i386/timer.h	2005-04-08 00:43:41 -07:00
+++ b/include/asm-i386/timer.h	2005-04-08 00:43:41 -07:00
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
+++ b/include/linux/dyn-tick-timer.h	2005-04-08 00:43:41 -07:00
@@ -0,0 +1,74 @@
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
+#ifndef _DYN_TICK_TIMER_H
+#define _DYN_TICK_TIMER_H
+
+#include <linux/interrupt.h>
+
+#define DYN_TICK_DEBUG		(1 << 31)
+#define DYN_TICK_TIMER_INT	(1 << 4)
+#define DYN_TICK_USE_APIC	(1 << 3)
+#define DYN_TICK_SKIPPING	(1 << 2)
+#define DYN_TICK_ENABLED	(1 << 1)
+#define DYN_TICK_SUITABLE	(1 << 0)
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
+struct dyn_tick_timer {
+	int (*arch_init) (void);
+	void (*arch_enable) (void);
+	void (*arch_disable) (void);
+	void (*arch_reprogram_timer) (void);
+};
+
+extern struct dyn_tick_state * dyn_tick;
+extern void dyn_tick_register(struct dyn_tick_timer * new_timer);
+
+#define NS_TICK_LEN		((1 * 1000000000)/HZ)
+#define DYN_TICK_MIN_SKIP	2
+
+#ifdef CONFIG_NO_IDLE_HZ
+
+extern unsigned long dyn_tick_reprogram_timer(void);
+
+#else
+
+#define arch_has_safe_halt()		0
+#define dyn_tick_reprogram_timer()	{}
+
+
+#endif	/* CONFIG_NO_IDLE_HZ */
+#endif	/* _DYN_TICK_TIMER_H */
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2005-04-08 00:43:41 -07:00
+++ b/kernel/Makefile	2005-04-08 00:43:41 -07:00
@@ -28,6 +28,7 @@
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
+obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick-timer.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -Nru a/kernel/dyn-tick-timer.c b/kernel/dyn-tick-timer.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/kernel/dyn-tick-timer.c	2005-04-08 00:43:41 -07:00
@@ -0,0 +1,256 @@
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
+ */
+
+#include <linux/version.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/sysdev.h>
+#include <linux/interrupt.h>
+#include <linux/cpumask.h>
+#include <linux/pm.h>
+#include <linux/dyn-tick-timer.h>
+#include <asm/io.h>
+
+#include "io_ports.h"
+
+#define DYN_TICK_VERSION	"050301-1"
+
+struct dyn_tick_state dyn_tick_state;
+struct dyn_tick_state * dyn_tick = &dyn_tick_state;
+struct dyn_tick_timer * dyn_tick_cfg;
+
+static void (*orig_idle) (void) = 0;
+extern void disable_pit_tick(void);
+extern void reprogram_pit_tick(int jiffies_to_skip);
+extern void reprogram_apic_timer(unsigned int count);
+extern void reprogram_pit_tick(int jiffies_to_skip);
+static cpumask_t dyn_cpu_map;
+
+/*
+ * Arch independed code needed to reprogram next timer interrupt.
+ * Gets called from cpu_idle() before entering idle loop. Note that
+ * we want to have all processors idle before reprogramming the
+ * next timer interrupt.
+ */
+unsigned long dyn_tick_reprogram_timer(void)
+{
+	int cpu;
+	unsigned long flags;
+	cpumask_t idle_cpus;
+	unsigned long next;
+
+	if (dyn_tick->state & DYN_TICK_DEBUG)
+		printk("i");
+	
+	if (!(dyn_tick->state & DYN_TICK_ENABLED))
+		return 0;
+
+	/* Check if we are already skipping ticks and can idle other cpus */
+	if (dyn_tick->state & DYN_TICK_SKIPPING) {
+		reprogram_apic_timer(dyn_tick->skip);
+		return 0;
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
+
+			dyn_tick_cfg->arch_reprogram_timer();
+
+			dyn_tick->skip_cpu = cpu;
+			dyn_tick->state |= DYN_TICK_SKIPPING;
+		}
+		cpus_clear(dyn_cpu_map);
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return dyn_tick->skip;
+}
+
+void __init dyn_tick_register(struct dyn_tick_timer * arch_timer)
+{
+	dyn_tick_cfg = arch_timer;
+	printk(KERN_INFO "dyn-tick: Registering dynamic tick timer v%s\n",
+	       DYN_TICK_VERSION);
+}
+
+/*
+ * ---------------------------------------------------------------------------
+ * Sysfs interface
+ * ---------------------------------------------------------------------------
+ */
+
+extern struct sys_device device_timer;
+
+static ssize_t show_dyn_tick_state(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "suitable:\t%i\n"
+		       "enabled:\t%i\n"
+		       "skipping:\t%i\n"
+		       "using APIC:\t%i\n"
+		       "int enabled:\t%i\n"
+		       "debug:\t\t%i\n",
+		       dyn_tick->state & DYN_TICK_SUITABLE,
+		       (dyn_tick->state & DYN_TICK_ENABLED) >> 1,
+		       (dyn_tick->state & DYN_TICK_SKIPPING) >> 2,
+		       (dyn_tick->state & DYN_TICK_USE_APIC) >> 3,
+		       (dyn_tick->state & DYN_TICK_TIMER_INT) >> 4,
+		       (dyn_tick->state & DYN_TICK_DEBUG) >> 31);
+}
+
+static ssize_t set_dyn_tick_state(struct sys_device *dev, const char * buf,
+				ssize_t count)
+{
+	unsigned long flags;
+	unsigned int enable = simple_strtoul(buf, NULL, 2);
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	if (enable) {
+		if (dyn_tick_cfg->arch_enable)
+			dyn_tick_cfg->arch_enable();
+		dyn_tick->state |= DYN_TICK_ENABLED;
+	} else {
+		if (dyn_tick_cfg->arch_disable)
+			dyn_tick_cfg->arch_disable();
+		dyn_tick->state &= ~DYN_TICK_ENABLED;
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return count;
+}
+
+static SYSDEV_ATTR(dyn_tick_state, 0644, show_dyn_tick_state,
+		   set_dyn_tick_state);
+
+static ssize_t show_dyn_tick_int(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "%i\n",
+		       (dyn_tick->state & DYN_TICK_TIMER_INT) >> 4);
+}
+
+static ssize_t set_dyn_tick_int(struct sys_device *dev, const char * buf,
+				ssize_t count)
+{
+	unsigned long flags;
+	unsigned int enable = simple_strtoul(buf, NULL, 2);
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	if (enable)
+		dyn_tick->state |= DYN_TICK_TIMER_INT;
+	else
+		dyn_tick->state &= ~DYN_TICK_TIMER_INT;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return count;
+}
+
+static SYSDEV_ATTR(dyn_tick_int, 0644, show_dyn_tick_int, set_dyn_tick_int);
+
+static ssize_t show_dyn_tick_dbg(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "%i\n",
+		       (dyn_tick->state & DYN_TICK_DEBUG) >> 31);
+}
+
+static ssize_t set_dyn_tick_dbg(struct sys_device *dev, const char * buf,
+				ssize_t count)
+{
+	unsigned long flags;
+	unsigned int enable = simple_strtoul(buf, NULL, 2);
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	if (enable)
+		dyn_tick->state |= DYN_TICK_DEBUG;
+	else
+		dyn_tick->state &= ~DYN_TICK_DEBUG;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return count;
+}
+
+static SYSDEV_ATTR(dyn_tick_dbg, 0644, show_dyn_tick_dbg, set_dyn_tick_dbg);
+
+/*
+ * ---------------------------------------------------------------------------
+ * Init functions
+ * ---------------------------------------------------------------------------
+ */
+
+static int __init dyn_tick_early_init(void)
+{
+	dyn_tick->state |= DYN_TICK_TIMER_INT;
+}
+
+subsys_initcall(dyn_tick_early_init);
+
+/*
+ * We need to initialize dynamic tick after calibrate delay
+ */
+static int __init dyn_tick_late_init(void)
+{
+	int ret = 0;
+
+	if (dyn_tick_cfg == NULL || dyn_tick_cfg->arch_init == NULL ||
+	    !(dyn_tick->state & DYN_TICK_SUITABLE)) {
+		printk(KERN_ERR, "dyn-tick: No suitable timer found\n");
+		return -ENODEV;
+	}
+
+	ret = dyn_tick_cfg->arch_init();
+	if (ret != 0) {
+		printk(KERN_ERR "dyn-tick: Init failed\n");
+		return -ENODEV;
+	}
+
+	ret = sysdev_create_file(&device_timer, &attr_dyn_tick_state);
+	ret = sysdev_create_file(&device_timer, &attr_dyn_tick_int);
+	ret = sysdev_create_file(&device_timer, &attr_dyn_tick_dbg);
+
+	printk(KERN_INFO "dyn-tick: Timer using dynamic tick\n");
+
+	return ret;
+}
+
+late_initcall(dyn_tick_late_init);

--9jxsPFA5p3P2qPhR--
