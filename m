Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311856AbSDDW5F>; Thu, 4 Apr 2002 17:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311866AbSDDW44>; Thu, 4 Apr 2002 17:56:56 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:39430 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311856AbSDDW4m>; Thu, 4 Apr 2002 17:56:42 -0500
Message-ID: <3CACD9AF.357E353A@zip.com.au>
Date: Thu, 04 Apr 2002 14:54:39 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Roger Larsson <roger.larsson@norran.net>, Robert Love <rml@tech9.net>,
        Dave Hansen <haveblue@us.ibm.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() atboot  
 time
In-Reply-To: <3CACD5D3.B2DA02AE@zip.com.au> <Pine.LNX.4.33.0204041440520.15947-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 4 Apr 2002, Andrew Morton wrote:
> >  Another approach would be:
> >
> > preempt_schedule()
> > {
> >       current->state2 = current->state;
> >       current->state = TASK_RUNNING;
> >       schedule();
> >       current->state = current->state2;
> > }
> 
> Yes, but please no.
> 
> My current tree says
> 
>         asmlinkage void preempt_schedule(void)
>         {
>                 if (unlikely(preempt_get_count()))
>                         return;
>                 if (current->state != TASK_RUNNING)
>                         return;
>                 schedule();
>         }
> 
> and if people start getting latency problems due to loops with state !=
> TASK_RUNNING, then I suspect we might just make "set_current_state()"
> check that case explicitly and do a conditional reschedule (ie make it the
> same as if we released a lock). That would be a hell of a lot cleaner, in
> my opinion.
> 

That would work.  And would also fix my "spin_unlock sometimes
stomps on TASK_INTERRUPTIBLE" problem.

It does mean that we'll need to convert many open-coded

	current->state = whatever;

instances to use [__]set_current_state().  But that's not
a bad thing.  Janitorial patches for this are already
floating about.

Robert, do you have time to do the code-and-test thing?

-
