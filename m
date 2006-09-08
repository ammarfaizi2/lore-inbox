Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWIHTqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWIHTqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 15:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWIHTqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 15:46:46 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:30599 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750962AbWIHTqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 15:46:45 -0400
Message-ID: <4501C87A.70505@mvista.com>
Date: Fri, 08 Sep 2006 12:46:02 -0700
From: Kevin Hilman <khilman@mvista.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] use SA_NODELAY for XScale PMU interrupts
References: <4501C2FE.40109@mvista.com>
In-Reply-To: <4501C2FE.40109@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman wrote:
> In the XScale oprofile support, the performance monitoring unit (PMU)
> triggers interrupts and the ISR reads out the performance data.  These
> ISRs are currently set to SA_INTERRUPT.  In order to get accurate
> performance and profiling data under PREEMPT_RT, these should use
> SA_NODELAY.  The functions called by this ISR are limited to
> drivers/oprofile functions.
> 
> Patch against 2.6.18-rt8
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>

Resend, without the #define DEBUG.

Index: dev/arch/arm/oprofile/op_model_xscale.c
===================================================================
--- dev.orig/arch/arm/oprofile/op_model_xscale.c
+++ dev/arch/arm/oprofile/op_model_xscale.c
@@ -20,6 +20,8 @@
 #include <linux/sched.h>
 #include <linux/oprofile.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+
 #include <asm/irq.h>
 #include <asm/system.h>

@@ -383,8 +385,9 @@ static int xscale_pmu_start(void)
 {
 	int ret;
 	u32 pmnc = read_pmnc();
+	int irq_flags = SA_INTERRUPT | SA_NODELAY;

-	ret = request_irq(XSCALE_PMU_IRQ, xscale_pmu_interrupt, SA_INTERRUPT,
+	ret = request_irq(XSCALE_PMU_IRQ, xscale_pmu_interrupt, irq_flags,
 			"XScale PMU", (void *)results);

 	if (ret < 0) {
