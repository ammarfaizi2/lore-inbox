Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVDQXji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVDQXji (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 19:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVDQXji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 19:39:38 -0400
Received: from aun.it.uu.se ([130.238.12.36]:4564 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261559AbVDQXj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 19:39:27 -0400
Date: Mon, 18 Apr 2005 01:39:18 +0200 (MEST)
Message-Id: <200504172339.j3HNdIDF011543@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org, alexn@dsv.su.se
Subject: Re: 2.6.12-rc2-mm3
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2005 00:27:02 +0200, Alexander Nyberg wrote:
>This patch fixes the NMI checking problems in -mm x64 for me. It 

What problems?

>changes the perfctr selection to use RETIRED_UOPS instead 
>(makes both processors tick even on my box).

This patch mixes what appears to be cleanups with what appears
to be bug fixes. Please separate them, and describe the problem
in enough detail that we can judge the validity of the bug-fix parts.

>Index: x64_mm/arch/x86_64/kernel/nmi.c
>===================================================================
>--- x64_mm.orig/arch/x86_64/kernel/nmi.c	2005-04-17 14:34:09.000000000 +0200
>+++ x64_mm/arch/x86_64/kernel/nmi.c	2005-04-18 02:11:37.000000000 +0200
>@@ -58,7 +58,7 @@
> int panic_on_timeout;
> 
> unsigned int nmi_watchdog = NMI_DEFAULT;
>-static unsigned int nmi_hz = HZ;
>+static unsigned long nmi_hz = HZ;

Why? Surely the value won't exceed 2^32-1?

> unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
> 
> /* Note that these events don't tick when the CPU idles. This means
>@@ -70,6 +70,7 @@
> #define K7_EVNTSEL_USR		(1 << 16)
> #define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0x76
> #define K7_NMI_EVENT		K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING
>+#define K7_RETIRED_UOPS	0xC1 /* always running */
> 
> #define P6_EVNTSEL0_ENABLE	(1 << 22)
> #define P6_EVNTSEL_INT		(1 << 20)
>@@ -78,6 +79,11 @@
> #define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
> #define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED
> 
>+static inline unsigned long nmi_interval(void)
>+{
>+	return (((unsigned long)cpu_khz * 1000UL) / nmi_hz);

Extraneous parentheses. Also I'd prefer to divide before the multiply.

>+}
>+
> /* Run after command line and cpu_init init, but before all other checks */
> void __init nmi_watchdog_default(void)
> {
>@@ -129,8 +135,8 @@
> 
> 	for (cpu = 0; cpu < NR_CPUS; cpu++)
> 		counts[cpu] = cpu_pda[cpu].__nmi_count; 
>-	local_irq_enable();

Why?

>-	mdelay((10*1000)/nmi_hz); // wait 10 ticks
>+
>+	mdelay((10*1000) / nmi_hz); /* wait 10 NMI ticks */

Not a bug fix.

> 
> 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
> 		if (cpu_pda[cpu].__nmi_count - counts[cpu] <= 5) {
>@@ -305,9 +311,6 @@
> 	int i;
> 	unsigned int evntsel;
> 
>-	/* No check, so can start with slow frequency */
>-	nmi_hz = 1; 
>-

What's this for?

> 	/* XXX should check these in EFER */
> 
> 	nmi_perfctr_msr = MSR_K7_PERFCTR0;
>@@ -322,10 +325,10 @@
> 	evntsel = K7_EVNTSEL_INT
> 		| K7_EVNTSEL_OS
> 		| K7_EVNTSEL_USR
>-		| K7_NMI_EVENT;
>+		| K7_RETIRED_UOPS;

Bogus. Redefine K7_NMI_EVENT instead.

/Mikael
