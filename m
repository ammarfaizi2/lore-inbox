Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbTFXAJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 20:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265019AbTFXAJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 20:09:31 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:22187 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264906AbTFXAJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 20:09:27 -0400
Subject: [PATCH] linux-2.5.73_lost-tick-spst_A0
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1056413762.1028.59.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Jun 2003 17:16:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, all
	This patch (against 2.5.73) tries to resolve issues caused by running
the TSC based lost tick compensation code on CPUs that change frequency
(speedstep, etc). Should the CPU be in slow mode when calibrate_tsc()
executes, the kernel will assume we have so many cycles per tick. Later
when the cpu speeds up, the kernel will start noting that too many
cycles have past since the last interrupt. Since this can occasionally
happen, the lost tick compensation code then tries to fix this by
incrementing jiffies. Thus every tick we end up incrementing jiffies
many times, causing timers to expire too quickly and time to rush ahead.

This patch detects when there has been 100 consecutive interrupts where
we had to compensate for lost ticks. If this occurs, we spit out a
warning and fall back to using the PIT as a time source.

I've tested this on my speedstep enabled laptop with success, and others
laptop users seeing this problem have reported it works for them. Also
to ensure we don't fall back to the slower PIT too quickly, I tested the
code on a system I have that looses ~30 ticks about every second and it
can still manage to use the TSC as a good time source. 

Andrew, would you consider taking this into your tree for further
testing? 

thanks
-john


diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Mon Jun 23 17:03:13 2003
+++ b/arch/i386/kernel/timers/timer.c	Mon Jun 23 17:03:13 2003
@@ -29,6 +29,16 @@
 }
 __setup("clock=", clock_setup);
 
+
+/* The chosen timesource has been found to be bad. 
+ * Fall back to a known good timesource (the PIT)
+ */
+extern struct timer_opts *timer;
+void clock_fallback(void)
+{
+	timer = &timer_pit;	
+}
+
 /* iterates through the list of timers, returning the first 
  * one that initializes successfully.
  */
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Jun 23 17:03:13 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Jun 23 17:03:13 2003
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
+			printk(KERN_WARN "Loosing too many ticks!\n");
+			printk(KERN_WARN "TSC cannot be used as a timesource."
+					" (Are you running with SpeedStep?)\n");
+			printk(KERN_WARN "Falling back to a sane timesource.\n");
+			clock_fallback();
+		}
+	} else
+		lost_count = 0;
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);



