Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130491AbRBAT3L>; Thu, 1 Feb 2001 14:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130535AbRBAT3A>; Thu, 1 Feb 2001 14:29:00 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:60564 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S130491AbRBAT2t>;
	Thu, 1 Feb 2001 14:28:49 -0500
Date: Thu, 1 Feb 2001 20:28:27 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200102011928.UAA03188@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4.1-ac1 UP-APIC/NMI watchdog fixes
Cc: linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl, mingo@elte.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (against 2.4.1-ac1) contains the following fixes:
* UP-APIC linkage fix: nr_ioapics must be moved from io_apic.c to
  mpparse.c to permit linking the kernel in pure UP-APIC configs.
* NMI watchdog cleanups: mark setup_apic_nmi_watchdog() as __init,
  fix the K7 init code to not leave any perfctr MSR uninitialised,
  avoid having to check CPU type in NMI handler.
  (Yes, the merged wrmsr(,,-1) is safe for P6.)

Alan, please include this in -ac2.

/Mikael

--- linux-2.4.1-ac1/arch/i386/kernel/io_apic.c.~1~	Thu Feb  1 15:33:35 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/io_apic.c	Thu Feb  1 16:16:11 2001
@@ -38,7 +38,6 @@
 /*
  * # of IRQ routing registers
  */
-int nr_ioapics;
 int nr_ioapic_registers[MAX_IO_APICS];
 
 #if CONFIG_SMP
--- linux-2.4.1-ac1/arch/i386/kernel/mpparse.c.~1~	Thu Feb  1 15:33:35 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/mpparse.c	Thu Feb  1 16:15:41 2001
@@ -48,6 +48,8 @@
 /* MP IRQ source entries */
 int mp_irq_entries;
 
+int nr_ioapics;
+
 int pic_mode;
 unsigned long mp_lapic_addr;
 
--- linux-2.4.1-ac1/arch/i386/kernel/nmi.c.~1~	Thu Feb  1 15:33:35 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/nmi.c	Thu Feb  1 18:07:34 2001
@@ -82,25 +82,35 @@
 /*
  * Activate the NMI watchdog via the local APIC.
  * Original code written by Keith Owens.
+ * AMD K7 code by Mikael Pettersson.
  */
 
+static unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 #define MSR_K7_EVNTSEL0 0xC0010000
 #define MSR_K7_PERFCTR0 0xC0010004
+/* Event 0x76 isn't listed in recent revisions of AMD #22007, and it
+   slows down (but doesn't halt) when the CPU is idle. Unfortunately
+   the K7 doesn't appear to have any other clock-like perfctr event. */
+#define K7_NMI_EVENT	0x76	/* CYCLES_PROCESSOR_IS_RUNNING */
+#define K7_NMI_EVNTSEL	((1<<20)|(3<<16)|K7_NMI_EVENT)	/* INT,OS,USR,<event> */
 
-void setup_apic_nmi_watchdog (void)
+void __init setup_apic_nmi_watchdog (void)
 {
 	int value;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
 	    boot_cpu_data.x86 == 6) {
-		unsigned evntsel = (1<<20)|(3<<16);	/* INT, OS, USR */
-#if 1	/* listed in old docs */
-		evntsel |= 0x76;	/* CYCLES_PROCESSOR_IS_RUNNING */
-#else	/* try this if the above doesn't work */
-		evntsel |= 0xC0;	/* RETIRED_INSTRUCTIONS */
-#endif
-		wrmsr(MSR_K7_EVNTSEL0, 0, 0);
-		wrmsr(MSR_K7_PERFCTR0, 0, 0);
+		unsigned i;
+		unsigned evntsel;
+
+		nmi_perfctr_msr = MSR_K7_PERFCTR0;
+
+		for(i = 0; i < 4; ++i) {
+			wrmsr(MSR_K7_EVNTSEL0+i, 0, 0);
+			wrmsr(MSR_K7_PERFCTR0+i, 0, 0);
+		}
+
+		evntsel = K7_NMI_EVNTSEL;
 		wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
 		printk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/HZ*1000));
 		wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/HZ*1000), -1);
@@ -112,6 +122,8 @@
 		return;
 	}
 
+	nmi_perfctr_msr = MSR_IA32_PERFCTR1;
+
 	/* clear performance counters 0, 1 */
 
 	wrmsr(MSR_IA32_EVNTSEL0, 0, 0);
@@ -190,14 +202,6 @@
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;
 	}
-	if (cpu_has_apic && (nmi_watchdog == NMI_LOCAL_APIC)) {
-		/* XXX: nmi_watchdog should carry this info */
-		unsigned msr;
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-			wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/HZ*1000), -1);
-		} else {
-			wrmsr(MSR_IA32_PERFCTR1, -(cpu_khz/HZ*1000), 0);
-		}
-	}
+	if (cpu_has_apic && (nmi_watchdog == NMI_LOCAL_APIC))
+		wrmsr(nmi_perfctr_msr, -(cpu_khz/HZ*1000), -1);
 }
-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
