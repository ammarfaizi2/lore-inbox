Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbTAJIpi>; Fri, 10 Jan 2003 03:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbTAJIpi>; Fri, 10 Jan 2003 03:45:38 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:11196 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264631AbTAJIpe>; Fri, 10 Jan 2003 03:45:34 -0500
Date: Fri, 10 Jan 2003 09:54:43 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Richard A Nelson <cowboy@debian.org>, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2.4.21-pre3-ac1/2 and CONFIG_CPU_FREQ failure
Message-ID: <20030110085443.GA5269@brodo.de>
References: <Pine.LNX.4.51.0301091807300.24500@nqynaqf.yrkvatgba.voz.pbz> <16534.1042162736@www24.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16534.1042162736@www24.gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for that, the attached patch should fix it. It updates the timer
notifier code to the version which got into 2.5.55.

	Dominik

On Fri, Jan 10, 2003 at 02:38:56AM +0100, Richard A Nelson wrote:
> If CONFIG_CPU_FREQ is set, and CONFIG_SMP isn't,
> ./arch/i386/kernel/time.c will fail to compile at line 946:
> 
> #if defined(CONFIG_CPU_FREQ) && !defined(CONFIG_SMP)
>     cpufreq_register_notifier(&time_cpufreq_notifier_block,
> CPUFREQ_TRANSITION_NOTIFIER);
> #endif
> 
> There is no definition of time_cpufreq_notifier_block

diff -ruN linux-original/arch/i386/kernel/elanfreq.c linux/arch/i386/kernel/elanfreq.c
--- linux-original/arch/i386/kernel/elanfreq.c	2003-01-10 09:40:32.000000000 +0100
+++ linux/arch/i386/kernel/elanfreq.c	2003-01-10 09:47:07.000000000 +0100
@@ -31,8 +31,6 @@
 #define REG_CSCIR 0x22 		/* Chip Setup and Control Index Register    */
 #define REG_CSCDR 0x23		/* Chip Setup and Control Data  Register    */
 
-#define SAFE_FREQ 33000		/* every Elan CPU can run at 33 MHz         */
-
 static struct cpufreq_driver *elanfreq_driver;
 
 /* Module parameter */
diff -ruN linux-original/arch/i386/kernel/longhaul.c linux/arch/i386/kernel/longhaul.c
--- linux-original/arch/i386/kernel/longhaul.c	2003-01-10 09:40:32.000000000 +0100
+++ linux/arch/i386/kernel/longhaul.c	2003-01-10 09:46:56.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  $Id: longhaul.c,v 1.77 2002/10/31 21:17:40 db Exp $
+ *  $Id: longhaul.c,v 1.83 2003/01/02 22:16:26 db Exp $
  *
  *  (C) 2001  Dave Jones. <davej@suse.de>
  *  (C) 2002  Padraig Brady. <padraig@antefacto.com>
diff -ruN linux-original/arch/i386/kernel/longrun.c linux/arch/i386/kernel/longrun.c
--- linux-original/arch/i386/kernel/longrun.c	2003-01-10 09:40:32.000000000 +0100
+++ linux/arch/i386/kernel/longrun.c	2003-01-10 09:46:50.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  $Id: longrun.c,v 1.14 2002/10/31 21:17:40 db Exp $
+ *  $Id: longrun.c,v 1.18 2003/01/02 22:16:26 db Exp $
  *
  * (C) 2002  Dominik Brodowski <linux@brodo.de>
  *
diff -ruN linux-original/arch/i386/kernel/p4-clockmod.c linux/arch/i386/kernel/p4-clockmod.c
--- linux-original/arch/i386/kernel/p4-clockmod.c	2003-01-10 09:40:32.000000000 +0100
+++ linux/arch/i386/kernel/p4-clockmod.c	2003-01-10 09:46:17.000000000 +0100
@@ -213,7 +213,7 @@
 }
 
 
-int __init cpufreq_p4_init(void)
+static int __init cpufreq_p4_init(void)
 {	
 	struct cpuinfo_x86 *c = cpu_data;
 	int cpuid;
@@ -245,6 +245,16 @@
 	}
 
 	printk(KERN_INFO PFX "P4/Xeon(TM) CPU On-Demand Clock Modulation available\n");
+
+	if (!stock_freq) {
+		if (cpu_khz)
+			stock_freq = cpu_khz;
+		else {
+			printk(KERN_INFO PFX "unknown core frequency - please use module parameter 'stock_freq'\n");
+			return -EINVAL;
+		}
+	}
+
 	driver = kmalloc(sizeof(struct cpufreq_driver) +
 			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!driver)
@@ -252,9 +262,6 @@
 
 	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
-	if (!stock_freq)
-		stock_freq = cpu_khz;
-
 #ifdef CONFIG_CPU_FREQ_24_API
 	for (i=0;i<NR_CPUS;i++) {
 		driver->cpu_cur_freq[i] = stock_freq;
@@ -290,7 +297,7 @@
 }
 
 
-void __exit cpufreq_p4_exit(void)
+static void __exit cpufreq_p4_exit(void)
 {
 	unsigned int i;
 
diff -ruN linux-original/arch/i386/kernel/powernow-k6.c linux/arch/i386/kernel/powernow-k6.c
--- linux-original/arch/i386/kernel/powernow-k6.c	2003-01-10 09:40:32.000000000 +0100
+++ linux/arch/i386/kernel/powernow-k6.c	2003-01-10 09:46:29.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  $Id: powernow-k6.c,v 1.36 2002/10/31 21:17:40 db Exp $
+ *  $Id: powernow-k6.c,v 1.42 2003/01/02 22:41:08 db Exp $
  *  This file was part of Powertweak Linux (http://powertweak.sf.net)
  *  and is shared with the Linux Kernel module.
  *
diff -ruN linux-original/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-original/arch/i386/kernel/setup.c	2003-01-10 09:40:32.000000000 +0100
+++ linux/arch/i386/kernel/setup.c	2003-01-10 09:42:38.000000000 +0100
@@ -104,8 +104,6 @@
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/seq_file.h>
-#include <linux/notifier.h>
-#include <linux/cpufreq.h>
 #include <asm/processor.h>
 #include <linux/console.h>
 #include <asm/mtrr.h>
@@ -209,40 +207,6 @@
 #define RAMDISK_LOAD_FLAG		0x4000	
 
 
-#ifdef CONFIG_CPU_FREQ
-static unsigned long loops_per_jiffy_ref = 0;
-static unsigned int  ref_freq = 0;
-
-static int
-loops_per_jiffy_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-				       void *data)
-{
-	struct cpufreq_freqs *freq = data;
-
-	if (!loops_per_jiffy_ref) {
-		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
-		ref_freq = freq->old;
-	}
-
-	switch (val) {
-	case CPUFREQ_PRECHANGE:
-		if (freq->old < freq->new)
-		        cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
-		break;
-	case CPUFREQ_POSTCHANGE:
-		if (freq->new < freq->old)
-		        cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
-		break;
-	}
-
-	return 0;
-}
-
-static struct notifier_block loops_per_jiffy_cpufreq_notifier_block = {
-	.notifier_call	= loops_per_jiffy_cpufreq_notifier
-};
-#endif
-
 #ifdef	CONFIG_VISWS
 char visws_board_type = -1;
 char visws_board_rev = -1;
@@ -2912,11 +2876,6 @@
 		for ( i = 0 ; i < NCAPINTS ; i++ )
 			boot_cpu_data.x86_capability[i] &= c->x86_capability[i];
 	}
-#ifdef CONFIG_CPU_FREQ
-	if (c == &boot_cpu_data) {
-			cpufreq_register_notifier(&loops_per_jiffy_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
-	}
-#endif
 
 	printk(KERN_DEBUG "CPU:             Common caps: %08x %08x %08x %08x\n",
 	       boot_cpu_data.x86_capability[0],
diff -ruN linux-original/arch/i386/kernel/speedstep.c linux/arch/i386/kernel/speedstep.c
--- linux-original/arch/i386/kernel/speedstep.c	2003-01-10 09:40:32.000000000 +0100
+++ linux/arch/i386/kernel/speedstep.c	2003-01-10 09:46:41.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  $Id: speedstep.c,v 1.58 2002/11/11 15:35:46 db Exp $
+ *  $Id: speedstep.c,v 1.64 2003/01/02 22:16:26 db Exp $
  *
  * (C) 2001  Dave Jones, Arjan van de ven.
  * (C) 2002  Dominik Brodowski <linux@brodo.de>
@@ -659,7 +659,7 @@
 		return -ENODEV;
 	}
 
-	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.58 $\n");
+	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.64 $\n");
 	dprintk(KERN_DEBUG "cpufreq: chipset 0x%x - processor 0x%x\n", 
 	       speedstep_chipset, speedstep_processor);
 
diff -ruN linux-original/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux-original/arch/i386/kernel/time.c	2003-01-10 09:40:32.000000000 +0100
+++ linux/arch/i386/kernel/time.c	2003-01-10 09:45:34.000000000 +0100
@@ -42,6 +42,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <linux/notifier.h>
 #include <linux/cpufreq.h>
 
 #include <asm/io.h>
@@ -827,46 +828,45 @@
 }
 
 #ifdef CONFIG_CPU_FREQ
+static unsigned int  ref_freq = 0;
+static unsigned long loops_per_jiffy_ref = 0;
 
+#ifndef CONFIG_SMP
 static unsigned long fast_gettimeoffset_ref = 0;
 static unsigned long cpu_khz_ref = 0;
-static unsigned int  ref_freq = 0;
+#endif
 
 static int
-tsc_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 		       void *data)
 {
 	struct cpufreq_freqs *freq = data;
 
-	if (!use_tsc)
-		return 0;
-
-	if (!fast_gettimeoffset_ref) {
+	if (!ref_freq) {
+		ref_freq = freq->old;
+		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
+#ifndef CONFIG_SMP
 		fast_gettimeoffset_ref = fast_gettimeoffset_quotient;
 		cpu_khz_ref = cpu_khz;
-		ref_freq = freq->old;
+#endif
 	}
 
-	switch (val) {
-	case CPUFREQ_PRECHANGE:
-		if (freq->old < freq->new) {
-		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
-		        cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
-		}
-		break;
-	case CPUFREQ_POSTCHANGE:
-		if (freq->new < freq->old) {
-		        fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
-		        cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
+	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
+	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
+		cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+#ifndef CONFIG_SMP
+		if (use_tsc) {
+			fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
+			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
 		}
-		break;
+#endif
 	}
 
 	return 0;
 }
 
-static struct notifier_block tsc_cpufreq_notifier_block = {
-	.notifier_call	= tsc_cpufreq_notifier
+static struct notifier_block time_cpufreq_notifier_block = {
+	.notifier_call	= time_cpufreq_notifier
 };
 #endif
 
@@ -942,7 +942,7 @@
 		}
 	}
 
-#if defined(CONFIG_CPU_FREQ) && !defined(CONFIG_SMP)
+#ifdef CONFIG_CPU_FREQ
 	cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 #endif
 
diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-01-10 09:40:46.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-01-10 09:48:35.000000000 +0100
@@ -5,7 +5,7 @@
  *            (C) 2002 Dominik Brodowski <linux@brodo.de>
  *            
  *
- * $Id: cpufreq.h,v 1.29 2002/11/11 15:35:47 db Exp $
+ * $Id: cpufreq.h,v 1.32 2003/01/02 22:16:27 db Exp $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-01-10 09:40:52.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-01-10 09:47:48.000000000 +0100
@@ -4,7 +4,7 @@
  *  Copyright (C) 2001 Russell King
  *            (C) 2002 Dominik Brodowski <linux@brodo.de>
  *
- *  $Id: cpufreq.c,v 1.50 2002/11/11 15:35:48 db Exp $
+ *  $Id: cpufreq.c,v 1.55 2003/01/10 08:39:18 db Exp $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
