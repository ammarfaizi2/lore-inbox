Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267654AbTAaAIB>; Thu, 30 Jan 2003 19:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267655AbTAaAIB>; Thu, 30 Jan 2003 19:08:01 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24758 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267654AbTAaAIA>; Thu, 30 Jan 2003 19:08:00 -0500
Subject: [RFC][PATCH] linux-2.4.21-pre4_tsc-lost-tick_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1043972238.19049.27.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 30 Jan 2003 16:17:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Occasionally due to hardware or software, its possible to miss multiple
timer interrupts. This can cause small inconsistencies in time as well
as time drifting behind other systems. 

This patch checks each timer interrupt, using the TSC, if we have missed
any ticks. Then if so, compensates jiffies for them. I have already
submitted a patch for 2.4 which does this for the cyclone-timer based
code, and I've been testing a version for 2.5 for all time sources (in
-mm6, I believe). 

Since this code affects more users then the cyclone-based version, I
want to be more careful and get more testing in the 2.5 tree before I
submit this. However, just so people wanting it can play with it and
test it themselves, I wanted to send this out for comments. 

I'm already somewhat cautious that loops_per_jiffy isn't going to cut it
with this patch (I'm thinking fast_gettimeoffset_quotient would probably
be better). So please let me know if you find any issues with this
patch.

thanks
-john

diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Thu Jan 30 16:03:19 2003
+++ b/arch/i386/kernel/time.c	Thu Jan 30 16:03:19 2003
@@ -657,6 +657,7 @@
 	if(use_cyclone)
 		mark_timeoffset_cyclone();
 	else if (use_tsc) {
+		unsigned long delta = last_tsc_low;
 		/*
 		 * It is important that these two operations happen almost at
 		 * the same time. We do the RDTSC stuff first, since it's
@@ -700,6 +701,13 @@
 		   momentarily as they flip back to zero */
 		if (count == LATCH) {
 			count--;
+		}
+
+		/* lost tick compensation */
+		delta = last_tsc_low - delta;
+		if(delta >= 2*loops_per_jiffy){
+			delta = (delta/loops_per_jiffy)-1;
+			jiffies += delta;
 		}
 
 		count = ((LATCH-1) - count) * TICK_SIZE;



