Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271846AbTG2QOX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271886AbTG2QOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:14:22 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:6101 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S271846AbTG2QOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:14:06 -0400
Date: Tue, 29 Jul 2003 18:14:03 +0200 (MEST)
Message-Id: <200307291614.h6TGE3Q9010535@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][CFT][2.6.0-test2] local APIC enable fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There has been a number of problem reports about local APIC
interacting badly with ACPI on P4s due to the P4 local APIC
force-enable change in 2.5.74,

This patch reverts the 2.5.74 patch, so if the BIOS disables
the local APIC on a P4, we don't enable it by default any more.

The rescue the situation for those P4 systems where the local
APIC _can_ be enabled safely, I've added two kernel parameters
that can be used to override broken BIOSen:
- "nolapic" prevents the kernel from enabling or using the local
  APIC. This is stronger than listing a machine in the DMI scan
  blacklist, since it also works for machines that boot with the
  local APIC already enabled.
- "lapic" tells the kernel to force-enable the P4 local APIC if
  the BIOS disabled it. I haven't changed the logic for P6/K7
  family processors, so we still force-enable those unless
  "nolapic" was passed to the kernel.

The patch also includes a cleanup: the dont_use_local_apic_timer
flag variable is not set any more since 2.5.74, so it's removed.

Please test.

/Mikael

diff -ruN linux-2.6.0-test2/Documentation/kernel-parameters.txt linux-2.6.0-test2.apic-fixes/Documentation/kernel-parameters.txt
--- linux-2.6.0-test2/Documentation/kernel-parameters.txt	2003-07-14 13:17:24.000000000 +0200
+++ linux-2.6.0-test2.apic-fixes/Documentation/kernel-parameters.txt	2003-07-29 15:55:38.000000000 +0200
@@ -436,6 +436,8 @@
 
 	l2cr=		[PPC]
 
+	lapic		[IA-32,APIC] Enable the local APIC even if BIOS disabled it.
+
 	lasi=		[HW,SCSI] PARISC LASI driver for the 53c700 chip
 			Format: addr:<io>,irq:<irq>
 
@@ -625,6 +627,8 @@
 
 	nointroute	[IA-64]
 
+	nolapic		[IA-32,APIC] Do not enable or use the local APIC.
+
 	nomce		[IA-32] Machine Check Exception
 
 	noresume	[SWSUSP] Disables resume and restore original swap space.
diff -ruN linux-2.6.0-test2/arch/i386/kernel/apic.c linux-2.6.0-test2.apic-fixes/arch/i386/kernel/apic.c
--- linux-2.6.0-test2/arch/i386/kernel/apic.c	2003-07-03 12:32:41.000000000 +0200
+++ linux-2.6.0-test2.apic-fixes/arch/i386/kernel/apic.c	2003-07-29 15:55:41.000000000 +0200
@@ -594,7 +594,26 @@
  * Detect and enable local APICs on non-SMP boards.
  * Original code written by Keir Fraser.
  */
-int dont_enable_local_apic __initdata = 0;
+
+/*
+ * Knob to control our willingness to enable the local APIC.
+ */
+int enable_local_apic __initdata = 0; /* -1=force-disable, +1=force-enable */
+
+static int __init lapic_disable(char *str)
+{
+	enable_local_apic = -1;
+	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
+	return 0;
+}
+__setup("nolapic", lapic_disable);
+
+static int __init lapic_enable(char *str)
+{
+	enable_local_apic = 1;
+	return 0;
+}
+__setup("lapic", lapic_enable);
 
 static int __init detect_init_APIC (void)
 {
@@ -602,7 +621,7 @@
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
 	/* Disabled by DMI scan or kernel option? */
-	if (dont_enable_local_apic)
+	if (enable_local_apic < 0)
 		return -1;
 
 	/* Workaround for us being called before identify_cpu(). */
@@ -616,7 +635,7 @@
 		goto no_apic;
 	case X86_VENDOR_INTEL:
 		if (boot_cpu_data.x86 == 6 ||
-		    boot_cpu_data.x86 == 15 ||
+		    (boot_cpu_data.x86 == 15 && (cpu_has_apic || enable_local_apic > 0)) ||
 		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
 			break;
 		goto no_apic;
@@ -897,14 +916,8 @@
 
 static unsigned int calibration_result;
 
-int dont_use_local_apic_timer __initdata = 0;
-
 void __init setup_boot_APIC_clock(void)
 {
-	/* Disabled by DMI scan or kernel option? */
-	if (dont_use_local_apic_timer)
-		return;
-
 	printk("Using local APIC timer interrupts.\n");
 	using_apic_timer = 1;
 
@@ -1121,6 +1134,9 @@
  */
 int __init APIC_init_uniprocessor (void)
 {
+	if (enable_local_apic < 0)
+		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
+
 	if (!smp_found_config && !cpu_has_apic)
 		return -1;
 
diff -ruN linux-2.6.0-test2/arch/i386/kernel/dmi_scan.c linux-2.6.0-test2.apic-fixes/arch/i386/kernel/dmi_scan.c
--- linux-2.6.0-test2/arch/i386/kernel/dmi_scan.c	2003-06-17 12:51:19.000000000 +0200
+++ linux-2.6.0-test2.apic-fixes/arch/i386/kernel/dmi_scan.c	2003-07-29 15:55:38.000000000 +0200
@@ -300,9 +300,9 @@
 static int __init local_apic_kills_bios(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
-	extern int dont_enable_local_apic;
-	if (!dont_enable_local_apic) {
-		dont_enable_local_apic = 1;
+	extern int enable_local_apic;
+	if (enable_local_apic == 0) {
+		enable_local_apic = -1;
 		printk(KERN_WARNING "%s with broken BIOS detected. "
 		       "Refusing to enable the local APIC.\n",
 		       d->ident);
