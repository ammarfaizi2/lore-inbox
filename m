Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279509AbRKRNoE>; Sun, 18 Nov 2001 08:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279556AbRKRNny>; Sun, 18 Nov 2001 08:43:54 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:27323 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S279509AbRKRNno>; Sun, 18 Nov 2001 08:43:44 -0500
Date: Sun, 18 Nov 2001 15:51:37 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] moving F0 0F bug check to bugs.h
Message-ID: <Pine.LNX.4.33.0111181540190.16977-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any reason why the F0 0F bug check isn't in bugs.h? We only
check for the bug once so we might as well move it to check the boot cpu
only in bugs.h. Diffed against 2.4.14-pre6, please consider for
applying.

Regards,
	Zwane Mwaikambo


diff -urbB linux-2.4.14-pre6-orig/arch/i386/kernel/setup.c linux-2.4.14-pre6-zm/arch/i386/kernel/setup.c
--- linux-2.4.14-pre6-orig/arch/i386/kernel/setup.c	Sun Nov 18 15:18:05 2001
+++ linux-2.4.14-pre6-zm/arch/i386/kernel/setup.c	Sun Nov 18 15:28:54 2001
@@ -2025,29 +2025,10 @@

 static void __init init_intel(struct cpuinfo_x86 *c)
 {
-#ifndef CONFIG_M686
-	static int f00f_workaround_enabled = 0;
-#endif
 	char *p = NULL;
 	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */

-#ifndef CONFIG_M686
-	/*
-	 * All current models of Pentium and Pentium with MMX technology CPUs
-	 * have the F0 0F bug, which lets nonpriviledged users lock up the system.
-	 * Note that the workaround only should be initialized once...
-	 */
-	c->f00f_bug = 0;
-	if ( c->x86 == 5 ) {
-		c->f00f_bug = 1;
-		if ( !f00f_workaround_enabled ) {
-			trap_init_f00f_bug();
-			printk(KERN_NOTICE "Intel Pentium with F0 0F bug - workaround enabled.\n");
-			f00f_workaround_enabled = 1;
-		}
-	}
-#endif
-
+	c->f00f_bug = boot_cpu_data.f00f_bug;	/* to avoid confusion */

 	if (c->cpuid_level > 1) {
 		/* supports eax=2  call */
diff -urbB linux-2.4.14-pre6-orig/include/asm-i386/bugs.h linux-2.4.14-pre6-zm/include/asm-i386/bugs.h
--- linux-2.4.14-pre6-orig/include/asm-i386/bugs.h	Mon Nov  5 22:42:12 2001
+++ linux-2.4.14-pre6-zm/include/asm-i386/bugs.h	Sun Nov 18 15:27:54 2001
@@ -144,6 +144,23 @@
 }

 /*
+ * All current models of Pentium and Pentium with MMX technology CPUs
+ * have the F0 0F bug, which lets nonpriviledged users lock up the system.
+ * Note that the workaround only should be initialized once...
+ */
+static void __init check_f00f(void)
+{
+#ifndef CONFIG_M686
+	boot_cpu_data.f00f_bug = 0;
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 5)) {
+		boot_cpu_data.f00f_bug = 1;
+		trap_init_f00f_bug();
+		printk(KERN_NOTICE "Intel Pentium with F0 0F bug - workaround enabled.\n");
+	}
+#endif
+}
+
+/*
  * Check whether we are able to run this kernel safely on SMP.
  *
  * - In order to run on a i386, we need to be compiled for i386
@@ -213,5 +230,6 @@
 	check_fpu();
 	check_hlt();
 	check_popad();
+	check_f00f();
 	system_utsname.machine[1] = '0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
 }

