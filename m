Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSDDWko>; Thu, 4 Apr 2002 17:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311756AbSDDWkf>; Thu, 4 Apr 2002 17:40:35 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:26639 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311752AbSDDWkV>; Thu, 4 Apr 2002 17:40:21 -0500
Message-ID: <3CACD5D3.B2DA02AE@zip.com.au>
Date: Thu, 04 Apr 2002 14:38:11 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@norran.net>
CC: Robert Love <rml@tech9.net>, Linus Torvalds <torvalds@transmeta.com>,
        Dave Hansen <haveblue@us.ibm.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at boot 
 time
In-Reply-To: <Pine.LNX.4.33.0204041113410.12895-100000@penguin.transmeta.com> <1017948383.22303.537.camel@phantasy> <200204042334.04367.roger.larsson@norran.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson wrote:
> 
> ...
> How about doing:
> 
> asmlinkage void preempt_schedule(void)
> {
>         unsigned long saved_state;
> 
>         if (unlikely(preempt_get_count()))
>                 return;
> 
>         preempt_disable(); /* or use an atomic operation */
>         saved_state = current->state;
>         current->state = TASK_RUNNING;
>         preempt_enable_no_resched(); /* we are scheduling anyway... */
>         schedule();

Interrupt occurs, puts this task in state TASK_RUNNING.

>         current->state = saved_state;

whoops.  We went back into TASK_UNINTERRUPTIBLE.

> }
> 

We could fix this with changes to schedule(), but that's
not nice.   Another approach would be:

preempt_schedule()
{
	current->state2 = current->state;
	current->state = TASK_RUNNING;
	schedule();
	current->state = current->state2;
}

and wake_up() would do:

	tsk->state = TASK_RUNNING;
	tsk->state2 = TASK_RUNNING;

With the appropriate locking, memory barriers and other
relevant goo I think this would work...

-
