Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268097AbTAJBlC>; Thu, 9 Jan 2003 20:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268098AbTAJBlB>; Thu, 9 Jan 2003 20:41:01 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:61615 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268097AbTAJBk7>; Thu, 9 Jan 2003 20:40:59 -0500
Subject: [PATCH] linux-2.5.55_timer-tsc-cleanups_A0
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1042163110.1052.291.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 09 Jan 2003 17:45:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, All,

	This patch cleans up the timer_tsc code. It removes the unused use_tsc
variable and makes fast_gettimeoffset_quotient static (replacing it w/
cpu_khz in smpboot.c). 

Please consider for acceptance.

thanks
-john


diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Thu Jan  9 17:03:07 2003
+++ b/arch/i386/kernel/smpboot.c	Thu Jan  9 17:03:07 2003
@@ -182,8 +182,6 @@
 
 #define NR_LOOPS 5
 
-extern unsigned long fast_gettimeoffset_quotient;
-
 /*
  * accurate 64-bit/32-bit division, expanded to 32-bit divisions and 64-bit
  * multiplication. Not terribly optimized but we need it at boot time only
@@ -223,7 +221,8 @@
 
 	printk("checking TSC synchronization across %u CPUs: ", num_booting_cpus());
 
-	one_usec = ((1<<30)/fast_gettimeoffset_quotient)*(1<<2);
+	/* convert from kcyc/sec to cyc/usec */
+	one_usec = cpu_khz / 1000;
 
 	atomic_set(&tsc_start_flag, 1);
 	wmb();
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Thu Jan  9 17:03:07 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Thu Jan  9 17:03:07 2003
@@ -19,7 +19,6 @@
 extern int x86_udelay_tsc;
 extern spinlock_t i8253_lock;
 
-static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
@@ -30,7 +29,7 @@
  * Equal to 2^32 * (1 / (clocks per usec) ).
  * Initialized in time_init.
  */
-unsigned long fast_gettimeoffset_quotient;
+static unsigned long fast_gettimeoffset_quotient;
 
 static unsigned long get_offset_tsc(void)
 {
@@ -267,7 +266,6 @@
 		unsigned long tsc_quotient = calibrate_tsc();
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient = tsc_quotient;
-			use_tsc = 1;
 			/*
 			 *	We could be more selective here I suspect
 			 *	and just enable this for the next intel chips ?



