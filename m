Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVJRBEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVJRBEm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 21:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVJRBEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 21:04:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56303 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932351AbVJRBEk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 21:04:40 -0400
Message-ID: <435449DC.8070109@mvista.com>
Date: Mon, 17 Oct 2005 18:03:24 -0700
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
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0510100213480.3728@scrub.home>  <1129016558.1728.285.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>  <Pine.LNX.4.61.0510150143500.1386@scrub.home>  <1129490809.1728.874.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0510170021050.1386@scrub.home>  <20051017075917.GA4827@elte.hu>  <Pine.LNX.4.61.0510171054430.1386@scrub.home>  <20051017094153.GA9091@elte.hu> <20051017025657.0d2d09cc.akpm@osdl.org>  <Pine.LNX.4.61.0510171511010.1386@scrub.home> <1129582512.19559.136.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510180032420.1386@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0510180032420.1386@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Mon, 17 Oct 2005, Thomas Gleixner wrote:
> 
> 
>>On Mon, 2005-10-17 at 18:25 +0200, Roman Zippel wrote:
>>
~
>>interval, overrun:
>>Interval holds the converted interval value for itimers. The overrun
>>member is used by the rearm code so the caller can figure out the number
>>of missed events. 
>>
>>The cleanup I pointed out for the posix timer interval timers is pretty
>>obvious. It makes use of interval and overrun and removes two members of
>>the posix timer structure.
> 
> 
> Where I think it's possible to separate the timer from the interval 
> functionality to get a simpler timer base implementation.

They are required fields for the POSIX timer.  I think you are saying that they should be there and 
not in the ktime struct, which is part of the POSIX timer struct.  Is that right?

Along this line, I have a bit of a problem with the ktimer code doing the timer repeat stuff.  This 
is NOT used by POSIX timers because we want to wait for the user to pick up the signal before 
starting the next interval.  This is key to avoiding timer storms and I would think that puting the 
repeat stuff in ktimer code opens it to the possibility of other users starting a timer storm via 
this.  I think the itimer code should also use the signal call back to start the next interval, and 
for the same reason.
> 
> 
~
>>>- resolution handling: at what resolution should/does the kernel work and 
>>>what do we report to user space. The spec allows multiple interpretations 
>>>and I have a hard time to get at least one coherent interpretation out of 
>>>Thomas.
>>
>>I interpret the spec in the way I do for following reasons:
>>
>>1. It is _usual practice_ to return the "timer" resolution for
>>clock_res() and to return clock values with as much resolution as
>>possible. In no case should the actual clock resolution be less than
>>what clock_res() returns.
>>- George Anzinger in this thread. Similar opinions can be found via
>>Google. I came to the same conclusion and saw no reason to repeat
>>Georges statement. I thought a simple pointer would be sufficient.
> 
> 
> In this case you don't interpret the spec, you ignore the spec. (I'll 
> leave it open whether that's a good or bad thing.)

Eh?  Granted we don't truncate the time on settime, but how else is it ignored?
> 
> 
>>2. The rounding to the resolution value is explicitly required by the
>>standard.
> 
> 
> It doesn't explicitly specify which resolution (see the previous mail).
> It doesn't explicitly specify how this rounding has to be implemented.

In the timer_settime() call there is only one possible resolution refered to, that of the specified 
clock.  The standard says(http://www.opengroup.org/onlinepubs/009695399/functions/timer_settime.html):

Time values that are between two consecutive non-negative integer multiples of the resolution of the 
specified timer shall be rounded up to the larger multiple of the resolution. Quantization error 
shall not cause the timer to expire earlier than the rounded time value.

This says a) round to the next resolution, and b) don't allow the resulting timer to expire early. 
The implication is that timers are to expire on resolution boundries so we need to round such that 
the expire happens _after_ the rounded time.

Am I missing something here?

The assumption, that I think you made, that we can let the hardware do the rounding runs contrary to 
one of the main reasons for resolution, i.e. to group timers so that we can reduce the system 
overhead.  Just because we have timer hardware with microsecond resolution is not reason enough to 
offer it to the user as handling an interrupt every micro second is way too much overhead, and, in 
most cases, the user doesn't even want to such a fine resolution.
> 
> 
>>3. It makes a lot of sense to do what (1.) describes, due to the fact
>>that we actually want to restrict the timer resolution to avoid
>>interrupt and reprogramming floods in very short intervals. This in fact
>>is the default behaviour in a jiffy driven environment. Pretending a
>>real nsec resolution and doing no rounding at all is violating (2.).
>>>From an application programmers view it makes sense to return the timer
>>resolution so he actually can adjust the program behaviour on the
>>provided resolution and not rely on wild guess assumptions about what
>>might be there. Applications need to be able to verify whether the
>>system can handle the required intervals or not.
> 
> 
> A portable application simply cannot make this assumption.

POSIX clocks and timers are part of the REAL TIME POSIX extension.  Arguing that real time apps need 
to be portable is, I think, rather beside the point.  At the same time, if rounding follows the 
rules, one can set up a timer_settime() timer_gettime() sequence to get the resolution, even with 
the itimer one can do this.  So resolution is available to the user in one way or another.  What he 
does with it is up to him, but at least some RT apps. set up timer to expire early and after expiry, 
busy wait until the "appointed" time.  Knowing the resolution helps to know how to set this up...
~
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
