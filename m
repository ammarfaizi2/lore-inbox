Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278928AbRKTMMD>; Tue, 20 Nov 2001 07:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281047AbRKTMLy>; Tue, 20 Nov 2001 07:11:54 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:53153 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S278928AbRKTMLi>;
	Tue, 20 Nov 2001 07:11:38 -0500
Date: Tue, 20 Nov 2001 13:11:36 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200111201211.NAA23317@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] Pentium 4 NMI watchdog support
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch adds NMI watchdog support for the Pentium 4,
driven by the performance counters and the local APIC similar
to how the watchdog works on the P6 and K7.
The patch also includes two minor cleanups to related code:
- replaced a number of for() loops to clear MSRs in nmi.c
  with calls to a new local procedure
- renamed MSR_IA32_PERFCTR0/PERFCTR1/EVNTSEL0/EVNTSEL1
  to MSR_P6_PERFCTR0/PERFCTR1/EVNTSEL0/EVNTSEL1 since these MSRs
  are completely P6-specific (include/asm-i386/msr.h)

/Mikael

--- linux-2.4.15-pre7-p4watchdog/arch/i386/kernel/nmi.c.~1~	Sun Sep 23 21:06:30 2001
+++ linux-2.4.15-pre7-p4watchdog/arch/i386/kernel/nmi.c	Tue Nov 20 12:11:04 2001
@@ -8,6 +8,7 @@
  *  Fixes:
  *  Mikael Pettersson	: AMD K7 support for local APIC NMI watchdog.
  *  Mikael Pettersson	: Power Management for local APIC NMI watchdog.
+ *  Mikael Pettersson	: Pentium 4 support for local APIC NMI watchdog.
  */
 
 #include <linux/config.h>
@@ -43,6 +44,32 @@
 #define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
 #define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED
 
+#define MSR_P4_MISC_ENABLE	0x1A0
+#define MSR_P4_MISC_ENABLE_PERF_AVAIL	(1<<7)
+#define MSR_P4_MISC_ENABLE_PEBS_UNAVAIL	(1<<12)
+#define MSR_P4_PERFCTR0		0x300
+#define MSR_P4_CCCR0		0x360
+#define P4_ESCR_EVENT_SELECT(N)	((N)<<25)
+#define P4_ESCR_OS		(1<<3)
+#define P4_ESCR_USR		(1<<2)
+#define P4_CCCR_OVF_PMI		(1<<26)
+#define P4_CCCR_THRESHOLD(N)	((N)<<20)
+#define P4_CCCR_COMPLEMENT	(1<<19)
+#define P4_CCCR_COMPARE		(1<<18)
+#define P4_CCCR_REQUIRED	(3<<16)
+#define P4_CCCR_ESCR_SELECT(N)	((N)<<13)
+#define P4_CCCR_ENABLE		(1<<12)
+/* Set up IQ_COUNTER0 to behave like a clock, by having IQ_CCCR0 filter
+   CRU_ESCR0 (with any non-null event selector) through a complemented
+   max threshold. [IA32-Vol3, Section 14.9.9] */
+#define MSR_P4_IQ_COUNTER0	0x30C
+#define MSR_P4_IQ_CCCR0		0x36C
+#define MSR_P4_CRU_ESCR0	0x3B8
+#define P4_NMI_CRU_ESCR0	(P4_ESCR_EVENT_SELECT(0x3F)|P4_ESCR_OS|P4_ESCR_USR)
+#define P4_NMI_IQ_CCCR0	\
+	(P4_CCCR_OVF_PMI|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
+	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
+
 int __init check_nmi_watchdog (void)
 {
 	irq_cpustat_t tmp[NR_CPUS];
@@ -84,11 +111,11 @@
 	/*
 	 * If any other x86 CPU has a local APIC, then
 	 * please test the NMI stuff there and send me the
-	 * missing bits. Right now Intel P6 and AMD K7 only.
+	 * missing bits. Right now Intel P6/P4 and AMD K7 only.
 	 */
 	if ((nmi == NMI_LOCAL_APIC) &&
 			(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
-			(boot_cpu_data.x86 == 6))
+			(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
 		nmi_watchdog = nmi;
 	if ((nmi == NMI_LOCAL_APIC) &&
 			(boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
@@ -118,7 +145,15 @@
 		wrmsr(MSR_K7_EVNTSEL0, 0, 0);
 		break;
 	case X86_VENDOR_INTEL:
-		wrmsr(MSR_IA32_EVNTSEL0, 0, 0);
+		switch (boot_cpu_data.x86) {
+		case 6:
+			wrmsr(MSR_P6_EVNTSEL0, 0, 0);
+			break;
+		case 15:
+			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
+			wrmsr(MSR_P4_CRU_ESCR0, 0, 0);
+			break;
+		}
 		break;
 	}
 }
@@ -157,17 +192,22 @@
  * Original code written by Keith Owens.
  */
 
+static void __pminit clear_msr_range(unsigned int base, unsigned int n)
+{
+	unsigned int i;
+
+	for(i = 0; i < n; ++i)
+		wrmsr(base+i, 0, 0);
+}
+
 static void __pminit setup_k7_watchdog(void)
 {
-	int i;
 	unsigned int evntsel;
 
 	nmi_perfctr_msr = MSR_K7_PERFCTR0;
 
-	for(i = 0; i < 4; ++i) {
-		wrmsr(MSR_K7_EVNTSEL0+i, 0, 0);
-		wrmsr(MSR_K7_PERFCTR0+i, 0, 0);
-	}
+	clear_msr_range(MSR_K7_EVNTSEL0, 4);
+	clear_msr_range(MSR_K7_PERFCTR0, 4);
 
 	evntsel = K7_EVNTSEL_INT
 		| K7_EVNTSEL_OS
@@ -184,27 +224,54 @@
 
 static void __pminit setup_p6_watchdog(void)
 {
-	int i;
 	unsigned int evntsel;
 
-	nmi_perfctr_msr = MSR_IA32_PERFCTR0;
+	nmi_perfctr_msr = MSR_P6_PERFCTR0;
 
-	for(i = 0; i < 2; ++i) {
-		wrmsr(MSR_IA32_EVNTSEL0+i, 0, 0);
-		wrmsr(MSR_IA32_PERFCTR0+i, 0, 0);
-	}
+	clear_msr_range(MSR_P6_EVNTSEL0, 2);
+	clear_msr_range(MSR_P6_PERFCTR0, 2);
 
 	evntsel = P6_EVNTSEL_INT
 		| P6_EVNTSEL_OS
 		| P6_EVNTSEL_USR
 		| P6_NMI_EVENT;
 
-	wrmsr(MSR_IA32_EVNTSEL0, evntsel, 0);
-	Dprintk("setting IA32_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_IA32_PERFCTR0, -(cpu_khz/nmi_hz*1000), 0);
+	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
+	Dprintk("setting P6_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
+	wrmsr(MSR_P6_PERFCTR0, -(cpu_khz/nmi_hz*1000), 0);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= P6_EVNTSEL0_ENABLE;
-	wrmsr(MSR_IA32_EVNTSEL0, evntsel, 0);
+	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
+}
+
+static int __pminit setup_p4_watchdog(void)
+{
+	unsigned int misc_enable, dummy;
+
+	rdmsr(MSR_P4_MISC_ENABLE, misc_enable, dummy);
+	if (!(misc_enable & MSR_P4_MISC_ENABLE_PERF_AVAIL))
+		return 0;
+
+	nmi_perfctr_msr = MSR_P4_IQ_COUNTER0;
+
+	if (!(misc_enable & MSR_P4_MISC_ENABLE_PEBS_UNAVAIL))
+		clear_msr_range(0x3F1, 2);
+	/* MSR 0x3F0 seems to have a default value of 0xFC00, but current
+	   docs doesn't fully define it, so leave it alone for now. */
+	clear_msr_range(0x3A0, 31);
+	clear_msr_range(0x3C0, 6);
+	clear_msr_range(0x3C8, 6);
+	clear_msr_range(0x3E0, 2);
+	clear_msr_range(MSR_P4_CCCR0, 18);
+	clear_msr_range(MSR_P4_PERFCTR0, 18);
+
+	wrmsr(MSR_P4_CRU_ESCR0, P4_NMI_CRU_ESCR0, 0);
+	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0 & ~P4_CCCR_ENABLE, 0);
+	Dprintk("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/nmi_hz*1000));
+	wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0, 0);
+	return 1;
 }
 
 void __pminit setup_apic_nmi_watchdog (void)
@@ -216,9 +283,17 @@
 		setup_k7_watchdog();
 		break;
 	case X86_VENDOR_INTEL:
-		if (boot_cpu_data.x86 != 6)
+		switch (boot_cpu_data.x86) {
+		case 6:
+			setup_p6_watchdog();
+			break;
+		case 15:
+			if (!setup_p4_watchdog())
+				return;
+			break;
+		default:
 			return;
-		setup_p6_watchdog();
+		}
 		break;
 	default:
 		return;
@@ -295,6 +370,18 @@
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;
 	}
-	if (nmi_perfctr_msr)
+	if (nmi_perfctr_msr) {
+		if (nmi_perfctr_msr == MSR_P4_IQ_COUNTER0) {
+			/*
+			 * P4 quirks:
+			 * - An overflown perfctr will assert its interrupt
+			 *   until the OVF flag in its CCCR is cleared.
+			 * - LVTPC is masked on interrupt and must be
+			 *   unmasked by the LVTPC handler.
+			 */
+			wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0, 0);
+			apic_write(APIC_LVTPC, APIC_DM_NMI);
+		}
 		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
+	}
 }
--- linux-2.4.15-pre7-p4watchdog/include/asm-i386/msr.h.~1~	Sun Sep 23 21:06:37 2001
+++ linux-2.4.15-pre7-p4watchdog/include/asm-i386/msr.h	Tue Nov 20 12:04:39 2001
@@ -48,18 +48,12 @@
 #define MSR_IA32_UCODE_WRITE		0x79
 #define MSR_IA32_UCODE_REV		0x8b
 
-#define MSR_IA32_PERFCTR0		0xc1
-#define MSR_IA32_PERFCTR1		0xc2
-
 #define MSR_IA32_BBL_CR_CTL		0x119
 
 #define MSR_IA32_MCG_CAP		0x179
 #define MSR_IA32_MCG_STATUS		0x17a
 #define MSR_IA32_MCG_CTL		0x17b
 
-#define MSR_IA32_EVNTSEL0		0x186
-#define MSR_IA32_EVNTSEL1		0x187
-
 #define MSR_IA32_DEBUGCTLMSR		0x1d9
 #define MSR_IA32_LASTBRANCHFROMIP	0x1db
 #define MSR_IA32_LASTBRANCHTOIP		0x1dc
@@ -71,6 +65,11 @@
 #define MSR_IA32_MC0_ADDR		0x402
 #define MSR_IA32_MC0_MISC		0x403
 
+#define MSR_P6_PERFCTR0			0xc1
+#define MSR_P6_PERFCTR1			0xc2
+#define MSR_P6_EVNTSEL0			0x186
+#define MSR_P6_EVNTSEL1			0x187
+
 /* AMD Defined MSRs */
 #define MSR_K6_EFER			0xC0000080
 #define MSR_K6_STAR			0xC0000081
