Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVD0ARS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVD0ARS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 20:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVD0ARS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 20:17:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41723 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261861AbVD0ARF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 20:17:05 -0400
Message-ID: <426ED97B.4050204@mvista.com>
Date: Tue, 26 Apr 2005 17:14:51 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dwalker@mvista.com
CC: ganzinger@mvista.com, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: del_timer_sync needed for UP  RT systems.
References: <426ED1EC.80500@mvista.com> <1114559749.12773.67.camel@dhcp153.mvista.com>
In-Reply-To: <1114559749.12773.67.camel@dhcp153.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> Basically , there is a race condition in sys_timer_delete() and
> posix_timer_event() .
> 
>>From sys_timer_delete() :
> 
>    /*
> 	 * This keeps any tasks waiting on the spin lock from thinking
> 	 * they got something (see the lock code above).
> 	 */
> 	if (timer->it_process) {
> 		if (timer->it_sigev_notify ==
> (SIGEV_SIGNAL|SIGEV_THREAD_ID))
> 			put_task_struct(timer->it_process);
> 		timer->it_process = NULL;
> 	}
> 	unlock_timer(timer, flags);
> 	/* Preemption happens here. */
> 	release_posix_timer(timer, IT_ID_SET);
> 
> 
> So when the timer is getting triggered , right before it takes the timer
> lock, preemption happens. You finish the code above. Then your preempted
> again right after unlock timer, shown above.
> 
> At this point, your triggering a timer that is half deleted, in posix_timer_fn() .
> timer->it_process = NULL , so when you try to send the signal to the
> timer owner you crash with an OOPS , cause the timer owner was just set
> to NULL.
> 
> George, at least CC me, after all I found/documented this bug ..

Sorry, my bad :(
> 
> Preliminary fix included ..
> 
> Daniel
> 
> On Tue, 2005-04-26 at 16:42, George Anzinger wrote:
> 
>>Ingo,
>>
>>In tracking down the failure of a system running the RT patch we have found a 
>>preemption between the time run_timer_list clears its spinlock and the call back 
>>function (in this case in posix-timers.c) gets its spinlock.  The bad news is 
>>that it is possible for the timer to be released at this point leaving the call 
>>back code with a pointer to a bogus timer.
>>
>>This was/is possible, of course, in SMP systems and is why del_timer_sync() 
>>exists.  I suspect that del_timer_sync() needs to also do the "right thing" in 
>>UP RT systems.
>>
>>This means removing the #ifdef CONFIG_SMP at about line 56 of kernel/timer.c 
>>thus setting up base->running_timer in all cases (or at least in SMP and RT 
>>cases) and also the #ifdef CONFIG_SMP around del_timer_sync() and, of course, 
>>the defines that redirect calls to these functions.
>>
>>Does this make sense?
>>
>>
>>------------------------------------------------------------------------
>>
>>Source: MontaVista Software, Inc.
>>MR: 11506 
>>Type: Defect Fix
>>Disposition: needs submitting to LKML 
>>Signed-off-by: Daniel Walker <dwalker@mvista.com>
>>Description:
>>	Ok, so here is the run down.. Basically , there is a race condition in
>>sys_timer_delete() and posix_timer_event() .
>>
>>>From sys_timer_delete() :
>>		timer->it_process = NULL;
>>	}
>>	unlock_timer(timer, flags);
>>	/* Preemption happens here. */
>>	release_posix_timer(timer, IT_ID_SET);
>>
>>
>>So when the timer is getting triggered , right before it takes the timer
>>lock, preemption happens. You finish the code above. Then your preempted
>>again right after unlock timer, shown above.
>>
>>At this point, your triggering a timer that is half deleted, in posix_timer_fn() .
>>timer->it_process = NULL , so when you try to send the signal to the
>>timer owner you crash with an OOPS , because the timer owner was just set
>>to NULL.
>>
>>Index: linux-2.6.10/kernel/posix-timers.c
>>===================================================================
>>--- linux-2.6.10.orig/kernel/posix-timers.c	2005-04-26 17:38:25.000000000 +0000
>>+++ linux-2.6.10/kernel/posix-timers.c	2005-04-26 17:53:54.000000000 +0000
>>@@ -433,6 +433,14 @@ exit:
>> 
>> int posix_timer_event(struct k_itimer *timr,int si_private)
>> {
>>+	/*
>>+	 * If it_process is NULL then this timer is
>>+	 * in the process of being deleted. At this
>>+	 * point we can't do very much. So we
>>+	 * try to return gracefuly.
>>+	 */
>>+	if (timr->it_process == NULL) return 1;
>>+
>> 	memset(&timr->sigq->info, 0, sizeof(siginfo_t));
>> 	timr->sigq->info.si_sys_private = si_private;
>> 	/*
The problem here is that the reference is to timr, a pointer to something which 
has been deleted.  The memory may well be used elsewhere by this time which will 
make the test of it_process wrong.  It also means we could mess with someone 
elses memory in the memset above.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
