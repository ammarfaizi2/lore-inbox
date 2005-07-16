Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVGPDEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVGPDEh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVGPDCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:02:34 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:45204 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262068AbVGPDCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 23:02:13 -0400
Subject: [RFC][PATCH - 6/12] NTP cleanup: Clean up ntp_adjtimex() arguement
	checking
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1121482804.25236.39.camel@cog.beaverton.ibm.com>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <1121482620.25236.31.camel@cog.beaverton.ibm.com>
	 <1121482672.25236.33.camel@cog.beaverton.ibm.com>
	 <1121482713.25236.35.camel@cog.beaverton.ibm.com>
	 <1121482758.25236.37.camel@cog.beaverton.ibm.com>
	 <1121482804.25236.39.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 20:02:05 -0700
Message-Id: <1121482925.25236.42.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Currently ntp_adjtimex() checks the validity of a few arguments values
then takes the xtime_lock then checks the validity of more arguments
while it parses them. This separates the logic so we check the validity
of all arguments before aquiring the xtime lock. This greatly improves
the readability of the code.

Any comments or feedback would be greatly appreciated.

thanks
-john


linux-2.6.13-rc3_timeofday-ntp-part6_B4.patch
============================================
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -267,21 +267,44 @@ int ntp_adjtimex(struct timex *txc)
 
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
@@ -290,65 +313,42 @@ int ntp_adjtimex(struct timex *txc)
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


