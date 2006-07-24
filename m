Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWGXRGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWGXRGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWGXRGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:06:41 -0400
Received: from fmr17.intel.com ([134.134.136.16]:19367 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932219AbWGXRGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:06:40 -0400
Subject: Reducing local_bh_enable/disable overhead in irqtrace
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: mingo@elte.hu
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Intel
Date: Mon, 24 Jul 2006 09:22:35 -0700
Message-Id: <1153758155.10345.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

The recent changes from irqtrace feature has added overheads to
local_bh_disable and local_bh_enable that reduces UDP performance across
x86_64 and IA64, even though IA64 does not support the irqtrace feature.
Patch in question is

[PATCH]lockdep: irqtrace subsystem, core
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=c
ommit;h=de30a2b355ea85350ca2f58f3b9bf4e5bc007986

Prior to this patch, local_bh_disable was a short macro. Now it is a
function which calls  __local_bh_disable with added irq flags save and
restore.  The irq flags save and restore were also added to
local_bh_enable, probably for injecting the trace irqs code.  This
overhead is on the generic code path across all architectures.  On a
IA_64 test machine (Itanium-2 1.6 GHz) running a benchmark like
netperf's UDP streaming test, the added overhead results in a drop of 3%
in throughput, as udp_sendmsg calls the local_bh_enable/disable several
times. Other workloads that have heavy usages of local_bh_enable/disable
could also be affected. The patch ideally should not have affected IA-64
performance as it does not have IRQ tracing support.  A significant
portion of the overhead is in the added irq flags save and restore,
which I think is not needed if IRQ tracing is unused. A suggested patch
is attached below that recovers the lost performance.  However, the
"ifdef"s in the patch are a bit ugly.

Tim Chen

Signed-off-by: Tim Chen <tim.c.chen@intel.com>
--- a/kernel/softirq.c.orig	2006-07-19 12:18:29.000000000 -0700
+++ b/kernel/softirq.c	2006-07-21 08:34:42.000000000 -0700
@@ -65,6 +65,7 @@
  * This one is for softirq.c-internal use,
  * where hardirqs are disabled legitimately:
  */
+#ifdef CONFIG_TRACE_IRQFLAGS
 static void __local_bh_disable(unsigned long ip)
 {
 	unsigned long flags;
@@ -80,6 +81,13 @@
 		trace_softirqs_off(ip);
 	raw_local_irq_restore(flags);
 }
+#else /* !CONFIG_TRACE_IRQFLAGS */
+static inline void __local_bh_disable(unsigned long ip) 
+{
+	add_preempt_count(SOFTIRQ_OFFSET); 
+	barrier(); 
+}
+#endif /* CONFIG_TRACE_IRQFLAGS */
 
 void local_bh_disable(void)
 {
@@ -121,12 +129,16 @@
 
 void local_bh_enable(void)
 {
+#ifdef CONFIG_TRACE_IRQFLAGS
 	unsigned long flags;
 
 	WARN_ON_ONCE(in_irq());
+#endif
 	WARN_ON_ONCE(irqs_disabled());
 
+#ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_save(flags);
+#endif
 	/*
 	 * Are softirqs going to be turned on now:
 	 */
@@ -142,18 +154,22 @@
 		do_softirq();
 
 	dec_preempt_count();
+#ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_restore(flags);
+#endif
 	preempt_check_resched();
 }
 EXPORT_SYMBOL(local_bh_enable);
 
 void local_bh_enable_ip(unsigned long ip)
 {
+#ifdef CONFIG_TRACE_IRQFLAGS
 	unsigned long flags;
 
 	WARN_ON_ONCE(in_irq());
 
 	local_irq_save(flags);
+#endif
 	/*
 	 * Are softirqs going to be turned on now:
 	 */
@@ -169,7 +185,9 @@
 		do_softirq();
 
 	dec_preempt_count();
+#ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_restore(flags);
+#endif
 	preempt_check_resched();
 }
 EXPORT_SYMBOL(local_bh_enable_ip);


