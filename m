Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbTJHS1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 14:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTJHS1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 14:27:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:40669 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261639AbTJHS1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 14:27:32 -0400
Date: Wed, 8 Oct 2003 11:25:10 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@digeo.com>, john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Time precision, adjtime(x) vs. gettimeofday
Message-Id: <20031008112510.06ae1ebd.shemminger@osdl.org>
In-Reply-To: <1065619951.25818.15.camel@gaston>
References: <1065619951.25818.15.camel@gaston>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Oct 2003 15:32:31 +0200
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Hi !
> 
> While fixing problems experienced by some scientific users who
> found out that gettimeofday() could sometimes run backward, I
> found a nasty issue I don't know if we can fix at all or if it's
> not worth bothering.
> 
> So the problem is with any arch (ppc, x86, ...) who uses a HW
> timer (like the CPU timebase on PPC) to provide better-than-jiffy
> precision in do_gettimeofday().
> 
> The problem is that the offset added to xtime value (typically
> the HW timer current value minus the HW timer value at the last
> timer interrupt scaled to usec) uses a scaling factor which has
> been calibrated once, and doesn't take into account the adjustements
> done to xtime increase by adjtime/adjtimex algorithm.
> 
> That means that if, for example, adjtimex was called with a factor
> that is trying to slow you down a bit, and you call gettimeofday
> right before the end of a jiffy period, you may calculate an offset
> based on the HW timer that is actually higher than what will be
> really added to xtime on the next interrupt.
> 
> So you can end-up returning non-monotonic values from gettimeofday().
> 
> I don't see a way to fix that that wouldn't bloat do_gettimeofday(),
> except if we can, at jiffy interrupt time, pre-calculate a scaling
> factor for the next jiffy and just apply it on the HW timer value
> on the next calls to do_gettimeofday(). But that option would need
> better understanding of the adjtime(x) algorithm that what I have
> at this point.
> 
> Storing the last value to make sure we don't return a value that is
> lower will defeat the read_lock/write_lock mecanism, forcing us to
> take the write_lock(), and thus screwing up scalability.

The following will prevent adjtime from causing time regression.
It delays starting the adjtime mechanism for one tick, and 
keeps gettimeofday inside the window.

Only fixes i386, but changes to other arch would be similar.

Running a simple clock test program and playing with adjtime demonstrates
that this fixes the problem (and 2.6.0-test6 is broken). 
But given the fragile nature of the timer code, it should go through some
more testing before inclusion.  Andrew could you put this in the next
-mm tree?

diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Wed Oct  8 11:20:55 2003
+++ b/arch/i386/kernel/time.c	Wed Oct  8 11:20:55 2003
@@ -102,6 +102,15 @@
 		lost = jiffies - wall_jiffies;
 		if (lost)
 			usec += lost * (1000000 / HZ);
+
+		/*
+		 * If time_adjust is negative then NTP is slowing the clock
+		 * so make sure not to go into next possible interval.
+		 * Better to lose some accuracy than have time go backwards..
+		 */
+		if (unlikely(time_adjust < 0) && usec > tickadj)
+			usec = tickadj;
+
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
 	} while (read_seqretry(&xtime_lock, seq));
diff -Nru a/include/linux/timex.h b/include/linux/timex.h
--- a/include/linux/timex.h	Wed Oct  8 11:20:55 2003
+++ b/include/linux/timex.h	Wed Oct  8 11:20:55 2003
@@ -302,6 +302,7 @@
 extern long time_reftime;	/* time at last adjustment (s) */
 
 extern long time_adjust;	/* The amount of adjtime left */
+extern long time_next_adjust;	/* Value for time_adjust at next tick */
 
 /* interface variables pps->timer interrupt */
 extern long pps_offset;		/* pps time offset (us) */
diff -Nru a/kernel/time.c b/kernel/time.c
--- a/kernel/time.c	Wed Oct  8 11:20:55 2003
+++ b/kernel/time.c	Wed Oct  8 11:20:55 2003
@@ -233,7 +233,7 @@
 	result = time_state;	/* mostly `TIME_OK' */
 
 	/* Save for later - semantics of adjtime is to return old value */
-	save_adjust = time_adjust;
+	save_adjust = time_next_adjust ? time_next_adjust : time_adjust;
 
 #if 0	/* STA_CLOCKERR is never set yet */
 	time_status &= ~STA_CLOCKERR;		/* reset STA_CLOCKERR */
@@ -280,7 +280,8 @@
 	    if (txc->modes & ADJ_OFFSET) {	/* values checked earlier */
 		if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
 		    /* adjtime() is independent from ntp_adjtime() */
-		    time_adjust = txc->offset;
+		    if ((time_next_adjust = txc->offset) == 0)
+			 time_adjust = 0;
 		}
 		else if ( time_status & (STA_PLL | STA_PPSTIME) ) {
 		    ltemp = (time_status & (STA_PPSTIME | STA_PPSSIGNAL)) ==
diff -Nru a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	Wed Oct  8 11:20:55 2003
+++ b/kernel/timer.c	Wed Oct  8 11:20:55 2003
@@ -463,6 +463,7 @@
 long time_adj;				/* tick adjust (scaled 1 / HZ)	*/
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
+long time_next_adjust;
 
 /*
  * this routine handles the overflow of the microsecond field
@@ -643,6 +644,12 @@
 	}
 	xtime.tv_nsec += delta_nsec;
 	time_interpolator_update(delta_nsec);
+
+	/* Changes by adjtime() do not take effect till next tick. */
+	if (time_next_adjust != 0) {
+		time_adjust = time_next_adjust;
+		time_next_adjust = 0;
+	}
 }
 
 /*
