Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269198AbUIYDIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269198AbUIYDIO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 23:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269199AbUIYDIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 23:08:14 -0400
Received: from holomorphy.com ([207.189.100.168]:44260 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269198AbUIYDII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 23:08:08 -0400
Date: Fri, 24 Sep 2004 20:08:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [sched.h 3/8] privatize CALC_LOAD()
Message-ID: <20040925030802.GO9106@holomorphy.com>
References: <20040925024513.GL9106@holomorphy.com> <20040925024917.GM9106@holomorphy.com> <20040925025304.GN9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925025304.GN9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 07:53:04PM -0700, William Lee Irwin III wrote:
> CT_TO_SECS() and CT_TO_USECS() are used where jiffies_to_timeval()
> should be; this patch teaches their sole caller to use that instead and
> by so doing removes them from the kernel entirely.

CALC_LOAD() is used nowhere but kernel/timer.c; this patch moves it
there.


Index: mm3-2.6.9-rc2/include/linux/sched.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/sched.h	2004-09-24 18:45:29.052287408 -0700
+++ mm3-2.6.9-rc2/include/linux/sched.h	2004-09-24 18:58:09.944614192 -0700
@@ -75,15 +75,6 @@
 
 #define FSHIFT		11		/* nr of bits of precision */
 #define FIXED_1		(1<<FSHIFT)	/* 1.0 as fixed-point */
-#define LOAD_FREQ	(5*HZ)		/* 5 sec intervals */
-#define EXP_1		1884		/* 1/exp(5sec/1min) as fixed-point */
-#define EXP_5		2014		/* 1/exp(5sec/5min) */
-#define EXP_15		2037		/* 1/exp(5sec/15min) */
-
-#define CALC_LOAD(load,exp,n) \
-	load *= exp; \
-	load += n*(FIXED_1-exp); \
-	load >>= FSHIFT;
 
 extern int nr_threads;
 extern int last_pid;
Index: mm3-2.6.9-rc2/kernel/timer.c
===================================================================
--- mm3-2.6.9-rc2.orig/kernel/timer.c	2004-09-24 17:37:17.000000000 -0700
+++ mm3-2.6.9-rc2/kernel/timer.c	2004-09-24 18:58:21.931791864 -0700
@@ -884,6 +884,16 @@
  */
 unsigned long avenrun[3];
 
+#define EXP_1		1884		/* 1/exp(5sec/1min) as fixed-point */
+#define EXP_5		2014		/* 1/exp(5sec/5min) */
+#define EXP_15		2037		/* 1/exp(5sec/15min) */
+
+static inline unsigned long
+__calc_load(unsigned long prev, unsigned long decay, unsigned long new)
+{
+	return (decay*prev + (FIXED_1 - decay)*new) >> FSHIFT;
+}
+
 /*
  * calc_load - given tick count, update the avenrun load estimates.
  * This is called while holding a write_lock on xtime_lock.
@@ -891,15 +901,15 @@
 static inline void calc_load(unsigned long ticks)
 {
 	unsigned long active_tasks; /* fixed-point */
-	static int count = LOAD_FREQ;
+	static int count = 5*HZ;
 
 	count -= ticks;
 	if (count < 0) {
-		count += LOAD_FREQ;
+		count += 5*HZ;
 		active_tasks = count_active_tasks();
-		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
-		CALC_LOAD(avenrun[1], EXP_5, active_tasks);
-		CALC_LOAD(avenrun[2], EXP_15, active_tasks);
+		avenrun[0] = __calc_load(avenrun[0], EXP_1, active_tasks);
+		avenrun[1] = __calc_load(avenrun[1], EXP_5, active_tasks);
+		avenrun[2] = __calc_load(avenrun[2], EXP_15, active_tasks);
 	}
 }
 
