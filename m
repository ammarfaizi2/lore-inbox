Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265357AbSJaTW5>; Thu, 31 Oct 2002 14:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbSJaTW4>; Thu, 31 Oct 2002 14:22:56 -0500
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.61.209]:5762 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S265357AbSJaTWz>;
	Thu, 31 Oct 2002 14:22:55 -0500
Date: Thu, 31 Oct 2002 14:28:50 -0500
Message-Id: <200210311928.g9VJSoY03708@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net, jim.houston@ccur.com
Subject: [PATCH] calibrate_tsc should not use HZ
Reply-to: jim.houston@attbi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone,

I noticed that the calibration time for calibrate_tsc() is 5 jiffies.
This means the result with 1000 Hz jiffies may be less accurate
then it was at 100 Hz.  The attached patch removes this dependency.

Jim Houston - Concurrent Computer Corp.

diff -X /usr1/jhouston/dontdiff -ur linux.orig/arch/i386/kernel/timers/timer_tsc.c linux.kdb/arch/i386/kernel/timers/timer_tsc.c
--- linux.orig/arch/i386/kernel/timers/timer_tsc.c	Wed Oct 23 00:54:19 2002
+++ linux.kdb/arch/i386/kernel/timers/timer_tsc.c	Thu Oct 31 14:18:21 2002
@@ -97,8 +97,13 @@
  * device.
  */
 
-#define CALIBRATE_LATCH	(5 * LATCH)
-#define CALIBRATE_TIME	(5 * 1000020/HZ)
+/*
+ * Pick the largest possible latch value (it is a 16 bit counter)
+ * and calculate the corresponding time.
+ */
+#define CALIBRATE_LATCH	(0xffff)	
+#define CALIBRATE_TIME	((int)((1000000LL*CALIBRATE_LATCH + \
+				CLOCK_TICK_RATE/2)/CLOCK_TICK_RATE)
 
 static unsigned long __init calibrate_tsc(void)
 {
