Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262870AbSKDWxr>; Mon, 4 Nov 2002 17:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262872AbSKDWxq>; Mon, 4 Nov 2002 17:53:46 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:57290 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262870AbSKDWxk>; Mon, 4 Nov 2002 17:53:40 -0500
Subject: [patch] linux-2.5.45_delay-cleanup_A0.patch
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Nov 2002 14:58:58 -0800
Message-Id: <1036450738.5089.232.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, All, 
	This patch moves __delay into the timer_ops infrastructure. This makes
it simple to use alternate time sources for the __delay function. 

Please consider for inclusion. 

-john

diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Mon Nov  4 14:58:18 2002
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Mon Nov  4 14:58:18 2002
@@ -150,7 +150,6 @@
 }
 

-#if 0 /* XXX future work */
 static void delay_cyclone(unsigned long loops)
 {
 	unsigned long bclock, now;
@@ -162,12 +161,12 @@
 		now = cyclone_timer[0];
 	} while ((now-bclock) < loops);
 }
-#endif
 /************************************************************/
 
 /* cyclone timer_opts struct */
 struct timer_opts timer_cyclone = {
 	.init = init_cyclone, 
 	.mark_offset = mark_offset_cyclone, 
-	.get_offset = get_offset_cyclone
+	.get_offset = get_offset_cyclone,
+	.delay = delay_cyclone,
 };
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Mon Nov  4 14:58:18 2002
+++ b/arch/i386/kernel/timers/timer_pit.c	Mon Nov  4 14:58:18 2002
@@ -25,6 +25,19 @@
 	/* nothing needed */
 }
 
+static void delay_pit(unsigned long loops)
+{
+	int d0;
+	__asm__ __volatile__(
+		"\tjmp 1f\n"
+		".align 16\n"
+		"1:\tjmp 2f\n"
+		".align 16\n"
+		"2:\tdecl %0\n\tjns 2b"
+		:"=&a" (d0)
+		:"0" (loops));
+}
+
 
 /* This function must be called with interrupts disabled 
  * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
@@ -127,4 +140,5 @@
 	.init =		init_pit, 
 	.mark_offset =	mark_offset_pit, 
 	.get_offset =	get_offset_pit,
+	.delay = delay_pit,
 };
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Nov  4 14:58:18 2002
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Nov  4 14:58:18 2002
@@ -12,7 +12,6 @@
 #include <asm/timer.h>
 #include <asm/io.h>
 
-extern int x86_udelay_tsc;
 extern spinlock_t i8253_lock;
 
 static int use_tsc;
@@ -87,6 +86,17 @@
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 }
 
+static void delay_tsc(unsigned long loops)
+{
+	unsigned long bclock, now;
+	
+	rdtscl(bclock);
+	do
+	{
+		rep_nop();
+		rdtscl(now);
+	} while ((now-bclock) < loops);
+}
 
 /* ------ Calibrate the TSC ------- 
  * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
@@ -249,8 +259,6 @@
 			 *	We could be more selective here I suspect
 			 *	and just enable this for the next intel chips ?
 			 */
-			x86_udelay_tsc = 1;
-
 			/* report CPU clock rate in Hz.
 			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
 			 * clock/second. Our precision is about 100 ppm.
@@ -278,4 +286,5 @@
 	.init =		init_tsc,
 	.mark_offset =	mark_offset_tsc, 
 	.get_offset =	get_offset_tsc,
+	.delay = delay_tsc,
 };
diff -Nru a/arch/i386/lib/delay.c b/arch/i386/lib/delay.c
--- a/arch/i386/lib/delay.c	Mon Nov  4 14:58:18 2002
+++ b/arch/i386/lib/delay.c	Mon Nov  4 14:58:18 2002
@@ -15,35 +15,18 @@
 #include <linux/delay.h>
 #include <asm/processor.h>
 #include <asm/delay.h>
+#include <asm/timer.h>
 
 #ifdef CONFIG_SMP
 #include <asm/smp.h>
 #endif
 
-int x86_udelay_tsc = 0;		/* Delay via TSC */
+extern struct timer_opts* timer;
 
-	
 /*
- *	Do a udelay using the TSC for any CPU that happens
- *	to have one that we trust.
+ *	Backup non-TSC based delay loop.
+ *	Used until a timer is chosen.
  */
-
-static void __rdtsc_delay(unsigned long loops)
-{
-	unsigned long bclock, now;
-	
-	rdtscl(bclock);
-	do
-	{
-		rep_nop();
-		rdtscl(now);
-	} while ((now-bclock) < loops);
-}
-
-/*
- *	Non TSC based delay loop for 386, 486, MediaGX
- */
- 
 static void __loop_delay(unsigned long loops)
 {
 	int d0;
@@ -59,8 +42,8 @@
 
 void __delay(unsigned long loops)
 {
-	if (x86_udelay_tsc)
-		__rdtsc_delay(loops);
+	if(timer)
+		timer->delay(loops);
 	else
 		__loop_delay(loops);
 }
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Mon Nov  4 14:58:18 2002
+++ b/include/asm-i386/timer.h	Mon Nov  4 14:58:18 2002
@@ -14,6 +14,7 @@
 	int (*init)(void);
 	void (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
+	void (*delay)(unsigned long);
 };
 
 #define TICK_SIZE (tick_nsec / 1000)

