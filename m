Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262586AbRE3C5X>; Tue, 29 May 2001 22:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262585AbRE3C5N>; Tue, 29 May 2001 22:57:13 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:26543 "EHLO
	c0mailgw12.prontomail.com") by vger.kernel.org with ESMTP
	id <S262584AbRE3C4z>; Tue, 29 May 2001 22:56:55 -0400
Message-ID: <3B146125.77845217@mvista.com>
Date: Tue, 29 May 2001 19:55:33 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ivan Schreter <is@zapwerk.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched_yield in 2.2.x
In-Reply-To: <01053002030500.01197@linux>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Schreter wrote:
> 
> Hello,
> 
> I'm not subscribed, so eventual replies please CC: to me (is@zapwerk.com).
> 
> Here is a 2-line patch that fixes sched_yield() call to actually really yield
> the processor in 2.2.x kernels. I am using 2.2.16 and so have tested it in
> 2.2.16 only, but I suppose it should work with other kernels as well (there
> seem not to be so many changes).
> 
> Bug description: When a process called sched_yield() it was properly marked for
> reschedule and bit SCHED_YIELD for reschedule was properly set in p->policy.
> However, prev_goodness() cleared this bit returning goodness 0 (I changed it to
> -1 just to be sure this process isn't accidentally picked when there is other
> process to run - maybe I'm wrong here, but 2.4.5 gives it also goodness -1, so
> it should be OK). This was not that bad, but successive calls to goodness()

The -1 is better than 0 since 0 will trigger a recalc if no other tasks
have any time left.  (Or do you want this to happen?  As you have it,
the yielding task will get control if all other tasks in the run list
have zero counters.  Seems like the recalculation should happen to find
a better candidate.)

The real problem with this patch is that if a real time task yields, the
patch will cause the scheduler to pick a lower priority task or a
SCHED_OTHER task.  This one is not so easy to solve.  You want to scan
the run_list in the proper order so that the real time task will be the
last pick at its priority.  Problem is, the pre load with the prev task
is out of order.  You might try: http://rtsched.sourceforge.net/

> while searching for next process to run included last process, which had
> meanwhile YIELD bit cleared and thus it's goodness value was calculated as
> better. And we come to second line of the fix - do not consider prev process in
> searching for next process to run, as it is anyway already selected as next by
> default when no better process is found.
> 
> I hope that it will work in SMP environment as well (it should, since
> schedule() seems to be mostly independent of UP/SMP).
> 
> And why do I want to use sched_yield()? Well, to implement user-space
> longer-duration locks which don't consume the whole timeslice when waiting, but
> rather relinquish processor to other task so it finishes it's work in critical
> region sooner.
> 
> It's funny nobody has fixed this by now, but as I've seen there were couple
> of discussion about sched_yield() already... I come probably too late...
> 
> Ivan Schreter
> is@zapwerk.com
> 
>   ------------------------------------------------------------------------
>                        Name: sched_patch.diff
>    sched_patch.diff    Type: Plain Text (text/plain)
>                    Encoding: base64
