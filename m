Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbSKFCfz>; Tue, 5 Nov 2002 21:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSKFCfz>; Tue, 5 Nov 2002 21:35:55 -0500
Received: from modemcable074.85-202-24.mtl.mc.videotron.ca ([24.202.85.74]:41754
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265541AbSKFCfw>; Tue, 5 Nov 2002 21:35:52 -0500
Date: Tue, 5 Nov 2002 21:39:51 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH][2.5-AC] Forced enable/disable local APIC
Message-ID: <Pine.LNX.4.44.0211052138060.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The DMI stuff should be fine too.

Index: linux-2.5.45-ac1/arch/i386/kernel/apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.45-ac1/arch/i386/kernel/apic.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 apic.c
--- linux-2.5.45-ac1/arch/i386/kernel/apic.c	5 Nov 2002 04:47:02 -0000	1.1.1.1
+++ linux-2.5.45-ac1/arch/i386/kernel/apic.c	6 Nov 2002 00:19:38 -0000
@@ -609,11 +609,27 @@
 
 #endif	/* CONFIG_PM */
 
+int enable_local_apic_flag __initdata = 0; /* 0=probe, 1=force, 2=disable e.g. DMI */
+
+static int __init nolapic_setup(char *str)
+{
+	enable_local_apic_flag = 2;
+	return 1;
+}
+
+static int __init lapic_setup(char *str)
+{
+	enable_local_apic_flag = 1;
+	return 1;
+}
+
+__setup("nolapic", nolapic_setup);
+__setup("lapic", lapic_setup);
+
 /*
  * Detect and enable local APICs on non-SMP boards.
  * Original code written by Keir Fraser.
  */
-int dont_enable_local_apic __initdata = 0;
 
 static int __init detect_init_APIC (void)
 {
@@ -621,11 +637,14 @@
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
 	/* Disabled by DMI scan or kernel option? */
-	if (dont_enable_local_apic)
+	if (enable_local_apic_flag == 2)
 		return -1;
 
 	/* Workaround for us being called before identify_cpu(). */
 	get_cpu_vendor(&boot_cpu_data);
+	
+	if (enable_local_apic_flag == 1)
+		goto force_apic;
 
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
@@ -642,6 +661,7 @@
 		goto no_apic;
 	}
 
+force_apic:
 	if (!cpu_has_apic) {
 		/*
 		 * Some BIOSes disable the local APIC in the
Index: linux-2.5.45-ac1/arch/i386/kernel/dmi_scan.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.45-ac1/arch/i386/kernel/dmi_scan.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 dmi_scan.c
--- linux-2.5.45-ac1/arch/i386/kernel/dmi_scan.c	5 Nov 2002 04:47:02 -0000	1.1.1.1
+++ linux-2.5.45-ac1/arch/i386/kernel/dmi_scan.c	6 Nov 2002 00:22:02 -0000
@@ -314,9 +314,9 @@
 static int __init local_apic_kills_bios(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
-	extern int dont_enable_local_apic;
-	if (!dont_enable_local_apic) {
-		dont_enable_local_apic = 1;
+	extern int enable_local_apic_flag;
+	if (!enable_local_apic_flag) {
+		enable_local_apic_flag = 2;
 		printk(KERN_WARNING "%s with broken BIOS detected. "
 		       "Refusing to enable the local APIC.\n",
 		       d->ident);
@@ -333,9 +333,9 @@
 static int __init apm_kills_local_apic(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
-	extern int dont_enable_local_apic;
-	if (apm_info.bios.version && !dont_enable_local_apic) {
-		dont_enable_local_apic = 1;
+	extern int enable_local_apic_flag;
+	if (apm_info.bios.version && !enable_local_apic_flag) {
+		enable_local_apic_flag = 2;
 		printk(KERN_WARNING "%s with broken BIOS detected. "
 		       "Refusing to enable the local APIC.\n",
 		       d->ident);

-- 
function.linuxpower.ca

