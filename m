Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWHJAOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWHJAOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWHJAOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:14:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:12938 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932320AbWHJAOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:14:51 -0400
Message-Id: <20060810001114.155770000@linux-m68k.org>
References: <20060810000146.913645000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 10 Aug 2006 02:01:49 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: [NTP 3/9] add time_freq to tick length
Content-Disposition: inline; filename=0003-NTP-add-time_freq-to-tick-length.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the frequency part to ntp_update_frequency().

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
---
 kernel/time/ntp.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6-mm/kernel/time/ntp.c
===================================================================
--- linux-2.6-mm.orig/kernel/time/ntp.c
+++ linux-2.6-mm/kernel/time/ntp.c
@@ -43,8 +43,7 @@ long time_tolerance = MAXFREQ;		/* frequ
 long time_precision = 1;		/* clock precision (us)		*/
 long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
-long time_freq = (((NSEC_PER_SEC + HZ/2) % HZ - HZ/2) << SHIFT_USEC) / NSEC_PER_USEC;
-					/* frequency offset (scaled ppm)*/
+long time_freq;				/* frequency offset (scaled ppm)*/
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 long time_next_adjust;
@@ -73,6 +72,7 @@ void ntp_update_frequency(void)
 {
 	tick_length_base = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << TICK_LENGTH_SHIFT;
 	tick_length_base += (s64)CLOCK_TICK_ADJUST << TICK_LENGTH_SHIFT;
+	tick_length_base += ((s64)time_freq * NSEC_PER_USEC) << (TICK_LENGTH_SHIFT - SHIFT_USEC);
 
 	do_div(tick_length_base, HZ);
 
@@ -169,8 +169,6 @@ void second_overflow(void)
 	 * Compute the frequency estimate and additional phase adjustment due
 	 * to frequency error for the next second.
 	 */
-	ltemp = time_freq;
-	time_adj += shift_right(ltemp,(SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
 
 #if HZ == 100
 	/*
@@ -395,7 +393,7 @@ int do_adjtimex(struct timex *txc)
 	    if (txc->modes & ADJ_TICK)
 		tick_usec = txc->tick;
 
-	    if (txc->modes & ADJ_TICK)
+	    if (txc->modes & (ADJ_TICK|ADJ_FREQUENCY|ADJ_OFFSET))
 		    ntp_update_frequency();
 	} /* txc->modes */
 leave:	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0)

--

