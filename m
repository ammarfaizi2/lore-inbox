Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTKBPg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 10:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTKBPg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 10:36:26 -0500
Received: from aun.it.uu.se ([130.238.12.36]:21695 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261735AbTKBPgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 10:36:23 -0500
Date: Sun, 2 Nov 2003 16:36:22 +0100 (MET)
Message-Id: <200311021536.hA2FaMmY016943@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH][2.6] CONFIG_HZ for x86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a CONFIG_HZ option to x86, allowing the kernel-
internal HZ to be reduced from 1000 to 512 or 100. This solves
lost timer interrupt problems on really old machines like my 486.
According to Alan Cox, HZ==1000 is also harmful on some laptops
(presumably due to long SMI windows), so this patch should be
useful for those too.

Selecting a lower HZ may also help thermal efficiency slightly,
by allowing machines to idle longer between timer interrupts.

HZ==100 also reduces the size of the kernel, since it eliminates
a lot of HZ<-->USER_HZ conversions.

HZ==512 may or may not be useful, but it does work. Why 512 and
not 500? It's to avoid having to correct for HZ != 1<<SHIFT_HZ
in kernel/timer.c:second_overflow().

The patch also fixes some jiffies_to_clock_t() buglets, which
cause warnings in fs/proc/proc_misc.c when (HZ % USER_HZ) != 0.

/Mikael

diff -ruN linux-2.6.0-test9/arch/i386/Kconfig linux-2.6.0-test9.config-hz/arch/i386/Kconfig
--- linux-2.6.0-test9/arch/i386/Kconfig	2003-10-09 00:24:52.000000000 +0200
+++ linux-2.6.0-test9.config-hz/arch/i386/Kconfig	2003-11-02 15:10:42.099258992 +0100
@@ -958,6 +958,26 @@
 
 endmenu
 
+choice
+	prompt "Kernel internal timer frequency"
+	default HZ_1000
+
+config HZ_1000
+	bool "1000"
+
+config HZ_512
+	bool "512"
+
+config HZ_100
+	bool "100"
+
+endchoice
+
+config HZ
+	int
+	default "1000" if HZ_1000
+	default "512" if HZ_512
+	default "100" if HZ_100
 
 menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
 
diff -ruN linux-2.6.0-test9/fs/proc/proc_misc.c linux-2.6.0-test9.config-hz/fs/proc/proc_misc.c
--- linux-2.6.0-test9/fs/proc/proc_misc.c	2003-09-28 12:19:52.000000000 +0200
+++ linux-2.6.0-test9.config-hz/fs/proc/proc_misc.c	2003-11-02 15:10:45.000000000 +0100
@@ -393,7 +393,7 @@
 			sum += kstat_cpu(i).irqs[j];
 	}
 
-	seq_printf(p, "cpu  %u %u %u %u %u %u %u\n",
+	seq_printf(p, "cpu  %lu %lu %lu %lu %lu %lu %lu\n",
 		jiffies_to_clock_t(user),
 		jiffies_to_clock_t(nice),
 		jiffies_to_clock_t(system),
@@ -403,7 +403,7 @@
 		jiffies_to_clock_t(softirq));
 	for (i = 0; i < NR_CPUS; i++){
 		if (!cpu_online(i)) continue;
-		seq_printf(p, "cpu%d %u %u %u %u %u %u %u\n",
+		seq_printf(p, "cpu%d %lu %lu %lu %lu %lu %lu %lu\n",
 			i,
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.user),
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.nice),
diff -ruN linux-2.6.0-test9/include/asm-i386/param.h linux-2.6.0-test9.config-hz/include/asm-i386/param.h
--- linux-2.6.0-test9/include/asm-i386/param.h	2002-07-06 12:33:14.000000000 +0200
+++ linux-2.6.0-test9.config-hz/include/asm-i386/param.h	2003-11-02 15:10:42.000000000 +0100
@@ -2,7 +2,7 @@
 #define _ASMi386_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ		1000		/* Internal kernel timer frequency */
+# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
 #endif
diff -ruN linux-2.6.0-test9/include/linux/times.h linux-2.6.0-test9.config-hz/include/linux/times.h
--- linux-2.6.0-test9/include/linux/times.h	2003-07-28 01:24:44.000000000 +0200
+++ linux-2.6.0-test9.config-hz/include/linux/times.h	2003-11-02 15:10:45.000000000 +0100
@@ -6,7 +6,7 @@
 #include <asm/types.h>
 
 #if (HZ % USER_HZ)==0
-# define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
+# define jiffies_to_clock_t(x) ((clock_t) ((x) / (HZ / USER_HZ)))
 #else
 # define jiffies_to_clock_t(x) ((clock_t) jiffies_64_to_clock_t((u64) x))
 #endif
