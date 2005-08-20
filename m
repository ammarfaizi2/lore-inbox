Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVHTHVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVHTHVH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 03:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVHTHVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 03:21:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:33787 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932097AbVHTHVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 03:21:06 -0400
Message-ID: <4306891E.9060409@mvista.com>
Date: Fri, 19 Aug 2005 18:36:30 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>
Subject: Re: [PATCH 2.6.13-rc6-rt9]  PI aware dynamic priority adjustment
References: <20050818060126.GA13152@elte.hu>	 <1124495303.23647.579.camel@tglx.tec.linutronix.de>	 <43067713.4040700@mvista.com> <1124498172.23647.606.camel@tglx.tec.linutronix.de>
In-Reply-To: <1124498172.23647.606.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> George,
> 
> On Fri, 2005-08-19 at 17:19 -0700, George Anzinger wrote:
> 
>>>2. Drift of cyclic timers (armed by set_timer()):
>>>
>>>Due to rounding errors and the drift adjustment code, the fixed
>>>increment which is precalculated when the timer is set up and added on
>>>rearm, I see creeping deviation from the timeline. 
>>>
>>>I have a patch lined up to base the rearm on human (nsac) units, so this
>>>effect will go away. But this is waste of time until (1.) is not solved.
>>>
>>>George ???
>>
>>Could I (we) see what you have in mind?
> 
> 
> Nothing which applies clean at the moment and I have no access to the
> box where the patch floats around.
> 
> It's simply explained.
> 
> Current code:
> 
> set_timer()
> 	calc interval->jiffies / interval->arch_cycles;
> 	based on it.interval
> 
> rearm()
> 	timer->expires += interval->jiffies;
> 	timer->arch_cycle_expires += interval->arch_cycles;
> 	normalize(timer);
> 
> Patched code:
> 
> set_timer()
> 	timer.interval = it.interval; 
> 	timer.next_expire = it.value; 
> 	both stored as timespec
> 
> rearm()
> 	next_expire += interval;
> 	calc timer->expires/arch_cycle_expires;
> 	
> So on each rearm we eliminate the rounding errors and take the drift
> adjustment into account.
> 
> It adds some calculation overhead to each rearm, but ....
> 
I think the standard was written to eliminate the need for this.  The 
notion is that we have a resolution which we use in the calculations so 
while there may be drift WRT his request, there should be no drift WRT 
the requested value rounded up to the next resolution.

Still, if we can't keep that resolution in arch_cycles...

On another issue along this line, I have been thinking of changing the 
x86 TSC arch cycle size to 1ns.  (NOT the resolution, the units for the 
arch cycle.)  The reason to do this is to correctly track changes in cpu 
frequency as it is today, we would need to track down and update all 
pending HR timers when ever the frequency changed.  By using a common 
unit all we need to do is change the conversion constants (well I guess 
they would not be constants any more :).  I REALLY don't want to do this 
as it does add conversion overhead, but I can not think of another clean 
way to track TSC frequency changes.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
