Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRBHOt2>; Thu, 8 Feb 2001 09:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbRBHOtS>; Thu, 8 Feb 2001 09:49:18 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:9685 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129078AbRBHOtA>;
	Thu, 8 Feb 2001 09:49:00 -0500
Date: Thu, 8 Feb 2001 15:48:44 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200102081448.PAA02346@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4.1-ac6 UP-APIC bug fix
Cc: linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl, mingo@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains two CPU detection bug fixes:
- arch/i386/kernel/apic.c:detect_init_APIC():
  This is being run before identify_cpu(), so the x86_vendor
  field wasn't properly defined. It only _seemed_ to work before
  because uninitialised == 0 == X86_VENDOR_INTEL.
  The basic CPU detection code in head.S has set up most fields
  we need, all that's needed here is to call get_cpu_vendor()
  to convert the vendor string to its vendor code.
  [Maciej Rozycki is working on moving identify_cpu() to an earlier
  point in the boot process, which may subsume this fix; but for
  now, this fix is necessary.]
  The patch also permits AMD K7 Model > 1 to have its local APIC
  enabled, since testing indicates that it's P6 compatible.
- arch/i386/kernel/head.S: correct boot_cpu_data.x86_vendor_id[]
  offset. This bug has been in Linus' kernel since 2.4.0-test11
  when the x86_capability field was expanded from 1 to 4 words.
  The effect was that the initial vendor string was saved in the
  wrong location, breaking get_cpu_vendor() calls before identify_cpu().
  I suspect that dodgy_tsc() in setup.c was broken by this too.

Alan, please apply for -ac7.

/Mikael

--- linux-2.4.1-ac6/arch/i386/kernel/apic.c.~1~	Thu Feb  8 14:24:43 2001
+++ linux-2.4.1-ac6/arch/i386/kernel/apic.c	Thu Feb  8 14:56:48 2001
@@ -384,29 +384,33 @@
  * Original code written by Keir Fraser.
  */
 
-int detect_init_APIC (void)
+int __init detect_init_APIC (void)
 {
 	u32 h, l, dummy, features;
+	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
-		printk("No APIC support for non-Intel processors.\n");
-		return -1;
-	}
+	/* Workaround for us being called before identify_cpu(). */
+	get_cpu_vendor(&boot_cpu_data);
 
-	if (boot_cpu_data.x86 < 5) {
-		printk("No local APIC on pre-Pentium Intel processors.\n");
-		return -1;
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		if (boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model > 1)
+			break;
+		goto no_apic;
+	case X86_VENDOR_INTEL:
+		if (boot_cpu_data.x86 == 6 ||
+		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
+			break;
+		goto no_apic;
+	default:
+		goto no_apic;
 	}
 
 	if (!cpu_has_apic) {
-		if (boot_cpu_data.x86 == 5) {
-			printk("APIC turned off by hardware.\n");
-			return -1;
-		}
 		/*
 		 * Some BIOSes disable the local APIC in the
 		 * APIC_BASE MSR. This can only be done in
-		 * software for PPro and above.
+		 * software for Intel P6 and AMD K7 (Model > 1).
 		 */
 		rdmsr(MSR_IA32_APICBASE, l, h);
 		if (!(l & MSR_IA32_APICBASE_ENABLE)) {
@@ -434,6 +438,10 @@
 	printk("Found and enabled local APIC!\n");
 
 	return 0;
+
+no_apic:
+	printk("No local APIC present or hardware disabled\n");
+	return -1;
 }
 
 void __init init_apic_mappings(void)
--- linux-2.4.1-ac6/arch/i386/kernel/head.S.~1~	Tue Dec 12 13:57:57 2000
+++ linux-2.4.1-ac6/arch/i386/kernel/head.S	Thu Feb  8 14:33:45 2001
@@ -34,7 +34,7 @@
 #define X86_HARD_MATH	CPU_PARAMS+6
 #define X86_CPUID	CPU_PARAMS+8
 #define X86_CAPABILITY	CPU_PARAMS+12
-#define X86_VENDOR_ID	CPU_PARAMS+16
+#define X86_VENDOR_ID	CPU_PARAMS+28
 
 /*
  * swapper_pg_dir is the main page directory, address 0x00101000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
