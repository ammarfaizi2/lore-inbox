Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVGLRuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVGLRuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVGLRuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:50:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:33690 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261781AbVGLRuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:50:32 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: john stultz <johnstul@us.ibm.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Con Kolivas <kernel@kolivas.org>,
       lkml <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>, Lee Revell <rlrevell@joe-job.com>,
       Diego Calleja <diegocg@gmail.com>, azarah@nosferatu.za.org,
       Andrew Morton <akpm@osdl.org>, cw@f00f.org, torvalds@osdl.org,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>
In-Reply-To: <18080000.1121181987@[10.10.2.4]>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <42D310ED.2000407@mvista.com> <20050712121008.GA7804@ucw.cz>
	 <200507122239.03559.kernel@kolivas.org> <20050712133018.GA8467@ucw.cz>
	 <18080000.1121181987@[10.10.2.4]>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 10:50:23 -0700
Message-Id: <1121190623.7673.77.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 08:26 -0700, Martin J. Bligh wrote:
> >> > The PIT crystal runs at 14.3181818 MHz (CGA dotclock, found on ISA, ...)
> >> > and is divided by 12 to get PIT tick rate
> >> > 
> >> > 	14.3181818 MHz / 12 = 1193182 Hz
> >> > 
> >> > The reality is that the crystal is usually off by 50-100 ppm from the
> >> > standard value, depending on temperature.
> >> > 
> >> >     HZ   ticks/jiffie  1 second      error (ppm)
> >> > ---------------------------------------------------
> >> >    100      11932      1.000015238      15.2
> >> >    200       5966      1.000015238      15.2
> >> >    250       4773      1.000057143      57.1
> >> >    300       3977      0.999931429     -68.6
> >> >    333       3583      0.999964114     -35.9
> >> >    500       2386      0.999847619    -152.4
> >> >   1000       1193      0.999847619    -152.4
> >> > 
> >> > Some HZ values indeed fit the tick frequency better than others, up to
> >> > 333 the error is lost in the physical error of the crystal, for 500 and
> >> > 1000, it definitely is larger, and thus noticeable.
> >> > 
> >> > Some (less round and nice) values of HZ would fit even better:
> >> > 
> >> >     HZ   ticks/jiffie  1 second      error (ppm)
> >> > ---------------------------------------------------
> >> >     82      14551      1.000000152       0.2
> >> 
> >> 
> >> Most interesting... Would 838 Hz be a much better choice than 1000 then? 
> >> (apart from the ugliness).
> > 
> > No, 838 isn't significantly better. 864 and 627 would be better
> > candidates:
> > 
> >     HZ   ticks/jiffie  1 second      error (ppm)
> > ---------------------------------------------------
> >    627       1903      0.999999314      -0.7
> >    838       1424      1.000109105     109.1
> >    864       1381      1.000001829       1.8
> > 
> > A good HZ value would make ntpd significantly happier, if the crystal is
> > of reasonable quality.
> > 
> > 152ppm (1000Hz) is 13 seconds a day,
> > 0.7 ppm (627Hz) is 22 seconds a year.
> 
> Does positive vs negative error make a difference to the timer subsystem?
> Nish was telling me they had to add 1 extra tick to timer inaccuracies
> because of the errors ... does changing the polarity of the error 
> affect that (seems like it would ... but I got lost by now ;-))?

It doesn't affect the soft-timer subsystem very much due to the
additional rounding described above, but it does affect anywhere jiffies
is used directly via HZ for time. Awhile back there were some issues we
had with proc output being confused in the transition via HZ, ACTHZ and
USER_HZ that were related.

This would probably be a good plug for Nish's time based (as opposed to
tick based) soft-timer work. By utilizing the timekeeping subsystem,
using absolute nanoseconds since boot instead of jiffies to expire soft-
timers we can avoid worrying about HZ/ACTHZ error in that subsystem.
Additionally it avoids any sort of accumulating error which could be
caused by lost ticks and allows for lower best-case latencies and
improved average latencies.

This helps pave the way for tickless/dynamic HZ systems by removing the
already broken assumption that ticks are regular and periodic.

Granted, the HZ/ACTHZ issue still exist, but the impact is more
isolated.

thanks
-john




 

