Return-Path: <linux-kernel-owner+w=401wt.eu-S932904AbWLTBgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904AbWLTBgP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932918AbWLTBgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:36:15 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39294 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932904AbWLTBgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:36:14 -0500
Subject: Re: [RFC] HZ free ntp
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612132125450.1867@scrub.home>
References: <20061204204024.2401148d.akpm@osdl.org>
	 <Pine.LNX.4.64.0612060348150.1868@scrub.home>
	 <20061205203013.7073cb38.akpm@osdl.org>
	 <1165393929.24604.222.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612061334230.1867@scrub.home>
	 <20061206131155.GA8558@elte.hu>
	 <Pine.LNX.4.64.0612061422190.1867@scrub.home>
	 <1165956021.20229.10.camel@localhost>
	 <Pine.LNX.4.64.0612131338420.1867@scrub.home>
	 <1166037549.6425.21.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612132125450.1867@scrub.home>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 17:32:36 -0800
Message-Id: <1166578357.5594.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 21:40 +0100, Roman Zippel wrote:
> On Wed, 13 Dec 2006, john stultz wrote:
> > > You cannot choose arbitrary intervals otherwise you get other problems,
> > > e.g. with your patch time_offset handling is broken.
> >
> > I'm not seeing this yet. Any more details?
> 
> time_offset is scaled to HZ in do_adjtimex, which needs to be changed as
> well.

Ah, thanks! Fixed.

> > > You don't have to introduce anything new, it's tick_length that changes
> > > and HZ that becomes a variable in this function.
> >
> > So, forgive me for rehashing this, but it seems we're cross talking
> > again. The context here is the dynticks code. Where HZ doesn't change,
> > but we get interrupts at much reduced rates.
> 
> I know and all you have to change in the ntp and some related code is to
> replace HZ there with a variable, thus make it changable, so you can
> increase the update interval (i.e. it becomes 1s/hz instead of 1s/HZ).

Untested patch below. Does this vibe better with you are suggesting?

Any other suggestions or feedback?

thanks
-john


diff --git a/include/linux/timex.h b/include/linux/timex.h
index db501dc..8241e6e 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -286,6 +286,9 @@ #endif /* !CONFIG_TIME_INTERPOLATION */
 
 #define TICK_LENGTH_SHIFT	32
 
+#define NTP_INTERVAL_FREQ  (HZ)
+#define NTP_INTERVAL_LENGTH (NSEC_PER_SEC/NTP_INTERVAL_FREQ)
+
 /* Returns how long ticks are at present, in ns / 2^(SHIFT_SCALE-10). */
 extern u64 current_tick_length(void);
 
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 3afeaa3..eb12509 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -24,7 +24,7 @@ static u64 tick_length, tick_length_base
 
 #define MAX_TICKADJ		500		/* microsecs */
 #define MAX_TICKADJ_SCALED	(((u64)(MAX_TICKADJ * NSEC_PER_USEC) << \
-				  TICK_LENGTH_SHIFT) / HZ)
+				  TICK_LENGTH_SHIFT) / NTP_INTERVAL_FREQ)
 
 /*
  * phase-lock loop variables
@@ -46,13 +46,17 @@ #define CLOCK_TICK_ADJUST	(((s64)CLOCK_T
 
 static void ntp_update_frequency(void)
 {
-	tick_length_base = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << TICK_LENGTH_SHIFT;
-	tick_length_base += (s64)CLOCK_TICK_ADJUST << TICK_LENGTH_SHIFT;
-	tick_length_base += (s64)time_freq << (TICK_LENGTH_SHIFT - SHIFT_NSEC);
+	u64 second_length = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ)
+				<< TICK_LENGTH_SHIFT;
+	second_length += (s64)CLOCK_TICK_ADJUST << TICK_LENGTH_SHIFT;
+	second_length += (s64)time_freq << (TICK_LENGTH_SHIFT - SHIFT_NSEC);
 
-	do_div(tick_length_base, HZ);
+	tick_length_base = second_length;
 
-	tick_nsec = tick_length_base >> TICK_LENGTH_SHIFT;
+	do_div(second_length, HZ);
+	tick_nsec = second_length >> TICK_LENGTH_SHIFT;
+
+	do_div(tick_length_base, NTP_INTERVAL_FREQ);
 }
 
 /**
@@ -162,7 +166,7 @@ void second_overflow(void)
 			tick_length -= MAX_TICKADJ_SCALED;
 		} else {
 			tick_length += (s64)(time_adjust * NSEC_PER_USEC /
-					     HZ) << TICK_LENGTH_SHIFT;
+					NTP_INTERVAL_FREQ) << TICK_LENGTH_SHIFT;
 			time_adjust = 0;
 		}
 	}
@@ -239,7 +243,8 @@ #endif
 		    result = -EINVAL;
 		    goto leave;
 		}
-		time_freq = ((s64)txc->freq * NSEC_PER_USEC) >> (SHIFT_USEC - SHIFT_NSEC);
+		time_freq = ((s64)txc->freq * NSEC_PER_USEC)
+				>> (SHIFT_USEC - SHIFT_NSEC);
 	    }
 
 	    if (txc->modes & ADJ_MAXERROR) {
@@ -309,7 +314,8 @@ #endif
 		    freq_adj += time_freq;
 		    freq_adj = min(freq_adj, (s64)MAXFREQ_NSEC);
 		    time_freq = max(freq_adj, (s64)-MAXFREQ_NSEC);
-		    time_offset = (time_offset / HZ) << SHIFT_UPDATE;
+		    time_offset = (time_offset / NTP_INTERVAL_FREQ)
+		    			<< SHIFT_UPDATE;
 		} /* STA_PLL */
 	    } /* txc->modes & ADJ_OFFSET */
 	    if (txc->modes & ADJ_TICK)
@@ -324,8 +330,10 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
 	    txc->offset	   = save_adjust;
 	else
-	    txc->offset    = shift_right(time_offset, SHIFT_UPDATE) * HZ / 1000;
-	txc->freq	   = (time_freq / NSEC_PER_USEC) << (SHIFT_USEC - SHIFT_NSEC);
+	    txc->offset    = shift_right(time_offset, SHIFT_UPDATE)
+	    			* NTP_INTERVAL_FREQ / 1000;
+	txc->freq	   = (time_freq / NSEC_PER_USEC)
+				<< (SHIFT_USEC - SHIFT_NSEC);
 	txc->maxerror	   = time_maxerror;
 	txc->esterror	   = time_esterror;
 	txc->status	   = time_status;
diff --git a/kernel/timer.c b/kernel/timer.c
index 0256ab4..616b7fd 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -890,7 +890,7 @@ void __init timekeeping_init(void)
 	ntp_clear();
 
 	clock = clocksource_get_next();
-	clocksource_calculate_interval(clock, tick_nsec);
+	clocksource_calculate_interval(clock, NTP_INTERVAL_LENGTH);
 	clock->cycle_last = clocksource_read(clock);
 
 	write_sequnlock_irqrestore(&xtime_lock, flags);
@@ -1092,7 +1092,7 @@ #endif
 	if (change_clocksource()) {
 		clock->error = 0;
 		clock->xtime_nsec = 0;
-		clocksource_calculate_interval(clock, tick_nsec);
+		clocksource_calculate_interval(clock, NTP_INTERVAL_LENGTH);
 	}
 }
 


