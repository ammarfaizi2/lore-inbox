Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311756AbSDDWny>; Thu, 4 Apr 2002 17:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311782AbSDDWno>; Thu, 4 Apr 2002 17:43:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21774 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311756AbSDDWnb>; Thu, 4 Apr 2002 17:43:31 -0500
Date: Thu, 4 Apr 2002 14:42:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Roger Larsson <roger.larsson@norran.net>, Robert Love <rml@tech9.net>,
        Dave Hansen <haveblue@us.ibm.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
 boot  time
In-Reply-To: <3CACD5D3.B2DA02AE@zip.com.au>
Message-ID: <Pine.LNX.4.33.0204041440520.15947-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Apr 2002, Andrew Morton wrote:
>  Another approach would be:
> 
> preempt_schedule()
> {
> 	current->state2 = current->state;
> 	current->state = TASK_RUNNING;
> 	schedule();
> 	current->state = current->state2;
> }

Yes, but please no.

My current tree says

	asmlinkage void preempt_schedule(void)
	{
	        if (unlikely(preempt_get_count()))
	                return;
	        if (current->state != TASK_RUNNING)
	                return;
	        schedule();
	}

and if people start getting latency problems due to loops with state != 
TASK_RUNNING, then I suspect we might just make "set_current_state()" 
check that case explicitly and do a conditional reschedule (ie make it the 
same as if we released a lock). That would be a hell of a lot cleaner, in 
my opinion.

		Linus

