Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVHBGM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVHBGM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 02:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVHBGKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 02:10:31 -0400
Received: from koto.vergenet.net ([210.128.90.7]:49293 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S261386AbVHBGKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 02:10:06 -0400
Date: Tue, 2 Aug 2005 16:16:51 +0900
From: Horms <horms@verge.net.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: John Stultz <johnstul@us.ibm.com>, Tom Rini <trini@kernel.crashing.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: [Patch] ppc32: stop misusing ntps time_offset value
Message-ID: <20050802071648.GA22793@verge.net.au>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	John Stultz <johnstul@us.ibm.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
	Greg Kroah-Hartman <gregkh@suse.de>, debian-kernel@lists.debian.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

is this appropriate for 2.4? It seems to apply cleanly to 
your current git tree.

Signed-off-by: Horms <horms@verge.net.au>

From: john stultz <johnstul@us.ibm.com>
Date: Fri, 1 Jul 2005 05:08:54 +0000 (+1000)
Subject: [PATCH] ppc32: stop misusing ntps time_offset value
X-Git-Tag: v2.6.12.3
X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/gregkh/linux-2.6.12.y.git;a=commitdiff;h=8f399a7448e0b58eae969426f61b7e81d55d2639

  [PATCH] ppc32: stop misusing ntps time_offset value
  
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
Backported to Debian's 2.6.8 by dann frazier <dannf@debian.org>
Backported to Debian's 2.4.27 by Horms <horms@debian.org>

--- a/arch/ppc/kernel/time.c	2003-08-25 20:44:40.000000000 +0900
+++ b/arch/ppc/kernel/time.c	2005-08-02 15:37:12.000000000 +0900
@@ -84,7 +84,7 @@
 
 extern unsigned long wall_jiffies;
 
-static long time_offset;
+static long timezone_offset;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
@@ -187,7 +187,7 @@
 		     xtime.tv_sec - last_rtc_update >= 659 &&
 		     abs(xtime.tv_usec - (1000000-1000000/HZ)) < 500000/HZ &&
 		     jiffies - wall_jiffies == 1) {
-		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)
+		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + timezone_offset) == 0)
 				last_rtc_update = xtime.tv_sec+1;
 			else
 				/* Try again one minute later */
@@ -297,7 +297,7 @@
 	unsigned old_stamp, stamp, elapsed;
 
         if (ppc_md.time_init != NULL)
-                time_offset = ppc_md.time_init();
+                timezone_offset = ppc_md.time_init();
 
 	if (__USE_RTC()) {
 		/* 601 processor: dec counts down by 128 every 128ns */
@@ -344,9 +344,9 @@
 	/* If platform provided a timezone (pmac), we correct the time
 	 * using do_sys_settimeofday() which in turn calls warp_clock()
 	 */
-        if (time_offset) {
+        if (timezone_offset) {
         	struct timezone tz;
-        	tz.tz_minuteswest = -time_offset / 60;
+        	tz.tz_minuteswest = -timezone_offset / 60;
         	tz.tz_dsttime = 0;
         	do_sys_settimeofday(NULL, &tz);
         }
