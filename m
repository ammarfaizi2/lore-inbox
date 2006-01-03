Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWACOQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWACOQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWACOQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:16:58 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:59635 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751430AbWACOQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:16:57 -0500
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
From: Daniel Walker <dwalker@mvista.com>
To: kus Kusche Klaus <kus@keba.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323312@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323312@MAILIT.keba.co.at>
Content-Type: multipart/mixed; boundary="=-jPXxYfBdFMMJZDjnvnGK"
Date: Tue, 03 Jan 2006 06:16:55 -0800
Message-Id: <1136297815.5915.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jPXxYfBdFMMJZDjnvnGK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-01-03 at 09:00 +0100, kus Kusche Klaus wrote:
> > From: Daniel Walker
> > Here's a more updated patch, the should replace the other 
> > patch I sent.
> > I think the tracing error is the result of a missed interrupt 
> > enable in
> > the ARM assembly code. I've only compile tested this.  
> 
> Compiles, but BUGs immediately after uncompressing (second line of
> console output) and then runs into an infinite Oops loop...
> Reproducible.

Ok, yet another patch. This one uses the correct lowlevel calls, and I
fixed the call ordering.

Daniel

--=-jPXxYfBdFMMJZDjnvnGK
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
@@ -39,17 +39,29 @@
 #if __LINUX_ARM_ARCH__ >= 6
 	.macro	disable_irq
 	cpsid	i
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+	b	trace_irqs_off_lowlevel
+#endif
 	.endm
 
 	.macro	enable_irq
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+	b	trace_irqs_on
+#endif
 	cpsie	i
 	.endm
 #else
 	.macro	disable_irq
 	msr	cpsr_c, #PSR_I_BIT | SVC_MODE
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+	b	trace_irqs_off_lowlevel
+#endif
 	.endm
 
 	.macro	enable_irq
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+	b	trace_irqs_on
+#endif
 	msr	cpsr_c, #SVC_MODE
 	.endm
 #endif

--=-jPXxYfBdFMMJZDjnvnGK--

