Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWGRJ27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWGRJ27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWGRJ2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:28:48 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:4226 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932121AbWGRJU4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:20:56 -0400
Message-Id: <20060718091956.415762000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:26 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: [RFC PATCH 26/33] subarch suport for idle loop (NO_IDLE_HZ for Xen)
Content-Disposition: inline; filename=i386-idle
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paravirtualize the idle loop to explicitly trap to the hypervisor when
blocking, and to use the NO_IDLE_HZ functionality introduced by s390
to inform the rcu subsystem that the CPU is quiescent.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 arch/i386/mach-xen/setup-xen.c        |   59 ++++++++++++++++++++++++++++++++++
 drivers/xen/Kconfig                   |    8 ++++
 drivers/xen/core/time.c               |   21 ++++++++++++
 include/asm-i386/mach-xen/mach_time.h |    3 +
 4 files changed, 91 insertions(+)

diff -r 793d8e45fb1e arch/i386/mach-xen/setup-xen.c
--- a/arch/i386/mach-xen/setup-xen.c	Tue Jul 18 03:41:42 2006 -0400
+++ b/arch/i386/mach-xen/setup-xen.c	Tue Jul 18 03:43:53 2006 -0400
@@ -7,6 +7,7 @@
 #include <linux/mm.h>
 #include <linux/bootmem.h>
 #include <linux/initrd.h>
+#include <linux/pm.h>
 
 #include <asm/e820.h>
 #include <asm/setup.h>
@@ -15,6 +16,9 @@
 
 #include <xen/interface/physdev.h>
 
+#include "mach_time.h"
+
+static void xen_idle(void);
 
 struct start_info *xen_start_info;
 EXPORT_SYMBOL(xen_start_info);
@@ -82,4 +86,59 @@ void __init machine_specific_arch_setup(
 		initrd_reserve_bootmem = 0;
 		initrd_below_start_ok = 1;
 	}
+
+
+	pm_idle = xen_idle;
 }
+
+/*
+ * stop_hz_timer / start_hz_timer - enter/exit 'tickless mode' on an idle cpu
+ * These functions are based on implementations from arch/s390/kernel/time.c
+ */
+static void stop_hz_timer(void)
+{
+	unsigned int cpu = smp_processor_id();
+	unsigned long j;
+
+	cpu_set(cpu, nohz_cpu_mask);
+
+	/* See matching smp_mb in rcu_start_batch in rcupdate.c.  These mbs  */
+	/* ensure that if __rcu_pending (nested in rcu_needs_cpu) fetches a  */
+	/* value of rcp->cur that matches rdp->quiescbatch and allows us to  */
+	/* stop the hz timer then the cpumasks created for subsequent values */
+	/* of cur in rcu_start_batch are guaranteed to pick up the updated   */
+	/* nohz_cpu_mask and so will not depend on this cpu.                 */
+
+	smp_mb();
+
+	/* Leave ourselves in 'tick mode' if rcu or softirq or timer pending. */
+	if (rcu_needs_cpu(cpu) || local_softirq_pending() ||
+	    (j = next_timer_interrupt(), time_before_eq(j, jiffies))) {
+		cpu_clear(cpu, nohz_cpu_mask);
+		j = jiffies + 1;
+	}
+
+	BUG_ON(HYPERVISOR_set_timer_op(jiffies_to_st(j)) != 0);
+}
+
+static void start_hz_timer(void)
+{
+	cpu_clear(smp_processor_id(), nohz_cpu_mask);
+}
+
+static void xen_idle(void)
+{
+	local_irq_disable();
+
+	if (need_resched())
+		local_irq_enable();
+	else {
+		current_thread_info()->status &= ~TS_POLLING;
+		smp_mb__after_clear_bit();
+		stop_hz_timer();
+		/* Blocking includes an implicit local_irq_enable(). */
+		HYPERVISOR_sched_op(SCHEDOP_block, 0);
+		start_hz_timer();
+		current_thread_info()->status |= TS_POLLING;
+	}
+}
diff -r 793d8e45fb1e drivers/xen/Kconfig
--- a/drivers/xen/Kconfig	Tue Jul 18 03:41:42 2006 -0400
+++ b/drivers/xen/Kconfig	Tue Jul 18 03:43:53 2006 -0400
@@ -12,6 +12,14 @@ config XEN
 
 if XEN
 
+config NO_IDLE_HZ
+	bool
+	default y
+	help
+	  Switches the regular HZ timer off when the system is going idle.
+	  This helps Xen to detect that the Linux system is idle, reducing
+	  the overhead of idle systems.
+
 config XEN_SHADOW_MODE
 	bool
 	default y
diff -r 793d8e45fb1e drivers/xen/core/time.c
--- a/drivers/xen/core/time.c	Tue Jul 18 03:41:42 2006 -0400
+++ b/drivers/xen/core/time.c	Tue Jul 18 03:43:53 2006 -0400
@@ -227,6 +227,27 @@ void do_timer_interrupt_hook(struct pt_r
 	update_process_times(user_mode_vm(regs));
 }
 
+
+/* Convert jiffies to Xen system time. */
+u64 jiffies_to_st(unsigned long j)
+{
+	unsigned long seq;
+	long delta;
+	u64 st;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		delta = j - jiffies;
+		/* NB. The next check can trigger in some wrap-around cases,
+		 * but that's ok: we'll just end up with a shorter timeout. */
+		if (delta < 1)
+			delta = 1;
+		st = processed_system_time + (delta * (u64)NS_PER_TICK);
+	} while (read_seqretry(&xtime_lock, seq));
+
+	return st;
+}
+
 static cycle_t xen_clocksource_read(void)
 {
 	struct shadow_time_info *shadow = &per_cpu(shadow_time, smp_processor_id());
diff -r 793d8e45fb1e include/asm-i386/mach-xen/mach_time.h
--- a/include/asm-i386/mach-xen/mach_time.h	Tue Jul 18 03:41:42 2006 -0400
+++ b/include/asm-i386/mach-xen/mach_time.h	Tue Jul 18 03:43:53 2006 -0400
@@ -13,4 +13,7 @@ int mach_set_rtc_mmss(unsigned long nowt
 int mach_set_rtc_mmss(unsigned long nowtime);
 unsigned long mach_get_cmos_time(void);
 
+/* Convert jiffies to Xen system time. */
+u64 jiffies_to_st(unsigned long j);
+
 #endif /* !_MACH_TIME_H */

--
