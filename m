Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285118AbSABTOK>; Wed, 2 Jan 2002 14:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287903AbSABTNV>; Wed, 2 Jan 2002 14:13:21 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:54758 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S287905AbSABTK3>;
	Wed, 2 Jan 2002 14:10:29 -0500
Date: Wed, 2 Jan 2002 20:10:28 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201021910.UAA18871@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] DMI/APIC updates 4 of 4: dmi-apic-fixups
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This is part 4 of 4 of a patch set for 2.5.2-pre6 to move the
x86 DMI scan to an earlier point in the boot sequence. This is
motivated by the UP APIC code, which must be disabled on some
machines with broken BIOSen, but there are also other cases that
would benefit from it. Tested. Please apply.

This last patch (patch-dmi-apic-fixups) adds DMI matching rules
and APIC workarounds to detect and handle machines known to have
UP APIC problems, currently Dell laptops and Intel's old AL440LX.
The UP APIC initialisation is moved from setup_arch() to trap_init();
this minor adjustment allows the UP APIC initialisation to respond
to DMI matches and explicit kernel command line options. To be
effective, this needs the early-dmi-scan patch I posted previously.

/Mikael

diff -ruN linux-2.5.2-pre6.early-dmi-scan/arch/i386/kernel/apic.c linux-2.5.2-pre6.dmi-apic-fixups/arch/i386/kernel/apic.c
--- linux-2.5.2-pre6.early-dmi-scan/arch/i386/kernel/apic.c	Wed Jan  2 00:43:14 2002
+++ linux-2.5.2-pre6.dmi-apic-fixups/arch/i386/kernel/apic.c	Wed Jan  2 00:59:58 2002
@@ -578,12 +578,17 @@
  * Detect and enable local APICs on non-SMP boards.
  * Original code written by Keir Fraser.
  */
+int dont_enable_local_apic __initdata = 0;
 
 static int __init detect_init_APIC (void)
 {
 	u32 h, l, features;
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
+	/* Disabled by DMI scan or kernel option? */
+	if (dont_enable_local_apic)
+		return -1;
+
 	/* Workaround for us being called before identify_cpu(). */
 	get_cpu_vendor(&boot_cpu_data);
 
@@ -901,8 +906,14 @@
 
 static unsigned int calibration_result;
 
+int dont_use_local_apic_timer __initdata = 0;
+
 void __init setup_APIC_clocks (void)
 {
+	/* Disabled by DMI scan or kernel option? */
+	if (dont_use_local_apic_timer)
+		return;
+
 	printk("Using local APIC timer interrupts.\n");
 	using_apic_timer = 1;
 
diff -ruN linux-2.5.2-pre6.early-dmi-scan/arch/i386/kernel/dmi_scan.c linux-2.5.2-pre6.dmi-apic-fixups/arch/i386/kernel/dmi_scan.c
--- linux-2.5.2-pre6.early-dmi-scan/arch/i386/kernel/dmi_scan.c	Wed Jan  2 01:01:06 2002
+++ linux-2.5.2-pre6.dmi-apic-fixups/arch/i386/kernel/dmi_scan.c	Wed Jan  2 00:59:58 2002
@@ -417,6 +417,43 @@
 	return 0;
 }
 
+/*
+ * Some machines, usually laptops, can't handle an enabled local APIC.
+ * The symptoms include hangs or reboots when suspending or resuming,
+ * attaching or detaching the power cord, or entering BIOS setup screens
+ * through magic key sequences.
+ */
+static int __init local_apic_kills_bios(struct dmi_blacklist *d)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	extern int dont_enable_local_apic;
+	if (!dont_enable_local_apic) {
+		dont_enable_local_apic = 1;
+		printk(KERN_WARNING "%s with broken BIOS detected. "
+		       "Refusing to enable the local APIC.\n",
+		       d->ident);
+	}
+#endif
+	return 0;
+}
+
+/*
+ * The Intel AL440LX mainboard will hang randomly if the local APIC
+ * timer is running and the APM BIOS hasn't been disabled.
+ */
+static int __init apm_kills_local_apic_timer(struct dmi_blacklist *d)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	extern int dont_use_local_apic_timer;
+	if (apm_info.bios.version && !dont_use_local_apic_timer) {
+		dont_use_local_apic_timer = 1;
+		printk(KERN_WARNING "%s with broken BIOS detected. "
+		       "The local APIC timer will not be used.\n",
+		       d->ident);
+	}
+#endif
+	return 0;
+}
 
 /*
  *	Simple "print if true" callback
@@ -561,6 +598,25 @@
 			MATCH(DMI_BIOS_DATE, "09/12/00"), NO_MATCH
 			} },
 
+	/* Machines which have problems handling enabled local APICs */
+
+	{ local_apic_kills_bios, "Dell Inspiron", {
+			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			MATCH(DMI_PRODUCT_NAME, "Inspiron"),
+			NO_MATCH, NO_MATCH
+			} },
+
+	{ local_apic_kills_bios, "Dell Latitude", {
+			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			MATCH(DMI_PRODUCT_NAME, "Latitude"),
+			NO_MATCH, NO_MATCH
+			} },
+
+	{ apm_kills_local_apic_timer, "Intel AL440LX", {
+			MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			MATCH(DMI_BOARD_NAME, "AL440LX"),
+			NO_MATCH, NO_MATCH } },
+
 	/* Problem Intel 440GX bioses */
 
 	{ broken_pirq, "SABR1 Bios", {			/* Bad $PIR */
diff -ruN linux-2.5.2-pre6.early-dmi-scan/arch/i386/kernel/setup.c linux-2.5.2-pre6.dmi-apic-fixups/arch/i386/kernel/setup.c
--- linux-2.5.2-pre6.early-dmi-scan/arch/i386/kernel/setup.c	Wed Jan  2 01:01:06 2002
+++ linux-2.5.2-pre6.dmi-apic-fixups/arch/i386/kernel/setup.c	Wed Jan  2 00:59:58 2002
@@ -870,7 +870,6 @@
 	 */
 	if (smp_found_config)
 		get_smp_config();
-	init_apic_mappings();
 #endif
 
 
diff -ruN linux-2.5.2-pre6.early-dmi-scan/arch/i386/kernel/traps.c linux-2.5.2-pre6.dmi-apic-fixups/arch/i386/kernel/traps.c
--- linux-2.5.2-pre6.early-dmi-scan/arch/i386/kernel/traps.c	Tue Dec 18 00:40:11 2001
+++ linux-2.5.2-pre6.dmi-apic-fixups/arch/i386/kernel/traps.c	Wed Jan  2 00:59:58 2002
@@ -920,6 +920,10 @@
 		EISA_bus = 1;
 #endif
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	init_apic_mappings();
+#endif
+
 	set_trap_gate(0,&divide_error);
 	set_trap_gate(1,&debug);
 	set_intr_gate(2,&nmi);
