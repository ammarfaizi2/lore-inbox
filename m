Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVJSCxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVJSCxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 22:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVJSCxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 22:53:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:49661 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932402AbVJSCxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 22:53:49 -0400
Message-ID: <4355B4EB.2080307@mvista.com>
Date: Tue, 18 Oct 2005 19:52:27 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0510100213480.3728@scrub.home>  <1129016558.1728.285.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>  <Pine.LNX.4.61.0510150143500.1386@scrub.home>  <1129490809.1728.874.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0510170021050.1386@scrub.home>  <20051017075917.GA4827@elte.hu>  <Pine.LNX.4.61.0510171054430.1386@scrub.home>  <20051017094153.GA9091@elte.hu> <20051017025657.0d2d09cc.akpm@osdl.org>  <Pine.LNX.4.61.0510171511010.1386@scrub.home> <1129582512.19559.136.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510180032420.1386@scrub.home> <435449DC.8070109@mvista.com> <Pine.LNX.4.61.0510181823560.1386@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0510181823560.1386@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Mon, 17 Oct 2005, George Anzinger wrote:
> 
~
> 
>>>>2. The rounding to the resolution value is explicitly required by the
>>>>standard.
>>>
>>>
>>>It doesn't explicitly specify which resolution (see the previous mail).
>>>It doesn't explicitly specify how this rounding has to be implemented.
>>
>>In the timer_settime() call there is only one possible resolution referred to,
>>that of the specified clock.  The standard
>>says(http://www.opengroup.org/onlinepubs/009695399/functions/timer_settime.html):
>>
>>Time values that are between two consecutive non-negative integer multiples of
>>the resolution of the specified timer shall be rounded up to the larger
>>multiple of the resolution. Quantization error shall not cause the timer to
>>expire earlier than the rounded time value.
>>
>>This says a) round to the next resolution, and b) don't allow the resulting
>>timer to expire early. The implication is that timers are to expire on
>>resolution boundaries so we need to round such that the expire happens _after_
>>the rounded time.
>>
>>Am I missing something here?
> 
> 
> In short: rounding errors.
> 
> Above says IOW if we have a clock with a frequency f and a resolution with
> r=10^9/f, we have to round time t up so that it becomes a integer multiple 
> i of r, so that once the counter reaches the value i all timer with up to a
> time value of i*r are expired.
> 
> If we now simply ignore the resolution fraction, we get a rounded value 
> which is quickly far away from the real value (with a worst case of r-1 
> nsec). This means an explicit rounding is likely only to make things 
> worse and any rounding is better done as part of the conversion from/to 
> timespec to/from the counter value according to the above rules and even 
> this conversion should be avoided as much as possible to minimize rounding 
> errors.

I think the rounding errors you are talking about would require us to define the clock period in 
something finer than nanoseconds.  The usual practice is to work with a resolution specified in 
nanoseconds (which is the same units the user hands us).  We then only worry about the last 
"resolution" or so of the elapsed time, rather than going back to the beginning of time.  The math 
becomes harder when converting to a particular timer with resolution in the nanosecond area, as, for 
example, the TSC.  Here we use what I call "scaled math" to both improve resolution and accuracy and 
to avoid the evil div instruction.  It is rather easy to get accuracy down to a few parts per 
billion.  I really don't think the math, however, is the issue here.

Rather I think you would like to turn the hardware resolution into the resolution we use and send to 
the user.  This, I think, is not quite the right way to go.  Suppose, for example, we have a timer 
that will do micro second resolution.  To provide this to the user implies that he is free to ask 
for timers that expire every micro second.  Today, this is not really a wise thing to do as we would 
soon use all the cpu cycles doing interrupt overhead.  So we define a resolution, say 100 micro 
seconds, and set things up that way.  This means we, at most, need to handle timer interrupts once 
every 100 usecs (still not really wise, put possible with some of todays hardware).

Now, if the timer we use actually has a resolution of 1.33333 usec, do we want to use a multiple of 
this as our resolution?  Not really, folks would just get confused. We can just tell them it is 
100usec and do the math.  The errors introduced by this are, at most, 1.3333 usec, and they are NOT 
cumulative, as long as we do the math for each expiry.  (If we try to compute a LATCH to use to get 
100 usec periods, we will accumulate errors, so why do that?)  A jitter of 1.3333 usec is well under 
the radar, being lost in the interrupt overhead.
> 
> 
>>The assumption, that I think you made, that we can let the hardware do the
>>rounding runs contrary to one of the main reasons for resolution, i.e. to
>>group timers so that we can reduce the system overhead.  Just because we have
>>timer hardware with microsecond resolution is not reason enough to offer it to
>>the user as handling an interrupt every micro second is way too much overhead,
>>and, in most cases, the user doesn't even want to such a fine resolution.
> 
> 
> This just means that we have two values to describe a timer, the clock 
> resolution describes the precision with which the timer can be programmed 
> and the timer precision which describes the maximum frequency of timer 
> expiry. I think both values are of interest to user applications, so my 
> current preference is to actually export them both properly instead of 
> overloading the clock_getres() interface.

But, as I say above, we don't want to export the hardware detail, but an abstraction we build on top 
of it.  Suppose we don't want to provide 100 usec timers except where really needed.  We could 
provide a different abstraction that has, say 10 ms resolution.  We could then set things up so that 
the user gets this all most all the time, say by define CLOCK_REALTIME with this resolution.  We 
then might define CLOCK_REALTIME_HR to have a resolution of 100 usec.  The user who needs it will 
realize that it has higher overhead (else why would we make it a bit harder to get to), and use it 
only when he needs the resolution it provides.

There is no reason that both of these "clocks" can not use the same underlying code and hardware. 
At the same time they do not have to.
> 
> The spec allows both resolutions:
> 
> "an implementation (is required) to document the resolution supported for 
> timers and nanosleep() if they differ from the supported clock resolution"

What we want to do, and what is done by others, is to define different clocks which carry their 
resolution to the timers used on them.  This is a little orthogonal to the standard, but seems to be 
a reasonable extension.
> 
> This means that unfortunately only one can be determined at runtime via 
> standard means, so if we are going to create non portable interfaces, we 
> should do it at least properly.
> 
> bye, Roman

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
