Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVLVEbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVLVEbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVLVEbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:31:48 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:47605 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S932132AbVLVEbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:31:47 -0500
Message-ID: <43AA2BD1.3060009@mvista.com>
Date: Wed, 21 Dec 2005 20:30:09 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com,
       mingo@elte.hu
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
References: <20051206000126.589223000@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0512061628050.1610@scrub.home>  <1133908082.16302.93.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0512070347450.1609@scrub.home>  <1134148980.16302.409.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0512120007010.1609@scrub.home> <1134405768.4205.190.camel@tglx.tec.linutronix.de> <439E2308.1000600@mvista.com> <Pine.LNX.4.61.0512150141050.1609@scrub.home> <43A0D505.3080507@mvista.com> <Pine.LNX.4.61.0512191550460.1609@scrub.home> <43A71E07.30403@mvista.com> <Pine.LNX.4.61.0512212350110.2778@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0512212350110.2778@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Mon, 19 Dec 2005, George Anzinger wrote:
> 
> 
>>>You don't think the current behaviour is wrong.
>>>
>>>
>>
>>One of the issues I see with using your assumption is that moving the timer to
>>an absolute clock after the initial expiry _may_ lead to additional
>>qauntization errors, depending on how aligned the two clocks are.
> 
> 
> What do you mean by "moving the timer to an an absolute clock"?

The assumption I am making is that the timer is connected to a clock 
(CLOCK_MONOTONIC or CLOCK_REALTIME).  Timers on CLOCK_REALTIME with 
the absolute flag set should expire at the requested time as read from 
that clock, where as relative timers are not affected by time setting 
and thus should be on CLOCK_MONOTONIC.  It is unclear, in general, how 
these two clocks relate to each other at the nanosecond level, or so 
one might think.  Of course, we can define this problem away by a 
particular definition of one of these clocks as being derived from the 
other (which we, infact, do in Linux).
> 
> 
>>I would guess, then, that either the non-absolute or the absolute timer
>>behaves badly in the face of clock setting.  Could you provide a pointer to
>>the NetBSD code so I can have a look too?
> 
> 
> http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/kern/kern_time.c?rev=1.98&content-type=text/x-cvsweb-markup
> AFAICT TIMER_ABSTIME is only used to convert the relative value to an 
> absolute value.

Yes,  there is also this interesting comment in settime:
/* WHAT DO WE DO ABOUT PENDING REAL-TIME TIMEOUTS??? */

I strongly suspect that this system does NOT expire absolute timers 
and clock_nanosleep calls at the requested time in the face of clock 
setting.

I see NO hooks in the referenced code that would allow them to find 
such timers at clock set time, nor are they entered into any different 
list to make them findable.  It would appear that the absolute 
attribute is lost as soon as the time is convereted to a relative time.

In fairness, the POSIX folks added the clock setting requirement a few 
years after the absolute flag was defined...  but, still, there is 
that comment.
	

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
