Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVLUX0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVLUX0x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbVLUX0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:26:52 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:62602 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964981AbVLUX0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:26:51 -0500
Date: Thu, 22 Dec 2005 00:26:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 7/10] NTP: remove time_tolerance
Message-ID: <Pine.LNX.4.61.0512220025550.30921@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


time_tolerance isn't changed at all in the kernel, so simply remove it
and use a constant instead, this simplifies the next patch, as it avoids
a number of conversions.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/timex.h |    1 -
 kernel/time.c         |    6 +++---
 kernel/timer.c        |    3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h	2005-12-21 12:12:11.000000000 +0100
+++ linux-2.6-mm/include/linux/timex.h	2005-12-21 12:12:15.000000000 +0100
@@ -208,7 +208,6 @@ extern int time_state;		/* clock status 
 extern int time_status;		/* clock synchronization status bits */
 extern long time_offset;	/* time adjustment (ns) */
 extern long time_constant;	/* pll time constant */
-extern long time_tolerance;	/* frequency tolerance (ppm) */
 extern long time_precision;	/* clock precision (us) */
 extern long time_maxerror;	/* maximum error */
 extern long time_esterror;	/* estimated error */
Index: linux-2.6-mm/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/kernel/time.c	2005-12-21 12:12:11.000000000 +0100
+++ linux-2.6-mm/kernel/time.c	2005-12-21 12:12:15.000000000 +0100
@@ -337,8 +337,8 @@ int do_adjtimex(struct timex *txc)
 			} else /* calibration interval too long (p. 12) */
 				result = TIME_ERROR;
 		    }
-		    time_freq = min(time_freq, time_tolerance);
-		    time_freq = max(time_freq, -time_tolerance);
+		    time_freq = min(time_freq, MAXFREQ);
+		    time_freq = max(time_freq, -MAXFREQ);
 		    time_offset = (time_offset / HZ) << SHIFT_HZ;
 		} /* STA_PLL */
 	    } /* txc->modes & ADJ_OFFSET */
@@ -361,7 +361,7 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	txc->status	   = time_status;
 	txc->constant	   = time_constant;
 	txc->precision	   = time_precision;
-	txc->tolerance	   = time_tolerance;
+	txc->tolerance	   = MAXFREQ;
 	txc->tick	   = tick_usec;
 
 	/* PPS is not implemented, so these are zero */
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2005-12-21 12:12:11.000000000 +0100
+++ linux-2.6-mm/kernel/timer.c	2005-12-21 12:12:15.000000000 +0100
@@ -578,7 +578,6 @@ int time_state = TIME_OK;		/* clock sync
 int time_status = STA_UNSYNC;		/* clock status bits		*/
 long time_offset;			/* time adjustment (ns)		*/
 long time_constant = 2;			/* pll time constant		*/
-long time_tolerance = MAXFREQ;		/* frequency tolerance (ppm)	*/
 long time_precision = 1;		/* clock precision (us)		*/
 long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
@@ -648,7 +647,7 @@ static void second_overflow(void)
 	long ltemp;
 
 	/* Bump the maxerror field */
-	time_maxerror += time_tolerance >> SHIFT_USEC;
+	time_maxerror += MAXFREQ >> SHIFT_USEC;
 	if (time_maxerror > NTP_PHASE_LIMIT) {
 		time_maxerror = NTP_PHASE_LIMIT;
 		time_status |= STA_UNSYNC;
