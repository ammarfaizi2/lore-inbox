Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265578AbTFMXPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 19:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265579AbTFMXPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 19:15:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:32156 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265578AbTFMXPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 19:15:48 -0400
Subject: [RFC] linux-2.5.70_time-macro-cleanup_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: george anzinger <george@mvista.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055546646.18636.187.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Jun 2003 16:24:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This quick patch cleans up the i386 time code to use USEC_PER_SEC and
friends. I think George Anzinger has had similar such changes in various
patches he has mailed out, but this splits the cleanup out by itself.

Let me know if you have any comments or suggestions.

thanks
-john


diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Fri Jun 13 16:16:11 2003
+++ b/arch/i386/kernel/time.c	Fri Jun 13 16:16:11 2003
@@ -99,14 +99,14 @@
 		{
 			unsigned long lost = jiffies - wall_jiffies;
 			if (lost)
-				usec += lost * (1000000 / HZ);
+				usec += lost * (USEC_PER_SEC / HZ);
 		}
 		sec = xtime.tv_sec;
-		usec += (xtime.tv_nsec / 1000);
+		usec += (xtime.tv_nsec / NSEC_PER_USEC);
 	} while (read_seqretry(&xtime_lock, seq));
 
-	while (usec >= 1000000) {
-		usec -= 1000000;
+	while (usec >= USEC_PER_SEC) {
+		usec -= USEC_PER_SEC;
 		sec++;
 	}
 
@@ -213,9 +213,9 @@
 	 */
 	if ((time_status & STA_UNSYNC) == 0 &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
-	    (xtime.tv_nsec / 1000)
+	    (xtime.tv_nsec / NSEC_PER_USEC)
 			>= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
-	    (xtime.tv_nsec / 1000)
+	    (xtime.tv_nsec / NSEC_PER_USEC)
 			<= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
 		if (set_rtc_mmss(xtime.tv_sec) == 0)
 			last_rtc_update = xtime.tv_sec;
diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Fri Jun 13 16:16:11 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Fri Jun 13 16:16:11 2003
@@ -67,10 +67,10 @@
 
 	/* lost tick compensation */
 	delta = last_cyclone_low - delta;	
-	delta /= (CYCLONE_TIMER_FREQ/1000000);
+	delta /= (CYCLONE_TIMER_FREQ/USEC_PER_SEC);
 	delta += delay_at_last_interrupt;
-	lost = delta/(1000000/HZ);
-	delay = delta%(1000000/HZ);
+	lost = delta/(USEC_PER_SEC/HZ);
+	delay = delta%(USEC_PER_SEC/HZ);
 	if (lost >= 2)
 		jiffies += lost-1;
 	
@@ -107,7 +107,7 @@
 
 	/* convert cyclone ticks to microseconds */	
 	/* XXX slow, can we speed this up? */
-	offset = offset/(CYCLONE_TIMER_FREQ/1000000);
+	offset = offset/(CYCLONE_TIMER_FREQ/USEC_PER_SEC);
 
 	/* our adjusted time offset in microseconds */
 	return delay_at_last_interrupt + offset;
@@ -131,7 +131,7 @@
 
 	/* convert to nanoseconds */
 	ret = base + ((this_offset - last_offset)&CYCLONE_TIMER_MASK);
-	return ret * (1000000000 / CYCLONE_TIMER_FREQ);
+	return ret * (NSEC_PER_SEC / CYCLONE_TIMER_FREQ);
 }
 
 static int __init init_cyclone(char* override)
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Fri Jun 13 16:16:11 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Fri Jun 13 16:16:11 2003
@@ -176,8 +176,8 @@
 		delta = edx;
 	}
 	delta += delay_at_last_interrupt;
-	lost = delta/(1000000/HZ);
-	delay = delta%(1000000/HZ);
+	lost = delta/(USEC_PER_SEC/HZ);
+	delay = delta%(USEC_PER_SEC/HZ);
 	if (lost >= 2)
 		jiffies += lost-1;
 



