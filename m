Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279570AbRKRO3m>; Sun, 18 Nov 2001 09:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279581AbRKRO3c>; Sun, 18 Nov 2001 09:29:32 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:25537 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S279570AbRKRO3Z>; Sun, 18 Nov 2001 09:29:25 -0500
Date: Sun, 18 Nov 2001 16:37:25 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] moving F0 0F bug check to bugs.h
In-Reply-To: <Pine.LNX.4.30.0111181512230.29315-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0111181631380.16977-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, Dave Jones wrote:

> hpa moved it (And some others) during his 2.3.99 big cleanup of setup.c
> and friends.

Hmm most of them were gone, but f00f is indeed still there in 2.4.15-pre6

> Whilst not an ideal solution, some people do silly things like
> putting a P150 and a P166 clocked to 150 into SMP boxes.
> It could be possible for 1 CPU to have the bug whilst another doesn't.

This particular bug hits all 586s so we're safe in this regard.

> It's questionable we should support such nightmare scenarios, but
> as this is __initcode anyway, it's not that big a deal.

ahh but isn't that the beauty of Linux ;)

Regards,
	Zwane Mwaikambo

diff against 2.4.15-pre6 again since i missed the f00f_trap. Also because
i kept referring it to 2.4.14-pre6 i really mean 2.4.15-pre6

diff -urbB linux-2.4.14-pre6-orig/arch/i386/kernel/setup.c linux-2.4.14-pre6-zm/arch/i386/kernel/setup.c
--- linux-2.4.14-pre6-orig/arch/i386/kernel/setup.c	Sun Nov 18 15:18:05 2001
+++ linux-2.4.14-pre6-zm/arch/i386/kernel/setup.c	Sun Nov 18 16:22:58 2001
@@ -2020,34 +2020,12 @@
 	set_bit(X86_FEATURE_CX8, &c->x86_capability);
 }

-
-extern void trap_init_f00f_bug(void);
-
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
Only in linux-2.4.14-pre6-zm/arch/i386/kernel: setup.c~
diff -urbB linux-2.4.14-pre6-orig/include/asm-i386/bugs.h linux-2.4.14-pre6-zm/include/asm-i386/bugs.h
--- linux-2.4.14-pre6-orig/include/asm-i386/bugs.h	Mon Nov  5 22:42:12 2001
+++ linux-2.4.14-pre6-zm/include/asm-i386/bugs.h	Sun Nov 18 16:23:30 2001
@@ -144,6 +144,26 @@
 }

 /*
+ * All current models of Pentium and Pentium with MMX technology CPUs
+ * have the F0 0F bug, which lets nonpriviledged users lock up the system.
+ * Note that the workaround only should be initialized once...
+ */
+
+extern void trap_init_f00f_bug(void);
+
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
@@ -213,5 +233,6 @@
 	check_fpu();
 	check_hlt();
 	check_popad();
+	check_f00f();
 	system_utsname.machine[1] = '0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
 }
Only in linux-2.4.14-pre6-zm/include/asm-i386: bugs.h~

