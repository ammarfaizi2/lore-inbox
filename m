Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbTBGUSI>; Fri, 7 Feb 2003 15:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbTBGUSI>; Fri, 7 Feb 2003 15:18:08 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45764 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266384AbTBGUSF>;
	Fri, 7 Feb 2003 15:18:05 -0500
Subject: [RFC][PATCH] linux-2.5.59_getcycles_A0
From: john stultz <johnstul@us.ibm.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1044649542.18673.20.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 07 Feb 2003 12:25:43 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel, All,

	This patch moves the get_cycles() implementation into the timer_opts
subsystem. This patch corrects issues between the hangcheck-timer code
and systems running with timer_cyclone. As an extra bonus, it removes
the CONFIG_X86_TSC #ifdef in get_cycles replacing it with
timer->get_cycles(). 

Comments flames and suggestions welcome.

thanks
-john

diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Fri Feb  7 12:18:21 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Fri Feb  7 12:18:21 2003
@@ -161,6 +161,16 @@
 		now = cyclone_timer[0];
 	} while ((now-bclock) < loops);
 }
+
+static unsigned long long get_cycles_cyclone(void)
+{
+	unsigned long long ret;	
+	ret = cyclone_timer[1]; 		/* store high 8 bits */
+	ret = (ret & 0xFF) << 32;		/* mask and shift them up */
+	ret = ret | cyclone_timer[0];	/* store lower 32 bits */
+	return ret;
+}
+
 /************************************************************/
 
 /* cyclone timer_opts struct */
@@ -169,4 +179,5 @@
 	.mark_offset = mark_offset_cyclone, 
 	.get_offset = get_offset_cyclone,
 	.delay = delay_cyclone,
+	.get_cycles = get_cycles_cyclone,
 };
diff -Nru a/arch/i386/kernel/timers/timer_none.c b/arch/i386/kernel/timers/timer_none.c
--- a/arch/i386/kernel/timers/timer_none.c	Fri Feb  7 12:18:21 2003
+++ b/arch/i386/kernel/timers/timer_none.c	Fri Feb  7 12:18:21 2003
@@ -28,10 +28,16 @@
 		:"0" (loops));
 }
 
+static unsigned long long get_cycles_none(void)
+{
+	return 0ULL;
+}
+
 /* tsc timer_opts struct */
 struct timer_opts timer_none = {
 	.init =		init_none, 
 	.mark_offset =	mark_offset_none, 
 	.get_offset =	get_offset_none,
 	.delay = delay_none,
+	.get_cycles = get_cycles_none,
 };
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Fri Feb  7 12:18:21 2003
+++ b/arch/i386/kernel/timers/timer_pit.c	Fri Feb  7 12:18:21 2003
@@ -135,6 +135,11 @@
 	return count;
 }
 
+static unsigned long long get_cycles_pit(void)
+{
+	return 0ULL;
+}
+
 
 /* tsc timer_opts struct */
 struct timer_opts timer_pit = {
@@ -142,4 +147,5 @@
 	.mark_offset =	mark_offset_pit, 
 	.get_offset =	get_offset_pit,
 	.delay = delay_pit,
+	.get_cycles = get_cycles_pit,
 };
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Fri Feb  7 12:18:21 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Fri Feb  7 12:18:21 2003
@@ -118,6 +118,13 @@
 	} while ((now-bclock) < loops);
 }
 
+static unsigned long long get_cycles_tsc(void)
+{
+	unsigned long long ret;
+	rdtscll(ret);
+	return ret;
+}
+
 /* ------ Calibrate the TSC ------- 
  * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
  * Too much 64-bit arithmetic here to do this cleanly in C, and for
@@ -319,4 +326,5 @@
 	.mark_offset =	mark_offset_tsc, 
 	.get_offset =	get_offset_tsc,
 	.delay = delay_tsc,
+	.get_cycles = get_cycles_tsc,
 };
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Fri Feb  7 12:18:21 2003
+++ b/include/asm-i386/timer.h	Fri Feb  7 12:18:21 2003
@@ -15,6 +15,7 @@
 	void (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
 	void (*delay)(unsigned long);
+	unsigned long long (*get_cycles)(void);
 };
 
 #define TICK_SIZE (tick_nsec / 1000)
diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
--- a/include/asm-i386/timex.h	Fri Feb  7 12:18:21 2003
+++ b/include/asm-i386/timex.h	Fri Feb  7 12:18:21 2003
@@ -7,7 +7,7 @@
 #define _ASMi386_TIMEX_H
 
 #include <linux/config.h>
-#include <asm/msr.h>
+#include <asm/timer.h>
 
 #ifdef CONFIG_MELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
@@ -37,17 +37,10 @@
 typedef unsigned long long cycles_t;
 
 extern cycles_t cacheflush_time;
-
+extern struct timer_opts* timer;
 static inline cycles_t get_cycles (void)
 {
-#ifndef CONFIG_X86_TSC
-	return 0;
-#else
-	unsigned long long ret;
-
-	rdtscll(ret);
-	return ret;
-#endif
+	return timer->get_cycles();
 }
 
 extern unsigned long cpu_khz;



