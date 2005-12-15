Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVLOBLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVLOBLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVLOBLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:11:49 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:43759 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S964889AbVLOBLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:11:48 -0500
Message-ID: <43A0C2B9.1070508@mvista.com>
Date: Wed, 14 Dec 2005 17:11:21 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
CC: Thomas Gleixner <tglx@linutronix.de>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
References: <17594.192.54.193.25.1134477932.squirrel@rousalka.dyndns.org>    <439F5B91.4010903@mvista.com> <34966.192.54.193.35.1134554604.squirrel@rousalka.dyndns.org>
In-Reply-To: <34966.192.54.193.35.1134554604.squirrel@rousalka.dyndns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Mailhot wrote:
> On Mer 14 dÃ©cembre 2005 00:38, George Anzinger wrote:
> 
>>Nicolas Mailhot wrote:
>>
>>>"This is your interpretation and I disagree.
>>>
>>>If I set up a timer with a 24 hour interval, which should go off
>>>everyday at 6:00 AM, then I expect that this timer does this even when
>>>the clock is set e.g. by daylight saving. I think, that this is a
>>>completely valid interpretation and makes a lot of sense from a
>>>practical point of view. The existing implementation does it that way
>>>already, so why do we want to change this ?"
>>
>>I think that there is a miss understanding here.  The kernel timers,
>>at this time, do not know or care about daylight savings time.  This
>>is not really a clock set but a time zone change which does not
>>intrude on the kernels notion of time (that being, more or less UTC).
> 
> 
> Probably. I freely admit I didn't follow the whole discussion. But the
> example quoted strongly hinted at fudging timers in case of DST, which
> would be very bad if done systematically and not on explicit user request.
> 
> What I meant to write is "do not assume any random clock adjustement
> should change timer duration". Some people want it, others definitely
> don't.
> 
> I case of kernel code legal time should be pretty much irrelevant, so if
> 24h timers are adjusted so they still go of at the same legal hour, that
> would be a bug IMHO.

I am not quite sure what you are asking for here, but, as things set 
today, the kernels notion of time starts with a set time somewhere 
around boot up, be it from RT clock hardware or, possibly some script 
that quires some other system to find the time (NTP or otherwise). 
This time is then kept up to date by timer ticks which are assumed to 
have some fixed duration with, possibly, small drift corrections via 
NTP code.  And then there is the random settimeofday, which the kernel 
has to assume is "needed" and correct.

On top of this the POSIX clocks and timers code implements clocks 
which read the current time and a system relative time called 
monotonic time.  We, by convention, roll the monotonic time and uptime 
together, and, assuming that the NTP corrections are telling us 
something about our "rock", we correct both the monotonic time and the 
time of day as per the NTP requests.

Timers are then built on top of these clocks in two ways, again, as 
per the POSIX standard: 1) the relative timer, and 2) the absolute 
timer.  For the relative timer, the specified expiry time is defined 
to be _now_ plus the given interval.  For the absolute timer the 
expiry time is defined as that time when the given clock reaches the 
requested time.

The only thing in here that might relate to your "legal" hour is that 
we adjust (via NTP) the clocks so that they, supposedly, run at the 
NBS (or is it the Naval Observatory) rate, give or take a small, 
hopefully, well defined error.
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
