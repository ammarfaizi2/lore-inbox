Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268410AbTAMXcP>; Mon, 13 Jan 2003 18:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268412AbTAMXcP>; Mon, 13 Jan 2003 18:32:15 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:1232 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268410AbTAMXcF>;
	Mon, 13 Jan 2003 18:32:05 -0500
Subject: [PATCH][RESEND] linux-2.5.57_delay-cleanup_A1.patch
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1042500792.1514.1.camel@w-jstultz2.beaverton.ibm.com>
References: <1042500792.1514.1.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042500918.1515.4.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 13 Jan 2003 15:35:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, All,
	This patch applies ontop of linux-2.5.57_timer-none_A0 and tries to
cleanup the delay code by moving the timer-specific implementations into
the timer_ops struct. Thus, rather then doing:

	if(x86_delay_tsc)
		__rdtsc_delay(loops);
	else if(x86_delay_cyclone)
		__cyclone_delay(loops);
	else if(whatever....

we just simply do:

	timer->delay(loops);

Making it much easier to accommodate alternate time sources. 

Please apply.

thanks
-john

diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Mon Jan 13 14:55:52 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Mon Jan 13 14:55:52 2003
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
diff -Nru a/arch/i386/kernel/timers/timer_none.c b/arch/i386/kernel/timers/timer_none.c
--- a/arch/i386/kernel/timers/timer_none.c	Mon Jan 13 14:55:52 2003
+++ b/arch/i386/kernel/timers/timer_none.c	Mon Jan 13 14:55:52 2003
@@ -15,10 +15,23 @@
 	return 0;
 }
 
+static void delay_none(unsigned long loops)
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
 
 /* tsc timer_opts struct */
 struct timer_opts timer_none = {
 	.init =		init_none, 
 	.mark_offset =	mark_offset_none, 
 	.get_offset =	get_offset_none,
+	.delay = delay_none,
 };
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Mon Jan 13 14:55:52 2003
+++ b/arch/i386/kernel/timers/timer_pit.c	Mon Jan 13 14:55:52 2003
@@ -27,6 +27,19 @@
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
@@ -129,4 +142,5 @@
 	.init =		init_pit, 
 	.mark_offset =	mark_offset_pit, 
 	.get_offset =	get_offset_pit,
+	.delay = delay_pit,
 };
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Jan 13 14:55:52 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Jan 13 14:55:52 2003
@@ -16,7 +16,6 @@
 
 int tsc_disable __initdata = 0;
 
-extern int x86_udelay_tsc;
 extern spinlock_t i8253_lock;
 
 static int use_tsc;
@@ -107,6 +106,17 @@
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
@@ -272,8 +282,6 @@
 			 *	We could be more selective here I suspect
 			 *	and just enable this for the next intel chips ?
 			 */
-			x86_udelay_tsc = 1;
-
 			/* report CPU clock rate in Hz.
 			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
 			 * clock/second. Our precision is about 100 ppm.
@@ -310,4 +318,5 @@
 	.init =		init_tsc,
 	.mark_offset =	mark_offset_tsc, 
 	.get_offset =	get_offset_tsc,
+	.delay = delay_tsc,
 };
diff -Nru a/arch/i386/lib/delay.c b/arch/i386/lib/delay.c
--- a/arch/i386/lib/delay.c	Mon Jan 13 14:55:52 2003
+++ b/arch/i386/lib/delay.c	Mon Jan 13 14:55:52 2003
@@ -15,54 +15,17 @@
 #include <linux/delay.h>
 #include <asm/processor.h>
 #include <asm/delay.h>
+#include <asm/timer.h>
 
 #ifdef CONFIG_SMP
 #include <asm/smp.h>
 #endif
 
-int x86_udelay_tsc = 0;		/* Delay via TSC */
-
-	
-/*
- *	Do a udelay using the TSC for any CPU that happens
- *	to have one that we trust.
- */
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
-static void __loop_delay(unsigned long loops)
-{
-	int d0;
-	__asm__ __volatile__(
-		"\tjmp 1f\n"
-		".align 16\n"
-		"1:\tjmp 2f\n"
-		".align 16\n"
-		"2:\tdecl %0\n\tjns 2b"
-		:"=&a" (d0)
-		:"0" (loops));
-}
+extern struct timer_opts* timer;
 
 void __delay(unsigned long loops)
 {
-	if (x86_udelay_tsc)
-		__rdtsc_delay(loops);
-	else
-		__loop_delay(loops);
+	timer->delay(loops);
 }
 
 inline void __const_udelay(unsigned long xloops)
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Mon Jan 13 14:55:52 2003
+++ b/include/asm-i386/timer.h	Mon Jan 13 14:55:52 2003
@@ -14,6 +14,7 @@
 	int (*init)(void);
 	void (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
+	void (*delay)(unsigned long);
 };
 
 #define TICK_SIZE (tick_nsec / 1000)



