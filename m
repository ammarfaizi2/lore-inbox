Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTKQWuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 17:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTKQWuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 17:50:15 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:55454 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261928AbTKQWuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 17:50:05 -0500
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
From: john stultz <johnstul@us.ibm.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       "Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, cat@zip.com.au,
       gawain@freda.homelinux.org, gene.heskett@verizon.net,
       papadako@csd.uoc.gr, Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <1069104441.11424.1979.camel@cog.beaverton.ibm.com>
References: <1069071092.3238.5.camel@localhost.localdomain>
	 <3FB8C92E.7030201@gmx.de>  <200311172046.17736.schlicht@uni-mannheim.de>
	 <1069104441.11424.1979.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1069109094.11432.1989.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Nov 2003 14:44:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-17 at 13:27, john stultz wrote:
> On Mon, 2003-11-17 at 11:46, Thomas Schlichter wrote:
> > The problem is that sched_clock() uses the TSC if the hardware supports it. 
> > But the needed scaling factors are only initialized in init_tsc() and 
> > init_hpet(). So there are 2 possibilities to fix this:
> > 1. Call the neccessary parts of init_tsc() in init_pmtmr() and init_pit().
> > 2. Use the TSC in sched_clock() only if "clock=tsc" was set.
> 
> As far as sched_clock() goes, I haven't followed its development
> closely, but it seem that it is very close to monotonic_clock() in
> functionality. The benefit of monotonic_clock is that it is implemented
> for each time source (however its not implemented for every arch). For
> i386 at least, we may want to make sched_clock just call
> monotonic_clock, but I need to look into the details. 

Here's a patch that does the above. I'm not very aware of the issues
around the scheduler so I'm not sure if the cost of going off chip to
the cyclone or ACPI PM time sources are just outright, but for the TSC
case monotonic_clock() is basically the same function as sched_clock().
So this might be the best fix for systems not using the TSC as a time
source. 

I'd be interested to hear if it has any effect on performance.

thanks
-john


diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Mon Nov 17 14:36:32 2003
+++ b/arch/i386/kernel/time.c	Mon Nov 17 14:36:32 2003
@@ -190,6 +190,12 @@
 }
 EXPORT_SYMBOL(monotonic_clock);
 
+/* sched_clock() ~== monotonic_clock() */
+unsigned long long sched_clock(void)
+{
+	return cur_timer->monotonic_clock();
+}
+
 
 /*
  * timer_interrupt() needs to keep up the real-time clock,
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Mon Nov 17 14:36:32 2003
+++ b/arch/i386/kernel/timers/timer_pit.c	Mon Nov 17 14:36:32 2003
@@ -37,7 +37,7 @@
 
 static unsigned long long monotonic_clock_pit(void)
 {
-	return 0;
+	return (unsigned long long)jiffies * (NSEC_PER_SEC / HZ);
 }
 
 static void delay_pit(unsigned long loops)
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Nov 17 14:36:32 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Nov 17 14:36:32 2003
@@ -127,30 +127,6 @@
 	return base + cycles_2_ns(this_offset - last_offset);
 }
 
-/*
- * Scheduler clock - returns current time in nanosec units.
- */
-unsigned long long sched_clock(void)
-{
-	unsigned long long this_offset;
-
-	/*
-	 * In the NUMA case we dont use the TSC as they are not
-	 * synchronized across all CPUs.
-	 */
-#ifndef CONFIG_NUMA
-	if (unlikely(!cpu_has_tsc))
-#endif
-		return (unsigned long long)jiffies * (1000000000 / HZ);
-
-	/* Read the Time Stamp Counter */
-	rdtscll(this_offset);
-
-	/* return the value in ns */
-	return cycles_2_ns(this_offset);
-}
-
-
 static void mark_offset_tsc(void)
 {
 	unsigned long lost,delay;



