Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVHKBg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVHKBg1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 21:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbVHKBg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 21:36:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:37595 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932200AbVHKBgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 21:36:25 -0400
Subject: [RFC][PATCH - 12/13] NTP cleanup: cleanup ntp_advance() adjtime
	code
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1123724120.32531.5.camel@cog.beaverton.ibm.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123723384.30963.269.camel@cog.beaverton.ibm.com>
	 <1123723534.32330.0.camel@cog.beaverton.ibm.com>
	 <1123723578.32330.2.camel@cog.beaverton.ibm.com>
	 <1123723634.32330.4.camel@cog.beaverton.ibm.com>
	 <1123723696.32330.6.camel@cog.beaverton.ibm.com>
	 <1123723739.32330.8.camel@cog.beaverton.ibm.com>
	 <1123723875.32330.10.camel@cog.beaverton.ibm.com>
	 <1123723913.32330.12.camel@cog.beaverton.ibm.com>
	 <1123724003.32531.0.camel@cog.beaverton.ibm.com>
	 <1123724039.32531.2.camel@cog.beaverton.ibm.com>
	 <1123724120.32531.5.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 18:36:20 -0700
Message-Id: <1123724180.32531.6.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch simplifies and cleans up the adjtime code in ntp_advance and
corrects a comment.

Any comments or feedback would be greatly appreciated.

thanks
-john

linux-2.6.13-rc6_timeofday-ntp-part12_B5.patch
============================================
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -156,29 +156,25 @@ void ntp_advance(unsigned long interval_
 	shifted_ppm_sum += ss_adj << SHIFT_USEC;
 
 
-	if ( (time_adjust_step = ntp_adjtime_offset) != 0 ) {
-	    /* We are doing an adjtime thing.
-	     *
-	     * Prepare time_adjust_step to be within bounds.
-	     * Note that a positive ntp_adjtime_offset means we want the clock
-	     * to run faster.
-	     *
-	     * Limit the amount of the step to be in the range
-	     * -tickadj .. +tickadj
-	     */
-		if (ntp_adjtime_offset > tickadj)
-			time_adjust_step = tickadj;
-		else if (ntp_adjtime_offset < -tickadj)
-			time_adjust_step = -tickadj;
+	/* Calculate the fixed tick adjustment */
+	fixed_tick_ns_adj = 0;
 
-	    /* Reduce by this step the amount of time left  */
-	    ntp_adjtime_offset -= time_adjust_step;
+	/* If we are doing an adjtime thing */
+	if (ntp_adjtime_offset) {
+		long adjust_step = ntp_adjtime_offset;
+		/* Limit the amount of the step to be in the range
+		 * -tickadj .. +tickadj
+		 */
+		adjust_step = min_t(long, tickadj, adjust_step);
+		adjust_step = max_t(long, -tickadj, adjust_step);
+		/* Reduce by this step the amount of time left  */
+		ntp_adjtime_offset -= adjust_step;
+		fixed_tick_ns_adj += adjust_step * 1000;
 	}
-	fixed_tick_ns_adj = time_adjust_step * 1000;
 
 	/*
-	 * Advance the phase, once it gets to one microsecond, then
-	 * advance the tick more.
+	 * Advance the phase, once it gets to one nanosecond,
+	 * then advance the fixed_tick_ns_adj.
 	 */
 	time_phase += time_adj;
 	if (time_phase <= -FINENSEC) {


