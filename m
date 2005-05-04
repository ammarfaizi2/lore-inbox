Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVEDRtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVEDRtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVEDRru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:47:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40947 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261251AbVEDRqS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:46:18 -0400
Message-ID: <42790A5C.4050403@mvista.com>
Date: Wed, 04 May 2005 10:46:04 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Liu Qi <liuqi@ict.ac.cn>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Help with the high res timers
References: <E1DSl7F-0002v2-Ck@sc8-sf-web4.sourceforge.net>	 <20050503024336.GA4023@ict.ac.cn>  <4277EEF7.8010609@mvista.com>	 <1115158804.13738.56.camel@cog.beaverton.ibm.com>	 <427805F8.7000309@mvista.com> <1115166592.13738.96.camel@cog.beaverton.ibm.com>
In-Reply-To: <1115166592.13738.96.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

~

>>The issue is not its length, but can we interrupt at its end.  The key to high 
>>res is being on time.  If we want a 100usec resolution timer, we need to have 
>>the low res timer hit its mark with something real close to this.
> 
> 
> Indeed. 
> 
> As an aside, one nice thing with Nish's code is that the maximum soft-
> timer latency is only the maximum interval between ticks. This avoids
> accumulating error caused by lost ticks. 

I think you are confusing the x86 problems with lost ticks with the wider world. 
  Most archs have reasonable time resources and, while they may suffer from late 
ticks, do not, therefor loose time.  In as much as you can find a way to 
eliminate time loss in the x86 due to lost ticks of the time base, you can also 
do so with the current time keeping system.  The current code is just to 
dependant on catching every timer tick.  It should use the other resources 
available to it to cover any missing ticks.  (We do this rather nicely in the 
HRT patch, by the way.)
> 
> 
> 
>>>Now when the new code expires timers it does so against the timeofday
>>>subsystem's notion of time instead of jiffies. It simply goes through
>>>all the timer bucket entries between now and the last time we expired
>>>timers.
>>
>>This is not unlike what happens now.  I would hope that the number of buckets 
>>visited averages to to something real close to 1 per run_timers entery.
> 
> 
> Well, as long as the HZ period is close to the timer-interval unit
> length, this is true. However if the timer-interval unit is smaller,
> multiple bucket entries would be expired. The performance considerations
> here are being looked at and this may be an area where the concepts in
> HRT might help (having a HRT specific sub-bucket).

This is where we get in trouble with HR timers.  For a HR timer, we need to know 
how to get a timer to expire (i.e. appear in the call back) at a well defined 
and presise time (leaving aside latency issues).  The above discription allows 
timers to be put in buckets without (as near as I can tell) making transparent 
exactly when the bucket will be emptied, only saying that it will be after the 
latest timer in the bucket is due.
> 
> 
>>>Now an interesting point you bring up above is when to schedule timer
>>>interrupts. One could just have a fine-grained timer-interval unit and
>>>crank up HZ, but clearly we don't want to schedule interrupts to go off
>>>too frequently or the overhead won't be worth it. Instead to get high-
>>>res timers, the idea is to look at the timer list and schedule
>>>interrupts appropriately. Then we only take an interrupt when there is
>>>work to do, rather then at regular periodic intervals when there may or
>>>may not be anything to expire.
>>
>>This would suggest that all timers are high res.  I don't think this makes sense:
>>1) because most users just don't care that much about resolution and high-res 
>>carries some overhead.
>>2) Not all platform hardware is able to handle high res.
> 
> 
> Indeed, in our system all timers could be high res, but don't
> necessarily need to be by default. It ends up being a function of how
> finely-grained the timer-interval units are set to be and how
> efficiently the hardware can be scheduled.

We currently ship HRT with a resolution of 1usec.  Lets agree that you don't 
want to even try to do this by adjusting the timer-interval.
> 
> 
>>I think high res timers should only be used when the user asks for them.  This 
>>keeps the overhead under control.
> 
> 
> Abstractly that makes sense, but I'm not sure how you mean "when the
> user asks for them". Is this a runtime consideration, or is it compile
> time?

Run time, he uses the POSIX clocks and timers interface and uses a seperate high 
res clock.  Only timers on high res clocks are high res.
> 
> 
~
>>
>>A small, measureable latency is ok and need not be backed out by the software. 
>>If you go this route you risk expiring a timer early and the standard says bad 
>>things about this.
> 
> 
> Since we expire based upon time instead of ticks, we can never expire
> early.

Think of it this way.  Decompose a HR timer into corse and fine units (you 
choose, but here let say jiffies and nanoseconds).  Now we want the normal timer 
system to handle the jiffies part of the time and to turn the timer over to the 
HR timer code to take care of the nanosecond remainder.  If the jiffie part is 
late, depending on the nanosecond part, it could make the timer late (i.e for 
low values of the nanosecond part).  For high values of the nanosecond part, we 
can compenstate...

This decomposition makes a lot of sense, by the way, for, at least, the 
following reasons:
1) it keeps the most of the HR issues out of the normal timer code,
2) it keeps high res and low res timer in the correct time order, i.e. a low res 
timer for jiffie X will expire prior to a high res timer for jiffie X + Y 
nanoseconds.
3) handling the high res timer list is made vastly easier as it will only need 
to have a rather small number of timers in it at any given time (i.e. those that 
are to expire prior to the next corse timer tick).
> 
> 
>>What is missing in this is that the flag ship arch (x86) has piss poor 
>>capability to schedule timer interrupts.  I.e. there really is no commonly 
>>available timer to generate interrupts at some arbitrary time.  There is, 
>>however, the PIT, which, if you don't mess with it, is very low overhead but 
>>periodic.
>>
>>Then there is the issue of what the time standard is.  In the x86, the PIT is 
>>it.  The pm_timer is close, but the read problem adds so much overhead as to 
>>make it hard to justify.  Possibly the HPET does a better job, but it is still 
>>an I/O access (read SLOW) and is not commonly available as yet.
> 
> 
> With my rework, the time standard issue is separate problem domain from
> HRT. If the timeofday code cannot give correct time, its a bug in that
> subsystem. While you're point is a fair critique of my timeofday work
> (which I am trying to address), the clear interface between soft-timers
> and timeofday allows for the soft-timer subsystem to not worry about
> that.

Leaving aside timers, one issue I am trying to get you to address is that on 
most X86 machines the "clock" rock is only expressed via PIT interrupts.  While 
we must express time with more resolution than this, we must also "use" that 
rock (i.e. PIT) to keep decent long term time.
> 
> 
>>You also have to do something reasonable for the accounting subsystems. 
>>Currently this is done by sampling the system at a periodic rate.  What ever is 
>>running gets charged with the last period.  If you go non-periodic, either you 
>>have to charge a variable period when the sample is taken or you have to set up 
>>timers as part of context switching.  This ladder is not wise as the context 
>>switch overhead then gets larger.  It is rather easy to show that the accounting 
>>overhead in such a system with a modest load is higher than in a periodic 
>>sampled system.  This system is also charged with doing the time slicing.  With 
>>out a periodic tick, a timer needs to be set up each context switch.
> 
> 
> I've not looked at the accounting subsystem yet, but I'll try to dig in
> and see what we can do here. Thanks for the heads up.

This is the main reason a tick less system is unwise.  It is overload prone.
> 
> 
>>In addition to all of this, there is the issue of how to organize the timer list 
>>so that you can find the next timer.  With the current organization this is 
>>something you just don't want to do.  On the other hand, I am convinced that, 
>>for periodic timers, it is about as good as it gets.
> 
> 
> You might have to go a bit more into detail on this last point. 

First, lets agree that we need not be in love with any given timer list structure.

The issues to be addressed are:
1) Fast insert.
2) Fast removal prior to expire, (almost all timers never expire).
3) Fast look up and removal of timers to expire NOW

If you want to find the next timer to expire at some time in the furture:
4) Fast look up of the next timer.

The current cascade timer list does a very good job of 1, 2, and 3 but is not 
set up to make 4 easy or fast.


> 
> One thing I'd like to emphasize is that while Nish and my work do change
> a large amount of code that collides with your code, we want to make
> sure that what the HRT patch achieves is still possible. As I get more
> familiar with the HRT code needs and you get more familiar with what
> we're providing I hope things will work smoothly.
> 
As do I.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
