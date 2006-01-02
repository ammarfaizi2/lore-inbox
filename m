Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWABQHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWABQHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWABQHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:07:21 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:62460 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750797AbWABQHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:07:20 -0500
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
From: Daniel Walker <dwalker@mvista.com>
To: kus Kusche Klaus <kus@keba.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323310@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323310@MAILIT.keba.co.at>
Content-Type: multipart/mixed; boundary="=-f7HqTKMO5GxdSQalXnXE"
Date: Mon, 02 Jan 2006 08:07:18 -0800
Message-Id: <1136218038.22548.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f7HqTKMO5GxdSQalXnXE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Here's a more updated patch, the should replace the other patch I sent.
I think the tracing error is the result of a missed interrupt enable in
the ARM assembly code. I've only compile tested this.  

Daniel

On Mon, 2006-01-02 at 15:55 +0100, kus Kusche Klaus wrote:
> > From: Daniel Walker
> > Right .. I'm still looking into it. ARM is just missing some vital
> > tracing bits I think .
> 
> As I wrote in some earlier mail, I'm probably the first one ever
> who tried it on ARM: When I tried first, tracing didn't work at all,
> because the trace timing macro's were not defined (at least for
> sa1100). I quick-hacked the three missing macros (this caused the
> tracer to produce at least some output) without checking if 
> anything else is missing.
> 
> 

--=-f7HqTKMO5GxdSQalXnXE
Content-Disposition: attachment; filename=fix_tracing_arm_idle_loop.patch
Content-Type: text/x-patch; name=fix_tracing_arm_idle_loop.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.14/arch/arm/kernel/process.c
===================================================================
--- linux-2.6.14.orig/arch/arm/kernel/process.c
+++ linux-2.6.14/arch/arm/kernel/process.c
@@ -89,12 +89,12 @@ void default_idle(void)
 	if (hlt_counter)
 		cpu_relax();
 	else {
-		raw_local_irq_disable();
+		__raw_local_irq_disable();
 		if (!need_resched()) {
 			timer_dyn_reprogram();
 			arch_idle();
 		}
-		raw_local_irq_enable();
+		__raw_local_irq_enable();
 	}
 }
 
@@ -121,8 +121,10 @@ void cpu_idle(void)
 		if (!idle)
 			idle = default_idle;
 		leds_event(led_idle_start);
+		__preempt_enable_no_resched();
 		while (!need_resched())
 			idle();
+		preempt_disable();
 		leds_event(led_idle_end);
 		__preempt_enable_no_resched();
 		__schedule();
Index: linux-2.6.14/arch/arm/kernel/entry-header.S
===================================================================
--- linux-2.6.14.orig/arch/arm/kernel/entry-header.S
+++ linux-2.6.14/arch/arm/kernel/entry-header.S
@@ -38,18 +38,30 @@
 
 #if __LINUX_ARM_ARCH__ >= 6
 	.macro	disable_irq
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+	b	trace_irqs_off
+#endif
 	cpsid	i
 	.endm
 
 	.macro	enable_irq
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+	b	trace_irqs_on
+#endif
 	cpsie	i
 	.endm
 #else
 	.macro	disable_irq
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+	b	trace_irqs_off
+#endif
 	msr	cpsr_c, #PSR_I_BIT | SVC_MODE
 	.endm
 
 	.macro	enable_irq
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+	b	trace_irqs_on
+#endif
 	msr	cpsr_c, #SVC_MODE
 	.endm
 #endif

--=-f7HqTKMO5GxdSQalXnXE--

