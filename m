Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbTAXTgi>; Fri, 24 Jan 2003 14:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbTAXTgi>; Fri, 24 Jan 2003 14:36:38 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:30115 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264010AbTAXTgg>;
	Fri, 24 Jan 2003 14:36:36 -0500
Subject: [RFC] [PATCH] linux-2.5.59_cyclone-fixes_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1043437064.15683.187.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Jan 2003 11:37:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All, 
	In order for the timer_cyclone.c code to be enabled, the following
issues need to be remedied.

1) fast_gettimeoffset_quotient (initialized in timer_tsc->init()) is
used outside of timer_tsc.c Thus it either needs to be made static or
initialized in timer_cyclone.c

2) cpu_khz is only initialized in timer_tsc->init(). Either timer_tsc
needs to initialize in timer_tsc as well, or it needs to be initialized
outside the timer subsystem. 

Now I have more "proper" patches for these issues, which makes
fast_gettimeoffset_quotient static and initializes cpu_khz in
cpu/common.c (which could be later expanded to making cpu_khz per-cpu). 

However these patches move a reasonable amount of code around and touch
generic code in a number of places. So instead I've created this patch
as a "quick-fix" by duplicating some of the timer_tsc->init() code into
timer_cyclone->init(). This way we can still enable the timer_cyclone 
code w/o touching any generic code (well, I do have to un-static
calibrate_tsc())

Honestly, I'm not super happy about doing it this way, but I do realize
the slush needs to thicken. However, I will continue to push the cleanup
patches, but this way the cyclone code won't depend on them.  

Comments, suggestions and flames welcome.

thanks
-john
 

diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Wed Jan 22 13:35:09 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Wed Jan 22 13:35:09 2003
@@ -17,7 +17,7 @@
 #include <asm/fixmap.h>
 
 extern spinlock_t i8253_lock;
-
+extern unsigned long fast_gettimeoffset_quotient;
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
@@ -142,6 +142,28 @@
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
--- a/arch/i386/kernel/timers/timer_tsc.c	Wed Jan 22 13:35:09 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Wed Jan 22 13:35:09 2003
@@ -130,7 +130,7 @@
 #define CALIBRATE_LATCH	(5 * LATCH)
 #define CALIBRATE_TIME	(5 * 1000020/HZ)
 
-static unsigned long __init calibrate_tsc(void)
+unsigned long __init calibrate_tsc(void)
 {
        /* Set the Gate high, disable speaker */
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);



