Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbTBTSxb>; Thu, 20 Feb 2003 13:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266749AbTBTSxb>; Thu, 20 Feb 2003 13:53:31 -0500
Received: from mx1.elte.hu ([157.181.1.137]:24214 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S266718AbTBTSx3>;
	Thu, 20 Feb 2003 13:53:29 -0500
Date: Thu, 20 Feb 2003 20:00:26 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302200949520.1385-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302201958370.1446-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Linus Torvalds wrote:

> > a true heisenbug. I cannot reproduce it anymore. Anyway, from the serial
> > console i collected 3 instances of crashes - whatever it's worth.
> 
> Pretty much every single time, release_task() has been there on the
> backtrace.
> 
> In fact, I bet you this code in do_exit() is the cause:
> 
>         preempt_disable();
> 
>         if (tsk->exit_signal == -1)
> ***             release_task(tsk);	***
> 
>         schedule();
> 
> Note how "release_task()" will be releasing the stack that the process
> is running on right now. [...]

but, release_task() is a delayed thing for exactly this reason. It fills
out the per-CPU task_cache but does not free the task.

the release_task() + schedule() must be atomic though - ie. we must not be
preempted anytime inbetween [because that other task could free the
task_cache] - but i wasnt running with CONFIG_PREEMPT, so i cannot see how
it could happen.

	Ingo

