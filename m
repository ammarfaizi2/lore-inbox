Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWHJAPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWHJAPi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWHJAPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:15:37 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:13962 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932342AbWHJAPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:15:36 -0400
Message-Id: <20060810001114.974838000@linux-m68k.org>
References: <20060810000146.913645000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 10 Aug 2006 02:01:52 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: [NTP 6/9] remove time_tolerance
Content-Disposition: inline; filename=0006-NTP-remove-time_tolerance.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

time_tolerance isn't changed at all in the kernel, so simply remove it,
this simplifies the next patch, as it avoids a number of conversions.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
---
 include/linux/timex.h |    1 -
 kernel/time/ntp.c     |    9 ++++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h
+++ linux-2.6-mm/include/linux/timex.h
@@ -207,7 +207,6 @@ extern int time_state;		/* clock status 
 extern int time_status;		/* clock synchronization status bits */
 extern long time_offset;	/* time adjustment (us) */
 extern long time_constant;	/* pll time constant */
-extern long time_tolerance;	/* frequency tolerance (ppm) */
 extern long time_precision;	/* clock precision (us) */
 extern long time_maxerror;	/* maximum error */
 extern long time_esterror;	/* estimated error */
Index: linux-2.6-mm/kernel/time/ntp.c
===================================================================
--- linux-2.6-mm.orig/kernel/time/ntp.c
+++ linux-2.6-mm/kernel/time/ntp.c
@@ -40,7 +40,6 @@ int time_state = TIME_OK;		/* clock sync
 int time_status = STA_UNSYNC;		/* clock status bits		*/
 long time_offset;			/* time adjustment (ns)		*/
 long time_constant = 2;			/* pll time constant		*/
-long time_tolerance = MAXFREQ;		/* frequency tolerance (ppm)	*/
 long time_precision = 1;		/* clock precision (us)		*/
 long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
@@ -93,7 +92,7 @@ void second_overflow(void)
 	long time_adj;
 
 	/* Bump the maxerror field */
-	time_maxerror += time_tolerance >> SHIFT_USEC;
+	time_maxerror += MAXFREQ >> SHIFT_USEC;
 	if (time_maxerror > NTP_PHASE_LIMIT) {
 		time_maxerror = NTP_PHASE_LIMIT;
 		time_status |= STA_UNSYNC;
@@ -319,8 +318,8 @@ int do_adjtimex(struct timex *txc)
 			} else /* calibration interval too long (p. 12) */
 				result = TIME_ERROR;
 		    }
-		    time_freq = min(time_freq, time_tolerance);
-		    time_freq = max(time_freq, -time_tolerance);
+		    time_freq = min(time_freq, MAXFREQ);
+		    time_freq = max(time_freq, -MAXFREQ);
 		    time_offset = (time_offset * NSEC_PER_USEC / HZ) << SHIFT_UPDATE;
 		} /* STA_PLL */
 	    } /* txc->modes & ADJ_OFFSET */
@@ -343,7 +342,7 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	txc->status	   = time_status;
 	txc->constant	   = time_constant;
 	txc->precision	   = time_precision;
-	txc->tolerance	   = time_tolerance;
+	txc->tolerance	   = MAXFREQ;
 	txc->tick	   = tick_usec;
 
 	/* PPS is not implemented, so these are zero */

--

