Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266246AbUGOREv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUGOREv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 13:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266247AbUGOREv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 13:04:51 -0400
Received: from [192.48.179.6] ([192.48.179.6]:8433 "EHLO omx1.americas.sgi.com")
	by vger.kernel.org with ESMTP id S266246AbUGOREp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 13:04:45 -0400
Date: Thu, 15 Jul 2004 10:03:28 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: davidm@hpl.hp.com, george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>, ia64 <linux-ia64@vger.kernel.org>
Subject: Re: gettimeofday nanoseconds patch (makes it possible for the
 posix-timer functions to return higher accuracy)
In-Reply-To: <1089908059.15272.29.camel@leatherman>
Message-ID: <Pine.LNX.4.58.0407150950030.21918@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0407140940260.14704@schroedinger.engr.sgi.com> 
 <1089835776.1388.216.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0407141323530.15874@schroedinger.engr.sgi.com> 
 <1089839740.1388.230.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0407141703360.17055@schroedinger.engr.sgi.com> 
 <1089852486.1388.256.camel@cog.beaverton.ibm.com>  <16629.56037.120532.779793@napali.hpl.hp.com>
  <Pine.LNX.4.58.0407150810290.21314@schroedinger.engr.sgi.com>
 <1089908059.15272.29.camel@leatherman>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2004, john stultz wrote:

> > The old code only insured that the interpolated offset in nanoseconds
> > after a timer tick never goes backward. Negative corrections to xtime
> > could also result in time going backward since the offset is
> > always added to xtime. Both the old and the new code use the logic in
> > time_interpolator_update (invoked when xtime is advanced) to compensate
> > for this situation.
>
> However it seems this compensation also negates NTPs adjustment. There
> is nothing that scales the time_interpolator_update's output.
>
> A quick example:
> So lets say tick length is 1000us. At time zero we call gettimeofday(),
> it returns xtime + time_interpolator_update(), both return zero. 999us
> later at time two, the same thing happens and we return (0 + 999). A
> usec later at time three, the timer interrupt is called and xtime is
> incremented 1000us, and time_interpolator decrements 1000us. Thus a call
> to gettimeofday would return (1000 + 0). Immediately following, adjtimex
> is called, setting the tick length to 900us. Then 999 usecs later at
> time four, we return (1000 + 999). The next usec at time five, the timer
> interrupt goes off and increments xtime by 900, and decrements the
> time_interpolator by 900. Thus a call to gettimeofday() would return
> (1900 + 100). So rather returning the proper NTP adjusted time of 1900,
> 2000 is being returned as if the NTP adjustment never occured.

The above omits some details but is basically correct. Note that the
time_interpolator gradually brings time back into sync with xtime because
it looses a few nanoseconds (depending on the clock) each tick. At
some point the correction asked for by the timer tick will be greater than the
offset and at that time the offset is set to zero. Then a resync has
occurred.

> Now, you cannot have time going backwards, so the solution is to cap the
> output of time_interpolator_update() by insuring that during an NTP
> adjusted tick, we do not return more then the NTP adjusted tick length
> added to the base offset we calculated at the last timer interrupt.

> Thus at time four above(and during the 99 usecs before it) we would
> return (1000 + 900) instead of (1000+999).

Having time stand still is an awkward solution: Time may stand
still even longer if the tick is delayed and then time suddenly jumps
ahead when the tick finally occurs.

The existing implementation slowly compensates and is the best solution
IMHO.

> And again, the ia64 code isn't my specialty, so if I'm just being daft,
> please let me know.

What I described was coded by others. I just hope that I have explained it
accurately.
