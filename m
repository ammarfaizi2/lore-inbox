Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267138AbTBIByE>; Sat, 8 Feb 2003 20:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267141AbTBIByE>; Sat, 8 Feb 2003 20:54:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37646 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267138AbTBIByD>; Sat, 8 Feb 2003 20:54:03 -0500
Date: Sat, 8 Feb 2003 18:00:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Anton Blanchard <anton@samba.org>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <20030209005737.GD20110@krispykreme>
Message-ID: <Pine.LNX.4.44.0302081754340.5231-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Feb 2003, Anton Blanchard wrote:
> 
> From BK late last night (has everything except the most recent 2
> sound changesets)
> 
> kernel BUG at kernel/exit.c:710!
> 
> which is:
> 
> do_exit()
> ...
>         schedule();
>         BUG();
>         /* Avoid "noreturn function does return".  */
>         for (;;) ;
> }
> 
> Oops. In a police lineup Id finger the signal changes.

Interesting. Especially as the last thing exit_notify() does (just a few 
lines above the schedule()) is to do

        tsk->state = TASK_ZOMBIE;

and that schedule() _really_ really shouldn't return. Regardless of any 
signal handler changes.

By then we also have local interrupts disabled, and we've explicitly 
disabled preemption, so I don't see how anything could ever wake us up any 
more. 

But yes, I'd agree with your line-up, if for no other reason than the fact 
that I don't really see anything else even _remotely_ likely to muck 
around with process state.

I don't see this (obviously), but could you make "try_to_wake_up()" (in 
kernel/sched.c) do a

	BUG_ON(p->state & TASK_ZOMBIE);

to see if somebody tries to wake up a zombie task (maybe the signal 
handler stuff does that under some unlucky circumstances).

And then the call trace would be very interesting indeed if the above bug 
triggers.. (and unlike the do_exit() bug, the tri_to_wake_up() thing 
should clearly pinpoint where the problem actually happens, knock wood).

		Linus

