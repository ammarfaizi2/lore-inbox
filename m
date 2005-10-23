Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVJWSRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVJWSRv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 14:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVJWSRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 14:17:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32754 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750795AbVJWSRu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 14:17:50 -0400
Message-ID: <435BD3C2.9070705@mvista.com>
Date: Sun, 23 Oct 2005 11:17:38 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0510100213480.3728@scrub.home>  <1129016558.1728.285.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>  <Pine.LNX.4.61.0510150143500.1386@scrub.home>  <1129490809.1728.874.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0510170021050.1386@scrub.home>  <20051017075917.GA4827@elte.hu>  <Pine.LNX.4.61.0510171054430.1386@scrub.home>  <20051017094153.GA9091@elte.hu> <20051017025657.0d2d09cc.akpm@osdl.org>  <Pine.LNX.4.61.0510171511010.1386@scrub.home> <1129582512.19559.136.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510180032420.1386@scrub.home> <435449DC.8070109@mvista.com> <Pine.LNX.4.61.0510181823560.1386@scrub.home> <4355B4EB.2080307@mvista.com> <Pine.LNX.4.61.0510211326400.1386@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0510211326400.1386@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Tue, 18 Oct 2005, George Anzinger wrote:
> 
> 
>>>Above says IOW if we have a clock with a frequency f and a resolution with
>>>r=10^9/f, we have to round time t up so that it becomes a integer multiple i
>>>of r, so that once the counter reaches the value i all timer with up to a
>>>time value of i*r are expired.
> 
> 
> You don't specifically disagree, so I can assume you agree that this a 
> valid interpretation of the spec?
> (I'm asking because it's important for the design of the timer system.)

I agree with the proviso that we can define such a clock as an abstraction of a clock with a better 
resolution.  I.e. we can provide clocks with lesser resolution than the physical clock has.
> 
> 
>>>If we now simply ignore the resolution fraction, we get a rounded value
>>>which is quickly far away from the real value (with a worst case of r-1
>>>nsec). This means an explicit rounding is likely only to make things worse
>>>and any rounding is better done as part of the conversion from/to timespec
>>>to/from the counter value according to the above rules and even this
>>>conversion should be avoided as much as possible to minimize rounding
>>>errors.
>>
>>I think the rounding errors you are talking about would require us to define
>>the clock period in something finer than nanoseconds.
> 
> 
> No, you don't have to, all you have to do is to make sure that 
> "Quantization error shall not cause the timer to expire earlier than the 
> rounded time value." IOW at the time the timer expires, the expiry time 
> must not be greater than clock_gettime().

That should be "less than", but yes.  The comment I was making is that the math is not that hard to 
get right.
> 
> 
>>Rather I think you would like to turn the hardware resolution into the
>>resolution we use and send to the user.  This, I think, is not quite the right
>>way to go.  Suppose, for example, we have a timer that will do micro second
>>resolution.  To provide this to the user implies that he is free to ask for
>>timers that expire every micro second.  Today, this is not really a wise thing
>>to do as we would soon use all the cpu cycles doing interrupt overhead.  So we
>>define a resolution, say 100 micro seconds, and set things up that way.  This
>>means we, at most, need to handle timer interrupts once every 100 usecs (still
>>not really wise, put possible with some of todays hardware).
>>
>>Now, if the timer we use actually has a resolution of 1.33333 usec, do we want
>>to use a multiple of this as our resolution?  Not really, folks would just get
>>confused. We can just tell them it is 100usec and do the math.  The errors
>>introduced by this are, at most, 1.3333 usec, and they are NOT cumulative, as
>>long as we do the math for each expiry.  (If we try to compute a LATCH to use
>>to get 100 usec periods, we will accumulate errors, so why do that?)  A jitter
>>of 1.3333 usec is well under the radar, being lost in the interrupt overhead.
> 
> 
> No, the error is worse, although I specifically talk about the rounding 
> done in Thomas' patch, I'm not sure we're really talking about the same 
> thing. I didn't mean the error caused by jitter, in this case I'd 
> actually agree with you.
> 
> He sets the resolution right now to (NSEC_PER_SEC/HZ) and uses this value 
> to explicit round the time values. For example a timer is set to the value 
> 1.1ms and is rounded to 2ms. The timer tick now actually expires at 1.2ms 
> and could expire the timer, but it's instead expired at 2.2ms and user 
> space sees an error of 1.1ms.
> A similiar error even exists with interval timer, e.g. an interval timer 
> is set to 0.9ms and rounded to 1ms. If the clock now expires a little 
> too early the timer will expire repeatedly one tick too late.
> 
> In general due to this rounding and normal clock skew an extra error is 
> added with an average value of half the timer resolution.


I admit I have not looked, in detail, at this part of ktimers, however, assuming that the clock 
ticks at HZ then the normal error to be expected is and average of 1/2 the resolution with a max of 
1 resolution.  This is AFTER the rounding to the next resolution, so we can expect the expiry to be 
any where from 0 to 2*resolution-1.  (up to resolution-1 from rounding, and up to one resolution 
from clock skew).  This the way I and every one I have worked with understand the standard.

In your example, consider a request for 0.1ms rounded to 1ms....
> 
> 
>>But, as I say above, we don't want to export the hardware detail, but an
>>abstraction we build on top of it.  Suppose we don't want to provide 100 usec
>>timers except where really needed.  We could provide a different abstraction
>>that has, say 10 ms resolution.  We could then set things up so that the user
>>gets this all most all the time, say by define CLOCK_REALTIME with this
>>resolution.  We then might define CLOCK_REALTIME_HR to have a resolution of
>>100 usec.  The user who needs it will realize that it has higher overhead
>>(else why would we make it a bit harder to get to), and use it only when he
>>needs the resolution it provides.
>>
>>There is no reason that both of these "clocks" can not use the same underlying
>>code and hardware. At the same time they do not have to.
> 
> 
> I don't have a problem with this at all. I think it's fine to leave 
> clock_getres(CLOCK_REALTIME) at a save value.
> 
> 
>>>The spec allows both resolutions:
>>>
>>>"an implementation (is required) to document the resolution supported for
>>>timers and nanosleep() if they differ from the supported clock resolution"
>>
>>What we want to do, and what is done by others, is to define different clocks
>>which carry their resolution to the timers used on them.  This is a little
>>orthogonal to the standard, but seems to be a reasonable extension.
> 
> 
> Could you please give me an example for "others"?

Well, I know that HP in the HPRT system (likely long gone by now) did it this way.  That was back 
prior to 1997.  The system was based on the HP PA risc arch which has a system timer based on a 
cycle counter (rather like the PPC, but different).

> I don't think I have a problem with this. My point is to better define 
> "reasonable extension" or to be more specific what user expectations are 
> reasonable. What is needed by applications and where exactly do we draw 
> the line, when it comes to extra complexity in the timer design.
> 
> I wouldn't a priori exclude the possibility to break some user 
> applications, which have unreasonable expectations. We did this in the 
> past (e.g. sched_yield()), we simply fixed the applications and moved on, 
> but this requires more information about what applications expect about 
> high resolution timer.

We have had good acceptance of the HRT patch in our customer base.  As far as I know we have not 
gotten any feed back on just what resolution they want or use.  We allow them to define it (within 
reason) at configure time.  I have been recommending, for the x86, nothing better than about 100usec 
but this is based on my machine being able to handle an interrupt in about that amount of time.

We don't require alignment of the resolution with the actual hardware resolution as at these levels 
the interrupt jitter smooths over any issues in this area.  A comment here, in some of your math 
examples you seem to be implying that we are going to use a particular resolution from the begining 
of time to compute expiry time.  In fact, we start from "now" as defined by a, possibly corrected, 
system clock.  Once we have the rounded expiry time we use full resolution math to figure how to fit 
that into the timing services.  So, infact, the resolution comes into play only over 1 to 2 
resolutions of the requested time.  In other words, errors do not accumulate since we always mark to 
the corrected clock.
> 
> George, many thanks for trying to understand me and helping me to get a 
> better understanding of the issues. I see more misunderstandings than 
> disagreements, so I'd be really grateful, if you can help me later to 
> translate this into something Thomas and Ingo can understand. :-)
> 
No problem.  Do be advised I will be out most of next week through the end of Oct.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
