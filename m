Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWEIU6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWEIU6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWEIU5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:57:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13277 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750756AbWEIU5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:57:13 -0400
From: dzickus <dzickus@redhat.com>
Message-Id: <20060509205956.494947000@drseuss.boston.redhat.com>
References: <20060509205035.446349000@drseuss.boston.redhat.com>
User-Agent: quilt/0.45-1
Date: Tue, 09 May 2006 16:50:37 -0400
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, oprofile-list@lists.sourceforge.net, dzickus@redhat.com
Subject: [patch 2/8] Add performance counter reservation framework for UP kernels
Content-Disposition: inline; filename=nmi-x86-reservation-UP.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds basic infrastructure to allow subsystems to reserve performance
counters on the x86 chips.  Only UP kernels are supported in this patch to
make reviewing easier.  The SMP portion makes a lot more changes. 

Think of this as a locking mechanism where each bit represents a different
counter.  In addition, each subsystem should also reserve an appropriate
event selection register that will correspond to the performance counter it
will be using (this is mainly neccessary for the Pentium 4 chips as they
break the 1:1 relationship to performance counters). 

This will help prevent subsystems like oprofile from interfering with the
nmi watchdog. 

Signed-off-by:  Don Zickus <dzickus@redhat.com>

Index: linux-don/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-don.orig/arch/x86_64/kernel/nmi.c
+++ linux-don/arch/x86_64/kernel/nmi.c
@@ -28,6 +28,20 @@
 #include <asm/kdebug.h>
 #include <asm/mce.h>
 
+/* perfctr_nmi_owner tracks the ownership of the perfctr registers:
+ * evtsel_nmi_owner tracks the ownership of the event selection
+ * - different performance counters/ event selection may be reserved for
+ *   different subsystems this reservation system just tries to coordinate
+ *   things a little
+ */
+static DEFINE_PER_CPU(unsigned, perfctr_nmi_owner);
+static DEFINE_PER_CPU(unsigned, evntsel_nmi_owner[2]);
+
+/* this number is calculated from Intel's MSR_P4_CRU_ESCR5 register and it's
+ * offset from MSR_P4_BSU_ESCR0.  It will be the max for all platforms (for now)
+ */
+#define NMI_MAX_COUNTER_BITS 66
+
 /*
  * lapic_nmi_owner tracks the ownership of the lapic NMI hardware:
  * - it may be reserved by some other driver, or not
@@ -91,6 +105,95 @@ static unsigned int nmi_p4_cccr_val;
 	(P4_CCCR_OVF_PMI0|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
 	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
 
+/* converts an msr to an appropriate reservation bit */
+static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
+{
+	/* returns the bit offset of the performance counter register */
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		return (msr - MSR_K7_PERFCTR0);
+	case X86_VENDOR_INTEL:
+		return (msr - MSR_P4_BPU_PERFCTR0);
+	}
+	return 0;
+}
+
+/* converts an msr to an appropriate reservation bit */
+static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
+{
+	/* returns the bit offset of the event selection register */
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		return (msr - MSR_K7_EVNTSEL0);
+	case X86_VENDOR_INTEL:
+		return (msr - MSR_P4_BSU_ESCR0);
+	}
+	return 0;
+}
+
+/* checks for a bit availability (hack for oprofile) */
+int avail_to_resrv_perfctr_nmi_bit(unsigned int counter)
+{
+	BUG_ON(counter > NMI_MAX_COUNTER_BITS);
+
+	return (!test_bit(counter, &__get_cpu_var(perfctr_nmi_owner)));
+}
+
+/* checks the an msr for availability */
+int avail_to_resrv_perfctr_nmi(unsigned int msr)
+{
+	unsigned int counter;
+
+	counter = nmi_perfctr_msr_to_bit(msr);
+	BUG_ON(counter > NMI_MAX_COUNTER_BITS);
+
+	return (!test_bit(counter, &__get_cpu_var(perfctr_nmi_owner)));
+}
+
+int reserve_perfctr_nmi(unsigned int msr)
+{
+	unsigned int counter;
+
+	counter = nmi_perfctr_msr_to_bit(msr);
+	BUG_ON(counter > NMI_MAX_COUNTER_BITS);
+
+	if (!test_and_set_bit(counter, &__get_cpu_var(perfctr_nmi_owner)))
+		return 1;
+	return 0;
+}
+
+void release_perfctr_nmi(unsigned int msr)
+{
+	unsigned int counter;
+
+	counter = nmi_perfctr_msr_to_bit(msr);
+	BUG_ON(counter > NMI_MAX_COUNTER_BITS);
+
+	clear_bit(counter, &__get_cpu_var(perfctr_nmi_owner));
+}
+
+int reserve_evntsel_nmi(unsigned int msr)
+{
+	unsigned int counter;
+
+	counter = nmi_evntsel_msr_to_bit(msr);
+	BUG_ON(counter > NMI_MAX_COUNTER_BITS);
+
+	if (!test_and_set_bit(counter, &__get_cpu_var(evntsel_nmi_owner)))
+		return 1;
+	return 0;
+}
+
+void release_evntsel_nmi(unsigned int msr)
+{
+	unsigned int counter;
+
+	counter = nmi_evntsel_msr_to_bit(msr);
+	BUG_ON(counter > NMI_MAX_COUNTER_BITS);
+
+	clear_bit(counter, &__get_cpu_var(evntsel_nmi_owner));
+}
+
 static __cpuinit inline int nmi_known_cpu(void)
 {
 	switch (boot_cpu_data.x86_vendor) {
@@ -326,34 +429,22 @@ late_initcall(init_lapic_nmi_sysfs);
 
 #endif	/* CONFIG_PM */
 
-/*
- * Activate the NMI watchdog via the local APIC.
- * Original code written by Keith Owens.
- */
-
-static void clear_msr_range(unsigned int base, unsigned int n)
+static int setup_k7_watchdog(void)
 {
-	unsigned int i;
-
-	for(i = 0; i < n; ++i)
-		wrmsr(base+i, 0, 0);
-}
-
-static void setup_k7_watchdog(void)
-{
-	int i;
 	unsigned int evntsel;
 
 	nmi_perfctr_msr = MSR_K7_PERFCTR0;
 
-	for(i = 0; i < 4; ++i) {
-		/* Simulator may not support it */
-		if (checking_wrmsrl(MSR_K7_EVNTSEL0+i, 0UL)) {
-			nmi_perfctr_msr = 0;
-			return;
-		}
-		wrmsrl(MSR_K7_PERFCTR0+i, 0UL);
-	}
+	if (!reserve_perfctr_nmi(nmi_perfctr_msr))
+		goto fail;
+
+	if (!reserve_evntsel_nmi(MSR_K7_EVNTSEL0))
+		goto fail1;
+
+	/* Simulator may not support it */
+	if (checking_wrmsrl(MSR_K7_EVNTSEL0, 0UL))
+		goto fail2;
+	wrmsrl(MSR_K7_PERFCTR0, 0UL);
 
 	evntsel = K7_EVNTSEL_INT
 		| K7_EVNTSEL_OS
@@ -365,6 +456,13 @@ static void setup_k7_watchdog(void)
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= K7_EVNTSEL_ENABLE;
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
+	return 1;
+fail2:
+	release_evntsel_nmi(MSR_K7_EVNTSEL0);
+fail1:
+	release_perfctr_nmi(nmi_perfctr_msr);
+fail:
+	return 0;
 }
 
 
@@ -383,22 +481,11 @@ static int setup_p4_watchdog(void)
 		nmi_p4_cccr_val |= P4_CCCR_OVF_PMI1;
 #endif
 
-	if (!(misc_enable & MSR_P4_MISC_ENABLE_PEBS_UNAVAIL))
-		clear_msr_range(0x3F1, 2);
-	/* MSR 0x3F0 seems to have a default value of 0xFC00, but current
-	   docs doesn't fully define it, so leave it alone for now. */
-	if (boot_cpu_data.x86_model >= 0x3) {
-		/* MSR_P4_IQ_ESCR0/1 (0x3ba/0x3bb) removed */
-		clear_msr_range(0x3A0, 26);
-		clear_msr_range(0x3BC, 3);
-	} else {
-		clear_msr_range(0x3A0, 31);
-	}
-	clear_msr_range(0x3C0, 6);
-	clear_msr_range(0x3C8, 6);
-	clear_msr_range(0x3E0, 2);
-	clear_msr_range(MSR_P4_CCCR0, 18);
-	clear_msr_range(MSR_P4_PERFCTR0, 18);
+	if (!reserve_perfctr_nmi(nmi_perfctr_msr))
+		goto fail;
+
+	if (!reserve_evntsel_nmi(MSR_P4_CRU_ESCR0))
+		goto fail1;
 
 	wrmsr(MSR_P4_CRU_ESCR0, P4_NMI_CRU_ESCR0, 0);
 	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0 & ~P4_CCCR_ENABLE, 0);
@@ -407,6 +494,10 @@ static int setup_p4_watchdog(void)
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
 	return 1;
+fail1:
+	release_perfctr_nmi(nmi_perfctr_msr);
+fail:
+	return 0;
 }
 
 void setup_apic_nmi_watchdog(void)
@@ -417,7 +508,8 @@ void setup_apic_nmi_watchdog(void)
 			return;
 		if (strstr(boot_cpu_data.x86_model_id, "Screwdriver"))
 			return;
-		setup_k7_watchdog();
+		if (!setup_k7_watchdog())
+			return;
 		break;
 	case X86_VENDOR_INTEL:
 		if (boot_cpu_data.x86 != 15)
@@ -587,6 +679,12 @@ int proc_unknown_nmi_panic(struct ctl_ta
 
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
+EXPORT_SYMBOL(avail_to_resrv_perfctr_nmi);
+EXPORT_SYMBOL(avail_to_resrv_perfctr_nmi_bit);
+EXPORT_SYMBOL(reserve_perfctr_nmi);
+EXPORT_SYMBOL(release_perfctr_nmi);
+EXPORT_SYMBOL(reserve_evntsel_nmi);
+EXPORT_SYMBOL(release_evntsel_nmi);
 EXPORT_SYMBOL(reserve_lapic_nmi);
 EXPORT_SYMBOL(release_lapic_nmi);
 EXPORT_SYMBOL(disable_timer_nmi_watchdog);
Index: linux-don/include/asm-x86_64/nmi.h
===================================================================
--- linux-don.orig/include/asm-x86_64/nmi.h
+++ linux-don/include/asm-x86_64/nmi.h
@@ -56,7 +56,13 @@ extern int panic_on_timeout;
 extern int unknown_nmi_panic;
 
 extern int check_nmi_watchdog(void);
- 
+extern int avail_to_resrv_perfctr_nmi_bit(unsigned int);
+extern int avail_to_resrv_perfctr_nmi(unsigned int);
+extern int reserve_perfctr_nmi(unsigned int);
+extern void release_perfctr_nmi(unsigned int);
+extern int reserve_evntsel_nmi(unsigned int);
+extern void release_evntsel_nmi(unsigned int);
+
 extern void setup_apic_nmi_watchdog (void);
 extern int reserve_lapic_nmi(void);
 extern void release_lapic_nmi(void);
Index: linux-don/arch/i386/kernel/nmi.c
===================================================================
--- linux-don.orig/arch/i386/kernel/nmi.c
+++ linux-don/arch/i386/kernel/nmi.c
@@ -34,6 +34,20 @@ static unsigned int nmi_perfctr_msr;	/* 
 static unsigned int nmi_p4_cccr_val;
 extern void show_registers(struct pt_regs *regs);
 
+/* perfctr_nmi_owner tracks the ownership of the perfctr registers:
+ * evtsel_nmi_owner tracks the ownership of the event selection
+ * - different performance counters/ event selection may be reserved for
+ *   different subsystems this reservation system just tries to coordinate
+ *   things a little
+ */
+static DEFINE_PER_CPU(unsigned long, perfctr_nmi_owner);
+static DEFINE_PER_CPU(unsigned long, evntsel_nmi_owner[3]);
+
+/* this number is calculated from Intel's MSR_P4_CRU_ESCR5 register and it's
+ * offset from MSR_P4_BSU_ESCR0.  It will be the max for all platforms (for now)
+ */
+#define NMI_MAX_COUNTER_BITS 66
+
 /*
  * lapic_nmi_owner tracks the ownership of the lapic NMI hardware:
  * - it may be reserved by some other driver, or not
@@ -95,6 +109,105 @@ int nmi_active;
 	(P4_CCCR_OVF_PMI0|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
 	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
 
+/* converts an msr to an appropriate reservation bit */
+static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
+{
+	/* returns the bit offset of the performance counter register */
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		return (msr - MSR_K7_PERFCTR0);
+	case X86_VENDOR_INTEL:
+		switch (boot_cpu_data.x86) {
+		case 6:
+			return (msr - MSR_P6_PERFCTR0);
+		case 15:
+			return (msr - MSR_P4_BPU_PERFCTR0);
+		}
+	}
+	return 0;
+}
+
+/* converts an msr to an appropriate reservation bit */
+static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
+{
+	/* returns the bit offset of the event selection register */
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		return (msr - MSR_K7_EVNTSEL0);
+	case X86_VENDOR_INTEL:
+		switch (boot_cpu_data.x86) {
+		case 6:
+			return (msr - MSR_P6_EVNTSEL0);
+		case 15:
+			return (msr - MSR_P4_BSU_ESCR0);
+		}
+	}
+	return 0;
+}
+
+/* checks for a bit availability (hack for oprofile) */
+int avail_to_resrv_perfctr_nmi_bit(unsigned int counter)
+{
+	BUG_ON(counter > NMI_MAX_COUNTER_BITS);
+
+	return (!test_bit(counter, &__get_cpu_var(perfctr_nmi_owner)));
+}
+
+/* checks the an msr for availability */
+int avail_to_resrv_perfctr_nmi(unsigned int msr)
+{
+	unsigned int counter;
+
+	counter = nmi_perfctr_msr_to_bit(msr);
+	BUG_ON(counter > NMI_MAX_COUNTER_BITS);
+
+	return (!test_bit(counter, &__get_cpu_var(perfctr_nmi_owner)));
+}
+
+int reserve_perfctr_nmi(unsigned int msr)
+{
+	unsigned int counter;
+
+	counter = nmi_perfctr_msr_to_bit(msr);
+	BUG_ON(counter > NMI_MAX_COUNTER_BITS);
+
+	if (!test_and_set_bit(counter, &__get_cpu_var(perfctr_nmi_owner)))
+		return 1;
+	return 0;
+}
+
+void release_perfctr_nmi(unsigned int msr)
+{
+	unsigned int counter;
+
+	counter = nmi_perfctr_msr_to_bit(msr);
+	BUG_ON(counter > NMI_MAX_COUNTER_BITS);
+
+	clear_bit(counter, &__get_cpu_var(perfctr_nmi_owner));
+}
+
+int reserve_evntsel_nmi(unsigned int msr)
+{
+	unsigned int counter;
+
+	counter = nmi_evntsel_msr_to_bit(msr);
+	BUG_ON(counter > NMI_MAX_COUNTER_BITS);
+
+	if (!test_and_set_bit(counter, &__get_cpu_var(evntsel_nmi_owner[0])))
+		return 1;
+	return 0;
+}
+
+void release_evntsel_nmi(unsigned int msr)
+{
+	unsigned int counter;
+
+	counter = nmi_evntsel_msr_to_bit(msr);
+	BUG_ON(counter > NMI_MAX_COUNTER_BITS);
+
+	clear_bit(counter, &__get_cpu_var(evntsel_nmi_owner[0]));
+}
+
 #ifdef CONFIG_SMP
 /* The performance counters used by NMI_LOCAL_APIC don't trigger when
  * the CPU is idle. To make sure the NMI watchdog really ticks on all
@@ -344,14 +457,6 @@ late_initcall(init_lapic_nmi_sysfs);
  * Original code written by Keith Owens.
  */
 
-static void clear_msr_range(unsigned int base, unsigned int n)
-{
-	unsigned int i;
-
-	for(i = 0; i < n; ++i)
-		wrmsr(base+i, 0, 0);
-}
-
 static void write_watchdog_counter(const char *descr)
 {
 	u64 count = (u64)cpu_khz * 1000;
@@ -362,14 +467,19 @@ static void write_watchdog_counter(const
 	wrmsrl(nmi_perfctr_msr, 0 - count);
 }
 
-static void setup_k7_watchdog(void)
+static int setup_k7_watchdog(void)
 {
 	unsigned int evntsel;
 
 	nmi_perfctr_msr = MSR_K7_PERFCTR0;
 
-	clear_msr_range(MSR_K7_EVNTSEL0, 4);
-	clear_msr_range(MSR_K7_PERFCTR0, 4);
+	if (!reserve_perfctr_nmi(nmi_perfctr_msr))
+		goto fail;
+
+	if (!reserve_evntsel_nmi(MSR_K7_EVNTSEL0))
+		goto fail1;
+
+	wrmsrl(MSR_K7_PERFCTR0, 0UL);
 
 	evntsel = K7_EVNTSEL_INT
 		| K7_EVNTSEL_OS
@@ -381,16 +491,24 @@ static void setup_k7_watchdog(void)
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= K7_EVNTSEL_ENABLE;
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
+	return 1;
+fail1:
+	release_perfctr_nmi(nmi_perfctr_msr);
+fail:
+	return 0;
 }
 
-static void setup_p6_watchdog(void)
+static int setup_p6_watchdog(void)
 {
 	unsigned int evntsel;
 
 	nmi_perfctr_msr = MSR_P6_PERFCTR0;
 
-	clear_msr_range(MSR_P6_EVNTSEL0, 2);
-	clear_msr_range(MSR_P6_PERFCTR0, 2);
+	if (!reserve_perfctr_nmi(nmi_perfctr_msr))
+		goto fail;
+
+	if (!reserve_evntsel_nmi(MSR_P6_EVNTSEL0))
+		goto fail1;
 
 	evntsel = P6_EVNTSEL_INT
 		| P6_EVNTSEL_OS
@@ -402,6 +520,11 @@ static void setup_p6_watchdog(void)
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= P6_EVNTSEL0_ENABLE;
 	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
+	return 1;
+fail1:
+	release_perfctr_nmi(nmi_perfctr_msr);
+fail:
+	return 0;
 }
 
 static int setup_p4_watchdog(void)
@@ -419,22 +542,11 @@ static int setup_p4_watchdog(void)
 		nmi_p4_cccr_val |= P4_CCCR_OVF_PMI1;
 #endif
 
-	if (!(misc_enable & MSR_P4_MISC_ENABLE_PEBS_UNAVAIL))
-		clear_msr_range(0x3F1, 2);
-	/* MSR 0x3F0 seems to have a default value of 0xFC00, but current
-	   docs doesn't fully define it, so leave it alone for now. */
-	if (boot_cpu_data.x86_model >= 0x3) {
-		/* MSR_P4_IQ_ESCR0/1 (0x3ba/0x3bb) removed */
-		clear_msr_range(0x3A0, 26);
-		clear_msr_range(0x3BC, 3);
-	} else {
-		clear_msr_range(0x3A0, 31);
-	}
-	clear_msr_range(0x3C0, 6);
-	clear_msr_range(0x3C8, 6);
-	clear_msr_range(0x3E0, 2);
-	clear_msr_range(MSR_P4_CCCR0, 18);
-	clear_msr_range(MSR_P4_PERFCTR0, 18);
+	if (!reserve_perfctr_nmi(nmi_perfctr_msr))
+		goto fail;
+
+	if (!reserve_evntsel_nmi(MSR_P4_CRU_ESCR0))
+		goto fail1;
 
 	wrmsr(MSR_P4_CRU_ESCR0, P4_NMI_CRU_ESCR0, 0);
 	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0 & ~P4_CCCR_ENABLE, 0);
@@ -442,6 +554,10 @@ static int setup_p4_watchdog(void)
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
 	return 1;
+fail1:
+	release_perfctr_nmi(nmi_perfctr_msr);
+fail:
+	return 0;
 }
 
 void setup_apic_nmi_watchdog (void)
@@ -450,7 +566,8 @@ void setup_apic_nmi_watchdog (void)
 	case X86_VENDOR_AMD:
 		if (boot_cpu_data.x86 != 6 && boot_cpu_data.x86 != 15)
 			return;
-		setup_k7_watchdog();
+		if (!setup_k7_watchdog())
+			return;
 		break;
 	case X86_VENDOR_INTEL:
 		switch (boot_cpu_data.x86) {
@@ -458,7 +575,8 @@ void setup_apic_nmi_watchdog (void)
 			if (boot_cpu_data.x86_model > 0xd)
 				return;
 
-			setup_p6_watchdog();
+			if(!setup_p6_watchdog())
+				return;
 			break;
 		case 15:
 			if (boot_cpu_data.x86_model > 0x4)
@@ -611,6 +729,12 @@ int proc_unknown_nmi_panic(ctl_table *ta
 
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
+EXPORT_SYMBOL(avail_to_resrv_perfctr_nmi);
+EXPORT_SYMBOL(avail_to_resrv_perfctr_nmi_bit);
+EXPORT_SYMBOL(reserve_perfctr_nmi);
+EXPORT_SYMBOL(release_perfctr_nmi);
+EXPORT_SYMBOL(reserve_evntsel_nmi);
+EXPORT_SYMBOL(release_evntsel_nmi);
 EXPORT_SYMBOL(reserve_lapic_nmi);
 EXPORT_SYMBOL(release_lapic_nmi);
 EXPORT_SYMBOL(disable_timer_nmi_watchdog);
Index: linux-don/include/asm-i386/nmi.h
===================================================================
--- linux-don.orig/include/asm-i386/nmi.h
+++ linux-don/include/asm-i386/nmi.h
@@ -25,6 +25,13 @@ void set_nmi_callback(nmi_callback_t cal
  */
 void unset_nmi_callback(void);
 
+extern int avail_to_resrv_perfctr_nmi_bit(unsigned int);
+extern int avail_to_resrv_perfctr_nmi(unsigned int);
+extern int reserve_perfctr_nmi(unsigned int);
+extern void release_perfctr_nmi(unsigned int);
+extern int reserve_evntsel_nmi(unsigned int);
+extern void release_evntsel_nmi(unsigned int);
+
 extern void setup_apic_nmi_watchdog (void);
 extern int reserve_lapic_nmi(void);
 extern void release_lapic_nmi(void);

--
