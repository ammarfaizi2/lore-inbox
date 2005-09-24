Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVIXCn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVIXCn2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 22:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbVIXCn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 22:43:28 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:41409 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751367AbVIXCn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 22:43:28 -0400
Date: Sat, 24 Sep 2005 04:43:14 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <1127464041.24044.809.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0509232258270.3728@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0509201247190.3743@scrub.home>  <1127342485.24044.600.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0509221816030.3728@scrub.home> <1127464041.24044.809.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Sep 2005, Thomas Gleixner wrote:

> Each network connection, each disk I/O operation arms a timeout timer to
> cover error conditions. Increasing the load on those increases the
> number of armed timers. At the same time this increased load keeps the
> timers longer active as it takes more time to detect that the "good"
> condition arrived on time.

You're still rather vague here...
Anyway, if the amount of active timer should be a problem, there are ways 
to avoid them. For disk io it's rather simple as the timeout is mostly 
constant:

start i/o:
	req->expire = jiffies + timeout;
	list_add_tail(req->list, &timeout_list);
	if (!timer_pending(timer)) {
		timer->expire = req->expire;
		add_timer(timer);
	}

timeout function:
	req = list_head(&timeout_list);
	if (time_after_eq(req->expire, jiffies)) {
		// error...
	} else {
		timer->expire = req->expire;
		add_timer(timer);
	}

Network timer are a bit more difficult as the timeouts are more dynamic, 
but one can at least delay arming the timer in most cases, by running a 
timer every x ticks:

start timer:
	if (timeout < x)
		add_timer();
	else
		list_add_tail();

timer function:
	list_for_each_entry()
		add_timer();

Should the action be successfull before the timer runs, it only needs to 
remove it from the private list.


> Admittedly everything which is dealing with aspects of time is related,
> but it can and must be seperated into different subsystems, which make
> use of the provided interfaces.
> 
> 1. Time tick
> 
> 	- constant frequency tick
> 	
> 	Provides interface for:
> 	reading the current tick count
> 
> 2. Time of day
> 
> 	- handles frequency adjustments of the timesource
> 	- keeps track of monotonic time
> 	- provides the representation of wall clock time
> 	- handles the adjustment of wall clock time
> 
> 	Provides interfaces for:
> 	reading monotonic time
> 	reading wallclock time
> 	adjusting the frequency of the time source
> 	setting wallclock time
> 
> 
> 	Makes possibly use of the interface:
> 	(Depends on the availability of time sources)
> 	time tick:read tick count
> 
> 3. Timeout API
> 
> 	- Time tick based timer handling
> 	- Solely used for in kernel purposes
> 
> 	Provides interfaces for:
> 	adding timers
> 	modifying timers
> 	deleting timers
> 
> 	Makes use of the interface:
> 	time tick:read tick count
> 
> 4. Timer API
> 
> 	- monotonic clock based timers
> 	- realtime (wallclock) clock based timers
> 	- Mainly intended for application timers
> 
> 	Provides interfaces for:
> 	adding timers
> 	modifying timers
> 	deleting timers
> 	
> 	Makes use of the interfaces:
> 	timeofday: read monotonic time	
> 	timeofday: read wallclock time	
> 
> So we have four seperate building blocks related to time, but clearly
> seperated.

First, please don't say API if you talk about subsystems, it's not the 
same. APIs are part of a subsystem and describe the relationships between 
subsystems. I think that caused a major part of the confusion.


I don't completely agree with your picture above and while these 
subsystems are mostly separate, they are not independent:

current dependencies:

	1. time source ---> 2. wallclock    ---> 4. process timer
	                \-> 3. kernel timer -/

We have currently a very simple time source, which just provides a 
nonprogrammable timer interrupt. Process timer are limited in their 
(programmable) resolution to kernel.

This maybe also explains better the 3 types of time I mentioned (or 
domains if you prefer):
- wallclock time: NTP controlled, only readable and not programmable
- scheduler time: monotonic and unsynchronized, readable and programmable 
  in HZ resolution
- process time: derived from the first two.

Johns work now (hopefully) integrates wallclock functionality into the 
time source:

	time source ---> wallclock time
	ntp library -/

This means the NTP code becomes a library which can be used by the time 
source to provide a synchronized wallclock time.

The next step would be to make the time source programmable, so that we 
can get rid of the kernel timer dependency from the process timer:

	time source ---> kernel timer
	             \-> process timer

In this context the main functionality of your patch now finally becomes 
understandable: making process timer independent of kernel timer. This 
never became clear from your announcement, it talks about a lot of 
unrelated problems, but it never gets to the actual problem.

bye, Roman
