Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131512AbRABUlT>; Tue, 2 Jan 2001 15:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131468AbRABUlK>; Tue, 2 Jan 2001 15:41:10 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13578 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131717AbRABUk3>; Tue, 2 Jan 2001 15:40:29 -0500
Date: Tue, 2 Jan 2001 21:09:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Anton Blanchard <anton@linuxcare.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: scheduling problem?
Message-ID: <20010102210949.C7563@athlon.random>
In-Reply-To: <Pine.Linu.4.10.10101021542460.648-100000@mikeg.weiden.de> <Pine.LNX.4.10.10101021057040.25012-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101021057040.25012-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 02, 2001 at 11:02:41AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 11:02:41AM -0800, Linus Torvalds wrote:
> What does the system feel like if you just change the "sleep for bdflush"
> logic in wakeup_bdflush() to something like
> 
> 	wake_up_process(bdflush_tsk);
> 	__set_current_state(TASK_RUNNING);
> 	current->policy |= SCHED_YIELD;
> 	schedule();
> 
> instead of trying to wait for bdflush to wake us up?

My bet is a `VM: killing' message.

Waiting bdflush back-wakeup is mandatory to do write throttling correctly.  The
above will break write throttling at least unless something foundamental is
changed recently and that doesn't seem the case.

What I like to do there is to just make bdflush the same thing that kswapd
_should_ (I said "should" because it seems it's not the case anymore in 2.4.x
from some email I read recently, I didn't checked that myself yet) be for
memory pressure (I implemented that at some point in my private local tree). I
mean: bdflush only does the async writeouts and the task context calls
something like flush_dirty_buffers itself. The main reason I was doing that is
to fix the case of >bdf_prm.ndirty tasks all waiting on bdflush at the same
time (that will break write throttling even now in 2.2.x and in current 2.4.x).
That's an unlukcy condition very similar to the one in GFP that is fixed
correctly in 2.2.19pre2 putting pages in a per-process freelist during memory
balancing.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
