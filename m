Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311866AbSDDXJr>; Thu, 4 Apr 2002 18:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSDDXJh>; Thu, 4 Apr 2002 18:09:37 -0500
Received: from zero.tech9.net ([209.61.188.187]:60425 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S311866AbSDDXJU>;
	Thu, 4 Apr 2002 18:09:20 -0500
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
	boot  time
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Roger Larsson <roger.larsson@norran.net>,
        Dave Hansen <haveblue@us.ibm.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204041440520.15947-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 18:07:47 -0500
Message-Id: <1017961694.23629.649.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 17:42, Linus Torvalds wrote:

> My current tree says
> 
> 	asmlinkage void preempt_schedule(void)
> 	{
> 	        if (unlikely(preempt_get_count()))
> 	                return;
> 	        if (current->state != TASK_RUNNING)
> 	                return;
> 	        schedule();
> 	}

You need to do the same thing in entry.S ... Ingo decoupled the two
entry paths from each other (entry.S does preempt_schedule's work on its
own, and then directly calls schedule).

So, right now the ret_from_intr path sets the task state to
TASK_RUNNING.  That needs to be replaced with a jump out if it is NOT
task running.

Curiously, what is wrong with the way we did it in the original patch? 
I.e. set a bit in preempt_count and use that to skip to pick_next_task
in schedule.  This allows us to preempt any task of any state ...

	Robert Love

