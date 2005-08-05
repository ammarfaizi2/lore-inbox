Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbVHENuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbVHENuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 09:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVHENuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 09:50:23 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:64936 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263020AbVHENuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 09:50:11 -0400
Date: Fri, 5 Aug 2005 15:50:07 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc5-gitNOW] msleep() cannot be used from interrupt
Message-ID: <20050805135007.GA6985@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
  can you apply patch below?

Since beginning of July my Opteron box was randomly crashing and being rebooted
by hardware watchdog.  Today it finally did it in front of me, and this patch
will hopefully fix it.

Problem is that at the end of June (28th, commit 
47f176fdaf8924bc83fddcf9658f2fd3ef60d573, [PATCH] Using msleep() instead of HZ) 
rtc_get_rtc_time was converted to use msleep() instead of busy waiting.  But
rtc_get_rtc_time is used by hpet_rtc_interrupt, and scheduling is not allowed
during interrupt.  So I'm reverting this part of original change, replacing
msleep() back with busy loop.

Original old code was busy waiting for 20ms, while on my hardware in the worst
case update-in-progress bit was asserted for at most 363 passes through loop
(on 2GHz dual Opteron), much less than even one jiffie, not even talking
about 20ms.  So I changed code to just wait only as long as necessary.  Otherwise
when RTC was set to generate 8192Hz timer, it stopped doing anything for
20ms (160 pulses were skipped!) from time to time, and this is rather suboptimal
as far as I can tell.

						Thanks,
							Petr Vandrovec


Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>

diff -urdN linux/drivers/char/rtc.c linux/drivers/char/rtc.c
--- linux/drivers/char/rtc.c	2005-08-05 12:43:54.000000000 +0000
+++ linux/drivers/char/rtc.c	2005-08-05 13:26:48.000000000 +0000
@@ -1209,6 +1209,7 @@
 
 void rtc_get_rtc_time(struct rtc_time *rtc_tm)
 {
+	unsigned long uip_watchdog = jiffies;
 	unsigned char ctrl;
 #ifdef CONFIG_MACH_DECSTATION
 	unsigned int real_year;
@@ -1224,8 +1225,10 @@
 	 * Once the read clears, read the RTC time (again via ioctl). Easy.
 	 */
 
-	if (rtc_is_updating() != 0)
-		msleep(20);
+	while (rtc_is_updating() != 0 && jiffies - uip_watchdog < 2*HZ/100) {
+		barrier();
+		cpu_relax();
+	}
 
 	/*
 	 * Only the values that we read from the RTC are set. We leave
