Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUFKWAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUFKWAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUFKWAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 18:00:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:51964 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264346AbUFKWAO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 18:00:14 -0400
Message-ID: <40CA2B49.50905@mvista.com>
Date: Fri, 11 Jun 2004 14:59:37 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Hu, Boris" <boris.hu@intel.com>
CC: ganzinger@mvista.com, drepper@redhat.com, "Li, Adam" <adam.li@intel.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] One possible bugfix for CLOCK_REALTIME timer.
References: <37FBBA5F3A361C41AB7CE44558C3448E0466695D@pdsmsx403>
In-Reply-To: <37FBBA5F3A361C41AB7CE44558C3448E0466695D@pdsmsx403>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hu, Boris wrote:
> I must miss sth in locks. Let me try to summarize all possible related
> locks here, please correct me if I miss sth or mistake it. :)
> 
> There are three locks in our situation. 
> 
> Locks					  Resource
> clock->abs_timer_lock		abs_timer_list
> 
> xtime_lock				wall_to_monotonic
> 
> timer->it_lock			timer
> 
Please note that this is a learning exercise for me too.  There are, of course, 
several ways to handle these issues.  We are trying for a relatively fast way 
through the maze, at least as far as cpu time is concerned.

Lets call them abs, xtime, and timer for short.

A word about the xtime lock.  The reason we take it is to get a coherent time. 
To do this we are required to read all the related time values at once.  We 
don't need to dispose of them (i.e. place them in our structure, compute or 
convert, etc.) while holding the lock, just grab all the bits.

The timer lock is, for this discussion, to insure continued existence of the 
timer.  Sooner or later the timer will be released back to the free memory pool...

And, for completeness, the abs lock protects the abs list structure.  If held 
for the entire clock_was_set sequence it will also serialize this.

> 
> Scenarios
> 1. Add the absolute timespec timer to the abs_timer_list
> 	1.1 copy wall_to_monotonic to timer's local
> wall_to_monotonic_copy
> 		xtime_lock 		readlock
                 (for coherence we need to get this at the same time we get the 
current time which we do in the process of calculating the expire time)
XX> 	1.2 add the timer to abs_timer_list
XX> 		abs_timer_lock   	spin_lock
XX> 		timer->it_lock   	spin_lock_irqsave???
To be more correct here, lets change the order and write it this way to show 
that one is held while the other is taken (lets also include the add_timer):
	1.2 add the timer to abs_timer_list
		timer->it_lock
			add_timer (takes the timer list lock)
			abs_timer_lock
> 
XX> 2. Update the expire value of the absolute timespec timers in
XX> abs_timer_list when the realtime clock is changed.
XX> 		xtime_lock 		readlock
XX> 		abs_timer_lock   	spin_lock
XX> 		timer->it_lock   	spin_lock_irqsave???	
This code must take the locks in the same order to avoid dead locks.  This is a 
pain as we find the timer under the abs lock and then must drop the abs lock to 
take the timer lock.  We would like to look at, possibly doing (where we depend 
on the abs list lock to keep the timer allocated):
   2. clock change
		abs_timer_lock     (also serializes clock_was_set)
			xtime_lock  (see note below)
			delete from timer list (takes the timer list lock)
				add_timer

Note, that we are taking the xtime lock.  It is needed here only because 
wall_to... is two words and, again, we want coherence of these.

Also, this code, on finding that the timer is not in the timer_list (delete 
fails) need do nothing.  It is ok to leave it in the abs list, as it will be 
removed in due course.  (We assume this can only happen if we have interrupted 
either 3 or 4 below.)

XX> 3. Delete the timer from abs_timer_list when it is expired or deleted by
XX> the user.
XX> 		abs_timer_lock   	spin_lock		
XX> 		timer->it_lock   	spin_lock_irqsave???	
Lets separate these two.
   3. timer expires
		<remove from the timer list> (timer list lock)
		timer->it_lock
			abs_timer_lock
And then we restart it...
   3.1 		timer->it_lock
			xtime_lock (get NOW and wall_to...)
			(update expire time)
			add_timer
			abs_timer_lock
   4. Delete timer (or stop it)
MUST take in the same order as above...
		timer->it_lock
			<removed from the timer list>
			abs_timer_lock

So, where are the "holes"?

a.) if the clock is set between 1.1 and 1.2, i.e. we have pegged the wall_to.. 
to the timer but do not yet have it in the abs list.  This same "hole" is in 
3.1.  I think the easy way to fix this is to recheck wall_to... WHILE HOLDING 
the abs list lock.  If it fails, update as in 2.  This does not need to be a 
while loop as long as the abs lock is held as any changes to wall_to... beyond 
this point will be serialized with clock_was_sets abs lock.  Something like:
       	abs_timer_lock
		verify (delete/ add_timer if needed)
		(add to the abs list)

b.) If a timer expires and we are "on the way" to clock_was_set, we could miss 
the need to restart it with a new time.  Once we get in clock_was_set the abs 
lock will stall the expire code, but NOT do anything as the timer is no longer 
in the list.  Both of these problems can be solved by the expire code verifying 
that the timers wall_to... is the same as the current value.  If not, and the 
change requires the timer to wait longer, restart the timer.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

