Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVHQA2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVHQA2p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVHQA2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:28:45 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:13697 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750777AbVHQA2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:28:44 -0400
Date: Wed, 17 Aug 2005 02:28:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <1124151001.8630.87.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0508162337130.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com> 
 <1123726394.32531.33.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508152115480.3728@scrub.home>
 <1124151001.8630.87.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 15 Aug 2005, john stultz wrote:

> > Please provide the right abstractions, e.g. leave the gettimeofday 
> > implementation to the timesource and use some helper (template) functions 
> > to do the actual work. Basically as long as you have a cycle_t in the 
> > common code something is really wrong, this code belongs in the continous 
> > clock template.
> 
> I'm not sure I agree. By pushing all the gettimeofday logic behind the
> timesource or clock class you describe above, you end up with lots of
> duplicated and error prone code.

That's there template code comes in, so that the drivers need only to add 
little code themselves. The point is that every time source has different 
requirements and if we want efficient implementations, too much common 
code doesn't really help. It's a tradeoff.

Let's look at the example patch below. I played a little with some code 
and this just demonstrates an accurate conversion of the tick/freq values 
into the internal values in ns resolution. It does a little more work 
ahead, but the interrupt code becomes simpler and most important it 
doesn't require any expensive 64bit math and you can't get it much more 
accurate than that. The current gettimeofday code for tick based sources 
is really cheap and I'd like to keep that (i.e. free of 64bit math). The 
accuracy can and should be fixed (the change to timespec wasn't really a 
major improvement, as it introduced new rounding errors).

The other thing the example demonstrates is the interface from NTP to 
timer code. The NTP code provides the basic parameters and then leaves it 
to the clock implementation how they apply. The adjustment and phase 
variables are really private variables. In the code below it's rather 
easily possible to make HZ another parameter and you can have clocks 
running at different frequencies (e.g. to implement dynamic ticks). A low 
frequency timer provides the wall clock and a separate timer takes care of 
the kernel timer.

The code below needs of course a little more work, currently I use it to 
collect some data on how the current code behaves. I'll add the adjustment 
code and then I'll see how it compares to it.

> > This also allows better implementations, e.g. gettimeofday can be done in 
> > a single step instead of two using a single lock instead of two.
> 
> This is a miss-characterization. In most cases the continuous
> gettimeofday is done in a single step with a single lock. Although it
> does have the flexibility to allow for more complex setups, as well as
> the ability to opt out and use the existing tick based code. 

You have it the wrong way around. In the general case you need two locks 
and only in some cases can you optimize one away. To evaluate the 
complexity of the design you really have to look at the general case for 
each component. You're rather focused on just the best cases.

bye, Roman

---

 kernel/time.c  |    3 ++-
 kernel/timer.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/time.c
===================================================================
--- linux-2.6.orig/kernel/time.c	2005-07-13 03:18:04.000000000 +0200
+++ linux-2.6/kernel/time.c	2005-08-16 01:37:20.000000000 +0200
@@ -366,8 +366,9 @@ int do_adjtimex(struct timex *txc)
 	    } /* txc->modes & ADJ_OFFSET */
 	    if (txc->modes & ADJ_TICK) {
 		tick_usec = txc->tick;
-		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
 	    }
+	    if (txc->modes & (ADJ_FREQUENCY|ADJ_OFFSET|ADJ_TICK))
+		    time_recalc();
 	} /* txc->modes */
 leave:	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0
 	    || ((time_status & (STA_PPSFREQ|STA_PPSTIME)) != 0
Index: linux-2.6/kernel/timer.c
===================================================================
--- linux-2.6.orig/kernel/timer.c	2005-07-13 03:18:04.000000000 +0200
+++ linux-2.6/kernel/timer.c	2005-08-16 23:10:53.000000000 +0200
@@ -559,6 +559,7 @@ found:
  */
 unsigned long tick_usec = TICK_USEC; 		/* USER_HZ period (usec) */
 unsigned long tick_nsec = TICK_NSEC;		/* ACTHZ period (nsec) */
+unsigned long tick_nsec2 = TICK_NSEC;
 
 /* 
  * The current time 
@@ -569,6 +570,7 @@ unsigned long tick_nsec = TICK_NSEC;		/*
  * the usual normalization.
  */
 struct timespec xtime __attribute__ ((aligned (16)));
+struct timespec xtime2 __attribute__ ((aligned (16)));
 struct timespec wall_to_monotonic __attribute__ ((aligned (16)));
 
 EXPORT_SYMBOL(xtime);
@@ -596,6 +598,33 @@ static long time_adj;			/* tick adjust (
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 long time_next_adjust;
+static long time_adj2, time_adj2_cur, time_freq_adj2, time_freq_phase2, time_phase2;
+
+void time_recalc(void)
+{
+	long f, t;
+	tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
+
+	t = time_freq >> (SHIFT_USEC + 8);
+	if (t) {
+		time_freq -= t << (SHIFT_USEC + 8);
+		t *= 1000 << 8;
+	}
+	f = time_freq * 125;
+	t += tick_usec * USER_HZ * 1000 + (f >> (SHIFT_USEC - 3));
+	f &= (1 << (SHIFT_USEC - 3)) - 1;
+	tick_nsec2 = t / HZ;
+	f += (t % HZ) << (SHIFT_USEC - 3);
+	f <<= 5;
+	time_adj2 = f / HZ;
+	time_freq_adj2 = f % HZ;
+
+	printk("tr: %ld.%09ld(%ld,%ld,%ld,%ld) - %ld.%09ld(%ld,%ld,%ld)\n",
+		xtime.tv_sec, xtime.tv_sec,
+		tick_nsec, time_freq, time_offset, time_next_adjust,
+		xtime2.tv_sec, xtime2.tv_nsec,
+		tick_nsec2, time_adj2, time_freq_adj2);
+}
 
 /*
  * this routine handles the overflow of the microsecond field
@@ -739,6 +768,16 @@ static void second_overflow(void)
 #endif
 }
 
+static void second_overflow2(void)
+{
+	time_adj2_cur = time_adj2;
+	time_freq_phase2 += time_freq_adj2;
+	if (time_freq_phase2 > HZ) {
+		time_freq_phase2 -= HZ;
+		time_adj2_cur++;
+	}
+}
+
 /* in the NTP reference this is called "hardclock()" */
 static void update_wall_time_one_tick(void)
 {
@@ -786,6 +825,20 @@ static void update_wall_time_one_tick(vo
 		time_adjust = time_next_adjust;
 		time_next_adjust = 0;
 	}
+
+	delta_nsec = tick_nsec2;
+	time_phase2 += time_adj2_cur;
+	if (time_phase2 >= (1 << (SHIFT_USEC + 2))) {
+		long ltemp = time_phase2 >> (SHIFT_USEC + 2);
+		time_phase2 -= ltemp << (SHIFT_USEC + 2);
+		delta_nsec += ltemp;
+	}
+	xtime2.tv_nsec += delta_nsec;
+	if (xtime2.tv_nsec >= NSEC_PER_SEC) {
+		xtime2.tv_nsec -= NSEC_PER_SEC;
+		xtime2.tv_sec++;
+		second_overflow2();
+	}
 }
 
 /*
