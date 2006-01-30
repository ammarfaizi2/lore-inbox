Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWA3N3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWA3N3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 08:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWA3N3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 08:29:46 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:6670 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932263AbWA3N3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 08:29:45 -0500
Message-ID: <43DE14F0.5070208@shadowen.org>
Date: Mon, 30 Jan 2006 13:30:24 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] timer tsc ensure we allow for initial tsc and tsc sync
References: <20060120125342.GA7632@shadowen.org> <1138399887.14289.107.camel@cog.beaverton.ibm.com>
In-Reply-To: <1138399887.14289.107.camel@cog.beaverton.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050508000901040707030407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050508000901040707030407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

john stultz wrote:

> There's a test patch in there that maybe you could try?

Yep this one also seems to fix it.  It also looks like a more general
solution than mine.  I've attached the patch here so that its recorded
with this.  I've added some description to the top.  Tests ok on the
machine which was showing issues for me.  Help yourself to a:

Acked-by: Andy Whitcroft <apw@shadowen.org>

If you are happy with it I for one would like to see it in -mm.  Perhaps
you could sign it off and send it to Andrew for inclusion.

-apw

--------------050508000901040707030407
Content-Type: text/plain;
 name="jstultz-suppress-lost-tick-processing-till-after-timers-are-up-and-synchronised"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jstultz-suppress-lost-tick-processing-till-after-timers-are-up-and-synchronised"

From: John Stultz <johnstul@us.ibm.com>

Suppress lost tick detection until we are fully initialised.
This prevents any modifications to the high resolution timers
from causing non-linearities in the flow of time.  For example on
an SMP system we resyncronise the TSC values for all processors.
This results in a TSC reset which will be seen as a huge apparent
tick loss.  This can cause premature expiry of timers and in extreme
cases can cause the soft lockup detection to fire.

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

--------------050508000901040707030407--
