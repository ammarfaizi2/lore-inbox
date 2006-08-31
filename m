Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWHaOb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWHaOb2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 10:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWHaOb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 10:31:28 -0400
Received: from mo31.po.2iij.net ([210.128.50.54]:24097 "EHLO mo31.po.2iij.net")
	by vger.kernel.org with ESMTP id S932332AbWHaOb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 10:31:27 -0400
Date: Thu, 31 Aug 2006 23:31:08 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yoichi_yuasa@tripeaks.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [-mm PATCH] mips: moved to GENERIC_TIME
Message-Id: <20060831233108.5b5c9e66.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch has moved to GENERIC_TIME about MIPS and has removed MIPS specific do_gettimeofday()/do_settimeofday().
MIPS specific do_gettimeofday()/do_settimeofday() in 2.6.18-rc4-mm3 have undefined reference problem.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X linux-2.6.18-rc4-mm3/Documentation/dontdiff linux-2.6.18-rc4-mm3-orig/arch/mips/Kconfig linux-2.6.18-rc4-mm3/arch/mips/Kconfig
--- linux-2.6.18-rc4-mm3-orig/arch/mips/Kconfig	2006-08-30 23:52:24.491501500 +0900
+++ linux-2.6.18-rc4-mm3/arch/mips/Kconfig	2006-08-30 23:54:56.597007500 +0900
@@ -860,6 +860,10 @@ config SCHED_NO_NO_OMIT_FRAME_POINTER
 	bool
 	default y
 
+config GENERIC_TIME
+	bool
+	default y
+
 #
 # Select some configuration options automatically based on user selections.
 #
diff -pruN -X linux-2.6.18-rc4-mm3/Documentation/dontdiff linux-2.6.18-rc4-mm3-orig/arch/mips/kernel/time.c linux-2.6.18-rc4-mm3/arch/mips/kernel/time.c
--- linux-2.6.18-rc4-mm3-orig/arch/mips/kernel/time.c	2006-08-30 23:52:24.983532250 +0900
+++ linux-2.6.18-rc4-mm3/arch/mips/kernel/time.c	2006-08-31 00:09:32.646857000 +0900
@@ -149,80 +149,6 @@ void (*mips_timer_ack)(void);
 unsigned int (*mips_hpt_read)(void);
 void (*mips_hpt_init)(unsigned int);
 
-
-/*
- * This version of gettimeofday has microsecond resolution and better than
- * microsecond precision on fast machines with cycle counter.
- */
-void do_gettimeofday(struct timeval *tv)
-{
-	unsigned long seq;
-	unsigned long usec, sec;
-	unsigned long max_ntp_tick;
-
-	do {
-		seq = read_seqbegin(&xtime_lock);
-
-		usec = do_gettimeoffset();
-
-		/*
-		 * If time_adjust is negative then NTP is slowing the clock
-		 * so make sure not to go into next possible interval.
-		 * Better to lose some accuracy than have time go backwards..
-		 */
-		if (unlikely(time_adjust < 0)) {
-			max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
-			usec = min(usec, max_ntp_tick);
-		}
-
-		sec = xtime.tv_sec;
-		usec += (xtime.tv_nsec / 1000);
-
-	} while (read_seqretry(&xtime_lock, seq));
-
-	while (usec >= 1000000) {
-		usec -= 1000000;
-		sec++;
-	}
-
-	tv->tv_sec = sec;
-	tv->tv_usec = usec;
-}
-
-EXPORT_SYMBOL(do_gettimeofday);
-
-int do_settimeofday(struct timespec *tv)
-{
-	time_t wtm_sec, sec = tv->tv_sec;
-	long wtm_nsec, nsec = tv->tv_nsec;
-
-	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
-		return -EINVAL;
-
-	write_seqlock_irq(&xtime_lock);
-
-	/*
-	 * This is revolting.  We need to set "xtime" correctly.  However,
-	 * the value in this location is the value at the most recent update
-	 * of wall time.  Discover what correction gettimeofday() would have
-	 * made, and then undo it!
-	 */
-	nsec -= do_gettimeoffset() * NSEC_PER_USEC;
-
-	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
-	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
-
-	set_normalized_timespec(&xtime, sec, nsec);
-	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
-
-	ntp_clear();
-	write_sequnlock_irq(&xtime_lock);
-	clock_was_set();
-	return 0;
-}
-
-EXPORT_SYMBOL(do_settimeofday);
-
 /*
  * Gettimeoffset routines.  These routines returns the time duration
  * since last timer interrupt in usecs.
