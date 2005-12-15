Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbVLOA4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbVLOA4n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVLOA4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:56:43 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:16367 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S965086AbVLOA4m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:56:42 -0500
Message-ID: <43A0BEF0.5050509@mvista.com>
Date: Wed, 14 Dec 2005 16:55:12 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com,
       mingo@elte.hu
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
References: <20051206000126.589223000@tglx.tec.linutronix.de>	 <Pine.LNX.4.61.0512061628050.1610@scrub.home>	 <1133908082.16302.93.camel@tglx.tec.linutronix.de>	 <Pine.LNX.4.61.0512070347450.1609@scrub.home>	 <1134148980.16302.409.camel@tglx.tec.linutronix.de>	 <Pine.LNX.4.61.0512120007010.1609@scrub.home>	 <1134405768.4205.190.camel@tglx.tec.linutronix.de>	 <Pine.LNX.4.61.0512140101410.1609@scrub.home> <1134599444.2542.76.camel@tglx.tec.linutronix.de>
In-Reply-To: <1134599444.2542.76.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> Hi,
~

> 
> 
>>This error is actually the expected behaviour for any timer with a 
>>resolution different from 1 nsec. I don't want to say that we can't have 
>>such a timer, but I'm not so sure whether this should be the default 
>>behaviour. I actually prefer George's earlier suggestion of CLOCK_REALTIME 
>>and CLOCK_REALTIME_HR, where one is possibly faster and the other is more 
>>precise. Even within the kernel I would prefer to map itimer and nanosleep 
>>to the first clock (maybe also based on arch/kconfig defaults).
>>OTOH if the hardware allows it, both clocks can do the same thing, but I 
>>really would like to have the possibility to give higher (and thus 
>>possibly more expensive) resolution only to those asking for it.
> 
> 
> Thats an rather odd approach for me. If we drag this further then we
> might consider that only some users (i.e. applications) of -rt patches
> are using the enhanced functionalities, which introduces interesting
> computational problems (e.g when to treat a mutex as a concurrency
> control which is capable of priority inversion or not). 

Er... what?  This is a non-compute.
> 
> I vote strongly against introducing private, special purpose APIs and I
> consider CLOCK_XXX_HR as such. The proposed hrtimer solution does not
> introduce any penalties for people who do not enable a future high
> resolution extension. It gives us the benefit of a clean code base which
> is capable to be switched simply and non intrusive to the high
> resolution mode. We have done extensive tests on the impact of
> converting all users unconditionally to high resolution mode once it is
> switched on and the penalty is within the noise range. 
> 
> You are explicitely asking for increased complexity with your approach. 

I beg to differ here.  The fact that high res timers, in general, 
require an interrupt per expiry, and that, by definition, we are 
changing the resolution by, I would guess, a couple of orders of 
magnitude implies a rather much larger over head.  If we sum this over 
all user timers it can IMHO get out of control.  Given that only a 
very small number of applications really need the extra resolution, I 
think it makes a lot of sense that those applications incur the 
overhead and others, which don't need nor want the higher resolution, 
just use the old low resolution timers.  The notion of switching this 
at configure time implies that a given kernel is going to be used ONLY 
one way or another for all applications, which, AFAICT is just not the 
way most users do things.

As to CLOCK_XXX_HR being a special purpose API, this is only half 
true.  It is a POSIX conforming extension and I do think you can find 
it used elsewhere as well.  On the other hand, it if you want to limit 
the higher overhead timers to only those who ask, well, I guess you 
could call that "special purpose".

On the complexity thing, your new organization makes the added 
"complexity" rather non-complex, in fact, you might say it is down 
right simple, for which, thank you.
> 
> 
~
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
