Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVLMB0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVLMB0x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 20:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVLMB0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 20:26:53 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:44010 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1751010AbVLMB0x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 20:26:53 -0500
Message-ID: <439E2308.1000600@mvista.com>
Date: Mon, 12 Dec 2005 17:25:28 -0800
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
References: <20051206000126.589223000@tglx.tec.linutronix.de>	 <Pine.LNX.4.61.0512061628050.1610@scrub.home>	 <1133908082.16302.93.camel@tglx.tec.linutronix.de>	 <Pine.LNX.4.61.0512070347450.1609@scrub.home>	 <1134148980.16302.409.camel@tglx.tec.linutronix.de>	 <Pine.LNX.4.61.0512120007010.1609@scrub.home> <1134405768.4205.190.camel@tglx.tec.linutronix.de>
In-Reply-To: <1134405768.4205.190.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
~
> 
> 
>>I wouldn't say a 1 day interval timer is a very realistic example and the 
>>old timer wouldn't be very precise for this.
> 
> 
> Sure, as all comparisons are flawed. I just used a simple example to
> illustrate my POV.
> 
> 
>>The rationale for example talks about "a periodic timer with an absolute 
>>_initial_ expiration time", so I could also construct a valid example with 
>>this expectation. The more I read the spec the more I think the current 
>>behaviour is not correct, e.g. that ABS_TIME is only relevant for 
>>it_value.
>>So I'm interested in specific interpretations of the spec which support 
>>the current behaviour.

My $0.02 worth: It is clear (from the standard) that the initial time 
is to be ABS_TIME.  It is also clear that the interval is to be added 
to that time.  IMHO then, the result should have the same property, 
i.e. ABS_TIME.  Sort of like adding an offset to a relative address. 
The result is still relative.
> 
> 
> Unfortunately you find just the spec all over the place. I fear we have
> to find and agree on an interpretation ourself.
> 
> I agree, that the restriction to the initial it_value is definitely
> something you can read out of the spec. But it does not make a lot of
> sense for me. Also the restriction to TIMER_ABSTIME is somehow strange
> as it converts an CLOCK_REALTIME timer to a CLOCK_MONOTONIC timer. I
> never understood the rationale behind that.

I don't think it really does that.  The TIMER_ABSTIME flag just says 
that the time requested is to be taken as "clock" time (which ever 
clock) AND that this is to be the expire time regardless of clock 
setting.  We, in an attempt to simplify the lists, convert the expire 
time into some common time notation (in most cases we convert relative 
times to absolute times) but this introduces problems because the 
caller has _asked_ for a relative or absolute time and not the other. 
  If the clock can not be set this is not a problem.  If it can, well, 
we need to keep track of what the caller wanted, absolute or relative.

It might help others to understand this if you were to remove the 
clock names from your queues and instead call them "absolute_real" and 
"up_time".  Then it would be more clear, I think, that we are mapping 
user requests onto these queues based on the desired functionality 
without a predilection to put a timer on a given queue just because a 
particular clock was requested.  At this point it becomes clear, for 
example, that a TIMER_ABSTIME request on the real clock is the _only_ 
request that should be mapped to the "absolute_real" list.
> 
~
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
