Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUCEEmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 23:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbUCEEmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 23:42:20 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.27]:5637 "EHLO
	mwinf0402.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262205AbUCEEmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 23:42:16 -0500
Date: Fri, 5 Mar 2004 05:42:38 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] set nmi_hz to 1 with nmi_watchdog=2 and SMP
Message-ID: <20040305054238.GA1016@zaniah>
References: <20040304054215.GA683@zaniah> <20040303213033.6348a08b.akpm@osdl.org> <20040304072630.GB683@zaniah> <20040303223235.177685dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303223235.177685dd.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2004 at 22:32 +0000, Andrew Morton wrote:

> Can we scale the performance counter multiplier down a bit?  1000 NMIs per
> second sounds excessive.

there, patch apply cleanly on top of the nmi_watchdog=2 and P4-HT patch,
most of the patch rename nmi_hz to apic_nmi_hz, the only meaningfull chunk
is the first.

regrads,
phil


Philippe Elie:

rename nmi_hz to apic_nmi_hz and make it global, on smp box setup
apic_nmi_hz to 1 hz after all cpus are up. apic_nmi_hz was already
already set correctly on UP box.


diff -upr -X /home/phe/dontdiff-2.6.0 linux-2.6.orig/arch/i386/kernel/io_apic.c linux-2.6/arch/i386/kernel/io_apic.c
--- linux-2.6.orig/arch/i386/kernel/io_apic.c	2004-03-04 05:05:19.000000000 +0000
+++ linux-2.6/arch/i386/kernel/io_apic.c	2004-03-05 02:25:57.000000000 +0000
@@ -2304,6 +2304,9 @@ void __init setup_IO_APIC(void)
 	check_timer();
 	if (!acpi_ioapic)
 		print_IO_APIC();
+
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		apic_nmi_hz = 1;
 }
 
 /*
diff -upr -X /home/phe/dontdiff-2.6.0 linux-2.6.orig/arch/i386/kernel/nmi.c linux-2.6/arch/i386/kernel/nmi.c
--- linux-2.6.orig/arch/i386/kernel/nmi.c	2004-03-05 03:57:02.000000000 +0000
+++ linux-2.6/arch/i386/kernel/nmi.c	2004-03-05 03:55:58.000000000 +0000
@@ -32,7 +32,7 @@
 #include <asm/nmi.h>
 
 unsigned int nmi_watchdog = NMI_NONE;
-static unsigned int nmi_hz = HZ;
+unsigned int apic_nmi_hz = HZ;
 static unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 static unsigned int nmi_p4_cccr_val;
 extern void show_registers(struct pt_regs *regs);
@@ -94,7 +94,7 @@ int __init check_nmi_watchdog (void)
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		prev_nmi_count[cpu] = irq_stat[cpu].__nmi_count;
 	local_irq_enable();
-	mdelay((10*1000)/nmi_hz); // wait 10 ticks
+	mdelay((10*1000)/apic_nmi_hz); // wait 10 ticks
 
 	/* FIXME: Only boot CPU is online at this stage.  Check CPUs
            as they come up. */
@@ -112,7 +112,7 @@ int __init check_nmi_watchdog (void)
 	/* now that we know it works we can reduce NMI frequency to
 	   something more reasonable; makes a difference in some configs */
 	if (nmi_watchdog == NMI_LOCAL_APIC)
-		nmi_hz = 1;
+		apic_nmi_hz = 1;
 
 	return 0;
 }
@@ -286,8 +286,8 @@ static void setup_k7_watchdog(void)
 		| K7_NMI_EVENT;
 
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	Dprintk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
+	Dprintk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/apic_nmi_hz*1000));
+	wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/apic_nmi_hz*1000), -1);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= K7_EVNTSEL_ENABLE;
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
@@ -308,8 +308,8 @@ static void setup_p6_watchdog(void)
 		| P6_NMI_EVENT;
 
 	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
-	Dprintk("setting P6_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_P6_PERFCTR0, -(cpu_khz/nmi_hz*1000), 0);
+	Dprintk("setting P6_PERFCTR0 to %08lx\n", -(cpu_khz/apic_nmi_hz*1000));
+	wrmsr(MSR_P6_PERFCTR0, -(cpu_khz/apic_nmi_hz*1000), 0);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= P6_EVNTSEL0_ENABLE;
 	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
@@ -343,8 +343,8 @@ static int setup_p4_watchdog(void)
 
 	wrmsr(MSR_P4_CRU_ESCR0, P4_NMI_CRU_ESCR0, 0);
 	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0 & ~P4_CCCR_ENABLE, 0);
-	Dprintk("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
+	Dprintk("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/apic_nmi_hz*1000));
+	wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/apic_nmi_hz*1000), -1);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
 	return 1;
@@ -434,7 +434,7 @@ void nmi_watchdog_tick (struct pt_regs *
 		 * wait a few IRQs (5 seconds) before doing the oops ...
 		 */
 		alert_counter[cpu]++;
-		if (alert_counter[cpu] == 5*nmi_hz) {
+		if (alert_counter[cpu] == 5*apic_nmi_hz) {
 			spin_lock(&nmi_print_lock);
 			/*
 			 * We are in trouble anyway, lets at least try
@@ -465,7 +465,7 @@ void nmi_watchdog_tick (struct pt_regs *
 			wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
 			apic_write(APIC_LVTPC, APIC_DM_NMI);
 		}
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
+		wrmsr(nmi_perfctr_msr, -(cpu_khz/apic_nmi_hz*1000), -1);
 	}
 }
 
diff -upr -X /home/phe/dontdiff-2.6.0 linux-2.6.orig/include/asm-i386/apic.h linux-2.6/include/asm-i386/apic.h
--- linux-2.6.orig/include/asm-i386/apic.h	2004-03-04 05:05:37.000000000 +0000
+++ linux-2.6/include/asm-i386/apic.h	2004-03-05 02:28:41.000000000 +0000
@@ -94,6 +94,7 @@ extern int check_nmi_watchdog (void);
 extern void enable_NMI_through_LVT0 (void * dummy);
 
 extern unsigned int nmi_watchdog;
+extern unsigned int apic_nmi_hz;
 #define NMI_NONE	0
 #define NMI_IO_APIC	1
 #define NMI_LOCAL_APIC	2
