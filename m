Return-Path: <linux-kernel-owner+w=401wt.eu-S1751203AbXAITUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbXAITUd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbXAITUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:20:33 -0500
Received: from mga05.intel.com ([192.55.52.89]:23836 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751203AbXAITUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:20:32 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,164,1167638400"; 
   d="scan'208"; a="186263927:sNHT28438550"
Date: Tue, 9 Jan 2007 10:50:16 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] Handle 32 bit PerfMon Counter writes cleanly in x86_64 nmi_watchdog
Message-ID: <20070109105016.A20238@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



P6 CPUs and Core/Core 2 CPUs which has 'architectural perf mon' feature,
only supports write of low 32 bits in Performance Monitoring Counters.
Bits 32..39 are sign extended based on bit 31 and bits 40..63 are reserved
and should be zero.

This patch:

Change x86_64 nmi handler to handle this case cleanly.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.20-rc-mm/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6.20-rc-mm.orig/arch/x86_64/kernel/nmi.c
+++ linux-2.6.20-rc-mm/arch/x86_64/kernel/nmi.c
@@ -214,6 +214,23 @@ static __init void nmi_cpu_busy(void *da
 }
 #endif
 
+static unsigned int adjust_for_32bit_ctr(unsigned int hz)
+{
+	unsigned int retval = hz;
+
+	/*
+	 * On Intel CPUs with ARCH_PERFMON only 32 bits in the counter
+	 * are writable, with higher bits sign extending from bit 31.
+	 * So, we can only program the counter with 31 bit values and
+	 * 32nd bit should be 1, for 33.. to be 1.
+	 * Find the appropriate nmi_hz
+	 */
+ 	if ((((u64)cpu_khz * 1000) / retval) > 0x7fffffffULL) {
+		retval = ((u64)cpu_khz * 1000) / 0x7fffffffUL + 1;
+	}
+	return retval;
+}
+
 int __init check_nmi_watchdog (void)
 {
 	int *counts;
@@ -268,17 +285,8 @@ int __init check_nmi_watchdog (void)
 		struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
 
 		nmi_hz = 1;
-		/*
-		 * On Intel CPUs with ARCH_PERFMON only 32 bits in the counter
-		 * are writable, with higher bits sign extending from bit 31.
-		 * So, we can only program the counter with 31 bit values and
-		 * 32nd bit should be 1, for 33.. to be 1.
-		 * Find the appropriate nmi_hz
-		 */
-	 	if (wd->perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0 &&
-			((u64)cpu_khz * 1000) > 0x7fffffffULL) {
-			nmi_hz = ((u64)cpu_khz * 1000) / 0x7fffffffUL + 1;
-		}
+	 	if (wd->perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0)
+			nmi_hz = adjust_for_32bit_ctr(nmi_hz);
 	}
 
 	kfree(counts);
@@ -663,7 +671,9 @@ static int setup_intel_arch_watchdog(voi
 
 	/* setup the timer */
 	wrmsr(evntsel_msr, evntsel, 0);
-	wrmsrl(perfctr_msr, -((u64)cpu_khz * 1000 / nmi_hz));
+
+	nmi_hz = adjust_for_32bit_ctr(nmi_hz);
+	wrmsr(perfctr_msr, (u32)(-((u64)cpu_khz * 1000 / nmi_hz)), 0);
 
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= ARCH_PERFMON_EVENTSEL0_ENABLE;
@@ -884,15 +894,23 @@ int __kprobes nmi_watchdog_tick(struct p
 				dummy &= ~P4_CCCR_OVF;
 	 			wrmsrl(wd->cccr_msr, dummy);
 	 			apic_write(APIC_LVTPC, APIC_DM_NMI);
+				/* start the cycle over again */
+				wrmsrl(wd->perfctr_msr,
+				       -((u64)cpu_khz * 1000 / nmi_hz));
 	 		} else if (wd->perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0) {
 				/*
 				 * ArchPerfom/Core Duo needs to re-unmask
 				 * the apic vector
 				 */
 				apic_write(APIC_LVTPC, APIC_DM_NMI);
+				/* ARCH_PERFMON has 32 bit counter writes */
+				wrmsr(wd->perfctr_msr,
+				     (u32)(-((u64)cpu_khz * 1000 / nmi_hz)), 0);
+			} else {
+				/* start the cycle over again */
+				wrmsrl(wd->perfctr_msr,
+				       -((u64)cpu_khz * 1000 / nmi_hz));
 			}
-			/* start the cycle over again */
-			wrmsrl(wd->perfctr_msr, -((u64)cpu_khz * 1000 / nmi_hz));
 			rc = 1;
 		} else 	if (nmi_watchdog == NMI_IO_APIC) {
 			/* don't know how to accurately check for this.
