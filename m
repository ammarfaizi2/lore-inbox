Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVCHBlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVCHBlX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 20:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVCGWk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:40:27 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:65270 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261838AbVCGVsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:48:14 -0500
Date: Mon, 7 Mar 2005 13:48:08 -0800
From: Frank Rowand <frowand@mvista.com>
Message-Id: <200503072148.j27Lm8Hu006320@localhost.localdomain>
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH 2/5] ppc RT: ppc_cpu_khz.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Source: MontaVista Software, Inc.
Signed-off-by: Frank Rowand <frowand@mvista.com>

Index: linux-2.6.10/arch/ppc/platforms/prpmc800.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/prpmc800.c
+++ linux-2.6.10/arch/ppc/platforms/prpmc800.c
@@ -331,6 +331,7 @@ static void __init prpmc800_calibrate_de
 		tb_ticks_per_second = 100000000 / 4;
 		tb_ticks_per_jiffy = tb_ticks_per_second / HZ;
 		tb_to_us = mulhwu_scale_factor(tb_ticks_per_second, 1000000);
+		cpu_khz = tb_ticks_per_second / 1000;
 		return;
 	}
 
@@ -371,6 +372,7 @@ static void __init prpmc800_calibrate_de
 	tb_ticks_per_second = (tbl_end - tbl_start) * 2;
 	tb_ticks_per_jiffy = tb_ticks_per_second / HZ;
 	tb_to_us = mulhwu_scale_factor(tb_ticks_per_second, 1000000);
+	cpu_khz = tb_ticks_per_second / 1000;
 }
 
 static void prpmc800_restart(char *cmd)
Index: linux-2.6.10/arch/ppc/syslib/m8xx_setup.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/syslib/m8xx_setup.c
+++ linux-2.6.10/arch/ppc/syslib/m8xx_setup.c
@@ -163,6 +163,7 @@ void __init m8xx_calibrate_decr(void)
         printk("Decrementer Frequency = %d/%d\n", freq, divisor);
         tb_ticks_per_jiffy = freq / HZ / divisor;
 	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
+	cpu_khz = (freq / divisor) / 1000;
 
 	/* Perform some more timer/timebase initialization.  This used
 	 * to be done elsewhere, but other changes caused it to get
Index: linux-2.6.10/arch/ppc/platforms/chrp_time.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/chrp_time.c
+++ linux-2.6.10/arch/ppc/platforms/chrp_time.c
@@ -191,4 +191,5 @@ void __init chrp_calibrate_decr(void)
  	       freq/1000000, freq%1000000);
 	tb_ticks_per_jiffy = freq / HZ;
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
+	cpu_khz = freq / 1000;
 }
Index: linux-2.6.10/arch/ppc/platforms/gemini_setup.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/gemini_setup.c
+++ linux-2.6.10/arch/ppc/platforms/gemini_setup.c
@@ -465,6 +465,7 @@ void __init gemini_calibrate_decr(void)
 	divisor = 4;
 	tb_ticks_per_jiffy = freq / HZ / divisor;
 	tb_to_us = mulhwu_scale_factor(freq/divisor, 1000000);
+	cpu_khz = (freq / divisor) / 1000;
 }
 
 unsigned long __init gemini_find_end_of_memory(void)
Index: linux-2.6.10/include/asm-ppc/time.h
===================================================================
--- linux-2.6.10.orig/include/asm-ppc/time.h
+++ linux-2.6.10/include/asm-ppc/time.h
@@ -20,6 +20,7 @@
 extern unsigned tb_ticks_per_jiffy;
 extern unsigned tb_to_us;
 extern unsigned tb_last_stamp;
+extern unsigned long cpu_khz;
 extern unsigned long disarm_decr[NR_CPUS];
 
 extern void to_tm(int tim, struct rtc_time * tm);
Index: linux-2.6.10/arch/ppc/platforms/pmac_time.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/pmac_time.c
+++ linux-2.6.10/arch/ppc/platforms/pmac_time.c
@@ -198,6 +198,7 @@ via_calibrate_decr(void)
 
 	tb_ticks_per_jiffy = (dstart - dend) / (6 * (HZ/100));
 	tb_to_us = mulhwu_scale_factor(dstart - dend, 60000);
+	cpu_khz = (dstart - dend) / 60;
 
 	printk(KERN_INFO "via_calibrate_decr: ticks per jiffy = %u (%u ticks)\n",
 	       tb_ticks_per_jiffy, dstart - dend);
@@ -289,4 +290,5 @@ pmac_calibrate_decr(void)
 	       freq/1000000, freq%1000000);
 	tb_ticks_per_jiffy = freq / HZ;
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
+	cpu_khz = freq / 1000;
 }
Index: linux-2.6.10/arch/ppc/platforms/apus_setup.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/apus_setup.c
+++ linux-2.6.10/arch/ppc/platforms/apus_setup.c
@@ -282,6 +282,7 @@ void apus_calibrate_decr(void)
 	       freq/1000000, freq%1000000);
 	tb_ticks_per_jiffy = freq / HZ;
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
+	cpu_khz = freq / 1000;
 
 	__bus_speed = bus_speed;
 	__speed_test_failed = speed_test_failed;
Index: linux-2.6.10/arch/ppc/platforms/k2.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/k2.c
+++ linux-2.6.10/arch/ppc/platforms/k2.c
@@ -411,6 +411,7 @@ static void __init k2_calibrate_decr(voi
 	freq = k2_get_bus_speed();
 	tb_ticks_per_jiffy = freq / HZ / divisor;
 	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
+	cpu_khz = (freq / divisor) / 1000;
 }
 
 static int k2_show_cpuinfo(struct seq_file *m)
Index: linux-2.6.10/arch/ppc/platforms/powerpmc250.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/powerpmc250.c
+++ linux-2.6.10/arch/ppc/platforms/powerpmc250.c
@@ -167,6 +167,7 @@ powerpmc250_calibrate_decr(void)
 
 	tb_ticks_per_jiffy = freq / (HZ * divisor);
 	tb_to_us = mulhwu_scale_factor(freq/divisor, 1000000);
+	cpu_khz = (freq / divisor) / 1000;
 }
 
 static void
Index: linux-2.6.10/arch/ppc/syslib/m8260_setup.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/syslib/m8260_setup.c
+++ linux-2.6.10/arch/ppc/syslib/m8260_setup.c
@@ -78,6 +78,7 @@ m8260_calibrate_decr(void)
         divisor = 4;
         tb_ticks_per_jiffy = freq / HZ / divisor;
 	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
+	cpu_khz = (freq / divisor) / 1000;
 }
 
 /* The 8260 has an internal 1-second timer update register that
Index: linux-2.6.10/arch/ppc/syslib/ibm44x_common.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/syslib/ibm44x_common.c
+++ linux-2.6.10/arch/ppc/syslib/ibm44x_common.c
@@ -60,6 +60,7 @@ void __init ibm44x_calibrate_decr(unsign
 {
 	tb_ticks_per_jiffy = freq / HZ;
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
+	cpu_khz = freq / 1000;
 
 	/* Set the time base to zero */
 	mtspr(SPRN_TBWL, 0);
Index: linux-2.6.10/arch/ppc/platforms/prpmc750.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/prpmc750.c
+++ linux-2.6.10/arch/ppc/platforms/prpmc750.c
@@ -271,6 +271,7 @@ static void __init prpmc750_calibrate_de
 
 	tb_ticks_per_jiffy = freq / (HZ * divisor);
 	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
+	cpu_khz = (freq / divisor) / 1000;
 }
 
 static void prpmc750_restart(char *cmd)
Index: linux-2.6.10/arch/ppc/platforms/prep_setup.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/prep_setup.c
+++ linux-2.6.10/arch/ppc/platforms/prep_setup.c
@@ -938,6 +938,7 @@ prep_calibrate_decr(void)
 					(freq/divisor)/1000000,
 					(freq/divisor)%1000000);
 			tb_to_us = mulhwu_scale_factor(freq/divisor, 1000000);
+			cpu_khz = (freq / divisor) / 1000;
 			tb_ticks_per_jiffy = freq / HZ / divisor;
 		}
 	}
Index: linux-2.6.10/arch/ppc/platforms/spruce.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/spruce.c
+++ linux-2.6.10/arch/ppc/platforms/spruce.c
@@ -150,6 +150,7 @@ spruce_calibrate_decr(void)
 	freq = SPRUCE_BUS_SPEED;
 	tb_ticks_per_jiffy = freq / HZ / divisor;
 	tb_to_us = mulhwu_scale_factor(freq/divisor, 1000000);
+	cpu_khz = (freq / divisor) / 1000;
 }
 
 static int
Index: linux-2.6.10/arch/ppc/syslib/mpc52xx_setup.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/syslib/mpc52xx_setup.c
+++ linux-2.6.10/arch/ppc/syslib/mpc52xx_setup.c
@@ -220,6 +220,7 @@ mpc52xx_calibrate_decr(void)
 
 	tb_ticks_per_jiffy = xlbfreq / HZ / divisor;
 	tb_to_us = mulhwu_scale_factor(xlbfreq / divisor, 1000000);
+	cpu_khz = (xlbfreq / divisor) / 1000;
 }
 
 
Index: linux-2.6.10/arch/ppc/platforms/ev64260.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/ev64260.c
+++ linux-2.6.10/arch/ppc/platforms/ev64260.c
@@ -552,6 +552,7 @@ ev64260_calibrate_decr(void)
 
 	tb_ticks_per_jiffy = freq / HZ;
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
+	cpu_khz = freq / 1000;
 
 	return;
 }
Index: linux-2.6.10/arch/ppc/syslib/ppc85xx_setup.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/syslib/ppc85xx_setup.c
+++ linux-2.6.10/arch/ppc/syslib/ppc85xx_setup.c
@@ -58,6 +58,7 @@ mpc85xx_calibrate_decr(void)
         divisor = 8;
         tb_ticks_per_jiffy = freq / divisor / HZ;
         tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
+        cpu_khz = (freq / divisor) / 1000;
 
 	/* Set the time base to zero */
 	mtspr(SPRN_TBWL, 0);
Index: linux-2.6.10/arch/ppc/syslib/todc_time.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/syslib/todc_time.c
+++ linux-2.6.10/arch/ppc/syslib/todc_time.c
@@ -504,6 +504,7 @@ todc_calibrate_decr(void)
 
 	tb_ticks_per_jiffy = freq / HZ;
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
+	cpu_khz = freq / 1000;
 
 	return;
 }
Index: linux-2.6.10/arch/ppc/platforms/adir_setup.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/adir_setup.c
+++ linux-2.6.10/arch/ppc/platforms/adir_setup.c
@@ -77,6 +77,7 @@ adir_calibrate_decr(void)
 	freq = adir_get_bus_speed();
 	tb_ticks_per_jiffy = freq / HZ / divisor;
 	tb_to_us = mulhwu_scale_factor(freq/divisor, 1000000);
+	cpu_khz = (freq / divisor) / 1000;
 }
 
 static int
Index: linux-2.6.10/arch/ppc/syslib/ppc4xx_setup.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/syslib/ppc4xx_setup.c
+++ linux-2.6.10/arch/ppc/syslib/ppc4xx_setup.c
@@ -178,6 +178,7 @@ ppc4xx_calibrate_decr(void)
 	freq = bip->bi_tbfreq;
 	tb_ticks_per_jiffy = freq / HZ;
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
+	cpu_khz = freq / 1000;
 
 	/* Set the time base to zero.
 	   ** At 200 Mhz, time base will rollover in ~2925 years.
Index: linux-2.6.10/arch/ppc/kernel/time.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/kernel/time.c
+++ linux-2.6.10/arch/ppc/kernel/time.c
@@ -86,6 +86,7 @@ unsigned tb_ticks_per_jiffy;
 unsigned tb_to_us;
 unsigned tb_last_stamp;
 unsigned long tb_to_ns_scale;
+unsigned long cpu_khz;
 
 extern unsigned long wall_jiffies;
 
@@ -296,6 +297,7 @@ void __init time_init(void)
 		tb_ticks_per_jiffy = DECREMENTER_COUNT_601;
 		/* mulhwu_scale_factor(1000000000, 1000000) is 0x418937 */
 		tb_to_us = 0x418937;
+		cpu_khz = 1000000000 / 1000;
         } else {
                 ppc_md.calibrate_decr();
 		tb_to_ns_scale = mulhwu(tb_to_us, 1000 << 10);
