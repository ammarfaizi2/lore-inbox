Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbTHYUV6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 16:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTHYUV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 16:21:58 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:57571 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262301AbTHYUVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 16:21:51 -0400
Date: Mon, 25 Aug 2003 22:21:11 +0200 (MEST)
Message-Id: <200308252021.h7PKLBYB015229@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo@conectiva.com.br
Subject: 2.4.22 local APIC updates 2/3: add lapic/nolapic options
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

This patch adds the lapic and nolapic kernel options, which give
users greater control of the local APIC enable process on x86:
- "nolapic" prevents the kernel from enabling or using the local
  APIC. This is stronger than listing a machine in the DMI scan
  blacklist, since it also works for machines that boot with the
  local APIC already enabled.
  "nolapic" can also be seen as a simple-to-deploy alternative to
  keeping the DMI blacklist rules up-to-date.
- "lapic" tells the kernel to force-enable the P4 local APIC if
  the BIOS disabled it. This is needed on some machines. The
  default (don't enable if BIOS didn't) can't be changed since
  there is an even larger number of P4s where ACPI breaks if the
  local APIC is enabled.

Backport from 2.6.0-test4. Tested in 2.4.22-rc. Please apply.

This patch renames the dont_enable_local_apic variable, so if you
apply it you also need to apply "local APIC updates 1/3: remove
incorrect blacklist rules".

/Mikael

diff -ruN linux-2.4.22/Documentation/kernel-parameters.txt linux-2.4.22.apic-options/Documentation/kernel-parameters.txt
--- linux-2.4.22/Documentation/kernel-parameters.txt	2003-08-25 20:07:40.000000000 +0200
+++ linux-2.4.22.apic-options/Documentation/kernel-parameters.txt	2003-08-25 20:15:50.000000000 +0200
@@ -278,6 +278,8 @@
 
 	keepinitrd	[HW, ARM]
 
+	lapic		[IA-32,APIC] Enable the local APIC even if BIOS disabled it.
+
 	load_ramdisk=	[RAM] List of ramdisks to load from floppy.
 
 	lockd.udpport=	[NFS]
@@ -414,6 +416,8 @@
 
 	nointroute	[IA-64]
  
+	nolapic		[IA-32,APIC] Do not enable or use the local APIC.
+
 	no-scroll	[VGA]
 
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel.
diff -ruN linux-2.4.22/arch/i386/kernel/apic.c linux-2.4.22.apic-options/arch/i386/kernel/apic.c
--- linux-2.4.22/arch/i386/kernel/apic.c	2003-06-14 13:30:19.000000000 +0200
+++ linux-2.4.22.apic-options/arch/i386/kernel/apic.c	2003-08-25 20:15:50.000000000 +0200
@@ -593,7 +593,26 @@
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
@@ -601,7 +620,7 @@
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
-		    (boot_cpu_data.x86 == 15 && cpu_has_apic) ||
+		    (boot_cpu_data.x86 == 15 && (cpu_has_apic || enable_local_apic > 0)) ||
 		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
 			break;
 		goto no_apic;
@@ -1152,6 +1171,9 @@
  */
 int __init APIC_init_uniprocessor (void)
 {
+	if (enable_local_apic < 0)
+		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
+
 	if (!smp_found_config && !cpu_has_apic)
 		return -1;
 
diff -ruN linux-2.4.22/arch/i386/kernel/dmi_scan.c linux-2.4.22.apic-options/arch/i386/kernel/dmi_scan.c
--- linux-2.4.22/arch/i386/kernel/dmi_scan.c	2003-08-25 20:07:40.000000000 +0200
+++ linux-2.4.22.apic-options/arch/i386/kernel/dmi_scan.c	2003-08-25 20:15:50.000000000 +0200
@@ -335,9 +335,9 @@
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
