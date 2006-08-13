Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWHMVAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWHMVAq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWHMVAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:00:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5390 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751472AbWHMVAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:00:38 -0400
Date: Sun, 13 Aug 2006 23:00:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: [-mm patch] kernel/time/ntp.c: possible cleanups
Message-ID: <20060813210037.GN3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global function static:
  - ntp_update_frequency()
- make the following needlessly global variables static:
  - time_state
  - time_offset
  - time_constant
  - time_reftime
- remove the following read-only global variable:
  - time_precision

Please review which of these changes do make sense and which do conflict 
with pending patches.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/timex.h |    6 ------
 kernel/time/ntp.c     |   39 +++++++++++++++++++--------------------
 2 files changed, 19 insertions(+), 26 deletions(-)

--- linux-2.6.18-rc4-mm1/include/linux/timex.h.old	2006-08-13 18:20:36.000000000 +0200
+++ linux-2.6.18-rc4-mm1/include/linux/timex.h	2006-08-13 18:23:24.000000000 +0200
@@ -197,21 +197,15 @@
 /*
  * phase-lock loop variables
  */
-extern int time_state;		/* clock status */
 extern int time_status;		/* clock synchronization status bits */
-extern long time_offset;	/* time adjustment (us) */
-extern long time_constant;	/* pll time constant */
-extern long time_precision;	/* clock precision (us) */
 extern long time_maxerror;	/* maximum error */
 extern long time_esterror;	/* estimated error */
 
 extern long time_freq;		/* frequency offset (scaled ppm) */
-extern long time_reftime;	/* time at last adjustment (s) */
 
 extern long time_adjust;	/* The amount of adjtime left */
 
 extern void ntp_clear(void);
-extern void ntp_update_frequency(void);
 
 /**
  * ntp_synced - Returns 1 if the NTP status is not UNSYNC
--- linux-2.6.18-rc4-mm1/kernel/time/ntp.c.old	2006-08-13 18:18:58.000000000 +0200
+++ linux-2.6.18-rc4-mm1/kernel/time/ntp.c	2006-08-13 18:23:33.000000000 +0200
@@ -30,17 +30,30 @@
  * phase-lock loop variables
  */
 /* TIME_ERROR prevents overwriting the CMOS clock */
-int time_state = TIME_OK;		/* clock synchronization status	*/
+static int time_state = TIME_OK;	/* clock synchronization status	*/
 int time_status = STA_UNSYNC;		/* clock status bits		*/
-long time_offset;			/* time adjustment (ns)		*/
-long time_constant = 2;			/* pll time constant		*/
-long time_precision = 1;		/* clock precision (us)		*/
+static long time_offset;		/* time adjustment (ns)		*/
+static long time_constant = 2;		/* pll time constant		*/
 long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
 long time_freq;				/* frequency offset (scaled ppm)*/
-long time_reftime;			/* time at last adjustment (s)	*/
+static long time_reftime;		/* time at last adjustment (s)	*/
 long time_adjust;
 
+#define CLOCK_TICK_OVERFLOW	(LATCH * HZ - CLOCK_TICK_RATE)
+#define CLOCK_TICK_ADJUST	(((s64)CLOCK_TICK_OVERFLOW * NSEC_PER_SEC) / CLOCK_TICK_RATE)
+
+static void ntp_update_frequency(void)
+{
+	tick_length_base = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << TICK_LENGTH_SHIFT;
+	tick_length_base += (s64)CLOCK_TICK_ADJUST << TICK_LENGTH_SHIFT;
+	tick_length_base += (s64)time_freq << (TICK_LENGTH_SHIFT - SHIFT_NSEC);
+
+	do_div(tick_length_base, HZ);
+
+	tick_nsec = tick_length_base >> TICK_LENGTH_SHIFT;
+}
+
 /**
  * ntp_clear - Clears the NTP state variables
  *
@@ -59,20 +72,6 @@
 	time_offset = 0;
 }
 
-#define CLOCK_TICK_OVERFLOW	(LATCH * HZ - CLOCK_TICK_RATE)
-#define CLOCK_TICK_ADJUST	(((s64)CLOCK_TICK_OVERFLOW * NSEC_PER_SEC) / CLOCK_TICK_RATE)
-
-void ntp_update_frequency(void)
-{
-	tick_length_base = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << TICK_LENGTH_SHIFT;
-	tick_length_base += (s64)CLOCK_TICK_ADJUST << TICK_LENGTH_SHIFT;
-	tick_length_base += (s64)time_freq << (TICK_LENGTH_SHIFT - SHIFT_NSEC);
-
-	do_div(tick_length_base, HZ);
-
-	tick_nsec = tick_length_base >> TICK_LENGTH_SHIFT;
-}
-
 /*
  * this routine handles the overflow of the microsecond field
  *
@@ -330,7 +329,7 @@
 	txc->esterror	   = time_esterror;
 	txc->status	   = time_status;
 	txc->constant	   = time_constant;
-	txc->precision	   = time_precision;
+	txc->precision	   = 1;
 	txc->tolerance	   = MAXFREQ;
 	txc->tick	   = tick_usec;
 

