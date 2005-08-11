Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVHKB3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVHKB3G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 21:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVHKB3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 21:29:06 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:4066 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932105AbVHKB3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 21:29:04 -0400
Subject: [RFC][PATCH - 6/13] NTP cleanup: Clean up ntp_adjtimex() arguement
	checking
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1123723696.32330.6.camel@cog.beaverton.ibm.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123723384.30963.269.camel@cog.beaverton.ibm.com>
	 <1123723534.32330.0.camel@cog.beaverton.ibm.com>
	 <1123723578.32330.2.camel@cog.beaverton.ibm.com>
	 <1123723634.32330.4.camel@cog.beaverton.ibm.com>
	 <1123723696.32330.6.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 18:28:59 -0700
Message-Id: <1123723739.32330.8.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All
	Currently ntp_adjtimex() checks the validity of a few arguments values
then takes the xtime_lock then checks the validity of more arguements
while it parses them. This separates the logic so we check the validity
of all arguements before aquiring the xtime lock. This greatly improves
the readability of the code.

Any comments or feedback would be greatly appreciated.

thanks
-john


linux-2.6.13-rc6_timeofday-ntp-part6_B5.patch
============================================
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -264,21 +264,44 @@ int ntp_adjtimex(struct timex *txc)
 
 	/* Now we validate the data before disabling interrupts */
 
-	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
-		/* singleshot must not be used with any other mode bits */
-		if (txc->modes != ADJ_OFFSET_SINGLESHOT)
-			return -EINVAL;
-
-	if (txc->modes != ADJ_OFFSET_SINGLESHOT && (txc->modes & ADJ_OFFSET))
-		/* adjustment Offset limited to +- .512 seconds */
-		if (txc->offset <= - MAXPHASE || txc->offset >= MAXPHASE )
-			return -EINVAL;
-
-	/* if the quartz is off by more than 10% something is VERY wrong ! */
-	if (txc->modes & ADJ_TICK)
-		if (txc->tick <  900000/USER_HZ ||
-				txc->tick > 1100000/USER_HZ)
-			return -EINVAL;
+	/* frequency adjustment limited to +/- MAXFREQ */
+	if ((txc->modes & ADJ_FREQUENCY)
+			&& (abs(txc->freq) > MAXFREQ))
+		return -EINVAL;
+
+	/* maxerror adjustment limited to NTP_PHASE_LIMIT */
+	if ((txc->modes & ADJ_MAXERROR)
+			&& (txc->maxerror < 0
+				|| txc->maxerror >= NTP_PHASE_LIMIT))
+		return -EINVAL;
+
+	/* esterror adjustment limited to NTP_PHASE_LIMIT */
+	if ((txc->modes & ADJ_ESTERROR)
+			&& (txc->esterror < 0
+				|| txc->esterror >= NTP_PHASE_LIMIT))
+		return -EINVAL;
+
+	/* constant adjustment must be positive */
+	if ((txc->modes & ADJ_TIMECONST)
+			&& (txc->constant < 0)) /* NTP v4 uses values > 6 */
+		return -EINVAL;
+
+	/* Single shot mode can only be used by itself */
+	if (((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
+			&& (txc->modes != ADJ_OFFSET_SINGLESHOT))
+		return -EINVAL;
+
+	/* offset adjustment limited to +/- MAXPHASE */
+	if ((txc->modes != ADJ_OFFSET_SINGLESHOT)
+			&& (txc->modes & ADJ_OFFSET)
+			&& (abs(txc->offset)>= MAXPHASE))
+		return -EINVAL;
+
+	/* tick adjustment limited to 10% */
+	if ((txc->modes & ADJ_TICK)
+			&& ((txc->tick < 900000/USER_HZ)
+				||(txc->tick > 11000000/USER_HZ)))
+		return -EINVAL;
 
 	write_seqlock_irq(&xtime_lock);
 	result = time_state;       /* mostly `TIME_OK' */
@@ -287,65 +310,42 @@ int ntp_adjtimex(struct timex *txc)
 	save_adjust = time_next_adjust ? time_next_adjust : time_adjust;
 
 	/* If there are input parameters, then process them */
-	if (txc->modes)	{
-		if (txc->modes & ADJ_STATUS)	/* only set allowed bits */
-			time_status =  (txc->status & ~STA_RONLY) |
-					(time_status & STA_RONLY);
-
-		if (txc->modes & ADJ_FREQUENCY) {	/* p. 22 */
-			if (txc->freq > MAXFREQ || txc->freq < -MAXFREQ) {
-				result = -EINVAL;
-				goto leave;
-			}
-			time_freq = txc->freq;
-		}
-
-		if (txc->modes & ADJ_MAXERROR) {
-			if (txc->maxerror < 0
-					|| txc->maxerror >= NTP_PHASE_LIMIT) {
-				result = -EINVAL;
-				goto leave;
-			}
-			time_maxerror = txc->maxerror;
-		}
-
-		if (txc->modes & ADJ_ESTERROR) {
-			if (txc->esterror < 0
-					|| txc->esterror >= NTP_PHASE_LIMIT) {
-				result = -EINVAL;
-				goto leave;
-			}
-			time_esterror = txc->esterror;
-		}
 
-		if (txc->modes & ADJ_TIMECONST) {	/* p. 24 */
-			if (txc->constant < 0) { /* NTP v4 uses values > 6 */
-				result = -EINVAL;
-				goto leave;
-			}
-			time_constant = txc->constant;
-		}
+	if (txc->modes & ADJ_STATUS)	/* only set allowed bits */
+		time_status = (txc->status & ~STA_RONLY) |
+				(time_status & STA_RONLY);
+
+	if (txc->modes & ADJ_FREQUENCY)
+		time_freq = txc->freq;
+
+	if (txc->modes & ADJ_MAXERROR)
+		time_maxerror = txc->maxerror;
+
+	if (txc->modes & ADJ_ESTERROR)
+		time_esterror = txc->esterror;
+
+	if (txc->modes & ADJ_TIMECONST)
+		time_constant = txc->constant;
+
+	if (txc->modes & ADJ_OFFSET) {
+		if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
+			/* adjtime() is independent from ntp_adjtime() */
+			if ((time_next_adjust = txc->offset) == 0)
+				time_adjust = 0;
+		} else if (ntp_hardupdate(txc->offset, xtime))
+			result = TIME_ERROR;
+	}
 
-		if (txc->modes & ADJ_OFFSET) { /* values checked earlier */
-			if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
-				/* adjtime() is independent from ntp_adjtime() */
-				if ((time_next_adjust = txc->offset) == 0)
-					time_adjust = 0;
-				else if (ntp_hardupdate(txc->offset, xtime))
-					result = TIME_ERROR;
-			}
-		} /* txc->modes & ADJ_OFFSET */
-
-		if (txc->modes & ADJ_TICK) {
-			tick_usec = txc->tick;
-			tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
-		}
-	} /* txc->modes */
-leave:
+	if (txc->modes & ADJ_TICK) {
+		tick_usec = txc->tick;
+		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
+	}
 
 	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0)
 		result = TIME_ERROR;
 
+	/* write kernel state to user timex values*/
+
 	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
 		txc->offset = save_adjust;
 	else {


