Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVGPDKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVGPDKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVGPDHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:07:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:37556 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262102AbVGPDGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 23:06:50 -0400
Subject: [RFC][PATCH - 10/12] NTP cleanup: Use ntp_lock instead of
	xtime_lock
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1121483160.28638.4.camel@cog.beaverton.ibm.com>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <1121482620.25236.31.camel@cog.beaverton.ibm.com>
	 <1121482672.25236.33.camel@cog.beaverton.ibm.com>
	 <1121482713.25236.35.camel@cog.beaverton.ibm.com>
	 <1121482758.25236.37.camel@cog.beaverton.ibm.com>
	 <1121482804.25236.39.camel@cog.beaverton.ibm.com>
	 <1121482925.25236.42.camel@cog.beaverton.ibm.com>
	 <1121483064.28638.0.camel@cog.beaverton.ibm.com>
	 <1121483101.28638.2.camel@cog.beaverton.ibm.com>
	 <1121483160.28638.4.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 20:06:42 -0700
Message-Id: <1121483202.28638.6.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch introduces the ntp_lock which replaces the xtime_lock for
serialization in the NTP subsystem. This further isolates the NTP
subsystem from the time subsystem.

Any comments or feedback would be greatly appreciated.

thanks
-john

linux-2.6.13-rc3_timeofday-ntp-part10_B4.patch
============================================
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -69,6 +69,8 @@ static int ntp_state    = TIME_OK;      
 long ntp_adjtime_offset;
 static long ntp_next_adjtime_offset;
 
+/* lock for the above variables */
+static seqlock_t ntp_lock = SEQLOCK_UNLOCKED;
 
 #define SEC_PER_DAY 86400
 
@@ -79,7 +81,9 @@ int ntp_advance(unsigned long interval_n
 {
 	static unsigned long interval_sum = 0;
 	long time_adjust_step, delta_nsec;
+	unsigned long flags;
 
+	write_seqlock_irqsave(&ntp_lock, flags);
 
 	/* Some components of the NTP state machine are advanced
 	 * in full second increments (this is a hold-over from
@@ -178,6 +182,7 @@ int ntp_advance(unsigned long interval_n
 		ntp_adjtime_offset = ntp_next_adjtime_offset;
 		ntp_next_adjtime_offset = 0;
 	}
+	write_sequnlock_irqrestore(&ntp_lock, flags);
 
 	return delta_nsec;
 }
@@ -187,13 +192,13 @@ int ntp_advance(unsigned long interval_n
  * offset: current offset
  * tv: timeval holding the current time
  *
- * Private function, called only by ntp_adjtimex
+ * Private function, called only by ntp_adjtimex while holding ntp_lock
  *
  * This function is called when an offset adjustment is requested.
  * It calculates the offset adjustment and manipulates the
  * frequency adjustement accordingly.
  */
-static int ntp_hardupdate(long offset, struct timespec tv)
+static int ntp_hardupdate(long offset, struct timeval tv)
 {
 	int ret;
 	long current_offset, interval;
@@ -256,6 +261,7 @@ int ntp_adjtimex(struct timex *txc)
 {
 	long save_adjust;
 	int result;
+	unsigned long flags;
 
 	/* Now we validate the data before disabling interrupts */
 
@@ -298,7 +304,8 @@ int ntp_adjtimex(struct timex *txc)
 				||(txc->tick > 11000000/USER_HZ)))
 		return -EINVAL;
 
-	write_seqlock_irq(&xtime_lock);
+	write_seqlock_irqsave(&ntp_lock, flags);
+
 	result = ntp_state;       /* mostly `TIME_OK' */
 
 	/* Save for later - semantics of adjtime is to return old value */
@@ -327,7 +334,7 @@ int ntp_adjtimex(struct timex *txc)
 			/* adjtime() is independent from ntp_adjtime() */
 			if ((ntp_next_adjtime_offset = txc->offset) == 0)
 				ntp_adjtime_offset = 0;
-		} else if (ntp_hardupdate(txc->offset, xtime))
+		} else if (ntp_hardupdate(txc->offset, txc->time))
 			result = TIME_ERROR;
 	}
 
@@ -364,8 +371,8 @@ int ntp_adjtimex(struct timex *txc)
 	txc->errcnt = 0;
 	txc->stbcnt = 0;
 
-	write_sequnlock_irq(&xtime_lock);
-	do_gettimeofday(&txc->time);
+	write_sequnlock_irqrestore(&ntp_lock, flags);
+
 	return result;
 }
 
@@ -387,6 +394,8 @@ int ntp_leapsecond(struct timespec now)
 	 * set ahead one second.
 	 */
 	static time_t leaptime = 0;
+	unsigned long flags;
+	write_seqlock_irqsave(&ntp_lock, flags);
 
 	switch (ntp_state) {
 	case TIME_OK:
@@ -429,6 +438,7 @@ int ntp_leapsecond(struct timespec now)
 			ntp_state = TIME_OK;
 	}
 
+	write_sequnlock_irqrestore(&ntp_lock, flags);
 	return 0;
 }
 
@@ -436,14 +446,18 @@ int ntp_leapsecond(struct timespec now)
 /**
  * ntp_clear - Clears the NTP state machine.
  *
- * Must be called while holding a write on the xtime_lock
  */
 void ntp_clear(void)
 {
+	unsigned long flags;
+	write_seqlock_irqsave(&ntp_lock, flags);
+
 	ntp_next_adjtime_offset = 0;		/* stop active adjtime() */
 	ntp_status |= STA_UNSYNC;
 	ntp_maxerror = NTP_PHASE_LIMIT;
 	ntp_esterror = NTP_PHASE_LIMIT;
+
+	write_sequnlock_irqrestore(&ntp_lock, flags);
 }
 
 /**
diff --git a/kernel/time.c b/kernel/time.c
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -222,6 +222,11 @@ int do_adjtimex(struct timex *txc)
 	if (txc->modes && !capable(CAP_SYS_TIME))
 		return -EPERM;
 		
+	/* Note: We set tx->time first,
+	 * because ntp_adjtimex uses it
+	 */
+	do_gettimeofday(&txc->time);
+
 	result = ntp_adjtimex(txc);
 	
 	notify_arch_cmos_timer();


