Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbTAQCt7>; Thu, 16 Jan 2003 21:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267120AbTAQCt7>; Thu, 16 Jan 2003 21:49:59 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:28611 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267106AbTAQCt5>;
	Thu, 16 Jan 2003 21:49:57 -0500
Subject: [PATCH] linux-2.5.59_timer-tsc-cleanup_A0
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1042771949.29942.19.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 16 Jan 2003 18:52:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Andrew, All,
        Just a resend/resync for 2.5.59. This patch cleans up the
timer_tsc code, removing the unused use_tsc variable and making
fast_gettimeoffset_quotient static.

Please apply.

thanks
-john


diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Thu Jan 16 18:46:42 2003
+++ b/arch/i386/kernel/smpboot.c	Thu Jan 16 18:46:42 2003
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
--- a/arch/i386/kernel/timers/timer_tsc.c	Thu Jan 16 18:46:42 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Thu Jan 16 18:46:42 2003
@@ -18,7 +18,6 @@
 
 extern spinlock_t i8253_lock;
 
-static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
@@ -29,7 +28,7 @@
  * Equal to 2^32 * (1 / (clocks per usec) ).
  * Initialized in time_init.
  */
-unsigned long fast_gettimeoffset_quotient;
+static unsigned long fast_gettimeoffset_quotient;
 
 static unsigned long get_offset_tsc(void)
 {
@@ -277,7 +276,6 @@
 		unsigned long tsc_quotient = calibrate_tsc();
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient = tsc_quotient;
-			use_tsc = 1;
 			/*
 			 *	We could be more selective here I suspect
 			 *	and just enable this for the next intel chips ?



