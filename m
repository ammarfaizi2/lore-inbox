Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311211AbSDDTvF>; Thu, 4 Apr 2002 14:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311262AbSDDTu4>; Thu, 4 Apr 2002 14:50:56 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:24313 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S311211AbSDDTut>;
	Thu, 4 Apr 2002 14:50:49 -0500
Message-ID: <3CACAE05.5422E3B0@mvista.com>
Date: Thu, 04 Apr 2002 11:48:22 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dave Hansen <haveblue@us.ibm.com>, "Adam J. Richter" <adam@yggdrasil.com>,
        linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() atboot 
 time
In-Reply-To: <Pine.LNX.4.33.0204041108040.12895-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 4 Apr 2002, Dave Hansen wrote:
> >
> > I've diabled preemption in the area where it used to be disabled because
> > of the old lock_kernel().  I'm sending this message from a machine with
> > that patch applied, so the patch does fix it.
> 
> I think the real fix is to make sure that preemption never hits while
> current->state == TASK_ZOMBIE.
> 
> In other words, I think the _correct_ fix is to just make
> preempt_schedule() check for something like
> 
>         if (current->state != TASK_RUNNING)
>                 return;
> 
I agree that the set state to running code should go, but there are
places in the kernel where a great deal of time is spent with the state
other than running.  AND most of them make sense.  Adding a PREEMPTING
super state, as was in the original patch, addressed this quite well
IMHO.  This super state was treated by the scheduler as RUNNING
regardless of the actual state.  As long as it is not in the actual
"state" member, the condition waited for can still set the true state to
RUNNING and all is well.

What is the objection to this?

> and just getting rid of the current "unconditionally set state to
> running".
> 
> (Side note: if the state isn't running, we're most likely going to
> reschedule in a controlled manner soon anyway. Sure, there are some loops
> which set state to non-runnable early for race avoidance, but is it a
> _problem_?)
> 
All I can say is that we thought it was when we did the original
preemption work.  Some of those loops are long.

I tend to agree with not doing the random "set state to running".  It
breeds paranoia, and rightly so.

And yes the ZOMBIE code must not be preempted.  This is one of the
reasons the preempt code was designed to allow schedule() to be called
with preemption disabled.  I gives a nice clean schedule() call.  It
might be a better solution than the interrupt off schedule() calls made
in the sleep calls in sched.c.

>                 Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
