Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTDKHEf (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 03:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbTDKHEf (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 03:04:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62959 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264303AbTDKHEe (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 03:04:34 -0400
Message-ID: <3E966BAA.804@mvista.com>
Date: Fri, 11 Apr 2003 00:15:54 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 kernel/timer.c may incorrectly reenable interrupts
References: <24294.1050043625@kao2.melbourne.sgi.com>
In-Reply-To: <24294.1050043625@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 2.4.20 kernel/timer.c
> 
> static inline void update_times(void)
> {
> 	unsigned long ticks;
> 
> 	/*
> 	 * update_times() is run from the raw timer_bh handler so we
> 	 * just know that the irqs are locally enabled and so we don't
> 	 * need to save/restore the flags of the local CPU here. -arca
> 	 */
> 	write_lock_irq(&xtime_lock);
> 	vxtime_lock();
> 
> 	ticks = jiffies - wall_jiffies;
> 	if (ticks) {
> 		wall_jiffies += ticks;
> 		update_wall_time(ticks);
> 	}
> 	vxtime_unlock();
> 	write_unlock_irq(&xtime_lock);
> 	calc_load(ticks);
> }
> 
> I hit one case when the routine was called with interrupts disabled and
> it unconditionally enabled them, with nasty side effects.  Code fragment
> 
>   local_irq_save();
>   local_bh_disable();
>   ....
>   local_bh_enable();
>   local_irq_restore();
> 
> local_bh_enable() checks for pending softirqs, finds that there is an
> outstanding timer bh and runs it.  do_softirq() -> tasklet_hi_action()
> -> bh_action() -> timer_bh() -> update_times() which unconditionally
> reenables interrupts.  Then the timer code issued cli(), because
> interrupts were incorrectly reenabled it tried to get the global cli
> lock and hung.

If you look at do_softirq() you will see that it enables irqs 
unconditionally while calling pending functions.  It does, however, 
save the irq on entry and restore it on exit (seems strange eh).
> 
> There is no documentation that defines the required nesting order of
> local_irq and local_bh.  Even if the above code fragment is deemed to
> be illegal, there are uses of local_bh_enable() all through the kernel,
> it will be difficult to prove that none of them are called with
> interrupts disabled.  If there is any chance that local_bh_enable() is
> called with interrupts off, update_times() is wrong.

IMHO, update_times() is right!  The code fragment you found is wrong. 
  If there is a real need we could code up a check to see if 
local_bh_enable() is called with interrupts off.

As machines get faster and faster, it will be come more and more of a 
burden to "stop the world" and sync with the interrupt system, which 
is running at a much slower speed.  This is what the cli / sti/ 
restore flags causes.  I saw one test where the time to do the cli was 
as long as the run_timer_list code, for example.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

