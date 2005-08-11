Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVHKBeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVHKBeE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 21:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVHKBeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 21:34:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:24280 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932167AbVHKBeD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 21:34:03 -0400
Subject: [RFC][PATCH - 10/13] NTP cleanup: Use ntp_lock instead of
	xtime_lock
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1123724003.32531.0.camel@cog.beaverton.ibm.com>
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
Content-Type: text/plain
Date: Wed, 10 Aug 2005 18:33:59 -0700
Message-Id: <1123724039.32531.2.camel@cog.beaverton.ibm.com>
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

linux-2.6.13-rc6_timeofday-ntp-part10_B5.patch
============================================
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -69,6 +69,8 @@ static int ntp_state    = TIME_OK;      
 long ntp_adjtime_offset;
 static long ntp_next_adjtime_offset;
 
+/* lock for the above variables */
+static seqlock_t ntp_lock = SEQLOCK_UNLOCKED;
 
 static long fixed_tick_ns_adj;
 
@@ -78,7 +80,9 @@ void ntp_advance(unsigned long interval_
 {
 	static unsigned long interval_sum = 0;
 	long time_adjust_step;
+	unsigned long flags;
 
+	write_seqlock_irqsave(&ntp_lock, flags);
 
 	/* Some components of the NTP state machine are advanced
 	 * in full second increments (this is a hold-over from
@@ -177,6 +181,8 @@ void ntp_advance(unsigned long interval_
 		ntp_adjtime_offset = ntp_next_adjtime_offset;
 		ntp_next_adjtime_offset = 0;
 	}
+
+	write_sequnlock_irqrestore(&ntp_lock, flags);
 }
 
 /**
@@ -184,13 +190,13 @@ void ntp_advance(unsigned long interval_
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
@@ -253,6 +259,7 @@ int ntp_adjtimex(struct timex *txc)
 {
 	long save_adjust;
 	int result;
+	unsigned long flags;
 
 	/* Now we validate the data before disabling interrupts */
 
@@ -295,7 +302,8 @@ int ntp_adjtimex(struct timex *txc)
 				||(txc->tick > 11000000/USER_HZ)))
 		return -EINVAL;
 
-	write_seqlock_irq(&xtime_lock);
+	write_seqlock_irqsave(&ntp_lock, flags);
+
 	result = ntp_state;       /* mostly `TIME_OK' */
 
 	/* Save for later - semantics of adjtime is to return old value */
@@ -324,7 +332,7 @@ int ntp_adjtimex(struct timex *txc)
 			/* adjtime() is independent from ntp_adjtime() */
 			if ((ntp_next_adjtime_offset = txc->offset) == 0)
 				ntp_adjtime_offset = 0;
-		} else if (ntp_hardupdate(txc->offset, xtime))
+		} else if (ntp_hardupdate(txc->offset, txc->time))
 			result = TIME_ERROR;
 	}
 
@@ -361,8 +369,8 @@ int ntp_adjtimex(struct timex *txc)
 	txc->errcnt = 0;
 	txc->stbcnt = 0;
 
-	write_sequnlock_irq(&xtime_lock);
-	do_gettimeofday(&txc->time);
+	write_sequnlock_irqrestore(&ntp_lock, flags);
+
 	return result;
 }
 
@@ -384,6 +392,8 @@ int ntp_leapsecond(struct timespec now)
 	 * set ahead one second.
 	 */
 	static time_t leaptime = 0;
+	unsigned long flags;
+	write_seqlock_irqsave(&ntp_lock, flags);
 
 	switch (ntp_state) {
 	case TIME_OK:
@@ -426,6 +436,7 @@ int ntp_leapsecond(struct timespec now)
 			ntp_state = TIME_OK;
 	}
 
+	write_sequnlock_irqrestore(&ntp_lock, flags);
 	return 0;
 }
 
@@ -433,14 +444,18 @@ int ntp_leapsecond(struct timespec now)
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


