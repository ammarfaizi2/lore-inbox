Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSKDX6I>; Mon, 4 Nov 2002 18:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSKDX6I>; Mon, 4 Nov 2002 18:58:08 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:48581 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263137AbSKDX6F>;
	Mon, 4 Nov 2002 18:58:05 -0500
Subject: [RFC][PATCH] linux-2.5.46_timer-tsc-cleanups_A0.patch
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Nov 2002 16:03:33 -0800
Message-Id: <1036454614.6099.16.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All, 
	Here's a small patch to cleanup timer_tsc.c. It removes an unused
variable and makes fast_gettimeoffset_quotient static. 

Would someone please double check my smpboot.c change, as I'm replacing
fast_gettimeoffset_quotient w/ cpu_khz. I believe my change is doing the
right thing, but would like a second opinion. 

thanks
-john


diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Mon Nov  4 15:42:17 2002
+++ b/arch/i386/kernel/smpboot.c	Mon Nov  4 15:42:17 2002
@@ -181,8 +181,6 @@
 
 #define NR_LOOPS 5
 
-extern unsigned long fast_gettimeoffset_quotient;
-
 /*
  * accurate 64-bit/32-bit division, expanded to 32-bit divisions and 64-bit
  * multiplication. Not terribly optimized but we need it at boot time only
@@ -222,7 +220,8 @@
 
 	printk("checking TSC synchronization across %u CPUs: ", num_booting_cpus());
 
-	one_usec = ((1<<30)/fast_gettimeoffset_quotient)*(1<<2);
+	/* convert from kcyc/sec to cyc/usec */
+	one_usec = cpu_khz / 1000;
 
 	atomic_set(&tsc_start_flag, 1);
 	wmb();
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Nov  4 15:42:17 2002
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Nov  4 15:42:17 2002
@@ -15,7 +15,6 @@
 extern int x86_udelay_tsc;
 extern spinlock_t i8253_lock;
 
-static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
@@ -26,7 +25,7 @@
  * Equal to 2^32 * (1 / (clocks per usec) ).
  * Initialized in time_init.
  */
-unsigned long fast_gettimeoffset_quotient;
+static unsigned long fast_gettimeoffset_quotient;
 
 static unsigned long get_offset_tsc(void)
 {
@@ -244,7 +243,6 @@
 		unsigned long tsc_quotient = calibrate_tsc();
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient = tsc_quotient;
-			use_tsc = 1;
 			/*
 			 *	We could be more selective here I suspect
 			 *	and just enable this for the next intel chips ?


