Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbTBFBqC>; Wed, 5 Feb 2003 20:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTBFBqC>; Wed, 5 Feb 2003 20:46:02 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:62904 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261963AbTBFBqA>;
	Wed, 5 Feb 2003 20:46:00 -0500
Subject: [PATCH] linux-2.5.59_cyclone-fixes_A1
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1044496432.19553.166.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 05 Feb 2003 17:53:52 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, All,

        This patch "fixes" the timer_cyclone code by having it
initialize fast_gettimeoffset_quotient and cpu_khz in the same manner as
timer_tsc. This is required for enabling the timer_cyclone code on the
x440. 

Ideally fast_gettimeoffset_quotient would not be used outside timer_tsc
and cpu_khz would be initialized generically outside the timer
subsystem. I have patches to do this, but they touch quite a bit of
generic code, and I'd rather not make the timer_cyclone enablement
(patch to follow) depend on these larger changes. 

Please apply.

thanks
-john


diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Wed Feb  5 17:49:18 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Wed Feb  5 17:49:18 2003
@@ -17,6 +17,8 @@
 #include <asm/fixmap.h>
 
 extern spinlock_t i8253_lock;
+extern unsigned long fast_gettimeoffset_quotient;
+extern unsigned long calibrate_tsc(void);
 
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
@@ -142,6 +144,28 @@
 			printk(KERN_ERR "Summit chipset: Counter not counting! DISABLED\n");
 			cyclone_timer = 0;
 			return -ENODEV;
+		}
+	}
+
+	/* init fast_gettimeoffset_quotent and cpu_khz.
+	 * XXX - This should really be done elsewhere, 
+	 * 		and in a more generic fashion. -johnstul@us.ibm.com
+	 */
+	if (cpu_has_tsc) {
+		unsigned long tsc_quotient = calibrate_tsc();
+		if (tsc_quotient) {
+			fast_gettimeoffset_quotient = tsc_quotient;
+			/* report CPU clock rate in Hz.
+			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
+			 * clock/second. Our precision is about 100 ppm.
+			 */
+			{	unsigned long eax=0, edx=1000;
+				__asm__("divl %2"
+		       		:"=a" (cpu_khz), "=d" (edx)
+        	       		:"r" (tsc_quotient),
+	                	"0" (eax), "1" (edx));
+				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
+			}
 		}
 	}
 
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Wed Feb  5 17:49:18 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Wed Feb  5 17:49:18 2003
@@ -130,7 +130,7 @@
 #define CALIBRATE_LATCH	(5 * LATCH)
 #define CALIBRATE_TIME	(5 * 1000020/HZ)
 
-static unsigned long __init calibrate_tsc(void)
+unsigned long __init calibrate_tsc(void)
 {
        /* Set the Gate high, disable speaker */
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);



