Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbRBBOdT>; Fri, 2 Feb 2001 09:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129206AbRBBOdI>; Fri, 2 Feb 2001 09:33:08 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:12229 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129272AbRBBOc6>; Fri, 2 Feb 2001 09:32:58 -0500
Date: Fri, 2 Feb 2001 15:28:42 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] 2.4.1-ac1 UP-APIC/NMI watchdog fixes
In-Reply-To: <200102011928.UAA03188@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1010202142901.28509G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael,

 I've forgotten to cc you when sending Ingo my patch-2.4.0-ac12-upapic-19
fixes a few days ago, my apologies.  Since the two patches conflict with
each other, I've merged them together and provide the result below. 
Please check if it is fine for you. 

 I'm unsure about the K7_NMI_EVENT macro -- I think it should go into
include/asm-i386/msr.h, but the comment should remain here.  It should get
reworded a bit in this case, I suppose, though. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.1-ac1-upapic-20
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/kernel/apic.c linux-2.4.1-ac1/arch/i386/kernel/apic.c
--- linux-2.4.1-ac1.macro/arch/i386/kernel/apic.c	Fri Feb  2 12:32:24 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/apic.c	Fri Feb  2 13:25:21 2001
@@ -885,10 +885,10 @@ asmlinkage void smp_error_interrupt(void
  * This initializes the IO-APIC and APIC hardware if this is
  * a UP kernel.
  */
-void __init APIC_init_uniprocessor (void)
+int __init APIC_init_uniprocessor (void)
 {
 	if (!smp_found_config && !cpu_has_apic)
-		return;
+		return -1;
 
 	/*
 	 * Complain if the BIOS pretends there is one.
@@ -896,7 +896,7 @@ void __init APIC_init_uniprocessor (void
 	if (!cpu_has_apic && APIC_INTEGRATED(apic_version[boot_cpu_id])) {
 		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
 			boot_cpu_id);
-		return;
+		return -1;
 	}
 
 	verify_local_APIC();
@@ -915,4 +915,6 @@ void __init APIC_init_uniprocessor (void
 		setup_IO_APIC();
 #endif
 	setup_APIC_clocks();
+
+	return 0;
 }
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/kernel/io_apic.c linux-2.4.1-ac1/arch/i386/kernel/io_apic.c
--- linux-2.4.1-ac1.macro/arch/i386/kernel/io_apic.c	Fri Feb  2 12:32:24 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/io_apic.c	Fri Feb  2 13:05:37 2001
@@ -38,7 +38,6 @@ static spinlock_t ioapic_lock = SPIN_LOC
 /*
  * # of IRQ routing registers
  */
-int nr_ioapics;
 int nr_ioapic_registers[MAX_IO_APICS];
 
 #if CONFIG_SMP
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/kernel/mpparse.c linux-2.4.1-ac1/arch/i386/kernel/mpparse.c
--- linux-2.4.1-ac1.macro/arch/i386/kernel/mpparse.c	Fri Feb  2 12:32:24 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/mpparse.c	Fri Feb  2 13:05:37 2001
@@ -48,6 +48,8 @@ struct mpc_config_intsrc mp_irqs[MAX_IRQ
 /* MP IRQ source entries */
 int mp_irq_entries;
 
+int nr_ioapics;
+
 int pic_mode;
 unsigned long mp_lapic_addr;
 
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/kernel/nmi.c linux-2.4.1-ac1/arch/i386/kernel/nmi.c
--- linux-2.4.1-ac1.macro/arch/i386/kernel/nmi.c	Wed Jan 31 22:01:50 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/nmi.c	Fri Feb  2 13:25:21 2001
@@ -82,25 +82,34 @@ __setup("nmi_watchdog=", setup_nmi_watch
 /*
  * Activate the NMI watchdog via the local APIC.
  * Original code written by Keith Owens.
+ * AMD K7 code by Mikael Pettersson.
  */
 
-#define MSR_K7_EVNTSEL0 0xC0010000
-#define MSR_K7_PERFCTR0 0xC0010004
+static unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 
-void setup_apic_nmi_watchdog (void)
+/* Event 0x76 isn't listed in recent revisions of AMD #22007, and it
+   slows down (but doesn't halt) when the CPU is idle. Unfortunately
+   the K7 doesn't appear to have any other clock-like perfctr event. */
+#define K7_NMI_EVENT	0x76	/* CYCLES_PROCESSOR_IS_RUNNING */
+#define K7_NMI_EVNTSEL	((1<<20)|(3<<16)|K7_NMI_EVENT)	/* INT,OS,USR,<event> */
+
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
+		int i;
+		unsigned int evntsel;
+
+		nmi_perfctr_msr = MSR_K7_PERFCTR0;
+
+		for (i = 0; i < 4; ++i) {
+			wrmsr(MSR_K7_EVNTSEL0 + i, 0, 0);
+			wrmsr(MSR_K7_PERFCTR0 + i, 0, 0);
+		}
+
+		evntsel = K7_NMI_EVNTSEL;
 		wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
 		printk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/HZ*1000));
 		wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/HZ*1000), -1);
@@ -112,28 +121,35 @@ void setup_apic_nmi_watchdog (void)
 		return;
 	}
 
-	/* clear performance counters 0, 1 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+	    boot_cpu_data.x86 == 6) {
+
+		nmi_perfctr_msr = MSR_IA32_PERFCTR1;
 
-	wrmsr(MSR_IA32_EVNTSEL0, 0, 0);
-	wrmsr(MSR_IA32_EVNTSEL1, 0, 0);
-	wrmsr(MSR_IA32_PERFCTR0, 0, 0);
-	wrmsr(MSR_IA32_PERFCTR1, 0, 0);
-
-	/* send local-APIC timer counter overflow event as an NMI */
-
-	value =   1 << 20	/* Interrupt on overflow */
-		| 1 << 17	/* OS mode */
-		| 1 << 16	/* User mode */
-		| 0x79;		/* Event, cpu clocks not halted */
-	wrmsr(MSR_IA32_EVNTSEL1, value, 0);
-	printk("PERFCTR1: %08lx\n", -(cpu_khz/HZ*1000));
-	wrmsr(MSR_IA32_PERFCTR1, -(cpu_khz/HZ*1000), 0);
-
-	/* Enable performance counters, only using ctr1 */
-
-	apic_write_around(APIC_LVTPC, APIC_DM_NMI);
-	value = 1 << 22;
-	wrmsr(MSR_IA32_EVNTSEL0, value, 0);
+		/* clear performance counters 0, 1 */
+
+		wrmsr(MSR_IA32_EVNTSEL0, 0, 0);
+		wrmsr(MSR_IA32_EVNTSEL1, 0, 0);
+		wrmsr(MSR_IA32_PERFCTR0, 0, 0);
+		wrmsr(MSR_IA32_PERFCTR1, 0, 0);
+
+		/* send local-APIC timer counter overflow event as an NMI */
+
+		value =   1 << 20	/* Interrupt on overflow */
+			| 1 << 17	/* OS mode */
+			| 1 << 16	/* User mode */
+			| 0x79;		/* Event, cpu clocks not halted */
+		wrmsr(MSR_IA32_EVNTSEL1, value, 0);
+		printk("PERFCTR1: %08lx\n", -(cpu_khz/HZ*1000));
+		wrmsr(MSR_IA32_PERFCTR1, -(cpu_khz/HZ*1000), 0);
+
+		/* Enable performance counters, only using ctr1 */
+
+		apic_write_around(APIC_LVTPC, APIC_DM_NMI);
+		value = 1 << 22;
+		wrmsr(MSR_IA32_EVNTSEL0, value, 0);
+		return;
+	}
 }
 
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
@@ -190,14 +206,6 @@ void nmi_watchdog_tick (struct pt_regs *
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
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/kernel/smpboot.c linux-2.4.1-ac1/arch/i386/kernel/smpboot.c
--- linux-2.4.1-ac1.macro/arch/i386/kernel/smpboot.c	Fri Feb  2 12:32:24 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/smpboot.c	Fri Feb  2 13:25:21 2001
@@ -868,12 +868,15 @@ void __init smp_boot_cpus(void)
 	 * get out of here now!
 	 */
 	if (!smp_found_config) {
-		printk(KERN_NOTICE "SMP motherboard not detected. Using dummy APIC emulation.\n");
+		printk(KERN_NOTICE "SMP motherboard not detected.\n");
 #ifndef CONFIG_VISWS
 		io_apic_irqs = 0;
 #endif
 		cpu_online_map = phys_cpu_present_map = 1;
 		smp_num_cpus = 1;
+		if (APIC_init_uniprocessor())
+			printk(KERN_NOTICE "Local APIC not detected."
+					   " Using dummy APIC emulation.\n");
 		goto smp_done;
 	}
 
@@ -1019,4 +1022,3 @@ void __init smp_boot_cpus(void)
 smp_done:
 	zap_low_mappings();
 }
-
diff -up --recursive --new-file linux-2.4.1-ac1.macro/include/asm-i386/apic.h linux-2.4.1-ac1/include/asm-i386/apic.h
--- linux-2.4.1-ac1.macro/include/asm-i386/apic.h	Fri Feb  2 12:56:56 2001
+++ linux-2.4.1-ac1/include/asm-i386/apic.h	Fri Feb  2 13:25:21 2001
@@ -77,7 +77,7 @@ extern void smp_local_timer_interrupt (s
 extern void setup_APIC_clocks (void);
 extern void setup_apic_nmi_watchdog (void);
 extern inline void nmi_watchdog_tick (struct pt_regs * regs);
-extern void APIC_init_uniprocessor (void);
+extern int APIC_init_uniprocessor (void);
 
 extern unsigned int apic_timer_irqs [NR_CPUS];
 extern int check_nmi_watchdog (void);
diff -up --recursive --new-file linux-2.4.1-ac1.macro/include/asm-i386/msr.h linux-2.4.1-ac1/include/asm-i386/msr.h
--- linux-2.4.1-ac1.macro/include/asm-i386/msr.h	Fri Feb  2 12:33:07 2001
+++ linux-2.4.1-ac1/include/asm-i386/msr.h	Fri Feb  2 13:25:21 2001
@@ -67,4 +67,8 @@
 #define		MSR_IA32_MC0_MISC_OFFSET	0x3
 #define		MSR_IA32_MC0_BANK_COUNT		0x4
 
+
+#define MSR_K7_EVNTSEL0			0xC0010000
+#define MSR_K7_PERFCTR0			0xC0010004
+
 #endif



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
