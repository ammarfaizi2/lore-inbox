Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264265AbSIQPeu>; Tue, 17 Sep 2002 11:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264266AbSIQPeu>; Tue, 17 Sep 2002 11:34:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15110 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264265AbSIQPet>; Tue, 17 Sep 2002 11:34:49 -0400
Date: Tue, 17 Sep 2002 08:40:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <Pine.LNX.4.44.0209170823130.3942-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209170834210.4144-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Sep 2002, Linus Torvalds wrote:
> 
> I really think we need this to have a stable system. Alan still thinks 
> preempt is unstable, and this helps counter some of that - by adding 
> sanity checks that all the counters are doing the right thing.

That said, the exit() crap does end up being a bit unreadable.  How about
just splitting up schedule() into the "normal schedule" and the "exit()"  
case. In particular, there are a few other things that are illegal for 
the non-exit case anyway, and that we migth as well check for. There are 
also potentially things we might want to do in the exit case that we don't 
want to do in the hot-path.

So we could just rename the current core "schedule()" functionality as
"static void do_schedule()", and then have

	void schedule(void)
	{
		BUG_ON(in_atomic());
		BUG_ON(current->state & TASK_ZOMBIE);
		do_schedule();
	}

	void exit_schedule(void)
	{
		BUG_ON(!(current->state & TASK_ZOMBIE));
		do_schedule();
	}

which is simpler than playing games with preempt_count == -2, and also 
allows us more sanity checking than we have right now (the TASK_ZOMBIE 
thing is also a exit-specific thing, and there may well be others too).

		Linus

