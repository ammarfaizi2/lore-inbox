Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWDCT5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWDCT5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 15:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWDCT5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 15:57:32 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:2793 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964867AbWDCT5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 15:57:31 -0400
Date: Mon, 3 Apr 2006 21:57:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] generic gettimeofday functions
Message-ID: <Pine.LNX.4.64.0604032157100.4718@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This provides generic functions for gettimeofday/settimeofday for archs,
which are ready to completely switch to clocksources.

 kernel/time.c  |    2 +
 kernel/timer.c |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

Index: linux-2.6-mm/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/kernel/time.c	2006-04-02 17:23:13.000000000 +0200
+++ linux-2.6-mm/kernel/time.c	2006-04-02 17:23:52.000000000 +0200
@@ -523,6 +523,7 @@ EXPORT_SYMBOL(do_gettimeofday);
 
 
 #else
+#ifndef CONFIG_GENERIC_TIME
 /*
  * Simulate gettimeofday using do_gettimeofday which only allows a timeval
  * and therefore only yields usec accuracy
@@ -537,6 +538,7 @@ void getnstimeofday(struct timespec *tv)
 }
 EXPORT_SYMBOL_GPL(getnstimeofday);
 #endif
+#endif
 
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2006-04-02 17:23:36.000000000 +0200
+++ linux-2.6-mm/kernel/timer.c	2006-04-02 17:23:52.000000000 +0200
@@ -1030,6 +1030,97 @@ void clocksource_update(struct pt_regs *
 	softlockup_tick();
 }
 
+#ifdef CONFIG_GENERIC_TIME
+
+/**
+ * get_realtime_clock_ts - Returns the time of day in a timespec
+ * @ts:		pointer to the timespec to be set
+ *
+ * Returns the time of day in a timespec.
+ */
+void getnstimeofday(struct timespec *ts)
+{
+	unsigned long seq, nsec;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		ts->tv_sec = xtime.tv_sec;
+		nsec = clocksource_get_nsec_offset(curr_clocksource);
+	} while (read_seqretry(&xtime_lock, seq));
+
+	while (nsec >= NSEC_PER_SEC) {
+		nsec -= NSEC_PER_SEC;
+		ts->tv_sec++;
+	}
+	ts->tv_nsec = nsec;
+}
+
+EXPORT_SYMBOL(getnstimeofday);
+/**
+ * do_gettimeofday - Returns the time of day in a timeval
+ * @tv:		pointer to the timeval to be set
+ *
+ * NOTE: Users should be converted to using get_realtime_clock_ts()
+ */
+void do_gettimeofday(struct timeval *tv)
+{
+	unsigned long seq, nsec;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		tv->tv_sec = xtime.tv_sec;
+		nsec = clocksource_get_nsec_offset(curr_clocksource);
+	} while (read_seqretry(&xtime_lock, seq));
+
+	while (nsec >= NSEC_PER_SEC) {
+		nsec -= NSEC_PER_SEC;
+		tv->tv_sec++;
+	}
+	tv->tv_usec = nsec / NSEC_PER_USEC;
+}
+
+EXPORT_SYMBOL(do_gettimeofday);
+
+/**
+ * do_settimeofday - Sets the time of day
+ * @tv:		pointer to the timespec variable containing the new time
+ *
+ * Sets the time of day to the new time and update NTP and notify hrtimers
+ */
+int do_settimeofday(struct timespec *ts)
+{
+	time_t wtm_sec;
+	long wtm_nsec;
+
+	if ((unsigned long)ts->tv_nsec >= NSEC_PER_SEC)
+		return -EINVAL;
+
+	write_seqlock_irq(&xtime_lock);
+
+	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - ts->tv_sec);
+	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - ts->tv_nsec);
+	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
+
+	xtime = *ts;
+
+	curr_clocksource->ntp_error = 0;
+	curr_clocksource->cycles_last = curr_clocksource->read();
+	curr_clocksource->xtime_nsec = (u64)xtime.tv_nsec << curr_clocksource->shift;
+
+	ntp_clear();
+
+	write_sequnlock_irq(&xtime_lock);
+
+	/* signal hrtimers about time change */
+	clock_was_set();
+
+	return 0;
+}
+
+EXPORT_SYMBOL(do_settimeofday);
+
+#endif
+
 #ifdef __ARCH_WANT_SYS_ALARM
 
 /*
