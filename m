Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWCQXas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWCQXas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWCQXas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:30:48 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:41371 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751374AbWCQXar
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:30:47 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
Message-Id: <2.132654658@selenic.com>
Subject: [PATCH 1/14] RTC: Remove RTC UIP synchronization on x86
Date: Fri, 17 Mar 2006 17:30:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RTC UIP synchronization on x86

Reading the CMOS clock on x86 and some other arches currently takes up
to one second because it synchronizes with the CMOS second tick-over.
This delay shows up at boot time as well a resume time.

This is the currently the most substantial boot time delay for
machines that are working towards instant-on capability. Also, a quick
back of the envelope calculation (.5sec * 2M users * 1 boot a day * 10 years)
suggests it has cost Linux users in the neighborhood of a million
man-hours.

An earlier thread on this topic is here:

http://groups.google.com/group/linux.kernel/browse_frm/thread/8a24255215ff6151/2aa97e66a977653d?hl=en&lr=&ie=UTF-8&rnum=1&prev=/groups%3Fhl%3Den%26lr%3D%26ie%3DUTF-8%26selm%3D1To2R-2S7-11%40gated-at.bofh.it#2aa97e66a977653d

..from which the consensus seems to be that it's no longer desirable.

In my view, there are basically four cases to consider:

1) networked, need precise walltime: use NTP
2) networked, don't need precise walltime: use NTP anyway
3) not networked, don't need sub-second precision walltime: don't care
4) not networked, need sub-second precision walltime:
   get a network or a radio time source because RTC isn't good enough anyway

So this patch series simply removes the synchronization in favor of a
simple seqlock-like approach using the seconds value.

Note that for purposes of timer accuracy on wakeup, this patch will
cause us to fire timers up to one second late. But as the current
timer resume code will already sync once (or more!), it's no worse for
short timers.


Index: 2.6.16-rc4-rtc/include/asm-i386/mach-default/mach_time.h
===================================================================
--- 2.6.16-rc4-rtc.orig/include/asm-i386/mach-default/mach_time.h	2006-02-24 15:48:47.000000000 -0600
+++ 2.6.16-rc4-rtc/include/asm-i386/mach-default/mach_time.h	2006-02-24 15:49:41.000000000 -0600
@@ -82,21 +82,8 @@ static inline int mach_set_rtc_mmss(unsi
 static inline unsigned long mach_get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	int i;
 
-	/* The Linux interpretation of the CMOS clock register contents:
-	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
-	 * RTC registers show the second which has precisely just started.
-	 * Let's hope other operating systems interpret the RTC the same way.
-	 */
-	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
-			break;
-	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-			break;
-	do { /* Isn't this overkill ? UIP above should guarantee consistency */
+	do {
 		sec = CMOS_READ(RTC_SECONDS);
 		min = CMOS_READ(RTC_MINUTES);
 		hour = CMOS_READ(RTC_HOURS);
@@ -104,6 +91,7 @@ static inline unsigned long mach_get_cmo
 		mon = CMOS_READ(RTC_MONTH);
 		year = CMOS_READ(RTC_YEAR);
 	} while (sec != CMOS_READ(RTC_SECONDS));
+
 	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
 	  {
 	    BCD_TO_BIN(sec);
