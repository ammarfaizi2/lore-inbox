Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbTIDEgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 00:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbTIDEgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 00:36:45 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:61888 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264550AbTIDEgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 00:36:41 -0400
Subject: [PATCH] linux-2.6.0-test4_cyclone-hpet-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, venkatesh.pallipadi@intel.com
Content-Type: text/plain
Organization: 
Message-Id: <1062649798.1312.1519.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Sep 2003 21:29:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All,
	I probably should have been more active in reviewing the HPET code
before it went in, but I've been somewhat occupied with other bugs
recently. I'm excited to see someone else using my time-source
interface, however the HPET patch definitely pushes the interface beyond
its design (not a bad thing, just makes for some short term uglies).
Having multiple interrupt sources as well as time sources will generate
some work for 2.7 to clean it all up.

Anyway, the HPET changes made calibrate_tsc() static, which it probably
should be, but it broke the timer_cyclone code. This patch fixes it back
up by re-implementing calibrate_tsc() locally as it was done in
timer_hpet.c 

Please apply.

thanks
-john


Also, while apparently unrelated, but touching code from the HPET patch,
I'm seeing some form of memory corruption on the 16way x440 which is
overwriting the wait_timer_tick pointer in apic.c I added some
initialized corruption pad variables around the pointer and they're
definitely being trampled. I'll have to look into it further tomorrow.



diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Wed Sep  3 21:07:47 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Wed Sep  3 21:07:47 2003
@@ -18,8 +18,9 @@
 #include <asm/pgtable.h>
 #include <asm/fixmap.h>
 
+#include "mach_timer.h"
+
 extern spinlock_t i8253_lock;
-extern unsigned long calibrate_tsc(void);
 
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
@@ -132,6 +133,66 @@
 	/* convert to nanoseconds */
 	ret = base + ((this_offset - last_offset)&CYCLONE_TIMER_MASK);
 	return ret * (1000000000 / CYCLONE_TIMER_FREQ);
+}
+
+/* ------ Calibrate the TSC ------- 
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Too much 64-bit arithmetic here to do this cleanly in C, and for
+ * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
+ * output busy loop as low as possible. We avoid reading the CTC registers
+ * directly because of the awkward 8-bit access mechanism of the 82C54
+ * device.
+ */
+
+#define CALIBRATE_TIME	(5 * 1000020/HZ)
+
+static unsigned long __init calibrate_tsc(void)
+{
+	mach_prepare_counter();
+
+	{
+		unsigned long startlow, starthigh;
+		unsigned long endlow, endhigh;
+		unsigned long count;
+
+		rdtsc(startlow,starthigh);
+		mach_countup(&count);
+		rdtsc(endlow,endhigh);
+
+
+		/* Error: ECTCNEVERSET */
+		if (count <= 1)
+			goto bad_ctc;
+
+		/* 64-bit subtract - gcc just messes up with long longs */
+		__asm__("subl %2,%0\n\t"
+			"sbbl %3,%1"
+			:"=a" (endlow), "=d" (endhigh)
+			:"g" (startlow), "g" (starthigh),
+			 "0" (endlow), "1" (endhigh));
+
+		/* Error: ECPUTOOFAST */
+		if (endhigh)
+			goto bad_ctc;
+
+		/* Error: ECPUTOOSLOW */
+		if (endlow <= CALIBRATE_TIME)
+			goto bad_ctc;
+
+		__asm__("divl %2"
+			:"=a" (endlow), "=d" (endhigh)
+			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
+
+		return endlow;
+	}
+
+	/*
+	 * The CTC wasn't reliable: we got a hit on the very first read,
+	 * or the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+bad_ctc:
+	return 0;
 }
 
 static int __init init_cyclone(char* override)




