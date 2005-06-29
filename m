Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVF2WJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVF2WJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVF2WIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:08:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:23424 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262693AbVF2WF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:05:58 -0400
Subject: [RFC][PATCH] ppc misusing NTP's time_offset value
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org,
       paulus@samba.org
Cc: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 29 Jun 2005 15:05:51 -0700
Message-Id: <1120082751.24889.120.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

	As part of my timeofday rework, I've been looking at the NTP code and I
noticed that the PPC architecture is apparently misusing the NTP's
time_offset (it is a terrible name!) value as some form of timezone
offset. This could cause problems when time_offset changed by the NTP
code.
	
	This patch changes the PPC code so it uses a more clear local variable:
timezone_offset.

Could a PPC maintainer verify this is correct?

Let me know if you have any comments or feedback.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
--- a/arch/ppc/kernel/time.c
+++ b/arch/ppc/kernel/time.c
@@ -90,6 +90,9 @@ unsigned long tb_to_ns_scale;
 
 extern unsigned long wall_jiffies;
 
+/* used for timezone offset */
+static long timezone_offset;
+
 DEFINE_SPINLOCK(rtc_lock);
 
 EXPORT_SYMBOL(rtc_lock);
@@ -171,7 +174,7 @@ void timer_interrupt(struct pt_regs * re
 		     xtime.tv_sec - last_rtc_update >= 659 &&
 		     abs((xtime.tv_nsec / 1000) - (1000000-1000000/HZ)) < 500000/HZ &&
 		     jiffies - wall_jiffies == 1) {
-		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)
+		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + timezone_offset) == 0)
 				last_rtc_update = xtime.tv_sec+1;
 			else
 				/* Try again one minute later */
@@ -284,7 +287,7 @@ void __init time_init(void)
 	unsigned old_stamp, stamp, elapsed;
 
         if (ppc_md.time_init != NULL)
-                time_offset = ppc_md.time_init();
+                timezone_offset = ppc_md.time_init();
 
 	if (__USE_RTC()) {
 		/* 601 processor: dec counts down by 128 every 128ns */
@@ -329,10 +332,10 @@ void __init time_init(void)
 	set_dec(tb_ticks_per_jiffy);
 
 	/* If platform provided a timezone (pmac), we correct the time */
-        if (time_offset) {
-		sys_tz.tz_minuteswest = -time_offset / 60;
+        if (timezone_offset) {
+		sys_tz.tz_minuteswest = -timezone_offset / 60;
 		sys_tz.tz_dsttime = 0;
-		xtime.tv_sec -= time_offset;
+		xtime.tv_sec -= timezone_offset;
         }
         set_normalized_timespec(&wall_to_monotonic,
                                 -xtime.tv_sec, -xtime.tv_nsec);


