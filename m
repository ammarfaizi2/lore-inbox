Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135575AbRDXMtR>; Tue, 24 Apr 2001 08:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135576AbRDXMtJ>; Tue, 24 Apr 2001 08:49:09 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:2574 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S135575AbRDXMtB>; Tue, 24 Apr 2001 08:49:01 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Tue, 24 Apr 2001 14:48:39 +0200
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-28924
Subject: patch-proposal: extended adjtime()
Message-ID: <3AE59246.11659.172798A@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Message-Boundary-28924
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

Hello,

someone found out that in Linux adjtime()'s correction is limited to 
something like 2000s (signed 32bit microseconds for i386). This is not 
a true problem, but for those who desperately need/want it, I have a 
patch proposal (incomplete, but essential) to implement the full range 
(maybe even more). The patch tries to keep binary compatibility, too.

Opinions?

Regards,
Ulrich



--Message-Boundary-28924
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'newadjtime.diff'

--- kernel/243time.c	Mon Apr 16 20:14:27 2001
+++ kernel/xxxtime.c	Mon Apr 16 20:41:15 2001
@@ -100,7 +100,8 @@
 	write_lock_irq(&xtime_lock);
 	xtime.tv_sec = value;
 	xtime.tv_usec = 0;
-	time_adjust = 0;	/* stop active adjtime() */
+	time_adjust.tv_sec = time_adjust.tv_usec = 0;
+	/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
@@ -225,7 +226,8 @@
  */
 int do_adjtimex(struct timex *txc)
 {
-        long ltemp, mtemp, save_adjust;
+        long ltemp, mtemp;
+	struct timeval save_adjust;
 	int result;
 
 	/* In order to modify anything, you gotta be super-user! */
@@ -295,7 +297,31 @@
 	    if (txc->modes & ADJ_OFFSET) {	/* values checked earlier */
 		if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
 		    /* adjtime() is independent from ntp_adjtime() */
-		    time_adjust = txc->offset;
+
+		    /* Try to extend the range for plain old adjtime()
+		     * to multiple seconds without breaking binary
+		     * compatibility. A perfect solution is not
+		     * possible, but this one has a high probability
+		     * for success. The true solution is a syscall of
+		     * its own.
+		     * The offset for ADJ_OFFSET_SINGLESHOT is stored in
+		     * txc->time (struct timeval) now. To avoid using
+		     * garbage vaues, it's required to copy
+		     * `txc->time.tv_usec' also into `txc->offset'. Just
+		     * to be sure, we also require the magic word
+		     * EXTENDED_ADJTIME_MAGIC to be written to `txc->status'
+		     * (it's a value not possible before, and it's
+		     * overwritten after each call).
+		     */
+#define EXTENDED_ADJTIME_MAGIC	(0x0000ffff + ('U' << 24) + ('W' << 16))
+		    /* old compatible interface */
+		    time_adjust.tv_usec = txc->offset;
+
+		    if (txc->offset == txc->time.tv_usec &&
+			txc->status == EXTENDED_ADJTIME_MAGIC) {
+			/* extended part */
+			time_adjust.tv_sec = txc->time.tv_sec;
+		    }
 		}
 		else if ( time_status & (STA_PLL | STA_PPSTIME) ) {
 		    ltemp = (time_status & (STA_PPSTIME | STA_PPSSIGNAL)) ==
@@ -375,9 +401,11 @@
 	    /* p. 24, (d) */
 		result = TIME_ERROR;
 	
-	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
-	    txc->offset	   = save_adjust;
-	else {
+	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT) {
+	    txc->offset	   = save_adjust.tv_usec;
+	    if (txc->status == EXTENDED_ADJTIME_MAGIC)
+		txc->time = save_adjust;
+	} else {
 	    if (time_offset < 0)
 		txc->offset = -(-time_offset >> SHIFT_UPDATE);
 	    else
--- kernel/243timer.c	Mon Apr 16 20:34:29 2001
+++ kernel/xxxtimer.c	Mon Apr 16 21:01:29 2001
@@ -58,8 +58,7 @@
 long time_adj;				/* tick adjust (scaled 1 / HZ)	*/
 long time_reftime;			/* time at last adjustment (s)	*/
 
-long time_adjust;
-long time_adjust_step;
+struct timeval time_adjust;		/* remaining time adjustment */
 
 unsigned long event;
 
@@ -461,8 +460,26 @@
 /* in the NTP reference this is called "hardclock()" */
 static void update_wall_time_one_tick(void)
 {
-	if ( (time_adjust_step = time_adjust) != 0 ) {
-	    /* We are doing an adjtime thing. 
+	long time_adjust_step;
+
+	if ((time_adjust.tv_sec | time_adjust.tv_usec) != 0) {
+	    time_adjust_step = time_adjust.tv_usec;
+	    if (time_adjust_step > 0) {
+		/* if we run out of microseconds, but have more seconds,
+		 * borrow another second
+		 */
+		if (time_adjust_step < tickadj && time_adjust.tv_sec > 0) {
+		    time_adjust_step = time_adjust.tv_usec += 1000000;
+		    --time_adjust.tv_sec;
+		}
+	    } else {
+		if (time_adjust_step > -tickadj && time_adjust.tv_sec < 0) {
+		    time_adjust_step = time_adjust.tv_usec -= 1000000;
+		    ++time_adjust.tv_sec;
+		}
+	    }
+		    
+	    /* We gave to complete the adjtime() thing. 
 	     *
 	     * Prepare time_adjust_step to be within bounds.
 	     * Note that a positive time_adjust means we want the clock
@@ -471,15 +488,16 @@
 	     * Limit the amount of the step to be in the range
 	     * -tickadj .. +tickadj
 	     */
-	     if (time_adjust > tickadj)
+	     if (time_adjust_step > tickadj)
 		time_adjust_step = tickadj;
-	     else if (time_adjust < -tickadj)
+	     else if (time_adjust_step < -tickadj)
 		time_adjust_step = -tickadj;
 	     
-	    /* Reduce by this step the amount of time left  */
-	    time_adjust -= time_adjust_step;
+	    /* Reduce remaining correction by this step. Can't overflow */
+	    time_adjust.tv_usec -= time_adjust_step;
+	    xtime.tv_usec += time_adjust_step;
 	}
-	xtime.tv_usec += tick + time_adjust_step;
+	xtime.tv_usec += tick;
 	/*
 	 * Advance the phase, once it gets to one microsecond, then
 	 * advance the tick more.

--Message-Boundary-28924--
