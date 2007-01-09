Return-Path: <linux-kernel-owner+w=401wt.eu-S932088AbXAITXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbXAITXX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbXAITXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:23:22 -0500
Received: from mga06.intel.com ([134.134.136.21]:14074 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932088AbXAITXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:23:21 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,164,1167638400"; 
   d="scan'208"; a="183212688:sNHT55253597"
Date: Tue, 9 Jan 2007 10:51:24 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] Handle 32 bit PerfMon Counter writes cleanly in i386 nmi_watchdog
Message-ID: <20070109105124.B20238@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Change i386 nmi handler to handle 32 bit perfmon counter MSR writes cleanly.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.20-rc-mm/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.20-rc-mm.orig/arch/i386/kernel/nmi.c
+++ linux-2.6.20-rc-mm/arch/i386/kernel/nmi.c
@@ -217,6 +217,28 @@ static __init void nmi_cpu_busy(void *da
 }
 #endif
 
+static unsigned int adjust_for_32bit_ctr(unsigned int hz)
+{
+	u64 counter_val;
+	unsigned int retval = hz;
+
+	/*
+	 * On Intel CPUs with P6/ARCH_PERFMON only 32 bits in the counter
+	 * are writable, with higher bits sign extending from bit 31.
+	 * So, we can only program the counter with 31 bit values and
+	 * 32nd bit should be 1, for 33.. to be 1.
+	 * Find the appropriate nmi_hz
+	 */
+	counter_val = (u64)cpu_khz * 1000;
+	do_div(counter_val, retval);
+ 	if (counter_val > 0x7fffffffULL) {
+		u64 count = (u64)cpu_khz * 1000;
+		do_div(count, 0x7fffffffUL);
+		retval = count + 1;
+	}
+	return retval;
+}
+
 static int __init check_nmi_watchdog(void)
 {
 	unsigned int *prev_nmi_count;
@@ -282,18 +304,10 @@ static int __init check_nmi_watchdog(voi
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
-			u64 count = (u64)cpu_khz * 1000;
-			do_div(count, 0x7fffffffUL);
-			nmi_hz = count + 1;
+
+		if (wd->perfctr_msr == MSR_P6_PERFCTR0 ||
+		    wd->perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0) {
+			nmi_hz = adjust_for_32bit_ctr(nmi_hz);
 		}
 	}
 
@@ -477,6 +491,17 @@ static void write_watchdog_counter(unsig
 	wrmsrl(perfctr_msr, 0 - count);
 }
 
+static void write_watchdog_counter32(unsigned int perfctr_msr,
+		const char *descr)
+{
+	u64 count = (u64)cpu_khz * 1000;
+
+	do_div(count, nmi_hz);
+	if(descr)
+		Dprintk("setting %s to -0x%08Lx\n", descr, count);
+	wrmsr(perfctr_msr, (u32)(-count), 0);
+}
+
 /* Note that these events don't tick when the CPU idles. This means
    the frequency varies with CPU load. */
 
@@ -566,7 +591,8 @@ static int setup_p6_watchdog(void)
 
 	/* setup the timer */
 	wrmsr(evntsel_msr, evntsel, 0);
-	write_watchdog_counter(perfctr_msr, "P6_PERFCTR0");
+	nmi_hz = adjust_for_32bit_ctr(nmi_hz);
+	write_watchdog_counter32(perfctr_msr, "P6_PERFCTR0");
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= P6_EVNTSEL0_ENABLE;
 	wrmsr(evntsel_msr, evntsel, 0);
@@ -739,7 +765,8 @@ static int setup_intel_arch_watchdog(voi
 
 	/* setup the timer */
 	wrmsr(evntsel_msr, evntsel, 0);
-	write_watchdog_counter(perfctr_msr, "INTEL_ARCH_PERFCTR0");
+	nmi_hz = adjust_for_32bit_ctr(nmi_hz);
+	write_watchdog_counter32(perfctr_msr, "INTEL_ARCH_PERFCTR0");
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= ARCH_PERFMON_EVENTSEL0_ENABLE;
 	wrmsr(evntsel_msr, evntsel, 0);
@@ -995,6 +1022,8 @@ __kprobes int nmi_watchdog_tick(struct p
 				dummy &= ~P4_CCCR_OVF;
 	 			wrmsrl(wd->cccr_msr, dummy);
 	 			apic_write(APIC_LVTPC, APIC_DM_NMI);
+				/* start the cycle over again */
+				write_watchdog_counter(wd->perfctr_msr, NULL);
 	 		}
 			else if (wd->perfctr_msr == MSR_P6_PERFCTR0 ||
 				 wd->perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0) {
@@ -1003,9 +1032,12 @@ __kprobes int nmi_watchdog_tick(struct p
 				 * other P6 variant.
 				 * ArchPerfom/Core Duo also needs this */
 				apic_write(APIC_LVTPC, APIC_DM_NMI);
+				/* P6/ARCH_PERFMON has 32 bit counter write */
+				write_watchdog_counter32(wd->perfctr_msr, NULL);
+			} else {
+				/* start the cycle over again */
+				write_watchdog_counter(wd->perfctr_msr, NULL);
 			}
-			/* start the cycle over again */
-			write_watchdog_counter(wd->perfctr_msr, NULL);
 			rc = 1;
 		} else if (nmi_watchdog == NMI_IO_APIC) {
 			/* don't know how to accurately check for this.
