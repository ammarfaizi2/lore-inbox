Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVGNV4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVGNV4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 17:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVGNV4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 17:56:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:4246 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261338AbVGNVyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:54:41 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       lkml <linux-kernel@vger.kernel.org>, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <Pine.LNX.4.58.0507141307060.19183@g5.osdl.org>
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
	 <1121360561.3967.55.camel@laptopd505.fenrus.org>
	 <1121370122.7673.161.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0507141307060.19183@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 14:54:35 -0700
Message-Id: <1121378075.7673.228.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 13:13 -0700, Linus Torvalds wrote:
> 
> On Thu, 14 Jul 2005, john stultz wrote:
> > 
> > We'll I'd probably put it as: "they do care about absolute time, but
> > they do not care about ticks or timer interrupt frequency"
> 
> Well, the thing is, you have to count time some sane way.
> 
> You can do it by having very expensive data structures that say "real
> time", but then you have some serious confusion when it comes to things
> like whether it's wallclock time (which might have shifts and other
> interesting issues) or some "virtual cpu time". You also end up having a
> much much more expensive interface, ie "time_after()" ends up being a much
> more complicated test.

I think you might be mis-characterizing Nish's and my idea. To me it
sounds very close to what you are suggesting w/ the HZ=2k idea.

> So the _sane_ way to do timeouts is to define an _arbitrary_ clock that is 
> just an integer counter. None of this "nanoseconds + full seconds" crap. 
> None of this stupid confusion with "real time". You select something that 
> is conceptually _clearly_ somethign else, and that will never get confused 
> when root sets the time backwards or anything like that.

But confusion is the problem we have now. 

People think in time, so they try to convert it into jiffies using HZ,
but then they're surprised when things happen early since the interrupt
freq isn't quite HZ but ACTHZ. Then if you fix that, you still have the
issue that if they use clock_gettime(CLOCK_MONOTONIC) to measure your
timer request it may still be early because jiffies aren't NTP adjusted.

We're not suggesting using timespecs for timers internally, just
do_monotonic_clock() which in Nish's patch returns 64 bits of
nanoseconds since the system booted and doesn't go backwards.

> In other words, you select the thing we call "jiffies".

In Nish's patch, do_monotonic_clock() is used in almost exactly the same
way as jiffies is used. 

Imagine HZ is a billion we have perfect timer hardware (which increments
jiffies exactly each nanosecond)and replace jiffies w/
do_monotonic_clock(). 

That's effectively what you get only without having the timer interrupt
go off a billion times a second. Instead, the timer interrupt can go off
at whatever frequency and soft-timers don't have to care. All interrupt
frequency changes is worse case latency.
 

> Face it, it is just _superior_ to the alternatives. The alternative is to
> have some "fake time" aka "struct timespec", and always have to worry
> about normalization and complicated comparisons, and using more memory 
> too, btw.
>
> There is no way to avoid having some kind of counter to specify time.  
> NONE. The only choice is what you base your notion of time on, and how you
> represent it. Do you represent it as two separate counters and try to make
> it look like "fractions of seconds", or do you represent it as a single
> counter, and make it look like "ticks".

I agree we have to keep time somehow, but we already do and we already
keep nanosecond precision. So why don't we just use it instead of some
low-res interrupt counter?

> And the single counter is _simpler_. The alternatives have absolutely 
> _zero_ upsides. Name _one_. 

In my mind, consistency. 

I mean, if I understand your suggestion w/ HZ=2k. Effectively you are
just redefining jiffies to be some fixed unit (effectively 500
microseconds). Then when timer interrupt arrive at some frequency lower
then 2kHZ you have to add more then 500usecs to jiffies. Right?

This is what we already do for timekeeping. The only difference is that
timekeeping deals with the HZ/ACTHZ issue and NTP adjustments and we
keep nanosecond precision.

thanks
-john

