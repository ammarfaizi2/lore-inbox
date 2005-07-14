Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVGNTTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVGNTTl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVGNTTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:19:34 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:40165 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263081AbVGNTS6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:18:58 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <dvhltc@us.ibm.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       lkml <linux-kernel@vger.kernel.org>, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	 <20050714005106.GA16085@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
	 <1121304825.4435.126.camel@mindpipe>
	 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
	 <1121326938.3967.12.camel@laptopd505.fenrus.org>
	 <20050714121340.GA1072@ucw.cz>
	 <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 12:18:41 -0700
Message-Id: <1121368721.7673.151.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 09:37 -0700, Linus Torvalds wrote:
> 
> On Thu, 14 Jul 2005, Vojtech Pavlik wrote:
> >  
> > A note on the relaive timer API: There needs to be a way to say
> > "x milliseconds from the time this timer should have triggered" instead
> > of "x milliseconds from now", to avoid skew in timers that try to be
> > strictly periodic.
> 
> I disagree.
> 
> There should be an _absolute_ interface, and a driver that wants that 
> should just have calculated when in time the timeout finishes - and then 
> keep on using the absolute value.
> 
> Btw, this is exactly why the jiffy-based thing is _good_. The kernel 
> timers _are_ absolute, and you make them relative by adding "jiffies".
> 
> The fact is, the current timers are better than people give them credit 
> for, and converting them away from a jiffies-based interface (to a 
> usleep-like one) is STUPID.

Yes, I strongly agree that absolute references are required in order to
avoid the accumulating time error that can happen when folks use
relative interfaces alone. 

That said, I still think there is a benefit to moving away from jiffies
and using absolute time units. Now keep your badder in control for just
a second, let me try to explain myself :)

> There's absolutely nothing wrong with "jiffies", and anybody who thinks 
> that
> 
> 	msleep(20);
> 
> is fundamentally better than
> 
> 	timeout = jiffies + HZ/50;
> 
> just doesn't realize that the latter is a bit more complicated exactly 
> because the latter is a hell of a lot more POWERFUL. Trying to get rid of 
> jiffies for some religious reason is _stupid_.


Agreed, but we preserve the same correctness if we do something like:
	now_ns = do_monotonic_clock()
	timeout_ns = now_ns + 20000000;

And I'd argue we get something even more powerful. First, we have
something that is more easily understandable because we're working with
units people do not have to convert. Secondly we have a fixed point in
TIME rather then ticks, which allows us to avoid all the issues caused
by lost timer interrupts and the fact that (jiffies * HZ) != (xtime +
wall_to_monotonic).

Again, I agree that that it is necessary to keep absolute units similar
to what you posted about setting HZ to 2000 and just varying the
interrupt frequency as needed. Only rather then keeping some ticks as
our absolute unit, why not nanoseconds? Then we can make changes to the
interrupt frequency without affecting our absolute references.

Nish has some code, which I hope he'll be sending out shortly that does
just this, converting the soft-timer subsystem to use absolute time
instead of ticks for expiration. I feel it both simplifies the code and
makes it easier to changing the timer interrupt frequency while the
system is running.

We'll also be talking more about it at OLS, where apparently I may have
to hide behind plastic sheeting. :)

thanks
-john

