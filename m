Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVDRLGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVDRLGH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 07:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVDRLGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 07:06:07 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:49307 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262030AbVDRLF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 07:05:57 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12-rc2-mm3
From: Alexander Nyberg <alexn@dsv.su.se>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200504172339.j3HNdIDF011543@harpo.it.uu.se>
References: <200504172339.j3HNdIDF011543@harpo.it.uu.se>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 13:05:45 +0200
Message-Id: <1113822345.365.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Proper patch now that goes all the way, sorry for spamming]

Patch below uses RETIRED_UOPS for a more constant rate of NMI sending.
This makes x64 deliver NMI interrupts every fourth second at a constant
rate when going through the local apic. Makes both cpus on my box to get
NMIs at constant rate that it previously did not, there could be long
delays when a CPU was idle.

This fixes misdetection in check_nmi_watchdog() that thought the NMI
sending was stuck although it was not because the perfctr did not
generate enough events with the previous mask. The 10-second
check_nmi_watchdog() delay is down to 10 msec now.

Tested on opteron SMP.


Index: x64_mm/arch/x86_64/kernel/nmi.c
===================================================================
--- x64_mm.orig/arch/x86_64/kernel/nmi.c	2005-04-18 12:56:05.000000000 +0200
+++ x64_mm/arch/x86_64/kernel/nmi.c	2005-04-18 14:47:14.000000000 +0200
@@ -59,16 +59,14 @@
 
 unsigned int nmi_watchdog = NMI_DEFAULT;
 static unsigned int nmi_hz = HZ;
+static int nmi_mult = 1;	/* nmi multiplier for longer intervals */
 unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 
-/* Note that these events don't tick when the CPU idles. This means
-   the frequency varies with CPU load. */
-
 #define K7_EVNTSEL_ENABLE	(1 << 22)
 #define K7_EVNTSEL_INT		(1 << 20)
 #define K7_EVNTSEL_OS		(1 << 17)
 #define K7_EVNTSEL_USR		(1 << 16)
-#define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0x76
+#define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0xC1 /* Retired uops */
 #define K7_NMI_EVENT		K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING
 
 #define P6_EVNTSEL0_ENABLE	(1 << 22)
@@ -78,6 +76,11 @@
 #define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
 #define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED
 
+static inline unsigned long nmi_interval(void)
+{
+	return ((unsigned long)cpu_khz * 1000 * nmi_mult) / nmi_hz;
+}
+
 /* Run after command line and cpu_init init, but before all other checks */
 void __init nmi_watchdog_default(void)
 {
@@ -146,8 +149,10 @@
 
 	/* now that we know it works we can reduce NMI frequency to
 	   something more reasonable; makes a difference in some configs */
-	if (nmi_watchdog == NMI_LOCAL_APIC)
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
 		nmi_hz = 1;
+		nmi_mult = 8;
+	}
 
 	return 0;
 }
@@ -305,9 +310,6 @@
 	int i;
 	unsigned int evntsel;
 
-	/* No check, so can start with slow frequency */
-	nmi_hz = 1; 
-
 	/* XXX should check these in EFER */
 
 	nmi_perfctr_msr = MSR_K7_PERFCTR0;
@@ -325,7 +327,7 @@
 		| K7_NMI_EVENT;
 
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz*1000) / nmi_hz);
+	wrmsrl(MSR_K7_PERFCTR0, -nmi_interval());
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= K7_EVNTSEL_ENABLE;
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
@@ -393,10 +395,10 @@
 	if (last_irq_sums[cpu] == sum) {
 		/*
 		 * Ayiee, looks like this CPU is stuck ...
-		 * wait a few IRQs (5 seconds) before doing the oops ...
+		 * wait a few NMIs before doing the oops ...
 		 */
 		alert_counter[cpu]++;
-		if (alert_counter[cpu] == 5*nmi_hz) {
+		if (alert_counter[cpu] == 3*nmi_hz) {
 			if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT)
 							== NOTIFY_STOP) {
 				alert_counter[cpu] = 0; 
@@ -409,7 +411,7 @@
 		alert_counter[cpu] = 0;
 	}
 	if (nmi_perfctr_msr)
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
+		wrmsr(nmi_perfctr_msr, -nmi_interval(), -1);
 }
 
 static int dummy_nmi_callback(struct pt_regs * regs, int cpu)


