Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131549AbRABTeC>; Tue, 2 Jan 2001 14:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131600AbRABTdw>; Tue, 2 Jan 2001 14:33:52 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:21508 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131549AbRABTdl>; Tue, 2 Jan 2001 14:33:41 -0500
Date: Tue, 2 Jan 2001 11:02:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Anton Blanchard <anton@linuxcare.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: scheduling problem?
In-Reply-To: <Pine.Linu.4.10.10101021542460.648-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.10.10101021057040.25012-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2001, Mike Galbraith wrote:
> 
> Yes and no.  I've seen nasty stalls for quite a while now.  (I think
> that there is a wakeup problem lurking)
> 
> I found the change which triggers my horrid stalls.  Nobody is going
> to believe this...

Hmm.. I can believe it. The code that waits on bdflush in wakeup_bdflush()
is somewhat suspicious. In particular, if/when that ever triggers, and
bdflush() is busy in flush_dirty_buffers(), then the process that is
trying to wake bdflush up is going to wait until flush_dirty_buffers() is
done. 

Which, if there is a process dirtying pages, can basically be
pretty much forever.

This was probably hidden by the lower limits simply by virtue of bdflush
never being very active before.

What does the system feel like if you just change the "sleep for bdflush"
logic in wakeup_bdflush() to something like

	wake_up_process(bdflush_tsk);
	__set_current_state(TASK_RUNNING);
	current->policy |= SCHED_YIELD;
	schedule();

instead of trying to wait for bdflush to wake us up?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
