Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbUCDEmW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 23:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbUCDEmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 23:42:22 -0500
Received: from smtp9.wanadoo.fr ([193.252.22.22]:19844 "EHLO
	mwinf0902.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261446AbUCDEl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 23:41:56 -0500
Date: Thu, 4 Mar 2004 05:42:15 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] nmi_watchdog=2 and P4-HT
Message-ID: <20040304054215.GA683@zaniah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Actually with nmi_watchdog=2 and a P4 ht box the nmi is reflected
only on logical processor 0, it's better to get it on both.

Note, if you test this patch, than on all x86 SMP and nmi_watchdog=2
nmi occurs at 1000 hz (if the cpu is loaded) not at the intended 1 hz
rate but that's a distinct problem.

regards,
Phil

--- linux-2.6.orig/arch/i386/kernel/nmi.c	2004-03-04 05:05:19.000000000 +0000
+++ linux-2.6/arch/i386/kernel/nmi.c	2004-03-04 04:28:43.000000000 +0000
@@ -33,7 +33,8 @@
 
 unsigned int nmi_watchdog = NMI_NONE;
 static unsigned int nmi_hz = HZ;
-unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
+static unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
+static unsigned int nmi_p4_cccr_val;
 extern void show_registers(struct pt_regs *regs);
 
 /* nmi_active:
@@ -66,7 +67,8 @@ int nmi_active;
 #define P4_ESCR_EVENT_SELECT(N)	((N)<<25)
 #define P4_ESCR_OS		(1<<3)
 #define P4_ESCR_USR		(1<<2)
-#define P4_CCCR_OVF_PMI		(1<<26)
+#define P4_CCCR_OVF_PMI0	(1<<26)
+#define P4_CCCR_OVF_PMI1	(1<<27)
 #define P4_CCCR_THRESHOLD(N)	((N)<<20)
 #define P4_CCCR_COMPLEMENT	(1<<19)
 #define P4_CCCR_COMPARE		(1<<18)
@@ -79,7 +81,7 @@ int nmi_active;
 #define MSR_P4_IQ_COUNTER0	0x30C
 #define P4_NMI_CRU_ESCR0	(P4_ESCR_EVENT_SELECT(0x3F)|P4_ESCR_OS|P4_ESCR_USR)
 #define P4_NMI_IQ_CCCR0	\
-	(P4_CCCR_OVF_PMI|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
+	(P4_CCCR_OVF_PMI0|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
 	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
 
 int __init check_nmi_watchdog (void)
@@ -322,6 +324,11 @@ static int setup_p4_watchdog(void)
 		return 0;
 
 	nmi_perfctr_msr = MSR_P4_IQ_COUNTER0;
+	nmi_p4_cccr_val = P4_NMI_IQ_CCCR0;
+#ifdef CONFIG_SMP
+	if (smp_num_siblings == 2)
+		nmi_p4_cccr_val |= P4_CCCR_OVF_PMI1;
+#endif
 
 	if (!(misc_enable & MSR_P4_MISC_ENABLE_PEBS_UNAVAIL))
 		clear_msr_range(0x3F1, 2);
@@ -339,7 +346,8 @@ static int setup_p4_watchdog(void)
 	Dprintk("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/nmi_hz*1000));
 	wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
-	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0, 0);
+	wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
+	nmi_hz = 1;
 	return 1;
 }
 
@@ -455,7 +463,7 @@ void nmi_watchdog_tick (struct pt_regs *
 			 * - LVTPC is masked on interrupt and must be
 			 *   unmasked by the LVTPC handler.
 			 */
-			wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0, 0);
+			wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
 			apic_write(APIC_LVTPC, APIC_DM_NMI);
 		}
 		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);



