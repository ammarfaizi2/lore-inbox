Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTKRKxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 05:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTKRKxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 05:53:33 -0500
Received: from ozlabs.org ([203.10.76.45]:58274 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262540AbTKRKx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 05:53:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16313.63872.16107.755531@cargo.ozlabs.ibm.com>
Date: Tue, 18 Nov 2003 21:50:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: implement sched_clock properly
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, can this go in at the moment?

Currently the sched_clock implementation for PPC64 is bogus.  It just
reads the timebase register, which counts at some fixed rate,
typically around 100MHz.  This patch adds code to calculate a
suitable multiplier from the timebase frequency, and use that in
sched_clock().

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc64/kernel/time.c ppc64-2.5/arch/ppc64/kernel/time.c
--- linux-2.5/arch/ppc64/kernel/time.c	2003-10-09 10:07:18.000000000 +1000
+++ ppc64-2.5/arch/ppc64/kernel/time.c	2003-11-18 21:41:32.145850944 +1100
@@ -91,6 +91,9 @@
 unsigned long processor_freq;
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
+unsigned long tb_to_ns_scale;
+unsigned long tb_to_ns_shift;
+
 struct gettimeofday_struct do_gtod;
 
 extern unsigned long wall_jiffies;
@@ -313,11 +316,13 @@
 /*
  * Scheduler clock - returns current time in nanosec units.
  *
- * This is wrong, but my CPUs run at 1GHz, so nyer nyer.
+ * Note: mulhdu(a, b) (multiply high double unsigned) returns
+ * the high 64 bits of a * b, i.e. (a * b) >> 64, where a and b
+ * are 64-bit unsigned numbers.
  */
 unsigned long long sched_clock(void)
 {
-	return get_tb();
+	return mulhdu(get_tb(), tb_to_ns_scale) << tb_to_ns_shift;
 }
 
 /*
@@ -473,9 +478,30 @@
 	/* This function is only called on the boot processor */
 	unsigned long flags;
 	struct rtc_time tm;
+	struct div_result res;
+	unsigned long scale, shift;
 
 	ppc_md.calibrate_decr();
 
+	/*
+	 * Compute scale factor for sched_clock.
+	 * The calibrate_decr() function has set tb_ticks_per_sec,
+	 * which is the timebase frequency.
+	 * We compute 1e9 * 2^64 / tb_ticks_per_sec and interpret
+	 * the 128-bit result as a 64.64 fixed-point number.
+	 * We then shift that number right until it is less than 1.0,
+	 * giving us the scale factor and shift count to use in
+	 * sched_clock().
+	 */
+	div128_by_32(1000000000, 0, tb_ticks_per_sec, &res);
+	scale = res.result_low;
+	for (shift = 0; res.result_high != 0; ++shift) {
+		scale = (scale >> 1) | (res.result_high << 63);
+		res.result_high >>= 1;
+	}
+	tb_to_ns_scale = scale;
+	tb_to_ns_shift = shift;
+
 #ifdef CONFIG_PPC_ISERIES
 	if (!piranha_simulator)
 #endif
