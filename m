Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVAJN1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVAJN1F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVAJN1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:27:05 -0500
Received: from ozlabs.org ([203.10.76.45]:155 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262231AbVAJN0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:26:24 -0500
Date: Tue, 11 Jan 2005 00:24:29 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: xtime <-> gettimeofday can get out of sync
Message-ID: <20050110132429.GS14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ive noticed a problem where xtime and gettimeofday could get out of sync
if interrupts are disabled for too long (eg long kernel code paths or
dropping into the debugger for a while).

We correctly replay lost jiffies but in that loop time_sync_xtime syncs
the intermediate values of xtime up with the current value of
gettimeofday. So xtime jumps by a bunch and from then on it is ahead of
gettimeofday and we never resync the two. I guess this is to avoid xtime
going backwards.

The patch below creates a __do_gettimeofday where you can pass in a tb
value and sync the intermediate values of xtime properly.

Note that the time_sync_xtime check only stops the seconds from going
backwards, the ns component still could couldnt it? Considering this
is hard to get right, should we switch to the time interpolator stuff?
The only problem there is it might be trouble for systemcfg (which
exports stuff to do userspace gettimeofday).

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

===== arch/ppc64/kernel/time.c 1.44 vs edited =====
--- 1.44/arch/ppc64/kernel/time.c	2005-01-05 13:48:14 +11:00
+++ edited/arch/ppc64/kernel/time.c	2005-01-09 16:37:33 +11:00
@@ -142,16 +142,54 @@
         }
 }
 
+/*
+ * This version of gettimeofday has microsecond resolution.
+ */
+static inline void __do_gettimeofday(struct timeval *tv, unsigned long tb_val)
+{
+	unsigned long sec, usec, tb_ticks;
+	unsigned long xsec, tb_xsec;
+	struct gettimeofday_vars * temp_varp;
+	unsigned long temp_tb_to_xs, temp_stamp_xsec;
+
+	/*
+	 * These calculations are faster (gets rid of divides)
+	 * if done in units of 1/2^20 rather than microseconds.
+	 * The conversion to microseconds at the end is done
+	 * without a divide (and in fact, without a multiply)
+	 */
+	tb_ticks = tb_val - do_gtod.tb_orig_stamp;
+	temp_varp = do_gtod.varp;
+	temp_tb_to_xs = temp_varp->tb_to_xs;
+	temp_stamp_xsec = temp_varp->stamp_xsec;
+	tb_xsec = mulhdu( tb_ticks, temp_tb_to_xs );
+	xsec = temp_stamp_xsec + tb_xsec;
+	sec = xsec / XSEC_PER_SEC;
+	xsec -= sec * XSEC_PER_SEC;
+	usec = (xsec * USEC_PER_SEC)/XSEC_PER_SEC;
+
+	tv->tv_sec = sec;
+	tv->tv_usec = usec;
+}
+
+void do_gettimeofday(struct timeval *tv)
+{
+	__do_gettimeofday(tv, get_tb());
+}
+
+EXPORT_SYMBOL(do_gettimeofday);
+
 /* Synchronize xtime with do_gettimeofday */ 
 
-static __inline__ void timer_sync_xtime( unsigned long cur_tb )
+static inline void timer_sync_xtime(unsigned long cur_tb)
 {
 	struct timeval my_tv;
 
-	if ( cur_tb > next_xtime_sync_tb ) {
+	if (cur_tb > next_xtime_sync_tb) {
 		next_xtime_sync_tb = cur_tb + xtime_sync_interval;
-		do_gettimeofday( &my_tv );
-		if ( xtime.tv_sec <= my_tv.tv_sec ) {
+		__do_gettimeofday(&my_tv, cur_tb);
+
+		if (xtime.tv_sec <= my_tv.tv_sec) {
 			xtime.tv_sec = my_tv.tv_sec;
 			xtime.tv_nsec = my_tv.tv_usec * 1000;
 		}
@@ -274,7 +312,7 @@
 			write_seqlock(&xtime_lock);
 			tb_last_stamp = lpaca->next_jiffy_update_tb;
 			do_timer(regs);
-			timer_sync_xtime( cur_tb );
+			timer_sync_xtime(lpaca->next_jiffy_update_tb);
 			timer_check_rtc();
 			write_sequnlock(&xtime_lock);
 			if ( adjusting_time && (time_adjust == 0) )
@@ -312,36 +350,6 @@
 {
 	return mulhdu(get_tb(), tb_to_ns_scale) << tb_to_ns_shift;
 }
-
-/*
- * This version of gettimeofday has microsecond resolution.
- */
-void do_gettimeofday(struct timeval *tv)
-{
-        unsigned long sec, usec, tb_ticks;
-	unsigned long xsec, tb_xsec;
-	struct gettimeofday_vars * temp_varp;
-	unsigned long temp_tb_to_xs, temp_stamp_xsec;
-
-	/* These calculations are faster (gets rid of divides)
-	 * if done in units of 1/2^20 rather than microseconds.
-	 * The conversion to microseconds at the end is done
-	 * without a divide (and in fact, without a multiply) */
-	tb_ticks = get_tb() - do_gtod.tb_orig_stamp;
-	temp_varp = do_gtod.varp;
-	temp_tb_to_xs = temp_varp->tb_to_xs;
-	temp_stamp_xsec = temp_varp->stamp_xsec;
-	tb_xsec = mulhdu( tb_ticks, temp_tb_to_xs );
-	xsec = temp_stamp_xsec + tb_xsec;
-	sec = xsec / XSEC_PER_SEC;
-	xsec -= sec * XSEC_PER_SEC;
-	usec = (xsec * USEC_PER_SEC)/XSEC_PER_SEC;
-
-        tv->tv_sec = sec;
-        tv->tv_usec = usec;
-}
-
-EXPORT_SYMBOL(do_gettimeofday);
 
 int do_settimeofday(struct timespec *tv)
 {

