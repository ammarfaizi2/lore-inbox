Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132230AbRACFqj>; Wed, 3 Jan 2001 00:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132242AbRACFqU>; Wed, 3 Jan 2001 00:46:20 -0500
Received: from www.wen-online.de ([212.223.88.39]:23812 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S132230AbRACFqP>;
	Wed, 3 Jan 2001 00:46:15 -0500
Date: Wed, 3 Jan 2001 05:48:01 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Anton Blanchard <anton@linuxcare.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: scheduling problem?
In-Reply-To: <Pine.LNX.4.10.10101021057040.25012-100000@penguin.transmeta.com>
Message-ID: <Pine.Linu.4.10.10101030546500.1057-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Linus Torvalds wrote:

> On Tue, 2 Jan 2001, Mike Galbraith wrote:
> > 
> > Yes and no.  I've seen nasty stalls for quite a while now.  (I think
> > that there is a wakeup problem lurking)
> > 
> > I found the change which triggers my horrid stalls.  Nobody is going
> > to believe this...
> 
> Hmm.. I can believe it. The code that waits on bdflush in wakeup_bdflush()
> is somewhat suspicious. In particular, if/when that ever triggers, and
> bdflush() is busy in flush_dirty_buffers(), then the process that is
> trying to wake bdflush up is going to wait until flush_dirty_buffers() is
> done. 
> 
> Which, if there is a process dirtying pages, can basically be
> pretty much forever.
> 
> This was probably hidden by the lower limits simply by virtue of bdflush
> never being very active before.
> 
> What does the system feel like if you just change the "sleep for bdflush"
> logic in wakeup_bdflush() to something like
> 
> 	wake_up_process(bdflush_tsk);
> 	__set_current_state(TASK_RUNNING);
> 	current->policy |= SCHED_YIELD;
> 	schedule();
> 
> instead of trying to wait for bdflush to wake us up?

No difference (except more context switching as expected)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
