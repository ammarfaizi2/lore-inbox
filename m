Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTAYUZM>; Sat, 25 Jan 2003 15:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbTAYUZM>; Sat, 25 Jan 2003 15:25:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:60923 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262190AbTAYUZJ>; Sat, 25 Jan 2003 15:25:09 -0500
Subject: [RFC][PATCH] linux-2.5.59_lost-tick_A1
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: shemminger@osdl.org, ak@suse.de, akpm@digeo.com
Content-Type: text/plain
Organization: 
Message-Id: <1043526273.1029.12.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 25 Jan 2003 12:24:33 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All, 
	Here is the next rev of my lost-tick compensation code, which handles
the case where interrupts are disabled for longer then two ticks. This
patch solves the problem by checking when an interrupt occurs if
timer->get_offset() is a value greater then 2 ticks. If so, it
increments jiffies appropriately. 

New in this version:
o detect_lost_tick() is now static inlined
o printk warning messages the first 5 occurrences
o also show_trace() when displaying warning. 


I'd really like it if folks seeing the problem would take this for a
spin and let me know if it works for them. Also, any comments or
suggestions would be appreciated.

thanks
-john

diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Sat Jan 25 12:06:50 2003
+++ b/arch/i386/kernel/time.c	Sat Jan 25 12:06:50 2003
@@ -265,6 +265,34 @@
 #endif
 }
 
+
+/* Lost tick detection and compensation */
+static inline void detect_lost_tick(void)
+{
+	/* read time since last interrupt */
+	unsigned long delta = timer->get_offset();
+	static unsigned long dbg_print;
+	
+	/* check if delta is greater then two ticks */
+	if(delta >= 2*(1000000/HZ)){
+
+		/* only print debug info first 5 times */
+		if(dbg_print < 5){
+			printk(KERN_WARNING "\nWarning! Detected %lu micro-second"
+					" gap between interrupts.\n",delta);
+			printk(KERN_WARNING "  Compensating for %lu lost ticks.\n",
+					delta/(1000000/HZ)-1);
+			/* dump trace info */
+			show_trace(NULL);
+			dbg_print++;
+		}
+		/* calculate number of missed ticks */
+		delta = delta/(1000000/HZ)-1;
+		jiffies += delta;
+	}
+		
+}
+
 /*
  * This is the same as the above, except we _also_ save the current
  * Time Stamp Counter value at the time of the timer interrupt, so that
@@ -281,6 +309,7 @@
 	 */
 	write_lock(&xtime_lock);
 
+	detect_lost_tick();
 	timer->mark_offset();
  
 	do_timer_interrupt(irq, NULL, regs);




