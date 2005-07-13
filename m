Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVGMWJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVGMWJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVGMSpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:45:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:21219 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262319AbVGMSoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:44:54 -0400
Date: Wed, 13 Jul 2005 11:42:32 -0700
From: Greg KH <gregkh@suse.de>
To: benh@kernel.crashing.org, johnstul@us.ibm.com, trini@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [03/11] ppc32: stop misusing ntps time_offset value
Message-ID: <20050713184232.GD9330@kroah.com>
References: <20050713184130.GA9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184130.GA9330@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: john stultz <johnstul@us.ibm.com>

As part of my timeofday rework, I've been looking at the NTP code and I
noticed that the PPC architecture is apparently misusing the NTP's
time_offset (it is a terrible name!) value as some form of timezone offset.

This could cause problems when time_offset changed by the NTP code.  This
patch changes the PPC code so it uses a more clear local variable:
timezone_offset.

Signed-off-by: John Stultz <johnstul@us.ibm.com>
Acked-by: Tom Rini <trini@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/ppc/kernel/time.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

--- linux-2.6.12.2.orig/arch/ppc/kernel/time.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/arch/ppc/kernel/time.c	2005-07-13 10:56:23.000000000 -0700
@@ -89,6 +89,9 @@
 
 extern unsigned long wall_jiffies;
 
+/* used for timezone offset */
+static long timezone_offset;
+
 DEFINE_SPINLOCK(rtc_lock);
 
 EXPORT_SYMBOL(rtc_lock);
@@ -170,7 +173,7 @@
 		     xtime.tv_sec - last_rtc_update >= 659 &&
 		     abs((xtime.tv_nsec / 1000) - (1000000-1000000/HZ)) < 500000/HZ &&
 		     jiffies - wall_jiffies == 1) {
-		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)
+		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + timezone_offset) == 0)
 				last_rtc_update = xtime.tv_sec+1;
 			else
 				/* Try again one minute later */
@@ -286,7 +289,7 @@
 	unsigned old_stamp, stamp, elapsed;
 
         if (ppc_md.time_init != NULL)
-                time_offset = ppc_md.time_init();
+                timezone_offset = ppc_md.time_init();
 
 	if (__USE_RTC()) {
 		/* 601 processor: dec counts down by 128 every 128ns */
@@ -331,10 +334,10 @@
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
