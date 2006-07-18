Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWGRJ0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWGRJ0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWGRJVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:21:01 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:8066 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932112AbWGRJUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:20:25 -0400
Message-Id: <20060718091954.777155000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:25 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       john stultz <johnstul@us.ibm.com>
Subject: [RFC PATCH 25/33] Implement timekeeping for Xen
Content-Disposition: inline; filename=xen-time
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the hypervisor as the basis of the guest's time.  This means that
the hypervisor wallclock time is used to emulate the cmos clock, and
set the inital system clock at boot.

It also registers a Xen clocksource, so the system clock is kept in
sync with the hypervisor's clock.

This does not implement setting the hypervisor clock; nor does it
implement non-independent time, so hypervisor wallclock changes will
not affect the guest.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: john stultz <johnstul@us.ibm.com>

---
 arch/i386/mach-default/Makefile       |    2
 arch/i386/mach-default/setup-time.c   |   16 +
 arch/i386/mach-default/setup.c        |   14 -
 drivers/xen/core/Makefile             |    2
 drivers/xen/core/time.c               |  285 +++++++++++++++++++++++++++++++++
 include/asm-i386/mach-xen/do_timer.h  |    3
 include/asm-i386/mach-xen/mach_time.h |   16 +
 7 files changed, 322 insertions(+), 16 deletions(-)

diff -r 2657dae4b5cd arch/i386/mach-default/Makefile
--- a/arch/i386/mach-default/Makefile	Tue Jul 18 02:26:10 2006 -0400
+++ b/arch/i386/mach-default/Makefile	Tue Jul 18 03:40:46 2006 -0400
@@ -2,4 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-obj-y				:= setup.o setup-memory.o
+obj-y				:= setup.o setup-memory.o setup-time.o
diff -r 2657dae4b5cd arch/i386/mach-default/setup.c
--- a/arch/i386/mach-default/setup.c	Tue Jul 18 02:26:10 2006 -0400
+++ b/arch/i386/mach-default/setup.c	Tue Jul 18 03:40:46 2006 -0400
@@ -77,20 +77,6 @@ void __init trap_init_hook(void)
 {
 }
 
-static struct irqaction irq0  = { timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "timer", NULL, NULL};
-
-/**
- * time_init_hook - do any specific initialisations for the system timer.
- *
- * Description:
- *	Must plug the system timer interrupt source at HZ into the IRQ listed
- *	in irq_vectors.h:TIMER_IRQ
- **/
-void __init time_init_hook(void)
-{
-	setup_irq(0, &irq0);
-}
-
 #ifdef CONFIG_MCA
 /**
  * mca_nmi_hook - hook into MCA specific NMI chain
diff -r 2657dae4b5cd drivers/xen/core/Makefile
--- a/drivers/xen/core/Makefile	Tue Jul 18 02:26:10 2006 -0400
+++ b/drivers/xen/core/Makefile	Tue Jul 18 03:40:46 2006 -0400
@@ -1,3 +1,3 @@
 
-obj-y	:= features.o
+obj-y	:= features.o time.o
 
diff -r 2657dae4b5cd arch/i386/mach-default/setup-time.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/arch/i386/mach-default/setup-time.c	Tue Jul 18 03:40:46 2006 -0400
@@ -0,0 +1,16 @@
+#include <linux/interrupt.h>
+#include <asm/arch_hooks.h>
+
+static struct irqaction irq0  = { timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "timer", NULL, NULL};
+
+/**
+ * time_init_hook - do any specific initialisations for the system timer.
+ *
+ * Description:
+ *	Must plug the system timer interrupt source at HZ into the IRQ listed
+ *	in irq_vectors.h:TIMER_IRQ
+ **/
+void __init time_init_hook(void)
+{
+	setup_irq(0, &irq0);
+}
diff -r 2657dae4b5cd drivers/xen/core/time.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/xen/core/time.c	Tue Jul 18 03:40:46 2006 -0400
@@ -0,0 +1,362 @@
+/* 
+ * Xen-specific time functions
+ */
+
+#include <linux/kernel.h>
+#include <linux/time.h>
+#include <linux/interrupt.h>
+#include <linux/clocksource.h>
+#include <linux/kernel_stat.h>
+
+#include <asm/arch_hooks.h>
+#include <asm/hypervisor.h>
+
+#include <xen/evtchn.h>
+#include <xen/interface/xen.h>
+#include <xen/interface/vcpu.h>
+
+#include "mach_time.h"
+#include "do_timer.h"
+
+
+/* Permitted clock jitter, in nsecs, beyond which a warning will be printed. */
+static unsigned long permitted_clock_jitter = 10000000UL; /* 10ms */
+static int __init __permitted_clock_jitter(char *str)
+{
+	permitted_clock_jitter = simple_strtoul(str, NULL, 0);
+	return 1;
+}
+__setup("permitted_clock_jitter=", __permitted_clock_jitter);
+
+
+/* These are perodically updated in shared_info, and then copied here. */
+struct shadow_time_info {
+	u64 tsc_timestamp;     /* TSC at last update of time vals.  */
+	u64 system_timestamp;  /* Time, in nanosecs, since boot.    */
+	u32 tsc_to_nsec_mul;
+	u32 tsc_to_usec_mul;
+	int tsc_shift;
+	u32 version;
+};
+
+static DEFINE_PER_CPU(struct shadow_time_info, shadow_time);
+
+/* Keep track of last time we did processing/updating of jiffies and xtime. */
+static u64 processed_system_time;   /* System time (ns) at last processing. */
+static DEFINE_PER_CPU(u64, processed_system_time);
+
+/* How much CPU time was spent blocked and how much was 'stolen'? */
+static DEFINE_PER_CPU(u64, processed_stolen_time);
+static DEFINE_PER_CPU(u64, processed_blocked_time);
+
+/* Current runstate of each CPU (updated automatically by the hypervisor). */
+static DEFINE_PER_CPU(struct vcpu_runstate_info, runstate);
+
+/* Must be signed, as it's compared with s64 quantities which can be -ve. */
+#define NS_PER_TICK (1000000000LL/HZ)
+
+/*
+ * Reads a consistent set of time-base values from Xen, into a shadow data
+ * area.
+ */
+static void get_time_values_from_xen(void)
+{
+	struct shared_info      *s = HYPERVISOR_shared_info;
+	struct vcpu_time_info   *src;
+	struct shadow_time_info *dst;
+
+	src = &s->vcpu_info[smp_processor_id()].time;
+	dst = &per_cpu(shadow_time, smp_processor_id());
+
+	do {
+		dst->version = src->version;
+		rmb();
+		dst->tsc_timestamp     = src->tsc_timestamp;
+		dst->system_timestamp  = src->system_time;
+		dst->tsc_to_nsec_mul   = src->tsc_to_system_mul;
+		dst->tsc_shift         = src->tsc_shift;
+		rmb();
+	} while ((src->version & 1) | (dst->version ^ src->version));
+
+	dst->tsc_to_usec_mul = dst->tsc_to_nsec_mul / 1000;
+}
+
+static inline int time_values_up_to_date(int cpu)
+{
+	struct vcpu_time_info   *src;
+	struct shadow_time_info *dst;
+
+	src = &HYPERVISOR_shared_info->vcpu_info[cpu].time;
+	dst = &per_cpu(shadow_time, cpu);
+
+	rmb();
+	return (dst->version == src->version);
+}
+
+/*
+ * Scale a 64-bit delta by scaling and multiplying by a 32-bit fraction,
+ * yielding a 64-bit result.
+ */
+static inline u64 scale_delta(u64 delta, u32 mul_frac, int shift)
+{
+	u64 product;
+#ifdef __i386__
+	u32 tmp1, tmp2;
+#endif
+
+	if (shift < 0)
+		delta >>= -shift;
+	else
+		delta <<= shift;
+
+#ifdef __i386__
+	__asm__ (
+		"mul  %5       ; "
+		"mov  %4,%%eax ; "
+		"mov  %%edx,%4 ; "
+		"mul  %5       ; "
+		"xor  %5,%5    ; "
+		"add  %4,%%eax ; "
+		"adc  %5,%%edx ; "
+		: "=A" (product), "=r" (tmp1), "=r" (tmp2)
+		: "a" ((u32)delta), "1" ((u32)(delta >> 32)), "2" (mul_frac) );
+#elif __x86_64__
+	__asm__ (
+		"mul %%rdx ; shrd $32,%%rdx,%%rax"
+		: "=a" (product) : "0" (delta), "d" ((u64)mul_frac) );
+#else
+#error implement me!
+#endif
+
+	return product;
+}
+
+static u64 get_nsec_offset(struct shadow_time_info *shadow)
+{
+	u64 now, delta;
+	rdtscll(now);
+	delta = now - shadow->tsc_timestamp;
+	return scale_delta(delta, shadow->tsc_to_nsec_mul, shadow->tsc_shift);
+}
+
+
+void do_timer_interrupt_hook(struct pt_regs *regs)
+{
+	s64 delta, delta_cpu, stolen, blocked;
+	u64 sched_time;
+	int i, cpu = smp_processor_id();
+	struct shadow_time_info *shadow = &per_cpu(shadow_time, cpu);
+	struct vcpu_runstate_info *runstate = &per_cpu(runstate, cpu);
+
+	do {
+		get_time_values_from_xen();
+
+		/* Obtain a consistent snapshot of elapsed wallclock cycles. */
+		delta = delta_cpu =
+			shadow->system_timestamp + get_nsec_offset(shadow);
+		delta     -= processed_system_time;
+		delta_cpu -= per_cpu(processed_system_time, cpu);
+
+		/*
+		 * Obtain a consistent snapshot of stolen/blocked cycles. We
+		 * can use state_entry_time to detect if we get preempted here.
+		 */
+		do {
+			sched_time = runstate->state_entry_time;
+			barrier();
+			stolen = runstate->time[RUNSTATE_runnable] +
+				runstate->time[RUNSTATE_offline] -
+				per_cpu(processed_stolen_time, cpu);
+			blocked = runstate->time[RUNSTATE_blocked] -
+				per_cpu(processed_blocked_time, cpu);
+			barrier();
+		} while (sched_time != runstate->state_entry_time);
+	} while (!time_values_up_to_date(cpu));
+
+	if ((unlikely(delta < -(s64)permitted_clock_jitter) ||
+	     unlikely(delta_cpu < -(s64)permitted_clock_jitter))
+	    && printk_ratelimit()) {
+		printk("Timer ISR/%d: Time went backwards: "
+		       "delta=%lld delta_cpu=%lld shadow=%lld "
+		       "off=%lld processed=%lld cpu_processed=%lld\n",
+		       cpu, delta, delta_cpu, shadow->system_timestamp,
+		       (s64)get_nsec_offset(shadow),
+		       processed_system_time,
+		       per_cpu(processed_system_time, cpu));
+		for (i = 0; i < num_online_cpus(); i++)
+			printk(" %d: %lld\n", i,
+			       per_cpu(processed_system_time, i));
+	}
+
+	/* System-wide jiffy work. */
+	while (delta >= NS_PER_TICK) {
+		delta -= NS_PER_TICK;
+		processed_system_time += NS_PER_TICK;
+		do_timer(regs);
+	}
+	/*
+	 * Account stolen ticks.
+	 * HACK: Passing NULL to account_steal_time()
+	 * ensures that the ticks are accounted as stolen.
+	 */
+	if ((stolen > 0) && (delta_cpu > 0)) {
+		delta_cpu -= stolen;
+		if (unlikely(delta_cpu < 0))
+			stolen += delta_cpu; /* clamp local-time progress */
+		do_div(stolen, NS_PER_TICK);
+		per_cpu(processed_stolen_time, cpu) += stolen * NS_PER_TICK;
+		per_cpu(processed_system_time, cpu) += stolen * NS_PER_TICK;
+		account_steal_time(NULL, (cputime_t)stolen);
+	}
+
+	/*
+	 * Account blocked ticks.
+	 * HACK: Passing idle_task to account_steal_time()
+	 * ensures that the ticks are accounted as idle/wait.
+	 */
+	if ((blocked > 0) && (delta_cpu > 0)) {
+		delta_cpu -= blocked;
+		if (unlikely(delta_cpu < 0))
+			blocked += delta_cpu; /* clamp local-time progress */
+		do_div(blocked, NS_PER_TICK);
+		per_cpu(processed_blocked_time, cpu) += blocked * NS_PER_TICK;
+		per_cpu(processed_system_time, cpu)  += blocked * NS_PER_TICK;
+		account_steal_time(idle_task(cpu), (cputime_t)blocked);
+	}
+
+	update_process_times(user_mode_vm(regs));
+}
+
+static cycle_t xen_clocksource_read(void)
+{
+	struct shadow_time_info *shadow = &per_cpu(shadow_time, smp_processor_id());
+
+	get_time_values_from_xen();
+
+	return shadow->system_timestamp + get_nsec_offset(shadow);
+}
+
+static void xen_get_wallclock(struct timespec *ts)
+{
+	const struct shared_info *s = HYPERVISOR_shared_info;
+	u32 version;
+	u64 delta;
+	struct timespec now;
+
+	/* get wallclock at system boot */
+	do {
+		version = s->wc_version;
+		rmb();
+		now.tv_sec  = s->wc_sec;
+		now.tv_nsec = s->wc_nsec;
+		rmb();
+	} while ((s->wc_version & 1) | (version ^ s->wc_version));
+
+	delta = xen_clocksource_read();	/* time since system boot */
+	delta += now.tv_sec * (u64)NSEC_PER_SEC + now.tv_nsec;
+
+	now.tv_nsec = do_div(delta, NSEC_PER_SEC);
+	now.tv_sec = delta;
+
+	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
+}
+
+unsigned long mach_get_cmos_time(void)
+{
+	struct timespec ts;
+
+	xen_get_wallclock(&ts);
+
+	return ts.tv_sec;
+}
+
+int mach_set_rtc_mmss(unsigned long now)
+{
+	/* do nothing for domU */
+	return -1;
+}
+
+static void init_cpu_khz(void)
+{
+	u64 __cpu_khz = 1000000ULL << 32;
+	struct vcpu_time_info *info;
+	info = &HYPERVISOR_shared_info->vcpu_info[0].time;
+	do_div(__cpu_khz, info->tsc_to_system_mul);
+	if (info->tsc_shift < 0)
+		cpu_khz = __cpu_khz << -info->tsc_shift;
+	else
+		cpu_khz = __cpu_khz >> info->tsc_shift;
+}
+
+static struct clocksource xen_clocksource = {
+	.name = "xen",
+	.rating = 400,
+	.read = xen_clocksource_read,
+	.mask = ~0,
+	.mult = 1,		/* time directly in nanoseconds */
+	.shift = 0,
+	.is_continuous = 1
+};
+
+static void init_missing_ticks_accounting(int cpu)
+{
+	struct vcpu_register_runstate_memory_area area;
+	struct vcpu_runstate_info *runstate = &per_cpu(runstate, cpu);
+
+	memset(runstate, 0, sizeof(*runstate));
+
+	area.addr.v = runstate;
+	HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area, cpu, &area);
+
+	per_cpu(processed_blocked_time, cpu) =
+		runstate->time[RUNSTATE_blocked];
+	per_cpu(processed_stolen_time, cpu) =
+		runstate->time[RUNSTATE_runnable] +
+		runstate->time[RUNSTATE_offline];
+}
+
+
+/* Dynamically-mapped IRQ. */
+static DEFINE_PER_CPU(int, timer_irq);
+
+extern void (*late_time_init)(void);
+static void setup_cpu0_timer_irq(void)
+{
+	printk(KERN_DEBUG "installing Xen timer for CPU 0\n");
+
+	per_cpu(timer_irq, 0) =
+		bind_virq_to_irqhandler(
+			VIRQ_TIMER,
+			0,
+			timer_interrupt,
+			SA_INTERRUPT,
+			"timer0",
+			NULL);
+	BUG_ON(per_cpu(timer_irq, 0) < 0);
+}
+
+extern void (*late_time_init)(void);
+
+__init void time_init_hook(void)
+{
+	get_time_values_from_xen();
+
+	processed_system_time = per_cpu(shadow_time, 0).system_timestamp;
+	per_cpu(processed_system_time, 0) = processed_system_time;
+
+	init_cpu_khz();
+	printk(KERN_INFO "Xen reported: %u.%03u MHz processor.\n",
+	       cpu_khz / 1000, cpu_khz % 1000);
+
+	/* Cannot request_irq() until kmem is initialised. */
+	late_time_init = setup_cpu0_timer_irq;
+
+	init_missing_ticks_accounting(0);
+
+	clocksource_register(&xen_clocksource);
+
+	/* Set initial system time with full resolution */
+	xen_get_wallclock(&xtime);
+	set_normalized_timespec(&wall_to_monotonic,
+				-xtime.tv_sec, -xtime.tv_nsec);
+}
diff -r 2657dae4b5cd include/asm-i386/mach-xen/do_timer.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-xen/do_timer.h	Tue Jul 18 03:40:46 2006 -0400
@@ -0,0 +1,3 @@
+
+void do_timer_interrupt_hook(struct pt_regs *regs);
+
diff -r 2657dae4b5cd include/asm-i386/mach-xen/mach_time.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-xen/mach_time.h	Tue Jul 18 03:40:46 2006 -0400
@@ -0,0 +1,16 @@
+#ifndef _MACH_TIME_H
+#define _MACH_TIME_H
+
+/* Still need these definitions for other uses of cmos/nvram */
+#include <linux/mc146818rtc.h>
+
+/* for check timing call set_rtc_mmss() 500ms     */
+/* used in arch/i386/time.c::do_timer_interrupt() */
+#define USEC_AFTER	500000
+#define USEC_BEFORE	500000
+
+/* In Xen, "CMOS" time is fetched from the hypervisor */
+int mach_set_rtc_mmss(unsigned long nowtime);
+unsigned long mach_get_cmos_time(void);
+
+#endif /* !_MACH_TIME_H */

--
