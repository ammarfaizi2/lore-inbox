Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVEDSQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVEDSQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVEDSQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:16:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:28837 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261301AbVEDSOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:14:49 -0400
Message-ID: <42791114.60109@us.ibm.com>
Date: Wed, 04 May 2005 11:14:44 -0700
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: Nishanth Aravamudan <nacc@us.ibm.com>, john stultz <johnstul@us.ibm.com>,
       Liu Qi <liuqi@ict.ac.cn>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Help with the high res timers
References: <E1DSl7F-0002v2-Ck@sc8-sf-web4.sourceforge.net> <20050503024336.GA4023@ict.ac.cn> <4277EEF7.8010609@mvista.com> <1115158804.13738.56.camel@cog.beaverton.ibm.com> <427805F8.7000309@mvista.com> <20050504001307.GF3372@us.ibm.com> <42790207.30709@mvista.com>
In-Reply-To: <42790207.30709@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
 > |First I want to express my joy that we are discussing these issues at
 > some depth.
 >
 > I also think we need a wider audience and so have added the kernel list
 > to the cc.  For that reason, I will not trim this message, thus allowing
 > them to "catch up".
 >
 > Nishanth Aravamudan wrote:
 >
 >> On 03.05.2005 [16:15:04 -0700], George Anzinger wrote:
 >>
 >>> john stultz wrote:
 >>>
 >>>> On Tue, 2005-05-03 at 14:36 -0700, George Anzinger wrote:
 >>>>
 >>>>
 >>>>> At the moment I am trying to understand and recast the work John
 >>>>> Stultz is doing.  I have some very real concerns here and there is
 >>>>> a patch by nacc@us.ibm.com<Nishanth Aravamudan> that, to me, looks
 >>>>> like a royal pain.  I think we need to understand it better and
 >>>>> voice our concerns in a way that is constructive. Nish's patch is
 >>>>> here: http://www.ussg.iu.edu/hypermail/linux/kernel/0504.3/1635.html
 >>
 >>
 >>
 >> I'm not on the HRT list, so I didn't get the original e-mail...keep me
 >> on the CC, please.
 >>
 >>
 >>>> Hey George,     Hopefully our work isn't causing you too much
 >>>> trouble. I do     understand
 >>>> the pain of having large conflicting works that try to achieve similar
 >>>> goals.
 >>>>
 >>>>
 >>>>
 >>>>> To summarize my concerns, the HRT code depends on correct and exact
 >>>>> registration of the timer interrupt with time of day.  (We don't
 >>>>> worry about latency here.) In the latest x86 HRT patch we fine tune
 >>>>> the system clock to insure this alignment.  This allows us to set
 >>>>> up two stage timers that use the run_timers code for the coarse
 >>>>> time (to the time base resolution) followed by a short high res
 >>>>> hardware timer to get to the higher resolution we want.  If the
 >>>>> coarse timer (i.e. add_timer, run_timer and friends) do not
 >>>>> register correctly, we will have the case of a coarse timer
 >>>>> expiring after the needed and requested time.  Now,
 >>>>
 >>>>
 >>>>> from a coarse timer point of view, that may be fine, but it means
 >>>>> we can
 >>>>
 >>>>
 >>>>> not depend on it for the high res first stage.
 >>>>
 >>>>
 >>>>
 >>>>
 >>>> The conceptual idea Nish is going after, is once we have a solid 
method
 >>>> to get a high-res timeofday (via the new monotonic_clock()
 >>>> function), we
 >>>> can use that instead of jiffies to expire soft-timers.
 >>>> This requires re-defining each timer-bucket entry length from a jiffy
 >>>> instead to a unit of time (Nish calls this a timerinterval unit). This
 >>>> timer-interval unit's length is flexible can be defined at compile
 >>>> time.
 >>>> Currently Nish is using ~1ms (1<<20 nanoseconds) as the interval
 >>>> length,
 >>>> but it could be redefined to be as desired to give higher-res soft-
 >>>> timers.
 >>>
 >>>
 >>> The issue is not its length, but can we interrupt at its end.  The
 >>> key to high res is being on time.  If we want a 100usec resolution
 >>> timer, we need to have the low res timer hit its mark with something
 >>> real close to this.
 >>
 >>
 >>
 >> Are you asking: Can we interrupt at the end of the timerinterval? That
 >> doesn't matter to me, so much, since I made the timerinerval length
 >> independent of the interrupt source. If you wanted to make sure they
 >> corresponded completely, you simply would need to change the
 >> nsecs_to_timerintervals() function appropriately. I was trying to stay
 >> somewhat efficient, especially since we're dealing with a 64-bit
 >> quantity, and thus used the shifting John mentioned above.
 >
 >
 > I think we are at too high a level to go into this in detail here, but
 > part of the HRT patch is a header called sc_math.h (Scaled math).  The
 > notion that you need to choose and hard code the multiplier is addressed
 > there.  The only real choice you need to make is the number of bits you
 > want to shift.  The more you shift the more exact the answer is.  For an
 > example of choosing the shift bits you may want to look at jiffies.h in
 > the current tree.
 >
 >>
 >> So, currently, my code does not provide for high-res timers,
 >> admittedly. It does enable some of the infrastructure that should make
 >> implementing high-res timing in mainline (turned on by tuning
 >> TIMERINTERVAL_BITS or setting a .config option, perhaps) more feasible,
 >> in my eyes. I think we have the same goal in mind -- make timing
 >> flexible and useful.
 >>
 >> To get 100 usec resolution with my system, you would need to make
 >> TIMERINTERVAL_BITS=16. Basically, this makes a timerinterval = 1
 >> nanosecond << 16, or 131.07 (131) microseconds. (Of course, you could
 >> not use shifting and just divide by 10. Might be slower, but is
 >> certainly feasible.) Admittedly, this is not perfect, but it's close.
 >> Now, this has nothing to do with the hardware. But, it defines the
 >> lowest interval, *regardless* of hardware, which the system will
 >> support. If you request a 100 microsecond delay, we will make it 131
 >> microseconds.
 >
 >
 > Leaving aside the precision issue (addressed by scaled math above), I
 > don't think this is the way to address high resolution.  For the most
 > part most user and kernel applications are quite happy with 10 ms
 > resolution and, I would argue, we should go back to the 100 HZ value.
 > IMNSHO high res should be asked for on a request at a time basis.  The
 > POSIX standard provided a rather nice way to do this in the CLOCKS &
 > TIMERS section of the standard.  In the kernel the low res part of this
 > is in kernel/posix-timers.c.  To extend to high res all one does is to
 > define new clocks.  In HRT we define two high res clocks
 > (CLOCK_REALTIME_HR and CLOCK_MONOTONIC_HR).  From the user point of
 > view, to get high res, he has to used one of these clocks.
 >
 > The trick is to muster the kernel resources to make the *_HR clock a
 > reality. In my HRT patches I have done this with a two phase approach.
 > I simply add a second, HR member to the timer structure.  This allows
 > the timer to carry the extra bits needed to express the added resolution
 > and also, if the bits are zero, to indicate that it is just a low res
 > timer.  Over the life time of the HRT patch I have worked with two
 > different ways of handling the HR bits in the timer list.  In all cases,
 > we stay with a periodic time tick and only incur extra overhead when the
 > timer is about to expire.  We ask the "arch" code to provide an
 > interrupt source with the needed short term resolution.  Since we only
 > use this timer at the end of the timer period it needs cover only a
 > short time (0 to 1 jiffie), but should have good resolution over this
 > period.  Also, since it is a rather short time, we don't require it to
 > have long term stability.
 >
 > The point is, the standard, low res, timer code needs to be only
 > minimally aware of the HR bits.  On the other hand, since the HR timer
 > will be started on expiration of the low res timer, we need that
 > expiration to be aligned with the clock in a stable, predictable long
 > term way.  (For what its worth, we have yet to address NTP clock
 > drifting in the HRT patch, so that is still a fly in this web of time.)
 >

You are still dependent on jiffies which is very unreliable du to lost 
ticks, HZ vs ACTHZ, etc.  Even if you use a periodic tick, it seems the 
HRT code would still benefit from a human-time soft-timers sub-system 
that wasn't affected by such things.


 >>
 >> Now, the trick is then, to get the hardware to tick every 100
 >> microseconds. You have a lot more expertise in this area, and I would be
 >> interested to see what the actual options are. Presuming we are able to
 >> get a periodic interrupt at this rate, we could then do what I think HRT
 >> pretty much does, maintain the normal buckets for normal timers and then
 >> have a special HRT bucket. We could then be aware of when, in
 >> nanoseconds, the next HRT interrupt should be, set the hardware
 >> appropriately and be ok. If there are no HRT timers, then we'll never
 >> check that bucket, really (we could also just not configure in that
 >> option). I think it's feasible, regardless. There may be performance
 >> penalties, I agree. I'm working on figuring out how bad things get if we
 >> set TIMERINTERVAL_BITS=10, for instance (about every microsecond). If
 >> the system stays up, I'll be happy :)
 >
 >
 > I don't think we have hardware yet that can address 100usec ticks, nor,
 > as I argue above, do we need it.  In point of fact, we found it
 > necessary to address the user who, using the POSIX standard timer
 > interface asked for a repeating timer of, say 1 usec (yes we "say" we
 > support 1 usec resolution).  Such a request could easily consume the
 > machine (I call these timer storms), causing it never to be hear from
 > again.  The, I think, elegant solution to the timer storm problem is to
 > not restart the timer until the user picks up the prior expiration.
 > This dynamically adjusts the timer response to the amount of machine
 > available at the time.
 >
 >>
 >>
 >>>> Now when the new code expires timers it does so against the timeofday
 >>>> subsystem's notion of time instead of jiffies. It simply goes through
 >>>> all the timer bucket entries between now and the last time we expired
 >>>> timers.
 >>>
 >>>
 >>> This is not unlike what happens now.  I would hope that the number of
 >>> buckets visited averages to to something real close to 1 per
 >>> run_timers entry.
 >>
 >>
 >>
 >> I agree, this is what we might be able to achieve by keeping high-res
 >> timers in their own bucket. That way, we could conceivably know when the
 >> next periodic interrupt is and when the next HRT interrupt is in
 >> absolute nanoseconds (based on do_monotonic_clock()).
 >
 >
 > For what its worth, we have such a clock in HRT.  It is expressed in
 > jiffies and arch_cycles, but jiffies is what is used today as the
 > "standard" for internal system time.  This gets into the area of just
 > how to express time in areas where you need to quickly get and compare
 > the time.  After a lot of though, I decided to use arch_cycles rather
 > than nanoseconds because arch_cycles are directly readable from the
 > hardware.  Any other unit of time requires a conversion, and, as you
 > know, usually requires 64-bits as well.  By staying with arch_cycles we
 > avoid "most" of the conversion overhead.
 >

I can see why you might want to use arch_cycles, and at least it is an 
absolute time.  Jiffies though is not.  Perhaps HRT could benefit from a 
conversion to "milliseconds + arch_cycles" ?

 >>
 >>
 >>>> Now an interesting point you bring up above is when to schedule timer
 >>>> interrupts. One could just have a fine-grained timer-interval unit and
 >>>> crank up HZ, but clearly we don't want to schedule interrupts to 
go off
 >>>> too frequently or the overhead won't be worth it. Instead to get high-
 >>>> res timers, the idea is to look at the timer list and schedule
 >>>> interrupts appropriately. Then we only take an interrupt when there is
 >>>> work to do, rather then at regular periodic intervals when there 
may or
 >>>> may not be anything to expire.
 >>>
 >>>
 >>> This would suggest that all timers are high res.  I don't think this
 >>> makes sense:
 >>> 1) because most users just don't care that much about resolution and
 >>> high-res carries some overhead.
 >>> 2) Not all platform hardware is able to handle high res.
 >>
 >>
 >>
 >> I agree, this is an issue which my TIMERINTERVAL_BITS=10 test should
 >> also reveal. But under the normal case where TIMERINTERVAL_BITS are 20,
 >> then there will never be an interrupt scheduled to go off quicker than
 >> 2^20 nanoseconds in the future (about a millisecond). Everything hinges
 >> around these bits :) (mostly because they define how we convert
 >> nanoseconds to timerintervals).
 >>
 >>
 >>> I think high res timers should only be used when the user asks for
 >>> them.  This keeps the overhead under control.
 >>
 >>
 >>
 >> I agree -- the user asking for the, currently, would mean they set
 >> TIMERINTERVAL_BITS lower than normal and also set up the hardware to
 >> interrupt appropriately.
 >
 >
 > No, no, they ask by using a *_HR clock.
 >
 >>
 >>
 >>>> Now from my understanding of your framework, this sounds similar 
to how
 >>>> your high-res hardware timer interrupt is used. The idea being that we
 >>>> use that for all soft-timers, instead of having two levels of high-res
 >>>> and coarse soft-timers.
 >>>>
 >>>> The interesting problem that Darren will be looking at is how to
 >>>> schedule interrupts accurately. This appears to be something you've
 >>>> already attacked, so your experience would be helpful. My idea being
 >>>> that the timer_interrupt code checks when it intended to fire and when
 >>>> it actually did fire, and that information could then be used to tune
 >>>> the interrupt scheduling code.
 >>>
 >>>
 >>> A small, measurable latency is ok and need not be backed out by the
 >>> software. If you go this route you risk expiring a timer early and
 >>> the standard says bad things about this.
 >>
 >>
 >>
 >> I'm not sure what you mean about timers going off early. We round up on
 >> addition and round down on expiration to make sure that we don't get
 >> timers early. As long as do_monotonic_clock() is accurate, we should be
 >> ok. (Darren's part uses the timerintervals value to figure out when the
 >> next interrupt should be, similar to the existing
 >> next_timer_interrupt())
 >
 >
 > Your rounding up or down is not really different than what is done with
 > jiffies today...
 >
 >>
 >>
 >>> What is missing in this is that the flag ship arch (x86) has piss
 >>> poor capability to schedule timer interrupts.  I.e. there really is
 >>> no commonly available timer to generate interrupts at some arbitrary
 >>> time.  There is, however, the PIT, which, if you don't mess with it,
 >>> is very low overhead but periodic.
 >>
 >>
 >>
 >> And generally, we are going to stay periodic, for now. Darren's patch is
 >> a further extension on mine, which requires a lot of testing.
 >>
 >>
 >>> Then there is the issue of what the time standard is.  In the x86,
 >>> the PIT is it.  The pm_timer is close, but the read problem adds so
 >>> much overhead as to make it hard to justify.  Possibly the HPET does
 >>> a better job, but it is still an I/O access (read SLOW) and is not
 >>> commonly available as yet.
 >>>
 >>> You also have to do something reasonable for the accounting
 >>> subsystems. Currently this is done by sampling the system at a
 >>> periodic rate.  What ever is running gets charged with the last
 >>> period.  If you go non-periodic, either you have to charge a variable
 >>> period when the sample is taken or you have to set up timers as part
 >>> of context switching.  This ladder is not wise as the context switch
 >>> overhead then gets larger.  It is rather easy to show that the
 >>> accounting overhead in such a system with a modest load is higher
 >>> than in a periodic sampled system.  This system is also charged with
 >>> doing the time slicing.  With out a periodic tick, a timer needs to
 >>> be set up each context switch.
 >>
 >>
 >>
 >> We will always (at least in our current concept) have an idea of when,
 >> worst/best case, the next timer interrupt will be (a maximum, predefined
 >> interval). This would also define how long the system could go
 >> completely idle without expiring any timers.
 >
 >
 > I think we should leave the skipping of timer interrupts to VST code.
 > The VST code only needs to figure out when the next timer is to expire
 > when the cpu is idle, i.e. it has a time to spare to look up that timer.
 >
 >>
 >>
 >>> In addition to all of this, there is the issue of how to organize the
 >>> timer list so that you can find the next timer.  With the current
 >>> organization this is something you just don't want to do.  On the
 >>> other hand, I am convinced that, for periodic timers, it is about as
 >>> good as it gets.
 >>
 >>
 >>
 >> I think currently, we do something similar to next_timer_interrupt(),
 >> making sure we update the stored value whenever we add a new timer, if
 >> necessary. Except now, we will determine the next time to set the hw
 >> timer to go off every time we expire timers.
 >
 >
 > Finding the next timer is a high overhead operation....

Perhaps it is now, but does it have to be?  The process scheduler used 
to be full of O(N) algorithms to, but they were all converted to O(1) by 
doing several incremental calculations instead of one huge one.  Perhaps 
something similar could be done with timers by cacheing a couple of 
timer expirations and modifying them as timers are added, removed, and 
modified.  Just brainstorming here.

 >
 >>
 >> I know my proposal is a big change and does make things more difficult
 >> in the short-term for the HRT patch. But I think it is possible to work
 >> together and get a very reasonable system in place, which allows for
 >> both HRT and normal timers to work effectively. I may have made things
 >> worse in my response, but I think the discussion has to be had :)
 >>
 >
 >

--Darren
