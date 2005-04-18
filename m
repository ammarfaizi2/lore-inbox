Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVDRJ42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVDRJ42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 05:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVDRJ42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 05:56:28 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:46040 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262004AbVDRJ4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 05:56:17 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12-rc2-mm3
From: Alexander Nyberg <alexn@dsv.su.se>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200504172339.j3HNdIDF011543@harpo.it.uu.se>
References: <200504172339.j3HNdIDF011543@harpo.it.uu.se>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 11:56:15 +0200
Message-Id: <1113818175.357.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >This patch fixes the NMI checking problems in -mm x64 for me. It 
> 
> What problems?
> 

Sorry, in -mm on x64 check_nmi_watchdog() has started to be run as a
late_initcall(). Currently it reports the NMIs as stuck on a few systems
although they are not, both of mine are reported as stuck. This appears
to be because the current event mask uses don't appear to tick much
running mdelay() on opteron (in my case). Also in -mm because nmi_hz is
set to 1 in setup_k7_watchdog() the NMI watchdog checking takes 10
seconds, a bit much.

Patch below uses RETIRED_UOPS for a more constant rate of NMI sending, 
this works well for me. However I'd like NMIs to maybe fire every fourth
second or so. Using nmi_mult to multiply nmi_interval() by 4 doesn't
seem to make it go every fourth second however, maybe every 1.5 second,
I'm puzzled about this...


Index: x64_mm/arch/x86_64/kernel/nmi.c
===================================================================
--- x64_mm.orig/arch/x86_64/kernel/nmi.c	2005-04-18 12:56:05.000000000 +0200
+++ x64_mm/arch/x86_64/kernel/nmi.c	2005-04-18 13:34:37.000000000 +0200
@@ -59,6 +59,7 @@
 
 unsigned int nmi_watchdog = NMI_DEFAULT;
 static unsigned int nmi_hz = HZ;
+static int nmi_mult = 1;	/* nmi multiplier, how many seconds inbetween */
 unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 
 /* Note that these events don't tick when the CPU idles. This means
@@ -68,7 +69,7 @@
 #define K7_EVNTSEL_INT		(1 << 20)
 #define K7_EVNTSEL_OS		(1 << 17)
 #define K7_EVNTSEL_USR		(1 << 16)
-#define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0x76
+#define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0xC1 /* Retired uops */
 #define K7_NMI_EVENT		K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING
 
 #define P6_EVNTSEL0_ENABLE	(1 << 22)
@@ -78,6 +79,11 @@
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
@@ -146,8 +152,10 @@
 
 	/* now that we know it works we can reduce NMI frequency to
 	   something more reasonable; makes a difference in some configs */
-	if (nmi_watchdog == NMI_LOCAL_APIC)
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
 		nmi_hz = 1;
+		nmi_mult = 4;
+	}
 
 	return 0;
 }
@@ -305,9 +313,6 @@
 	int i;
 	unsigned int evntsel;
 
-	/* No check, so can start with slow frequency */
-	nmi_hz = 1; 
-
 	/* XXX should check these in EFER */
 
 	nmi_perfctr_msr = MSR_K7_PERFCTR0;
@@ -325,7 +330,7 @@
 		| K7_NMI_EVENT;
 
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz*1000) / nmi_hz);
+	wrmsrl(MSR_K7_PERFCTR0, -nmi_interval());
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= K7_EVNTSEL_ENABLE;
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
@@ -409,7 +414,7 @@
 		alert_counter[cpu] = 0;
 	}
 	if (nmi_perfctr_msr)
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
+		wrmsr(nmi_perfctr_msr, -nmi_interval(), -1);
 }
 
 static int dummy_nmi_callback(struct pt_regs * regs, int cpu)


