Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbTBJPQa>; Mon, 10 Feb 2003 10:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTBJPQa>; Mon, 10 Feb 2003 10:16:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2053 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262452AbTBJPQ3>; Mon, 10 Feb 2003 10:16:29 -0500
Date: Mon, 10 Feb 2003 07:22:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <Pine.LNX.4.44.0302100951540.2724-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302100720020.2127-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Feb 2003, Ingo Molnar wrote:
> 
> > Interesting. Especially as the last thing exit_notify() does (just a few
> > lines above the schedule()) is to do
> > 
> >         tsk->state = TASK_ZOMBIE;
> > 
> > and that schedule() _really_ really shouldn't return. Regardless of any
> > signal handler changes.
> 
> the proper way to avoid such scenarios (besides removing tasks from all
> waitqueues) is to remove the thread from all the PID-hashes prior setting
> it to TASK_ZOMBIE.

Not a good idea.

We still want to find zombie processes, since they show up in "ps"  
listings etc. And I don't think sending a signal to a zombie process
should return ESRCH, since it's there.

Btw, I fixed it by making all wake-up events give a mask of which states 
can be woken up. That's really what SIGCONT wanted anyway (only wake up 
stopped tasks), _and_ it's what default_wake_function() really wanted.

		Linus

