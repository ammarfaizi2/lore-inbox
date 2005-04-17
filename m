Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVDQW1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVDQW1P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 18:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVDQW1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 18:27:15 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:46749 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261526AbVDQW1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 18:27:04 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12-rc2-mm3
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mikpe@csd.uu.se
In-Reply-To: <20050411012532.58593bc1.akpm@osdl.org>
References: <20050411012532.58593bc1.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 00:27:02 +0200
Message-Id: <1113776822.348.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> 
> 

[Mikael Pettersson on CC, would like your advice]

This patch fixes the NMI checking problems in -mm x64 for me. It 
changes the perfctr selection to use RETIRED_UOPS instead 
(makes both processors tick even on my box).

This makes the NMI tick once per second while running which is quite much, 
I'd like to get it down to every fourth second and herein lies the problem.
Multiplying nmi_interval() in patch below with 4 does not help, still ticks 
at about the same pace. I'm puzzled...


Index: x64_mm/arch/x86_64/kernel/nmi.c
===================================================================
--- x64_mm.orig/arch/x86_64/kernel/nmi.c	2005-04-17 14:34:09.000000000 +0200
+++ x64_mm/arch/x86_64/kernel/nmi.c	2005-04-18 02:11:37.000000000 +0200
@@ -58,7 +58,7 @@
 int panic_on_timeout;
 
 unsigned int nmi_watchdog = NMI_DEFAULT;
-static unsigned int nmi_hz = HZ;
+static unsigned long nmi_hz = HZ;
 unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 
 /* Note that these events don't tick when the CPU idles. This means
@@ -70,6 +70,7 @@
 #define K7_EVNTSEL_USR		(1 << 16)
 #define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0x76
 #define K7_NMI_EVENT		K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING
+#define K7_RETIRED_UOPS	0xC1 /* always running */
 
 #define P6_EVNTSEL0_ENABLE	(1 << 22)
 #define P6_EVNTSEL_INT		(1 << 20)
@@ -78,6 +79,11 @@
 #define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
 #define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED
 
+static inline unsigned long nmi_interval(void)
+{
+	return (((unsigned long)cpu_khz * 1000UL) / nmi_hz);
+}
+
 /* Run after command line and cpu_init init, but before all other checks */
 void __init nmi_watchdog_default(void)
 {
@@ -129,8 +135,8 @@
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		counts[cpu] = cpu_pda[cpu].__nmi_count; 
-	local_irq_enable();
-	mdelay((10*1000)/nmi_hz); // wait 10 ticks
+
+	mdelay((10*1000) / nmi_hz); /* wait 10 NMI ticks */
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (cpu_pda[cpu].__nmi_count - counts[cpu] <= 5) {
@@ -305,9 +311,6 @@
 	int i;
 	unsigned int evntsel;
 
-	/* No check, so can start with slow frequency */
-	nmi_hz = 1; 
-
 	/* XXX should check these in EFER */
 
 	nmi_perfctr_msr = MSR_K7_PERFCTR0;
@@ -322,10 +325,10 @@
 	evntsel = K7_EVNTSEL_INT
 		| K7_EVNTSEL_OS
 		| K7_EVNTSEL_USR
-		| K7_NMI_EVENT;
+		| K7_RETIRED_UOPS;
 
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz*1000) / nmi_hz);
+	wrmsrl(MSR_K7_PERFCTR0, -nmi_interval());
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= K7_EVNTSEL_ENABLE;
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
@@ -409,7 +412,7 @@
 		alert_counter[cpu] = 0;
 	}
 	if (nmi_perfctr_msr)
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
+		wrmsr(nmi_perfctr_msr, -nmi_interval(), -1);
 }
 
 static int dummy_nmi_callback(struct pt_regs * regs, int cpu)


