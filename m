Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131022AbQKWKPz>; Thu, 23 Nov 2000 05:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131100AbQKWKPo>; Thu, 23 Nov 2000 05:15:44 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1540 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S131022AbQKWKPd>;
        Thu, 23 Nov 2000 05:15:33 -0500
Date: Wed, 22 Nov 2000 11:14:53 +0100
From: Pavel Machek <pavel@bug.ucw.cz>
Message-Id: <200011221014.LAA05819@bug.ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: TSC changes detector
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- clean/arch/i386/kernel/time.c	Thu Nov  2 21:00:59 2000
+++ linux/arch/i386/kernel/time.c	Wed Nov 22 11:12:05 2000
@@ -63,7 +63,7 @@
  */
 #include <linux/irq.h>
 
-
+extern int x86_udelay_tsc;
 unsigned long cpu_khz;	/* Detected as we calibrate the TSC */
 
 /* Number of usecs that the last interrupt was delayed */
@@ -152,7 +152,7 @@
  * comp.protocols.time.ntp!
  */
 
-static unsigned long do_slow_gettimeoffset(void)
+static unsigned long do_read_hwtimer(void)
 {
 	int count;
 
@@ -227,7 +227,7 @@
 
 				count -= 256;
 #else
-				printk("do_slow_gettimeoffset(): hardware timer problem?\n");
+				printk("do_read_hwtimer(): hardware timer problem?\n");
 #endif
 			}
 		}
@@ -235,6 +235,12 @@
 		jiffies_p = jiffies_t;
 
 	count_p = count;
+	return count;
+}
+
+unsigned long do_slow_gettimeoffset(void)
+{
+	unsigned long count = do_read_hwtimer();
 
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	count = (count + LATCH/2) / LATCH;
@@ -449,7 +455,39 @@
 #endif
 }
 
-static int use_tsc;
+int use_tsc;
+
+void big_calibrate_tsc(void)
+{
+	if (cpu_has_tsc) {
+		unsigned long tsc_quotient = calibrate_tsc();
+		if (tsc_quotient) {
+			fast_gettimeoffset_quotient = tsc_quotient;
+			use_tsc = 1;
+			/*
+			 *	We could be more selective here I suspect
+			 *	and just enable this for the next intel chips ?
+			 */
+			x86_udelay_tsc = 1;
+#ifndef do_gettimeoffset
+			do_gettimeoffset = do_fast_gettimeoffset;
+#endif
+			do_get_fast_time = do_gettimeofday;
+
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
+		} else { printk( "Failed to detect CPU Hz.\n" ); use_tsc = 0; }
+	} else use_tsc = 0;
+}
 
 /*
  * This is the same as the above, except we _also_ save the current
@@ -469,6 +507,28 @@
 	 */
 	write_lock(&xtime_lock);
 
+	if (use_tsc) {
+		long off = do_gettimeoffset();
+		/* Damn, kapmd plays hell with this. We'd need to busy loop in timer interrupt to calibrate reliably. */ 
+		static int faster = 0, slower = 0;
+		if (off > (1100000/HZ))
+			faster++;
+		else
+			faster = 0;
+
+		if (off < (900000/HZ))
+			slower++;
+		else
+			slower = 0;
+
+		if ((faster > 10) || (slower > 10)) {
+			printk( KERN_ERR "TSC is %s than it should be! ", (faster > 10) ? "faster" : "slower" );
+			big_calibrate_tsc();
+			faster = 0;
+			slower = 0;
+		}
+	}
+
 	if (use_tsc)
 	{
 		/*
@@ -558,7 +618,7 @@
 #define CALIBRATE_LATCH	(5 * LATCH)
 #define CALIBRATE_TIME	(5 * 1000020/HZ)
 
-static unsigned long __init calibrate_tsc(void)
+static unsigned long calibrate_tsc(void)
 {
        /* Set the Gate high, disable speaker */
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
@@ -625,8 +685,6 @@
 
 void __init time_init(void)
 {
-	extern int x86_udelay_tsc;
-	
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_usec = 0;
 
@@ -657,34 +715,7 @@
  
  	dodgy_tsc();
  	
-	if (cpu_has_tsc) {
-		unsigned long tsc_quotient = calibrate_tsc();
-		if (tsc_quotient) {
-			fast_gettimeoffset_quotient = tsc_quotient;
-			use_tsc = 1;
-			/*
-			 *	We could be more selective here I suspect
-			 *	and just enable this for the next intel chips ?
-			 */
-			x86_udelay_tsc = 1;
-#ifndef do_gettimeoffset
-			do_gettimeoffset = do_fast_gettimeoffset;
-#endif
-			do_get_fast_time = do_gettimeofday;
-
-			/* report CPU clock rate in Hz.
-			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
-			 * clock/second. Our precision is about 100 ppm.
-			 */
-			{	unsigned long eax=0, edx=1000;
-				__asm__("divl %2"
-		       		:"=a" (cpu_khz), "=d" (edx)
-        	       		:"r" (tsc_quotient),
-	                	"0" (eax), "1" (edx));
-				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
-			}
-		}
-	}
+	big_calibrate_tsc();
 
 #ifdef CONFIG_VISWS
 	printk("Starting Cobalt Timer system clock\n");
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
