Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131221AbRAMS3K>; Sat, 13 Jan 2001 13:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131029AbRAMS3C>; Sat, 13 Jan 2001 13:29:02 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131162AbRAMSZg>;
	Sat, 13 Jan 2001 13:25:36 -0500
Date: Sat, 13 Jan 2001 16:16:59 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101131516.QAA24636@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] enable K7 nmi watchdog
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (against 2.4.0-ac8) _may_ enable the NMI watchdog on
some K7 systems. It won't help if you have an old K7 without a
local APIC, or if your BIOS disables it.

This is a quick hack to test the mechanism -- I'll submit a
cleaner patch later if this one works.

If you try this, please cc: me the result (positive or negative)
and a copy of the kernel's boot log.

/Mikael

--- linux-2.4.0-ac8/arch/i386/kernel/nmi.c.~1~	Sat Jan 13 14:57:09 2001
+++ linux-2.4.0-ac8/arch/i386/kernel/nmi.c	Sat Jan 13 16:00:27 2001
@@ -64,6 +64,10 @@
 			(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
 			(boot_cpu_data.x86 == 6))
 		nmi_watchdog = nmi;
+	if ((nmi == NMI_LOCAL_APIC) &&
+			(boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
+			(boot_cpu_data.x86 == 6))
+		nmi_watchdog = nmi;
 	/*
 	 * We can enable the IO-APIC watchdog
 	 * unconditionally.
@@ -80,10 +84,34 @@
  * Original code written by Keith Owens.
  */
 
+#define MSR_K7_EVNTSEL0 0xC001000
+#define MSR_K7_PERFCTR0 0xC001004
+
 void setup_apic_nmi_watchdog (void)
 {
 	int value;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	    boot_cpu_data.x86 == 6) {
+		unsigned evntsel = (1<<20)|(3<<16);	/* INT, OS, USR */
+#if 1	/* listed in old docs */
+		evntsel |= 0x76;	/* CYCLES_PROCESSOR_IS_RUNNING */
+#else	/* try this if the above doesn't work */
+		evntsel |= 0xC0;	/* RETIRED_INSTRUCTIONS */
+#endif
+		wrmsr(MSR_K7_EVNTSEL0, 0, 0);
+		wrmsr(MSR_K7_PERFCTR0, 0, 0);
+		wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
+		printk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/HZ*1000));
+		wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/HZ*1000), 0);
+		printk("setting K7 LVTPC to DM_NMI\n");
+		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		evntsel |= (1<<22);	/* ENable */
+		printk("setting K7_EVNTSEL0 to %08x\n", evntsel);
+		wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
+		return;
+	}
+
 	/* clear performance counters 0, 1 */
 
 	wrmsr(MSR_IA32_EVNTSEL0, 0, 0);
@@ -162,7 +190,14 @@
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;
 	}
-	if (cpu_has_apic && (nmi_watchdog == NMI_LOCAL_APIC))
-		wrmsr(MSR_IA32_PERFCTR1, -(cpu_khz/HZ*1000), 0);
+	if (cpu_has_apic && (nmi_watchdog == NMI_LOCAL_APIC)) {
+		/* XXX: nmi_watchdog should carry this info */
+		unsigned msr;
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+			msr = MSR_K7_PERFCTR0;
+		else
+			msr = MSR_IA32_PERFCTR1;
+		wrmsr(msr, -(cpu_khz/HZ*1000), 0);
+	}
 }
 
--- linux-2.4.0-ac8/arch/i386/kernel/setup.c.~1~	Sat Jan 13 14:57:09 2001
+++ linux-2.4.0-ac8/arch/i386/kernel/setup.c	Sat Jan 13 14:57:48 2001
@@ -1926,14 +1926,6 @@
 			c->x86 = 4;
 		}
 
-		/*
-		 * Athlons have an APIC, but the APIC-programming
-		 * MSRs are in different places. If you want NMI-watchdog
-		 * on Athlons, please fix setup_apic_nmi_watchdog().
-		 */
-		if (c->x86_vendor == X86_VENDOR_AMD)
-			clear_bit(X86_FEATURE_APIC, &c->x86_capability);
-
 		/* AMD-defined flags: level 0x80000001 */
 		xlvl = cpuid_eax(0x80000000);
 		if ( (xlvl & 0xffff0000) == 0x80000000 ) {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
