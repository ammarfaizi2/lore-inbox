Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265926AbTF3WUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 18:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbTF3WUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 18:20:52 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:3975 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265926AbTF3WUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 18:20:25 -0400
Subject: [PATCH SET - 2/3] linux-2.5.73_lost-tick-speedstep-fix_A1
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1057011840.28319.342.camel@w-jstultz2.beaverton.ibm.com>
References: <1057011774.28320.340.camel@w-jstultz2.beaverton.ibm.com>
	 <1057011840.28319.342.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057011938.28320.345.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Jun 2003 15:25:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch is a modification of the lost-tick-speedstep-fix patch in
2.5.73-mm2.

The patch tries to resolve issues caused by running the TSC based lost
tick compensation code on CPUs that change frequency (speedstep, etc). 

Should the CPU be in slow mode when calibrate_tsc() executes, the kernel
will assume we have so many cycles per tick.  Later when the cpu speeds
up, the kernel will start noting that too many cycles have past since
the last interrupt.  Since this can occasionally happen, the lost tick
compensation code then tries to fix this by incrementing jiffies. Thus
every tick we end up incrementing jiffies many times, causing timers to
expire too quickly and time to rush ahead.

This patch detects when there has been 100 consecutive interrupts where
we had to compensate for lost ticks.  If this occurs, we spit out a
warning and fall back to using the PIT as a time source.

I've tested this on my speedstep enabled laptop with success, and others
laptop users seeing this problem have reported it works for them.  Also
to ensure we don't fall back to the slower PIT too quickly, I tested the
code on a system I have that looses ~30 ticks about every second and it
can still manage to use the TSC as a good time source.  

This solves most of the "time doubling" problems seen on laptops.
Additionally this revision has been modified to use the cleanups made in
rename-timer_A1.

Please consider for inclusion in your tree.

thanks
-john

 arch/i386/kernel/timers/timer.c     |    9 +++++++++
 arch/i386/kernel/timers/timer_tsc.c |   13 ++++++++++++-
 include/asm-i386/timer.h            |    1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Mon Jun 30 13:52:43 2003
+++ b/arch/i386/kernel/timers/timer.c	Mon Jun 30 13:52:43 2003
@@ -23,6 +23,15 @@
 }
 __setup("clock=", clock_setup);
 
+
+/* The chosen timesource has been found to be bad. 
+ * Fall back to a known good timesource (the PIT)
+ */
+void clock_fallback(void)
+{
+	cur_timer = &timer_pit;	
+}
+
 /* iterates through the list of timers, returning the first 
  * one that initializes successfully.
  */
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Jun 30 13:52:43 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Jun 30 13:52:43 2003
@@ -124,6 +124,7 @@
 	int countmp;
 	static int count1 = 0;
 	unsigned long long this_offset, last_offset;
+	static int lost_count = 0;
 	
 	write_lock(&monotonic_lock);
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
@@ -178,9 +179,19 @@
 	delta += delay_at_last_interrupt;
 	lost = delta/(1000000/HZ);
 	delay = delta%(1000000/HZ);
-	if (lost >= 2)
+	if (lost >= 2) {
 		jiffies += lost-1;
 
+		/* sanity check to ensure we're not always loosing ticks */
+		if (lost_count++ > 100) {
+			printk(KERN_WARNING "Loosing too many ticks!\n");
+			printk(KERN_WARNING "TSC cannot be used as a timesource."
+					" (Are you running with SpeedStep?)\n");
+			printk(KERN_WARNING "Falling back to a sane timesource.\n");
+			clock_fallback();
+		}
+	} else
+		lost_count = 0;
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Mon Jun 30 13:52:43 2003
+++ b/include/asm-i386/timer.h	Mon Jun 30 13:52:43 2003
@@ -21,6 +21,7 @@
 #define TICK_SIZE (tick_nsec / 1000)
 
 extern struct timer_opts* select_timer(void);
+extern void clock_fallback(void);
 
 /* Modifiers for buggy PIT handling */
 



