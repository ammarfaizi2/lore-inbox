Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRABVet>; Tue, 2 Jan 2001 16:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbRABVek>; Tue, 2 Jan 2001 16:34:40 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51465 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129764AbRABVed>; Tue, 2 Jan 2001 16:34:33 -0500
Date: Tue, 2 Jan 2001 13:02:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Anton Blanchard <anton@linuxcare.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: scheduling problem?
In-Reply-To: <20010102210949.C7563@athlon.random>
Message-ID: <Pine.LNX.4.10.10101021250160.25414-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2001, Andrea Arcangeli wrote:

> On Tue, Jan 02, 2001 at 11:02:41AM -0800, Linus Torvalds wrote:
> > What does the system feel like if you just change the "sleep for bdflush"
> > logic in wakeup_bdflush() to something like
> > 
> > 	wake_up_process(bdflush_tsk);
> > 	__set_current_state(TASK_RUNNING);
> > 	current->policy |= SCHED_YIELD;
> > 	schedule();
> > 
> > instead of trying to wait for bdflush to wake us up?
> 
> My bet is a `VM: killing' message.

Maybe in 2.2.x, yes.

> Waiting bdflush back-wakeup is mandatory to do write throttling correctly.  The
> above will break write throttling at least unless something foundamental is
> changed recently and that doesn't seem the case.

page_launder() should wait for the dirty pages, and that's not something
2.2.x ever did.

This way, the issue of dirty data in the VM is handled by the VM pressure,
not by trying to artificially throttle writers.

NOTE! I think that throttling writers is fine and good, but as it stands
now, the dirty buffer balancing will throttle anybody, not just the
writer. That's partly because of the 2.4.x mis-feature of doing the
balance_dirty call even for previously dirty buffers (fixed in my tree,
btw).

It's _really_ bad to wait for bdflush to finish if we hold on to things
like the superblock lock - which _does_ happen right now. That's why I'm
pretty convinced that we should NOT blindly do the dirty balance in
"mark_buffer_dirty()", but instead at more well-defined points (in places
like "generic_file_write()", for example).

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
