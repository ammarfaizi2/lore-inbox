Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbTD0BKy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 21:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbTD0BKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 21:10:54 -0400
Received: from zero.aec.at ([193.170.194.10]:55309 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263169AbTD0BKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 21:10:36 -0400
Date: Sun, 27 Apr 2003 03:22:38 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] An generic subarchitecture for 2.5.68
Message-ID: <20030427012238.GA13997@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds an generic x86 subarchitecture. It is intended to provide
an dynamic interface for APIC drivers. There are already three subarchitectures
(bigsmp, summit, default) that only differ in how they drive the local APIC.
A fourth - Unisys ES7000 - is scheduled to be merged soon.

The subarchitecture concept separated this nicely, but it has the big
drawback that they are compile time options. A Linux vendor cannot
ship own binary kernel rpms for all of these machines. Runtime probing
is needed instead.

This patch adds a new "generic" subarchitecture that just acts as a
dynamic switching layer for APIC drivers. It only tries to virtualize
the APICs, no attempt is made to cover further incompatiblities.
This means machines like the Visual Workstation, pc9800 or 
Voyager are not covered; but these are unlikely to be supported by
binary distributions anyways.

The generic arch reuses the existing interface in mach_ipi / mach_mpparse.h / 
mach_apic.h and just pulls it using some macros into an "struct genapic" 
object. The main APIC code does not recognize it, it is all hidden
in the mach-generic include files.

Auto detection of APIC types is supported in the usual way used by
existing ports like Summit - checking ACPI or mptables for specific
signatures - or it can be specified by the user using a new "apic="
boot option. I also moved the DMI scan to before the generic
subarchitecture probe, so DMI could be used in future too to probe
specific machines. 

Some minor hacks were needed to avoid circular declaration of a few
symbols, but overall it's fairly clean.

The patch has been tested on a Summit machine, an generic 4 virtual CPUs
Xeon and on an ES7000. 

Patch for 2.5.68+bkcvs

Please consider applying,

-Andi

diff -u linux-apic/arch/i386/kernel/timers/Makefile-o linux-apic/arch/i386/kernel/timers/Makefile
--- linux-apic/arch/i386/kernel/timers/Makefile-o	2003-02-13 18:53:22.000000000 +0100
+++ linux-apic/arch/i386/kernel/timers/Makefile	2003-04-27 02:45:24.000000000 +0200
@@ -4,4 +4,4 @@
 
 obj-y := timer.o timer_none.o timer_tsc.o timer_pit.o
 
-obj-$(CONFIG_X86_SUMMIT)	+= timer_cyclone.o
+obj-$(CONFIG_X86_CYCLONE_TIMER)	+= timer_cyclone.o
diff -u linux-apic/arch/i386/kernel/timers/timer.c-o linux-apic/arch/i386/kernel/timers/timer.c
--- linux-apic/arch/i386/kernel/timers/timer.c-o	2003-04-14 23:37:04.000000000 +0200
+++ linux-apic/arch/i386/kernel/timers/timer.c	2003-04-27 02:45:24.000000000 +0200
@@ -6,12 +6,12 @@
 /* list of externed timers */
 extern struct timer_opts timer_pit;
 extern struct timer_opts timer_tsc;
-#ifdef CONFIG_X86_SUMMIT
+#ifdef CONFIG_X86_CYCLONE_TIMER
 extern struct timer_opts timer_cyclone;
 #endif
 /* list of timers, ordered by preference, NULL terminated */
 static struct timer_opts* timers[] = {
-#ifdef CONFIG_X86_SUMMIT
+#ifdef CONFIG_X86_CYCLONE_TIMER
 	&timer_cyclone,
 #endif
 	&timer_tsc,
diff -u linux-apic/arch/i386/kernel/setup.c-o linux-apic/arch/i386/kernel/setup.c
--- linux-apic/arch/i386/kernel/setup.c-o	2003-04-25 01:17:20.000000000 +0200
+++ linux-apic/arch/i386/kernel/setup.c	2003-04-27 02:45:25.000000000 +0200
@@ -91,6 +91,7 @@
 
 extern void early_cpu_init(void);
 extern void dmi_scan_machine(void);
+extern void generic_apic_probe(char *);
 extern int root_mountflags;
 extern char _text, _etext, _edata, _end;
 extern int blk_nohighio;
@@ -909,6 +910,13 @@
 	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
 #endif
 	paging_init();
+
+	dmi_scan_machine();
+
+#ifdef CONFIG_X86_GENERICARCH
+	generic_apic_probe(*cmdline_p);
+#endif	
+
 #ifdef CONFIG_ACPI_BOOT
 	/*
 	 * Parse the ACPI tables for possible boot-time SMP configuration.
@@ -930,7 +938,6 @@
 	conswitchp = &dummy_con;
 #endif
 #endif
-	dmi_scan_machine();
 }
 
 static int __init highio_setup(char *str)
diff -u linux-apic/arch/i386/kernel/io_apic.c-o linux-apic/arch/i386/kernel/io_apic.c
--- linux-apic/arch/i386/kernel/io_apic.c-o	2003-04-27 02:40:32.000000000 +0200
+++ linux-apic/arch/i386/kernel/io_apic.c	2003-04-27 02:45:25.000000000 +0200
@@ -280,7 +280,9 @@
 extern unsigned long irq_affinity[NR_IRQS];
 
 static int __cacheline_aligned pending_irq_balance_apicid[NR_IRQS];
-static int irqbalance_disabled = NO_BALANCE_IRQ;
+
+#define IRQBALANCE_CHECK_ARCH -999
+static int irqbalance_disabled = IRQBALANCE_CHECK_ARCH;
 static int physical_balance = 0;
 
 struct irq_cpu_info {
@@ -342,8 +344,10 @@
 	unsigned long allowed_mask;
 	unsigned int new_cpu;
 		
-	if (irqbalance_disabled)
+	if (irqbalance_disabled == IRQBALANCE_CHECK_ARCH && NO_BALANCE_IRQ)
 		return;
+	else if (irqbalance_disabled) 
+		return; 
 
 	allowed_mask = cpu_online_map & irq_affinity[irq];
 	new_cpu = move(cpu, allowed_mask, now, 1);
diff -u linux-apic/arch/i386/kernel/mpparse.c-o linux-apic/arch/i386/kernel/mpparse.c
--- linux-apic/arch/i386/kernel/mpparse.c-o	2003-04-25 01:17:20.000000000 +0200
+++ linux-apic/arch/i386/kernel/mpparse.c	2003-04-27 02:45:25.000000000 +0200
@@ -73,7 +73,9 @@
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
 
+#ifndef CONFIG_X86_GENERICARCH
 int x86_summit = 0;
+#endif
 u8 bios_cpu_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
 /*
diff -u linux-apic/arch/i386/kernel/smp.c-o linux-apic/arch/i386/kernel/smp.c
--- linux-apic/arch/i386/kernel/smp.c-o	2003-04-14 23:37:04.000000000 +0200
+++ linux-apic/arch/i386/kernel/smp.c	2003-04-27 02:45:25.000000000 +0200
@@ -123,7 +123,7 @@
 	return SET_APIC_DEST_FIELD(mask);
 }
 
-static inline void __send_IPI_shortcut(unsigned int shortcut, int vector)
+inline void __send_IPI_shortcut(unsigned int shortcut, int vector)
 {
 	/*
 	 * Subtle. In the case of the 'never do double writes' workaround
@@ -155,7 +155,7 @@
 	__send_IPI_shortcut(APIC_DEST_SELF, vector);
 }
 
-static inline void send_IPI_mask_bitmask(int mask, int vector)
+inline void send_IPI_mask_bitmask(int mask, int vector)
 {
 	unsigned long cfg;
 	unsigned long flags;
@@ -186,7 +186,7 @@
 	local_irq_restore(flags);
 }
 
-static inline void send_IPI_mask_sequence(int mask, int vector)
+inline void send_IPI_mask_sequence(int mask, int vector)
 {
 	unsigned long cfg, flags;
 	unsigned int query_cpu, query_mask;
diff -u linux-apic/arch/i386/mach-generic/default.c-o linux-apic/arch/i386/mach-generic/default.c
--- linux-apic/arch/i386/mach-generic/default.c-o	2003-04-27 02:45:25.000000000 +0200
+++ linux-apic/arch/i386/mach-generic/default.c	2003-04-27 02:45:25.000000000 +0200
@@ -0,0 +1,22 @@
+/* 
+ * Default generic APIC driver. This handles upto 8 CPUs.
+ */
+#define APIC_DEFINITION 1
+#include <asm/genapic.h>
+#include <asm/fixmap.h>
+#include <asm/apicdef.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <asm/mach-default/mach_apic.h>
+#include <asm/mach-default/mach_ipi.h>
+#include <asm/mach-default/mach_mpparse.h>
+
+/* should be called last. */
+static __init int probe_default(void)
+{ 
+	return 1;
+} 
+
+struct genapic apic_default = APIC_INIT("default", probe_default); 
diff -u linux-apic/arch/i386/mach-generic/Makefile-o linux-apic/arch/i386/mach-generic/Makefile
--- linux-apic/arch/i386/mach-generic/Makefile-o	2003-04-27 02:45:25.000000000 +0200
+++ linux-apic/arch/i386/mach-generic/Makefile	2003-04-27 02:45:25.000000000 +0200
@@ -0,0 +1,9 @@
+#
+# Makefile for the generic architecture
+#
+
+EXTRA_CFLAGS	+= -I../kernel
+
+obj-y				:= probe.o summit.o bigsmp.o default.o
+
+
diff -u linux-apic/arch/i386/mach-generic/summit.c-o linux-apic/arch/i386/mach-generic/summit.c
--- linux-apic/arch/i386/mach-generic/summit.c-o	2003-04-27 02:45:25.000000000 +0200
+++ linux-apic/arch/i386/mach-generic/summit.c	2003-04-27 02:45:25.000000000 +0200
@@ -0,0 +1,22 @@
+/* 
+ * APIC driver for the IBM "Summit" chipset.
+ */
+#define APIC_DEFINITION 1
+#include <asm/genapic.h>
+#include <asm/fixmap.h>
+#include <asm/apicdef.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <asm/mach-summit/mach_apic.h>
+#include <asm/mach-summit/mach_ipi.h>
+#include <asm/mach-summit/mach_mpparse.h>
+
+static __init int probe_summit(void)
+{ 
+	/* probed later in mptable/ACPI hooks */
+	return 0;
+} 
+
+struct genapic apic_summit = APIC_INIT("summit", probe_summit); 
diff -u linux-apic/arch/i386/mach-generic/bigsmp.c-o linux-apic/arch/i386/mach-generic/bigsmp.c
--- linux-apic/arch/i386/mach-generic/bigsmp.c-o	2003-04-27 02:45:25.000000000 +0200
+++ linux-apic/arch/i386/mach-generic/bigsmp.c	2003-04-27 02:45:25.000000000 +0200
@@ -0,0 +1,23 @@
+/* 
+ * APIC driver for "bigsmp" XAPIC machines with more than 8 virtual CPUs.
+ * Drives the local APIC in "clustered mode".
+ */
+#define APIC_DEFINITION 1
+#include <asm/genapic.h>
+#include <asm/fixmap.h>
+#include <asm/apicdef.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <asm/mach-bigsmp/mach_apic.h>
+#include <asm/mach-bigsmp/mach_ipi.h>
+#include <asm/mach-default/mach_mpparse.h>
+
+int dmi_bigsmp; /* can be set by dmi scanners */
+
+static __init int probe_bigsmp(void)
+{ 
+	return dmi_bigsmp; 
+} 
+
+struct genapic apic_bigsmp = APIC_INIT("bigsmp", probe_bigsmp); 
diff -u linux-apic/arch/i386/mach-generic/probe.c-o linux-apic/arch/i386/mach-generic/probe.c
--- linux-apic/arch/i386/mach-generic/probe.c-o	2003-04-27 02:45:25.000000000 +0200
+++ linux-apic/arch/i386/mach-generic/probe.c	2003-04-27 02:45:25.000000000 +0200
@@ -0,0 +1,96 @@
+/* Copyright 2003 Andi Kleen, SuSE Labs. 
+ * Subject to the GNU Public License, v.2 
+ * 
+ * Generic x86 APIC driver probe layer.
+ */  
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/ctype.h>
+#include <linux/init.h>
+#include <asm/fixmap.h>
+#include <asm/apicdef.h>
+#include <asm/genapic.h>
+
+extern struct genapic apic_summit;
+extern struct genapic apic_bigsmp;
+extern struct genapic apic_default;
+
+struct genapic *genapic = &apic_default;
+
+struct genapic *apic_probe[] __initdata = { 
+	&apic_summit,
+	&apic_bigsmp, 
+	&apic_default,	/* must be last */
+	NULL,
+};
+
+void __init generic_apic_probe(char *command_line) 
+{ 
+	char *s;
+	int i;
+	int changed = 0;
+
+	s = strstr(command_line, "apic=");
+	if (s && (s == command_line || isspace(s[-1]))) { 
+		char *p = strchr(s, ' '), old; 
+		if (!p)
+			p = strchr(s, '\0'); 
+		old = *p; 
+		*p = 0; 
+		for (i = 0; !changed && apic_probe[i]; i++) {
+			if (!strcmp(apic_probe[i]->name, s+5)) { 
+				changed = 1;
+				genapic = apic_probe[i];
+			}
+		}
+		if (!changed)
+			printk(KERN_ERR "Unknown genapic `%s' specified.\n", s);
+		*p = old;
+	} 
+	for (i = 0; !changed && apic_probe[i]; i++) { 
+		if (apic_probe[i]->probe()) {
+			changed = 1;
+			genapic = apic_probe[i]; 
+		} 
+	}
+	/* Not visible without early console */ 
+	if (!changed) 
+		panic("Didn't find an APIC driver"); 
+
+	printk(KERN_INFO "Using APIC driver %s\n", genapic->name);
+} 
+
+/* These functions can switch the APIC even after the initial ->probe() */
+
+int __init mps_oem_check(struct mp_config_table *mpc, char *oem, char *productid)
+{ 
+	int i;
+	for (i = 0; apic_probe[i]; ++i) { 
+		if (apic_probe[i]->mps_oem_check(mpc,oem,productid)) { 
+			genapic = apic_probe[i];
+			printk(KERN_INFO "Switched to APIC driver `%s'.\n", 
+			       genapic->name);
+			return 1;
+		} 
+	} 
+	return 0;
+} 
+
+int __init acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	int i;
+	for (i = 0; apic_probe[i]; ++i) { 
+		if (apic_probe[i]->acpi_madt_oem_check(oem_id, oem_table_id)) { 
+			genapic = apic_probe[i];
+			printk(KERN_INFO "Switched to APIC driver `%s'.\n", 
+			       genapic->name);
+			return 1;
+		} 
+	} 
+	return 0;	
+}
+
+int hard_smp_processor_id(void)
+{
+	return genapic->get_apic_id(*(unsigned long *)(APIC_BASE+APIC_ID));
+}
diff -u linux-apic/arch/i386/Makefile-o linux-apic/arch/i386/Makefile
--- linux-apic/arch/i386/Makefile-o	2003-04-14 23:37:04.000000000 +0200
+++ linux-apic/arch/i386/Makefile	2003-04-27 02:45:25.000000000 +0200
@@ -73,6 +73,11 @@
 mflags-$(CONFIG_X86_SUMMIT) := -Iinclude/asm-i386/mach-summit
 mcore-$(CONFIG_X86_SUMMIT)  := mach-default
 
+# generic subarchitecture
+mflags-$(CONFIG_X86_GENERICARCH) := -Iinclude/asm-i386/mach-generic
+mcore-$(CONFIG_X86_GENERICARCH) := mach-default
+core-$(CONFIG_X86_GENERICARCH) += arch/i386/mach-generic/
+
 # default subarch .h files
 mflags-y += -Iinclude/asm-i386/mach-default
 
diff -u linux-apic/arch/i386/Kconfig-o linux-apic/arch/i386/Kconfig
--- linux-apic/arch/i386/Kconfig-o	2003-04-27 02:40:32.000000000 +0200
+++ linux-apic/arch/i386/Kconfig	2003-04-27 02:45:25.000000000 +0200
@@ -71,11 +71,6 @@
 
 	  If you don't have one of these computers, you should say N here.
 
-config ACPI_SRAT
-	bool
-	default y
-	depends on NUMA && X86_SUMMIT
-
 config X86_BIGSMP
 	bool "Support for other sub-arch SMP systems with more than 8 CPUs"
 	help
@@ -95,8 +90,23 @@
 	  A kernel compiled for the Visual Workstation will not run on PCs
 	  and vice versa. See <file:Documentation/sgi-visws.txt> for details.
 
+config X86_GENERICARCH
+       bool "Generic architecture (Summit, bigsmp, default)"
+       help
+          This option compiles in the Summit, bigsmp, default subarchitectures.
+	  It is intended for a generic binary kernel.
+
 endchoice
 
+config ACPI_SRAT
+	bool
+	default y
+	depends on NUMA && (X86_SUMMIT || X86_GENERICARCH)
+
+config X86_CYCLONE_TIMER
+       bool 
+       default y
+       depends on X86_SUMMIT || X86_GENERICARCH
 
 choice
 	prompt "Processor family"
@@ -669,7 +679,7 @@
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation Support"
-	depends on SMP && HIGHMEM64G && (X86_PC || X86_NUMAQ || (X86_SUMMIT && ACPI && !ACPI_HT_ONLY))
+	depends on SMP && HIGHMEM64G && (X86_PC || X86_NUMAQ || X86_GENERICARCH || (X86_SUMMIT && ACPI && !ACPI_HT_ONLY))
 	default n if X86_PC
 	default y if (X86_NUMAQ || X86_SUMMIT)
 
@@ -767,7 +777,7 @@
 # Summit needs it only when NUMA is on
 config BOOT_IOREMAP
 	bool
-	depends on (X86_SUMMIT && NUMA)
+	depends on ((X86_SUMMIT || X86_GENERICARCH) && NUMA)
 	default y
 
 endmenu
diff -u linux-apic/include/asm-i386/mach-bigsmp/mach_apic.h-o linux-apic/include/asm-i386/mach-bigsmp/mach_apic.h
--- linux-apic/include/asm-i386/mach-bigsmp/mach_apic.h-o	2003-03-11 02:36:27.000000000 +0100
+++ linux-apic/include/asm-i386/mach-bigsmp/mach_apic.h	2003-04-27 02:45:25.000000000 +0200
@@ -15,18 +15,28 @@
 
 static inline int apic_id_registered(void)
 {
-	        return (1);
+	return (1);
 }
 
 #define APIC_DFR_VALUE	(APIC_DFR_CLUSTER)
-#define TARGET_CPUS	((cpu_online_map < 0xf)?cpu_online_map:0xf)
+static inline unsigned long target_cpus(void)
+{ 
+	return ((cpu_online_map < 0xf)?cpu_online_map:0xf);
+}
+#define TARGET_CPUS	(target_cpus())
 
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
 #define APIC_BROADCAST_ID     (0x0f)
-#define check_apicid_used(bitmap, apicid) (0)
-#define check_apicid_present(bit) (phys_cpu_present_map & (1 << bit))
+static inline unsigned long check_apicid_used(unsigned long bitmap, int apicid) 
+{ 
+	return 0;
+} 
+static inline unsigned long check_apicid_present(int bit) 
+{ 
+	return (phys_cpu_present_map & (1 << bit));
+}
 
 static inline unsigned long calculate_ldr(unsigned long old)
 {
@@ -115,4 +125,13 @@
 	return (1);
 }
 
+#define		APIC_ID_MASK		(0x0F<<24)
+
+static inline unsigned get_apic_id(unsigned long x) 
+{ 
+	return (((x)>>24)&0x0F);
+} 
+
+#define		GET_APIC_ID(x)	get_apic_id(x)
+
 #endif /* __ASM_MACH_APIC_H */
diff -u linux-apic/include/asm-i386/mach-bigsmp/mach_ipi.h-o linux-apic/include/asm-i386/mach-bigsmp/mach_ipi.h
--- linux-apic/include/asm-i386/mach-bigsmp/mach_ipi.h-o	2003-01-14 05:30:21.000000000 +0100
+++ linux-apic/include/asm-i386/mach-bigsmp/mach_ipi.h	2003-04-27 02:45:25.000000000 +0200
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_IPI_H
 #define __ASM_MACH_IPI_H
 
-static inline void send_IPI_mask_sequence(int mask, int vector);
+inline void send_IPI_mask_sequence(int mask, int vector);
 
 static inline void send_IPI_mask(int mask, int vector)
 {
diff -u linux-apic/include/asm-i386/mach-default/mach_mpparse.h-o linux-apic/include/asm-i386/mach-default/mach_mpparse.h
--- linux-apic/include/asm-i386/mach-default/mach_mpparse.h-o	2003-04-14 23:37:22.000000000 +0200
+++ linux-apic/include/asm-i386/mach-default/mach_mpparse.h	2003-04-27 02:45:25.000000000 +0200
@@ -12,14 +12,16 @@
 {
 }
 
-static inline void mps_oem_check(struct mp_config_table *mpc, char *oem, 
+static inline int mps_oem_check(struct mp_config_table *mpc, char *oem, 
 		char *productid)
 {
+	return 0;
 }
 
 /* Hook from generic ACPI tables.c */
-static inline void acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+static inline int acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
+	return 0;
 }
 
 
diff -u linux-apic/include/asm-i386/mach-default/mach_apic.h-o linux-apic/include/asm-i386/mach-default/mach_apic.h
--- linux-apic/include/asm-i386/mach-default/mach_apic.h-o	2003-03-11 02:36:27.000000000 +0100
+++ linux-apic/include/asm-i386/mach-default/mach_apic.h	2003-04-27 02:45:25.000000000 +0200
@@ -3,11 +3,15 @@
 
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
+static inline unsigned long target_cpus(void)
+{ 
 #ifdef CONFIG_SMP
- #define TARGET_CPUS (cpu_online_map)
+	return cpu_online_map;
 #else
- #define TARGET_CPUS 0x01
+	return 1; 
 #endif
+} 
+#define TARGET_CPUS (target_cpus())
 
 #define NO_BALANCE_IRQ (0)
 #define esr_disable (0)
@@ -16,13 +20,15 @@
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
 #define APIC_BROADCAST_ID      0x0F
-#define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
-#define check_apicid_present(bit) (phys_cpu_present_map & (1 << bit))
 
-static inline int apic_id_registered(void)
+static inline unsigned long check_apicid_used(unsigned long bitmap, int apicid) 
+{ 
+	return (bitmap & (1UL << apicid)); 
+} 
+
+static inline unsigned long check_apicid_present(int bit) 
 {
-	return (test_bit(GET_APIC_ID(apic_read(APIC_ID)), 
-						&phys_cpu_present_map));
+	return (phys_cpu_present_map & (1UL << bit));
 }
 
 /*
@@ -42,7 +48,7 @@
 	apic_write_around(APIC_LDR, val);
 }
 
-static inline ulong ioapic_phys_id_map(ulong phys_map)
+static inline unsigned long ioapic_phys_id_map(unsigned long phys_map)
 {
 	return phys_map;
 }
@@ -99,4 +105,19 @@
 	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
 
+#define		APIC_ID_MASK		(0xF<<24)
+
+static inline unsigned get_apic_id(unsigned long x) 
+{ 
+	return (((x)>>24)&0xF);
+} 
+
+#define		GET_APIC_ID(x)	get_apic_id(x)
+
+static inline int apic_id_registered(void)
+{
+	return (test_bit(GET_APIC_ID(apic_read(APIC_ID)), 
+						&phys_cpu_present_map));
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -u linux-apic/include/asm-i386/mach-default/mach_ipi.h-o linux-apic/include/asm-i386/mach-default/mach_ipi.h
--- linux-apic/include/asm-i386/mach-default/mach_ipi.h-o	2002-12-23 19:19:53.000000000 +0100
+++ linux-apic/include/asm-i386/mach-default/mach_ipi.h	2003-04-27 02:45:25.000000000 +0200
@@ -1,8 +1,8 @@
 #ifndef __ASM_MACH_IPI_H
 #define __ASM_MACH_IPI_H
 
-static inline void send_IPI_mask_bitmask(int mask, int vector);
-static inline void __send_IPI_shortcut(unsigned int shortcut, int vector);
+inline void send_IPI_mask_bitmask(int mask, int vector);
+inline void __send_IPI_shortcut(unsigned int shortcut, int vector);
 
 static inline void send_IPI_mask(int mask, int vector)
 {
diff -u linux-apic/include/asm-i386/mach-summit/mach_mpparse.h-o linux-apic/include/asm-i386/mach-summit/mach_mpparse.h
--- linux-apic/include/asm-i386/mach-summit/mach_mpparse.h-o	2003-04-20 13:26:41.000000000 +0200
+++ linux-apic/include/asm-i386/mach-summit/mach_mpparse.h	2003-04-27 02:47:51.000000000 +0200
@@ -14,26 +14,34 @@
 {
 }
 
-static inline void mps_oem_check(struct mp_config_table *mpc, char *oem, 
+static inline int mps_oem_check(struct mp_config_table *mpc, char *oem, 
 		char *productid)
 {
 	if (!strncmp(oem, "IBM ENSW", 8) && 
 			(!strncmp(productid, "VIGIL SMP", 9) 
 			 || !strncmp(productid, "EXA", 3)
 			 || !strncmp(productid, "RUTHLESS SMP", 12))){
+#ifndef CONFIG_X86_GENERICARCH
 		x86_summit = 1;
+#endif
 		use_cyclone = 1; /*enable cyclone-timer*/
+		return 1;
 	}
+	return 0;
 }
 
 /* Hook from generic ACPI tables.c */
-static inline void acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+static inline int acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
 	if (!strncmp(oem_id, "IBM", 3) &&
 	    (!strncmp(oem_table_id, "SERVIGIL", 8)
 	     || !strncmp(oem_table_id, "EXA", 3))){
+#ifndef CONFIG_X86_GENERICARCH
 		x86_summit = 1;
+#endif
 		use_cyclone = 1; /*enable cyclone-timer*/
+		return 1;
 	}
+	return 0;
 }
 #endif /* __ASM_MACH_MPPARSE_H */
diff -u linux-apic/include/asm-i386/mach-summit/mach_apic.h-o linux-apic/include/asm-i386/mach-summit/mach_apic.h
--- linux-apic/include/asm-i386/mach-summit/mach_apic.h-o	2003-03-11 02:36:27.000000000 +0100
+++ linux-apic/include/asm-i386/mach-summit/mach_apic.h	2003-04-27 02:45:25.000000000 +0200
@@ -1,7 +1,13 @@
 #ifndef __ASM_MACH_APIC_H
 #define __ASM_MACH_APIC_H
 
+#include <linux/config.h>
+
+#ifdef CONFIG_X86_GENERICARCH
+#define x86_summit 1	/* must be an constant expressiona for generic arch */
+#else
 extern int x86_summit;
+#endif
 
 #define esr_disable (x86_summit ? 1 : 0)
 #define NO_BALANCE_IRQ (0)
@@ -9,20 +15,34 @@
 #define XAPIC_DEST_CPUS_MASK    0x0Fu
 #define XAPIC_DEST_CLUSTER_MASK 0xF0u
 
-#define xapic_phys_to_log_apicid(phys_apic) ( (1ul << ((phys_apic) & 0x3)) |\
-		((phys_apic) & XAPIC_DEST_CLUSTER_MASK) )
+static inline unsigned long xapic_phys_to_log_apicid(int phys_apic) 
+{
+	return ( (1ul << ((phys_apic) & 0x3)) |
+		 ((phys_apic) & XAPIC_DEST_CLUSTER_MASK) );
+}
 
 #define APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
-#define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map)
+
+static inline unsigned long target_cpus(void)
+{
+	return (x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map);
+} 
+#define TARGET_CPUS	(target_cpus())
 
 #define INT_DELIVERY_MODE (x86_summit ? dest_Fixed : dest_LowestPrio)
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
-#define APIC_BROADCAST_ID     (x86_summit ? 0xFF : 0x0F)
-#define check_apicid_used(bitmap, apicid) (x86_summit ? 0 : (bitmap & (1 << apicid)))
+#define APIC_BROADCAST_ID     (0x0F)
+static inline unsigned long check_apicid_used(unsigned long bitmap, int apicid) 
+{ 
+	return (x86_summit ? 0 : (bitmap & (1 << apicid)));
+} 
 
 /* we don't use the phys_cpu_present_map to indicate apicid presence */
-#define check_apicid_present(bit) (x86_summit ? 1 : (phys_cpu_present_map & (1 << bit))) 
+static inline unsigned long check_apicid_present(int bit) 
+{
+	return (x86_summit ? 1 : (phys_cpu_present_map & (1 << bit)));
+}
 
 extern u8 bios_cpu_apicid[];
 
@@ -113,4 +133,13 @@
 		return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
 
+#define		APIC_ID_MASK		(0xFF<<24)
+
+static inline unsigned get_apic_id(unsigned long x) 
+{ 
+	return (((x)>>24)&0xFF);
+} 
+
+#define		GET_APIC_ID(x)	get_apic_id(x)
+
 #endif /* __ASM_MACH_APIC_H */
diff -u linux-apic/include/asm-i386/mach-summit/mach_ipi.h-o linux-apic/include/asm-i386/mach-summit/mach_ipi.h
--- linux-apic/include/asm-i386/mach-summit/mach_ipi.h-o	2002-12-23 19:19:58.000000000 +0100
+++ linux-apic/include/asm-i386/mach-summit/mach_ipi.h	2003-04-27 02:45:25.000000000 +0200
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_IPI_H
 #define __ASM_MACH_IPI_H
 
-static inline void send_IPI_mask_sequence(int mask, int vector);
+inline void send_IPI_mask_sequence(int mask, int vector);
 
 static inline void send_IPI_mask(int mask, int vector)
 {
diff -u linux-apic/include/asm-i386/mach-generic/mach_apic.h-o linux-apic/include/asm-i386/mach-generic/mach_apic.h
--- linux-apic/include/asm-i386/mach-generic/mach_apic.h-o	2003-04-27 02:45:25.000000000 +0200
+++ linux-apic/include/asm-i386/mach-generic/mach_apic.h	2003-04-27 02:45:25.000000000 +0200
@@ -0,0 +1,30 @@
+#ifndef __ASM_MACH_APIC_H
+#define __ASM_MACH_APIC_H
+
+#include <asm/genapic.h>
+
+#define esr_disable (genapic->esr_disable)
+#define NO_BALANCE_IRQ (genapic->no_balance_irq)
+#define APIC_BROADCAST_ID (genapic->apic_broadcast_id)
+#define INT_DELIVERY_MODE (genapic->int_delivery_mode)
+#define INT_DEST_MODE (genapic->int_dest_mode)
+#define TARGET_CPUS	  (genapic->target_cpus())
+#define apic_id_registered (genapic->apic_id_registered)
+#define apic_id_registered (genapic->apic_id_registered)
+#define init_apic_ldr (genapic->init_apic_ldr)
+#define ioapic_phys_id_map (genapic->ioapic_phys_id_map)
+#define clustered_apic_check (genapic->clustered_apic_check) 
+#define multi_timer_check (genapic->multi_timer_check)
+#define apicid_to_node (genapic->apicid_to_node)
+#define cpu_to_logical_apicid (genapic->cpu_to_logical_apicid) 
+#define cpu_present_to_apicid (genapic->cpu_present_to_apicid)
+#define apicid_to_cpu_present (genapic->apicid_to_cpu_present)
+#define mpc_apic_id (genapic->mpc_apic_id) 
+#define setup_portio_remap (genapic->setup_portio_remap)
+#define check_apicid_present (genapic->check_apicid_present)
+#define check_phys_apicid_present (genapic->check_phys_apicid_present)
+#define check_apicid_used (genapic->check_apicid_used)
+#define GET_APIC_ID (genapic->get_apic_id)
+#define APIC_ID_MASK (genapic->apic_id_mask)
+
+#endif /* __ASM_MACH_APIC_H */
diff -u linux-apic/include/asm-i386/mach-generic/mach_ipi.h-o linux-apic/include/asm-i386/mach-generic/mach_ipi.h
--- linux-apic/include/asm-i386/mach-generic/mach_ipi.h-o	2003-04-27 02:45:25.000000000 +0200
+++ linux-apic/include/asm-i386/mach-generic/mach_ipi.h	2003-04-27 02:45:25.000000000 +0200
@@ -0,0 +1,10 @@
+#ifndef _MACH_IPI_H
+#define _MACH_IPI_H 1
+
+#include <asm/genapic.h>
+
+#define send_IPI_mask (genapic->send_IPI_mask)
+#define send_IPI_allbutself (genapic->send_IPI_allbutself)
+#define send_IPI_all (genapic->send_IPI_all)
+
+#endif
diff -u linux-apic/include/asm-i386/mach-generic/mach_mpparse.h-o linux-apic/include/asm-i386/mach-generic/mach_mpparse.h
--- linux-apic/include/asm-i386/mach-generic/mach_mpparse.h-o	2003-04-27 02:45:25.000000000 +0200
+++ linux-apic/include/asm-i386/mach-generic/mach_mpparse.h	2003-04-27 02:45:25.000000000 +0200
@@ -0,0 +1,12 @@
+#ifndef _MACH_MPPARSE_H
+#define _MACH_MPPARSE_H 1
+
+#include <asm/genapic.h>
+
+#define mpc_oem_bus_info (genapic->mpc_oem_bus_info)
+#define mpc_oem_pci_bus (genapic->mpc_oem_pci_bus)
+
+int mps_oem_check(struct mp_config_table *mpc, char *oem, char *productid); 
+int acpi_madt_oem_check(char *oem_id, char *oem_table_id); 
+
+#endif
diff -u linux-apic/include/asm-i386/fixmap.h-o linux-apic/include/asm-i386/fixmap.h
--- linux-apic/include/asm-i386/fixmap.h-o	2003-02-13 18:53:22.000000000 +0100
+++ linux-apic/include/asm-i386/fixmap.h	2003-04-27 02:45:25.000000000 +0200
@@ -60,7 +60,7 @@
 #ifdef CONFIG_X86_F00F_BUG
 	FIX_F00F_IDT,	/* Virtual mapping for IDT */
 #endif
-#ifdef CONFIG_X86_SUMMIT
+#ifdef CONFIG_X86_CYCLONE_TIMER
 	FIX_CYCLONE_TIMER, /*cyclone timer register*/
 #endif 
 #ifdef CONFIG_HIGHMEM
diff -u linux-apic/include/asm-i386/smp.h-o linux-apic/include/asm-i386/smp.h
--- linux-apic/include/asm-i386/smp.h-o	2003-01-15 21:09:18.000000000 +0100
+++ linux-apic/include/asm-i386/smp.h	2003-04-27 02:45:25.000000000 +0200
@@ -87,11 +87,17 @@
 	return -1;
 }
 #ifdef CONFIG_X86_LOCAL_APIC
-static __inline int hard_smp_processor_id(void)
+
+#ifdef APIC_DEFINITION
+extern int hard_smp_processor_id(void);
+#else
+#include <mach_apic.h>
+static inline int hard_smp_processor_id(void)
 {
 	/* we don't want to mark this access volatile - bad code generation */
 	return GET_APIC_ID(*(unsigned long *)(APIC_BASE+APIC_ID));
 }
+#endif
 
 static __inline int logical_smp_processor_id(void)
 {
diff -u linux-apic/include/asm-i386/mpspec.h-o linux-apic/include/asm-i386/mpspec.h
--- linux-apic/include/asm-i386/mpspec.h-o	2003-01-15 21:09:18.000000000 +0100
+++ linux-apic/include/asm-i386/mpspec.h	2003-04-27 02:45:25.000000000 +0200
@@ -16,7 +16,7 @@
 /*
  * a maximum of 16 APICs with the current APIC ID architecture.
  */
-#if defined(CONFIG_X86_NUMAQ) || defined (CONFIG_X86_SUMMIT)
+#if defined(CONFIG_X86_NUMAQ) || defined (CONFIG_X86_SUMMIT) || defined(CONFIG_X86_GENERICARCH)
 #define MAX_APICS 256
 #else
 #define MAX_APICS 16
diff -u linux-apic/include/asm-i386/apicdef.h-o linux-apic/include/asm-i386/apicdef.h
--- linux-apic/include/asm-i386/apicdef.h-o	2003-02-04 18:00:43.000000000 +0100
+++ linux-apic/include/asm-i386/apicdef.h	2003-04-27 02:45:25.000000000 +0200
@@ -11,13 +11,6 @@
 #define		APIC_DEFAULT_PHYS_BASE	0xfee00000
  
 #define		APIC_ID		0x20
-#ifdef CONFIG_X86_SUMMIT
- #define		APIC_ID_MASK		(0xFF<<24)
- #define		GET_APIC_ID(x)		(((x)>>24)&0xFF)
-#else
- #define		APIC_ID_MASK		(0x0F<<24)
- #define		GET_APIC_ID(x)		(((x)>>24)&0x0F)
-#endif
 #define		APIC_LVR	0x30
 #define			APIC_LVR_MASK		0xFF00FF
 #define			GET_APIC_VERSION(x)	((x)&0xFF)
diff -u linux-apic/include/asm-i386/numnodes.h-o linux-apic/include/asm-i386/numnodes.h
--- linux-apic/include/asm-i386/numnodes.h-o	2003-02-25 18:05:56.000000000 +0100
+++ linux-apic/include/asm-i386/numnodes.h	2003-04-27 02:45:25.000000000 +0200
@@ -5,7 +5,7 @@
 
 #ifdef CONFIG_X86_NUMAQ
 #include <asm/numaq.h>
-#elif CONFIG_X86_SUMMIT
+#elif CONFIG_NUMA
 #include <asm/srat.h>
 #else
 #define MAX_NUMNODES	1
diff -u linux-apic/include/asm-i386/mmzone.h-o linux-apic/include/asm-i386/mmzone.h
--- linux-apic/include/asm-i386/mmzone.h-o	2003-03-08 19:23:49.000000000 +0100
+++ linux-apic/include/asm-i386/mmzone.h	2003-04-27 02:45:25.000000000 +0200
@@ -120,7 +120,7 @@
 
 #ifdef CONFIG_X86_NUMAQ
 #include <asm/numaq.h>
-#elif CONFIG_X86_SUMMIT
+#elif CONFIG_NUMA	/* summit or generic arch */
 #include <asm/srat.h>
 #elif CONFIG_X86_PC
 #define get_memcfg_numa get_memcfg_numa_flat
diff -u linux-apic/include/asm-i386/genapic.h-o linux-apic/include/asm-i386/genapic.h
--- linux-apic/include/asm-i386/genapic.h-o	2003-04-27 02:45:25.000000000 +0200
+++ linux-apic/include/asm-i386/genapic.h	2003-04-27 02:45:25.000000000 +0200
@@ -0,0 +1,106 @@
+#ifndef _ASM_GENAPIC_H
+#define _ASM_GENAPIC_H 1
+
+/* 
+ * Generic APIC driver interface.
+ *  
+ * An straight forward mapping of the APIC related parts of the 
+ * x86 subarchitecture interface to a dynamic object.
+ *	
+ * This is used by the "generic" x86 subarchitecture. 
+ *
+ * Copyright 2003 Andi Kleen, SuSE Labs.
+ */
+
+struct mpc_config_translation;
+struct mpc_config_bus;
+struct mp_config_table;
+struct mpc_config_processor;
+
+struct genapic { 
+	char *name; 
+	int (*probe)(void); 
+
+	int (*apic_id_registered)(void);
+	unsigned long (*target_cpus)(void); 
+	int int_delivery_mode;
+	int int_dest_mode; 
+	int apic_broadcast_id; 
+	int esr_disable;
+	unsigned long (*check_apicid_used)(unsigned long bitmap, int apicid); 
+	unsigned long (*check_apicid_present)(int apicid); 
+	int no_balance_irq;
+	void (*init_apic_ldr)(void);
+	unsigned long (*ioapic_phys_id_map)(unsigned long map); 
+
+	void (*clustered_apic_check)(void);
+	int (*multi_timer_check)(int apic, int irq);
+	int (*apicid_to_node)(int logical_apicid); 
+	int (*cpu_to_logical_apicid)(int cpu);
+	int (*cpu_present_to_apicid)(int mps_cpu);
+	unsigned long (*apicid_to_cpu_present)(int phys_apicid); 
+	int (*mpc_apic_id)(struct mpc_config_processor *m, 
+			   struct mpc_config_translation *t); 
+	void (*setup_portio_remap)(void); 
+	int (*check_phys_apicid_present)(int boot_cpu_physical_apicid);
+
+	/* mpparse */
+	void (*mpc_oem_bus_info)(struct mpc_config_bus *, char *, 
+				 struct mpc_config_translation *);
+	void (*mpc_oem_pci_bus)(struct mpc_config_bus *, 
+				struct mpc_config_translation *); 
+
+	/* When one of the next two hooks returns 1 the genapic
+	   is switched to this. Essentially they are additional probe 
+	   functions. */
+	int (*mps_oem_check)(struct mp_config_table *mpc, char *oem, 
+			      char *productid);
+	int (*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
+
+	unsigned (*get_apic_id)(unsigned long x);
+	unsigned long apic_id_mask; 
+	
+	/* ipi */
+	void (*send_IPI_mask)(int mask, int vector);
+	void (*send_IPI_allbutself)(int vector);
+	void (*send_IPI_all)(int vector);
+}; 
+
+#define APICFUNC(x) .x = x
+
+#define APIC_INIT(aname, aprobe) { \
+	.name = aname, \
+	.probe = aprobe, \
+	.int_delivery_mode = INT_DELIVERY_MODE, \
+	.int_dest_mode = INT_DEST_MODE, \
+	.apic_broadcast_id = APIC_BROADCAST_ID, \
+	.no_balance_irq = NO_BALANCE_IRQ, \
+	APICFUNC(apic_id_registered), \
+	APICFUNC(target_cpus), \
+	APICFUNC(check_apicid_used), \
+	APICFUNC(check_apicid_present), \
+	APICFUNC(init_apic_ldr), \
+	APICFUNC(ioapic_phys_id_map), \
+	APICFUNC(clustered_apic_check), \
+	APICFUNC(multi_timer_check), \
+	APICFUNC(apicid_to_node), \
+	APICFUNC(cpu_to_logical_apicid), \
+	APICFUNC(cpu_present_to_apicid), \
+	APICFUNC(apicid_to_cpu_present), \
+	APICFUNC(mpc_apic_id), \
+	APICFUNC(setup_portio_remap), \
+	APICFUNC(check_phys_apicid_present), \
+	APICFUNC(mpc_oem_bus_info), \
+	APICFUNC(mpc_oem_pci_bus), \
+	APICFUNC(mps_oem_check), \
+	APICFUNC(get_apic_id), \
+	.apic_id_mask = APIC_ID_MASK, \
+	APICFUNC(acpi_madt_oem_check), \
+	APICFUNC(send_IPI_mask), \
+	APICFUNC(send_IPI_allbutself), \
+	APICFUNC(send_IPI_all), \
+	}
+
+extern struct genapic *genapic;
+
+#endif

