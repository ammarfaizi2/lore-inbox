Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbTFUAAp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 20:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbTFUAAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 20:00:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:12980 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264997AbTFUAAn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 20:00:43 -0400
Subject: Re: 2.5.72: wall-clock time advancing too rapidly?
From: john stultz <johnstul@us.ibm.com>
To: Andy Pfiffer <andyp@osdl.org>
Cc: Andreas Haumer <andreas@xss.co.at>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1056151705.1162.114.camel@andyp.pdx.osdl.net>
References: <1056039012.3879.5.camel@andyp.pdx.osdl.net>
	 <1056058206.18644.532.camel@w-jstultz2.beaverton.ibm.com>
	 <3EF32223.6000207@xss.co.at> <1056151705.1162.114.camel@andyp.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1056154072.1027.13.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Jun 2003 17:07:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, I've got a first pass at a patch that might solve this. 

This patch detects if we have 100 consecutive interrupts that find lost
ticks. If that occurs, we assume that the TSC is changing frequency and
we fall back to the PIT for a time source (equiv to booting w/
clock=pit). 

I'd like to see this well tested as I don't want to prematurely disable
the TSC if lost ticks is just doing its job, but I also want to catch
speedstep cpus before folks notice time going out of control. So the #
of consecutive interrupts may need adjusting. 

thanks
-john

This patch can also be found under bugme bug #827
http://bugme.osdl.org/show_bug.cgi?id=827

diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Fri Jun 20 16:56:05 2003
+++ b/arch/i386/kernel/timers/timer.c	Fri Jun 20 16:56:05 2003
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
--- a/arch/i386/kernel/timers/timer_tsc.c	Fri Jun 20 16:56:05 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Fri Jun 20 16:56:05 2003
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
+			printk("Loosing too many ticks!\n");
+			printk("TSC cannot be used as a timesource."
+					" (Are you running with SpeedStep?)\n");
+			printk("Falling back to a sane timesource.\n");
+			clock_fallback();
+		}
+	} else
+		lost_count = 0;
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);





