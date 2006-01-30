Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030179AbWA3W3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbWA3W3h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 17:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWA3W3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 17:29:37 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:16342 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932392AbWA3W3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 17:29:36 -0500
Subject: [PATCH] disable lost tick compensation before TSCs are synced
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 14:29:24 -0800
Message-Id: <1138660164.10057.20.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid lost tick compensation early in boot before the TSCs are
synchronized. Currently timekeeping is enabled before the TSCs are
synchronized, thus when the TSCs are synched (reset to zero), it appears
that a number of lost ticks have occurred. This can cause premature
expiry of timers and in extreme cases can cause the soft lockup
detection to fire.

This resolves issues reported by Andy Whitcroft as well as bug #5366
reported by Tim Mann.

The new timekeeping work avoids this issue, but since it is not quite
ready for mainline, this patch would be a good idea for 2.6.16.

thanks
-john


Signed-off-by: John Stultz <johnstul@us.ibm.com>
Acked-by: Andy Whitcroft <apw@shadowen.org>

diff --git a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c
+++ b/arch/i386/kernel/timers/timer_tsc.c
@@ -45,6 +45,15 @@ static unsigned long last_tsc_high; /* m
 static unsigned long long monotonic_base;
 static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
 
+/* Avoid compensating for lost ticks before TSCs are synched */
+static int detect_lost_ticks;
+static int __init start_lost_tick_compensation(void)
+{
+	detect_lost_ticks = 1;
+	return 0;
+}
+late_initcall(start_lost_tick_compensation);
+
 /* convert from cycles(64bits) => nanoseconds (64bits)
  *  basic equation:
  *		ns = cycles / (freq / ns_per_sec)
@@ -196,7 +205,8 @@ static void mark_offset_tsc_hpet(void)
 
 	/* lost tick compensation */
 	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
-	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))) {
+	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))
+					&& detect_lost_ticks) {
 		int lost_ticks = (offset - hpet_last) / hpet_tick;
 		jiffies_64 += lost_ticks;
 	}
@@ -419,7 +429,7 @@ static void mark_offset_tsc(void)
 	delta += delay_at_last_interrupt;
 	lost = delta/(1000000/HZ);
 	delay = delta%(1000000/HZ);
-	if (lost >= 2) {
+	if (lost >= 2 && detect_lost_ticks) {
 		jiffies_64 += lost-1;
 
 		/* sanity check to ensure we're not always losing ticks */


