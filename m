Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVJLXsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVJLXsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVJLXsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:48:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:53500 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932488AbVJLXsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:48:05 -0400
Message-ID: <434DA06C.7050801@mvista.com>
Date: Wed, 12 Oct 2005 16:46:52 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com,
       paulmck@us.ibm.com, Christoph Hellwig <hch@infradead.org>,
       oleg@tv-sign.ru, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0509301825290.3728@scrub.home>  <1128168344.15115.496.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0510100213480.3728@scrub.home> <1129016558.1728.285.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510130004330.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0510130004330.3728@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Tue, 11 Oct 2005, Thomas Gleixner wrote:
> 
> 
>>>>As far as I understand SUS timer resolution is equal to clock resolution
>>>>and the timer value/interval is rounded up to the resolution.
>>>
>>>Please check the rationale about clocks and timers. It talks about clocks 
>>>and timer services based on them and their resolutions can be different.

Well, yes and no.  Under timer_settime() it talks about ticks and resolution being the inverse of 
the tick rate.  AND it does imply that timers on a given CLOCK will have that clocks resolution as 
returned by clock_res().  This is fine as far as it goes.  In practical systems we almost always 
have a much higher resolution for the clock_gettime() and gettimeofday() than the tick rate.  What 
the standard does not seem to want to do is to admit that a clock may have the ability to be read at 
a better resolution than its tick rate.

For this reason, the usual practice is to return the "timer" resolution for clock_res() and to 
return clock values with as much resolution as possible.  In no case should the actual clock 
resolution be less than what clock_res() returns.

>>
>>clock_settime():
>>... Time values that are between two consecutive non-negative integer
>>multiples of the resolution of the specified clock shall be truncated
>>down to the smaller multiple of the resolution.
>>
>>timer_settime():
>>...Time values that are between two consecutive non-negative integer
>>multiples of the resolution of the specified timer shall be rounded up
>>to the larger multiple of the resolution. Quantization error shall not
>>cause the timer to expire earlier than the rounded time value.

Here the standard uses "resolution of the specified timer" but the only way, in the standard, to 
associate a resolution with a timer is via the CLOCK used.
> 
> 
> Where does it say anything about that their resolution is equal?

So the timers resolution is the same as the CLOCKs resolution as returned by clock_res() but, as I 
said above, the usual practice is to return clock values (via clock_gettime or gettimeofday) with 
higher resolution.
> 
> 
>>>>Reprogramming interval timers by now + interval is completely wrong.
>>>>Reprogramming has to be 
>>>>timer->expires + interval and nothing else. 
>>>
>>>Where do get the requirement for an explicit rounding from?
>>>The point is that the timer should not expire early, but there is more 
>>>than one way to do this and can be done implicitly using the timer 
>>>resolution.
>>
>>See above.

The standard requires that timer expiry times and interval times be rounded up to the next 
"resolution" value.  For the first or initial time of a repeating timer we, usually, have to add an 
additional "resolution" to account for starting the timer at some point between ticks.  For the 
interval on repeating timers, we know that the interval is starting at the last expiry time and thus 
do not need to account for the between tick start time.
> 
~

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
