Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269250AbUJQQgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269250AbUJQQgv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269196AbUJQQNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:13:02 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:24965 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S269179AbUJQQKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:10:00 -0400
Subject: [PATCH 5/8] replacing/fixing printk with pr_debug/pr_info in
	arch/i386 - nmi.c
From: Daniele Pizzoni <auouo@tin.it>
To: kernel-janitors <kernel-janitors@lists.osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Message-Id: <1098032573.3023.126.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 19:11:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom macro Dprintk (defined in apic.h included via smp.h) with pr_debug from kernel.h.
Use  pr_info when appropriate.
Fix consistency of printks.

Signed-off-by: Daniele Pizzoni <auouo@tin.it>

Index: linux-2.6.9-rc4/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/i386/kernel/nmi.c	2004-10-17 16:57:00.404604432 +0200
+++ linux-2.6.9-rc4/arch/i386/kernel/nmi.c	2004-10-17 17:01:18.114426584 +0200
@@ -13,6 +13,7 @@
  *  Mikael Pettersson	: PM converted to driver model. Disable/enable API.
  */
 
+#include <linux/kernel.h>
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/irq.h>
@@ -107,7 +108,7 @@ int __init check_nmi_watchdog (void)
 	unsigned int prev_nmi_count[NR_CPUS];
 	int cpu;
 
-	printk(KERN_INFO "testing NMI watchdog ... ");
+	pr_info("testing NMI watchdog ... ");
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		prev_nmi_count[cpu] = irq_stat[cpu].__nmi_count;
@@ -120,13 +121,13 @@ int __init check_nmi_watchdog (void)
 		if (!cpu_online(cpu))
 			continue;
 		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
-			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
+			printk(KERN_WARNING "CPU#%d: NMI appears to be stuck!\n", cpu);
 			nmi_active = 0;
 			lapic_nmi_owner &= ~LAPIC_NMI_WATCHDOG;
 			return -1;
 		}
 	}
-	printk("OK.\n");
+	pr_info("OK.\n");
 
 	/* now that we know it works we can reduce NMI frequency to
 	   something more reasonable; makes a difference in some configs */
@@ -332,7 +333,7 @@ static void setup_k7_watchdog(void)
 		| K7_NMI_EVENT;
 
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	Dprintk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
+	pr_debug("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
 	wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= K7_EVNTSEL_ENABLE;
@@ -354,7 +355,7 @@ static void setup_p6_watchdog(void)
 		| P6_NMI_EVENT;
 
 	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
-	Dprintk("setting P6_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
+	pr_debug("setting P6_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
 	wrmsr(MSR_P6_PERFCTR0, -(cpu_khz/nmi_hz*1000), 0);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= P6_EVNTSEL0_ENABLE;
@@ -395,7 +396,7 @@ static int setup_p4_watchdog(void)
 
 	wrmsr(MSR_P4_CRU_ESCR0, P4_NMI_CRU_ESCR0, 0);
 	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0 & ~P4_CCCR_ENABLE, 0);
-	Dprintk("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/nmi_hz*1000));
+	pr_debug("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/nmi_hz*1000));
 	wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);


