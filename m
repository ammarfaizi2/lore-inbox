Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUGOQVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUGOQVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 12:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUGOQVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 12:21:41 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9125 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264633AbUGOQVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 12:21:24 -0400
Subject: Re: gettimeofday nanoseconds patch (makes it possible for the
	posix-timer functions to return higher accuracy)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: davidm@hpl.hp.com, george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>, ia64 <linux-ia64@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0407150810290.21314@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0407140940260.14704@schroedinger.engr.sgi.com>
	 <1089835776.1388.216.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0407141323530.15874@schroedinger.engr.sgi.com>
	 <1089839740.1388.230.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0407141703360.17055@schroedinger.engr.sgi.com>
	 <1089852486.1388.256.camel@cog.beaverton.ibm.com>
	 <16629.56037.120532.779793@napali.hpl.hp.com>
	 <Pine.LNX.4.58.0407150810290.21314@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1089908059.15272.29.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 15 Jul 2004 09:14:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-15 at 08:31, Christoph Lameter wrote:
> On Wed, 14 Jul 2004, David Mosberger wrote:
> 
> > >>>>> On Wed, 14 Jul 2004 17:48:06 -0700, john stultz <johnstul@us.ibm.com> said:
> >
> >   John> Although you still have the issue w/ NTP adjustments being
> >   John> ignored, but last time I looked at the time_interpolator code,
> >   John> it seemed it was being ignored there too, so at least your not
> >   John> doing worse then the ia64 do_gettimeofday(). [If I'm doing the
> >   John> time_interpolator code a great injustice with the above,
> >   John> someone please correct me]
> >
> > The existing time-interpolator code for ia64 never lets time go
> > backwards (in the absence of a settimeofday(), of course).  There is
> > no need to special-case NTP.
> >
> > With Christoph's changes, NTP is an issue again, however.
> 
> The old code only insured that the interpolated offset in nanoseconds
> after a timer tick never goes backward. Negative corrections to xtime
> could also result in time going backward since the offset is
> always added to xtime. Both the old and the new code use the logic in
> time_interpolator_update (invoked when xtime is advanced) to compensate
> for this situation.

However it seems this compensation also negates NTPs adjustment. There
is nothing that scales the time_interpolator_update's output. 

A quick example:
So lets say tick length is 1000us. At time zero we call gettimeofday(),
it returns xtime + time_interpolator_update(), both return zero. 999us
later at time two, the same thing happens and we return (0 + 999). A
usec later at time three, the timer interrupt is called and xtime is
incremented 1000us, and time_interpolator decrements 1000us. Thus a call
to gettimeofday would return (1000 + 0). Immediately following, adjtimex
is called, setting the tick length to 900us. Then 999 usecs later at
time four, we return (1000 + 999). The next usec at time five, the timer
interrupt goes off and increments xtime by 900, and decrements the
time_interpolator by 900. Thus a call to gettimeofday() would return
(1900 + 100). So rather returning the proper NTP adjusted time of 1900,
2000 is being returned as if the NTP adjustment never occured. 

Now, you cannot have time going backwards, so the solution is to cap the
output of time_interpolator_update() by insuring that during an NTP
adjusted tick, we do not return more then the NTP adjusted tick length
added to the base offset we calculated at the last timer interrupt.

Thus at time four above(and during the 99 usecs before it) we would
return (1000 + 900) instead of (1000+999). 

And again, the ia64 code isn't my specialty, so if I'm just being daft,
please let me know. 

thanks
-john





