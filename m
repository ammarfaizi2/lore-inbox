Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267352AbTBLANk>; Tue, 11 Feb 2003 19:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbTBLANk>; Tue, 11 Feb 2003 19:13:40 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:48557 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267649AbTBLAMP>; Tue, 11 Feb 2003 19:12:15 -0500
Subject: [RESEND][PATCH] linux-2.5.60_timer-tsc-cleanups_A1
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1045009173.987.18.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Feb 2003 16:19:33 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, All

	This cleanup patch makes fast_gettimeoffset_quotient (a timer_tsc
specific variable) static, and replaces its usage with cpu_khz, making
it timer_opt independent.

Please apply.

thanks
-john

diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Tue Feb 11 16:12:33 2003
+++ b/arch/i386/kernel/smpboot.c	Tue Feb 11 16:12:33 2003
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
--- a/arch/i386/kernel/timers/timer_tsc.c	Tue Feb 11 16:12:33 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Tue Feb 11 16:12:33 2003
@@ -29,7 +29,7 @@
  * Equal to 2^32 * (1 / (clocks per usec) ).
  * Initialized in time_init.
  */
-unsigned long fast_gettimeoffset_quotient;
+static unsigned long fast_gettimeoffset_quotient;
 
 static unsigned long get_offset_tsc(void)
 {



